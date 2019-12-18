#import "AtmosplayInterstitialBridge.h"
#import "ZPLADRewardVideo.h"
#import "AtmosplayTypes.h"
#import "ZPLADObjectCache.h"
#import "AtmosplayBannerBridge.h"

static NSString *ZPLADStringFromUTF8String(const char *bytes) { return bytes ? @(bytes) : nil; }

/// Creates a AtmosplayInterstitialBridge and returns its reference
AtmosplayTypeInterstitialRef ZPLADCreateInterstitial(AtmosplayTypeInterstitialClientRef *interstitialClient,
                                                       const char *adAppID,
                                                       const char *adUnitID) {
    AtmosplayInterstitialBridge *interstitial = [[AtmosplayInterstitialBridge alloc]
                      initWithInterstitialClientReference:interstitialClient
                                       adAppId: ZPLADStringFromUTF8String(adAppID)
                                       adUnitId: ZPLADStringFromUTF8String(adUnitID)];
    ZPLADObjectCache *cache = [ZPLADObjectCache sharedInstance];
    [cache.references setObject:interstitial forKey:[interstitial atmosplayAds_referenceKey]];
    return (__bridge AtmosplayTypeInterstitialRef)interstitial;
}

/// Sets the interstitial callback methods to be invoked during interstitial ad events.
void ZPLADSetInterstitialAdCallbacks(
        AtmosplayTypeInterstitialClientRef interstitialAd,
        AtmosplayInterstitialDidReceivedAdCallback adReceivedCallback,
        AtmosplayInterstitialDidFailToReceiveAdWithErrorCallback adFailedCallback,
        AtmosplayInterstitialDidStartPlayingCallback videoDidStartCallback,
        AtmosplayInterstitiaDidClickCallback adClickedCallback,
        AtmosplayInterstitialDidCloseCallback videoDidCloseCallback,
        AtmosplayInterstitialDidCompleteCallback adDidCompleteCallback) {
    AtmosplayInterstitialBridge *internalInterstitialAd = (__bridge AtmosplayInterstitialBridge *)interstitialAd;
    internalInterstitialAd.adReceivedCallback = adReceivedCallback;
    internalInterstitialAd.adFailedCallback = adFailedCallback;
    internalInterstitialAd.videoDidStartCallback = videoDidStartCallback;
    internalInterstitialAd.adClickedCallback = adClickedCallback;
    internalInterstitialAd.adDidCloseCallback = videoDidCloseCallback;
    internalInterstitialAd.videoDidCompleteCallback = adDidCompleteCallback;
}

/// Makes an interstitial ad request.
void ZPLADRequestInterstitial(AtmosplayTypeInterstitialRef interstitial) {    
    AtmosplayInterstitialBridge *internalInterstitial = (__bridge AtmosplayInterstitialBridge *)interstitial;
    [internalInterstitial loadAd];
}

/// Returns YES if the AtmosplayInterstitialBridge is ready to be shown.
BOOL ZPLADInterstitialReady(AtmosplayTypeInterstitialRef interstitial) {
    AtmosplayInterstitialBridge *internalInterstitial = (__bridge AtmosplayInterstitialBridge *)interstitial;
    return [internalInterstitial isReady];
}

/// Shows the AtmosplayInterstitialBridge.
void ZPLADShowInterstitial(AtmosplayTypeInterstitialRef interstitial) {
    AtmosplayInterstitialBridge *internalInterstitial = (__bridge AtmosplayInterstitialBridge *)interstitial;
    [internalInterstitial show];
}

/// Sets AtmosplayInterstitialBridge autoload next ad.
void ZPLADSetInterstitialAutoload(AtmosplayTypeInterstitialRef interstitial, BOOL autoload) {
    AtmosplayInterstitialBridge *internalInterstitial = (__bridge AtmosplayInterstitialBridge *)interstitial;
    [internalInterstitial setAutoload:autoload];
}

/// Sets AtmosplayInterstitialBridge channel id.
void ZPLADSetInterstitialChannelId(AtmosplayTypeInterstitialRef interstitial, const char *channelId) {
    AtmosplayInterstitialBridge *internalInterstitial = (__bridge AtmosplayInterstitialBridge *)interstitial;
    [internalInterstitial setChannelId:ZPLADStringFromUTF8String(channelId)];
}


/// Creates a ZPLADRewardVideo and returns its reference
AtmosplayTypeRewardedVideoRef ZPLADCreateRewardVideo(AtmosplayTypeRewardedVideoClientRef *rewardVideoClient,
                                                 const char *adAppID,
                                                 const char *adUnitID) {
    ZPLADRewardVideo *rewardVideo = [[ZPLADRewardVideo alloc]
                                       initWithRewardVideoClientReference:rewardVideoClient
                                       adAppId: ZPLADStringFromUTF8String(adAppID)
                                       adUnitId: ZPLADStringFromUTF8String(adUnitID)];
    ZPLADObjectCache *cache = [ZPLADObjectCache sharedInstance];
    [cache.references setObject:rewardVideo forKey:[rewardVideo atmosplayAds_referenceKey]];
    return (__bridge AtmosplayTypeRewardedVideoRef)rewardVideo;
}

/// Sets the interstitial callback methods to be invoked during interstitial ad events.
void ZPLADSetRewardVideoAdCallbacks(
        AtmosplayTypeRewardedVideoClientRef rewardVideoAd,
        AtmosplayRewardedVideoDidReceivedAdCallback adReceivedCallback,
        AtmosplayRewardedVideoDidFailToReceiveAdWithErrorCallback adFailedCallback,
        AtmosplayRewardedVideoDidStartPlayingCallback videoDidStartCallback,
        AtmosplayRewardedVideoDidClickCallback adClickedCallback,
        AtmosplayRewardedVideoDidCloseCallback videoDidCloseCallback,
        AtmosplayRewardedVideoDidRewardCallback adDidRewardCallback,
        AtmosplayRewardedVideoDidCompleteCallback adDidCompleteCallback) {
    ZPLADRewardVideo *internalRewardVideoAd = (__bridge ZPLADRewardVideo *)rewardVideoAd;
    internalRewardVideoAd.adReceivedCallback = adReceivedCallback;
    internalRewardVideoAd.adFailedCallback = adFailedCallback;
    internalRewardVideoAd.videoDidStartCallback = videoDidStartCallback;
    internalRewardVideoAd.adClickedCallback = adClickedCallback;
    internalRewardVideoAd.adRewardCallback = adDidRewardCallback;
    internalRewardVideoAd.adDidCloseCallback = videoDidCloseCallback;
    internalRewardVideoAd.videoDidCompleteCallback = adDidCompleteCallback;
}

/// Makes an reward video ad request.
void ZPLADRequestRewardVideo(AtmosplayTypeRewardedVideoRef rewardVideo) {
    ZPLADRewardVideo *internalRewardVideo = (__bridge ZPLADRewardVideo *)rewardVideo;
    [internalRewardVideo loadAd];
}

/// Returns YES if the ZPLADRewardVideo is ready to be shown.
BOOL ZPLADRewardVideoReady(AtmosplayTypeRewardedVideoRef rewardVideo) {
    ZPLADRewardVideo *internalRewardVideo = (__bridge ZPLADRewardVideo *)rewardVideo;
    return [internalRewardVideo isReady];
}

/// Shows the ZPLADRewardVideo.
void ZPLADShowRewardVideo(AtmosplayTypeRewardedVideoRef rewardVideo) {
    ZPLADRewardVideo *internalRewardVideo = (__bridge ZPLADRewardVideo *)rewardVideo;
    [internalRewardVideo show];
}

/// Sets ZPLADRewardVideo autoload next ad.
void ZPLADSetRewardVideoAutoload(AtmosplayTypeRewardedVideoRef rewardVideo, BOOL autoload) {
    ZPLADRewardVideo *internalRewardVideo = (__bridge ZPLADRewardVideo *)rewardVideo;
    [internalRewardVideo setAutoload:autoload];
}

/// Sets ZPLADRewardVideo channel id.
void ZPLADSetRewardVideoChannelId(AtmosplayTypeRewardedVideoRef rewardVideo, const char *channelId) {
    ZPLADRewardVideo *internalRewardVideo = (__bridge ZPLADRewardVideo *)rewardVideo;
    [internalRewardVideo setChannelId:ZPLADStringFromUTF8String(channelId)];
}

#pragma mark - Banner method
AtmosplayTypeBannerRef InitAtmosplayBannerAd(AtmosplayTypeBannerClientRef *bannerRef, const char *adAppID, const char *adUnitID) {
    
    AtmosplayBannerBridge *banner = [[AtmosplayBannerBridge alloc] initWithBannerClientReference:bannerRef adAppId:ZPLADStringFromUTF8String(adAppID) adUnitId:ZPLADStringFromUTF8String(adUnitID)];
    
    ZPLADObjectCache *cache = [ZPLADObjectCache sharedInstance];
    [cache.references setObject:banner forKey:[banner atmosplayAds_referenceKey]];
    return (__bridge AtmosplayTypeBannerRef)banner;
}

void ShowBannerView(AtmosplayTypeBannerRef bannerView){
    AtmosplayBannerBridge *internalBanner = (__bridge AtmosplayBannerBridge *)bannerView;
    [internalBanner showBannerView];
}
void HideBannerView(AtmosplayTypeBannerRef bannerView){
    AtmosplayBannerBridge *internalBanner = (__bridge AtmosplayBannerBridge *)bannerView;
    [internalBanner hideBannerView];
}
void DestroyBannerView(AtmosplayTypeBannerRef bannerView){
    AtmosplayBannerBridge *internalBanner = (__bridge AtmosplayBannerBridge *)bannerView;
    [internalBanner removeBannerView];
}
void SetBannerAdSize(AtmosplayTypeBannerRef bannerView,AtmosplayAdsBannerSize bannerSize){
    AtmosplayBannerBridge *internalBanner = (__bridge AtmosplayBannerBridge *)bannerView;
    [internalBanner setBannerAdSize:bannerSize];
}

void SetBannerPosition(AtmosplayTypeBannerRef bannerView,int position){
    AtmosplayBannerBridge *internalBanner = (__bridge AtmosplayBannerBridge *)bannerView;
    [internalBanner setBannerPosition:position];
}
void SetBannerChannelID(AtmosplayTypeBannerRef bannerView,const char *channelID){
    AtmosplayBannerBridge *internalBanner = (__bridge AtmosplayBannerBridge *)bannerView;
    [internalBanner setChannelID:ZPLADStringFromUTF8String(channelID)];
}

/// Sets the banner callback methods to be invoked during banner ad events.
void SetBannerCallbacks(
                        AtmosplayTypeBannerRef bannerView,
                        AtmosplayBannerDidReceiveAdCallback adReceivedCallback,
                        AtmosplayBannerDidFailToReceiveAdWithErrorCallback adFailedCallback,
                        AtmosplayBannerDidClickCallback adClickedCallback){
    AtmosplayBannerBridge *internalBanner = (__bridge AtmosplayBannerBridge *)bannerView;
    // set banner property
    internalBanner.adReceivedCallback = adReceivedCallback;
    internalBanner.adFailedCallback = adFailedCallback;
    internalBanner.adClickedCallback = adClickedCallback;
}

void RequestBannerAd( AtmosplayTypeBannerRef bannerView){
    AtmosplayBannerBridge *internalBanner = (__bridge AtmosplayBannerBridge *)bannerView;
    [internalBanner loadAd];
}

#pragma mark - Other methods
/// Removes an object from the cache.
void AtmosplayAdsRelease(AtmosplayTypeRef ref) {
    if (ref) {
        ZPLADObjectCache *cache = [ZPLADObjectCache sharedInstance];
        [cache.references removeObjectForKey:[(__bridge NSObject *)ref atmosplayAds_referenceKey]];
    }
}

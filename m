Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0065D744878
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 12:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbjGAK0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 06:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjGAK0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 06:26:06 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD8F3ABD
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jul 2023 03:26:01 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-98d34f1e54fso295258966b.2
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jul 2023 03:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1688207160; x=1690799160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7GZu65JhxFHkJXNbRjSzNPKPbKjdim0drHX3vhxmqLw=;
        b=G7bwbgPOZZ4AtLEKCrS9/WIuQNJms0y0q1gZhnrYDR3D0g9eNuyWDZ7WxqrjEAMZbB
         I7Avp1bkeWotBu7pOcXufgFMVeNkHXE5P+b4alodtmMedvHWnyLWxoIAPX2pudMlu2YI
         L1+L5ZEWPvf1/o417Ji7b/v3ttD6pexxGMQ8YBgzY3fb/eJ8BV1bOtivZB4SR5ud3cNB
         eumzgvxbY3yzecd9Qp0zTwJf/Y93fqayUOgeHu8O6qiR/9F3MvdlxhjnOvbEGnuUznDY
         Xt2NE5kIu9Jcv/Zdirm6B2UqOyFfsTzMH1qHd5gfxKaAr1ttUVFy85mPrrRbNO4YER/m
         /zhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688207160; x=1690799160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7GZu65JhxFHkJXNbRjSzNPKPbKjdim0drHX3vhxmqLw=;
        b=gDbp4bcNsyU4LlEW5s5Nuh/wI/8QMCcj177Tc/FjBD0PYf7WFaKjNM0RwDOonBBMra
         hN31l4TeQ3rZIIoPUd/MK9FqFuRb1A6mQv8K8lhNq56yn6eHOY+NvENYKa1l0il1OgKj
         WKIZWtopIh6btgcGnhifNqpe+7SAwb7jxnbczQtCo/AQSh2LtHyjQT773JEjUS9hqFeQ
         UXZ/0YqCofgGG2YU8xA4CtzToqq8CiCcNY89a7xviNAQNmW3RRL7mMNix1nmiRFdBiqo
         cqXlNVuLJmW1iMmzfnK+f+x4kW36cJ22fzhMAPEW8fsQshDpYxQKEu4p3ub3j8gYUYtV
         +1SA==
X-Gm-Message-State: ABy/qLbp28A6yjzMlZUaw8CxcHosbk60hCQ+PhUr1nRNB4HH3akux6oy
        FEMK/gizPYciaP0vZxRWqEvy872t8PNnfg==
X-Google-Smtp-Source: APBJJlE7NvtKVHZ3a/ABk4LTkGSQ+LbJXPCPZubIx16bKbKw+ui6gAWfGFC0JkNOz///4x41FvzhYQ==
X-Received: by 2002:a17:906:5650:b0:982:82aa:86b1 with SMTP id v16-20020a170906565000b0098282aa86b1mr2700060ejr.43.1688207159678;
        Sat, 01 Jul 2023 03:25:59 -0700 (PDT)
Received: from localhost.localdomain ([2a02:810a:9640:26a8:185:3db5:c5f0:49bb])
        by smtp.gmail.com with ESMTPSA id v4-20020a170906180400b009920e9a3a73sm5446274eje.115.2023.07.01.03.25.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 01 Jul 2023 03:25:59 -0700 (PDT)
From:   Franziska Naepelt <franziska.naepelt@googlemail.com>
To:     franziska.naepelt@googlemail.com
Cc:     dan.carpenter@linaro.org, eperi1024@gmail.com,
        gregkh@linuxfoundation.org, guozihua@huawei.com,
        hdegoede@redhat.com, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, philipp.g.hortmann@gmail.com,
        quic_vjakkam@quicinc.com, tegongkang@gmail.com
Subject: [PATCH v4 2/3] staging: rtl8723bs: Fix alignment open parenthesis
Date:   Sat,  1 Jul 2023 12:25:55 +0200
Message-Id: <20230701102555.5393-1-franziska.naepelt@googlemail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20230701102223.5308-1-franziska.naepelt@googlemail.com>
References: <20230701102223.5308-1-franziska.naepelt@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following checkpatch issues:
- CHECK: Alignment should match open parenthesis

Signed-off-by: Franziska Naepelt <franziska.naepelt@googlemail.com>
---
v4: Fix sign-off email address
---
 .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 91 ++++++++++---------
 1 file changed, 49 insertions(+), 42 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index 7a651952f77c..8f30098168f1 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -95,14 +95,14 @@ static struct ieee80211_channel rtw_2ghz_channels[] = {
 static void rtw_2g_channels_init(struct ieee80211_channel *channels)
 {
 	memcpy((void *)channels, (void *)rtw_2ghz_channels,
-		sizeof(struct ieee80211_channel) * RTW_2G_CHANNELS_NUM
+	       sizeof(struct ieee80211_channel) * RTW_2G_CHANNELS_NUM
 	);
 }

 static void rtw_2g_rates_init(struct ieee80211_rate *rates)
 {
 	memcpy(rates, rtw_g_rates,
-		sizeof(struct ieee80211_rate) * RTW_G_RATES_NUM
+	       sizeof(struct ieee80211_rate) * RTW_G_RATES_NUM
 	);
 }

@@ -276,7 +276,7 @@ struct cfg80211_bss *rtw_cfg80211_inform_bss(struct adapter *padapter, struct wl

 	/* We've set wiphy's signal_type as CFG80211_SIGNAL_TYPE_MBM: signal strength in mBm (100*dBm) */
 	if (check_fwstate(pmlmepriv, _FW_LINKED) == true &&
-		is_same_network(&pmlmepriv->cur_network.network, &pnetwork->network, 0)) {
+	    is_same_network(&pmlmepriv->cur_network.network, &pnetwork->network, 0)) {
 		notify_signal = 100 * translate_percentage_to_dbm(padapter->recvpriv.signal_strength);/* dbm */
 	} else {
 		notify_signal = 100 * translate_percentage_to_dbm(pnetwork->network.phy_info.signal_strength);/* dbm */
@@ -314,7 +314,7 @@ struct cfg80211_bss *rtw_cfg80211_inform_bss(struct adapter *padapter, struct wl
 	*((__le64 *)pbuf) = cpu_to_le64(notify_timestamp);

 	bss = cfg80211_inform_bss_frame(wiphy, notify_channel, (struct ieee80211_mgmt *)buf,
-		len, notify_signal, GFP_ATOMIC);
+					len, notify_signal, GFP_ATOMIC);

 	if (unlikely(!bss))
 		goto exit;
@@ -346,9 +346,9 @@ int rtw_cfg80211_check_bss(struct adapter *padapter)

 	notify_channel = ieee80211_get_channel(padapter->rtw_wdev->wiphy, freq);
 	bss = cfg80211_get_bss(padapter->rtw_wdev->wiphy, notify_channel,
-			pnetwork->mac_address, pnetwork->ssid.ssid,
-			pnetwork->ssid.ssid_length,
-			IEEE80211_BSS_TYPE_ANY, IEEE80211_PRIVACY_ANY);
+			       pnetwork->mac_address, pnetwork->ssid.ssid,
+			       pnetwork->ssid.ssid_length,
+			       IEEE80211_BSS_TYPE_ANY, IEEE80211_PRIVACY_ANY);

 	cfg80211_put_bss(padapter->rtw_wdev->wiphy, bss);

@@ -487,7 +487,7 @@ void rtw_cfg80211_indicate_disconnect(struct adapter *padapter)
 					      NULL, 0, true, GFP_ATOMIC);
 		} else {
 			cfg80211_connect_result(padapter->pnetdev, NULL, NULL, 0, NULL, 0,
-				WLAN_STATUS_UNSPECIFIED_FAILURE, GFP_ATOMIC/*GFP_KERNEL*/);
+						WLAN_STATUS_UNSPECIFIED_FAILURE, GFP_ATOMIC/*GFP_KERNEL*/);
 		}
 	}
 }
@@ -778,7 +778,7 @@ static int rtw_cfg80211_set_encryption(struct net_device *dev, struct ieee_param
 					psta->ieee8021x_blocked = false;

 				if ((padapter->securitypriv.ndisencryptstatus == Ndis802_11Encryption2Enabled) ||
-						(padapter->securitypriv.ndisencryptstatus ==  Ndis802_11Encryption3Enabled)) {
+				    (padapter->securitypriv.ndisencryptstatus ==  Ndis802_11Encryption3Enabled)) {
 					psta->dot118021XPrivacy = padapter->securitypriv.dot11PrivacyAlgrthm;
 				}

@@ -827,7 +827,7 @@ static int rtw_cfg80211_set_encryption(struct net_device *dev, struct ieee_param
 					pbcmc_sta->ieee8021x_blocked = false;

 				if ((padapter->securitypriv.ndisencryptstatus == Ndis802_11Encryption2Enabled) ||
-						(padapter->securitypriv.ndisencryptstatus ==  Ndis802_11Encryption3Enabled)) {
+				    (padapter->securitypriv.ndisencryptstatus ==  Ndis802_11Encryption3Enabled)) {
 					pbcmc_sta->dot118021XPrivacy = padapter->securitypriv.dot11PrivacyAlgrthm;
 				}
 			}
@@ -945,9 +945,9 @@ static int cfg80211_rtw_del_key(struct wiphy *wiphy, struct net_device *ndev,
 }

 static int cfg80211_rtw_set_default_key(struct wiphy *wiphy,
-	struct net_device *ndev, int link_id, u8 key_index
-	, bool unicast, bool multicast
-	)
+					struct net_device *ndev, int link_id,
+					u8 key_index, bool unicast,
+					bool multicast)
 {
 	struct adapter *padapter = rtw_netdev_priv(ndev);
 	struct security_priv *psecuritypriv = &padapter->securitypriv;
@@ -1122,9 +1122,10 @@ void rtw_cfg80211_unlink_bss(struct adapter *padapter, struct wlan_network *pnet
 	struct wlan_bssid_ex *select_network = &pnetwork->network;

 	bss = cfg80211_get_bss(wiphy, NULL/*notify_channel*/,
-		select_network->mac_address, select_network->ssid.ssid,
-		select_network->ssid.ssid_length, IEEE80211_BSS_TYPE_ANY,
-		IEEE80211_PRIVACY_ANY);
+			       select_network->mac_address,
+			       select_network->ssid.ssid,
+			       select_network->ssid.ssid_length,
+			       IEEE80211_BSS_TYPE_ANY, IEEE80211_PRIVACY_ANY);

 	if (bss) {
 		cfg80211_unlink_bss(wiphy, bss);
@@ -1329,7 +1330,7 @@ static int rtw_cfg80211_set_wpa_version(struct security_priv *psecuritypriv, u32
 }

 static int rtw_cfg80211_set_auth_type(struct security_priv *psecuritypriv,
-			     enum nl80211_auth_type sme_auth_type)
+				      enum nl80211_auth_type sme_auth_type)
 {
 	switch (sme_auth_type) {
 	case NL80211_AUTHTYPE_AUTOMATIC:
@@ -1634,7 +1635,7 @@ static int cfg80211_rtw_leave_ibss(struct wiphy *wiphy, struct net_device *ndev)
 }

 static int cfg80211_rtw_connect(struct wiphy *wiphy, struct net_device *ndev,
-				 struct cfg80211_connect_params *sme)
+				struct cfg80211_connect_params *sme)
 {
 	int ret = 0;
 	enum ndis_802_11_authentication_mode authmode;
@@ -1709,7 +1710,7 @@ static int cfg80211_rtw_connect(struct wiphy *wiphy, struct net_device *ndev,

 	/* For WEP Shared auth */
 	if ((psecuritypriv->dot11AuthAlgrthm == dot11AuthAlgrthm_Shared ||
-	    psecuritypriv->dot11AuthAlgrthm == dot11AuthAlgrthm_Auto) && sme->key) {
+	     psecuritypriv->dot11AuthAlgrthm == dot11AuthAlgrthm_Auto) && sme->key) {
 		u32 wep_key_idx, wep_key_len, wep_total_len;
 		struct ndis_802_11_wep	 *pwep = NULL;

@@ -1807,15 +1808,14 @@ static int cfg80211_rtw_disconnect(struct wiphy *wiphy, struct net_device *ndev,
 }

 static int cfg80211_rtw_set_txpower(struct wiphy *wiphy,
-	struct wireless_dev *wdev,
-	enum nl80211_tx_power_setting type, int mbm)
+				    struct wireless_dev *wdev,
+				    enum nl80211_tx_power_setting type, int mbm)
 {
 	return 0;
 }

 static int cfg80211_rtw_get_txpower(struct wiphy *wiphy,
-	struct wireless_dev *wdev,
-	int *dbm)
+				    struct wireless_dev *wdev, int *dbm)
 {
 	*dbm = (12);

@@ -2228,7 +2228,7 @@ static struct wireless_dev *
 }

 static int cfg80211_rtw_del_virtual_intf(struct wiphy *wiphy,
-	struct wireless_dev *wdev
+					 struct wireless_dev *wdev
 )
 {
 	struct net_device *ndev = wdev_to_ndev(wdev);
@@ -2295,13 +2295,14 @@ static int rtw_add_beacon(struct adapter *adapter, const u8 *head, size_t head_l
 }

 static int cfg80211_rtw_start_ap(struct wiphy *wiphy, struct net_device *ndev,
-								struct cfg80211_ap_settings *settings)
+				 struct cfg80211_ap_settings *settings)
 {
 	int ret = 0;
 	struct adapter *adapter = rtw_netdev_priv(ndev);

-	ret = rtw_add_beacon(adapter, settings->beacon.head, settings->beacon.head_len,
-		settings->beacon.tail, settings->beacon.tail_len);
+	ret = rtw_add_beacon(adapter, settings->beacon.head,
+			     settings->beacon.head_len, settings->beacon.tail,
+			     settings->beacon.tail_len);

 	adapter->mlmeextpriv.mlmext_info.hidden_ssid_mode = settings->hidden_ssid;

@@ -2318,8 +2319,9 @@ static int cfg80211_rtw_start_ap(struct wiphy *wiphy, struct net_device *ndev,
 	return ret;
 }

-static int cfg80211_rtw_change_beacon(struct wiphy *wiphy, struct net_device *ndev,
-		struct cfg80211_beacon_data *info)
+static int cfg80211_rtw_change_beacon(struct wiphy *wiphy,
+				      struct net_device *ndev,
+				      struct cfg80211_beacon_data *info)
 {
 	struct adapter *adapter = rtw_netdev_priv(ndev);

@@ -2332,9 +2334,10 @@ static int cfg80211_rtw_stop_ap(struct wiphy *wiphy, struct net_device *ndev,
 	return 0;
 }

-static int	cfg80211_rtw_add_station(struct wiphy *wiphy, struct net_device *ndev,
-				const u8 *mac,
-			struct station_parameters *params)
+static int	cfg80211_rtw_add_station(struct wiphy *wiphy,
+					 struct net_device *ndev,
+					 const u8 *mac,
+					 struct station_parameters *params)
 {
 	return 0;
 }
@@ -2396,8 +2399,10 @@ static int cfg80211_rtw_del_station(struct wiphy *wiphy, struct net_device *ndev
 	return ret;
 }

-static int cfg80211_rtw_change_station(struct wiphy *wiphy, struct net_device *ndev,
-				  const u8 *mac, struct station_parameters *params)
+static int cfg80211_rtw_change_station(struct wiphy *wiphy,
+				       struct net_device *ndev,
+				       const u8 *mac,
+				       struct station_parameters *params)
 {
 	return 0;
 }
@@ -2422,8 +2427,10 @@ static struct sta_info *rtw_sta_info_get_by_idx(const int idx, struct sta_priv *
 	return psta;
 }

-static int	cfg80211_rtw_dump_station(struct wiphy *wiphy, struct net_device *ndev,
-			       int idx, u8 *mac, struct station_info *sinfo)
+static int	cfg80211_rtw_dump_station(struct wiphy *wiphy,
+					  struct net_device *ndev,
+					  int idx, u8 *mac,
+					  struct station_info *sinfo)
 {
 	int ret = 0;
 	struct adapter *padapter = rtw_netdev_priv(ndev);
@@ -2445,8 +2452,9 @@ static int	cfg80211_rtw_dump_station(struct wiphy *wiphy, struct net_device *nde
 	return ret;
 }

-static int	cfg80211_rtw_change_bss(struct wiphy *wiphy, struct net_device *ndev,
-			      struct bss_parameters *params)
+static int	cfg80211_rtw_change_bss(struct wiphy *wiphy,
+					struct net_device *ndev,
+					struct bss_parameters *params)
 {
 	return 0;
 }
@@ -2529,10 +2537,9 @@ static int _cfg80211_rtw_mgmt_tx(struct adapter *padapter, u8 tx_ch, const u8 *b
 	return ret;
 }

-static int cfg80211_rtw_mgmt_tx(struct wiphy *wiphy,
-	struct wireless_dev *wdev,
-	struct cfg80211_mgmt_tx_params *params,
-	u64 *cookie)
+static int cfg80211_rtw_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
+				struct cfg80211_mgmt_tx_params *params,
+				u64 *cookie)
 {
 	struct net_device *ndev = wdev_to_ndev(wdev);
 	struct ieee80211_channel *chan = params->chan;
--
2.39.2 (Apple Git-143)


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 172D2735D5A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 20:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbjFSSNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 14:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232111AbjFSSNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 14:13:05 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C67A1B0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 11:13:02 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9887ebe16d0so235918766b.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 11:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1687198380; x=1689790380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k3lPC1NaG28i6896h3scqLwd/Pl9ZFzYUuPdAO/i3WU=;
        b=REouLqfcG5RmtqcrUPyseUPu3OEdrtRxbrg8YZAsp5AQW69nUfAtDDDj3sFCm7kVhr
         wwrj8CP68bwOtVBp3BnlUXl5gwDdLN/WsWLigk3e5kEYoKQUkgk20ECM4CawgVaWwVQl
         /0VKfixyOIEZbZw7a+l0qZvJpmpOF+x97uQtoBe85owCoGe+2PuHhbRymx25DIYDj2lX
         j13DdfYczEOGZp8N36RzmVPlW38OHZvouiXg+xVxB3txdXQrEWHgLhLatr9uNG1L0jDv
         BhQ3dOq3Bsxtasxhu8+bcl56H9MUZC8dSisBfHH3j5xVst6Wz+aHjafAp9nhDDaSQGXE
         amSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687198380; x=1689790380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k3lPC1NaG28i6896h3scqLwd/Pl9ZFzYUuPdAO/i3WU=;
        b=X3nIswCorWhQZMSOoObQ2GWgqcJLbS47KeSi4/gWy1MceUkrIgK9dPSlzRjLA2vmP9
         xCc/grKGQpTjdx9f/zJu4iMXAggVVbO9TuCG/L9CfEBgb17UYAJqL1JIkEfCwjcgpSMM
         nAJkcDszpkwsSbNMJaZfLaby0j3D8kjjtK4W9qbSZygOfgshyI++opPCcib+OozL45An
         RD5d1cqM6qGQ8P4Ltfi5Ak5Y4jTNv8xMXZVdXoTHHmRRIlJ1KOwYFYIiKnc8uD9SpQwZ
         Bvmoc8orgv7lsB7LKFoIRS2ZQQc21SJq18kCTdF+YamDr00abUUCwWqjeDKCVcOU7jwD
         PAJQ==
X-Gm-Message-State: AC+VfDyBXaMraii4VPKNQnDzufXuCmqh4g3W71Pk5oXPQKzSPdAZUtcC
        yqMiAUh5pQHLAuVTp/HxDlw=
X-Google-Smtp-Source: ACHHUZ5+bsTW94X154hZMIJPIV5jfq+bsCsgyITU/b4qM8u02y+nWwrEcxZ17RzZ/LNTQYYQ+yBBlw==
X-Received: by 2002:a17:907:3fa3:b0:94e:116:8581 with SMTP id hr35-20020a1709073fa300b0094e01168581mr10957330ejc.5.1687198380447;
        Mon, 19 Jun 2023 11:13:00 -0700 (PDT)
Received: from localhost.localdomain ([2a02:810a:9640:26a8:dcda:2154:7873:34])
        by smtp.gmail.com with ESMTPSA id qu13-20020a170907110d00b00988781076e2sm30992ejb.78.2023.06.19.11.12.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 19 Jun 2023 11:13:00 -0700 (PDT)
From:   Franziska Naepelt <franziska.naepelt@googlemail.com>
X-Google-Original-From: Franziska Naepelt <franziska.naepelt@gmail.com>
To:     franziska.naepelt@googlemail.com
Cc:     eperi1024@gmail.com, franziska.naepelt@gmail.com,
        gregkh@linuxfoundation.org, hdegoede@redhat.com,
        johannes.berg@intel.com, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, quic_vjakkam@quicinc.com,
        tegongkang@gmail.com
Subject: [PATCH 5/5] staging: rtl8723bs: Fix alignment open parenthesis
Date:   Mon, 19 Jun 2023 20:12:58 +0200
Message-Id: <20230619181258.19152-1-franziska.naepelt@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20230619175703.18826-1-franziska.naepelt@gmail.com>
References: <20230619175703.18826-1-franziska.naepelt@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following checkpatch issues:
- CHECK: Alignment should match open parenthesis

Signed-off-by: Franziska Naepelt <franziska.naepelt@gmail.com>
---
 .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 91 ++++++++++---------
 1 file changed, 49 insertions(+), 42 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index c00a377258d8..292cba045023 100644
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
 
@@ -275,7 +275,7 @@ struct cfg80211_bss *rtw_cfg80211_inform_bss(struct adapter *padapter, struct wl
 
 	/* We've set wiphy's signal_type as CFG80211_SIGNAL_TYPE_MBM: signal strength in mBm (100*dBm) */
 	if (check_fwstate(pmlmepriv, _FW_LINKED) == true &&
-		is_same_network(&pmlmepriv->cur_network.network, &pnetwork->network, 0)) {
+	    is_same_network(&pmlmepriv->cur_network.network, &pnetwork->network, 0)) {
 		notify_signal = 100 * translate_percentage_to_dbm(padapter->recvpriv.signal_strength);/* dbm */
 	} else {
 		notify_signal = 100 * translate_percentage_to_dbm(pnetwork->network.phy_info.signal_strength);/* dbm */
@@ -313,7 +313,7 @@ struct cfg80211_bss *rtw_cfg80211_inform_bss(struct adapter *padapter, struct wl
 	*((__le64 *)pbuf) = cpu_to_le64(notify_timestamp);
 
 	bss = cfg80211_inform_bss_frame(wiphy, notify_channel, (struct ieee80211_mgmt *)buf,
-		len, notify_signal, GFP_ATOMIC);
+					len, notify_signal, GFP_ATOMIC);
 
 	if (unlikely(!bss))
 		goto exit;
@@ -345,9 +345,9 @@ int rtw_cfg80211_check_bss(struct adapter *padapter)
 
 	notify_channel = ieee80211_get_channel(padapter->rtw_wdev->wiphy, freq);
 	bss = cfg80211_get_bss(padapter->rtw_wdev->wiphy, notify_channel,
-			pnetwork->mac_address, pnetwork->ssid.ssid,
-			pnetwork->ssid.ssid_length,
-			IEEE80211_BSS_TYPE_ANY, IEEE80211_PRIVACY_ANY);
+			       pnetwork->mac_address, pnetwork->ssid.ssid,
+			       pnetwork->ssid.ssid_length,
+			       IEEE80211_BSS_TYPE_ANY, IEEE80211_PRIVACY_ANY);
 
 	cfg80211_put_bss(padapter->rtw_wdev->wiphy, bss);
 
@@ -486,7 +486,7 @@ void rtw_cfg80211_indicate_disconnect(struct adapter *padapter)
 					      NULL, 0, true, GFP_ATOMIC);
 		} else {
 			cfg80211_connect_result(padapter->pnetdev, NULL, NULL, 0, NULL, 0,
-				WLAN_STATUS_UNSPECIFIED_FAILURE, GFP_ATOMIC/*GFP_KERNEL*/);
+						WLAN_STATUS_UNSPECIFIED_FAILURE, GFP_ATOMIC/*GFP_KERNEL*/);
 		}
 	}
 }
@@ -777,7 +777,7 @@ static int rtw_cfg80211_set_encryption(struct net_device *dev, struct ieee_param
 					psta->ieee8021x_blocked = false;
 
 				if ((padapter->securitypriv.ndisencryptstatus == Ndis802_11Encryption2Enabled) ||
-						(padapter->securitypriv.ndisencryptstatus ==  Ndis802_11Encryption3Enabled)) {
+				    (padapter->securitypriv.ndisencryptstatus ==  Ndis802_11Encryption3Enabled)) {
 					psta->dot118021XPrivacy = padapter->securitypriv.dot11PrivacyAlgrthm;
 				}
 
@@ -826,7 +826,7 @@ static int rtw_cfg80211_set_encryption(struct net_device *dev, struct ieee_param
 					pbcmc_sta->ieee8021x_blocked = false;
 
 				if ((padapter->securitypriv.ndisencryptstatus == Ndis802_11Encryption2Enabled) ||
-						(padapter->securitypriv.ndisencryptstatus ==  Ndis802_11Encryption3Enabled)) {
+				    (padapter->securitypriv.ndisencryptstatus ==  Ndis802_11Encryption3Enabled)) {
 					pbcmc_sta->dot118021XPrivacy = padapter->securitypriv.dot11PrivacyAlgrthm;
 				}
 			}
@@ -944,9 +944,9 @@ static int cfg80211_rtw_del_key(struct wiphy *wiphy, struct net_device *ndev,
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
@@ -1121,9 +1121,10 @@ void rtw_cfg80211_unlink_bss(struct adapter *padapter, struct wlan_network *pnet
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
@@ -1328,7 +1329,7 @@ static int rtw_cfg80211_set_wpa_version(struct security_priv *psecuritypriv, u32
 }
 
 static int rtw_cfg80211_set_auth_type(struct security_priv *psecuritypriv,
-			     enum nl80211_auth_type sme_auth_type)
+				      enum nl80211_auth_type sme_auth_type)
 {
 	switch (sme_auth_type) {
 	case NL80211_AUTHTYPE_AUTOMATIC:
@@ -1633,7 +1634,7 @@ static int cfg80211_rtw_leave_ibss(struct wiphy *wiphy, struct net_device *ndev)
 }
 
 static int cfg80211_rtw_connect(struct wiphy *wiphy, struct net_device *ndev,
-				 struct cfg80211_connect_params *sme)
+				struct cfg80211_connect_params *sme)
 {
 	int ret = 0;
 	enum ndis_802_11_authentication_mode authmode;
@@ -1708,7 +1709,7 @@ static int cfg80211_rtw_connect(struct wiphy *wiphy, struct net_device *ndev,
 
 	/* For WEP Shared auth */
 	if ((psecuritypriv->dot11AuthAlgrthm == dot11AuthAlgrthm_Shared ||
-	    psecuritypriv->dot11AuthAlgrthm == dot11AuthAlgrthm_Auto) && sme->key) {
+	     psecuritypriv->dot11AuthAlgrthm == dot11AuthAlgrthm_Auto) && sme->key) {
 		u32 wep_key_idx, wep_key_len, wep_total_len;
 		struct ndis_802_11_wep	 *pwep = NULL;
 
@@ -1806,15 +1807,14 @@ static int cfg80211_rtw_disconnect(struct wiphy *wiphy, struct net_device *ndev,
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
 
@@ -2227,7 +2227,7 @@ static struct wireless_dev *
 }
 
 static int cfg80211_rtw_del_virtual_intf(struct wiphy *wiphy,
-	struct wireless_dev *wdev
+					 struct wireless_dev *wdev
 )
 {
 	struct net_device *ndev = wdev_to_ndev(wdev);
@@ -2294,13 +2294,14 @@ static int rtw_add_beacon(struct adapter *adapter, const u8 *head, size_t head_l
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
 
@@ -2317,8 +2318,9 @@ static int cfg80211_rtw_start_ap(struct wiphy *wiphy, struct net_device *ndev,
 	return ret;
 }
 
-static int cfg80211_rtw_change_beacon(struct wiphy *wiphy, struct net_device *ndev,
-		struct cfg80211_beacon_data *info)
+static int cfg80211_rtw_change_beacon(struct wiphy *wiphy,
+				      struct net_device *ndev,
+				      struct cfg80211_beacon_data *info)
 {
 	struct adapter *adapter = rtw_netdev_priv(ndev);
 
@@ -2331,9 +2333,10 @@ static int cfg80211_rtw_stop_ap(struct wiphy *wiphy, struct net_device *ndev,
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
@@ -2395,8 +2398,10 @@ static int cfg80211_rtw_del_station(struct wiphy *wiphy, struct net_device *ndev
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
@@ -2421,8 +2426,10 @@ static struct sta_info *rtw_sta_info_get_by_idx(const int idx, struct sta_priv *
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
@@ -2444,8 +2451,9 @@ static int	cfg80211_rtw_dump_station(struct wiphy *wiphy, struct net_device *nde
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
@@ -2528,10 +2536,9 @@ static int _cfg80211_rtw_mgmt_tx(struct adapter *padapter, u8 tx_ch, const u8 *b
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


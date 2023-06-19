Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46E9A735D48
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 20:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbjFSSID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 14:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232196AbjFSSIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 14:08:00 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2EF128
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 11:07:59 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-970028cfb6cso613017366b.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 11:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1687198077; x=1689790077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+3xnjd0eY8aQSj0QUgbvMXe0x5b/buzAezpR6BW9YoA=;
        b=pKM/o4HN/dcO0Z/xHwNdbeQebyVtN3To8gAF20wPUGE/45rNM19+hyyFXiyEgoy/2I
         8Eup5urzdmcL2kouRqaVAlhjIU+UIVzE4FsLLbbe21AOCLzFSOTEMCcL3ET59Weei9VF
         53mK5v2q/d4qiKL9u2XlgDJEU/MufzxMCKdvm4tGL3/lHFiYtCJ53LbY01i2LcDqqDeO
         pAuEB7EC6otKXxQe6su1jHFCTv1fv5JQFnBNU5DH409qcMxn2ULfRLUoUb/ClzBxXkA+
         WSSStkzc4Ea1wdJfo9iM72sTf0EMdKVFKDJPOcsPZ2xkLMDtJn5czfyBllnAFUH9+wSu
         zP9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687198077; x=1689790077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+3xnjd0eY8aQSj0QUgbvMXe0x5b/buzAezpR6BW9YoA=;
        b=DD8FGHbksC3yDm5SarXpfxJ5TG1zAF/a6C63VKvT5WpnPvrT4ytiOtfHICf9cZatVI
         +iCW6VfWkfXVSlO/s3XvWFHwq3cfwXerkjb8fekb0/ta78xjuVnkXgpMRtcajAffblVZ
         x8ic6O1ToDp52G1ew8WM21ZMVaICDnuuqeuh86lFP5vdHKMtvW1uxLjLqDpHsNFXqiyh
         ZB6n8Fwo+pJK+iqM13lFWt7j39f0khZeFBfLgH+3cgDEzEEpP2PAtje/o1DiMkIrhqLb
         TOSuhVDsoyUwtuTg4OHN2hBbDXajvrliVCw2vV8rawkYp1Cv4scH9T1evAFNhpvDzK+P
         NNzw==
X-Gm-Message-State: AC+VfDx53EydPcCBeIWP4kMPQu4TZyfhqFZRRENMWR/KWI2avQ5LneYo
        I3olb/lwmgTSDBOIqUrpPpA=
X-Google-Smtp-Source: ACHHUZ714AGjCPDgBlyZ8eBV3aeRatY715HnXU4wYJ++p4cqyBk07bFYYj+cF5Ki80va9RKWROfQQA==
X-Received: by 2002:a17:907:86ab:b0:987:792:34e5 with SMTP id qa43-20020a17090786ab00b00987079234e5mr6985114ejc.23.1687198077390;
        Mon, 19 Jun 2023 11:07:57 -0700 (PDT)
Received: from localhost.localdomain ([2a02:810a:9640:26a8:dcda:2154:7873:34])
        by smtp.gmail.com with ESMTPSA id hk12-20020a170906c9cc00b009659ad1072fsm22076ejb.113.2023.06.19.11.07.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 19 Jun 2023 11:07:57 -0700 (PDT)
From:   Franziska Naepelt <franziska.naepelt@googlemail.com>
X-Google-Original-From: Franziska Naepelt <franziska.naepelt@gmail.com>
To:     franziska.naepelt@googlemail.com
Cc:     eperi1024@gmail.com, franziska.naepelt@gmail.com,
        gregkh@linuxfoundation.org, hdegoede@redhat.com,
        johannes.berg@intel.com, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, quic_vjakkam@quicinc.com,
        tegongkang@gmail.com
Subject: [PATCH 2/5] staging: rtl8723bs: Fix space issues
Date:   Mon, 19 Jun 2023 20:07:53 +0200
Message-Id: <20230619180753.18998-1-franziska.naepelt@gmail.com>
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

Fix the following checkpatch space issues:
- CHECK: spaces preferred around that '*' (ctx:VxV)
- CHECK: spaces preferred around that '+' (ctx:VxV)
- CHECK: spaces preferred around that '-' (ctx:VxV)
- CHECK: spaces preferred around that '|' (ctx:VxV)
- CHECK: No space is necessary after a cast
- WARNING: please, no spaces at the start of a line

Signed-off-by: Franziska Naepelt <franziska.naepelt@gmail.com>
---
 .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 77 +++++++++----------
 1 file changed, 38 insertions(+), 39 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index 1afd1a93bcee..abda4e0f0bf5 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -95,14 +95,14 @@ static struct ieee80211_channel rtw_2ghz_channels[] = {
 static void rtw_2g_channels_init(struct ieee80211_channel *channels)
 {
 	memcpy((void *)channels, (void *)rtw_2ghz_channels,
-		sizeof(struct ieee80211_channel)*RTW_2G_CHANNELS_NUM
+		sizeof(struct ieee80211_channel) * RTW_2G_CHANNELS_NUM
 	);
 }
 
 static void rtw_2g_rates_init(struct ieee80211_rate *rates)
 {
 	memcpy(rates, rtw_g_rates,
-		sizeof(struct ieee80211_rate)*RTW_G_RATES_NUM
+		sizeof(struct ieee80211_rate) * RTW_G_RATES_NUM
 	);
 }
 
@@ -126,8 +126,8 @@ static struct ieee80211_supported_band *rtw_spt_band_alloc(
 	if (!spt_band)
 		goto exit;
 
-	spt_band->channels = (struct ieee80211_channel *)(((u8 *)spt_band)+sizeof(struct ieee80211_supported_band));
-	spt_band->bitrates = (struct ieee80211_rate *)(((u8 *)spt_band->channels)+sizeof(struct ieee80211_channel)*n_channels);
+	spt_band->channels = (struct ieee80211_channel *)(((u8 *)spt_band) + sizeof(struct ieee80211_supported_band));
+	spt_band->bitrates = (struct ieee80211_rate *)(((u8 *)spt_band->channels) + sizeof(struct ieee80211_channel) * n_channels);
 	spt_band->band = band;
 	spt_band->n_channels = n_channels;
 	spt_band->n_bitrates = n_bitrates;
@@ -247,10 +247,10 @@ struct cfg80211_bss *rtw_cfg80211_inform_bss(struct adapter *padapter, struct wl
 		u32 wpsielen = 0;
 		u8 *wpsie = NULL;
 
-		wpsie = rtw_get_wps_ie(pnetwork->network.ies+_FIXED_IE_LENGTH_, pnetwork->network.ie_length-_FIXED_IE_LENGTH_, NULL, &wpsielen);
+		wpsie = rtw_get_wps_ie(pnetwork->network.ies + _FIXED_IE_LENGTH_, pnetwork->network.ie_length - _FIXED_IE_LENGTH_, NULL, &wpsielen);
 
 		if (wpsie && wpsielen > 0)
-			psr = rtw_get_wps_attr_content(wpsie,  wpsielen, WPS_ATTR_SELECTED_REGISTRAR, (u8 *)(&sr), NULL);
+			psr = rtw_get_wps_attr_content(wpsie, wpsielen, WPS_ATTR_SELECTED_REGISTRAR, (u8 *)(&sr), NULL);
 
 		if (sr != 0) {
 			/* it means under processing WPS */
@@ -266,7 +266,6 @@ struct cfg80211_bss *rtw_cfg80211_inform_bss(struct adapter *padapter, struct wl
 	}
 	/* spin_unlock_bh(&pwdev_priv->scan_req_lock); */
 
-
 	channel = pnetwork->network.configuration.ds_config;
 	freq = rtw_ieee80211_channel_to_frequency(channel, NL80211_BAND_2GHZ);
 
@@ -277,9 +276,9 @@ struct cfg80211_bss *rtw_cfg80211_inform_bss(struct adapter *padapter, struct wl
 	/* We've set wiphy's signal_type as CFG80211_SIGNAL_TYPE_MBM: signal strength in mBm (100*dBm) */
 	if (check_fwstate(pmlmepriv, _FW_LINKED) == true &&
 		is_same_network(&pmlmepriv->cur_network.network, &pnetwork->network, 0)) {
-		notify_signal = 100*translate_percentage_to_dbm(padapter->recvpriv.signal_strength);/* dbm */
+		notify_signal = 100 * translate_percentage_to_dbm(padapter->recvpriv.signal_strength);/* dbm */
 	} else {
-		notify_signal = 100*translate_percentage_to_dbm(pnetwork->network.phy_info.signal_strength);/* dbm */
+		notify_signal = 100 * translate_percentage_to_dbm(pnetwork->network.phy_info.signal_strength);/* dbm */
 	}
 
 	buf = kzalloc(MAX_BSSINFO_LEN, GFP_ATOMIC);
@@ -452,20 +451,20 @@ void rtw_cfg80211_indicate_connect(struct adapter *padapter)
 		roam_info.links[0].channel = notify_channel;
 		roam_info.links[0].bssid = cur_network->network.mac_address;
 		roam_info.req_ie =
-			pmlmepriv->assoc_req+sizeof(struct ieee80211_hdr_3addr)+2;
+			pmlmepriv->assoc_req + sizeof(struct ieee80211_hdr_3addr) + 2;
 		roam_info.req_ie_len =
-			pmlmepriv->assoc_req_len-sizeof(struct ieee80211_hdr_3addr)-2;
+			pmlmepriv->assoc_req_len - sizeof(struct ieee80211_hdr_3addr) - 2;
 		roam_info.resp_ie =
-			pmlmepriv->assoc_rsp+sizeof(struct ieee80211_hdr_3addr)+6;
+			pmlmepriv->assoc_rsp + sizeof(struct ieee80211_hdr_3addr) + 6;
 		roam_info.resp_ie_len =
-			pmlmepriv->assoc_rsp_len-sizeof(struct ieee80211_hdr_3addr)-6;
+			pmlmepriv->assoc_rsp_len - sizeof(struct ieee80211_hdr_3addr) - 6;
 		cfg80211_roamed(padapter->pnetdev, &roam_info, GFP_ATOMIC);
 	} else {
 		cfg80211_connect_result(padapter->pnetdev, cur_network->network.mac_address
-			, pmlmepriv->assoc_req+sizeof(struct ieee80211_hdr_3addr)+2
-			, pmlmepriv->assoc_req_len-sizeof(struct ieee80211_hdr_3addr)-2
-			, pmlmepriv->assoc_rsp+sizeof(struct ieee80211_hdr_3addr)+6
-			, pmlmepriv->assoc_rsp_len-sizeof(struct ieee80211_hdr_3addr)-6
+			, pmlmepriv->assoc_req + sizeof(struct ieee80211_hdr_3addr) + 2
+			, pmlmepriv->assoc_req_len - sizeof(struct ieee80211_hdr_3addr) - 2
+			, pmlmepriv->assoc_rsp + sizeof(struct ieee80211_hdr_3addr) + 6
+			, pmlmepriv->assoc_rsp_len - sizeof(struct ieee80211_hdr_3addr) - 6
 			, WLAN_STATUS_SUCCESS, GFP_ATOMIC);
 	}
 }
@@ -720,7 +719,7 @@ static int rtw_cfg80211_set_encryption(struct net_device *dev, struct ieee_param
 	param->u.crypt.err = 0;
 	param->u.crypt.alg[IEEE_CRYPT_ALG_NAME_LEN - 1] = '\0';
 
-	if (param_len < (u32) ((u8 *) param->u.crypt.key - (u8 *) param) + param->u.crypt.key_len) {
+	if (param_len < (u32)((u8 *)param->u.crypt.key - (u8 *)param) + param->u.crypt.key_len) {
 		ret =  -EINVAL;
 		goto exit;
 	}
@@ -1035,10 +1034,10 @@ static int cfg80211_rtw_get_station(struct wiphy *wiphy,
 	}
 
 	/* for Ad-Hoc/AP mode */
-	if ((check_fwstate(pmlmepriv, WIFI_ADHOC_STATE)
- || check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE)
- || check_fwstate(pmlmepriv, WIFI_AP_STATE))
-		&& check_fwstate(pmlmepriv, _FW_LINKED)) {
+	if ((check_fwstate(pmlmepriv, WIFI_ADHOC_STATE) ||
+	     check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE) ||
+	     check_fwstate(pmlmepriv, WIFI_AP_STATE)) &&
+	    check_fwstate(pmlmepriv, _FW_LINKED)) {
 		/* TODO: should acquire station info... */
 	}
 
@@ -1237,7 +1236,7 @@ static int cfg80211_rtw_scan(struct wiphy *wiphy
 	spin_unlock_bh(&pwdev_priv->scan_req_lock);
 
 	if (check_fwstate(pmlmepriv, WIFI_AP_STATE) == true) {
-		if (check_fwstate(pmlmepriv, WIFI_UNDER_WPS|_FW_UNDER_SURVEY|_FW_UNDER_LINKING) == true) {
+		if (check_fwstate(pmlmepriv, WIFI_UNDER_WPS | _FW_UNDER_SURVEY | _FW_UNDER_LINKING) == true) {
 			need_indicate_scan_done = true;
 			goto check_need_indicate_scan_done;
 		}
@@ -1291,7 +1290,7 @@ static int cfg80211_rtw_scan(struct wiphy *wiphy
 	}
 
 	/* parsing channels, n_channels */
-	memset(ch, 0, sizeof(struct rtw_ieee80211_channel)*RTW_CHANNEL_SCAN_AMOUNT);
+	memset(ch, 0, sizeof(struct rtw_ieee80211_channel) * RTW_CHANNEL_SCAN_AMOUNT);
 	for (i = 0; i < request->n_channels && i < RTW_CHANNEL_SCAN_AMOUNT; i++) {
 		ch[i].hw_value = request->channels[i]->hw_value;
 		ch[i].flags = request->channels[i]->flags;
@@ -1305,7 +1304,7 @@ static int cfg80211_rtw_scan(struct wiphy *wiphy
 	} else if (request->n_channels <= 4) {
 		for (j = request->n_channels - 1; j >= 0; j--)
 			for (i = 0; i < survey_times; i++)
-				memcpy(&ch[j*survey_times+i], &ch[j], sizeof(struct rtw_ieee80211_channel));
+				memcpy(&ch[j * survey_times + i], &ch[j], sizeof(struct rtw_ieee80211_channel));
 		_status = rtw_sitesurvey_cmd(padapter, ssid, RTW_SSID_SCAN_AMOUNT, ch, survey_times * request->n_channels);
 	} else {
 		_status = rtw_sitesurvey_cmd(padapter, ssid, RTW_SSID_SCAN_AMOUNT, NULL, 0);
@@ -1461,7 +1460,7 @@ static int rtw_cfg80211_set_wpa_ie(struct adapter *padapter, u8 *pie, size_t iel
 		goto exit;
 	}
 
-	if (ielen > MAX_WPA_IE_LEN+MAX_WPS_IE_LEN+MAX_P2P_IE_LEN) {
+	if (ielen > MAX_WPA_IE_LEN + MAX_WPS_IE_LEN + MAX_P2P_IE_LEN) {
 		ret = -EINVAL;
 		goto exit;
 	}
@@ -1481,19 +1480,19 @@ static int rtw_cfg80211_set_wpa_ie(struct adapter *padapter, u8 *pie, size_t iel
 
 	pwpa = rtw_get_wpa_ie(buf, &wpa_ielen, ielen);
 	if (pwpa && wpa_ielen > 0) {
-		if (rtw_parse_wpa_ie(pwpa, wpa_ielen+2, &group_cipher, &pairwise_cipher, NULL) == _SUCCESS) {
+		if (rtw_parse_wpa_ie(pwpa, wpa_ielen + 2, &group_cipher, &pairwise_cipher, NULL) == _SUCCESS) {
 			padapter->securitypriv.dot11AuthAlgrthm = dot11AuthAlgrthm_8021X;
 			padapter->securitypriv.ndisauthtype = Ndis802_11AuthModeWPAPSK;
-			memcpy(padapter->securitypriv.supplicant_ie, &pwpa[0], wpa_ielen+2);
+			memcpy(padapter->securitypriv.supplicant_ie, &pwpa[0], wpa_ielen + 2);
 		}
 	}
 
 	pwpa2 = rtw_get_wpa2_ie(buf, &wpa2_ielen, ielen);
 	if (pwpa2 && wpa2_ielen > 0) {
-		if (rtw_parse_wpa2_ie(pwpa2, wpa2_ielen+2, &group_cipher, &pairwise_cipher, NULL) == _SUCCESS) {
+		if (rtw_parse_wpa2_ie(pwpa2, wpa2_ielen + 2, &group_cipher, &pairwise_cipher, NULL) == _SUCCESS) {
 			padapter->securitypriv.dot11AuthAlgrthm = dot11AuthAlgrthm_8021X;
 			padapter->securitypriv.ndisauthtype = Ndis802_11AuthModeWPA2PSK;
-			memcpy(padapter->securitypriv.supplicant_ie, &pwpa2[0], wpa2_ielen+2);
+			memcpy(padapter->securitypriv.supplicant_ie, &pwpa2[0], wpa2_ielen + 2);
 		}
 	}
 
@@ -1892,7 +1891,7 @@ static int cfg80211_rtw_set_pmksa(struct wiphy *wiphy,
 
 			memcpy(psecuritypriv->PMKIDList[index].PMKID, (u8 *)pmksa->pmkid, WLAN_PMKID_LEN);
 			psecuritypriv->PMKIDList[index].bUsed = true;
-			psecuritypriv->PMKIDIndex = index+1;
+			psecuritypriv->PMKIDIndex = index + 1;
 			blInserted = true;
 			break;
 		}
@@ -2094,8 +2093,8 @@ static netdev_tx_t rtw_cfg80211_monitor_if_xmit_entry(struct sk_buff *skb, struc
 		_rtw_xmit_entry(skb, padapter->pnetdev);
 		return NETDEV_TX_OK;
 
-	} else if ((frame_control & (IEEE80211_FCTL_FTYPE|IEEE80211_FCTL_STYPE)) ==
-		   (IEEE80211_FTYPE_MGMT|IEEE80211_STYPE_ACTION)) {
+	} else if ((frame_control & (IEEE80211_FCTL_FTYPE | IEEE80211_FCTL_STYPE)) ==
+		   (IEEE80211_FTYPE_MGMT | IEEE80211_STYPE_ACTION)) {
 		/* only for action frames */
 		struct xmit_frame		*pmgntframe;
 		struct pkt_attrib	*pattrib;
@@ -2209,7 +2208,7 @@ static int rtw_cfg80211_add_monitor_if(struct adapter *padapter, char *name, str
 		goto out;
 
 	*ndev = pwdev_priv->pmon_ndev = mon_ndev;
-	memcpy(pwdev_priv->ifname_mon, name, IFNAMSIZ+1);
+	memcpy(pwdev_priv->ifname_mon, name, IFNAMSIZ + 1);
 
 out:
 	if (ret && mon_wdev) {
@@ -2303,14 +2302,14 @@ static int rtw_add_beacon(struct adapter *adapter, const u8 *head, size_t head_l
 	if (head_len < 24)
 		return -EINVAL;
 
-	pbuf = rtw_zmalloc(head_len+tail_len);
+	pbuf = rtw_zmalloc(head_len + tail_len);
 	if (!pbuf)
 		return -ENOMEM;
 
-	memcpy(pbuf, (void *)head+24, head_len-24);/*  24 =beacon header len. */
-	memcpy(pbuf+head_len-24, (void *)tail, tail_len);
+	memcpy(pbuf, (void *)head + 24, head_len - 24);/*  24 =beacon header len. */
+	memcpy(pbuf + head_len - 24, (void *)tail, tail_len);
 
-	len = head_len+tail_len-24;
+	len = head_len + tail_len - 24;
 
 	/* check wps ie if inclued */
 	rtw_get_wps_ie(pbuf + _FIXED_IE_LENGTH_, len - _FIXED_IE_LENGTH_, NULL, &wps_ielen);
@@ -2600,7 +2599,7 @@ static int cfg80211_rtw_mgmt_tx(struct wiphy *wiphy,
 	pwdev_priv = adapter_wdev_data(padapter);
 
 	/* cookie generation */
-	*cookie = (unsigned long) buf;
+	*cookie = (unsigned long)buf;
 
 	/* indicate ack before issue frame to avoid racing with rsp frame */
 	rtw_cfg80211_mgmt_tx_status(padapter, *cookie, buf, len, ack, GFP_KERNEL);
-- 
2.39.2 (Apple Git-143)


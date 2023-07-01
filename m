Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE3B744877
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 12:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjGAKZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 06:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjGAKZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 06:25:45 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE9C11FCB
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jul 2023 03:25:43 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b6afc1ceffso45367251fa.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jul 2023 03:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1688207142; x=1690799142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=clI9fiq1iEcRtB6iNCIk8JBKBujqSi3c+gmf90kUWRE=;
        b=r9o+mc5F8h0HyZ3CfSL4FrLY4tFSnT7SlSEywz/LsmCaQtyEnuBFAksRQvlKdeZt4M
         KYhUoQRbNX+SXPQKXQgq9SJHnHZy6arPPFkyyQted1yZBeiUBNVn3NfkrvYjP/u5v1Da
         rIUR3LSuX3lM51wu+jH37kekb/Y0eWzJ9UB01zmkjBuy98dCtMODYlI2GZtcPJqrcxru
         PgpvZu9v1fmtx++GiFR14uAyYElMwVSTOyp1vemxLFL+TvxqRzrxXUTbqd+n/mlUqw7e
         PxLDbVGQD5g0x8cxbDoaInXc+5GZ1xHG79XNGrBTj74Lw5qHpz6QqAvlxuPZDxLo66FZ
         aHHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688207142; x=1690799142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=clI9fiq1iEcRtB6iNCIk8JBKBujqSi3c+gmf90kUWRE=;
        b=lZ8w7NW15VnnQ3iritHw/GAYpTFO7ET1QCmbzdEtgonozeSL7JZ5rC8Az5GylUT1oD
         RGPyUYrEwnqAc5AwQ0JXm7Q1OnOq8wZL3+HADpXAoJ6q1020/saAHo17o11rKDRJKmqW
         1o3kAh1fRAeQCizJC915z62yaZ+NvJ1eWrxOrGJEvYPUbdST4mjlbK2Vqlzq3v+MUXoK
         WW9y8Uqr9lOqNcpMWDb3bHhy9yVmKq/b8qFfFrALXtBSwaGueo2SLdvF9pmbL2ercksh
         QDHifqi+5z7y8yBNPDQefDqCL+qDf3RrStVXiHEb8GCUVha+KLVaosFuuCArwpInRgli
         FEEQ==
X-Gm-Message-State: ABy/qLbMcNKGlehFVkn3GjL6VrBWjXNtboDalJGsdRqyb3PBEMaqVzTG
        Bha/iOVb5DUla8zAnBzk15Y=
X-Google-Smtp-Source: APBJJlE1XByDiG2QhYXA7oPbgM9U6jwxP0GkFu53zwp/PfmOdp3LAXegd8nc1+o6okVO+tlrmocMeg==
X-Received: by 2002:a2e:7214:0:b0:2b6:cecb:2f0f with SMTP id n20-20020a2e7214000000b002b6cecb2f0fmr3708508ljc.2.1688207141632;
        Sat, 01 Jul 2023 03:25:41 -0700 (PDT)
Received: from localhost.localdomain ([2a02:810a:9640:26a8:185:3db5:c5f0:49bb])
        by smtp.gmail.com with ESMTPSA id i7-20020aa7c9c7000000b0051a3334f873sm7597535edt.89.2023.07.01.03.25.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 01 Jul 2023 03:25:41 -0700 (PDT)
From:   Franziska Naepelt <franziska.naepelt@googlemail.com>
To:     franziska.naepelt@googlemail.com
Cc:     dan.carpenter@linaro.org, eperi1024@gmail.com,
        gregkh@linuxfoundation.org, guozihua@huawei.com,
        hdegoede@redhat.com, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, philipp.g.hortmann@gmail.com,
        quic_vjakkam@quicinc.com, tegongkang@gmail.com
Subject: [PATCH v4 1/3] staging: rtl8723bs: Fix space issues
Date:   Sat,  1 Jul 2023 12:25:38 +0200
Message-Id: <20230701102538.5359-1-franziska.naepelt@googlemail.com>
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

Fix the following checkpatch space issues:
- CHECK: spaces preferred around that '*' (ctx:VxV)
- CHECK: spaces preferred around that '+' (ctx:VxV)
- CHECK: spaces preferred around that '-' (ctx:VxV)
- CHECK: spaces preferred around that '|' (ctx:VxV)
- CHECK: No space is necessary after a cast
- WARNING: please, no spaces at the start of a line

Signed-off-by: Franziska Naepelt <franziska.naepelt@googlemail.com>
---
v4: Fix sign-off email address
---
 .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 76 +++++++++----------
 1 file changed, 38 insertions(+), 38 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index 2ae7843abdf7..7a651952f77c 100644
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
@@ -277,9 +277,9 @@ struct cfg80211_bss *rtw_cfg80211_inform_bss(struct adapter *padapter, struct wl
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
@@ -449,20 +449,20 @@ void rtw_cfg80211_indicate_connect(struct adapter *padapter)
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
@@ -708,7 +708,7 @@ static int rtw_cfg80211_set_encryption(struct net_device *dev, struct ieee_param
 	param->u.crypt.err = 0;
 	param->u.crypt.alg[IEEE_CRYPT_ALG_NAME_LEN - 1] = '\0';

-	if (param_len < (u32) ((u8 *) param->u.crypt.key - (u8 *) param) + param->u.crypt.key_len) {
+	if (param_len < (u32)((u8 *)param->u.crypt.key - (u8 *)param) + param->u.crypt.key_len) {
 		ret =  -EINVAL;
 		goto exit;
 	}
@@ -1019,10 +1019,10 @@ static int cfg80211_rtw_get_station(struct wiphy *wiphy,
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

@@ -1219,7 +1219,7 @@ static int cfg80211_rtw_scan(struct wiphy *wiphy
 	spin_unlock_bh(&pwdev_priv->scan_req_lock);

 	if (check_fwstate(pmlmepriv, WIFI_AP_STATE) == true) {
-		if (check_fwstate(pmlmepriv, WIFI_UNDER_WPS|_FW_UNDER_SURVEY|_FW_UNDER_LINKING) == true) {
+		if (check_fwstate(pmlmepriv, WIFI_UNDER_WPS | _FW_UNDER_SURVEY | _FW_UNDER_LINKING) == true) {
 			need_indicate_scan_done = true;
 			goto check_need_indicate_scan_done;
 		}
@@ -1273,7 +1273,7 @@ static int cfg80211_rtw_scan(struct wiphy *wiphy
 	}

 	/* parsing channels, n_channels */
-	memset(ch, 0, sizeof(struct rtw_ieee80211_channel)*RTW_CHANNEL_SCAN_AMOUNT);
+	memset(ch, 0, sizeof(struct rtw_ieee80211_channel) * RTW_CHANNEL_SCAN_AMOUNT);
 	for (i = 0; i < request->n_channels && i < RTW_CHANNEL_SCAN_AMOUNT; i++) {
 		ch[i].hw_value = request->channels[i]->hw_value;
 		ch[i].flags = request->channels[i]->flags;
@@ -1287,7 +1287,7 @@ static int cfg80211_rtw_scan(struct wiphy *wiphy
 	} else if (request->n_channels <= 4) {
 		for (j = request->n_channels - 1; j >= 0; j--)
 			for (i = 0; i < survey_times; i++)
-				memcpy(&ch[j*survey_times+i], &ch[j], sizeof(struct rtw_ieee80211_channel));
+				memcpy(&ch[j * survey_times + i], &ch[j], sizeof(struct rtw_ieee80211_channel));
 		_status = rtw_sitesurvey_cmd(padapter, ssid, RTW_SSID_SCAN_AMOUNT, ch, survey_times * request->n_channels);
 	} else {
 		_status = rtw_sitesurvey_cmd(padapter, ssid, RTW_SSID_SCAN_AMOUNT, NULL, 0);
@@ -1436,7 +1436,7 @@ static int rtw_cfg80211_set_wpa_ie(struct adapter *padapter, u8 *pie, size_t iel
 		goto exit;
 	}

-	if (ielen > MAX_WPA_IE_LEN+MAX_WPS_IE_LEN+MAX_P2P_IE_LEN) {
+	if (ielen > MAX_WPA_IE_LEN + MAX_WPS_IE_LEN + MAX_P2P_IE_LEN) {
 		ret = -EINVAL;
 		goto exit;
 	}
@@ -1456,19 +1456,19 @@ static int rtw_cfg80211_set_wpa_ie(struct adapter *padapter, u8 *pie, size_t iel

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

@@ -1863,7 +1863,7 @@ static int cfg80211_rtw_set_pmksa(struct wiphy *wiphy,
 		if (!memcmp(psecuritypriv->PMKIDList[index].Bssid, (u8 *)pmksa->bssid, ETH_ALEN)) {
 			memcpy(psecuritypriv->PMKIDList[index].PMKID, (u8 *)pmksa->pmkid, WLAN_PMKID_LEN);
 			psecuritypriv->PMKIDList[index].bUsed = true;
-			psecuritypriv->PMKIDIndex = index+1;
+			psecuritypriv->PMKIDIndex = index + 1;
 			blInserted = true;
 			break;
 		}
@@ -2064,8 +2064,8 @@ static netdev_tx_t rtw_cfg80211_monitor_if_xmit_entry(struct sk_buff *skb, struc
 		_rtw_xmit_entry(skb, padapter->pnetdev);
 		return NETDEV_TX_OK;

-	} else if ((frame_control & (IEEE80211_FCTL_FTYPE|IEEE80211_FCTL_STYPE)) ==
-		   (IEEE80211_FTYPE_MGMT|IEEE80211_STYPE_ACTION)) {
+	} else if ((frame_control & (IEEE80211_FCTL_FTYPE | IEEE80211_FCTL_STYPE)) ==
+		   (IEEE80211_FTYPE_MGMT | IEEE80211_STYPE_ACTION)) {
 		/* only for action frames */
 		struct xmit_frame		*pmgntframe;
 		struct pkt_attrib	*pattrib;
@@ -2174,7 +2174,7 @@ static int rtw_cfg80211_add_monitor_if(struct adapter *padapter, char *name, str
 		goto out;

 	*ndev = pwdev_priv->pmon_ndev = mon_ndev;
-	memcpy(pwdev_priv->ifname_mon, name, IFNAMSIZ+1);
+	memcpy(pwdev_priv->ifname_mon, name, IFNAMSIZ + 1);

 out:
 	if (ret && mon_wdev) {
@@ -2268,14 +2268,14 @@ static int rtw_add_beacon(struct adapter *adapter, const u8 *head, size_t head_l
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
@@ -2558,7 +2558,7 @@ static int cfg80211_rtw_mgmt_tx(struct wiphy *wiphy,
 	pwdev_priv = adapter_wdev_data(padapter);

 	/* cookie generation */
-	*cookie = (unsigned long) buf;
+	*cookie = (unsigned long)buf;

 	/* indicate ack before issue frame to avoid racing with rsp frame */
 	rtw_cfg80211_mgmt_tx_status(padapter, *cookie, buf, len, ack, GFP_KERNEL);
--
2.39.2 (Apple Git-143)


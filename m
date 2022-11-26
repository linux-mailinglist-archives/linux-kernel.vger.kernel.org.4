Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE916396FA
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 17:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbiKZQCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 11:02:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiKZQBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 11:01:44 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31E6193ED
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 08:01:43 -0800 (PST)
Received: from dslb-188-096-151-149.188.096.pools.vodafone-ip.de ([188.96.151.149] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1oyxcZ-0000Ub-AR; Sat, 26 Nov 2022 17:01:39 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 07/10] staging: r8188eu: exit if beacon is not from our bss
Date:   Sat, 26 Nov 2022 17:01:26 +0100
Message-Id: <20221126160129.178697-8-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221126160129.178697-1-martin@kaiser.cx>
References: <20221126160129.178697-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not process an incoming beacon message in the OnBeacon function if the
beacon was sent by a base station other than the one to which we're
connected.

This patch does not modify the behaviour of the code. It reverts the if
condition and returns if the beacon should not be processed. This is
simpler than wrapping the entire processing into a large if clause.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c | 103 ++++++++++----------
 1 file changed, 52 insertions(+), 51 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index f7d3ecf551bf..a15998d912a7 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -569,67 +569,68 @@ static void OnBeacon(struct adapter *padapter, struct recv_frame *precv_frame)
 		return;
 	}
 
-	if (!memcmp(mgmt->bssid, get_my_bssid(&pmlmeinfo->network), ETH_ALEN)) {
-		if (pmlmeinfo->state & WIFI_FW_AUTH_NULL) {
-			/* we should update current network before auth, or some IE is wrong */
-			pbss = kmalloc(sizeof(struct wlan_bssid_ex), GFP_ATOMIC);
-			if (pbss) {
-				if (collect_bss_info(padapter, precv_frame, pbss) == _SUCCESS) {
-					update_network(&pmlmepriv->cur_network.network, pbss, padapter, true);
-					rtw_get_bcn_info(&pmlmepriv->cur_network);
-				}
-				kfree(pbss);
+	if (memcmp(mgmt->bssid, get_my_bssid(&pmlmeinfo->network), ETH_ALEN))
+		return;
+
+	if (pmlmeinfo->state & WIFI_FW_AUTH_NULL) {
+		/* we should update current network before auth, or some IE is wrong */
+		pbss = kmalloc(sizeof(struct wlan_bssid_ex), GFP_ATOMIC);
+		if (pbss) {
+			if (collect_bss_info(padapter, precv_frame, pbss) == _SUCCESS) {
+				update_network(&pmlmepriv->cur_network.network, pbss, padapter, true);
+				rtw_get_bcn_info(&pmlmepriv->cur_network);
 			}
+			kfree(pbss);
+		}
 
-			/* check the vendor of the assoc AP */
-			pmlmeinfo->assoc_AP_vendor = check_assoc_AP(pframe + sizeof(struct ieee80211_hdr_3addr), len - sizeof(struct ieee80211_hdr_3addr));
+		/* check the vendor of the assoc AP */
+		pmlmeinfo->assoc_AP_vendor = check_assoc_AP(pframe + sizeof(struct ieee80211_hdr_3addr), len - sizeof(struct ieee80211_hdr_3addr));
 
-			pmlmeext->TSFValue = le64_to_cpu(mgmt->u.beacon.timestamp);
+		pmlmeext->TSFValue = le64_to_cpu(mgmt->u.beacon.timestamp);
 
-			/* start auth */
-			start_clnt_auth(padapter);
+		/* start auth */
+		start_clnt_auth(padapter);
 
-			return;
-		}
+		return;
+	}
 
-		if (((pmlmeinfo->state & 0x03) == WIFI_FW_STATION_STATE) && (pmlmeinfo->state & WIFI_FW_ASSOC_SUCCESS)) {
-			psta = rtw_get_stainfo(pstapriv, mgmt->sa);
-			if (psta) {
-				ret = rtw_check_bcn_info(padapter, pframe, len);
-				if (!ret) {
-					receive_disconnect(padapter,
-							   pmlmeinfo->network.MacAddress, 0);
-					return;
-				}
-				/* update WMM, ERP in the beacon */
-				/* todo: the timer is used instead of the number of the beacon received */
-				if ((sta_rx_pkts(psta) & 0xf) == 0)
-					update_beacon_info(padapter, ie_ptr, ie_len, psta);
-				process_p2p_ps_ie(padapter, ie_ptr, ie_len);
+	if (((pmlmeinfo->state & 0x03) == WIFI_FW_STATION_STATE) && (pmlmeinfo->state & WIFI_FW_ASSOC_SUCCESS)) {
+		psta = rtw_get_stainfo(pstapriv, mgmt->sa);
+		if (psta) {
+			ret = rtw_check_bcn_info(padapter, pframe, len);
+			if (!ret) {
+				receive_disconnect(padapter,
+						   pmlmeinfo->network.MacAddress, 0);
+				return;
 			}
-		} else if ((pmlmeinfo->state & 0x03) == WIFI_FW_ADHOC_STATE) {
-			psta = rtw_get_stainfo(pstapriv, mgmt->sa);
-			if (psta) {
-				/* update WMM, ERP in the beacon */
-				/* todo: the timer is used instead of the number of the beacon received */
-				if ((sta_rx_pkts(psta) & 0xf) == 0)
-					update_beacon_info(padapter, ie_ptr, ie_len, psta);
-			} else {
-				/* allocate a new CAM entry for IBSS station */
-				cam_idx = allocate_fw_sta_entry(padapter);
-				if (cam_idx == NUM_STA)
-					return;
+			/* update WMM, ERP in the beacon */
+			/* todo: the timer is used instead of the number of the beacon received */
+			if ((sta_rx_pkts(psta) & 0xf) == 0)
+				update_beacon_info(padapter, ie_ptr, ie_len, psta);
+			process_p2p_ps_ie(padapter, ie_ptr, ie_len);
+		}
+	} else if ((pmlmeinfo->state & 0x03) == WIFI_FW_ADHOC_STATE) {
+		psta = rtw_get_stainfo(pstapriv, mgmt->sa);
+		if (psta) {
+			/* update WMM, ERP in the beacon */
+			/* todo: the timer is used instead of the number of the beacon received */
+			if ((sta_rx_pkts(psta) & 0xf) == 0)
+				update_beacon_info(padapter, ie_ptr, ie_len, psta);
+		} else {
+			/* allocate a new CAM entry for IBSS station */
+			cam_idx = allocate_fw_sta_entry(padapter);
+			if (cam_idx == NUM_STA)
+				return;
 
-				/* get supported rate */
-				if (update_sta_support_rate(padapter, ie_ptr, ie_len, cam_idx) == _FAIL) {
-					pmlmeinfo->FW_sta_info[cam_idx].status = 0;
-					return;
-				}
+			/* get supported rate */
+			if (update_sta_support_rate(padapter, ie_ptr, ie_len, cam_idx) == _FAIL) {
+				pmlmeinfo->FW_sta_info[cam_idx].status = 0;
+				return;
+			}
 
-				pmlmeext->TSFValue = le64_to_cpu(mgmt->u.beacon.timestamp);
+			pmlmeext->TSFValue = le64_to_cpu(mgmt->u.beacon.timestamp);
 
-				report_add_sta_event(padapter, mgmt->sa, cam_idx);
-			}
+			report_add_sta_event(padapter, mgmt->sa, cam_idx);
 		}
 	}
 }
-- 
2.30.2


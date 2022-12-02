Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 000D364035B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 10:32:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232524AbiLBJc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 04:32:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232573AbiLBJcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 04:32:19 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47097BDCF2
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 01:32:19 -0800 (PST)
Received: from ipservice-092-217-087-074.092.217.pools.vodafone-ip.de ([92.217.87.74] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1p12Oy-0001zC-5v; Fri, 02 Dec 2022 10:32:12 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 1/2] staging: r8188eu: use subtype helpers in collect_bss_info
Date:   Fri,  2 Dec 2022 10:31:58 +0100
Message-Id: <20221202093159.404111-2-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221202093159.404111-1-martin@kaiser.cx>
References: <20221202093159.404111-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the iee80211 helper functions to check the frame subtype in
collect_bss_info. Replace the call to the driver-specific
GetFrameSubType function.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c | 26 +++++++++------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index 95a9470f4c99..1b9cf7596a76 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -5963,10 +5963,11 @@ void site_survey(struct adapter *padapter)
 /* collect bss info from Beacon and Probe request/response frames. */
 u8 collect_bss_info(struct adapter *padapter, struct recv_frame *precv_frame, struct wlan_bssid_ex *bssid)
 {
+	struct ieee80211_mgmt *mgmt = (struct ieee80211_mgmt *)precv_frame->rx_data;
 	int	i;
 	u32	len;
 	u8 *p;
-	u16 val16, subtype;
+	u16 val16;
 	u8 *pframe = precv_frame->rx_data;
 	u32	packet_len = precv_frame->len;
 	u8 ie_offset;
@@ -5982,23 +5983,18 @@ u8 collect_bss_info(struct adapter *padapter, struct recv_frame *precv_frame, st
 
 	memset(bssid, 0, sizeof(struct wlan_bssid_ex));
 
-	subtype = GetFrameSubType(pframe);
-
-	if (subtype == WIFI_BEACON) {
+	if (ieee80211_is_beacon(mgmt->frame_control)) {
 		bssid->Reserved[0] = 1;
 		ie_offset = _BEACON_IE_OFFSET_;
+	} else if (ieee80211_is_probe_req(mgmt->frame_control)) {
+		ie_offset = _PROBEREQ_IE_OFFSET_;
+		bssid->Reserved[0] = 2;
+	} else if (ieee80211_is_probe_resp(mgmt->frame_control)) {
+		ie_offset = _PROBERSP_IE_OFFSET_;
+		bssid->Reserved[0] = 3;
 	} else {
-		/*  FIXME : more type */
-		if (subtype == WIFI_PROBEREQ) {
-			ie_offset = _PROBEREQ_IE_OFFSET_;
-			bssid->Reserved[0] = 2;
-		} else if (subtype == WIFI_PROBERSP) {
-			ie_offset = _PROBERSP_IE_OFFSET_;
-			bssid->Reserved[0] = 3;
-		} else {
-			bssid->Reserved[0] = 0;
-			ie_offset = _FIXED_IE_LENGTH_;
-		}
+		bssid->Reserved[0] = 0;
+		ie_offset = _FIXED_IE_LENGTH_;
 	}
 
 	bssid->Length = sizeof(struct wlan_bssid_ex) - MAX_IE_SZ + len;
-- 
2.30.2


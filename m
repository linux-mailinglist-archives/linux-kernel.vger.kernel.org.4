Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB416396F9
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 17:02:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbiKZQCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 11:02:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiKZQBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 11:01:43 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80FA193DF
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 08:01:42 -0800 (PST)
Received: from dslb-188-096-151-149.188.096.pools.vodafone-ip.de ([188.96.151.149] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1oyxcX-0000Ub-Rx; Sat, 26 Nov 2022 17:01:37 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 05/10] staging: r8188eu: use ie buffer in update_beacon_info
Date:   Sat, 26 Nov 2022 17:01:24 +0100
Message-Id: <20221126160129.178697-6-martin@kaiser.cx>
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

The update_beacon_info function parses information elements of a beacon
message. It should take the pointer to the information elements and their
total length, not the entire beacon message.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c    | 4 ++--
 drivers/staging/r8188eu/core/rtw_wlan_util.c   | 9 +++------
 drivers/staging/r8188eu/include/rtw_mlme_ext.h | 3 +--
 3 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index 07c57a2b61b9..38dc98cffbc4 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -604,7 +604,7 @@ static void OnBeacon(struct adapter *padapter, struct recv_frame *precv_frame)
 				/* update WMM, ERP in the beacon */
 				/* todo: the timer is used instead of the number of the beacon received */
 				if ((sta_rx_pkts(psta) & 0xf) == 0)
-					update_beacon_info(padapter, pframe, len, psta);
+					update_beacon_info(padapter, ie_ptr, ie_len, psta);
 				process_p2p_ps_ie(padapter, ie_ptr, ie_len);
 			}
 		} else if ((pmlmeinfo->state & 0x03) == WIFI_FW_ADHOC_STATE) {
@@ -613,7 +613,7 @@ static void OnBeacon(struct adapter *padapter, struct recv_frame *precv_frame)
 				/* update WMM, ERP in the beacon */
 				/* todo: the timer is used instead of the number of the beacon received */
 				if ((sta_rx_pkts(psta) & 0xf) == 0)
-					update_beacon_info(padapter, pframe, len, psta);
+					update_beacon_info(padapter, ie_ptr, ie_len, psta);
 			} else {
 				/* allocate a new CAM entry for IBSS station */
 				cam_idx = allocate_fw_sta_entry(padapter);
diff --git a/drivers/staging/r8188eu/core/rtw_wlan_util.c b/drivers/staging/r8188eu/core/rtw_wlan_util.c
index 965bb7da4cce..da3465d6bb0f 100644
--- a/drivers/staging/r8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/r8188eu/core/rtw_wlan_util.c
@@ -1035,16 +1035,13 @@ int rtw_check_bcn_info(struct adapter  *Adapter, u8 *pframe, u32 packet_len)
 	return _FAIL;
 }
 
-void update_beacon_info(struct adapter *padapter, u8 *pframe, uint pkt_len, struct sta_info *psta)
+void update_beacon_info(struct adapter *padapter, u8 *ie_ptr, uint ie_len, struct sta_info *psta)
 {
 	unsigned int i;
-	unsigned int len;
 	struct ndis_802_11_var_ie *pIE;
 
-	len = pkt_len - (_BEACON_IE_OFFSET_ + WLAN_HDR_A3_LEN);
-
-	for (i = 0; i < len;) {
-		pIE = (struct ndis_802_11_var_ie *)(pframe + (_BEACON_IE_OFFSET_ + WLAN_HDR_A3_LEN) + i);
+	for (i = 0; i < ie_len;) {
+		pIE = (struct ndis_802_11_var_ie *)(ie_ptr + i);
 
 		switch (pIE->ElementID) {
 		case _HT_EXTRA_INFO_IE_:	/* HT info */
diff --git a/drivers/staging/r8188eu/include/rtw_mlme_ext.h b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
index 089bd5446773..6724424a334e 100644
--- a/drivers/staging/r8188eu/include/rtw_mlme_ext.h
+++ b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
@@ -447,8 +447,7 @@ void HTOnAssocRsp(struct adapter *padapter);
 void ERP_IE_handler(struct adapter *padapter, struct ndis_802_11_var_ie *pIE);
 void VCS_update(struct adapter *padapter, struct sta_info *psta);
 
-void update_beacon_info(struct adapter *padapter, u8 *pframe, uint len,
-			struct sta_info *psta);
+void update_beacon_info(struct adapter *padapter, u8 *ie_ptr, uint ie_len, struct sta_info *psta);
 int rtw_check_bcn_info(struct adapter  *Adapter, u8 *pframe, u32 packet_len);
 void update_IOT_info(struct adapter *padapter);
 void update_capinfo(struct adapter *adapter, u16 updatecap);
-- 
2.30.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4E0064034A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 10:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232511AbiLBJ0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 04:26:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232774AbiLBJZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 04:25:38 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B2113E17
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 01:25:37 -0800 (PST)
Received: from ipservice-092-217-087-074.092.217.pools.vodafone-ip.de ([92.217.87.74] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1p12IV-0001tn-E9; Fri, 02 Dec 2022 10:25:31 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 2/2] staging: r8188eu: remove unused da parameter
Date:   Fri,  2 Dec 2022 10:25:25 +0100
Message-Id: <20221202092525.403887-3-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221202092525.403887-1-martin@kaiser.cx>
References: <20221202092525.403887-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All callers of issue_probereq_p2p set the da parameter to NULL. Remove
this parameters and the code that runs only for da != NULL.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c   | 28 ++++++++-----------
 drivers/staging/r8188eu/core/rtw_p2p.c        |  8 +++---
 .../staging/r8188eu/include/rtw_mlme_ext.h    |  2 +-
 3 files changed, 17 insertions(+), 21 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index cf7b39cfb8f4..95a9470f4c99 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -3183,7 +3183,7 @@ void issue_probersp_p2p(struct adapter *padapter, unsigned char *da)
 	dump_mgntframe(padapter, pmgntframe);
 }
 
-inline void issue_probereq_p2p(struct adapter *padapter, u8 *da)
+inline void issue_probereq_p2p(struct adapter *padapter)
 {
 	struct xmit_frame		*pmgntframe;
 	struct pkt_attrib		*pattrib;
@@ -3216,20 +3216,16 @@ inline void issue_probereq_p2p(struct adapter *padapter, u8 *da)
 	fctrl = &pwlanhdr->frame_control;
 	*(fctrl) = 0;
 
-	if (da) {
-		memcpy(pwlanhdr->addr1, da, ETH_ALEN);
-		memcpy(pwlanhdr->addr3, da, ETH_ALEN);
+	if ((pwdinfo->p2p_info.scan_op_ch_only) || (pwdinfo->rx_invitereq_info.scan_op_ch_only)) {
+		/*	This two flags will be set when this is only the P2P client mode. */
+		memcpy(pwlanhdr->addr1, pwdinfo->p2p_peer_interface_addr, ETH_ALEN);
+		memcpy(pwlanhdr->addr3, pwdinfo->p2p_peer_interface_addr, ETH_ALEN);
 	} else {
-		if ((pwdinfo->p2p_info.scan_op_ch_only) || (pwdinfo->rx_invitereq_info.scan_op_ch_only)) {
-			/*	This two flags will be set when this is only the P2P client mode. */
-			memcpy(pwlanhdr->addr1, pwdinfo->p2p_peer_interface_addr, ETH_ALEN);
-			memcpy(pwlanhdr->addr3, pwdinfo->p2p_peer_interface_addr, ETH_ALEN);
-		} else {
-			/*	broadcast probe request frame */
-			eth_broadcast_addr(pwlanhdr->addr1);
-			eth_broadcast_addr(pwlanhdr->addr3);
-		}
+		/*	broadcast probe request frame */
+		eth_broadcast_addr(pwlanhdr->addr1);
+		eth_broadcast_addr(pwlanhdr->addr3);
 	}
+
 	memcpy(pwlanhdr->addr2, mac, ETH_ALEN);
 
 	SetSeqNum(pwlanhdr, pmlmeext->mgnt_seq);
@@ -5867,9 +5863,9 @@ void site_survey(struct adapter *padapter)
 		if (ScanType == SCAN_ACTIVE) { /* obey the channel plan setting... */
 			if (rtw_p2p_chk_state(pwdinfo, P2P_STATE_SCAN) ||
 			    rtw_p2p_chk_state(pwdinfo, P2P_STATE_FIND_PHASE_SEARCH)) {
-				issue_probereq_p2p(padapter, NULL);
-				issue_probereq_p2p(padapter, NULL);
-				issue_probereq_p2p(padapter, NULL);
+				issue_probereq_p2p(padapter);
+				issue_probereq_p2p(padapter);
+				issue_probereq_p2p(padapter);
 			} else {
 				int i;
 				for (i = 0; i < RTW_SSID_SCAN_AMOUNT; i++) {
diff --git a/drivers/staging/r8188eu/core/rtw_p2p.c b/drivers/staging/r8188eu/core/rtw_p2p.c
index ce05458bd1ad..93d3c9c4399c 100644
--- a/drivers/staging/r8188eu/core/rtw_p2p.c
+++ b/drivers/staging/r8188eu/core/rtw_p2p.c
@@ -1453,7 +1453,7 @@ static void pre_tx_invitereq_handler(struct adapter *padapter)
 
 	set_channel_bwmode(padapter, pwdinfo->invitereq_info.peer_ch, HAL_PRIME_CHNL_OFFSET_DONT_CARE, HT_CHANNEL_WIDTH_20);
 	rtw_mlme_under_site_survey(padapter);
-	issue_probereq_p2p(padapter, NULL);
+	issue_probereq_p2p(padapter);
 	_set_timer(&pwdinfo->pre_tx_scan_timer, P2P_TX_PRESCAN_TIMEOUT);
 
 }
@@ -1464,7 +1464,7 @@ static void pre_tx_provdisc_handler(struct adapter *padapter)
 
 	set_channel_bwmode(padapter, pwdinfo->tx_prov_disc_info.peer_channel_num[0], HAL_PRIME_CHNL_OFFSET_DONT_CARE, HT_CHANNEL_WIDTH_20);
 	rtw_mlme_under_site_survey(padapter);
-	issue_probereq_p2p(padapter, NULL);
+	issue_probereq_p2p(padapter);
 	_set_timer(&pwdinfo->pre_tx_scan_timer, P2P_TX_PRESCAN_TIMEOUT);
 
 }
@@ -1475,7 +1475,7 @@ static void pre_tx_negoreq_handler(struct adapter *padapter)
 
 	set_channel_bwmode(padapter, pwdinfo->nego_req_info.peer_channel_num[0], HAL_PRIME_CHNL_OFFSET_DONT_CARE, HT_CHANNEL_WIDTH_20);
 	rtw_mlme_under_site_survey(padapter);
-	issue_probereq_p2p(padapter, NULL);
+	issue_probereq_p2p(padapter);
 	_set_timer(&pwdinfo->pre_tx_scan_timer, P2P_TX_PRESCAN_TIMEOUT);
 
 }
@@ -1725,7 +1725,7 @@ static void pre_tx_scan_timer_process(struct timer_list *t)
 	if (rtw_p2p_chk_state(pwdinfo, P2P_STATE_TX_PROVISION_DIS_REQ)) {
 		if (pwdinfo->tx_prov_disc_info.benable) {	/*	the provision discovery request frame is trigger to send or not */
 			p2p_protocol_wk_cmd(adapter, P2P_PRE_TX_PROVDISC_PROCESS_WK);
-			/* issue_probereq_p2p(adapter, NULL); */
+			/* issue_probereq_p2p(adapter); */
 			/* _set_timer(&pwdinfo->pre_tx_scan_timer, P2P_TX_PRESCAN_TIMEOUT); */
 		}
 	} else if (rtw_p2p_chk_state(pwdinfo, P2P_STATE_GONEGO_ING)) {
diff --git a/drivers/staging/r8188eu/include/rtw_mlme_ext.h b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
index 6724424a334e..589de7c54d93 100644
--- a/drivers/staging/r8188eu/include/rtw_mlme_ext.h
+++ b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
@@ -497,7 +497,7 @@ void issue_probersp_p2p(struct adapter *padapter, unsigned char *da);
 void issue_p2p_provision_request(struct adapter *padapter, u8 *pssid,
 				 u8 ussidlen, u8 *pdev_raddr);
 void issue_p2p_GO_request(struct adapter *padapter, u8 *raddr);
-void issue_probereq_p2p(struct adapter *padapter, u8 *da);
+void issue_probereq_p2p(struct adapter *padapter);
 void issue_p2p_invitation_response(struct adapter *padapter, u8 *raddr,
 				   u8 dialogToken, u8 success);
 void issue_p2p_invitation_request(struct adapter *padapter, u8 *raddr);
-- 
2.30.2


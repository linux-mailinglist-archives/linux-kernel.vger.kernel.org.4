Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E688C609C2F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 10:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbiJXIOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 04:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbiJXIOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 04:14:33 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8856912093
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 01:14:30 -0700 (PDT)
Received: from ipservice-092-217-079-032.092.217.pools.vodafone-ip.de ([92.217.79.32] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1omsbK-0000nk-HT; Mon, 24 Oct 2022 10:14:26 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 01/17] staging: r8188eu: restructure mlme subfunction handling
Date:   Mon, 24 Oct 2022 10:14:01 +0200
Message-Id: <20221024081417.66441-2-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221024081417.66441-1-martin@kaiser.cx>
References: <20221024081417.66441-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move some code around in rtw_mlme_ext.c to make it simpler.

mlme_sta_tbl is used only by mgt_dispatcher. Move the table inside the
function. Move mgt_dispatcher behind the handler functions. We can then
make the handler functions static.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c | 116 ++++++++++----------
 1 file changed, 57 insertions(+), 59 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index d44e455f09ca..15b7148fa898 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -12,24 +12,6 @@
 #include "../include/rtl8188e_xmit.h"
 #include "../include/rtl8188e_dm.h"
 
-/* response function for each management frame subtype, do not reorder */
-static mlme_handler mlme_sta_tbl[] = {
-	OnAssocReq,
-	OnAssocRsp,
-	OnAssocReq,
-	OnAssocRsp,
-	OnProbeReq,
-	OnProbeRsp,
-	NULL,
-	NULL,
-	OnBeacon,
-	NULL,
-	OnDisassoc,
-	OnAuthClient,
-	OnDeAuth,
-	OnAction,
-};
-
 static u8 null_addr[ETH_ALEN] = {0, 0, 0, 0, 0, 0};
 
 /**************************************************
@@ -393,47 +375,6 @@ void free_mlme_ext_priv(struct mlme_ext_priv *pmlmeext)
 	}
 }
 
-void mgt_dispatcher(struct adapter *padapter, struct recv_frame *precv_frame)
-{
-	int index;
-	mlme_handler fct;
-	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)precv_frame->rx_data;
-	struct sta_info *psta = rtw_get_stainfo(&padapter->stapriv, hdr->addr2);
-
-	if (!ieee80211_is_mgmt(hdr->frame_control))
-		return;
-
-	/* receive the frames that ra(a1) is my address or ra(a1) is bc address. */
-	if (memcmp(hdr->addr1, myid(&padapter->eeprompriv), ETH_ALEN) &&
-	    !is_broadcast_ether_addr(hdr->addr1))
-		return;
-
-	index = (le16_to_cpu(hdr->frame_control) & IEEE80211_FCTL_STYPE) >> 4;
-	if (index >= ARRAY_SIZE(mlme_sta_tbl))
-		return;
-	fct = mlme_sta_tbl[index];
-
-	if (psta) {
-		if (ieee80211_has_retry(hdr->frame_control)) {
-			if (precv_frame->attrib.seq_num == psta->RxMgmtFrameSeqNum)
-				/* drop the duplicate management frame */
-				return;
-		}
-		psta->RxMgmtFrameSeqNum = precv_frame->attrib.seq_num;
-	}
-
-	if (ieee80211_is_auth(hdr->frame_control)) {
-		if (check_fwstate(pmlmepriv, WIFI_AP_STATE))
-			fct = OnAuth;
-		else
-			fct = OnAuthClient;
-	}
-
-	if (fct)
-		fct(padapter, precv_frame);
-}
-
 static u32 p2p_listen_state_process(struct adapter *padapter, unsigned char *da)
 {
 	bool response = true;
@@ -4004,6 +3945,63 @@ struct xmit_frame *alloc_mgtxmitframe(struct xmit_priv *pxmitpriv)
 	return pmgntframe;
 }
 
+void mgt_dispatcher(struct adapter *padapter, struct recv_frame *precv_frame)
+{
+	mlme_handler mlme_sta_tbl[] = {
+		OnAssocReq,
+		OnAssocRsp,
+		OnAssocReq,
+		OnAssocRsp,
+		OnProbeReq,
+		OnProbeRsp,
+		NULL,
+		NULL,
+		OnBeacon,
+		NULL,
+		OnDisassoc,
+		OnAuthClient,
+		OnDeAuth,
+		OnAction,
+	};
+	int index;
+	mlme_handler fct;
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
+	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)precv_frame->rx_data;
+	struct sta_info *psta = rtw_get_stainfo(&padapter->stapriv, hdr->addr2);
+
+	if (!ieee80211_is_mgmt(hdr->frame_control))
+		return;
+
+	/* receive the frames that ra(a1) is my address or ra(a1) is bc address. */
+	if (memcmp(hdr->addr1, myid(&padapter->eeprompriv), ETH_ALEN) &&
+	    !is_broadcast_ether_addr(hdr->addr1))
+		return;
+
+	index = (le16_to_cpu(hdr->frame_control) & IEEE80211_FCTL_STYPE) >> 4;
+	if (index >= ARRAY_SIZE(mlme_sta_tbl))
+		return;
+	fct = mlme_sta_tbl[index];
+
+	if (psta) {
+		if (ieee80211_has_retry(hdr->frame_control)) {
+			if (precv_frame->attrib.seq_num == psta->RxMgmtFrameSeqNum)
+				/* drop the duplicate management frame */
+				return;
+		}
+		psta->RxMgmtFrameSeqNum = precv_frame->attrib.seq_num;
+	}
+
+	if (ieee80211_is_auth(hdr->frame_control)) {
+		if (check_fwstate(pmlmepriv, WIFI_AP_STATE))
+			fct = OnAuth;
+		else
+			fct = OnAuthClient;
+	}
+
+	if (fct)
+		fct(padapter, precv_frame);
+}
+
 /****************************************************************************
 
 Following are some TX functions for WiFi MLME
-- 
2.30.2


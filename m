Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55427612BEC
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 18:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiJ3Rd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 13:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbiJ3Rdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 13:33:51 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E8D2A44F
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 10:33:49 -0700 (PDT)
Received: from ipservice-092-217-067-184.092.217.pools.vodafone-ip.de ([92.217.67.184] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1opCBs-000469-TO; Sun, 30 Oct 2022 18:33:44 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH v2 05/13] staging: r8188eu: make OnAction_p2p static void
Date:   Sun, 30 Oct 2022 18:33:18 +0100
Message-Id: <20221030173326.1588647-6-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221030173326.1588647-1-martin@kaiser.cx>
References: <20221030173326.1588647-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OnAction_p2p is called only by OnAction, its return value is not checked.
We can make it a static void function.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c    | 9 ++++-----
 drivers/staging/r8188eu/include/rtw_mlme_ext.h | 3 ---
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index 779c022b1c50..f1054192bfb1 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -3832,7 +3832,7 @@ static void on_action_public(struct adapter *padapter, struct recv_frame *precv_
 	}
 }
 
-unsigned int OnAction_p2p(struct adapter *padapter, struct recv_frame *precv_frame)
+static void OnAction_p2p(struct adapter *padapter, struct recv_frame *precv_frame)
 {
 	u8 *frame_body;
 	u8 category, OUI_Subtype;
@@ -3842,16 +3842,16 @@ unsigned int OnAction_p2p(struct adapter *padapter, struct recv_frame *precv_fra
 
 	/* check RA matches or not */
 	if (memcmp(myid(&padapter->eeprompriv), GetAddr1Ptr(pframe), ETH_ALEN))/* for if1, sta/ap mode */
-		return _SUCCESS;
+		return;
 
 	frame_body = (unsigned char *)(pframe + sizeof(struct ieee80211_hdr_3addr));
 
 	category = frame_body[0];
 	if (category != RTW_WLAN_CATEGORY_P2P)
-		return _SUCCESS;
+		return;
 
 	if (be32_to_cpu(*((__be32 *)(frame_body + 1))) != P2POUI)
-		return _SUCCESS;
+		return;
 
 	len -= sizeof(struct ieee80211_hdr_3addr);
 	OUI_Subtype = frame_body[5];
@@ -3869,7 +3869,6 @@ unsigned int OnAction_p2p(struct adapter *padapter, struct recv_frame *precv_fra
 	default:
 		break;
 	}
-	return _SUCCESS;
 }
 
 static void OnAction(struct adapter *padapter, struct recv_frame *precv_frame)
diff --git a/drivers/staging/r8188eu/include/rtw_mlme_ext.h b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
index 4ccdce1ad9be..ce5b57e23e53 100644
--- a/drivers/staging/r8188eu/include/rtw_mlme_ext.h
+++ b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
@@ -536,9 +536,6 @@ void start_clnt_auth(struct adapter *padapter);
 void start_clnt_join(struct adapter *padapter);
 void start_create_ibss(struct adapter *padapter);
 
-unsigned int OnAction_p2p(struct adapter *padapter,
-			  struct recv_frame *precv_frame);
-
 void mlmeext_joinbss_event_callback(struct adapter *padapter, int join_res);
 void mlmeext_sta_del_event_callback(struct adapter *padapter);
 void mlmeext_sta_add_event_callback(struct adapter *padapter,
-- 
2.30.2


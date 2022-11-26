Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2C46396F6
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 17:01:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbiKZQBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 11:01:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiKZQBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 11:01:41 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11593193E2
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 08:01:41 -0800 (PST)
Received: from dslb-188-096-151-149.188.096.pools.vodafone-ip.de ([188.96.151.149] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1oyxcV-0000Ub-Jx; Sat, 26 Nov 2022 17:01:35 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 02/10] staging: r8188eu: read timestamp from ieee80211_mgmt
Date:   Sat, 26 Nov 2022 17:01:21 +0100
Message-Id: <20221126160129.178697-3-martin@kaiser.cx>
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

Read the 64-bit timestamp from struct ieee80211_mgmt instead of parsing
the beacon message ourselves.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c | 21 ++-------------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index 80342b53a129..66e3a90da3a3 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -389,21 +389,6 @@ static u32 p2p_listen_state_process(struct adapter *padapter, unsigned char *da)
 	return _SUCCESS;
 }
 
-static void update_TSF(struct mlme_ext_priv *pmlmeext, u8 *pframe)
-{
-	u8 *pIE;
-	__le32 *pbuf;
-
-	pIE = pframe + sizeof(struct ieee80211_hdr_3addr);
-	pbuf = (__le32 *)pIE;
-
-	pmlmeext->TSFValue = le32_to_cpu(*(pbuf + 1));
-
-	pmlmeext->TSFValue = pmlmeext->TSFValue << 32;
-
-	pmlmeext->TSFValue |= le32_to_cpu(*pbuf);
-}
-
 static void correct_TSF(struct adapter *padapter)
 {
 	u8 reg;
@@ -592,8 +577,7 @@ static void OnBeacon(struct adapter *padapter, struct recv_frame *precv_frame)
 			/* check the vendor of the assoc AP */
 			pmlmeinfo->assoc_AP_vendor = check_assoc_AP(pframe + sizeof(struct ieee80211_hdr_3addr), len - sizeof(struct ieee80211_hdr_3addr));
 
-			/* update TSF Value */
-			update_TSF(pmlmeext, pframe);
+			pmlmeext->TSFValue = le64_to_cpu(mgmt->u.beacon.timestamp);
 
 			/* start auth */
 			start_clnt_auth(padapter);
@@ -635,8 +619,7 @@ static void OnBeacon(struct adapter *padapter, struct recv_frame *precv_frame)
 					return;
 				}
 
-				/* update TSF Value */
-				update_TSF(pmlmeext, pframe);
+				pmlmeext->TSFValue = le64_to_cpu(mgmt->u.beacon.timestamp);
 
 				/* report sta add event */
 				report_add_sta_event(padapter, GetAddr2Ptr(pframe), cam_idx);
-- 
2.30.2


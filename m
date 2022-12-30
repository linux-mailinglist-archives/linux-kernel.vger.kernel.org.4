Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4A85659B3D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 19:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235120AbiL3SHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 13:07:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235422AbiL3SHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 13:07:16 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452796248
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 10:07:15 -0800 (PST)
Received: from dslb-188-097-208-179.188.097.pools.vodafone-ip.de ([188.97.208.179] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1pBJmf-0004rR-6C; Fri, 30 Dec 2022 19:07:09 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 04/20] staging: r8188eu: return immediately if we're not meant to encrypt
Date:   Fri, 30 Dec 2022 19:06:30 +0100
Message-Id: <20221230180646.91008-5-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221230180646.91008-1-martin@kaiser.cx>
References: <20221230180646.91008-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function xmitframe_swencrypt, we can return immediately if our packet
needs no encryption. This is simpler than wrapping all the code into a
large if statement.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_xmit.c | 31 +++++++++++++------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index 4cd457cfb791..35d291d78c60 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -765,21 +765,22 @@ static void xmitframe_swencrypt(struct adapter *padapter, struct xmit_frame *pxm
 {
 	struct	pkt_attrib	 *pattrib = &pxmitframe->attrib;
 
-	if (pattrib->bswenc) {
-		switch (pattrib->encrypt) {
-		case _WEP40_:
-		case _WEP104_:
-			rtw_wep_encrypt(padapter, pxmitframe);
-			break;
-		case _TKIP_:
-			rtw_tkip_encrypt(padapter, pxmitframe);
-			break;
-		case _AES_:
-			rtw_aes_encrypt(padapter, pxmitframe);
-			break;
-		default:
-			break;
-		}
+	if (!pattrib->bswenc)
+		return;
+
+	switch (pattrib->encrypt) {
+	case _WEP40_:
+	case _WEP104_:
+		rtw_wep_encrypt(padapter, pxmitframe);
+		break;
+	case _TKIP_:
+		rtw_tkip_encrypt(padapter, pxmitframe);
+		break;
+	case _AES_:
+		rtw_aes_encrypt(padapter, pxmitframe);
+		break;
+	default:
+		break;
 	}
 }
 
-- 
2.30.2


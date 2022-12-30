Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4AA659B40
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 19:07:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235501AbiL3SHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 13:07:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235436AbiL3SHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 13:07:20 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3BDC1C424
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 10:07:16 -0800 (PST)
Received: from dslb-188-097-208-179.188.097.pools.vodafone-ip.de ([188.97.208.179] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1pBJmi-0004rR-BI; Fri, 30 Dec 2022 19:07:12 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 08/20] staging: r8188eu: remove duplicate psta check
Date:   Fri, 30 Dec 2022 19:06:34 +0100
Message-Id: <20221230180646.91008-9-martin@kaiser.cx>
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

We do not need the psta check in the while loop of rtw_xmitframe_coalesce.
psta is already checked near the start of the function and is not modified
afterwards.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_xmit.c | 36 ++++++++++++-------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index 62b66a205a06..2bccb9ca42e9 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -1009,25 +1009,23 @@ s32 rtw_xmitframe_coalesce(struct adapter *padapter, struct sk_buff *pkt, struct
 
 		/* adding icv, if necessary... */
 		if (pattrib->iv_len) {
-			if (psta) {
-				switch (pattrib->encrypt) {
-				case _WEP40_:
-				case _WEP104_:
-					WEP_IV(pattrib->iv, psta->dot11txpn, pattrib->key_idx);
-					break;
-				case _TKIP_:
-					if (bmcst)
-						TKIP_IV(pattrib->iv, psta->dot11txpn, pattrib->key_idx);
-					else
-						TKIP_IV(pattrib->iv, psta->dot11txpn, 0);
-					break;
-				case _AES_:
-					if (bmcst)
-						AES_IV(pattrib->iv, psta->dot11txpn, pattrib->key_idx);
-					else
-						AES_IV(pattrib->iv, psta->dot11txpn, 0);
-					break;
-				}
+			switch (pattrib->encrypt) {
+			case _WEP40_:
+			case _WEP104_:
+				WEP_IV(pattrib->iv, psta->dot11txpn, pattrib->key_idx);
+				break;
+			case _TKIP_:
+				if (bmcst)
+					TKIP_IV(pattrib->iv, psta->dot11txpn, pattrib->key_idx);
+				else
+					TKIP_IV(pattrib->iv, psta->dot11txpn, 0);
+				break;
+			case _AES_:
+				if (bmcst)
+					AES_IV(pattrib->iv, psta->dot11txpn, pattrib->key_idx);
+				else
+					AES_IV(pattrib->iv, psta->dot11txpn, 0);
+				break;
 			}
 
 			memcpy(pframe, pattrib->iv, pattrib->iv_len);
-- 
2.30.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A097F659B52
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 19:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235303AbiL3SQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 13:16:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbiL3SQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 13:16:04 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E4E2DC2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 10:16:03 -0800 (PST)
Received: from dslb-188-097-208-179.188.097.pools.vodafone-ip.de ([188.97.208.179] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1pBJms-0004rR-8L; Fri, 30 Dec 2022 19:07:22 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 20/20] staging: r8188eu: we use a constant number of hw_xmit entries
Date:   Fri, 30 Dec 2022 19:06:46 +0100
Message-Id: <20221230180646.91008-21-martin@kaiser.cx>
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

struct xmit_priv contains a pointer to an array of struct hw_xmit entries.
xmit_priv's (ill-named) hwxmit_entry component stores the size of this
array, i.e. the number of hw_xmit entries that are used.

The array size is constant, it's initialised to HWXMIT_ENTRY and never
updated. Simplify the code accordingly. Remove hwxmit_entry, do not pass
the array size as a function parameter and use HWXMIT_ENTRY in the code
that handles the array.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_xmit.c      | 8 +++-----
 drivers/staging/r8188eu/hal/rtl8188eu_xmit.c | 2 +-
 drivers/staging/r8188eu/include/rtw_xmit.h   | 3 +--
 3 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index 76b0839ca19d..d224785a747b 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -1417,7 +1417,7 @@ static struct xmit_frame *dequeue_one_xmitframe(struct xmit_priv *pxmitpriv, str
 	return pxmitframe;
 }
 
-struct xmit_frame *rtw_dequeue_xframe(struct xmit_priv *pxmitpriv, struct hw_xmit *phwxmit_i, int entry)
+struct xmit_frame *rtw_dequeue_xframe(struct xmit_priv *pxmitpriv, struct hw_xmit *phwxmit_i)
 {
 	struct list_head *sta_plist, *sta_phead;
 	struct hw_xmit *phwxmit;
@@ -1439,7 +1439,7 @@ struct xmit_frame *rtw_dequeue_xframe(struct xmit_priv *pxmitpriv, struct hw_xmi
 
 	spin_lock_bh(&pxmitpriv->lock);
 
-	for (i = 0; i < entry; i++) {
+	for (i = 0; i < HWXMIT_ENTRY; i++) {
 		phwxmit = phwxmit_i + inx[i];
 
 		sta_phead = get_list_head(phwxmit->sta_queue);
@@ -1543,9 +1543,7 @@ int rtw_alloc_hwxmits(struct adapter *padapter)
 	struct hw_xmit *hwxmits;
 	struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
 
-	pxmitpriv->hwxmit_entry = HWXMIT_ENTRY;
-
-	pxmitpriv->hwxmits = kzalloc(sizeof(struct hw_xmit) * pxmitpriv->hwxmit_entry, GFP_KERNEL);
+	pxmitpriv->hwxmits = kzalloc(sizeof(struct hw_xmit) * HWXMIT_ENTRY, GFP_KERNEL);
 	if (!pxmitpriv->hwxmits)
 		return -ENOMEM;
 
diff --git a/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c b/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
index d1af76cc2091..e097fa14dc6e 100644
--- a/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
+++ b/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
@@ -398,7 +398,7 @@ bool rtl8188eu_xmitframe_complete(struct adapter *adapt, struct xmit_priv *pxmit
 	if (!pxmitbuf)
 		return false;
 
-	pxmitframe = rtw_dequeue_xframe(pxmitpriv, pxmitpriv->hwxmits, pxmitpriv->hwxmit_entry);
+	pxmitframe = rtw_dequeue_xframe(pxmitpriv, pxmitpriv->hwxmits);
 	if (!pxmitframe) {
 		/*  no more xmit frame, release xmit buffer */
 		rtw_free_xmitbuf(pxmitpriv, pxmitbuf);
diff --git a/drivers/staging/r8188eu/include/rtw_xmit.h b/drivers/staging/r8188eu/include/rtw_xmit.h
index eafa693efc2f..f8f10c67b764 100644
--- a/drivers/staging/r8188eu/include/rtw_xmit.h
+++ b/drivers/staging/r8188eu/include/rtw_xmit.h
@@ -276,7 +276,6 @@ struct	xmit_priv {
 	u64	last_tx_bytes;
 	u64	last_tx_pkts;
 	struct hw_xmit *hwxmits;
-	u8	hwxmit_entry;
 	u8	wmm_para_seq[4];/* sequence for wmm ac parameter strength
 				 * from large to small. it's value is 0->vo,
 				 * 1->vi, 2->be, 3->bk. */
@@ -334,7 +333,7 @@ struct tx_servq *rtw_get_sta_pending(struct adapter *padapter,
 s32 rtw_xmitframe_enqueue(struct adapter *padapter,
 			  struct xmit_frame *pxmitframe);
 struct xmit_frame *rtw_dequeue_xframe(struct xmit_priv *pxmitpriv,
-				      struct hw_xmit *phwxmit_i, int entry);
+				      struct hw_xmit *phwxmit_i);
 
 s32 rtw_xmit_classifier(struct adapter *padapter,
 			struct xmit_frame *pxmitframe);
-- 
2.30.2


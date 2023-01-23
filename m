Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3506788C5
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 21:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbjAWUyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 15:54:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232158AbjAWUyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 15:54:20 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 727B332E47
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 12:54:13 -0800 (PST)
Received: from ipservice-092-217-089-134.092.217.pools.vodafone-ip.de ([92.217.89.134] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1pK3pO-0000Lk-80; Mon, 23 Jan 2023 21:54:06 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 14/23] staging: r8188eu: decrement qcnt in rtw_dequeue_xframe
Date:   Mon, 23 Jan 2023 21:53:33 +0100
Message-Id: <20230123205342.229589-15-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230123205342.229589-1-martin@kaiser.cx>
References: <20230123205342.229589-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rtw_dequeue_xframe calls dequeue_one_xmitframe and passes a struct
tx_servq. The only use for this parameter is to decrement its qcnt if an
xmit_frame could be extracted.

It makes more sense to remove the struct tx_servq parameter from
dequeue_one_xmitframe and decrement qcnt in the calling function when
dequeue_one_xmitframe returns success, i.e. when an xmit_frame was
extracted.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_xmit.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index 96079d9a6c42..7802a34ebcfd 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -1355,7 +1355,7 @@ s32 rtw_xmitframe_enqueue(struct adapter *padapter, struct xmit_frame *pxmitfram
 	return _SUCCESS;
 }
 
-static struct xmit_frame *dequeue_one_xmitframe(struct tx_servq *ptxservq, struct __queue *pframe_queue)
+static struct xmit_frame *dequeue_one_xmitframe(struct __queue *pframe_queue)
 {
 	struct list_head *xmitframe_plist, *xmitframe_phead;
 	struct xmit_frame *pxmitframe;
@@ -1367,7 +1367,6 @@ static struct xmit_frame *dequeue_one_xmitframe(struct tx_servq *ptxservq, struc
 	xmitframe_plist = xmitframe_phead->next;
 	pxmitframe = container_of(xmitframe_plist, struct xmit_frame, list);
 	list_del_init(&pxmitframe->list);
-	ptxservq->qcnt--;
 	return pxmitframe;
 }
 
@@ -1398,10 +1397,11 @@ struct xmit_frame *rtw_dequeue_xframe(struct xmit_priv *pxmitpriv, struct hw_xmi
 
 			pframe_queue = &ptxservq->sta_pending;
 
-			pxmitframe = dequeue_one_xmitframe(ptxservq, pframe_queue);
+			pxmitframe = dequeue_one_xmitframe(pframe_queue);
 
 			if (pxmitframe) {
 				phwxmit->accnt--;
+				ptxservq->qcnt--;
 
 				/* Remove sta node when there are no pending packets. */
 				if (list_empty(&pframe_queue->queue))
-- 
2.30.2


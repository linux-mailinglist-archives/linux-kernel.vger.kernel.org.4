Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7F26788C7
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 21:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbjAWUzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 15:55:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232021AbjAWUyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 15:54:20 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725AA2DE5C
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 12:54:13 -0800 (PST)
Received: from ipservice-092-217-089-134.092.217.pools.vodafone-ip.de ([92.217.89.134] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1pK3pQ-0000Lk-HU; Mon, 23 Jan 2023 21:54:08 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 17/23] staging: r8188eu: merge dequeue_one_xmitframe into its caller
Date:   Mon, 23 Jan 2023 21:53:36 +0100
Message-Id: <20230123205342.229589-18-martin@kaiser.cx>
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

dequeue_one_xmitframe is a small function that is called only from
rtw_dequeue_xframe. Merge the two functions.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_xmit.c | 34 +++++++++----------------
 1 file changed, 12 insertions(+), 22 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index 6060a1832431..cb0d8346ac10 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -1355,18 +1355,6 @@ s32 rtw_xmitframe_enqueue(struct adapter *padapter, struct xmit_frame *pxmitfram
 	return _SUCCESS;
 }
 
-static struct xmit_frame *dequeue_one_xmitframe(struct list_head *xframe_list)
-{
-	struct xmit_frame *pxmitframe;
-
-	if (list_empty(xframe_list))
-		return NULL;
-
-	pxmitframe = container_of(xframe_list->next, struct xmit_frame, list);
-	list_del_init(&pxmitframe->list);
-	return pxmitframe;
-}
-
 struct xmit_frame *rtw_dequeue_xframe(struct xmit_priv *pxmitpriv, struct hw_xmit *phwxmit_i)
 {
 	struct list_head *sta_phead;
@@ -1391,19 +1379,21 @@ struct xmit_frame *rtw_dequeue_xframe(struct xmit_priv *pxmitpriv, struct hw_xmi
 		sta_phead = get_list_head(phwxmit->sta_queue);
 
 		list_for_each_entry_safe(ptxservq, tmp_txservq, sta_phead, tx_pending) {
-
 			xframe_list = get_list_head(&ptxservq->sta_pending);
-			pxmitframe = dequeue_one_xmitframe(xframe_list);
+			if (list_empty(xframe_list))
+				continue;
 
-			if (pxmitframe) {
-				phwxmit->accnt--;
-				ptxservq->qcnt--;
+			pxmitframe = container_of(xframe_list->next, struct xmit_frame, list);
+			list_del_init(&pxmitframe->list);
 
-				/* Remove sta node when there are no pending packets. */
-				if (list_empty(xframe_list))
-					list_del_init(&ptxservq->tx_pending);
-				goto exit;
-			}
+			phwxmit->accnt--;
+			ptxservq->qcnt--;
+
+			/* Remove sta node when there are no pending packets. */
+			if (list_empty(xframe_list))
+				list_del_init(&ptxservq->tx_pending);
+
+			goto exit;
 		}
 	}
 exit:
-- 
2.30.2


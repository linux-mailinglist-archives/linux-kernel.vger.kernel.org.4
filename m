Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42D5768E111
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 20:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbjBGTXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 14:23:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231518AbjBGTXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 14:23:34 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2029D37547
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 11:23:34 -0800 (PST)
Received: from dslb-178-004-202-208.178.004.pools.vodafone-ip.de ([178.4.202.208] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1pPTYu-0002XK-MJ; Tue, 07 Feb 2023 20:23:29 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 2/7] staging: r8188eu: simplify rtw_alloc_xmitframe
Date:   Tue,  7 Feb 2023 20:23:14 +0100
Message-Id: <20230207192319.294203-3-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230207192319.294203-1-martin@kaiser.cx>
References: <20230207192319.294203-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the rtw_alloc_xmitframe function a bit simpler.

The container_of() call never returns NULL. The if (pxframe) check is
false only if pfree_xmit_queue is empty. Handle this special case
explicitly and save one level of indentation.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_xmit.c | 40 +++++++++++--------------
 1 file changed, 17 insertions(+), 23 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index 4d6210d89533..6ec342b726f9 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -1256,38 +1256,32 @@ struct xmit_frame *rtw_alloc_xmitframe(struct xmit_priv *pxmitpriv)/* _queue *pf
 
 	spin_lock_bh(&pfree_xmit_queue->lock);
 
-	if (list_empty(&pfree_xmit_queue->queue)) {
-		pxframe =  NULL;
-	} else {
-		phead = get_list_head(pfree_xmit_queue);
-
-		plist = phead->next;
+	if (list_empty(&pfree_xmit_queue->queue))
+		goto out;
 
-		pxframe = container_of(plist, struct xmit_frame, list);
-
-		list_del_init(&pxframe->list);
-	}
+	phead = get_list_head(pfree_xmit_queue);
+	plist = phead->next;
+	pxframe = container_of(plist, struct xmit_frame, list);
+	list_del_init(&pxframe->list);
 
-	if (pxframe) { /* default value setting */
-		pxmitpriv->free_xmitframe_cnt--;
+	pxmitpriv->free_xmitframe_cnt--;
 
-		pxframe->buf_addr = NULL;
-		pxframe->pxmitbuf = NULL;
+	pxframe->buf_addr = NULL;
+	pxframe->pxmitbuf = NULL;
 
-		memset(&pxframe->attrib, 0, sizeof(struct pkt_attrib));
-		/* pxframe->attrib.psta = NULL; */
+	memset(&pxframe->attrib, 0, sizeof(struct pkt_attrib));
+	/* pxframe->attrib.psta = NULL; */
 
-		pxframe->frame_tag = DATA_FRAMETAG;
+	pxframe->frame_tag = DATA_FRAMETAG;
 
-		pxframe->pkt = NULL;
-		pxframe->pkt_offset = 1;/* default use pkt_offset to fill tx desc */
+	pxframe->pkt = NULL;
+	pxframe->pkt_offset = 1;/* default use pkt_offset to fill tx desc */
 
-		pxframe->agg_num = 1;
-		pxframe->ack_report = 0;
-	}
+	pxframe->agg_num = 1;
+	pxframe->ack_report = 0;
 
+out:
 	spin_unlock_bh(&pfree_xmit_queue->lock);
-
 	return pxframe;
 }
 
-- 
2.30.2


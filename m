Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A74656788C1
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 21:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232285AbjAWUy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 15:54:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231795AbjAWUyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 15:54:13 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6E525E38
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 12:54:09 -0800 (PST)
Received: from ipservice-092-217-089-134.092.217.pools.vodafone-ip.de ([92.217.89.134] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1pK3pM-0000Lk-1E; Mon, 23 Jan 2023 21:54:04 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 11/23] staging: r8188eu: simplify dequeue_one_xmitframe
Date:   Mon, 23 Jan 2023 21:53:30 +0100
Message-Id: <20230123205342.229589-12-martin@kaiser.cx>
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

Revert the if condition and exit immediately if the list of xmitframes
is empty. Hopefully, this makes the code a little bit simpler.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_xmit.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index 334d75214011..96079d9a6c42 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -1358,16 +1358,16 @@ s32 rtw_xmitframe_enqueue(struct adapter *padapter, struct xmit_frame *pxmitfram
 static struct xmit_frame *dequeue_one_xmitframe(struct tx_servq *ptxservq, struct __queue *pframe_queue)
 {
 	struct list_head *xmitframe_plist, *xmitframe_phead;
-	struct	xmit_frame	*pxmitframe = NULL;
+	struct xmit_frame *pxmitframe;
 
 	xmitframe_phead = get_list_head(pframe_queue);
-	xmitframe_plist = xmitframe_phead->next;
+	if (list_empty(xmitframe_phead))
+		return NULL;
 
-	if (!list_empty(xmitframe_phead)) {
-		pxmitframe = container_of(xmitframe_plist, struct xmit_frame, list);
-		list_del_init(&pxmitframe->list);
-		ptxservq->qcnt--;
-	}
+	xmitframe_plist = xmitframe_phead->next;
+	pxmitframe = container_of(xmitframe_plist, struct xmit_frame, list);
+	list_del_init(&pxmitframe->list);
+	ptxservq->qcnt--;
 	return pxmitframe;
 }
 
-- 
2.30.2


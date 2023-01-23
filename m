Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 120DF6788CA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 21:55:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232405AbjAWUzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 15:55:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232088AbjAWUyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 15:54:38 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB5A38650
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 12:54:15 -0800 (PST)
Received: from ipservice-092-217-089-134.092.217.pools.vodafone-ip.de ([92.217.89.134] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1pK3pR-0000Lk-AX; Mon, 23 Jan 2023 21:54:09 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 18/23] staging: r8188eu: use lists for hwxmits
Date:   Mon, 23 Jan 2023 21:53:37 +0100
Message-Id: <20230123205342.229589-19-martin@kaiser.cx>
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

struct hw_xmit's sta_list points to one of vo, vi, be or bk_pending in
struct xmit_priv. All of these are defined as struct __queue, which is a
list plus a spinlock.

For these components, the spinlock is unused, we need only the list.

This patch converts sta_list and vo, vi, be and bk_pending to struct
list_head.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_xmit.c    | 32 ++++++++++------------
 drivers/staging/r8188eu/include/rtw_xmit.h | 10 +++----
 2 files changed, 19 insertions(+), 23 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index cb0d8346ac10..ef6d3a9bffea 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -76,10 +76,10 @@ int _rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 
 	pxmitpriv->adapter = padapter;
 
-	rtw_init_queue(&pxmitpriv->be_pending);
-	rtw_init_queue(&pxmitpriv->bk_pending);
-	rtw_init_queue(&pxmitpriv->vi_pending);
-	rtw_init_queue(&pxmitpriv->vo_pending);
+	INIT_LIST_HEAD(&pxmitpriv->be_pending);
+	INIT_LIST_HEAD(&pxmitpriv->bk_pending);
+	INIT_LIST_HEAD(&pxmitpriv->vi_pending);
+	INIT_LIST_HEAD(&pxmitpriv->vo_pending);
 
 	rtw_init_queue(&pxmitpriv->free_xmit_queue);
 
@@ -881,10 +881,10 @@ s32 rtw_txframes_pending(struct adapter *padapter)
 {
 	struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
 
-	return (!list_empty(&pxmitpriv->be_pending.queue) ||
-			!list_empty(&pxmitpriv->bk_pending.queue) ||
-			!list_empty(&pxmitpriv->vi_pending.queue) ||
-			!list_empty(&pxmitpriv->vo_pending.queue));
+	return (!list_empty(&pxmitpriv->be_pending) ||
+		!list_empty(&pxmitpriv->bk_pending) ||
+		!list_empty(&pxmitpriv->vi_pending) ||
+		!list_empty(&pxmitpriv->vo_pending));
 }
 
 s32 rtw_txframes_sta_ac_pending(struct adapter *padapter, struct pkt_attrib *pattrib)
@@ -1357,7 +1357,6 @@ s32 rtw_xmitframe_enqueue(struct adapter *padapter, struct xmit_frame *pxmitfram
 
 struct xmit_frame *rtw_dequeue_xframe(struct xmit_priv *pxmitpriv, struct hw_xmit *phwxmit_i)
 {
-	struct list_head *sta_phead;
 	struct hw_xmit *phwxmit;
 	struct tx_servq *ptxservq, *tmp_txservq;
 	struct list_head *xframe_list;
@@ -1375,10 +1374,7 @@ struct xmit_frame *rtw_dequeue_xframe(struct xmit_priv *pxmitpriv, struct hw_xmi
 
 	for (i = 0; i < HWXMIT_ENTRY; i++) {
 		phwxmit = phwxmit_i + inx[i];
-
-		sta_phead = get_list_head(phwxmit->sta_queue);
-
-		list_for_each_entry_safe(ptxservq, tmp_txservq, sta_phead, tx_pending) {
+		list_for_each_entry_safe(ptxservq, tmp_txservq, phwxmit->sta_list, tx_pending) {
 			xframe_list = get_list_head(&ptxservq->sta_pending);
 			if (list_empty(xframe_list))
 				continue;
@@ -1460,7 +1456,7 @@ s32 rtw_xmit_classifier(struct adapter *padapter, struct xmit_frame *pxmitframe)
 	ptxservq = rtw_get_sta_pending(padapter, psta, pattrib->priority, (u8 *)(&ac_index));
 
 	if (list_empty(&ptxservq->tx_pending))
-		list_add_tail(&ptxservq->tx_pending, get_list_head(phwxmits[ac_index].sta_queue));
+		list_add_tail(&ptxservq->tx_pending, phwxmits[ac_index].sta_list);
 
 	list_add_tail(&pxmitframe->list, get_list_head(&ptxservq->sta_pending));
 	ptxservq->qcnt++;
@@ -1481,10 +1477,10 @@ int rtw_alloc_hwxmits(struct adapter *padapter)
 
 	hwxmits = pxmitpriv->hwxmits;
 
-	hwxmits[0].sta_queue = &pxmitpriv->vo_pending;
-	hwxmits[1].sta_queue = &pxmitpriv->vi_pending;
-	hwxmits[2].sta_queue = &pxmitpriv->be_pending;
-	hwxmits[3].sta_queue = &pxmitpriv->bk_pending;
+	hwxmits[0].sta_list = &pxmitpriv->vo_pending;
+	hwxmits[1].sta_list = &pxmitpriv->vi_pending;
+	hwxmits[2].sta_list = &pxmitpriv->be_pending;
+	hwxmits[3].sta_list = &pxmitpriv->bk_pending;
 
 	return 0;
 }
diff --git a/drivers/staging/r8188eu/include/rtw_xmit.h b/drivers/staging/r8188eu/include/rtw_xmit.h
index cc32167fb4dc..30f8000120b2 100644
--- a/drivers/staging/r8188eu/include/rtw_xmit.h
+++ b/drivers/staging/r8188eu/include/rtw_xmit.h
@@ -97,7 +97,7 @@ union txdesc {
 };
 
 struct	hw_xmit	{
-	struct __queue *sta_queue;
+	struct list_head *sta_list;
 	int	accnt;
 };
 
@@ -257,10 +257,10 @@ struct agg_pkt_info {
 
 struct	xmit_priv {
 	spinlock_t lock;
-	struct __queue be_pending;
-	struct __queue bk_pending;
-	struct __queue vi_pending;
-	struct __queue vo_pending;
+	struct list_head be_pending;
+	struct list_head bk_pending;
+	struct list_head vi_pending;
+	struct list_head vo_pending;
 	u8 *pallocated_frame_buf;
 	u8 *pxmit_frame_buf;
 	uint free_xmitframe_cnt;
-- 
2.30.2


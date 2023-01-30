Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFF1E681ADA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 20:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238142AbjA3Txg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 14:53:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237710AbjA3Tx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 14:53:27 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F116246D45
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 11:53:24 -0800 (PST)
Received: from dslb-188-097-040-029.188.097.pools.vodafone-ip.de ([188.97.40.29] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1pMaDO-0007S2-Jq; Mon, 30 Jan 2023 20:53:18 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 3/9] staging: r8188eu: change another function param from __queue to list_head
Date:   Mon, 30 Jan 2023 20:52:57 +0100
Message-Id: <20230130195303.138941-4-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230130195303.138941-1-martin@kaiser.cx>
References: <20230130195303.138941-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify the rtw_free_xmitframe_queue function to take a list_head pointer
instead of a __queue pointer.

This is an intermediate step towards changing struct tx_servq's
sta_pending from __queue to list_head.

Now that the function takes a list instead of a queue, we should also
rename it to rtw_free_xmitframe_list.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_sta_mgt.c | 10 +++++-----
 drivers/staging/r8188eu/core/rtw_xmit.c    |  9 ++++-----
 drivers/staging/r8188eu/include/rtw_xmit.h |  3 +--
 3 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_sta_mgt.c b/drivers/staging/r8188eu/core/rtw_sta_mgt.c
index b4aee8623099..49a92725c5ed 100644
--- a/drivers/staging/r8188eu/core/rtw_sta_mgt.c
+++ b/drivers/staging/r8188eu/core/rtw_sta_mgt.c
@@ -260,22 +260,22 @@ void rtw_free_stainfo(struct adapter *padapter, struct sta_info *psta)
 
 	spin_lock_bh(&pxmitpriv->lock);
 
-	rtw_free_xmitframe_queue(pxmitpriv, &psta->sleep_q);
+	rtw_free_xmitframe_list(pxmitpriv, get_list_head(&psta->sleep_q));
 	psta->sleepq_len = 0;
 
-	rtw_free_xmitframe_queue(pxmitpriv, &pstaxmitpriv->vo_q.sta_pending);
+	rtw_free_xmitframe_list(pxmitpriv, get_list_head(&pstaxmitpriv->vo_q.sta_pending));
 
 	list_del_init(&pstaxmitpriv->vo_q.tx_pending);
 
-	rtw_free_xmitframe_queue(pxmitpriv, &pstaxmitpriv->vi_q.sta_pending);
+	rtw_free_xmitframe_list(pxmitpriv, get_list_head(&pstaxmitpriv->vi_q.sta_pending));
 
 	list_del_init(&pstaxmitpriv->vi_q.tx_pending);
 
-	rtw_free_xmitframe_queue(pxmitpriv, &pstaxmitpriv->bk_q.sta_pending);
+	rtw_free_xmitframe_list(pxmitpriv, get_list_head(&pstaxmitpriv->bk_q.sta_pending));
 
 	list_del_init(&pstaxmitpriv->bk_q.tx_pending);
 
-	rtw_free_xmitframe_queue(pxmitpriv, &pstaxmitpriv->be_q.sta_pending);
+	rtw_free_xmitframe_list(pxmitpriv, get_list_head(&pstaxmitpriv->be_q.sta_pending));
 
 	list_del_init(&pstaxmitpriv->be_q.tx_pending);
 
diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index 3117db41d749..d272166a99ec 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -1325,15 +1325,14 @@ s32 rtw_free_xmitframe(struct xmit_priv *pxmitpriv, struct xmit_frame *pxmitfram
 	return _SUCCESS;
 }
 
-void rtw_free_xmitframe_queue(struct xmit_priv *pxmitpriv, struct __queue *pframequeue)
+void rtw_free_xmitframe_list(struct xmit_priv *pxmitpriv, struct list_head *xframe_list)
 {
-	struct list_head *plist, *phead;
+	struct list_head *plist;
 	struct	xmit_frame	*pxmitframe;
 
-	phead = get_list_head(pframequeue);
-	plist = phead->next;
+	plist = xframe_list->next;
 
-	while (phead != plist) {
+	while (xframe_list != plist) {
 		pxmitframe = container_of(plist, struct xmit_frame, list);
 
 		plist = plist->next;
diff --git a/drivers/staging/r8188eu/include/rtw_xmit.h b/drivers/staging/r8188eu/include/rtw_xmit.h
index d8808e68f778..8557b311e809 100644
--- a/drivers/staging/r8188eu/include/rtw_xmit.h
+++ b/drivers/staging/r8188eu/include/rtw_xmit.h
@@ -309,8 +309,7 @@ s32 rtw_put_snap(u8 *data, u16 h_proto);
 struct xmit_frame *rtw_alloc_xmitframe(struct xmit_priv *pxmitpriv);
 s32 rtw_free_xmitframe(struct xmit_priv *pxmitpriv,
 		       struct xmit_frame *pxmitframe);
-void rtw_free_xmitframe_queue(struct xmit_priv *pxmitpriv,
-			      struct __queue *pframequeue);
+void rtw_free_xmitframe_list(struct xmit_priv *pxmitpriv, struct list_head *xframe_list);
 struct tx_servq *rtw_get_sta_pending(struct adapter *padapter,
 				     struct sta_info *psta, int up, u8 *ac);
 struct xmit_frame *rtw_dequeue_xframe(struct xmit_priv *pxmitpriv,
-- 
2.30.2


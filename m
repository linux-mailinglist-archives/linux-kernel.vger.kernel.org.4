Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC7E681ADB
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 20:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236074AbjA3Txj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 14:53:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237681AbjA3Tx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 14:53:27 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05FA46739
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 11:53:24 -0800 (PST)
Received: from dslb-188-097-040-029.188.097.pools.vodafone-ip.de ([188.97.40.29] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1pMaDP-0007S2-82; Mon, 30 Jan 2023 20:53:19 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 4/9] staging: r8188eu: make sta_pending a list_head
Date:   Mon, 30 Jan 2023 20:52:58 +0100
Message-Id: <20230130195303.138941-5-martin@kaiser.cx>
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

We can now change sta_pending in struct tx_servq from __queue to
list_head. The driver defines __queue as list_head + spinlock, the
spinlock is not used for sta_pending.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_sta_mgt.c   |  8 ++++----
 drivers/staging/r8188eu/core/rtw_xmit.c      | 16 ++++++++--------
 drivers/staging/r8188eu/hal/rtl8188eu_xmit.c |  4 ++--
 drivers/staging/r8188eu/include/rtw_xmit.h   |  2 +-
 4 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_sta_mgt.c b/drivers/staging/r8188eu/core/rtw_sta_mgt.c
index 49a92725c5ed..a9c29b2bf230 100644
--- a/drivers/staging/r8188eu/core/rtw_sta_mgt.c
+++ b/drivers/staging/r8188eu/core/rtw_sta_mgt.c
@@ -263,19 +263,19 @@ void rtw_free_stainfo(struct adapter *padapter, struct sta_info *psta)
 	rtw_free_xmitframe_list(pxmitpriv, get_list_head(&psta->sleep_q));
 	psta->sleepq_len = 0;
 
-	rtw_free_xmitframe_list(pxmitpriv, get_list_head(&pstaxmitpriv->vo_q.sta_pending));
+	rtw_free_xmitframe_list(pxmitpriv, &pstaxmitpriv->vo_q.sta_pending);
 
 	list_del_init(&pstaxmitpriv->vo_q.tx_pending);
 
-	rtw_free_xmitframe_list(pxmitpriv, get_list_head(&pstaxmitpriv->vi_q.sta_pending));
+	rtw_free_xmitframe_list(pxmitpriv, &pstaxmitpriv->vi_q.sta_pending);
 
 	list_del_init(&pstaxmitpriv->vi_q.tx_pending);
 
-	rtw_free_xmitframe_list(pxmitpriv, get_list_head(&pstaxmitpriv->bk_q.sta_pending));
+	rtw_free_xmitframe_list(pxmitpriv, &pstaxmitpriv->bk_q.sta_pending);
 
 	list_del_init(&pstaxmitpriv->bk_q.tx_pending);
 
-	rtw_free_xmitframe_list(pxmitpriv, get_list_head(&pstaxmitpriv->be_q.sta_pending));
+	rtw_free_xmitframe_list(pxmitpriv, &pstaxmitpriv->be_q.sta_pending);
 
 	list_del_init(&pstaxmitpriv->be_q.tx_pending);
 
diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index d272166a99ec..24cf11e7b4bc 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -17,7 +17,7 @@ static u8 RFC1042_OUI[P80211_OUI_LEN] = { 0x00, 0x00, 0x00 };
 static void _init_txservq(struct tx_servq *ptxservq)
 {
 	INIT_LIST_HEAD(&ptxservq->tx_pending);
-	rtw_init_queue(&ptxservq->sta_pending);
+	INIT_LIST_HEAD(&ptxservq->sta_pending);
 	ptxservq->qcnt = 0;
 }
 
@@ -1361,7 +1361,7 @@ struct xmit_frame *rtw_dequeue_xframe(struct xmit_priv *pxmitpriv, struct hw_xmi
 	for (i = 0; i < HWXMIT_ENTRY; i++) {
 		phwxmit = phwxmit_i + inx[i];
 		list_for_each_entry_safe(ptxservq, tmp_txservq, phwxmit->sta_list, tx_pending) {
-			xframe_list = get_list_head(&ptxservq->sta_pending);
+			xframe_list = &ptxservq->sta_pending;
 			if (list_empty(xframe_list))
 				continue;
 
@@ -1444,7 +1444,7 @@ s32 rtw_xmit_classifier(struct adapter *padapter, struct xmit_frame *pxmitframe)
 	if (list_empty(&ptxservq->tx_pending))
 		list_add_tail(&ptxservq->tx_pending, phwxmits[ac_index].sta_list);
 
-	list_add_tail(&pxmitframe->list, get_list_head(&ptxservq->sta_pending));
+	list_add_tail(&pxmitframe->list, &ptxservq->sta_pending);
 	ptxservq->qcnt++;
 	phwxmits[ac_index].accnt++;
 exit:
@@ -1832,21 +1832,21 @@ void stop_sta_xmit(struct adapter *padapter, struct sta_info *psta)
 
 	pstapriv->sta_dz_bitmap |= BIT(psta->aid);
 
-	dequeue_xmitframes_to_sleeping_queue(padapter, psta, get_list_head(&pstaxmitpriv->vo_q.sta_pending));
+	dequeue_xmitframes_to_sleeping_queue(padapter, psta, &pstaxmitpriv->vo_q.sta_pending);
 	list_del_init(&pstaxmitpriv->vo_q.tx_pending);
 
-	dequeue_xmitframes_to_sleeping_queue(padapter, psta, get_list_head(&pstaxmitpriv->vi_q.sta_pending));
+	dequeue_xmitframes_to_sleeping_queue(padapter, psta, &pstaxmitpriv->vi_q.sta_pending);
 	list_del_init(&pstaxmitpriv->vi_q.tx_pending);
 
-	dequeue_xmitframes_to_sleeping_queue(padapter, psta, get_list_head(&pstaxmitpriv->be_q.sta_pending));
+	dequeue_xmitframes_to_sleeping_queue(padapter, psta, &pstaxmitpriv->be_q.sta_pending);
 	list_del_init(&pstaxmitpriv->be_q.tx_pending);
 
-	dequeue_xmitframes_to_sleeping_queue(padapter, psta, get_list_head(&pstaxmitpriv->bk_q.sta_pending));
+	dequeue_xmitframes_to_sleeping_queue(padapter, psta, &pstaxmitpriv->bk_q.sta_pending);
 	list_del_init(&pstaxmitpriv->bk_q.tx_pending);
 
 	/* for BC/MC Frames */
 	pstaxmitpriv = &psta_bmc->sta_xmitpriv;
-	dequeue_xmitframes_to_sleeping_queue(padapter, psta_bmc, get_list_head(&pstaxmitpriv->be_q.sta_pending));
+	dequeue_xmitframes_to_sleeping_queue(padapter, psta_bmc, &pstaxmitpriv->be_q.sta_pending);
 	list_del_init(&pstaxmitpriv->be_q.tx_pending);
 
 	spin_unlock_bh(&pxmitpriv->lock);
diff --git a/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c b/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
index 18557738dbad..5aa33fc4041d 100644
--- a/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
+++ b/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
@@ -461,7 +461,7 @@ bool rtl8188eu_xmitframe_complete(struct adapter *adapt)
 	}
 	spin_lock_bh(&pxmitpriv->lock);
 
-	xmitframe_phead = get_list_head(&ptxservq->sta_pending);
+	xmitframe_phead = &ptxservq->sta_pending;
 	xmitframe_plist = xmitframe_phead->next;
 
 	while (xmitframe_phead != xmitframe_plist) {
@@ -512,7 +512,7 @@ bool rtl8188eu_xmitframe_complete(struct adapter *adapt)
 		}
 	} /* end while (aggregate same priority and same DA(AP or STA) frames) */
 
-	if (list_empty(&ptxservq->sta_pending.queue))
+	if (list_empty(&ptxservq->sta_pending))
 		list_del_init(&ptxservq->tx_pending);
 
 	spin_unlock_bh(&pxmitpriv->lock);
diff --git a/drivers/staging/r8188eu/include/rtw_xmit.h b/drivers/staging/r8188eu/include/rtw_xmit.h
index 8557b311e809..dfdc1c57d5d4 100644
--- a/drivers/staging/r8188eu/include/rtw_xmit.h
+++ b/drivers/staging/r8188eu/include/rtw_xmit.h
@@ -221,7 +221,7 @@ struct xmit_frame {
 
 struct tx_servq {
 	struct list_head tx_pending;
-	struct __queue sta_pending;
+	struct list_head sta_pending;
 	int qcnt;
 };
 
-- 
2.30.2


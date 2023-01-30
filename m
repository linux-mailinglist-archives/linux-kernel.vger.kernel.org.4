Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 308AF681AD9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 20:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238039AbjA3Txd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 14:53:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237635AbjA3TxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 14:53:25 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F4093F283
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 11:53:23 -0800 (PST)
Received: from dslb-188-097-040-029.188.097.pools.vodafone-ip.de ([188.97.40.29] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1pMaDN-0007S2-Sm; Mon, 30 Jan 2023 20:53:17 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 2/9] staging: r8188eu: change function param from __queue to list_head
Date:   Mon, 30 Jan 2023 20:52:56 +0100
Message-Id: <20230130195303.138941-3-martin@kaiser.cx>
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

Modify the dequeue_xmitframes_to_sleeping_queue function to take a
list_head pointer instead of a __queue pointer.

This is an intermediate step towards changing struct tx_servq's
sta_pending from __queue to list_head.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_xmit.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index 4e49f1d49eb5..3117db41d749 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -1788,16 +1788,15 @@ int xmitframe_enqueue_for_sleeping_sta(struct adapter *padapter, struct xmit_fra
 	return ret;
 }
 
-static void dequeue_xmitframes_to_sleeping_queue(struct adapter *padapter, struct sta_info *psta, struct __queue *pframequeue)
+static void dequeue_xmitframes_to_sleeping_queue(struct adapter *padapter, struct sta_info *psta, struct list_head *phead)
 {
-	struct list_head *plist, *phead;
+	struct list_head *plist;
 	u8	ac_index;
 	struct tx_servq	*ptxservq;
 	struct pkt_attrib	*pattrib;
 	struct xmit_frame	*pxmitframe;
 	struct hw_xmit *phwxmits =  padapter->xmitpriv.hwxmits;
 
-	phead = get_list_head(pframequeue);
 	plist = phead->next;
 
 	while (phead != plist) {
@@ -1834,21 +1833,21 @@ void stop_sta_xmit(struct adapter *padapter, struct sta_info *psta)
 
 	pstapriv->sta_dz_bitmap |= BIT(psta->aid);
 
-	dequeue_xmitframes_to_sleeping_queue(padapter, psta, &pstaxmitpriv->vo_q.sta_pending);
+	dequeue_xmitframes_to_sleeping_queue(padapter, psta, get_list_head(&pstaxmitpriv->vo_q.sta_pending));
 	list_del_init(&pstaxmitpriv->vo_q.tx_pending);
 
-	dequeue_xmitframes_to_sleeping_queue(padapter, psta, &pstaxmitpriv->vi_q.sta_pending);
+	dequeue_xmitframes_to_sleeping_queue(padapter, psta, get_list_head(&pstaxmitpriv->vi_q.sta_pending));
 	list_del_init(&pstaxmitpriv->vi_q.tx_pending);
 
-	dequeue_xmitframes_to_sleeping_queue(padapter, psta, &pstaxmitpriv->be_q.sta_pending);
+	dequeue_xmitframes_to_sleeping_queue(padapter, psta, get_list_head(&pstaxmitpriv->be_q.sta_pending));
 	list_del_init(&pstaxmitpriv->be_q.tx_pending);
 
-	dequeue_xmitframes_to_sleeping_queue(padapter, psta, &pstaxmitpriv->bk_q.sta_pending);
+	dequeue_xmitframes_to_sleeping_queue(padapter, psta, get_list_head(&pstaxmitpriv->bk_q.sta_pending));
 	list_del_init(&pstaxmitpriv->bk_q.tx_pending);
 
 	/* for BC/MC Frames */
 	pstaxmitpriv = &psta_bmc->sta_xmitpriv;
-	dequeue_xmitframes_to_sleeping_queue(padapter, psta_bmc, &pstaxmitpriv->be_q.sta_pending);
+	dequeue_xmitframes_to_sleeping_queue(padapter, psta_bmc, get_list_head(&pstaxmitpriv->be_q.sta_pending));
 	list_del_init(&pstaxmitpriv->be_q.tx_pending);
 
 	spin_unlock_bh(&pxmitpriv->lock);
-- 
2.30.2


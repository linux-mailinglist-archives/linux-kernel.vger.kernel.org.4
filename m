Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46BF96788BC
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 21:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbjAWUyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 15:54:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbjAWUyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 15:54:05 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3897C7DB5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 12:54:05 -0800 (PST)
Received: from ipservice-092-217-089-134.092.217.pools.vodafone-ip.de ([92.217.89.134] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1pK3pH-0000Lk-7J; Mon, 23 Jan 2023 21:53:59 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 05/23] staging: r8188eu: simplify the sta loop in rtw_dequeue_xframe
Date:   Mon, 23 Jan 2023 21:53:24 +0100
Message-Id: <20230123205342.229589-6-martin@kaiser.cx>
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

Use list_for_each_entry_safe to iterate over the station entries in
function rtw_dequeue_xframe instead of coding the loop manually.

We have to use the safe version, the loop body may remove a station from
the list over which we iterate.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_xmit.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index 5f2426be6c11..b07a1ce21a38 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -1377,9 +1377,9 @@ static struct xmit_frame *dequeue_one_xmitframe(struct xmit_priv *pxmitpriv, str
 
 struct xmit_frame *rtw_dequeue_xframe(struct xmit_priv *pxmitpriv, struct hw_xmit *phwxmit_i)
 {
-	struct list_head *sta_plist, *sta_phead;
+	struct list_head *sta_phead;
 	struct hw_xmit *phwxmit;
-	struct tx_servq *ptxservq = NULL;
+	struct tx_servq *ptxservq, *tmp_txservq;
 	struct __queue *pframe_queue = NULL;
 	struct xmit_frame *pxmitframe = NULL;
 	struct adapter *padapter = pxmitpriv->adapter;
@@ -1401,10 +1401,8 @@ struct xmit_frame *rtw_dequeue_xframe(struct xmit_priv *pxmitpriv, struct hw_xmi
 		phwxmit = phwxmit_i + inx[i];
 
 		sta_phead = get_list_head(phwxmit->sta_queue);
-		sta_plist = sta_phead->next;
 
-		while (sta_phead != sta_plist) {
-			ptxservq = container_of(sta_plist, struct tx_servq, tx_pending);
+		list_for_each_entry_safe(ptxservq, tmp_txservq, sta_phead, tx_pending) {
 
 			pframe_queue = &ptxservq->sta_pending;
 
@@ -1418,8 +1416,6 @@ struct xmit_frame *rtw_dequeue_xframe(struct xmit_priv *pxmitpriv, struct hw_xmi
 					list_del_init(&ptxservq->tx_pending);
 				goto exit;
 			}
-
-			sta_plist = sta_plist->next;
 		}
 	}
 exit:
-- 
2.30.2


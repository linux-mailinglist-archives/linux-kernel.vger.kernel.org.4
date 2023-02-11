Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13658693297
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 17:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjBKQvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 11:51:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjBKQvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 11:51:09 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD8E1BF1
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 08:51:08 -0800 (PST)
Received: from dslb-094-219-036-079.094.219.pools.vodafone-ip.de ([94.219.36.79] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1pQt5Y-0006wA-Mp; Sat, 11 Feb 2023 17:51:00 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH] staging: r8188eu: merge _rtw_enqueue_cmd into its caller
Date:   Sat, 11 Feb 2023 17:50:45 +0100
Message-Id: <20230211165045.414424-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The _rtw_enqueue_cmd function is called only by rtw_enqueue_cmd.

When _rtw_enqueue_cmd is called, the caller has already checked that the
obj parameter is not NULL. _rtw_enqueue_cmd returns _SUCCESS in any case.

We can merge the two functions and simplify the error handling.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_cmd.c | 47 +++++---------------------
 1 file changed, 9 insertions(+), 38 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index d57360a68fb3..ca9e3d4ee7f4 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -28,32 +28,6 @@ void rtw_free_evt_priv(struct	evt_priv *pevtpriv)
 	}
 }
 
-/* Calling Context:
- *
- * rtw_enqueue_cmd can only be called between kernel thread,
- * since only spin_lock is used.
- *
- * ISR/Call-Back functions can't call this sub-function.
- */
-
-static int _rtw_enqueue_cmd(struct __queue *queue, struct cmd_obj *obj)
-{
-	unsigned long flags;
-
-	if (!obj)
-		goto exit;
-
-	spin_lock_irqsave(&queue->lock, flags);
-
-	list_add_tail(&obj->list, &queue->queue);
-
-	spin_unlock_irqrestore(&queue->lock, flags);
-
-exit:
-
-	return _SUCCESS;
-}
-
 int rtw_init_cmd_priv(struct cmd_priv *pcmdpriv)
 {
 	init_completion(&pcmdpriv->enqueue_cmd);
@@ -125,28 +99,25 @@ static int rtw_cmd_filter(struct cmd_priv *pcmdpriv, struct cmd_obj *cmd_obj)
 
 u32 rtw_enqueue_cmd(struct cmd_priv *pcmdpriv, struct cmd_obj *cmd_obj)
 {
-	int res = _FAIL;
+	unsigned long flags;
 	struct adapter *padapter = pcmdpriv->padapter;
 
 	if (!cmd_obj)
-		goto exit;
+		return _FAIL;
 
 	cmd_obj->padapter = padapter;
 
-	res = rtw_cmd_filter(pcmdpriv, cmd_obj);
-	if (res == _FAIL) {
+	if (rtw_cmd_filter(pcmdpriv, cmd_obj) == _FAIL) {
 		rtw_free_cmd_obj(cmd_obj);
-		goto exit;
+		return _FAIL;
 	}
 
-	res = _rtw_enqueue_cmd(&pcmdpriv->cmd_queue, cmd_obj);
-
-	if (res == _SUCCESS)
-		complete(&pcmdpriv->enqueue_cmd);
+	spin_lock_irqsave(&pcmdpriv->cmd_queue.lock, flags);
+	list_add_tail(&cmd_obj->list, &pcmdpriv->cmd_queue.queue);
+	spin_unlock_irqrestore(&pcmdpriv->cmd_queue.lock, flags);
 
-exit:
-
-	return res;
+	complete(&pcmdpriv->enqueue_cmd);
+	return _SUCCESS;
 }
 
 struct	cmd_obj	*rtw_dequeue_cmd(struct cmd_priv *pcmdpriv)
-- 
2.30.2


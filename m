Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 377CE6788D8
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 21:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231963AbjAWU6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 15:58:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232322AbjAWU5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 15:57:54 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D0538B4A
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 12:57:36 -0800 (PST)
Received: from ipservice-092-217-089-134.092.217.pools.vodafone-ip.de ([92.217.89.134] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1pK3pS-0000Lk-Rp; Mon, 23 Jan 2023 21:54:10 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 20/23] staging: r8188eu: remove rtw_xmitframe_enqueue
Date:   Mon, 23 Jan 2023 21:53:39 +0100
Message-Id: <20230123205342.229589-21-martin@kaiser.cx>
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

The rtw_xmitframe_enqueue function is only one line. We can remove it and
call rtw_xmit_classifier directly.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_xmit.c      | 5 -----
 drivers/staging/r8188eu/hal/rtl8188eu_xmit.c | 2 +-
 drivers/staging/r8188eu/include/rtw_xmit.h   | 2 --
 3 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index 4f9defdbe257..3752d4fddd11 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -1345,11 +1345,6 @@ void rtw_free_xmitframe_queue(struct xmit_priv *pxmitpriv, struct __queue *pfram
 	spin_unlock_bh(&pframequeue->lock);
 }
 
-s32 rtw_xmitframe_enqueue(struct adapter *padapter, struct xmit_frame *pxmitframe)
-{
-	return rtw_xmit_classifier(padapter, pxmitframe);
-}
-
 struct xmit_frame *rtw_dequeue_xframe(struct xmit_priv *pxmitpriv, struct hw_xmit *phwxmit_i)
 {
 	struct hw_xmit *phwxmit;
diff --git a/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c b/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
index e067cc271686..18557738dbad 100644
--- a/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
+++ b/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
@@ -596,7 +596,7 @@ static s32 pre_xmitframe(struct adapter *adapt, struct xmit_frame *pxmitframe)
 	return true;
 
 enqueue:
-	res = rtw_xmitframe_enqueue(adapt, pxmitframe);
+	res = rtw_xmit_classifier(adapt, pxmitframe);
 	spin_unlock_bh(&pxmitpriv->lock);
 
 	if (res != _SUCCESS) {
diff --git a/drivers/staging/r8188eu/include/rtw_xmit.h b/drivers/staging/r8188eu/include/rtw_xmit.h
index 30f8000120b2..4aa7833487c8 100644
--- a/drivers/staging/r8188eu/include/rtw_xmit.h
+++ b/drivers/staging/r8188eu/include/rtw_xmit.h
@@ -320,8 +320,6 @@ void rtw_free_xmitframe_queue(struct xmit_priv *pxmitpriv,
 			      struct __queue *pframequeue);
 struct tx_servq *rtw_get_sta_pending(struct adapter *padapter,
 				     struct sta_info *psta, int up, u8 *ac);
-s32 rtw_xmitframe_enqueue(struct adapter *padapter,
-			  struct xmit_frame *pxmitframe);
 struct xmit_frame *rtw_dequeue_xframe(struct xmit_priv *pxmitpriv,
 				      struct hw_xmit *phwxmit_i);
 
-- 
2.30.2


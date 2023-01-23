Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C14176788D3
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 21:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232253AbjAWU5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 15:57:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbjAWU5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 15:57:30 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11333252B
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 12:57:18 -0800 (PST)
Received: from ipservice-092-217-089-134.092.217.pools.vodafone-ip.de ([92.217.89.134] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1pK3pV-0000Lk-Kt; Mon, 23 Jan 2023 21:54:13 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 23/23] staging: r8188eu: merge rtw_free_hwxmits into its only caller
Date:   Mon, 23 Jan 2023 21:53:42 +0100
Message-Id: <20230123205342.229589-24-martin@kaiser.cx>
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

rtw_free_hwxmits is called only by _rtw_free_xmit_priv. We can merge the
two functions and make the code a bit shorter.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_xmit.c    | 11 +----------
 drivers/staging/r8188eu/include/rtw_xmit.h |  1 -
 2 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index 3752d4fddd11..f50e10f0d51f 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -281,7 +281,7 @@ void _rtw_free_xmit_priv(struct xmit_priv *pxmitpriv)
 
 	vfree(pxmitpriv->pallocated_xmit_extbuf);
 
-	rtw_free_hwxmits(padapter);
+	kfree(pxmitpriv->hwxmits);
 
 	mutex_destroy(&pxmitpriv->ack_tx_mutex);
 }
@@ -1475,15 +1475,6 @@ int rtw_alloc_hwxmits(struct adapter *padapter)
 	return 0;
 }
 
-void rtw_free_hwxmits(struct adapter *padapter)
-{
-	struct hw_xmit *hwxmits;
-	struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
-
-	hwxmits = pxmitpriv->hwxmits;
-	kfree(hwxmits);
-}
-
 static int rtw_br_client_tx(struct adapter *padapter, struct sk_buff **pskb)
 {
 	struct sk_buff *skb = *pskb;
diff --git a/drivers/staging/r8188eu/include/rtw_xmit.h b/drivers/staging/r8188eu/include/rtw_xmit.h
index 33c3031de2c4..d8808e68f778 100644
--- a/drivers/staging/r8188eu/include/rtw_xmit.h
+++ b/drivers/staging/r8188eu/include/rtw_xmit.h
@@ -328,7 +328,6 @@ s32 rtw_txframes_sta_ac_pending(struct adapter *padapter,
 int _rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter);
 void _rtw_free_xmit_priv(struct xmit_priv *pxmitpriv);
 int rtw_alloc_hwxmits(struct adapter *padapter);
-void rtw_free_hwxmits(struct adapter *padapter);
 s32 rtw_xmit(struct adapter *padapter, struct sk_buff **pkt);
 
 int xmitframe_enqueue_for_sleeping_sta(struct adapter *padapter, struct xmit_frame *pxmitframe);
-- 
2.30.2


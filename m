Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35EE5661862
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 19:59:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236437AbjAHS6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 13:58:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjAHS6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 13:58:00 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E828E00D
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 10:57:59 -0800 (PST)
Received: from dslb-188-096-147-053.188.096.pools.vodafone-ip.de ([188.96.147.53] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1pEarh-0003b8-Bx; Sun, 08 Jan 2023 19:57:53 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 04/13] staging: r8188eu: voq_cnt is write-only
Date:   Sun,  8 Jan 2023 19:57:29 +0100
Message-Id: <20230108185738.597105-5-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230108185738.597105-1-martin@kaiser.cx>
References: <20230108185738.597105-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

voq_cnt in struct xmit_priv is initialised, incremented and decremented
but never read. Remove voq_cnt and resulting dead code.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_xmit.c        | 3 ---
 drivers/staging/r8188eu/include/rtw_xmit.h     | 2 --
 drivers/staging/r8188eu/os_dep/usb_ops_linux.c | 4 ----
 3 files changed, 9 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index 1319a7fce8b3..8211b858573f 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -194,9 +194,6 @@ int _rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 
 	pxmitpriv->txirp_cnt = 1;
 
-	/* per AC pending irp */
-	pxmitpriv->voq_cnt = 0;
-
 	pxmitpriv->ack_tx = false;
 	mutex_init(&pxmitpriv->ack_tx_mutex);
 	rtw_sctx_init(&pxmitpriv->ack_tx_ops, 0);
diff --git a/drivers/staging/r8188eu/include/rtw_xmit.h b/drivers/staging/r8188eu/include/rtw_xmit.h
index 71a7fb33b0d0..7e6cf745d913 100644
--- a/drivers/staging/r8188eu/include/rtw_xmit.h
+++ b/drivers/staging/r8188eu/include/rtw_xmit.h
@@ -281,8 +281,6 @@ struct	xmit_priv {
 				 * 1->vi, 2->be, 3->bk. */
 	u8		txirp_cnt;/*  */
 	struct tasklet_struct xmit_tasklet;
-	/* per AC pending irp */
-	int voq_cnt;
 	struct __queue free_xmitbuf_queue;
 	struct __queue pending_xmitbuf_queue;
 	u8 *pallocated_xmitbuf;
diff --git a/drivers/staging/r8188eu/os_dep/usb_ops_linux.c b/drivers/staging/r8188eu/os_dep/usb_ops_linux.c
index 7929b7d5e89e..6fe5a4230291 100644
--- a/drivers/staging/r8188eu/os_dep/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/os_dep/usb_ops_linux.c
@@ -42,9 +42,6 @@ static void usb_write_port_complete(struct urb *purb, struct pt_regs *regs)
 	struct xmit_priv	*pxmitpriv = &padapter->xmitpriv;
 
 	switch (pxmitbuf->flags) {
-	case VO_QUEUE_INX:
-		pxmitpriv->voq_cnt--;
-		break;
 	case HIGH_QUEUE_INX:
 		rtw_chk_hi_queue_cmd(padapter);
 		break;
@@ -106,7 +103,6 @@ u32 rtw_write_port(struct adapter *padapter, u32 addr, u32 cnt, u8 *wmem)
 
 	switch (addr) {
 	case VO_QUEUE_INX:
-		pxmitpriv->voq_cnt++;
 		pxmitbuf->flags = VO_QUEUE_INX;
 		break;
 	case VI_QUEUE_INX:
-- 
2.30.2


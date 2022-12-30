Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC01659B45
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 19:07:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235533AbiL3SHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 13:07:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235158AbiL3SH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 13:07:29 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071181C908
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 10:07:20 -0800 (PST)
Received: from dslb-188-097-208-179.188.097.pools.vodafone-ip.de ([188.97.208.179] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1pBJmm-0004rR-Ce; Fri, 30 Dec 2022 19:07:16 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 13/20] staging: r8188eu: remove unused dma_transfer_addr
Date:   Fri, 30 Dec 2022 19:06:39 +0100
Message-Id: <20221230180646.91008-14-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221230180646.91008-1-martin@kaiser.cx>
References: <20221230180646.91008-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dma_transfer_addr component in struct xmit_buf is initialised but not
used. Remove it.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_xmit.c    | 1 -
 drivers/staging/r8188eu/include/rtw_xmit.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index 0fef508408a7..bf4bb1e66985 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -41,7 +41,6 @@ static int rtw_xmit_resource_alloc(struct adapter *padapter, struct xmit_buf *px
 		return -ENOMEM;
 
 	pxmitbuf->pbuf = (u8 *)ALIGN((size_t)(pxmitbuf->pallocated_buf), XMITBUF_ALIGN_SZ);
-	pxmitbuf->dma_transfer_addr = 0;
 
 	pxmitbuf->pxmit_urb = usb_alloc_urb(0, GFP_KERNEL);
 	if (!pxmitbuf->pxmit_urb) {
diff --git a/drivers/staging/r8188eu/include/rtw_xmit.h b/drivers/staging/r8188eu/include/rtw_xmit.h
index b017f9293f86..1c4fbdf97a12 100644
--- a/drivers/staging/r8188eu/include/rtw_xmit.h
+++ b/drivers/staging/r8188eu/include/rtw_xmit.h
@@ -202,7 +202,6 @@ struct xmit_buf {
 	struct submit_ctx *sctx;
 	u32	ff_hwaddr;
 	struct urb *pxmit_urb;
-	dma_addr_t dma_transfer_addr;	/* (in) dma addr for transfer_buffer */
 	int last[8];
 };
 
-- 
2.30.2


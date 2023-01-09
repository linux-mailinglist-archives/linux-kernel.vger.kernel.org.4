Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDA466632F0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 22:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237792AbjAIVaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 16:30:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbjAIV3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 16:29:23 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763C26258
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 13:29:16 -0800 (PST)
Received: from dslb-188-096-147-178.188.096.pools.vodafone-ip.de ([188.96.147.178] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1pEzhe-0007iD-8q; Mon, 09 Jan 2023 22:29:10 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH v2 08/12] staging: r8188eu: txirp_cnt is write-only
Date:   Mon,  9 Jan 2023 22:28:48 +0100
Message-Id: <20230109212852.75612-9-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230109212852.75612-1-martin@kaiser.cx>
References: <20230108185738.597105-1-martin@kaiser.cx>
 <20230109212852.75612-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

txirp_cnt in struct xmit_priv is initialised but never read. Remove it.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_xmit.c    | 2 --
 drivers/staging/r8188eu/include/rtw_xmit.h | 1 -
 2 files changed, 3 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index 8211b858573f..1cd560630de3 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -192,8 +192,6 @@ int _rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 	for (i = 0; i < 4; i++)
 		pxmitpriv->wmm_para_seq[i] = i;
 
-	pxmitpriv->txirp_cnt = 1;
-
 	pxmitpriv->ack_tx = false;
 	mutex_init(&pxmitpriv->ack_tx_mutex);
 	rtw_sctx_init(&pxmitpriv->ack_tx_ops, 0);
diff --git a/drivers/staging/r8188eu/include/rtw_xmit.h b/drivers/staging/r8188eu/include/rtw_xmit.h
index 7e6cf745d913..50d9311d3e40 100644
--- a/drivers/staging/r8188eu/include/rtw_xmit.h
+++ b/drivers/staging/r8188eu/include/rtw_xmit.h
@@ -279,7 +279,6 @@ struct	xmit_priv {
 	u8	wmm_para_seq[4];/* sequence for wmm ac parameter strength
 				 * from large to small. it's value is 0->vo,
 				 * 1->vi, 2->be, 3->bk. */
-	u8		txirp_cnt;/*  */
 	struct tasklet_struct xmit_tasklet;
 	struct __queue free_xmitbuf_queue;
 	struct __queue pending_xmitbuf_queue;
-- 
2.30.2


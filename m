Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C60DC652DE0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 09:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234390AbiLUI3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 03:29:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiLUI3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 03:29:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50CB91DF10
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 00:28:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5CC861722
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 08:28:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EBC9C433F0;
        Wed, 21 Dec 2022 08:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671611335;
        bh=N698njmM2B2uPN33946WgNLAAoM5jgi1Y50DyPJmOtQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bzxSycqgyvMUEP5DwEr0WxevPI+tvkDqgLzXJ5B9RrYEa5bu1+vqaV4QvyUSscIOJ
         aof4qdO4w5Sv6m1Do61NUf8biPWe/HAvfzELCIPGFXC9qLjCxgRuGWzPT8/h2jK2jm
         flYBzKMbgeq91Iz1DEJ9+HLL5MkFNqdVuMfchC6mbHxUtFLmR9w6b4HtmJmduP8tvx
         Uur3pd3plrFjx1LJ/xoY9TDPZZGmf20d3RoCAzRtiafAKvDO2xawb7PNw6oIyrpM1W
         rhjv+HHazGYIhY5PhEarLnv7AqpyfbTayLAXrwfQX/YSOgDNJdTKU28d1pRT/2jHg6
         MzHSCn7QyTOuQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 2/2] habanalabs: fix dma-buf release handling if dma_buf_fd() fails
Date:   Wed, 21 Dec 2022 10:28:46 +0200
Message-Id: <20221221082846.3164-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221221082846.3164-1-ogabbay@kernel.org>
References: <20221221082846.3164-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomer Tayar <ttayar@habana.ai>

The dma-buf private object is freed if a call to dma_buf_fd() fails,
and because a file was already associated with the dma-buf in
dma_buf_export(), the release op will be called and will use this
object.

Mark the 'priv' field as NULL in this case, and avoid accessing it from
the release op.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/memory.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
index 693456366753..a2d24c9a3d1e 100644
--- a/drivers/misc/habanalabs/common/memory.c
+++ b/drivers/misc/habanalabs/common/memory.c
@@ -1782,7 +1782,12 @@ static void hl_unmap_dmabuf(struct dma_buf_attachment *attachment,
 static void hl_release_dmabuf(struct dma_buf *dmabuf)
 {
 	struct hl_dmabuf_priv *hl_dmabuf = dmabuf->priv;
-	struct hl_ctx *ctx = hl_dmabuf->ctx;
+	struct hl_ctx *ctx;
+
+	if (!hl_dmabuf)
+		return;
+
+	ctx = hl_dmabuf->ctx;
 
 	if (hl_dmabuf->memhash_hnode) {
 		mutex_lock(&ctx->mem_hash_lock);
@@ -1822,7 +1827,7 @@ static int export_dmabuf(struct hl_ctx *ctx,
 
 	fd = dma_buf_fd(hl_dmabuf->dmabuf, flags);
 	if (fd < 0) {
-		dev_err(hdev->dev, "failed to get a file descriptor for a dma-buf\n");
+		dev_err(hdev->dev, "failed to get a file descriptor for a dma-buf, %d\n", fd);
 		rc = fd;
 		goto err_dma_buf_put;
 	}
@@ -1835,6 +1840,7 @@ static int export_dmabuf(struct hl_ctx *ctx,
 	return 0;
 
 err_dma_buf_put:
+	hl_dmabuf->dmabuf->priv = NULL;
 	dma_buf_put(hl_dmabuf->dmabuf);
 	return rc;
 }
-- 
2.34.1


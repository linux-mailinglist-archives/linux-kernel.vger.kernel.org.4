Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C67269C369
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 00:35:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjBSXe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 18:34:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBSXe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 18:34:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65AB0A27A
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 15:34:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE40460C12
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 23:34:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23564C433D2;
        Sun, 19 Feb 2023 23:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676849695;
        bh=HpPijLAkeZBcfgpuO4krVSl+jKWdeWQmrUDYyhPWGcQ=;
        h=From:To:Cc:Subject:Date:From;
        b=NsGjE+1Lp+eCe7wYIRJcHYd1KJ1QXkrs8uba2KgCXiVTVm9VfHlSxqhqsFKyYx3nH
         ZW+5Gfxa5m95Cn0o3sn4WT/vHujk83q4/vwkiMj2eORE8Df1Nn7y3S+CqitnfLAIQY
         VxIHWE8FFSnAzr4wY9Ypjstyr2KJDN14XMHLyUPLY2i1fjazCq4rLT/E3IitW4fZg2
         lTT0Gdp0gVvnpOYKwAceBoN0h0It0DBDjK8YtaoiMU6OCRWpQvCeR5uJfSmAQuw2pV
         GQcVFDgQRYW8aCWY8TRG88kwMEkx8Ea4sANyThy9uiNQZc3QEMnbNG3wuhngg70aI+
         5KlzsgpCVrVTg==
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
Subject: [PATCH] soc: mediatek: cmdq: Remove unused helper funciton
Date:   Sun, 19 Feb 2023 23:34:39 +0000
Message-Id: <20230219233439.3157-1-chunkuang.hu@kernel.org>
X-Mailer: git-send-email 2.34.1
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

cmdq_pkt_create(), cmdq_pkt_destroy(), and cmdq_pkt_flush_async()
are not used by all client drivers (MediaTek drm driver and
MediaTek mdp3 driver), so remove them.

Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
---
 drivers/soc/mediatek/mtk-cmdq-helper.c | 59 --------------------------
 include/linux/soc/mediatek/mtk-cmdq.h  | 28 ------------
 2 files changed, 87 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediatek/mtk-cmdq-helper.c
index c1837a468267..d4ab39236c79 100644
--- a/drivers/soc/mediatek/mtk-cmdq-helper.c
+++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
@@ -104,50 +104,6 @@ void cmdq_mbox_destroy(struct cmdq_client *client)
 }
 EXPORT_SYMBOL(cmdq_mbox_destroy);
 
-struct cmdq_pkt *cmdq_pkt_create(struct cmdq_client *client, size_t size)
-{
-	struct cmdq_pkt *pkt;
-	struct device *dev;
-	dma_addr_t dma_addr;
-
-	pkt = kzalloc(sizeof(*pkt), GFP_KERNEL);
-	if (!pkt)
-		return ERR_PTR(-ENOMEM);
-	pkt->va_base = kzalloc(size, GFP_KERNEL);
-	if (!pkt->va_base) {
-		kfree(pkt);
-		return ERR_PTR(-ENOMEM);
-	}
-	pkt->buf_size = size;
-	pkt->cl = (void *)client;
-
-	dev = client->chan->mbox->dev;
-	dma_addr = dma_map_single(dev, pkt->va_base, pkt->buf_size,
-				  DMA_TO_DEVICE);
-	if (dma_mapping_error(dev, dma_addr)) {
-		dev_err(dev, "dma map failed, size=%u\n", (u32)(u64)size);
-		kfree(pkt->va_base);
-		kfree(pkt);
-		return ERR_PTR(-ENOMEM);
-	}
-
-	pkt->pa_base = dma_addr;
-
-	return pkt;
-}
-EXPORT_SYMBOL(cmdq_pkt_create);
-
-void cmdq_pkt_destroy(struct cmdq_pkt *pkt)
-{
-	struct cmdq_client *client = (struct cmdq_client *)pkt->cl;
-
-	dma_unmap_single(client->chan->mbox->dev, pkt->pa_base, pkt->buf_size,
-			 DMA_TO_DEVICE);
-	kfree(pkt->va_base);
-	kfree(pkt);
-}
-EXPORT_SYMBOL(cmdq_pkt_destroy);
-
 static int cmdq_pkt_append_command(struct cmdq_pkt *pkt,
 				   struct cmdq_instruction inst)
 {
@@ -425,19 +381,4 @@ int cmdq_pkt_finalize(struct cmdq_pkt *pkt)
 }
 EXPORT_SYMBOL(cmdq_pkt_finalize);
 
-int cmdq_pkt_flush_async(struct cmdq_pkt *pkt)
-{
-	int err;
-	struct cmdq_client *client = (struct cmdq_client *)pkt->cl;
-
-	err = mbox_send_message(client->chan, pkt);
-	if (err < 0)
-		return err;
-	/* We can send next packet immediately, so just call txdone. */
-	mbox_client_txdone(client->chan, 0);
-
-	return 0;
-}
-EXPORT_SYMBOL(cmdq_pkt_flush_async);
-
 MODULE_LICENSE("GPL v2");
diff --git a/include/linux/soc/mediatek/mtk-cmdq.h b/include/linux/soc/mediatek/mtk-cmdq.h
index 2b498f4f3946..60e4c0ca52a1 100644
--- a/include/linux/soc/mediatek/mtk-cmdq.h
+++ b/include/linux/soc/mediatek/mtk-cmdq.h
@@ -57,21 +57,6 @@ struct cmdq_client *cmdq_mbox_create(struct device *dev, int index);
  */
 void cmdq_mbox_destroy(struct cmdq_client *client);
 
-/**
- * cmdq_pkt_create() - create a CMDQ packet
- * @client:	the CMDQ mailbox client
- * @size:	required CMDQ buffer size
- *
- * Return: CMDQ packet pointer
- */
-struct cmdq_pkt *cmdq_pkt_create(struct cmdq_client *client, size_t size);
-
-/**
- * cmdq_pkt_destroy() - destroy the CMDQ packet
- * @pkt:	the CMDQ packet
- */
-void cmdq_pkt_destroy(struct cmdq_pkt *pkt);
-
 /**
  * cmdq_pkt_write() - append write command to the CMDQ packet
  * @pkt:	the CMDQ packet
@@ -264,17 +249,4 @@ int cmdq_pkt_jump(struct cmdq_pkt *pkt, dma_addr_t addr);
  */
 int cmdq_pkt_finalize(struct cmdq_pkt *pkt);
 
-/**
- * cmdq_pkt_flush_async() - trigger CMDQ to asynchronously execute the CMDQ
- *                          packet and call back at the end of done packet
- * @pkt:	the CMDQ packet
- *
- * Return: 0 for success; else the error code is returned
- *
- * Trigger CMDQ to asynchronously execute the CMDQ packet and call back
- * at the end of done packet. Note that this is an ASYNC function. When the
- * function returned, it may or may not be finished.
- */
-int cmdq_pkt_flush_async(struct cmdq_pkt *pkt);
-
 #endif	/* __MTK_CMDQ_H__ */
-- 
2.34.1


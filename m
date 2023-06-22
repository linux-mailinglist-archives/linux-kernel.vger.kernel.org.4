Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B23B5739E17
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 12:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbjFVKMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 06:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjFVKMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 06:12:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7AFE2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 03:12:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 19FA66179B
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 10:12:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8630C433C8;
        Thu, 22 Jun 2023 10:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687428760;
        bh=xfE+SfdZbVenJR/6vTIRquflwQen9M2hQvN+u8qWUMU=;
        h=From:To:Cc:Subject:Date:From;
        b=aAFUIIEIxnNtlXlzMa5qj5LivneC/3DsagG3gKQvdrLByGh+pLn65NP6NqL1sd09q
         Xwbxw5hJOHt/ZPc/mN2q8fz52Z7j3xDSaYvptczL5PQZ6BYYeo1LsvF+p2+99x4ldK
         Au9G6Z8UWRGtKHP5lIE8CZqg2xbaC7MkZcHOmfKrYOWvCRKQa6L2ctbNqQg1Kk+4NU
         Ettls9pSe+NKL1hLa1FRjsUZfAtpDw+T0e5tU0pYGhEZegWl20K7IgY6r+lFnl7RBA
         TMZAhxjjz1UHI03Sy2ZHAfx+w85+7CwiyTDxD6NXAKGK5v+m9GTtk1ku3X5ZLtjgqz
         +PYKcUp3+shAg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Mark Brown <broonie@kernel.org>,
        Yingkun Meng <mengyingkun@loongson.cn>
Cc:     Arnd Bergmann <arnd@arndb.de>, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: loongson: fix address space confusion
Date:   Thu, 22 Jun 2023 12:12:22 +0200
Message-Id: <20230622101235.3230941-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The i2s driver uses the mapped __iomem address of the FIFO as the DMA
address for the device. This apparently works on loongarch because of
the way it handles __iomem pointers as aliases of physical addresses,
but this is not portable to other architectures and causes a compiler
warning when dma addresses are not the same size as pointers:

sound/soc/loongson/loongson_i2s_pci.c: In function 'loongson_i2s_pci_probe':
sound/soc/loongson/loongson_i2s_pci.c:110:29: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]
  110 |         tx_data->dev_addr = (dma_addr_t)i2s->reg_base + LS_I2S_TX_DATA;
      |                             ^
sound/soc/loongson/loongson_i2s_pci.c:113:29: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]
  113 |         rx_data->dev_addr = (dma_addr_t)i2s->reg_base + LS_I2S_RX_DATA;
      |                             ^

Change the driver to instead use the physical address as stored in the
PCI BAR resource directly. Since 'dev_addr' is a 32-bit address, I think
this results in the same truncated address on loongarch but is otherwise
closer to portable code and avoids the warning.

Fixes: d84881e06836d ("ASoC: Add support for Loongson I2S controller")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
This is only build tested and I don't understand the loongarch specifics
that well, please review or test for actual hardware requirements.
---
 sound/soc/loongson/loongson_i2s_pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/loongson/loongson_i2s_pci.c b/sound/soc/loongson/loongson_i2s_pci.c
index 6dcfb17d3276d..fa90361865c6c 100644
--- a/sound/soc/loongson/loongson_i2s_pci.c
+++ b/sound/soc/loongson/loongson_i2s_pci.c
@@ -107,10 +107,10 @@ static int loongson_i2s_pci_probe(struct pci_dev *pdev,
 	tx_data = &i2s->tx_dma_data;
 	rx_data = &i2s->rx_dma_data;
 
-	tx_data->dev_addr = (dma_addr_t)i2s->reg_base + LS_I2S_TX_DATA;
+	tx_data->dev_addr = pci_resource_start(pdev, 0) + LS_I2S_TX_DATA;
 	tx_data->order_addr = i2s->reg_base + LS_I2S_TX_ORDER;
 
-	rx_data->dev_addr = (dma_addr_t)i2s->reg_base + LS_I2S_RX_DATA;
+	rx_data->dev_addr = pci_resource_start(pdev, 0) + LS_I2S_RX_DATA;
 	rx_data->order_addr = i2s->reg_base + LS_I2S_RX_ORDER;
 
 	tx_data->irq = fwnode_irq_get_byname(fwnode, "tx");
-- 
2.39.2


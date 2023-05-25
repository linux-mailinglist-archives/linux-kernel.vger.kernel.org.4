Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41F1B7114CF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 20:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242245AbjEYSlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 14:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242135AbjEYSj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 14:39:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358D41FD2;
        Thu, 25 May 2023 11:37:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 15D89648DF;
        Thu, 25 May 2023 18:37:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE542C4339B;
        Thu, 25 May 2023 18:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685039834;
        bh=K4YcD6dswcLwvVVRAb/LMSzwarNi1nA2TqBIrwoBs0c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BgpP5KW2BjCg3TbQTHHgY+JFpujjh8W+ImNQFuNCE5ZvaQJ+EhW9uIFp+qTlgG4ei
         us29foCrGdkiBNZMdgDHg1AsAtlO5qwHyOJw5mvABZgyi7uYJGI1dlqSAMLAzqUw3q
         qXsheO7dXGD/i1fBaEfCDHzcSEDYR9THhIxhu59K94MRPjTgp7BJlxSspwxKwRYjUw
         XH4dt3P8kVpuuBQE2usa5yDZbhOqUK00lGrkj/xA8FxFN16uLVEMu63OlCGi9ZLOjf
         HkaSTLbhErJ4+Ze78F3OgeoyD9f+0uQlxvBThVBtADFVXhXQVFCt2ifAnxP/yPslld
         iSgdyZfv1NxfQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wei Chen <harperchen1110@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>, serjk@netup.ru,
        aospan@netup.ru, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 18/57] media: netup_unidvb: fix irq init by register it at the end of probe
Date:   Thu, 25 May 2023 14:35:28 -0400
Message-Id: <20230525183607.1793983-18-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230525183607.1793983-1-sashal@kernel.org>
References: <20230525183607.1793983-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Chen <harperchen1110@gmail.com>

[ Upstream commit e6ad6233592593079db5c8fa592c298e51bc1356 ]

IRQ handler netup_spi_interrupt() takes spinlock spi->lock. The lock
is initialized in netup_spi_init(). However, irq handler is registered
before initializing the lock.

Spinlock dma->lock and i2c->lock suffer from the same problem.

Fix this by registering the irq at the end of probe.

Link: https://lore.kernel.org/linux-media/20230315134518.1074497-1-harperchen1110@gmail.com
Signed-off-by: Wei Chen <harperchen1110@gmail.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../media/pci/netup_unidvb/netup_unidvb_core.c  | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/media/pci/netup_unidvb/netup_unidvb_core.c b/drivers/media/pci/netup_unidvb/netup_unidvb_core.c
index 8287851b5ffdc..751a954baf651 100644
--- a/drivers/media/pci/netup_unidvb/netup_unidvb_core.c
+++ b/drivers/media/pci/netup_unidvb/netup_unidvb_core.c
@@ -887,12 +887,7 @@ static int netup_unidvb_initdev(struct pci_dev *pci_dev,
 		ndev->lmmio0, (u32)pci_resource_len(pci_dev, 0),
 		ndev->lmmio1, (u32)pci_resource_len(pci_dev, 1),
 		pci_dev->irq);
-	if (request_irq(pci_dev->irq, netup_unidvb_isr, IRQF_SHARED,
-			"netup_unidvb", pci_dev) < 0) {
-		dev_err(&pci_dev->dev,
-			"%s(): can't get IRQ %d\n", __func__, pci_dev->irq);
-		goto irq_request_err;
-	}
+
 	ndev->dma_size = 2 * 188 *
 		NETUP_DMA_BLOCKS_COUNT * NETUP_DMA_PACKETS_COUNT;
 	ndev->dma_virt = dma_alloc_coherent(&pci_dev->dev,
@@ -933,6 +928,14 @@ static int netup_unidvb_initdev(struct pci_dev *pci_dev,
 		dev_err(&pci_dev->dev, "netup_unidvb: DMA setup failed\n");
 		goto dma_setup_err;
 	}
+
+	if (request_irq(pci_dev->irq, netup_unidvb_isr, IRQF_SHARED,
+			"netup_unidvb", pci_dev) < 0) {
+		dev_err(&pci_dev->dev,
+			"%s(): can't get IRQ %d\n", __func__, pci_dev->irq);
+		goto dma_setup_err;
+	}
+
 	dev_info(&pci_dev->dev,
 		"netup_unidvb: device has been initialized\n");
 	return 0;
@@ -951,8 +954,6 @@ static int netup_unidvb_initdev(struct pci_dev *pci_dev,
 	dma_free_coherent(&pci_dev->dev, ndev->dma_size,
 			ndev->dma_virt, ndev->dma_phys);
 dma_alloc_err:
-	free_irq(pci_dev->irq, pci_dev);
-irq_request_err:
 	iounmap(ndev->lmmio1);
 pci_bar1_error:
 	iounmap(ndev->lmmio0);
-- 
2.39.2


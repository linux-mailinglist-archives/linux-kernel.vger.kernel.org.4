Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 916A464D409
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 00:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbiLNXy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 18:54:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbiLNXxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 18:53:22 -0500
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B12AD50D45;
        Wed, 14 Dec 2022 15:53:21 -0800 (PST)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 52047E0ED6;
        Thu, 15 Dec 2022 02:53:21 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:from:from:in-reply-to:message-id
        :mime-version:references:reply-to:subject:subject:to:to; s=post;
         bh=2krqQUJZ/RVFcV7ojrfBDjEoktm5LxoQTABT1U/V+7Y=; b=Wfum5l7c4RkM
        wmhC2x3I0j/zR0yimNrfkdTT8HLV+5oKUt+Sp0UzC6KeuYqOSiYaoUx7Cm5UzMog
        kV65zXSEbKh/C5gBeQIxKmKAds08jKxlKCVKccUlfLup2EOsthgaZ3r8zPVJhZuT
        VfhehmNoPbWTaMzOY1J+3Yak6iZEBWE=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 45143E0E6B;
        Thu, 15 Dec 2022 02:53:21 +0300 (MSK)
Received: from localhost (10.8.30.6) by mail (192.168.51.25) with Microsoft
 SMTP Server (TLS) id 15.0.1395.4; Thu, 15 Dec 2022 02:53:21 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Robin Murphy <robin.murphy@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>, Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        caihuoqing <caihuoqing@baidu.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        <linux-pci@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 18/25] dmaengine: dw-edma: Use DMA-engine device DebugFS subdirectory
Date:   Thu, 15 Dec 2022 02:52:58 +0300
Message-ID: <20221214235305.31744-19-Sergey.Semin@baikalelectronics.ru>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221214235305.31744-1-Sergey.Semin@baikalelectronics.ru>
References: <20221214235305.31744-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.8.30.6]
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since all DW eDMA read and write channels are now installed in a framework
of a single DMA-engine device, we can freely move all the DW eDMA-specific
DebugFS nodes into a ready-to-use DMA-engine DebugFS subdirectory. It's
created during the DMA-device registration and can be found in the
dma_device.dbg_dev_root field.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Acked-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/dma/dw-edma/dw-edma-core.c       |  3 ---
 drivers/dma/dw-edma/dw-edma-core.h       |  3 ---
 drivers/dma/dw-edma/dw-edma-v0-core.c    |  5 -----
 drivers/dma/dw-edma/dw-edma-v0-core.h    |  1 -
 drivers/dma/dw-edma/dw-edma-v0-debugfs.c | 16 ++++------------
 drivers/dma/dw-edma/dw-edma-v0-debugfs.h |  5 -----
 6 files changed, 4 insertions(+), 29 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index c3ecae4287d0..58808bec4148 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -1038,9 +1038,6 @@ int dw_edma_remove(struct dw_edma_chip *chip)
 		list_del(&chan->vc.chan.device_node);
 	}
 
-	/* Turn debugfs off */
-	dw_edma_v0_core_debugfs_off(dw);
-
 	return 0;
 }
 EXPORT_SYMBOL_GPL(dw_edma_remove);
diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index b576a8fff45a..e3ad3e372b55 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -111,9 +111,6 @@ struct dw_edma {
 	raw_spinlock_t			lock;		/* Only for legacy */
 
 	struct dw_edma_chip             *chip;
-#ifdef CONFIG_DEBUG_FS
-	struct dentry			*debugfs;
-#endif /* CONFIG_DEBUG_FS */
 };
 
 struct dw_edma_sg {
diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index 77e6cfe52e0a..66f296daac5a 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -504,8 +504,3 @@ void dw_edma_v0_core_debugfs_on(struct dw_edma *dw)
 {
 	dw_edma_v0_debugfs_on(dw);
 }
-
-void dw_edma_v0_core_debugfs_off(struct dw_edma *dw)
-{
-	dw_edma_v0_debugfs_off(dw);
-}
diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.h b/drivers/dma/dw-edma/dw-edma-v0-core.h
index 75aec6d31b21..ab96a1f48080 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.h
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.h
@@ -23,6 +23,5 @@ void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first);
 int dw_edma_v0_core_device_config(struct dw_edma_chan *chan);
 /* eDMA debug fs callbacks */
 void dw_edma_v0_core_debugfs_on(struct dw_edma *dw);
-void dw_edma_v0_core_debugfs_off(struct dw_edma *dw);
 
 #endif /* _DW_EDMA_V0_CORE_H */
diff --git a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
index e6cf608d121b..d12c607433bf 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
@@ -268,7 +268,7 @@ static void dw_edma_debugfs_regs(struct dw_edma *dw)
 	struct dentry *regs_dent;
 	int nr_entries;
 
-	regs_dent = debugfs_create_dir(REGISTERS_STR, dw->debugfs);
+	regs_dent = debugfs_create_dir(REGISTERS_STR, dw->dma.dbg_dev_root);
 
 	nr_entries = ARRAY_SIZE(debugfs_regs);
 	dw_edma_debugfs_create_x32(dw, debugfs_regs, nr_entries, regs_dent);
@@ -282,17 +282,9 @@ void dw_edma_v0_debugfs_on(struct dw_edma *dw)
 	if (!debugfs_initialized())
 		return;
 
-	dw->debugfs = debugfs_create_dir(dw->name, NULL);
-
-	debugfs_create_u32("mf", 0444, dw->debugfs, &dw->chip->mf);
-	debugfs_create_u16("wr_ch_cnt", 0444, dw->debugfs, &dw->wr_ch_cnt);
-	debugfs_create_u16("rd_ch_cnt", 0444, dw->debugfs, &dw->rd_ch_cnt);
+	debugfs_create_u32("mf", 0444, dw->dma.dbg_dev_root, &dw->chip->mf);
+	debugfs_create_u16("wr_ch_cnt", 0444, dw->dma.dbg_dev_root, &dw->wr_ch_cnt);
+	debugfs_create_u16("rd_ch_cnt", 0444, dw->dma.dbg_dev_root, &dw->rd_ch_cnt);
 
 	dw_edma_debugfs_regs(dw);
 }
-
-void dw_edma_v0_debugfs_off(struct dw_edma *dw)
-{
-	debugfs_remove_recursive(dw->debugfs);
-	dw->debugfs = NULL;
-}
diff --git a/drivers/dma/dw-edma/dw-edma-v0-debugfs.h b/drivers/dma/dw-edma/dw-edma-v0-debugfs.h
index 3391b86edf5a..fb3342d97d6d 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-debugfs.h
+++ b/drivers/dma/dw-edma/dw-edma-v0-debugfs.h
@@ -13,15 +13,10 @@
 
 #ifdef CONFIG_DEBUG_FS
 void dw_edma_v0_debugfs_on(struct dw_edma *dw);
-void dw_edma_v0_debugfs_off(struct dw_edma *dw);
 #else
 static inline void dw_edma_v0_debugfs_on(struct dw_edma *dw)
 {
 }
-
-static inline void dw_edma_v0_debugfs_off(struct dw_edma *dw)
-{
-}
 #endif /* CONFIG_DEBUG_FS */
 
 #endif /* _DW_EDMA_V0_DEBUG_FS_H */
-- 
2.38.1



Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68950699510
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 14:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjBPNA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 08:00:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjBPNAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 08:00:34 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD8553E60A
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 05:00:33 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 417C266021B1;
        Thu, 16 Feb 2023 13:00:32 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676552432;
        bh=RccccoYIg2VDJV5r2fovP6KY9nTyOOMC3E5fFvlWdFY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CZwvRMWpjpMt9A3c2h48lxb4llxSXlmhnZvFdgt0z/bAH+AKBliugLhJm1Kpn1zpx
         Qprb22EehySQH2hh43Bs0e8DkBlWgXT8n2F7C3MOPwocTtb1xOEYSFDIhbmwJC7ML0
         dQVP+EkF3DcnAVBPLRPYCExiAe4L7BjBENJVYC4EaSKIb/KSZ7k+Sr9uv1WO3aDtYI
         2KmtK0fUzNjNhvYGxvpI11b4immJn4pBHIfAfVEwRnkerh7R7/Ra8zxof/9FUZPdQb
         YUJ00ZbDuh344LvhqrrZrOEH5cHfWb2dZbDq/+PCTvS2IA98Vgqqhf8FzKBROmBc12
         GYvV4w5LTC2Fg==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     jason-jh.lin@mediatek.com, chunkuang.hu@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v1 9/9] soc: mediatek: Cleanup ifdefs for IS_REACHABLE(CONFIG_MTK_CMDQ)
Date:   Thu, 16 Feb 2023 14:00:21 +0100
Message-Id: <20230216130021.64875-10-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230216130021.64875-1-angelogioacchino.delregno@collabora.com>
References: <20230216130021.64875-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the mtk-cmdq.h header contains inline functions for cases
in which the driver is not enabled (either module or built-in), we
can safely go on with cleaning up ifdefs for CMDQ handling.

This also shows in a clearer manner that writing through CMDQ HW is
optional and used only for performance purposes when/where wanted,
needed and/or required.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/soc/mediatek/mtk-mmsys.c | 22 +++++++++-------------
 drivers/soc/mediatek/mtk-mutex.c | 15 +++------------
 2 files changed, 12 insertions(+), 25 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-mmsys.c
index 0f0fa27e17a5..8da5c8d26ed0 100644
--- a/drivers/soc/mediatek/mtk-mmsys.c
+++ b/drivers/soc/mediatek/mtk-mmsys.c
@@ -131,21 +131,18 @@ struct mtk_mmsys {
 static void mtk_mmsys_update_bits(struct mtk_mmsys *mmsys, u32 offset, u32 mask, u32 val,
 				  struct cmdq_pkt *cmdq_pkt)
 {
+	int ret;
 	u32 tmp;
 
-#if IS_REACHABLE(CONFIG_MTK_CMDQ)
-	if (cmdq_pkt) {
-		if (mmsys->cmdq_base.size == 0) {
-			pr_err("mmsys lose gce property, failed to update mmsys bits with cmdq");
+	if (mmsys->cmdq_base.size && cmdq_pkt) {
+		ret = cmdq_pkt_write_mask(cmdq_pkt, mmsys->cmdq_base.subsys,
+					  mmsys->cmdq_base.offset + offset, val,
+					  mask);
+		if (ret)
+			pr_debug("CMDQ unavailable: using CPU write\n");
+		else
 			return;
-		}
-		cmdq_pkt_write_mask(cmdq_pkt, mmsys->cmdq_base.subsys,
-				    mmsys->cmdq_base.offset + offset, val,
-				    mask);
-		return;
 	}
-#endif
-
 	tmp = readl_relaxed(mmsys->regs + offset);
 	tmp = (tmp & ~mask) | (val & mask);
 	writel_relaxed(tmp, mmsys->regs + offset);
@@ -332,11 +329,10 @@ static int mtk_mmsys_probe(struct platform_device *pdev)
 		}
 	}
 
-#if IS_REACHABLE(CONFIG_MTK_CMDQ)
+	/* CMDQ is optional */
 	ret = cmdq_dev_get_client_reg(dev, &mmsys->cmdq_base, 0);
 	if (ret)
 		dev_dbg(dev, "No mediatek,gce-client-reg!\n");
-#endif
 
 	platform_set_drvdata(pdev, mmsys);
 
diff --git a/drivers/soc/mediatek/mtk-mutex.c b/drivers/soc/mediatek/mtk-mutex.c
index 07eff509580a..78c04cc5457a 100644
--- a/drivers/soc/mediatek/mtk-mutex.c
+++ b/drivers/soc/mediatek/mtk-mutex.c
@@ -770,23 +770,18 @@ int mtk_mutex_enable_by_cmdq(struct mtk_mutex *mutex, void *pkt)
 {
 	struct mtk_mutex_ctx *mtx = container_of(mutex, struct mtk_mutex_ctx,
 						 mutex[mutex->id]);
-#if IS_REACHABLE(CONFIG_MTK_CMDQ)
 	struct cmdq_pkt *cmdq_pkt = (struct cmdq_pkt *)pkt;
 
 	WARN_ON(&mtx->mutex[mutex->id] != mutex);
 
 	if (!mtx->cmdq_reg.size) {
 		dev_err(mtx->dev, "mediatek,gce-client-reg hasn't been set");
-		return -EINVAL;
+		return -ENODEV;
 	}
 
 	cmdq_pkt_write(cmdq_pkt, mtx->cmdq_reg.subsys,
 		       mtx->addr + DISP_REG_MUTEX_EN(mutex->id), 1);
 	return 0;
-#else
-	dev_err(mtx->dev, "Not support for enable MUTEX by CMDQ");
-	return -ENODEV;
-#endif
 }
 EXPORT_SYMBOL_GPL(mtk_mutex_enable_by_cmdq);
 
@@ -881,10 +876,7 @@ static int mtk_mutex_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct mtk_mutex_ctx *mtx;
 	struct resource *regs;
-	int i;
-#if IS_REACHABLE(CONFIG_MTK_CMDQ)
-	int ret;
-#endif
+	int i, ret;
 
 	mtx = devm_kzalloc(dev, sizeof(*mtx), GFP_KERNEL);
 	if (!mtx)
@@ -911,11 +903,10 @@ static int mtk_mutex_probe(struct platform_device *pdev)
 	}
 	mtx->addr = regs->start;
 
-#if IS_REACHABLE(CONFIG_MTK_CMDQ)
+	/* CMDQ is optional */
 	ret = cmdq_dev_get_client_reg(dev, &mtx->cmdq_reg, 0);
 	if (ret)
 		dev_dbg(dev, "No mediatek,gce-client-reg!\n");
-#endif
 
 	platform_set_drvdata(pdev, mtx);
 
-- 
2.39.1


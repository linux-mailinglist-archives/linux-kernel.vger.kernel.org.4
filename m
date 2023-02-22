Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 284D169F221
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 10:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232243AbjBVJsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 04:48:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232110AbjBVJsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 04:48:00 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F933866E
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 01:46:11 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 627B866021D5;
        Wed, 22 Feb 2023 09:43:05 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677058985;
        bh=t0WQRQY93wT7Ed+artLK4huBmFp5RCO/YHHv1kqN5ow=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ihCuNPi0WgxnIHJEEL+kMrFdWXEi9a4xwIiBOZoekKc0R1UMCAscg4QF16nCCkfw5
         bEwK2qBpTo/xZzWahGFe2Xt2JHnkzsnbqyD/NTM5Q8N92XPpPxcilEv95/gLSuoE1G
         l19rMU234gvbymd2bprEeJBPS8kIETCZds1t72eG/hFBT6D/6m8ko9BByk7IKTUKrM
         ZWcZRuOm8BPL1g5+JgHVh8C2aAW3tXGpXc+nW7xkRWTRsVMwF1CDkQzc2wBmR7KmaT
         Ov8Tc888vKvh7sS3KQBmOWpZkn2pjn8LQETcdxJtj/40vzb3FoCWGlXjOD04banzzD
         iYLlSU5XpaEnA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     jason-jh.lin@mediatek.com, chunkuang.hu@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chen-Yu Tsai <wenst@chromium.org>
Subject: [PATCH v2 9/9] soc: mediatek: Cleanup ifdefs for IS_REACHABLE(CONFIG_MTK_CMDQ)
Date:   Wed, 22 Feb 2023 10:42:53 +0100
Message-Id: <20230222094253.23678-10-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230222094253.23678-1-angelogioacchino.delregno@collabora.com>
References: <20230222094253.23678-1-angelogioacchino.delregno@collabora.com>
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
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
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
index b106f3d23e0d..b92cffec7be7 100644
--- a/drivers/soc/mediatek/mtk-mutex.c
+++ b/drivers/soc/mediatek/mtk-mutex.c
@@ -871,23 +871,18 @@ int mtk_mutex_enable_by_cmdq(struct mtk_mutex *mutex, void *pkt)
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
 
@@ -1000,10 +995,7 @@ static int mtk_mutex_probe(struct platform_device *pdev)
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
@@ -1030,11 +1022,10 @@ static int mtk_mutex_probe(struct platform_device *pdev)
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
2.39.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48F1969950D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 14:00:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjBPNAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 08:00:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjBPNAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 08:00:32 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD6503D093
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 05:00:31 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 51B0166021AD;
        Thu, 16 Feb 2023 13:00:30 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676552430;
        bh=CGTdGgAkIa0N9/8JF5Pc98xYJtzEvXtjERV+RFs8Mn0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c0qRVUW1m3Hm+37hwH7b9QiKLsEcAYSmzQ7U8v/BBuloJHMcYTdowiuvNJNKPyD03
         I2T+K5gTR0O7ej6LueV0WqxLPdFLs4v1SvqxeMScyl/7Bp7tWBH7qR21D7Sw0g+pEw
         kjbDu0IvDlTtkbP0mtBlgS2CxL0bc7iYLLusntrRYtXiBo4vb1KXHvQcTCHn5XSIDx
         a9gbdwe86XgcSerMs8FK2AbfqZ0IMvl7SKAleJ3SWlTA+UYopIBu2RSM+zgQmeXX7l
         HmwJ84H9TrMfZYo6b5D54j82bdVnmttqjJHHKI0yp3HSICkBE9Gax5GldHbhRupZp8
         /H0QQalo9ZvwA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     jason-jh.lin@mediatek.com, chunkuang.hu@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v1 6/9] soc: mediatek: mtk-mutex: Replace max handles number with definition
Date:   Thu, 16 Feb 2023 14:00:18 +0100
Message-Id: <20230216130021.64875-7-angelogioacchino.delregno@collabora.com>
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

Replace the magic number "10", defining the maximum number of supported
handles with a MTK_MUTEX_MAX_HANDLES definition.
While at it, also change the type for `id` from a signed integer to
a unsigned 8 bits integer to save some (small) memory footprint, as
this number is never higher than 10.

This cleanup brings no functional changes.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/soc/mediatek/mtk-mutex.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-mutex.c b/drivers/soc/mediatek/mtk-mutex.c
index 5c875139425c..fb6bd0838892 100644
--- a/drivers/soc/mediatek/mtk-mutex.c
+++ b/drivers/soc/mediatek/mtk-mutex.c
@@ -14,6 +14,8 @@
 #include <linux/soc/mediatek/mtk-mutex.h>
 #include <linux/soc/mediatek/mtk-cmdq.h>
 
+#define MTK_MUTEX_MAX_HANDLES			10
+
 #define MT2701_MUTEX0_MOD0			0x2c
 #define MT2701_MUTEX0_SOF0			0x30
 #define MT8183_MUTEX0_MOD0			0x30
@@ -234,7 +236,7 @@
 #define MT8195_MUTEX_EOF_DPI1			(MT8195_MUTEX_SOF_DPI1 << 7)
 
 struct mtk_mutex {
-	int id;
+	u8 id;
 	bool claimed;
 };
 
@@ -264,7 +266,7 @@ struct mtk_mutex_ctx {
 	struct device			*dev;
 	struct clk			*clk;
 	void __iomem			*regs;
-	struct mtk_mutex		mutex[10];
+	struct mtk_mutex		mutex[MTK_MUTEX_MAX_HANDLES];
 	const struct mtk_mutex_data	*data;
 	phys_addr_t			addr;
 	struct cmdq_client_reg		cmdq_reg;
@@ -616,7 +618,7 @@ struct mtk_mutex *mtk_mutex_get(struct device *dev)
 	struct mtk_mutex_ctx *mtx = dev_get_drvdata(dev);
 	int i;
 
-	for (i = 0; i < 10; i++)
+	for (i = 0; i < MTK_MUTEX_MAX_HANDLES; i++)
 		if (!mtx->mutex[i].claimed) {
 			mtx->mutex[i].claimed = true;
 			return &mtx->mutex[i];
@@ -888,7 +890,7 @@ static int mtk_mutex_probe(struct platform_device *pdev)
 	if (!mtx)
 		return -ENOMEM;
 
-	for (i = 0; i < 10; i++)
+	for (i = 0; i < MTK_MUTEX_MAX_HANDLES; i++)
 		mtx->mutex[i].id = i;
 
 	mtx->data = of_device_get_match_data(dev);
-- 
2.39.1


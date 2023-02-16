Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86786699509
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 14:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjBPNAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 08:00:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjBPNAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 08:00:30 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C3443D098
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 05:00:29 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id AF7F166021A8;
        Thu, 16 Feb 2023 13:00:27 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676552428;
        bh=akKsNWR5T+Lv1H5lxALji7s6hzqhOq0hzyQywZA1KxE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cWy8JSqxDFC+vrCbBbLvJLBzpjUhLpwI000YFJ/nt88WfbpXed9qQQUGTfxOVquhK
         4bvLeXlyB6AUiZJcFJ9s4NyVDeqRa0H1hijpHGnYvqnu8LezJSNiTlpex96224zqI+
         MNdn9ak+BA/oBubolhXyc7MJlavl30TkstyMRYj4MNxl1yNUnyjBL8lwm3BAHn21gr
         HGIrbvlit/obWtnnzQ8kpmXH6FL0SAOjRxFDqc8/QBWVVxlUqaDUjpwy7RmOFMnAWZ
         lM5FbNih59+3d6iY/ZGVjD7fu0NSFybpgviQeTSdfhclSIV8L8IYIb/ikDf82/eF5d
         xextHCvrDFBSg==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     jason-jh.lin@mediatek.com, chunkuang.hu@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v1 2/9] soc: mediatek: mtk-mmsys: Use module_platform_driver() macro
Date:   Thu, 16 Feb 2023 14:00:14 +0100
Message-Id: <20230216130021.64875-3-angelogioacchino.delregno@collabora.com>
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

Instead of open-coding init/exit calls, switch to using the
module_platform_driver() macro instead, doing the exact same.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/soc/mediatek/mtk-mmsys.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-mmsys.c
index af22f3490034..1a574de9484d 100644
--- a/drivers/soc/mediatek/mtk-mmsys.c
+++ b/drivers/soc/mediatek/mtk-mmsys.c
@@ -447,19 +447,7 @@ static struct platform_driver mtk_mmsys_drv = {
 	.probe = mtk_mmsys_probe,
 	.remove = mtk_mmsys_remove,
 };
-
-static int __init mtk_mmsys_init(void)
-{
-	return platform_driver_register(&mtk_mmsys_drv);
-}
-
-static void __exit mtk_mmsys_exit(void)
-{
-	platform_driver_unregister(&mtk_mmsys_drv);
-}
-
-module_init(mtk_mmsys_init);
-module_exit(mtk_mmsys_exit);
+module_platform_driver(mtk_mmsys_drv);
 
 MODULE_AUTHOR("Yongqiang Niu <yongqiang.niu@mediatek.com>");
 MODULE_DESCRIPTION("MediaTek SoC MMSYS driver");
-- 
2.39.1


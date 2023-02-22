Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFB4569F21A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 10:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbjBVJrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 04:47:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbjBVJrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 04:47:00 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 666413CE0C
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 01:45:04 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0A8DF66021D0;
        Wed, 22 Feb 2023 09:43:03 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677058984;
        bh=W3yq5QP4VSIp5kuNHWkTn9ITtbb/6KY6TaV3sJDTiN4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Npvg6e4prXO4gcc0DXYI5ohzflUH1du/8pA8tgxw0rxzh7TEUPb/Ae2kzyj/FnwB0
         pI7Gf0c9ob4sKINxhGmpGLNp5kjZ37BUhg5DJotm8UQSdCS0ii31AqADnNYjF9Q5Ct
         4xvi9SLp6B6TsdEqUekc2lahepdB7W0MoyU1pD9wctvu0fRan/aCzstzGMay6L4vy+
         VSCHyosMm5d8LV2Ysa5PzmftGBdrftP3nU6Yfr6QzD6g6PUCKJMot4Ydaxf5ZFU2em
         6ivphDJBKG9cOir6/GMi8xtTdBB5d4aetKVZnITmc6M6Cyicq+vaBvbVQaNa+ZD+IA
         V0erBJYFq04Ug==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     jason-jh.lin@mediatek.com, chunkuang.hu@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chen-Yu Tsai <wenst@chromium.org>
Subject: [PATCH v2 7/9] soc: mediatek: mtk-mutex: Use module_platform_driver() macro
Date:   Wed, 22 Feb 2023 10:42:51 +0100
Message-Id: <20230222094253.23678-8-angelogioacchino.delregno@collabora.com>
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

Replace open-coded init/exit calls with the module_platform_driver()
macro being equivalent.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/soc/mediatek/mtk-mutex.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-mutex.c b/drivers/soc/mediatek/mtk-mutex.c
index b68bb87bc365..b106f3d23e0d 100644
--- a/drivers/soc/mediatek/mtk-mutex.c
+++ b/drivers/soc/mediatek/mtk-mutex.c
@@ -1067,19 +1067,7 @@ static struct platform_driver mtk_mutex_driver = {
 		.of_match_table = mutex_driver_dt_match,
 	},
 };
-
-static int __init mtk_mutex_init(void)
-{
-	return platform_driver_register(&mtk_mutex_driver);
-}
-
-static void __exit mtk_mutex_exit(void)
-{
-	platform_driver_unregister(&mtk_mutex_driver);
-}
-
-module_init(mtk_mutex_init);
-module_exit(mtk_mutex_exit);
+module_platform_driver(mtk_mutex_driver);
 
 MODULE_AUTHOR("Yongqiang Niu <yongqiang.niu@mediatek.com>");
 MODULE_DESCRIPTION("MediaTek SoC MUTEX driver");
-- 
2.39.2


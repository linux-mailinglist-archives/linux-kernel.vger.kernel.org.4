Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66B7B71F4E5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 23:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232786AbjFAVi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 17:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbjFAViX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 17:38:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F960E5C;
        Thu,  1 Jun 2023 14:37:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 344CB64A18;
        Thu,  1 Jun 2023 21:37:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75D65C433D2;
        Thu,  1 Jun 2023 21:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685655459;
        bh=cRNCWYgITY1Avwy3p/OqeMIYf76GSCIWeVOmp7qHdis=;
        h=From:To:Cc:Subject:Date:From;
        b=ExkIxw7gKOEphmOgoz9uN/SxJtg8mfaCbNEEeV3NwHCHLTipif8dod9mhyq567jrs
         h42rhezz0SUvFIpt5DbaYVzRRnz1Y7A3JFJwT8tcqfFTSorKTEBopguhPjnK2bV0Fa
         A2G6qCJ8QycLujMc/c3UPLbd82Qen9VnEjbDzYrZNIcG0NBK6x4hFXEWK/IQoxCJ5K
         NpHTjUtng2RwD524bRqnSh6zL1mZFcRkfo5dzxHYDdULEIUVqxX1Jv6JehPwTor7Av
         aHL6pNTAzgFm0YtRrU6WPOzPFIYiDo5kFQF+spcu4q+FMWsjtQ/HelhEOYefHFayJf
         Xgow79I4vUvWw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Bin Liu <bin.liu@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        irui wang <irui.wang@mediatek.com>,
        kyrie wu <kyrie.wu@mediatek.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        oushixiong <oushixiong@kylinos.cn>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH] [v2] media: mtk_jpeg_core: avoid unused-variable warning
Date:   Thu,  1 Jun 2023 23:37:22 +0200
Message-Id: <20230601213732.3625642-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The mtk8195_jpegenc_drvdata object was added outside of an #ifdef causing
a harmless build warning.

drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c:1879:32: error: 'mtk8195_jpegenc_drvdata' defined but not used [-Werror=unused-variable]
 1879 | static struct mtk_jpeg_variant mtk8195_jpegenc_drvdata = {
      |                                ^~~~~~~~~~~~~~~~~~~~~~~

A follow-up patch moved it inside of an #ifdef, which caused more
warnings, and a third patch ended up adding even more #ifdefs. These
were all bogus, since the actual problem here is the incorrect use
of of_ptr(). Since the driver (like any other modern platform driver)
only works in combination with CONFIG_OF, there is no point in hiding
the reference, so just remove that along with all the pointless #ifdef
checks in the driver.

This improves build coverage and avoids running into the same problem
again when another part of the driver gets changed that relies on
the #ifdef blocks to be completely matched.

Fixes: 934e8bccac95 ("mtk-jpegenc: support jpegenc multi-hardware")
Fixes: 4ae47770d57bf ("media: mtk-jpegenc: Fix a compilation issue")
Fixes: da4ede4b7fd6a ("media: mtk-jpeg: move data/code inside CONFIG_OF blocks")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c   | 6 +-----
 drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.c | 4 +---
 drivers/media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.c | 4 +---
 3 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
index 4768156181c99..40cb3cb87ba17 100644
--- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
+++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
@@ -28,7 +28,6 @@
 #include "mtk_jpeg_core.h"
 #include "mtk_jpeg_dec_parse.h"
 
-#if defined(CONFIG_OF)
 static struct mtk_jpeg_fmt mtk_jpeg_enc_formats[] = {
 	{
 		.fourcc		= V4L2_PIX_FMT_JPEG,
@@ -102,7 +101,6 @@ static struct mtk_jpeg_fmt mtk_jpeg_dec_formats[] = {
 		.flags		= MTK_JPEG_FMT_FLAG_CAPTURE,
 	},
 };
-#endif
 
 #define MTK_JPEG_ENC_NUM_FORMATS ARRAY_SIZE(mtk_jpeg_enc_formats)
 #define MTK_JPEG_DEC_NUM_FORMATS ARRAY_SIZE(mtk_jpeg_dec_formats)
@@ -1455,7 +1453,6 @@ static const struct dev_pm_ops mtk_jpeg_pm_ops = {
 	SET_RUNTIME_PM_OPS(mtk_jpeg_pm_suspend, mtk_jpeg_pm_resume, NULL)
 };
 
-#if defined(CONFIG_OF)
 static int mtk_jpegenc_get_hw(struct mtk_jpeg_ctx *ctx)
 {
 	struct mtk_jpegenc_comp_dev *comp_jpeg;
@@ -1951,14 +1948,13 @@ static const struct of_device_id mtk_jpeg_match[] = {
 };
 
 MODULE_DEVICE_TABLE(of, mtk_jpeg_match);
-#endif
 
 static struct platform_driver mtk_jpeg_driver = {
 	.probe = mtk_jpeg_probe,
 	.remove_new = mtk_jpeg_remove,
 	.driver = {
 		.name           = MTK_JPEG_NAME,
-		.of_match_table = of_match_ptr(mtk_jpeg_match),
+		.of_match_table = mtk_jpeg_match,
 		.pm             = &mtk_jpeg_pm_ops,
 	},
 };
diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.c b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.c
index 869068fac5e2f..baa7be58ce691 100644
--- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.c
+++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.c
@@ -39,7 +39,6 @@ enum mtk_jpeg_color {
 	MTK_JPEG_COLOR_400		= 0x00110000
 };
 
-#if defined(CONFIG_OF)
 static const struct of_device_id mtk_jpegdec_hw_ids[] = {
 	{
 		.compatible = "mediatek,mt8195-jpgdec-hw",
@@ -47,7 +46,6 @@ static const struct of_device_id mtk_jpegdec_hw_ids[] = {
 	{},
 };
 MODULE_DEVICE_TABLE(of, mtk_jpegdec_hw_ids);
-#endif
 
 static inline int mtk_jpeg_verify_align(u32 val, int align, u32 reg)
 {
@@ -653,7 +651,7 @@ static struct platform_driver mtk_jpegdec_hw_driver = {
 	.probe = mtk_jpegdec_hw_probe,
 	.driver = {
 		.name = "mtk-jpegdec-hw",
-		.of_match_table = of_match_ptr(mtk_jpegdec_hw_ids),
+		.of_match_table = mtk_jpegdec_hw_ids,
 	},
 };
 
diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.c b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.c
index 71e85b4bbf127..244018365b6f1 100644
--- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.c
+++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.c
@@ -46,7 +46,6 @@ static const struct mtk_jpeg_enc_qlt mtk_jpeg_enc_quality[] = {
 	{.quality_param = 97, .hardware_value = JPEG_ENC_QUALITY_Q97},
 };
 
-#if defined(CONFIG_OF)
 static const struct of_device_id mtk_jpegenc_drv_ids[] = {
 	{
 		.compatible = "mediatek,mt8195-jpgenc-hw",
@@ -54,7 +53,6 @@ static const struct of_device_id mtk_jpegenc_drv_ids[] = {
 	{},
 };
 MODULE_DEVICE_TABLE(of, mtk_jpegenc_drv_ids);
-#endif
 
 void mtk_jpeg_enc_reset(void __iomem *base)
 {
@@ -377,7 +375,7 @@ static struct platform_driver mtk_jpegenc_hw_driver = {
 	.probe = mtk_jpegenc_hw_probe,
 	.driver = {
 		.name = "mtk-jpegenc-hw",
-		.of_match_table = of_match_ptr(mtk_jpegenc_drv_ids),
+		.of_match_table = mtk_jpegenc_drv_ids,
 	},
 };
 
-- 
2.39.2


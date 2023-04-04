Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF5886D6A79
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 19:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236233AbjDDRYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 13:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236053AbjDDRXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 13:23:33 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D26B1BD7
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 10:23:01 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id w9so133613095edc.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 10:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680628981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r2gzNYH0bDm6Lr5uWKUQ2JJneYTqX0cquEENMFQ0oyw=;
        b=pdovZsCvQkj/BU+GdCyoZR9xp1bPhRdY/zAn1or4ah3BAI95CegkoVB/dhweLJDc7t
         /6BOtc0hHBHLvTQtonHneVYbUc1jqU4YD7+CXLtvGPRAuCGxPZEgyGBM60F2/VahZ8gM
         GQvnqls4EwSJeRvNqOtzOwJ60iey6LLzonBLv7avBFgo/ytO3Sfvh4MHQHHCQCrnfwE4
         9noskJuIrzoZNudbdW1eXW7BTeEFZN7drXE3Y0PwxWgTKPg++Qh9j1jCc8P9nIJwXQGY
         6FfBQoxG8lUgph2yFlfd84C+6HbS8FONtHDcOUSh7BC0GNRGbVIKDASrD9OGQ9sbhzKC
         zxcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680628981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r2gzNYH0bDm6Lr5uWKUQ2JJneYTqX0cquEENMFQ0oyw=;
        b=mCKB540xivn12lQAWCAud72Fq86Y9U/KI2nR4aMe3dEAYeITndV26us86QxbOk4rVx
         FScKYgM41vqxyTqcYXY+k7z2nwnFgIN8aAYLqzYVgrHWRmBsvzEU1fqZBJno9JIUMIfE
         iWPerLEinVgKq52oUn5VMqEA9wbIz7+tRs3S7E4Vm+06qDmM97LjKIIToHET5kTZJen5
         Cg1tGGBgpx8wRRI5U5gD8AQYbTyaM/hmN8yDaA5bSi7kl+S2Cc3FQP4dAqgUdmQcuWKN
         VN/wF5OuMxJKme3/kyw65k9jOe6NTxho7Kl6O6qc69IlAliUzxF+zDis9zrn3EbOR1FK
         VDHQ==
X-Gm-Message-State: AAQBX9eCed41VS/llPQT4zLA/FqkX02/DTkiiC5Ct2U+GnppxBUgzy8m
        laeCWgyjGRX+qYXqvLAs3WuDJYJwonOOHrvmzUI=
X-Google-Smtp-Source: AKy350a8IeRBjVAtCFBu0Sg2wexxjjzdpCKgnLLaUTZwYjDjYRGBgjNvmJNdIpryp9/mHMHLIOiHIQ==
X-Received: by 2002:a17:906:a414:b0:905:a46b:a725 with SMTP id l20-20020a170906a41400b00905a46ba725mr48404ejz.16.1680628980848;
        Tue, 04 Apr 2023 10:23:00 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id bv20-20020a170906b1d400b009447277c2aasm6208333ejb.39.2023.04.04.10.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 10:23:00 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 27/40] nvmem: mtk-efuse: Support postprocessing for GPU speed binning data
Date:   Tue,  4 Apr 2023 18:21:35 +0100
Message-Id: <20230404172148.82422-28-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230404172148.82422-1-srinivas.kandagatla@linaro.org>
References: <20230404172148.82422-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

On some MediaTek SoCs GPU speed binning data is available for read
in the SoC's eFuse array but it has a format that is incompatible
with what the OPP API expects, as we read a number from 0 to 7 but
opp-supported-hw is expecting a bitmask to enable an OPP entry:
being what we read limited to 0-7, it's straightforward to simply
convert the value to BIT(value) as a post-processing action.

So, introduce post-processing support and enable it by evaluating
the newly introduced platform data's `uses_post_processing` member,
currently enabled only for MT8186.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/mtk-efuse.c | 53 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 51 insertions(+), 2 deletions(-)

diff --git a/drivers/nvmem/mtk-efuse.c b/drivers/nvmem/mtk-efuse.c
index a08e0aedd21c..b36cd0dcc8c7 100644
--- a/drivers/nvmem/mtk-efuse.c
+++ b/drivers/nvmem/mtk-efuse.c
@@ -10,6 +10,11 @@
 #include <linux/io.h>
 #include <linux/nvmem-provider.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
+
+struct mtk_efuse_pdata {
+	bool uses_post_processing;
+};
 
 struct mtk_efuse_priv {
 	void __iomem *base;
@@ -29,6 +34,37 @@ static int mtk_reg_read(void *context,
 	return 0;
 }
 
+static int mtk_efuse_gpu_speedbin_pp(void *context, const char *id, int index,
+				     unsigned int offset, void *data, size_t bytes)
+{
+	u8 *val = data;
+
+	if (val[0] < 8)
+		val[0] = BIT(val[0]);
+
+	return 0;
+}
+
+static void mtk_efuse_fixup_cell_info(struct nvmem_device *nvmem,
+				      struct nvmem_layout *layout,
+				      struct nvmem_cell_info *cell)
+{
+	size_t sz = strlen(cell->name);
+
+	/*
+	 * On some SoCs, the GPU speedbin is not read as bitmask but as
+	 * a number with range [0-7] (max 3 bits): post process to use
+	 * it in OPP tables to describe supported-hw.
+	 */
+	if (cell->nbits <= 3 &&
+	    strncmp(cell->name, "gpu-speedbin", min(sz, strlen("gpu-speedbin"))) == 0)
+		cell->read_post_process = mtk_efuse_gpu_speedbin_pp;
+}
+
+static struct nvmem_layout mtk_efuse_layout = {
+	.fixup_cell_info = mtk_efuse_fixup_cell_info,
+};
+
 static int mtk_efuse_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -36,6 +72,7 @@ static int mtk_efuse_probe(struct platform_device *pdev)
 	struct nvmem_device *nvmem;
 	struct nvmem_config econfig = {};
 	struct mtk_efuse_priv *priv;
+	const struct mtk_efuse_pdata *pdata;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -45,20 +82,32 @@ static int mtk_efuse_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->base))
 		return PTR_ERR(priv->base);
 
+	pdata = device_get_match_data(dev);
 	econfig.stride = 1;
 	econfig.word_size = 1;
 	econfig.reg_read = mtk_reg_read;
 	econfig.size = resource_size(res);
 	econfig.priv = priv;
 	econfig.dev = dev;
+	if (pdata->uses_post_processing)
+		econfig.layout = &mtk_efuse_layout;
 	nvmem = devm_nvmem_register(dev, &econfig);
 
 	return PTR_ERR_OR_ZERO(nvmem);
 }
 
+static const struct mtk_efuse_pdata mtk_mt8186_efuse_pdata = {
+	.uses_post_processing = true,
+};
+
+static const struct mtk_efuse_pdata mtk_efuse_pdata = {
+	.uses_post_processing = false,
+};
+
 static const struct of_device_id mtk_efuse_of_match[] = {
-	{ .compatible = "mediatek,mt8173-efuse",},
-	{ .compatible = "mediatek,efuse",},
+	{ .compatible = "mediatek,mt8173-efuse", .data = &mtk_efuse_pdata },
+	{ .compatible = "mediatek,mt8186-efuse", .data = &mtk_mt8186_efuse_pdata },
+	{ .compatible = "mediatek,efuse", .data = &mtk_efuse_pdata },
 	{/* sentinel */},
 };
 MODULE_DEVICE_TABLE(of, mtk_efuse_of_match);
-- 
2.25.1


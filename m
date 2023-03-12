Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA956B6665
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 14:15:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbjCLNPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 09:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjCLNOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 09:14:50 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC20A2412D
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 06:14:03 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id x3so38435411edb.10
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 06:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678626843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z7zCiKznvtISJjaLkQGP6+7WjJ33gWstbauf9XZGz6U=;
        b=hkgeQTl7kiZH/3Q54ASwYRPqBYEKm9l2FvNF4N6ujUzpjYBOHSlr9uaGtfsFgk5dUy
         Lf7kyZH3h1JJOZsT/VqnMhAwIr9habC6FILxMvlJg+5lDE8Gm8v9LoOiSX0AgLvzYOXV
         D1eMF/v8xIRnSfqePFrzRlbuWXhKfLcsc5BxUvRxpTQsE40ns4iU8iLxwlkwixvZdt1i
         plgBO2DlKmx7mC/7hZlCbT6NpXJAd3vc/duYJ32+zVYAhmGzyshA+m/npMOTDXiqIciY
         cqtNGAb85Dl+16dZ0hHPIPDKjL/nPIK6PpZ9XRG6VOw8dR+hyXC1DPyCGKqcyAUvnNbP
         D7MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678626843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z7zCiKznvtISJjaLkQGP6+7WjJ33gWstbauf9XZGz6U=;
        b=ibikctfxw64/Fmx2xstAj5WHE8pzPg1DOR6KEwcF5pXJMQrjDZkyH+I6uly1NV0QzF
         GqK2mpP8ASrO4DicGVaGAm32RWZJXK8BEThRHfG5jn350wrcj5aHfqjoF5YOM39qFKVS
         mPKP9uv0WklSQydtVsIubiou+ncxI3SJgvx+wsw+68OLtDLs5LV8cK5sA3Xd3pMGNmWd
         oS/xyEuBgJxU/pjiSFPX5cn5r6b3kiGDpssFoxUag8NWDVPzIxddUPumP0Rme8aGLMrW
         TyKlfGdmhVTyQavL5wqLSiDZLu+ZpoUrLh6kQlkRTTCpoT1hfWubfSerQPDIEnFBSN2U
         7i9A==
X-Gm-Message-State: AO0yUKXENKau4jxpDTknKs6wGTOJW4Mv0HqDWwN+DcGy8kEgCH5bDBPV
        FTJx2LhLYn+skLKkmMJYjkBtQg==
X-Google-Smtp-Source: AK7set9rwzHv7NjHz3Ld8t1U7IlpFCFMC7/C2h9WMvqIP99asEQnOhRylPIAm1sXrRZyif38WBVBkg==
X-Received: by 2002:a17:906:855:b0:921:c122:52a7 with SMTP id f21-20020a170906085500b00921c12252a7mr4317759ejd.22.1678626843141;
        Sun, 12 Mar 2023 06:14:03 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:d9f6:3e61:beeb:295a])
        by smtp.gmail.com with ESMTPSA id r19-20020a1709067fd300b008eddbd46d7esm2213279ejs.31.2023.03.12.06.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 06:14:02 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Joe Tessler <jrt@google.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Michael Tretter <m.tretter@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Wenyou Yang <wenyou.yang@microchip.com>,
        Bin Liu <bin.liu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Minghsiu Tsai <minghsiu.tsai@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Yong Deng <yong.deng@magewell.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sean Young <sean@mess.org>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-rockchip@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 20/28] media: platform: jpeg: always reference OF data
Date:   Sun, 12 Mar 2023 14:13:10 +0100
Message-Id: <20230312131318.351173-20-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230312131318.351173-1-krzysztof.kozlowski@linaro.org>
References: <20230312131318.351173-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver can match only via the DT table so the table should be always
used and the of_match_ptr does not have any sense (this also allows ACPI
matching via PRP0001, even though it might not be relevant here).  This
also fixes !CONFIG_OF error:

  drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c:1890:38: error: ‘mtk8195_jpegdec_drvdata’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
index 969516a940ba..bd12e73492e5 100644
--- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
+++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
@@ -1898,7 +1898,6 @@ static const struct mtk_jpeg_variant mtk8195_jpegdec_drvdata = {
 	.cap_q_default_fourcc = V4L2_PIX_FMT_YUV420M,
 };
 
-#if defined(CONFIG_OF)
 static const struct of_device_id mtk_jpeg_match[] = {
 	{
 		.compatible = "mediatek,mt8173-jpgdec",
@@ -1924,14 +1923,13 @@ static const struct of_device_id mtk_jpeg_match[] = {
 };
 
 MODULE_DEVICE_TABLE(of, mtk_jpeg_match);
-#endif
 
 static struct platform_driver mtk_jpeg_driver = {
 	.probe = mtk_jpeg_probe,
 	.remove = mtk_jpeg_remove,
 	.driver = {
 		.name           = MTK_JPEG_NAME,
-		.of_match_table = of_match_ptr(mtk_jpeg_match),
+		.of_match_table = mtk_jpeg_match,
 		.pm             = &mtk_jpeg_pm_ops,
 	},
 };
-- 
2.34.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEFDE6165E5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 16:18:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbiKBPSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 11:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbiKBPSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 11:18:18 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E97E20997
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 08:18:16 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id o4so25049486wrq.6
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 08:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T9e18AuOzDnWHjh6xr+jQAEK5xQcjVqynS6u486cJkU=;
        b=vVrjNop7hjPDib3wv1ot+HsH3VyGY3cb14mf3za4DKjEZmUbSC2uxLrZbr9QnoCHIu
         H5/e2OqFLFx7fZkBeLMA/uQdUWoNIURrEKKCt52vEpTGslev/6AHfGyDdH6Xw00LZfAg
         xm48kYROY6HxVm/Z8NRksM6sxlqr1ajMCnMD9W/j/StqwddMDD1fomQALLVGYcL5Y5jG
         S0FCj+Aiqu+7h2ZpCXDkrzX6H1bLjZwnOcSwHRODkxDKNvivnbIhWku2tiTBb1p4VZg8
         0noIDWAH+red8jcQl3qJxEQ1NLTvQBBtk0t431y/RiB7OiE3vYU4m+zt5DQK8o2lu0W7
         G9mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T9e18AuOzDnWHjh6xr+jQAEK5xQcjVqynS6u486cJkU=;
        b=weDgVwlEVxaYuWto5yOt9diIUuSb9MKaXpMAMz/bp9vg5sI7Jq3dCd2eXdqM+PIjhw
         ssKJtqP52odH+FejrVgKMrpsEA6sDoyCjAVwGDU7usP8EYGYUkawOT4osGdh+FJgi6ea
         bhRNmPUs3H90IoIngwaw/xAkfqXkEKntg20cUes6KGuOw6ZUSy450bJHbU+7DpXo8aWf
         tyV6WTfs50OoBtpHH3pO6ndKkEQlANpCdXqVSCzs5GpB3InUCvysN36skSWIT0Fsbwbp
         6IXapcBw3jpfw5Qb7YjwMboPrOGt5Zzop1mTZdVks6XyZPHvI7aLvREJFI8G11apDkWf
         9YVQ==
X-Gm-Message-State: ACrzQf3IOgDIKBMhoPieh68LLH6CXFS1hJ5uhnBFGBDQ2yceCSavSmfo
        jVcLLRY3NOX+29vr1tF3wjPoEQ==
X-Google-Smtp-Source: AMsMyM6o4omJsNxu8orKzfd9naeNFZCxwtIS7R+A+z31p3n+znaJYmIV7aHiK1qWp4qPwRtqSSxMKQ==
X-Received: by 2002:a5d:5967:0:b0:236:bd27:f1b8 with SMTP id e39-20020a5d5967000000b00236bd27f1b8mr13149257wri.390.1667402294756;
        Wed, 02 Nov 2022 08:18:14 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id bq13-20020a5d5a0d000000b002365921c9aesm13332818wrb.77.2022.11.02.08.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 08:18:14 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Wed, 02 Nov 2022 16:18:09 +0100
Subject: [PATCH v6 3/3] iommu/mediatek: add support for MT8365 SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221001-iommu-support-v6-3-be4fe8da254b@baylibre.com>
References: <20221001-iommu-support-v6-0-be4fe8da254b@baylibre.com>
In-Reply-To: <20221001-iommu-support-v6-0-be4fe8da254b@baylibre.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>, Yong Wu <yong.wu@mediatek.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Mergnat <amergnat@baylibre.com>,
        iommu@lists.linux.dev, linux-mediatek@lists.infradead.org,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        Fabien Parent <fparent@baylibre.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.10.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2006; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=Q4NYYQifFh9zAugrVsdD24zlf7qYZx8w4pW2A66Dgc4=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBjYooyAnt/3uDKzQTl89xfXRYOhl4D1bU+Q7od77hw
 ErFRlkKJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCY2KKMgAKCRArRkmdfjHURUUFD/
 93Y7hT8/4BU2SdrJ0KdhJzQYPpku8B/wTpGm45+uiAJV6r77tTcgbr7cZSyBAy+xZY+qRMrPGUBVqU
 Ajk7HHfEUF/WzcXIHzB6KHGSf9c+3D+rNDm6yBs9CXUg0xfe0jkc81bUSf/+aC6XtdBECiWrNn70Xv
 z5QtntaQBOINOB63LBBI96uXqH0grV99uYxelModQWaNKjnnyBzEdHxp8ey/RqZ0oQfTDV7oFTgjA7
 otXN+ux0mGGPdZ8oBe/GvEX7L5kok0LuiJZcKejE4YliRSfIv38O7OauoXtk1LSHQs91f/ddL+dRQ/
 D/6p8qf/2vv/21M10jkcf8Vk4zfQDIEnzYEFFVeBl9/nvHmPrT2oszCCkzDs0hPP+zvuvmkZIgY4CI
 OmxgXt/hKzfsvct9x2WMTlzCxfeeVIxdCJA2d085AYXb6LA6Y71MFI4I9mcLrMqxo1v4+vhdbJPpOQ
 nY62Wdcvc1qqNbkJy+SJeKRq5wGQNEItSFfJ6+zZgY8aXAKh/1KIkUZhzpAHk7yY9THS1T/eoTjH/z
 5M0Trb/g65/NJvhAz1Qyl8HK/QEaIFN/SNGss5FWTgsbx0b8C8HXFFpcQFm9qXM2DGFncyqqxx1QCp
 5n+o0IQHkJLe15tSnQyvryaHLrSaEv3uepvuEH7vMOAwwx+nTTeoRryGDb0g==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabien Parent <fparent@baylibre.com>

Add IOMMU support for MT8365 SoC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
Reviewed-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
Tested-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Yong Wu <yong.wu@mediatek.com>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 drivers/iommu/mtk_iommu.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 563e3c54a0e2..aff7a9190749 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -170,6 +170,7 @@ enum mtk_iommu_plat {
 	M4U_MT8186,
 	M4U_MT8192,
 	M4U_MT8195,
+	M4U_MT8365,
 };
 
 struct mtk_iommu_iova_region {
@@ -1525,6 +1526,17 @@ static const struct mtk_iommu_plat_data mt8195_data_vpp = {
 			   {4, MTK_INVALID_LARBID, MTK_INVALID_LARBID, MTK_INVALID_LARBID, 6}},
 };
 
+static const struct mtk_iommu_plat_data mt8365_data = {
+	.m4u_plat	= M4U_MT8365,
+	.flags		= RESET_AXI | INT_ID_PORT_WIDTH_6,
+	.inv_sel_reg	= REG_MMU_INV_SEL_GEN1,
+	.banks_num	= 1,
+	.banks_enable	= {true},
+	.iova_region	= single_domain,
+	.iova_region_nr	= ARRAY_SIZE(single_domain),
+	.larbid_remap	= {{0}, {1}, {2}, {3}, {4}, {5}}, /* Linear mapping. */
+};
+
 static const struct of_device_id mtk_iommu_of_ids[] = {
 	{ .compatible = "mediatek,mt2712-m4u", .data = &mt2712_data},
 	{ .compatible = "mediatek,mt6779-m4u", .data = &mt6779_data},
@@ -1537,6 +1549,7 @@ static const struct of_device_id mtk_iommu_of_ids[] = {
 	{ .compatible = "mediatek,mt8195-iommu-infra", .data = &mt8195_data_infra},
 	{ .compatible = "mediatek,mt8195-iommu-vdo",   .data = &mt8195_data_vdo},
 	{ .compatible = "mediatek,mt8195-iommu-vpp",   .data = &mt8195_data_vpp},
+	{ .compatible = "mediatek,mt8365-m4u", .data = &mt8365_data},
 	{}
 };
 

-- 
b4 0.10.1

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58FFA5F9EEF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 14:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbiJJMyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 08:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbiJJMyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 08:54:22 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4ABE6BCEB
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 05:54:21 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id bv10so13339535wrb.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 05:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vZ4L3eGmqKYAclKSwyEel3UxVWUej6QJpYaCconox5E=;
        b=rgdAIwlkpvnub0RaiX4fefvk5wCulG8vp0BP+WcJrCUzbBspaWp2GtmBMF2ij7UeLB
         Vp5SkCMp1ZSqvsLBcT4POcX4auHkHhOq7FB0ywft1Pa/l7hKPZ+xAzRMLY6gPjWTVmA8
         xg6qQ+G78hQntai3/+GlX8xjMlTDLggQNzZLhq/MikBC1eNglLYCGniTx9YWcfTmpEMI
         BnWGwWk0ysejp7Jm80d3IzfhR6Sa65sJSw+Ed18KeOvxIf+WX0CQS4j0RsvYxNFruZXH
         IrLWWQz5qw+moFKHLqvUzIyQ636wdqjcZ/l4qvx0+BS5yg6A1E/UbL96D6wQaMYh7aSC
         CN8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vZ4L3eGmqKYAclKSwyEel3UxVWUej6QJpYaCconox5E=;
        b=W2VN95UXVablIgEtboC2PQgBEfwMbMsqCE+kFa2oIaTrG/CZIPkIRSCWnQW5jRzOkV
         TOo2kZHYZguf8Zy4KzL6FkfikQ6B4majljKOo6f3JGlaAydso7pfGduDNGI1pC6k/xPM
         xG7fIKkRRWGeDanTfG91H3C77kF5l7ZAnH+vg2n/UC48vcj/G92sRaa56DVLuRCFksXh
         crx3WIv4xzFIMfLGHS/5hKd0R83IcOOy9a/dqu4AMug/MWFpHzhiSCnX2L7x2etvESXH
         OylZaaUq0kMuA+sOi9zvcMgdmusbWi2KE2qGk5qGmzj/2XAc0zKWcRdVelQ9KU/jOmFi
         o5TQ==
X-Gm-Message-State: ACrzQf3S33HN9A7iiCvqa1PWZF5JGPYvU2uokIuvlL/lj2ij/rOtKE54
        puxl0iYrrEZ51Rd/JuvvJ5BFRg==
X-Google-Smtp-Source: AMsMyM6jeFIQqxlWum39mAdlhTnkevmmnxlbs7XGdKPUqz8uSEIoAoVBL7h0xE0OUAXWWR6OqM8iUQ==
X-Received: by 2002:a5d:674f:0:b0:22e:3d59:cf0f with SMTP id l15-20020a5d674f000000b0022e3d59cf0fmr11451686wrw.304.1665406459794;
        Mon, 10 Oct 2022 05:54:19 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id v24-20020a1cf718000000b003a6125562e1sm9767020wmh.46.2022.10.10.05.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 05:54:19 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Mon, 10 Oct 2022 14:54:09 +0200
Subject: [PATCH v3 3/3] iommu/mediatek: add support for MT8365 SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221001-iommu-support-v3-3-c7b3059b0d16@baylibre.com>
References: <20221001-iommu-support-v3-0-c7b3059b0d16@baylibre.com>
In-Reply-To: <20221001-iommu-support-v3-0-c7b3059b0d16@baylibre.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Will Deacon <will@kernel.org>, Yong Wu <yong.wu@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     iommu@lists.linux.dev,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Fabien Parent <fparent@baylibre.com>,
        Alexandre Mergnat <amergnat@baylibre.com>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        linux-mediatek@lists.infradead.org
X-Mailer: b4 0.10.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1965; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=cCyHI5RY2bhm2xuqZZiDh/1knZLz2wwqAtcDhxPnQwM=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBjRBX2YK800J3vnj2EsuGIXwS9BVe1DVrvkohAErig
 dhZktjuJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCY0QV9gAKCRArRkmdfjHURe/sEA
 CqnQVlGZAtTO0mYLapEecmZMAnuNd/teKEJA8sNJsOZRnbBG0YUkf6TAt8LhIl+iuHeAM2CKth1FHx
 CJ1Zq4fdOAHjzYHc4z2qtkH0lhTGqqFv5xqz6NLWf8w8/MzplFOiyTlSAPJY7Ombcs6ZCoZiF4fSOh
 7NfKlgQbESF62kYa1+JVBHZCnFljcMVtJpDL+BrtJd+ec9G+tU0sg1O/ojEyr1NgmJI3c41HVBIm06
 MG6HmMXV0m2uCkj+bxbbhN4qrAaX/ZkmC5YKk349IxlG9/Rp2F4jpl0FD3HRC7WUCH2lhvFSKNLROj
 7uVkGx5NeZv2/xjKLaoJzUfy4ylMkNxaJDSXI5TLFwl0R/DbY6JAyluQ+/SAp88dLQpnTLVcv2CL1S
 ov1LgNIq5KsSfhhSj9CknfVJ1PS5X5xNtwtEvPc0E8LvvUDmOuY5I/q6TMOYEi/kA4j6cBJ5eYbRNX
 6JowXJLr7o9SRuqEgWmMacKQnsNwpE40pJqfNLJFhYESCIrvQwZ9TwCLXLgkSFJqW7YFYqiwXyael9
 FZ9jPNXcb090aJKlNKujeQw2Y0jBzRRMcBjLpuq4NzAVJCHnY14IJ/EGK2O1drZr2k7KavWCBOC2VQ
 s4I8rbJJE4AmsYYN8WMAOJKWU+x7cSujgWPZs0VBausgpWGQrlaoQkCjRawg==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 drivers/iommu/mtk_iommu.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 35e9731c3441..50ee1f833c2b 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -170,6 +170,7 @@ enum mtk_iommu_plat {
 	M4U_MT8186,
 	M4U_MT8192,
 	M4U_MT8195,
+	M4U_MT8365,
 };
 
 struct mtk_iommu_iova_region {
@@ -1528,6 +1529,17 @@ static const struct mtk_iommu_plat_data mt8195_data_vpp = {
 			   {4, MTK_INVALID_LARBID, MTK_INVALID_LARBID, MTK_INVALID_LARBID, 6}},
 };
 
+static const struct mtk_iommu_plat_data mt8365_data = {
+	.m4u_plat	= M4U_MT8365,
+	.flags		= RESET_AXI | HAS_INT_ID_PORT_WIDTH_6,
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
@@ -1540,6 +1552,7 @@ static const struct of_device_id mtk_iommu_of_ids[] = {
 	{ .compatible = "mediatek,mt8195-iommu-infra", .data = &mt8195_data_infra},
 	{ .compatible = "mediatek,mt8195-iommu-vdo",   .data = &mt8195_data_vdo},
 	{ .compatible = "mediatek,mt8195-iommu-vpp",   .data = &mt8195_data_vpp},
+	{ .compatible = "mediatek,mt8365-m4u", .data = &mt8365_data},
 	{}
 };
 

-- 
b4 0.10.1

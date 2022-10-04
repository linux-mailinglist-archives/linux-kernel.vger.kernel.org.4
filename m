Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E74C5F4081
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 12:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbiJDKCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 06:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbiJDKBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 06:01:55 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA4522B0D
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 03:01:54 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id ay7-20020a05600c1e0700b003b49861bf48so619522wmb.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 03:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date;
        bh=UCHhyl70uAm4FbUL9mwyr19eGZ4dPDjyDFd/jrFReLo=;
        b=fh3UfVbpdDeet/1XCkYWjg2/E4PiuHeDTJQd2hoe+94nACRvwOpOjzXKKpG/SdugwH
         kS81FUAqWb2I9Qv3zxN8iikHgCoUOxow06tYiAaYLyANwhWMQe/QSbp2sjqfUp+dFP7O
         ri/R1rLhuvBRfmfYzEklHSn9Vsa4RJtdARStFddh2SYBG9kRosE6C18fcVyegbFSh7E/
         nogpSKVd7v/BtGxISWOIZPJA/oRTQeTTRj3a/wJWVCjOVNTdjPUeWQT8Xy1zPxum1tPp
         b2+s8gVMbL4+tgazq0nE0Hh5QnNepHSbi4+cylfEr1Ykbn9+bfdh/UdWdGWkj8eSPOd7
         qimg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=UCHhyl70uAm4FbUL9mwyr19eGZ4dPDjyDFd/jrFReLo=;
        b=eSLSG5OlvehAMpwgvnRv71L8n6+eY9ObzYi2GT9+UZuAhaCP0mYF3JQbeAB4dCXO8Y
         IvgNvtH2of6iv+SloDwWuyjSpTdsq9ROg4chmwAuGT0YMYhCRYaJViVj8T7cvm/gkht1
         NL9tSwguMF3LDoHtqK3BDDsLQQjmkpCk8feqPXb2sv7ztBOLEz+dtxROs8QsRNSNSwwu
         Mnio488ilSaQ+6mVDFNHyfQscQgpn9rR8UIJa00DPN+rXdOM93TbJto9IShYGg90G6XW
         bY47ponr9Hurj1ZsOGZl/n37KSPEqn/JJaEFwvEWGDQMjwLrsNb9GCAQ9Oj1ds6oYNTb
         szTw==
X-Gm-Message-State: ACrzQf0HRvNFqKIas6pC1U+YcAyQhaQ1O6LB3boQhliJqYvbHUZg2dRi
        o/LIq8y+FmS3gm2EWGQ2/dwp2w==
X-Google-Smtp-Source: AMsMyM7yAfzXC1KQcXOqONXs26gOwP9cvOo+9AGcMS4RfHc3wJ2L1C3VSCFQa/HL28Dt92Xi5bmQtQ==
X-Received: by 2002:a05:600c:4fd1:b0:3b4:c00d:230a with SMTP id o17-20020a05600c4fd100b003b4c00d230amr9327609wmq.62.1664877712628;
        Tue, 04 Oct 2022 03:01:52 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id d3-20020a5d6dc3000000b0022e3cba367fsm5473645wrz.100.2022.10.04.03.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 03:01:52 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Tue, 04 Oct 2022 12:01:41 +0200
Subject: [PATCH v2 3/3] iommu/mediatek: add support for MT8365 SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221001-iommu-support-v2-3-dbfef2eeebc9@baylibre.com>
References: <20221001-iommu-support-v2-0-dbfef2eeebc9@baylibre.com>
In-Reply-To: <20221001-iommu-support-v2-0-dbfef2eeebc9@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>, Yong Wu <yong.wu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Alexandre Mergnat <amergnat@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Fabien Parent <fparent@baylibre.com>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        devicetree@vger.kernel.org, iommu@lists.linux.dev
X-Mailer: b4 0.10.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1834; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=gxfKtOcvwaqvfxbBFQC1V9d4zYH8j2MMwYTDkwSvA64=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBjPASL1Deu6Z2zUrYCapL6mHfzitqM2lCpSojrm1ZA
 FReZPU+JAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCYzwEiwAKCRArRkmdfjHURZUGD/
 9O7uNTCvNAEKKImI7SsasH1T+l0x/ce701ne1kIqklNfeP/U44HmutCEmxEUnam83dDuM8705t9l1T
 nFpn8NIAvLZ+pxn1+UuBHimCFs8R+CzPaMBQbeX9moANniY0a8UjHDwr1BrTfxyJeooP9nnwatyqwh
 YK1X2Kdzv0sv4QLz3vdC8DUBjDD4/82gDc4qfN3mQmsbneZR4NU8BMXd+NNoP0p6voRIvVoj9KEibU
 4l+6w+WPpLziPQPUhLYNs/WsDOWrg67S/pU/AhSgXYKoAm6/SnasDMc4M0AndwCVnnVAkYR9nqBB38
 iDeeZKXzPp27BFvkUi07tkywwGknAG7Io7byvmyP28wDWoDvJGWsV4vY6kMdBMumxa4RbyjyIm63vR
 6lo2acvS6CRUkx9QtWWsCQDhItHwqKUec5Hia2xidfFEmWy1j42jdBm29FHJXLOewfXNz1lga+bjsK
 7aX2h7ZevTDEq+1k1nD9YuFYTRcXFiTGVgkPO0qDPH+6HIfMv7+u593LPpef/AQRk+86zUDnFPDvOj
 MG+en9irRvaumGU+vnwdhEGhaz2iRfxpTN7oZoeSbyZE1DGfSmsEjkkNP3tZZbGXplI8yq1bMMdF5/
 U+TAiTFa4DRPmXssdkT/K3LORzI2RN1rctlJabAVBHirP3hQp1lamp91EWBA==
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
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 drivers/iommu/mtk_iommu.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index a57ce509c8b5..ce8c9660208e 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -167,6 +167,7 @@ enum mtk_iommu_plat {
 	M4U_MT8186,
 	M4U_MT8192,
 	M4U_MT8195,
+	M4U_MT8365,
 };
 
 struct mtk_iommu_iova_region {
@@ -1531,6 +1532,18 @@ static const struct mtk_iommu_plat_data mt8195_data_vpp = {
 	.int_id_port_width = 5,
 };
 
+static const struct mtk_iommu_plat_data mt8365_data = {
+	.m4u_plat	= M4U_MT8365,
+	.flags		= RESET_AXI,
+	.inv_sel_reg	= REG_MMU_INV_SEL_GEN1,
+	.banks_num	= 1,
+	.banks_enable	= {true},
+	.iova_region	= single_domain,
+	.iova_region_nr	= ARRAY_SIZE(single_domain),
+	.larbid_remap	= {{0}, {1}, {2}, {3}, {4}, {5}}, /* Linear mapping. */
+	.int_id_port_width = 6,
+};
+
 static const struct of_device_id mtk_iommu_of_ids[] = {
 	{ .compatible = "mediatek,mt2712-m4u", .data = &mt2712_data},
 	{ .compatible = "mediatek,mt6779-m4u", .data = &mt6779_data},
@@ -1543,6 +1556,7 @@ static const struct of_device_id mtk_iommu_of_ids[] = {
 	{ .compatible = "mediatek,mt8195-iommu-infra", .data = &mt8195_data_infra},
 	{ .compatible = "mediatek,mt8195-iommu-vdo",   .data = &mt8195_data_vdo},
 	{ .compatible = "mediatek,mt8195-iommu-vpp",   .data = &mt8195_data_vpp},
+	{ .compatible = "mediatek,mt8365-m4u", .data = &mt8365_data},
 	{}
 };
 

-- 
b4 0.10.1

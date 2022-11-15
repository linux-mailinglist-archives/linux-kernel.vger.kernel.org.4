Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 057CB62956F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 11:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238330AbiKOKMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 05:12:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238296AbiKOKLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 05:11:42 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 983C9F3E;
        Tue, 15 Nov 2022 02:11:41 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 751E66602980;
        Tue, 15 Nov 2022 10:11:39 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1668507100;
        bh=nr11OW0GjXZZd+uqu9pF2DuJ8K92kyYL5cWgAQ18zqQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kKPZyci6AotvDeCWL9iM2NEBpE7Z8BD20eVo35ib98AltVwiFBcwZmfIMnMFF1XPr
         5vlVtGEjd11fz+YRLkMmUhn97qlpsdkc4DL6NhgMm7Mkwyq1oicoTZ7ILmmgDzuhjM
         ze0fKEDW33y8MZR0UepcThvIbFu3/lAeZE00q+cOipZQ8Lcqot9TRVnTyQN8HPCKck
         pMryKWdgZqXUNVnkCcUcU72ywyTz5g2+BhbOUwbY61ixF1hwqgKC+NR2GZoEY2LovL
         adOi8bpXpHWwZ9iuBZ2twoRkkWBhNpLm4nS9wufTfY8QLx9jZPPZJENuxux6eG7vRa
         qdyNF8dFcgZWw==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     agross@kernel.org
Cc:     andersson@kernel.org, konrad.dybcio@linaro.org, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robdclark@gmail.com,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        marijn.suijten@somainline.org, kernel@collabora.com,
        luca@z3ntu.xyz, a39.skl@gmail.com, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v3 6/6] iommu/qcom: Add support for QSMMUv2 and QSMMU-500 secured contexts
Date:   Tue, 15 Nov 2022 11:11:22 +0100
Message-Id: <20221115101122.155440-7-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221115101122.155440-1-angelogioacchino.delregno@collabora.com>
References: <20221115101122.155440-1-angelogioacchino.delregno@collabora.com>
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

On some SoCs like MSM8956, MSM8976 and others, secure contexts are
also secured: these get programmed by the bootloader or TZ (as usual)
but their "interesting" registers are locked out by the hypervisor,
disallowing direct register writes from Linux and, in many cases,
completely disallowing the reprogramming of TTBR, TCR, MAIR and other
registers including, but not limited to, resetting contexts.
This is referred downstream as a "v2" IOMMU but this is effectively
a "v2 firmware configuration" instead.

Luckily, the described behavior of version 2 is effective only on
secure contexts and not on non-secure ones: add support for that,
finally getting a completely working IOMMU on at least MSM8956/76.

Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
[Marijn: Rebased over next-20221111]
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/iommu/arm/arm-smmu/qcom_iommu.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
index 94f51cafee17..db7d7cf5cc7d 100644
--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -59,6 +59,7 @@ struct qcom_iommu_ctx {
 	struct device		*dev;
 	void __iomem		*base;
 	bool			 secure_init;
+	bool			 secured_ctx;
 	u8			 asid;      /* asid and ctx bank # are 1:1 */
 	struct iommu_domain	*domain;
 };
@@ -287,6 +288,12 @@ static int qcom_iommu_init_domain(struct iommu_domain *domain,
 			ctx->secure_init = true;
 		}
 
+		/* Secured QSMMU-500/QSMMU-v2 contexts cannot be programmed */
+		if (ctx->secured_ctx) {
+			ctx->domain = domain;
+			continue;
+		}
+
 		qcom_iommu_reset_ctx(ctx);
 
 		/* TTBRs */
@@ -418,7 +425,8 @@ static void qcom_iommu_detach_dev(struct iommu_domain *domain, struct device *de
 		struct qcom_iommu_ctx *ctx = to_ctx(qcom_domain, fwspec->ids[i]);
 
 		/* Disable and reset the context bank */
-		qcom_iommu_reset_ctx(ctx);
+		if (!ctx->secured_ctx)
+			qcom_iommu_reset_ctx(ctx);
 
 		ctx->domain = NULL;
 	}
@@ -699,10 +707,14 @@ static int qcom_iommu_ctx_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return -ENODEV;
 
+	if (of_device_is_compatible(dev->of_node, "qcom,msm-iommu-v2-sec"))
+		ctx->secured_ctx = true;
+
 	/* clear IRQs before registering fault handler, just in case the
 	 * boot-loader left us a surprise:
 	 */
-	iommu_writel(ctx, ARM_SMMU_CB_FSR, iommu_readl(ctx, ARM_SMMU_CB_FSR));
+	if (!ctx->secured_ctx)
+		iommu_writel(ctx, ARM_SMMU_CB_FSR, iommu_readl(ctx, ARM_SMMU_CB_FSR));
 
 	ret = devm_request_irq(dev, irq,
 			       qcom_iommu_fault,
@@ -744,6 +756,8 @@ static int qcom_iommu_ctx_remove(struct platform_device *pdev)
 static const struct of_device_id ctx_of_match[] = {
 	{ .compatible = "qcom,msm-iommu-v1-ns" },
 	{ .compatible = "qcom,msm-iommu-v1-sec" },
+	{ .compatible = "qcom,msm-iommu-v2-ns" },
+	{ .compatible = "qcom,msm-iommu-v2-sec" },
 	{ /* sentinel */ }
 };
 
@@ -761,7 +775,8 @@ static bool qcom_iommu_has_secure_context(struct qcom_iommu_dev *qcom_iommu)
 	struct device_node *child;
 
 	for_each_child_of_node(qcom_iommu->dev->of_node, child) {
-		if (of_device_is_compatible(child, "qcom,msm-iommu-v1-sec")) {
+		if (of_device_is_compatible(child, "qcom,msm-iommu-v1-sec") ||
+		    of_device_is_compatible(child, "qcom,msm-iommu-v2-sec")) {
 			of_node_put(child);
 			return true;
 		}
@@ -909,6 +924,7 @@ static const struct dev_pm_ops qcom_iommu_pm_ops = {
 
 static const struct of_device_id qcom_iommu_of_match[] = {
 	{ .compatible = "qcom,msm-iommu-v1" },
+	{ .compatible = "qcom,msm-iommu-v2" },
 	{ /* sentinel */ }
 };
 
-- 
2.38.1


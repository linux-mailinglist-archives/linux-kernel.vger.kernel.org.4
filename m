Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAE6A739D7C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 11:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbjFVJfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 05:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231981AbjFVJdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 05:33:49 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D49F426A8;
        Thu, 22 Jun 2023 02:28:04 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 95AB16607074;
        Thu, 22 Jun 2023 10:28:02 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1687426083;
        bh=+uExxuo8h2T7GFt5bvQIbcFkvr4CRRqph4Cl584xqkA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z5de8s7eMgTJLSc+T/gQAJNvv3j/FMZjGX3zvP0Qkxiywmzs0jc/NNFsFn3AVKEXv
         8/WAefQTLGjGtUYCZp1PfYdEoe3gv9l+PMiXDWbvCz20p401MbzX63b5N7cfUjVG4P
         edPajuFNXIeKlB77nDynZTmTpNtt0fUa0xAIOgmKmLNlacq3oyNZoSqEi1COlar2vy
         4jGMArZcLhBf6Sap8ASzNeIVngRggp7J2bSMxqiaIcTxBbPkqvg+8/95hFRVCP3ALK
         PLOaZ7nTioO3MiBqwgwBEijhe4V0K7uEeSyi5vX5AJPZeStj7ZdJbEQ/DhpUowaoO4
         dgUAVzQMrID9w==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     agross@kernel.org
Cc:     andersson@kernel.org, luca@z3ntu.xyz, konrad.dybcio@linaro.org,
        dmitry.baryshkov@linaro.org, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        robdclark@gmail.com, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        Marijn Suijten <marijn.suijten@somainline.org>
Subject: [PATCH v5 6/6] iommu/qcom: Add support for QSMMUv2 and QSMMU-500 secured contexts
Date:   Thu, 22 Jun 2023 11:27:42 +0200
Message-Id: <20230622092742.74819-7-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230622092742.74819-1-angelogioacchino.delregno@collabora.com>
References: <20230622092742.74819-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/iommu/arm/arm-smmu/qcom_iommu.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
index 9786fd094e7d..7b6241f36698 100644
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
@@ -273,6 +274,12 @@ static int qcom_iommu_init_domain(struct iommu_domain *domain,
 			ctx->secure_init = true;
 		}
 
+		/* Secured QSMMU-500/QSMMU-v2 contexts cannot be programmed */
+		if (ctx->secured_ctx) {
+			ctx->domain = domain;
+			continue;
+		}
+
 		/* Disable context bank before programming */
 		iommu_writel(ctx, ARM_SMMU_CB_SCTLR, 0);
 
@@ -669,10 +676,14 @@ static int qcom_iommu_ctx_probe(struct platform_device *pdev)
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
@@ -712,6 +723,8 @@ static void qcom_iommu_ctx_remove(struct platform_device *pdev)
 static const struct of_device_id ctx_of_match[] = {
 	{ .compatible = "qcom,msm-iommu-v1-ns" },
 	{ .compatible = "qcom,msm-iommu-v1-sec" },
+	{ .compatible = "qcom,msm-iommu-v2-ns" },
+	{ .compatible = "qcom,msm-iommu-v2-sec" },
 	{ /* sentinel */ }
 };
 
@@ -729,7 +742,8 @@ static bool qcom_iommu_has_secure_context(struct qcom_iommu_dev *qcom_iommu)
 	struct device_node *child;
 
 	for_each_child_of_node(qcom_iommu->dev->of_node, child) {
-		if (of_device_is_compatible(child, "qcom,msm-iommu-v1-sec")) {
+		if (of_device_is_compatible(child, "qcom,msm-iommu-v1-sec") ||
+		    of_device_is_compatible(child, "qcom,msm-iommu-v2-sec")) {
 			of_node_put(child);
 			return true;
 		}
@@ -873,6 +887,7 @@ static const struct dev_pm_ops qcom_iommu_pm_ops = {
 
 static const struct of_device_id qcom_iommu_of_match[] = {
 	{ .compatible = "qcom,msm-iommu-v1" },
+	{ .compatible = "qcom,msm-iommu-v2" },
 	{ /* sentinel */ }
 };
 
-- 
2.40.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6480F62956D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 11:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238388AbiKOKL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 05:11:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238283AbiKOKLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 05:11:40 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA95D88;
        Tue, 15 Nov 2022 02:11:39 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 159826602A0B;
        Tue, 15 Nov 2022 10:11:37 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1668507098;
        bh=N1mKhVUV01NUb+7PkgRk9SjnldpaGZ/+V+1gVCVqXzo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bz1oK+LiSMFDkOxh5ALtdt4gGBrzdxJqBydMYV7KP51k5HvPzhMBn3gPlJPsPFoxu
         cefNzdCrm0RqXTTlSpBoDjjx4jvl2//i1jBhRrcu5AmyzFp6TMrcjsd7orirnyZZ2m
         KnV8B/YeQuN/QFFlL1FXbe7EX2Vpjh0qSUT5GaMM5KOjXgyUz5FpyH6ieMsWHcDaVO
         sAQbQaM3M960uyShk+GpusCOqEMli1hJTZdKQ1VMmZoA4mzDFzKpK8cys/ci1dRPz5
         yWrFZiLJz/uHHlgE1M+uOrBwMMz8lGWLIFuuo0JkY+HCtuXnufEmHccYIgabGkYbOM
         kbA+pSBcO6edw==
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
Subject: [PATCH v3 4/6] iommu/qcom: Index contexts by asid number to allow asid 0
Date:   Tue, 15 Nov 2022 11:11:20 +0100
Message-Id: <20221115101122.155440-5-angelogioacchino.delregno@collabora.com>
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

This driver was indexing the contexts by asid-1, which is probably
done under the assumption that the first ASID is always 1.

Unfortunately this is not always true: at least for MSM8956 and
MSM8976's GPU IOMMU, the gpu_user context's ASID number is zero.
To allow using a zero asid number, index the contexts by `asid`
instead of by `asid - 1`.

Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
[Marijn: Rebased over next-20221111]
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/iommu/arm/arm-smmu/qcom_iommu.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
index 49f4308f1bd2..94f51cafee17 100644
--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -52,7 +52,7 @@ struct qcom_iommu_dev {
 	void __iomem		*local_base;
 	u32			 sec_id;
 	u8			 num_ctxs;
-	struct qcom_iommu_ctx	*ctxs[];   /* indexed by asid-1 */
+	struct qcom_iommu_ctx	*ctxs[];   /* indexed by asid */
 };
 
 struct qcom_iommu_ctx {
@@ -94,7 +94,7 @@ static struct qcom_iommu_ctx * to_ctx(struct qcom_iommu_domain *d, unsigned asid
 	struct qcom_iommu_dev *qcom_iommu = d->iommu;
 	if (!qcom_iommu)
 		return NULL;
-	return qcom_iommu->ctxs[asid - 1];
+	return qcom_iommu->ctxs[asid];
 }
 
 static inline void
@@ -563,12 +563,10 @@ static int qcom_iommu_of_xlate(struct device *dev, struct of_phandle_args *args)
 	qcom_iommu = platform_get_drvdata(iommu_pdev);
 
 	/* make sure the asid specified in dt is valid, so we don't have
-	 * to sanity check this elsewhere, since 'asid - 1' is used to
-	 * index into qcom_iommu->ctxs:
+	 * to sanity check this elsewhere:
 	 */
-	if (WARN_ON(asid < 1) ||
-	    WARN_ON(asid > qcom_iommu->num_ctxs) ||
-	    WARN_ON(qcom_iommu->ctxs[asid - 1] == NULL)) {
+	if (WARN_ON(asid >= qcom_iommu->num_ctxs) ||
+	    WARN_ON(qcom_iommu->ctxs[asid] == NULL)) {
 		put_device(&iommu_pdev->dev);
 		return -EINVAL;
 	}
@@ -726,7 +724,7 @@ static int qcom_iommu_ctx_probe(struct platform_device *pdev)
 
 	dev_dbg(dev, "found asid %u\n", ctx->asid);
 
-	qcom_iommu->ctxs[ctx->asid - 1] = ctx;
+	qcom_iommu->ctxs[ctx->asid] = ctx;
 
 	return 0;
 }
@@ -738,7 +736,7 @@ static int qcom_iommu_ctx_remove(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, NULL);
 
-	qcom_iommu->ctxs[ctx->asid - 1] = NULL;
+	qcom_iommu->ctxs[ctx->asid] = NULL;
 
 	return 0;
 }
@@ -779,7 +777,7 @@ static int qcom_iommu_device_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct resource *res;
 	struct clk *clk;
-	int ret, max_asid = 0;
+	int ret, num_ctxs, max_asid = 0;
 
 	/* find the max asid (which is 1:1 to ctx bank idx), so we know how
 	 * many child ctx devices we have:
@@ -787,11 +785,13 @@ static int qcom_iommu_device_probe(struct platform_device *pdev)
 	for_each_child_of_node(dev->of_node, child)
 		max_asid = max(max_asid, get_asid(child));
 
-	qcom_iommu = devm_kzalloc(dev, struct_size(qcom_iommu, ctxs, max_asid),
+	num_ctxs = max_asid + 1;
+
+	qcom_iommu = devm_kzalloc(dev, struct_size(qcom_iommu, ctxs, num_ctxs),
 				  GFP_KERNEL);
 	if (!qcom_iommu)
 		return -ENOMEM;
-	qcom_iommu->num_ctxs = max_asid;
+	qcom_iommu->num_ctxs = num_ctxs;
 	qcom_iommu->dev = dev;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-- 
2.38.1


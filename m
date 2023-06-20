Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89C81736873
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 11:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232615AbjFTJyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 05:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232529AbjFTJxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 05:53:22 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76132127;
        Tue, 20 Jun 2023 02:51:37 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 818096606F94;
        Tue, 20 Jun 2023 10:51:35 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1687254696;
        bh=YU/50uDXcSxDqIMfavvqSq4fy2uuTpev475iPj7d5+M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SFU8vTESFZIg+fJV5pu+p9OJS54+H9S2wyzzXkQr5ekFwbvf0redMkop1j62Hgk75
         2kUGVsms2ErwmW2LGjsS0f4sM2027aRjTbUmHMPLbmG4wu2oR5osu+Wx5+H3nPjyrS
         n/uNseaNWK1QXSRJRXXSr4qSLvXD0OkrIgtK25N/QhrfV/rwA1MgDiQw94cfn3qPhi
         5rheZBgFizOA4RrSRbtwdtgTCK22WTCs+o1Rb1KwyIa0takutXrPSe65ZD+gc8Rm9W
         eXS5h7CHGmVdRj5du36qjcUGJA09DgSjwgCwul1IlAn41kqVQqP7yXjgi7BDzwnmbB
         qvy0skovxh6CA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     agross@kernel.org
Cc:     andersson@kernel.org, konrad.dybcio@linaro.org,
        dmitry.baryshkov@linaro.org, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        robdclark@gmail.com, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com
Subject: [PATCH v4 4/6] iommu/qcom: Index contexts by asid number to allow asid 0
Date:   Tue, 20 Jun 2023 11:51:25 +0200
Message-Id: <20230620095127.96600-5-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230620095127.96600-1-angelogioacchino.delregno@collabora.com>
References: <20230620095127.96600-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

While at it, also enhance human readability by renaming the
`num_ctxs` member of struct qcom_iommu_dev to `max_asid`.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/iommu/arm/arm-smmu/qcom_iommu.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
index 8b48f7e8f3db..f4b948a0bd1c 100644
--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -51,8 +51,8 @@ struct qcom_iommu_dev {
 	struct clk_bulk_data clks[CLK_NUM];
 	void __iomem		*local_base;
 	u32			 sec_id;
-	u8			 num_ctxs;
-	struct qcom_iommu_ctx	*ctxs[];   /* indexed by asid-1 */
+	u8			 max_asid;
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
@@ -534,12 +534,10 @@ static int qcom_iommu_of_xlate(struct device *dev, struct of_phandle_args *args)
 	qcom_iommu = platform_get_drvdata(iommu_pdev);
 
 	/* make sure the asid specified in dt is valid, so we don't have
-	 * to sanity check this elsewhere, since 'asid - 1' is used to
-	 * index into qcom_iommu->ctxs:
+	 * to sanity check this elsewhere:
 	 */
-	if (WARN_ON(asid < 1) ||
-	    WARN_ON(asid > qcom_iommu->num_ctxs) ||
-	    WARN_ON(qcom_iommu->ctxs[asid - 1] == NULL)) {
+	if (WARN_ON(asid > qcom_iommu->max_asid) ||
+	    WARN_ON(qcom_iommu->ctxs[asid] == NULL)) {
 		put_device(&iommu_pdev->dev);
 		return -EINVAL;
 	}
@@ -696,7 +694,7 @@ static int qcom_iommu_ctx_probe(struct platform_device *pdev)
 
 	dev_dbg(dev, "found asid %u\n", ctx->asid);
 
-	qcom_iommu->ctxs[ctx->asid - 1] = ctx;
+	qcom_iommu->ctxs[ctx->asid] = ctx;
 
 	return 0;
 }
@@ -708,7 +706,7 @@ static void qcom_iommu_ctx_remove(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, NULL);
 
-	qcom_iommu->ctxs[ctx->asid - 1] = NULL;
+	qcom_iommu->ctxs[ctx->asid] = NULL;
 }
 
 static const struct of_device_id ctx_of_match[] = {
@@ -755,11 +753,11 @@ static int qcom_iommu_device_probe(struct platform_device *pdev)
 	for_each_child_of_node(dev->of_node, child)
 		max_asid = max(max_asid, get_asid(child));
 
-	qcom_iommu = devm_kzalloc(dev, struct_size(qcom_iommu, ctxs, max_asid),
+	qcom_iommu = devm_kzalloc(dev, struct_size(qcom_iommu, ctxs, max_asid + 1),
 				  GFP_KERNEL);
 	if (!qcom_iommu)
 		return -ENOMEM;
-	qcom_iommu->num_ctxs = max_asid;
+	qcom_iommu->max_asid = max_asid;
 	qcom_iommu->dev = dev;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-- 
2.40.1


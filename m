Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9D9E625DC6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 16:00:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234907AbiKKPAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 10:00:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234799AbiKKO7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 09:59:33 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D84E063BBB;
        Fri, 11 Nov 2022 06:59:32 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BBF3A6602A59;
        Fri, 11 Nov 2022 14:59:30 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1668178771;
        bh=Uu2Iue2Zm6k/+FEoq7MKfKY9a5FHnfb6lp6TkxmYFRg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ji175R1aNfzKHK18s5KugJr20pgxwV4WtDoVyta3R+nVqDqYA7oX45rhWJwWSKV5v
         za6ubSoO341xTJ8UREvfDtV3Qv+YWHdRJNBi/I8TtI0ArwiyIjL95dJJJeDmPFJlYM
         O2N8yu9BkQFeL9wviuJFSznOyp2Y7MeZV0t+IicNWxtGlu8+XEuC839am895RzrIoC
         Fxvd8jZ1qQnSUpyBHtbS9VQgfjvsvDK1yoOH98ipA2n5+lQoU1C5zYKjT4lBKhMZVj
         Se8mclKCE4OOB4BtJ3wqm48ZhoIkodBwWT1N3bkM+7FG8xbPXpgSgpYjsEC9ky3nCY
         IqvGQrHibJazw==
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
Subject: [PATCH v2 4/8] iommu/qcom: Properly reset the IOMMU context
Date:   Fri, 11 Nov 2022 15:59:15 +0100
Message-Id: <20221111145919.221159-5-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221111145919.221159-1-angelogioacchino.delregno@collabora.com>
References: <20221111145919.221159-1-angelogioacchino.delregno@collabora.com>
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

Avoid context faults by resetting the context(s) entirely at
detach_dev() time and also do the same before programming the
context for domain initialization.

Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
[Marijn: Rebased over next-20221111]
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/iommu/arm/arm-smmu/qcom_iommu.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
index 491a8093f3d6..2249430d99d0 100644
--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -223,6 +223,21 @@ static irqreturn_t qcom_iommu_fault(int irq, void *dev)
 	return IRQ_HANDLED;
 }
 
+static void qcom_iommu_reset_ctx(struct qcom_iommu_ctx *ctx)
+{
+	iommu_writel(ctx, ARM_SMMU_CB_FAR, 0);
+	iommu_writel(ctx, ARM_SMMU_CB_FSRRESTORE, 0);
+	iommu_writel(ctx, ARM_SMMU_CB_FSR, ARM_SMMU_FSR_FAULT);
+	iommu_writel(ctx, ARM_SMMU_CB_S1_MAIR1, 0);
+	iommu_writel(ctx, ARM_SMMU_CB_PAR, 0);
+	iommu_writel(ctx, ARM_SMMU_CB_S1_MAIR0, 0);
+	iommu_writel(ctx, ARM_SMMU_CB_SCTLR, 0);
+	iommu_writel(ctx, ARM_SMMU_CB_TCR2, 0);
+	iommu_writel(ctx, ARM_SMMU_CB_TCR, 0);
+	iommu_writeq(ctx, ARM_SMMU_CB_TTBR0, 0);
+	iommu_writeq(ctx, ARM_SMMU_CB_TTBR1, 0);
+}
+
 static int qcom_iommu_init_domain(struct iommu_domain *domain,
 				  struct qcom_iommu_dev *qcom_iommu,
 				  struct device *dev)
@@ -273,6 +288,8 @@ static int qcom_iommu_init_domain(struct iommu_domain *domain,
 			ctx->secure_init = true;
 		}
 
+		qcom_iommu_reset_ctx(ctx);
+
 		/* TTBRs */
 		iommu_writeq(ctx, ARM_SMMU_CB_TTBR0,
 				pgtbl_cfg.arm_lpae_s1_cfg.ttbr |
@@ -401,8 +418,8 @@ static void qcom_iommu_detach_dev(struct iommu_domain *domain, struct device *de
 	for (i = 0; i < fwspec->num_ids; i++) {
 		struct qcom_iommu_ctx *ctx = to_ctx(qcom_domain, fwspec->ids[i]);
 
-		/* Disable the context bank: */
-		iommu_writel(ctx, ARM_SMMU_CB_SCTLR, 0);
+		/* Disable and reset the context bank */
+		qcom_iommu_reset_ctx(ctx);
 
 		ctx->domain = NULL;
 	}
-- 
2.38.1


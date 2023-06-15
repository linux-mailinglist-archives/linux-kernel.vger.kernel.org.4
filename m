Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DCE0732169
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 23:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjFOVNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 17:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjFOVND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 17:13:03 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D35DC2735
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 14:12:59 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b1ac373c9eso35170851fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 14:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686863578; x=1689455578;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jUFJynfbYH68TgX/3zQnDPC8kILyVFzPYFqe48XXoJ4=;
        b=CKrqkFKwkCG+NHBVhNryc3DylQL8Hr8ibvmALVJBz3FyuX51mC7FkXxQ8pU4TKA+Wi
         oPLl16C52JWsAh4wnSIlxYe/j1gsldVI5ebyrI1YReG+cPn8HfthHPi9ow+IViHhUvQK
         huipbFqHF8EJkkHXXanUGAciJ/x0500WZ6MpYLLUvvv29Uc3EjvYS3vilwiVQibK1Uje
         TKMEnrYYmQrTarlbeaSuUFeMewHdMBch+0IXtEymTdlM7fPeeavbWknhxiFVjoz2dB++
         kJSArksE3ZKcZZ4Z9LOcd38bW5td4CcCabPbl1fC5oj8AQiLM9VpIy35fehsdQQ+BTNg
         IIxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686863578; x=1689455578;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jUFJynfbYH68TgX/3zQnDPC8kILyVFzPYFqe48XXoJ4=;
        b=dGkhjf2rhZ5rJvz6Z3Yrlo+8ht2Wd71A0WADWblkbVbXdBhFaOO0UEPJKTzWM+iJpF
         HJ7f4A1l8NyionP4AHxVjWpb3Po4rKdxCNS6vhGXW2O1OOoQ56G+nOZ5zoORFFBkW9PL
         kUFGGN7FkA1PUbFcWTdMMIXK+ELbRN+7mfzo+xnECrsD1SpaGjI/XyI97TOVGTsLOsK2
         w9y9/IxPh/QtOQiTLh6eU/MJHWxyCybALakhGcIM5bsjXZaHsexYrORBFMTWTKVulfSg
         zpxrEsnxhiOXsu1+TXpfSZL2ODS/gxMTmSWd7d5MgR1DCVLJAU0gQUIy4cqPXD1D1e5m
         Ur7A==
X-Gm-Message-State: AC+VfDzHvPhBNSRL1Gjynpozr6sBAF+Z1+rtDUcVdkqejOwoEW6a/ESG
        8J/1711lc7sbFj0hBUfiAVKg2w==
X-Google-Smtp-Source: ACHHUZ4xMBT7SJ9fBGQ4PJ0W58mFDjweuxpu/r35fNnU/FhyjgWEUNTSbyS9rbbIrDOe02jh2sK0mQ==
X-Received: by 2002:a2e:82d5:0:b0:2b1:a8e9:df4a with SMTP id n21-20020a2e82d5000000b002b1a8e9df4amr422963ljh.6.1686863578068;
        Thu, 15 Jun 2023 14:12:58 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id b8-20020a2e8488000000b002b32f9b6bd3sm1809447ljh.62.2023.06.15.14.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 14:12:56 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Thu, 15 Jun 2023 23:12:48 +0200
Subject: [PATCH] soc: qcom: icc-bwmon: Don't ignore return values of regmap
 functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230615-topic-bwmonretval-v1-1-223bd048ebf7@linaro.org>
X-B4-Tracking: v=1; b=H4sIAM9+i2QC/x2NQQqDMBAAvyJ7biCJVaRfKT0kca0L6UY2agvi3
 7t4nIFhDqgohBUezQGCO1UqrOBuDaQ58BsNjcrgrW9t7zqzloWSid9PYcF1D9m0k+8tOj/cxwG
 0i6GiiRI4zVrylrPKRXCi3zV6vs7zD7a/Pcd4AAAA
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686863575; l=11315;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=jQfZ8A8yO923snxoscqaGq6MypAl4RGdSw5D8sggzT4=;
 b=Sxm0c6JgpeNiP7rNz7MZhk11JK10M/qBq1Ns5/UvDTTAkiLKl7qGahG9pclm62D2OGxEOK89s
 YzRsFgOlbFACL4mwE2evUDXGRaKrL8QbYpkRFXI2fA0mcyZbjl4x2cb
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As it turns out, not all regmap accesses succeed. Not knowing this is
particularly suboptimal when there's a breaking change to the regmap
APIs. Monitor the return values of regmap_ calls and propagate errors,
should any occur.

To keep any level of readability in bwmon_enable(), add some comments
to separate the logical blocks.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Depends on: https://lore.kernel.org/linux-arm-msm/20230610-topic-bwmon_opp-v2-1-0d25c1ce7dca@linaro.org/
---
 drivers/soc/qcom/icc-bwmon.c | 211 ++++++++++++++++++++++++++++++-------------
 1 file changed, 150 insertions(+), 61 deletions(-)

diff --git a/drivers/soc/qcom/icc-bwmon.c b/drivers/soc/qcom/icc-bwmon.c
index 8daf0eb03279..306f911d2be0 100644
--- a/drivers/soc/qcom/icc-bwmon.c
+++ b/drivers/soc/qcom/icc-bwmon.c
@@ -449,9 +449,10 @@ static const struct regmap_config sdm845_llcc_bwmon_regmap_cfg = {
 	.cache_type		= REGCACHE_RBTREE,
 };
 
-static void bwmon_clear_counters(struct icc_bwmon *bwmon, bool clear_all)
+static int bwmon_clear_counters(struct icc_bwmon *bwmon, bool clear_all)
 {
 	unsigned int val = BWMON_CLEAR_CLEAR;
+	int ret;
 
 	if (clear_all)
 		val |= BWMON_CLEAR_CLEAR_ALL;
@@ -463,14 +464,20 @@ static void bwmon_clear_counters(struct icc_bwmon *bwmon, bool clear_all)
 	 * region. So, we need to make sure the counter clear is completed
 	 * before we try to clear the IRQ or do any other counter operations.
 	 */
-	regmap_field_force_write(bwmon->regs[F_CLEAR], val);
+	ret = regmap_field_force_write(bwmon->regs[F_CLEAR], val);
+	if (ret)
+		return ret;
+
 	if (bwmon->data->quirks & BWMON_NEEDS_FORCE_CLEAR)
-		regmap_field_force_write(bwmon->regs[F_CLEAR], 0);
+		ret = regmap_field_force_write(bwmon->regs[F_CLEAR], 0);
+
+	return ret;
 }
 
-static void bwmon_clear_irq(struct icc_bwmon *bwmon)
+static int bwmon_clear_irq(struct icc_bwmon *bwmon)
 {
 	struct regmap_field *global_irq_clr;
+	int ret;
 
 	if (bwmon->data->global_regmap_fields)
 		global_irq_clr = bwmon->global_regs[F_GLOBAL_IRQ_CLEAR];
@@ -493,17 +500,27 @@ static void bwmon_clear_irq(struct icc_bwmon *bwmon)
 	 * clearing here so that local writes don't happen before the
 	 * interrupt is cleared.
 	 */
-	regmap_field_force_write(bwmon->regs[F_IRQ_CLEAR], BWMON_IRQ_ENABLE_MASK);
-	if (bwmon->data->quirks & BWMON_NEEDS_FORCE_CLEAR)
-		regmap_field_force_write(bwmon->regs[F_IRQ_CLEAR], 0);
+	ret = regmap_field_force_write(bwmon->regs[F_IRQ_CLEAR], BWMON_IRQ_ENABLE_MASK);
+	if (ret)
+		return ret;
+
+	if (bwmon->data->quirks & BWMON_NEEDS_FORCE_CLEAR) {
+		ret = regmap_field_force_write(bwmon->regs[F_IRQ_CLEAR], 0);
+		if (ret)
+			return ret;
+	}
+
 	if (bwmon->data->quirks & BWMON_HAS_GLOBAL_IRQ)
-		regmap_field_force_write(global_irq_clr,
-					 BWMON_V4_GLOBAL_IRQ_ENABLE_ENABLE);
+		ret = regmap_field_force_write(global_irq_clr,
+					       BWMON_V4_GLOBAL_IRQ_ENABLE_ENABLE);
+
+	return ret;
 }
 
-static void bwmon_disable(struct icc_bwmon *bwmon)
+static int bwmon_disable(struct icc_bwmon *bwmon)
 {
 	struct regmap_field *global_irq_en;
+	int ret;
 
 	if (bwmon->data->global_regmap_fields)
 		global_irq_en = bwmon->global_regs[F_GLOBAL_IRQ_ENABLE];
@@ -511,20 +528,29 @@ static void bwmon_disable(struct icc_bwmon *bwmon)
 		global_irq_en = bwmon->regs[F_GLOBAL_IRQ_ENABLE];
 
 	/* Disable interrupts. Strict ordering, see bwmon_clear_irq(). */
-	if (bwmon->data->quirks & BWMON_HAS_GLOBAL_IRQ)
-		regmap_field_write(global_irq_en, 0x0);
-	regmap_field_write(bwmon->regs[F_IRQ_ENABLE], 0x0);
+	if (bwmon->data->quirks & BWMON_HAS_GLOBAL_IRQ) {
+		ret = regmap_field_write(global_irq_en, 0x0);
+		if (ret)
+			return ret;
+	}
+
+	ret = regmap_field_write(bwmon->regs[F_IRQ_ENABLE], 0x0);
+	if (ret)
+		return ret;
 
 	/*
 	 * Disable bwmon. Must happen before bwmon_clear_irq() to avoid spurious
 	 * IRQ.
 	 */
-	regmap_field_write(bwmon->regs[F_ENABLE], 0x0);
+	ret = regmap_field_write(bwmon->regs[F_ENABLE], 0x0);
+
+	return ret;
 }
 
-static void bwmon_enable(struct icc_bwmon *bwmon, unsigned int irq_enable)
+static int bwmon_enable(struct icc_bwmon *bwmon, unsigned int irq_enable)
 {
 	struct regmap_field *global_irq_en;
+	int ret;
 
 	if (bwmon->data->global_regmap_fields)
 		global_irq_en = bwmon->global_regs[F_GLOBAL_IRQ_ENABLE];
@@ -532,14 +558,21 @@ static void bwmon_enable(struct icc_bwmon *bwmon, unsigned int irq_enable)
 		global_irq_en = bwmon->regs[F_GLOBAL_IRQ_ENABLE];
 
 	/* Enable interrupts */
-	if (bwmon->data->quirks & BWMON_HAS_GLOBAL_IRQ)
-		regmap_field_write(global_irq_en,
-				   BWMON_V4_GLOBAL_IRQ_ENABLE_ENABLE);
+	if (bwmon->data->quirks & BWMON_HAS_GLOBAL_IRQ) {
+		ret = regmap_field_write(global_irq_en,
+					 BWMON_V4_GLOBAL_IRQ_ENABLE_ENABLE);
+		if (ret)
+			return ret;
+	}
 
-	regmap_field_write(bwmon->regs[F_IRQ_ENABLE], irq_enable);
+	ret = regmap_field_write(bwmon->regs[F_IRQ_ENABLE], irq_enable);
+	if (ret)
+		return ret;
 
 	/* Enable bwmon */
-	regmap_field_write(bwmon->regs[F_ENABLE], BWMON_ENABLE_ENABLE);
+	ret = regmap_field_write(bwmon->regs[F_ENABLE], BWMON_ENABLE_ENABLE);
+
+	return ret;
 }
 
 static unsigned int bwmon_kbps_to_count(struct icc_bwmon *bwmon,
@@ -548,55 +581,97 @@ static unsigned int bwmon_kbps_to_count(struct icc_bwmon *bwmon,
 	return kbps / bwmon->data->count_unit_kb;
 }
 
-static void bwmon_set_threshold(struct icc_bwmon *bwmon,
+static int bwmon_set_threshold(struct icc_bwmon *bwmon,
 				struct regmap_field *reg, unsigned int kbps)
 {
 	unsigned int thres;
 
 	thres = mult_frac(bwmon_kbps_to_count(bwmon, kbps),
 			  bwmon->data->sample_ms, MSEC_PER_SEC);
-	regmap_field_write(reg, thres);
+	return regmap_field_write(reg, thres);
 }
 
-static void bwmon_start(struct icc_bwmon *bwmon)
+static int bwmon_start(struct icc_bwmon *bwmon)
 {
 	const struct icc_bwmon_data *data = bwmon->data;
+	int ret, window;
 	u32 bw_low = 0;
-	int window;
 
 	/* No need to check for errors, as this must have succeeded before. */
 	dev_pm_opp_find_bw_ceil(bwmon->dev, &bw_low, 0);
 
-	bwmon_clear_counters(bwmon, true);
+	ret = bwmon_clear_counters(bwmon, true);
+	if (ret)
+		return ret;
 
 	window = mult_frac(bwmon->data->sample_ms, HW_TIMER_HZ, MSEC_PER_SEC);
 	/* Maximum sampling window: 0xffffff for v4 and 0xfffff for v5 */
-	regmap_field_write(bwmon->regs[F_SAMPLE_WINDOW], window);
-
-	bwmon_set_threshold(bwmon, bwmon->regs[F_THRESHOLD_HIGH], bw_low);
-	bwmon_set_threshold(bwmon, bwmon->regs[F_THRESHOLD_MED], bw_low);
-	bwmon_set_threshold(bwmon, bwmon->regs[F_THRESHOLD_LOW], 0);
-
-	regmap_field_write(bwmon->regs[F_THRESHOLD_COUNT_ZONE0],
-			   BWMON_THRESHOLD_COUNT_ZONE0_DEFAULT);
-	regmap_field_write(bwmon->regs[F_THRESHOLD_COUNT_ZONE1],
-			   data->zone1_thres_count);
-	regmap_field_write(bwmon->regs[F_THRESHOLD_COUNT_ZONE2],
-			   BWMON_THRESHOLD_COUNT_ZONE2_DEFAULT);
-	regmap_field_write(bwmon->regs[F_THRESHOLD_COUNT_ZONE3],
-			   data->zone3_thres_count);
-
-	regmap_field_write(bwmon->regs[F_ZONE_ACTIONS_ZONE0],
-			   BWMON_ZONE_ACTIONS_ZONE0);
-	regmap_field_write(bwmon->regs[F_ZONE_ACTIONS_ZONE1],
-			   BWMON_ZONE_ACTIONS_ZONE1);
-	regmap_field_write(bwmon->regs[F_ZONE_ACTIONS_ZONE2],
-			   BWMON_ZONE_ACTIONS_ZONE2);
-	regmap_field_write(bwmon->regs[F_ZONE_ACTIONS_ZONE3],
-			   BWMON_ZONE_ACTIONS_ZONE3);
-
-	bwmon_clear_irq(bwmon);
-	bwmon_enable(bwmon, BWMON_IRQ_ENABLE_MASK);
+	ret = regmap_field_write(bwmon->regs[F_SAMPLE_WINDOW], window);
+	if (ret)
+		return ret;
+
+	/* Set up bandwidth thresholds */
+	ret = bwmon_set_threshold(bwmon, bwmon->regs[F_THRESHOLD_HIGH], bw_low);
+	if (ret)
+		return ret;
+
+	ret = bwmon_set_threshold(bwmon, bwmon->regs[F_THRESHOLD_MED], bw_low);
+	if (ret)
+		return ret;
+
+	ret = bwmon_set_threshold(bwmon, bwmon->regs[F_THRESHOLD_LOW], 0);
+	if (ret)
+		return ret;
+
+	/* Set up threshold counts */
+	ret = regmap_field_write(bwmon->regs[F_THRESHOLD_COUNT_ZONE0],
+				 BWMON_THRESHOLD_COUNT_ZONE0_DEFAULT);
+	if (ret)
+		return ret;
+
+	ret = regmap_field_write(bwmon->regs[F_THRESHOLD_COUNT_ZONE1],
+				 data->zone1_thres_count);
+	if (ret)
+		return ret;
+
+	ret = regmap_field_write(bwmon->regs[F_THRESHOLD_COUNT_ZONE2],
+				 BWMON_THRESHOLD_COUNT_ZONE2_DEFAULT);
+	if (ret)
+		return ret;
+
+	ret = regmap_field_write(bwmon->regs[F_THRESHOLD_COUNT_ZONE3],
+				 data->zone3_thres_count);
+	if (ret)
+		return ret;
+
+	/* Set up zone actions */
+	ret = regmap_field_write(bwmon->regs[F_ZONE_ACTIONS_ZONE0],
+				 BWMON_ZONE_ACTIONS_ZONE0);
+	if (ret)
+		return ret;
+
+	ret = regmap_field_write(bwmon->regs[F_ZONE_ACTIONS_ZONE1],
+				 BWMON_ZONE_ACTIONS_ZONE1);
+	if (ret)
+		return ret;
+
+	ret = regmap_field_write(bwmon->regs[F_ZONE_ACTIONS_ZONE2],
+				 BWMON_ZONE_ACTIONS_ZONE2);
+	if (ret)
+		return ret;
+
+	ret = regmap_field_write(bwmon->regs[F_ZONE_ACTIONS_ZONE3],
+				 BWMON_ZONE_ACTIONS_ZONE3);
+	if (ret)
+		return ret;
+
+	/* Clear any previous interrupts and get the stone rolling! */
+	ret = bwmon_clear_irq(bwmon);
+	if (ret)
+		return ret;
+
+
+	return bwmon_enable(bwmon, BWMON_IRQ_ENABLE_MASK);
 }
 
 static irqreturn_t bwmon_intr(int irq, void *dev_id)
@@ -622,7 +697,8 @@ static irqreturn_t bwmon_intr(int irq, void *dev_id)
 		return IRQ_NONE;
 	}
 
-	bwmon_disable(bwmon);
+	if (bwmon_disable(bwmon))
+		return IRQ_NONE;
 
 	zone = get_bitmask_order(status) - 1;
 	/*
@@ -671,13 +747,20 @@ static irqreturn_t bwmon_intr_thread(int irq, void *dev_id)
 	else
 		irq_enable = BWMON_IRQ_ENABLE_MASK;
 
-	bwmon_set_threshold(bwmon, bwmon->regs[F_THRESHOLD_HIGH],
-			    up_kbps);
-	bwmon_set_threshold(bwmon, bwmon->regs[F_THRESHOLD_MED],
-			    down_kbps);
-	bwmon_clear_counters(bwmon, false);
-	bwmon_clear_irq(bwmon);
-	bwmon_enable(bwmon, irq_enable);
+	if (bwmon_set_threshold(bwmon, bwmon->regs[F_THRESHOLD_HIGH], up_kbps))
+		return IRQ_NONE;
+
+	if (bwmon_set_threshold(bwmon, bwmon->regs[F_THRESHOLD_MED], down_kbps))
+		return IRQ_NONE;
+
+	if (bwmon_clear_counters(bwmon, false))
+		return IRQ_NONE;
+
+	if (bwmon_clear_irq(bwmon))
+		return IRQ_NONE;
+
+	if (bwmon_enable(bwmon, irq_enable))
+		return IRQ_NONE;
 
 	if (bwmon->target_kbps == bwmon->current_kbps)
 		goto out;
@@ -780,7 +863,10 @@ static int bwmon_probe(struct platform_device *pdev)
 
 	bwmon->dev = dev;
 
-	bwmon_disable(bwmon);
+	ret = bwmon_disable(bwmon);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to disable BWMON\n");
+
 	ret = devm_request_threaded_irq(dev, bwmon->irq, bwmon_intr,
 					bwmon_intr_thread,
 					IRQF_ONESHOT, dev_name(dev), bwmon);
@@ -788,7 +874,10 @@ static int bwmon_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, ret, "failed to request IRQ\n");
 
 	platform_set_drvdata(pdev, bwmon);
-	bwmon_start(bwmon);
+
+	ret = bwmon_start(bwmon);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to start BWMON\n");
 
 	return 0;
 }

---
base-commit: 772c02db794651e8d006813f545b8bfd6906b718
change-id: 20230615-topic-bwmonretval-3f260e1284d8

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>


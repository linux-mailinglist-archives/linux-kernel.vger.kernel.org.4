Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20CB56AAADA
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 16:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjCDPjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 10:39:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjCDPjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 10:39:33 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31AABBBC
        for <linux-kernel@vger.kernel.org>; Sat,  4 Mar 2023 07:39:30 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id i9so7304874lfc.6
        for <linux-kernel@vger.kernel.org>; Sat, 04 Mar 2023 07:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677944369;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EXY5357tFqNnM8uqY1hO5VGgznQMI6SfCbMMJByfZyo=;
        b=QwuBYrNGytFsO+yNLvAZ6cf6LR1BQn6IeGAE5rP9SR+zRR835P63eciWTVThHBS1JI
         O/pqIoma+ScdWRt3fO8DXwgWreNb1I8I9nUZJyGXda7apAM4cOyzM/muxQOKhD+0BtWe
         MuqGXy79XrNIc3CmSpCublmGnyi+9S+7sx/2RFxEFg+T+gz35YBymAAG4wCw13ysuvtt
         o3UIt4dkXZn2k0HsNldHetk1eo2sbDmSRRj1KwNKekSpgpvE57BrsjWcLdwsbV1BKBmq
         SBHdoQcsq2LMKEkIot4Tntckb6yNsKXY+aABB716On+TkrcD9PK792vw1dcofSsLmuaT
         nKqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677944369;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EXY5357tFqNnM8uqY1hO5VGgznQMI6SfCbMMJByfZyo=;
        b=jKVT8JK0EDxbj6RKChsmCUXQI724QsGPcf3nPdkjGYTEeygr4Sv+9xbxcRcBIklmB9
         4oWff68HulFx0jVuC/Ml8svSXoNhxQsz+UIclPROufnIDGUZS7yEJTqPM8mtabovLDwG
         KxnQYIhxMq5iyJREAHnTuypl9OGgX/nAT8R0DPfCJ03OMd/nHdlDJPBFS8XNks9a2/vs
         CLfxQvJpAPoZZg5/WAtpXjWmbE6XMf831s69L5+Gc9k6YbCOtXg1YZmEOeuXiCfjrpZh
         dNA1hNqg7cuW3IWg+HsqwWmLyO8tSEmbmD37L0h7kUts4aDxB0Web39a50sPAVgHMkC5
         xptg==
X-Gm-Message-State: AO0yUKUFR3hMdxks/lhunUAT8eIPsnnyfZ4XIQDW2I5idUgRmOOvJIbc
        hCJ8c67oio7NieYpj6wVmCbtAA==
X-Google-Smtp-Source: AK7set+lYjScynxzf2L3Ekrzh4d5ljeeCZf5UtAx1yLSJq5Ux4yrco2apYq1hwcNoBxqVS+IsNJFVA==
X-Received: by 2002:ac2:5a02:0:b0:4e7:4a3c:696 with SMTP id q2-20020ac25a02000000b004e74a3c0696mr1452960lfn.53.1677944369151;
        Sat, 04 Mar 2023 07:39:29 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id f14-20020ac2532e000000b004ab52b0bcf9sm855065lfh.207.2023.03.04.07.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Mar 2023 07:39:28 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Sat, 04 Mar 2023 16:39:20 +0100
Subject: [PATCH 2/3] soc: qcom: icc-bwmon: Handle global registers
 correctly
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230304-topic-ddr_bwmon-v1-2-e563837dc7d1@linaro.org>
References: <20230304-topic-ddr_bwmon-v1-0-e563837dc7d1@linaro.org>
In-Reply-To: <20230304-topic-ddr_bwmon-v1-0-e563837dc7d1@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677944365; l=11284;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=aNYpDL2mtgTupisZAIlUKvsOidHG4OJUMBRdq3RwREs=;
 b=xXvbENr6Yged13votu4x6KjUN76bmn7QdzadRn/u37EpS0dybEk68audOUdw4AZ97UcyWhoxkyoA
 1e2Qr8PVC0IlkZQYwvyvJDd4NkSe2OO8E7M1WWncEXufLaP8jgUy
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The BWMON hardware has two sets of registers: one for the monitor itself
and one called "global". It has what seems to be some kind of a head
switch and an interrupt control register. It's usually 0x200 in size.

On fairly recent SoCs (with the starting point seemingly being moving
the OSM programming to the firmware) these two register sets are
contiguous and overlapping, like this (on sm8450):

/* notice how base.start == global_base.start+0x100 */
reg = <0x90b6400 0x300>, <0x90b6300 0x200>;
reg-names = "base", "global_base";

Which led to some confusion and the assumption that since the
"interesting" global registers begin right after global_base+0x100,
there's no need to map two separate regions and one can simply subtract
0x100 from the offsets.

This is however not the case for anything older than SDM845, as the
global region can appear in seemingly random spots on the register map.

Add support for it to let bwmon function on older SoCs like MSM8998 and
allow operation with just one set of registers for newer platforms.

Fixes: b9c2ae6cac40 ("soc: qcom: icc-bwmon: Add bandwidth monitoring driver")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/soc/qcom/icc-bwmon.c | 136 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 118 insertions(+), 18 deletions(-)

diff --git a/drivers/soc/qcom/icc-bwmon.c b/drivers/soc/qcom/icc-bwmon.c
index d07be3700db6..9ef632d80ee3 100644
--- a/drivers/soc/qcom/icc-bwmon.c
+++ b/drivers/soc/qcom/icc-bwmon.c
@@ -34,14 +34,27 @@
 /* Internal sampling clock frequency */
 #define HW_TIMER_HZ				19200000
 
-#define BWMON_V4_GLOBAL_IRQ_CLEAR		0x008
-#define BWMON_V4_GLOBAL_IRQ_ENABLE		0x00c
+#define BWMON_V4_GLOBAL_IRQ_CLEAR		0x108
+#define BWMON_V4_GLOBAL_IRQ_ENABLE		0x10c
 /*
  * All values here and further are matching regmap fields, so without absolute
  * register offsets.
  */
 #define BWMON_V4_GLOBAL_IRQ_ENABLE_ENABLE	BIT(0)
 
+/*
+ * Starting with SDM845, the BWMON4 register space has changed a bit:
+ * the global registers were jammed into the beginning of the monitor region.
+ * To keep the proper offsets, one would have to map <GLOBAL_BASE 0x200> and
+ * <GLOBAL_BASE+0x100 0x300>, which is straight up wrong.
+ * To facilitate for that, while allowing the older, arguably more proper
+ * implementations to work, offset the global registers by -0x100 to avoid
+ * having to map half of the global registers twice.
+ */
+#define BWMON_V4_845_OFFSET			0x100
+#define BWMON_V4_GLOBAL_IRQ_CLEAR_845		(BWMON_V4_GLOBAL_IRQ_CLEAR - BWMON_V4_845_OFFSET)
+#define BWMON_V4_GLOBAL_IRQ_ENABLE_845		(BWMON_V4_GLOBAL_IRQ_ENABLE - BWMON_V4_845_OFFSET)
+
 #define BWMON_V4_IRQ_STATUS			0x100
 #define BWMON_V4_IRQ_CLEAR			0x108
 
@@ -118,8 +131,10 @@
 #define BWMON_NEEDS_FORCE_CLEAR			BIT(1)
 
 enum bwmon_fields {
-	F_GLOBAL_IRQ_CLEAR,
-	F_GLOBAL_IRQ_ENABLE,
+	/* Fields used only on >=SDM845 with BWMON_HAS_GLOBAL_IRQ */
+	F_GLB_IRQ_CLEAR,
+	F_GLB_IRQ_ENABLE,
+
 	F_IRQ_STATUS,
 	F_IRQ_CLEAR,
 	F_IRQ_ENABLE,
@@ -145,6 +160,13 @@ enum bwmon_fields {
 	F_NUM_FIELDS
 };
 
+enum bwmon_global_fields {
+	F_GLOBAL_IRQ_CLEAR,
+	F_GLOBAL_IRQ_ENABLE,
+
+	F_NUM_GLOBAL_FIELDS
+};
+
 struct icc_bwmon_data {
 	unsigned int sample_ms;
 	unsigned int count_unit_kb; /* kbytes */
@@ -157,6 +179,9 @@ struct icc_bwmon_data {
 
 	const struct regmap_config *regmap_cfg;
 	const struct reg_field *regmap_fields;
+
+	const struct regmap_config *global_regmap_cfg;
+	const struct reg_field *global_regmap_fields;
 };
 
 struct icc_bwmon {
@@ -166,6 +191,7 @@ struct icc_bwmon {
 
 	struct regmap *regmap;
 	struct regmap_field *regs[F_NUM_FIELDS];
+	struct regmap_field *global_regs[F_NUM_FIELDS];
 
 	unsigned int max_bw_kbps;
 	unsigned int min_bw_kbps;
@@ -175,8 +201,8 @@ struct icc_bwmon {
 
 /* BWMON v4 */
 static const struct reg_field msm8998_bwmon_reg_fields[] = {
-	[F_GLOBAL_IRQ_CLEAR]	= REG_FIELD(BWMON_V4_GLOBAL_IRQ_CLEAR, 0, 0),
-	[F_GLOBAL_IRQ_ENABLE]	= REG_FIELD(BWMON_V4_GLOBAL_IRQ_ENABLE, 0, 0),
+	[F_GLB_IRQ_CLEAR]	= REG_FIELD(BWMON_V4_GLOBAL_IRQ_CLEAR_845, 0, 0),
+	[F_GLB_IRQ_ENABLE]	= REG_FIELD(BWMON_V4_GLOBAL_IRQ_ENABLE_845, 0, 0),
 	[F_IRQ_STATUS]		= REG_FIELD(BWMON_V4_IRQ_STATUS, 4, 7),
 	[F_IRQ_CLEAR]		= REG_FIELD(BWMON_V4_IRQ_CLEAR, 4, 7),
 	[F_IRQ_ENABLE]		= REG_FIELD(BWMON_V4_IRQ_ENABLE, 4, 7),
@@ -202,7 +228,7 @@ static const struct reg_field msm8998_bwmon_reg_fields[] = {
 };
 
 static const struct regmap_range msm8998_bwmon_reg_noread_ranges[] = {
-	regmap_reg_range(BWMON_V4_GLOBAL_IRQ_CLEAR, BWMON_V4_GLOBAL_IRQ_CLEAR),
+	regmap_reg_range(BWMON_V4_GLOBAL_IRQ_CLEAR_845, BWMON_V4_GLOBAL_IRQ_CLEAR_845),
 	regmap_reg_range(BWMON_V4_IRQ_CLEAR, BWMON_V4_IRQ_CLEAR),
 	regmap_reg_range(BWMON_V4_CLEAR, BWMON_V4_CLEAR),
 };
@@ -222,16 +248,34 @@ static const struct regmap_access_table msm8998_bwmon_reg_volatile_table = {
 	.n_yes_ranges	= ARRAY_SIZE(msm8998_bwmon_reg_volatile_ranges),
 };
 
+static const struct reg_field msm8998_bwmon_global_reg_fields[] = {
+	[F_GLOBAL_IRQ_CLEAR]	= REG_FIELD(BWMON_V4_GLOBAL_IRQ_CLEAR, 0, 0),
+	[F_GLOBAL_IRQ_ENABLE]	= REG_FIELD(BWMON_V4_GLOBAL_IRQ_ENABLE, 0, 0),
+};
+
+static const struct regmap_range msm8998_bwmon_global_reg_noread_ranges[] = {
+	regmap_reg_range(BWMON_V4_GLOBAL_IRQ_CLEAR, BWMON_V4_GLOBAL_IRQ_CLEAR),
+};
+
+static const struct regmap_access_table msm8998_bwmon_global_reg_read_table = {
+	.no_ranges	= msm8998_bwmon_global_reg_noread_ranges,
+	.n_no_ranges	= ARRAY_SIZE(msm8998_bwmon_global_reg_noread_ranges),
+};
+
 /*
  * Fill the cache for non-readable registers only as rest does not really
  * matter and can be read from the device.
  */
 static const struct reg_default msm8998_bwmon_reg_defaults[] = {
-	{ BWMON_V4_GLOBAL_IRQ_CLEAR, 0x0 },
+	{ BWMON_V4_GLOBAL_IRQ_CLEAR_845, 0x0 },
 	{ BWMON_V4_IRQ_CLEAR, 0x0 },
 	{ BWMON_V4_CLEAR, 0x0 },
 };
 
+static const struct reg_default msm8998_bwmon_global_reg_defaults[] = {
+	{ BWMON_V4_GLOBAL_IRQ_CLEAR, 0x0 },
+};
+
 static const struct regmap_config msm8998_bwmon_regmap_cfg = {
 	.reg_bits		= 32,
 	.reg_stride		= 4,
@@ -252,10 +296,27 @@ static const struct regmap_config msm8998_bwmon_regmap_cfg = {
 	.cache_type		= REGCACHE_RBTREE,
 };
 
+static const struct regmap_config msm8998_bwmon_global_regmap_cfg = {
+	.reg_bits		= 32,
+	.reg_stride		= 4,
+	.val_bits		= 32,
+	/*
+	 * No concurrent access expected - driver has one interrupt handler,
+	 * regmap is not shared, no driver or user-space API.
+	 */
+	.disable_locking	= true,
+	.rd_table		= &msm8998_bwmon_global_reg_read_table,
+	.reg_defaults		= msm8998_bwmon_global_reg_defaults,
+	.num_reg_defaults	= ARRAY_SIZE(msm8998_bwmon_global_reg_defaults),
+	/*
+	 * Cache is necessary for using regmap fields with non-readable
+	 * registers.
+	 */
+	.cache_type		= REGCACHE_RBTREE,
+};
+
 /* BWMON v5 */
 static const struct reg_field sdm845_llcc_bwmon_reg_fields[] = {
-	[F_GLOBAL_IRQ_CLEAR]	= {},
-	[F_GLOBAL_IRQ_ENABLE]	= {},
 	[F_IRQ_STATUS]		= REG_FIELD(BWMON_V5_IRQ_STATUS, 0, 3),
 	[F_IRQ_CLEAR]		= REG_FIELD(BWMON_V5_IRQ_CLEAR, 0, 3),
 	[F_IRQ_ENABLE]		= REG_FIELD(BWMON_V5_IRQ_ENABLE, 0, 3),
@@ -369,16 +430,21 @@ static void bwmon_clear_irq(struct icc_bwmon *bwmon)
 	regmap_field_force_write(bwmon->regs[F_IRQ_CLEAR], BWMON_IRQ_ENABLE_MASK);
 	if (bwmon->data->quirks & BWMON_NEEDS_FORCE_CLEAR)
 		regmap_field_force_write(bwmon->regs[F_IRQ_CLEAR], 0);
-	if (bwmon->data->quirks & BWMON_HAS_GLOBAL_IRQ)
-		regmap_field_force_write(bwmon->regs[F_GLOBAL_IRQ_CLEAR],
+	if (bwmon->global_regs[0])
+		regmap_field_force_write(bwmon->global_regs[F_GLOBAL_IRQ_CLEAR],
+					 BWMON_V4_GLOBAL_IRQ_ENABLE_ENABLE);
+	else
+		regmap_field_force_write(bwmon->regs[F_GLB_IRQ_CLEAR],
 					 BWMON_V4_GLOBAL_IRQ_ENABLE_ENABLE);
 }
 
 static void bwmon_disable(struct icc_bwmon *bwmon)
 {
 	/* Disable interrupts. Strict ordering, see bwmon_clear_irq(). */
-	if (bwmon->data->quirks & BWMON_HAS_GLOBAL_IRQ)
-		regmap_field_write(bwmon->regs[F_GLOBAL_IRQ_ENABLE], 0x0);
+	if (bwmon->global_regs[0])
+		regmap_field_write(bwmon->global_regs[F_GLOBAL_IRQ_ENABLE], 0x0);
+	else
+		regmap_field_write(bwmon->regs[F_GLB_IRQ_ENABLE], 0x0);
 	regmap_field_write(bwmon->regs[F_IRQ_ENABLE], 0x0);
 
 	/*
@@ -391,9 +457,13 @@ static void bwmon_disable(struct icc_bwmon *bwmon)
 static void bwmon_enable(struct icc_bwmon *bwmon, unsigned int irq_enable)
 {
 	/* Enable interrupts */
-	if (bwmon->data->quirks & BWMON_HAS_GLOBAL_IRQ)
-		regmap_field_write(bwmon->regs[F_GLOBAL_IRQ_ENABLE],
-				   BWMON_V4_GLOBAL_IRQ_ENABLE_ENABLE);
+	if (bwmon->global_regs[0])
+		regmap_field_write(bwmon->global_regs[F_GLOBAL_IRQ_ENABLE],
+					 BWMON_V4_GLOBAL_IRQ_ENABLE_ENABLE);
+	else
+		regmap_field_write(bwmon->regs[F_GLB_IRQ_ENABLE],
+					 BWMON_V4_GLOBAL_IRQ_ENABLE_ENABLE);
+
 	regmap_field_write(bwmon->regs[F_IRQ_ENABLE], irq_enable);
 
 	/* Enable bwmon */
@@ -556,7 +626,9 @@ static int bwmon_init_regmap(struct platform_device *pdev,
 	struct device *dev = &pdev->dev;
 	void __iomem *base;
 	struct regmap *map;
+	int ret;
 
+	/* Map the monitor base */
 	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
 		return dev_err_probe(dev, PTR_ERR(base),
@@ -567,12 +639,38 @@ static int bwmon_init_regmap(struct platform_device *pdev,
 		return dev_err_probe(dev, PTR_ERR(map),
 				     "failed to initialize regmap\n");
 
+	BUILD_BUG_ON(ARRAY_SIZE(msm8998_bwmon_global_reg_fields) != F_NUM_GLOBAL_FIELDS);
 	BUILD_BUG_ON(ARRAY_SIZE(msm8998_bwmon_reg_fields) != F_NUM_FIELDS);
 	BUILD_BUG_ON(ARRAY_SIZE(sdm845_llcc_bwmon_reg_fields) != F_NUM_FIELDS);
 
-	return devm_regmap_field_bulk_alloc(dev, map, bwmon->regs,
+	ret = devm_regmap_field_bulk_alloc(dev, map, bwmon->regs,
 					   bwmon->data->regmap_fields,
 					   F_NUM_FIELDS);
+	if (ret)
+		return ret;
+
+	if (bwmon->data->quirks & BWMON_HAS_GLOBAL_IRQ) {
+		/* Map the global base, if separate */
+		base = devm_platform_ioremap_resource(pdev, 1);
+
+		/* If it's not, bail out early and assume the 845 register scheme */
+		if (IS_ERR(base) && PTR_ERR(base) == -EINVAL)
+			goto exit;
+		else if (IS_ERR(base))
+			return dev_err_probe(dev, PTR_ERR(base),
+					     "failed to map bwmon global registers\n");
+
+		map = devm_regmap_init_mmio(dev, base, bwmon->data->global_regmap_cfg);
+		if (IS_ERR(map))
+			return dev_err_probe(dev, PTR_ERR(map),
+					     "failed to initialize global regmap\n");
+
+		ret = devm_regmap_field_bulk_alloc(dev, map, bwmon->global_regs,
+						   bwmon->data->global_regmap_fields,
+						   F_NUM_GLOBAL_FIELDS);
+	}
+exit:
+	return ret;
 }
 
 static int bwmon_probe(struct platform_device *pdev)
@@ -645,6 +743,8 @@ static const struct icc_bwmon_data msm8998_bwmon_data = {
 	.quirks = BWMON_HAS_GLOBAL_IRQ,
 	.regmap_fields = msm8998_bwmon_reg_fields,
 	.regmap_cfg = &msm8998_bwmon_regmap_cfg,
+	.global_regmap_fields = msm8998_bwmon_global_reg_fields,
+	.global_regmap_cfg = &msm8998_bwmon_global_regmap_cfg,
 };
 
 static const struct icc_bwmon_data sdm845_llcc_bwmon_data = {

-- 
2.39.2


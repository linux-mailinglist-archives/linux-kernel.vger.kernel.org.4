Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8976BB596
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 15:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233018AbjCOOLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 10:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232946AbjCOOLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 10:11:37 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B29C1521EB
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 07:11:31 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id g17so24500785lfv.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 07:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678889491;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3N7Hjcr2PZGVfKJQdXc+HZpWhdde40yz4tbRtMjIzn4=;
        b=xWHah0xmgpZ/mKNlmVhUkznJxDid2Y2Vrf5LUZ3Hl8dEJSwj3WgHsb+e+rldyq4WxC
         pxy2wlOnjEHRku4STkdF4RBhvMlTQ6ohRE7sY2TEhIzuUxapC2hEL9NZzLUGEXS62j+C
         0cYtCRuVj/5rO19UagynVC5kMo8yL3nuImBKQRjhmHd54M35k/dTog1waO4Z1Hi3LF/L
         j6UH+BkCPOWOhSqiVZFYw66zwWG7esOJwqqD79M1YWme5M6G+OHHzn07k/tNHiYgqby4
         1nfybkLwE8J/umhD7yNLvOkJeRh1ApJfW1tnjAjCZR2Qy+P79Le3ljj95pi/cGlM8VnT
         fNvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678889491;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3N7Hjcr2PZGVfKJQdXc+HZpWhdde40yz4tbRtMjIzn4=;
        b=ACZpmtyJUJrzauKp45koPvE5gTHH7wwd+jkJLpelzxRlXTVDK4WSaR0/TEGTtutrAg
         rZm4H3yvHPByo7XJjWbCK7MsMiCnLVgHkqXwkN3dTpuGgpVuDH8YoMyE/qHarxM3kQyl
         3RGtCM66jH8ceQE4INeLi/pPRVu3ojMSxgAsRD45cgP0Nmc0zYvLMFQUewDX5Nizj9CR
         DauVqjdxAay0UVEEZXoRLs8fnKTp5vBBXIcB7QYguLmPXFW8TzSkYxNWIZXbGkCJ99zz
         dUEK/r7L/Cq5CluflT3HN8TkN9TIwMs1vYnzzQpsfml3S77JHdKZSk11urCDy+kPgnBV
         JyJQ==
X-Gm-Message-State: AO0yUKWyy8D/baCazKlZOeMdAkvp9Gg6lB+ZuwZZKbFPAXhdfmGIcqon
        Lri4vNxrspsyh+H3zSO3Ve4ufQ==
X-Google-Smtp-Source: AK7set808RvWuOaT9i1uSL0FnsaeK8jB0OlgMQ/hLwKTN+gDkPYl2DupbjcE6nOdmMItz4Bb8n9hmw==
X-Received: by 2002:a05:6512:4dc:b0:4e8:49f6:674f with SMTP id w28-20020a05651204dc00b004e849f6674fmr1676008lfq.36.1678889490768;
        Wed, 15 Mar 2023 07:11:30 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id b8-20020ac25e88000000b004e845a08567sm824678lfq.291.2023.03.15.07.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 07:11:30 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 15 Mar 2023 15:11:21 +0100
Subject: [PATCH v3 3/7] soc: qcom: icc-bwmon: Handle global registers
 correctly
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230304-topic-ddr_bwmon-v3-3-77a050c2fbda@linaro.org>
References: <20230304-topic-ddr_bwmon-v3-0-77a050c2fbda@linaro.org>
In-Reply-To: <20230304-topic-ddr_bwmon-v3-0-77a050c2fbda@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678889480; l=15677;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=+E/FiEc3YfiZWKRvWhE0s83huKfmblgyJVvmNE9VGcc=;
 b=MPAGQUW9Hn2+Y1VtmbmgxsPZrEyIeps4lu8VO+suJiPkAhGBWt2wfTAjYfbEzRp/7UCvmuE3YWik
 imobrtXbCIjCvT3VEhaWelor1fEyCqL8MP545yd1ucTeR8YSJxvB
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
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

Handle the case where the global registers are mapped separately to allow
proper functioning of BWMONv4 on MSM8998 and older. Add specific
compatibles for 845, 8280xp, 7280 and 8550 (all of which use the single
reg space scheme) to keep backwards compatibility with old DTs.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/soc/qcom/icc-bwmon.c | 230 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 209 insertions(+), 21 deletions(-)

diff --git a/drivers/soc/qcom/icc-bwmon.c b/drivers/soc/qcom/icc-bwmon.c
index d45caf512e2d..fd58c5b69897 100644
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
 
@@ -118,9 +131,13 @@
 #define BWMON_NEEDS_FORCE_CLEAR			BIT(1)
 
 enum bwmon_fields {
+	/* Global region fields, keep them at the top */
 	F_GLOBAL_IRQ_CLEAR,
 	F_GLOBAL_IRQ_ENABLE,
-	F_IRQ_STATUS,
+	F_NUM_GLOBAL_FIELDS,
+
+	/* Monitor region fields */
+	F_IRQ_STATUS = F_NUM_GLOBAL_FIELDS,
 	F_IRQ_CLEAR,
 	F_IRQ_ENABLE,
 	F_ENABLE,
@@ -157,6 +174,9 @@ struct icc_bwmon_data {
 
 	const struct regmap_config *regmap_cfg;
 	const struct reg_field *regmap_fields;
+
+	const struct regmap_config *global_regmap_cfg;
+	const struct reg_field *global_regmap_fields;
 };
 
 struct icc_bwmon {
@@ -165,6 +185,7 @@ struct icc_bwmon {
 	int irq;
 
 	struct regmap_field *regs[F_NUM_FIELDS];
+	struct regmap_field *global_regs[F_NUM_GLOBAL_FIELDS];
 
 	unsigned int max_bw_kbps;
 	unsigned int min_bw_kbps;
@@ -174,8 +195,8 @@ struct icc_bwmon {
 
 /* BWMON v4 */
 static const struct reg_field msm8998_bwmon_reg_fields[] = {
-	[F_GLOBAL_IRQ_CLEAR]	= REG_FIELD(BWMON_V4_GLOBAL_IRQ_CLEAR, 0, 0),
-	[F_GLOBAL_IRQ_ENABLE]	= REG_FIELD(BWMON_V4_GLOBAL_IRQ_ENABLE, 0, 0),
+	[F_GLOBAL_IRQ_CLEAR]	= {},
+	[F_GLOBAL_IRQ_ENABLE]	= {},
 	[F_IRQ_STATUS]		= REG_FIELD(BWMON_V4_IRQ_STATUS, 4, 7),
 	[F_IRQ_CLEAR]		= REG_FIELD(BWMON_V4_IRQ_CLEAR, 4, 7),
 	[F_IRQ_ENABLE]		= REG_FIELD(BWMON_V4_IRQ_ENABLE, 4, 7),
@@ -201,7 +222,6 @@ static const struct reg_field msm8998_bwmon_reg_fields[] = {
 };
 
 static const struct regmap_range msm8998_bwmon_reg_noread_ranges[] = {
-	regmap_reg_range(BWMON_V4_GLOBAL_IRQ_CLEAR, BWMON_V4_GLOBAL_IRQ_CLEAR),
 	regmap_reg_range(BWMON_V4_IRQ_CLEAR, BWMON_V4_IRQ_CLEAR),
 	regmap_reg_range(BWMON_V4_CLEAR, BWMON_V4_CLEAR),
 };
@@ -221,16 +241,33 @@ static const struct regmap_access_table msm8998_bwmon_reg_volatile_table = {
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
@@ -251,6 +288,93 @@ static const struct regmap_config msm8998_bwmon_regmap_cfg = {
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
+static const struct reg_field sdm845_cpu_bwmon_reg_fields[] = {
+	[F_GLOBAL_IRQ_CLEAR]	= REG_FIELD(BWMON_V4_GLOBAL_IRQ_CLEAR_845, 0, 0),
+	[F_GLOBAL_IRQ_ENABLE]	= REG_FIELD(BWMON_V4_GLOBAL_IRQ_ENABLE_845, 0, 0),
+	[F_IRQ_STATUS]		= REG_FIELD(BWMON_V4_IRQ_STATUS, 4, 7),
+	[F_IRQ_CLEAR]		= REG_FIELD(BWMON_V4_IRQ_CLEAR, 4, 7),
+	[F_IRQ_ENABLE]		= REG_FIELD(BWMON_V4_IRQ_ENABLE, 4, 7),
+	/* F_ENABLE covers entire register to disable other features */
+	[F_ENABLE]		= REG_FIELD(BWMON_V4_ENABLE, 0, 31),
+	[F_CLEAR]		= REG_FIELD(BWMON_V4_CLEAR, 0, 1),
+	[F_SAMPLE_WINDOW]	= REG_FIELD(BWMON_V4_SAMPLE_WINDOW, 0, 23),
+	[F_THRESHOLD_HIGH]	= REG_FIELD(BWMON_V4_THRESHOLD_HIGH, 0, 11),
+	[F_THRESHOLD_MED]	= REG_FIELD(BWMON_V4_THRESHOLD_MED, 0, 11),
+	[F_THRESHOLD_LOW]	= REG_FIELD(BWMON_V4_THRESHOLD_LOW, 0, 11),
+	[F_ZONE_ACTIONS_ZONE0]	= REG_FIELD(BWMON_V4_ZONE_ACTIONS, 0, 7),
+	[F_ZONE_ACTIONS_ZONE1]	= REG_FIELD(BWMON_V4_ZONE_ACTIONS, 8, 15),
+	[F_ZONE_ACTIONS_ZONE2]	= REG_FIELD(BWMON_V4_ZONE_ACTIONS, 16, 23),
+	[F_ZONE_ACTIONS_ZONE3]	= REG_FIELD(BWMON_V4_ZONE_ACTIONS, 24, 31),
+	[F_THRESHOLD_COUNT_ZONE0]	= REG_FIELD(BWMON_V4_THRESHOLD_COUNT, 0, 7),
+	[F_THRESHOLD_COUNT_ZONE1]	= REG_FIELD(BWMON_V4_THRESHOLD_COUNT, 8, 15),
+	[F_THRESHOLD_COUNT_ZONE2]	= REG_FIELD(BWMON_V4_THRESHOLD_COUNT, 16, 23),
+	[F_THRESHOLD_COUNT_ZONE3]	= REG_FIELD(BWMON_V4_THRESHOLD_COUNT, 24, 31),
+	[F_ZONE0_MAX]		= REG_FIELD(BWMON_V4_ZONE_MAX(0), 0, 11),
+	[F_ZONE1_MAX]		= REG_FIELD(BWMON_V4_ZONE_MAX(1), 0, 11),
+	[F_ZONE2_MAX]		= REG_FIELD(BWMON_V4_ZONE_MAX(2), 0, 11),
+	[F_ZONE3_MAX]		= REG_FIELD(BWMON_V4_ZONE_MAX(3), 0, 11),
+};
+
+static const struct regmap_range sdm845_cpu_bwmon_reg_noread_ranges[] = {
+	regmap_reg_range(BWMON_V4_GLOBAL_IRQ_CLEAR_845, BWMON_V4_GLOBAL_IRQ_CLEAR_845),
+	regmap_reg_range(BWMON_V4_IRQ_CLEAR, BWMON_V4_IRQ_CLEAR),
+	regmap_reg_range(BWMON_V4_CLEAR, BWMON_V4_CLEAR),
+};
+
+static const struct regmap_access_table sdm845_cpu_bwmon_reg_read_table = {
+	.no_ranges	= sdm845_cpu_bwmon_reg_noread_ranges,
+	.n_no_ranges	= ARRAY_SIZE(sdm845_cpu_bwmon_reg_noread_ranges),
+};
+
+/*
+ * Fill the cache for non-readable registers only as rest does not really
+ * matter and can be read from the device.
+ */
+static const struct reg_default sdm845_cpu_bwmon_reg_defaults[] = {
+	{ BWMON_V4_GLOBAL_IRQ_CLEAR_845, 0x0 },
+	{ BWMON_V4_IRQ_CLEAR, 0x0 },
+	{ BWMON_V4_CLEAR, 0x0 },
+};
+
+static const struct regmap_config sdm845_cpu_bwmon_regmap_cfg = {
+	.reg_bits		= 32,
+	.reg_stride		= 4,
+	.val_bits		= 32,
+	/*
+	 * No concurrent access expected - driver has one interrupt handler,
+	 * regmap is not shared, no driver or user-space API.
+	 */
+	.disable_locking	= true,
+	.rd_table		= &sdm845_cpu_bwmon_reg_read_table,
+	.volatile_table		= &msm8998_bwmon_reg_volatile_table,
+	.reg_defaults		= sdm845_cpu_bwmon_reg_defaults,
+	.num_reg_defaults	= ARRAY_SIZE(sdm845_cpu_bwmon_reg_defaults),
+	/*
+	 * Cache is necessary for using regmap fields with non-readable
+	 * registers.
+	 */
+	.cache_type		= REGCACHE_RBTREE,
+};
+
 /* BWMON v5 */
 static const struct reg_field sdm845_llcc_bwmon_reg_fields[] = {
 	[F_GLOBAL_IRQ_CLEAR]	= {},
@@ -349,6 +473,13 @@ static void bwmon_clear_counters(struct icc_bwmon *bwmon, bool clear_all)
 
 static void bwmon_clear_irq(struct icc_bwmon *bwmon)
 {
+	struct regmap_field *global_irq_clr;
+
+	if (bwmon->data->global_regmap_fields)
+		global_irq_clr = bwmon->global_regs[F_GLOBAL_IRQ_CLEAR];
+	else
+		global_irq_clr = bwmon->regs[F_GLOBAL_IRQ_CLEAR];
+
 	/*
 	 * Clear zone and global interrupts. The order and barriers are
 	 * important. Quoting downstream Qualcomm msm-4.9 tree:
@@ -369,15 +500,22 @@ static void bwmon_clear_irq(struct icc_bwmon *bwmon)
 	if (bwmon->data->quirks & BWMON_NEEDS_FORCE_CLEAR)
 		regmap_field_force_write(bwmon->regs[F_IRQ_CLEAR], 0);
 	if (bwmon->data->quirks & BWMON_HAS_GLOBAL_IRQ)
-		regmap_field_force_write(bwmon->regs[F_GLOBAL_IRQ_CLEAR],
+		regmap_field_force_write(global_irq_clr,
 					 BWMON_V4_GLOBAL_IRQ_ENABLE_ENABLE);
 }
 
 static void bwmon_disable(struct icc_bwmon *bwmon)
 {
+	struct regmap_field *global_irq_en;
+
+	if (bwmon->data->global_regmap_fields)
+		global_irq_en = bwmon->global_regs[F_GLOBAL_IRQ_ENABLE];
+	else
+		global_irq_en = bwmon->regs[F_GLOBAL_IRQ_ENABLE];
+
 	/* Disable interrupts. Strict ordering, see bwmon_clear_irq(). */
 	if (bwmon->data->quirks & BWMON_HAS_GLOBAL_IRQ)
-		regmap_field_write(bwmon->regs[F_GLOBAL_IRQ_ENABLE], 0x0);
+		regmap_field_write(global_irq_en, 0x0);
 	regmap_field_write(bwmon->regs[F_IRQ_ENABLE], 0x0);
 
 	/*
@@ -389,10 +527,18 @@ static void bwmon_disable(struct icc_bwmon *bwmon)
 
 static void bwmon_enable(struct icc_bwmon *bwmon, unsigned int irq_enable)
 {
+	struct regmap_field *global_irq_en;
+
+	if (bwmon->data->global_regmap_fields)
+		global_irq_en = bwmon->global_regs[F_GLOBAL_IRQ_ENABLE];
+	else
+		global_irq_en = bwmon->regs[F_GLOBAL_IRQ_ENABLE];
+
 	/* Enable interrupts */
 	if (bwmon->data->quirks & BWMON_HAS_GLOBAL_IRQ)
-		regmap_field_write(bwmon->regs[F_GLOBAL_IRQ_ENABLE],
+		regmap_field_write(global_irq_en,
 				   BWMON_V4_GLOBAL_IRQ_ENABLE_ENABLE);
+
 	regmap_field_write(bwmon->regs[F_IRQ_ENABLE], irq_enable);
 
 	/* Enable bwmon */
@@ -555,7 +701,9 @@ static int bwmon_init_regmap(struct platform_device *pdev,
 	struct device *dev = &pdev->dev;
 	void __iomem *base;
 	struct regmap *map;
+	int ret;
 
+	/* Map the monitor base */
 	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
 		return dev_err_probe(dev, PTR_ERR(base),
@@ -566,12 +714,35 @@ static int bwmon_init_regmap(struct platform_device *pdev,
 		return dev_err_probe(dev, PTR_ERR(map),
 				     "failed to initialize regmap\n");
 
+	BUILD_BUG_ON(ARRAY_SIZE(msm8998_bwmon_global_reg_fields) != F_NUM_GLOBAL_FIELDS);
 	BUILD_BUG_ON(ARRAY_SIZE(msm8998_bwmon_reg_fields) != F_NUM_FIELDS);
+	BUILD_BUG_ON(ARRAY_SIZE(sdm845_cpu_bwmon_reg_fields) != F_NUM_FIELDS);
 	BUILD_BUG_ON(ARRAY_SIZE(sdm845_llcc_bwmon_reg_fields) != F_NUM_FIELDS);
 
-	return devm_regmap_field_bulk_alloc(dev, map, bwmon->regs,
+	ret = devm_regmap_field_bulk_alloc(dev, map, bwmon->regs,
 					   bwmon->data->regmap_fields,
 					   F_NUM_FIELDS);
+	if (ret)
+		return ret;
+
+	if (bwmon->data->global_regmap_cfg) {
+		/* Map the global base, if separate */
+		base = devm_platform_ioremap_resource(pdev, 1);
+		if (IS_ERR(base))
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
+
+	return ret;
 }
 
 static int bwmon_probe(struct platform_device *pdev)
@@ -644,6 +815,21 @@ static const struct icc_bwmon_data msm8998_bwmon_data = {
 	.quirks = BWMON_HAS_GLOBAL_IRQ,
 	.regmap_fields = msm8998_bwmon_reg_fields,
 	.regmap_cfg = &msm8998_bwmon_regmap_cfg,
+	.global_regmap_fields = msm8998_bwmon_global_reg_fields,
+	.global_regmap_cfg = &msm8998_bwmon_global_regmap_cfg,
+};
+
+static const struct icc_bwmon_data sdm845_cpu_bwmon_data = {
+	.sample_ms = 4,
+	.count_unit_kb = 64,
+	.default_highbw_kbps = 4800 * 1024, /* 4.8 GBps */
+	.default_medbw_kbps = 512 * 1024, /* 512 MBps */
+	.default_lowbw_kbps = 0,
+	.zone1_thres_count = 16,
+	.zone3_thres_count = 1,
+	.quirks = BWMON_HAS_GLOBAL_IRQ,
+	.regmap_fields = sdm845_cpu_bwmon_reg_fields,
+	.regmap_cfg = &sdm845_cpu_bwmon_regmap_cfg,
 };
 
 static const struct icc_bwmon_data sdm845_llcc_bwmon_data = {
@@ -672,16 +858,18 @@ static const struct icc_bwmon_data sc7280_llcc_bwmon_data = {
 };
 
 static const struct of_device_id bwmon_of_match[] = {
-	{
-		.compatible = "qcom,msm8998-bwmon",
-		.data = &msm8998_bwmon_data
-	}, {
-		.compatible = "qcom,sdm845-llcc-bwmon",
-		.data = &sdm845_llcc_bwmon_data
-	}, {
-		.compatible = "qcom,sc7280-llcc-bwmon",
-		.data = &sc7280_llcc_bwmon_data
-	},
+	/* BWMONv4, separate monitor and global register spaces */
+	{ .compatible = "qcom,msm8998-bwmon", .data = &msm8998_bwmon_data },
+	/* BWMONv4, unified register space */
+	{ .compatible = "qcom,sdm845-bwmon", .data = &sdm845_cpu_bwmon_data },
+	/* BWMONv5 */
+	{ .compatible = "qcom,sdm845-llcc-bwmon", .data = &sdm845_llcc_bwmon_data },
+	{ .compatible = "qcom,sc7280-llcc-bwmon", .data = &sc7280_llcc_bwmon_data },
+
+	/* Compatibles kept for legacy reasons */
+	{ .compatible = "qcom,sc7280-cpu-bwmon", .data = &sdm845_cpu_bwmon_data },
+	{ .compatible = "qcom,sc8280xp-cpu-bwmon", .data = &sdm845_cpu_bwmon_data },
+	{ .compatible = "qcom,sm8550-cpu-bwmon", .data = &sdm845_cpu_bwmon_data },
 	{}
 };
 MODULE_DEVICE_TABLE(of, bwmon_of_match);

-- 
2.39.2


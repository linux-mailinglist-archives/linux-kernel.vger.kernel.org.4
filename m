Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C72936DAE7D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 15:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240400AbjDGN6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 09:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbjDGN6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 09:58:21 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2031.outbound.protection.outlook.com [40.92.98.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93DD99749;
        Fri,  7 Apr 2023 06:58:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eF9XzQ8PtINTBtnblJE7AcXA+tsfnSHS/1Su/DMjxtV6Y5o0uomhAOtUBJwsz/lxyLjBEopFEdfZ9zXUYO1iCVG90kJiSi08Py7rMZ1yBdg+Wdcu9rizaFFCdlmV7EfKrqV+PpBnfNOMI1mC1a5U8GefwWqk5iiDD7iKrMeGqUsB/+sGh5JxFpPIRA2sWbSKwQuFlPwiDW7J5egPVPZtzM/5VCCXjcz6TPrTEkUWiPomm6hNDN1ABCxOgzuZvo+jp2iSqB3zemhFZFwWWxmVrxRZ47f0kDNi160hfWhMQcFAFEdhSlA4gMtc3B5PM8drP75jrd1iskXcKP9QLCYz4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oNdydiTzpJyZPcWN9hLe/9xc7/iFeYG00TjZn+iHq5g=;
 b=WcRQs4TppN1BQ+bWk43NFBMVrTn+16HXOihU2W/19DhsSQv/ibMHKWjuhwjvM06ujsHWXBDQK+/nK/458YGJYiiZYGf9tu9b48zGsys493ATA95nr415BO97289AeVBbMLw/sB3rn0nQt7moa8jmjyazT21anUSLoOeWbH/3ySvhJJgGCKONRBqbjJD1IqjTXXq0AE8BXD43U8lJE8XfVXR7YU4pLUxTycPUcKatQ5ERKLMvWzd8gZttx6r69s4CrLH82FhK1nZ8k5LxVeAAiYBCgo7sMog1zDOpjFjOPCCjdsyj7LsXRL2idN5PZT6gq9BF4xqnd8D0eqYu87J/iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oNdydiTzpJyZPcWN9hLe/9xc7/iFeYG00TjZn+iHq5g=;
 b=itPtUJUh85QvhXdT3mRmZledDXuJKBptohfv3OiBnwlzBP2rW+c3UM/CJ5tBE/XZto5416AMVoZGgdof6LMX376rZLEjMtkFETLGobLPas5SZgdXxlgTRuPcqimiUdzDlQpvrcmpbKHcNqW3rd5ue8Lo1GTAnk7QYGVGGdlABZSEscAMFmKVZ1vVJW9/Gw+Dfu50yA0FUi7fjyIsGqGwItmHI7KEIi+71WcpHzohwdY4Jx+jBGk5LbTyRsuf4e88qlk3ndfAz0dUFN2jl5I6eSd3VK/kYolTeA20BBjK/XbdAnhqD0ZLWQ331QJRQwhfJEDIrQZB01S1qRHH6D49kg==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:252::12)
 by OSZP286MB2208.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:18d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.35; Fri, 7 Apr
 2023 13:58:09 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::d190:6e4d:5a1e:59a]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::d190:6e4d:5a1e:59a%3]) with mapi id 15.20.6277.033; Fri, 7 Apr 2023
 13:58:09 +0000
From:   Shengyu Qu <wiagn233@outlook.com>
To:     lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org,
        lgirdwood@gmail.com, broonie@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Shengyu Qu <wiagn233@outlook.com>
Subject: [PATCH v1 2/4] mfd: axp20x: Add support for AXP15060 PMIC
Date:   Fri,  7 Apr 2023 21:57:15 +0800
Message-ID: <TY3P286MB261143DE18C43F6C9333E43998969@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230407135717.17381-1-wiagn233@outlook.com>
References: <20230407135717.17381-1-wiagn233@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [8jLPweEiGCVYOHPXxBCM4a4KLpncsKCM]
X-ClientProxiedBy: SJ0PR05CA0050.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::25) To TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:252::12)
X-Microsoft-Original-Message-ID: <20230407135717.17381-3-wiagn233@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2611:EE_|OSZP286MB2208:EE_
X-MS-Office365-Filtering-Correlation-Id: 7529450c-a03c-49e2-c9cc-08db37701e6f
X-MS-Exchange-SLBlob-MailProps: AZnQBsB9Xmovywdyt6JbrF6Sw9xOtJaeKrvFgPLelwiouCg4lKyp/mivNGUePMraoF3KmOqFohA53T9g9bwD/Fp+kD1S9TbusjhWIVvAZsAvM+aeFhJ3Te9JQjCElerYfXKZ0s5Fu2+P37WrTWp/Q6riYgeOu0y4sOsJsLzCBr6XForwolHAKFH2fjCGs5bwALpC63fHdDIzZizYY9MhnOtbPYBkHjk4qhLmkRGvXUjKWuQgwdwb4FrpRCe83N0xvrc9a3s3SGTldnaxZV83SKCFt920tC7EZhmYcBxSN71+zMbTGz3IucrK3nzXz02+oJ8sLf03oLQchz6yyT+8qMe98xW1fbPiZzVYPkrdLxSP4dbAf9bB6UZmkYgofMl7PY91FuxCfzfUCO3pu7tZqraceDPuc1WSL5UrpDfyTO0L4XSKXOpaXg9BtFsDbtCMZo0WL/NityXAdPxTQOCdN3GlStQjwWal0/OzTCjokkEV1Uoms8Rt++6hCGRKKdCNqMbTBnPr0CegCQBjbPpj2Jqk6o9TsCYSvvXNgn5QW+vE5hwp/zsAYTjJFGaQvDlMGXsY9KZZjnAvb4DHX1iPTv1YANj3j3FdlQY8dtp6GCU5/YHxChP2DFxOQR3LlVAHAQSVrIPIpR0XjzCbUQplsJicNQA7/d+18Uh0nybX90+yfSkZta/MlsOkFjkr/U34Oj0ycJs9YeHJI85AVfn0nbDWEOYh5FMMYw6jBJhpvnh8LOfWcEjEnJKx3PkmIjMkrrxtP+538VA=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FyaYpJzGJh97256vPRIiPOTuCKy+LVHBh+UVjTPKq5trhDeI+mSBCzQh8Hr/YBQZD5SHuYuQBfnc/VVWqBuFDpQfbwk51OMngWzxDqFkpeZ0FKkZ+P49qjP6vTrd2qRkdeU4cjCpBq7g0SUD7btalcqn+aaW+ZYRlA5TFqilVCsdTRZM5WtVgXmCTCLyQIT/y69TB0diR36xSaG79n7v64/fgKPKmr5hXI3ofSc/1tgjX495BeKq2n2QAmyjXBZz/8Pdn7bs2O0qSE/kGgHhhbE1HuZd1lrml0O76l/P4XcWgBm6aJXfF+cykj0T9iTPw//GMmmxec0VFyEysEO1J0IzM3ymSRcNQQ0t3XFxBxj9bCO2vPaGI0zOw6ivRFHWfQr52os90UBd9E2n+1g58JyYgj0lxsy4NPRuh9VbkKsvJ4Mcoqe0VGLkMC832SgZLHfxbTNqQUaVZPQ3gSl/tv1+l15kcNX/XTIWVoBvWd6/GLhwhEqfpHzjFwY1lwNLqOYTcKj2D16JzBhcjCz3qm8HSzfDEcqMrwrEbG3fmqRg3ZN+NwJ19xJdd5zr09GjS5kzhYjE+nLDA+dYXUbXhDfbIH1IZpftI5twK1iD+saKLrXrYQFyPrkZLUXQN8A8
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?av4OWTO+CegGRYP/1x5y+5jrPXf7qp8xBiMJNUhLDAzgoHzl23dp5vM60FJz?=
 =?us-ascii?Q?SWRfh+eOGGjXZfKygn87Fwudu9PC+8e9nh7/rb1gjTSc4GXNIWZYOn9/+/YM?=
 =?us-ascii?Q?ULb61ha5os7YVYxUu4btat3khA2qq4h0CmD/LQSy0ioD6KT2UQ6iaE1phdtr?=
 =?us-ascii?Q?pBJyB5/u8OgxeT+1BP3szweh17/UuQtukHt508H1AreKzmWJa2KxukMIsJTe?=
 =?us-ascii?Q?aK9vbJq6HNfpVqwHsfgzcCrxuazgkBCG2GNtk3Wbn8Yqe4xL5WXUY+uEZyF5?=
 =?us-ascii?Q?5BydkJ7v04SkBnPWKNRuep+12rDLXLSEsNz0vQ4OnWh8qxuvqwqV8KNG2Pok?=
 =?us-ascii?Q?h/w48QlvtOTGrsM5ZbPqgKqbdl9a52k0WdJvCmACTrHNaVF6czbhQPPT92Yj?=
 =?us-ascii?Q?Bkz9RKq0eqTZ0l/mfZqANtWvBBhBOM/G1TTrZ/DYq5MrNR568lcR0IypKO+a?=
 =?us-ascii?Q?qcgNjIoltsxiiJ9V0Fbpmdy12LsNwxmgASgS8BwYLLzvB6zOcoWt6dry6+26?=
 =?us-ascii?Q?DJL2OdBuycejD+IDS0T8BEss08JOlNVRSRdJfsS+skxly36oWO6fEGuklcmP?=
 =?us-ascii?Q?W0PrJb0egqIY8ymVzOyvBzNZXj9HcKgsxF3gxCJh0Ierv42h1BpoUhUP0b32?=
 =?us-ascii?Q?IwLSEdGwq57sYDQoX2x0Tn/WX1nxi/xVdatLX8F8J3lQf+e0o9J3PuSyoTzb?=
 =?us-ascii?Q?4khF+HLO/l9CvIpBMBoXYCCzw82fXOaPSRDUyEEn2JEEwG4Uaz4deedaRQhf?=
 =?us-ascii?Q?DDg15FhZidfeXbzozC31kSDGjh1VcJMEbUL7nQoOMqlI9UcZ3vHfr5Nnj0RU?=
 =?us-ascii?Q?AAOGrJwgF9gahkrR0eYrDCoI4QnTeVBUXGC8Jyc0DMt4FE1RUJdh+tpgeM/b?=
 =?us-ascii?Q?0EumySXXZys4W12iLp6yMg7+LODGwlwIn9nCIr7TPwNokAFIw5iE8empxo1G?=
 =?us-ascii?Q?mJqb+fTm6scO5NROyCElo7wYFoUHIykTxbeHW4rSNS3yOMWpyh2lFHvogwWT?=
 =?us-ascii?Q?8x7hMjW1a4Te/pbx0rIPCYHLQC3opnnrBjtFBDgVY7ODKF7KY2u/lqunveZM?=
 =?us-ascii?Q?FPA6tcBhgdgfTt6prKphwPs+vkl04bsrF9M1BfOREU0Uix1Yzhsl4CDQ0ESO?=
 =?us-ascii?Q?OuinwHJ/tCwEu/yhw5bmOtMN6usrlvIejcuBd7fbD1B/uaSlbHf9FAf4r91D?=
 =?us-ascii?Q?a/WwiukUyZXLPOI1V0tQTzRAdYBTWAlQlbyNiQ=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7529450c-a03c-49e2-c9cc-08db37701e6f
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2023 13:58:09.5352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZP286MB2208
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AXP15060 is a PMIC chip produced by X-Powers, and could be connected
via an I2C bus.

Describe the regmap and the MFD bits, along with the registers exposed
via I2C. Eventually advertise the device using a new compatible string
and add support for power off the system.

The driver would disable PEK function if IRQ is not configured in device
tree, since some boards (For example, Starfive Visionfive 2) didn't
connect IRQ line of PMIC to SOC.

GPIO function isn't enabled in this commit, since its configuration
operation is different from any existing AXP PMICs and needs
logic modification on existing driver. GPIO support might come in later
patches.

Signed-off-by: Shengyu Qu <wiagn233@outlook.com>
---
 drivers/mfd/axp20x-i2c.c   |  2 +
 drivers/mfd/axp20x.c       | 90 ++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/axp20x.h | 85 +++++++++++++++++++++++++++++++++++
 3 files changed, 177 insertions(+)

diff --git a/drivers/mfd/axp20x-i2c.c b/drivers/mfd/axp20x-i2c.c
index f49fbd307958..b4f5cb457117 100644
--- a/drivers/mfd/axp20x-i2c.c
+++ b/drivers/mfd/axp20x-i2c.c
@@ -65,6 +65,7 @@ static const struct of_device_id axp20x_i2c_of_match[] = {
 	{ .compatible = "x-powers,axp223", .data = (void *)AXP223_ID },
 	{ .compatible = "x-powers,axp803", .data = (void *)AXP803_ID },
 	{ .compatible = "x-powers,axp806", .data = (void *)AXP806_ID },
+	{ .compatible = "x-powers,axp15060", .data = (void *)AXP15060_ID },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, axp20x_i2c_of_match);
@@ -78,6 +79,7 @@ static const struct i2c_device_id axp20x_i2c_id[] = {
 	{ "axp223", 0 },
 	{ "axp803", 0 },
 	{ "axp806", 0 },
+	{ "axp15060", 0 },
 	{ },
 };
 MODULE_DEVICE_TABLE(i2c, axp20x_i2c_id);
diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index 01a6bbb6d266..42ec27a4dfc4 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -43,6 +43,7 @@ static const char * const axp20x_model_names[] = {
 	"AXP806",
 	"AXP809",
 	"AXP813",
+	"AXP15060",
 };
 
 static const struct regmap_range axp152_writeable_ranges[] = {
@@ -168,6 +169,31 @@ static const struct regmap_access_table axp806_volatile_table = {
 	.n_yes_ranges	= ARRAY_SIZE(axp806_volatile_ranges),
 };
 
+static const struct regmap_range axp15060_writeable_ranges[] = {
+	regmap_reg_range(AXP15060_PWR_OUT_CTRL1, AXP15060_DCDC_MODE_CTRL2),
+	regmap_reg_range(AXP15060_OUTPUT_MONITOR_DISCHARGE, AXP15060_CPUSLDO_V_CTRL),
+	regmap_reg_range(AXP15060_PWR_WAKEUP_CTRL, AXP15060_PWR_DISABLE_DOWN_SEQ),
+	regmap_reg_range(AXP15060_PEK_KEY, AXP15060_PEK_KEY),
+	regmap_reg_range(AXP15060_IRQ1_EN, AXP15060_IRQ2_EN),
+	regmap_reg_range(AXP15060_IRQ1_STATE, AXP15060_IRQ2_STATE),
+};
+
+static const struct regmap_range axp15060_volatile_ranges[] = {
+	regmap_reg_range(AXP15060_STARTUP_SRC, AXP15060_STARTUP_SRC),
+	regmap_reg_range(AXP15060_PWR_WAKEUP_CTRL, AXP15060_PWR_DISABLE_DOWN_SEQ),
+	regmap_reg_range(AXP15060_IRQ1_STATE, AXP15060_IRQ2_STATE),
+};
+
+static const struct regmap_access_table axp15060_writeable_table = {
+	.yes_ranges	= axp15060_writeable_ranges,
+	.n_yes_ranges	= ARRAY_SIZE(axp15060_writeable_ranges),
+};
+
+static const struct regmap_access_table axp15060_volatile_table = {
+	.yes_ranges	= axp15060_volatile_ranges,
+	.n_yes_ranges	= ARRAY_SIZE(axp15060_volatile_ranges),
+};
+
 static const struct resource axp152_pek_resources[] = {
 	DEFINE_RES_IRQ_NAMED(AXP152_IRQ_PEK_RIS_EDGE, "PEK_DBR"),
 	DEFINE_RES_IRQ_NAMED(AXP152_IRQ_PEK_FAL_EDGE, "PEK_DBF"),
@@ -236,6 +262,11 @@ static const struct resource axp809_pek_resources[] = {
 	DEFINE_RES_IRQ_NAMED(AXP809_IRQ_PEK_FAL_EDGE, "PEK_DBF"),
 };
 
+static const struct resource axp15060_pek_resources[] = {
+	DEFINE_RES_IRQ_NAMED(AXP15060_IRQ_PEK_RIS_EDGE, "PEK_DBR"),
+	DEFINE_RES_IRQ_NAMED(AXP15060_IRQ_PEK_FAL_EDGE, "PEK_DBF"),
+};
+
 static const struct regmap_config axp152_regmap_config = {
 	.reg_bits	= 8,
 	.val_bits	= 8,
@@ -281,6 +312,15 @@ static const struct regmap_config axp806_regmap_config = {
 	.cache_type	= REGCACHE_RBTREE,
 };
 
+static const struct regmap_config axp15060_regmap_config = {
+	.reg_bits	= 8,
+	.val_bits	= 8,
+	.wr_table	= &axp15060_writeable_table,
+	.volatile_table	= &axp15060_volatile_table,
+	.max_register	= AXP15060_IRQ2_STATE,
+	.cache_type	= REGCACHE_RBTREE,
+};
+
 #define INIT_REGMAP_IRQ(_variant, _irq, _off, _mask)			\
 	[_variant##_IRQ_##_irq] = { .reg_offset = (_off), .mask = BIT(_mask) }
 
@@ -502,6 +542,23 @@ static const struct regmap_irq axp809_regmap_irqs[] = {
 	INIT_REGMAP_IRQ(AXP809, GPIO0_INPUT,		4, 0),
 };
 
+static const struct regmap_irq axp15060_regmap_irqs[] = {
+	INIT_REGMAP_IRQ(AXP15060, DIE_TEMP_HIGH_LV1,	0, 0),
+	INIT_REGMAP_IRQ(AXP15060, DIE_TEMP_HIGH_LV2,	0, 1),
+	INIT_REGMAP_IRQ(AXP15060, DCDC1_V_LOW,		0, 2),
+	INIT_REGMAP_IRQ(AXP15060, DCDC2_V_LOW,		0, 3),
+	INIT_REGMAP_IRQ(AXP15060, DCDC3_V_LOW,		0, 4),
+	INIT_REGMAP_IRQ(AXP15060, DCDC4_V_LOW,		0, 5),
+	INIT_REGMAP_IRQ(AXP15060, DCDC5_V_LOW,		0, 6),
+	INIT_REGMAP_IRQ(AXP15060, DCDC6_V_LOW,		0, 7),
+	INIT_REGMAP_IRQ(AXP15060, PEK_LONG,			1, 0),
+	INIT_REGMAP_IRQ(AXP15060, PEK_SHORT,			1, 1),
+	INIT_REGMAP_IRQ(AXP15060, GPIO1_INPUT,		1, 2),
+	INIT_REGMAP_IRQ(AXP15060, PEK_FAL_EDGE,			1, 3),
+	INIT_REGMAP_IRQ(AXP15060, PEK_RIS_EDGE,			1, 4),
+	INIT_REGMAP_IRQ(AXP15060, GPIO2_INPUT,		1, 5),
+};
+
 static const struct regmap_irq_chip axp152_regmap_irq_chip = {
 	.name			= "axp152_irq_chip",
 	.status_base		= AXP152_IRQ1_STATE,
@@ -581,6 +638,17 @@ static const struct regmap_irq_chip axp809_regmap_irq_chip = {
 	.num_regs		= 5,
 };
 
+static const struct regmap_irq_chip axp15060_regmap_irq_chip = {
+	.name			= "axp15060",
+	.status_base		= AXP15060_IRQ1_STATE,
+	.ack_base		= AXP15060_IRQ1_STATE,
+	.unmask_base		= AXP15060_IRQ1_EN,
+	.init_ack_masked	= true,
+	.irqs			= axp15060_regmap_irqs,
+	.num_irqs		= ARRAY_SIZE(axp15060_regmap_irqs),
+	.num_regs		= 2,
+};
+
 static const struct mfd_cell axp20x_cells[] = {
 	{
 		.name		= "axp20x-gpio",
@@ -825,6 +893,16 @@ static const struct mfd_cell axp813_cells[] = {
 	},
 };
 
+static const struct mfd_cell axp15060_cells[] = {
+	{
+		.name		= "axp221-pek",
+		.num_resources	= ARRAY_SIZE(axp15060_pek_resources),
+		.resources	= axp15060_pek_resources,
+	}, {
+		.name		= "axp20x-regulator",
+	},
+};
+
 static int axp20x_power_off(struct sys_off_data *data)
 {
 	struct axp20x_dev *axp20x = data->cb_data;
@@ -934,6 +1012,18 @@ int axp20x_match_device(struct axp20x_dev *axp20x)
 		 */
 		axp20x->regmap_irq_chip = &axp803_regmap_irq_chip;
 		break;
+	case AXP15060_ID:
+		/* Don't register the power key part if there is no interrupt line. */
+		if (axp20x->irq > 0) {
+			axp20x->nr_cells = ARRAY_SIZE(axp15060_cells);
+			axp20x->cells = axp15060_cells;
+		} else {
+			axp20x->nr_cells = ARRAY_SIZE(axp806_cells);
+			axp20x->cells = axp806_cells;
+		}
+		axp20x->regmap_cfg = &axp15060_regmap_config;
+		axp20x->regmap_irq_chip = &axp15060_regmap_irq_chip;
+		break;
 	default:
 		dev_err(dev, "unsupported AXP20X ID %lu\n", axp20x->variant);
 		return -EINVAL;
diff --git a/include/linux/mfd/axp20x.h b/include/linux/mfd/axp20x.h
index 2058194807bd..abc2bdc54bf5 100644
--- a/include/linux/mfd/axp20x.h
+++ b/include/linux/mfd/axp20x.h
@@ -21,6 +21,7 @@ enum axp20x_variants {
 	AXP806_ID,
 	AXP809_ID,
 	AXP813_ID,
+	AXP15060_ID,
 	NR_AXP20X_VARIANTS,
 };
 
@@ -131,6 +132,39 @@ enum axp20x_variants {
 /* Other DCDC regulator control registers are the same as AXP803 */
 #define AXP813_DCDC7_V_OUT		0x26
 
+#define AXP15060_STARTUP_SRC		0x00
+#define AXP15060_PWR_OUT_CTRL1		0x10
+#define AXP15060_PWR_OUT_CTRL2		0x11
+#define AXP15060_PWR_OUT_CTRL3		0x12
+#define AXP15060_DCDC1_V_CTRL		0x13
+#define AXP15060_DCDC2_V_CTRL		0x14
+#define AXP15060_DCDC3_V_CTRL		0x15
+#define AXP15060_DCDC4_V_CTRL		0x16
+#define AXP15060_DCDC5_V_CTRL		0x17
+#define AXP15060_DCDC6_V_CTRL		0x18
+#define AXP15060_ALDO1_V_CTRL		0x19
+#define AXP15060_DCDC_MODE_CTRL1		0x1a
+#define AXP15060_DCDC_MODE_CTRL2		0x1b
+#define AXP15060_OUTPUT_MONITOR_DISCHARGE		0x1e
+#define AXP15060_IRQ_PWROK_VOFF		0x1f
+#define AXP15060_ALDO2_V_CTRL		0x20
+#define AXP15060_ALDO3_V_CTRL		0x21
+#define AXP15060_ALDO4_V_CTRL		0x22
+#define AXP15060_ALDO5_V_CTRL		0x23
+#define AXP15060_BLDO1_V_CTRL		0x24
+#define AXP15060_BLDO2_V_CTRL		0x25
+#define AXP15060_BLDO3_V_CTRL		0x26
+#define AXP15060_BLDO4_V_CTRL		0x27
+#define AXP15060_BLDO5_V_CTRL		0x28
+#define AXP15060_CLDO1_V_CTRL		0x29
+#define AXP15060_CLDO2_V_CTRL		0x2a
+#define AXP15060_CLDO3_V_CTRL		0x2b
+#define AXP15060_CLDO4_V_CTRL		0x2d
+#define AXP15060_CPUSLDO_V_CTRL		0x2e
+#define AXP15060_PWR_WAKEUP_CTRL		0x31
+#define AXP15060_PWR_DISABLE_DOWN_SEQ		0x32
+#define AXP15060_PEK_KEY		0x36
+
 /* Interrupt */
 #define AXP152_IRQ1_EN			0x40
 #define AXP152_IRQ2_EN			0x41
@@ -139,6 +173,11 @@ enum axp20x_variants {
 #define AXP152_IRQ2_STATE		0x49
 #define AXP152_IRQ3_STATE		0x4a
 
+#define AXP15060_IRQ1_EN		0x40
+#define AXP15060_IRQ2_EN		0x41
+#define AXP15060_IRQ1_STATE		0x48
+#define AXP15060_IRQ2_STATE		0x49
+
 #define AXP20X_IRQ1_EN			0x40
 #define AXP20X_IRQ2_EN			0x41
 #define AXP20X_IRQ3_EN			0x42
@@ -222,6 +261,8 @@ enum axp20x_variants {
 #define AXP22X_GPIO_STATE		0x94
 #define AXP22X_GPIO_PULL_DOWN		0x95
 
+#define AXP15060_CLDO4_GPIO2_MODESET		0x2c
+
 /* Battery */
 #define AXP20X_CHRG_CC_31_24		0xb0
 #define AXP20X_CHRG_CC_23_16		0xb1
@@ -419,6 +460,33 @@ enum {
 	AXP813_REG_ID_MAX,
 };
 
+enum {
+	AXP15060_DCDC1 = 0,
+	AXP15060_DCDC2,
+	AXP15060_DCDC3,
+	AXP15060_DCDC4,
+	AXP15060_DCDC5,
+	AXP15060_DCDC6,
+	AXP15060_ALDO1,
+	AXP15060_ALDO2,
+	AXP15060_ALDO3,
+	AXP15060_ALDO4,
+	AXP15060_ALDO5,
+	AXP15060_BLDO1,
+	AXP15060_BLDO2,
+	AXP15060_BLDO3,
+	AXP15060_BLDO4,
+	AXP15060_BLDO5,
+	AXP15060_CLDO1,
+	AXP15060_CLDO2,
+	AXP15060_CLDO3,
+	AXP15060_CLDO4,
+	AXP15060_CPUSLDO,
+	AXP15060_SW,
+	AXP15060_RTC_LDO,
+	AXP15060_REG_ID_MAX,
+};
+
 /* IRQs */
 enum {
 	AXP152_IRQ_LDO0IN_CONNECT = 1,
@@ -637,6 +705,23 @@ enum axp809_irqs {
 	AXP809_IRQ_GPIO0_INPUT,
 };
 
+enum axp15060_irqs {
+	AXP15060_IRQ_DIE_TEMP_HIGH_LV1 = 1,
+	AXP15060_IRQ_DIE_TEMP_HIGH_LV2,
+	AXP15060_IRQ_DCDC1_V_LOW,
+	AXP15060_IRQ_DCDC2_V_LOW,
+	AXP15060_IRQ_DCDC3_V_LOW,
+	AXP15060_IRQ_DCDC4_V_LOW,
+	AXP15060_IRQ_DCDC5_V_LOW,
+	AXP15060_IRQ_DCDC6_V_LOW,
+	AXP15060_IRQ_PEK_LONG,
+	AXP15060_IRQ_PEK_SHORT,
+	AXP15060_IRQ_GPIO1_INPUT,
+	AXP15060_IRQ_PEK_FAL_EDGE,
+	AXP15060_IRQ_PEK_RIS_EDGE,
+	AXP15060_IRQ_GPIO2_INPUT,
+};
+
 struct axp20x_dev {
 	struct device			*dev;
 	int				irq;
-- 
2.25.1


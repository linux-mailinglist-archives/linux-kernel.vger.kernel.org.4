Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4946DAEC3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 16:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240726AbjDGOT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 10:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232209AbjDGOTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 10:19:11 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2055.outbound.protection.outlook.com [40.92.98.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2629C86A6;
        Fri,  7 Apr 2023 07:19:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aMv9CYpjPeePTP2I5mch41cAI4RqKlLP7IQJ3Z8k3LtMw1wWOEtJFJtMqjQD7cWrg8OSDXL8USI305pLFNagZxFtrnjCrymCDBPfknQc7qJSp2ZbPEfISI+15BoVJuQRxR0FGANCRisKSGBLXYL46aGkhHus5z28ATMtkXyXDHvF2JhU+Q6Zh/lGG4UJOztdERKaLAnxYsowbrydztXwx+femmFZ+XZT2MnGaHlleb00o7uBthqDKw93rvP0GyyztKiiycm8QaN9FzRXxY9R1sU6vkCLs8qt9qZ4kWKX6+exx0FpOvzBDiOMTXDk705kjYjRNL1/zhNO9PPOfaoa6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oNdydiTzpJyZPcWN9hLe/9xc7/iFeYG00TjZn+iHq5g=;
 b=VGaVty2vMiBs3csgcLJNJsTtro7yls5eyUb6ivqpNeDrWwfCkY2iUILEwF0Jl/72NeP1eDM53sIXKJg3P9iQJVBxc+OKKCcLWPe6E82qe+8/UeBsTalj5zH8tuXv8rj5ypmM1a73O47YnTFwRC1soWsCS5/TUcQFAGxSVW7P1CLA0+iwi9YqJG/fwvTx9jgULO+9x21xxCX/jRvpQDgxbA/9I6W8F0byvUJK0r5yuEWswyk7sUPnNqRfB2/PY97CqNRlMAPBSWy6+upyxoiSMCoQrugjaK+9oSjcs1C2hd841kjAnXQwfvYxQILfV+dlqPNZDghnWpvON0V/yfTIVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oNdydiTzpJyZPcWN9hLe/9xc7/iFeYG00TjZn+iHq5g=;
 b=j4riy+jRLVhanFBJzPciNRK5DMHulENXpUppO9kMMy97fZ808XshwB9WnpJWx35gFh6NwJQBgiWm3gc09SnRXixz3Imb759wgqxqfqIDsp9Edc3QDdqmoNad2VOJ1VeT3faSFbWqhqdCSZ8kzHe2R5/NgbG5QIuvksd+9HkdRiJyNh9wsopWw4bdwT38hOCehQn9v31HtyVmE1qohK+9GIlwzCchDxQfK41JOHdB1Lmln7gLQsokgLR9sSN7UYiZ1OrjwHkFrr6bTWznfB5ih2KB8n0vqnEIrCEaqSXgy//b+/Zol2+8wUzCM68rqgfv5NGf2ARXYle8Y8jDs94uvQ==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:252::12)
 by TYCP286MB2638.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:242::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.33; Fri, 7 Apr
 2023 14:18:56 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::d190:6e4d:5a1e:59a]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::d190:6e4d:5a1e:59a%3]) with mapi id 15.20.6277.033; Fri, 7 Apr 2023
 14:18:56 +0000
From:   Shengyu Qu <wiagn233@outlook.com>
To:     lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org,
        lgirdwood@gmail.com, broonie@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Shengyu Qu <wiagn233@outlook.com>
Subject: [PATCH v1 2/4] mfd: axp20x: Add support for AXP15060 PMIC
Date:   Fri,  7 Apr 2023 22:18:11 +0800
Message-ID: <TY3P286MB2611B7354DE4050FFB7CCD5498969@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230407141813.89-1-wiagn233@outlook.com>
References: <20230407141813.89-1-wiagn233@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [0sULqq3+mQ+7Lf0dFYm24FVDeZBVpBaH]
X-ClientProxiedBy: SJ0PR13CA0083.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::28) To TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:252::12)
X-Microsoft-Original-Message-ID: <20230407141813.89-3-wiagn233@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2611:EE_|TYCP286MB2638:EE_
X-MS-Office365-Filtering-Correlation-Id: c633eeda-30c0-4163-8c70-08db3773061e
X-MS-Exchange-SLBlob-MailProps: AZnQBsB9Xmovywdyt6JbrF6Sw9xOtJaeKrvFgPLelwin8svx3ObvHkE/xwmqBRHV2K+dg0cp6H7QOaZolrWEkpgnPQfPTI0d7gYBz2cRH0jIJAREfHKOdUeMrhQkw5qfqqFscQUBfjLdeiP00ssYz58JX55Uxhs7gzXWtnmUWfGBnxHms6bADjdhRMfPwjEPJWGNga2MznKrBXWMWGmXf/tl06ahCte+5MMLfsCTOXt73XDVV3LpD6yIsvhSxx27MoQVJG/6ohkAUWgtyrDqXQcT/NZZJwq2u+OaY8Cdp15DBHD7AtNqTGR+wi1ZHvhNhuAy50DlYjy+r3YsWt4ktyCF7nDoDyuXdxzt8hnV+ca1MEKFL3SYW2Va5khpLQatgzBqFmYP9IoPCBBrvJqDvIFpo02EIHwnOZz4xSHGtNbLdkraz/sKiKMHSj84Js3TyTSWHS/y7eJrmKr2OXZdjaq8CAaxDPHCAJ+4iUYp8rN2PzOKQpFItWbKE50hjhMQYZvZTT1eZMxcg+dD2W88RcJamjQG3icmB6CaYAxqSXt2CnudzwWzfr1Vz3fcRbL44mDutdNDEAL5eVOopu3WZoqfW5qL1C3lmB2S7ibrzhXpHcUyuBrYu8hbYZ0iQESnXH1TeaVMGUf15L0u1xuFslGYjRo3k8MPQwQsjjbTVcxN5Jx6biel8WOfEOTI7tnO8HynbLaY2P28lDuSTmGcJ7r7qavSb1VUzZsOwWLK7mSKbP3lGjOMC/QzjkaJfwHq7h99PwYFoS0=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZiPfioi1KmV2ocNUiX9U57NXVjR1rZkBuom5QJHP61+xWp480uD9xXF7k+gGvSOGqiytjAmXvj1FqVF4wr3Pvu5c9285A+zUHsb1/yWBAWS4QXIQ6qmW3B0wK1FTCCE6aTpEaMlwS1ttnxpPMFA0dPwvntWoekIYPwavGTcl6/fYRm5ihs18TBfYekSp5Wr2kxMef0XhDuosuJZ1gRGXscK5zho79aYh709Fm/1gToNnUREQtoHgMQYKhxPu94tvYZ06b9nL0An4VFYlXF56+CZU7XSbKCFHNChAhJXKTF61NxVDB6OWl6cKCCK3K320eyJs4O3dHeD/W9u1Ot8oEl35/1ITyzgGy/JxqD5ej+vBkAoAvCS+4ktmBEC/yc4iR35csMr/v7+iZln/RwNr6M7ZjVgZF4ODtGxHv02emW9a/EpnLhBqv2C0h/XLaW0AUL69P+i3ygWaZ5dgO3AJk93msM2XMVW9hYqJRUnzbRJqGTJK/zdJlLnMfpcyDU3/dzYIE9DnWKsY8TmkApsM+1mE2nGifZ2zhvAQZzobgnlA/GvYUEMMKIjtubhK9T7IPa6hO5REJx3lVtxl5WyOnW8behW5E/Sz9ufZKYTMhiMCEYt40HWHv+qOfn4ZFWAO
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?89PIIDVJbEgaED3ktpzNya6+USwSqO1paD5IUW4bru8/jXb5S+wtEdruz7+z?=
 =?us-ascii?Q?LG+CUWlgb/MI1g7B8K9tB0HM3XeCLAt7QEwgA0VlHqjVcTculS4SQdH8j05m?=
 =?us-ascii?Q?SMOvHoi6gOXPbiLF1xXEsHverATfe6prM4HqgvKstcqD95Soe4uEBB+USpTs?=
 =?us-ascii?Q?bKTlPzsnyk6WeG1jhKP4EKkznNyYDYGXCr3nSo/F++9MD5PfKmW5W21pHwC9?=
 =?us-ascii?Q?/K/zAMTELwMKzccxmF67JGI7QSkQBMwyjkH5nnTuSEgXtuuBJma/imW3T3ku?=
 =?us-ascii?Q?5iqYnPTczBBBSHWtlBTrPS39OqpHsarhP+7A4dR+fLKQ7MUki1Q3Tt1vQlP1?=
 =?us-ascii?Q?tinwHz2R0M6fZ7+LILdGATknzTbtw6kWjIG74tvmMg9ezB3AQ9A4qlveIrXC?=
 =?us-ascii?Q?AO+7wRvKibcyrxpZPyLeHFgbSsZG7FdY2YfKFULb4svXFMqMB4g6lzB6B0Uc?=
 =?us-ascii?Q?FwQz1nvv6kFvhQoLDrBlh520JGPgeaTPaM8awx3SiFmgTE5d3YjQ9Yu8qhd4?=
 =?us-ascii?Q?XYaNp/0XlpcgLGWwHLuMgm4i++zum3EMIRp1Ddj2uvdZD5Q3h+I9PT3BRsXP?=
 =?us-ascii?Q?3bq8dnbMRjQfkAVlOmADMd8olcCQvkGMFmovNU7kYkKKyQUqcxVEqSe/Ye3r?=
 =?us-ascii?Q?9N/9B40A/n/MW8Ez+KL4hwL4zoPZTwovl9rVXBnNjIr3PdfZlo+pEHuoTowb?=
 =?us-ascii?Q?yKGCt/+7B+n0iv73Qdmzffhx29+hd6sD7UBSqiQsn3I+veF9xx/1l8B4szm+?=
 =?us-ascii?Q?Y0kPW+FR5TFVu/d0CesYXvM9o4O2V4Hv8WgvnpRBnGk7pNEZRli8iUJb5T3+?=
 =?us-ascii?Q?ail/JttBjD/qtJzlW/+55EywZEPaqGbj2DpN3lFv7wAX+zNOuAbLTALFlHHu?=
 =?us-ascii?Q?B+G9ry2kF2Wyz+UJbjwdSbFv5O0WOQmmZUO6BigG3JQDC+i0MAjRbko8lww9?=
 =?us-ascii?Q?Lf6U76OTE6Wpugoz/mlFcuyJK1xKUVSm1gzY25lpfzlTzVgh2Wn+sAUq+mac?=
 =?us-ascii?Q?0yRQDuN7pB2euXuJCd05yU4TWQmRFKwqUvwq6sYyrp8taaRXF8c3V/48VtaN?=
 =?us-ascii?Q?+tMKrNY/kaKsavAIkHcbKn4miQ2zB5Cq8+z7aDFaiEIqQ5iJYG17/PzNmsSj?=
 =?us-ascii?Q?cqOB0WOqg611S4mlxXnv0un984weQJkbP0O8mpdr5TI43pVelIrjLWa/tYAL?=
 =?us-ascii?Q?p+dxKZhtLEri7ndE+osmcCwWbjDZ7FcIMBttag=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c633eeda-30c0-4163-8c70-08db3773061e
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2023 14:18:56.8764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2638
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


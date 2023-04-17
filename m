Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA6C16E433A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 11:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjDQJGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 05:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbjDQJGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 05:06:47 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2054.outbound.protection.outlook.com [40.92.99.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126484ECF;
        Mon, 17 Apr 2023 02:06:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ONYEru6QmOxjtz1mEFGKrK2oRQNOC2rswl+Fj8aSju+2sUMAHPelTT9R3DprctIxMCKjV2KvfFp0nAn4sGXmVsfCCa2HE5MbmGcg3ERZDo1VI8PnphzPQgWt3Lzx/SjIDBkbT5JWdnJRv372JfblStPa9KXK+NG96Vx/4OqujFmQfQwoKv+M3lujo3cChKf+HwQH+/d9aWQTbAikU7Qq1GfMezNUmVS1d2SAFcODJz6h38X7Mzv0EEltzVNDmt6ChGg62D22fwrJ7+LCSPHUyuDYoi5VmtFWqtcLR+6OlzjRn0KWivbz2Bruli0DzEm6PeiOG2Atb8lXABElIdkHRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4k+h/ZUBEuodBCT0rTvRVoAFZFf4Cv24jMVxAJ5HSYo=;
 b=ZqIG2MZ+wi39JGqfoY6YCD0kmReqltRjwqfl7TepIXtqdxduhgwXxTETWKXstTMQWqeJK+2vcR/1t4zlhKkpjMWteOszgiIPH+6r3TnfMW9ennPKIwEdyJvmc4wa1vFcT1rvhBYWfrbQPc4z0fuq3QxHkmOxeqlB1+uIMX9s0YjJyFobK0WzKE6f3n6KM2xzlt/HnS8hzvhiI39kCUyx6BUJdcGjxy6jekwr3HNOSl5qDE5F24Vme9pjzRINGnMfU5V4yG4QjCN05XkZRki4n+KAVRC9trpPXflIVJFZMuvv3HEXc09I/7KcPI83ACEFnbSHdRCBp8qCq4DVAndc9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4k+h/ZUBEuodBCT0rTvRVoAFZFf4Cv24jMVxAJ5HSYo=;
 b=tMYbkeFJ2TVNk3A+Sqc+2mtpr/VEnGEm6COe6t93wbn0OUXOz+bS9hnfS8B8GspbgW2wy/O8qBErmGEzs69BFGjoN2WVoi2+q2Q4vArjMWV03GZ6WqSktTYc8HDkfui1bC91TijpQ8UqkENa87H1lUsYgIFaullFGo4nqcxSSgalgO94KkVx+BrKNCXIxgo71eDHlYEdGN55QaGI65XSaNYB7BWnTqrsIBj6xTodKzX51YLl83hX2XwiFRlhr3uH1CgPe8X7BINce9oipJ9J8rUqMZEyCVUe4dk9UKZ4W2P27LYnZtMTqNWpQ+ID1ejpGUNw1Ug+Nc4loHhtMNNw+Q==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:252::12)
 by TYWP286MB1989.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:166::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Mon, 17 Apr
 2023 09:06:41 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::d190:6e4d:5a1e:59a]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::d190:6e4d:5a1e:59a%3]) with mapi id 15.20.6298.045; Mon, 17 Apr 2023
 09:06:40 +0000
From:   Shengyu Qu <wiagn233@outlook.com>
To:     lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org,
        lgirdwood@gmail.com, broonie@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Shengyu Qu <wiagn233@outlook.com>
Subject: [PATCH v2 2/4] mfd: axp20x: Add support for AXP15060 PMIC
Date:   Mon, 17 Apr 2023 17:05:36 +0800
Message-ID: <TY3P286MB261126058D704A3CDE91CE6D989C9@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230417090537.6052-1-wiagn233@outlook.com>
References: <20230417090537.6052-1-wiagn233@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [JoLvhz74Y3+G2nKZ++MiedsMaFP46OqH]
X-ClientProxiedBy: SG2PR02CA0074.apcprd02.prod.outlook.com
 (2603:1096:4:90::14) To TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:252::12)
X-Microsoft-Original-Message-ID: <20230417090537.6052-3-wiagn233@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2611:EE_|TYWP286MB1989:EE_
X-MS-Office365-Filtering-Correlation-Id: cc4a7a63-8600-4008-fd2b-08db3f230ea1
X-MS-Exchange-SLBlob-MailProps: AZnQBsB9XmofvZvLhntBlNaxIR7rLBomZ2T+rSRu5ixbbU0wYnJ+lviXgoP5B1rc+d65CurglCDQ7cNjpNPi0Xvbwwp6yabGEZf9VX3Rnn34+6IIrscxVLTSYJBCRpa7xAJnCYjxPusdVgJO0uGFMYEPe5RSM0L3kJbBECMUbnxPZYPCcVEdbeCOKBh3Lhjg6aBw2aCCMgyb/hND6ItMpOYR24s7MnUQsh9lwdxTlkmyXGbOcdZS0sQEulH4w7HMkugRwHLqh5n0obj/XTosnIzUf4MLK+8kpekvYDV6UJjqfzLLb31nHdH3alSZNEYlbQBytyuYJDUikxMVu6cyOXd/6w0NM20tFTXDLr6xDI3UGnbWD4r0xrBzuS9T6ICi4Mz+Zoh8r0SckT1i0zay0xBc1rQZ0itH/4OuQ0N/ew0yyBxhQNDZaFFeCOWfYaxe2O5UT31lLxdfzsLUPBGb7a398fbWwsDHirObY4sqG1Lrr8uRm6+FEgFAtuVlH/FzWrGnnTqd0U+/W82/ckvKkMq48tWdFBlbY/u1+tT2Rfh478T503/M5Qt86nBo3VKvUjiqq7Rj0xAmzHQnvxP9na97fO27VGdqby8k59UFAMxUqWO49e0zCo7E18J0U7AmMQGHxnVqjVnh/jm4wKdLBHnAitCIBVP0NV5LhMPvSCayIHMwjAW47imBh3xgaPrcpdxp4RvKtkLcwiydIXHjDQvvcVmZMdgHD35safUOMDh1L86ElghKQc4l88lrt/5yZZxyNv87occ=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q4zbaRITHw7HmDyyUXJ8sUjmu77a7aPEFsjtn5h5WPhClicfXehbQTrz6pAfrmQ2cr9dfrqYFFozafjQ2ak5tbxI+s83KZjAL32JrdV+VRnFRg3Cigesq4QRYUDVLYhKjN5Z4op/YY9xYA1Y6VTG8U7fZQkbDuRYDYmWpDsU/twsPpKQOGU401zlhIczO9AWSGd/pT9OPODzZ+6WhG+DwPyDHOZ5yYPISlRkiX3dcLG2KhIrD5UZEp8kiqCj9LsZz7yQcgtmiPF2HUua8LFOYi2BjmBQ2FoP17XSOVJBQWj2GCT0bJFa1bqiABsJt5PpgFgDVsxJjOWyPPZIFM9asjYh0L2BK47HiPmCqiOsyFBsHBRU+a9AjdSvk49c/byF9xCjraDuOL5xwthoxOOxd51jZhJgRKRzfyCosQ+ZgVxYdzk/V+pWEfpQD+Zh1N2Otz6PW2ERsJpyA4QGdmsw8b62ApbZ5GeTlhGEWr6Rs0hj3omqpVOAPT/AFI+7bPdOnQwdnxh/Ba8EMlVvyflHIICdQ9DH2aYUxC7ROItsExebbdW+zgyXlyvTf+2hoeep52Xp9h4JMw1MPCh1qRc53SHFvYQ06XqaUWBow351WPMpUbXAIivBsr1Tt+SWnBBG
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xFy6Dy9dF+wU97uCDCRgF5loHOFV9JpcqLAOHCEK2OKXX8GHtA4AAwNIYUV8?=
 =?us-ascii?Q?o6gHVnZGBfodInGv8Hg8lxfidDTwaP0OGtnJ+0fzNrheJYmwobL1RgsOnsB/?=
 =?us-ascii?Q?iYVxX6QKvcsYrdsELgMbU/xpoqarJ/Zn+n9YNx6GapHZa24IMuhZJO/O0w4h?=
 =?us-ascii?Q?O5fIj7BhlNk+I3WqoYkraI4WcOGKP06Lvd4UrHNFjw44RrvQHCfAv+mxmeAS?=
 =?us-ascii?Q?jbWc4eIGV4fmH6m7x9eu9WuZDuG5e+EYYaJzJ4Qiiyoph0HTc9XjCE+YKmud?=
 =?us-ascii?Q?G2OjCX2ec7wWD3vLzAotawa7FL2gqyD81gUJOZ6Gp3VluIjwZe4RNS+Yu2AC?=
 =?us-ascii?Q?AJLOFgUuh6lqMWPClzLMGbtY6jU8Od1a27nsmUhzhKA7cftao08N0MOsSEqj?=
 =?us-ascii?Q?jK5PPMh+YWA37+fL8+D2gMUN9tRaf/FzfABk6EB9236wCPklw205AE9rUTBe?=
 =?us-ascii?Q?f8JqGXTFGY+o+BuCPfmDRzdHYT3Z038X7l/bg75XT7zJ8p7p/GmZ+kAeb/1H?=
 =?us-ascii?Q?AhaVcPAW9A/X1E5AFIoGkEhGs93vM+mdvkJjj97dTSIqlJcDfoku64KFBB4z?=
 =?us-ascii?Q?eCZ1SzWUy3GDIIxf+eETURpl7hTTI24TfYCXTfd6CpCCFqMYduviaDzvyImx?=
 =?us-ascii?Q?O1S2Yl7NtIOb6z1MDt9ZR0KKtScuZ26jJzqAw13ggJ9eTp6JE88pwEQZQAt8?=
 =?us-ascii?Q?ZX4ieGEhlDCfxpkWntdwVXbUHG5Tq4/Ce32y+6h9UaMln01S9E59nyQVTSNE?=
 =?us-ascii?Q?78p5N5RVMTr5S9rnMVNOUBloQWhlYYJ8rqPhtGKgBg1fZ9L6pfvfldRC5/Db?=
 =?us-ascii?Q?vIMy7g8TyQXk1x9klXZJFESJkVPFhIJIZC7AAAwC1z7h/8FpMSQdvwnVGV6P?=
 =?us-ascii?Q?UOV9Ap4wk6xQF8lToVKXSt/fiM/QzQ76df6UvNPlrdxX3Oa3MRH+8a9IpiOp?=
 =?us-ascii?Q?cY20uiqUbfzzNaO98Ur55+LvJlIttb/6zl2MGqUUFfZFpzkh2SpBlPpNJtke?=
 =?us-ascii?Q?VJIwn4y9pkjBh+1kYSn5mjrIkIn+JpnoCIK2uB5w1LhQDqLVP3PhAAXIUIrC?=
 =?us-ascii?Q?T+9MWTd+68+2C92QJaJ4aB/0cRlkqwfrVh7htSIE5etOfkVhCmLJgBqniyQf?=
 =?us-ascii?Q?mZVbALrqf/Dna6IK1v0XIci4WwZby28A6VzDylgRh4JLZUFtjTnKKVqBcMKd?=
 =?us-ascii?Q?uiI2uZydgl8wOTiO91j2ByqgesMGfzmGfd9M5w=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc4a7a63-8600-4008-fd2b-08db3f230ea1
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2023 09:06:40.8550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB1989
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
index 7720ac15c7d4..9c65f1f04adc 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -43,6 +43,7 @@ static const char * const axp20x_model_names[] = {
 	"AXP806",
 	"AXP809",
 	"AXP813",
+	"AXP15060",
 };
 
 static const struct regmap_range axp152_writeable_ranges[] = {
@@ -169,6 +170,31 @@ static const struct regmap_access_table axp806_volatile_table = {
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
@@ -237,6 +263,11 @@ static const struct resource axp809_pek_resources[] = {
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
@@ -282,6 +313,15 @@ static const struct regmap_config axp806_regmap_config = {
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
 
@@ -503,6 +543,23 @@ static const struct regmap_irq axp809_regmap_irqs[] = {
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
@@ -582,6 +639,17 @@ static const struct regmap_irq_chip axp809_regmap_irq_chip = {
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
@@ -826,6 +894,16 @@ static const struct mfd_cell axp813_cells[] = {
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
@@ -935,6 +1013,18 @@ int axp20x_match_device(struct axp20x_dev *axp20x)
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


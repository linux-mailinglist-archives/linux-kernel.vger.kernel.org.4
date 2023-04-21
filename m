Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 227246EADBF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 17:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbjDUPJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 11:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232701AbjDUPJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 11:09:15 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2093.outbound.protection.outlook.com [40.92.98.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C776AC65E;
        Fri, 21 Apr 2023 08:09:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mukowrw0XEUAGUajKK2tp62d+ooEGG55WQr7KHeCryizWFJbzRJEmS7ozLDQ+w2RuZ+WdLCno+vWh5PimOBhdHBacaS0OnVaZqYFDGWgQ1ayhLvBAQVOD2SQMjEAofcAbsxeKimXzHCGce0JMapbyUpsYAnidQUm3ol2PIMt2fr1gzfq7U/PJyB1qORW8ocr9rE/oK00YSaPNXWeKzjywcyHe71cBFaLqYGevReWHJGBm8JZsN8kNYQ6Yn7Ky9vH07V+GQTzdmFv96nnKXIYwfhzFIdOrpofTGmlg1eV9MrO9AXbddvhU5uonN5SqxR/tP5GQu6ZDdWp2Xp5DgzbvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oSPdBhtkeurCWstSSMQgavQ0w2d0YXpE9S36lo3hao8=;
 b=SWwBvUROG68PjgtHNYjgbnYSVxH4NMDXo7PBKxVEOhDAW/NyD5d7wv3zl6yzAoIlceJYEJwivL1+TrIyziOFz79lWoqEoSEVTiG+Xac7izFcwlTPN0RUx7nR6fjXSEh9op4+WQxV2WswuvhF+5YnWWVupRjbeMSNxeAO5ifCo3BMVMdmscvuq0XQXL2kfiNBpcpl9JYnIF5xUoh138npuqAEIVwJnvKH8011rL+kf8YGQQk7icLYn/s6LSa4KXa3P2Mu/VGTIe2UkotdMtdx0NKpP+rJhUaoDMGg1uftoB8giNKZir41k9TzUolRRpNVbWXHmD2g/UmxWbIYT/kv8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oSPdBhtkeurCWstSSMQgavQ0w2d0YXpE9S36lo3hao8=;
 b=qrZZ0kLpKgweTszwB0FV4jYkH8zrr2EW5ctBOjiu+aL4UkEBL9VrYIi7zNXf86PYqOEA9lrpfqI6hs/Wq4xZcnDlQo4g+kkw9hRaxrigQtdtq5C3/A9xJCb0CGIdwroeh47H15jmQC5KCE4y8H5fFGIgiWoHh9LnQdXxw3EqCDVZl56xsmZvpvQacEb5aOzxXuP4PBdrXUrbn81L+cZ/k3FKuWri6zj/KRiv9linei89cyfcJyAaqDoM/0kdrftcn5O1HYRpW0i+te+AeoEKjlTmQk1nklTy/hu9WJDZfHVR74xZKlLI1XRx3BfJ2/t9LBh57l+LZBIy3E7lZV2SGg==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:252::12)
 by TY3P286MB3505.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3b5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.21; Fri, 21 Apr
 2023 15:09:05 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::5805:16d6:6ab7:6639]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::5805:16d6:6ab7:6639%2]) with mapi id 15.20.6319.022; Fri, 21 Apr 2023
 15:09:05 +0000
From:   Shengyu Qu <wiagn233@outlook.com>
To:     lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org,
        lgirdwood@gmail.com, broonie@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     andre.przywara@arm.com, conor.dooley@microchip.com,
        Shengyu Qu <wiagn233@outlook.com>
Subject: [PATCH v3 2/3] mfd: axp20x: Add support for AXP15060 PMIC
Date:   Fri, 21 Apr 2023 23:08:15 +0800
Message-ID: <TY3P286MB261162D57695AC8164ED50E298609@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230421150816.10513-1-wiagn233@outlook.com>
References: <20230421150816.10513-1-wiagn233@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [EVXWU5GwnilvZYvrDIIbJ0lBajv+y5aT]
X-ClientProxiedBy: SJ0PR13CA0168.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::23) To TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:252::12)
X-Microsoft-Original-Message-ID: <20230421150816.10513-3-wiagn233@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2611:EE_|TY3P286MB3505:EE_
X-MS-Office365-Filtering-Correlation-Id: 15c5ab04-cf9c-45cc-e54a-08db427a593e
X-MS-Exchange-SLBlob-MailProps: obhAqMD0nT8wRrMOmTC7gIiazLgnsCtwhnhAGbDj2hDMRim7xxuKvJHQLTlYf31lTWHXy85Ee2mWKElPi//BCB7R5ow9ftMUPXOnZeFuwe0aIpYFBpog0QB7C2yRT4mPaXEfd75i6K1payRHjUSzWSTNx+zm7gOFYyxIGR6Plp07e29R05L2Dd9ME1ljwvaXG30z4QmemWL8RbqPGSgmGZvcVgv3RuwtYZE5PE67ueEG7OduJ36+KfkPr43lZuM4FYHKja9mhxlq2Vc0LNamK6EgUSE6u6fJ5CWdQrhDonaKONxJR5JnzAf4KcW4SJGNudJ1GUwO+zLGaufEnOZPwo/qw/cTeigSE9ukbL0bmxk6BdI1x7/50H5eqn6SE8ycYoZe7k1jYSE5PG5FtOWn6DFbyZfuWdbPVHzxXsTeAgu/9A1Pk1g3z20OKmGdFiVT3habpKwu3pDjKaaNcCAZW2HLnd8KNiX/V528NVIeBia+uL6vETIehRoafACqnpAcF+192+5ceYR6VHqRV3JJGMvlDMHst9nUD9lXpYbE4O+NuGmltQ42SRn+Kiv8J4T2rhaMEgwTsIBGy1S+CGQlWoosddHAGWaDaP5AmjuuCgZLic048FOZ5ACLLs+rsAzu/HBctGQPSucqRO9ahDM1Caa+1ZyRYeJF5XXrJnAlBAlNUbNIJ7qCNBtj+gBsKuOcWJzfwq4fui8av7aRymlOdaFofdQDDHlv7haWUjPyFySXh4aZFBknHcLbFYyj2yGSaLKu67uhUbNxMPmpRD5EGc/TMQ4U8Qd6bnyAiGbwL1GMyG652wDIx1eMotlxo5Hs
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FZD79xd5qZQNgvGrzE6c3j6u+Evfdq3aey+axsxaZzf9d0b0MaR7DctCTwHL0P9S+NFFN9K8QM+3wyBbeC5qEAMMzqDa1dEYA9t+m/2l4lXXN2RmQLx7w4tKFDIiPk12Bsv6ss8emzCAQ9mRYKMuD270KItrh3SEWSDM5kmx1BYZroHTPtvtFO0cU2nqCVT0WIM400RPvCxfw0UqEaRJZmvCCvmnujlqWBFwjcQyVKTZtQWowbWUPRJ+yU81uvyV6X+t468vn0ZIVFMfX62kouqTaau8uFzmPc9EJ3h3Ne8LCgaVG7K+Y0QA7LCFHOh2Cw8/6fsS6MmQlr0NuPtsiOiubx7dgEbZMEKUT+nWfRcCQBHMLIP4Abb+nR/MsunnWUBM6YgfMHXHpzqwYuD6FT0lhMlx5/Z80yV79o0h+7HqV1IO+ysjyEKLbpEGk1sylng4SD+KRyAeaIi5+pWqdPbbl9zXePiYD1xa8EKaeFvXaveHg/EhHyKXq7OYbYzyZqi7lgMQLUuPtGf7VEWprmgVyxMKe3ZWzIKSJ05UhwauTuXzmiTuPAYPopI+a/DwTpAtRIFfwgxPm8TYEHkcIL3J/EKVTa4zOwW9PIw1XAo=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IGXOfXSm6OP3/+v/b0b+0BY+BQYTWqBqOHAD0ca4Q3up+vBg+QkSrP0gnETl?=
 =?us-ascii?Q?hhK/49N2JyIL9p/FQOvk54YzLkFRooipdjCh8gy1kCb2c3itBmdxgtt/De9V?=
 =?us-ascii?Q?xx5tRKmEjgtJCHuJoVuUNiVrgNrQ52ATr9/p1KhIcEGfs/NiDq0gBsDX4vPu?=
 =?us-ascii?Q?2jWWujI4Bd/lLxHYStg/z+TKLtTFn7z9uEN5x7wwcANrvqpD96BvHSa9QvFa?=
 =?us-ascii?Q?K3ybamvczW56rs5O757n7t+6jfM46nCZipnlfk6KVqmo7Tk5Wvsjjl/mtooy?=
 =?us-ascii?Q?ZRo/j12Gnedbdq0lLAd82dEo5SeyNYq+qGJoeQs5Lr/Cm3XkHPJEZeX6gR1m?=
 =?us-ascii?Q?LFjPF/fikJr9oE6gfYFpB/ABRnrsCzKhfalYRpw4JVEoFf2e6KxuU259+n+O?=
 =?us-ascii?Q?zkivOEP9cUMaxRCLXCUzwl0/U+OTQjosgSB0MiTE3npPLV+7wvYRE0WfSJuu?=
 =?us-ascii?Q?3wHZuc4yHkl7NODnyasRpWC0d3rPXBOti5a/GLCeCRsvyE5Zhl+PPHFI8Oo6?=
 =?us-ascii?Q?KajX4YpNx2zLCHJJ1lhd/6kAAFzn4BW6IzkneW580aQao0EfC7hSw054pCiZ?=
 =?us-ascii?Q?onfpLbAXpWJ2/WsUdnwfz5/cab3z5KoqfCgQAspqFGj+pGJH9TA0+fM8hB8G?=
 =?us-ascii?Q?WjpH8uyXhaAQgecBkbB5bjsP5xRggAYPf5nygSzU0wk5BPEdQRosmnCzHA8p?=
 =?us-ascii?Q?8BSwdBMxiPlKO8irCbbq2vaPBkio5PslXIzlhkn+DlSHjLC1j9yD+N0gfVSc?=
 =?us-ascii?Q?ImY0SL1EeIEYRwj7rJFIMLcg2Htg4NMAToxMKQgY1QfYN6U+ExAufHDKA24A?=
 =?us-ascii?Q?6nzTpoUpkcNizYa+bIihzpiiVZgHeq4qHN89WWNrK7guWmyx0zh1ptbKouWI?=
 =?us-ascii?Q?LYtFiWkzfkj4Il/vIhSElZxl1FFhBF2TGf7t4B30CFBRN0IgzGIYCnIuWtn/?=
 =?us-ascii?Q?CF+T12XTDBBkDT6mBcY5qUiOA9oR0K+t54mw8KD3QGXfkFysqiFkIM7AdLT3?=
 =?us-ascii?Q?+ptOQfhhHvr8wJjPgFc4Wg6u8ccmrCO/7YPqcSfEZtcjCssI5DEwvqIjgajx?=
 =?us-ascii?Q?o2u28PnX3aS4/7fWuObPXg1/i0UOXf3qMEavLjc6JXlJyn2DTFPVsMLy+Gmr?=
 =?us-ascii?Q?bUvNrt0O1R+ZgWKCVFRSmkdEMAC1uFew1JeOK0wxOxAn+yWDa9fyyxfnTij+?=
 =?us-ascii?Q?uELIGjvXiiKiriKQbwtKlU6GMPo1r52cS1yP4w=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15c5ab04-cf9c-45cc-e54a-08db427a593e
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2023 15:09:05.5840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB3505
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

---
Changes since v2:
 - Rebase to AXP313a series v10 [1] + newest (20230420) -next branch
 - Add axp_regulator_only_cells rather than directly using axp806_cells
   for cases that IRQ line isn't connected.

Changes since v1:
 - Nothing

[1] https://lore.kernel.org/linux-sunxi/20230401001850.4988-1-andre.przywara@arm.com/

Signed-off-by: Shengyu Qu <wiagn233@outlook.com>
---
 drivers/mfd/axp20x-i2c.c   |   2 +
 drivers/mfd/axp20x.c       | 107 +++++++++++++++++++++++++++++++++++++
 include/linux/mfd/axp20x.h |  85 +++++++++++++++++++++++++++++
 3 files changed, 194 insertions(+)

diff --git a/drivers/mfd/axp20x-i2c.c b/drivers/mfd/axp20x-i2c.c
index 03fb0840a4c0..a49e5e217554 100644
--- a/drivers/mfd/axp20x-i2c.c
+++ b/drivers/mfd/axp20x-i2c.c
@@ -66,6 +66,7 @@ static const struct of_device_id axp20x_i2c_of_match[] = {
 	{ .compatible = "x-powers,axp313a", .data = (void *)AXP313A_ID },
 	{ .compatible = "x-powers,axp803", .data = (void *)AXP803_ID },
 	{ .compatible = "x-powers,axp806", .data = (void *)AXP806_ID },
+	{ .compatible = "x-powers,axp15060", .data = (void *)AXP15060_ID },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, axp20x_i2c_of_match);
@@ -80,6 +81,7 @@ static const struct i2c_device_id axp20x_i2c_id[] = {
 	{ "axp313a", 0 },
 	{ "axp803", 0 },
 	{ "axp806", 0 },
+	{ "axp15060", 0 },
 	{ },
 };
 MODULE_DEVICE_TABLE(i2c, axp20x_i2c_id);
diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index 95f74ba3149e..07a846ecbf18 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -44,6 +44,7 @@ static const char * const axp20x_model_names[] = {
 	"AXP806",
 	"AXP809",
 	"AXP813",
+	"AXP15060",
 };
 
 static const struct regmap_range axp152_writeable_ranges[] = {
@@ -189,6 +190,31 @@ static const struct regmap_access_table axp806_volatile_table = {
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
@@ -262,6 +288,11 @@ static const struct resource axp809_pek_resources[] = {
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
@@ -316,6 +347,15 @@ static const struct regmap_config axp806_regmap_config = {
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
 
@@ -547,6 +587,23 @@ static const struct regmap_irq axp809_regmap_irqs[] = {
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
@@ -637,6 +694,17 @@ static const struct regmap_irq_chip axp809_regmap_irq_chip = {
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
@@ -886,6 +954,23 @@ static const struct mfd_cell axp813_cells[] = {
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
+/* For boards that don't have IRQ line connected to SOC. */
+static const struct mfd_cell axp_regulator_only_cells[] = {
+	{
+		.name		= "axp20x-regulator",
+	},
+};
+
 static int axp20x_power_off(struct sys_off_data *data)
 {
 	struct axp20x_dev *axp20x = data->cb_data;
@@ -1011,6 +1096,28 @@ int axp20x_match_device(struct axp20x_dev *axp20x)
 		 */
 		axp20x->regmap_irq_chip = &axp803_regmap_irq_chip;
 		break;
+	case AXP15060_ID:
+		/*
+		 * Don't register the power key part if there is no interrupt
+		 * line.
+		 *
+		 * Since most use cases of AXP PMICs are Allwinner SOCs, board
+		 * designers follow Allwinner's reference design and connects
+		 * IRQ line to SOC, there's no need for those variants to deal
+		 * with cases that IRQ isn't connected. However, AXP15660 is
+		 * used by some other vendors' SOCs that didn't connect IRQ
+		 * line, we need to deal with this case.
+		 */
+		if (axp20x->irq > 0) {
+			axp20x->nr_cells = ARRAY_SIZE(axp15060_cells);
+			axp20x->cells = axp15060_cells;
+		} else {
+			axp20x->nr_cells = ARRAY_SIZE(axp_regulator_only_cells);
+			axp20x->cells = axp_regulator_only_cells;
+		}
+		axp20x->regmap_cfg = &axp15060_regmap_config;
+		axp20x->regmap_irq_chip = &axp15060_regmap_irq_chip;
+		break;
 	default:
 		dev_err(dev, "unsupported AXP20X ID %lu\n", axp20x->variant);
 		return -EINVAL;
diff --git a/include/linux/mfd/axp20x.h b/include/linux/mfd/axp20x.h
index edd7fdcc33f9..fff7fa6b7c5d 100644
--- a/include/linux/mfd/axp20x.h
+++ b/include/linux/mfd/axp20x.h
@@ -22,6 +22,7 @@ enum axp20x_variants {
 	AXP806_ID,
 	AXP809_ID,
 	AXP813_ID,
+	AXP15060_ID,
 	NR_AXP20X_VARIANTS,
 };
 
@@ -143,6 +144,39 @@ enum axp20x_variants {
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
@@ -164,6 +198,11 @@ enum axp20x_variants {
 #define AXP20X_IRQ5_STATE		0x4c
 #define AXP20X_IRQ6_STATE		0x4d
 
+#define AXP15060_IRQ1_EN		0x40
+#define AXP15060_IRQ2_EN		0x41
+#define AXP15060_IRQ1_STATE		0x48
+#define AXP15060_IRQ2_STATE		0x49
+
 /* ADC */
 #define AXP20X_ACIN_V_ADC_H		0x56
 #define AXP20X_ACIN_V_ADC_L		0x57
@@ -234,6 +273,8 @@ enum axp20x_variants {
 #define AXP22X_GPIO_STATE		0x94
 #define AXP22X_GPIO_PULL_DOWN		0x95
 
+#define AXP15060_CLDO4_GPIO2_MODESET		0x2c
+
 /* Battery */
 #define AXP20X_CHRG_CC_31_24		0xb0
 #define AXP20X_CHRG_CC_23_16		0xb1
@@ -441,6 +482,33 @@ enum {
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
@@ -669,6 +737,23 @@ enum axp809_irqs {
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
2.40.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDC3362AF89
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 00:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbiKOXi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 18:38:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbiKOXiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 18:38:15 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2101.outbound.protection.outlook.com [40.107.113.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42F62A27C;
        Tue, 15 Nov 2022 15:38:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wtw+WUclIkVKKE9Kz2fKR7lsBn3gaCeVAPzPvS8h3RR8ZW8wis/aPCIPmSoZXaq7bdJwK5NkIky4XmraBJPacc2XT3fhXYcvKl+lTvdhdhPj1UonY8Ino+zv4LU+qKBwwuo+BYmXbcWCrpFu4cV6FQZS4jBThOmBywQoLELg1I4Ssj7DtbiqvVT3fqX0hgvmMNFzL4QhE23OO2hthmv/gU6Ly/5jNsvffpu3N9tsa/Cxy0gt42bmYmyfwddxFQrKFUUhXSrP57/N53yqnHEo7hWzddpP60Gs/qMfx/yL9bJ3Gw0xSsv/TFOdf9IODMhiizJAp0ErchdCp2bV525gLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KxuLH6HTvJ99lMDIe9+ZKFcNFsWiCK41QU/oWCAQQNY=;
 b=QWr5CPa6q8/VkDkfz72JLOSTZ8Rvv3j8ANXPqNitNLEkJubxLxrF53s3OFpT0w4GGnvgT3DSHbW8cEGPxM5PPHm8ziDS+V29NGDE5QFO42i+4EdBof+hUrfc59ah9oWh/UFxk8hPlPJkLOIWolZvgXvGfPn8fBwxtvx3UdSH4EHu7mIPFXgaRXTkt+3ZhOp6YLlFgHMQ3d9bZh/cp1ri/RspBYgu4gMG12vw1hhp6YsC8TgPWtjRRF+Wp092mpccap2AXFjuug/JmkSIZSvf4L/KhhrvqNluc85Vs8WP7Efw7s339mjEWhcF3BLeZQKRCwEWibYnei58acjtgiEbPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KxuLH6HTvJ99lMDIe9+ZKFcNFsWiCK41QU/oWCAQQNY=;
 b=DkYx9GK3SuHf4P0DaqfjFZnEyvJrHt3Ntf+AIyBtIhOa2NOAgtPe2gDGfbMbcuGJKgdadxn4RXpAOfA9YcG13aYn6hT2DAWn0I7FqBtnc9RCNhdoJXAc0cY/n40cd1ppkgx5wC3BARslTBPVjpPjZtrJYWv9DmJr0L6MDRrs0hM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from OSAPR01MB3892.jpnprd01.prod.outlook.com (2603:1096:604:5b::23)
 by OS3PR01MB8842.jpnprd01.prod.outlook.com (2603:1096:604:17f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Tue, 15 Nov
 2022 23:38:09 +0000
Received: from OSAPR01MB3892.jpnprd01.prod.outlook.com
 ([fe80::60f7:f062:7c7c:d289]) by OSAPR01MB3892.jpnprd01.prod.outlook.com
 ([fe80::60f7:f062:7c7c:d289%6]) with mapi id 15.20.5813.018; Tue, 15 Nov 2022
 23:38:09 +0000
From:   Alex Helms <alexander.helms.jy@renesas.com>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        sboyd@kernel.org, mturquette@baylibre.com, geert+renesas@glider.be,
        alexander.helms.jy@renesas.com
Subject: [PATCH v3 2/2] clk: Add support for Renesas ProXO oscillator
Date:   Tue, 15 Nov 2022 16:37:49 -0700
Message-Id: <20221115233749.10161-3-alexander.helms.jy@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221115233749.10161-1-alexander.helms.jy@renesas.com>
References: <20221115233749.10161-1-alexander.helms.jy@renesas.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0052.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::27) To OSAPR01MB3892.jpnprd01.prod.outlook.com
 (2603:1096:604:5b::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSAPR01MB3892:EE_|OS3PR01MB8842:EE_
X-MS-Office365-Filtering-Correlation-Id: 0316ef2c-bf10-42ea-05b3-08dac7627441
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lK43rrcdf4uj1SwnjEAN1f8qP8CZwBccrWxHTHrrFK3uD6dA4q9+mMiVUbGqwRbYEGQQjqYheHN5jhVRl6lwVSlZhHIdRrp0xgUcf3CIBCtfI9pR0e1izRkweOvmHvKgWVbJzDY/q16rTkjBhFuPTqDkrk/dtCze0jlfhqVLCQPj84oeFORVKvgD6DMndDFh2+HwmIj/JKFu9PW5NHsYf4yTDta9eUCysyOhw5+V2enniZ/7LGDaFKdac9oVIxcUrQN2gMrq20xamYe4papnuLEdG7+tkFHNl85LcMcwFz0Tpjs1uKqy0YOqxxaG/Qdh4dB/Qs6XlWdKEsWxtIf+NjnanbRsgJJCSNvn6zKqZHI9B/BHojd33NLciaO7srw0ziKCuAb4sGiyfYuhlAY0AY4vci0vTMPKZju6YE06jCttjpP1+bAYaQIvR68yOSbqnhK+AGn3MDlSewsuBbLtvC6iz3Qffh6kXofAh7K6x5o+rAw2Xv/7Gv1F4CtZJpuH44qFF5tYzlhChyQtseXXsqdTgHFUUURenAfOONRRHVhbek11z/LviDL750Ab4f9qxJgtlGWfvZFFrgMEMxdXgc5dlt4klWD7yvroh2+7lOmae4f69FWBUILabRAEeJPonJ4VXalDh7JdzEP65WdDn9vqgT0pcRh6mYdQwqaZT6uwucp63t+sWxdekqJVTkiPmsaMHl5Du25FM6d5P1+sYFykoI+bcg+3ws9B3ulZLt6kSSpcuIxQuCbYcfuHcNea
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB3892.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(376002)(396003)(366004)(39860400002)(451199015)(1076003)(186003)(36756003)(83380400001)(6486002)(478600001)(6512007)(2616005)(107886003)(6666004)(52116002)(6506007)(86362001)(103116003)(38350700002)(8936002)(38100700002)(41300700001)(2906002)(26005)(5660300002)(30864003)(316002)(8676002)(66476007)(66946007)(66556008)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sSLwzu2e1D6R5ruuHCA8blUq3yMC1TFcfvkoXJbuKjqwlV6Cbl3MszcjaQEm?=
 =?us-ascii?Q?lm9S22paGFKnyWK5c5wgxyI+LG3PF2m1L7FnTeuHrqTb8ksGDPXkmbLkBAV7?=
 =?us-ascii?Q?RHMy2mUBD3fukXe+++Wdygd+wXzryKk1s9KLQPXJCShgTDQWj981uAztpiCs?=
 =?us-ascii?Q?CKvQz1I7nWA0tjjDcRMxe/eXZkIaBJCrx8zhhiLaUkjGH3CoDanyNcbP39dy?=
 =?us-ascii?Q?1WlARhFSY4drAZclOOCZGclkDWTD7J5bPaLq8zwkaCNEo4SbaMOvtOYuKsVr?=
 =?us-ascii?Q?acLE0XpWz3g9dFlvpEI+ebcyclqgxb2SSfHAnCyXUGoNFaOF7RQShLw//LY3?=
 =?us-ascii?Q?jnzo9XfDH13ifyg5HcsQPFXEcF5CZNtPYtJBSgvgfRqkJeooh7EurYUXV5Ye?=
 =?us-ascii?Q?RWeFwkiZgeHPhikwYV0PAulKfO8TXojnOuth3OBoLoZPP7/nzxu2KnaXSYnV?=
 =?us-ascii?Q?+aXw/XhRaKaeqH/xQV3J7JpgGnI1uucmTEN0QwPAP+V03BkHAxzg7oYnJa9J?=
 =?us-ascii?Q?siYRWLrhQo5vXvJ1Ug2dYnCg2o0QgZ/IIBImd4RssUkiEbsNn7oAhQhgov66?=
 =?us-ascii?Q?evXoVWaej89H0kI7WrQLuGjtfYMPWEAgZr3bNGmj04yQbCx1ERdA8+DEzUV4?=
 =?us-ascii?Q?EgZPUF4rrs+QnLAK9TRiLQXit/EtyBKQSlQjbjipJEAWljlrko5BL8+Cu3oE?=
 =?us-ascii?Q?M3H5DNmEwzjOgWkdcIshpxZFdIUVdZzFv7HZTA3rkMCFhW6oiflX3lacsQ1F?=
 =?us-ascii?Q?LHJK6e3X9hg7kK09CyVkarbiegUccIlmymFCrggxNolshBpAxWK9Ys1gRkDt?=
 =?us-ascii?Q?q6L605Z7XYRPaSd1ud6Tfhl0rn6HoYVn0zQxR4LXy9e7+mZgbEw//OJpAxLl?=
 =?us-ascii?Q?7Dq8BYsIvHElEsCXzAwMQjP5H/pLXd/bq+pezJ+378nS9FXX8PdK3Y2rEmSj?=
 =?us-ascii?Q?RTmh6xGtJ7jcv1cdqUld6N53DP6ERdLPSkgb/LZ85tQFQtmc/qOt5kahA8C/?=
 =?us-ascii?Q?gQO1LwtAd8D1Wh9XyB2p4U66RblDIv+b7MZL2eW4r1MAvwIkxFxIDHvFgSRu?=
 =?us-ascii?Q?k0nFe3SU/GFaUAodmBZtaotXtF4VlYmVGOPG6X3pHnBW5E92F20VTJ5KIs5u?=
 =?us-ascii?Q?XW9mqxVpYnzCubDgZN8G+NLSJra/DkWuqGd7/cIwCJYPTR7a8ZGm593BhBag?=
 =?us-ascii?Q?2s983Qk5RCxi1gB/G25fkY6wj/NeSp0SxTFhiiTnwQ+47t7BIOUnEwwRHtVS?=
 =?us-ascii?Q?mzdFt1tATiKM3+BjpnrnvFI3mJr3TS3asLYjSJMphtdDOD89LTFKgss1qcAU?=
 =?us-ascii?Q?TGJEfyKRXeCBLnCMwLCwO+Eq+Zs1O7/b5w3h3gLujRmjWPb5CVta2ARx8rXP?=
 =?us-ascii?Q?QpNdkq7OIlg2wdm82klJ+DJdsg7NTf+DOaeWT3s52LhYXy4k/SOsTs+CSGgz?=
 =?us-ascii?Q?6mixsRSiAfaZrrl6gY0q/zXswHbeQcPgudMJLBb/MHOAPiZWdeHtPTPZAh4P?=
 =?us-ascii?Q?ggmfy33y1pERcVoubnaNa/obCVBSzS14A5faB9FHIY0ydUCd47G+/uCMmvm+?=
 =?us-ascii?Q?dqqQGCNseADh01jiD5XoHr5vcROhHnQMR6Zym7akhBd5BLCzVYOCVNfAZjw2?=
 =?us-ascii?Q?pUeBX1fiwbGq3BYqanWOTto=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0316ef2c-bf10-42ea-05b3-08dac7627441
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB3892.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 23:38:09.8580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W+2tQuBf2yxllxdZehzZ3Vhh8XwrgLhKAQHtmHCBorN7tk4r7AfzpeVpaRmB4YeSAWlg+KiKZLSPftSNRJH1DsbQBOOtTpNJypaMz0Y0uKM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8842
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ProXO is a programmable ultra-low phase noise quartz-based
oscillator with a single output. This driver supports changing
the frequency of the ProXP XP variant.

Signed-off-by: Alex Helms <alexander.helms.jy@renesas.com>
---
 MAINTAINERS             |   1 +
 drivers/clk/Kconfig     |   7 +
 drivers/clk/Makefile    |   1 +
 drivers/clk/clk-proxo.c | 410 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 419 insertions(+)
 create mode 100644 drivers/clk/clk-proxo.c

diff --git a/MAINTAINERS b/MAINTAINERS
index d52a8a5d2..c7f5c0655 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16084,6 +16084,7 @@ RENESAS PROXO CLOCK DRIVER
 M:	Alex Helms <alexander.helms.jy@renesas.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/clock/renesas,proxo.yaml
+F:	drivers/clk/clk-proxo.c
 
 RESET CONTROLLER FRAMEWORK
 M:	Philipp Zabel <p.zabel@pengutronix.de>
diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 8f905df60..31f684d69 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -396,6 +396,13 @@ config COMMON_CLK_K210
 	help
 	  Support for the Canaan Kendryte K210 RISC-V SoC clocks.
 
+config COMMON_CLK_PROXO
+	bool "Clock driver for Renesas ProXO"
+	depends on I2C && OF
+	select REGMAP_I2C
+	help
+	  Support for the Renesas ProXO oscillator clock.
+
 source "drivers/clk/actions/Kconfig"
 source "drivers/clk/analogbits/Kconfig"
 source "drivers/clk/baikal-t1/Kconfig"
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 99941b4a3..be6e28cc4 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -52,6 +52,7 @@ obj-$(CONFIG_ARCH_NSPIRE)		+= clk-nspire.o
 obj-$(CONFIG_COMMON_CLK_OXNAS)		+= clk-oxnas.o
 obj-$(CONFIG_COMMON_CLK_PALMAS)		+= clk-palmas.o
 obj-$(CONFIG_CLK_LS1028A_PLLDIG)	+= clk-plldig.o
+obj-$(CONFIG_COMMON_CLK_PROXO)		+= clk-proxo.o
 obj-$(CONFIG_COMMON_CLK_PWM)		+= clk-pwm.o
 obj-$(CONFIG_CLK_QORIQ)			+= clk-qoriq.o
 obj-$(CONFIG_COMMON_CLK_RK808)		+= clk-rk808.o
diff --git a/drivers/clk/clk-proxo.c b/drivers/clk/clk-proxo.c
new file mode 100644
index 000000000..7d4268687
--- /dev/null
+++ b/drivers/clk/clk-proxo.c
@@ -0,0 +1,410 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Common clock framework driver for the ProXO family of quartz-based oscillators.
+ *
+ * Copyright (c) 2022 Renesas Electronics Corporation
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/regmap.h>
+#include <linux/swab.h>
+
+/* Most ProXO products have a 50MHz xtal, can be overridden in device tree */
+#define PROXO_DEFAULT_XTAL	50000000
+
+/* VCO range is 6.86 GHz to 8.65 GHz */
+#define PROXO_FVCO_MIN		6860000000ULL
+#define PROXO_FVCO_MAX		8650000000ULL
+
+/* Output range is 15MHz to 2.1GHz */
+#define PROXO_FOUT_MIN		15000000UL
+#define PROXO_FOUT_MAX		2100000000UL
+
+#define PROXO_FRAC_BITS		24
+#define PROXO_FRAC_DIVISOR	BIT(PROXO_FRAC_BITS)
+
+/* Disable the doubler if the crystal is > 80MHz */
+#define PROXO_FDBL_MAX		80000000U
+
+#define PROXO_OUTDIV_MIN	4
+#define PROXO_OUTDIV_MAX	511
+#define PROXO_FB_MIN		41
+
+#define PROXO_REG_FREQ0		0x10
+#define PROXO_REG_XO		0x51
+#define PROXO_REG_TRIG		0x62
+
+#define OUTDIV_8_MASK		0x80
+#define FBDIV_INT_8_7_MASK	0x30
+#define FBDIV_INT_6_0_MASK	0x7f
+#define DOUBLE_DIS_MASK		0x80
+#define CP_MASK			0x0e
+#define PLL_MODE_MASK		0x01
+
+enum proxo_model {
+	PROXO_XP,
+};
+
+enum proxo_pll_mode {
+	PLL_MODE_FRAC,
+	PLL_MODE_INT,
+};
+
+struct clk_proxo {
+	struct clk_hw hw;
+	struct regmap *regmap;
+	struct i2c_client *i2c_client;
+	enum proxo_model model;
+	u32 fxtal;
+	u64 fvco;
+	u32 fout;
+	u8 double_dis;
+	u16 fb_int;
+	u32 fb_frac;
+	u16 out_div;
+};
+
+#define to_clk_proxo(_hw)	container_of(_hw, struct clk_proxo, hw)
+
+static u8 proxo_get_cp_value(u64 fvco)
+{
+	if (fvco < 7000000000ULL)
+		return 5;
+	else if (fvco >= 7000000000ULL && fvco < 7400000000ULL)
+		return 4;
+	else if (fvco >= 7400000000ULL && fvco < 7800000000ULL)
+		return 3;
+	else
+		return 2;
+}
+
+static u64 proxo_calc_fvco(u32 fxtal, u8 double_dis, u16 fb_int, u32 fb_frac)
+{
+	u64 fref, fvco;
+	u8 doubler;
+
+	doubler = double_dis ? 1 : 2;
+	fref = (u64)fxtal * doubler;
+	fvco = (fref * fb_int) + div_u64(fref * fb_frac, PROXO_FRAC_DIVISOR);
+
+	return fvco;
+}
+
+static int proxo_get_divs(struct clk_proxo *proxo, u16 *out_div, u16 *fb_int, u32 *fb_frac,
+			  u8 *double_dis)
+{
+	int ret;
+	u8 reg[6];
+	unsigned int xo;
+
+	ret = regmap_bulk_read(proxo->regmap, PROXO_REG_FREQ0, reg, ARRAY_SIZE(reg));
+	if (ret)
+		return ret;
+
+	ret = regmap_read(proxo->regmap, PROXO_REG_XO, &xo);
+	if (ret)
+		return ret;
+
+	*out_div = (u16_get_bits(reg[1], OUTDIV_8_MASK) << 8) + reg[0];
+	*fb_int = (u16_get_bits(reg[2], FBDIV_INT_8_7_MASK) << 7) + (reg[1] & FBDIV_INT_6_0_MASK);
+	*fb_frac = ((u32)reg[5] << 16) + ((u32)reg[4] << 8) + reg[3];
+	*double_dis = !!(xo & DOUBLE_DIS_MASK);
+
+	if (*fb_frac > (PROXO_FRAC_DIVISOR >> 1))
+		(*fb_int)--;
+
+	pr_debug("%s - out_div: %u, fb_int: %u, fb_frac: %u, doubler_dis: %u\n",
+		 __func__, *out_div, *fb_int, *fb_frac, *double_dis);
+
+	return ret;
+}
+
+static int proxo_get_defaults(struct clk_proxo *proxo)
+{
+	int ret;
+
+	ret = proxo_get_divs(proxo, &proxo->out_div, &proxo->fb_int, &proxo->fb_frac,
+			     &proxo->double_dis);
+	if (ret)
+		return ret;
+
+	proxo->fvco = proxo_calc_fvco(proxo->fxtal, proxo->double_dis, proxo->fb_int,
+				      proxo->fb_frac);
+	proxo->fout = div_u64(proxo->fvco, proxo->out_div);
+
+	pr_debug("%s - out_div: %u, fb_int: %u, fb_frac: %u, doubler_dis: %u, fvco: %llu, fout: %u\n",
+		 __func__, proxo->out_div, proxo->fb_int, proxo->fb_frac, proxo->double_dis,
+		 proxo->fvco, proxo->fout);
+
+	return ret;
+}
+
+static int proxo_calc_divs(unsigned long frequency, struct clk_proxo *proxo, u32 *fout,
+			   u16 *out_div, u16 *fb_int, u32 *fb_frac, u8 *double_dis)
+{
+	int i;
+	u8 doubler;
+	u16 out_div_start;
+	u32 fref;
+	u64 fvco;
+	bool found = false, allow_frac = false;
+
+	out_div_start = 1 + div64_u64(PROXO_FVCO_MIN, frequency);
+	doubler = proxo->fxtal <= PROXO_FDBL_MAX ? 2 : 1;
+	fref = proxo->fxtal * doubler;
+	*fout = (u32)max(PROXO_FOUT_MIN, min(PROXO_FOUT_MAX, (unsigned long)*fout));
+	*out_div = PROXO_OUTDIV_MIN;
+	*fb_int = PROXO_FB_MIN;
+	*fb_frac = 0;
+	*double_dis = doubler == 1 ? 1 : 0;
+
+retry:
+	for (i = out_div_start; i <= PROXO_OUTDIV_MAX; ++i) {
+		*out_div = i;
+		fvco = frequency * *out_div;
+		if (fvco > PROXO_FVCO_MAX) {
+			allow_frac = true;
+			goto retry;
+		}
+		*fb_int = div_u64_rem(fvco, fref, fb_frac);
+		if (*fb_frac == 0) {
+			found = true;
+			break;
+		}
+		if (allow_frac) {
+			*fb_frac = 1 + (u32)div_u64((u64)*fb_frac << PROXO_FRAC_BITS, fref);
+			found = true;
+			break;
+		}
+	}
+
+	if (!found)
+		return -EINVAL;
+
+	if (fvco < PROXO_FVCO_MIN || fvco > PROXO_FVCO_MAX)
+		return -EINVAL;
+
+	fvco = ((u64)fref * *fb_int) + div_u64((u64)fref * *fb_frac, PROXO_FRAC_DIVISOR);
+	*fout = div_u64(fvco, *out_div);
+
+	return 0;
+}
+
+static int proxo_update_frequency(struct clk_proxo *proxo)
+{
+	enum proxo_pll_mode pll_mode;
+	u8 cp_value;
+	u16 fb_int;
+	u8 reg[6];
+
+	cp_value = proxo_get_cp_value(proxo->fvco);
+	pll_mode = proxo->fb_frac == 0 ? PLL_MODE_INT : PLL_MODE_FRAC;
+	fb_int = proxo->fb_frac > (PROXO_FRAC_DIVISOR >> 1) ? proxo->fb_int + 1 : proxo->fb_int;
+
+	reg[0] = proxo->out_div & 0xff;
+	reg[1] = ((proxo->out_div >> 1) & OUTDIV_8_MASK) + (fb_int & FBDIV_INT_6_0_MASK);
+	reg[2] = (fb_int >> 3) & FBDIV_INT_8_7_MASK;
+	reg[2] = u8_replace_bits(reg[2], cp_value, CP_MASK);
+	reg[2] = u8_replace_bits(reg[2], pll_mode, PLL_MODE_MASK);
+	reg[3] = proxo->fb_frac & 0xff;
+	reg[4] = (proxo->fb_frac >> 8) & 0xff;
+	reg[5] = (proxo->fb_frac >> 16) & 0xff;
+
+	return regmap_bulk_write(proxo->regmap, PROXO_REG_FREQ0, reg, ARRAY_SIZE(reg));
+}
+
+static int proxo_set_frequency(struct clk_proxo *proxo, unsigned long frequency)
+{
+	int ret;
+
+	ret = proxo_calc_divs(frequency, proxo, &proxo->fout, &proxo->out_div, &proxo->fb_int,
+			      &proxo->fb_frac, &proxo->double_dis);
+	if (ret)
+		return ret;
+
+	proxo->fvco = proxo_calc_fvco(proxo->fxtal, proxo->double_dis, proxo->fb_int,
+				      proxo->fb_frac);
+	proxo->fout = div_u64(proxo->fvco, proxo->out_div);
+
+	pr_debug("%s - out_div: %u, fb_int: %u, fb_frac: %u, doubler_dis: %u, fvco: %llu, fout: %u\n",
+		 __func__, proxo->out_div, proxo->fb_int, proxo->fb_frac,
+	proxo->double_dis, proxo->fvco, proxo->fout);
+
+	proxo_update_frequency(proxo);
+
+	/* trigger frequency change */
+	regmap_write(proxo->regmap, PROXO_REG_TRIG, 0x00);
+	regmap_write(proxo->regmap, PROXO_REG_TRIG, 0x01);
+	regmap_write(proxo->regmap, PROXO_REG_TRIG, 0x00);
+
+	return ret;
+}
+
+static unsigned long proxo_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
+{
+	struct clk_proxo *proxo = to_clk_proxo(hw);
+	int ret;
+	u8 double_dis;
+	u16 out_div, fb_int;
+	u32 fout, fb_frac;
+	u64 fvco;
+
+	ret = proxo_get_divs(proxo, &out_div, &fb_int, &fb_frac, &double_dis);
+	if (ret) {
+		dev_err(&proxo->i2c_client->dev, "unable to recalc rate\n");
+		return 0;
+	}
+
+	fvco = proxo_calc_fvco(proxo->fxtal, double_dis, fb_int, fb_frac);
+	fout = div_u64(fvco, out_div);
+
+	return fout;
+}
+
+static long proxo_round_rate(struct clk_hw *hw, unsigned long rate, unsigned long *parent_rate)
+{
+	struct clk_proxo *proxo = to_clk_proxo(hw);
+	int ret;
+	u8 double_dis;
+	u16 out_div, fb_int;
+	u32 fout, fb_frac;
+
+	if (!rate)
+		return 0;
+
+	ret = proxo_calc_divs(rate, proxo, &fout, &out_div, &fb_int, &fb_frac, &double_dis);
+	if (ret) {
+		dev_err(&proxo->i2c_client->dev, "unable to round rate\n");
+		return 0;
+	}
+
+	return fout;
+}
+
+static int proxo_set_rate(struct clk_hw *hw, unsigned long rate, unsigned long parent_rate)
+{
+	struct clk_proxo *proxo = to_clk_proxo(hw);
+
+	if (rate < PROXO_FOUT_MIN || rate > PROXO_FOUT_MAX) {
+		dev_err(&proxo->i2c_client->dev, "requested frequency %lu Hz is out of range\n",
+			rate);
+		return -EINVAL;
+	}
+
+	return proxo_set_frequency(proxo, rate);
+}
+
+static const struct clk_ops proxo_clk_ops = {
+	.recalc_rate = proxo_recalc_rate,
+	.round_rate = proxo_round_rate,
+	.set_rate = proxo_set_rate,
+};
+
+static const struct i2c_device_id proxo_i2c_id[] = {
+	{ "proxo-xp", PROXO_XP },
+	{},
+};
+MODULE_DEVICE_TABLE(i2c, proxo_i2c_id);
+
+static const struct regmap_config proxo_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = 0x63,
+	.cache_type = REGCACHE_RBTREE,
+	.use_single_write = true,
+	.use_single_read = true,
+};
+
+static int proxo_probe(struct i2c_client *client)
+{
+	struct clk_proxo *proxo;
+	struct clk_init_data init;
+	const struct i2c_device_id *id = i2c_match_id(proxo_i2c_id, client);
+	int ret;
+
+	proxo = devm_kzalloc(&client->dev, sizeof(*proxo), GFP_KERNEL);
+	if (!proxo)
+		return -ENOMEM;
+
+	init.ops = &proxo_clk_ops;
+	init.flags = 0;
+	init.num_parents = 0;
+	proxo->hw.init = &init;
+	proxo->i2c_client = client;
+	proxo->model = id->driver_data;
+
+	if (of_property_read_string(client->dev.of_node, "clock-output-names", &init.name))
+		init.name = client->dev.of_node->name;
+
+	if (of_property_read_u32(client->dev.of_node, "renesas,crystal-frequency-hz", &proxo->fxtal))
+		proxo->fxtal = PROXO_DEFAULT_XTAL;
+
+	proxo->regmap = devm_regmap_init_i2c(client, &proxo_regmap_config);
+	if (IS_ERR(proxo->regmap))
+		return PTR_ERR(proxo->regmap);
+
+	i2c_set_clientdata(client, proxo);
+
+	ret = proxo_get_defaults(proxo);
+	if (ret) {
+		dev_err(&client->dev, "getting defaults failed\n");
+		return ret;
+	}
+
+	ret = devm_clk_hw_register(&client->dev, &proxo->hw);
+	if (ret) {
+		dev_err(&client->dev, "clock registration failed\n");
+		return ret;
+	}
+
+	ret = of_clk_add_hw_provider(client->dev.of_node, of_clk_hw_simple_get, &proxo->hw);
+	if (ret) {
+		dev_err(&client->dev, "unable to add clk provider\n");
+		return ret;
+	}
+
+	ret = clk_set_rate_range(proxo->hw.clk, PROXO_FOUT_MIN, PROXO_FOUT_MAX);
+	if (ret) {
+		dev_err(&client->dev, "clk_set_rate_range failed\n");
+		return ret;
+	}
+
+	dev_info(&client->dev, "registered, current frequency %u Hz\n", proxo->fout);
+
+	return ret;
+}
+
+static int proxo_remove(struct i2c_client *client)
+{
+	of_clk_del_provider(client->dev.of_node);
+	return 0;
+}
+
+static const struct of_device_id proxo_of_match[] = {
+	{ .compatible = "renesas,proxo-xp" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, proxo_of_match);
+
+static struct i2c_driver proxo_i2c_driver = {
+	.driver = {
+		.name = "proxo",
+		.of_match_table = proxo_of_match,
+	},
+	.probe_new = proxo_probe,
+	.remove = proxo_remove,
+	.id_table = proxo_i2c_id,
+};
+module_i2c_driver(proxo_i2c_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Alex Helms <alexander.helms.jy@renesas.com");
+MODULE_DESCRIPTION("Renesas ProXO common clock framework driver");
-- 
2.30.2


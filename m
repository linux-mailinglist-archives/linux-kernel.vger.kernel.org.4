Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2B65E8468
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 22:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233003AbiIWUxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 16:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233112AbiIWUx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 16:53:26 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2106.outbound.protection.outlook.com [40.107.114.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31B2F5092;
        Fri, 23 Sep 2022 13:53:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FrmRD31l7jGaw0FuG31q7x3DCrkgcrfdGTjmxnIXEYxlD2LS5TDhZF3s2b2sz2/NC2Pwg5ZkV+xdx5tK4b5L+wCGsP99dqs6zv+aYlQ+fFiwFwU1MfpD9ubLu8h5U/tw8UvgJFqbjH2Ddl5AU4IMUTNHmQbCsJNKB73QDxtG1ufpnfvTQlzRcN2U/dzmQlHPAU/NRsR7LnRi+FCEe12rCQO3bE7TKe6wuW3dQlw0vNhUFVZVxep23I4qG8lveObL7qM9EzzOK8K+EAG8JhCQc2QZjOf6c5whnnXXtIgwhHxx/6oxqF9pETo2yIjqsyjCvLx+SLDR6G6SBIKpKicbxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1dUO/KoDMLwQn7rFZgJht/uLABMk/YjcXl3KfomGs60=;
 b=nVLX5LCgigirCUK0j+zvy4mNx20SLAeJPsDKoltZOQJGf9F6PEHYSQoQDWNkXKMx4rRWx2KkSm2bCjavMBfZj7tHHLOQZmQj0qyBK1CCrAOsKMbtQADJ07Bv0UwxhaULknuHCNkcMS0mGL0zJigivgO6fdHNGFiY8HGC2aqk8Y9hstszmYkd3+RKe+4xvHQSlbhaeAJsxRFz0B/tdUQ3gr2nBPji4zHkjlE4XTMjq0Q6n5LkClCTTqKggtDJDlvh/yPmwntUA/j2e0OtJuwIKUJYvgb7cQRyCP45EPP1BEU99x+ZUsGZNJWwIJ0Oyh9+Hgfawnk49buz/IsyoqeB8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1dUO/KoDMLwQn7rFZgJht/uLABMk/YjcXl3KfomGs60=;
 b=NV8q9J15/SpciOPdKEv7yzxWfc05Sr95mnXjusYIRaQ2WDxW9vqxPecVDR5/Sjo6ND+sKjFxjCpbcU2JtLIvu/5CdEe+mM8SiItCGD/EbYmLUenQa7v4t9tG2GFFSZnx7l9Nx0W8xcX8+fMTKZ2SyXZrDUfN//GIOywI9rs3c+Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from OSAPR01MB3892.jpnprd01.prod.outlook.com (2603:1096:604:5b::23)
 by OSZPR01MB8499.jpnprd01.prod.outlook.com (2603:1096:604:16e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.20; Fri, 23 Sep
 2022 20:53:10 +0000
Received: from OSAPR01MB3892.jpnprd01.prod.outlook.com
 ([fe80::700f:4552:de5:c2dc]) by OSAPR01MB3892.jpnprd01.prod.outlook.com
 ([fe80::700f:4552:de5:c2dc%3]) with mapi id 15.20.5654.020; Fri, 23 Sep 2022
 20:53:10 +0000
From:   Alex Helms <alexander.helms.jy@renesas.com>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     robh+dt@kernel.org, sboyd@kernel.org, mturquette@baylibre.com,
        geert+renesas@glider.be, alexander.helms.jy@renesas.com
Subject: [PATCH v2 2/2] clk: Add support for Renesas ProXO oscillator
Date:   Fri, 23 Sep 2022 13:52:51 -0700
Message-Id: <20220923205251.1387-3-alexander.helms.jy@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220923205251.1387-1-alexander.helms.jy@renesas.com>
References: <20220923205251.1387-1-alexander.helms.jy@renesas.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0042.namprd02.prod.outlook.com
 (2603:10b6:a03:54::19) To OSAPR01MB3892.jpnprd01.prod.outlook.com
 (2603:1096:604:5b::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSAPR01MB3892:EE_|OSZPR01MB8499:EE_
X-MS-Office365-Filtering-Correlation-Id: 922fedd0-c1c1-427f-7b1f-08da9da5a017
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wn2KCGzQu3zCqfm4t3Q064YVXXXGSs053Y2cKkS8mZ9Ef51+6M1KvjhSpSsI7JGUztXTzzWdI21eYVkUuKvv3KsBg4eeDJxc6rPAGqkf3UZEtsIPp/ts3KJZQTxVbtaZXKQ1FnVvj0X3hEu/NjE3FmCgqSYEU/S8x2gVCL4kYWrcXXBNDMyIoXgUG+vYy10IT/9XkXe3vfkm72HMdZMciPDTu1W7Wb5Cu1seL5U0+J+taMhXqcSzmzUYCBbb1Z7MwdBfyWgHBQ1xWrKltOgb+hlDhKckYBslEeTufodWHRaN860jXxcNsoWmCxITGz6t1O948Mq+BBOa5PsAJRSOHM6sPcNJIiKajgqNuamKCit4Sw28fPzCSt3NCG1fsUdTt4o8MvczVp69CD0riIjm9WbNKk6IqtL2pXrdqF5aq1SAoIz3h3LgtVL4S7eJ2lKPVZu4i8HWDBm2WWGbE2uRRhuZdqof3LTT8ezvo1WTFszwW5/7Szl1djRMekb2hJy5DA2ni7CycEFQsz11HNAsDpuwSMd0XfgnIcrrIEZ7RDbDfCQL5WXQMBs/sYb0oGZ4N2gS5wUQusAGvEJstOX54zbOP9vDwIqJPMSJ7QfgpFfbF8OWDaCQmne+IZc/55YeuUm0JbahoeP512Fo2L0kOYR2s56Teum9y1/xAGR3y3DdJKDba3sTFBGT159KK79LWNMmu0+RqIfYwAZrTQ4KFX317V+Sp7BSnS8oGQs+OTAn904FySB6Hwrbvvd9ACkkBmlh0u3shICuudlBSYVLOA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB3892.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(396003)(366004)(346002)(376002)(451199015)(6486002)(6666004)(41300700001)(316002)(478600001)(6506007)(2616005)(8676002)(66556008)(4326008)(66476007)(66946007)(6512007)(107886003)(26005)(8936002)(30864003)(83380400001)(2906002)(38100700002)(38350700002)(1076003)(5660300002)(186003)(52116002)(86362001)(36756003)(103116003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2ernomYXt27wrKGaMW2cP5tASPWQgWhqhylkIQOqiVK/oddZ8pNKE9GXGFtQ?=
 =?us-ascii?Q?hdozLByehi1k8PvuPwU588fi/X9w0htBqAL1g94aw5g6CtPlJk+6nWdrGz2v?=
 =?us-ascii?Q?OtlJ9UfcN7Hz6DN5By+XBa8uHkHPgPrSyHpSxUVuqhBsjt6RvXTGaKaZoCmb?=
 =?us-ascii?Q?8TeoRca83Jz6cDo6GFQ2TwLrj/fU39hGc658ctAvhKew30SGm3nG1eLWUG1C?=
 =?us-ascii?Q?N6zrLUg160+nyWczyVM2bmNP6IlUPvT82NRRDKBTnvAcuFBM45W59OTOjdYx?=
 =?us-ascii?Q?woPbLSGAwkhbMD02xZBtBPBzGT1TOruw+VB4QkNgChpCFDvwX5Ehf4eRQQrc?=
 =?us-ascii?Q?Mzpn1hO6YF/EaYqA04WZBHzdwKT0/625HgooxQ1j2Tk830sDMIVY1BYe3n2/?=
 =?us-ascii?Q?JKiDgFmKqlBHShttL5jPxvRhNaK4E5nbHHKXDktRZvXHRQkuXROl6B7JOWRE?=
 =?us-ascii?Q?N0BtaAw8Pi9tMkShU1i+mIHHaxUHu+aq5GwZSj5tu9sjoouHVZiY5cv9WuOT?=
 =?us-ascii?Q?eXd9m8MwsbvhdKj45ynO8+g75bukjHscytVNPW32ch0iu94oNqD1n65ebilY?=
 =?us-ascii?Q?2pSiy9p4uMN/YEY4pQvU0dEfUThWNMdP2UUcrfw5AyghTe8NamdGSNd+3hQz?=
 =?us-ascii?Q?tQamnXcPJx9MLOeXVRXzeErOpDAuMykJQXNgAlUAFgC3jo0Y+eT6qY5rytT9?=
 =?us-ascii?Q?+0HLSF0Sqv1Lat0HrB1O2eYqh17tQUwdljj1wZrldP2Wm/nBkvaZ/4Ekvhqw?=
 =?us-ascii?Q?ew9iP6ixtvtrDqRtYIyQLGQlHA0aBillzbrkJRQ9QC7dLTEDxLncLY7N4PhV?=
 =?us-ascii?Q?ODv/toNLYzdy6XwhQYtrhoukXk7AsU0J+C8QfAeRdiUvj/SbqEazZHtSLpqX?=
 =?us-ascii?Q?AUztqqbStn6uWtm+Q6pNAK60G3Y13sXBJx0v21LGTid+KBG4d4sck1ffyp+c?=
 =?us-ascii?Q?tB9ZM24abHkprtxyJLsKXAVriLHCqVZzZx9CnNwbwKVabOuDtvpwAOpvrCYc?=
 =?us-ascii?Q?h3zcyvtp15l0rCaBWmJW/qqzPNMF+dsJVrjfroe2US1aly/fn/t6qI4Uywpn?=
 =?us-ascii?Q?9HrrNg4RBdyZnv7Zd/8ZJuY85/aVyoPlMillv/X8VlYKvSwEZ7BQXtivFFa8?=
 =?us-ascii?Q?/Txp7V81FI2z60iB4ULETE6eLeahqoLw7JcC7Ywrr3Lr1kpm2MEG8boLAsQW?=
 =?us-ascii?Q?11MPlD0xtstyYp9M3Hb8i3GWdC1sqMQRZafE4Q2R2UcVwEry0QOEkWYeNQoq?=
 =?us-ascii?Q?QWm1WiMQzoKah/vemYlpU+jyOv5pgQxIscl27+ISt/F6Ekz2TN1x62JpK4sM?=
 =?us-ascii?Q?f0xq1nJOQJRBcOM5c4X+dJab9aj/JyGvccZ68nTL071ZlL/1R6mWhJGo/ZxE?=
 =?us-ascii?Q?A8vCl6XUxhJAiFRT8ry3vagfryNIFlCNEsrvfMft/tA339KMQOKx3bWrWUu4?=
 =?us-ascii?Q?bLqmmqVifqbQwcXLrsPpwY4gRNJtPYObkTwWIF1bhgcGS6tKkoFgL1msQ9vu?=
 =?us-ascii?Q?vwk54+5Ye8F+a7L6ZxxcLPR3ge1/Vl9ADgW4/RY+/2vtLjMleGeSmRvThwxa?=
 =?us-ascii?Q?MuETpej2XiKbVxY5lsxi4LVMYwKYPKo0Dvxrk3LfEeRzLacLDc8tjQgdnX0T?=
 =?us-ascii?Q?G2bWJO5aAshplIQKEJoZ6y8=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 922fedd0-c1c1-427f-7b1f-08da9da5a017
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB3892.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 20:53:10.8498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xujfr/qjamttvpazAYETpKFjn2zMj28QOylAzJxyrXCtTSNpFRlHtJQSF22zcSbnHgsqru94K/NHeAVIndAuUryC5pkEd3d3+IYvJkiJolQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8499
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
index 000000000..f70fb8681
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
+	if (of_property_read_u32(client->dev.of_node, "renesas,crystal-frequency", &proxo->fxtal))
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


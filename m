Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 000E95B9006
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 23:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbiINVSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 17:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiINVSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 17:18:37 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2137.outbound.protection.outlook.com [40.107.113.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9677A844FB;
        Wed, 14 Sep 2022 14:18:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EZw8JVl+kQEJsOjFd5C9gb9HmFipMQZsE9uebpoEPGY3vZCb3d8dCxp/CmWmOPJZLND0K9G/0n7Thfb03CBXI+AiJLpe++oeiJwN/iocpMp3syzZmWwnRRaEIwUB0qDxxCAd+4t0Fi8q9johTCBfciX+qfBOZV2zPWBy4ALkhaGMz5NEOxKUA+eU51kbzP+U1uPXgySO//+aT/D6JKtRZAOjX3//zE6QSdZfkLfJMdXxF4S1q10szzxVI5DMcvXsdDhrCIdrqtDrThC2wZyiKdvfdplTMJ309hy6Pi4bzKA/RQbqxF1O/XQTcXAND4KF/mXDEHfyB+aGXJVPnZfnzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Azr2pqjowsxq8UmfO9lX15GbH6ISHr4XWfiTIAAolGw=;
 b=eCRY3yfCd1tje8OPp2HwcHhE1EYGeV3yYIjg8OV7W24Pq4MtC689qyuefd8R/s2Z3qz3m76QOwZiXOT5LLKkX5bJj0vvyhc5bzX85vxMv/BcPaeVdAjtpeKLWQCLaDJif/4BcWybCRseIIJ0pzWUI4HDnA7VOPFKu85lDIZZ5igmM5rQwgaRudeVEqhIMgRYC4Be5bCkEvagjjVf1Ka1vYglXqt9DVub5HbJCfnDfGvg7UH73SOd4PUEbalnf1T5JhhnFuLaMsx4ttILgZv3l8LRmV8PaV9e/TrAnaPUNQNbHGreTUNY37VJNXt/CFjRgaExAeGzs+UzdfyX21EyWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Azr2pqjowsxq8UmfO9lX15GbH6ISHr4XWfiTIAAolGw=;
 b=kRRYjT+gsveDDGS5dAFAQjx6RXhrT7ui49Xzq7icAUmVv+R9LU887/QiPt+wHmScj21wkj2HBlnd7ELup2nwxf+m3oReviJh7wUlvvgPW9IidK4FaPJ+lp1XHWBRaqxmnezALl1J3BHptQASVyp9bYnyz5UO3meNZub/5sZm6a4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from OSAPR01MB3892.jpnprd01.prod.outlook.com (2603:1096:604:5b::23)
 by TYCPR01MB10511.jpnprd01.prod.outlook.com (2603:1096:400:308::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Wed, 14 Sep
 2022 21:18:31 +0000
Received: from OSAPR01MB3892.jpnprd01.prod.outlook.com
 ([fe80::700f:4552:de5:c2dc]) by OSAPR01MB3892.jpnprd01.prod.outlook.com
 ([fe80::700f:4552:de5:c2dc%3]) with mapi id 15.20.5632.014; Wed, 14 Sep 2022
 21:18:31 +0000
From:   Alex Helms <alexander.helms.jy@renesas.com>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     robh+dt@kernel.org, sboyd@kernel.org, mturquette@baylibre.com,
        geert+renesas@glider.be, alexander.helms.jy@renesas.com
Subject: [PATCH 2/2] clk: Add support for Renesas ProXO oscillator
Date:   Wed, 14 Sep 2022 14:18:09 -0700
Message-Id: <20220914211809.22500-3-alexander.helms.jy@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220914211809.22500-1-alexander.helms.jy@renesas.com>
References: <20220914211809.22500-1-alexander.helms.jy@renesas.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0067.namprd05.prod.outlook.com
 (2603:10b6:a03:332::12) To OSAPR01MB3892.jpnprd01.prod.outlook.com
 (2603:1096:604:5b::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSAPR01MB3892:EE_|TYCPR01MB10511:EE_
X-MS-Office365-Filtering-Correlation-Id: 59b877a2-8f92-44ce-d353-08da9696aca1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RuAchaBH/SWnUq3zCaPuQGxrEYPsLQN1XNK5FlVIjToCoUVeKq3c87pfeMHRZB/vZrZ5g1Nbv9IAZ0TcReWPoXWcA3vc+dRIxFhaE+NG1ewUn2FfhuOVa4E5f7SwFktvzWOyu6DbxTG1zfGx96VSd7icU5kc/r07KICriKz5thRtudLSFuv9N+02YAJlY27zEMMsCZ9UrDElpqDyF4IA7wgEr6kjBHbCJqIHKVhjCMGhSU/ZyozzXsljMeIZ0s1uxDy0+CceDh4hUUO3pahl7VpQOX7Q2JlBVBSibihrFM83/m6uPlQJgjIGpl0JLB3+PCfDecW/XusrbFK6ZRyqU4UTjo2qQEMg6mc1QmDQYoSsG3KKIFID7GO16OSparBQ9CpxAHxHo42fMg6X8GgepVUWvfXKKXd3fo8y40n5I50/5pFiAPreZRQPmvn9df/JXf4bnlbXmqsmI59/J4ESngENJI2H8svYS/uGIZDyPnP2sFUoIcaoitMwVUxTx5Ze5hLXgyIRD51TUrlvyzB2NYSWRvS/KXJ4UGEgggQBRtoAf0p5TvbMboGfGWR2wsWXiw/7/kMBuUWc8qZq+FIQwZHVq7mF6K21ydfgwUXMlpfQLasTZHWgvXVBpEk2cfW8x5kfjUys64Kji6ZfGZl6Cu56PTnyT41Hm9/rsEPzUOOpZYHh3DInuKXXxHrSUA6k2uEPiXbux5Xnan/yKvyCdK65JvMgbuX+lfio2HlIAVfdNpofRamXK5vUnTSwUIStXoQESSpkCSsSYo9aChHlIg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB3892.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(39860400002)(346002)(396003)(136003)(451199015)(1076003)(4326008)(86362001)(6512007)(478600001)(2616005)(66556008)(30864003)(8676002)(38100700002)(26005)(6506007)(38350700002)(6486002)(107886003)(5660300002)(52116002)(41300700001)(316002)(103116003)(2906002)(6666004)(66946007)(83380400001)(66476007)(36756003)(8936002)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9WmhbGSC6pOKmR4/2Z6zgVJp3PgTL+QcE8tQGei+IlM+YHC1bPY2yhrNeCZF?=
 =?us-ascii?Q?bZrfqDhFCOdY1o+G7pzEN3eDoO7o1gUMIgKyEVGxj4LUlL93mri/k7TrRp5M?=
 =?us-ascii?Q?yUj/BEzAMDyDZS2m7HfwZl+KfJOli0oCRDk5iF0BStZmH25MngBfGsfGDFXq?=
 =?us-ascii?Q?a2dA+LEYhvvRyAD5C3DrzKDZFfIe1ctY/faclMvBm56ykXJQqB0d/2t/DWxD?=
 =?us-ascii?Q?TbCxqhHxYHEm5KbIvvu/26pKDJnotUfscoGRz8vKKJj4UVRHfM5qsP5QWGdp?=
 =?us-ascii?Q?Au9rH64XWcKgDYhZOb7JxkCf9awxFDi4c0EALqusUoO4hG5nnKAU51puScT9?=
 =?us-ascii?Q?T112rOEBq+2TiETKwF889l+cuaujBaJhfmWBl85qu5kiu9Ex+6xpUExHngh2?=
 =?us-ascii?Q?4Ugs0CMjsiKwDODz/fSWK+UPQB3FI/MJr4+N2UiNe3JsriHlcniLzlGWuMet?=
 =?us-ascii?Q?XpzRYR216eRE8lcxTPGLErEFCUsHXaiUAWmW8Hqd9xVumkuFSvx2VfIC1MHS?=
 =?us-ascii?Q?83CMjsc+6KhZTlSXnoRWAaCRVLgCFd1bo4tkVKVKfewK8oxWSbtWQJid8Wlq?=
 =?us-ascii?Q?/VmLcGQ/AjNnwLXsHCnEdTyUqtsTbi5de78E9M5FqENDP4VHnN0KIfPAAoeL?=
 =?us-ascii?Q?8zN5qOtaqCnnsloCUjsubB0496hsZLcMh1IEIa1FkWyKUqCAYGl0yVIfMdNb?=
 =?us-ascii?Q?XfF8d8UDRcbSByJwpfmSYQI3tGkhRXc9IE7WIBrWk0tZhhYU8vQG9UYhvKgf?=
 =?us-ascii?Q?lff7jraMLEcstXI4gz/tjM8uBDS+GclgROnfCs2zRHahKG90XrXbQeWi/M15?=
 =?us-ascii?Q?UxYwAAYfNsrAKxya2Raaj3vJQ4QErq2N/9wAJ1lveqV/2qUmCyn83V3he6TH?=
 =?us-ascii?Q?G+MBn68nKkTqXaM8CS1LPyZB2wUF2AbBPuaPb2w1rQ8Rr4Sp+9cKUWv1ZSyj?=
 =?us-ascii?Q?ClmyZUXxgM8Rp10cuWxns0H2mGT4L5aGzvSiozHEoE5YhTyX6KXp8Bux00Od?=
 =?us-ascii?Q?f4OpICyG/pzrJ3YageKVTN0+yy8D3CX2u37eUE/WskGLDwR0uXUU8a/xJytz?=
 =?us-ascii?Q?7AwPSifX+oIc3GeHqARNDyR2teFgshzHgurhW3fPcnnCJcgE1wYLL6jhkh2j?=
 =?us-ascii?Q?/YvU6xnDnvDJ7bydu7iIk0ddP4L+tl0GQHEBL8mQ1IzQmm/nvkPKEehwSN5A?=
 =?us-ascii?Q?4e2l2OePlgDF/h40hwwYYnqLpg7vPHFGwB1ie+r/WUpAxXNuNMmDBk7qCQq0?=
 =?us-ascii?Q?8k9Pc2RtzAQ9UjZxM8XguYn9LhK54GB7NJ2fKpX5+4wTeSZJnGF7Ry9uj7D4?=
 =?us-ascii?Q?Sc61kWSka2wlKj1gtBydnV+KJg97aoD7Gbu09KZgLC5nUi2uIgRwu0B7a1zB?=
 =?us-ascii?Q?SQs+E6MDnzV0FF6Dy/jGZWdhacfxY03grHtFU0HDH1Q6Wx4LfZAOxfOuBKxG?=
 =?us-ascii?Q?WUrtL6KP7Nfp+UbQcDso3J/diAEE6K0dQJ8Fs1A2gqPtoG5Bje8tTcTDRcux?=
 =?us-ascii?Q?wyaVYDIRgpSBAC3wmc/lPY6M84Zbt0V0B92xQfuj6lcB+zFhO7qyHLI0ssqN?=
 =?us-ascii?Q?flBSZ2CJQGcpXoXJaKdeDg77n7RBzfTDRqS7c5Hoipj7ZpHfvGY0gV65Zn/3?=
 =?us-ascii?Q?hLhZGHPiraY2P8xafCmHD7w=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59b877a2-8f92-44ce-d353-08da9696aca1
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB3892.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 21:18:31.3924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TKoyJ2Hkci5Wil2lw3VQn41xSz7ivrg/aFh9N0KeJ/7dyMi0kVcO6+NCHK5gTM0MHeF6u/PDqIRkT33PDUp+DShoSdtYppJ1s6WHXbQCiN4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10511
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
index 000000000..2216fc7f9
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
+	if (of_property_read_u32(client->dev.of_node, "renesas,xtal", &proxo->fxtal))
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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC4762A1D8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 20:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbiKOT06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 14:26:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbiKOT0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 14:26:52 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on20712.outbound.protection.outlook.com [IPv6:2a01:111:f403:7010::712])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBFE12F387;
        Tue, 15 Nov 2022 11:26:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KBr1LidQu2/udfdxwXwQeRLroinVD8a5qMJAjQGbl0HLdJ1ihfaSCoUL/lNUcnYKbYvfH+6yBR9YM9TIovOvEhBgRmc8kYwokKi+pl4lITz3I3FSsWkeSnmznHasfeKBlX3V1eNNN2ASMMpWyMUlph1j7CNrggqJDLEeS7veIZjhFqlXiR8/gvjJBNTNUC+fRNB3ImIWWrFfI53tmHzptiVngH5m4TQms1mXIZRxhk3fn4azo1TTMtehkcUcQou6jI4BWA4pX+QYu8qHKr8rDGdB0jGWSlk3LNlHkZ7mCmZznCsqQJ0qEc50Z8Rx8h5F665bRb0AzXL3CL3OGwpfMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8IuFB1Vr5rsAyTv8YvsBS/9JF4NwkIOSIpehyRSDp2g=;
 b=mZGVIc2YfO1EF7yqJkSf/20qAVltZMk0UI/Jv0O/TCJq8o5p9CBZtoi+YMGdqenyeJvzhVh1YAdBcJR0JNR6DZqQVs0f46emS0MSEdFRdNcYqmK0R7FlVaz+oLMKHhPtf0F4IL7NOMbMCd61Xy9lu1Zl7coDgl8QoC0qfYpM/DT6113UEq62QLML8Gc7hUi9JaVbeEQ3/bvJzcksNW7o7BEURGHJyAVDPKzu/TI6E34nf38uYfFXLwpOBZ3hH0py0p0Hq4xwOpr5xbWdSjQEG9pxrNJEuC+YibLIuDxiToTfVFBbpp0sBELAC/g8xHrOUF8Bti0Hye2p05d1vXY71Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8IuFB1Vr5rsAyTv8YvsBS/9JF4NwkIOSIpehyRSDp2g=;
 b=PQqOE3mJiuANjMikTHQoNvSNPnqrzXBan5dJRrsw7erJ9r0sP0T8zX9dkWqUAffTQKcisBNY9As0iTQ8RBCpTVfpRgNMlwMLEPK9EuFwS7q+Hubwmsk9/byf3/+uZa8iYxo+2WjyzcHMoGLex1TnlFkbVFQbrn9LvOZfUVncTRU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from OSAPR01MB3892.jpnprd01.prod.outlook.com (2603:1096:604:5b::23)
 by TYWPR01MB10539.jpnprd01.prod.outlook.com (2603:1096:400:2fe::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Tue, 15 Nov
 2022 19:26:45 +0000
Received: from OSAPR01MB3892.jpnprd01.prod.outlook.com
 ([fe80::60f7:f062:7c7c:d289]) by OSAPR01MB3892.jpnprd01.prod.outlook.com
 ([fe80::60f7:f062:7c7c:d289%6]) with mapi id 15.20.5813.018; Tue, 15 Nov 2022
 19:26:45 +0000
From:   Alex Helms <alexander.helms.jy@renesas.com>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        sboyd@kernel.org, mturquette@baylibre.com, geert+renesas@glider.be,
        alexander.helms.jy@renesas.com
Subject: [PATCH 2/2] clk: Add support for Renesas PhiClock clock generator
Date:   Tue, 15 Nov 2022 12:26:25 -0700
Message-Id: <20221115192625.9410-3-alexander.helms.jy@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221115192625.9410-1-alexander.helms.jy@renesas.com>
References: <20221115192625.9410-1-alexander.helms.jy@renesas.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0057.namprd11.prod.outlook.com
 (2603:10b6:a03:80::34) To OSAPR01MB3892.jpnprd01.prod.outlook.com
 (2603:1096:604:5b::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSAPR01MB3892:EE_|TYWPR01MB10539:EE_
X-MS-Office365-Filtering-Correlation-Id: de89b4b6-a9f1-4030-7ce5-08dac73f556f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0zmY4oGtxwUuHExzM3Qm5W1oxhDhiGQkjMDzBHRAgwOHc23z0oq+3MXAlfeEulmCWC9tDyMXKwGLUVowK1C+qTwYbWD6UWFgBDmXfT6mquDkWPIEsOA1DrAoz7r1uu05vEcdLMpqoOcJF387MjLThmZG13L0E0azY66hYH88dLNAmPblvDpJSLNxJp6wRzSbC9GAP1+BnRACYFl6lM8zjxJMH3g3OVQ7mqLSuEYCIbubSbBMZMeJTNn48oeuZaD2JI2nEcLr1DzUEgoFmI6Fidrt3p7JYCoUxoM2Xl1fCP+8xHlZ0/u17WA48rJE+BhTwt7fF8Jw6WCk1IjMc0CO6h4l3shRwVYFSi22UlRSLysoYPjLrbEkQpxhbc+uPvCduOGxzOcIMyptI50rpLZW8kHHdF4x8h2tdarnjxbFXhKUWqvfAbHX22i+0GlEr6rIt3oxYiOQ0H+L3vvY2G266kih6s71/igw43twaUJl/2Hid7dMBlm7/xXSitr+TI1fQa0Ln17Sqc06IS9Npg8/5WhotpnVVRM2YOg3DI8QkbJW+6XIVHxGldlnB6d+TgKPKGpQu+w0vcFhZ7fLAz0qpDqEP2Flr0sTQ3wTd081XNST6UWqEJ55+j4v0qWyZpR4PB0mW36qTJbL38iH71iFrIenw2NdXMh+7l71va7hU61KRlfTvkS28SJ54yQJaSu6ZjTjULgxtWBKlDXTv5a7c48cy8vSZxWRPerUY+FgniEq/s5Ykicstl0T0mHwq0tyuPPOIn8xu+evl09E5G8+Pg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB3892.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(396003)(136003)(376002)(346002)(451199015)(2906002)(8936002)(8676002)(83380400001)(36756003)(2616005)(66946007)(66556008)(66476007)(41300700001)(86362001)(6506007)(38350700002)(38100700002)(52116002)(186003)(5660300002)(1076003)(30864003)(4326008)(103116003)(316002)(26005)(6486002)(107886003)(6512007)(478600001)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aDm2cLfwcZ28eeokoCPcipllW9pYoE5XFMEfu1wMEZHxoMMgrBwYxRMQnsZk?=
 =?us-ascii?Q?Ye5Y5S05n3XcCK5iRsKgnem0CMM471rMKbNKEAocAbbW1fINdco2MrX7gP1a?=
 =?us-ascii?Q?aSm9eROSsHiW6Vk1ixPcmGKKkbvnPGvYtM+ON5nrqFi+CevJ5WY0wPv1Z2oQ?=
 =?us-ascii?Q?UCw8OdDByjOQ4UUEhSafUlCuv/I/HIRLWQP9Yi8KP5e63z+Ox7x+WvSwkAbo?=
 =?us-ascii?Q?Hr7WZH0H/u+lJaTkomB8uPXYkvZdzV6UDNO9+EmpvmHIeuWbcrb12oCV2N8X?=
 =?us-ascii?Q?JgdjswdC3jQXTiawfrMw/yIPAS/w+8VYYrYoPRzXDUykuTo+1PLAOeWLS6s4?=
 =?us-ascii?Q?w0WtvDJqAheiDwAzsW5ScmXSvT9ZRWCB4KSEb1lL9/TBno+lRcIfdTOthpgy?=
 =?us-ascii?Q?A/OpKQz2bWZbnOrzN5asiLFCxxdaIU8xXR853vQdSTEwDdgsaUq+cIMA7S6G?=
 =?us-ascii?Q?UrumkhHBFzuT43GhoNYmrIzy3n8mvpE63GJ+HMIrX1ndNZ0m7EAKa7WCFoIu?=
 =?us-ascii?Q?SOOsMAxWgHEeipIBbZHefirJhIhzn0q5eYTQ4AotaMdn6j/dtpJnxq1+vpii?=
 =?us-ascii?Q?iotPPxdDhCZoUxJXTdL5Yk7138V6utemLtKj4TrxvzU4V5o8H+4VMw8hzT7X?=
 =?us-ascii?Q?QBsMGLUQztsB4min4K4r+sQQCAMZ/lU9VfC503CpiIOWDsr0cnF3j/5oN4zI?=
 =?us-ascii?Q?x/YQeLA9jwNask2gKvLWBfyehSjU5X+A0cmZtaQ14KmUQcbxE5i6RsYTA351?=
 =?us-ascii?Q?gTdb+GRzNvr1aMVQE492AttBvkqbgXscqkUZSTnDP7H+ozMkregObc5rwKZC?=
 =?us-ascii?Q?8xn0yU5Gi4iytilyEbRuCNg1UMV+xULnA3xbDv53yFcsdrobvqxrEoSgJRPA?=
 =?us-ascii?Q?rROH+P4PEMYwKcl4pKTR5cJkc/mGEkQQ9nOsV8wmoInHyUo/eWFXzeuXcIKC?=
 =?us-ascii?Q?syHAs7WIDHR7nFWGXV9c5cSpyKcGAcXKeCHDgrMWaiOXT6PvN2Y2eI/euzXq?=
 =?us-ascii?Q?Aw7VQncR7cuemMHGMRGiZ3bwvSFDjsiWttZ6S6IY55M7tLLk3BiapjyovB62?=
 =?us-ascii?Q?QT9n3/x5DXV4JEwY8gS8vHsOZb1a31JKrBk4ksPC40cwmwZyXTGAP0fWG63N?=
 =?us-ascii?Q?5aGurk5W6uwrihiKqAAk1VSN8LwvVx5hNJN4L5gvc7qqsFKNSr3TKPcFiGL0?=
 =?us-ascii?Q?vcw0hchutheMpIzVxhxmic49VdFEinUBm3hmM6xRrO5ba2++sKGxvWHmHIT+?=
 =?us-ascii?Q?n5Ig2VcF+B9eB9acT+vmUB0frHiOYOcmKZLp70/0O/pWNIH6gCfv24O5x1lO?=
 =?us-ascii?Q?LAClJuGpAjaPQEJhPFJWeSGOwo1n3zWKRosaH2FgkQaOB4XTnWRMpDUHARvx?=
 =?us-ascii?Q?/7VaLi2VxV5BDSOdOmHvZbWR+k2JiVEPy3/ymD3tqLWdDdWJetrDZMwVi6mc?=
 =?us-ascii?Q?SoBwT4iZUe3U9REpsOYzE12sgALg2/uuadK5xvXUE/sLzR8rEovU0WyO7q/b?=
 =?us-ascii?Q?llgB8RTWr9AYBAJJt91+RPs4fMEe8IABcSPx9I9z48G9zR0C0v/nMPw80HP2?=
 =?us-ascii?Q?I52Zwoa2T2RExgMvWDaUkkBTELBQhLco3e7HETwFcOr+1JfronTaX46nBzPU?=
 =?us-ascii?Q?Q0ezTrDhozotuXSqoXG1zfg=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de89b4b6-a9f1-4030-7ce5-08dac73f556f
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB3892.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 19:26:45.8614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a4/pDWQMDYZSVUEn4U0ah97/a/K6lU0hyl9nHFom4kzCyACFLsln+Uyqcf0L61p9cRAUE2bETJWPl/Shh725ihnMEz1+s6OO+ZwivQKDO6g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10539
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add clock device driver for Renesas PhiClock clock generator. The device
takes 1 input clock and has 1 ref out and 2 clock outputs that are the
same frequency. This driver is for the 9FGV1006 device. It supports
changing the frequency with or without spread spectrum enabled, and gating
each output clock.

Signed-off-by: Alex Helms <alexander.helms.jy@renesas.com>
---
 MAINTAINERS                |   1 +
 drivers/clk/Kconfig        |   9 +
 drivers/clk/Makefile       |   1 +
 drivers/clk/clk-phiclock.c | 729 +++++++++++++++++++++++++++++++++++++
 4 files changed, 740 insertions(+)
 create mode 100644 drivers/clk/clk-phiclock.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 7eabe930b..0a8b429e1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17645,6 +17645,7 @@ RENESAS PHICLOCK CLOCK DRIVER
 M:	Alex Helms <alexander.helms.jy@renesas.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/clock/renesas,phiclock.yaml
+F:	drivers/clk/clk-phiclock.c
 
 RESET CONTROLLER FRAMEWORK
 M:	Philipp Zabel <p.zabel@pengutronix.de>
diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index d79905f3e..6bcdde0f0 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -386,6 +386,15 @@ config COMMON_CLK_VC7
 	  Renesas Versaclock7 is a family of configurable clock generator
 	  and jitter attenuator ICs with fractional and integer dividers.
 
+config COMMON_CLK_PHICLOCK
+	tristate "Clock driver for Renesas PhiClock devices"
+	depends on I2C
+	depends on OF
+	select REGMAP_I2C
+	help
+	  Renesas PhiClock is a clock generator with a fractional divider
+	  and spread spectrum support.
+
 config COMMON_CLK_STM32MP135
 	def_bool COMMON_CLK && MACH_STM32MP13
 	help
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index e3ca0d058..6b12861f7 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -52,6 +52,7 @@ obj-$(CONFIG_ARCH_NPCM7XX)	    	+= clk-npcm7xx.o
 obj-$(CONFIG_ARCH_NSPIRE)		+= clk-nspire.o
 obj-$(CONFIG_COMMON_CLK_OXNAS)		+= clk-oxnas.o
 obj-$(CONFIG_COMMON_CLK_PALMAS)		+= clk-palmas.o
+obj-$(CONFIG_COMMON_CLK_PHICLOCK)	+= clk-phiclock.o
 obj-$(CONFIG_CLK_LS1028A_PLLDIG)	+= clk-plldig.o
 obj-$(CONFIG_COMMON_CLK_PWM)		+= clk-pwm.o
 obj-$(CONFIG_CLK_QORIQ)			+= clk-qoriq.o
diff --git a/drivers/clk/clk-phiclock.c b/drivers/clk/clk-phiclock.c
new file mode 100644
index 000000000..cff1547e6
--- /dev/null
+++ b/drivers/clk/clk-phiclock.c
@@ -0,0 +1,729 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Common clock framework driver for the PhiClock 9FGV1006 clock generator.
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
+#include <linux/math64.h>
+#include <linux/minmax.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/regmap.h>
+#include <linux/swab.h>
+
+/* VCO range is 2.3GHz to 2.6GHz */
+#define PHICLOCK_FVCO_MIN		2300000000UL
+#define PHICLOCK_FVCO_MAX		2600000000UL
+
+/* FOUT range is 10MHz to 325MHz */
+#define PHICLOCK_FOUT_MIN		10000000UL
+#define PHICLOCK_FOUT_MAX		325000000UL
+
+/* FPFD max frequency is 160MHz */
+#define PHICLOCK_FPFD_MAX		160000000UL
+
+#define PHICLOCK_NUM_CLKS		4
+#define PHICLOCK_REF0			0
+#define PHICLOCK_OUT			1
+#define PHICLOCK_OUT0			2
+#define PHICLOCK_OUT1			3
+
+#define PHICLOCK_FBFRAC_BITS		16
+#define PHICLOCK_FBFRAC_DIVISOR		BIT(PHICLOCK_FBFRAC_BITS)
+
+#define PHICLOCK_FBDIV_MIN		12
+#define PHICLOCK_FBDIV_MAX		255
+
+#define PHICLOCK_OUTDIV_MIN		8
+#define PHICLOCK_OUTDIV_MAX		4095
+
+#define PHICLOCK_REG_REF0		0x01
+#define PHICLOCK_REG_OUT0		0x05
+#define PHICLOCK_REG_OUT1		0x0b
+#define PHICLOCK_REG_SS_CNFG_PERIOD	0x10
+#define PHICLOCK_REG_FBINT		0x12
+#define PHICLOCK_REG_FBFRAC		0x13
+#define PHICLOCK_REG_SS_STEP		0x15
+#define PHICLOCK_REG_FBCNFG		0x18
+#define PHICLOCK_REG_CALIBRATION	0x1a
+#define PHICLOCK_REG_OUTDIV		0x21
+#define PHICLOCK_REG_DOUBLER		0x25
+
+#define PHICLOCK_REF_EN_MASK		0x40
+#define PHICLOCK_OUT_EN_MASK		0x80
+#define PHICLOCK_FBMODE_MASK		0x02
+#define PHICLOCK_OUTDIV_11_8_MASK	0xf0
+#define PHICLOCK_DOUBLER_MASK		0x20
+#define PHICLOCK_VCO_CAL_MASK		0x80
+#define PHICLOCK_SS_EN_MASK		0x80
+#define PHICLOCK_SS_PERIOD_11_8_MASK	0x0f
+
+enum phiclock_pll_mode {
+	PLL_MODE_FRAC,
+	PLL_MODE_INT,
+};
+
+enum phiclock_ss_direction {
+	SS_DOWN,
+	SS_CENTER,
+};
+
+enum phiclock_model {
+	PHICLOCK_9FGV1006,
+};
+
+struct phiclock_data;
+
+struct phiclock_clk_hw {
+	struct clk_hw hw;
+	struct clk_init_data init;
+	struct phiclock_data *phiclock;
+	unsigned int idx;
+	u8 enabled;
+};
+
+struct phiclock_data {
+	struct regmap *regmap;
+	struct i2c_client *i2c_client;
+	struct clk *xin_clkin_clk;
+	struct phiclock_clk_hw hw[PHICLOCK_NUM_CLKS];
+	enum phiclock_model model;
+	enum phiclock_ss_direction ss_direction;
+	u16 ss_amount;
+	u16 ss_modulation;
+	u32 fvco;
+	u32 fout;
+	u8 doubler;
+	u8 fbint;
+	u16 fbfrac;
+	u16 outdiv;
+	u8 ss_en;
+	u16 ss_period;
+	u16 ss_step;
+};
+
+static inline struct phiclock_clk_hw *to_phiclock_clk(struct clk_hw *hw)
+{
+	return container_of(hw, struct phiclock_clk_hw, hw);
+}
+
+static int phiclock_get_en_reg(unsigned int idx, unsigned int *reg, unsigned int *mask)
+{
+	switch (idx) {
+	case PHICLOCK_REF0:
+		*reg = PHICLOCK_REG_REF0;
+		*mask = PHICLOCK_REF_EN_MASK;
+		break;
+	case PHICLOCK_OUT0:
+		*reg = PHICLOCK_REG_OUT0;
+		*mask = PHICLOCK_OUT_EN_MASK;
+		break;
+	case PHICLOCK_OUT1:
+		*reg = PHICLOCK_REG_OUT1;
+		*mask = PHICLOCK_OUT_EN_MASK;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static u32 phiclock_calc_fvco(struct phiclock_data *phiclock)
+{
+	u64 fref, fvco;
+	u8 doubler;
+
+	doubler = phiclock->doubler ? 2 : 1;
+	fref = clk_get_rate(phiclock->xin_clkin_clk) * doubler;
+
+	fvco = 2 * ((fref * phiclock->fbint) +
+		div_u64(fref * phiclock->fbfrac, PHICLOCK_FBFRAC_DIVISOR));
+
+	return (u32)fvco;
+}
+
+static int phiclock_get_divs(struct phiclock_data *phiclock, u8 *doubler, u8 *fbint, u16 *fbfrac,
+			     u16 *outdiv)
+{
+	int ret;
+	unsigned int tmp;
+	u8 reg[3];
+
+	ret = regmap_bulk_read(phiclock->regmap, PHICLOCK_REG_FBINT, reg, 3);
+	if (ret)
+		return ret;
+
+	*fbint = reg[0];
+	*fbfrac = (reg[1] << 8) + reg[2];
+
+	ret = regmap_bulk_read(phiclock->regmap, PHICLOCK_REG_OUTDIV, reg, 2);
+	if (ret)
+		return ret;
+
+	*outdiv = ((reg[1] & PHICLOCK_OUTDIV_11_8_MASK) << 8) + reg[0];
+	if (*outdiv < PHICLOCK_OUTDIV_MIN)
+		*outdiv = PHICLOCK_OUTDIV_MIN;
+	if (*outdiv > PHICLOCK_OUTDIV_MAX)
+		*outdiv = PHICLOCK_OUTDIV_MAX;
+
+	ret = regmap_read(phiclock->regmap, PHICLOCK_REG_DOUBLER, &tmp);
+	if (ret)
+		return ret;
+
+	*doubler = (tmp & PHICLOCK_DOUBLER_MASK) >> 5;
+
+	pr_debug("doubler: %u, fbint: %u, fbfrac: %u, outdiv: %u\n",
+		 *doubler, *fbint, *fbfrac, *outdiv);
+
+	return ret;
+}
+
+static int phiclock_get_ss(struct phiclock_data *phiclock, u8 *ss_en, u16 *ss_period, u16 *ss_step)
+{
+	int ret;
+	u8 reg[2];
+
+	*ss_en = 0;
+	*ss_period = 0;
+	*ss_step = 0;
+
+	ret = regmap_bulk_read(phiclock->regmap, PHICLOCK_REG_SS_CNFG_PERIOD, reg, 2);
+	if (ret)
+		return ret;
+
+	*ss_en = !!(reg[0] & PHICLOCK_SS_EN_MASK);
+	*ss_period = ((reg[0] & PHICLOCK_SS_PERIOD_11_8_MASK) << 8) + reg[1];
+
+	ret = regmap_bulk_read(phiclock->regmap, PHICLOCK_REG_SS_STEP, reg, 2);
+	if (ret)
+		return ret;
+
+	*ss_step = (reg[0] << 8) + reg[1];
+
+	pr_debug("ss_en: %u, ss_period: %u, ss_step: %u\n", *ss_en, *ss_period, *ss_step);
+
+	return ret;
+}
+
+static int phiclock_get_defaults(struct phiclock_data *phiclock)
+{
+	int ret;
+	unsigned int ref0, out0, out1;
+
+	ret = phiclock_get_divs(phiclock, &phiclock->doubler, &phiclock->fbint, &phiclock->fbfrac,
+				&phiclock->outdiv);
+	if (ret)
+		return ret;
+
+	phiclock->fvco = phiclock_calc_fvco(phiclock);
+	phiclock->fout = phiclock->fvco / phiclock->outdiv;
+
+	ret = phiclock_get_ss(phiclock, &phiclock->ss_en, &phiclock->ss_period, &phiclock->ss_step);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(phiclock->regmap, PHICLOCK_REG_REF0, &ref0);
+	ret = regmap_read(phiclock->regmap, PHICLOCK_REG_OUT0, &out0);
+	ret = regmap_read(phiclock->regmap, PHICLOCK_REG_OUT1, &out1);
+	if (ret)
+		return ret;
+
+	ref0 = (ref0 & PHICLOCK_REF_EN_MASK) >> __ffs(PHICLOCK_REF_EN_MASK);
+	out0 = (out0 & PHICLOCK_OUT_EN_MASK) >> __ffs(PHICLOCK_OUT_EN_MASK);
+	out1 = (out1 & PHICLOCK_OUT_EN_MASK) >> __ffs(PHICLOCK_OUT_EN_MASK);
+	phiclock->hw[PHICLOCK_REF0].enabled = ref0;
+	phiclock->hw[PHICLOCK_OUT0].enabled = out0;
+	phiclock->hw[PHICLOCK_OUT1].enabled = out1;
+
+	pr_debug("doubler: %u, fbint: %u, fbfrac: %u, outdiv: %u, fvco: %u, fout: %u\n",
+		 phiclock->doubler, phiclock->fbint, phiclock->fbfrac, phiclock->outdiv,
+		 phiclock->fvco, phiclock->fout);
+
+	pr_debug("ref0_en: %u, out0_en: %u, out1_en: %u\n", ref0, out0, out1);
+
+	pr_debug("ss_en: %u, ss_period: %u, ss_step: %u\n",
+		 phiclock->ss_en, phiclock->ss_period, phiclock->ss_step);
+
+	return ret;
+}
+
+static int phiclock_calc_divs(const unsigned long frequency, const struct phiclock_data *phiclock,
+			      u8 *doubler, u8 *fbint, u16 *fbfrac, u16 *outdiv, u32 *fout,
+			      u32 *fvco, u16 *ss_period, u16 *ss_step)
+{
+	u16 outdivstart;
+	u32 fpfd;
+	unsigned long fin;
+	bool found = false, allow_frac = false;
+	bool ss_en = phiclock->ss_en && phiclock->ss_amount && phiclock->ss_modulation;
+
+	if (frequency == 0)
+		return -EINVAL;
+
+	if (phiclock->fbint == 0)
+		return -EINVAL;
+
+	fin = clk_get_rate(phiclock->xin_clkin_clk);
+	*doubler = 2 * fin <= PHICLOCK_FPFD_MAX ? 1 : 0;
+	*fbint = PHICLOCK_FBDIV_MIN;
+	*fbfrac = 0;
+	*outdiv = PHICLOCK_OUTDIV_MIN;
+	*fout = PHICLOCK_FOUT_MIN;
+	*fvco = *outdiv * frequency;
+
+	fpfd = fin * (*doubler + 1);
+	outdivstart = 1 + (PHICLOCK_FVCO_MIN / frequency);
+
+	if (ss_en)
+		allow_frac = true;
+
+retry:
+	for (*outdiv = outdivstart; *outdiv <= PHICLOCK_OUTDIV_MAX; ++(*outdiv)) {
+		*fvco = *outdiv * frequency;
+		if (*fvco > PHICLOCK_FVCO_MAX) {
+			allow_frac = true;
+			goto retry;
+		}
+
+		*fbint = (*fvco >> 1) / fpfd;
+		*fbfrac = (*fvco >> 1) % fpfd;
+
+		if (*fbint < PHICLOCK_FBDIV_MIN)
+			*fbint = PHICLOCK_FBDIV_MIN;
+		if (*fbint > PHICLOCK_FBDIV_MAX)
+			*fbint = PHICLOCK_FBDIV_MAX;
+
+		if (*fbfrac == 0) {
+			found = true;
+			break;
+		}
+
+		if (allow_frac) {
+			*fbfrac = 1 + div_u64(((u64)*fvco >> 1) % fpfd << PHICLOCK_FBFRAC_BITS,
+					      fpfd);
+			found = true;
+			break;
+		}
+	}
+
+	if (!found)
+		return -EINVAL;
+
+	if (*fvco < PHICLOCK_FVCO_MIN || *fvco > PHICLOCK_FVCO_MAX)
+		return -EINVAL;
+
+	if (ss_en) {
+		unsigned int ss_amount = phiclock->ss_amount;
+
+		if (phiclock->ss_direction == SS_CENTER) {
+			u64 num, den;
+			u32 rem;
+
+			num = (u64)*fbint * PHICLOCK_FBFRAC_DIVISOR + *fbfrac;
+			num *= 10000 + phiclock->ss_amount;
+			den = 10000 * PHICLOCK_FBFRAC_DIVISOR;
+			*fbint = div_u64_rem(num, den, &rem);
+			*fbfrac = rem / 10000;
+
+			/* center spread requires peak-peak */
+			ss_amount *= 2;
+		}
+
+		*ss_period = fpfd / (4 * phiclock->ss_modulation);
+		*ss_step = (u16)div_u64((ss_amount * (u64)*fbint) << 24, 20000 * *ss_period);
+	}
+
+	*fvco = 2 * (((u64)fpfd * *fbint) + div_u64((u64)fpfd * *fbfrac, PHICLOCK_FBFRAC_DIVISOR));
+	*fout = *fvco / *outdiv;
+
+	if (*fout < PHICLOCK_FOUT_MIN || *fout > PHICLOCK_FOUT_MAX)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int phiclock_update_frequency(struct phiclock_data *phiclock)
+{
+	int ret;
+	enum phiclock_pll_mode pll_mode;
+	u8 reg[3];
+
+	pll_mode = phiclock->fbfrac == 0 ? PLL_MODE_INT : PLL_MODE_FRAC;
+
+	if (phiclock->ss_period == 0 && phiclock->ss_step == 0)
+		phiclock->ss_en = 0;
+
+	reg[0] = phiclock->fbint;
+	reg[1] = (phiclock->fbfrac >> 8) & 0xff;
+	reg[2] = phiclock->fbfrac & 0xff;
+	ret = regmap_bulk_write(phiclock->regmap, PHICLOCK_REG_FBINT, reg, 3);
+
+	reg[0] = phiclock->outdiv & 0xff;
+	reg[1] = (phiclock->outdiv & PHICLOCK_OUTDIV_11_8_MASK) >> 4;
+	ret = regmap_bulk_write(phiclock->regmap, PHICLOCK_REG_OUTDIV, reg, 2);
+
+	ret = regmap_write_bits(phiclock->regmap, PHICLOCK_REG_FBCNFG, PHICLOCK_FBMODE_MASK,
+				pll_mode << __ffs(PHICLOCK_FBMODE_MASK));
+
+	ret = regmap_write_bits(phiclock->regmap, PHICLOCK_REG_DOUBLER, PHICLOCK_DOUBLER_MASK,
+				phiclock->doubler << __ffs(PHICLOCK_DOUBLER_MASK));
+
+	ret = regmap_write_bits(phiclock->regmap, PHICLOCK_REG_SS_CNFG_PERIOD, PHICLOCK_SS_EN_MASK,
+				phiclock->ss_en << __ffs(PHICLOCK_SS_EN_MASK));
+
+	reg[0] = phiclock->ss_en << __ffs(PHICLOCK_SS_EN_MASK);
+	reg[0] += ((phiclock->ss_period >> 8) & PHICLOCK_SS_PERIOD_11_8_MASK);
+	reg[1] = phiclock->ss_period & 0xff;
+	ret = regmap_bulk_write(phiclock->regmap, PHICLOCK_REG_SS_CNFG_PERIOD, reg, 2);
+
+	reg[0] = (phiclock->ss_step >> 8) & 0xff;
+	reg[1] = phiclock->ss_step & 0xff;
+	ret = regmap_bulk_write(phiclock->regmap, PHICLOCK_REG_SS_STEP, reg, 2);
+
+	/* VCO calibration to apply the changes, cal starts on the 0->1 transition */
+	ret = regmap_write_bits(phiclock->regmap, PHICLOCK_REG_CALIBRATION, PHICLOCK_VCO_CAL_MASK,
+				0 << __ffs(PHICLOCK_VCO_CAL_MASK));
+	ret = regmap_write_bits(phiclock->regmap, PHICLOCK_REG_CALIBRATION, PHICLOCK_VCO_CAL_MASK,
+				1 << __ffs(PHICLOCK_VCO_CAL_MASK));
+
+	return ret;
+}
+
+static int phiclock_set_frequency(struct phiclock_data *phiclock, unsigned long frequency)
+{
+	int ret;
+
+	ret = phiclock_calc_divs(frequency, phiclock,
+				 &phiclock->doubler, &phiclock->fbint, &phiclock->fbfrac,
+				 &phiclock->outdiv, &phiclock->fout, &phiclock->fvco,
+				 &phiclock->ss_period, &phiclock->ss_step);
+	if (ret)
+		return ret;
+
+	pr_debug("doubler: %u, fbint: %u, fbfrac: %u, outdiv: %u, fvco: %u, fout: %u\n",
+		 phiclock->doubler, phiclock->fbint, phiclock->fbfrac, phiclock->outdiv,
+		 phiclock->fvco, phiclock->fout);
+
+	if (phiclock->ss_en)
+		pr_debug("ss_period: %u, ss_step: %u\n",
+			 phiclock->ss_period, phiclock->ss_step);
+
+	ret = phiclock_update_frequency(phiclock);
+
+	return ret;
+}
+
+static unsigned long phiclock_clk_recalc_rate(struct clk_hw *hw, unsigned long rate)
+{
+	struct phiclock_clk_hw *clk_hw = to_phiclock_clk(hw);
+	struct phiclock_data *phiclock = clk_hw->phiclock;
+	int ret;
+	u8 doubler, fbint;
+	u16 fbfrac, outdiv;
+	u32 fvco, fout;
+
+	ret = phiclock_get_divs(phiclock, &doubler, &fbint, &fbfrac, &outdiv);
+	if (ret) {
+		dev_err(&phiclock->i2c_client->dev, "recalc rate error\n");
+		return 0;
+	}
+
+	fvco = phiclock_calc_fvco(phiclock);
+	fout = fvco / outdiv;
+
+	return fout;
+}
+
+static long phiclock_clk_round_rate(struct clk_hw *hw, unsigned long rate,
+				    unsigned long *parent_rate)
+{
+	struct phiclock_clk_hw *clk_hw = to_phiclock_clk(hw);
+	struct phiclock_data *phiclock = clk_hw->phiclock;
+	int ret;
+	u8 doubler, fbint, ss_en;
+	u16 fbfrac, outdiv, ss_period, ss_step;
+	u32 fout, fvco;
+
+	if (!rate)
+		return 0;
+
+	/* Temporarily disable spread spectrum for rounding. */
+	ss_en = phiclock->ss_en;
+	phiclock->ss_en = 0;
+	ret = phiclock_calc_divs(rate, phiclock, &doubler, &fbint, &fbfrac, &outdiv, &fout, &fvco,
+				 &ss_period, &ss_step);
+	phiclock->ss_en = ss_en;
+	if (ret) {
+		dev_err(&phiclock->i2c_client->dev, "round rate error\n");
+		return 0;
+	}
+
+	return fout;
+}
+
+static int phiclock_clk_set_rate(struct clk_hw *hw, unsigned long rate, unsigned long parent_rate)
+{
+	struct phiclock_clk_hw *clk_hw = to_phiclock_clk(hw);
+	struct phiclock_data *phiclock = clk_hw->phiclock;
+
+	if (rate < PHICLOCK_FOUT_MIN || rate > PHICLOCK_FOUT_MAX) {
+		dev_err(&phiclock->i2c_client->dev, "requested frequency %lu Hz is out of range\n",
+			rate);
+		return -EINVAL;
+	}
+
+	return phiclock_set_frequency(phiclock, rate);
+}
+
+static int phiclock_clk_prepare(struct clk_hw *hw)
+{
+	struct phiclock_clk_hw *clk_hw = to_phiclock_clk(hw);
+	struct phiclock_data *phiclock = clk_hw->phiclock;
+	int err;
+	unsigned int reg, mask;
+
+	pr_debug("prepare %s", clk_hw_get_name(hw));
+
+	err = phiclock_get_en_reg(clk_hw->idx, &reg, &mask);
+	if (err)
+		return err;
+
+	clk_hw->enabled = 1;
+	err = regmap_update_bits(phiclock->regmap, reg, mask, mask);
+	return err;
+}
+
+static void phiclock_clk_unprepare(struct clk_hw *hw)
+{
+	struct phiclock_clk_hw *clk_hw = to_phiclock_clk(hw);
+	struct phiclock_data *phiclock = clk_hw->phiclock;
+	int err;
+	unsigned int reg, mask;
+
+	pr_debug("unprepare %s", clk_hw_get_name(hw));
+
+	err = phiclock_get_en_reg(clk_hw->idx, &reg, &mask);
+	if (!err) {
+		clk_hw->enabled = 0;
+		regmap_update_bits(phiclock->regmap, reg, mask, 0);
+	}
+}
+
+static int phiclock_clk_is_prepared(struct clk_hw *hw)
+{
+	struct phiclock_clk_hw *clk_hw = to_phiclock_clk(hw);
+	struct phiclock_data *phiclock = clk_hw->phiclock;
+	int err;
+	unsigned int reg, mask, val = 0;
+
+	pr_debug("is_prepared %s", clk_hw_get_name(hw));
+
+	err = phiclock_get_en_reg(clk_hw->idx, &reg, &mask);
+	if (err)
+		return err;
+
+	err = regmap_read(phiclock->regmap, reg, &val);
+	if (err)
+		return err;
+
+	return !!(val & mask);
+}
+
+static const struct i2c_device_id phiclock_i2c_id[] = {
+	{ "9fgv1006", PHICLOCK_9FGV1006 },
+	{},
+};
+MODULE_DEVICE_TABLE(i2c, phiclock_i2c_id);
+
+static const struct regmap_config phiclock_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = 0x25,
+	.cache_type = REGCACHE_RBTREE
+};
+
+struct phiclock_clk {
+	const char *name;
+	int parent_index;
+	const struct clk_ops ops;
+};
+
+static const struct phiclock_clk phiclock_clks[PHICLOCK_NUM_CLKS] = {
+	[PHICLOCK_REF0] = {
+		.name = "phiclock_ref0",
+		.parent_index = -1,
+		.ops = {
+			.prepare	= phiclock_clk_prepare,
+			.unprepare	= phiclock_clk_unprepare,
+			.is_prepared	= phiclock_clk_is_prepared,
+		},
+	},
+	[PHICLOCK_OUT] = {
+		.name = "phiclock_out",
+		.parent_index = -1,
+		.ops = {
+			.recalc_rate	= phiclock_clk_recalc_rate,
+			.round_rate	= phiclock_clk_round_rate,
+			.set_rate	= phiclock_clk_set_rate,
+		},
+	},
+	[PHICLOCK_OUT0] = {
+		.name = "phiclock_out0",
+		.parent_index = PHICLOCK_OUT,
+		.ops = {
+			.prepare	= phiclock_clk_prepare,
+			.unprepare	= phiclock_clk_unprepare,
+			.is_prepared	= phiclock_clk_is_prepared,
+		},
+	},
+	[PHICLOCK_OUT1] = {
+		.name = "phiclock_out1",
+		.parent_index = PHICLOCK_OUT,
+		.ops = {
+			.prepare	= phiclock_clk_prepare,
+			.unprepare	= phiclock_clk_unprepare,
+			.is_prepared	= phiclock_clk_is_prepared,
+		},
+	},
+};
+
+static struct clk_hw *phiclock_of_clk_get(struct of_phandle_args *clkspec, void *data)
+{
+	struct phiclock_data *driver_data = data;
+	unsigned int idx = clkspec->args[0];
+
+	return &driver_data->hw[idx].hw;
+}
+
+static int phiclock_probe(struct i2c_client *client)
+{
+	struct phiclock_data *phiclock;
+	struct device *dev = &client->dev;
+	const char *xin_clkin_name, *spread_spectrum_type_name;
+	unsigned int i;
+	u32 ss_amount = 0, ss_modulation = 0;
+	enum phiclock_ss_direction ss_direction = SS_DOWN;
+	int ret;
+
+	phiclock = devm_kzalloc(dev, sizeof(*phiclock), GFP_KERNEL);
+	if (!phiclock)
+		return -ENOMEM;
+
+	phiclock->xin_clkin_clk = devm_clk_get(dev, "xin-clkin");
+	if (IS_ERR(phiclock->xin_clkin_clk)) {
+		return dev_err_probe(dev, PTR_ERR(phiclock->xin_clkin_clk),
+				     "xin-clkin not specified\n");
+	}
+
+	xin_clkin_name = __clk_get_name(phiclock->xin_clkin_clk);
+
+	phiclock->regmap = devm_regmap_init_i2c(client, &phiclock_regmap_config);
+	if (IS_ERR(phiclock->regmap)) {
+		return dev_err_probe(dev, PTR_ERR(phiclock->regmap),
+				     "failed to initialize register map\n");
+	}
+
+	i2c_set_clientdata(client, phiclock);
+	phiclock->i2c_client = client;
+	phiclock->ss_amount = ss_amount;
+	phiclock->ss_modulation = ss_modulation;
+	phiclock->ss_direction = ss_direction;
+
+	ret = phiclock_get_defaults(phiclock);
+	if (ret) {
+		dev_err(dev, "error getting defaults\n");
+		return ret;
+	}
+
+	for (i = 0; i < PHICLOCK_NUM_CLKS; i++) {
+		int parent_index = phiclock_clks[i].parent_index;
+		const char *name;
+
+		if (of_property_read_string_index(dev->of_node,
+						  "clock-output-names", i, &name) == 0) {
+			phiclock->hw[i].init.name = name;
+		} else {
+			phiclock->hw[i].init.name = phiclock_clks[i].name;
+		}
+
+		phiclock->hw[i].idx = i;
+		phiclock->hw[i].init.ops = &phiclock_clks[i].ops;
+		phiclock->hw[i].init.num_parents = 1;
+		phiclock->hw[i].init.flags = 0;
+
+		if (parent_index > 0) {
+			phiclock->hw[i].init.parent_names = &phiclock->hw[parent_index].init.name;
+			phiclock->hw[i].init.flags |= CLK_SET_RATE_PARENT;
+		} else {
+			phiclock->hw[i].init.parent_names = &xin_clkin_name;
+		}
+
+		phiclock->hw[i].hw.init = &phiclock->hw[i].init;
+		phiclock->hw[i].phiclock = phiclock;
+
+		ret = devm_clk_hw_register(dev, &phiclock->hw[i].hw);
+		if (ret < 0) {
+			return dev_err_probe(dev, ret, "failed to register %s clock\n",
+					     phiclock->hw[i].init.name);
+		}
+	}
+
+	if (of_property_read_u32(dev->of_node, "renesas,ss-amount-percent", &ss_amount) == 0)
+		phiclock->ss_amount = ss_amount;
+
+	if (of_property_read_u32(dev->of_node, "renesas,ss-modulation-hz", &ss_modulation) == 0)
+		phiclock->ss_modulation = ss_modulation;
+
+	if (of_property_read_string(dev->of_node, "renesas,ss-direction",
+				    &spread_spectrum_type_name) == 0) {
+		if (strcmp(spread_spectrum_type_name, "center") == 0)
+			phiclock->ss_direction = SS_CENTER;
+		else
+			phiclock->ss_direction = SS_DOWN;
+	}
+
+	ret = devm_of_clk_add_hw_provider(dev, phiclock_of_clk_get, phiclock);
+	if (ret) {
+		dev_err(dev, "unable to add clk provider\n");
+		return ret;
+	}
+
+	dev_info(dev, "registered, current frequency %u Hz\n", phiclock->fout);
+
+	return ret;
+}
+
+static void phiclock_remove(struct i2c_client *client)
+{
+	of_clk_del_provider(client->dev.of_node);
+}
+
+static const struct of_device_id phiclock_of_match[] = {
+	{ .compatible = "renesas,9fgv1006" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, phiclock_of_match);
+
+static struct i2c_driver phiclock_i2c_driver = {
+	.driver = {
+		.name = "phiclock",
+		.of_match_table = phiclock_of_match,
+	},
+	.probe_new = phiclock_probe,
+	.remove = phiclock_remove,
+	.id_table = phiclock_i2c_id,
+};
+module_i2c_driver(phiclock_i2c_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Alex Helms <alexander.helms.jy@renesas.com");
+MODULE_DESCRIPTION("Renesas PhiClock Clock Generator Driver");
-- 
2.25.1


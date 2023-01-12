Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D851666B7F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 08:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236705AbjALHQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 02:16:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236660AbjALHQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 02:16:38 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on20610.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::610])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD954F10C;
        Wed, 11 Jan 2023 23:16:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gNVyPe8UJKEaOicRkF8e6jznNJYe+J9NBk4oe+UcMBlOqizFq6TYYxzsZa+h4vwQ/+Vkvz6GLNRvwpAhFYue8/APP8PaF8xVke8QqtGwFCj1+md2h2ykBTq5h3JK769EwOwv8eHLzAv/gWZn5uw/AiPwORdL83lefyIUcWNZiroWFISZNEyMm7PIT+Pws7RT/NIiaK9RfZrhvIOAJyhihpdN1GPyb+bpqD5227DUqQtSBdpkmisJZvbYBzA2bPJJ+IiEczY/CiDu/A0gBNrSx85UTguWYpnRV097cE3lw39ezSWEQhSeSzS9g8ZK7GQcSqt5DhXC7rrf7UNuEy3e/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WwiKKghS/QICyHE5AlfqeYtx5+H4vzRxqfEINLH2+uM=;
 b=NoL09H3qdiIWJXVUwnN2DIDmhKFNkXySuegFu6RL1+SQl0JE5JbBeAidsdeSkuouWWYlj3S0wfxSC7FilIjc+t3b7DhkVEVvYXVDVpVKwYYI01nvFRqA88nXrVyKt7z1roO9tDSLgruN6M7Zg6a3Te8+ZjuZt8raam0JkYBjEaeuI/ZMsT0qz9n/3yDEEEPCcLFTKBX3XvUciP/CYnI600owM2icqc6wscGmHYwYQ5rWnOQEPuQW/lJ1BL9NZswf48JLA+36Bc8ufChnxcaqfdyn+a5W8x5z44qDvRkD9GutzUv1VzTVDkV7zehtabPDy/qibp8VWDuaXBq32sBzxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WwiKKghS/QICyHE5AlfqeYtx5+H4vzRxqfEINLH2+uM=;
 b=XCuxpwMCG+kpmKcSpQzTyJE1dJMW0geJXzyxiznkc0TwKpU2oeh7Dp00x6qmzE96+QvOG7fBgF66tDScQathfZKVRp0bSZbJjz2M9Eiw8cYrTuPznJ1Y5YFHoRYYKIBVS5WFBPnqNjqxZFOA0TmxiKC4xU2dqwF0EDDferUKXhU=
Received: from MW4PR04CA0173.namprd04.prod.outlook.com (2603:10b6:303:85::28)
 by SN7PR12MB8004.namprd12.prod.outlook.com (2603:10b6:806:341::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Thu, 12 Jan
 2023 07:16:13 +0000
Received: from CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::d5) by MW4PR04CA0173.outlook.office365.com
 (2603:10b6:303:85::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13 via Frontend
 Transport; Thu, 12 Jan 2023 07:16:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT029.mail.protection.outlook.com (10.13.174.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5986.18 via Frontend Transport; Thu, 12 Jan 2023 07:16:12 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 12 Jan
 2023 01:16:07 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 11 Jan
 2023 23:15:54 -0800
Received: from xhdmubinusm40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 12 Jan 2023 01:15:51 -0600
From:   Mubin Sayyed <mubin.sayyed@amd.com>
To:     <robh+dt@kernel.org>, <treding@nvidia.com>,
        <u.kleine-koenig@pengutronix.de>, <linux-pwm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <git@amd.com>,
        <michal.simek@amd.com>, <siva.durga.prasad.paladugu@amd.com>,
        <mubin10@gmail.com>, Mubin Sayyed <mubin.sayyed@amd.com>
Subject: [LINUX PATCH 3/3] pwm: pwm-cadence: Add support for TTC PWM
Date:   Thu, 12 Jan 2023 12:45:26 +0530
Message-ID: <20230112071526.3035949-4-mubin.sayyed@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230112071526.3035949-1-mubin.sayyed@amd.com>
References: <20230112071526.3035949-1-mubin.sayyed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT029:EE_|SN7PR12MB8004:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a8a1a05-3858-4170-8962-08daf46ce2fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TL8SqRyiSLGyOPr+rRrDbY7oJAxqLn3Wbzte2InxvQfNsoSRCjNY+D2B2OASWu4SLa3OfTgEK6Lu9CREssa1VZ6IOWBrXHg6RGZt2tXx8/oEFdYajYtUDCLHTiD5bMfUTAHDdG4Az6nWD8mg2F8+rpNzuxFIb06YMtBK+RMCSw6NSZH5RkLemlYC2KtAj+pcJjHWyEcvNLDSDdC1U7pI2vTQ2rxrLOrSPSl61NdK7xqHo+nws00AvAWHizFlqSeqgP5J9wHWxEzoKiDqqfJ4BIJX91usdG/Av6vQj1NzhlhzoYwzEn9vsT5dKKMkQ/KwsIBt3uS2ptZe2Q4/jT+XK8r7mY2r+M0rxEFbkgLhQPUYSvJnVJr/0p0bEwXDPw9kTl6ESjXDClttkTzj6c1mri99SZGy9Ym5ICVOpA5c6NuWI7frzAjt63fCRmGCLvMVnghCYTfQr22nR1NXbLYN0AJAuqEgSvFWa1098tortqtvaYDFAYacrdYtwqMepFE14fkj5Cd6Na6jwjQnszaV+HGvDkbYDvCsiNKNzSOCqiZ1MtswmnYZoM3XnffhAGJxQWObCyiJxX/ezk2299TvNZdHrA5oHgsFsN1phgY3FC8mq/8qBuPzMKladgGKabP0AMlfILks8i2ixqRgqN+0pLYM/kfeb3fWXokBTqSVFPJ7yHHSHAj5OxYkOMgo0iOsoePBav5QIn5tkRW/0r7LsFgyehljzY1PgbGUPrjn5Lg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(346002)(39860400002)(376002)(451199015)(36840700001)(46966006)(40470700004)(30864003)(44832011)(2906002)(5660300002)(41300700001)(82310400005)(6666004)(4326008)(8676002)(70206006)(70586007)(40460700003)(8936002)(36756003)(86362001)(40480700001)(110136005)(81166007)(356005)(54906003)(82740400003)(36860700001)(83380400001)(478600001)(2616005)(47076005)(316002)(1076003)(426003)(26005)(186003)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2023 07:16:12.6343
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a8a1a05-3858-4170-8962-08daf46ce2fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8004
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cadence TTC timer can be configured as clocksource/clockevent
or PWM device. Specific TTC device would be configured as PWM
device, if pwm-cells property is present in the device tree
node.

In case of Zynq, ZynqMP and Versal SoC's, each TTC device has 3
timers/counters, so maximum 3 PWM channels can be configured for
each TTC IP instance. Also, output of 0th PWM channel of each TTC
device can be routed to MIO or EMIO, and output of 2nd and 3rd
PWM channel can be routed only to EMIO.

Period for given PWM channel is configured through interval timer
and duty cycle through match counter.

Signed-off-by: Mubin Sayyed <mubin.sayyed@amd.com>
---
 drivers/pwm/Kconfig       |  11 ++
 drivers/pwm/Makefile      |   1 +
 drivers/pwm/pwm-cadence.c | 363 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 375 insertions(+)
 create mode 100644 drivers/pwm/pwm-cadence.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index dae023d783a2..9e0f1fae4711 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -504,6 +504,17 @@ config PWM_SIFIVE
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-sifive.
 
+config PWM_CADENCE
+	tristate "Cadence PWM support"
+	depends on OF
+	depends on COMMON_CLK
+	help
+	  Generic PWM framework driver for cadence TTC IP found on
+	  Xilinx Zynq/ZynqMP/Versal SOCs. Each TTC device has 3 PWM
+	  channels. Output of 0th PWM channel of each TTC device can
+	  be routed to MIO or EMIO, and output of 1st and 2nd PWM
+	  channels can be routed only to EMIO.
+
 config PWM_SL28CPLD
 	tristate "Kontron sl28cpld PWM support"
 	depends on MFD_SL28CPLD || COMPILE_TEST
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 7bf1a29f02b8..f744f021be0f 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -46,6 +46,7 @@ obj-$(CONFIG_PWM_RENESAS_TPU)	+= pwm-renesas-tpu.o
 obj-$(CONFIG_PWM_ROCKCHIP)	+= pwm-rockchip.o
 obj-$(CONFIG_PWM_SAMSUNG)	+= pwm-samsung.o
 obj-$(CONFIG_PWM_SIFIVE)	+= pwm-sifive.o
+obj-$(CONFIG_PWM_CADENCE)	+= pwm-cadence.o
 obj-$(CONFIG_PWM_SL28CPLD)	+= pwm-sl28cpld.o
 obj-$(CONFIG_PWM_SPEAR)		+= pwm-spear.o
 obj-$(CONFIG_PWM_SPRD)		+= pwm-sprd.o
diff --git a/drivers/pwm/pwm-cadence.c b/drivers/pwm/pwm-cadence.c
new file mode 100644
index 000000000000..de981df3ec5a
--- /dev/null
+++ b/drivers/pwm/pwm-cadence.c
@@ -0,0 +1,363 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver to configure cadence TTC timer as PWM
+ * generator
+ *
+ * Copyright (C) 2022, Advanced Micro Devices, Inc.
+ */
+
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+#include <linux/of_address.h>
+
+#define TTC_CLK_CNTRL_OFFSET		0x00
+#define TTC_CNT_CNTRL_OFFSET		0x0C
+#define TTC_MATCH_CNT_VAL_OFFSET	0x30
+#define TTC_COUNT_VAL_OFFSET		0x18
+#define TTC_INTR_VAL_OFFSET		0x24
+#define TTC_ISR_OFFSET			0x54
+#define TTC_IER_OFFSET			0x60
+#define TTC_PWM_CHANNEL_OFFSET		0x4
+
+#define TTC_CLK_CNTRL_CSRC_MASK		BIT(5)
+#define TTC_CLK_CNTRL_PSV_MASK		GENMASK(4, 1)
+
+#define TTC_CNTR_CTRL_DIS_MASK		BIT(0)
+#define TTC_CNTR_CTRL_INTR_MODE_EN_MASK	BIT(1)
+#define TTC_CNTR_CTRL_MATCH_MODE_EN_MASK	BIT(3)
+#define TTC_CNTR_CTRL_RST_MASK		BIT(4)
+#define TTC_CNTR_CTRL_WAVE_EN_MASK	BIT(5)
+#define TTC_CNTR_CTRL_WAVE_POL_MASK	BIT(6)
+
+#define TTC_CLK_CNTRL_PSV_SHIFT		1
+
+#define TTC_PWM_MAX_CH			3
+
+/**
+ * struct ttc_pwm_priv - Private data for TTC PWM drivers
+ * @chip:	PWM chip structure representing PWM controller
+ * @clk:	TTC input clock
+ * @max:	Maximum value of the counters
+ * @base:	Base address of TTC instance
+ */
+struct ttc_pwm_priv {
+	struct pwm_chip chip;
+	struct clk *clk;
+	u32 max;
+	void __iomem *base;
+};
+
+static inline u32 ttc_pwm_readl(struct ttc_pwm_priv *priv,
+				unsigned long offset)
+{
+	return readl_relaxed(priv->base + offset);
+}
+
+static inline void ttc_pwm_writel(struct ttc_pwm_priv *priv,
+				  unsigned long offset,
+				  unsigned long val)
+{
+	writel_relaxed(val, priv->base + offset);
+}
+
+static inline u32 ttc_pwm_ch_readl(struct ttc_pwm_priv *priv,
+				   struct pwm_device *pwm,
+				   unsigned long offset)
+{
+	unsigned long pwm_ch_offset = offset +
+				       (TTC_PWM_CHANNEL_OFFSET * pwm->hwpwm);
+
+	return ttc_pwm_readl(priv, pwm_ch_offset);
+}
+
+static inline void ttc_pwm_ch_writel(struct ttc_pwm_priv *priv,
+				     struct pwm_device *pwm,
+				     unsigned long offset,
+				     unsigned long val)
+{
+	unsigned long pwm_ch_offset = offset +
+				       (TTC_PWM_CHANNEL_OFFSET * pwm->hwpwm);
+
+	ttc_pwm_writel(priv, pwm_ch_offset, val);
+}
+
+static inline struct ttc_pwm_priv *xilinx_pwm_chip_to_priv(struct pwm_chip *chip)
+{
+	return container_of(chip, struct ttc_pwm_priv, chip);
+}
+
+static void ttc_pwm_enable(struct ttc_pwm_priv *priv, struct pwm_device *pwm)
+{
+	u32 ctrl_reg;
+
+	ctrl_reg = ttc_pwm_ch_readl(priv, pwm, TTC_CNT_CNTRL_OFFSET);
+	ctrl_reg |= (TTC_CNTR_CTRL_INTR_MODE_EN_MASK
+				 | TTC_CNTR_CTRL_MATCH_MODE_EN_MASK | TTC_CNTR_CTRL_RST_MASK);
+	ctrl_reg &= (~(TTC_CNTR_CTRL_DIS_MASK | TTC_CNTR_CTRL_WAVE_EN_MASK));
+	ttc_pwm_ch_writel(priv, pwm, TTC_CNT_CNTRL_OFFSET, ctrl_reg);
+}
+
+static void ttc_pwm_disable(struct ttc_pwm_priv *priv, struct pwm_device *pwm)
+{
+	u32 ctrl_reg;
+
+	ctrl_reg = ttc_pwm_ch_readl(priv, pwm, TTC_CNT_CNTRL_OFFSET);
+	ctrl_reg |= TTC_CNTR_CTRL_DIS_MASK;
+
+	ttc_pwm_ch_writel(priv, pwm, TTC_CNT_CNTRL_OFFSET, ctrl_reg);
+}
+
+static void ttc_pwm_rev_polarity(struct ttc_pwm_priv *priv, struct pwm_device *pwm)
+{
+	u32 ctrl_reg;
+
+	ctrl_reg = ttc_pwm_ch_readl(priv, pwm, TTC_CNT_CNTRL_OFFSET);
+	ctrl_reg ^= TTC_CNTR_CTRL_WAVE_POL_MASK;
+	ttc_pwm_ch_writel(priv, pwm, TTC_CNT_CNTRL_OFFSET, ctrl_reg);
+}
+
+static void ttc_pwm_set_counters(struct ttc_pwm_priv *priv,
+				 struct pwm_device *pwm,
+				 u32 div,
+				 u32 period_cycles,
+				 u32 duty_cycles)
+{
+	u32 clk_reg;
+
+	/* Set up prescalar */
+	clk_reg = ttc_pwm_ch_readl(priv, pwm, TTC_CLK_CNTRL_OFFSET);
+	clk_reg &= ~TTC_CLK_CNTRL_PSV_MASK;
+	clk_reg |= div;
+	ttc_pwm_ch_writel(priv, pwm, TTC_CLK_CNTRL_OFFSET, clk_reg);
+
+	/* Set up period */
+	ttc_pwm_ch_writel(priv, pwm, TTC_INTR_VAL_OFFSET, period_cycles);
+
+	/* Set up duty cycle */
+	ttc_pwm_ch_writel(priv, pwm, TTC_MATCH_CNT_VAL_OFFSET, duty_cycles);
+}
+
+static int ttc_pwm_apply(struct pwm_chip *chip,
+			 struct pwm_device *pwm,
+			 const struct pwm_state *state)
+{
+	u32 div = 0;
+	u64 period_cycles;
+	u64 duty_cycles;
+	unsigned long rate;
+	struct pwm_state cstate;
+	struct ttc_pwm_priv *priv = xilinx_pwm_chip_to_priv(chip);
+
+	pwm_get_state(pwm, &cstate);
+
+	if (state->polarity != cstate.polarity) {
+		if (cstate.enabled)
+			ttc_pwm_disable(priv, pwm);
+
+		ttc_pwm_rev_polarity(priv, pwm);
+
+		if (cstate.enabled)
+			ttc_pwm_enable(priv, pwm);
+	}
+
+	if (state->period != cstate.period ||
+	    state->duty_cycle != cstate.duty_cycle) {
+		rate = clk_get_rate(priv->clk);
+
+		/* Prevent overflow by limiting to the maximum possible period */
+		period_cycles = min_t(u64, state->period, ULONG_MAX * NSEC_PER_SEC);
+		period_cycles = DIV_ROUND_CLOSEST(period_cycles * rate, NSEC_PER_SEC);
+
+		if (period_cycles > priv->max) {
+			/* prescale frequency to fit requested period cycles within limit */
+			div = 1;
+
+			while ((period_cycles  > priv->max) && (div < 65536)) {
+				rate = DIV_ROUND_CLOSEST(rate, BIT(div));
+				period_cycles = DIV_ROUND_CLOSEST(state->period * rate,
+								  NSEC_PER_SEC);
+				if (period_cycles < priv->max)
+					break;
+				div++;
+			}
+
+			if (period_cycles  > priv->max)
+				return -ERANGE;
+		}
+
+		duty_cycles = DIV_ROUND_CLOSEST(state->duty_cycle * rate,
+						NSEC_PER_SEC);
+		if (cstate.enabled)
+			ttc_pwm_disable(priv, pwm);
+
+		ttc_pwm_set_counters(priv, pwm, div, period_cycles, duty_cycles);
+
+		if (cstate.enabled)
+			ttc_pwm_enable(priv, pwm);
+	}
+
+	if (state->enabled != cstate.enabled) {
+		if (state->enabled)
+			ttc_pwm_enable(priv, pwm);
+		else
+			ttc_pwm_disable(priv, pwm);
+	}
+
+	return 0;
+}
+
+static int ttc_pwm_get_state(struct pwm_chip *chip,
+			     struct pwm_device *pwm,
+			     struct pwm_state *state)
+{
+	struct ttc_pwm_priv *priv = xilinx_pwm_chip_to_priv(chip);
+	unsigned long rate;
+	u32 value;
+	u64 tmp;
+
+	value = ttc_pwm_ch_readl(priv, pwm, TTC_CNT_CNTRL_OFFSET);
+
+	if (value & TTC_CNTR_CTRL_WAVE_POL_MASK)
+		state->polarity = PWM_POLARITY_INVERSED;
+	else
+		state->polarity = PWM_POLARITY_NORMAL;
+
+	if (value & TTC_CNTR_CTRL_DIS_MASK)
+		state->enabled = false;
+	else
+		state->enabled = true;
+
+	rate = clk_get_rate(priv->clk);
+
+	tmp = ttc_pwm_ch_readl(priv, pwm, TTC_INTR_VAL_OFFSET);
+	state->period = DIV_ROUND_CLOSEST_ULL(tmp, rate);
+
+	tmp = ttc_pwm_ch_readl(priv, pwm, TTC_MATCH_CNT_VAL_OFFSET);
+	state->duty_cycle = DIV_ROUND_CLOSEST_ULL(tmp, rate);
+
+	return 0;
+}
+
+static struct pwm_device *
+ttc_pwm_of_xlate(struct pwm_chip *chip, const struct of_phandle_args *args)
+{
+	struct pwm_device *pwm;
+
+	if (args->args[0] >= TTC_PWM_MAX_CH)
+		return NULL;
+
+	pwm = pwm_request_from_chip(chip, args->args[0], NULL);
+	if (IS_ERR(pwm))
+		return pwm;
+
+	if (args->args[1])
+		pwm->args.period = args->args[1];
+
+	if (args->args[2])
+		pwm->args.polarity = args->args[2];
+
+	return pwm;
+}
+
+static const struct pwm_ops ttc_pwm_ops = {
+	.apply = ttc_pwm_apply,
+	.get_state = ttc_pwm_get_state,
+	.owner = THIS_MODULE,
+};
+
+static int ttc_pwm_probe(struct platform_device *pdev)
+{
+	int ret;
+	int clksel;
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct ttc_pwm_priv *priv;
+	u32 pwm_cells;
+	u32 timer_width;
+	struct clk *clk_cs;
+
+	ret = of_property_read_u32(np, "#pwm-cells", &pwm_cells);
+	if (ret == -EINVAL)
+		return -ENODEV;
+
+	if (ret)
+		return dev_err_probe(dev, ret, "could not read #pwm-cells\n");
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
+
+	ret = of_property_read_u32(np, "timer-width", &timer_width);
+	if (ret)
+		timer_width = 16;
+
+	priv->max = BIT(timer_width) - 1;
+
+	clksel = ttc_pwm_readl(priv, TTC_CLK_CNTRL_OFFSET);
+	clksel = !!(clksel & TTC_CLK_CNTRL_CSRC_MASK);
+	clk_cs = of_clk_get(np, clksel);
+	if (IS_ERR(clk_cs))
+		return dev_err_probe(dev, PTR_ERR(clk_cs),
+				     "ERROR: timer input clock not found\n");
+
+	priv->clk = clk_cs;
+	ret = clk_prepare_enable(priv->clk);
+	if (ret)
+		return dev_err_probe(dev, ret, "Clock enable failed\n");
+
+	clk_rate_exclusive_get(priv->clk);
+
+	priv->chip.dev = dev;
+	priv->chip.ops = &ttc_pwm_ops;
+	priv->chip.npwm = TTC_PWM_MAX_CH;
+	priv->chip.of_xlate = ttc_pwm_of_xlate;
+	ret = pwmchip_add(&priv->chip);
+	if (ret) {
+		clk_rate_exclusive_put(priv->clk);
+		clk_disable_unprepare(priv->clk);
+		return dev_err_probe(dev, ret, "Could not register PWM chip\n");
+	}
+
+	platform_set_drvdata(pdev, priv);
+
+	return 0;
+}
+
+static int ttc_pwm_remove(struct platform_device *pdev)
+{
+	struct ttc_pwm_priv *priv = platform_get_drvdata(pdev);
+
+	pwmchip_remove(&priv->chip);
+	clk_rate_exclusive_put(priv->clk);
+	clk_disable_unprepare(priv->clk);
+
+	return 0;
+}
+
+static const struct of_device_id ttc_pwm_of_match[] = {
+	{ .compatible = "cdns,ttc"},
+	{},
+};
+MODULE_DEVICE_TABLE(of, ttc_pwm_of_match);
+
+static struct platform_driver ttc_pwm_driver = {
+	.probe = ttc_pwm_probe,
+	.remove = ttc_pwm_remove,
+	.driver = {
+		.name = "ttc-pwm",
+		.of_match_table = of_match_ptr(ttc_pwm_of_match),
+	},
+};
+module_platform_driver(ttc_pwm_driver);
+
+MODULE_AUTHOR("Mubin Sayyed <mubin.sayyed@amd.com>");
+MODULE_DESCRIPTION("Cadence TTC PWM driver");
+MODULE_LICENSE("GPL");
-- 
2.25.1


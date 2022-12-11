Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1F064964D
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 21:43:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbiLKUnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 15:43:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiLKUnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 15:43:50 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2065.outbound.protection.outlook.com [40.107.215.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F386FDEBD;
        Sun, 11 Dec 2022 12:43:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c7jtglKSL6PCkbVhWLkfSdEyYEHiurvPVn0CfJY6L/31YJNmGTaetzptI3FPmOEAz+vzsQNj3ZrcWKGdsLrnqk4MXuOUEab6mpRdIUWfc3pEsxQ2YtJKcfpfR/CwcgIL0+8W3iPMFkE17+387W5cP4UoRH6lw1R2TkFGK0xKx0mou6whk2q/pr9hRgOaUSHtpkMDM/zTW7LnDWfPkHJJDuIxWRibpFh2JZvmRg+fn7DufZ8hk4eMfZRvMiAE9gsvQtInOdyQ72H3jjX7GTkcBGqSrb3/AVHpEFdv31H86e1npRYuqIqpya/BWkoO9bJAwlPqgl1D67UTOIUoIJYOJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UAN6zInJDTfn6F/D7SoB9vaVK+Mf1cFsckdNCOCzxbM=;
 b=BONE5Q5+kQ6dd5q62V7YIVJeBsvA+oJjQCjcbWiuthOFg2RTYTbxCnNdZwldFW0iQqwlU+xP38TfSRJSiSR+BMsObYwL1OvGrcg0kOyRjJzHm0YIciwLY5uW6kvthFiF53FBVai2+XnW0OgNNkGWxMlEOVxMFmT3iF7Q6Ib8y52w08bOavaBDljGMH7lQ5tuY8z2ESoKQfbxE3xqkldyw6gknch8qPcUsoK5CixqXBGsa8UJyvUFBE0M7YcaWhewZ+TZ+gtF7FksnXhGriFavjmArwgpsQPyt4Z1gzgJPkOhPloQ/vWKomeJlKzlVDL4cuRrNU0KJKOD/l+BlCsvsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 175.98.123.7) smtp.rcpttodomain=baylibre.com smtp.mailfrom=nuvoton.com;
 dmarc=fail (p=none sp=quarantine pct=100) action=none header.from=gmail.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UAN6zInJDTfn6F/D7SoB9vaVK+Mf1cFsckdNCOCzxbM=;
 b=c+3wuZlb+DidL4xUyd3jwah3JMzV0jXUXOHqdNf84k4qEdlu4lV80q5iWY76xgQchCUiz4r/v5ZnypGSnEC+1o0S8plokTuMnk7sKM+EoObeP6SL31UVnAmt51jcgJg8gjNnvE638TS+aHnd8Eq0xAV5t3ABDaS5IrD9ymCBGF0=
Received: from TYCP286CA0157.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:383::12)
 by PUZPR03MB5933.apcprd03.prod.outlook.com (2603:1096:301:b0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Sun, 11 Dec
 2022 20:43:44 +0000
Received: from TYZAPC01FT050.eop-APC01.prod.protection.outlook.com
 (2603:1096:400:383:cafe::fa) by TYCP286CA0157.outlook.office365.com
 (2603:1096:400:383::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19 via Frontend
 Transport; Sun, 11 Dec 2022 20:43:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 175.98.123.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 175.98.123.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=175.98.123.7; helo=NTHCCAS04.nuvoton.com; pr=C
Received: from NTHCCAS04.nuvoton.com (175.98.123.7) by
 TYZAPC01FT050.mail.protection.outlook.com (10.118.152.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.5901.21 via Frontend Transport; Sun, 11 Dec 2022 20:43:42 +0000
Received: from NTHCML01A.nuvoton.com (10.1.8.177) by NTHCCAS04.nuvoton.com
 (10.1.8.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 12
 Dec 2022 04:43:40 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCML01A.nuvoton.com
 (10.1.8.177) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 12 Dec
 2022 04:43:39 +0800
Received: from taln60.nuvoton.co.il (10.191.1.180) by NTHCCAS01.nuvoton.com
 (10.1.12.25) with Microsoft SMTP Server id 15.1.2375.7 via Frontend
 Transport; Mon, 12 Dec 2022 04:43:39 +0800
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id B052F63A1E; Sun, 11 Dec 2022 22:43:38 +0200 (IST)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <avifishman70@gmail.com>, <tali.perry1@gmail.com>,
        <joel@jms.id.au>, <venture@google.com>, <yuenn@google.com>,
        <benjaminfair@google.com>
CC:     <openbmc@lists.ozlabs.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v14 1/1] clk: npcm8xx: add clock controller
Date:   Sun, 11 Dec 2022 22:43:24 +0200
Message-ID: <20221211204324.169991-2-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20221211204324.169991-1-tmaimon77@gmail.com>
References: <20221211204324.169991-1-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZAPC01FT050:EE_|PUZPR03MB5933:EE_
X-MS-Office365-Filtering-Correlation-Id: d3457e2e-2fb0-4415-9b42-08dadbb8642e
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: buDRJbdhS6uoB3jnXRXnX9cf0CPKmnj+oH3WMPSd/9d2endSaeryXAByTPUKzgDGYLpY3KB/q5WbfUb7/0S1ClatJx67YG1gEuKi+0Nk4MfHK1iBWvNIukMM5Y4BPOb3Gjrqtis5vHBmBb3N4QxK0Mb+L6QBEu/YZKTHJVShCIjc8BrEgSP6WZETRilfU8NudHpzHBk4y9+T62BGbCKruxt3j+Yx1bzgX+mbTOP3j2wIUpOgtFS9n/g+gjvc3qXSuwaQlAnHJ1hKumapXJbvtK38SNjtl+UjeEnbPpfi74wOB6wGShyMW8G02dPlbdiUHWqhd5QM+ta3D1xZgM2Bk4hOhf9zNrC5AIGzLhUiw6XOc5K8dtHcdFWyKQ2qAEz3wHg9rg2dKXsnYP1C+euE+4rQapjr14aheq+nw3o9u4cGie24AOGtQRXuV7vuhfyUP1WAzPDiYOaFdH47yxkWefaUNoLOIYmWI1LcYilYhbMYH1tCqcENbEPvj72RtbMwA6I30uCbJgOSyhGiWH593Xvlw2BJixGXHRTYHyx3n+LuuuJZyQCuXW97R5yFCuqB4dHhmEBcJYJgralE+MGxEhXNA+6HL3sE0iFZndnJs2SNJXkSJXoa3QQ54WnC0HXrcHm2S4EDYOV48T3aBeajZttQPHVfL6SgT/4pXIHRuYIp/KvFAOlpFgmbH2DyX0EVmBmQkNB2of30I2XBVDnp0NFV4Zb988JkfHlKSL65vVr9S/aeCorpbJMkdCC7TH9/BYLjNI8GXRKzKZF5b4885l56oD14aQ/i66Ih47PFxUY=
X-Forefront-Antispam-Report: CIP:175.98.123.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS04.nuvoton.com;PTR:175-98-123-7.static.tfn.net.tw;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(376002)(346002)(39850400004)(451199015)(46966006)(36840700001)(40470700004)(478600001)(41300700001)(82310400005)(36756003)(42882007)(73392003)(336012)(55446002)(30864003)(47076005)(356005)(81166007)(36860700001)(26005)(6266002)(82740400003)(6666004)(2616005)(5660300002)(82202003)(8676002)(70206006)(40480700001)(70586007)(7416002)(186003)(83170400001)(1076003)(42186006)(2906002)(4326008)(76482006)(54906003)(8936002)(83380400001)(40460700003)(110136005)(316002)(45356006)(32563001)(35450700002);DIR:OUT;SFP:1101;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2022 20:43:42.6806
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3457e2e-2fb0-4415-9b42-08dadbb8642e
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[175.98.123.7];Helo=[NTHCCAS04.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: TYZAPC01FT050.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB5933
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        DKIM_SIGNED,DKIM_VALID,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,NML_ADSP_CUSTOM_MED,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nuvoton Arbel BMC NPCM8XX contains an integrated clock controller which
generates and supplies clocks to all modules within the BMC.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 drivers/clk/Kconfig       |   8 +
 drivers/clk/Makefile      |   1 +
 drivers/clk/clk-npcm8xx.c | 650 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 659 insertions(+)
 create mode 100644 drivers/clk/clk-npcm8xx.c

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index d79905f3e174..0a8aad45e2a7 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -326,6 +326,14 @@ config COMMON_CLK_LOCHNAGAR
 	  This driver supports the clocking features of the Cirrus Logic
 	  Lochnagar audio development board.
 
+config COMMON_CLK_NPCM8XX
+	tristate "Clock driver for the NPCM8XX SoC Family"
+	depends on ARCH_NPCM || COMPILE_TEST
+	help
+	  This driver supports the clocks on the Nuvoton BMC NPCM8XX SoC Family,
+	  all the clocks are initialized by the bootloader, so this driver
+	  allows only reading of current settings directly from the hardware.
+
 config COMMON_CLK_NXP
 	def_bool COMMON_CLK && (ARCH_LPC18XX || ARCH_LPC32XX)
 	select REGMAP_MMIO if ARCH_LPC32XX
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index e3ca0d058a25..cae295de5459 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -49,6 +49,7 @@ obj-$(CONFIG_ARCH_MILBEAUT_M10V)	+= clk-milbeaut.o
 obj-$(CONFIG_ARCH_MOXART)		+= clk-moxart.o
 obj-$(CONFIG_ARCH_NOMADIK)		+= clk-nomadik.o
 obj-$(CONFIG_ARCH_NPCM7XX)	    	+= clk-npcm7xx.o
+obj-$(CONFIG_COMMON_CLK_NPCM8XX)	+= clk-npcm8xx.o
 obj-$(CONFIG_ARCH_NSPIRE)		+= clk-nspire.o
 obj-$(CONFIG_COMMON_CLK_OXNAS)		+= clk-oxnas.o
 obj-$(CONFIG_COMMON_CLK_PALMAS)		+= clk-palmas.o
diff --git a/drivers/clk/clk-npcm8xx.c b/drivers/clk/clk-npcm8xx.c
new file mode 100644
index 000000000000..08ee7bea6f3a
--- /dev/null
+++ b/drivers/clk/clk-npcm8xx.c
@@ -0,0 +1,650 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Nuvoton NPCM8xx Clock Generator
+ * All the clocks are initialized by the bootloader, so this driver allow only
+ * reading of current settings directly from the hardware.
+ *
+ * Copyright (C) 2020 Nuvoton Technologies
+ * Author: Tomer Maimon <tomer.maimon@nuvoton.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk-provider.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#include <dt-bindings/clock/nuvoton,npcm845-clk.h>
+
+#define NPCM8XX_REF_CLK		25000000
+
+struct npcm8xx_clk_pll_data {
+	unsigned int	id;
+	const char	*name;
+	u32		reg;
+	unsigned long	flags;
+};
+
+struct npcm8xx_clk_pll {
+	struct clk_hw hw;
+	void __iomem *pllcon;
+	struct npcm8xx_clk_pll_data pll;
+	struct clk_init_data init;
+};
+
+#define to_npcm8xx_clk_pll(_hw) container_of(_hw, struct npcm8xx_clk_pll, hw)
+
+#define PLLCON_LOKI	BIT(31)
+#define PLLCON_LOKS	BIT(30)
+#define PLLCON_FBDV	GENMASK(27, 16)
+#define PLLCON_OTDV2	GENMASK(15, 13)
+#define PLLCON_PWDEN	BIT(12)
+#define PLLCON_OTDV1	GENMASK(10, 8)
+#define PLLCON_INDV	GENMASK(5, 0)
+
+static unsigned long npcm8xx_clk_pll_recalc_rate(struct clk_hw *hw,
+						 unsigned long parent_rate)
+{
+	struct npcm8xx_clk_pll *pll = to_npcm8xx_clk_pll(hw);
+	unsigned long fbdv, indv, otdv1, otdv2;
+	unsigned int val;
+	u64 ret;
+
+	if (parent_rate == 0) {
+		pr_debug("%s: parent rate is zero\n", __func__);
+		return 0;
+	}
+
+	val = readl_relaxed(pll->pllcon + pll->pll.reg);
+
+	indv = FIELD_GET(PLLCON_INDV, val);
+	fbdv = FIELD_GET(PLLCON_FBDV, val);
+	otdv1 = FIELD_GET(PLLCON_OTDV1, val);
+	otdv2 = FIELD_GET(PLLCON_OTDV2, val);
+
+	ret = (u64)parent_rate * fbdv;
+	do_div(ret, indv * otdv1 * otdv2);
+
+	return ret;
+}
+
+static const struct clk_ops npcm8xx_clk_pll_ops = {
+	.recalc_rate = npcm8xx_clk_pll_recalc_rate,
+};
+
+static struct clk_hw *
+npcm8xx_clk_register_pll(struct device *dev, struct npcm8xx_clk_pll *pll,
+			 void __iomem *sys_base)
+{
+	struct clk_hw *hw;
+	int ret;
+
+	pll->pllcon = sys_base;
+	hw = &pll->hw;
+
+	ret = devm_clk_hw_register(dev, hw);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return hw;
+}
+
+#define NPCM8XX_CLKEN1          (0x00)
+#define NPCM8XX_CLKEN2          (0x28)
+#define NPCM8XX_CLKEN3          (0x30)
+#define NPCM8XX_CLKEN4          (0x70)
+#define NPCM8XX_CLKSEL          (0x04)
+#define NPCM8XX_CLKDIV1         (0x08)
+#define NPCM8XX_CLKDIV2         (0x2C)
+#define NPCM8XX_CLKDIV3         (0x58)
+#define NPCM8XX_CLKDIV4         (0x7C)
+#define NPCM8XX_PLLCON0         (0x0C)
+#define NPCM8XX_PLLCON1         (0x10)
+#define NPCM8XX_PLLCON2         (0x54)
+#define NPCM8XX_SWRSTR          (0x14)
+#define NPCM8XX_IRQWAKECON      (0x18)
+#define NPCM8XX_IRQWAKEFLAG     (0x1C)
+#define NPCM8XX_IPSRST1         (0x20)
+#define NPCM8XX_IPSRST2         (0x24)
+#define NPCM8XX_IPSRST3         (0x34)
+#define NPCM8XX_WD0RCR          (0x38)
+#define NPCM8XX_WD1RCR          (0x3C)
+#define NPCM8XX_WD2RCR          (0x40)
+#define NPCM8XX_SWRSTC1         (0x44)
+#define NPCM8XX_SWRSTC2         (0x48)
+#define NPCM8XX_SWRSTC3         (0x4C)
+#define NPCM8XX_SWRSTC4         (0x50)
+#define NPCM8XX_CORSTC          (0x5C)
+#define NPCM8XX_PLLCONG         (0x60)
+#define NPCM8XX_AHBCKFI         (0x64)
+#define NPCM8XX_SECCNT          (0x68)
+#define NPCM8XX_CNTR25M         (0x6C)
+#define NPCM8XX_THRTL_CNT       (0xC0)
+
+struct npcm8xx_clk_mux_data {
+	u8 shift;
+	u32 mask;
+	const u32 *table;
+	const char *name;
+	const struct clk_parent_data *parent_data;
+	u8 num_parents;
+	unsigned long flags;
+	/*
+	 * If this clock is exported via DT, set onecell_idx to constant
+	 * defined in include/dt-bindings/clock/nuvoton, NPCM8XX-clock.h for
+	 * this specific clock.  Otherwise, set to -1.
+	 */
+	int onecell_idx;
+};
+
+struct npcm8xx_clk_div_data {
+	u32 reg;
+	u8 shift;
+	u8 width;
+	const char *name;
+	const struct clk_parent_data *parent_data;
+	u8 clk_divider_flags;
+	unsigned long flags;
+	/*
+	 * If this clock is exported via DT, set onecell_idx to constant
+	 * defined in include/dt-bindings/clock/nuvoton, NPCM8XX-clock.h for
+	 * this specific clock.  Otherwise, set to -1.
+	 */
+	int onecell_idx;
+};
+
+/*
+ * Single copy of strings used to refer to clocks within this driver indexed by
+ * above enum.
+ */
+#define NPCM8XX_CLK_S_REFCLK      "refclk"
+#define NPCM8XX_CLK_S_SYSBYPCK    "sysbypck"
+#define NPCM8XX_CLK_S_MCBYPCK     "mcbypck"
+#define NPCM8XX_CLK_S_PLL0        "pll0"
+#define NPCM8XX_CLK_S_PLL1        "pll1"
+#define NPCM8XX_CLK_S_PLL1_DIV2   "pll1_div2"
+#define NPCM8XX_CLK_S_PLL2        "pll2"
+#define NPCM8XX_CLK_S_PLL_GFX     "pll_gfx"
+#define NPCM8XX_CLK_S_PLL2_DIV2   "pll2_div2"
+#define NPCM8XX_CLK_S_PIX_MUX     "gfx_pixel"
+#define NPCM8XX_CLK_S_MC_MUX      "mc_phy"
+#define NPCM8XX_CLK_S_CPU_MUX     "cpu"  /* AKA system clock */
+#define NPCM8XX_CLK_S_MC          "mc"
+#define NPCM8XX_CLK_S_AXI         "axi"  /* AKA CLK2 */
+#define NPCM8XX_CLK_S_AHB         "ahb"  /* AKA CLK4 */
+#define NPCM8XX_CLK_S_CLKOUT_MUX  "clkout_mux"
+#define NPCM8XX_CLK_S_UART_MUX    "uart_mux"
+#define NPCM8XX_CLK_S_SD_MUX      "sd_mux"
+#define NPCM8XX_CLK_S_GFXM_MUX    "gfxm_mux"
+#define NPCM8XX_CLK_S_SU_MUX      "serial_usb_mux"
+#define NPCM8XX_CLK_S_DVC_MUX     "dvc_mux"
+#define NPCM8XX_CLK_S_GFX_MUX     "gfx_mux"
+#define NPCM8XX_CLK_S_ADC_MUX     "adc_mux"
+#define NPCM8XX_CLK_S_SPI0        "spi0"
+#define NPCM8XX_CLK_S_SPI1        "spi1"
+#define NPCM8XX_CLK_S_SPI3        "spi3"
+#define NPCM8XX_CLK_S_SPIX        "spix"
+#define NPCM8XX_CLK_S_APB1        "apb1"
+#define NPCM8XX_CLK_S_APB2        "apb2"
+#define NPCM8XX_CLK_S_APB3        "apb3"
+#define NPCM8XX_CLK_S_APB4        "apb4"
+#define NPCM8XX_CLK_S_APB5        "apb5"
+#define NPCM8XX_CLK_S_APB19       "apb19"
+#define NPCM8XX_CLK_S_TOCK        "tock"
+#define NPCM8XX_CLK_S_CLKOUT      "clkout"
+#define NPCM8XX_CLK_S_PRE_ADC     "pre adc"
+#define NPCM8XX_CLK_S_UART        "uart"
+#define NPCM8XX_CLK_S_UART2       "uart2"
+#define NPCM8XX_CLK_S_TIMER       "timer"
+#define NPCM8XX_CLK_S_MMC         "mmc"
+#define NPCM8XX_CLK_S_SDHC        "sdhc"
+#define NPCM8XX_CLK_S_ADC         "adc"
+#define NPCM8XX_CLK_S_GFX         "gfx0_gfx1_mem"
+#define NPCM8XX_CLK_S_USBIF       "serial_usbif"
+#define NPCM8XX_CLK_S_USB_HOST    "usb_host"
+#define NPCM8XX_CLK_S_USB_BRIDGE  "usb_bridge"
+#define NPCM8XX_CLK_S_PCI         "pci"
+#define NPCM8XX_CLK_S_TH          "th"
+#define NPCM8XX_CLK_S_ATB         "atb"
+#define NPCM8XX_CLK_S_PRE_CLK     "pre_clk"
+
+#define NPCM8XX_CLK_S_RG_MUX	  "rg_mux"
+#define NPCM8XX_CLK_S_RCP_MUX	  "rcp_mux"
+#define NPCM8XX_CLK_S_RG	  "rg"
+#define NPCM8XX_CLK_S_RCP	  "rcp"
+
+static const u32 pll_mux_table[] = { 0, 1, 2, 3 };
+static const struct clk_parent_data pll_mux_parents[] = {
+	{ .fw_name = NPCM8XX_CLK_S_PLL0, .name = NPCM8XX_CLK_S_PLL0 },
+	{ .fw_name = NPCM8XX_CLK_S_PLL1, .name = NPCM8XX_CLK_S_PLL1 },
+	{ .fw_name = NPCM8XX_CLK_S_REFCLK, .name = NPCM8XX_CLK_S_REFCLK },
+	{ .fw_name = NPCM8XX_CLK_S_PLL2_DIV2, .name = NPCM8XX_CLK_S_PLL2_DIV2 }
+};
+
+static const u32 cpuck_mux_table[] = { 0, 1, 2, 3, 7 };
+static const struct clk_parent_data cpuck_mux_parents[] = {
+	{ .fw_name = NPCM8XX_CLK_S_PLL0, .name = NPCM8XX_CLK_S_PLL0 },
+	{ .fw_name = NPCM8XX_CLK_S_PLL1, .name = NPCM8XX_CLK_S_PLL1 },
+	{ .fw_name = NPCM8XX_CLK_S_REFCLK, .name = NPCM8XX_CLK_S_REFCLK },
+	{ .fw_name = NPCM8XX_CLK_S_SYSBYPCK, .name = NPCM8XX_CLK_S_SYSBYPCK },
+	{ .fw_name = NPCM8XX_CLK_S_PLL2, .name = NPCM8XX_CLK_S_PLL2 }
+};
+
+static const u32 pixcksel_mux_table[] = { 0, 2 };
+static const struct clk_parent_data pixcksel_mux_parents[] = {
+	{ .fw_name = NPCM8XX_CLK_S_PLL_GFX, .name = NPCM8XX_CLK_S_PLL_GFX },
+	{ .fw_name = NPCM8XX_CLK_S_REFCLK, .name = NPCM8XX_CLK_S_REFCLK }
+};
+
+static const u32 sucksel_mux_table[] = { 2, 3 };
+static const struct clk_parent_data sucksel_mux_parents[] = {
+	{ .fw_name = NPCM8XX_CLK_S_REFCLK, .name = NPCM8XX_CLK_S_REFCLK },
+	{ .fw_name = NPCM8XX_CLK_S_PLL2_DIV2, .name = NPCM8XX_CLK_S_PLL2_DIV2 }
+};
+
+static const u32 mccksel_mux_table[] = { 0, 2, 3 };
+static const struct clk_parent_data mccksel_mux_parents[] = {
+	{ .fw_name = NPCM8XX_CLK_S_PLL1_DIV2, .name = NPCM8XX_CLK_S_PLL1_DIV2 },
+	{ .fw_name = NPCM8XX_CLK_S_REFCLK, .name = NPCM8XX_CLK_S_REFCLK },
+	{ .fw_name = NPCM8XX_CLK_S_MCBYPCK, .name = NPCM8XX_CLK_S_MCBYPCK }
+};
+
+static const u32 clkoutsel_mux_table[] = { 0, 1, 2, 3, 4 };
+static const struct clk_parent_data clkoutsel_mux_parents[] = {
+	{ .fw_name = NPCM8XX_CLK_S_PLL0, .name = NPCM8XX_CLK_S_PLL0 },
+	{ .fw_name = NPCM8XX_CLK_S_PLL1, .name = NPCM8XX_CLK_S_PLL1 },
+	{ .fw_name = NPCM8XX_CLK_S_REFCLK, .name = NPCM8XX_CLK_S_REFCLK },
+	{ .fw_name = NPCM8XX_CLK_S_PLL_GFX, .name = NPCM8XX_CLK_S_PLL_GFX },
+	{ .fw_name = NPCM8XX_CLK_S_PLL2_DIV2, .name = NPCM8XX_CLK_S_PLL2_DIV2 }
+};
+
+static const u32 gfxmsel_mux_table[] = { 2, 3 };
+static const struct clk_parent_data gfxmsel_mux_parents[] = {
+	{ .fw_name = NPCM8XX_CLK_S_REFCLK, .name = NPCM8XX_CLK_S_REFCLK },
+	{ .fw_name = NPCM8XX_CLK_S_PLL2_DIV2, .name = NPCM8XX_CLK_S_PLL2_DIV2 }
+};
+
+static const u32 dvcssel_mux_table[] = { 2, 3 };
+static const struct clk_parent_data dvcssel_mux_parents[] = {
+	{ .fw_name = NPCM8XX_CLK_S_REFCLK, .name = NPCM8XX_CLK_S_REFCLK },
+	{ .fw_name = NPCM8XX_CLK_S_PLL2, .name = NPCM8XX_CLK_S_PLL2 }
+};
+
+static const struct clk_parent_data pre_adc_div_parent[] = {
+	{ .fw_name = NPCM8XX_CLK_S_PRE_ADC, .name = NPCM8XX_CLK_S_PRE_ADC }
+};
+
+static const struct clk_parent_data pre_clk_div_parent[] = {
+	{ .fw_name = NPCM8XX_CLK_S_PRE_CLK, .name = NPCM8XX_CLK_S_PRE_CLK }
+};
+
+static const struct clk_parent_data mux_adc_div_parent[] = {
+	{ .fw_name = NPCM8XX_CLK_S_ADC_MUX, .name = NPCM8XX_CLK_S_ADC_MUX }
+};
+
+static const struct clk_parent_data mux_uart_div_parent[] = {
+	{ .fw_name = NPCM8XX_CLK_S_UART_MUX, .name = NPCM8XX_CLK_S_UART_MUX }
+};
+
+static const struct clk_parent_data mux_sd_div_parent[] = {
+	{ .fw_name = NPCM8XX_CLK_S_SD_MUX, .name = NPCM8XX_CLK_S_SD_MUX }
+};
+
+static const struct clk_parent_data ahb_div_parent[] = {
+	{ .fw_name = NPCM8XX_CLK_S_AHB, .name = NPCM8XX_CLK_S_AHB }
+};
+
+static const struct clk_parent_data mux_gfx_div_parent[] = {
+	{ .fw_name = NPCM8XX_CLK_S_GFX_MUX, .name = NPCM8XX_CLK_S_GFX_MUX }
+};
+
+static const struct clk_parent_data mux_clkout_div_parent[] = {
+	{ .fw_name = NPCM8XX_CLK_S_CLKOUT_MUX, .name = NPCM8XX_CLK_S_CLKOUT_MUX }
+};
+
+static const struct clk_parent_data mux_su_div_parent[] = {
+	{ .fw_name = NPCM8XX_CLK_S_SU_MUX, .name = NPCM8XX_CLK_S_SU_MUX }
+};
+
+static const struct clk_parent_data mux_rg_div_parent[] = {
+	{ .fw_name = NPCM8XX_CLK_S_RG_MUX, .name = NPCM8XX_CLK_S_RG_MUX }
+};
+
+static const struct clk_parent_data mux_rcp_div_parent[] = {
+	{ .fw_name = NPCM8XX_CLK_S_RCP_MUX, .name = NPCM8XX_CLK_S_RCP_MUX }
+};
+
+static const struct clk_parent_data mux_cpu_div_parent[] = {
+	{ .fw_name = NPCM8XX_CLK_S_CPU_MUX, .name = NPCM8XX_CLK_S_CPU_MUX }
+};
+
+#define CLK_PLL(_reg, _name, _parent, _flags, _id) {			\
+		.pll.id = _id,						\
+		.pll.name = _name,					\
+		.pll.reg = _reg,					\
+		.hw.init = CLK_HW_INIT_PARENTS_DATA(_name, _parent,	\
+						    &npcm8xx_clk_pll_ops,	\
+						    _flags),		\
+	}
+
+static struct clk_parent_data npcm8xx_pll_parent[] = {
+	{ .fw_name = NPCM8XX_CLK_S_REFCLK, .name = NPCM8XX_CLK_S_REFCLK },
+};
+
+static struct npcm8xx_clk_pll npcm8xx_pll_clks[] = {
+	CLK_PLL(NPCM8XX_PLLCON0, NPCM8XX_CLK_S_PLL0, npcm8xx_pll_parent, 0, -1),
+	CLK_PLL(NPCM8XX_PLLCON1, NPCM8XX_CLK_S_PLL1, npcm8xx_pll_parent, 0, -1),
+	CLK_PLL(NPCM8XX_PLLCON2, NPCM8XX_CLK_S_PLL2, npcm8xx_pll_parent, 0, -1),
+	CLK_PLL(NPCM8XX_PLLCONG, NPCM8XX_CLK_S_PLL_GFX, npcm8xx_pll_parent, 0, -1),
+};
+
+static const struct npcm8xx_clk_mux_data npcm8xx_muxes[] = {
+	{ 0, 3, cpuck_mux_table, NPCM8XX_CLK_S_CPU_MUX,
+	cpuck_mux_parents, ARRAY_SIZE(cpuck_mux_parents), CLK_IS_CRITICAL,
+	NPCM8XX_CLK_CPU },
+
+	{ 4, 2, pixcksel_mux_table, NPCM8XX_CLK_S_PIX_MUX,
+	pixcksel_mux_parents, ARRAY_SIZE(pixcksel_mux_parents), 0,
+	NPCM8XX_CLK_GFX_PIXEL },
+
+	{ 6, 2, pll_mux_table, NPCM8XX_CLK_S_SD_MUX,
+	pll_mux_parents, ARRAY_SIZE(pll_mux_parents), 0, -1 },
+
+	{ 8, 2, pll_mux_table, NPCM8XX_CLK_S_UART_MUX,
+	pll_mux_parents, ARRAY_SIZE(pll_mux_parents), 0, -1 },
+
+	{ 10, 2, sucksel_mux_table, NPCM8XX_CLK_S_SU_MUX,
+	sucksel_mux_parents, ARRAY_SIZE(sucksel_mux_parents), 0, -1 },
+
+	{ 12, 2, mccksel_mux_table, NPCM8XX_CLK_S_MC_MUX,
+	mccksel_mux_parents, ARRAY_SIZE(mccksel_mux_parents), 0, -1 },
+
+	{ 14, 2, pll_mux_table, NPCM8XX_CLK_S_ADC_MUX,
+	pll_mux_parents, ARRAY_SIZE(pll_mux_parents), 0, -1 },
+
+	{ 16, 2, pll_mux_table, NPCM8XX_CLK_S_GFX_MUX,
+	pll_mux_parents, ARRAY_SIZE(pll_mux_parents), 0, -1 },
+
+	{ 18, 3, clkoutsel_mux_table, NPCM8XX_CLK_S_CLKOUT_MUX,
+	clkoutsel_mux_parents, ARRAY_SIZE(clkoutsel_mux_parents), 0, -1 },
+
+	{ 21, 2, gfxmsel_mux_table, NPCM8XX_CLK_S_GFXM_MUX,
+	gfxmsel_mux_parents, ARRAY_SIZE(gfxmsel_mux_parents), 0, -1 },
+
+	{ 23, 2, dvcssel_mux_table, NPCM8XX_CLK_S_DVC_MUX,
+	dvcssel_mux_parents, ARRAY_SIZE(dvcssel_mux_parents), 0, -1 },
+
+	{ 25, 2, pll_mux_table, NPCM8XX_CLK_S_RG_MUX,
+	pll_mux_parents, ARRAY_SIZE(pll_mux_parents), 0, -1 },
+
+	{ 27, 2, pll_mux_table, NPCM8XX_CLK_S_RCP_MUX,
+	pll_mux_parents, ARRAY_SIZE(pll_mux_parents), 0, -1 },
+};
+
+/* configurable dividers: */
+static const struct npcm8xx_clk_div_data npcm8xx_divs[] = {
+	{ NPCM8XX_CLKDIV1, 28, 3, NPCM8XX_CLK_S_ADC, pre_adc_div_parent,
+		CLK_DIVIDER_READ_ONLY | CLK_DIVIDER_POWER_OF_TWO, 0,
+		NPCM8XX_CLK_ADC },
+	/* bit 30-28 ADCCKDIV*/
+	{ NPCM8XX_CLKDIV1, 26, 2, NPCM8XX_CLK_S_AHB, pre_clk_div_parent,
+		CLK_DIVIDER_READ_ONLY, CLK_IS_CRITICAL, NPCM8XX_CLK_AHB },
+	/* bit 28-26 CLK4DIV*/
+	{ NPCM8XX_CLKDIV1, 21, 5, NPCM8XX_CLK_S_PRE_ADC,
+	mux_adc_div_parent, CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_PRE_ADC },
+	/* bit 25-21 PRE-ADCCKDIV*/
+	{ NPCM8XX_CLKDIV1, 16, 5, NPCM8XX_CLK_S_UART,
+	mux_uart_div_parent, CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_UART },
+	/* bit 20-16 UARTDIV*/
+	{ NPCM8XX_CLKDIV1, 11, 5, NPCM8XX_CLK_S_MMC,
+	mux_sd_div_parent, CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_MMC },
+	/* bit 15-11 MMCCKDIV*/
+	{ NPCM8XX_CLKDIV1, 6, 5, NPCM8XX_CLK_S_SPI3,
+	ahb_div_parent, 0, 0, NPCM8XX_CLK_SPI3 },
+	/* bit 10-6 AHB3CKDIV*/
+	{ NPCM8XX_CLKDIV1, 2, 4, NPCM8XX_CLK_S_PCI,
+	mux_gfx_div_parent, CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_PCI },
+	/* bit 5-2 PCICKDIV*/
+
+	{ NPCM8XX_CLKDIV2, 30, 2, NPCM8XX_CLK_S_APB4, ahb_div_parent,
+		CLK_DIVIDER_READ_ONLY | CLK_DIVIDER_POWER_OF_TWO, 0,
+		NPCM8XX_CLK_APB4 },
+	/* bit 31-30 APB4CKDIV*/
+	{ NPCM8XX_CLKDIV2, 28, 2, NPCM8XX_CLK_S_APB3, ahb_div_parent,
+		CLK_DIVIDER_READ_ONLY | CLK_DIVIDER_POWER_OF_TWO, 0,
+		NPCM8XX_CLK_APB3 },
+	/* bit 29-28 APB3CKDIV*/
+	{ NPCM8XX_CLKDIV2, 26, 2, NPCM8XX_CLK_S_APB2, ahb_div_parent,
+		CLK_DIVIDER_READ_ONLY | CLK_DIVIDER_POWER_OF_TWO, 0,
+		NPCM8XX_CLK_APB2 },
+	/* bit 28-26 APB2CKDIV*/
+	{ NPCM8XX_CLKDIV2, 24, 2, NPCM8XX_CLK_S_APB1, ahb_div_parent,
+		CLK_DIVIDER_READ_ONLY | CLK_DIVIDER_POWER_OF_TWO, 0,
+		NPCM8XX_CLK_APB1 },
+	/* bit 25-24 APB1CKDIV*/
+	{ NPCM8XX_CLKDIV2, 22, 2, NPCM8XX_CLK_S_APB5, ahb_div_parent,
+		CLK_DIVIDER_READ_ONLY | CLK_DIVIDER_POWER_OF_TWO, 0,
+		NPCM8XX_CLK_APB5 },
+	/* bit 23-22 APB5CKDIV*/
+	{ NPCM8XX_CLKDIV2, 16, 5, NPCM8XX_CLK_S_CLKOUT, mux_clkout_div_parent,
+		 CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_CLKOUT },
+	/* bit 20-16 CLKOUTDIV*/
+	{ NPCM8XX_CLKDIV2, 13, 3, NPCM8XX_CLK_S_GFX, mux_gfx_div_parent,
+		CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_GFX },
+	/* bit 15-13 GFXCKDIV*/
+	{ NPCM8XX_CLKDIV2, 8, 5, NPCM8XX_CLK_S_USB_BRIDGE, mux_su_div_parent,
+		CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_SU },
+	/* bit 12-8 SUCKDIV*/
+	{ NPCM8XX_CLKDIV2, 4, 4, NPCM8XX_CLK_S_USB_HOST, mux_su_div_parent,
+		CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_SU48 },
+	/* bit 8-4 SU48CKDIV*/
+	{ NPCM8XX_CLKDIV2, 0, 4, NPCM8XX_CLK_S_SDHC,
+	mux_sd_div_parent, CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_SDHC }
+	,/* bit 3-0 SD1CKDIV*/
+
+	{ NPCM8XX_CLKDIV3, 16, 8, NPCM8XX_CLK_S_SPI1,
+	ahb_div_parent, CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_SPI1 },
+	/* bit 23-16 SPI1CKDV*/
+	{ NPCM8XX_CLKDIV3, 11, 5, NPCM8XX_CLK_S_UART2,
+	mux_uart_div_parent, CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_UART2 },
+	/* bit 15-11 UARTDIV2*/
+	{ NPCM8XX_CLKDIV3, 6, 5, NPCM8XX_CLK_S_SPI0,
+	ahb_div_parent, CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_SPI0 },
+	/* bit 10-6 SPI0CKDV*/
+	{ NPCM8XX_CLKDIV3, 1, 5, NPCM8XX_CLK_S_SPIX,
+	ahb_div_parent, CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_SPIX },
+	/* bit 5-1 SPIXCKDV*/
+
+	{ NPCM8XX_CLKDIV4, 28, 4, NPCM8XX_CLK_S_RG, mux_rg_div_parent,
+	CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_RG },
+	/* bit 31-28 RGREFDIV*/
+	{ NPCM8XX_CLKDIV4, 12, 4, NPCM8XX_CLK_S_RCP, mux_rcp_div_parent,
+	CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_RCP },
+	/* bit 15-12 RCPREFDIV*/
+	{ NPCM8XX_THRTL_CNT, 0, 2, NPCM8XX_CLK_S_TH, mux_cpu_div_parent,
+	CLK_DIVIDER_READ_ONLY | CLK_DIVIDER_POWER_OF_TWO, 0, NPCM8XX_CLK_TH },
+	/* bit 1-0 TH_DIV*/
+};
+
+static DEFINE_SPINLOCK(npcm8xx_clk_lock);
+
+static int npcm8xx_clk_probe(struct platform_device *pdev)
+{
+	struct clk_hw_onecell_data *npcm8xx_clk_data;
+	struct device *dev = &pdev->dev;
+	void __iomem *clk_base;
+	struct resource *res;
+	struct clk_hw *hw;
+	unsigned int i;
+	int err;
+
+	npcm8xx_clk_data = devm_kzalloc(dev, struct_size(npcm8xx_clk_data, hws,
+							 NPCM8XX_NUM_CLOCKS),
+					GFP_KERNEL);
+	if (!npcm8xx_clk_data)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	clk_base = devm_ioremap(dev, res->start, resource_size(res));
+	if (!clk_base) {
+		dev_err(&pdev->dev, "Failed to remap I/O memory\n");
+		return -ENOMEM;
+	}
+
+	npcm8xx_clk_data->num = NPCM8XX_NUM_CLOCKS;
+
+	for (i = 0; i < NPCM8XX_NUM_CLOCKS; i++)
+		npcm8xx_clk_data->hws[i] = ERR_PTR(-EPROBE_DEFER);
+
+	/* Reference 25MHz clock */
+	hw = devm_clk_hw_register_fixed_rate(dev, "refclk", NULL, 0,
+					     NPCM8XX_REF_CLK);
+	if (IS_ERR(hw))
+		return PTR_ERR(hw);
+	npcm8xx_clk_data->hws[NPCM8XX_CLK_REFCLK] = hw;
+
+	/* Register plls */
+	for (i = 0; i < ARRAY_SIZE(npcm8xx_pll_clks); i++) {
+		struct npcm8xx_clk_pll *pll_clk = &npcm8xx_pll_clks[i];
+
+		hw = npcm8xx_clk_register_pll(dev, pll_clk, clk_base);
+		if (IS_ERR(hw)) {
+			dev_err(dev, "npcm8xx_clk: Can't register pll\n");
+			goto unregister_refclk;
+		}
+	}
+
+	/* Register fixed dividers */
+	hw = devm_clk_hw_register_fixed_factor(dev, NPCM8XX_CLK_S_PLL1_DIV2,
+					       NPCM8XX_CLK_S_PLL1, 0, 1, 2);
+	if (IS_ERR(hw)) {
+		dev_err(dev, "npcm8xx_clk: Can't register fixed div\n");
+		goto unregister_refclk;
+	}
+
+	hw = devm_clk_hw_register_fixed_factor(dev, NPCM8XX_CLK_S_PLL2_DIV2,
+					       NPCM8XX_CLK_S_PLL2, 0, 1, 2);
+	if (IS_ERR(hw)) {
+		dev_err(dev, "npcm8xx_clk: Can't register pll div2\n");
+		goto unregister_refclk;
+	}
+
+	hw = devm_clk_hw_register_fixed_factor(dev, NPCM8XX_CLK_S_PRE_CLK,
+					       NPCM8XX_CLK_S_CPU_MUX, 0, 1, 2);
+	if (IS_ERR(hw)) {
+		dev_err(dev, "npcm8xx_clk: Can't register ckclk div2\n");
+		goto unregister_refclk;
+	}
+
+	hw = devm_clk_hw_register_fixed_factor(dev, NPCM8XX_CLK_S_AXI,
+					       NPCM8XX_CLK_S_TH, 0, 1, 2);
+	if (IS_ERR(hw)) {
+		dev_err(dev, "npcm8xx_clk: Can't register axi div2\n");
+		goto unregister_refclk;
+	}
+
+	hw = devm_clk_hw_register_fixed_factor(dev, NPCM8XX_CLK_S_ATB,
+					       NPCM8XX_CLK_S_AXI, 0, 1, 2);
+	if (IS_ERR(hw)) {
+		dev_err(dev, "npcm8xx_clk: Can't register atb div2\n");
+		goto unregister_refclk;
+	}
+
+	/* Register muxes */
+	for (i = 0; i < ARRAY_SIZE(npcm8xx_muxes); i++) {
+		const struct npcm8xx_clk_mux_data *mux_data = &npcm8xx_muxes[i];
+
+		hw = devm_clk_hw_register_mux_parent_data_table(dev,
+								mux_data->name,
+								mux_data->parent_data,
+								mux_data->num_parents,
+								mux_data->flags,
+								clk_base + NPCM8XX_CLKSEL,
+								mux_data->shift,
+								mux_data->mask,
+								0,
+								mux_data->table,
+								&npcm8xx_clk_lock);
+		if (IS_ERR(hw)) {
+			dev_err(dev, "npcm8xx_clk: Can't register mux\n");
+			goto err_mux_clk;
+		}
+
+		if (mux_data->onecell_idx >= 0)
+			npcm8xx_clk_data->hws[mux_data->onecell_idx] = hw;
+	}
+
+	/* Register clock dividers specified in npcm8xx_divs */
+	for (i = 0; i < ARRAY_SIZE(npcm8xx_divs); i++) {
+		const struct npcm8xx_clk_div_data *div_data = &npcm8xx_divs[i];
+
+		hw = clk_hw_register_divider_parent_data(dev, div_data->name,
+							 div_data->parent_data,
+							 div_data->flags,
+							 clk_base + div_data->reg,
+							 div_data->shift,
+							 div_data->width,
+							 div_data->clk_divider_flags,
+							 &npcm8xx_clk_lock);
+		if (IS_ERR(hw)) {
+			dev_err(dev, "npcm8xx_clk: Can't register div table\n");
+			goto unregister_refclk;
+		}
+
+		if (div_data->onecell_idx >= 0)
+			npcm8xx_clk_data->hws[div_data->onecell_idx] = hw;
+	}
+
+	err = devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
+					  npcm8xx_clk_data);
+	if (err) {
+		dev_err(dev, "unable to add clk provider\n");
+		hw = ERR_PTR(err);
+		goto err_mux_clk;
+	}
+
+	return err;
+
+err_mux_clk:
+	while (i--) {
+		if (npcm8xx_muxes[i].onecell_idx >= 0)
+			clk_hw_unregister_mux(npcm8xx_clk_data->hws[npcm8xx_muxes[i].onecell_idx]);
+	}
+unregister_refclk:
+	clk_hw_unregister(npcm8xx_clk_data->hws[NPCM8XX_CLK_REFCLK]);
+	return PTR_ERR(hw);
+}
+
+static const struct of_device_id npcm8xx_clk_dt_ids[] = {
+	{ .compatible = "nuvoton,npcm845-clk", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, npcm8xx_clk_dt_ids);
+
+static struct platform_driver npcm8xx_clk_driver = {
+	.probe  = npcm8xx_clk_probe,
+	.driver = {
+		.name = "npcm8xx_clk",
+		.of_match_table = npcm8xx_clk_dt_ids,
+	},
+};
+
+static int __init npcm8xx_clk_driver_init(void)
+{
+	return platform_driver_register(&npcm8xx_clk_driver);
+}
+arch_initcall(npcm8xx_clk_driver_init);
+
+static void __exit npcm8xx_clk_exit(void)
+{
+	platform_driver_unregister(&npcm8xx_clk_driver);
+}
+module_exit(npcm8xx_clk_exit);
+
+MODULE_DESCRIPTION("Clock driver for Nuvoton NPCM8XX BMC SoC");
+MODULE_AUTHOR("Tomer Maimon <tomer.maimon@nuvoton.com>");
+MODULE_LICENSE("GPL v2");
+
-- 
2.33.0


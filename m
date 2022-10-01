Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ADBC5F16C9
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 01:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbiI3XoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 19:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbiI3XoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 19:44:17 -0400
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5E495156C3C;
        Fri, 30 Sep 2022 16:44:11 -0700 (PDT)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id C4707E0EBF;
        Fri, 30 Sep 2022 01:54:15 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:from:from:in-reply-to:message-id
        :mime-version:references:reply-to:subject:subject:to:to; s=post;
         bh=uRK9IKVlz6zQsxgI3y5ButPzPrRfjr0jcjT0sXlRj6k=; b=YrCJS7TmbIWM
        tt9epBeo+b+l6iOWMcGh3N0vzgHu8L1rVMYo2EDcnIUWIa6mNPQx6Ny2cZL905er
        X6zPLlT6HoEjFsxjuLYQD6As2BYBIhQsrNYJ7d4+vfGH6I4XDUw65FET6+Ykb1p0
        FkP4EHupIIZI9p++yw+fEJLY7GyoXqY=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id B66E6E0EBB;
        Fri, 30 Sep 2022 01:54:15 +0300 (MSK)
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 30 Sep 2022 01:54:16 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        <linux-clk@vger.kernel.org>, <linux-mips@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH RESEND v12 8/8] clk: baikal-t1: Convert to platform device driver
Date:   Fri, 30 Sep 2022 01:54:02 +0300
Message-ID: <20220929225402.9696-9-Sergey.Semin@baikalelectronics.ru>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220929225402.9696-1-Sergey.Semin@baikalelectronics.ru>
References: <20220929225402.9696-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [192.168.168.10]
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In accordance with the way the MIPS platform is normally design there are
only six clock sources which need to be available on the kernel start in
order to one end up booting correctly:
+ CPU PLL: needed by the r4k and MIPS GIC timer drivers. The former one is
  initialized by the arch code, while the later one is implemented in the
  mips-gic-timer.c driver as the OF-declared timer.
+ PCIe PLL: required as a parental clock source for the APB/timer domains.
+ APB clock: needed in order to access all the SoC CSRs at least for the
  timer OF-declared drivers.
+ APB Timer{0-2} clocks: these are the DW APB timers which drivers
  dw_apb_timer_of.c are implemented as the OF-declared timers.

So as long as the clocks above are available early the kernel will
normally work. Let's convert the Baikal-T1 CCU drivers to the platform
device drivers keeping that in mind.

Generally speaking the conversion isn't that complicated since the driver
infrastructure has been designed as flexible enough for that. First we
need to add a new PLL/Divider clock features flag which indicates the
corresponding clock source as a basic one and that clock sources will be
available on the kernel early boot stages. Second the internal PLL/Divider
descriptors need to be initialized with -EPROBE_DEFER value as the
corresponding clock source is unavailable at the early stages. They will
be allocated and initialized on the Baikal-T1 clock platform driver probe
procedure. Finally the already available PLL/Divider init functions need
to be split up into two ones: init procedure performed in the framework of
the OF-declared clock initialization (of_clk_init()), and the probe
procedure called by the platform devices bus driver. Note the later method
will just continue the system clocks initialization started in the former
one.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

---

Changelog v4:
- This is a new patch created on v4 lap of the series to make @Stephen
  a bit more happy about this series.)

Changelog v7:
- Fix "Alignment should match open parenthesis" warning for the
  pr_err() method invocations. (@Philipp)

Changelog 10:
- Include module.h header file.
---
 drivers/clk/baikal-t1/ccu-div.h     |   3 +
 drivers/clk/baikal-t1/ccu-pll.h     |   8 ++
 drivers/clk/baikal-t1/clk-ccu-div.c | 150 +++++++++++++++++++++++-----
 drivers/clk/baikal-t1/clk-ccu-pll.c | 129 +++++++++++++++++++-----
 4 files changed, 237 insertions(+), 53 deletions(-)

diff --git a/drivers/clk/baikal-t1/ccu-div.h b/drivers/clk/baikal-t1/ccu-div.h
index ff97bb30fcc3..76d8ee44d415 100644
--- a/drivers/clk/baikal-t1/ccu-div.h
+++ b/drivers/clk/baikal-t1/ccu-div.h
@@ -23,6 +23,8 @@
 
 /*
  * CCU Divider private flags
+ * @CCU_DIV_BASIC: Basic divider clock required by the kernel as early as
+ *		   possible.
  * @CCU_DIV_SKIP_ONE: Due to some reason divider can't be set to 1.
  *		      It can be 0 though, which is functionally the same.
  * @CCU_DIV_SKIP_ONE_TO_THREE: For some reason divider can't be within [1,3].
@@ -30,6 +32,7 @@
  * @CCU_DIV_LOCK_SHIFTED: Find lock-bit at non-standard position.
  * @CCU_DIV_RESET_DOMAIN: There is a clock domain reset handle.
  */
+#define CCU_DIV_BASIC			BIT(0)
 #define CCU_DIV_SKIP_ONE		BIT(1)
 #define CCU_DIV_SKIP_ONE_TO_THREE	BIT(2)
 #define CCU_DIV_LOCK_SHIFTED		BIT(3)
diff --git a/drivers/clk/baikal-t1/ccu-pll.h b/drivers/clk/baikal-t1/ccu-pll.h
index 76cd9132a219..a71bfd7b90ec 100644
--- a/drivers/clk/baikal-t1/ccu-pll.h
+++ b/drivers/clk/baikal-t1/ccu-pll.h
@@ -13,6 +13,12 @@
 #include <linux/bits.h>
 #include <linux/of.h>
 
+/*
+ * CCU PLL private flags
+ * @CCU_PLL_BASIC: Basic PLL required by the kernel as early as possible.
+ */
+#define CCU_PLL_BASIC		BIT(0)
+
 /*
  * struct ccu_pll_init_data - CCU PLL initialization data
  * @id: Clock private identifier.
@@ -22,6 +28,7 @@
  * @sys_regs: Baikal-T1 System Controller registers map.
  * @np: Pointer to the node describing the CCU PLLs.
  * @flags: PLL clock flags.
+ * @features: PLL private features.
  */
 struct ccu_pll_init_data {
 	unsigned int id;
@@ -31,6 +38,7 @@ struct ccu_pll_init_data {
 	struct regmap *sys_regs;
 	struct device_node *np;
 	unsigned long flags;
+	unsigned long features;
 };
 
 /*
diff --git a/drivers/clk/baikal-t1/clk-ccu-div.c b/drivers/clk/baikal-t1/clk-ccu-div.c
index 278aa38d767e..ce710ad8ebc3 100644
--- a/drivers/clk/baikal-t1/clk-ccu-div.c
+++ b/drivers/clk/baikal-t1/clk-ccu-div.c
@@ -12,6 +12,8 @@
 #define pr_fmt(fmt) "bt1-ccu-div: " fmt
 
 #include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
 #include <linux/printk.h>
 #include <linux/slab.h>
 #include <linux/clk-provider.h>
@@ -180,7 +182,7 @@ static const struct ccu_div_info sys_info[] = {
 			 CLK_SET_RATE_PARENT),
 	CCU_DIV_VAR_INFO(CCU_SYS_APB_CLK, "sys_apb_clk",
 			 "pcie_clk", CCU_SYS_APB_BASE, 5,
-			 CLK_IS_CRITICAL, CCU_DIV_RESET_DOMAIN),
+			 CLK_IS_CRITICAL, CCU_DIV_BASIC | CCU_DIV_RESET_DOMAIN),
 	CCU_DIV_GATE_INFO(CCU_SYS_GMAC0_TX_CLK, "sys_gmac0_tx_clk",
 			  "eth_clk", CCU_SYS_GMAC0_BASE, 5),
 	CCU_DIV_FIXED_INFO(CCU_SYS_GMAC0_PTP_CLK, "sys_gmac0_ptp_clk",
@@ -214,28 +216,53 @@ static const struct ccu_div_info sys_info[] = {
 			   "ref_clk", 25),
 	CCU_DIV_VAR_INFO(CCU_SYS_TIMER0_CLK, "sys_timer0_clk",
 			 "ref_clk", CCU_SYS_TIMER0_BASE, 17,
-			 CLK_SET_RATE_GATE, 0),
+			 CLK_SET_RATE_GATE, CCU_DIV_BASIC),
 	CCU_DIV_VAR_INFO(CCU_SYS_TIMER1_CLK, "sys_timer1_clk",
 			 "ref_clk", CCU_SYS_TIMER1_BASE, 17,
-			 CLK_SET_RATE_GATE, 0),
+			 CLK_SET_RATE_GATE, CCU_DIV_BASIC),
 	CCU_DIV_VAR_INFO(CCU_SYS_TIMER2_CLK, "sys_timer2_clk",
 			 "ref_clk", CCU_SYS_TIMER2_BASE, 17,
-			 CLK_SET_RATE_GATE, 0),
+			 CLK_SET_RATE_GATE, CCU_DIV_BASIC),
 	CCU_DIV_VAR_INFO(CCU_SYS_WDT_CLK, "sys_wdt_clk",
 			 "eth_clk", CCU_SYS_WDT_BASE, 17,
 			 CLK_SET_RATE_GATE, CCU_DIV_SKIP_ONE_TO_THREE)
 };
 
+static struct ccu_div_data *axi_data;
+static struct ccu_div_data *sys_data;
+
+static void ccu_div_set_data(struct ccu_div_data *data)
+{
+	struct device_node *np = data->np;
+
+	if (of_device_is_compatible(np, "baikal,bt1-ccu-axi"))
+		axi_data = data;
+	else if (of_device_is_compatible(np, "baikal,bt1-ccu-sys"))
+		sys_data = data;
+	else
+		pr_err("Invalid DT node '%s' specified\n", of_node_full_name(np));
+}
+
+static struct ccu_div_data *ccu_div_get_data(struct device_node *np)
+{
+	if (of_device_is_compatible(np, "baikal,bt1-ccu-axi"))
+		return axi_data;
+	else if (of_device_is_compatible(np, "baikal,bt1-ccu-sys"))
+		return sys_data;
+
+	pr_err("Invalid DT node '%s' specified\n", of_node_full_name(np));
+
+	return NULL;
+}
+
 static struct ccu_div *ccu_div_find_desc(struct ccu_div_data *data,
 					 unsigned int clk_id)
 {
-	struct ccu_div *div;
 	int idx;
 
 	for (idx = 0; idx < data->divs_num; ++idx) {
-		div = data->divs[idx];
-		if (div && div->id == clk_id)
-			return div;
+		if (data->divs_info[idx].id == clk_id)
+			return data->divs[idx];
 	}
 
 	return ERR_PTR(-EINVAL);
@@ -307,14 +334,16 @@ static struct clk_hw *ccu_div_of_clk_hw_get(struct of_phandle_args *clkspec,
 	clk_id = clkspec->args[0];
 	div = ccu_div_find_desc(data, clk_id);
 	if (IS_ERR(div)) {
-		pr_info("Invalid clock ID %d specified\n", clk_id);
+		if (div != ERR_PTR(-EPROBE_DEFER))
+			pr_info("Invalid clock ID %d specified\n", clk_id);
+
 		return ERR_CAST(div);
 	}
 
 	return ccu_div_get_clk_hw(div);
 }
 
-static int ccu_div_clk_register(struct ccu_div_data *data)
+static int ccu_div_clk_register(struct ccu_div_data *data, bool defer)
 {
 	int idx, ret;
 
@@ -322,6 +351,13 @@ static int ccu_div_clk_register(struct ccu_div_data *data)
 		const struct ccu_div_info *info = &data->divs_info[idx];
 		struct ccu_div_init_data init = {0};
 
+		if (!!(info->features & CCU_DIV_BASIC) ^ defer) {
+			if (!data->divs[idx])
+				data->divs[idx] = ERR_PTR(-EPROBE_DEFER);
+
+			continue;
+		}
+
 		init.id = info->id;
 		init.name = info->name;
 		init.parent_name = info->parent_name;
@@ -354,30 +390,43 @@ static int ccu_div_clk_register(struct ccu_div_data *data)
 		}
 	}
 
-	ret = of_clk_add_hw_provider(data->np, ccu_div_of_clk_hw_get, data);
-	if (ret) {
-		pr_err("Couldn't register dividers '%s' clock provider\n",
-			of_node_full_name(data->np));
-		goto err_hw_unregister;
-	}
-
 	return 0;
 
 err_hw_unregister:
-	for (--idx; idx >= 0; --idx)
+	for (--idx; idx >= 0; --idx) {
+		if (!!(data->divs_info[idx].features & CCU_DIV_BASIC) ^ defer)
+			continue;
+
 		ccu_div_hw_unregister(data->divs[idx]);
+	}
 
 	return ret;
 }
 
-static void ccu_div_clk_unregister(struct ccu_div_data *data)
+static void ccu_div_clk_unregister(struct ccu_div_data *data, bool defer)
 {
 	int idx;
 
-	of_clk_del_provider(data->np);
+	/* Uninstall only the clocks registered on the specfied stage */
+	for (idx = 0; idx < data->divs_num; ++idx) {
+		if (!!(data->divs_info[idx].features & CCU_DIV_BASIC) ^ defer)
+			continue;
 
-	for (idx = 0; idx < data->divs_num; ++idx)
 		ccu_div_hw_unregister(data->divs[idx]);
+	}
+}
+
+static int ccu_div_of_register(struct ccu_div_data *data)
+{
+	int ret;
+
+	ret = of_clk_add_hw_provider(data->np, ccu_div_of_clk_hw_get, data);
+	if (ret) {
+		pr_err("Couldn't register dividers '%s' clock provider\n",
+		       of_node_full_name(data->np));
+	}
+
+	return ret;
 }
 
 static int ccu_div_rst_register(struct ccu_div_data *data)
@@ -397,7 +446,49 @@ static int ccu_div_rst_register(struct ccu_div_data *data)
 	return 0;
 }
 
-static void ccu_div_init(struct device_node *np)
+static int ccu_div_probe(struct platform_device *pdev)
+{
+	struct ccu_div_data *data;
+	int ret;
+
+	data = ccu_div_get_data(dev_of_node(&pdev->dev));
+	if (!data)
+		return -EINVAL;
+
+	ret = ccu_div_clk_register(data, false);
+	if (ret)
+		return ret;
+
+	ret = ccu_div_rst_register(data);
+	if (ret)
+		goto err_clk_unregister;
+
+	return 0;
+
+err_clk_unregister:
+	ccu_div_clk_unregister(data, false);
+
+	return ret;
+}
+
+static const struct of_device_id ccu_div_of_match[] = {
+	{ .compatible = "baikal,bt1-ccu-axi" },
+	{ .compatible = "baikal,bt1-ccu-sys" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ccu_div_of_match);
+
+static struct platform_driver ccu_div_driver = {
+	.probe  = ccu_div_probe,
+	.driver = {
+		.name = "clk-ccu-div",
+		.of_match_table = ccu_div_of_match,
+		.suppress_bind_attrs = true,
+	},
+};
+builtin_platform_driver(ccu_div_driver);
+
+static __init void ccu_div_init(struct device_node *np)
 {
 	struct ccu_div_data *data;
 	int ret;
@@ -410,22 +501,27 @@ static void ccu_div_init(struct device_node *np)
 	if (ret)
 		goto err_free_data;
 
-	ret = ccu_div_clk_register(data);
+	ret = ccu_div_clk_register(data, true);
 	if (ret)
 		goto err_free_data;
 
-	ret = ccu_div_rst_register(data);
+	ret = ccu_div_of_register(data);
 	if (ret)
 		goto err_clk_unregister;
 
+	ccu_div_set_data(data);
+
 	return;
 
 err_clk_unregister:
-	ccu_div_clk_unregister(data);
+	ccu_div_clk_unregister(data, true);
 
 err_free_data:
 	ccu_div_free_data(data);
 }
+CLK_OF_DECLARE_DRIVER(ccu_axi, "baikal,bt1-ccu-axi", ccu_div_init);
+CLK_OF_DECLARE_DRIVER(ccu_sys, "baikal,bt1-ccu-sys", ccu_div_init);
 
-CLK_OF_DECLARE(ccu_axi, "baikal,bt1-ccu-axi", ccu_div_init);
-CLK_OF_DECLARE(ccu_sys, "baikal,bt1-ccu-sys", ccu_div_init);
+MODULE_AUTHOR("Serge Semin <Sergey.Semin@baikalelectronics.ru>");
+MODULE_DESCRIPTION("Baikal-T1 CCU Dividers clock driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/baikal-t1/clk-ccu-pll.c b/drivers/clk/baikal-t1/clk-ccu-pll.c
index 2445d4b12baf..313095587c26 100644
--- a/drivers/clk/baikal-t1/clk-ccu-pll.c
+++ b/drivers/clk/baikal-t1/clk-ccu-pll.c
@@ -12,6 +12,8 @@
 #define pr_fmt(fmt) "bt1-ccu-pll: " fmt
 
 #include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
 #include <linux/printk.h>
 #include <linux/slab.h>
 #include <linux/clk-provider.h>
@@ -31,13 +33,14 @@
 #define CCU_PCIE_PLL_BASE		0x018
 #define CCU_ETH_PLL_BASE		0x020
 
-#define CCU_PLL_INFO(_id, _name, _pname, _base, _flags)	\
-	{						\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _pname,			\
-		.base = _base,				\
-		.flags = _flags				\
+#define CCU_PLL_INFO(_id, _name, _pname, _base, _flags, _features)	\
+	{								\
+		.id = _id,						\
+		.name = _name,						\
+		.parent_name = _pname,					\
+		.base = _base,						\
+		.flags = _flags,					\
+		.features = _features,					\
 	}
 
 #define CCU_PLL_NUM			ARRAY_SIZE(pll_info)
@@ -48,6 +51,7 @@ struct ccu_pll_info {
 	const char *parent_name;
 	unsigned int base;
 	unsigned long flags;
+	unsigned long features;
 };
 
 /*
@@ -61,15 +65,15 @@ struct ccu_pll_info {
  */
 static const struct ccu_pll_info pll_info[] = {
 	CCU_PLL_INFO(CCU_CPU_PLL, "cpu_pll", "ref_clk", CCU_CPU_PLL_BASE,
-		     CLK_IS_CRITICAL),
+		     CLK_IS_CRITICAL, CCU_PLL_BASIC),
 	CCU_PLL_INFO(CCU_SATA_PLL, "sata_pll", "ref_clk", CCU_SATA_PLL_BASE,
-		     CLK_IS_CRITICAL | CLK_SET_RATE_GATE),
+		     CLK_IS_CRITICAL | CLK_SET_RATE_GATE, 0),
 	CCU_PLL_INFO(CCU_DDR_PLL, "ddr_pll", "ref_clk", CCU_DDR_PLL_BASE,
-		     CLK_IS_CRITICAL | CLK_SET_RATE_GATE),
+		     CLK_IS_CRITICAL | CLK_SET_RATE_GATE, 0),
 	CCU_PLL_INFO(CCU_PCIE_PLL, "pcie_pll", "ref_clk", CCU_PCIE_PLL_BASE,
-		     CLK_IS_CRITICAL),
+		     CLK_IS_CRITICAL, CCU_PLL_BASIC),
 	CCU_PLL_INFO(CCU_ETH_PLL, "eth_pll", "ref_clk", CCU_ETH_PLL_BASE,
-		     CLK_IS_CRITICAL | CLK_SET_RATE_GATE)
+		     CLK_IS_CRITICAL | CLK_SET_RATE_GATE, 0)
 };
 
 struct ccu_pll_data {
@@ -78,16 +82,16 @@ struct ccu_pll_data {
 	struct ccu_pll *plls[CCU_PLL_NUM];
 };
 
+static struct ccu_pll_data *pll_data;
+
 static struct ccu_pll *ccu_pll_find_desc(struct ccu_pll_data *data,
 					 unsigned int clk_id)
 {
-	struct ccu_pll *pll;
 	int idx;
 
 	for (idx = 0; idx < CCU_PLL_NUM; ++idx) {
-		pll = data->plls[idx];
-		if (pll && pll->id == clk_id)
-			return pll;
+		if (pll_info[idx].id == clk_id)
+			return data->plls[idx];
 	}
 
 	return ERR_PTR(-EINVAL);
@@ -133,14 +137,16 @@ static struct clk_hw *ccu_pll_of_clk_hw_get(struct of_phandle_args *clkspec,
 	clk_id = clkspec->args[0];
 	pll = ccu_pll_find_desc(data, clk_id);
 	if (IS_ERR(pll)) {
-		pr_info("Invalid PLL clock ID %d specified\n", clk_id);
+		if (pll != ERR_PTR(-EPROBE_DEFER))
+			pr_info("Invalid PLL clock ID %d specified\n", clk_id);
+
 		return ERR_CAST(pll);
 	}
 
 	return ccu_pll_get_clk_hw(pll);
 }
 
-static int ccu_pll_clk_register(struct ccu_pll_data *data)
+static int ccu_pll_clk_register(struct ccu_pll_data *data, bool defer)
 {
 	int idx, ret;
 
@@ -148,6 +154,14 @@ static int ccu_pll_clk_register(struct ccu_pll_data *data)
 		const struct ccu_pll_info *info = &pll_info[idx];
 		struct ccu_pll_init_data init = {0};
 
+		/* Defer non-basic PLLs allocation for the probe stage */
+		if (!!(info->features & CCU_PLL_BASIC) ^ defer) {
+			if (!data->plls[idx])
+				data->plls[idx] = ERR_PTR(-EPROBE_DEFER);
+
+			continue;
+		}
+
 		init.id = info->id;
 		init.name = info->name;
 		init.parent_name = info->parent_name;
@@ -155,6 +169,7 @@ static int ccu_pll_clk_register(struct ccu_pll_data *data)
 		init.sys_regs = data->sys_regs;
 		init.np = data->np;
 		init.flags = info->flags;
+		init.features = info->features;
 
 		data->plls[idx] = ccu_pll_hw_register(&init);
 		if (IS_ERR(data->plls[idx])) {
@@ -165,22 +180,71 @@ static int ccu_pll_clk_register(struct ccu_pll_data *data)
 		}
 	}
 
+	return 0;
+
+err_hw_unregister:
+	for (--idx; idx >= 0; --idx) {
+		if (!!(pll_info[idx].features & CCU_PLL_BASIC) ^ defer)
+			continue;
+
+		ccu_pll_hw_unregister(data->plls[idx]);
+	}
+
+	return ret;
+}
+
+static void ccu_pll_clk_unregister(struct ccu_pll_data *data, bool defer)
+{
+	int idx;
+
+	/* Uninstall only the clocks registered on the specfied stage */
+	for (idx = 0; idx < CCU_PLL_NUM; ++idx) {
+		if (!!(pll_info[idx].features & CCU_PLL_BASIC) ^ defer)
+			continue;
+
+		ccu_pll_hw_unregister(data->plls[idx]);
+	}
+}
+
+static int ccu_pll_of_register(struct ccu_pll_data *data)
+{
+	int ret;
+
 	ret = of_clk_add_hw_provider(data->np, ccu_pll_of_clk_hw_get, data);
 	if (ret) {
 		pr_err("Couldn't register PLL provider of '%s'\n",
 			of_node_full_name(data->np));
-		goto err_hw_unregister;
 	}
 
-	return 0;
+	return ret;
+}
 
-err_hw_unregister:
-	for (--idx; idx >= 0; --idx)
-		ccu_pll_hw_unregister(data->plls[idx]);
+static int ccu_pll_probe(struct platform_device *pdev)
+{
+	struct ccu_pll_data *data = pll_data;
 
-	return ret;
+	if (!data)
+		return -EINVAL;
+
+	return ccu_pll_clk_register(data, false);
 }
 
+static const struct of_device_id ccu_pll_of_match[] = {
+	{ .compatible = "baikal,bt1-ccu-pll" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ccu_pll_of_match);
+
+static struct platform_driver ccu_pll_driver = {
+	.probe  = ccu_pll_probe,
+	.driver = {
+		.name = "clk-ccu-pll",
+		.of_match_table = ccu_pll_of_match,
+		.suppress_bind_attrs = true,
+	},
+};
+builtin_platform_driver(ccu_pll_driver);
+
 static __init void ccu_pll_init(struct device_node *np)
 {
 	struct ccu_pll_data *data;
@@ -194,13 +258,26 @@ static __init void ccu_pll_init(struct device_node *np)
 	if (ret)
 		goto err_free_data;
 
-	ret = ccu_pll_clk_register(data);
+	ret = ccu_pll_clk_register(data, true);
 	if (ret)
 		goto err_free_data;
 
+	ret = ccu_pll_of_register(data);
+	if (ret)
+		goto err_clk_unregister;
+
+	pll_data = data;
+
 	return;
 
+err_clk_unregister:
+	ccu_pll_clk_unregister(data, true);
+
 err_free_data:
 	ccu_pll_free_data(data);
 }
-CLK_OF_DECLARE(ccu_pll, "baikal,bt1-ccu-pll", ccu_pll_init);
+CLK_OF_DECLARE_DRIVER(ccu_pll, "baikal,bt1-ccu-pll", ccu_pll_init);
+
+MODULE_AUTHOR("Serge Semin <Sergey.Semin@baikalelectronics.ru>");
+MODULE_DESCRIPTION("Baikal-T1 CCU PLL clock driver");
+MODULE_LICENSE("GPL");
-- 
2.37.3



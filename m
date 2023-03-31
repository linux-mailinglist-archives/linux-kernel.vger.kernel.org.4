Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89DF76D18CD
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 09:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbjCaHmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 03:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbjCaHll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 03:41:41 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2076.outbound.protection.outlook.com [40.107.101.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10AF211176;
        Fri, 31 Mar 2023 00:41:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QWIzt7BCVHyEJPHtiS/YQSixiJSGbIahe8JDLLUNlk7nYpNoBLO1HHI8x8piRz6dkkhem0+BJRe2bDlDkshFOihc2wVkyb0QCGOsXV6I6Gy1qOpokymVdqmjvDgHW7HsYdpTeyIijZOwBkRSKe55mgLPqqWAC7400ZWx6/aI8RRqPvjsGMGhFA2QhqlDHzqoUC0AcRI6lTqc2F30HPMuZStcesXbBEpy+UNiHKvE8BHTOktY8UWJF7LQOV/IkFFoiV1MKOnKIAQ5Ly+pFkKtm90mLtZ/41cWJHwdhb2prCWv/aYzqX8hUYmK+9Zrvush6z0shM2nNLWKsYQYws81Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CWEL/a+X4tXqmLP0hjTzAnzqIqLiUb1AGbLfNupgtrg=;
 b=SyoSoj46yY8EdGFvouozfzeNWI7+ZsfShNYheWIlvFYfvwYo/kY3VWdEHnfooqjKGAI8NGGObs6giLFHHwCkT2gdfMWs4z1LSOwjOq919DJYVbQzaJ39gkKyRJkVk0tTZgY1OhrMdlY82t52PFAEqJGzVsEM9YLobYz7X6/EFgGgD4PnxrnH7P1+04fOZxoX7eQAfTp8JIE9+GQLXHGp/76/4gjQ2aN0lTslJjZjJraZgzMNKi6LqZWgG/7Te4jW0NkmGb9GwM7renQaazUQE2YBhJK/MO2X5s2sbId/leOCU3k0dzC9hxkpJjN9zIR6P5AxoJ67li6RPonmYx3GGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-watchdog.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CWEL/a+X4tXqmLP0hjTzAnzqIqLiUb1AGbLfNupgtrg=;
 b=DJXbFJc4Kt66OZcg6nIbCgjoH1MBYXiOAVp3Er1DjvVUxpSDX7ZxVODxwSUyu8RYP5YGpJxnvklMGttGLh/rZtpCRYv74U9HPOLtKARUl/R2Ewtn2wttUNYO5fVjCu395TXm+GzT2kVMN2YpUxEqxxOyQ6PXHduyWqHQ3ToldRM=
Received: from BL1PR13CA0248.namprd13.prod.outlook.com (2603:10b6:208:2ba::13)
 by BY5PR12MB4322.namprd12.prod.outlook.com (2603:10b6:a03:20a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22; Fri, 31 Mar
 2023 07:41:36 +0000
Received: from BL02EPF000108EB.namprd05.prod.outlook.com
 (2603:10b6:208:2ba:cafe::29) by BL1PR13CA0248.outlook.office365.com
 (2603:10b6:208:2ba::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Fri, 31 Mar 2023 07:41:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF000108EB.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Fri, 31 Mar 2023 07:41:35 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 31 Mar
 2023 02:41:34 -0500
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Fri, 31 Mar 2023 02:41:31 -0500
From:   Srinivas Neeli <srinivas.neeli@amd.com>
To:     <shubhrajyoti.datta@amd.com>, <michal.simek@amd.com>,
        <srinivas.goud@amd.com>, <wim@linux-watchdog.org>,
        <linux@roeck-us.net>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <srinivas.neeli@amd.com>, <linux-watchdog@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <git@amd.com>,
        <git@xilinx.com>, <neelisrinivas18@gmail.com>
Subject: [PATCH V3 3/4] watchdog: xilinx_wwdt: Add Versal window watchdog support
Date:   Fri, 31 Mar 2023 13:11:16 +0530
Message-ID: <20230331074117.356339-4-srinivas.neeli@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230331074117.356339-1-srinivas.neeli@amd.com>
References: <20230331074117.356339-1-srinivas.neeli@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000108EB:EE_|BY5PR12MB4322:EE_
X-MS-Office365-Filtering-Correlation-Id: f0e6990f-657c-450b-c862-08db31bb5adb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +13PE/kTgTw51ousKML/f74MnU9GoV+FZ9KtZZT43IhNgQNECtw5f+wUJ2rTZTb63I802UfFGkCpCjUvTDTWvlkmjcTikAnkJYWrhg3jzxbLkLCXDVHaDDcJL4ChDihWEnWjuw7A1mwRSy/ZyGdf1z9rEUj3VZi4B3tee+cceaGx50rAigTYAWb+WRvG0/JWn05NfxYKDjHpC5pLOMeGMKO+SvsIc80LJI1GHdVVB6maNMYH8jwa4ODsyIFzFd90BkKj2Drz6sDqfYJYuO9E+6Rj2zliwa/tnpo6gxh/6vzaYYJb3nEaw7Pue7xf5mtZyoqyHSP7gkckWZVSdRUkPJOWqe9o3UBczmz2UJQ2X8tNLwECHj3SP9q0NCt+2eZeIV4emBZQ05tj3DbmGA9OMQB93tiiy38irNnRW9LiU6GRDeyHTQ1jrnaNR2fQgILenKLxaDc2AfAO1gs9RK43w2vrSYRt1ixEvzaJy5qa1IMdnONDRMyyCuMa9WZLPcVzeLr4UXRmhn7Xmc6JkC1a/QXvoyoang/iRdotf4O6pQCHKkmGVpe3+j08qZPmIVnkMt8yV4p9SdcZajqPQNPNgcNitgKmwwSVGBTHahTync6X4jXmvNO+ZiWaBgjbn4D18LoHsXIIFgdcDvwa8h6s+iOq8/3LQhWFsjPBp3YPpKUJM08XfCJUGUxSNxUgEcV1mm+VchCUomD7k2Yxg578YsKNfLP75WDaG9ahIEaff+M=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(136003)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(478600001)(47076005)(83380400001)(336012)(36860700001)(2616005)(426003)(186003)(1076003)(36756003)(40480700001)(82310400005)(86362001)(82740400003)(26005)(81166007)(356005)(40460700003)(6666004)(4326008)(70586007)(70206006)(2906002)(8676002)(44832011)(8936002)(5660300002)(41300700001)(54906003)(316002)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 07:41:35.5587
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0e6990f-657c-450b-c862-08db31bb5adb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000108EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4322
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Versal watchdog driver uses window watchdog mode. Window watchdog
timer(WWDT) contains closed(first) and open(second) window with
32 bit width. Write to the watchdog timer within predefined window
periods of time. This means a period that is not too soon and a
period that is not too late. The WWDT has to be restarted within
the open window time. If software tries to restart WWDT outside of
the open window time period, it generates a reset.

Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>
---
Changes in V3:
-Removed "xlnx,close_percent" support from dtb.
-Added "xlnx,close_percent" property as module paratmeter.
-Updated code with devm_clk_get_enabled().
Changes in V2:
- Takes "xlnx,close-percent" property from device tree parameter.
- Removed clk_disable() function.
- Removed module parameter permisions and using readomly.
- Added check for close_percent( 0 < close_perecent < 100).
- Updated other minor comments.
---
 drivers/watchdog/Kconfig       |  18 +++
 drivers/watchdog/Makefile      |   1 +
 drivers/watchdog/xilinx_wwdt.c | 215 +++++++++++++++++++++++++++++++++
 3 files changed, 234 insertions(+)
 create mode 100644 drivers/watchdog/xilinx_wwdt.c

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index f0872970daf9..ec4b522ae29e 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -304,6 +304,24 @@ config XILINX_WATCHDOG
 	  To compile this driver as a module, choose M here: the
 	  module will be called of_xilinx_wdt.
 
+config XILINX_WINDOW_WATCHDOG
+	tristate "Xilinx window watchdog timer"
+	depends on HAS_IOMEM
+	depends on ARM64
+	select WATCHDOG_CORE
+	help
+	  Window watchdog driver for the versal_wwdt IP core.
+	  Window watchdog timer(WWDT) contains closed(first) and
+	  open(second) window with 32 bit width. Write to the watchdog
+	  timer within predefined window periods of time. This means
+	  a period that is not too soon and a period that is not too
+	  late. The WWDT has to be restarted within the open window time.
+	  If software tries to restart WWDT outside of the open window
+	  time period, it generates a reset.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called xilinx_wwdt.
+
 config ZIIRAVE_WATCHDOG
 	tristate "Zodiac RAVE Watchdog Timer"
 	depends on I2C
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index 9cbf6580f16c..6cb5f1dfb492 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -157,6 +157,7 @@ obj-$(CONFIG_M54xx_WATCHDOG) += m54xx_wdt.o
 
 # MicroBlaze Architecture
 obj-$(CONFIG_XILINX_WATCHDOG) += of_xilinx_wdt.o
+obj-$(CONFIG_XILINX_WINDOW_WATCHDOG) += xilinx_wwdt.o
 
 # MIPS Architecture
 obj-$(CONFIG_ATH79_WDT) += ath79_wdt.o
diff --git a/drivers/watchdog/xilinx_wwdt.c b/drivers/watchdog/xilinx_wwdt.c
new file mode 100644
index 000000000000..7e9205bbf160
--- /dev/null
+++ b/drivers/watchdog/xilinx_wwdt.c
@@ -0,0 +1,215 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Window watchdog device driver for Xilinx Versal WWDT
+ *
+ * Copyright (C) 2022 - 2023, Advanced Micro Devices, Inc.
+ */
+
+#include <linux/clk.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/ioport.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/of_address.h>
+#include <linux/watchdog.h>
+
+#define XWWDT_DEFAULT_TIMEOUT	40
+#define XWWDT_MIN_TIMEOUT	1
+
+/* Register offsets for the WWDT device */
+#define XWWDT_MWR_OFFSET	0x00
+#define XWWDT_ESR_OFFSET	0x04
+#define XWWDT_FCR_OFFSET	0x08
+#define XWWDT_FWR_OFFSET	0x0c
+#define XWWDT_SWR_OFFSET	0x10
+
+/* Master Write Control Register Masks */
+#define XWWDT_MWR_MASK		BIT(0)
+
+/* Enable and Status Register Masks */
+#define XWWDT_ESR_WINT_MASK	BIT(16)
+#define XWWDT_ESR_WSW_MASK	BIT(8)
+#define XWWDT_ESR_WEN_MASK	BIT(0)
+
+#define XWWDT_CLOSE_WINDOW_PERCENT	50
+
+static int xwwdt_timeout;
+static int xclosed_window_percent;
+
+module_param(xwwdt_timeout, int, 0);
+MODULE_PARM_DESC(xwwdt_timeout,
+		 "Watchdog time in seconds. (default="
+		 __MODULE_STRING(XWWDT_DEFAULT_TIMEOUT) ")");
+module_param(xclosed_window_percent, int, 0);
+MODULE_PARM_DESC(xclosed_window_percent,
+		 "Watchdog closed window percentage. (default="
+		 __MODULE_STRING(XWWDT_CLOSE_WINDOW_PERCENT) ")");
+/**
+ * struct xwwdt_device - Watchdog device structure
+ * @base: base io address of WDT device
+ * @spinlock: spinlock for IO register access
+ * @xilinx_wwdt_wdd: watchdog device structure
+ * @freq: source clock frequency of WWDT
+ * @close_percent: Closed window percent
+ */
+struct xwwdt_device {
+	void __iomem *base;
+	spinlock_t spinlock; /* spinlock for register handling */
+	struct watchdog_device xilinx_wwdt_wdd;
+	unsigned long freq;
+	u32 close_percent;
+};
+
+static int xilinx_wwdt_start(struct watchdog_device *wdd)
+{
+	struct xwwdt_device *xdev = watchdog_get_drvdata(wdd);
+	struct watchdog_device *xilinx_wwdt_wdd = &xdev->xilinx_wwdt_wdd;
+	u64 time_out, closed_timeout, open_timeout;
+	u32 control_status_reg;
+
+	/* Calculate timeout count */
+	time_out = xdev->freq * wdd->timeout;
+
+	if (xdev->close_percent && xdev->close_percent < 100) {
+		closed_timeout = (time_out * xdev->close_percent) / 100;
+		open_timeout = time_out - closed_timeout;
+		wdd->min_hw_heartbeat_ms = xdev->close_percent * 10 * wdd->timeout;
+	} else {
+		/* Calculate XWWDT_CLOSE_WINDOW_PERCENT of timeout */
+		time_out *= XWWDT_CLOSE_WINDOW_PERCENT;
+		time_out /= 100;
+		wdd->min_hw_heartbeat_ms = XWWDT_CLOSE_WINDOW_PERCENT * 10 * wdd->timeout;
+	}
+
+	spin_lock(&xdev->spinlock);
+
+	iowrite32(XWWDT_MWR_MASK, xdev->base + XWWDT_MWR_OFFSET);
+	iowrite32(~(u32)XWWDT_ESR_WEN_MASK, xdev->base + XWWDT_ESR_OFFSET);
+
+	if (xdev->close_percent && xdev->close_percent < 100) {
+		iowrite32((u32)closed_timeout, xdev->base + XWWDT_FWR_OFFSET);
+		iowrite32((u32)open_timeout, xdev->base + XWWDT_SWR_OFFSET);
+	} else {
+		/* Configure closed and open windows with XWWDT_CLOSE_WINDOW_PERCENT of timeout */
+		iowrite32((u32)time_out, xdev->base + XWWDT_FWR_OFFSET);
+		iowrite32((u32)time_out, xdev->base + XWWDT_SWR_OFFSET);
+	}
+
+	/* Enable the window watchdog timer */
+	control_status_reg = ioread32(xdev->base + XWWDT_ESR_OFFSET);
+	control_status_reg |= XWWDT_ESR_WEN_MASK;
+	iowrite32(control_status_reg, xdev->base + XWWDT_ESR_OFFSET);
+
+	spin_unlock(&xdev->spinlock);
+
+	dev_dbg(xilinx_wwdt_wdd->parent, "Watchdog Started!\n");
+
+	return 0;
+}
+
+static int xilinx_wwdt_keepalive(struct watchdog_device *wdd)
+{
+	struct xwwdt_device *xdev = watchdog_get_drvdata(wdd);
+	u32 control_status_reg;
+
+	spin_lock(&xdev->spinlock);
+
+	/* Enable write access control bit for the window watchdog */
+	iowrite32(XWWDT_MWR_MASK, xdev->base + XWWDT_MWR_OFFSET);
+
+	/* Trigger restart kick to watchdog */
+	control_status_reg = ioread32(xdev->base + XWWDT_ESR_OFFSET);
+	control_status_reg |= XWWDT_ESR_WSW_MASK;
+	iowrite32(control_status_reg, xdev->base + XWWDT_ESR_OFFSET);
+
+	spin_unlock(&xdev->spinlock);
+
+	return 0;
+}
+
+static const struct watchdog_info xilinx_wwdt_ident = {
+	.options = WDIOF_KEEPALIVEPING |
+		WDIOF_SETTIMEOUT,
+	.firmware_version = 1,
+	.identity = "xlnx_window watchdog",
+};
+
+static const struct watchdog_ops xilinx_wwdt_ops = {
+	.owner = THIS_MODULE,
+	.start = xilinx_wwdt_start,
+	.ping = xilinx_wwdt_keepalive,
+};
+
+static int xwwdt_probe(struct platform_device *pdev)
+{
+	struct watchdog_device *xilinx_wwdt_wdd;
+	struct device *dev = &pdev->dev;
+	struct xwwdt_device *xdev;
+	struct clk *clk;
+	int ret;
+
+	xdev = devm_kzalloc(dev, sizeof(*xdev), GFP_KERNEL);
+	if (!xdev)
+		return -ENOMEM;
+
+	xilinx_wwdt_wdd = &xdev->xilinx_wwdt_wdd;
+	xilinx_wwdt_wdd->info = &xilinx_wwdt_ident;
+	xilinx_wwdt_wdd->ops = &xilinx_wwdt_ops;
+	xilinx_wwdt_wdd->parent = dev;
+
+	xdev->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(xdev->base))
+		return PTR_ERR(xdev->base);
+
+	clk = devm_clk_get_enabled(dev, NULL);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	xdev->freq = clk_get_rate(clk);
+	if (!xdev->freq)
+		return -EINVAL;
+
+	xilinx_wwdt_wdd->timeout = XWWDT_DEFAULT_TIMEOUT;
+	xilinx_wwdt_wdd->min_timeout = XWWDT_MIN_TIMEOUT;
+	xilinx_wwdt_wdd->max_hw_heartbeat_ms = 1000 * xilinx_wwdt_wdd->timeout;
+	xdev->close_percent = xclosed_window_percent;
+
+	ret = watchdog_init_timeout(xilinx_wwdt_wdd,
+				    xwwdt_timeout, &pdev->dev);
+	if (ret)
+		dev_info(&pdev->dev, "Configured default timeout value\n");
+
+	spin_lock_init(&xdev->spinlock);
+	watchdog_set_drvdata(xilinx_wwdt_wdd, xdev);
+	watchdog_set_nowayout(xilinx_wwdt_wdd, WATCHDOG_NOWAYOUT);
+
+	ret = devm_watchdog_register_device(dev, xilinx_wwdt_wdd);
+	if (ret)
+		return ret;
+
+	dev_info(dev, "Xilinx window watchdog Timer with timeout %ds\n",
+		 xilinx_wwdt_wdd->timeout);
+
+	return 0;
+}
+
+static const struct of_device_id xwwdt_of_match[] = {
+	{ .compatible = "xlnx,versal-wwdt", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, xwwdt_of_match);
+
+static struct platform_driver xwwdt_driver = {
+	.probe = xwwdt_probe,
+	.driver = {
+		.name = "Xilinx window watchdog",
+		.of_match_table = xwwdt_of_match,
+	},
+};
+
+module_platform_driver(xwwdt_driver);
+
+MODULE_AUTHOR("Neeli Srinivas <srinivas.neeli@amd.com>");
+MODULE_DESCRIPTION("Xilinx window watchdog driver");
+MODULE_LICENSE("GPL");
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 247986E9099
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 12:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235018AbjDTKnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 06:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234907AbjDTKnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 06:43:12 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F955BB4;
        Thu, 20 Apr 2023 03:42:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NaSavYKuB1VTYYYzeEKPUtt7OPGwULm8INAF0ZHfCWOHGaOsqjOuwxRNSJfpNd7SYKlJUBeOr9Qc+NvT0CRv9ObcsCAPK66xMFzJT0OTpnY+W8GRE0GIMGtroA0k+gHyqSf5UT7e8L70KWXK9V/qkSg9oMgwtykcIU3qMtTV8OaowX81yghfRyM5Mm7gzTRj3KyILWshiKFw5qHKCq91jkJNngyziQxGzavUDZPy5Z3iLSpoHHmrAQRD7cW7A/oi4NHGKHxMdkBv3TP24SubUuYUE7lMToPVNbrb/T6YjqZuXLe+GYheW5tqWvDVicNo3np0WNTA6L/0UCj+HbkhFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DZOiu4TTaPV1VIVOCcScNb52DkIinOzVWblp10jj9ws=;
 b=UyWNClZbb0SaNKRnAD3Ldh0lZt1/DbDHVYGkohr4IzPZiUqGGJZyO1hV3SJL3XuKQKRIP2TP3JsBhPt1/3E/nn6Zgsw9L2CBeb3ONfbx/V+1qwq8hI+37YW+7jUJQidoK48jbdtgBmmmpQTlINX0JplvfLDcuyQ3+PPDrT7Fyau58Vx/oRlV0aOmrOEoy3YWNQHN7kd5jeGE+F5HlgLFScvZiZmnxBqtQ89I20Sc+ssFrh7CdsoTWXFSBaWKpzIEGOxZGijDlmqsSo8bHWiN/ks04uEqh1Kx/ncRtTHnSaxYGrrrkFhO5w3qssa2vwvVsUbGreO/rla7VZp16wV7Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-watchdog.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DZOiu4TTaPV1VIVOCcScNb52DkIinOzVWblp10jj9ws=;
 b=2ElUIFPjdKf6HVFAm5CeA8m4X33EC4Sj8QK9q+nkRgeiVvShRNTG7kuiiEzbZip0AOmDQ6EMdA4L1sm1M4usPX8VCp0TCxHBojNaUATvW4TH2usZIvPoPDnyM/uLXh5pTtxgml+GwyubU8tthn9dfLYt0x31V6dS8y36MLgM/J4=
Received: from MW4PR03CA0255.namprd03.prod.outlook.com (2603:10b6:303:b4::20)
 by SN7PR12MB6768.namprd12.prod.outlook.com (2603:10b6:806:268::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Thu, 20 Apr
 2023 10:42:52 +0000
Received: from CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b4:cafe::d0) by MW4PR03CA0255.outlook.office365.com
 (2603:10b6:303:b4::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.25 via Frontend
 Transport; Thu, 20 Apr 2023 10:42:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT016.mail.protection.outlook.com (10.13.175.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6319.25 via Frontend Transport; Thu, 20 Apr 2023 10:42:51 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 20 Apr
 2023 05:42:50 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 20 Apr
 2023 03:42:49 -0700
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 20 Apr 2023 05:42:45 -0500
From:   Srinivas Neeli <srinivas.neeli@amd.com>
To:     <shubhrajyoti.datta@amd.com>, <michal.simek@amd.com>,
        <srinivas.goud@amd.com>, <wim@linux-watchdog.org>,
        <linux@roeck-us.net>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <srinivas.neeli@amd.com>, <linux-watchdog@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <git@amd.com>,
        <git@xilinx.com>, <neelisrinivas18@gmail.com>
Subject: [PATCH V4 3/4] watchdog: xilinx_wwdt: Add Versal window watchdog support
Date:   Thu, 20 Apr 2023 16:12:30 +0530
Message-ID: <20230420104231.2243079-4-srinivas.neeli@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230420104231.2243079-1-srinivas.neeli@amd.com>
References: <20230420104231.2243079-1-srinivas.neeli@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT016:EE_|SN7PR12MB6768:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d201c38-481a-42cd-c6b0-08db418bfda7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UxN3uxuR5bJMDaWcRTVkjx1jKpKrhZum38J98O9MCsVf1zKBzcbuOWI6oJqBo5eyu+HKIN98jtvE0BwOynM98ORCxo7z5Rp9sAX1fY9PzHalpQIDjGzoRtZnAZ1WjXfnHHo4lf7JRXtWX3mju5f6WnmujMTW5+rxDv5UwP+MI6JdaTM5iR/bq0Ljna9sYtKAQP66pRZ+sYA4xugAkpjAj5Hld0HyNbl+0/eyy+JV/vcQxiSNi3h1LpEzdzocyxMRTXArBrj7ofv9EMcL7ETtmb7YLkuqbBGy7SfcoEUHJINbtBDgYekDmcK5bX+mwHI3HYUItEmIYzl2Z0sS1dtcr/ktBvPOMox2cZYZ86r8umUeRFsrZ0YsUu+DSC3+InCpB2J3+rXS0VQZKTx+GVzHIvI3n0nGv3RC+T9AY+JFZGr24jPCOmO2Iej5uM7d74jLWeNC5r6koYyXMb8Fv0yVQARH9vH0GiBbgsijDlxYG6WrN4QcgS5e8NEaSJKADq2RRuP6889oAK/jrt3w46fSB417E+r7QBVqucEdkdCGZwxDT1rlpKDFyUovvt+hi+InqZYIXdMN+8MnddbUrhVaTt5AxNEfjwiyGFMxMft2cjNASHWrM1tE5+5ko9aRpPDQyYao+wt9VPXlLcxejg9g4jpQKe9FIVGWJTEZi6260PDWFJkb8xUhgIXhmTOTtZ/Fi0vp8/a1pJiqvTgktS5iTQ8u/z8517vvgoyiEhFLOIM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(346002)(136003)(451199021)(46966006)(36840700001)(40470700004)(478600001)(6666004)(8936002)(8676002)(316002)(41300700001)(82740400003)(4326008)(70206006)(70586007)(40480700001)(54906003)(110136005)(81166007)(356005)(186003)(40460700003)(2906002)(36756003)(426003)(83380400001)(1076003)(26005)(86362001)(336012)(47076005)(82310400005)(36860700001)(5660300002)(2616005)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 10:42:51.3229
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d201c38-481a-42cd-c6b0-08db418bfda7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6768
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
Changes in V4:
-Maximum timeout value calculated at 100Mhz source clock. This value
 vary depending on the source clock to IP.
-Removed module parameters prefix("x").
-Moved closed window percent check to the probe fucntion and updated
 dependent code.
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
 drivers/watchdog/xilinx_wwdt.c | 201 +++++++++++++++++++++++++++++++++
 3 files changed, 220 insertions(+)
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
index 000000000000..2585038d5575
--- /dev/null
+++ b/drivers/watchdog/xilinx_wwdt.c
@@ -0,0 +1,201 @@
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
+/* Max timeout is calculated at 100MHz source clock */
+#define XWWDT_DEFAULT_TIMEOUT	42
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
+static int wwdt_timeout;
+static int closed_window_percent;
+
+module_param(wwdt_timeout, int, 0);
+MODULE_PARM_DESC(wwdt_timeout,
+		 "Watchdog time in seconds. (default="
+		 __MODULE_STRING(XWWDT_DEFAULT_TIMEOUT) ")");
+module_param(closed_window_percent, int, 0);
+MODULE_PARM_DESC(closed_window_percent,
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
+	closed_timeout = (time_out * xdev->close_percent) / 100;
+	open_timeout = time_out - closed_timeout;
+	wdd->min_hw_heartbeat_ms = xdev->close_percent * 10 * wdd->timeout;
+
+	spin_lock(&xdev->spinlock);
+
+	iowrite32(XWWDT_MWR_MASK, xdev->base + XWWDT_MWR_OFFSET);
+	iowrite32(~(u32)XWWDT_ESR_WEN_MASK, xdev->base + XWWDT_ESR_OFFSET);
+	iowrite32((u32)closed_timeout, xdev->base + XWWDT_FWR_OFFSET);
+	iowrite32((u32)open_timeout, xdev->base + XWWDT_SWR_OFFSET);
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
+	xilinx_wwdt_wdd->min_timeout = XWWDT_MIN_TIMEOUT;
+	xilinx_wwdt_wdd->timeout = XWWDT_DEFAULT_TIMEOUT;
+	xilinx_wwdt_wdd->max_hw_heartbeat_ms = 1000 * xilinx_wwdt_wdd->timeout;
+
+	if (closed_window_percent == 0 || closed_window_percent >= 100)
+		xdev->close_percent = XWWDT_CLOSE_WINDOW_PERCENT;
+	else
+		xdev->close_percent = closed_window_percent;
+
+	watchdog_init_timeout(xilinx_wwdt_wdd, wwdt_timeout, &pdev->dev);
+	spin_lock_init(&xdev->spinlock);
+	watchdog_set_drvdata(xilinx_wwdt_wdd, xdev);
+	watchdog_set_nowayout(xilinx_wwdt_wdd, 1);
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


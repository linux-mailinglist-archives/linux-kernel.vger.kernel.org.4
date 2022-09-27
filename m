Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0202C5EC074
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 13:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbiI0LF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 07:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbiI0LEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 07:04:43 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2077.outbound.protection.outlook.com [40.107.95.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39FB512205A;
        Tue, 27 Sep 2022 04:04:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AzNOm7aMEy1zO6zExADW+e1zbSWAeDZ34o/GDyKBweUqwASjruiEM6jrZOwktI7V8L4BYtLmx5bW2yLIkSuVc+NrLs6RM2gJa8FVtQkKYnfdpPD+FkM6IgUKUmAqc9HdZnw0Pf+DSpf2Y6esnUshmSHD01syvaTDX/GJwd5gAJHfhG9xUFc2zEvIvJ8DzjirDvVjFXQMsqS0e85SKD5XhV17qHFKiFk/vsFYuAEljBFvrhd/XVHly8bGENP2VNizlgOFIhZAwn/eA/NZro7i2cFsiDgvwNNdf4zHg/wAXO1HmQdRS2Msmz/s50o+HbqTsGfzbq1EMr+S5qS4FzGnZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N7+AwU7/63JwDN35M7yVVgLVCrJhjSvPxLN8Suyk2EQ=;
 b=MkWLCVdWOyzkvjlhwJ4v5KJ8T7Zb9zVsDdqmBK41xvlucf5Sq7TMzAuBQcDpSOCiCFoa5IPxSn8KEX2LVU5BoOaXBO1ejRmzd3R9nhWIK70PS2SNzgnvtDLNBB86h/xE13v8mIDN8TsZUMyU10+M1ZtuXCWtP0Xr9faBmsLDZKmxJstEOcG7zuLmLLUxP68KTy3hVYLxajchCHhVB2iuQYKqZT+abHmCtexrAPc8vdSxvK7rf/PG22IwK6fX03/Q09rk9YpiWFx2v0v9pWhDrcrpTlCINsl9cIPXKVgio8t41boTe9PqQR2/7xBPr+0dyA7tX4Wp+bHu5ApLXHNJLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-watchdog.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N7+AwU7/63JwDN35M7yVVgLVCrJhjSvPxLN8Suyk2EQ=;
 b=LWL8MYkdYdIoa0JBPM/knfmYXxQIx+M9QkYqe4DAaIj3LPokdh9v+bZcW1caJ7suG7gZkRYFp0j1zE5cbLN5LUSqqQZJdT3OVRQLPW5ebf+ZyfatDHRh8pdmCuXpRQS97damZ9t891yEHSjdN25Z38OWzEQZZUNtoPDfA9XeZpU=
Received: from BN0PR07CA0004.namprd07.prod.outlook.com (2603:10b6:408:141::22)
 by CH2PR12MB4183.namprd12.prod.outlook.com (2603:10b6:610:7a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Tue, 27 Sep
 2022 11:03:35 +0000
Received: from BN8NAM11FT090.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:141:cafe::30) by BN0PR07CA0004.outlook.office365.com
 (2603:10b6:408:141::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26 via Frontend
 Transport; Tue, 27 Sep 2022 11:03:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT090.mail.protection.outlook.com (10.13.177.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Tue, 27 Sep 2022 11:03:34 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 27 Sep
 2022 06:03:34 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 27 Sep
 2022 06:03:33 -0500
Received: from xhdsneeli40u.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 27 Sep 2022 06:03:30 -0500
From:   Srinivas Neeli <srinivas.neeli@amd.com>
To:     <wim@linux-watchdog.org>, <linux@roeck-us.net>,
        <srinivas.neeli@amd.com>, <shubhrajyoti.datta@amd.com>,
        <michal.simek@amd.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-watchdog@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <git@amd.com>
Subject: [PATCH 2/3] watchdog: xilinx_wwdt: Add Versal window watchdog support
Date:   Tue, 27 Sep 2022 16:32:56 +0530
Message-ID: <20220927110257.41963-3-srinivas.neeli@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220927110257.41963-1-srinivas.neeli@amd.com>
References: <20220927110257.41963-1-srinivas.neeli@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT090:EE_|CH2PR12MB4183:EE_
X-MS-Office365-Filtering-Correlation-Id: d25ebfe6-6855-44e6-d70f-08daa077ec18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8goQWoADP+6pYJXyhiSNI1Bo1L4i4vLizYkqF9YEkBiXBeKCFXGpTOcrimjo+cnTj0xw3ROI7/p65Vq7pPwXujaMxCJ+hwGfoK0oFtlkAbc+7IpMn3rSp1dRnxFwLM/ko0BOEaec49w1LKD0RpYk1X1QjLwILeA6dg+KdH02yxpRMqni+FzGIPv2otbScwoWz1kMvqmnLvTW9aaISWD+ZHqfHUXqFxL+B/jF5ZT5ivEmwCi8e0RoeE5HU01pEe2hnD1gzrpZIsgnNbCNJzWOeJwac/yUpl9VO56uTPi9mH1dVqOAba5NBgQGBeTrNkmryjN6xMYEZY7KZaO4PkpCpi9HC4GM7ZhLk9oEM6e3d/if0M973pg3UUbMuOZZ2bY9GzWCP3QI3gQ2n7/Wh5bFh2HsiUZ15c2SF/1iGoUz84GPsmqmf7s/NVPib4HSRUe+yPn5OUBN+iRDnt07SWLQZdahpo3D207wx5M6LQ9p+cb1nxiLyGaKb0k/uraKLwFvzGiG4xpP4Lsn+t5ec9cAP84jHRjGey3SmGYWmP4/DRCqoX+UaVkaMtJV/CzmDZhHRRs0/7dSTuprZ20S/EFWxxlqbF8EVlC88J0fIxNywOP6k35dDikrjycFBveXTVzNuyIHeQbvt3mDOleQIPBoYWyyv5UZ4TFaPVll0EjvG91Ec5cH5j3Yhss+S+tcrWAZNS0D/WQ5Ax1em1Dg5qwazcwWDOGpN1mozhKW9Pmlw21wa3RShuXeG3Wqt76LjVtKXpdbwUc163aOkoj5Dx0Qu2ii7Gw+ykAUoalMGShWs6M4TUztHxk6cQoOQ/xc+IIs
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(39860400002)(376002)(346002)(451199015)(40470700004)(46966006)(36840700001)(8936002)(356005)(426003)(30864003)(5660300002)(40460700003)(2906002)(86362001)(44832011)(41300700001)(336012)(26005)(47076005)(186003)(83380400001)(478600001)(2616005)(6666004)(1076003)(70586007)(4326008)(81166007)(82740400003)(70206006)(316002)(8676002)(54906003)(110136005)(36860700001)(82310400005)(40480700001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 11:03:34.8324
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d25ebfe6-6855-44e6-d70f-08daa077ec18
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT090.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4183
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
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
 drivers/watchdog/Kconfig       |  17 ++
 drivers/watchdog/Makefile      |   1 +
 drivers/watchdog/xilinx_wwdt.c | 286 +++++++++++++++++++++++++++++++++
 3 files changed, 304 insertions(+)
 create mode 100644 drivers/watchdog/xilinx_wwdt.c

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 688922fc4edb..9822e471b9f0 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -304,6 +304,23 @@ config XILINX_WATCHDOG
 	  To compile this driver as a module, choose M here: the
 	  module will be called of_xilinx_wdt.
 
+config XILINX_WINDOW_WATCHDOG
+	tristate "Xilinx window watchdog timer"
+	depends on HAS_IOMEM
+	select WATCHDOG_CORE
+	help
+	  Window watchdog driver for the versal_wwdt ip core.
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
index cdeb119e6e61..4ff96c517407 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -155,6 +155,7 @@ obj-$(CONFIG_M54xx_WATCHDOG) += m54xx_wdt.o
 
 # MicroBlaze Architecture
 obj-$(CONFIG_XILINX_WATCHDOG) += of_xilinx_wdt.o
+obj-$(CONFIG_XILINX_WINDOW_WATCHDOG) += xilinx_wwdt.o
 
 # MIPS Architecture
 obj-$(CONFIG_ATH79_WDT) += ath79_wdt.o
diff --git a/drivers/watchdog/xilinx_wwdt.c b/drivers/watchdog/xilinx_wwdt.c
new file mode 100644
index 000000000000..2594a01c2764
--- /dev/null
+++ b/drivers/watchdog/xilinx_wwdt.c
@@ -0,0 +1,286 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Window watchdog device driver for Xilinx Versal WWDT
+ *
+ * Copyright (C) 2022, Advanced Micro Devices, Inc.
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
+#define XWWDT_MAX_TIMEOUT	42
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
+#define XWWDT_PERCENT		50
+
+static int xwwdt_timeout;
+static int xclosed_window_percent;
+
+module_param(xwwdt_timeout, int, 0644);
+MODULE_PARM_DESC(xwwdt_timeout,
+		 "Watchdog time in seconds. (default="
+		 __MODULE_STRING(XWWDT_DEFAULT_TIMEOUT) ")");
+module_param(xclosed_window_percent, int, 0644);
+MODULE_PARM_DESC(xclosed_window_percent,
+		 "Watchdog closed window percentage. (default="
+		 __MODULE_STRING(XWWDT_PERCENT) ")");
+
+/**
+ * struct xwwdt_device - Watchdog device structure
+ * @base: base io address of WDT device
+ * @spinlock: spinlock for IO register access
+ * @xilinx_wwdt_wdd: watchdog device structure
+ * @clk: struct clk * of a clock source
+ * @freq: source clock frequency of WWDT
+ */
+struct xwwdt_device {
+	void __iomem *base;
+	spinlock_t spinlock; /* spinlock for register handling */
+	struct watchdog_device xilinx_wwdt_wdd;
+	struct clk *clk;
+	unsigned long	freq;
+};
+
+static bool is_wwdt_in_closed_window(struct watchdog_device *wdd)
+{
+	struct xwwdt_device *xdev = watchdog_get_drvdata(wdd);
+	u32 csr, ret;
+
+	csr = ioread32(xdev->base + XWWDT_ESR_OFFSET);
+
+	ret = (csr & XWWDT_ESR_WEN_MASK) ? !(csr & XWWDT_ESR_WSW_MASK) ? 0 : 1 : 1;
+
+	return ret;
+}
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
+	if (xclosed_window_percent) {
+		closed_timeout = (time_out * xclosed_window_percent) / 100;
+		open_timeout = time_out - closed_timeout;
+		wdd->min_hw_heartbeat_ms = xclosed_window_percent * 10 * wdd->timeout;
+	} else {
+		/* Calculate 50% of timeout */
+		time_out *= XWWDT_PERCENT;
+		time_out /= 100;
+		wdd->min_hw_heartbeat_ms = XWWDT_PERCENT * 10 * wdd->timeout;
+	}
+
+	spin_lock(&xdev->spinlock);
+
+	iowrite32(XWWDT_MWR_MASK, xdev->base + XWWDT_MWR_OFFSET);
+	iowrite32(~(u32)XWWDT_ESR_WEN_MASK, xdev->base + XWWDT_ESR_OFFSET);
+
+	if (xclosed_window_percent) {
+		iowrite32((u32)closed_timeout, xdev->base + XWWDT_FWR_OFFSET);
+		iowrite32((u32)open_timeout, xdev->base + XWWDT_SWR_OFFSET);
+	} else {
+		/* Configure closed and open windows with 50% of timeout */
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
+static int xilinx_wwdt_set_timeout(struct watchdog_device *wdd,
+				   unsigned int new_time)
+{
+	struct xwwdt_device *xdev = watchdog_get_drvdata(wdd);
+	struct watchdog_device *xilinx_wwdt_wdd = &xdev->xilinx_wwdt_wdd;
+
+	if (watchdog_active(xilinx_wwdt_wdd))
+		return -EPERM;
+
+	wdd->timeout = new_time;
+
+	return 0;
+}
+
+static int xilinx_wwdt_stop(struct watchdog_device *wdd)
+{
+	struct xwwdt_device *xdev = watchdog_get_drvdata(wdd);
+	struct watchdog_device *xilinx_wwdt_wdd = &xdev->xilinx_wwdt_wdd;
+
+	if (watchdog_active(xilinx_wwdt_wdd)) {
+		if (!is_wwdt_in_closed_window(wdd)) {
+			dev_warn(xilinx_wwdt_wdd->parent, "timer in closed window");
+			return -EPERM;
+		}
+	}
+
+	spin_lock(&xdev->spinlock);
+
+	iowrite32(XWWDT_MWR_MASK, xdev->base + XWWDT_MWR_OFFSET);
+
+	/* Disable the Window watchdog timer */
+	iowrite32(~(u32)XWWDT_ESR_WEN_MASK, xdev->base + XWWDT_ESR_OFFSET);
+
+	spin_unlock(&xdev->spinlock);
+
+	clk_disable(xdev->clk);
+
+	dev_dbg(xilinx_wwdt_wdd->parent, "Watchdog Stopped!\n");
+
+	return 0;
+}
+
+static void xwwdt_clk_disable_unprepare(void *data)
+{
+	clk_disable_unprepare(data);
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
+	.stop = xilinx_wwdt_stop,
+	.set_timeout = xilinx_wwdt_set_timeout,
+	.ping = xilinx_wwdt_keepalive,
+};
+
+static int xwwdt_probe(struct platform_device *pdev)
+{
+	struct watchdog_device *xilinx_wwdt_wdd;
+	struct device *dev = &pdev->dev;
+	struct xwwdt_device *xdev;
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
+	xdev->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(xdev->clk))
+		return PTR_ERR(xdev->clk);
+
+	xdev->freq = clk_get_rate(xdev->clk);
+	if (!xdev->freq)
+		return -EINVAL;
+
+	ret = clk_prepare_enable(xdev->clk);
+	if (ret) {
+		dev_err(dev, "unable to enable clock\n");
+		return ret;
+	}
+
+	ret = devm_add_action_or_reset(dev, xwwdt_clk_disable_unprepare,
+				       xdev->clk);
+	if (ret)
+		return ret;
+
+	xilinx_wwdt_wdd->timeout = XWWDT_DEFAULT_TIMEOUT;
+	xilinx_wwdt_wdd->min_timeout = XWWDT_MIN_TIMEOUT;
+	xilinx_wwdt_wdd->max_timeout = XWWDT_MAX_TIMEOUT;
+
+	ret = watchdog_init_timeout(xilinx_wwdt_wdd,
+				    xwwdt_timeout, &pdev->dev);
+	if (ret)
+		dev_info(&pdev->dev, "Configured default timeout value\n");
+
+	spin_lock_init(&xdev->spinlock);
+	watchdog_set_drvdata(xilinx_wwdt_wdd, xdev);
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
+	{ .compatible = "xlnx,versal-wwdt-1.0", },
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
2.17.1


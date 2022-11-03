Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F07661799C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 10:16:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbiKCJQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 05:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbiKCJQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 05:16:05 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 650DC1055C;
        Thu,  3 Nov 2022 02:15:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CKluBpEiUcENWrFzkMdTu7ldAkItudP7qa4WrXPDshsWjeTCL4T1eCRA9nuK+04Ub3W/ZVz8Y85JmTSNlxMH+UzjI+GOowOxdV5XfxVMvfb3lF+/XUySFcCoZhmW58QveXSVD9gyBFOnlIpbfbMU0xS3nT5EyEeeXg/mNcfwEPtL4eYOirkHdhjDckM0/nAdAaZjnf58nw9Yg928kUAPBHBdOhhudG8XBjw2/cGC6FgXNmzLDutVvYD+71KwPXkjUP33ozOFYbuecd+gR1bgh0+oCnhyCGx6nk0tB5JNq6F4E6bDC9aHdF8KAF4VTQkUaeNje5qDgPZUjtVk7/4mCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ja4XXTauCBesW80bAsQSj0tNwF8nHtyD1Zo6x92Lfkg=;
 b=aLyICLIB33AFRoVdRqYOK4EDbth1Bg9v30Mkpc9fRwk9ijIT0bIVnN/xqd+S9KfXCdWIuHtfgsD7e8XcD3su0ypYbB2/JV5Sb5DEJvvzS6TNvufL+vgF7SMQbeClbXg6czxQcNA6SLRK0gzlgeNw3OaByedB6MmXzSDNFyUSkOjnlLS37ogZbHGjKeezaVZLoydQHXJy7NhCRnNMBTUUCOudR41nQUwZslXEBdeimRWw77PTK/5Nct/YNJv9GX7BuEAHZ3WezaOUa6qV+UYnP08hVVYfLkNQWiG9k7u9pW3/Ek+eouI9v24tm42Rsg3u8Gc5rNczpNiOCXt/UTjK1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ja4XXTauCBesW80bAsQSj0tNwF8nHtyD1Zo6x92Lfkg=;
 b=vctzCqqAp3IH8DzIpMGHsSEBzKVT2GP5ZMDxBIBOCJdH2yu92VWDRrilSJQLVIzIIjF4PIunYvfTs2YDhaNJVX8e34rNBetpA0lIJHOpyhBhNPoVRD3Hh6xIlf3VRKD13nIIQIbx+bWBkyHYQWN86/4FE17+cpRnjFVZAYY1ow0=
Received: from BN9PR03CA0077.namprd03.prod.outlook.com (2603:10b6:408:fc::22)
 by BL1PR12MB5379.namprd12.prod.outlook.com (2603:10b6:208:317::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Thu, 3 Nov
 2022 09:15:12 +0000
Received: from BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::97) by BN9PR03CA0077.outlook.office365.com
 (2603:10b6:408:fc::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22 via Frontend
 Transport; Thu, 3 Nov 2022 09:15:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT020.mail.protection.outlook.com (10.13.176.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.20 via Frontend Transport; Thu, 3 Nov 2022 09:15:11 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 3 Nov
 2022 04:15:10 -0500
From:   Appana Durga Kedareswara rao 
        <appana.durga.kedareswara.rao@amd.com>
To:     <appanad@amd.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <appana.durga.rao@xilinx.com>,
        <michal.simek@xilinx.com>, <derek.kiernan@xilinx.com>,
        <dragan.cvetic@xilinx.com>, <arnd@arndb.de>,
        <gregkh@linuxfoundation.org>
CC:     <linux-arm-kernel@lists.infradead.org>, <git@amd.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v6 2/4] drivers: misc: Add Support for TMR Manager
Date:   Thu, 3 Nov 2022 14:44:58 +0530
Message-ID: <20221103091500.3022212-3-appana.durga.kedareswara.rao@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221103091500.3022212-1-appana.durga.kedareswara.rao@amd.com>
References: <20221103091500.3022212-1-appana.durga.kedareswara.rao@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT020:EE_|BL1PR12MB5379:EE_
X-MS-Office365-Filtering-Correlation-Id: 55aadd53-aad3-4585-2abd-08dabd7be961
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hMbiBFpP2Cug0bXXsekZE0E5YzGTiBx2duudtLYqltuWcTIfIJ6H8/TCk0Agca8El5lzDk9fTCzX0pIeiImt9fGKZz3PLBUeIBYuSOtVJmLN0AwMD/GweT+4OMLoNBRgMrdQ2HtlI+RAomwV/Cjt/CJFbgMdvCL3Va/p4eqgWZ+RnA6QrvVtV+wXKPr9kkr++BnbCBTLBJ5gRrOzwhAHxJzfMdcw4rQiCDXrfrPK5/ppWEvp5yyWptEDkb57QlkKpGZwto5LZ1fpR8bHQCijxo3CdEPyuPIaXoFM2h61/BGvqORmrvXKI1PvXiFq9GDHdYupdze4Lj+xn8QGpMEO3ZQiUBNgG3VplcpzsoFsfoJSusDXmsKnoErAFchQNgXPHVFA4h7Gm8cn488lDOUx14g1Fwyj6DaFMYWfKbeGANoEueG6O8Zl7x98WmaJILFP3MS/ILZDJMPpNQdg9zNxeC8QMnnYph40ubc0ZVg5mLkc6RW/V17r73cegG9XRb+p8H8EI8p83gZ9YMJsaD4ZKkoZEvJLwBxRJZo8VU0t0qK6vAt5S2Mqz2k9aOxFatLVdIUlW2aEDl8hOgYx509MjKpfvKSNkpT9mxq+d310XPeFEzdsLQJspXHRwXtnu4wgQWxUT2HtWpT5b0Ftwk6gNwX21ymQjIKoxusBOtxp3dSrmuLQmtpWoiSCUa7m2STNE8SVKUdpA9gKIe8KitvkpOK0l93K4kTeqjLDK3nZ8Qu/WB3iCnGEUyGvPT4RrgffNYKcnmSw7jrqRG+X/q5N1TxUlOpwCCOMVJ4bxsnp4XV6X7MVf9FLUyKoIshdmx0RmZg4VW5aDPo0nsg6RLr1Y8Jgd8WDPqtHHiRKZEfh87E=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(346002)(39860400002)(136003)(451199015)(36840700001)(40470700004)(46966006)(82740400003)(40460700003)(36860700001)(316002)(54906003)(8676002)(110136005)(86362001)(103116003)(4326008)(16526019)(81166007)(921005)(356005)(1076003)(26005)(83380400001)(8936002)(186003)(426003)(478600001)(966005)(6666004)(2616005)(336012)(70206006)(41300700001)(70586007)(82310400005)(30864003)(2906002)(47076005)(5660300002)(40480700001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2022 09:15:11.9964
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55aadd53-aad3-4585-2abd-08dabd7be961
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5379
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Triple Modular Redundancy(TMR) subsystem contains three microblaze cores,
subsystem is fault-tolerant and continues to operate nominally after
encountering an error. Together with the capability to detect and recover
from errors, the implementation ensures the reliability of the entire
subsystem.  TMR Manager is responsible for performing recovery of the
subsystem detects the fault via a break signal it invokes microblaze
software break handler which calls the tmr manager driver api to
update the error count and status, added support for fault detection
feature via sysfs interface.

Usage:
To know the break handler count(Error count):
cat /sys/devices/platform/amba_pl/44a10000.tmr_manager/errcnt

Signed-off-by: Appana Durga Kedareswara rao <appana.durga.kedareswara.rao@amd.com>
Reported-by: kernel test robot <lkp@intel.com>
---
Changes for v6:
--> None.
Changes for v5:
--> Fixed Unexpected indentation htmldoc warning in
sysfs-driver-xilinx-tmr-manager.
--> Removed sysfs references from the Kconfig description.
Changes for v4:
--> None.
Changes for v3:
--> Added Krzysztof Reviewed by.
Changes for v2:
--> Added minimum and maximum values for xlnx,magic1 property as
suggested by Michal.
--> Fixed 80 char limit in description as suggested by Michal.

 .../testing/sysfs-driver-xilinx-tmr-manager   |  16 ++
 MAINTAINERS                                   |   7 +
 drivers/misc/Kconfig                          |  10 +
 drivers/misc/Makefile                         |   1 +
 drivers/misc/xilinx_tmr_manager.c             | 220 ++++++++++++++++++
 5 files changed, 254 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-xilinx-tmr-manager
 create mode 100644 drivers/misc/xilinx_tmr_manager.c

diff --git a/Documentation/ABI/testing/sysfs-driver-xilinx-tmr-manager b/Documentation/ABI/testing/sysfs-driver-xilinx-tmr-manager
new file mode 100644
index 000000000000..57b9b68a73ee
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-driver-xilinx-tmr-manager
@@ -0,0 +1,16 @@
+What:          /sys/devices/platform/amba_pl/<dev>/errcnt
+Date:          Nov 2022
+Contact:       appana.durga.kedareswara.rao@amd.com
+Description:   This control file provides the fault detection count.
+               This file cannot be written.
+               Example:
+               # cat /sys/devices/platform/amba_pl/44a10000.tmr_manager/errcnt
+               1
+
+What:          /sys/devices/platform/amba_pl/<dev>/dis_block_break
+Date:          Nov 2022
+Contact:       appana.durga.kedareswara.rao@amd.com
+Description:   Write any value to it, This control file enables the break signal.
+               This file is write only.
+               Example:
+               # echo <any value> > /sys/devices/platform/amba_pl/44a10000.tmr_manager/dis_block_break
diff --git a/MAINTAINERS b/MAINTAINERS
index 9774e7b07faf..58e165c44019 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13418,6 +13418,13 @@ W:	http://www.monstr.eu/fdt/
 T:	git git://git.monstr.eu/linux-2.6-microblaze.git
 F:	arch/microblaze/
 
+MICROBLAZE TMR MANAGER
+M:	Appana Durga Kedareswara rao <appana.durga.kedareswara.rao@amd.com>
+S:	Supported
+F:	Documentation/ABI/testing/sysfs-driver-xilinx-tmr-manager
+F:	Documentation/devicetree/bindings/misc/xlnx,tmr-manager.yaml
+F:	drivers/misc/xilinx_tmr_manager.c
+
 MICROCHIP AT91 DMA DRIVERS
 M:	Ludovic Desroches <ludovic.desroches@microchip.com>
 M:	Tudor Ambarus <tudor.ambarus@microchip.com>
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 358ad56f6524..a61445008f9e 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -496,6 +496,16 @@ config VCPU_STALL_DETECTOR
 
 	  If you do not intend to run this kernel as a guest, say N.
 
+config TMR_MANAGER
+	tristate "Select TMR Manager"
+	depends on MICROBLAZE && MB_MANAGER
+	help
+	  This option enables the driver developed for TMR Manager.
+	  The Triple Modular Redundancy(TMR) manager provides support for
+	  fault detection.
+
+	  Say N here unless you know what you are doing.
+
 source "drivers/misc/c2port/Kconfig"
 source "drivers/misc/eeprom/Kconfig"
 source "drivers/misc/cb710/Kconfig"
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index ac9b3e757ba1..b93b782a52f4 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -62,3 +62,4 @@ obj-$(CONFIG_HI6421V600_IRQ)	+= hi6421v600-irq.o
 obj-$(CONFIG_OPEN_DICE)		+= open-dice.o
 obj-$(CONFIG_GP_PCI1XXXX)	+= mchp_pci1xxxx/
 obj-$(CONFIG_VCPU_STALL_DETECTOR)	+= vcpu_stall_detector.o
+obj-$(CONFIG_TMR_MANAGER)      += xilinx_tmr_manager.o
diff --git a/drivers/misc/xilinx_tmr_manager.c b/drivers/misc/xilinx_tmr_manager.c
new file mode 100644
index 000000000000..535f723c1a5a
--- /dev/null
+++ b/drivers/misc/xilinx_tmr_manager.c
@@ -0,0 +1,220 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx TMR Subsystem.
+ *
+ * Copyright (C) 2022 Xilinx, Inc.
+ *
+ * Description:
+ * This driver is developed for TMR Manager,The Triple Modular Redundancy(TMR)
+ * Manager is responsible for handling the TMR subsystem state, including
+ * fault detection and error recovery. The core is triplicated in each of
+ * the sub-blocks in the TMR subsystem, and provides majority voting of
+ * its internal state provides soft error detection, correction and
+ * recovery.
+ */
+
+#include <asm/xilinx_mb_manager.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+
+/* TMR Manager Register offsets */
+#define XTMR_MANAGER_CR_OFFSET		0x0
+#define XTMR_MANAGER_FFR_OFFSET		0x4
+#define XTMR_MANAGER_CMR0_OFFSET	0x8
+#define XTMR_MANAGER_CMR1_OFFSET	0xC
+#define XTMR_MANAGER_BDIR_OFFSET	0x10
+#define XTMR_MANAGER_SEMIMR_OFFSET	0x1C
+
+/* Register Bitmasks/shifts */
+#define XTMR_MANAGER_CR_MAGIC1_MASK	GENMASK(7, 0)
+#define XTMR_MANAGER_CR_MAGIC2_MASK	GENMASK(15, 8)
+#define XTMR_MANAGER_CR_RIR_MASK	BIT(16)
+#define XTMR_MANAGER_FFR_LM12_MASK	BIT(0)
+#define XTMR_MANAGER_FFR_LM13_MASK	BIT(1)
+#define XTMR_MANAGER_FFR_LM23_MASK	BIT(2)
+
+#define XTMR_MANAGER_CR_MAGIC2_SHIFT	4
+#define XTMR_MANAGER_CR_RIR_SHIFT	16
+#define XTMR_MANAGER_CR_BB_SHIFT	18
+
+#define XTMR_MANAGER_MAGIC1_MAX_VAL	255
+
+/**
+ * struct xtmr_manager_dev - Driver data for TMR Manager
+ * @regs: device physical base address
+ * @cr_val: control register value
+ * @magic1: Magic 1 hardware configuration value
+ * @err_cnt: error statistics count
+ * @phys_baseaddr: Physical base address
+ */
+struct xtmr_manager_dev {
+	void __iomem *regs;
+	u32 cr_val;
+	u32 magic1;
+	u32 err_cnt;
+	resource_size_t phys_baseaddr;
+};
+
+/* IO accessors */
+static inline void xtmr_manager_write(struct xtmr_manager_dev *xtmr_manager,
+				      u32 addr, u32 value)
+{
+	iowrite32(value, xtmr_manager->regs + addr);
+}
+
+static inline u32 xtmr_manager_read(struct xtmr_manager_dev *xtmr_manager,
+				    u32 addr)
+{
+	return ioread32(xtmr_manager->regs + addr);
+}
+
+static void xmb_manager_reset_handler(struct xtmr_manager_dev *xtmr_manager)
+{
+	/* Clear the FFR Register contents as a part of recovery process. */
+	xtmr_manager_write(xtmr_manager, XTMR_MANAGER_FFR_OFFSET, 0);
+}
+
+static void xmb_manager_update_errcnt(struct xtmr_manager_dev *xtmr_manager)
+{
+	xtmr_manager->err_cnt++;
+}
+
+static ssize_t errcnt_show(struct device *dev, struct device_attribute *attr,
+			   char *buf)
+{
+	struct xtmr_manager_dev *xtmr_manager = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%x\n", xtmr_manager->err_cnt);
+}
+static DEVICE_ATTR_RO(errcnt);
+
+static ssize_t dis_block_break_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t size)
+{
+	struct xtmr_manager_dev *xtmr_manager = dev_get_drvdata(dev);
+	int ret;
+	long value;
+
+	ret = kstrtoul(buf, 16, &value);
+	if (ret)
+		return ret;
+
+	/* unblock the break signal*/
+	xtmr_manager->cr_val &= ~(1 << XTMR_MANAGER_CR_BB_SHIFT);
+	xtmr_manager_write(xtmr_manager, XTMR_MANAGER_CR_OFFSET,
+			   xtmr_manager->cr_val);
+	return size;
+}
+static DEVICE_ATTR_WO(dis_block_break);
+
+static struct attribute *xtmr_manager_dev_attrs[] = {
+	&dev_attr_dis_block_break.attr,
+	&dev_attr_errcnt.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(xtmr_manager_dev);
+
+static void xtmr_manager_init(struct xtmr_manager_dev *xtmr_manager)
+{
+	/* Clear the SEM interrupt mask register to disable the interrupt */
+	xtmr_manager_write(xtmr_manager, XTMR_MANAGER_SEMIMR_OFFSET, 0);
+
+	/* Allow recovery reset by default */
+	xtmr_manager->cr_val = (1 << XTMR_MANAGER_CR_RIR_SHIFT) |
+				xtmr_manager->magic1;
+	xtmr_manager_write(xtmr_manager, XTMR_MANAGER_CR_OFFSET,
+			   xtmr_manager->cr_val);
+	/*
+	 * Configure Break Delay Initialization Register to zero so that
+	 * break occurs immediately
+	 */
+	xtmr_manager_write(xtmr_manager, XTMR_MANAGER_BDIR_OFFSET, 0);
+
+	/*
+	 * To come out of break handler need to block the break signal
+	 * in the tmr manager, update the xtmr_manager cr_val for the same
+	 */
+	xtmr_manager->cr_val |= (1 << XTMR_MANAGER_CR_BB_SHIFT);
+
+	/*
+	 * When the break vector gets asserted because of error injection,
+	 * the break signal must be blocked before exiting from the
+	 * break handler, Below api updates the TMR manager address and
+	 * control register and error counter callback arguments,
+	 * which will be used by the break handler to block the
+	 * break and call the callback function.
+	 */
+	xmb_manager_register(xtmr_manager->phys_baseaddr, xtmr_manager->cr_val,
+			     (void *)xmb_manager_update_errcnt,
+			     xtmr_manager, (void *)xmb_manager_reset_handler);
+}
+
+/**
+ * xtmr_manager_probe - Driver probe function
+ * @pdev: Pointer to the platform_device structure
+ *
+ * This is the driver probe routine. It does all the memory
+ * allocation for the device.
+ *
+ * Return: 0 on success and failure value on error
+ */
+static int xtmr_manager_probe(struct platform_device *pdev)
+{
+	struct xtmr_manager_dev *xtmr_manager;
+	struct resource *res;
+	int err;
+
+	xtmr_manager = devm_kzalloc(&pdev->dev, sizeof(*xtmr_manager),
+				    GFP_KERNEL);
+	if (!xtmr_manager)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	xtmr_manager->regs =  devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(xtmr_manager->regs))
+		return PTR_ERR(xtmr_manager->regs);
+
+	xtmr_manager->phys_baseaddr = res->start;
+
+	err = of_property_read_u32(pdev->dev.of_node, "xlnx,magic1",
+				   &xtmr_manager->magic1);
+	if (err < 0) {
+		dev_err(&pdev->dev, "unable to read xlnx,magic1 property");
+		return err;
+	}
+
+	if (xtmr_manager->magic1 > XTMR_MANAGER_MAGIC1_MAX_VAL) {
+		dev_err(&pdev->dev, "invalid xlnx,magic1 property value");
+		return -EINVAL;
+	}
+
+	/* Initialize TMR Manager */
+	xtmr_manager_init(xtmr_manager);
+
+	platform_set_drvdata(pdev, xtmr_manager);
+
+	return 0;
+}
+
+static const struct of_device_id xtmr_manager_of_match[] = {
+	{
+		.compatible = "xlnx,tmr-manager-1.0",
+	},
+	{ /* end of table */ }
+};
+MODULE_DEVICE_TABLE(of, xtmr_manager_of_match);
+
+static struct platform_driver xtmr_manager_driver = {
+	.driver = {
+		.name = "xilinx-tmr_manager",
+		.of_match_table = xtmr_manager_of_match,
+		.dev_groups = xtmr_manager_dev_groups,
+	},
+	.probe = xtmr_manager_probe,
+};
+module_platform_driver(xtmr_manager_driver);
+
+MODULE_AUTHOR("Xilinx, Inc");
+MODULE_DESCRIPTION("Xilinx TMR Manager Driver");
+MODULE_LICENSE("GPL");
-- 
2.25.1


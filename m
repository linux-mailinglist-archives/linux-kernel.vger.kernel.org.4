Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D87FE5B2EA9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 08:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbiIIGTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 02:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbiIIGTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 02:19:34 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5662E84;
        Thu,  8 Sep 2022 23:19:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W3mREHGmxgr04prW1oOPjWCb0M1xmIAJ6RTX/NXqBjpf5wVBd4T3RowHmx/f/jfveNybF2MRxY8i6LMTrjVrMgjPjst1eqNnlXe9jLp3qvUoqrgK1JteNp9IxB7AwtaZ3D53huUrX7Bgbim7sMLSwzAnwrqp46YY1c6a1heOWHQ1gLz+FYg8736ppxeEaYcTuefTzuXjrQdbFLqN1bJblnRbC+PXs4n7pyKTzKAJ/fUdxtAUwa05iowz0y8ZMhyXQ6+hn6dKEuR32cMHt/f1KebiDSZwC+TKpTqox67B/hhWGYi67cFDq2UIeBTjsOQUOwYik2he1xvkZFxSsBg0QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OiAj4jx/M6co4ebqyN6T6/WjUVYyIbhfOEJ5Q/1XljE=;
 b=Kd07GM59NkUh5JfGT3eW3qJ0+Hw6oYBEfyTJLgyt6yhYQUnu/0GZXUMjcf6ytI4OJFSVNZqf9ZVlzN79E5Tbt2+Lwg/25jKeCJd3y+MGWXGCkicQd6I40KMZmYQ73zYvVMUk+T6iftP4dC24d/V/rGfk8BrtMiFw0MtyApA3beDIJN2FO+X7VE3hFvEhGQcNWWmEBbu6Rgt9yh6PVOMfRR/dl4PzOg52RLDuSTvyOXrESHt238D1HyLmmifRG9P79tJJQFrBlgzjqGs47sRmTQMbnOX2Gz1JoeFAvDQqSSYHAVQvXojqppYNCfSa8ZBkjVREZLPbwambyr15Uv8c3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OiAj4jx/M6co4ebqyN6T6/WjUVYyIbhfOEJ5Q/1XljE=;
 b=3W3TAHlaJfeTWU0GJaPV6X3IWW4bxRZCdmELT/+Sg7zMER2T001INe3CIzGrxxl2yEnW9xPOwlV4dKi4txOXv6BZDNzWiRNa/BnkxOKwCmaZ1qGXOb3ZchOHc6UWVk5Wwm/JNUlvWrBEDIiK5LqfuuPs36Fta6i9ZP+jqAIUDFk=
Received: from DS7PR05CA0031.namprd05.prod.outlook.com (2603:10b6:8:2f::6) by
 DM6PR12MB4313.namprd12.prod.outlook.com (2603:10b6:5:21e::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5612.20; Fri, 9 Sep 2022 06:19:29 +0000
Received: from DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2f:cafe::c4) by DS7PR05CA0031.outlook.office365.com
 (2603:10b6:8:2f::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.6 via Frontend
 Transport; Fri, 9 Sep 2022 06:19:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT025.mail.protection.outlook.com (10.13.172.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Fri, 9 Sep 2022 06:19:28 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 9 Sep
 2022 01:19:27 -0500
From:   Appana Durga Kedareswara rao 
        <appana.durga.kedareswara.rao@amd.com>
To:     <appanad@amd.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <michal.simek@xilinx.com>,
        <derek.kiernan@xilinx.com>, <dragan.cvetic@xilinx.com>,
        <arnd@arndb.de>, <gregkh@linuxfoundation.org>
CC:     <linux-arm-kernel@lists.infradead.org>, <git@amd.com>
Subject: [PATCH v4 2/4] drivers: misc: Add Support for TMR Manager
Date:   Fri, 9 Sep 2022 11:49:14 +0530
Message-ID: <20220909061916.2935431-3-appana.durga.kedareswara.rao@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220909061916.2935431-1-appana.durga.kedareswara.rao@amd.com>
References: <20220909061916.2935431-1-appana.durga.kedareswara.rao@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT025:EE_|DM6PR12MB4313:EE_
X-MS-Office365-Filtering-Correlation-Id: 471575fc-24d2-4078-fae3-08da922b4085
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D8EaWe9jifMK37dO2oN+IHAusfkUl3Vm8AwiLNy5BLQ/69jc2pQK7Vpe26M8mdUFl3uOYcByjWRkZyrqh1YB52N/d3uJ+bADNpWIMUnieoS7zBG5Z/i+Jm7FR6qsX7vkVtnpzFhlz/rsqiFvabszkTYOn4Db3Q2Z21nMTTfhaDbPbGbg9V7r9nbiqJ0eNjn3t1bq1CDcjDaoQm1Cn1gGjii9tbQri/VIC03Vxe9j3yOiDSDFKuD7jhLcJQxUUPAcwZx6Jin4ry1v8qQ1OdgBa4D62o6Y2qDmQnQNEpvUt5HUQa/OeSkSle5CSvujfu5OwhQJR6Qt28h1or9MOc0qbLiWAzjF3e1Z1lOQz6Hczeat7ZKpxGSnJHhVaAW56C956HfCXzgtjjslshPfXBhjE08167mkEt4BXndXiUgSHAxNJtH01L4+6dmdpBgEZ6H68jDPo+FknykQ7BHjKYu8bFb2Ha81X95XZ91Laldq5ZNf3vg+rp+fib2UmDdOKST1Ng9pkVr8XqGleGtIu0ylDUDeHF1bKRmE2RR3rQctupkmZBOMttRi/jw5hogLDXUCXHuc/nxe0OL2Q+39h1n+FauN5VP1lcSS9/VqBLBDQFrYH4uyJsi8FojUDz3HehQ1PkqNBiL6jzEYHapFQ64aE1XH0e5zN8p6yIsFX0PX+/g2/zHnxkTk087DhoK0oKgB3++fqLzUYNC4lpuMt5heXVAC7o64Ntl6vqB5pDbnKMfsV+fhKUkzgYpXEmkAlLnn8eY6gl8dHtdqtQs84UqkkUs2rIJjTpHKWCH1K6Tv3RsxTl7gU5QxM404jy25ogNFzhHmcTNOUEdNHfBD30A8N+aaNMkL+f/aNrmF9tmO9Xo=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(39860400002)(136003)(376002)(36840700001)(40470700004)(46966006)(30864003)(8936002)(2906002)(5660300002)(82310400005)(40480700001)(103116003)(40460700003)(86362001)(81166007)(921005)(356005)(36756003)(36860700001)(26005)(6666004)(478600001)(41300700001)(966005)(47076005)(2616005)(83380400001)(426003)(336012)(16526019)(186003)(1076003)(82740400003)(316002)(54906003)(70586007)(110136005)(8676002)(4326008)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 06:19:28.9024
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 471575fc-24d2-4078-fae3-08da922b4085
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4313
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
---
Changes for v4:
--> None.
Changes for v3:
--> Corrected month in the sysfs-driver-xilinx-tmr-manager file
--> Updated the Kconfig to compile the driver as a module
--> Removed unneeded status sysfs attribute
Changes for v2:
--> Fixed Month in the sysfs description.
--> Fixed line over 80 char in driver.
--> Replaced kstrtol with kstrtoul as suggested by Michal.
--> Added error check for xlnx,magic1 value.

 .../testing/sysfs-driver-xilinx-tmr-manager   |  16 ++
 MAINTAINERS                                   |   7 +
 drivers/misc/Kconfig                          |  10 +
 drivers/misc/Makefile                         |   3 +-
 drivers/misc/xilinx_tmr_manager.c             | 222 ++++++++++++++++++
 5 files changed, 257 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-xilinx-tmr-manager
 create mode 100644 drivers/misc/xilinx_tmr_manager.c

diff --git a/Documentation/ABI/testing/sysfs-driver-xilinx-tmr-manager b/Documentation/ABI/testing/sysfs-driver-xilinx-tmr-manager
new file mode 100644
index 000000000000..2a97be6ae849
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-driver-xilinx-tmr-manager
@@ -0,0 +1,16 @@
+What:		/sys/devices/platform/amba_pl/<dev>/errcnt
+Date:		Sep 2022
+Contact:	appana.durga.kedareswara.rao@amd.com
+Description:	This control file provides the fault detection count.
+		This file cannot be written.
+		Example:
+		# cat /sys/devices/platform/amba_pl/44a10000.tmr_manager/errcnt
+		  1
+
+What:		/sys/devices/platform/amba_pl/<dev>/dis_block_break
+Date:		Sep 2022
+Contact:	appana.durga.kedareswara.rao@amd.com
+Description:	Write any value to it, This control file enables the break signal.
+		This file is write only.
+		Example:
+		# echo <any value> > /sys/devices/platform/amba_pl/44a10000.tmr_manager/dis_block_break
diff --git a/MAINTAINERS b/MAINTAINERS
index f1390b8270b2..5fc5ec13985e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13277,6 +13277,13 @@ W:	http://www.monstr.eu/fdt/
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
index 94e9fb4cdd76..1508cc29b05a 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -496,6 +496,16 @@ config VCPU_STALL_DETECTOR
 
 	  If you do not intend to run this kernel as a guest, say N.
 
+config TMR_MANAGER
+	tristate "Select TMR Manager"
+	depends on MICROBLAZE && MB_MANAGER
+	help
+	  This option enables the driver developed for TMR Manager. The Triple
+	  Modular Redundancy(TMR) manager provides support for fault detection
+	  via sysfs interface.
+
+	  Say N here unless you know what you are doing.
+
 source "drivers/misc/c2port/Kconfig"
 source "drivers/misc/eeprom/Kconfig"
 source "drivers/misc/cb710/Kconfig"
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 2be8542616dd..4918f6632531 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -60,4 +60,5 @@ obj-$(CONFIG_XILINX_SDFEC)	+= xilinx_sdfec.o
 obj-$(CONFIG_HISI_HIKEY_USB)	+= hisi_hikey_usb.o
 obj-$(CONFIG_HI6421V600_IRQ)	+= hi6421v600-irq.o
 obj-$(CONFIG_OPEN_DICE)		+= open-dice.o
-obj-$(CONFIG_VCPU_STALL_DETECTOR)	+= vcpu_stall_detector.o
\ No newline at end of file
+obj-$(CONFIG_VCPU_STALL_DETECTOR)	+= vcpu_stall_detector.o
+obj-$(CONFIG_TMR_MANAGER)      += xilinx_tmr_manager.o
diff --git a/drivers/misc/xilinx_tmr_manager.c b/drivers/misc/xilinx_tmr_manager.c
new file mode 100644
index 000000000000..39365e0cb6e6
--- /dev/null
+++ b/drivers/misc/xilinx_tmr_manager.c
@@ -0,0 +1,222 @@
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
+ * recovery. Error detection feature is provided through sysfs
+ * entries which allow the user to observer the TMR microblaze
+ * status.
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
+ * allocation and creates sysfs entries for the device.
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


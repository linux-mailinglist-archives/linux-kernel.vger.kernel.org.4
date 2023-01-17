Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D70866DF14
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 14:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjAQNmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 08:42:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjAQNmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 08:42:06 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E0952A99B;
        Tue, 17 Jan 2023 05:42:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OAMl6XgX2KUjAjt1Gm1gHmVcOzzWWrwsTf45rs8a7mO0V2VrarFw+7qKZRyotFRMz8ZtEz9NgLw5zBFIaJNjwPyQyFkbWLdmdHwL+tWLGXWEx9x66nM1X2to+DnflizVI8FIGoJ9Zu1W/puifZM8r86ScjgFDsFvzXqUEXPD/vAOet+M3wyduNM8yNzIyw+UlnRfKH0n+kPsRKtrVSHQBeNLR94pDoP1VrCF+zlFQ7utozQILctKgh13VQyBJmoHWR9hUl3+Gg4rDS217iNooZu5VzN9kOzK0CP+/VUI+RCHrNMgIgidA9vhbMqd8LYH0ViD/KqCODkR6XyYDGj71A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gy2F/R1ZzyHXJC8vaOOFL8gSopsxNVrNaAOmejrWi+Y=;
 b=PC8ZAqY1V5SM3L5YClHAWI9ndbzD61jAhSkDoXuy7NgSqF8AVRRdhbHl/F0QL0kbqasnT1i5LL5DwJqPrYYbfB2c9dI+dbV2MUZvU85E92I1ZaAg4JhnyFsBx3PlVWSSBMfqhdiBLUgRZAC5B7DIGfS2claW5juK8oFPPw9ERKbTnGunX3Tah89gsvUMsi/O8+lqewcz6GOAubj8WS/5XiygVSP2N3RKbgeDxKlmWNq8X4zEYSQ1ekG5sgreViSTOqBbC4UTwZCnRjj0d0MiqjX8FdzOpDAcl/oMwMm3HUc3s4NnArfG+sLXzxcmBNUtVZEM6Gjgft8o6JVzZqb/qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gy2F/R1ZzyHXJC8vaOOFL8gSopsxNVrNaAOmejrWi+Y=;
 b=F1OSEUqFmx8CetRQI9e7TJc9iONtObKe/z6DSLl6COl4Npga8mbj7Ba/tUFGnOtnRlAb7sILGjspNnIQiaaOkt22o8azJZ8eQuQAs23Hj3rQkmQWttiBB8sY4O274NcmCOmIdmHEx7mYjbuo0K8ycq0oli3fRfoFyJlYg/o5+hY=
Received: from DS7PR05CA0094.namprd05.prod.outlook.com (2603:10b6:8:56::11) by
 DS0PR12MB8200.namprd12.prod.outlook.com (2603:10b6:8:f5::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.22; Tue, 17 Jan 2023 13:42:01 +0000
Received: from DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:56:cafe::b0) by DS7PR05CA0094.outlook.office365.com
 (2603:10b6:8:56::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6023.12 via Frontend
 Transport; Tue, 17 Jan 2023 13:42:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT010.mail.protection.outlook.com (10.13.172.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.13 via Frontend Transport; Tue, 17 Jan 2023 13:42:01 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 17 Jan
 2023 07:42:01 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 17 Jan
 2023 05:42:00 -0800
Received: from xhdipdslab41.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 17 Jan 2023 07:41:53 -0600
From:   Nipun Gupta <nipun.gupta@amd.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <eric.auger@redhat.com>, <alex.williamson@redhat.com>,
        <cohuck@redhat.com>, <song.bao.hua@hisilicon.com>,
        <mchehab+huawei@kernel.org>, <maz@kernel.org>,
        <f.fainelli@gmail.com>, <jeffrey.l.hugo@gmail.com>,
        <saravanak@google.com>, <Michael.Srba@seznam.cz>,
        <mani@kernel.org>, <yishaih@nvidia.com>, <jgg@ziepe.ca>,
        <jgg@nvidia.com>, <robin.murphy@arm.com>, <will@kernel.org>,
        <joro@8bytes.org>, <masahiroy@kernel.org>,
        <ndesaulniers@google.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kbuild@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <okaya@kernel.org>, <harpreet.anand@amd.com>,
        <nikhil.agarwal@amd.com>, <michal.simek@amd.com>, <git@amd.com>,
        Nipun Gupta <nipun.gupta@amd.com>
Subject: [PATCH 01/19] bus/cdx: add the cdx bus driver
Date:   Tue, 17 Jan 2023 19:11:33 +0530
Message-ID: <20230117134139.1298-2-nipun.gupta@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230117134139.1298-1-nipun.gupta@amd.com>
References: <20230117134139.1298-1-nipun.gupta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT010:EE_|DS0PR12MB8200:EE_
X-MS-Office365-Filtering-Correlation-Id: 68eb8588-1a07-4da8-6ce7-08daf8909cf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vk9DeUn/J+OQUvJ0GuXlLcPrpb0BooyYYfoCPNgNctUiquK3afdVwICkIoAjgGgEguuXKBwTKuh+wrZ54I/aYB/lIsdy8dAUSPuGR5nfApWtn/wJyEtyJqNqtxXHXFbu8IJgCQGTXqnNJvASFVirbPfvTdDDc7GlATVBfYCy4A7+0PqGR4bux/5aLpWiYYUqe9BsgTlKCIK+OfA+qf+7pQckfAj7j7NTa29aPCeVJYRLGXAZqBBtXUsrqXifwp5MVuosYJtfMHNCLBOmNPHrYsmqYfhobfD6y3XT5g0JzW395RFcyxm9iF+vggSvV052GJexCDRCBwuvrII0WdPy/OTyY5QLFCXA68bhFH5VHJZK1QCjl5Q+9ncgGJ1kMLC7Cf5Nm0fTvPOLOcInwyWkf8Qd03zujRblAdVqSUzCNO1l6jit/EoJ4dlbVG8isnJGcOiFH9UkbqSGA1i+e8XjmuE6OE6hGWSaJZmrii0/q+7Cpt0PaZIyebysttEes524SV3qOV+2Y7l6l4xeUTXxaUAsCXPt8sGRfQ8lqTMX0LNkm4gqaiqK1mwBdhFAviQ9PNJnUAsFHw+xjr80I5xWEQ/1KiV7tn6AQqXJk1G15oTWcgPWztaLLJwjIze5DlYjKd+z3KK00te6Gqd0puDMYyhltUu+wHRbb+v1UXt298Heef8aRyENaN0j8mY0GyY3qs149+VaedVhN3e7Bb3z0iy9z1lHueJviD70rFBvClTlNK1ZteiCiRoVJeP2/jOiQFp9kkX1tedC3PuYwTRAvaYLlOMol5mgwtp4bXh+MG+ngfFW50MXkLSzHxHCveBCEHmoAf3cQN8+uxsfSfyP2Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(39860400002)(396003)(376002)(451199015)(36840700001)(40470700004)(46966006)(6666004)(4326008)(478600001)(8676002)(36756003)(966005)(70206006)(70586007)(110136005)(54906003)(41300700001)(316002)(36860700001)(82740400003)(921005)(40480700001)(40460700003)(1076003)(356005)(81166007)(82310400005)(2616005)(186003)(336012)(47076005)(426003)(30864003)(86362001)(44832011)(26005)(5660300002)(7416002)(83380400001)(2906002)(8936002)(36900700001)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 13:42:01.8005
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68eb8588-1a07-4da8-6ce7-08daf8909cf7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8200
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce AMD CDX bus, which provides a mechanism for scanning
and probing CDX devices. These devices are memory mapped on
system bus for Application Processors(APUs).

CDX devices can be changed dynamically in the Fabric and CDX
bus interacts with CDX controller to rescan the bus and
rediscover the devices.

Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
Signed-off-by: Tarak Reddy <tarak.reddy@amd.com>
---
 Documentation/ABI/testing/sysfs-bus-cdx |  12 +
 MAINTAINERS                             |   7 +
 drivers/bus/Kconfig                     |   1 +
 drivers/bus/Makefile                    |   2 +
 drivers/bus/cdx/Kconfig                 |  14 +
 drivers/bus/cdx/Makefile                |   8 +
 drivers/bus/cdx/cdx.c                   | 433 ++++++++++++++++++++++++
 drivers/bus/cdx/cdx.h                   |  62 ++++
 include/linux/cdx/cdx_bus.h             | 153 +++++++++
 include/linux/mod_devicetable.h         |  15 +
 scripts/mod/devicetable-offsets.c       |   4 +
 scripts/mod/file2alias.c                |  12 +
 12 files changed, 723 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-cdx
 create mode 100644 drivers/bus/cdx/Kconfig
 create mode 100644 drivers/bus/cdx/Makefile
 create mode 100644 drivers/bus/cdx/cdx.c
 create mode 100644 drivers/bus/cdx/cdx.h
 create mode 100644 include/linux/cdx/cdx_bus.h

diff --git a/Documentation/ABI/testing/sysfs-bus-cdx b/Documentation/ABI/testing/sysfs-bus-cdx
new file mode 100644
index 000000000000..8c2425fdb6d9
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-cdx
@@ -0,0 +1,12 @@
+What:		/sys/bus/cdx/rescan
+Date:		January 2023
+Contact:	nipun.gupta@amd.com
+Description:
+		Writing a non-zero value to this file would cause rescan
+		of the bus and devices on the CDX bus. Any new devices would
+		be scanned and added to the list of linux devices and any
+		devices removed are also deleted from linux.
+
+                For example::
+
+		  # echo 1 > /sys/bus/cdx/rescan
diff --git a/MAINTAINERS b/MAINTAINERS
index 1c83c26e9f68..25c76cf27f21 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -962,6 +962,13 @@ Q:	https://patchwork.kernel.org/project/linux-rdma/list/
 F:	drivers/infiniband/hw/efa/
 F:	include/uapi/rdma/efa-abi.h
 
+AMD CDX BUS DRIVER
+M:	Nipun Gupta <nipun.gupta@amd.com>
+M:	Nikhil Agarwal <nikhil.agarwal@amd.com>
+S:	Maintained
+F:	drivers/bus/cdx/*
+F:	include/linux/cdx/*
+
 AMD CRYPTOGRAPHIC COPROCESSOR (CCP) DRIVER
 M:	Tom Lendacky <thomas.lendacky@amd.com>
 M:	John Allen <john.allen@amd.com>
diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
index 7bfe998f3514..b0324efb9a6a 100644
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@ -251,5 +251,6 @@ config DA8XX_MSTPRI
 
 source "drivers/bus/fsl-mc/Kconfig"
 source "drivers/bus/mhi/Kconfig"
+source "drivers/bus/cdx/Kconfig"
 
 endmenu
diff --git a/drivers/bus/Makefile b/drivers/bus/Makefile
index d90eed189a65..9e4d09789a81 100644
--- a/drivers/bus/Makefile
+++ b/drivers/bus/Makefile
@@ -20,6 +20,8 @@ obj-$(CONFIG_INTEL_IXP4XX_EB)	+= intel-ixp4xx-eb.o
 obj-$(CONFIG_MIPS_CDMM)		+= mips_cdmm.o
 obj-$(CONFIG_MVEBU_MBUS) 	+= mvebu-mbus.o
 
+obj-$(CONFIG_CDX_BUS)		+= cdx/
+
 # Interconnect bus driver for OMAP SoCs.
 obj-$(CONFIG_OMAP_INTERCONNECT)	+= omap_l3_smx.o omap_l3_noc.o
 
diff --git a/drivers/bus/cdx/Kconfig b/drivers/bus/cdx/Kconfig
new file mode 100644
index 000000000000..54e0623ebcff
--- /dev/null
+++ b/drivers/bus/cdx/Kconfig
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# CDX bus configuration
+#
+# Copyright (C) 2022-2023, Advanced Micro Devices, Inc.
+#
+
+config CDX_BUS
+	bool "CDX Bus driver"
+	help
+	  Driver to enable CDX Bus. CDX bus provides a mechanism for
+	  scanning and probing of CDX devices. CDX devices are memory
+	  mapped on system bus for embedded CPUs. CDX bus uses CDX
+	  controller and firmware to scan the CDX devices.
diff --git a/drivers/bus/cdx/Makefile b/drivers/bus/cdx/Makefile
new file mode 100644
index 000000000000..c5feb11fc718
--- /dev/null
+++ b/drivers/bus/cdx/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for CDX
+#
+# Copyright (C) 2022-2023, Advanced Micro Devices, Inc.
+#
+
+obj-$(CONFIG_CDX_BUS) += cdx.o
diff --git a/drivers/bus/cdx/cdx.c b/drivers/bus/cdx/cdx.c
new file mode 100644
index 000000000000..2737470f08d3
--- /dev/null
+++ b/drivers/bus/cdx/cdx.c
@@ -0,0 +1,433 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * CDX bus driver.
+ *
+ * Copyright (C) 2022-2023, Advanced Micro Devices, Inc.
+ */
+
+/*
+ * Architecture Overview
+ * =====================
+ * CDX is a Hardware Architecture designed for AMD FPGA devices. It
+ * consists of sophisticated mechanism for interaction between FPGA,
+ * Firmware and the APUs (Application CPUs).
+ *
+ * Firmware resides on RPU (Realtime CPUs) which interacts with
+ * the FPGA program manager and the APUs. The RPU provides memory-mapped
+ * interface (RPU if) which is used to communicate with APUs.
+ *
+ * The diagram below shows an overview of the CDX architecture:
+ *
+ *          +--------------------------------------+
+ *          |    Application CPUs (APU)            |
+ *          |                                      |
+ *          |                    CDX device drivers|
+ *          |     Linux OS                |        |
+ *          |                        CDX bus       |
+ *          |                             |        |
+ *          |                     CDX controller   |
+ *          |                             |        |
+ *          +-----------------------------|--------+
+ *                                        | (discover, config,
+ *                                        |  reset, rescan)
+ *                                        |
+ *          +------------------------| RPU if |----+
+ *          |                             |        |
+ *          |                             V        |
+ *          |          Realtime CPUs (RPU)         |
+ *          |                                      |
+ *          +--------------------------------------+
+ *                                |
+ *          +---------------------|----------------+
+ *          |  FPGA               |                |
+ *          |      +-----------------------+       |
+ *          |      |           |           |       |
+ *          | +-------+    +-------+   +-------+   |
+ *          | | dev 1 |    | dev 2 |   | dev 3 |   |
+ *          | +-------+    +-------+   +-------+   |
+ *          +--------------------------------------+
+ *
+ * The RPU firmware extracts the device information from the loaded FPGA
+ * image and implements a mechanism that allows the APU drivers to
+ * enumerate such devices (device personality and resource details) via
+ * a dedicated communication channel. RPU mediates operations such as
+ * discover, reset and rescan of the FPGA devices for the APU. This is
+ * done using memory mapped interface provided by the RPU to APU.
+ */
+
+#include <linux/init.h>
+#include <linux/irqdomain.h>
+#include <linux/kernel.h>
+#include <linux/of_device.h>
+#include <linux/slab.h>
+#include <linux/mm.h>
+#include <linux/cdx/cdx_bus.h>
+#include "cdx.h"
+
+/* Default DMA mask for devices on a CDX bus */
+#define CDX_DEFAULT_DMA_MASK	(~0ULL)
+#define MAX_CDX_CONTROLLERS 16
+
+static DECLARE_BITMAP(cdx_controller_id_map, MAX_CDX_CONTROLLERS);
+/* List of CDX controllers registered with the CDX bus */
+static LIST_HEAD(cdx_controllers);
+
+/**
+ * cdx_unregister_device - Unregister a CDX device
+ * @dev: CDX device
+ * @data: This is always passed as NULL, and is not used in this API,
+ *	  but is required here as the bus_for_each_dev() API expects
+ *	  the passed function (cdx_unregister_device) to have this
+ *	  as an argument.
+ *
+ * @return: -errno on failure, 0 on success.
+ */
+static int cdx_unregister_device(struct device *dev,
+				 void *data)
+{
+	struct cdx_device *cdx_dev = to_cdx_device(dev);
+
+	kfree(cdx_dev->driver_override);
+	cdx_dev->driver_override = NULL;
+	/*
+	 * Do not free cdx_dev here as it would be freed in
+	 * cdx_device_release() called from within put_device().
+	 */
+	device_del(&cdx_dev->dev);
+	put_device(&cdx_dev->dev);
+
+	return 0;
+}
+
+static void cdx_unregister_devices(struct bus_type *bus)
+{
+	/* Reset all the devices attached to cdx bus */
+	bus_for_each_dev(bus, NULL, NULL, cdx_unregister_device);
+}
+
+/**
+ * cdx_match_one_device - Tell if a CDX device structure has a matching
+ *			  CDX device id structure
+ * @id: single CDX device id structure to match
+ * @dev: the CDX device structure to match against
+ *
+ * @return: matching cdx_device_id structure or NULL if there is no match.
+ */
+static inline const struct cdx_device_id *
+cdx_match_one_device(const struct cdx_device_id *id,
+		     const struct cdx_device *dev)
+{
+	/* Use vendor ID and device ID for matching */
+	if ((id->vendor == CDX_ANY_ID || id->vendor == dev->vendor) &&
+	    (id->device == CDX_ANY_ID || id->device == dev->device))
+		return id;
+	return NULL;
+}
+
+/**
+ * cdx_match_id - See if a CDX device matches a given cdx_id table
+ * @ids: array of CDX device ID structures to search in
+ * @dev: the CDX device structure to match against.
+ *
+ * Used by a driver to check whether a CDX device is in its list of
+ * supported devices. Returns the matching cdx_device_id structure or
+ * NULL if there is no match.
+ *
+ * @return: matching cdx_device_id structure or NULL if there is no match.
+ */
+static inline const struct cdx_device_id *
+cdx_match_id(const struct cdx_device_id *ids, struct cdx_device *dev)
+{
+	if (ids) {
+		while (ids->vendor || ids->device) {
+			if (cdx_match_one_device(ids, dev))
+				return ids;
+			ids++;
+		}
+	}
+	return NULL;
+}
+
+/**
+ * cdx_bus_match - device to driver matching callback
+ * @dev: the cdx device to match against
+ * @drv: the device driver to search for matching cdx device
+ * structures
+ *
+ * @return: true on success, false otherwise.
+ */
+static int cdx_bus_match(struct device *dev, struct device_driver *drv)
+{
+	struct cdx_device *cdx_dev = to_cdx_device(dev);
+	struct cdx_driver *cdx_drv = to_cdx_driver(drv);
+	const struct cdx_device_id *found_id = NULL;
+	const struct cdx_device_id *ids;
+
+	ids = cdx_drv->match_id_table;
+
+	/* When driver_override is set, only bind to the matching driver */
+	if (cdx_dev->driver_override && strcmp(cdx_dev->driver_override, drv->name))
+		return false;
+
+	found_id = cdx_match_id(ids, cdx_dev);
+	if (!found_id)
+		return false;
+
+	do {
+		/*
+		 * In case override_only was set, enforce driver_override
+		 * matching.
+		 */
+		if (!found_id->override_only)
+			return true;
+		if (cdx_dev->driver_override)
+			return true;
+
+		ids = found_id + 1;
+		found_id = cdx_match_id(ids, cdx_dev);
+	} while (found_id);
+
+	return false;
+}
+
+static int cdx_probe(struct device *dev)
+{
+	struct cdx_driver *cdx_drv = to_cdx_driver(dev->driver);
+	struct cdx_device *cdx_dev = to_cdx_device(dev);
+	int error;
+
+	error = cdx_drv->probe(cdx_dev);
+	if (error < 0) {
+		dev_err_probe(dev, error, "%s failed\n", __func__);
+		return error;
+	}
+
+	return 0;
+}
+
+static void cdx_remove(struct device *dev)
+{
+	struct cdx_driver *cdx_drv = to_cdx_driver(dev->driver);
+	struct cdx_device *cdx_dev = to_cdx_device(dev);
+
+	if (cdx_drv && cdx_drv->remove)
+		cdx_drv->remove(cdx_dev);
+}
+
+static void cdx_shutdown(struct device *dev)
+{
+	struct cdx_driver *cdx_drv = to_cdx_driver(dev->driver);
+	struct cdx_device *cdx_dev = to_cdx_device(dev);
+
+	if (cdx_drv && cdx_drv->shutdown)
+		cdx_drv->shutdown(cdx_dev);
+}
+
+static int cdx_dma_configure(struct device *dev)
+{
+	struct cdx_device *cdx_dev = to_cdx_device(dev);
+	u32 input_id = cdx_dev->req_id;
+	int ret;
+
+	ret = of_dma_configure_id(dev, dev->parent->of_node, 0, &input_id);
+	if (ret && ret != -EPROBE_DEFER) {
+		dev_err(dev, "of_dma_configure_id() failed\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static ssize_t rescan_store(struct bus_type *bus,
+			    const char *buf, size_t count)
+{
+	struct cdx_controller *cdx;
+	unsigned long val = 0;
+
+	if (kstrtoul(buf, 0, &val) < 0)
+		return -EINVAL;
+
+	if (!val)
+		return -EINVAL;
+
+	/* Unregister all the devices on the bus */
+	cdx_unregister_devices(&cdx_bus_type);
+
+	/* Rescan all the devices */
+	list_for_each_entry(cdx, &cdx_controllers, node) {
+		int ret;
+
+		ret = cdx->ops->scan(cdx);
+		if (ret)
+			dev_err(cdx->dev, "cdx bus scanning failed\n");
+	}
+
+	return count;
+}
+static BUS_ATTR_WO(rescan);
+
+static struct attribute *cdx_bus_attrs[] = {
+	&bus_attr_rescan.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(cdx_bus);
+
+struct bus_type cdx_bus_type = {
+	.name		= "cdx",
+	.match		= cdx_bus_match,
+	.probe		= cdx_probe,
+	.remove		= cdx_remove,
+	.shutdown	= cdx_shutdown,
+	.dma_configure	= cdx_dma_configure,
+	.bus_groups	= cdx_bus_groups,
+};
+EXPORT_SYMBOL_GPL(cdx_bus_type);
+
+int __cdx_driver_register(struct cdx_driver *cdx_driver,
+			  struct module *owner)
+{
+	int error;
+
+	cdx_driver->driver.owner = owner;
+	cdx_driver->driver.bus = &cdx_bus_type;
+
+	error = driver_register(&cdx_driver->driver);
+	if (error < 0) {
+		pr_err("driver_register() failed for %s: %d\n",
+		       cdx_driver->driver.name, error);
+		return error;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(__cdx_driver_register);
+
+void cdx_driver_unregister(struct cdx_driver *cdx_driver)
+{
+	driver_unregister(&cdx_driver->driver);
+}
+EXPORT_SYMBOL_GPL(cdx_driver_unregister);
+
+static void cdx_device_release(struct device *dev)
+{
+	struct cdx_device *cdx_dev = to_cdx_device(dev);
+
+	kfree(cdx_dev);
+}
+
+int cdx_device_add(struct cdx_dev_params *dev_params)
+{
+	struct cdx_controller *cdx = dev_params->cdx;
+	struct device *parent = cdx->dev;
+	struct cdx_device *cdx_dev;
+	int ret;
+
+	cdx_dev = kzalloc(sizeof(*cdx_dev), GFP_KERNEL);
+	if (!cdx_dev)
+		return -ENOMEM;
+
+	/* Populate resource */
+	memcpy(cdx_dev->res, dev_params->res, sizeof(struct resource) *
+		dev_params->res_count);
+	cdx_dev->res_count = dev_params->res_count;
+
+	/* Populate CDX dev params */
+	cdx_dev->req_id = dev_params->req_id;
+	cdx_dev->vendor = dev_params->vendor;
+	cdx_dev->device = dev_params->device;
+	cdx_dev->bus_num = dev_params->bus_num;
+	cdx_dev->dev_num = dev_params->dev_num;
+	cdx_dev->cdx = dev_params->cdx;
+	cdx_dev->dma_mask = CDX_DEFAULT_DMA_MASK;
+
+	/* Initiaize generic device */
+	device_initialize(&cdx_dev->dev);
+	cdx_dev->dev.parent = parent;
+	cdx_dev->dev.bus = &cdx_bus_type;
+	cdx_dev->dev.dma_mask = &cdx_dev->dma_mask;
+	cdx_dev->dev.release = cdx_device_release;
+
+	/* Set Name */
+	dev_set_name(&cdx_dev->dev, "cdx-%02x:%02x",
+		     ((cdx->id << CDX_CONTROLLER_ID_SHIFT) | (cdx_dev->bus_num & CDX_BUS_NUM_MASK)),
+		     cdx_dev->dev_num);
+
+	ret = device_add(&cdx_dev->dev);
+	if (ret != 0) {
+		dev_err(&cdx_dev->dev,
+			"cdx device add failed: %d", ret);
+		goto fail;
+	}
+
+	return 0;
+fail:
+	/*
+	 * Do not free cdx_dev here as it would be freed in
+	 * cdx_device_release() called from put_device().
+	 */
+	put_device(&cdx_dev->dev);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(cdx_device_add);
+
+static int get_free_index(void)
+{
+	unsigned long id_map;
+	unsigned long mask;
+	int index = 0;
+
+	mask  = (1UL << MAX_CDX_CONTROLLERS) - 1;
+retry:
+	id_map = cdx_controller_id_map[0];
+	if ((id_map & mask) == mask)
+		return -ENOSPC;
+
+	index = ffz(id_map);
+	if (index >= MAX_CDX_CONTROLLERS)
+		return -ENOSPC;
+
+	if (test_and_set_bit(index, &cdx_controller_id_map[0]))
+		goto retry;
+
+	return index;
+}
+
+int cdx_register_controller(struct cdx_controller *cdx)
+{
+	int ret;
+
+	ret = get_free_index();
+	if (ret < 0) {
+		dev_err(cdx->dev,
+			"No free index available. Maximum controllers already registered\n");
+		cdx->id = (u8)MAX_CDX_CONTROLLERS;
+		return ret;
+	}
+	cdx->id = (u8)ret;
+
+	/* Scan all the devices */
+	cdx->ops->scan(cdx);
+
+	list_add_tail(&cdx->node, &cdx_controllers);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cdx_register_controller);
+
+void cdx_unregister_controller(struct cdx_controller *cdx)
+{
+	if (cdx->id >= MAX_CDX_CONTROLLERS)
+		return;
+
+	device_for_each_child(cdx->dev, NULL, cdx_unregister_device);
+	list_del(&cdx->node);
+	clear_bit(cdx->id, &cdx_controller_id_map[0]);
+}
+EXPORT_SYMBOL_GPL(cdx_unregister_controller);
+
+static int __init cdx_bus_init(void)
+{
+	bitmap_zero(cdx_controller_id_map, MAX_CDX_CONTROLLERS);
+	return bus_register(&cdx_bus_type);
+}
+postcore_initcall(cdx_bus_init);
diff --git a/drivers/bus/cdx/cdx.h b/drivers/bus/cdx/cdx.h
new file mode 100644
index 000000000000..740de8c5212b
--- /dev/null
+++ b/drivers/bus/cdx/cdx.h
@@ -0,0 +1,62 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Header file for the CDX Bus
+ *
+ * Copyright (C) 2022-2023, Advanced Micro Devices, Inc.
+ */
+
+#ifndef _CDX_H_
+#define _CDX_H_
+
+#include <linux/cdx/cdx_bus.h>
+
+/**
+ * struct cdx_dev_params - CDX device parameters
+ * @cdx: CDX controller associated with the device
+ * @parent: Associated CDX controller
+ * @vendor: Vendor ID for CDX device
+ * @device: Device ID for CDX device
+ * @bus_num: Bus number for this CDX device
+ * @dev_num: Device number for this device
+ * @res: array of MMIO region entries
+ * @res_count: number of valid MMIO regions
+ * @req_id: Requestor ID associated with CDX device
+ */
+struct cdx_dev_params {
+	struct cdx_controller *cdx;
+	u16 vendor;
+	u16 device;
+	u8 bus_num;
+	u8 dev_num;
+	struct resource res[MAX_CDX_DEV_RESOURCES];
+	u8 res_count;
+	u32 req_id;
+};
+
+/**
+ * cdx_register_controller - Register a CDX controller and its ports
+ *		on the CDX bus.
+ * @cdx: The CDX controller to register
+ *
+ * @return: -errno on failure, 0 on success.
+ */
+int cdx_register_controller(struct cdx_controller *cdx);
+
+/**
+ * cdx_unregister_controller - Unregister a CDX controller
+ * @cdx: The CDX controller to unregister
+ */
+void cdx_unregister_controller(struct cdx_controller *cdx);
+
+/**
+ * cdx_device_add - Add a CDX device. This function adds a CDX device
+ *		on the CDX bus as per the device parameters provided
+ *		by caller. It also creates and registers an associated
+ *		Linux generic device.
+ * @dev_params: device parameters associated with the device to be created.
+ *
+ * @return: -errno on failure, 0 on success.
+ */
+int cdx_device_add(struct cdx_dev_params *dev_params);
+
+#endif /* _CDX_H_ */
diff --git a/include/linux/cdx/cdx_bus.h b/include/linux/cdx/cdx_bus.h
new file mode 100644
index 000000000000..1d28f11da5e7
--- /dev/null
+++ b/include/linux/cdx/cdx_bus.h
@@ -0,0 +1,153 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * CDX bus public interface
+ *
+ * Copyright (C) 2022-2023, Advanced Micro Devices, Inc.
+ *
+ */
+
+#ifndef _CDX_BUS_H_
+#define _CDX_BUS_H_
+
+#include <linux/device.h>
+#include <linux/list.h>
+#include <linux/mod_devicetable.h>
+
+#define MAX_CDX_DEV_RESOURCES	4
+#define CDX_ANY_ID (0xFFFF)
+#define CDX_CONTROLLER_ID_SHIFT 4
+#define CDX_BUS_NUM_MASK 0xF
+
+/* Forward declaration for CDX controller */
+struct cdx_controller;
+
+typedef int (*cdx_scan_cb)(struct cdx_controller *cdx);
+
+/**
+ * CDX_DEVICE_DRIVER_OVERRIDE - macro used to describe a CDX device with
+ *                              override_only flags.
+ * @vend: the 16 bit CDX Vendor ID
+ * @dev: the 16 bit CDX Device ID
+ * @driver_override: the 32 bit CDX Device override_only
+ *
+ * This macro is used to create a struct cdx_device_id that matches only a
+ * driver_override device.
+ */
+#define CDX_DEVICE_DRIVER_OVERRIDE(vend, dev, driver_override) \
+	.vendor = (vend), .device = (dev), .override_only = (driver_override)
+
+/**
+ * struct cdx_ops - Callbacks supported by CDX controller.
+ * @scan: scan the devices on the controller
+ */
+struct cdx_ops {
+	cdx_scan_cb scan;
+};
+
+/**
+ * struct cdx_controller: CDX controller object
+ * @node: list of CDX controllers
+ * @dev: Linux device associated with the CDX controller.
+ * @priv: private data
+ * @id: Controller ID
+ * @ops: CDX controller ops
+ */
+struct cdx_controller {
+	struct list_head node;
+	struct device *dev;
+	void *priv;
+	u8 id;
+	struct cdx_ops *ops;
+};
+
+/**
+ * struct cdx_device - CDX device object
+ * @dev: Linux driver model device object
+ * @cdx: CDX controller associated with the device
+ * @vendor: Vendor ID for CDX device
+ * @device: Device ID for CDX device
+ * @bus_num: Bus number for this CDX device
+ * @dev_num: Device number for this device
+ * @res: array of MMIO region entries
+ * @res_attr: resource binary attribute
+ * @res_count: number of valid MMIO regions
+ * @dma_mask: Default DMA mask
+ * @flags: CDX device flags
+ * @req_id: Requestor ID associated with CDX device
+ * @driver_override: driver name to force a match; do not set directly,
+ *                   because core frees it; use driver_set_override() to
+ *                   set or clear it.
+ */
+struct cdx_device {
+	struct device dev;
+	struct cdx_controller *cdx;
+	u16 vendor;
+	u16 device;
+	u8 bus_num;
+	u8 dev_num;
+	struct resource res[MAX_CDX_DEV_RESOURCES];
+	u8 res_count;
+	u64 dma_mask;
+	u16 flags;
+	u32 req_id;
+	const char *driver_override;
+};
+
+#define to_cdx_device(_dev) \
+	container_of(_dev, struct cdx_device, dev)
+
+/**
+ * struct cdx_driver - CDX device driver
+ * @driver: Generic device driver
+ * @match_id_table: table of supported device matching Ids
+ * @probe: Function called when a device is added
+ * @remove: Function called when a device is removed
+ * @shutdown: Function called at shutdown time to quiesce the device
+ * @suspend: Function called when a device is stopped
+ * @resume: Function called when a device is resumed
+ * @driver_managed_dma: Device driver doesn't use kernel DMA API for DMA.
+ *		For most device drivers, no need to care about this flag
+ *		as long as all DMAs are handled through the kernel DMA API.
+ *		For some special ones, for example VFIO drivers, they know
+ *		how to manage the DMA themselves and set this flag so that
+ *		the IOMMU layer will allow them to setup and manage their
+ *		own I/O address space.
+ */
+struct cdx_driver {
+	struct device_driver driver;
+	const struct cdx_device_id *match_id_table;
+	int (*probe)(struct cdx_device *dev);
+	int (*remove)(struct cdx_device *dev);
+	void (*shutdown)(struct cdx_device *dev);
+	int (*suspend)(struct cdx_device *dev, pm_message_t state);
+	int (*resume)(struct cdx_device *dev);
+	bool driver_managed_dma;
+};
+
+#define to_cdx_driver(_drv) \
+	container_of(_drv, struct cdx_driver, driver)
+
+/* Macro to avoid include chaining to get THIS_MODULE */
+#define cdx_driver_register(drv) \
+	__cdx_driver_register(drv, THIS_MODULE)
+
+/**
+ * __cdx_driver_register - registers a CDX device driver
+ * @cdx_driver: CDX driver to register
+ * @owner: module owner
+ *
+ * @return: -errno on failure, 0 on success.
+ */
+int __must_check __cdx_driver_register(struct cdx_driver *cdx_driver,
+				       struct module *owner);
+
+/**
+ * cdx_driver_unregister - unregisters a device driver from the
+ * CDX bus.
+ * @cdx_driver: CDX driver to register
+ */
+void cdx_driver_unregister(struct cdx_driver *cdx_driver);
+
+extern struct bus_type cdx_bus_type;
+
+#endif /* _CDX_BUS_H_ */
diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index 549590e9c644..23445b163c2a 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -911,4 +911,19 @@ struct ishtp_device_id {
 	kernel_ulong_t driver_data;
 };
 
+/**
+ * struct cdx_device_id - CDX device identifier
+ * @vendor: Vendor ID
+ * @device: Device ID
+ * @override_only: Match only when dev->driver_override is this driver.
+ *
+ * Type of entries in the "device Id" table for CDX devices supported by
+ * a CDX device driver.
+ */
+struct cdx_device_id {
+	__u16 vendor;
+	__u16 device;
+	__u32 override_only;
+};
+
 #endif /* LINUX_MOD_DEVICETABLE_H */
diff --git a/scripts/mod/devicetable-offsets.c b/scripts/mod/devicetable-offsets.c
index c0d3bcb99138..62dc988df84d 100644
--- a/scripts/mod/devicetable-offsets.c
+++ b/scripts/mod/devicetable-offsets.c
@@ -262,5 +262,9 @@ int main(void)
 	DEVID(ishtp_device_id);
 	DEVID_FIELD(ishtp_device_id, guid);
 
+	DEVID(cdx_device_id);
+	DEVID_FIELD(cdx_device_id, vendor);
+	DEVID_FIELD(cdx_device_id, device);
+
 	return 0;
 }
diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
index 91c2e7ba5e52..28da34ba4359 100644
--- a/scripts/mod/file2alias.c
+++ b/scripts/mod/file2alias.c
@@ -1452,6 +1452,17 @@ static int do_dfl_entry(const char *filename, void *symval, char *alias)
 	return 1;
 }
 
+/* Looks like: cdx:vNdN */
+static int do_cdx_entry(const char *filename, void *symval,
+			char *alias)
+{
+	DEF_FIELD(symval, cdx_device_id, vendor);
+	DEF_FIELD(symval, cdx_device_id, device);
+
+	sprintf(alias, "cdx:v%08Xd%08Xd", vendor, device);
+	return 1;
+}
+
 /* Does namelen bytes of name exactly match the symbol? */
 static bool sym_is(const char *name, unsigned namelen, const char *symbol)
 {
@@ -1531,6 +1542,7 @@ static const struct devtable devtable[] = {
 	{"ssam", SIZE_ssam_device_id, do_ssam_entry},
 	{"dfl", SIZE_dfl_device_id, do_dfl_entry},
 	{"ishtp", SIZE_ishtp_device_id, do_ishtp_entry},
+	{"cdx", SIZE_cdx_device_id, do_cdx_entry},
 };
 
 /* Create MODULE_ALIAS() statements.
-- 
2.17.1


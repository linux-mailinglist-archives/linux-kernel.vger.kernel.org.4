Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EEF068273C
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 09:46:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbjAaIqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 03:46:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjAaIpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 03:45:55 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761674B1A3;
        Tue, 31 Jan 2023 00:41:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GpvWdgHmE5q4xt7UuIUHeOeVe1bKUYpPcdJobpEULr5VeECbHD51SBIj+fOPo+ZHqtjPc7Im3i0u9KwLsFeUq7r4qT9D9EBcpvpL2dsa8uoqzvNkTEFUjWuGrMPS0ZjhmiqCLE5Dqx+lFRITdHjTXDGY5ZgK4IzY97cyBvBGYyp/i6bxTcSbyS0t2zBH8X+F8SIuTjFFb+hx9At7AWSeAvpvNWM9oS0bhhywLb/zCjF5jvXCalcEWYh7JhitDk9TRr/l9QGcRHhLH1QxEL3QBL9Ce5buw5URvYeR9HvIJwWhD/eLyaKG77R6Nvg/fQFqVPhlId8UNFCNFWZ1w6v2yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JczlyPAE5K/erkiqNGqhUSsdcGRmj8lKTsw9c1HcXwo=;
 b=nNflGAWYPKVPPRGPG6d8LypUH+kFcZmSMkNQQjM5qr+pzpDkJPTlyEZS4YqE6XaJsCKOgwu+xrzDthWYDL4m/2+jMom2FjtfDCB9pyQ2UYTKOuHk0GF0v1nMcEjVCuiIjrtn6F/BSOBjrDxJ1RrvD+7bkermrK4OZj+SHrPx5CXi0NVSHUz0Bl66/2YtVVOYldpysTSxsGtrfu6T1bHfIyrChq1Jo3oSfiK7s//DjBbtqVZjPBuTfwMdUFdfgTFoYreonK0bFhnqhL0z2arlNUbEMl15CBavaDL3f5hFHppNFK4tPHNuRHzgA7/eNbdPWqiRF/pnOOYiHHLIMA8iXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JczlyPAE5K/erkiqNGqhUSsdcGRmj8lKTsw9c1HcXwo=;
 b=wSMkQMVNXvwa9eVVCvwgVYebSGOvFLSADMc5Zf+Yo/IPbhdQhRBguLYYJMO013M1FvAKtIycxn99H7aZyVW49hvmPfchHMXMZee8DMsm26L86/w0eGUumzbWvww9K1yjsLG9cLv2KijpneyiQ37Q8DO7lDmT4bHHxqsGjyXXkJo=
Received: from MW4P222CA0015.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::20)
 by IA1PR12MB6187.namprd12.prod.outlook.com (2603:10b6:208:3e5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Tue, 31 Jan
 2023 08:41:08 +0000
Received: from CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:114:cafe::c0) by MW4P222CA0015.outlook.office365.com
 (2603:10b6:303:114::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36 via Frontend
 Transport; Tue, 31 Jan 2023 08:41:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT009.mail.protection.outlook.com (10.13.175.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6043.21 via Frontend Transport; Tue, 31 Jan 2023 08:41:07 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 31 Jan
 2023 02:41:06 -0600
Received: from xhdipdslab41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 31 Jan 2023 02:40:58 -0600
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
        <ndesaulniers@google.com>, <rdunlap@infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kbuild@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <okaya@kernel.org>, <harpreet.anand@amd.com>,
        <nikhil.agarwal@amd.com>, <michal.simek@amd.com>, <git@amd.com>,
        Nipun Gupta <nipun.gupta@amd.com>
Subject: [PATCH v7 1/7] cdx: add the cdx bus driver
Date:   Tue, 31 Jan 2023 14:10:43 +0530
Message-ID: <20230131084049.23698-2-nipun.gupta@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230131084049.23698-1-nipun.gupta@amd.com>
References: <20230131084049.23698-1-nipun.gupta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT009:EE_|IA1PR12MB6187:EE_
X-MS-Office365-Filtering-Correlation-Id: fcdb13c8-66fb-45ed-61ff-08db0366e5bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g9KrsE8pIG52bAV2QTHbYH0kwySF6yET6D9/C+gvVi5G9fd8fmY+L7iqhT6d21hjxsyJB+NNDreaFydZPo2uLL7QU9j7XtRTjNJbSGFgGTN1jXSW8pOzL32cGdr9NDpdxj08uV27mK1RMrLzb5MSKJeBMLJQ4nY7j2xPYJKtULW2aAlrdr3HEBpxzJACp3fgj/bPUmEd/l5kJWLfyC7+iWJRwmsxvyyXqd/qUa5yoVbqoHYyoLqMVNlufx4qAQaHKlQQPyzbMA1BRmL7eGEKNEOm8wchSfJd81krbyYYTzLwvB23JR8aXI3qHD6q/cp7ST/QFHLGLJfo6f6SAkNl4o8EDWR9nZwlyqk9VQjMjkrCOAmz+cYQIbz4qeVcOqfUBn1VtXYdvrzOqcC/7IItLwjz5QtgRhWsAAEAUEHW80qRthNf1PXjrktJYygNkhMsy5qxCq2IGbn2KWiFSYi4AKx8CjEfoglGsbg8k6u4xJhwINBFQJt4pSaV2fFlSBspziqqEy3VYMiqEnr1qeRjmziDvDP692I3M+JaNLFb1kJvJU8iD/NDse/NRTCXRdJ9YVNDha5T8uR2r6tdn9HaFO2CeIPVyIyWtIwtfNMPHVFwVzsQG/agfySqFlS1SOkurf3JGlQZ3Eu2FmT0HEGh/Lqpg3gmF6iHTR2EWjz2be65KDg+5t5gZH8L+aqj+L3HjhE6vXi0EjeWvDVQkTZRb61T1WUrZhPbRer93409n2qU7ACRJVvhL5NM6/JkLghADeTKcQjwztGRTv+oTW5gEvZC60GLcvQEJWc1d5DD9hfqcaw1zVfEOUzKOCi7pKmzNIxLkIbClgApKzDdGFYlWQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(136003)(396003)(39860400002)(451199018)(36840700001)(40470700004)(46966006)(2906002)(7416002)(86362001)(30864003)(356005)(81166007)(921005)(5660300002)(8936002)(36860700001)(41300700001)(82740400003)(40480700001)(82310400005)(4326008)(44832011)(47076005)(316002)(426003)(110136005)(336012)(2616005)(83380400001)(8676002)(70206006)(70586007)(1076003)(36756003)(186003)(26005)(54906003)(478600001)(40460700003)(966005)(6666004)(83996005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 08:41:07.7370
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fcdb13c8-66fb-45ed-61ff-08db0366e5bc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6187
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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
---

CDX bus module is kept as bool and not as a tristate as IOMMU
does not support buses with module compilation. Buses are provided
to IOMMU at compile time only.

 Documentation/ABI/testing/sysfs-bus-cdx |  12 +
 MAINTAINERS                             |   7 +
 drivers/Kconfig                         |   2 +
 drivers/Makefile                        |   1 +
 drivers/cdx/Kconfig                     |  17 +
 drivers/cdx/Makefile                    |   8 +
 drivers/cdx/cdx.c                       | 408 ++++++++++++++++++++++++
 drivers/cdx/cdx.h                       |  62 ++++
 include/linux/cdx/cdx_bus.h             | 147 +++++++++
 include/linux/mod_devicetable.h         |  15 +
 scripts/mod/devicetable-offsets.c       |   4 +
 scripts/mod/file2alias.c                |  12 +
 12 files changed, 695 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-cdx
 create mode 100644 drivers/cdx/Kconfig
 create mode 100644 drivers/cdx/Makefile
 create mode 100644 drivers/cdx/cdx.c
 create mode 100644 drivers/cdx/cdx.h
 create mode 100644 include/linux/cdx/cdx_bus.h

diff --git a/Documentation/ABI/testing/sysfs-bus-cdx b/Documentation/ABI/testing/sysfs-bus-cdx
new file mode 100644
index 000000000000..b55248964c9a
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-cdx
@@ -0,0 +1,12 @@
+What:		/sys/bus/cdx/rescan
+Date:		January 2023
+Contact:	nipun.gupta@amd.com
+Description:
+		Writing a non-zero value to this file cause rescan of the bus
+		and devices on the CDX bus. Any new devices are scanned and
+		added to the list of Linux devices and any devices removed are
+		also deleted from Linux.
+
+		For example::
+
+		  # echo 1 > /sys/bus/cdx/rescan
diff --git a/MAINTAINERS b/MAINTAINERS
index 7d4677efcf02..3b31df9f6bb9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -964,6 +964,13 @@ Q:	https://patchwork.kernel.org/project/linux-rdma/list/
 F:	drivers/infiniband/hw/efa/
 F:	include/uapi/rdma/efa-abi.h
 
+AMD CDX BUS DRIVER
+M:	Nipun Gupta <nipun.gupta@amd.com>
+M:	Nikhil Agarwal <nikhil.agarwal@amd.com>
+S:	Maintained
+F:	drivers/cdx/*
+F:	include/linux/cdx/*
+
 AMD CRYPTOGRAPHIC COPROCESSOR (CCP) DRIVER
 M:	Tom Lendacky <thomas.lendacky@amd.com>
 M:	John Allen <john.allen@amd.com>
diff --git a/drivers/Kconfig b/drivers/Kconfig
index 968bd0a6fd78..514ae6b24cb2 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -241,4 +241,6 @@ source "drivers/peci/Kconfig"
 
 source "drivers/hte/Kconfig"
 
+source "drivers/cdx/Kconfig"
+
 endmenu
diff --git a/drivers/Makefile b/drivers/Makefile
index 6e3d527ca0c7..bf2b09ed849d 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -190,3 +190,4 @@ obj-$(CONFIG_MOST)		+= most/
 obj-$(CONFIG_PECI)		+= peci/
 obj-$(CONFIG_HTE)		+= hte/
 obj-$(CONFIG_DRM_ACCEL)		+= accel/
+obj-$(CONFIG_CDX_BUS)		+= cdx/
diff --git a/drivers/cdx/Kconfig b/drivers/cdx/Kconfig
new file mode 100644
index 000000000000..1aaee0ec5bd9
--- /dev/null
+++ b/drivers/cdx/Kconfig
@@ -0,0 +1,17 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# CDX bus configuration
+#
+# Copyright (C) 2022-2023, Advanced Micro Devices, Inc.
+#
+
+config CDX_BUS
+	bool "CDX Bus driver"
+	depends on OF && ARM64
+	help
+	  Driver to enable Composable DMA Transfer(CDX) Bus. CDX bus
+	  exposes Fabric devices which uses composable DMA IP to the
+	  APU. CDX bus provides a mechanism for scanning and probing
+	  of CDX devices. CDX devices are memory mapped on system bus
+	  for embedded CPUs. CDX bus uses CDX controller and firmware
+	  to scan these CDX devices.
diff --git a/drivers/cdx/Makefile b/drivers/cdx/Makefile
new file mode 100644
index 000000000000..c5feb11fc718
--- /dev/null
+++ b/drivers/cdx/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for CDX
+#
+# Copyright (C) 2022-2023, Advanced Micro Devices, Inc.
+#
+
+obj-$(CONFIG_CDX_BUS) += cdx.o
diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
new file mode 100644
index 000000000000..795770522b01
--- /dev/null
+++ b/drivers/cdx/cdx.c
@@ -0,0 +1,408 @@
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
+#include <linux/xarray.h>
+#include <linux/cdx/cdx_bus.h>
+#include "cdx.h"
+
+/* Default DMA mask for devices on a CDX bus */
+#define CDX_DEFAULT_DMA_MASK	(~0ULL)
+#define MAX_CDX_CONTROLLERS 16
+
+/* CDX controllers registered with the CDX bus */
+static DEFINE_XARRAY_ALLOC(cdx_controllers);
+
+/**
+ * cdx_unregister_device - Unregister a CDX device
+ * @dev: CDX device
+ * @data: This is always passed as NULL, and is not used in this API,
+ *	  but is required here as the bus_for_each_dev() API expects
+ *	  the passed function (cdx_unregister_device) to have this
+ *	  as an argument.
+ *
+ * Return: -errno on failure, 0 on success.
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
+ * Return: matching cdx_device_id structure or NULL if there is no match.
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
+ * Return: matching cdx_device_id structure or NULL if there is no match.
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
+ * Return: true on success, false otherwise.
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
+	unsigned long index, val = 0;
+	struct cdx_controller *cdx;
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
+	xa_for_each(&cdx_controllers, index, cdx) {
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
+int cdx_register_controller(struct cdx_controller *cdx)
+{
+	int ret;
+
+	ret = xa_alloc(&cdx_controllers, &cdx->id, cdx,
+		       XA_LIMIT(0, MAX_CDX_CONTROLLERS - 1), GFP_KERNEL);
+	if (ret < 0) {
+		dev_err(cdx->dev,
+			"No free index available. Maximum controllers already registered\n");
+		cdx->id = (u8)MAX_CDX_CONTROLLERS;
+		return ret;
+	}
+
+	/* Scan all the devices */
+	cdx->ops->scan(cdx);
+
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
+	xa_erase(&cdx_controllers, cdx->id);
+}
+EXPORT_SYMBOL_GPL(cdx_unregister_controller);
+
+static int __init cdx_bus_init(void)
+{
+	return bus_register(&cdx_bus_type);
+}
+postcore_initcall(cdx_bus_init);
diff --git a/drivers/cdx/cdx.h b/drivers/cdx/cdx.h
new file mode 100644
index 000000000000..c436ac7ac86f
--- /dev/null
+++ b/drivers/cdx/cdx.h
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
+ * Return: -errno on failure, 0 on success.
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
+ * Return: -errno on failure, 0 on success.
+ */
+int cdx_device_add(struct cdx_dev_params *dev_params);
+
+#endif /* _CDX_H_ */
diff --git a/include/linux/cdx/cdx_bus.h b/include/linux/cdx/cdx_bus.h
new file mode 100644
index 000000000000..d134e0104724
--- /dev/null
+++ b/include/linux/cdx/cdx_bus.h
@@ -0,0 +1,147 @@
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
+ * @dev: Linux device associated with the CDX controller.
+ * @priv: private data
+ * @id: Controller ID
+ * @ops: CDX controller ops
+ */
+struct cdx_controller {
+	struct device *dev;
+	void *priv;
+	u32 id;
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
+ * Return: -errno on failure, 0 on success.
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


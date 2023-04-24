Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 512926E7E1F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 17:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbjDSPVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 11:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233109AbjDSPVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 11:21:14 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on20610.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e89::610])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5A86A55;
        Wed, 19 Apr 2023 08:20:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=df4c5uyp6XzSI+QQquys+v1WRtUj+1gXoCnikIciiycKhJvll5oCV4MbLcu77nJWZ+n3X1xDYUw+RioQfC+qU17c3IuT0BhKwjAsuBhadhotSP+51w74TFz/5t86O5IZ6REiX9d+GUYc3xXlZnBFV2kKzFn8ELA4VL6HooPwllZn0fHWHrLpSFbS+1EuPaADa11sUoW7vWHLtQTJSO0rhOeoIRh3xSwcJIp34C40YGQwShm4mds0FheFq3boRlp5LMprljAzEpNZkxUrI72LpeDkfzBSpc3ejJ1qABgmlUNA4Ajc4PAcgoQqj5d7AX4xJ0I+Q6hORFT8ZsdSFtTNTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tx8lyqHqx9EL0crbs9xuR9YQRMoGqrPQy5xyf28GyHM=;
 b=AfXTKY+eRbclvtDTKKxfbqdLc1P7qpe/psngM+mTG95q6Qr3QEGcVJHUto+T1hXYnfoI1BSyBAhVUBfdHVQPa1X0PCUjL0f1xuin6iN+MRnxVkdNf4ecA5zZFhsUWzl7675d9TF9s1PQbET206gx+DeLUkHunnVTUQ57hztqaZbHGOTeLuiS7t7OX4sbRCWE7Ggcsf1aSq3y7BQI9GOvqf88mhjXgV9lGVLKhZqCMr/ZO3X83tot1dgzcKVIpEMBoCUDAQhcfClK56m/leVuJEnFqv/6+KX84R9m4EBhVwQybF2UXw2sUA+N74ArnJV0EH/fTSM21nspnTn++BHGvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tx8lyqHqx9EL0crbs9xuR9YQRMoGqrPQy5xyf28GyHM=;
 b=gWa/FkQBNIvDzGlXDJSmGiwNZ2HwVzvB1x1WzfTNlpmXhmJW+LRTL8/NL5XzBz8Q41M+PpiOsSZLGtnO2SfZFHLTLDBYeyqaFFWEfbFcGR4VLywibAJLout8uuluUUYY589sCgNqY2PjqsybP1i2+NbRYVNAMyGeY3LiaQjAhJE=
Received: from CY5PR19CA0089.namprd19.prod.outlook.com (2603:10b6:930:83::14)
 by BY5PR12MB4210.namprd12.prod.outlook.com (2603:10b6:a03:203::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Wed, 19 Apr
 2023 15:17:39 +0000
Received: from CY4PEPF0000C96E.namprd02.prod.outlook.com
 (2603:10b6:930:83:cafe::77) by CY5PR19CA0089.outlook.office365.com
 (2603:10b6:930:83::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22 via Frontend
 Transport; Wed, 19 Apr 2023 15:17:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000C96E.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6319.14 via Frontend Transport; Wed, 19 Apr 2023 15:17:38 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 19 Apr
 2023 10:17:38 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 19 Apr
 2023 10:17:37 -0500
Received: from xhdipdslab41.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 19 Apr 2023 10:17:33 -0500
From:   Nipun Gupta <nipun.gupta@amd.com>
To:     <alex.williamson@redhat.com>, <jgg@ziepe.ca>,
        <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
        <masahiroy@kernel.org>, <nathan@kernel.org>,
        <ndesaulniers@google.com>, <nicolas@fjasle.eu>
CC:     <git@amd.com>, <harpreet.anand@amd.com>,
        <pieter.jansen-van-vuuren@amd.com>, <nikhil.agarwal@amd.com>,
        <michal.simek@amd.com>, Nipun Gupta <nipun.gupta@amd.com>
Subject: [PATCH v5] vfio/cdx: add support for CDX bus
Date:   Wed, 19 Apr 2023 20:47:30 +0530
Message-ID: <20230419151730.15176-1-nipun.gupta@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C96E:EE_|BY5PR12MB4210:EE_
X-MS-Office365-Filtering-Correlation-Id: e1536d18-9678-4931-20d9-08db40e9365a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TTU8LeTo0Rgdej6GmMksQPeo15oWkyglFaWdRoODFSaL8kK1j5CAvA5BGFDUjBKFhLkeqh7558RXQL0sTQYEWDfsNusgp9ciTT16dDFpb63hvg0/HnKlqE3xaFwxcaIxE2koyL09AIYinwDsQBg9EBtPxxKlBHfbusNXvT0whqiKfMAyNj2bY94Uw0McrQzUGgmEnXcfE64IK7n/b7B7JKKaT4QoU1NflTWxabzpZx0tKMcQHrBCvzi8Z4NQfZrXJMMiuAB3TpVpDFU0JWjHSH/1iwUFJWNc8OqlSf9FkOmBx9r1iRoL9EL+HxWeNpLRjoUg6SM1Fe9GXHEPHiaB5z8yCQWnrSxWGK1pTPcQuRytH+4rZxnpA5N+FufyTVvTkoY516nPkiWWhnzQftPhX+aZ85fYQYIKu8P2pJlrGjYAjn5RodksQt6Wfw016pGk4EIFYM47YDwQK1W79B2411F1181obJKxQ4i+LkfOgqbImJMImHy9qcJK0HPci1aK/YVpaSv2nRCenl0HjqCYXVzLhuhcYWCmKycvm3bhB7eGs2wR6h8wURPt6SJgFF5ksx2JvhURIOQaYZkBr6ySmTKbcHlmJraJIZYE4xEL7fxTvFhGnllihVaCUfeydQs4tySrn+oBE9Jk341ec40X/AV6/4YyshPniLI6Be4rUD1u2DCbI/aRNcZYYmqHg6WkzfWPCiC5fF+O3D1kqK/n2lgDCN3Z0pu0rEq7TMlcQeO4fd6avsKj8bgMheDBj2Yc
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(346002)(376002)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(2906002)(40460700003)(30864003)(8936002)(8676002)(44832011)(5660300002)(36756003)(82310400005)(86362001)(40480700001)(1076003)(26005)(110136005)(54906003)(478600001)(2616005)(36860700001)(83380400001)(47076005)(336012)(426003)(186003)(316002)(82740400003)(4326008)(70586007)(70206006)(356005)(81166007)(41300700001)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2023 15:17:38.5553
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1536d18-9678-4931-20d9-08db40e9365a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C96E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4210
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vfio-cdx driver enables IOCTLs for user space to query
MMIO regions for CDX devices and mmap them. This change
also adds support for reset of CDX devices.

This change adds the VFIO CDX driver and enables the following
ioctls for CDX devices:
 - VFIO_DEVICE_GET_INFO:
 - VFIO_DEVICE_GET_REGION_INFO
 - VFIO_DEVICE_RESET

Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
Reviewed-by: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
Tested-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
---

Changes v4->v5:
- renamed vfio_cdx.c to main.c and vfio_cdx_private.h
  to private.h
- have separate functions for get_info and get_region_info

Changes v3->v4:
- fix vfio info flags

Changes v2->v3:
- removed redundant init and release functions
- removed redundant dev and cdx_dev from vfio_cdx_device
- added support for iommufd
- added VFIO_DEVICE_FLAGS_CDX
- removed unrequried WARN_ON
- removed unused ioaddr

Changes v1->v2:
- Updated file2alias to support vfio_cdx
- removed some un-necessary checks in mmap
- removed vfio reset wrapper API
- converted complex macros to static APIs
- used pgprot_device and io_remap_pfn_range

 MAINTAINERS                       |   7 +
 drivers/vfio/Kconfig              |   1 +
 drivers/vfio/Makefile             |   1 +
 drivers/vfio/cdx/Kconfig          |  17 ++
 drivers/vfio/cdx/Makefile         |   8 +
 drivers/vfio/cdx/main.c           | 275 ++++++++++++++++++++++++++++++
 drivers/vfio/cdx/private.h        |  28 +++
 include/linux/cdx/cdx_bus.h       |   1 -
 include/linux/mod_devicetable.h   |   6 +
 include/uapi/linux/vfio.h         |   1 +
 scripts/mod/devicetable-offsets.c |   1 +
 scripts/mod/file2alias.c          |  17 +-
 12 files changed, 361 insertions(+), 2 deletions(-)
 create mode 100644 drivers/vfio/cdx/Kconfig
 create mode 100644 drivers/vfio/cdx/Makefile
 create mode 100644 drivers/vfio/cdx/main.c
 create mode 100644 drivers/vfio/cdx/private.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 7f74d8571ac9..c4fd42ba8f46 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22064,6 +22064,13 @@ F:	Documentation/filesystems/vfat.rst
 F:	fs/fat/
 F:	tools/testing/selftests/filesystems/fat/
 
+VFIO CDX DRIVER
+M:	Nipun Gupta <nipun.gupta@amd.com>
+M:	Nikhil Agarwal <nikhil.agarwal@amd.com>
+L:	kvm@vger.kernel.org
+S:	Maintained
+F:	drivers/vfio/cdx/*
+
 VFIO DRIVER
 M:	Alex Williamson <alex.williamson@redhat.com>
 L:	kvm@vger.kernel.org
diff --git a/drivers/vfio/Kconfig b/drivers/vfio/Kconfig
index 89e06c981e43..aba36f5be4ec 100644
--- a/drivers/vfio/Kconfig
+++ b/drivers/vfio/Kconfig
@@ -57,6 +57,7 @@ source "drivers/vfio/pci/Kconfig"
 source "drivers/vfio/platform/Kconfig"
 source "drivers/vfio/mdev/Kconfig"
 source "drivers/vfio/fsl-mc/Kconfig"
+source "drivers/vfio/cdx/Kconfig"
 endif
 
 source "virt/lib/Kconfig"
diff --git a/drivers/vfio/Makefile b/drivers/vfio/Makefile
index 70e7dcb302ef..1a27b2516612 100644
--- a/drivers/vfio/Makefile
+++ b/drivers/vfio/Makefile
@@ -14,3 +14,4 @@ obj-$(CONFIG_VFIO_PCI) += pci/
 obj-$(CONFIG_VFIO_PLATFORM) += platform/
 obj-$(CONFIG_VFIO_MDEV) += mdev/
 obj-$(CONFIG_VFIO_FSL_MC) += fsl-mc/
+obj-$(CONFIG_VFIO_CDX) += cdx/
diff --git a/drivers/vfio/cdx/Kconfig b/drivers/vfio/cdx/Kconfig
new file mode 100644
index 000000000000..e6de0a0caa32
--- /dev/null
+++ b/drivers/vfio/cdx/Kconfig
@@ -0,0 +1,17 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# VFIO CDX configuration
+#
+# Copyright (C) 2022-2023, Advanced Micro Devices, Inc.
+#
+
+config VFIO_CDX
+	tristate "VFIO support for CDX bus devices"
+	depends on CDX_BUS
+	select EVENTFD
+	help
+	  Driver to enable VFIO support for the devices on CDX bus.
+	  This is required to make use of CDX devices present in
+	  the system using the VFIO framework.
+
+	  If you don't know what to do here, say N.
diff --git a/drivers/vfio/cdx/Makefile b/drivers/vfio/cdx/Makefile
new file mode 100644
index 000000000000..cd4a2e6fe609
--- /dev/null
+++ b/drivers/vfio/cdx/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (C) 2022-2023, Advanced Micro Devices, Inc.
+#
+
+obj-$(CONFIG_VFIO_CDX) += vfio-cdx.o
+
+vfio-cdx-objs := main.o
diff --git a/drivers/vfio/cdx/main.c b/drivers/vfio/cdx/main.c
new file mode 100644
index 000000000000..d5af6913658d
--- /dev/null
+++ b/drivers/vfio/cdx/main.c
@@ -0,0 +1,275 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2022-2023, Advanced Micro Devices, Inc.
+ */
+
+#include <linux/vfio.h>
+#include <linux/cdx/cdx_bus.h>
+
+#include "private.h"
+
+static struct cdx_driver vfio_cdx_driver;
+
+/**
+ * CDX_DRIVER_OVERRIDE_DEVICE_VFIO - macro used to describe a VFIO
+ *                                   "driver_override" CDX device.
+ * @vend: the 16 bit CDX Vendor ID
+ * @dev: the 16 bit CDX Device ID
+ *
+ * This macro is used to create a struct cdx_device_id that matches a
+ * specific device. driver_override will be set to
+ * CDX_ID_F_VFIO_DRIVER_OVERRIDE.
+ */
+#define CDX_DRIVER_OVERRIDE_DEVICE_VFIO(vend, dev) \
+	CDX_DEVICE_DRIVER_OVERRIDE(vend, dev, CDX_ID_F_VFIO_DRIVER_OVERRIDE)
+
+static int vfio_cdx_open_device(struct vfio_device *core_vdev)
+{
+	struct vfio_cdx_device *vdev =
+		container_of(core_vdev, struct vfio_cdx_device, vdev);
+	struct cdx_device *cdx_dev = to_cdx_device(core_vdev->dev);
+	int count = cdx_dev->res_count;
+	int i;
+
+	vdev->regions = kcalloc(count, sizeof(struct vfio_cdx_region),
+				GFP_KERNEL);
+	if (!vdev->regions)
+		return -ENOMEM;
+
+	for (i = 0; i < count; i++) {
+		struct resource *res = &cdx_dev->res[i];
+
+		vdev->regions[i].addr = res->start;
+		vdev->regions[i].size = resource_size(res);
+		vdev->regions[i].type = res->flags;
+		/*
+		 * Only regions addressed with PAGE granularity may be
+		 * MMAP'ed securely.
+		 */
+		if (!(vdev->regions[i].addr & ~PAGE_MASK) &&
+		    !(vdev->regions[i].size & ~PAGE_MASK))
+			vdev->regions[i].flags |=
+					VFIO_REGION_INFO_FLAG_MMAP;
+		vdev->regions[i].flags |= VFIO_REGION_INFO_FLAG_READ;
+		if (!(cdx_dev->res[i].flags & IORESOURCE_READONLY))
+			vdev->regions[i].flags |= VFIO_REGION_INFO_FLAG_WRITE;
+	}
+
+	return 0;
+}
+
+static void vfio_cdx_regions_cleanup(struct vfio_cdx_device *vdev)
+{
+	kfree(vdev->regions);
+}
+
+static void vfio_cdx_close_device(struct vfio_device *core_vdev)
+{
+	struct vfio_cdx_device *vdev =
+		container_of(core_vdev, struct vfio_cdx_device, vdev);
+	int ret;
+
+	vfio_cdx_regions_cleanup(vdev);
+
+	/* reset the device before cleaning up the interrupts */
+	ret = cdx_dev_reset(core_vdev->dev);
+	if (ret)
+		dev_warn(core_vdev->dev,
+			 "VFIO_CDX: reset device has failed (%d)\n", ret);
+}
+
+static int vfio_cdx_ioctl_get_info(struct vfio_cdx_device *vdev,
+				   struct vfio_device_info __user *arg)
+{
+	unsigned long minsz = offsetofend(struct vfio_device_info, num_irqs);
+	struct cdx_device *cdx_dev = to_cdx_device(vdev->vdev.dev);
+	struct vfio_device_info info;
+
+	if (copy_from_user(&info, arg, minsz))
+		return -EFAULT;
+
+	if (info.argsz < minsz)
+		return -EINVAL;
+
+	info.flags = VFIO_DEVICE_FLAGS_CDX;
+	info.flags |= VFIO_DEVICE_FLAGS_RESET;
+
+	info.num_regions = cdx_dev->res_count;
+	info.num_irqs = 0;
+
+	return copy_to_user(arg, &info, minsz) ? -EFAULT : 0;
+}
+
+static int vfio_cdx_ioctl_get_region_info(struct vfio_cdx_device *vdev,
+					  struct vfio_region_info __user *arg)
+{
+	unsigned long minsz = offsetofend(struct vfio_region_info, offset);
+	struct cdx_device *cdx_dev = to_cdx_device(vdev->vdev.dev);
+	struct vfio_region_info info;
+
+	if (copy_from_user(&info, arg, minsz))
+		return -EFAULT;
+
+	if (info.argsz < minsz)
+		return -EINVAL;
+
+	if (info.index >= cdx_dev->res_count)
+		return -EINVAL;
+
+	/* map offset to the physical address  */
+	info.offset = vfio_cdx_index_to_offset(info.index);
+	info.size = vdev->regions[info.index].size;
+	info.flags = vdev->regions[info.index].flags;
+
+	if (copy_to_user(arg, &info, minsz))
+		return -EFAULT;
+	return 0;
+}
+
+static long vfio_cdx_ioctl(struct vfio_device *core_vdev,
+			   unsigned int cmd, unsigned long arg)
+{
+	struct vfio_cdx_device *vdev =
+		container_of(core_vdev, struct vfio_cdx_device, vdev);
+	void __user *uarg = (void __user *)arg;
+
+	switch (cmd) {
+	case VFIO_DEVICE_GET_INFO:
+		return vfio_cdx_ioctl_get_info(vdev, uarg);
+	case VFIO_DEVICE_GET_REGION_INFO:
+		return vfio_cdx_ioctl_get_region_info(vdev, uarg);
+	case VFIO_DEVICE_RESET:
+		return cdx_dev_reset(core_vdev->dev);
+	default:
+		return -ENOTTY;
+	}
+}
+
+static int vfio_cdx_mmap_mmio(struct vfio_cdx_region region,
+			      struct vm_area_struct *vma)
+{
+	u64 size = vma->vm_end - vma->vm_start;
+	u64 pgoff, base;
+
+	pgoff = vma->vm_pgoff &
+		((1U << (VFIO_CDX_OFFSET_SHIFT - PAGE_SHIFT)) - 1);
+	base = pgoff << PAGE_SHIFT;
+
+	if (region.size < PAGE_SIZE || base + size > region.size)
+		return -EINVAL;
+
+	vma->vm_pgoff = (region.addr >> PAGE_SHIFT) + pgoff;
+	vma->vm_page_prot = pgprot_device(vma->vm_page_prot);
+
+	return io_remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
+				  size, vma->vm_page_prot);
+}
+
+static int vfio_cdx_mmap(struct vfio_device *core_vdev,
+			 struct vm_area_struct *vma)
+{
+	struct vfio_cdx_device *vdev =
+		container_of(core_vdev, struct vfio_cdx_device, vdev);
+	struct cdx_device *cdx_dev = to_cdx_device(core_vdev->dev);
+	unsigned int index;
+
+	index = vma->vm_pgoff >> (VFIO_CDX_OFFSET_SHIFT - PAGE_SHIFT);
+
+	if (index >= cdx_dev->res_count)
+		return -EINVAL;
+
+	if (!(vdev->regions[index].flags & VFIO_REGION_INFO_FLAG_MMAP))
+		return -EINVAL;
+
+	if (!(vdev->regions[index].flags & VFIO_REGION_INFO_FLAG_READ) &&
+	    (vma->vm_flags & VM_READ))
+		return -EINVAL;
+
+	if (!(vdev->regions[index].flags & VFIO_REGION_INFO_FLAG_WRITE) &&
+	    (vma->vm_flags & VM_WRITE))
+		return -EINVAL;
+
+	return vfio_cdx_mmap_mmio(vdev->regions[index], vma);
+}
+
+static const struct vfio_device_ops vfio_cdx_ops = {
+	.name		= "vfio-cdx",
+	.open_device	= vfio_cdx_open_device,
+	.close_device	= vfio_cdx_close_device,
+	.ioctl		= vfio_cdx_ioctl,
+	.mmap		= vfio_cdx_mmap,
+	.bind_iommufd	= vfio_iommufd_physical_bind,
+	.unbind_iommufd	= vfio_iommufd_physical_unbind,
+	.attach_ioas	= vfio_iommufd_physical_attach_ioas,
+};
+
+static int vfio_cdx_probe(struct cdx_device *cdx_dev)
+{
+	struct vfio_cdx_device *vdev = NULL;
+	struct device *dev = &cdx_dev->dev;
+	int ret;
+
+	vdev = vfio_alloc_device(vfio_cdx_device, vdev, dev,
+				 &vfio_cdx_ops);
+	if (IS_ERR(vdev))
+		return PTR_ERR(vdev);
+
+	ret = vfio_register_group_dev(&vdev->vdev);
+	if (ret) {
+		dev_err(dev, "VFIO_CDX: Failed to add to vfio group\n");
+		goto out_uninit;
+	}
+
+	dev_set_drvdata(dev, vdev);
+	return 0;
+
+out_uninit:
+	vfio_put_device(&vdev->vdev);
+	return ret;
+}
+
+static int vfio_cdx_remove(struct cdx_device *cdx_dev)
+{
+	struct device *dev = &cdx_dev->dev;
+	struct vfio_cdx_device *vdev;
+
+	vdev = dev_get_drvdata(dev);
+	vfio_unregister_group_dev(&vdev->vdev);
+	vfio_put_device(&vdev->vdev);
+
+	return 0;
+}
+
+static const struct cdx_device_id vfio_cdx_table[] = {
+	{ CDX_DRIVER_OVERRIDE_DEVICE_VFIO(CDX_ANY_ID, CDX_ANY_ID) }, /* match all by default */
+	{}
+};
+
+MODULE_DEVICE_TABLE(cdx, vfio_cdx_table);
+
+static struct cdx_driver vfio_cdx_driver = {
+	.probe		= vfio_cdx_probe,
+	.remove		= vfio_cdx_remove,
+	.match_id_table	= vfio_cdx_table,
+	.driver	= {
+		.name	= "vfio-cdx",
+		.owner	= THIS_MODULE,
+	},
+	.driver_managed_dma = true,
+};
+
+static int __init vfio_cdx_driver_init(void)
+{
+	return cdx_driver_register(&vfio_cdx_driver);
+}
+
+static void __exit vfio_cdx_driver_exit(void)
+{
+	cdx_driver_unregister(&vfio_cdx_driver);
+}
+
+module_init(vfio_cdx_driver_init);
+module_exit(vfio_cdx_driver_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("VFIO for CDX devices - User Level meta-driver");
diff --git a/drivers/vfio/cdx/private.h b/drivers/vfio/cdx/private.h
new file mode 100644
index 000000000000..8bdc117ea88e
--- /dev/null
+++ b/drivers/vfio/cdx/private.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2022-2023, Advanced Micro Devices, Inc.
+ */
+
+#ifndef VFIO_CDX_PRIVATE_H
+#define VFIO_CDX_PRIVATE_H
+
+#define VFIO_CDX_OFFSET_SHIFT    40
+
+static inline u64 vfio_cdx_index_to_offset(u32 index)
+{
+	return ((u64)(index) << VFIO_CDX_OFFSET_SHIFT);
+}
+
+struct vfio_cdx_region {
+	u32			flags;
+	u32			type;
+	u64			addr;
+	resource_size_t		size;
+};
+
+struct vfio_cdx_device {
+	struct vfio_device	vdev;
+	struct vfio_cdx_region	*regions;
+};
+
+#endif /* VFIO_CDX_PRIVATE_H */
diff --git a/include/linux/cdx/cdx_bus.h b/include/linux/cdx/cdx_bus.h
index 35ef41d8a61a..bead71b7bc73 100644
--- a/include/linux/cdx/cdx_bus.h
+++ b/include/linux/cdx/cdx_bus.h
@@ -14,7 +14,6 @@
 #include <linux/mod_devicetable.h>
 
 #define MAX_CDX_DEV_RESOURCES	4
-#define CDX_ANY_ID (0xFFFF)
 #define CDX_CONTROLLER_ID_SHIFT 4
 #define CDX_BUS_NUM_MASK 0xF
 
diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index ccaaeda792c0..ccf017353bb6 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -912,6 +912,12 @@ struct ishtp_device_id {
 	kernel_ulong_t driver_data;
 };
 
+#define CDX_ANY_ID (0xFFFF)
+
+enum {
+	CDX_ID_F_VFIO_DRIVER_OVERRIDE = 1,
+};
+
 /**
  * struct cdx_device_id - CDX device identifier
  * @vendor: Vendor ID
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 0552e8dcf0cb..8e91aaf973e7 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -213,6 +213,7 @@ struct vfio_device_info {
 #define VFIO_DEVICE_FLAGS_AP	(1 << 5)	/* vfio-ap device */
 #define VFIO_DEVICE_FLAGS_FSL_MC (1 << 6)	/* vfio-fsl-mc device */
 #define VFIO_DEVICE_FLAGS_CAPS	(1 << 7)	/* Info supports caps */
+#define VFIO_DEVICE_FLAGS_CDX	(1 << 8)	/* vfio-cdx device */
 	__u32	num_regions;	/* Max region index + 1 */
 	__u32	num_irqs;	/* Max IRQ index + 1 */
 	__u32   cap_offset;	/* Offset within info struct of first cap */
diff --git a/scripts/mod/devicetable-offsets.c b/scripts/mod/devicetable-offsets.c
index 62dc988df84d..abe65f8968dd 100644
--- a/scripts/mod/devicetable-offsets.c
+++ b/scripts/mod/devicetable-offsets.c
@@ -265,6 +265,7 @@ int main(void)
 	DEVID(cdx_device_id);
 	DEVID_FIELD(cdx_device_id, vendor);
 	DEVID_FIELD(cdx_device_id, device);
+	DEVID_FIELD(cdx_device_id, override_only);
 
 	return 0;
 }
diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
index 28da34ba4359..38120f932b0d 100644
--- a/scripts/mod/file2alias.c
+++ b/scripts/mod/file2alias.c
@@ -1458,8 +1458,23 @@ static int do_cdx_entry(const char *filename, void *symval,
 {
 	DEF_FIELD(symval, cdx_device_id, vendor);
 	DEF_FIELD(symval, cdx_device_id, device);
+	DEF_FIELD(symval, cdx_device_id, override_only);
 
-	sprintf(alias, "cdx:v%08Xd%08Xd", vendor, device);
+	switch (override_only) {
+	case 0:
+		strcpy(alias, "cdx:");
+		break;
+	case CDX_ID_F_VFIO_DRIVER_OVERRIDE:
+		strcpy(alias, "vfio_cdx:");
+		break;
+	default:
+		warn("Unknown CDX driver_override alias %08X\n",
+		     override_only);
+		return 0;
+	}
+
+	ADD(alias, "v", vendor != CDX_ANY_ID, vendor);
+	ADD(alias, "d", device != CDX_ANY_ID, device);
 	return 1;
 }
 
-- 
2.17.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53E1A682740
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 09:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbjAaIqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 03:46:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231995AbjAaIqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 03:46:08 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on20608.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::608])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2460346174;
        Tue, 31 Jan 2023 00:42:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dp4T5UCIMWmMTdzF4VmKA15yqQvvv7ppeTfMERJj+vrQbvjhlm3Nxp1MaNQgnhUNbm/FzFcOl+ltpkHFHLQzUBGvdUIHWNPAOW7Qgvgg9nJdV5WkLtcB/0gBb+jlTMcF/FnGWhAqpiw3AIDPN2LhMgtbK3Ty5jXNMyba+W17LjwUZ/UrcsAiqEwIJjNGqkfcAc4GblT/L2ZIYFNPynC5TZK4/pAjIxDeeS4NGLND9DM5y7lRpwNZMx2MAKq+gj2nGsPmoCYEhveXgaJUwnw6+1jKDprUJqvblNBFZRQPvE7vvfHETGtOzxxRTWO112Rc14V/EVG+CX/Tv/EPKLGvmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HbEJL+/8RkiLx89ULZXle2x43xi6Ey3oV6st+atuTKI=;
 b=bkX4fSxq1G97eVsa24ZUpn1bhwqYHS3HWMQa5UEG/gk5S0wxrqLlBU+NEOpsRDpeelTjGjXG4UoVc25Ki6LRQziboBpvG/hDDhSz7GHIQD054D/e/jPc5abdxSE83PPp+IFdpcq5gEsJRAW13aTzymXTdxo8IH8uS0CLWF3tNmek6gp/0tI0OOcDUq8qCuk/d02+q3VzuBfDs+RAllrZLIbPYwZCGvhmvCoDJDMbp/VF47mE4N8O6ZpVLaEyJYRLRjz4pNYsnqrb6P6zTR408MFfKhneFbHEn4QSJYz4rTqOU5ntuquuIM1R+hbtCoKfZcj/U9aik88DKUCvwjQxlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HbEJL+/8RkiLx89ULZXle2x43xi6Ey3oV6st+atuTKI=;
 b=Y1/Mk8sekq6SxhaOEU6DEd3eio2cPV42nugJo78yJnI11fKSvagwBOU/69NczB09ZLDFFbKmMbe4CAJC3uJRr1xnKSAX5BH+d1H1BPPqQKQwsFM4Hc/Nw7nehdXTgxyjxFrohMNw1OdhVnfXf1sAqlN/waIEeX1Qz4qdGBb9+mI=
Received: from BN9PR03CA0747.namprd03.prod.outlook.com (2603:10b6:408:110::32)
 by PH0PR12MB7886.namprd12.prod.outlook.com (2603:10b6:510:26e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Tue, 31 Jan
 2023 08:41:42 +0000
Received: from BN8NAM11FT110.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:110:cafe::96) by BN9PR03CA0747.outlook.office365.com
 (2603:10b6:408:110::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36 via Frontend
 Transport; Tue, 31 Jan 2023 08:41:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT110.mail.protection.outlook.com (10.13.176.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6043.22 via Frontend Transport; Tue, 31 Jan 2023 08:41:42 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 31 Jan
 2023 02:41:41 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 31 Jan
 2023 02:41:41 -0600
Received: from xhdipdslab41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 31 Jan 2023 02:41:33 -0600
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
Subject: [PATCH v7 5/7] cdx: add cdx controller
Date:   Tue, 31 Jan 2023 14:10:47 +0530
Message-ID: <20230131084049.23698-6-nipun.gupta@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230131084049.23698-1-nipun.gupta@amd.com>
References: <20230131084049.23698-1-nipun.gupta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT110:EE_|PH0PR12MB7886:EE_
X-MS-Office365-Filtering-Correlation-Id: 94cedb34-39a8-477c-292e-08db0366fa19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BqppZvCdtI3wMtAXKdfc1wSxT9JXbuKb/MULEfqS0FCQHwNRAxow3hGXfrqHo1tcjqrBQW2TAq7CggAYq9qkRLpMeqfurrQCaxP2jBQs9z5OxAYi6fgX84aLWzGF63GdDBFrnkzZTFEXSXYJWkqMjHEbFvrAbqPZrH93IUo5GEFXl7aJJxrdaHaXflpGIjW6J4JP/GDv2lZg4ni5vMkG1VkZ7bLU7xCrCcnDGxU60LbIv4C8oNCUpsJPk3VddKxH1O4yVCpj+PXuibwpk5b1kuPdvrb6rt17+2IG08Sox+fL0EvfYSvF4eBaT8gZu/+X4vLKSmtfkLOry94e+01n7MXCev6ZGLngNSvlfaZybPVysPqKgJfwbHTpzZkvNEPIEm8QXTh+zdIdrEfYk4MIckh+JsOOpeM1JWvztFvcbsC5KIC7ijxamRn7JKmTW9hXhZw8gW2Xbbk3InN5Izy2PnI/DwMIjJ1T5dKpj7CyMxXtOwXewR51FHIAwR/jjhaACpi+DLTZUR2HX2BymLpypTMXe279SCsBAqZioLreW5o7auxIoAriCfiKwPT71l4uydnOpGFV9GJ33MNrNwZR9NBnQFW3U0AvUJq9KhNAYkQzRoQ3hZwcBwp8uafLd8kwtnaHefid139GPtJS0B8zD77/YCpkt98Vvsh8JgxZjWJP2hqZdTuJ775e39A3wE9pi0trXUd7Qaiv7pDYAuBZ0+SG9E7m2bRyARXM+u1fMsDAy+eKD/WN+CkLzjRGeqymkiy9Hn5+SLFtk27HgB1InXJcDDKMl30pk6yilo0b9sY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(346002)(39860400002)(376002)(451199018)(46966006)(40470700004)(36840700001)(2906002)(316002)(921005)(44832011)(30864003)(26005)(186003)(356005)(1076003)(81166007)(5660300002)(40460700003)(7416002)(36756003)(110136005)(54906003)(2616005)(6666004)(82310400005)(40480700001)(82740400003)(47076005)(426003)(336012)(83380400001)(86362001)(478600001)(4326008)(8676002)(70206006)(70586007)(8936002)(36860700001)(41300700001)(2101003)(83996005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 08:41:42.0088
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94cedb34-39a8-477c-292e-08db0366fa19
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT110.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7886
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CDX controller uses MCDI interface as a protocol to
communicate with the RPU firmware and registers the
detected CDX devices on the CDX bus. It also uses
RPMsg as the communication channel with the Firmware.

Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
Signed-off-by: Puneet Gupta <puneet.gupta@amd.com>
Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
Signed-off-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
---
 drivers/cdx/controller/Kconfig          |   9 ++
 drivers/cdx/controller/Makefile         |   2 +-
 drivers/cdx/controller/cdx_controller.c | 188 ++++++++++++++++++++++++
 drivers/cdx/controller/mcdi_functions.c | 125 ++++++++++++++++
 drivers/cdx/controller/mcdi_functions.h |  50 +++++++
 5 files changed, 373 insertions(+), 1 deletion(-)
 create mode 100644 drivers/cdx/controller/cdx_controller.c
 create mode 100644 drivers/cdx/controller/mcdi_functions.c
 create mode 100644 drivers/cdx/controller/mcdi_functions.h

diff --git a/drivers/cdx/controller/Kconfig b/drivers/cdx/controller/Kconfig
index 785c71063b2a..17f9c6be2fe1 100644
--- a/drivers/cdx/controller/Kconfig
+++ b/drivers/cdx/controller/Kconfig
@@ -7,6 +7,15 @@
 
 if CDX_BUS
 
+config CDX_CONTROLLER
+	tristate "CDX bus controller"
+	help
+	  CDX controller drives the CDX bus. It interacts with
+	  firmware to get the hardware devices and registers with
+	  the CDX bus. Say Y to enable the CDX hardware driver.
+
+	  If unsure, say N.
+
 config MCDI_LOGGING
 	bool "MCDI Logging for the CDX controller"
 	depends on CDX_CONTROLLER
diff --git a/drivers/cdx/controller/Makefile b/drivers/cdx/controller/Makefile
index 0ce200678eda..f7437c882cc9 100644
--- a/drivers/cdx/controller/Makefile
+++ b/drivers/cdx/controller/Makefile
@@ -6,4 +6,4 @@
 #
 
 obj-$(CONFIG_CDX_CONTROLLER) += cdx-controller.o
-cdx-controller-objs := mcdi.o
+cdx-controller-objs := cdx_controller.o mcdi.o mcdi_functions.o
diff --git a/drivers/cdx/controller/cdx_controller.c b/drivers/cdx/controller/cdx_controller.c
new file mode 100644
index 000000000000..b27be2097305
--- /dev/null
+++ b/drivers/cdx/controller/cdx_controller.c
@@ -0,0 +1,188 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * CDX host controller driver for AMD versal-net platform.
+ *
+ * Copyright (C) 2022-2023, Advanced Micro Devices, Inc.
+ */
+
+#include <linux/of_platform.h>
+#include <linux/slab.h>
+#include <linux/cdx/cdx_bus.h>
+
+#include "../cdx.h"
+#include "mcdi_functions.h"
+#include "mcdi.h"
+
+static unsigned int cdx_mcdi_rpc_timeout(struct cdx_mcdi *cdx, unsigned int cmd)
+{
+	return MCDI_RPC_TIMEOUT;
+}
+
+static void cdx_mcdi_request(struct cdx_mcdi *cdx,
+			     const struct cdx_dword *hdr, size_t hdr_len,
+			     const struct cdx_dword *sdu, size_t sdu_len)
+{
+	/*
+	 * This will get updated by rpmsg APIs, with RPMSG introduction
+	 * in CDX controller as a transport layer.
+	 */
+}
+
+static const struct cdx_mcdi_ops mcdi_ops = {
+	.mcdi_rpc_timeout = cdx_mcdi_rpc_timeout,
+	.mcdi_request = cdx_mcdi_request,
+};
+
+static int cdx_scan_devices(struct cdx_controller *cdx)
+{
+	struct cdx_mcdi *cdx_mcdi = cdx->priv;
+	u8 bus_num, dev_num, num_cdx_bus;
+	int ret;
+
+	/* MCDI FW Read: Fetch the number of CDX buses on this controller */
+	ret = cdx_mcdi_get_num_buses(cdx_mcdi);
+	if (ret < 0) {
+		dev_err(cdx->dev,
+			"Get number of CDX buses failed: %d\n", ret);
+		return ret;
+	}
+	num_cdx_bus = (u8)ret;
+
+	for (bus_num = 0; bus_num < num_cdx_bus; bus_num++) {
+		u8 num_cdx_dev;
+
+		/* MCDI FW Read: Fetch the number of devices present */
+		ret = cdx_mcdi_get_num_devs(cdx_mcdi, bus_num);
+		if (ret < 0) {
+			dev_err(cdx->dev,
+				"CDX bus %d has no devices: %d\n", bus_num, ret);
+			continue;
+		}
+		num_cdx_dev = (u8)ret;
+
+		for (dev_num = 0; dev_num < num_cdx_dev; dev_num++) {
+			struct cdx_dev_params dev_params;
+
+			/* MCDI FW: Get the device config */
+			ret = cdx_mcdi_get_dev_config(cdx_mcdi, bus_num,
+						      dev_num, &dev_params);
+			if (ret) {
+				dev_err(cdx->dev,
+					"CDX device config get failed for %d(bus):%d(dev), %d\n",
+					bus_num, dev_num, ret);
+				continue;
+			}
+			dev_params.cdx = cdx;
+
+			/* Add the device to the cdx bus */
+			ret = cdx_device_add(&dev_params);
+			if (ret) {
+				dev_err(cdx->dev, "registering cdx dev: %d failed: %d\n",
+					dev_num, ret);
+				continue;
+			}
+
+			dev_dbg(cdx->dev, "CDX dev: %d on cdx bus: %d created\n",
+				dev_num, bus_num);
+		}
+	}
+
+	return 0;
+}
+
+static struct cdx_ops cdx_ops = {
+	.scan		= cdx_scan_devices,
+};
+
+static int xlnx_cdx_probe(struct platform_device *pdev)
+{
+	struct cdx_controller *cdx;
+	struct cdx_mcdi *cdx_mcdi;
+	int ret;
+
+	cdx_mcdi = kzalloc(sizeof(*cdx_mcdi), GFP_KERNEL);
+	if (!cdx_mcdi)
+		return -ENOMEM;
+
+	/* Store the MCDI ops */
+	cdx_mcdi->mcdi_ops = &mcdi_ops;
+	/* MCDI FW: Initialize the FW path */
+	ret = cdx_mcdi_init(cdx_mcdi);
+	if (ret) {
+		dev_err_probe(&pdev->dev, ret, "MCDI Initialization failed\n");
+		goto mcdi_init_fail;
+	}
+
+	cdx = kzalloc(sizeof(*cdx), GFP_KERNEL);
+	if (!cdx) {
+		ret = -ENOMEM;
+		goto cdx_alloc_fail;
+	}
+	platform_set_drvdata(pdev, cdx);
+
+	cdx->dev = &pdev->dev;
+	cdx->priv = cdx_mcdi;
+	cdx->ops = &cdx_ops;
+
+	return 0;
+
+cdx_alloc_fail:
+	cdx_mcdi_finish(cdx_mcdi);
+mcdi_init_fail:
+	kfree(cdx_mcdi);
+
+	return ret;
+}
+
+static int xlnx_cdx_remove(struct platform_device *pdev)
+{
+	struct cdx_controller *cdx = platform_get_drvdata(pdev);
+	struct cdx_mcdi *cdx_mcdi = cdx->priv;
+
+	kfree(cdx);
+
+	cdx_mcdi_finish(cdx_mcdi);
+	kfree(cdx_mcdi);
+
+	return 0;
+}
+
+static const struct of_device_id cdx_match_table[] = {
+	{.compatible = "xlnx,versal-net-cdx",},
+	{ },
+};
+
+MODULE_DEVICE_TABLE(of, cdx_match_table);
+
+static struct platform_driver cdx_pdriver = {
+	.driver = {
+		   .name = "cdx-controller",
+		   .pm = NULL,
+		   .of_match_table = cdx_match_table,
+		   },
+	.probe = xlnx_cdx_probe,
+	.remove = xlnx_cdx_remove,
+};
+
+static int __init cdx_controller_init(void)
+{
+	int ret;
+
+	ret = platform_driver_register(&cdx_pdriver);
+	if (ret < 0)
+		pr_err("platform_driver_register() failed: %d\n", ret);
+
+	return ret;
+}
+
+static void __exit cdx_controller_exit(void)
+{
+	platform_driver_unregister(&cdx_pdriver);
+}
+
+module_init(cdx_controller_init);
+module_exit(cdx_controller_exit);
+
+MODULE_AUTHOR("AMD Inc.");
+MODULE_DESCRIPTION("CDX controller for AMD devices");
+MODULE_LICENSE("GPL");
diff --git a/drivers/cdx/controller/mcdi_functions.c b/drivers/cdx/controller/mcdi_functions.c
new file mode 100644
index 000000000000..3940a2c7919c
--- /dev/null
+++ b/drivers/cdx/controller/mcdi_functions.c
@@ -0,0 +1,125 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2022-2023, Advanced Micro Devices, Inc.
+ */
+
+#include <linux/module.h>
+
+#include "mcdi.h"
+#include "mcdi_functions.h"
+
+int cdx_mcdi_get_num_buses(struct cdx_mcdi *cdx)
+{
+	MCDI_DECLARE_BUF(outbuf, MC_CMD_CDX_BUS_ENUM_BUSES_OUT_LEN);
+	size_t outlen;
+	int rc;
+
+	rc = cdx_mcdi_rpc(cdx, MC_CMD_CDX_BUS_ENUM_BUSES, NULL, 0,
+			  outbuf, sizeof(outbuf), &outlen);
+	if (rc)
+		return rc;
+
+	if (outlen != MC_CMD_CDX_BUS_ENUM_BUSES_OUT_LEN)
+		return -EIO;
+
+	return MCDI_DWORD(outbuf, CDX_BUS_ENUM_BUSES_OUT_BUS_COUNT);
+}
+
+int cdx_mcdi_get_num_devs(struct cdx_mcdi *cdx, int bus_num)
+{
+	MCDI_DECLARE_BUF(outbuf, MC_CMD_CDX_BUS_ENUM_DEVICES_OUT_LEN);
+	MCDI_DECLARE_BUF(inbuf, MC_CMD_CDX_BUS_ENUM_DEVICES_IN_LEN);
+	size_t outlen;
+	int rc;
+
+	MCDI_SET_DWORD(inbuf, CDX_BUS_ENUM_DEVICES_IN_BUS, bus_num);
+
+	rc = cdx_mcdi_rpc(cdx, MC_CMD_CDX_BUS_ENUM_DEVICES, inbuf, sizeof(inbuf),
+			  outbuf, sizeof(outbuf), &outlen);
+	if (rc)
+		return rc;
+
+	if (outlen != MC_CMD_CDX_BUS_ENUM_DEVICES_OUT_LEN)
+		return -EIO;
+
+	return MCDI_DWORD(outbuf, CDX_BUS_ENUM_DEVICES_OUT_DEVICE_COUNT);
+}
+
+int cdx_mcdi_get_dev_config(struct cdx_mcdi *cdx,
+			    u8 bus_num, u8 dev_num,
+			    struct cdx_dev_params *dev_params)
+{
+	MCDI_DECLARE_BUF(outbuf, MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_LEN);
+	MCDI_DECLARE_BUF(inbuf, MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_IN_LEN);
+	struct resource *res = &dev_params->res[0];
+	size_t outlen;
+	u32 req_id;
+	int rc;
+
+	MCDI_SET_DWORD(inbuf, CDX_BUS_GET_DEVICE_CONFIG_IN_BUS, bus_num);
+	MCDI_SET_DWORD(inbuf, CDX_BUS_GET_DEVICE_CONFIG_IN_DEVICE, dev_num);
+
+	rc = cdx_mcdi_rpc(cdx, MC_CMD_CDX_BUS_GET_DEVICE_CONFIG, inbuf, sizeof(inbuf),
+			  outbuf, sizeof(outbuf), &outlen);
+	if (rc)
+		return rc;
+
+	if (outlen != MC_CMD_CDX_BUS_GET_DEVICE_CONFIG_OUT_LEN)
+		return -EIO;
+
+	dev_params->bus_num = bus_num;
+	dev_params->dev_num = dev_num;
+
+	req_id = MCDI_DWORD(outbuf, CDX_BUS_GET_DEVICE_CONFIG_OUT_REQUESTER_ID);
+	dev_params->req_id = req_id;
+
+	dev_params->res_count = 0;
+	if (MCDI_QWORD(outbuf, CDX_BUS_GET_DEVICE_CONFIG_OUT_MMIO_REGION0_SIZE) != 0) {
+		res[dev_params->res_count].start =
+			MCDI_QWORD(outbuf, CDX_BUS_GET_DEVICE_CONFIG_OUT_MMIO_REGION0_BASE);
+		res[dev_params->res_count].end =
+			MCDI_QWORD(outbuf, CDX_BUS_GET_DEVICE_CONFIG_OUT_MMIO_REGION0_BASE) +
+				   MCDI_QWORD(outbuf,
+					      CDX_BUS_GET_DEVICE_CONFIG_OUT_MMIO_REGION0_SIZE) - 1;
+		res[dev_params->res_count].flags = IORESOURCE_MEM;
+		dev_params->res_count++;
+	}
+
+	if (MCDI_QWORD(outbuf, CDX_BUS_GET_DEVICE_CONFIG_OUT_MMIO_REGION1_SIZE) != 0) {
+		res[dev_params->res_count].start =
+			MCDI_QWORD(outbuf, CDX_BUS_GET_DEVICE_CONFIG_OUT_MMIO_REGION1_BASE);
+		res[dev_params->res_count].end =
+			MCDI_QWORD(outbuf, CDX_BUS_GET_DEVICE_CONFIG_OUT_MMIO_REGION1_BASE) +
+				   MCDI_QWORD(outbuf,
+					      CDX_BUS_GET_DEVICE_CONFIG_OUT_MMIO_REGION1_SIZE) - 1;
+		res[dev_params->res_count].flags = IORESOURCE_MEM;
+		dev_params->res_count++;
+	}
+
+	if (MCDI_QWORD(outbuf, CDX_BUS_GET_DEVICE_CONFIG_OUT_MMIO_REGION2_SIZE) != 0) {
+		res[dev_params->res_count].start =
+			MCDI_QWORD(outbuf, CDX_BUS_GET_DEVICE_CONFIG_OUT_MMIO_REGION2_BASE);
+		res[dev_params->res_count].end =
+			MCDI_QWORD(outbuf, CDX_BUS_GET_DEVICE_CONFIG_OUT_MMIO_REGION2_BASE) +
+				   MCDI_QWORD(outbuf,
+					      CDX_BUS_GET_DEVICE_CONFIG_OUT_MMIO_REGION2_SIZE) - 1;
+		res[dev_params->res_count].flags = IORESOURCE_MEM;
+		dev_params->res_count++;
+	}
+
+	if (MCDI_QWORD(outbuf, CDX_BUS_GET_DEVICE_CONFIG_OUT_MMIO_REGION3_SIZE) != 0) {
+		res[dev_params->res_count].start =
+			MCDI_QWORD(outbuf, CDX_BUS_GET_DEVICE_CONFIG_OUT_MMIO_REGION3_BASE);
+		res[dev_params->res_count].end =
+			MCDI_QWORD(outbuf, CDX_BUS_GET_DEVICE_CONFIG_OUT_MMIO_REGION3_BASE) +
+				   MCDI_QWORD(outbuf,
+					      CDX_BUS_GET_DEVICE_CONFIG_OUT_MMIO_REGION3_SIZE) - 1;
+		res[dev_params->res_count].flags = IORESOURCE_MEM;
+		dev_params->res_count++;
+	}
+
+	dev_params->vendor = MCDI_WORD(outbuf, CDX_BUS_GET_DEVICE_CONFIG_OUT_VENDOR_ID);
+	dev_params->device = MCDI_WORD(outbuf, CDX_BUS_GET_DEVICE_CONFIG_OUT_DEVICE_ID);
+
+	return 0;
+}
diff --git a/drivers/cdx/controller/mcdi_functions.h b/drivers/cdx/controller/mcdi_functions.h
new file mode 100644
index 000000000000..6bf5a4a0778f
--- /dev/null
+++ b/drivers/cdx/controller/mcdi_functions.h
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Header file for MCDI FW interaction for CDX bus.
+ *
+ * Copyright (C) 2022-2023, Advanced Micro Devices, Inc.
+ */
+
+#ifndef CDX_MCDI_FUNCTIONS_H
+#define CDX_MCDI_FUNCTIONS_H
+
+#include "mcdi.h"
+#include "../cdx.h"
+
+/**
+ * cdx_mcdi_get_num_buses - Get the total number of buses on
+ *	the controller.
+ * @cdx: pointer to MCDI interface.
+ *
+ * Return: total number of buses available on the controller,
+ *	<0 on failure
+ */
+int cdx_mcdi_get_num_buses(struct cdx_mcdi *cdx);
+
+/**
+ * cdx_mcdi_get_num_devs - Get the total number of devices on
+ *	a particular bus of the controller.
+ * @cdx: pointer to MCDI interface.
+ * @bus_num: Bus number.
+ *
+ * Return: total number of devices available on the bus, <0 on failure
+ */
+int cdx_mcdi_get_num_devs(struct cdx_mcdi *cdx, int bus_num);
+
+/**
+ * cdx_mcdi_get_dev_config - Get configuration for a particular
+ *	bus_num:dev_num
+ * @cdx: pointer to MCDI interface.
+ * @bus_num: Bus number.
+ * @dev_num: Device number.
+ * @dev_params: Pointer to cdx_dev_params, this is populated by this
+ *	device with the configuration corresponding to the provided
+ *	bus_num:dev_num.
+ *
+ * Return: 0 total number of devices available on the bus, <0 on failure
+ */
+int cdx_mcdi_get_dev_config(struct cdx_mcdi *cdx,
+			    u8 bus_num, u8 dev_num,
+			    struct cdx_dev_params *dev_params);
+
+#endif /* CDX_MCDI_FUNCTIONS_H */
-- 
2.17.1


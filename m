Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8CD766DF21
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 14:43:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbjAQNnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 08:43:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbjAQNmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 08:42:43 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E1435265;
        Tue, 17 Jan 2023 05:42:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FONFGHVI7nfSLl705WMyJyDZTn/S3cwtmoGC4QwXtVROWup6uPcTBJvuLRS+JdROToxHTOVooYjEPt/e2I1NoaUOXFkN9lAVK1PkbjyGPIPH4vvWkKjWzl7CihqCsHyUKGovmIxgMY0gWdUAaYOeMEg6FFB3bL/jW529xRhgFKVme6KHx/IEW8v1YjsaXwBhI/1Vrzn2+E1AzLj1AxD3ycTzSs2/GcPMwCUrePYfX7RuVR10Ne1rzx3/nk0p37J4cSpDN4Lea0F6XBb8yAr2lnUkAcWR4YZ8W4K1hmKw2W7J3ydNJpLiizDOeDMJ7x8+YBdcTCYhP5T3U/3qkDDpwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=29roSXroTmX19L8CXu2ANa5a0Zq4DPj0GlFqKKBovG0=;
 b=lGkPPDEvQAa35xG0ZYg9tygy3rJAQbCehUL3pUiNCKONqw0oWcY7Rl/KejxRPLuBzG0ZFpEP4wuQ7uCf8y1wG9f7tuFBz2F5J/kfX6wJY04qbO7KJKzmaGmpnam6Cd5DQYJQf4O+uJZTDHLj1I3K5JQiAGP3OgHuvC3ixMk1Com8+PwtKUnxFawW+hfxmsohlc9YJ0ISrS1wsYjRkzuHKZooGSnn44UfMzCL1pHjqtKAt/20xT/kmWLhR7sUikZ/TV4sXp1CBxTiOpLF98FYkZjz8uSuNgbmYA1tACapkcGnu7IF9cYwgp3CL0m5Cqcm6tJVcUBcJmdEqpIoEB8TWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=29roSXroTmX19L8CXu2ANa5a0Zq4DPj0GlFqKKBovG0=;
 b=5FcsyVDU2qd4a0cvYE8/XiYn0lPjCSuqSSa5t3LMEjd7ETSIV+poOfDqda/yVSONSMSpPouS3MUBxdVr+3mnQ3x8HMMycbXGuBlIBOnBccsEAei+FTl6IZYQ3bZeEdZphXZdn2hFG2XsRiL/5NeTMBYvhLEH/s33Sw2vkCt45Zo=
Received: from BN9PR03CA0229.namprd03.prod.outlook.com (2603:10b6:408:f8::24)
 by DS7PR12MB8204.namprd12.prod.outlook.com (2603:10b6:8:e1::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.23; Tue, 17 Jan 2023 13:42:35 +0000
Received: from BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f8:cafe::2d) by BN9PR03CA0229.outlook.office365.com
 (2603:10b6:408:f8::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.19 via Frontend
 Transport; Tue, 17 Jan 2023 13:42:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT054.mail.protection.outlook.com (10.13.177.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.13 via Frontend Transport; Tue, 17 Jan 2023 13:42:34 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 17 Jan
 2023 07:42:34 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 17 Jan
 2023 07:42:33 -0600
Received: from xhdipdslab41.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 17 Jan 2023 07:42:25 -0600
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
Subject: [PATCH 05/19] bus/cdx: add cdx controller
Date:   Tue, 17 Jan 2023 19:11:37 +0530
Message-ID: <20230117134139.1298-6-nipun.gupta@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230117134139.1298-1-nipun.gupta@amd.com>
References: <20230117134139.1298-1-nipun.gupta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT054:EE_|DS7PR12MB8204:EE_
X-MS-Office365-Filtering-Correlation-Id: e6bb495b-93fa-476f-0f7e-08daf890b0a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y7wePTsjB9Naa2MEm+lfbCvcUdzzdxkDNPI4173o1n7bJ+zW1z0G7qF+qB8SqMvT74jY2DR2E0r/cbA/HvhWpaamlZEc77XqbosZs7Pp7ctaBo7G58dOvGvHls5ndnwpkhmJHzOxWNUKqBopizL9qOvdlDKCwKVA9dVu7tr78GcB3t+ntOgJ5WpcGtBjI+WNlIvgG3ogUVZQ1WF/PefkibPQmiKN4afEIktg6HlLcxKLJM30+WC+t5G4ofeAqO5yJM+4+T15ax0ZLiBsD/vPb4avrEKPGX1bWc6ekl8GlZJq2JFH1LzLvbBgHv6n6K3mIpNrnmva/ummI19Cj4cYhkAv/ilZE3/jjAXEgoNRgX4BAbmS4LtVVxaaZrMqiEk2WMz3WXIgTgVmT/VnvYIceIs0O9iTvUMjnH8Q67Dze55a5XhNk5bZCvRoGZoRR8hFYE2HEbnVYOXpOSb27z+gH0uFITwog96nqxYr9xDGEnajdlPkPLod5KKZOd2TbO9SsXspx8X1HaM6rIvaLtOQbtSYkS4uHmSFQKe0guKqifTR6CzaCc9KY4YYjNR++GfwU1BBRuwmauk3urwhMgi3YVYnooh/rYfjHemtcy5xoy4OwEGPMpppVlXhvmnkU6ccsKFOZ7HAO0PsNfSuutgig7ru+BSorPWpJuFUR91B0s2DyVAxxYCVkW2NmYd1XSrFMGSJEA3WiltXBJdTNg+CeCtcy3mDcAWtzub1Ln1eKjLPYyyv0mnunMw4nWnqYvw1ysznMwgJi5+syyw2PsjuyAffP4ztFQL/fFgG2usNDcY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(136003)(39860400002)(396003)(451199015)(46966006)(36840700001)(40470700004)(83380400001)(36860700001)(82740400003)(81166007)(921005)(86362001)(356005)(7416002)(8936002)(30864003)(4326008)(70586007)(5660300002)(2906002)(8676002)(44832011)(70206006)(41300700001)(82310400005)(40480700001)(2616005)(186003)(26005)(47076005)(426003)(1076003)(336012)(6666004)(316002)(54906003)(478600001)(40460700003)(110136005)(36756003)(36900700001)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 13:42:34.8660
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6bb495b-93fa-476f-0f7e-08daf890b0a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8204
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
Signed-off-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
---
 drivers/bus/cdx/controller/Kconfig          |   9 +
 drivers/bus/cdx/controller/Makefile         |   2 +-
 drivers/bus/cdx/controller/cdx_controller.c | 243 ++++++++++++++++++++
 drivers/bus/cdx/controller/mcdi_functions.c | 125 ++++++++++
 drivers/bus/cdx/controller/mcdi_functions.h |  50 ++++
 5 files changed, 428 insertions(+), 1 deletion(-)
 create mode 100644 drivers/bus/cdx/controller/cdx_controller.c
 create mode 100644 drivers/bus/cdx/controller/mcdi_functions.c
 create mode 100644 drivers/bus/cdx/controller/mcdi_functions.h

diff --git a/drivers/bus/cdx/controller/Kconfig b/drivers/bus/cdx/controller/Kconfig
index 785c71063b2a..17f9c6be2fe1 100644
--- a/drivers/bus/cdx/controller/Kconfig
+++ b/drivers/bus/cdx/controller/Kconfig
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
diff --git a/drivers/bus/cdx/controller/Makefile b/drivers/bus/cdx/controller/Makefile
index 0ce200678eda..f7437c882cc9 100644
--- a/drivers/bus/cdx/controller/Makefile
+++ b/drivers/bus/cdx/controller/Makefile
@@ -6,4 +6,4 @@
 #
 
 obj-$(CONFIG_CDX_CONTROLLER) += cdx-controller.o
-cdx-controller-objs := mcdi.o
+cdx-controller-objs := cdx_controller.o mcdi.o mcdi_functions.o
diff --git a/drivers/bus/cdx/controller/cdx_controller.c b/drivers/bus/cdx/controller/cdx_controller.c
new file mode 100644
index 000000000000..9b910c9cb31e
--- /dev/null
+++ b/drivers/bus/cdx/controller/cdx_controller.c
@@ -0,0 +1,243 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Platform driver for CDX bus controller.
+ *
+ * Copyright (C) 2022-2023, Advanced Micro Devices, Inc.
+ */
+
+#include <linux/of_platform.h>
+#include <linux/cdx/cdx_bus.h>
+
+#include "../cdx.h"
+#include "mcdi_functions.h"
+#include "mcdi.h"
+
+#define CDX_NUM_MCDI_BUFFERS	1
+
+/*
+ * Get an MCDI buffer
+ *
+ * The caller is responsible for preventing racing by holding the
+ * MCDI iface_lock.
+ */
+static bool cdx_mcdi_get_buf(struct cdx_mcdi *cdx, u8 *bufid)
+{
+	if (!bufid)
+		return false;
+
+	*bufid = ffz(cdx->mcdi_buf_use);
+
+	if (*bufid < CDX_NUM_MCDI_BUFFERS) {
+		set_bit(*bufid, &cdx->mcdi_buf_use);
+		return true;
+	}
+
+	return false;
+}
+
+/* Return an MCDI buffer */
+static void cdx_mcdi_put_buf(struct cdx_mcdi *cdx, u8 bufid)
+{
+	CDX_WARN_ON_PARANOID(bufid >= CDX_NUM_MCDI_BUFFERS);
+	CDX_WARN_ON_PARANOID(!test_bit(bufid, &cdx->mcdi_buf_use));
+
+	clear_bit(bufid, &cdx->mcdi_buf_use);
+}
+
+static unsigned int cdx_mcdi_rpc_timeout(struct cdx_mcdi *cdx, unsigned int cmd)
+{
+	return MCDI_RPC_TIMEOUT;
+}
+
+static void cdx_mcdi_request(struct cdx_mcdi *cdx, u8 bufid,
+			     const struct cdx_dword *hdr, size_t hdr_len,
+			     const struct cdx_dword *sdu, size_t sdu_len)
+{
+	/*
+	 * This will get updated by rpmsg APIs, with RPMSG introduction
+	 * in CDX controller as a transport layer.
+	 */
+}
+
+static void cdx_mcdi_read_response(struct cdx_mcdi *cdx_mcdi, u8 bufid,
+				   struct cdx_dword *outbuf, size_t offset,
+				   size_t outlen)
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
+	.mcdi_read_response = cdx_mcdi_read_response,
+	.mcdi_get_buf = cdx_mcdi_get_buf,
+	.mcdi_put_buf = cdx_mcdi_put_buf,
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
+				"CDX bus %d has no devices: %d\n", bus_num, num_cdx_dev);
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
+	cdx_mcdi->mcdi_buf = kzalloc(MCDI_BUF_LEN, GFP_KERNEL);
+	if (!cdx_mcdi->mcdi_buf) {
+		ret = -ENOMEM;
+		goto cdx_mcdi_buf_fail;
+	}
+
+	dev_info(&pdev->dev, "Successfully registered CDX controller with RPMsg as transport\n");
+	return 0;
+
+cdx_mcdi_buf_fail:
+	kfree(cdx);
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
+	kfree(cdx_mcdi->mcdi_buf);
+	kfree(cdx);
+
+	cdx_mcdi_finish(cdx_mcdi);
+	kfree(cdx_mcdi);
+
+	return 0;
+}
+
+static const struct of_device_id cdx_match_table[] = {
+	{.compatible = "xlnx,cdxbus-controller",},
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
+MODULE_VERSION("1.0");
+MODULE_AUTHOR("AMD Inc.");
+MODULE_DESCRIPTION("CDX controller for AMD devices");
+MODULE_LICENSE("GPL");
diff --git a/drivers/bus/cdx/controller/mcdi_functions.c b/drivers/bus/cdx/controller/mcdi_functions.c
new file mode 100644
index 000000000000..3940a2c7919c
--- /dev/null
+++ b/drivers/bus/cdx/controller/mcdi_functions.c
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
diff --git a/drivers/bus/cdx/controller/mcdi_functions.h b/drivers/bus/cdx/controller/mcdi_functions.h
new file mode 100644
index 000000000000..97dfde18592f
--- /dev/null
+++ b/drivers/bus/cdx/controller/mcdi_functions.h
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
+ * @return: total number of buses available on the controller,
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
+ * @return: total number of devices available on the bus, <0 on failure
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
+ * @return: 0 total number of devices available on the bus, <0 on failure
+ */
+int cdx_mcdi_get_dev_config(struct cdx_mcdi *cdx,
+			    u8 bus_num, u8 dev_num,
+			    struct cdx_dev_params *dev_params);
+
+#endif /* CDX_MCDI_FUNCTIONS_H */
-- 
2.17.1


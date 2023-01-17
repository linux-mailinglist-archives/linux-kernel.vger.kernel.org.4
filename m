Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABCB866DF24
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 14:43:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjAQNns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 08:43:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbjAQNms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 08:42:48 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2053.outbound.protection.outlook.com [40.107.95.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB55C3B3F3;
        Tue, 17 Jan 2023 05:42:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b72AItH/MOHj99IaifeRTN0OG6d9uZ1NPUNxoBdgSIbZFeKkdAl0ThYfl/Ceq67M7u6VyOo+mZaDqs7wCbjNOGOfMjRzSpVxr+oiBDMN/Xq3KPM5KAmoQndkNNRGACEqXNeuvdoKDeSxPl+fDjkKm98ZUCYq+vjVT8kwIN6W+S7vhucu7XeKUVOGrxIh+HBlElMspa87qW5Wau3FELypA5ezMNjPJz4GLUmWREPPbwXs4Jh1UUHj/oLW+d9hp3wNLV8/P8DCiU7LUP7t4/PrCEUXVzuvSbw/lyhqo0PB8utZZbOU0ss4n/ieioZUYmu1UoRLmMUVKANxt72oMiHBHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0udxWhISzZf85RCwbUlznmcFDnwlrwT9DEol9L8EMbA=;
 b=X9Lyfc3DVDYmgvkjhcyxcVyXmxAOfAOn0R2tRSEE3zWkVEMT39Qm7NWvLAXjjVX1v+NJk7l2vAe303u/ADgghDEYYiedJRrEJnwKzS0EJjKKXSnFFuqPwaEPUjNUhVoxSbEykiiN6yAkvpzVdeCBn4jC8ZVSFjGmyc7YNnVjROk1v+QLjICZ00q6K44PB6sgK8tzIhCzKGw1Nx1vMZp859YAT6euSq9DItfgdsfJSV2p330grhR6E4MpoXQHDerFd/d11xGt7I7HJgz/PegkEnLaTa6A7jU4qo7rKop8gSlOrRY3hY4I2xB2Zp1ib0QxiAdOLrzm6iEl6BXLtf9WKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0udxWhISzZf85RCwbUlznmcFDnwlrwT9DEol9L8EMbA=;
 b=IVWiGROeZpXPLGCtVcEiTlGCRo5n+HenClJWECG0cYu75ygUm5duUbRhldmHhKYttuXcIRuhlv5N9dfxkJpnCbpMWAAtlMqD46l7B+KxigKmnqymw62PU+sYBEMLuQOk4oUP6BO23PKiIJfHbEe9UqltpkoeHbITfFXeLhcKu9Y=
Received: from DM6PR12CA0008.namprd12.prod.outlook.com (2603:10b6:5:1c0::21)
 by PH7PR12MB7456.namprd12.prod.outlook.com (2603:10b6:510:20f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Tue, 17 Jan
 2023 13:42:42 +0000
Received: from DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1c0:cafe::d4) by DM6PR12CA0008.outlook.office365.com
 (2603:10b6:5:1c0::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.19 via Frontend
 Transport; Tue, 17 Jan 2023 13:42:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT036.mail.protection.outlook.com (10.13.172.64) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.13 via Frontend Transport; Tue, 17 Jan 2023 13:42:42 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 17 Jan
 2023 07:42:41 -0600
Received: from xhdipdslab41.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 17 Jan 2023 07:42:33 -0600
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
        Abhijit Gangurde <abhijit.gangurde@amd.com>,
        Nipun Gupta <nipun.gupta@amd.com>
Subject: [PATCH 06/19] bus/cdx: add rpmsg communication channel for CDX
Date:   Tue, 17 Jan 2023 19:11:38 +0530
Message-ID: <20230117134139.1298-7-nipun.gupta@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230117134139.1298-1-nipun.gupta@amd.com>
References: <20230117134139.1298-1-nipun.gupta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT036:EE_|PH7PR12MB7456:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e4031cf-cf63-46d3-b374-08daf890b54f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JFHimPFRISzc8ALLFvs7eaIXIWBTH77VN8q8GLl6hvBSQnc+/GTa7Ty2pITbyruFFJqYdW4LSPTIYTbLN9pETRMSJa4pDeveXca6pL//yUWkoNxJ770x4oDqfVwt3TwajBufK4ULsWa6csAjV/1MP5E55qeiwNx6jndJXp34zlQpJsbtr7SJcm1llbkxw7/UrVgCGl9PuRdBvR16gWDMqtxbQVJNzsz3BssCiw0LaDpw/d/OsSnlQUI2h2Pt0DO2gMgLJYQmSF7UhwAhEzQ3MbwLxIl+1lbgBZ5QiJtDf2hVdqiBRTYrGUIHhOMsZtt4JJqj/Tl8qsKHmI+4J6KuKgVAaKqTC7CZQth85GaLRM8RCaOM3yFfk20th/3iGqSCJlomDYIouYye8q/YR10kC0Ih8i8+AR73pfiQIOq4W6YhWyRSz+tWgEFo7ZeiNzUY7qtGVGsdVUqCriA1itBqGdfVhXzusbH3+6oO8MqweCe5KTp8U2/FODHHgKfqLJXsz3gsCI83BT9j1oqMFuVta0jrhoybghXuiMrXKo0Fa49srMQvpsq1hhbV046W28BB5JL9ZdBldYlGx35FGrt8hiMr1b9ZvJP4rcLTwqSb6yb694aAtxLJkRjixKXurXz7A+ohnp3eKR5nn+G9pac1v8a7Cm9eR13t+ClH2h8+qbmUyGDDpVAORjTKJ1O7Hos+Z6cKdaEYQIhKEdeTJfLVyV/NWWnHSa0yZvUeA1r9Jk6L7+5pOEAaoDCtBHOoak+WWHuCqvGu69JF97LqWrHlEFZSiuIKK93Ub+IyZmpqxjs=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(396003)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(36756003)(40480700001)(478600001)(40460700003)(110136005)(54906003)(26005)(44832011)(41300700001)(2906002)(30864003)(7416002)(316002)(5660300002)(70586007)(4326008)(70206006)(8936002)(8676002)(2616005)(36860700001)(186003)(921005)(356005)(86362001)(82740400003)(1076003)(47076005)(426003)(336012)(81166007)(83380400001)(82310400005)(2101003)(36900700001)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 13:42:42.6287
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e4031cf-cf63-46d3-b374-08daf890b54f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7456
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Abhijit Gangurde <abhijit.gangurde@amd.com>

RPMsg is used as a transport communication channel. This
change introduces RPMsg driver and integrates it with the
CDX controller.

Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
---
 drivers/bus/cdx/controller/Kconfig          |   1 +
 drivers/bus/cdx/controller/Makefile         |   2 +-
 drivers/bus/cdx/controller/cdx_controller.c |  36 +++-
 drivers/bus/cdx/controller/cdx_controller.h |  30 +++
 drivers/bus/cdx/controller/cdx_rpmsg.c      | 222 ++++++++++++++++++++
 drivers/bus/cdx/controller/mcdi.h           |   9 +
 6 files changed, 291 insertions(+), 9 deletions(-)
 create mode 100644 drivers/bus/cdx/controller/cdx_controller.h
 create mode 100644 drivers/bus/cdx/controller/cdx_rpmsg.c

diff --git a/drivers/bus/cdx/controller/Kconfig b/drivers/bus/cdx/controller/Kconfig
index 17f9c6be2fe1..aea3ac86d3aa 100644
--- a/drivers/bus/cdx/controller/Kconfig
+++ b/drivers/bus/cdx/controller/Kconfig
@@ -9,6 +9,7 @@ if CDX_BUS
 
 config CDX_CONTROLLER
 	tristate "CDX bus controller"
+	select RPMSG
 	help
 	  CDX controller drives the CDX bus. It interacts with
 	  firmware to get the hardware devices and registers with
diff --git a/drivers/bus/cdx/controller/Makefile b/drivers/bus/cdx/controller/Makefile
index f7437c882cc9..f071be411d96 100644
--- a/drivers/bus/cdx/controller/Makefile
+++ b/drivers/bus/cdx/controller/Makefile
@@ -6,4 +6,4 @@
 #
 
 obj-$(CONFIG_CDX_CONTROLLER) += cdx-controller.o
-cdx-controller-objs := cdx_controller.o mcdi.o mcdi_functions.o
+cdx-controller-objs := cdx_controller.o cdx_rpmsg.o mcdi.o mcdi_functions.o
diff --git a/drivers/bus/cdx/controller/cdx_controller.c b/drivers/bus/cdx/controller/cdx_controller.c
index 9b910c9cb31e..b62a6d3b7bd4 100644
--- a/drivers/bus/cdx/controller/cdx_controller.c
+++ b/drivers/bus/cdx/controller/cdx_controller.c
@@ -8,6 +8,7 @@
 #include <linux/of_platform.h>
 #include <linux/cdx/cdx_bus.h>
 
+#include "cdx_controller.h"
 #include "../cdx.h"
 #include "mcdi_functions.h"
 #include "mcdi.h"
@@ -53,20 +54,14 @@ static void cdx_mcdi_request(struct cdx_mcdi *cdx, u8 bufid,
 			     const struct cdx_dword *hdr, size_t hdr_len,
 			     const struct cdx_dword *sdu, size_t sdu_len)
 {
-	/*
-	 * This will get updated by rpmsg APIs, with RPMSG introduction
-	 * in CDX controller as a transport layer.
-	 */
+	cdx_rpmsg_send(cdx, hdr, hdr_len, sdu, sdu_len);
 }
 
 static void cdx_mcdi_read_response(struct cdx_mcdi *cdx_mcdi, u8 bufid,
 				   struct cdx_dword *outbuf, size_t offset,
 				   size_t outlen)
 {
-	/*
-	 * This will get updated by rpmsg APIs, with RPMSG introduction
-	 * in CDX controller as a transport layer.
-	 */
+	cdx_rpmsg_read_resp(cdx_mcdi, outbuf, offset, outlen);
 }
 
 static const struct cdx_mcdi_ops mcdi_ops = {
@@ -77,6 +72,19 @@ static const struct cdx_mcdi_ops mcdi_ops = {
 	.mcdi_put_buf = cdx_mcdi_put_buf,
 };
 
+void cdx_rpmsg_post_probe(struct cdx_controller *cdx)
+{
+	/* Register CDX controller with CDX bus driver */
+	if (cdx_register_controller(cdx))
+		dev_err(cdx->dev, "Failed to register CDX controller\n");
+}
+
+void cdx_rpmsg_pre_remove(struct cdx_controller *cdx)
+{
+	cdx_unregister_controller(cdx);
+	cdx_mcdi_wait_for_quiescence(cdx->priv, MCDI_RPC_TIMEOUT);
+}
+
 static int cdx_scan_devices(struct cdx_controller *cdx)
 {
 	struct cdx_mcdi *cdx_mcdi = cdx->priv;
@@ -174,9 +182,19 @@ static int xlnx_cdx_probe(struct platform_device *pdev)
 		goto cdx_mcdi_buf_fail;
 	}
 
+	ret = cdx_setup_rpmsg(pdev);
+	if (ret) {
+		if (ret != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "Failed to register CDX RPMsg transport\n");
+		goto cdx_rpmsg_fail;
+	}
+
 	dev_info(&pdev->dev, "Successfully registered CDX controller with RPMsg as transport\n");
 	return 0;
 
+cdx_rpmsg_fail:
+	kfree(cdx_mcdi->mcdi_buf);
+	cdx_mcdi->mcdi_buf = NULL;
 cdx_mcdi_buf_fail:
 	kfree(cdx);
 cdx_alloc_fail:
@@ -192,6 +210,8 @@ static int xlnx_cdx_remove(struct platform_device *pdev)
 	struct cdx_controller *cdx = platform_get_drvdata(pdev);
 	struct cdx_mcdi *cdx_mcdi = cdx->priv;
 
+	cdx_destroy_rpmsg(pdev);
+
 	kfree(cdx_mcdi->mcdi_buf);
 	kfree(cdx);
 
diff --git a/drivers/bus/cdx/controller/cdx_controller.h b/drivers/bus/cdx/controller/cdx_controller.h
new file mode 100644
index 000000000000..43b7c742df87
--- /dev/null
+++ b/drivers/bus/cdx/controller/cdx_controller.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Header file for the CDX Controller
+ *
+ * Copyright (C) 2022-2023, Advanced Micro Devices, Inc.
+ */
+
+#ifndef _CDX_CONTROLLER_H_
+#define _CDX_CONTROLLER_H_
+
+#include <linux/cdx/cdx_bus.h>
+#include "mcdi_functions.h"
+
+void cdx_rpmsg_post_probe(struct cdx_controller *cdx);
+
+void cdx_rpmsg_pre_remove(struct cdx_controller *cdx);
+
+int cdx_rpmsg_send(struct cdx_mcdi *cdx_mcdi,
+		   const struct cdx_dword *hdr, size_t hdr_len,
+		   const struct cdx_dword *sdu, size_t sdu_len);
+
+void cdx_rpmsg_read_resp(struct cdx_mcdi *cdx_mcdi,
+			 struct cdx_dword *outbuf, size_t offset,
+			 size_t outlen);
+
+int cdx_setup_rpmsg(struct platform_device *pdev);
+
+void cdx_destroy_rpmsg(struct platform_device *pdev);
+
+#endif /* _CDX_CONT_PRIV_H_ */
diff --git a/drivers/bus/cdx/controller/cdx_rpmsg.c b/drivers/bus/cdx/controller/cdx_rpmsg.c
new file mode 100644
index 000000000000..147c2fadf67f
--- /dev/null
+++ b/drivers/bus/cdx/controller/cdx_rpmsg.c
@@ -0,0 +1,222 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Platform driver for CDX bus.
+ *
+ * Copyright (C) 2022-2023, Advanced Micro Devices, Inc.
+ */
+
+#include <linux/rpmsg.h>
+#include <linux/remoteproc.h>
+#include <linux/of_platform.h>
+#include <linux/cdx/cdx_bus.h>
+#include <linux/module.h>
+
+#include "../cdx.h"
+#include "cdx_controller.h"
+#include "mcdi_functions.h"
+#include "mcdi.h"
+
+#define to_rproc_device(_dev) \
+	container_of(_dev, struct rproc, dev)
+
+static struct rpmsg_device_id cdx_rpmsg_id_table[] = {
+	{ .name = "mcdi_ipc" },
+	{ },
+};
+MODULE_DEVICE_TABLE(rpmsg, cdx_rpmsg_id_table);
+
+int cdx_rpmsg_send(struct cdx_mcdi *cdx_mcdi,
+		   const struct cdx_dword *hdr, size_t hdr_len,
+		   const struct cdx_dword *sdu, size_t sdu_len)
+{
+	char send_buf[MCDI_BUF_LEN] = {0};
+
+	memset(cdx_mcdi->mcdi_buf, 0x0, MCDI_BUF_LEN);
+
+	memcpy(send_buf, hdr, hdr_len);
+	memcpy(send_buf + hdr_len, sdu, sdu_len);
+
+	return rpmsg_send(cdx_mcdi->ept, send_buf, hdr_len + sdu_len);
+}
+
+void cdx_rpmsg_read_resp(struct cdx_mcdi *cdx_mcdi,
+			 struct cdx_dword *outbuf, size_t offset,
+			 size_t outlen)
+{
+	memcpy(outbuf, (void *)((u64)cdx_mcdi->mcdi_buf + offset), outlen);
+}
+
+static int find_remoteproc_child_dev(struct device *dev, void *data)
+{
+	return strstr(dev_name(dev), "remoteproc") ? 1 : 0;
+}
+
+static int cdx_attach_to_rproc(struct platform_device *pdev)
+{
+	struct platform_device *node_pdev;
+	struct device_node *r5_core_node;
+	struct cdx_controller *cdx_c;
+	struct cdx_mcdi *cdx_mcdi;
+	struct device *dev;
+	struct rproc *rp;
+	int ret;
+
+	dev = &pdev->dev;
+	cdx_c = platform_get_drvdata(pdev);
+	cdx_mcdi = cdx_c->priv;
+
+	r5_core_node = of_parse_phandle(dev->of_node, "xlnx,rproc", 0);
+	if (!r5_core_node) {
+		dev_err(&pdev->dev, "xlnx,rproc: invalid phandle\n");
+		return -EINVAL;
+	}
+
+	node_pdev = of_find_device_by_node(r5_core_node);
+	if (!node_pdev) {
+		ret = -EPROBE_DEFER;
+		goto pdev_err;
+	}
+
+	dev = device_find_child(&node_pdev->dev, NULL, find_remoteproc_child_dev);
+	if (!dev) {
+		dev_err(&pdev->dev, "no matching remoteproc device found\n");
+		ret = -ENODEV;
+		goto no_child_err;
+	}
+
+	rp = to_rproc_device(dev);
+
+	/* Attach to remote processor */
+	ret = rproc_boot(rp);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to attach to remote processor\n");
+		goto no_child_err;
+	}
+
+	cdx_mcdi->r5_rproc = rp;
+no_child_err:
+	put_device(&node_pdev->dev);
+pdev_err:
+	of_node_put(r5_core_node);
+	return ret;
+}
+
+static void cdx_detach_to_r5(struct platform_device *pdev)
+{
+	struct cdx_controller *cdx_c;
+	struct cdx_mcdi *cdx_mcdi;
+
+	cdx_c = platform_get_drvdata(pdev);
+	cdx_mcdi = cdx_c->priv;
+
+	rproc_detach(cdx_mcdi->r5_rproc);
+}
+
+static int cdx_rpmsg_cb(struct rpmsg_device *rpdev, void *data,
+			int len, void *priv, u32 src)
+{
+	struct cdx_controller *cdx_c = dev_get_drvdata(&rpdev->dev);
+	struct cdx_mcdi *cdx_mcdi = cdx_c->priv;
+
+	if (len > MCDI_BUF_LEN)
+		return -EINVAL;
+
+	memcpy(cdx_mcdi->mcdi_buf, data, len);
+	cdx_mcdi_process_cmd(cdx_mcdi, *(struct cdx_dword *)cdx_mcdi->mcdi_buf);
+
+	return 0;
+}
+
+static void cdx_rpmsg_post_probe_work(struct work_struct *work)
+{
+	struct cdx_controller *cdx_c;
+	struct cdx_mcdi *cdx_mcdi;
+
+	cdx_mcdi = container_of(work, struct cdx_mcdi, work);
+	cdx_c = dev_get_drvdata(&cdx_mcdi->rpdev->dev);
+	cdx_rpmsg_post_probe(cdx_c);
+}
+
+static int cdx_rpmsg_probe(struct rpmsg_device *rpdev)
+{
+	struct rpmsg_channel_info chinfo = {0};
+	struct cdx_controller *cdx_c;
+	struct cdx_mcdi *cdx_mcdi;
+
+	cdx_c = (struct cdx_controller *)cdx_rpmsg_id_table[0].driver_data;
+	cdx_mcdi = cdx_c->priv;
+
+	chinfo.src = RPMSG_ADDR_ANY;
+	chinfo.dst = rpdev->dst;
+	strscpy(chinfo.name, cdx_rpmsg_id_table[0].name,
+		strlen(cdx_rpmsg_id_table[0].name));
+
+	cdx_mcdi->ept = rpmsg_create_ept(rpdev, cdx_rpmsg_cb, NULL, chinfo);
+	if (!cdx_mcdi->ept) {
+		dev_err_probe(&rpdev->dev, -ENXIO,
+			      "Failed to create ept for channel %s\n",
+			      chinfo.name);
+		return -EINVAL;
+	}
+
+	cdx_mcdi->rpdev = rpdev;
+	dev_set_drvdata(&rpdev->dev, cdx_c);
+
+	schedule_work(&cdx_mcdi->work);
+	return 0;
+}
+
+static void cdx_rpmsg_remove(struct rpmsg_device *rpdev)
+{
+	struct cdx_controller *cdx_c = dev_get_drvdata(&rpdev->dev);
+	struct cdx_mcdi *cdx_mcdi = cdx_c->priv;
+
+	flush_work(&cdx_mcdi->work);
+	cdx_rpmsg_pre_remove(cdx_c);
+
+	rpmsg_destroy_ept(cdx_mcdi->ept);
+	dev_set_drvdata(&rpdev->dev, NULL);
+}
+
+static struct rpmsg_driver cdx_rpmsg_driver = {
+	.drv.name = KBUILD_MODNAME,
+	.id_table = cdx_rpmsg_id_table,
+	.probe = cdx_rpmsg_probe,
+	.remove = cdx_rpmsg_remove,
+	.callback = cdx_rpmsg_cb,
+};
+
+int cdx_setup_rpmsg(struct platform_device *pdev)
+{
+	struct cdx_controller *cdx_c;
+	struct cdx_mcdi *cdx_mcdi;
+	int ret;
+
+	/* Attach to remote processor */
+	ret = cdx_attach_to_rproc(pdev);
+	if (ret)
+		return ret;
+
+	cdx_c = platform_get_drvdata(pdev);
+	cdx_mcdi = cdx_c->priv;
+
+	/* Register RPMsg driver */
+	cdx_rpmsg_id_table[0].driver_data = (kernel_ulong_t)cdx_c;
+
+	INIT_WORK(&cdx_mcdi->work, cdx_rpmsg_post_probe_work);
+	ret = register_rpmsg_driver(&cdx_rpmsg_driver);
+	if (ret < 0) {
+		dev_err(&pdev->dev,
+			"Failed to register cdx RPMsg driver: %d\n", ret);
+		cdx_detach_to_r5(pdev);
+	}
+
+	return ret;
+}
+
+void cdx_destroy_rpmsg(struct platform_device *pdev)
+{
+	unregister_rpmsg_driver(&cdx_rpmsg_driver);
+
+	cdx_detach_to_r5(pdev);
+}
diff --git a/drivers/bus/cdx/controller/mcdi.h b/drivers/bus/cdx/controller/mcdi.h
index a2ee8821b6fe..54e1b27c2a53 100644
--- a/drivers/bus/cdx/controller/mcdi.h
+++ b/drivers/bus/cdx/controller/mcdi.h
@@ -64,6 +64,10 @@ enum cdx_mcdi_cmd_state {
  * @mcdi_buf_use: Stores MCDI buffer usage
  * @mcdi_ops: MCDI operations
  * @mcdi_buf: MCDI receive buffer
+ * @r5_rproc : R5 Remoteproc device handle
+ * @rpdev: RPMsg device
+ * @ept: RPMsg endpoint
+ * @work: Post probe work
  */
 struct cdx_mcdi {
 	/* MCDI interface */
@@ -71,6 +75,11 @@ struct cdx_mcdi {
 	unsigned long mcdi_buf_use;
 	const struct cdx_mcdi_ops *mcdi_ops;
 	void *mcdi_buf;
+
+	struct rproc *r5_rproc;
+	struct rpmsg_device *rpdev;
+	struct rpmsg_endpoint *ept;
+	struct work_struct work;
 };
 
 struct cdx_mcdi_ops {
-- 
2.17.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A60E6B78F1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 14:28:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbjCMN20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 09:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbjCMN2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 09:28:20 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA3B64A90;
        Mon, 13 Mar 2023 06:27:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iDlcSh8YODE0Jbrhs3I3Xua/lMeP0Fun5u3P8i3g04KBBqS+ppRD9dDw2Cu1zUIo37EsBZC1zg6GpHokYOaHQUINI1AG6afa+9Y6yPBSoKP/6pwClNi0bFUJ24g8RoRjFi2+ov2iwN69ix+yjRRpEBxd5H5pQACGEZMfU8AMhMVP/PvBVO9F0clAHOOfdUFs30dl5qlSuQtRg/BZ3ESBQbS/6nNCsRJV/AImSjvwP/qcpUkW09ETJLZbqhJOlDfi/14LLXqTR3DZ1pFPYG9wB1q5v1TWdAZbyuWCSr1P70BLjG4+2SjhpM5MWzwmkPXPp4JfBKv3dMiLwGe7QiUnnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OdfWa/nJ+FmIyVEq/ucBA+pghbu/2suuEzfrPsxKUbw=;
 b=UWw+wyXwnSQ+WO5MoE2Hu/6r1O0B1EKfb2WwgzJ+Q7tDWHwH2LtLoUvcHJmLX4r+zogYcn4BB9guzEqYng2ys3967qSHJSnZtDvj86KiUFXkfe7u66qEbvemQd4s8gTzSgVILqU3ddetmDIHQZcIyyfl1af9iyk2txaxR8TqsiENdZ50sjTMrks6QJclgDdSrxbgZVAqWR0zi9ohQV3EwsgsWupIMTARrujncL4uZ48wH7HNTXJZfh342rPGiYzLuVZjvxTckqOurDJejfN7Z5gYKdZaToJoT9Z+9MsmybUlT7FeeC7FxngQQqUoyBqsaQQpqhaimEl0b8D9A5ls6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OdfWa/nJ+FmIyVEq/ucBA+pghbu/2suuEzfrPsxKUbw=;
 b=12Oed2WkHHkLK4eIPHRi93S1BAoAlDp5jOsFnOLvF/MeaIxoG7fKNvJIowdDUKYynv9ceRbpN/c96HBtM35vE9sg6SXWE+R4akr/CIZhfOJcVlT6W7uffQhnAM6VNXNup9OSOvlictqVwAAoNMMe2WzNFyCHNQUY2NNL/ti3Wb0=
Received: from MN2PR16CA0012.namprd16.prod.outlook.com (2603:10b6:208:134::25)
 by DS7PR12MB8084.namprd12.prod.outlook.com (2603:10b6:8:ef::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.19; Mon, 13 Mar 2023 13:27:47 +0000
Received: from BL02EPF000108EA.namprd05.prod.outlook.com
 (2603:10b6:208:134:cafe::fe) by MN2PR16CA0012.outlook.office365.com
 (2603:10b6:208:134::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.25 via Frontend
 Transport; Mon, 13 Mar 2023 13:27:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000108EA.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.13 via Frontend Transport; Mon, 13 Mar 2023 13:27:40 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 13 Mar
 2023 08:27:40 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 13 Mar
 2023 08:27:40 -0500
Received: from xhdipdslab41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Mon, 13 Mar 2023 08:27:31 -0500
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
        <baolu.lu@linux.intel.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kbuild@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <okaya@kernel.org>, <harpreet.anand@amd.com>,
        <nikhil.agarwal@amd.com>, <michal.simek@amd.com>,
        <pieter.jansen-van-vuuren@amd.com>, <pablo.cascon@amd.com>,
        <git@amd.com>, Nipun Gupta <nipun.gupta@amd.com>
Subject: [PATCH v10 6/7] cdx: add rpmsg communication channel for CDX
Date:   Mon, 13 Mar 2023 18:56:35 +0530
Message-ID: <20230313132636.31850-7-nipun.gupta@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230313132636.31850-1-nipun.gupta@amd.com>
References: <20230313132636.31850-1-nipun.gupta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000108EA:EE_|DS7PR12MB8084:EE_
X-MS-Office365-Filtering-Correlation-Id: a1c3317c-776d-4a8f-d12b-08db23c6b892
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FSyCetyfs1S/Ks/Zmv3Xh6aPnrTLxLDWdTbqZt81sZ8q0+i1JgwAM9cniTN6EYeotyqitFUNM+/yHU0WDO/1v01jzjlXao6i4eQtLstseSBwtTzK5ZsvgrMSZpq2eV7re0hhfX8pV/X5f1lqB6JxmmxLXPSLOC63/NxIirsuZCKedFZqTCXyIC3zI8suGnOIqoJj+VeL9lGf6qTpAlJR3WiWhjiOIpw8xRL4Yx3rHIjbQGteK++izNLN1teffMEBABnzZBHI1Hys4b41AWe7Zh3WojF0qgnP8pLiLVq+iXglTzizBq0iFMZePnUgYIlmgAQIq14cIWwpYyL0bRpUwGgkW8AQUhG1JRKA/n408VeQRmR3RdYt9G1UFxYwbawT9FDJI0BsdzM+4/KIGCVBJ9olK+W9uzTmJ82aUCS6RJtypqv6XEh5z/oYlDps7VDCP32DeC0M62Y5IT5XiH9177sqVgxG3J0qDObhUNhvtz1wBBj6CyqIHqAM2PPt7M/o4bYzC1E8tWcXDYjtkFni6r70itQQe1pKa0pZysfCBqBrT6kNapd3b3JbQCixA6MFEyfrXGGlruWrrReMUYaxkXMuf8mSKj+6+d3D5ASdI/qH1/xpkjtYn6YUlaiH4uKRHBrKS+iekuhBvP8mT6xYWZ/o2XnAdsNpI4wcnMUcRx6u5NCeXIkietIcyhwnCCMnrF62UECIoEJpK2RuJ3KW/TIXAeqI+CUykfaio22j/8x9UVt1+33imQSFZo8F+0S2TLavoY0y5+QNep2Cx0smqyJAO1uci80nLxQ5Q2q2daY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(346002)(396003)(39860400002)(451199018)(46966006)(36840700001)(40470700004)(36756003)(316002)(40460700003)(54906003)(110136005)(2906002)(7416002)(41300700001)(5660300002)(7406005)(44832011)(81166007)(356005)(4326008)(8676002)(30864003)(70206006)(8936002)(70586007)(36860700001)(82740400003)(86362001)(40480700001)(921005)(2616005)(82310400005)(26005)(83380400001)(186003)(1076003)(478600001)(336012)(426003)(47076005)(36900700001)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 13:27:40.9558
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1c3317c-776d-4a8f-d12b-08db23c6b892
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000108EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8084
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RPMsg is used as a transport communication channel. This
change introduces RPMsg driver and integrates it with the
CDX controller.

Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
Reviewed-by: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
Tested-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
---
 drivers/cdx/controller/Kconfig          |   2 +
 drivers/cdx/controller/Makefile         |   2 +-
 drivers/cdx/controller/cdx_controller.c |  32 +++-
 drivers/cdx/controller/cdx_controller.h |  30 ++++
 drivers/cdx/controller/cdx_rpmsg.c      | 202 ++++++++++++++++++++++++
 drivers/cdx/controller/mcdi.h           |  10 ++
 6 files changed, 273 insertions(+), 5 deletions(-)
 create mode 100644 drivers/cdx/controller/cdx_controller.h
 create mode 100644 drivers/cdx/controller/cdx_rpmsg.c

diff --git a/drivers/cdx/controller/Kconfig b/drivers/cdx/controller/Kconfig
index 17f9c6be2fe1..c3e3b9ff8dfe 100644
--- a/drivers/cdx/controller/Kconfig
+++ b/drivers/cdx/controller/Kconfig
@@ -9,6 +9,8 @@ if CDX_BUS
 
 config CDX_CONTROLLER
 	tristate "CDX bus controller"
+	select REMOTEPROC
+	select RPMSG
 	help
 	  CDX controller drives the CDX bus. It interacts with
 	  firmware to get the hardware devices and registers with
diff --git a/drivers/cdx/controller/Makefile b/drivers/cdx/controller/Makefile
index f7437c882cc9..f071be411d96 100644
--- a/drivers/cdx/controller/Makefile
+++ b/drivers/cdx/controller/Makefile
@@ -6,4 +6,4 @@
 #
 
 obj-$(CONFIG_CDX_CONTROLLER) += cdx-controller.o
-cdx-controller-objs := cdx_controller.o mcdi.o mcdi_functions.o
+cdx-controller-objs := cdx_controller.o cdx_rpmsg.o mcdi.o mcdi_functions.o
diff --git a/drivers/cdx/controller/cdx_controller.c b/drivers/cdx/controller/cdx_controller.c
index fbebc8cdcbf8..0d1826980935 100644
--- a/drivers/cdx/controller/cdx_controller.c
+++ b/drivers/cdx/controller/cdx_controller.c
@@ -9,6 +9,7 @@
 #include <linux/slab.h>
 #include <linux/cdx/cdx_bus.h>
 
+#include "cdx_controller.h"
 #include "../cdx.h"
 #include "mcdi_functions.h"
 #include "mcdi.h"
@@ -22,10 +23,8 @@ static void cdx_mcdi_request(struct cdx_mcdi *cdx,
 			     const struct cdx_dword *hdr, size_t hdr_len,
 			     const struct cdx_dword *sdu, size_t sdu_len)
 {
-	/*
-	 * This will get updated by rpmsg APIs, with RPMSG introduction
-	 * in CDX controller as a transport layer.
-	 */
+	if (cdx_rpmsg_send(cdx, hdr, hdr_len, sdu, sdu_len))
+		dev_err(&cdx->rpdev->dev, "Failed to send rpmsg data\n");
 }
 
 static const struct cdx_mcdi_ops mcdi_ops = {
@@ -33,6 +32,19 @@ static const struct cdx_mcdi_ops mcdi_ops = {
 	.mcdi_request = cdx_mcdi_request,
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
@@ -124,8 +136,18 @@ static int xlnx_cdx_probe(struct platform_device *pdev)
 	cdx->priv = cdx_mcdi;
 	cdx->ops = &cdx_ops;
 
+	ret = cdx_setup_rpmsg(pdev);
+	if (ret) {
+		if (ret != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "Failed to register CDX RPMsg transport\n");
+		goto cdx_rpmsg_fail;
+	}
+
+	dev_info(&pdev->dev, "Successfully registered CDX controller with RPMsg as transport\n");
 	return 0;
 
+cdx_rpmsg_fail:
+	kfree(cdx);
 cdx_alloc_fail:
 	cdx_mcdi_finish(cdx_mcdi);
 mcdi_init_fail:
@@ -139,6 +161,8 @@ static int xlnx_cdx_remove(struct platform_device *pdev)
 	struct cdx_controller *cdx = platform_get_drvdata(pdev);
 	struct cdx_mcdi *cdx_mcdi = cdx->priv;
 
+	cdx_destroy_rpmsg(pdev);
+
 	kfree(cdx);
 
 	cdx_mcdi_finish(cdx_mcdi);
diff --git a/drivers/cdx/controller/cdx_controller.h b/drivers/cdx/controller/cdx_controller.h
new file mode 100644
index 000000000000..43b7c742df87
--- /dev/null
+++ b/drivers/cdx/controller/cdx_controller.h
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
diff --git a/drivers/cdx/controller/cdx_rpmsg.c b/drivers/cdx/controller/cdx_rpmsg.c
new file mode 100644
index 000000000000..f37e639d6ce3
--- /dev/null
+++ b/drivers/cdx/controller/cdx_rpmsg.c
@@ -0,0 +1,202 @@
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
+	unsigned char *send_buf;
+	int ret;
+
+	send_buf = kzalloc(hdr_len + sdu_len, GFP_KERNEL);
+	if (!send_buf)
+		return -ENOMEM;
+
+	memcpy(send_buf, hdr, hdr_len);
+	memcpy(send_buf + hdr_len, sdu, sdu_len);
+
+	ret = rpmsg_send(cdx_mcdi->ept, send_buf, hdr_len + sdu_len);
+	kfree(send_buf);
+
+	return ret;
+}
+
+static int cdx_attach_to_rproc(struct platform_device *pdev)
+{
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
+	rp = rproc_get_by_phandle(r5_core_node->phandle);
+	if (!rp) {
+		ret = -EPROBE_DEFER;
+		goto pdev_err;
+	}
+
+	/* Attach to remote processor */
+	ret = rproc_boot(rp);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to attach to remote processor\n");
+		rproc_put(rp);
+		goto pdev_err;
+	}
+
+	cdx_mcdi->r5_rproc = rp;
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
+	rproc_put(cdx_mcdi->r5_rproc);
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
+	cdx_mcdi_process_cmd(cdx_mcdi, (struct cdx_dword *)data, len);
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
+	if (ret) {
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
diff --git a/drivers/cdx/controller/mcdi.h b/drivers/cdx/controller/mcdi.h
index 63933ede33ed..0bfbeab04e43 100644
--- a/drivers/cdx/controller/mcdi.h
+++ b/drivers/cdx/controller/mcdi.h
@@ -9,6 +9,7 @@
 
 #include <linux/mutex.h>
 #include <linux/kref.h>
+#include <linux/rpmsg.h>
 
 #include "bitfield.h"
 #include "mc_cdx_pcol.h"
@@ -62,11 +63,20 @@ enum cdx_mcdi_cmd_state {
  *	with CDX controller.
  * @mcdi: MCDI interface
  * @mcdi_ops: MCDI operations
+ * @r5_rproc : R5 Remoteproc device handle
+ * @rpdev: RPMsg device
+ * @ept: RPMsg endpoint
+ * @work: Post probe work
  */
 struct cdx_mcdi {
 	/* MCDI interface */
 	struct cdx_mcdi_data *mcdi;
 	const struct cdx_mcdi_ops *mcdi_ops;
+
+	struct rproc *r5_rproc;
+	struct rpmsg_device *rpdev;
+	struct rpmsg_endpoint *ept;
+	struct work_struct work;
 };
 
 struct cdx_mcdi_ops {
-- 
2.17.1


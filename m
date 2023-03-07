Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC60A6AE057
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 14:22:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbjCGNWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 08:22:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbjCGNVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 08:21:46 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E7A7EC6;
        Tue,  7 Mar 2023 05:20:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WFetT3NtVuF/alk/PW9vRjBzNId+0BLOdd1Eb74RJVyTtiqj+tKs05bcsuADDJg+m8Er4WDB0JJKQ20PC51qENc4vOCkpahCwWPV9sWtvhZCKsJOSM3yVJuYyJL+LPcXzLN6TrQW9Ctu8fXVdZE7FTn2iDAPzVV3D2i8RlVDvfnR+K3wn88ZClgQ16Jj3sc509hz3LJ2jS0oO+JGzsczSudWKB7Gu1MFjA5cEEzPlPvJhsmrPCq9emzodjf6CejGhhiSaMT5IywmRo8SmwYpdWuydqHz+aXeXlaMt0k5N1SEOvtr9ovtTn9LVGD50wwKQMTJVWUGbbOnI2i+cGbZ9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vnbKR1J3/ykl97bEmbHUqG24T0ZcRFANaHYXskHAaow=;
 b=Z3pXaH32Qm7qAhDJPRDC/wZctGgcDkIRpkp6Z3Fi7CehXD4AQEDeJXOOi8Yyo75upb2KjiP688A0AKZvIehij9GAdEuT7FZxuZiIMlbbapTEUnTKj5ARFJu424R8MM4eCiYIRYLsdMuuKPPs4Dn9s8QY0+NtS8FYtuOY1pBuLTHy4HuI+akZ9jIuRIoBinRYXEYeFxfmVEJv9CCRsZbShd0RsVkdIUhKXXf5E3eb/BO+d4ciMIHvMLZJm5uT4xSiJGSdF4R0rRVEC8zXlYVNWM7LoO7l5rUwwZdXf0llMk5Sh5He/9Di8LL18R6hKNb95630tlq3Ckrp4aDlPayplA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vnbKR1J3/ykl97bEmbHUqG24T0ZcRFANaHYXskHAaow=;
 b=wcYXLdAhgE97vjjUfqipP29DI7nOcmTJzMAwC4TWfxxWXO5TuohKxIqPWSKEGuSozPsKZRQ5aWZ1uhTaTOr/zINrRTlFLRoWLq1Id+u3CaTMNcaSG3yfXqnoqAtiUuaWtM/Ayr7vdNpgqm16GJWYuYBrMvjLUH0FnAt7T2lurPU=
Received: from MW2PR16CA0008.namprd16.prod.outlook.com (2603:10b6:907::21) by
 CYYPR12MB8730.namprd12.prod.outlook.com (2603:10b6:930:c1::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.29; Tue, 7 Mar 2023 13:20:20 +0000
Received: from CO1NAM11FT078.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::ef) by MW2PR16CA0008.outlook.office365.com
 (2603:10b6:907::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28 via Frontend
 Transport; Tue, 7 Mar 2023 13:20:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT078.mail.protection.outlook.com (10.13.175.177) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.16 via Frontend Transport; Tue, 7 Mar 2023 13:20:20 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 7 Mar
 2023 07:20:19 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 7 Mar
 2023 05:20:19 -0800
Received: from xhdipdslab41.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 7 Mar 2023 07:20:10 -0600
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
        <nikhil.agarwal@amd.com>, <michal.simek@amd.com>,
        <pieter.jansen-van-vuuren@amd.com>, <pablo.cascon@amd.com>,
        <git@amd.com>, Abhijit Gangurde <abhijit.gangurde@amd.com>,
        Nipun Gupta <nipun.gupta@amd.com>
Subject: [PATCH v9 6/7] cdx: add rpmsg communication channel for CDX
Date:   Tue, 7 Mar 2023 18:49:16 +0530
Message-ID: <20230307131917.30605-7-nipun.gupta@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230307131917.30605-1-nipun.gupta@amd.com>
References: <20230307131917.30605-1-nipun.gupta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT078:EE_|CYYPR12MB8730:EE_
X-MS-Office365-Filtering-Correlation-Id: 86ed7060-ee72-489d-374d-08db1f0eb399
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lZET3Kw829AIOyoRXsucwxLwSzxwkxTKSa38/DnOyfxabuWWtBZZ3FkPW/NPaWSBPvmt/wLqx8QZAFNeXd6fM9NglJRt3QJq7VcwIGc5tfVMwzsV3XcoDxgzRRoOnd8FRiSWPldLWeCxyaf0YUH4AJIOfrXxH8jwEg9VzEj28bkMlm3HwwAA9j0LNCyWLi/HqnFWfU+KDixXeTm+RSU8uMPdOZ28IAV7b4SZhJJLbfbVqN3jelvWT0U8egILH9nEnGAVMTSGRc7mNvE65t7l17tuTranpByHmcrEEqgBYY1g9ybl5MS9KzBBDmf/EltqlBv281Qmc6WSuW83YaPp9WYKbMC2A7HTX3gSbD5wsNDUhPMotRBKmHLIHrjmKhHVwOFA4C+3xj4yXEeYa6qEOJ4qUYCCjlB4tqa48MPC2pUeOmjSE64iJ13iEqscyRtAlELuaXjn0MHDBlKGD9Z5In3L9Jl44l9Vzr0na03RDqDGQnJGPrx3i+2XhylCmb7RxV9PLeCNO4bB5k9OnG2Xamo0lkXNWQOxKBS0NRvng81BfuMD2C88bPgCEv+Nqz8c0Mhhpg3dIMZlI7wdTU0EKpqQ3bUi5zy2PJyrjJC8bZzNxqdnTdcJvjoFTxAVHcguGsYm3MEh8XXhARS7jHKJZGaRUk/IWcEfkIhK1J6qVAzOQL5C1Y/0rABn2R4z9awYv5n2ePSZyeMZRh75LILfi/3wZHsyrgSMiNEpAla/8/hnLM/xOZWB3F5tTOtAn5zyqoQQR8Ea7qKVczkR0arnFbE+IOTJnR5T3ggwctRs5/E=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(346002)(39860400002)(376002)(136003)(396003)(451199018)(36840700001)(40470700004)(46966006)(2906002)(30864003)(7416002)(5660300002)(8936002)(41300700001)(4326008)(70206006)(70586007)(8676002)(83380400001)(44832011)(54906003)(110136005)(316002)(478600001)(40460700003)(1076003)(426003)(47076005)(40480700001)(336012)(86362001)(82310400005)(2616005)(82740400003)(36756003)(26005)(36860700001)(186003)(356005)(921005)(81166007)(36900700001)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 13:20:20.3879
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86ed7060-ee72-489d-374d-08db1f0eb399
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT078.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8730
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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


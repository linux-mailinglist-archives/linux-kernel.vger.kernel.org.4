Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38BDF6A89B1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 20:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbjCBTnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 14:43:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbjCBTnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 14:43:33 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C6A83CE3B;
        Thu,  2 Mar 2023 11:43:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lJER63E1lzPXmE7/ec2lQZRVsTtzgh8l+QN/kN/M3x1qdaz1dxm06jsDUTANLbEMh5Nj1qkrfmazzrfpDXnSCxOy/GzGauqTx9BeysfW/100x40WnLv+dD5GOVnbJkD3/YmjLlEyU67fhI+7y5yQH4a6WhGox0rvhjPYYf86SLNt22JM3tT8c7wmCochlk/1232/Dvach39ND1Rsv3CbWh4A+owaWYA/jnwVzaQeq7gkk3axA7RIla3+bg0IG5+e8iK46By3VRxXGdFLD72d0Hlh/J751wKkTRKzAPsn+ohaxElHF/Dwi+KmlDhOH+rLnxfU4wXwZbRDt+TAofh76Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xUtmsny6cIQjS+9zsO6Cp3sxnM0wTqT91Jyn3CmEJKs=;
 b=iSUwNugmZtajvwrL0YhG1xEo/rlLrue7Ask4H+1dKtH/E299Q7UNetbRCUffL6qqlpO/27/kan8zbLiCUW5tNJKtLiqWRZYAw0MnbQHnSSJYAZ3zVeZgn9KmeSaGFQpTx3szAfeKTJQfEpNqntYIvEn+qKumuV0nyxE1POhKxKZoH9OYQXIIrwgPkGP6EDZruhBOHSVD/hfJwC9bDK0FfeGLujQzCdOA8GheLA+DbG/zJKFjbhWZlonmKVk30U2+/gOV9qjCaglu80OIWheQ8Lolzh4221NFPsTki2jbpa9jTglWyTe0vas3vxqygPNKb9AM3UHW/2y7vogIb4LwbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=semihalf.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xUtmsny6cIQjS+9zsO6Cp3sxnM0wTqT91Jyn3CmEJKs=;
 b=hLDTGp4nZm2KORrEJgPEmFZfkqnMYxtbaOttE+J9UsBvSPeHjoRwWFKID07wR44DC0RkZYSI7yw2N2tHPurFHVhXWdfn4cm0QwSmivHgjIxRV/WOqjT93xaVzDhAlW5pJp63b2EBUBPVLBlC3Z+FXmiReF09zn5jj4QGhF7T/UM=
Received: from BN8PR12CA0035.namprd12.prod.outlook.com (2603:10b6:408:60::48)
 by DS7PR12MB6238.namprd12.prod.outlook.com (2603:10b6:8:96::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.17; Thu, 2 Mar
 2023 19:43:19 +0000
Received: from BN8NAM11FT091.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:60:cafe::1b) by BN8PR12CA0035.outlook.office365.com
 (2603:10b6:408:60::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19 via Frontend
 Transport; Thu, 2 Mar 2023 19:43:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT091.mail.protection.outlook.com (10.13.176.134) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.20 via Frontend Transport; Thu, 2 Mar 2023 19:43:18 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 2 Mar
 2023 13:43:17 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     =?UTF-8?q?Jan=20D=C4=85bro=C5=9B?= <jsd@semihalf.com>,
        Grzegorz Bernacki <gjb@semihalf.com>,
        <Rijo-john.Thomas@amd.com>, <Thomas.Lendacky@amd.com>,
        <herbert@gondor.apana.org.au>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "John Allen" <john.allen@amd.com>
CC:     Mario Limonciello <mario.limonciello@amd.com>,
        "David S. Miller" <davem@davemloft.net>,
        <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>
Subject: [PATCH v2 4/9] crypto: ccp: Add support for an interface for platform features
Date:   Thu, 2 Mar 2023 13:42:27 -0600
Message-ID: <20230302194235.1724-5-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230302194235.1724-1-mario.limonciello@amd.com>
References: <20230302194235.1724-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT091:EE_|DS7PR12MB6238:EE_
X-MS-Office365-Filtering-Correlation-Id: 66764d5c-7b0e-4db2-f51b-08db1b565f90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LvT2v8bBFMG4PmB92WeRxmIFSub5rb17ZZ7H8WB8tWp++I4AtrLEtmlL1Mho6h/gAW2AOstvaUuKEf5ua+R3zSm+m7VzhhuqWTC0UsgsahJC58wwOZjywACwCuoKx+he58/SPviQzOxi9IIwQEoBEc4yfeWlGnVDk70n0uWrmkbQtOf6WX4Md9l02grf5RttiLzMmwpEpR3ovrRHoFU8tjI2V01CKqTX544c4sMExiLfioT/X4BL1p6RGCE6AJtnSbRNQd+I2rukYK491vgjAcjogzl2wV/fhzeEfexyi317w8ZqgyWQyzeU/cDjDwvyYF1LftCL8MNnm1arHLH6Gt4kNHy8UeNz5YXlG7Zr7l92o2ikDrdmPd9b8pR9RAHANe5lM0y6XCxtnfTwKjoJqMtAJzuzK7DtIhq7oHkWtF6jUgBmoA7JLFeW4IBfx/4HjroKIaQkzeUm53RP1Hc3qOU01jKE6ltgHBPZWGoYX4mX0msMyqlWj0XhBL0GhG47+A+OUxeQfbaRwkYS81Jt7Biag/gZKZfk2IP6XZAZnCUngcgqsGs4nUBVxl05lNKyDOvvoFSNdw8fbz9k/iWYlTLCK12X2ynUQW4V7BNC6jy/Oruf9TioaeFldyjfpEPwCriaQ3N9fdDvjocRaprHwlQMdTT+QUNAYJTUQhBRdf7+m1mqj4WhPvTxQ9DgBkT8FQhgmJoY5DBaJrT9URVHxIQ01xptFHk6hcfT2WECJJa+1uZfB3Q0odEDFKyc220Es+5hoKl1mgygXSvsA+FB4w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(39860400002)(396003)(346002)(451199018)(36840700001)(46966006)(40470700004)(356005)(8676002)(81166007)(36860700001)(82740400003)(2906002)(44832011)(5660300002)(4326008)(36756003)(70206006)(30864003)(86362001)(8936002)(41300700001)(40480700001)(70586007)(186003)(2616005)(16526019)(336012)(40460700003)(26005)(1076003)(83380400001)(47076005)(426003)(316002)(6666004)(478600001)(6636002)(7696005)(54906003)(82310400005)(110136005)(36900700001)(134885004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 19:43:18.7061
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66764d5c-7b0e-4db2-f51b-08db1b565f90
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6238
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some platforms with a PSP support an interface for features that
interact directly with the PSP instead of through a SEV or TEE
environment.

Initialize this interface so that other drivers can consume it.
These drivers may either be subdrivers for the ccp module or
external modules.  For external modules, export a symbol for them
to utilize.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v1->v2:
 * Fix comment text
 * Add safety check that register values were populated
---
 drivers/crypto/ccp/Makefile          |   3 +-
 drivers/crypto/ccp/platform-access.c | 169 +++++++++++++++++++++++++++
 drivers/crypto/ccp/platform-access.h |  34 ++++++
 drivers/crypto/ccp/psp-dev.c         |  17 +++
 drivers/crypto/ccp/psp-dev.h         |   1 +
 drivers/crypto/ccp/sp-dev.h          |   7 ++
 include/linux/psp-platform-access.h  |  49 ++++++++
 7 files changed, 279 insertions(+), 1 deletion(-)
 create mode 100644 drivers/crypto/ccp/platform-access.c
 create mode 100644 drivers/crypto/ccp/platform-access.h
 create mode 100644 include/linux/psp-platform-access.h

diff --git a/drivers/crypto/ccp/Makefile b/drivers/crypto/ccp/Makefile
index db362fe472ea..f6196495e862 100644
--- a/drivers/crypto/ccp/Makefile
+++ b/drivers/crypto/ccp/Makefile
@@ -10,7 +10,8 @@ ccp-$(CONFIG_CRYPTO_DEV_CCP_DEBUGFS) += ccp-debugfs.o
 ccp-$(CONFIG_PCI) += sp-pci.o
 ccp-$(CONFIG_CRYPTO_DEV_SP_PSP) += psp-dev.o \
                                    sev-dev.o \
-                                   tee-dev.o
+                                   tee-dev.o \
+                                   platform-access.o
 
 obj-$(CONFIG_CRYPTO_DEV_CCP_CRYPTO) += ccp-crypto.o
 ccp-crypto-objs := ccp-crypto-main.o \
diff --git a/drivers/crypto/ccp/platform-access.c b/drivers/crypto/ccp/platform-access.c
new file mode 100644
index 000000000000..af3a1e97abfe
--- /dev/null
+++ b/drivers/crypto/ccp/platform-access.c
@@ -0,0 +1,169 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * AMD Platform Security Processor (PSP) Platform Access interface
+ *
+ * Copyright (C) 2023 Advanced Micro Devices, Inc.
+ *
+ * Author: Mario Limonciello <mario.limonciello@amd.com>
+ *
+ * Some of this code is adapted from drivers/i2c/busses/i2c-designware-amdpsp.c
+ * developed by Jan Dabros <jsd@semihalf.com> and Copyright (C) 2022 Google Inc.
+ *
+ */
+
+#include <linux/bitfield.h>
+#include <linux/errno.h>
+#include <linux/iopoll.h>
+#include <linux/mutex.h>
+
+#include "platform-access.h"
+
+#define PSP_CMD_TIMEOUT_US	(500 * USEC_PER_MSEC)
+
+/* Recovery field should be equal 0 to start sending commands */
+static int check_recovery(u32 __iomem *cmd)
+{
+	return FIELD_GET(PSP_CMDRESP_RECOVERY, ioread32(cmd));
+}
+
+static int wait_cmd(u32 __iomem *cmd)
+{
+	u32 tmp, expected;
+
+	/* Expect mbox_cmd to be cleared and ready bit to be set by PSP */
+	expected = FIELD_PREP(PSP_CMDRESP_RESP, 1);
+
+	/*
+	 * Check for readiness of PSP mailbox in a tight loop in order to
+	 * process further as soon as command was consumed.
+	 */
+	return readl_poll_timeout(cmd, tmp, (tmp & expected), 0,
+				  PSP_CMD_TIMEOUT_US);
+}
+
+int psp_check_platform_access_status(void)
+{
+	struct psp_device *psp = psp_get_master_device();
+
+	if (!psp || !psp->platform_access_data)
+		return -ENODEV;
+
+	return 0;
+}
+EXPORT_SYMBOL(psp_check_platform_access_status);
+
+int psp_send_platform_access_msg(enum psp_platform_access_msg msg,
+				 struct psp_request *req)
+{
+	struct psp_device *psp = psp_get_master_device();
+	u32 __iomem *cmd, __iomem *lo, __iomem *hi;
+	struct psp_platform_access_device *pa_dev;
+	phys_addr_t req_addr;
+	u32 cmd_reg;
+	int ret;
+
+	if (!psp || !psp->platform_access_data)
+		return -ENODEV;
+
+	pa_dev = psp->platform_access_data;
+	cmd = psp->io_regs + pa_dev->vdata->cmdresp_reg;
+	lo = psp->io_regs + pa_dev->vdata->cmdbuff_addr_lo_reg;
+	hi = psp->io_regs + pa_dev->vdata->cmdbuff_addr_hi_reg;
+
+	if (!cmd || !lo || !hi)
+		return -ENODEV;
+
+	mutex_lock(&pa_dev->mutex);
+
+	if (check_recovery(cmd)) {
+		dev_dbg(psp->dev, "in recovery\n");
+		ret = -EBUSY;
+		goto unlock;
+	}
+
+	if (wait_cmd(cmd)) {
+		dev_dbg(psp->dev, "not done processing command\n");
+		ret = -EBUSY;
+		goto unlock;
+	}
+
+	/*
+	 * Fill mailbox with address of command-response buffer, which will be
+	 * used for sending i2c requests as well as reading status returned by
+	 * PSP. Use physical address of buffer, since PSP will map this region.
+	 */
+	req_addr = __psp_pa(req);
+	iowrite32(lower_32_bits(req_addr), lo);
+	iowrite32(upper_32_bits(req_addr), hi);
+
+	print_hex_dump_debug("->psp ", DUMP_PREFIX_OFFSET, 16, 2, req,
+			     req->header.payload_size, false);
+
+	/* Write command register to trigger processing */
+	cmd_reg = FIELD_PREP(PSP_CMDRESP_CMD, msg);
+	iowrite32(cmd_reg, cmd);
+
+	if (wait_cmd(cmd)) {
+		ret = -ETIMEDOUT;
+		goto unlock;
+	}
+
+	/* Ensure it was triggered by this driver */
+	if (ioread32(lo) != lower_32_bits(req_addr) ||
+	    ioread32(hi) != upper_32_bits(req_addr)) {
+		ret = -EBUSY;
+		goto unlock;
+	}
+
+	/* Store the status in request header for caller to investigate */
+	cmd_reg = ioread32(cmd);
+	req->header.status = FIELD_GET(PSP_CMDRESP_STS, cmd_reg);
+	if (req->header.status) {
+		ret = -EIO;
+		goto unlock;
+	}
+
+	print_hex_dump_debug("<-psp ", DUMP_PREFIX_OFFSET, 16, 2, req,
+			     req->header.payload_size, false);
+
+	ret = 0;
+
+unlock:
+	mutex_unlock(&pa_dev->mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(psp_send_platform_access_msg);
+
+void platform_access_dev_destroy(struct psp_device *psp)
+{
+	struct psp_platform_access_device *pa_dev = psp->platform_access_data;
+
+	if (!pa_dev)
+		return;
+
+	mutex_destroy(&pa_dev->mutex);
+	psp->platform_access_data = NULL;
+}
+
+int platform_access_dev_init(struct psp_device *psp)
+{
+	struct device *dev = psp->dev;
+	struct psp_platform_access_device *pa_dev;
+
+	pa_dev = devm_kzalloc(dev, sizeof(*pa_dev), GFP_KERNEL);
+	if (!pa_dev)
+		return -ENOMEM;
+
+	psp->platform_access_data = pa_dev;
+	pa_dev->psp = psp;
+	pa_dev->dev = dev;
+
+	pa_dev->vdata = (struct platform_access_vdata *)psp->vdata->platform_access;
+
+	mutex_init(&pa_dev->mutex);
+
+	dev_dbg(dev, "platform access enabled\n");
+
+	return 0;
+}
diff --git a/drivers/crypto/ccp/platform-access.h b/drivers/crypto/ccp/platform-access.h
new file mode 100644
index 000000000000..56bc8eabeacc
--- /dev/null
+++ b/drivers/crypto/ccp/platform-access.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * AMD Platform Security Processor (PSP) Platform Access interface
+ *
+ * Copyright (C) 2023 Advanced Micro Devices, Inc.
+ *
+ * Author: Mario Limonciello <mario.limonciello@amd.com>
+ */
+
+#ifndef __PSP_PLATFORM_ACCESS_H__
+#define __PSP_PLATFORM_ACCESS_H__
+
+#include <linux/device.h>
+#include <linux/miscdevice.h>
+#include <linux/mutex.h>
+#include <linux/psp-platform-access.h>
+
+#include "psp-dev.h"
+
+struct psp_platform_access_device {
+	struct device *dev;
+	struct psp_device *psp;
+
+	struct platform_access_vdata *vdata;
+
+	struct mutex mutex;
+
+	void *platform_access_data;
+};
+
+void platform_access_dev_destroy(struct psp_device *psp);
+int platform_access_dev_init(struct psp_device *psp);
+
+#endif /* __PSP_PLATFORM_ACCESS_H__ */
diff --git a/drivers/crypto/ccp/psp-dev.c b/drivers/crypto/ccp/psp-dev.c
index cd8d1974726a..ec98f19800de 100644
--- a/drivers/crypto/ccp/psp-dev.c
+++ b/drivers/crypto/ccp/psp-dev.c
@@ -14,6 +14,7 @@
 #include "psp-dev.h"
 #include "sev-dev.h"
 #include "tee-dev.h"
+#include "platform-access.h"
 
 struct psp_device *psp_master;
 
@@ -102,6 +103,17 @@ static int psp_check_tee_support(struct psp_device *psp)
 	return 0;
 }
 
+static void psp_init_platform_access(struct psp_device *psp)
+{
+	int ret;
+
+	ret = platform_access_dev_init(psp);
+	if (ret) {
+		dev_warn(psp->dev, "platform access init failed: %d\n", ret);
+		return;
+	}
+}
+
 static int psp_init(struct psp_device *psp)
 {
 	int ret;
@@ -118,6 +130,9 @@ static int psp_init(struct psp_device *psp)
 			return ret;
 	}
 
+	if (psp->vdata->platform_access)
+		psp_init_platform_access(psp);
+
 	return 0;
 }
 
@@ -198,6 +213,8 @@ void psp_dev_destroy(struct sp_device *sp)
 
 	tee_dev_destroy(psp);
 
+	platform_access_dev_destroy(psp);
+
 	sp_free_psp_irq(sp, psp);
 
 	if (sp->clear_psp_master_device)
diff --git a/drivers/crypto/ccp/psp-dev.h b/drivers/crypto/ccp/psp-dev.h
index 55f54bb2b3fb..505e4bdeaca8 100644
--- a/drivers/crypto/ccp/psp-dev.h
+++ b/drivers/crypto/ccp/psp-dev.h
@@ -39,6 +39,7 @@ struct psp_device {
 
 	void *sev_data;
 	void *tee_data;
+	void *platform_access_data;
 
 	unsigned int capability;
 };
diff --git a/drivers/crypto/ccp/sp-dev.h b/drivers/crypto/ccp/sp-dev.h
index 20377e67f65d..5ec6c219a731 100644
--- a/drivers/crypto/ccp/sp-dev.h
+++ b/drivers/crypto/ccp/sp-dev.h
@@ -53,9 +53,16 @@ struct tee_vdata {
 	const unsigned int ring_rptr_reg;
 };
 
+struct platform_access_vdata {
+	const unsigned int cmdresp_reg;
+	const unsigned int cmdbuff_addr_lo_reg;
+	const unsigned int cmdbuff_addr_hi_reg;
+};
+
 struct psp_vdata {
 	const struct sev_vdata *sev;
 	const struct tee_vdata *tee;
+	const struct platform_access_vdata *platform_access;
 	const unsigned int feature_reg;
 	const unsigned int inten_reg;
 	const unsigned int intsts_reg;
diff --git a/include/linux/psp-platform-access.h b/include/linux/psp-platform-access.h
new file mode 100644
index 000000000000..977df5cfd494
--- /dev/null
+++ b/include/linux/psp-platform-access.h
@@ -0,0 +1,49 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __PSP_PLATFORM_ACCESS_H
+#define __PSP_PLATFORM_ACCESS_H
+
+#include <linux/psp.h>
+
+enum psp_platform_access_msg {
+	PSP_CMD_NONE = 0x0,
+};
+
+struct psp_req_buffer_hdr {
+	u32 payload_size;
+	u32 status;
+} __packed;
+
+struct psp_request {
+	struct psp_req_buffer_hdr header;
+	void *buf;
+} __packed;
+
+/**
+ * psp_send_platform_access_msg() - Send a message to control platform features
+ *
+ * This function is intended to be used by drivers outside of ccp to communicate
+ * with the platform.
+ *
+ * Returns:
+ *  0:           success
+ *  -%EBUSY:     mailbox in recovery or in use
+ *  -%ENODEV:    driver not bound with PSP device
+ *  -%ETIMEDOUT: request timed out
+ *  -%EIO:       unknown error (see kernel log)
+ */
+int psp_send_platform_access_msg(enum psp_platform_access_msg, struct psp_request *req);
+
+/**
+ * psp_check_platform_access_status() - Checks whether platform features is ready
+ *
+ * This function is intended to be used by drivers outside of ccp to determine
+ * if platform features has initialized.
+ *
+ * Returns:
+ * 0          platform features is ready
+ * -%ENODEV   platform features is not ready or present
+ */
+int psp_check_platform_access_status(void);
+
+#endif /* __PSP_PLATFORM_ACCESS_H */
-- 
2.34.1


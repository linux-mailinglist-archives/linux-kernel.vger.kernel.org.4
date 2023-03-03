Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66D806A9C5F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 17:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbjCCQwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 11:52:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbjCCQvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 11:51:45 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880F32A9BA;
        Fri,  3 Mar 2023 08:51:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SpuJPBpJvuJQAveOqxEXLWnoH++65ZilG1nZo4G+VttsH/Zw5Glns03kVwabgWJF1h7zthE9tKmRvSeNGouHueyY5bsimHcLt6kBCXmfkYmHuJwYLcdb7L+o93V9OCzF+3vdj5rt2bIYC5HfdJL8RWrjSShqXgy3kmYXvAQvD6h7KY7t5QVCgxFtw6PH54H15AQ6pU6TAVlKAmVGGmeXwEgUrHzTz4gvgz/MWaTsBxQOtmnQMnbcZRiXoPh3EZvYiPwNB9YhFLKaIDYt2KVGAOHbkPgGxic052X29cU7n/VNlhm3K0jRNvKAW01xv6XTHjWiJ8SGHfDO6850/kTQqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1LXQZNcsHenERtVDrZA/SwXiK5PBf2Fr+PU/GB2YjOg=;
 b=An9G6qVeI8n0zq5iSEv9YMFyf99OjbYJxWWnWxmuUyn9swF9Gi74jP9theeJKZgsZmzVxntHAIebYkfU+hg4U+Txxh5Kyu3U5rtH4EA+ALxHC3HnT6CFfSUwokrg47Oa6CKlzDzDzgpX9r2L1Ty5FtbvPwR4ZMvzJblPK7YBBG2PGsiAuEhz3U4ABHQTMH1agphMhytZLsVlA492R62Se6VQdTur2HwZ2eywYz5TjVcqzSthBVJOGfybvum/gUF5UTm9BEqgfgNZ4gC8bQGmZm+dn7dLPStAN8GWq4f/Kttm0wHkimSJ7UXhSaRHlv8phnL9a5OjxzLCCQHKAnYYHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=semihalf.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1LXQZNcsHenERtVDrZA/SwXiK5PBf2Fr+PU/GB2YjOg=;
 b=X/ot5YXhxlWXLOpLgDZ0Mq8yqHWcEuTFIxxrkB0HZLgGKwewm7k1pm/4AUDV1K6zHHXnipjGQlYs5QxIeA2JjZq8KafNU+N9XNxEB5Ii9UWT5doFBqW+sEdlMQwRg+yXN/VxyjtstmaCgduoxT4+nNnkkqyTKe9OdaPQZA4yAKs=
Received: from MW4PR04CA0157.namprd04.prod.outlook.com (2603:10b6:303:85::12)
 by PH7PR12MB7966.namprd12.prod.outlook.com (2603:10b6:510:274::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Fri, 3 Mar
 2023 16:51:14 +0000
Received: from CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::1a) by MW4PR04CA0157.outlook.office365.com
 (2603:10b6:303:85::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.22 via Frontend
 Transport; Fri, 3 Mar 2023 16:51:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT054.mail.protection.outlook.com (10.13.174.70) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.22 via Frontend Transport; Fri, 3 Mar 2023 16:51:14 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 3 Mar
 2023 10:51:11 -0600
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
Subject: [PATCH v3 4/9] crypto: ccp: Add support for an interface for platform features
Date:   Fri, 3 Mar 2023 10:50:42 -0600
Message-ID: <20230303165050.2918-5-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230303165050.2918-1-mario.limonciello@amd.com>
References: <20230303165050.2918-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT054:EE_|PH7PR12MB7966:EE_
X-MS-Office365-Filtering-Correlation-Id: a716691e-b4a9-4e7d-ccd3-08db1c078021
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2BXzNzK7T5bXi7cHgIOu4k1Og+EFfvlmPAEnjtJ+te7ga4EPYdpIF9MiQ8rpj3d1jhidwXHw9vqzP+Tsvlh0euDPD9BTgbejQ5KTMcxRCi6kLqwjlvQL2FZWXT2hIn+QqYhiZf2VKGE5LxRX+1CrBjfUOxr4XNIgx4B620PRev0y4emij3jFn+yxkV+cM82lX2f4TKkfxrIF2wOUSMorlT5+tt+x+XR3Ujk1xi6b8sHf7OUiHr94xhqFDQ+XsA5iZRgXjT1LmpBVeUuvW66wPD3ktgqZtf7HR7/sj1znwpTYukPxrhZJxnWyHmdHqmkEuKGDs0xMyo3be9OjnBen40FRnSJZKciTpBnmf2V9mj3wxqcodYW5sfwO3zzLq4gs3pW7/F8WAqqKyPfY1qXPlssz4CNlShTDnZkHyEVXtmVQu8jRbPVLmExwq7J0gM2v497FI/D8Hh+uerWv/N4t60LVyFpKkSRPESC3qiVqCnaaK/02bIZdKSZUWDqgW2siM1X5fYTrw76Da+/QyeqCy0IwVDBoZ/UEuEg9g+gOUxWjHwfQe76hbdXTP8ARRQa356gw2HSEjtu1AaM6RmP0Eci4orXDIFF72T0LVLnnKm2+3fYx2boDrs5Ry/ufWXINhyFlB+FRzwF6II1m84JV+Z/rClgyRaeWzcG49E+DaKemp9+RghzZLO9d/tMfrT9XZt+wuiyvlvg99NsMKj5OrFR+t2LQMXw+Gqh66Cgp9olmYPWEyLPHK2poi9B1GQiixntXR7ky5mndkib8k92dtA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(136003)(376002)(346002)(451199018)(46966006)(36840700001)(40470700004)(2906002)(82740400003)(41300700001)(316002)(478600001)(44832011)(5660300002)(82310400005)(30864003)(83380400001)(36756003)(40460700003)(8936002)(40480700001)(336012)(70206006)(8676002)(4326008)(70586007)(356005)(110136005)(81166007)(6636002)(54906003)(86362001)(36860700001)(7696005)(2616005)(426003)(47076005)(26005)(6666004)(1076003)(186003)(16526019)(36900700001)(134885004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2023 16:51:14.1698
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a716691e-b4a9-4e7d-ccd3-08db1c078021
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7966
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
v2->v3:
 * Drop safety check
 * Rename mutex
 * Add unique messages
v1->v2:
 * Fix comment text
 * Add safety check that register values were populated
---
 drivers/crypto/ccp/Makefile          |   3 +-
 drivers/crypto/ccp/platform-access.c | 166 +++++++++++++++++++++++++++
 drivers/crypto/ccp/platform-access.h |  34 ++++++
 drivers/crypto/ccp/psp-dev.c         |  17 +++
 drivers/crypto/ccp/psp-dev.h         |   1 +
 drivers/crypto/ccp/sp-dev.h          |   7 ++
 include/linux/psp-platform-access.h  |  49 ++++++++
 7 files changed, 276 insertions(+), 1 deletion(-)
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
index 000000000000..d7669a44dcfe
--- /dev/null
+++ b/drivers/crypto/ccp/platform-access.c
@@ -0,0 +1,166 @@
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
+	mutex_lock(&pa_dev->mailbox_mutex);
+
+	if (check_recovery(cmd)) {
+		dev_dbg(psp->dev, "platform mailbox is in recovery\n");
+		ret = -EBUSY;
+		goto unlock;
+	}
+
+	if (wait_cmd(cmd)) {
+		dev_dbg(psp->dev, "platform mailbox is not done processing command\n");
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
+	mutex_unlock(&pa_dev->mailbox_mutex);
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
+	mutex_destroy(&pa_dev->mailbox_mutex);
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
+	mutex_init(&pa_dev->mailbox_mutex);
+
+	dev_dbg(dev, "platform access enabled\n");
+
+	return 0;
+}
diff --git a/drivers/crypto/ccp/platform-access.h b/drivers/crypto/ccp/platform-access.h
new file mode 100644
index 000000000000..c3a97893320d
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
+	struct mutex mailbox_mutex;
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


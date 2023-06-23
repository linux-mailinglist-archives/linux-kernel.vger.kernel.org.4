Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1B8173BE6D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 20:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbjFWScM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 14:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232102AbjFWSbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 14:31:48 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2086.outbound.protection.outlook.com [40.107.101.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D093D2729;
        Fri, 23 Jun 2023 11:31:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=djuzsG1MYumGpSGce2nqn72rc8cILZPV/Es/VUjB9YltiuYYX1O0WKt3EcWwkLTHV85mMXBOQFJK3PkM7gosDW1SlCRDchjgkIWniYJNJN7FJSqwL097dpC0nHZe97AwNK2OAfPdTB3SslW3ZU+KQs8PwEHsJKoY5uCzr4sJiEbNzikXDhu1GHP6ZpPYLSuwxkyTl633t6EIxc2FBu/22mND70C3Gw3Zv3pm7wzWeKa113Mvu7fQIR3sn41V7l5qsJsH/52Eh9dyqYYS/RDopVyqrUutk2VCjXJQkVCHzBglJQAxzi7aSwlFoQbqD+ivnuDrIThdFhF4irpcWjqrNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LcKSDg07CXZRDLfL73qKPCaBUuO7BbORSlUSKvxtoYI=;
 b=ARIU2RxbDruJh4k1rTfMStER/NOR8qst0hLsdoK48ULh1n+Oz7DuvQ7Oj5zIky8W84NHy8C6s41BdIAJ2YXnYUIbY7XZqer+2xQgOuYUiit8xcRVU6bf/rK6+U5rKadVmMR+RWOoatUbycofZ8ri9G0i/gfFYuzHrCysWJQbHnQ0d/SMjrOzKl0KepHchppAIMt1YsGwjyGFhU2cr8qzLFcoKnEAiqpiIhE4vhhG1GP63bkvzJmNhVuclMjM4k7pMD9+kcbI3oEL24njuuFIWJYqgfkDFYaXUxXwDrLArAA39V0yiCIz/Htt34nwhPRjmuUyC6J+7wQstCRe4HAqQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LcKSDg07CXZRDLfL73qKPCaBUuO7BbORSlUSKvxtoYI=;
 b=JGvwhHE6hopHQpMwyAzhZHExRWzQovShh3tTWyBqyb7oI6rNpST9B0rT13rB4WFR7hspYxUUyMHWWKs5ilnbqlsxuVsDBVrMof2G/lrCEm1a8a5Zdbo3MiaVA79iAjItMxfzBfsC6uPa5yXU7nRl1z5CA5J4ZjVr3XPjME4eOKA=
Received: from BL1P221CA0025.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::13)
 by CH3PR12MB9218.namprd12.prod.outlook.com (2603:10b6:610:19f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Fri, 23 Jun
 2023 18:31:38 +0000
Received: from BL02EPF000145B8.namprd05.prod.outlook.com
 (2603:10b6:208:2c5:cafe::dc) by BL1P221CA0025.outlook.office365.com
 (2603:10b6:208:2c5::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26 via Frontend
 Transport; Fri, 23 Jun 2023 18:31:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000145B8.mail.protection.outlook.com (10.167.241.208) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.17 via Frontend Transport; Fri, 23 Jun 2023 18:31:38 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 23 Jun
 2023 13:31:35 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        John Allen <john.allen@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
CC:     "David S . Miller" <davem@davemloft.net>,
        <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v5 05/11] crypto: ccp: Add support for fetching a nonce for dynamic boost control
Date:   Fri, 23 Jun 2023 08:49:55 -0500
Message-ID: <20230623135001.18672-6-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230623135001.18672-1-mario.limonciello@amd.com>
References: <20230623135001.18672-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000145B8:EE_|CH3PR12MB9218:EE_
X-MS-Office365-Filtering-Correlation-Id: aebe5c43-1007-45e0-d6e1-08db741814f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HAGccXkuT54iMTKzxiIWHPDPZ6102l4uakZWqWv1kt9MEzsB7wRfsuggF5Cc2fPTKqrm/sAEm33EMxOgkZ6fUlaccuG4Yu6lk6pjtw0QFRFbzGJ4WvjkbTU00T8TsBJpFnEwIJ/EZLhWOEJLfFm85okbt482fYuP+s1ohkHNqXJXesZmZmHKDmE2G6NnwjkX9wH4lKKLyri5yZZ4HsI/u5OH1GA+AYrtH8MZ2KHyVY1SmTmye8TwxQAGqowkWe+g5IBs+PExtlkhKqvtMT6QOpCsFethXDjgQLfwEa2e7R8AzCW0GXKyfo3rNOhyZtGvILvgpmjUzLtRIZ4fPkX6UiKeIm6KwjtJ4L4g8SPtpNGDsM1VJQZqeSdj7p3L6XLFkVT979KIl9MD515e/+XyAoJQbiD3dkJqv2Fh1mLFAU4I+htISfIQiq5YcKT1G8lJbrQL9wY6XI5u9MwivPmjZzAtzWnOoVZshWtBGE5QTWVYmdpKg4qdM4cDATeBrCOFZBJ+SMFstxZIMYaTJaK/oRxv269Ljz0iNEN+5RV1vl+say3PDv5FyVosN1AHTfNOfzknBMXEGhKSYefb9qFhVmBDsAibzAklNpUwfEppXg+FA9NN1+roP+r+6qiJAjL4Pfk86gUl4xx3H1JSflrBlbU4yS0PlDB5G+CNwqia7voa6XKKaCHvj1B4r1Ud5jVb4x3GDkoP6f30SsiXxrBq3UpHpRep7vqrJSjW9UpjFl1OGaqJUFH2YgLM7GAMFB36GYAZZKXSxb0rfmT+d4hQLQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(396003)(136003)(346002)(451199021)(46966006)(40470700004)(36840700001)(44832011)(2906002)(30864003)(40480700001)(8676002)(8936002)(316002)(41300700001)(5660300002)(66899021)(70206006)(70586007)(4326008)(40460700003)(6666004)(336012)(426003)(82740400003)(7696005)(478600001)(36756003)(82310400005)(186003)(81166007)(356005)(2616005)(16526019)(47076005)(86362001)(83380400001)(110136005)(1076003)(26005)(36860700001)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 18:31:38.2150
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aebe5c43-1007-45e0-d6e1-08db741814f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000145B8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9218
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dynamic Boost Control is a feature offered on AMD client platforms that
allows software to request and set power or frequency limits.

Only software that has authenticated with the PSP can retrieve or set
these limits.

Create a character device and ioctl for fetching the nonce. This ioctl
supports optionally passing authentication information which will influence
how many calls the nonce is valid for.

Acked-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v4->v5:
 * Pick up tag
 * Add a missing static for dbc_fops
---
 drivers/crypto/ccp/Makefile         |   3 +-
 drivers/crypto/ccp/dbc.c            | 191 ++++++++++++++++++++++++++++
 drivers/crypto/ccp/dbc.h            |  44 +++++++
 drivers/crypto/ccp/psp-dev.c        |   9 ++
 drivers/crypto/ccp/psp-dev.h        |   1 +
 drivers/crypto/ccp/sp-dev.h         |   5 +
 drivers/crypto/ccp/sp-pci.c         |   1 +
 include/linux/psp-platform-access.h |   1 +
 include/uapi/linux/psp-dbc.h        |  67 ++++++++++
 9 files changed, 321 insertions(+), 1 deletion(-)
 create mode 100644 drivers/crypto/ccp/dbc.c
 create mode 100644 drivers/crypto/ccp/dbc.h
 create mode 100644 include/uapi/linux/psp-dbc.h

diff --git a/drivers/crypto/ccp/Makefile b/drivers/crypto/ccp/Makefile
index f6196495e862d..aa0ba2d17e1e2 100644
--- a/drivers/crypto/ccp/Makefile
+++ b/drivers/crypto/ccp/Makefile
@@ -11,7 +11,8 @@ ccp-$(CONFIG_PCI) += sp-pci.o
 ccp-$(CONFIG_CRYPTO_DEV_SP_PSP) += psp-dev.o \
                                    sev-dev.o \
                                    tee-dev.o \
-                                   platform-access.o
+                                   platform-access.o \
+                                   dbc.o
 
 obj-$(CONFIG_CRYPTO_DEV_CCP_CRYPTO) += ccp-crypto.o
 ccp-crypto-objs := ccp-crypto-main.o \
diff --git a/drivers/crypto/ccp/dbc.c b/drivers/crypto/ccp/dbc.c
new file mode 100644
index 0000000000000..f65e93a81e53f
--- /dev/null
+++ b/drivers/crypto/ccp/dbc.c
@@ -0,0 +1,191 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * AMD Secure Processor Dynamic Boost Control interface
+ *
+ * Copyright (C) 2023 Advanced Micro Devices, Inc.
+ *
+ * Author: Mario Limonciello <mario.limonciello@amd.com>
+ */
+
+#include "dbc.h"
+
+struct error_map {
+	u32 psp;
+	int ret;
+};
+
+#define DBC_ERROR_ACCESS_DENIED		0x0001
+#define DBC_ERROR_EXCESS_DATA		0x0004
+#define DBC_ERROR_BAD_PARAMETERS	0x0006
+#define DBC_ERROR_BAD_STATE		0x0007
+#define DBC_ERROR_NOT_IMPLEMENTED	0x0009
+#define DBC_ERROR_BUSY			0x000D
+#define DBC_ERROR_MESSAGE_FAILURE	0x0307
+#define DBC_ERROR_OVERFLOW		0x300F
+#define DBC_ERROR_SIGNATURE_INVALID	0x3072
+
+static struct error_map error_codes[] = {
+	{DBC_ERROR_ACCESS_DENIED,	-EACCES},
+	{DBC_ERROR_EXCESS_DATA,		-E2BIG},
+	{DBC_ERROR_BAD_PARAMETERS,	-EINVAL},
+	{DBC_ERROR_BAD_STATE,		-EAGAIN},
+	{DBC_ERROR_MESSAGE_FAILURE,	-ENOENT},
+	{DBC_ERROR_NOT_IMPLEMENTED,	-ENOENT},
+	{DBC_ERROR_BUSY,		-EBUSY},
+	{DBC_ERROR_OVERFLOW,		-ENFILE},
+	{DBC_ERROR_SIGNATURE_INVALID,	-EPERM},
+	{0x0,	0x0},
+};
+
+static int send_dbc_cmd(struct psp_dbc_device *dbc_dev,
+			enum psp_platform_access_msg msg)
+{
+	int ret;
+
+	dbc_dev->mbox->req.header.status = 0;
+	ret = psp_send_platform_access_msg(msg, (struct psp_request *)dbc_dev->mbox);
+	if (ret == -EIO) {
+		int i;
+
+		dev_dbg(dbc_dev->dev,
+			 "msg 0x%x failed with PSP error: 0x%x\n",
+			 msg, dbc_dev->mbox->req.header.status);
+
+		for (i = 0; error_codes[i].psp; i++) {
+			if (dbc_dev->mbox->req.header.status == error_codes[i].psp)
+				return error_codes[i].ret;
+		}
+	}
+
+	return ret;
+}
+
+static int send_dbc_nonce(struct psp_dbc_device *dbc_dev)
+{
+	int ret;
+
+	dbc_dev->mbox->req.header.payload_size = sizeof(dbc_dev->mbox->dbc_nonce);
+	ret = send_dbc_cmd(dbc_dev, PSP_DYNAMIC_BOOST_GET_NONCE);
+	if (ret == -EAGAIN) {
+		dev_dbg(dbc_dev->dev, "retrying get nonce\n");
+		ret = send_dbc_cmd(dbc_dev, PSP_DYNAMIC_BOOST_GET_NONCE);
+	}
+
+	return ret;
+}
+
+void dbc_dev_destroy(struct psp_device *psp)
+{
+	struct psp_dbc_device *dbc_dev = psp->dbc_data;
+
+	if (!dbc_dev)
+		return;
+
+	misc_deregister(&dbc_dev->char_dev);
+	mutex_destroy(&dbc_dev->ioctl_mutex);
+	psp->dbc_data = NULL;
+}
+
+static long dbc_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
+{
+	struct psp_device *psp_master = psp_get_master_device();
+	void __user *argp = (void __user *)arg;
+	struct psp_dbc_device *dbc_dev;
+	int ret;
+
+	if (!psp_master || !psp_master->dbc_data)
+		return -ENODEV;
+	dbc_dev = psp_master->dbc_data;
+
+	mutex_lock(&dbc_dev->ioctl_mutex);
+
+	switch (cmd) {
+	case DBCIOCNONCE:
+		if (copy_from_user(&dbc_dev->mbox->dbc_nonce.user, argp,
+				   sizeof(struct dbc_user_nonce))) {
+			ret = -EFAULT;
+			goto unlock;
+		}
+
+		ret = send_dbc_nonce(dbc_dev);
+		if (ret)
+			goto unlock;
+
+		if (copy_to_user(argp, &dbc_dev->mbox->dbc_nonce.user,
+				 sizeof(struct dbc_user_nonce))) {
+			ret = -EFAULT;
+			goto unlock;
+		}
+		break;
+	default:
+		ret = -EINVAL;
+
+	}
+unlock:
+	mutex_unlock(&dbc_dev->ioctl_mutex);
+
+	return ret;
+}
+
+static const struct file_operations dbc_fops = {
+	.owner	= THIS_MODULE,
+	.unlocked_ioctl = dbc_ioctl,
+};
+
+int dbc_dev_init(struct psp_device *psp)
+{
+	struct device *dev = psp->dev;
+	struct psp_dbc_device *dbc_dev;
+	int ret;
+
+	if (!PSP_FEATURE(psp, DBC))
+		return 0;
+
+	dbc_dev = devm_kzalloc(dev, sizeof(*dbc_dev), GFP_KERNEL);
+	if (!dbc_dev)
+		return -ENOMEM;
+
+	BUILD_BUG_ON(sizeof(union dbc_buffer) > PAGE_SIZE);
+	dbc_dev->mbox = (void *)devm_get_free_pages(dev, GFP_KERNEL, 0);
+	if (!dbc_dev->mbox) {
+		ret = -ENOMEM;
+		goto cleanup_dev;
+	}
+
+	psp->dbc_data = dbc_dev;
+	dbc_dev->dev = dev;
+
+	ret = send_dbc_nonce(dbc_dev);
+	if (ret == -EACCES) {
+		dev_dbg(dbc_dev->dev,
+			"dynamic boost control was previously authenticated\n");
+		ret = 0;
+	}
+	dev_dbg(dbc_dev->dev, "dynamic boost control is %savailable\n",
+		ret ? "un" : "");
+	if (ret) {
+		ret = 0;
+		goto cleanup_mbox;
+	}
+
+	dbc_dev->char_dev.minor = MISC_DYNAMIC_MINOR;
+	dbc_dev->char_dev.name = "dbc";
+	dbc_dev->char_dev.fops = &dbc_fops;
+	dbc_dev->char_dev.mode = 0600;
+	ret = misc_register(&dbc_dev->char_dev);
+	if (ret)
+		goto cleanup_mbox;
+
+	mutex_init(&dbc_dev->ioctl_mutex);
+
+	return 0;
+
+cleanup_mbox:
+	devm_free_pages(dev, (unsigned long)dbc_dev->mbox);
+
+cleanup_dev:
+	psp->dbc_data = NULL;
+	devm_kfree(dev, dbc_dev);
+
+	return ret;
+}
diff --git a/drivers/crypto/ccp/dbc.h b/drivers/crypto/ccp/dbc.h
new file mode 100644
index 0000000000000..1c3a0a078d156
--- /dev/null
+++ b/drivers/crypto/ccp/dbc.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * AMD Platform Security Processor (PSP) Dynamic Boost Control support
+ *
+ * Copyright (C) 2023 Advanced Micro Devices, Inc.
+ *
+ * Author: Mario Limonciello <mario.limonciello@amd.com>
+ */
+
+#ifndef __DBC_H__
+#define __DBC_H__
+
+#include <uapi/linux/psp-dbc.h>
+
+#include <linux/device.h>
+#include <linux/miscdevice.h>
+#include <linux/psp-platform-access.h>
+
+#include "psp-dev.h"
+
+struct psp_dbc_device {
+	struct device *dev;
+
+	union dbc_buffer *mbox;
+
+	struct mutex ioctl_mutex;
+
+	struct miscdevice char_dev;
+};
+
+struct dbc_nonce {
+	struct psp_req_buffer_hdr	header;
+	struct dbc_user_nonce		user;
+} __packed;
+
+union dbc_buffer {
+	struct psp_request		req;
+	struct dbc_nonce		dbc_nonce;
+};
+
+void dbc_dev_destroy(struct psp_device *psp);
+int dbc_dev_init(struct psp_device *psp);
+
+#endif /* __DBC_H */
diff --git a/drivers/crypto/ccp/psp-dev.c b/drivers/crypto/ccp/psp-dev.c
index 3390f0bd64085..d42d7bc623523 100644
--- a/drivers/crypto/ccp/psp-dev.c
+++ b/drivers/crypto/ccp/psp-dev.c
@@ -15,6 +15,7 @@
 #include "sev-dev.h"
 #include "tee-dev.h"
 #include "platform-access.h"
+#include "dbc.h"
 
 struct psp_device *psp_master;
 
@@ -112,6 +113,12 @@ static void psp_init_platform_access(struct psp_device *psp)
 		dev_warn(psp->dev, "platform access init failed: %d\n", ret);
 		return;
 	}
+
+	/* dbc must come after platform access as it tests the feature */
+	ret = dbc_dev_init(psp);
+	if (ret)
+		dev_warn(psp->dev, "failed to init dynamic boost control: %d\n",
+			 ret);
 }
 
 static int psp_init(struct psp_device *psp)
@@ -217,6 +224,8 @@ void psp_dev_destroy(struct sp_device *sp)
 
 	tee_dev_destroy(psp);
 
+	dbc_dev_destroy(psp);
+
 	platform_access_dev_destroy(psp);
 
 	sp_free_psp_irq(sp, psp);
diff --git a/drivers/crypto/ccp/psp-dev.h b/drivers/crypto/ccp/psp-dev.h
index 505e4bdeaca84..8a4de69399c59 100644
--- a/drivers/crypto/ccp/psp-dev.h
+++ b/drivers/crypto/ccp/psp-dev.h
@@ -40,6 +40,7 @@ struct psp_device {
 	void *sev_data;
 	void *tee_data;
 	void *platform_access_data;
+	void *dbc_data;
 
 	unsigned int capability;
 };
diff --git a/drivers/crypto/ccp/sp-dev.h b/drivers/crypto/ccp/sp-dev.h
index 76c32ee6bd657..2329ad524b494 100644
--- a/drivers/crypto/ccp/sp-dev.h
+++ b/drivers/crypto/ccp/sp-dev.h
@@ -28,6 +28,10 @@
 #define CACHE_NONE			0x00
 #define CACHE_WB_NO_ALLOC		0xb7
 
+#define PLATFORM_FEATURE_DBC		0x1
+
+#define PSP_FEATURE(psp, feat)	(psp->vdata && psp->vdata->platform_features & PLATFORM_FEATURE_##feat)
+
 /* Structure to hold CCP device data */
 struct ccp_device;
 struct ccp_vdata {
@@ -71,6 +75,7 @@ struct psp_vdata {
 	const unsigned int inten_reg;
 	const unsigned int intsts_reg;
 	const unsigned int bootloader_info_reg;
+	const unsigned int platform_features;
 };
 
 /* Structure to hold SP device data */
diff --git a/drivers/crypto/ccp/sp-pci.c b/drivers/crypto/ccp/sp-pci.c
index 205b93d229a95..b6ab56abeb682 100644
--- a/drivers/crypto/ccp/sp-pci.c
+++ b/drivers/crypto/ccp/sp-pci.c
@@ -470,6 +470,7 @@ static const struct psp_vdata pspv3 = {
 	.feature_reg		= 0x109fc,	/* C2PMSG_63 */
 	.inten_reg		= 0x10690,	/* P2CMSG_INTEN */
 	.intsts_reg		= 0x10694,	/* P2CMSG_INTSTS */
+	.platform_features	= PLATFORM_FEATURE_DBC,
 };
 
 static const struct psp_vdata pspv4 = {
diff --git a/include/linux/psp-platform-access.h b/include/linux/psp-platform-access.h
index 75da8f5f7ad84..53b4a1df51806 100644
--- a/include/linux/psp-platform-access.h
+++ b/include/linux/psp-platform-access.h
@@ -8,6 +8,7 @@
 enum psp_platform_access_msg {
 	PSP_CMD_NONE = 0x0,
 	PSP_I2C_REQ_BUS_CMD = 0x64,
+	PSP_DYNAMIC_BOOST_GET_NONCE,
 };
 
 struct psp_req_buffer_hdr {
diff --git a/include/uapi/linux/psp-dbc.h b/include/uapi/linux/psp-dbc.h
new file mode 100644
index 0000000000000..d032f78934e27
--- /dev/null
+++ b/include/uapi/linux/psp-dbc.h
@@ -0,0 +1,67 @@
+/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
+/*
+ * Userspace interface for AMD Dynamic Boost Control (DBC)
+ *
+ * Copyright (C) 2023 Advanced Micro Devices, Inc.
+ *
+ * Author: Mario Limonciello <mario.limonciello@amd.com>
+ */
+
+#ifndef __PSP_DBC_USER_H__
+#define __PSP_DBC_USER_H__
+
+#include <linux/types.h>
+
+/**
+ * DOC: AMD Dynamic Boost Control (DBC) interface
+ */
+
+#define DBC_NONCE_SIZE		16
+#define DBC_SIG_SIZE		32
+
+/**
+ * struct dbc_user_nonce - Nonce exchange structure (input/output).
+ * @auth_needed: Whether the PSP should authenticate this request (input).
+ *               0: no authentication, PSP will return single use nonce.
+ *               1: authentication: PSP will return multi-use nonce.
+ * @nonce:       8 byte value used for future authentication (output).
+ * @signature:   Optional 32 byte signature created by software using a
+ *               previous nonce (input).
+ */
+struct dbc_user_nonce {
+	__u32	auth_needed;
+	__u8	nonce[DBC_NONCE_SIZE];
+	__u8	signature[DBC_SIG_SIZE];
+} __packed;
+
+/**
+ * Dynamic Boost Control (DBC) IOC
+ *
+ * possible return codes for all DBC IOCTLs:
+ *  0:          success
+ *  -EINVAL:    invalid input
+ *  -E2BIG:     excess data passed
+ *  -EFAULT:    failed to copy to/from userspace
+ *  -EBUSY:     mailbox in recovery or in use
+ *  -ENODEV:    driver not bound with PSP device
+ *  -EACCES:    request isn't authorized
+ *  -EINVAL:    invalid parameter
+ *  -ETIMEDOUT: request timed out
+ *  -EAGAIN:    invalid request for state machine
+ *  -ENOENT:    not implemented
+ *  -ENFILE:    overflow
+ *  -EPERM:     invalid signature
+ *  -EIO:       unknown error
+ */
+#define DBC_IOC_TYPE	'D'
+
+/**
+ * DBCIOCNONCE - Fetch a nonce from the PSP for authenticating commands.
+ *               If a nonce is fetched without authentication it can only
+ *               be utilized for one command.
+ *               If a nonce is fetched with authentication it can be used
+ *               for multiple requests.
+ */
+#define DBCIOCNONCE	_IOWR(DBC_IOC_TYPE, 0x1, struct dbc_user_nonce)
+
+#endif /* __PSP_DBC_USER_H__ */
-- 
2.34.1


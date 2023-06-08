Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1138F7287DA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 21:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjFHTNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 15:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236317AbjFHTMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 15:12:52 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 359F830DA;
        Thu,  8 Jun 2023 12:12:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PJYKVgEr2nTHJ5g+tG86L6xlcoi0obsz0a/ROZFaRRQXMe0NCryL6s2rEl42vfJ1vVhmWvFDb+8zlfE8pVC9u3LFId50dzm67rnPl1T5mxWY5TSKfaRTOA25JmuG49vqiciOeCcNhaOnvVKRvwI9srdp5Z4G4V135yZwFTEmb0cVmrPPSk6V4xoGSzJaNjuiw58+tzLSiXEMtLnmKGxBcHZ25lCMXJildltS5pAUZsJOnGzWdKX2yrL3kpjTqH5VvAMitgnm1aYLDvE/aw1rzwqGZQ39wmW3qh5Zg09Atew9dLJsg77lf3qcL07wNhKE2mxOPFK7+D+sRN48+rvHZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fmmTnMcgBjF4jGvS3U3PBKUF7f02iPt5jZlaYir3rNw=;
 b=ZpfT8CIKxBdqneMpMjtry1TeTRnm0I6PslThIXoe6SReavoGzR+sM6cCG4bg6nqilis8WCYa38WDn5LR739X4Dl80mBTbht1xupVmDoanNxjinGPrnUx6/4N0gyre1C+fJjxPTHxnn2XMJFZmp7TUvGEFnVDKJuHW19ctGCdYPeLj8QO1iQ91nw3MYQikF6W2QPcFprlP/JsFRwYFYy7GW+xu6aGdWVy8tBRfMvB4fZyKt9oPeXJskBvwuBV2MOgbxornSfXKrT2+1CSWC8tGNYeWrurDVA8wBGLtvfkYfGsTO3CqQ2daLs58FQxJcc0PQ+QEhb4N0UHnOdkyqnAaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fmmTnMcgBjF4jGvS3U3PBKUF7f02iPt5jZlaYir3rNw=;
 b=xKa0q01B1B0gSPj58ZPiehB/D0buKcl1sEEEIf/s9l19u4UATH7CniaZSaKpZc28/SnMgCA1WaM5hCOrVWMMaCJvQjAHs7yEEBDRbxSinEabFAvbLg4y3vkTgI5sxjgfPv7YrZ+8r4vDJL8tLYkpQqtOqgU+/Usud4R/xYx4MUg=
Received: from MW4PR04CA0257.namprd04.prod.outlook.com (2603:10b6:303:88::22)
 by IA0PR12MB7650.namprd12.prod.outlook.com (2603:10b6:208:436::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Thu, 8 Jun
 2023 19:12:31 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:303:88:cafe::6b) by MW4PR04CA0257.outlook.office365.com
 (2603:10b6:303:88::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Thu, 8 Jun 2023 19:12:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.0 via Frontend Transport; Thu, 8 Jun 2023 19:12:30 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 8 Jun
 2023 14:12:25 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        John Allen <john.allen@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
CC:     "David S . Miller" <davem@davemloft.net>,
        <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v4 02/11] crypto: ccp: Add support for displaying PSP firmware versions
Date:   Thu, 8 Jun 2023 06:17:48 -0500
Message-ID: <20230608111757.32054-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230608111757.32054-1-mario.limonciello@amd.com>
References: <20230608111757.32054-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|IA0PR12MB7650:EE_
X-MS-Office365-Filtering-Correlation-Id: 35a184fc-21a8-4429-c400-08db68544e96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dqANo5KYkDpt69jMrHH1W61DqYmmErxGUvbL4zlGpsMKU8j4OTj675QzBj2fNBHVn20BB8I0pMc3GR8y/sukiqS7SCg+yZF1/9KpgW8zlsUaxAGLp2nrynGak4upB2/leI1vN684KEMu2Z0SUKxmE5OYkC0pcCQEHNNARkb+WA4WQ6Pe2OMHz9cSNmtnELOevzuKQENV0ubqUnBWwPqtOSlw76NsalBIVgnvBZHOwjV0O/7HujMAPmIW6J42DBBP7ArfrFvuxnrrVM5bzVhoGl9mSRmqW68DWC2AD2FKbptLApXQqsP18l0xPU6ykW+Q5abCdSAg+roKEGyANA7h4Zaib47fb6N1jryo7akcmpp+nz4LbVZrI7BcQGoLHLXwvUKkx3mOrs79VZe3eZaqwJ761kfx4bwXSMpM3kjdImyU038e18xrNlxY+FXogAwG4yvH/jbCnrVjCELvdXB36hbfl8gz0kmRATqOQdVptf2l4ZK7ibWeLQuh41OHHfTJBiZk3A4fQlYnOBTMAGGG1vKS955Lot1aLgb732Y7Z3KL4q6R9yOcGwO7fwcFhhe4DKezy4RsmLHlQLzBgnPqb6VYZWUAXw2CliE4Xaf3zqIl+OsGyepkuZxeSWXGY65vHj77yAXhyGGtdE19a619KmFQyU/fPRRoPsKlRRy9SR4LjJqj/lNT0PiQhzbeBVY9RtgB+3k/5J0f8ATdshqBAdyzfc5OwkINr9aYOT2kqljW1UCdw63OZ6irCNUWluYRokDW13bpfiu59cT13sjmxw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(136003)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(356005)(1076003)(2616005)(41300700001)(36860700001)(336012)(7696005)(426003)(6666004)(186003)(26005)(16526019)(83380400001)(47076005)(478600001)(40480700001)(40460700003)(54906003)(110136005)(81166007)(82310400005)(70586007)(70206006)(316002)(82740400003)(2906002)(8936002)(5660300002)(4326008)(8676002)(44832011)(86362001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 19:12:30.6695
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35a184fc-21a8-4429-c400-08db68544e96
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7650
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As it's not always obvious what PSP bootloader or TEE version are
present in OEM systems, add the ability to get this information from
sysfs for supported platforms.

Acked-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2->v3:
 * Pick up tag
v1->v2:
 * Move GENMASK declarations to top of the file
 * Add comment to support why checking for 0xffffffff
---
 Documentation/ABI/testing/sysfs-driver-ccp | 18 ++++++
 drivers/crypto/ccp/sp-dev.h                |  2 +
 drivers/crypto/ccp/sp-pci.c                | 64 ++++++++++++++++++++++
 3 files changed, 84 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-driver-ccp b/Documentation/ABI/testing/sysfs-driver-ccp
index 7aded9b75553..ee6b787eee7a 100644
--- a/Documentation/ABI/testing/sysfs-driver-ccp
+++ b/Documentation/ABI/testing/sysfs-driver-ccp
@@ -85,3 +85,21 @@ Description:
 		Possible values:
 		0: Not enforced
 		1: Enforced
+
+What:		/sys/bus/pci/devices/<BDF>/bootloader_version
+Date:		June 2023
+KernelVersion:	6.4
+Contact:	mario.limonciello@amd.com
+Description:
+		The /sys/bus/pci/devices/<BDF>/bootloader_version
+		file reports the firmware version of the AMD AGESA
+		bootloader.
+
+What:		/sys/bus/pci/devices/<BDF>/tee_version
+Date:		June 2023
+KernelVersion:	6.4
+Contact:	mario.limonciello@amd.com
+Description:
+		The /sys/bus/pci/devices/<BDF>/tee_version
+		file reports the firmware version of the AMD Trusted
+		Execution Environment (TEE).
diff --git a/drivers/crypto/ccp/sp-dev.h b/drivers/crypto/ccp/sp-dev.h
index 1253a0217985..76c32ee6bd65 100644
--- a/drivers/crypto/ccp/sp-dev.h
+++ b/drivers/crypto/ccp/sp-dev.h
@@ -51,6 +51,7 @@ struct tee_vdata {
 	const unsigned int cmdbuff_addr_hi_reg;
 	const unsigned int ring_wptr_reg;
 	const unsigned int ring_rptr_reg;
+	const unsigned int info_reg;
 };
 
 struct platform_access_vdata {
@@ -69,6 +70,7 @@ struct psp_vdata {
 	const unsigned int feature_reg;
 	const unsigned int inten_reg;
 	const unsigned int intsts_reg;
+	const unsigned int bootloader_info_reg;
 };
 
 /* Structure to hold SP device data */
diff --git a/drivers/crypto/ccp/sp-pci.c b/drivers/crypto/ccp/sp-pci.c
index c8f075a7f49f..6c93577950c7 100644
--- a/drivers/crypto/ccp/sp-pci.c
+++ b/drivers/crypto/ccp/sp-pci.c
@@ -8,6 +8,7 @@
  * Author: Gary R Hook <gary.hook@amd.com>
  */
 
+#include <linux/bitfield.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/device.h>
@@ -24,6 +25,12 @@
 #include "ccp-dev.h"
 #include "psp-dev.h"
 
+/* used for version string AA.BB.CC.DD */
+#define AA				GENMASK(31, 24)
+#define BB				GENMASK(23, 16)
+#define CC				GENMASK(15, 8)
+#define DD				GENMASK(7, 0)
+
 #define MSIX_VECTORS			2
 
 struct sp_pci {
@@ -88,8 +95,65 @@ static struct attribute_group psp_security_attr_group = {
 	.is_visible = psp_security_is_visible,
 };
 
+#define version_attribute_show(name, _offset)					\
+static ssize_t name##_show(struct device *d, struct device_attribute *attr,	\
+			   char *buf)						\
+{										\
+	struct sp_device *sp = dev_get_drvdata(d);				\
+	struct psp_device *psp = sp->psp_data;					\
+	unsigned int val = ioread32(psp->io_regs + _offset);			\
+	return sysfs_emit(buf, "%02lx.%02lx.%02lx.%02lx\n",			\
+			  FIELD_GET(AA, val),			\
+			  FIELD_GET(BB, val),			\
+			  FIELD_GET(CC, val),			\
+			  FIELD_GET(DD, val));			\
+}
+
+version_attribute_show(bootloader_version, psp->vdata->bootloader_info_reg)
+static DEVICE_ATTR_RO(bootloader_version);
+version_attribute_show(tee_version, psp->vdata->tee->info_reg)
+static DEVICE_ATTR_RO(tee_version);
+
+static struct attribute *psp_firmware_attrs[] = {
+	&dev_attr_bootloader_version.attr,
+	&dev_attr_tee_version.attr,
+	NULL,
+};
+
+static umode_t psp_firmware_is_visible(struct kobject *kobj, struct attribute *attr, int idx)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct sp_device *sp = dev_get_drvdata(dev);
+	struct psp_device *psp = sp->psp_data;
+	unsigned int val = 0xffffffff;
+
+	if (!psp)
+		return 0;
+
+	if (attr == &dev_attr_bootloader_version.attr &&
+	    psp->vdata->bootloader_info_reg)
+		val = ioread32(psp->io_regs + psp->vdata->bootloader_info_reg);
+
+	if (attr == &dev_attr_tee_version.attr &&
+	    psp->capability & PSP_CAPABILITY_TEE &&
+	    psp->vdata->tee->info_reg)
+		val = ioread32(psp->io_regs + psp->vdata->tee->info_reg);
+
+	/* If platform disallows accessing this register it will be all f's */
+	if (val != 0xffffffff)
+		return 0444;
+
+	return 0;
+}
+
+static struct attribute_group psp_firmware_attr_group = {
+	.attrs = psp_firmware_attrs,
+	.is_visible = psp_firmware_is_visible,
+};
+
 static const struct attribute_group *psp_groups[] = {
 	&psp_security_attr_group,
+	&psp_firmware_attr_group,
 	NULL,
 };
 
-- 
2.34.1


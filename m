Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19AFF6E998D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 18:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233207AbjDTQcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 12:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232605AbjDTQcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 12:32:07 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B55210DA;
        Thu, 20 Apr 2023 09:32:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EaMybteynNZ8Fq9I4rvl22LguMwuBTzvBQAJusI9IXyIP/zH8aEJ8/O7lDIAgx9hlBQ659A6zxvdywVtT2kvlYMuz9rQAM5wb5JaLCXqa3pYqIPEV2U2dFo2miYK0IwD1iK/OUyVw0jwwihGK/JbNfYD6uMbRIkKSiB36hLm8pziIaSYBYcd83uyM/zo2RqkNEuLNmCaTYGHbKJv+bULeseJLh94r/TqSga/TKk4L8zkZycRROJ9VtIHW/Fvlo5d9YZNGhn9iDf8hCrN0fe8V+W5UAZwAkJE7+Ln9uFK5qfl9euNd6tCZv00J5DOZLXz904V6QrEkutVgrLDpkTSiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=De/v1LOvw5LzDRNbq4X/mZpXgCayIOs5BnbBcv4n6uA=;
 b=RYhXYQ3+xjizORPkpMj1W6+meSTG0EwkCdkXk414f7jkT7VmbjmHOsE82ga0sc5B6JysL2bQFLIYJwcb0vQ1Hf26V4QsQYgHAVMigAdnBR1J6a3+6xpoCQV6cYN+PfpZkumOwHgeOxcYsLjy0ftGV8n+Ier9pajuswsHyVlKLsb/WYtwICuqhFx20959T3gF1m4sueOS+KxpEjSbx2qhkfPdtkLQfje93V/UaPdp/dXiJnDSnDnBjIH7efQ3k5SWKdHdv66k/JO7tc+aVKYxhhqRYBJ/1/FIlkmYbQ8t6gJQbiv4VpvHm5Ng8uZZJPFARlHhezZHKePyVIDkGTeFhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=De/v1LOvw5LzDRNbq4X/mZpXgCayIOs5BnbBcv4n6uA=;
 b=R7yu90jmnoBBAOXFES+rDaS2E3eG4Ht6wAcIGmpdEt9tob3P84woFMGupVcCPzpG5V+WHcbkVG9VkWJUte2hNfHFodqdbVwt1KsWtvB1MUC8GT5o0s3gkhENttG1BfiSfdW1FhSb/fAFAGnxf+xnWJOqq1G/fNLDKbkWwjK6uho=
Received: from DM6PR07CA0121.namprd07.prod.outlook.com (2603:10b6:5:330::33)
 by DM4PR12MB6206.namprd12.prod.outlook.com (2603:10b6:8:a7::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6319.22; Thu, 20 Apr 2023 16:32:04 +0000
Received: from DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:330:cafe::e) by DM6PR07CA0121.outlook.office365.com
 (2603:10b6:5:330::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.25 via Frontend
 Transport; Thu, 20 Apr 2023 16:32:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT027.mail.protection.outlook.com (10.13.172.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6319.25 via Frontend Transport; Thu, 20 Apr 2023 16:32:03 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 20 Apr
 2023 11:31:59 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        John Allen <john.allen@amd.com>
CC:     "David S . Miller" <davem@davemloft.net>,
        Mario Limonciello <mario.limonciello@amd.com>,
        <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>
Subject: [PATCH 02/10] crypto: ccp: Add support for displaying PSP firmware versions
Date:   Thu, 20 Apr 2023 11:31:30 -0500
Message-ID: <20230420163140.14940-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230420163140.14940-1-mario.limonciello@amd.com>
References: <20230420163140.14940-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT027:EE_|DM4PR12MB6206:EE_
X-MS-Office365-Filtering-Correlation-Id: 63db6666-7bc1-48ea-7a6c-08db41bcc653
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WWfZTLwYLV+r73ckYhWujG20v4diKqcFWlGmJ3Zl56A6bPZ9VigRCgxZrywOAxYwqBuuHipDk8iI3Nuzu69RbXmOhjm/RQEVqiiAyIweSUSEPF4izoyL9dm2LZdEmqLtnQIFKjqjpNHsfniRcOGeI/vzBhVgfiBaNT/jCai2BvmUBe1/esLH1QMoLmB+pnackxJGJiMlbcqn34j3Cc7uO0zRQKM/+GggRIkCjPMCPJWhgLUZ2K1YQRqLTwXpaUKmqXHp+AF0TYI1CGIl+8MbwtAgG+lrUazKmJtb1ygVJKFCm7GSYtUoiINgoNIqx65F8PP2vfNixL04EMr1HjxapoVP25huKES/yNmeWBBYAI6lKHjCqFiG7Mrkf1u4kJ8Jbi+D5vUxejGH3ZgJAdqtqbeRfqYapcfn4Z5oXf0DWdFnxTVKs/quTcCPedyQ1Hon2WMkl2vlLKotdNwq1BCh1USS53glH5TtUSZP9fo7HfcxYexpwRRpD7g43iH8g8aokTMb5V+7C8s1IrCeOvVglzbn+Oj7d5cgGtbsMoYGki6cptwwOkxsGg8S4gUl4RSSz5fgHWqKFS4cpuw5O8jUAAPnt7bQmPwEN6d5ABhiU/9m7Pt6MNvAA4VquqS7IG+jx+8rWg9SVC9Eo1YDJe9qdrQjxv8sKhF9cNmihAUEUcAb4dVf8jcudjO9EDRrcuzq/ZwyzRAm5zYGX4f/dn72FxpKGCqBjYO6lHqcNpq+ceA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(346002)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(4326008)(316002)(110136005)(54906003)(6636002)(70586007)(70206006)(40460700003)(186003)(16526019)(1076003)(26005)(47076005)(36860700001)(2616005)(336012)(426003)(83380400001)(40480700001)(5660300002)(41300700001)(8676002)(82310400005)(8936002)(478600001)(7696005)(6666004)(82740400003)(36756003)(86362001)(2906002)(81166007)(356005)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 16:32:03.9292
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63db6666-7bc1-48ea-7a6c-08db41bcc653
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6206
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
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

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 Documentation/ABI/testing/sysfs-driver-ccp | 18 +++++++
 drivers/crypto/ccp/sp-dev.h                |  2 +
 drivers/crypto/ccp/sp-pci.c                | 58 ++++++++++++++++++++++
 3 files changed, 78 insertions(+)

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
index 85e3dc8853e2..4d729aa1b260 100644
--- a/drivers/crypto/ccp/sp-pci.c
+++ b/drivers/crypto/ccp/sp-pci.c
@@ -8,6 +8,7 @@
  * Author: Gary R Hook <gary.hook@amd.com>
  */
 
+#include <linux/bitfield.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/device.h>
@@ -88,8 +89,65 @@ static struct attribute_group psp_security_attr_group = {
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
+			  FIELD_GET(GENMASK(31, 24), val),			\
+			  FIELD_GET(GENMASK(23, 16), val),			\
+			  FIELD_GET(GENMASK(15, 8), val),			\
+			  FIELD_GET(GENMASK(7, 0), val));			\
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
+
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


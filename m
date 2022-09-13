Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93E9A5B73AB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 17:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235453AbiIMPKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 11:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235554AbiIMPIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 11:08:43 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF55875FD4;
        Tue, 13 Sep 2022 07:30:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h3/mCmDLYKKuKiL3e0l8O28hsIQbyRcyxVQbHwnGvQgXvXSVSuAaGXnexHGk4JwPDknnpcWGHkmTw/iyGwOYXQDhss+iKfgQ/6vNRidgjRnFJC2SFDpGM/LG2GiQ0tFnZg/oMfBNSvY17iZTE/QnnEA2LVjraD1A05frPHwkYt04VQyWfMAYLrY+GCe0W0+jbVpe3AzGF0heUinmKOvAV3QjRNbAwXOK3xtZSvfneQHH1gvwC3pvb2swc1/9vhMFcCwjn0ta42fzivjSf3hq2DrxrBfZ+UKPf2q7Plcya8wa1ZM24Tqbmar7MWdt+IJV10amtt3Qcx5AlBs0aC3T7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=di9P3GynYsWrv/5VJ/6Q2QIIzvLb94oH09tAdYbUAcg=;
 b=DjJtx+7iAB/QVb5ZvVrvBGWUZTLrHGZW7diFGSHzqpfm5IJmcB1hKRs7Yn1qZiaYDXDnmtsa3ZCy+PSmS7tG3c0qVGK7RlKbTvug7PaL+hzsDCeN7wQSlDFfcdFsR+XZSrItkGk4q82AuD2u2sPpwURnR/jagz+TobJdIp6VDwuj8ljxGprlU8bAkHHu97NPnH30twDleXPJtcbwRt6mfZ8nn4yehPgmahXISV+dLtE4Ll9zLeXIkO+TbK94bt8NyoqatDnD70XAhkqJ9OzGD8S9FSkbDVV07ZVTfmpLt/+rgO3grnavoaR0CuNYSD2wrQ0PGyIalk0Wl6VYK7modw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=di9P3GynYsWrv/5VJ/6Q2QIIzvLb94oH09tAdYbUAcg=;
 b=y7+s7G+v1IiDA3WGCTJAr9yrZA8cOtJ40FS661tw7Cxh1cC5LxIkk7sd8rlqDWYYjgaUVCQJJ94gNEiI6QZxaJbU4okD9hmRmLo3MtkNaAao7VPsUC4ffOzK2Imlzmcvs4i6LGrB6O+RDDSMve1xMd90OWfCeC/nAhaR+iWhLGQ=
Received: from DM6PR11CA0051.namprd11.prod.outlook.com (2603:10b6:5:14c::28)
 by DS0PR12MB6487.namprd12.prod.outlook.com (2603:10b6:8:c4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Tue, 13 Sep
 2022 14:26:48 +0000
Received: from DM6NAM11FT080.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:14c:cafe::6f) by DM6PR11CA0051.outlook.office365.com
 (2603:10b6:5:14c::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12 via Frontend
 Transport; Tue, 13 Sep 2022 14:26:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT080.mail.protection.outlook.com (10.13.173.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Tue, 13 Sep 2022 14:26:48 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 09:26:47 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <mario.limonciello@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
CC:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>
Subject: [PATCH] platform/x86/amd: pmc: Add sysfs files for SMU
Date:   Tue, 13 Sep 2022 09:25:10 -0500
Message-ID: <20220913142510.1612-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT080:EE_|DS0PR12MB6487:EE_
X-MS-Office365-Filtering-Correlation-Id: 742f545e-4c20-48cb-a945-08da9593fe51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jHGfVdQzSAqpMh6Imr28MXnUPP4i3jbBh/Za1MSRW5AyX0NTxA3vapJnDJ1uOaJLrnIK7aTIfg2FM5BbrJZU6q8nNDCsXZTNmBxyBDJnlJESaw5JUeVA6ofVt2JMXK5aPNevlomljicqDa4N0WjrUERd9xhvkfJlAth5/SuVbe55U0t5jCyvfvk1KEw4jVQEUx/cbhxSlDEwz3Tx76J+qb26meKUtiVpc6pnSTr4JGhuFXTEOrsZu1U0EurCUTTAjXqmMc1tc7rECjz/coXCRcgoWYJZMheZq/Iy4uz6ytGA+w5bnLCqAkejLAKGzYVX8yd87NaFgQHAGfj4hrDICu0ufF+z2bNg6Fj7+iOqiQXEAGTI2A1NgJzcG4JRyghL70bSkyO6hr9WfZV2OzoXmt49Blx6RhRsIKBCdkuHk7rRPBuI1dNg2/p0zbjXqHbNl1pa1JXHt+Pvwjz9EUQa2TQsLxzNj/AAoNqmapfN3rrPei4XVoDQxQ+cGMz0H3YLXKnbsHyUl/THjgv5pP33ctMQCnkmZzAGwQ56Dx3kMIQO8CLoh8STmRWII1oADssvF1zmmc5HNXvNnEpuwqPyiZ+2lxN4i3W9bEy2m5+fe7dwmEBnZ2AyG+Fcq/te2BUwADoh4ONTHkWF70gdOg5JUlmOHdb6uECLZxjYc9jLG+il+FAANublPaOMdVtl4nwdjuPPdVOALItbFeqFNFYPSIVOsXs+rk8ay8O5elGJcdMSgEpIuI/lJZ41+IPrivre39rWoADMXiHY7G7lVXwPM3qrr2DH/YE4zl+gHjPnVMc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(346002)(376002)(136003)(451199015)(36840700001)(40470700004)(46966006)(44832011)(4326008)(36756003)(41300700001)(47076005)(40460700003)(356005)(2616005)(1076003)(186003)(2906002)(316002)(6636002)(70206006)(478600001)(70586007)(54906003)(8676002)(8936002)(426003)(336012)(16526019)(6666004)(40480700001)(86362001)(5660300002)(26005)(7696005)(110136005)(82740400003)(82310400005)(81166007)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2022 14:26:48.4748
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 742f545e-4c20-48cb-a945-08da9593fe51
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT080.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6487
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CPU/APU SMU FW version and program is currently discoverable by
turning on dynamic debugging or examining debugfs for the amdgpu
driver. To make this more discoverable, create a dedicated sysfs
file for it that userspace can parse without debugging enabled.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 Documentation/ABI/testing/sysfs-amd-pmc | 13 ++++++++
 drivers/platform/x86/amd/pmc.c          | 44 +++++++++++++++++++++++++
 2 files changed, 57 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-amd-pmc

diff --git a/Documentation/ABI/testing/sysfs-amd-pmc b/Documentation/ABI/testing/sysfs-amd-pmc
new file mode 100644
index 000000000000..ff627b48c875
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-amd-pmc
@@ -0,0 +1,13 @@
+What:		/sys/bus/platform/drivers/amd_pmc/*/smu_fw_version
+Date:		October 2022
+Contact:	Mario Limonciello <mario.limonciello@amd.com>
+Description:	Reading this file reports the version of the firmware loaded to
+		System Management Unit (SMU) contained in AMD CPUs and
+		APUs.
+
+What:		/sys/bus/platform/drivers/amd_pmc/*/smu_program
+Date:		October 2022
+Contact:	Mario Limonciello <mario.limonciello@amd.com>
+Description:	Reading this file reports the program corresponding to the SMU
+		firmware version.  The program field is used to disambiguate two
+		APU/CPU models that can share the same firmware binary.
\ No newline at end of file
diff --git a/drivers/platform/x86/amd/pmc.c b/drivers/platform/x86/amd/pmc.c
index 700eb19e8450..4302e7662087 100644
--- a/drivers/platform/x86/amd/pmc.c
+++ b/drivers/platform/x86/amd/pmc.c
@@ -455,6 +455,49 @@ static int amd_pmc_get_smu_version(struct amd_pmc_dev *dev)
 	return 0;
 }
 
+static ssize_t smu_fw_version_show(struct device *d, struct device_attribute *attr,
+				   char *buf)
+{
+	struct amd_pmc_dev *dev = dev_get_drvdata(d);
+
+	if (!dev->major) {
+		int rc = amd_pmc_get_smu_version(dev);
+
+		if (rc)
+			return rc;
+	}
+	return sysfs_emit(buf, "%u.%u.%u\n", dev->major, dev->minor, dev->rev);
+}
+static DEVICE_ATTR_RO(smu_fw_version);
+
+static ssize_t smu_program_show(struct device *d, struct device_attribute *attr,
+				   char *buf)
+{
+	struct amd_pmc_dev *dev = dev_get_drvdata(d);
+
+	if (!dev->major) {
+		int rc = amd_pmc_get_smu_version(dev);
+
+		if (rc)
+			return rc;
+	}
+	return sysfs_emit(buf, "%u\n", dev->smu_program);
+}
+static DEVICE_ATTR_RO(smu_program);
+
+static struct attribute *pmc_attrs[] = {
+	&dev_attr_smu_fw_version.attr,
+	&dev_attr_smu_program.attr,
+};
+static struct attribute_group pmc_attr_group = {
+	.attrs = pmc_attrs,
+};
+
+static const struct attribute_group *pmc_groups[] = {
+	&pmc_attr_group,
+	NULL,
+};
+
 static int amd_pmc_idlemask_show(struct seq_file *s, void *unused)
 {
 	struct amd_pmc_dev *dev = s->private;
@@ -935,6 +978,7 @@ static struct platform_driver amd_pmc_driver = {
 	.driver = {
 		.name = "amd_pmc",
 		.acpi_match_table = amd_pmc_acpi_ids,
+		.dev_groups = pmc_groups,
 	},
 	.probe = amd_pmc_probe,
 	.remove = amd_pmc_remove,
-- 
2.34.1


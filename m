Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 764865B8A33
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 16:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiINOTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 10:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiINOTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 10:19:40 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2045.outbound.protection.outlook.com [40.107.100.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 153F66419;
        Wed, 14 Sep 2022 07:19:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=odKBK+rAG1PGZj5xQH1EMTeCQh3rH3VE1sp1nwXGo9UL5jwWgZAvPrHPQGYWzRkrluz+y4eBYLVkKFibcaHZ2tdh52ZDxeqW+U/GeIGu+Hak5qpf1/oLiiiyKrwjHY5KVOb/jyl1Ol5NSFF9r0W5l/WF4flWGJmAZSgRSXlrFAcE0BGlL6o167oOXE3WAa2XMlXRSqgf5bJ8xryu9ausH7bIKocnjDA15MFvw8sNfy5xm1xZhiMBkEEhLEdFiFtb2kp5yJXMf9oKmBVq5fNdbPBWQ9WX+HJ2TyIkBiJdnJsQuDosjNP4yu8cEk5wH2qfPYVwPx8WOf+gq/EKK8P1Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PMsOO+CspOiS2Z/bhforObZvIYzvymDtcNB2TzRsyPE=;
 b=hYgvxdfsOrEv7ylODWMdi5Pcx792rnM9awhqml4bCZbnPokQx+Lf98DEzTOh0DvsgruNnAoapQKgJ93AUIglbP2I/MwIbzBj+kCGBHqGs0dKT5CX/6CjPFDVtCUfPNcyFsvYerdlqxnpVEEi/8v7Zf6lKnStOQ2CtXAeRymLWpl1ogSIW7YM5QTrZu0dws7WYT/wbvW8Cp+HfOeET6glNhwaPJhCjyuA0ua9hZ2t6cXKwefWj+XarFgKjT6V2oVNERl2wU40dL6fLzUObihYxlwnQVxZndCNQT0SOuGbncfxXFvMbgo+hZxxnVJJtjQkwBG7UDLbOJh+uDh50QJ5pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PMsOO+CspOiS2Z/bhforObZvIYzvymDtcNB2TzRsyPE=;
 b=qyqn6hByfpZpgWeU00PO4obheyKnd31r+9aGg6fZ+tFUD00xu/MGzrhWI3gT1fDjvS2nQ9FhSLl066gJZ/I6tNkODSzUv182yG8sjZknICC7kZoJhmWxdCreL9Ny6ETK9x5LGrW6+zVG0TJeerTcU7gUdseDoGhCM5tJ6d/KTbM=
Received: from BN1PR13CA0014.namprd13.prod.outlook.com (2603:10b6:408:e2::19)
 by CY5PR12MB6406.namprd12.prod.outlook.com (2603:10b6:930:3d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Wed, 14 Sep
 2022 14:19:35 +0000
Received: from BN8NAM11FT070.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e2:cafe::41) by BN1PR13CA0014.outlook.office365.com
 (2603:10b6:408:e2::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.5 via Frontend
 Transport; Wed, 14 Sep 2022 14:19:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT070.mail.protection.outlook.com (10.13.177.50) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 14:19:35 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 14 Sep
 2022 09:19:32 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <mario.limonciello@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
CC:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>
Subject: [PATCH v2] platform/x86/amd: pmc: Add sysfs files for SMU
Date:   Wed, 14 Sep 2022 09:18:50 -0500
Message-ID: <20220914141850.259-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT070:EE_|CY5PR12MB6406:EE_
X-MS-Office365-Filtering-Correlation-Id: 19baef57-ed81-4869-8185-08da965c267e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TBEywmzFD3leS0o87BCdyw5gMPtbjBqypBjZMHaTTcOvVX6d7WZSiES4OsSgF33fWS3I0VeFtYBYkUwbNhdurQMPMD87y0qFGXAoL5gb2yDHWBBgEJOaPHu7rUWBqR4tu3tsJSwh3cfNnuuPoLbKKlZHKBESPcuUsQRZP3DBjc+qebehns/qW5TxRB8WryJyxr62wND2CCxOKQiyE64OA5tFeIbHAkIxmNGQBDayX8DzOxNcRLbj+V+UtPV/8o8bdiEY8JJ09DMtNFhIQ4dP04uHjJE1c3BmQ7ryLfRdxV7l/i5IHSrnlV/nrvsOyRnzlE4cwsr4PsGux47WdaNwebaXatnX91HrvxyElI7SvSsHVsa4R5B6MN2rdF/8lmJXtAHBn2GcGr/LpCVfGy3m8ka2b6dTpxdKdKJJVla3I1gbKnM85zIwwRTC/RbQoioKyAXJqKi9AOCy/+2S0TMsQY4TZcd1x8WaZcMXW5mnEF3JBS9i9J+eQLE9ToqTNfU6NOSl3HCcGYe0V2yr/5el84Hy0+DR6Z8opZIletGrrlThbffKdGqJZ5psw3gbWZIYZeltpNinPhmI+VbgIWlqburlYSF9tRx+9J+CqX871aP9uP/t/MQH/m9J9E8o6+5qgOpcRLOUNqWqBnPfYiNdUw8AZaxBa/Xu5vmlP4rJ8eh2MMXwsOVQU79JyPAg+yv1WpsX+IgVp+GsUzQRQbEmfTZG1ZNSR/dFUPUsH2dyQzawzOAlIxTEu0TFgS9UQR49/4q38hLfW8rEds3HVLX4OIzPf0xkLVTa9JtkIHWR0XU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(346002)(396003)(376002)(451199015)(36840700001)(46966006)(40470700004)(47076005)(54906003)(8676002)(81166007)(40480700001)(186003)(110136005)(26005)(356005)(6666004)(8936002)(41300700001)(478600001)(16526019)(6636002)(82310400005)(2616005)(336012)(7696005)(5660300002)(82740400003)(1076003)(36860700001)(44832011)(2906002)(36756003)(86362001)(4326008)(70206006)(40460700003)(316002)(426003)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 14:19:35.2704
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19baef57-ed81-4869-8185-08da965c267e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT070.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6406
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
v1->v2:
 * Feedback from Barnabás Pőcze
   - Fix documentation EOF missing newline
   - Use ATTRIBUTE_GROUPS macro
   - Add missing NULL at end of attr

 Documentation/ABI/testing/sysfs-amd-pmc | 14 +++++++++
 drivers/platform/x86/amd/pmc.c          | 39 +++++++++++++++++++++++++
 2 files changed, 53 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-amd-pmc

diff --git a/Documentation/ABI/testing/sysfs-amd-pmc b/Documentation/ABI/testing/sysfs-amd-pmc
new file mode 100644
index 000000000000..5d71c2298f5b
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-amd-pmc
@@ -0,0 +1,14 @@
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
+
diff --git a/drivers/platform/x86/amd/pmc.c b/drivers/platform/x86/amd/pmc.c
index 700eb19e8450..6373c1bce649 100644
--- a/drivers/platform/x86/amd/pmc.c
+++ b/drivers/platform/x86/amd/pmc.c
@@ -455,6 +455,44 @@ static int amd_pmc_get_smu_version(struct amd_pmc_dev *dev)
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
+
+static DEVICE_ATTR_RO(smu_fw_version);
+static DEVICE_ATTR_RO(smu_program);
+
+static struct attribute *pmc_attrs[] = {
+	&dev_attr_smu_fw_version.attr,
+	&dev_attr_smu_program.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(pmc);
+
 static int amd_pmc_idlemask_show(struct seq_file *s, void *unused)
 {
 	struct amd_pmc_dev *dev = s->private;
@@ -935,6 +973,7 @@ static struct platform_driver amd_pmc_driver = {
 	.driver = {
 		.name = "amd_pmc",
 		.acpi_match_table = amd_pmc_acpi_ids,
+		.dev_groups = pmc_groups,
 	},
 	.probe = amd_pmc_probe,
 	.remove = amd_pmc_remove,
-- 
2.34.1


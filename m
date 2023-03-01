Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 135B56A7561
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 21:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjCAUdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 15:33:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjCAUda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 15:33:30 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7614AE04A
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 12:33:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XUB/2ONoGnZGo7XpDrj6C2PPzfz6XfJ3vNdzymon2T7HBy9tzuh7gEqf0lop7hAE4fpdOZL30nghAMFucIa0dFsGJ/2AUkK9cjf35r/q16lz87xms85s2Zp9Q/ErwFJNuqN1CmsUh8ng0VKI89UxNFSfkKQCSzFQevTHO2LPF/d7P2UusDgxgYz1uuQ0lVRLP9vNqJfzo1CXuoTiwgBHhQ2iUec2XQzn22q+D9g7EQvlDMGYQq8k9KIbT/Jc6gXnTwNzFlvxys/hpuZoxxDKQnq3lBaaA6R2QxBWLyL/enRcvV34+gzmFq9/xN7XV2qJz1fJZ48IOESsq4+7Q2iz8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cCfva3MZF3+TDCGiaCDAXYi239+FjG5FfTY5/Hw5c5c=;
 b=HIGP1Mi++kT10pvjctNDorzN4iTz5LDJmvCHjOSzQiqGWFTsjQF8aa23KFs/k59EG/HDye94OtsURs8u38A0pftnReMiiIstDl6BGa/4uP5T/yq2hopiTaPGw7lcGx01fRWWmCCL8gsBXGcy+tuTzJKAsa9dvzJhDbsv82ZnZkPqWIAMqqDuAk6BtBaYRivL3cRLpnArG7A6fWh013Duy4AGbiyh8/CtkiANu5WyxAugqwblvRG9pd+gPDh3upJXwzLyVLat9riWIKw0Aer/OIA5nbjifwlNzcnEU5z1HTZG2QvibbOEUThesf6tJf0DFM5WnMTtmsJUvbwP/ANiyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cCfva3MZF3+TDCGiaCDAXYi239+FjG5FfTY5/Hw5c5c=;
 b=km/vG0Yobst76TTtXqZcNINH/CJckSUNfv92dO8pUmJati590IFIYjcUXMxKPOED+Xz67l+UmGABlMt9XKKsp5tMG7MhSaM5nw/eKdQ80mIJhz5AgEI184pLzInivsjk1OaOmpjCJAkvIQqMM7Q7l+Z7NGThdN3bu089k6Zdd+Q=
Received: from MW2PR16CA0026.namprd16.prod.outlook.com (2603:10b6:907::39) by
 CY5PR12MB6526.namprd12.prod.outlook.com (2603:10b6:930:31::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.29; Wed, 1 Mar 2023 20:33:26 +0000
Received: from CO1NAM11FT108.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::5) by MW2PR16CA0026.outlook.office365.com
 (2603:10b6:907::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18 via Frontend
 Transport; Wed, 1 Mar 2023 20:33:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT108.mail.protection.outlook.com (10.13.175.226) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.18 via Frontend Transport; Wed, 1 Mar 2023 20:33:26 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 1 Mar
 2023 14:33:24 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        "Christoph Hellwig" <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
CC:     Mario Limonciello <mario.limonciello@amd.com>,
        <elvis.angelaccio@kde.org>, <linux-nvme@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] nvme: Add a module parameter for users to force simple suspend
Date:   Wed, 1 Mar 2023 14:33:01 -0600
Message-ID: <20230301203302.28889-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT108:EE_|CY5PR12MB6526:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c818466-2501-480a-7dea-08db1a9435cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pm/dK7w0u8kIDpRpOe/O/W+k9SpqeneRkuvIn5aKfw3suXzm82ZLqjCu/RJQMCJDjHUntdnOnpS1lOaHbT4CDZGr8YCdR60QirQ5NJVoGZZoDjP3a5oZqNN2Sw+oYiGIk82Ra/zaCec0K10JGFEPt4wj29iGTOFs9Ko+KHGlHpnQIytBMNSKArkEGScjI8i1Egv03E2bGUeDUQ1EYaCOPZvDzqIIxXxXlukQDrsXc9yQMntpIehjnnxzVLFvUFk/Y6FVRwsKg3TgPX3zIhYoD7+8R0pF4NxuvKjrUmPynAU+XNf7ze91+OOBD9EKdoZAdS7qf8h3oStUIOLMLEwPoU9cQd8/ZSWgj6l9q2WxWtQwMZTMSG2ch99Ht6TlKmjVnXAubdy3jPwMTWphuH6ijtLyhcXwBUya+WcG+IcxN3LoWMFSreVqF6m26CGSzWOgAFccHGwsaSTUUZaimZZZvAZfqpCNt3Pa/pCCdzevmeywm+AZzH4LCGAoHd4gvbwKMqRXRoFQlCxe+I5MkSayaYBbYHg7RiaOCVRcBn/SXYG6FfbT6Bdw1r8SookfjiJVCc+0oTsbjQt4wbptPT1TD3v93QjaQHqLlrv3CJpVty0gLISFwPsyrlUJircVAEjOSwL8cftWv7p2mgbNgLmPT/SjoraIPWcE8/+wQU3ZAJAE39l0c7SwS+HjG3Gs6sHV0E3tUbiXeTT+XpvHnsc7p20Dy7DsSewkES9khsggMJALGgdupSUYpu4ZnFL/Szf7TDylm92jAXSOP2cacQ6eew==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(376002)(396003)(39860400002)(451199018)(46966006)(40470700004)(36840700001)(110136005)(81166007)(54906003)(8936002)(82740400003)(36756003)(316002)(16526019)(8676002)(40460700003)(478600001)(82310400005)(186003)(26005)(7696005)(44832011)(86362001)(356005)(40480700001)(966005)(6666004)(1076003)(15650500001)(2616005)(5660300002)(2906002)(336012)(4326008)(70206006)(83380400001)(70586007)(47076005)(66899018)(426003)(41300700001)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 20:33:26.1505
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c818466-2501-480a-7dea-08db1a9435cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT108.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6526
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URI_TRY_3LD autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Elvis Angelaccio reports that his HP laptop that has two SSDs takes
a long time to resume from suspend to idle and has low hardware sleep
residency.  In analyzing the logs and acpidump from the BIOS it's clear
that BIOS does set the StorageD3Enable _DSD property but it's only
set on one of the SSDs.

Double checking the behavior in Windows there is no problem with
resume time or hardware sleep residency. It appears that Windows offers
a configuration setting for OEMs to utilize in their factory images
and end users to set to force allowing D3 to be used for sleep.

The preference would be that OEMs fix this in the BIOS by adding the
StorageD3Enable _DSD to both disks, but as this works on Windows by
such a policy we should offer something similar that users can utilize
in Linux too.

Remove the module parameter noacpi which could only be used to ignore
StorageD3Enable and instead add a new module parameter for the NVME
module that will let users force simple suspend to be enabled or
disabled universally.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=216773#c19
Link: https://learn.microsoft.com/en-us/windows/configuration/wcd/wcd-storaged3inmodernstandby
Reported-by: elvis.angelaccio@kde.org
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v1->v2:
 * Rebase on nvme/nvme-6.3
 * Replace noacpi parameter
 * Clear the quirk if set by driver and user set simple_suspend=0
---
 drivers/nvme/host/pci.c | 41 ++++++++++++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 13 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index d68e2db00d0d..93dcd9dc8df9 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -102,9 +102,9 @@ static unsigned int poll_queues;
 module_param_cb(poll_queues, &io_queue_count_ops, &poll_queues, 0644);
 MODULE_PARM_DESC(poll_queues, "Number of queues to use for polled IO.");
 
-static bool noacpi;
-module_param(noacpi, bool, 0444);
-MODULE_PARM_DESC(noacpi, "disable acpi bios quirks");
+static int simple_suspend = -1;
+module_param(simple_suspend, int, 0444);
+MODULE_PARM_DESC(simple_suspend, "use simple suspend for disks (0 = never, 1 = always, -1 = auto";)
 
 struct nvme_dev;
 struct nvme_queue;
@@ -2898,7 +2898,30 @@ static unsigned long check_vendor_combination_bug(struct pci_dev *pdev)
 		 */
 		if ((dmi_match(DMI_BOARD_VENDOR, "LENOVO")) &&
 		     dmi_match(DMI_BOARD_NAME, "LNVNB161216"))
-			return NVME_QUIRK_SIMPLE_SUSPEND;
+			return simple_suspend ? NVME_QUIRK_SIMPLE_SUSPEND : 0;
+	}
+
+	return 0;
+}
+
+/*
+ * Some systems include a BIOS _DSD property to ask for D3
+ * or users may explicitly request it enabled.
+ */
+static unsigned long check_simple_suspend(struct pci_dev *pdev)
+{
+	switch (simple_suspend) {
+	case 0:
+		return 0;
+	case 1:
+		return NVME_QUIRK_SIMPLE_SUSPEND;
+	default:
+		break;
+	}
+	if (acpi_storage_d3(&pdev->dev)) {
+		dev_info(&pdev->dev,
+			 "platform quirk: setting simple suspend\n");
+		return NVME_QUIRK_SIMPLE_SUSPEND;
 	}
 
 	return 0;
@@ -2932,15 +2955,7 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct pci_dev *pdev,
 	dev->dev = get_device(&pdev->dev);
 
 	quirks |= check_vendor_combination_bug(pdev);
-	if (!noacpi && acpi_storage_d3(&pdev->dev)) {
-		/*
-		 * Some systems use a bios work around to ask for D3 on
-		 * platforms that support kernel managed suspend.
-		 */
-		dev_info(&pdev->dev,
-			 "platform quirk: setting simple suspend\n");
-		quirks |= NVME_QUIRK_SIMPLE_SUSPEND;
-	}
+	quirks |= check_simple_suspend(pdev);
 	ret = nvme_init_ctrl(&dev->ctrl, &pdev->dev, &nvme_pci_ctrl_ops,
 			     quirks);
 	if (ret)
-- 
2.34.1


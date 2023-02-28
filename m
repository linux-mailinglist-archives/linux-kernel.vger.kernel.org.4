Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B517D6A6231
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 23:12:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjB1WMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 17:12:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjB1WMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 17:12:23 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2076.outbound.protection.outlook.com [40.107.100.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6733434F6F
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 14:12:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RedR2tccBSmQNT6PkoDuacfGHOVHZcnw/UbKqdfRy/MKITU7G0lljLydERg3AVz3LELnGBAPS2/rF4C9DOVHRI0NY4xGWNMAw6UGg5QY2vfcT1u7TI/nf4ir6BeWNRx3rbXazAL2KptWo4aJGqZEFcW/KsV370VIQ4noyIouOREFGqfBuxu9jVnzizZaZyXW7bpbVi1ClQv+VVKzWGjfPRP5JRS8eGJ9kDyxLEzaHzRCLPVpxR3E6sblUapCC8RK/3qKv/ufNFpoH5fPmAaqO82eu+towj117VNK3qcywrtxMcazq5VtPeRmTgIRSeAEQkWxlhtbP1XYgYOpmg+sgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RChCYz5Z3/1LKYDPjMV+ocb63QniqzB+9whNAQI1dY8=;
 b=SlCWuXVlfDZptDyPIiBFJCl0na/MbS0hnSkmfME5PnS141piZ9+lSy+i9J0OhurvYlGd3Nqq4GheQUa/jk5tQoWdkLrKvh2Zyof+NfRmWc/S36PNW132mj1vZIQCKKa+xLRBybaJi/Awne7XzQvvG3PBDcjBTeV1xo+YWOPcfZh1znzEQ3n8E9wjmJXBS7l/bvQoGlGtXuTWA5vV6MKCGPPd8+eCmQEHyAKHH9IjwrF4bZaGVJJSZdRWQf8jai1Z3GA4HCwhjJ7+2hqH+sGOdSOL0tCGthS01I0W8Rt8qQkvEqFbfVer8a8hvs726XOLseit+uMyf3X7zSHVUvs86A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RChCYz5Z3/1LKYDPjMV+ocb63QniqzB+9whNAQI1dY8=;
 b=CYhV/d2Q7EM5KDeg8gxVXf9VBeWUd+HT06aLzVlIohPbw2Eq4Tx4yKIz0TK//3BlPEPtxoT9ua8p8UQocDtgmxt0jRLMQcMHpNNpo2W9J4z0MZSqm7JWXjw89jOwJd6JAuGkJsGTwMGLl3v+4FPjBrAHGMxLNrdByQmZRha/XkI=
Received: from BN8PR15CA0002.namprd15.prod.outlook.com (2603:10b6:408:c0::15)
 by DM6PR12MB4298.namprd12.prod.outlook.com (2603:10b6:5:21e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Tue, 28 Feb
 2023 22:12:11 +0000
Received: from BN8NAM11FT105.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:c0:cafe::67) by BN8PR15CA0002.outlook.office365.com
 (2603:10b6:408:c0::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30 via Frontend
 Transport; Tue, 28 Feb 2023 22:12:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT105.mail.protection.outlook.com (10.13.176.183) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.17 via Frontend Transport; Tue, 28 Feb 2023 22:12:10 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 28 Feb
 2023 16:12:10 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        "Christoph Hellwig" <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
CC:     Mario Limonciello <mario.limonciello@amd.com>,
        <elvis.angelaccio@kde.org>, <linux-nvme@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] nvme: Add a module parameter for users to force simple suspend
Date:   Tue, 28 Feb 2023 16:11:48 -0600
Message-ID: <20230228221148.2672-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT105:EE_|DM6PR12MB4298:EE_
X-MS-Office365-Filtering-Correlation-Id: 96e44d70-f4c0-4ffb-bb9e-08db19d8d6be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q+Vc6sVqbeWgTM50nXAP/v1FhPjWGxQXyQGwcz/gE8++lHwC8DvBM16a+c2NAqUYeAwjQbMXDQpZFquQWvC96fohL1M6uyXIwxvY9zKtpF5w51zfodPlw2FEstfgkA+VOteGQqmy73Ca+88DQGdahpAchjmjSjjJHkRtvUayOg13hpKnI4d+PpMnbhsaikOqY5UMyYBi1q+hA/c2MVaGb9AvxurAUHKv+CHlMWaGMNjq7z9e/qoEIjmdlZ81zDXu3UyWVUc8k76ZJeY6VF1VemgtKVADScYhQwaqLbE1QVO/owwOd49fK8oJprsA5OXcPE5souPTXJzaxylrmbNxb8I9sDefyH+94O7z7E3ctHwpq0I7y7e7vJyub4Gn3z5BcpEQqU5M06paBHIKYs0t9xU41riWqz8TCrsBJVsat/gJ14Uqw+qwTHMcjsReozhtJ3wBfoqJtz9ut0tQ43Wu7HNveDd9GbypJiBb4ByUbwRgQezMR/yDsEm0POP6ejJ8SdBNEVHmd2sz2B+1zBZo/YtI1TLyfRv7G3ybvgJE0rLaD0ti2Y4iKzfe25Pb1rJbD62mQjwEtLrfCBW2ovsOL9KURDUq2xax8gtc67Hha9TUXeZwXaJxTYhez5KcVfZk2mQWAvEfrXiymyVA4AN8BnG21x5TmC+2nkdzmhGdoDusxDSu+0aaf5ffYcGZC28NxlZ2XlaDzDIIOMRSoBwQZGv0ADylmQ3NFo/fzg+fP5PVdOUYPd/HCzsRvgJ08m6LXNoJCeLEo4z+f8FtqZWGtw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(39860400002)(376002)(396003)(451199018)(36840700001)(46966006)(40470700004)(36860700001)(356005)(82740400003)(8936002)(41300700001)(81166007)(86362001)(36756003)(44832011)(2906002)(15650500001)(8676002)(40480700001)(70206006)(5660300002)(4326008)(82310400005)(70586007)(2616005)(40460700003)(336012)(16526019)(83380400001)(426003)(110136005)(26005)(186003)(1076003)(47076005)(478600001)(316002)(54906003)(6666004)(7696005)(966005)(66899018)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 22:12:10.9199
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96e44d70-f4c0-4ffb-bb9e-08db19d8d6be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT105.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4298
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

Add a new module parameter for the NVME module that will let users
force simple suspend to be enabled or disabled universally across
disks.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=216773#c19
Link: https://learn.microsoft.com/en-us/windows/configuration/wcd/wcd-storaged3inmodernstandby
Reported-and-tested-by: elvis.angelaccio@kde.org
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/nvme/host/pci.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 488ad7dabeb8..718bec2d793b 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -62,6 +62,10 @@ MODULE_PARM_DESC(sgl_threshold,
 		"Use SGLs when average request segment size is larger or equal to "
 		"this size. Use 0 to disable SGLs.");
 
+static int simple_suspend = -1;
+module_param(simple_suspend, int, 0444);
+MODULE_PARM_DESC(simple_suspend, "use simple suspend for disks (0 = never, 1 = always, -1 = auto";)
+
 #define NVME_PCI_MIN_QUEUE_SIZE 2
 #define NVME_PCI_MAX_QUEUE_SIZE 4095
 static int io_queue_depth_set(const char *val, const struct kernel_param *kp);
@@ -3088,6 +3092,19 @@ static void nvme_async_probe(void *data, async_cookie_t cookie)
 	nvme_put_ctrl(&dev->ctrl);
 }
 
+/*
+ * Some systems include a BIOS _DSD property to ask for D3
+ * or users may explicitly request it enabled.
+ */
+static bool nvme_use_simple_suspend(struct pci_dev *pdev)
+{
+	if (!simple_suspend)
+		return false;
+	if (simple_suspend == 1)
+		return true;
+	return !noacpi && acpi_storage_d3(&pdev->dev);
+}
+
 static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	int node, result = -ENOMEM;
@@ -3128,11 +3145,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	quirks |= check_vendor_combination_bug(pdev);
 
-	if (!noacpi && acpi_storage_d3(&pdev->dev)) {
-		/*
-		 * Some systems use a bios work around to ask for D3 on
-		 * platforms that support kernel managed suspend.
-		 */
+	if (nvme_use_simple_suspend(pdev)) {
 		dev_info(&pdev->dev,
 			 "platform quirk: setting simple suspend\n");
 		quirks |= NVME_QUIRK_SIMPLE_SUSPEND;
-- 
2.34.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 447AA6DFF1B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 21:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjDLTuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 15:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjDLTtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 15:49:46 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388BB7D9B;
        Wed, 12 Apr 2023 12:49:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aE0efWOvAkwJxR5D87R4N6oikOzaktzxlVBoWvMnaREG6IhtDdnCJGnXVbpwVO1uidJq1OncTADSxl3J3pklDNlKGEPZXciu2kFJ9xU5Hx8hUOtmtBQakN76zW/YmtrU2BfyXDi6smiBqiG1xdimjieB9efOmUP3fqyFxI/QNOFPonspSsRbYiyxYfhiVUbq4B2GPBaudsrBFvZRbDby2apNv60XoJYMS06G+2zRGrcjV2H4EHsZNtaBecO5gJmRK3qUF7DJjPYc4W2DhRXgyRM8ASOhO+t3EtdIq0OsqwZKQqFPiCNkBVWmPZWHKEfAKbmp1n8hFW57yjgm1hCHcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MAqoozhWE/kkT/GmPTdsTtBzAMT4Hd/ynr6EOHD7eUg=;
 b=AXrkV4WllOrlSGHRLFZgovHJgcd1fdTrravHK2RTLS8ebJZKbiGIkbLgMtAdFOW0/SoYcUuL2A96kkq0SOxR8NFmk2nBNEeZEgcgvHsaBR/xZSAtLlrQKz0GaW/Av1susKl31cI5RzVzL8oyid27G3n5W00ZdvQfC7zgfyyDmD19ijBcK3AGXb2v+3ySbllhTqqB108ktUIVYf0GmiFUw5Zk6wPxfQut+RXQOZFIu8lkROunBtpbcewmnp1XoUou/ZMRrcTOSphbd4ZedFSWHY7k3RvISqSFblk1NJ4d51VD6+CARbN95a8Xt4vtfgORoytKU5VZZHnkguX1Pu6/aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MAqoozhWE/kkT/GmPTdsTtBzAMT4Hd/ynr6EOHD7eUg=;
 b=UrvN3vv8ZGeZ4RjulZpLK3vnZalCHPnJ1qDYGK+NbqpvfU3wNWxwgDDJZG7mF4oXKjxlcoU/L6DyPi9tzQ7ty0wMhiC1mZ8vsQQ04NrB+XEhqhtQYmFEsyLf98/lJJNE+LsAM5zV3cxnSqjjk+z/8B1FBXmTF4ywkF58FyJ4ruo=
Received: from DM6PR06CA0052.namprd06.prod.outlook.com (2603:10b6:5:54::29) by
 BL0PR12MB4931.namprd12.prod.outlook.com (2603:10b6:208:17e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Wed, 12 Apr
 2023 19:49:38 +0000
Received: from DM6NAM11FT070.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:54:cafe::f5) by DM6PR06CA0052.outlook.office365.com
 (2603:10b6:5:54::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30 via Frontend
 Transport; Wed, 12 Apr 2023 19:49:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT070.mail.protection.outlook.com (10.13.173.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.31 via Frontend Transport; Wed, 12 Apr 2023 19:49:38 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 12 Apr
 2023 14:49:35 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Box David E <david.e.box@intel.com>, <jstultz@google.com>,
        <pavel@ucw.cz>, <svenva@chromium.org>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
CC:     <rrangel@chromium.org>, Jain Rajat <rajatja@google.com>,
        <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        "Mark Gross" <markgross@kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v8 2/4] platform/x86/amd: pmc: Report duration of time in hw sleep state
Date:   Wed, 12 Apr 2023 14:49:14 -0500
Message-ID: <20230412194917.7164-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230412194917.7164-1-mario.limonciello@amd.com>
References: <20230412194917.7164-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT070:EE_|BL0PR12MB4931:EE_
X-MS-Office365-Filtering-Correlation-Id: 6be2e253-c8ee-4597-de6f-08db3b8f0ca4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IhxlkEBjf2xoMf3DNl9DGf46ncGoFQkqlJtLWiKtIQMtmuL8D0B1B6soXJN8YOBabNiHSv5mwol/0wbi/iiVxW9Dii7aSvGKM5Cwie6FCj273pkzJL5FhzkfzsZ5nwtc+JyYh9hhbqBo2aNJ4FAvuLJrX2vMLIGm0vNDDk3VI/thfoUxiMZyZVEUYlFFKAMoxF4MAZgQ86JAkULD77DK6sXEqAJMjqWjyEhNYbt68UVxdJx+EA+9/8sKziruNzmRUKbuiOXiXn8HQ+s7VVisCwz2aNIWxqItBgU35bNlgGGirDXKXf3X6x+lii36huDAyUWio+SjkRASZZjk3NloLTzpCwZ1XxnOkEYfbV9QBk7pPWk0kVkdWG/MXj8PV6h9qB3TSaF+9oXVqAdGYUYHOHZxyzqGJCH6cG61lG+Uir+btkLGGeC/tdX2cmEqCndbpvmokogjSb1Ae0DG3Bz17Ea6SPoT3Hlxpv8JFgc6/Sp8UjJ9OpD5ESViXEfORu2ZmPLasy1jnWRGlENwJwVn8qJORtOqIEhaQKYK2nV0W5sXHiqzgxxzQTG7NHSEMCWbt8f20xA7f+qqKgjtbCc3hoXtBvIE4HVP6CiSmRWjFT3HYr2xM3lTzrZzk096OWaDBVz93nyxnEYuKxKwY0P+5T3/GPBH4yq+IqHE+FOUgOv1SoCFenr8BYcsbEb9QjAMGdt2bgMP0V7J+FnvSNNc5xHtUkWN/6S2M1Q/+ZwPJGM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(39860400002)(346002)(396003)(451199021)(40470700004)(46966006)(36840700001)(40460700003)(316002)(41300700001)(26005)(1076003)(81166007)(6666004)(7696005)(186003)(86362001)(47076005)(16526019)(2616005)(356005)(82310400005)(36860700001)(82740400003)(36756003)(426003)(336012)(83380400001)(40480700001)(110136005)(4326008)(54906003)(6636002)(70586007)(70206006)(8676002)(8936002)(5660300002)(2906002)(7416002)(44832011)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 19:49:38.0769
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6be2e253-c8ee-4597-de6f-08db3b8f0ca4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT070.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4931
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

amd_pmc displays a warning when a suspend didn't get to the deepest
state and a dynamic debugging message with the duration if it did.

Rather than logging to dynamic debugging the duration spent in the
deepest state, report this to the standard kernel reporting
infrastructure so that userspace software can query after the
suspend cycle is done.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v7->v8:
 * Report max hw sleep time as well.
---
 drivers/platform/x86/amd/pmc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/amd/pmc.c b/drivers/platform/x86/amd/pmc.c
index 2edaae04a691..e610457136e6 100644
--- a/drivers/platform/x86/amd/pmc.c
+++ b/drivers/platform/x86/amd/pmc.c
@@ -393,9 +393,8 @@ static void amd_pmc_validate_deepest(struct amd_pmc_dev *pdev)
 
 	if (!table.s0i3_last_entry_status)
 		dev_warn(pdev->dev, "Last suspend didn't reach deepest state\n");
-	else
-		dev_dbg(pdev->dev, "Last suspend in deepest state for %lluus\n",
-			 table.timein_s0i3_lastcapture);
+	pm_report_hw_sleep_time(table.s0i3_last_entry_status ?
+				table.timein_s0i3_lastcapture : 0);
 }
 
 static int amd_pmc_get_smu_version(struct amd_pmc_dev *dev)
@@ -1015,6 +1014,7 @@ static int amd_pmc_probe(struct platform_device *pdev)
 	}
 
 	amd_pmc_dbgfs_register(dev);
+	pm_report_max_hw_sleep(U64_MAX);
 	return 0;
 
 err_pci_dev_put:
-- 
2.34.1


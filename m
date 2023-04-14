Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BAD36E19A0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 03:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjDNBYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 21:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjDNBY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 21:24:29 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B11AF7;
        Thu, 13 Apr 2023 18:24:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SWNDt2gh6+hvIFP2+2BF7dT1OzPs5zRlVSSC+GMkqoEvjASd9bjUdmJD1ldb0YcxeBqAjAYHY82IVknMqZhmYe8y7zIRbqvZc9hSpaP2YaQoZ3CTsbNaRPZCVk2JY/qCuU5XoCeOG4ew3n4Oo0G18i4QOy8DhLb+q0hgmc6EBhgb9cqxWSKiju3OPLF7hY3tJCyvpdB/NwWLj3rxEPjaMKkKB2G5xvfyA84UMkl/k+B3oYciwOqN1a1W7gzIwvX2Gf5cTCadKs9oDMTGZfcuirDNhHm22CZmlFGL+gTDhqic+9k8y5inKJfI1UxqZgWTb+/AO6/D/1AVvCOfu3YQqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MAqoozhWE/kkT/GmPTdsTtBzAMT4Hd/ynr6EOHD7eUg=;
 b=CWZ3PW+SyqiajzR6HkFBQBbv9UGsHdsayozyuXkeSlrvmynhmtWxr7aU83yoSmyGXR8P/e7uRsupUJFfnXrh/U+EEHV5nJTUNkRSQhOOG1nkqgw7bdz7gq4oGy0ETXcOaJBY19PLjsDXyMBSZfj0dtbH+iOBJARsplgoaaobDBLUdRFPPbPozCFW6qLSEdXwPWmfqZn51hVmzPFm9rZFZcYDMNyRnS6KEebEpLrndIZ6VJaukCVwm304Z+3QNeMYPLRAJPw7Xe0H4SlXtY4rhTxpIntvUqnPt+Ti930P7R9O9YY5sFNm/eIyMcbxDOBftgz3Su6a701u1tZkZoLEjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MAqoozhWE/kkT/GmPTdsTtBzAMT4Hd/ynr6EOHD7eUg=;
 b=QUFcjJvTBRdcAPqEBychE90Zfpzp0T7+T4biEUS6wnOfh6pABCGmCX8Z/SppFcq8z+0OZ8tEeZsvnut/on8XnfTq1Jto2mv+q96QXzjK8gvVFh6VOCiJu1ZZp0ZsSoA4AkQXe/l2Tlk/c+9TwWzv495E9z0jO7MFAKUcsSCQw8A=
Received: from DS7PR03CA0119.namprd03.prod.outlook.com (2603:10b6:5:3b7::34)
 by CH3PR12MB9027.namprd12.prod.outlook.com (2603:10b6:610:120::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 01:24:26 +0000
Received: from DM6NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b7:cafe::3e) by DS7PR03CA0119.outlook.office365.com
 (2603:10b6:5:3b7::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.32 via Frontend
 Transport; Fri, 14 Apr 2023 01:24:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT019.mail.protection.outlook.com (10.13.172.172) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.36 via Frontend Transport; Fri, 14 Apr 2023 01:24:25 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 13 Apr
 2023 20:24:21 -0500
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
Subject: [PATCH v9 2/4] platform/x86/amd: pmc: Report duration of time in hw sleep state
Date:   Thu, 13 Apr 2023 20:23:43 -0500
Message-ID: <20230414012346.1946-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230414012346.1946-1-mario.limonciello@amd.com>
References: <20230414012346.1946-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT019:EE_|CH3PR12MB9027:EE_
X-MS-Office365-Filtering-Correlation-Id: 681d6fae-0a1b-4a0f-8ef9-08db3c86fc58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Svv/iEMFIpd6r/QJlaO/S4DL5iCQBMpjxOHk/Us2J0CcYBmN0/ZYGNatkXUEGFsoR+p1dDODN0gKA0uL4s8yTN1k+1G7jfg9ZPPGBa803tWw7QecNV0RTnQhYcvcRMIM4zTqiyPF1vcQXKopxefg9nlXOqtwHELoADuUsBaG0rArINoa2Y0LKwjyraMe+WXNfgPoTl1ywesRWtW99+NNbjiTWMXTv60vKqz5s5AbT3UQ3kLYEgfmu3dFyqxCKIo8hl7lyQkgcCW9rcMcProLPnJD7ea93bPQlTf6jXg9ZTHwQUEKJrf93kkvE08oJvJPtCgOWaRpRnvje6yXndK2TkjIi9QZVr9eoInZPDPpMlWHBMxOvQ7nKwdIZ3GmnJ67rPx/JQshxkNZTTUzBR/b/mB/TOTDgapUTIEpX5i4ci9SobhlSrtfgoy6s3DAjwyLjenDeElpH+Gzss9vuxBICiB9CA6iJyaIzFyqO3NLh8eRGIRTzM7zFOHm8N4LHE7Sepc6fRRPO9Y/3+KH5KflrZ3T1XmNEr3zQREe+Q90vr9JF+z3M73AQgHpyzJ5C6+yYDmcqRIbLdKTVIM54QNqbZGy+wZEutIH8xi63Ab8HznIyUWMr95UmLYHxfkR0C8/gE/z1LYiVf0fxJJSj6lblCdoLZd16K7wIAXYS8me1R6EL5HUCmUlE0Ax4L8Qf7XpDer7M6MhDPIGnuaSI+ZoXYOycdvxqkvWBUFFKkHGHQM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39860400002)(376002)(396003)(451199021)(46966006)(40470700004)(36840700001)(8936002)(186003)(16526019)(1076003)(26005)(40480700001)(7416002)(6666004)(5660300002)(44832011)(40460700003)(82310400005)(86362001)(426003)(336012)(478600001)(36860700001)(316002)(83380400001)(54906003)(41300700001)(6636002)(110136005)(356005)(47076005)(2906002)(2616005)(7696005)(70206006)(36756003)(70586007)(82740400003)(81166007)(8676002)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 01:24:25.9222
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 681d6fae-0a1b-4a0f-8ef9-08db3c86fc58
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9027
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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


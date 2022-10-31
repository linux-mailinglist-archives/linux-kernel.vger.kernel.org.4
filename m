Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA72613F2D
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 21:43:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbiJaUnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 16:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbiJaUnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 16:43:43 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D59F412AF7;
        Mon, 31 Oct 2022 13:43:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oTU1F5yQm4VIBb2f0YFWbiHD7Qu0nIVOE7dlpga+v0dZetq5BDBKHiPGJ51AIVSdYjpHnOlpaZCS+sQCsZk75FMI9aRHl9zgRcNVgzRd+4Ql87N0rQMMGZ+NwGYA/m5+Ty+/Zy7A4oWI06NCVJmE8gaH2+8kyBH0V8gSE2IMScKQg+sY/NvCKlgFRuVX29jrtc6d93h28OZlH8x2iMiPiYh3MRpYjRFSMa2esbMZKEjLn1oDjdkPPEB8yjHG/eHPKiQoga/n4vYoWXtX6vHvzzOIURMnI7ricdodt4aa5g3yls2pbsq8aHle/ESypttUoa6TIYhmSejfUxTNLkBdoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PCR/5SR/wQEMC/RwoqGf/cOFCD7FBlDMgAX+MAC/AF8=;
 b=SpHbPCFpz1FVdUQCY0JxH01G7ha9fOA74BjioAhyZGmds+314GQ0VEMRGPSySXOAEVMtY5IxfxPf3IhnY7h2brqqixBZzv5ZvenXuccOPBenk+FG6Rv8mWdvGLlvx0MfOfJ0e36hEaRYNWQXRdzygSHYS5DM9Ij9AAPo4NbMKtQN0bIBjhYEnxpfPlYZfJZv+cXldTXzfeHYeqjhc2JDHlsIVLJwei45DgA/izjKfTGL6N4r+ZXIrEWtEjtHN1/tyOjXtmZEHxeYPo6KxOiJ+WqtXtcjwxLSbLK3V3vo9E3kCLSbchplmfJSv302IdQx3xAGRCtvIFztH0AV08T+ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=chromium.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PCR/5SR/wQEMC/RwoqGf/cOFCD7FBlDMgAX+MAC/AF8=;
 b=rvpIA6tWP9eawpwVYLMJLCLGJuNSlouJYvI+hWl7CK14EeuJfdAv77g2To7lCM3IIkuqDLiSCkjaAeo90RNv1pH+ExYKKEeMNJdizzM1ZecyVs3fEPs+OwKeeWGx+OYAmv7182tTNWkgo6Lg0hyQ1IuTwUWHfq2dcR7AwDuBSSs=
Received: from MW4PR04CA0204.namprd04.prod.outlook.com (2603:10b6:303:86::29)
 by SA1PR12MB6725.namprd12.prod.outlook.com (2603:10b6:806:254::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Mon, 31 Oct
 2022 20:43:36 +0000
Received: from CO1NAM11FT097.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::74) by MW4PR04CA0204.outlook.office365.com
 (2603:10b6:303:86::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.18 via Frontend
 Transport; Mon, 31 Oct 2022 20:43:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT097.mail.protection.outlook.com (10.13.175.185) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5769.14 via Frontend Transport; Mon, 31 Oct 2022 20:43:35 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 31 Oct
 2022 15:43:34 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Sven van Ashbrook <svenva@chromium.org>,
        Rafael J Wysocki <rafael@kernel.org>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
CC:     Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        <rrangel@chromium.org>, <platform-driver-x86@vger.kernel.org>,
        Rajat Jain <rajatja@google.com>,
        "David E Box" <david.e.box@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "Mario Limonciello" <mario.limonciello@amd.com>,
        Mark Gross <markgross@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [RFC 2/3] platform/x86/amd: pmc: Report duration of time in deepest hw state
Date:   Mon, 31 Oct 2022 15:43:18 -0500
Message-ID: <20221031204320.22464-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221031204320.22464-1-mario.limonciello@amd.com>
References: <20221031204320.22464-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT097:EE_|SA1PR12MB6725:EE_
X-MS-Office365-Filtering-Correlation-Id: fca68cc3-5fc5-44b5-0563-08dabb809529
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iAsbT+iomMhgOQ63IsU9SJVQ1Eto74NNVJYuW0w078VcSi8hsZNG90KiX6oMNQ+dopI87AUS62FtgW/L1e6L7/mTth0rAljsAO/Rgm9AB6bNnPB2gAzEOja9qoM15KlWVHdbngRrKoBiJGS6izr08q61eej86si3judjFeEQE+/jSQ7uQ5tj5aZnfs8fq2QA0O8uYY2kVUea0m9VENo60amYzA/h0quS4qfrCZ/B1yjbuSmmsP5dfr/WQN5ZT5/a+axLWcD5MW491QXaH1QQtu8M9l9bpfX63QhAjpaaC7a8jQm7EgSUBoicm0VRn60/md2d6HT1psSG9sKQdoEaWwChMhxR4arlPwBYp9Lc7vRP3/iqPrshqwxm2c2R/m79zA/aVxCQzqLcogW4SsDTUn1nJJKf2oAtF7QTXtPVICS1uSfthKRMvf02zG9H9f0GeWhHMpZeFu+uQOSE1TG5KsoNmmpZz8BgziJRr9bR8Nri2P6QnQt5n6Tvv8adwlXZQzQ3VXPQPvkOwZR+TfcwlUZ+QoUF7Z5vmd+IP/7LKSPM6e/7dp8a7ykmU44diWb8A8PDig5CoJkguNUZQmDUN49oH35VwQi/rPaowBDeN1JqZlQAG/69dEaz1TBA2qGX5QBDs0PDkfnvhvG3jKOgkNY1KMe+QC9hR4fwvNuibrvdbMJrRNgcb4F0EFjujdBaMtGG76v2GtejTz7w4u77/OxqWb6sgeJ7gm2Slqm3fs3/1gRxTwrPtZA6CB7thkuPyjnOJ/Ml/2DUeNKFdrtVt2MBz9dQlzoYrJsqqLpevii6GZWpYgdFm0ZivCHrHy01
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(39860400002)(136003)(376002)(451199015)(36840700001)(40470700004)(46966006)(83380400001)(36860700001)(44832011)(36756003)(336012)(2616005)(8936002)(426003)(47076005)(16526019)(82740400003)(81166007)(356005)(40460700003)(5660300002)(41300700001)(478600001)(6636002)(40480700001)(70586007)(7416002)(70206006)(8676002)(4326008)(86362001)(54906003)(316002)(110136005)(26005)(82310400005)(1076003)(6666004)(186003)(7696005)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2022 20:43:35.7485
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fca68cc3-5fc5-44b5-0563-08dabb809529
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT097.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6725
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

amd_pmc displays a warning when a suspend didn't get to the deepest
state and a dynamic debugging message with the duration if it did.

Rather than logging to dynamic debugging the duration spent in the
deepest state, report this to the standard kernel reporting infrastructure
that can be accessed from sysfs.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/platform/x86/amd/pmc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/platform/x86/amd/pmc.c b/drivers/platform/x86/amd/pmc.c
index 3703b61fb5c00..0f94c919edd43 100644
--- a/drivers/platform/x86/amd/pmc.c
+++ b/drivers/platform/x86/amd/pmc.c
@@ -373,9 +373,7 @@ static void amd_pmc_validate_deepest(struct amd_pmc_dev *pdev)
 
 	if (!table.s0i3_last_entry_status)
 		dev_warn(pdev->dev, "Last suspend didn't reach deepest state\n");
-	else
-		dev_dbg(pdev->dev, "Last suspend in deepest state for %lluus\n",
-			 table.timein_s0i3_lastcapture);
+	pm_set_hw_deepest_state(table.s0i3_last_entry_status ? table.timein_s0i3_lastcapture : 0);
 }
 #endif
 
-- 
2.34.1


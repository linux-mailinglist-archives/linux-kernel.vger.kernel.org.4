Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1772B6E19A2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 03:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjDNBYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 21:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjDNBYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 21:24:31 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28E1E69;
        Thu, 13 Apr 2023 18:24:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dpoxlqB7DTLLYqyx6Mf0DrGdahCkbTGhriyeyBwzHyKKKEF+iqLmTwX/M5YDKxqwwXW79iVWWHBgpzbsTQ5vAI6YxewixQYUGnYaulHsDnFqZHv9hZ4yg9b4g0ZOj5aVzXNmE3r/KtjrrbpWxHCF81/VBJdEaeFMG3okf48mM+4YsY9KX04NEUQq5ii32R4HhdI9Ddf2YnUcEdr+xD/uovIfZXEatui30jeQjy/nkuVNsjI+usVDEPKV+9Qe+WIGira5wvFCZ19igXbV0zL1WOxwUAqWthX44mk1tLSgF5E2P1nQSwuts34X1cKdTwc5EtGNJeX6pb8DmvEaCurSVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6uyuYrzpFUD9AAiawcudYbjDPhPlJBKpXwXniY+Li4s=;
 b=aLxyqIs1SlaMOqnty4CS7CXYFxAuirc6bSeypO0Mh70GdrApheGvKRCw5eHLCQoaDa12WyaKLK/2IdA1QQKTZdJTgtH31TyUcJ9nSPl6a5OWjn7grGSekOlFg/Wle7mT5PeMdXvJNGiUwbaz8n1LcbG1ezM+qF6GuPOwZfHzelBbnuUAgElHF0FHpaJeNhJUyxLuL6jNaCRrzEC+BBdE8QMFrCF6myz3N2ZmLt4kJfetzp2VYay7wQtXSY3m3Df+cUyBO+o4B5rWOi1HBuqk9VuQU2+cS8j86U7sHZRxtdWctUS5WFxAPrCKYxGky7rACeruQnTZ1KL+3Yy6bOcSWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6uyuYrzpFUD9AAiawcudYbjDPhPlJBKpXwXniY+Li4s=;
 b=sPCG3ThX+0vOyxfSewCrhsJWBWaa/EAM2xJpNUcOQ3eVcZwWQDi7YSh8YhZ8KqrlRjyd4NKcSIQD4BLJasRM9QDek9fJazUIazRp2/I3mj5PPbGF5YX5QjtP8Gi7iiO33ohsvGYM3Q6HQ1OswvqF9CaXv822qPrqm97NhKY1H0A=
Received: from DM6PR02CA0080.namprd02.prod.outlook.com (2603:10b6:5:1f4::21)
 by PH8PR12MB6817.namprd12.prod.outlook.com (2603:10b6:510:1c8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 01:24:27 +0000
Received: from DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::3) by DM6PR02CA0080.outlook.office365.com
 (2603:10b6:5:1f4::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.31 via Frontend
 Transport; Fri, 14 Apr 2023 01:24:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT050.mail.protection.outlook.com (10.13.173.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.33 via Frontend Transport; Fri, 14 Apr 2023 01:24:26 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 13 Apr
 2023 20:24:23 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Box David E <david.e.box@intel.com>, <jstultz@google.com>,
        <pavel@ucw.cz>, <svenva@chromium.org>,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>
CC:     <Shyam-sundar.S-k@amd.com>, <rrangel@chromium.org>,
        Jain Rajat <rajatja@google.com>, <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v9 3/4] platform/x86/intel/pmc: core: Always capture counters on suspend
Date:   Thu, 13 Apr 2023 20:23:44 -0500
Message-ID: <20230414012346.1946-4-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT050:EE_|PH8PR12MB6817:EE_
X-MS-Office365-Filtering-Correlation-Id: e6f8e632-ff93-49f9-b085-08db3c86fc80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OoZfYjm9cncJ90fyvrkTNsH6zgqwW8MxIxmoyXLSUvc2r8HJn2+6alJcptXOG0Mqsrakabsb33LVYkUHiABHzMJ3n5rgFiMF9KR39DInL0CvxufXP4bnm50XR0fjlyiTqrDL2UHgdTnBj9VKYJyk0LAQhCdDbt1O46YIQCeYcJA3QMGGHMOSYTxU7/Htn/izgXnVYAalzpZt9tufVTrjmv8Ji6feqieVKYXjorFxNZNb2ec4gwW/Ox1yxz0Bvsc1kiy5sedKYz2KruZCY1rPyT7HKYLgH9YimOdOpE6EYR3Or64ncKBwnt7MVYMHHIrKOJEiOTKx76GMhhAbY4sw241HENxkt32Jl21GrAxSEwnxAid6Ct/7ecOgny3FtRt7nvrpzR7WxVA5syU3nMnETxLDMkCm2lo/8AY31xCan4e+FAu8frrhB0yYJuYdKWjPXt6R4JUcJriWlzOWoCxKpKXxnRpua7it4R5JFwiQH2lIL03jsxkEq1Bc+FreO8GAP/+AiDSnBU95xUjZa7lHWoomxnKn4eJWdWeU9JyrMv+N96B38SldOOroM4w+JK01oYrL/eoYt6mqaxs7z9AY8GXvpwFcCv9E8eoRmI+shrkzDh9LeNDuTC5BuMr3BwomTRKFgLGURA4+ylsdFJsXGDyNY6Cv6SYmhbA5xEY3drUd6Q2Cjolbk9uL0HvMB+wFjxXzSlDRNF2VA2aFfg1LLQl4MKydzkqZB8eJ9U5JQw4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(39860400002)(376002)(451199021)(40470700004)(36840700001)(46966006)(336012)(426003)(26005)(1076003)(40480700001)(70586007)(70206006)(36756003)(2906002)(6666004)(83380400001)(82310400005)(47076005)(7696005)(2616005)(186003)(16526019)(36860700001)(4326008)(15650500001)(40460700003)(110136005)(44832011)(54906003)(7416002)(86362001)(5660300002)(8936002)(8676002)(81166007)(316002)(356005)(478600001)(41300700001)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 01:24:26.1539
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6f8e632-ff93-49f9-b085-08db3c86fc80
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6817
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently counters are only captured during suspend when the
warn_on_s0ix_failures module parameter is set.

In order to relay this counter information to the kernel reporting
infrastructure adjust it so that the counters are always captured.

warn_on_s0ix_failures will be utilized solely for messaging by
the driver instead.

Reviewed-by: David E. Box <david.e.box@linux.intel.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v5->v6:
 * Pick up tag
v4->v5:
 * Squash patches together
 * Add extra pm_suspend_via_firmware() check for resume routine too
---
 drivers/platform/x86/intel/pmc/core.c | 13 +++++--------
 drivers/platform/x86/intel/pmc/core.h |  2 --
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index b9591969e0fa..925c5d676a43 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -1179,12 +1179,6 @@ static __maybe_unused int pmc_core_suspend(struct device *dev)
 {
 	struct pmc_dev *pmcdev = dev_get_drvdata(dev);
 
-	pmcdev->check_counters = false;
-
-	/* No warnings on S0ix failures */
-	if (!warn_on_s0ix_failures)
-		return 0;
-
 	/* Check if the syspend will actually use S0ix */
 	if (pm_suspend_via_firmware())
 		return 0;
@@ -1197,7 +1191,6 @@ static __maybe_unused int pmc_core_suspend(struct device *dev)
 	if (pmc_core_dev_state_get(pmcdev, &pmcdev->s0ix_counter))
 		return -EIO;
 
-	pmcdev->check_counters = true;
 	return 0;
 }
 
@@ -1233,12 +1226,16 @@ static __maybe_unused int pmc_core_resume(struct device *dev)
 	const struct pmc_bit_map **maps = pmcdev->map->lpm_sts;
 	int offset = pmcdev->map->lpm_status_offset;
 
-	if (!pmcdev->check_counters)
+	/* Check if the syspend used S0ix */
+	if (pm_suspend_via_firmware())
 		return 0;
 
 	if (!pmc_core_is_s0ix_failed(pmcdev))
 		return 0;
 
+	if (!warn_on_s0ix_failures)
+		return 0;
+
 	if (pmc_core_is_pc10_failed(pmcdev)) {
 		/* S0ix failed because of PC10 entry failure */
 		dev_info(dev, "CPU did not enter PC10!!! (PC10 cnt=0x%llx)\n",
diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index 810204d758ab..51d73efceaf3 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -319,7 +319,6 @@ struct pmc_reg_map {
  * @pmc_xram_read_bit:	flag to indicate whether PMC XRAM shadow registers
  *			used to read MPHY PG and PLL status are available
  * @mutex_lock:		mutex to complete one transcation
- * @check_counters:	On resume, check if counters are getting incremented
  * @pc10_counter:	PC10 residency counter
  * @s0ix_counter:	S0ix residency (step adjusted)
  * @num_lpm_modes:	Count of enabled modes
@@ -338,7 +337,6 @@ struct pmc_dev {
 	int pmc_xram_read_bit;
 	struct mutex lock; /* generic mutex lock for PMC Core */
 
-	bool check_counters; /* Check for counter increments on resume */
 	u64 pc10_counter;
 	u64 s0ix_counter;
 	int num_lpm_modes;
-- 
2.34.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7E446D0F33
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 21:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbjC3Tpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 15:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbjC3TpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 15:45:02 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E1FBEFB8;
        Thu, 30 Mar 2023 12:45:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LT+DiyOwMHhz5EPWsHvBu9/Rpvv+ue1YpKHddyOFEueDlKZogQUlBsQR6Yashvat0Xi8dfV0kiDH/9bz4YQtr+2AsNjiTtETxJcK4tZGE0gMeIy+m0+hU2NjkFs8YN6+LKGY2WZyyI2ZOUDdw7arOqCrR7zZwlhL/EASkm4T33kgFuAyf6BVludv7CSoJPSetHHqOBB76OKduL9PE6p0EXl1HCLlO4oeTYh/YQu3WsuczChyYpAz1ukabtjJi2oKj5ugBU1KXf5e42zpv/q05+sf1S14raJTLph8TRD3123TewOIyjFEsUd7B/P5RAy1NAfm7YlsnbGmNRAl7czeyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ufn8iPJCn4WCcxjd+crM3jNLBZ9f/9yk35ufgrRnb5U=;
 b=hXT6hKYvptTL4ChaxS+lBXkJgq6Ls6HagKn1PD5Xp6hJX3jtPs0r3wTEEp0SDaJGrdJHAP98mrDDoSlAfScZ1saYPFgrh9AvEzVeFew+PvD+GPvJ6TAqcYsMz+Gq1zFjAYx9X7I8YSAdfkF00I7mkTKG88W2ikA/1zcv0oyysphua3lADiNcpPCAT41++4SbEJRWRiXDW2ICBwwpyksD6TU1JWcdqzBEiP3sF+BNppE3anPB+f3WKi29rKL5QAy6Bv2DIoQoms9sR4SdM6wyyUYTvxTxbWEilc1rQNnJ3brd8x6GlAJPs8HYz11kLaXlwSNvRY/WVHqiOgHrp5hVOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=chromium.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ufn8iPJCn4WCcxjd+crM3jNLBZ9f/9yk35ufgrRnb5U=;
 b=1AheRUrUC7r8Pe5/M1UbdagsCdLlbsUTTqX9GwdFM4XWXH3MQt7uX0EQdN8K3ajZ0ujYi+GNtMC9YjW0XikFHXXwoMWsCGx8HA2tYU1bHf1HohIz/a7qfg/FuAMTxg1qcCbglP+OIngpNoLman0NLcKoOOtf/c9cJA4T60x3unQ=
Received: from DM6PR11CA0048.namprd11.prod.outlook.com (2603:10b6:5:14c::25)
 by DS0PR12MB8502.namprd12.prod.outlook.com (2603:10b6:8:15b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22; Thu, 30 Mar
 2023 19:44:59 +0000
Received: from DS1PEPF0000E63D.namprd02.prod.outlook.com
 (2603:10b6:5:14c:cafe::bb) by DM6PR11CA0048.outlook.office365.com
 (2603:10b6:5:14c::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Thu, 30 Mar 2023 19:44:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E63D.mail.protection.outlook.com (10.167.17.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Thu, 30 Mar 2023 19:44:59 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 30 Mar
 2023 14:44:57 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Sven van Ashbrook <svenva@chromium.org>,
        John Stultz <jstultz@google.com>,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        David E Box <david.e.box@intel.com>
CC:     Raul Rangel <rrangel@chromium.org>,
        Rajat Jain <rajatja@google.com>,
        "S-k Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Mark Gross <markgross@kernel.org>
Subject: [PATCH v5 3/4] platform/x86/intel/pmc: core: Always capture counters on suspend
Date:   Thu, 30 Mar 2023 14:44:37 -0500
Message-ID: <20230330194439.14361-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230330194439.14361-1-mario.limonciello@amd.com>
References: <20230330194439.14361-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E63D:EE_|DS0PR12MB8502:EE_
X-MS-Office365-Filtering-Correlation-Id: 76967357-d463-461c-26a7-08db31573f04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n3pQzI7J/h5HtyWkU693WfbdcbjZCuKh85hPx2ZY/iQVMJhYQgYek/7ysC24LPiyF/x1D7wF76W6+GjE0mGwxfGvmg9U5wCFCGvaLzhdQlWbIcS86WGb9/lx41SSh0d2fFgclroe4PnL8ypmbIzhmR0WVPE++g/jiZeuANqheSv/s1yfG2MEYb1Alc7CN9vb6N38pd4UXnfdCDBRwM7w8+de5mGgAGCS06u0WTrTgfMeMriSIvVZBffWkAqEVKtpT7lmCyd0VEipu46lwrA0uB0velTpgA50ZlLa+fHq2q76xRxuyj4ssqahHa3jyVNIqosgNOK7h+vw8H2JmMTdBcStipFQmi3YJoD5eRKjyOOg4T0Chx7AQ+7kZM/pKsaylVsaMQpNBW00lvEMmlx4/9tgxvmveHWmZUGA/nwVONtlXNbtAWj4izLM/IdrK8D0uxqEZjzHWCtJZDmH3skcn+HBgHWBmjH1VBC81PxhNNJ6CCtIKEGdb1P871Hvc4yXE/w3xqZQOZEPDQMXtMprKU8uMZXLghmakodD+08z+39NEsaCWt9A5koePok1NSxCxyPmEyBs9FoIPpyIOU7azKU8k68V8A4HaQTeIY+oaIk5k7ckcK+Qr4lBzuNQVW8Qb3rfyItQeJa4wWj5JRZWs2C2WiTWce9EKcDpdCZN4I2aedNYEY60EitdreOlTq934RvZSauicNPVj7k2nLG03v1AjNU9PXh4g4M9TOx3jIM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(346002)(376002)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(1076003)(26005)(83380400001)(47076005)(40480700001)(6666004)(40460700003)(16526019)(2616005)(186003)(426003)(54906003)(336012)(316002)(110136005)(36860700001)(82310400005)(15650500001)(478600001)(7416002)(44832011)(2906002)(5660300002)(86362001)(70586007)(8676002)(4326008)(70206006)(8936002)(41300700001)(36756003)(82740400003)(7696005)(81166007)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 19:44:59.0490
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76967357-d463-461c-26a7-08db31573f04
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E63D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8502
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
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

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v4->v5:
 * Squash patches together
 * Add extra pm_suspend_via_firmware() check for resume routine too
---
 drivers/platform/x86/intel/pmc/core.c | 13 +++++--------
 drivers/platform/x86/intel/pmc/core.h |  2 --
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index 3a15d32d7644..e2f171fac094 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -1168,12 +1168,6 @@ static __maybe_unused int pmc_core_suspend(struct device *dev)
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
@@ -1186,7 +1180,6 @@ static __maybe_unused int pmc_core_suspend(struct device *dev)
 	if (pmc_core_dev_state_get(pmcdev, &pmcdev->s0ix_counter))
 		return -EIO;
 
-	pmcdev->check_counters = true;
 	return 0;
 }
 
@@ -1222,12 +1215,16 @@ static __maybe_unused int pmc_core_resume(struct device *dev)
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


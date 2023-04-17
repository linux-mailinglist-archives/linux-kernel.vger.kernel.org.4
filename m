Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 396A26E4D2F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 17:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbjDQP2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 11:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbjDQP2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 11:28:20 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2044.outbound.protection.outlook.com [40.107.95.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57EE293D1;
        Mon, 17 Apr 2023 08:27:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FkB9JMqv+uT18q3scEVJ2VG1frlmdji/90gxmC7GwdGj4FIJAjerGc8NxsQtkhvV0f+tHkE4dOB/g4kUaA5WdcPIyWGV5D8t6z/PBj7D47rTn4+bHsREYzXdpa1WdJv2tAEUhmLY3cOiaJMl8x8Ayxj1bAAEI7XBYNOJsRhoKlxde4FOh7/MP0Ij67hoi3qt0saj055XSpBFZk9f1z0xfg0X7FDnbkPpuM0NSuosFoGoicdFfv/uCSiVajFgM6wbNCCH7GhGoflL8lxq7xPcaUjalzA983OXc4nApdcWWiM4rwVXuwnMuFwdbaH+pTXpckqTAdWdWp9AqOWnspvT4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8/4o3ginl8AgXQwaQyt6cMKrtMTpFY6CC1m6/DQpBRc=;
 b=GIJGjHC7efoe8dgKAAQseMOT9GCsk7OTdiwmYGRjEVRJS/IwelK84Epqzo3glpJsPBrj+x+pg+z08EuwVZlQd39FAAX7isDPi7Ba92wVGWJGZXzFMuhNSLxXd6f/pqlAkJ2VG7EwsSwtKEqass2Ruk5L8VP2IIBbKlxq4AoMb0zGn5ii88QyHFwEIAQ0OMJmLbnJdEqfnUUOYpJYV3XccAEYAZJgvGLNcfxwJiTx2C9kVnVF3WXnzWRfX6XqeeUGf8acyDsmMiiVMuIcKicZUTQqoCr7OfUnr2lYoMU5IednUz2+lfrZgWvn2Ow1lhz9H+OAwKarvYsIi73BUa6PIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8/4o3ginl8AgXQwaQyt6cMKrtMTpFY6CC1m6/DQpBRc=;
 b=NbHmDTNJpJpkq0I6H/qxrE29ia9W1L8KHzhbhsE6TsP0veXDCP0WdXcsekYzex74UkdIWDMBW/q4dVahOR/p5/OEHoyGNrIqyo4LPAXOFQJQFi9WZmMd4rD8F8uBMIIxhzF6Cu0k/yoBqx64/YaUTw33ft9Gex5fsYR7RsaulYs=
Received: from SJ0PR03CA0101.namprd03.prod.outlook.com (2603:10b6:a03:333::16)
 by PH0PR12MB8007.namprd12.prod.outlook.com (2603:10b6:510:28e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Mon, 17 Apr
 2023 15:27:34 +0000
Received: from CO1PEPF00001A5D.namprd05.prod.outlook.com
 (2603:10b6:a03:333:cafe::48) by SJ0PR03CA0101.outlook.office365.com
 (2603:10b6:a03:333::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.46 via Frontend
 Transport; Mon, 17 Apr 2023 15:27:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF00001A5D.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6319.14 via Frontend Transport; Mon, 17 Apr 2023 15:27:33 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 17 Apr
 2023 10:27:27 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
CC:     Box David E <david.e.box@intel.com>, <jstultz@google.com>,
        <pavel@ucw.cz>, <svenva@chromium.org>,
        <platform-driver-x86@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        S-k Shyam-sundar <Shyam-sundar.S-k@amd.com>,
        <rrangel@chromium.org>, Jain Rajat <rajatja@google.com>,
        <hdegoede@redhat.com>, <linux-kernel@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>
Subject: [PATCH v10 4/4] platform/x86/intel/pmc: core: Report duration of time in HW sleep state
Date:   Mon, 17 Apr 2023 10:27:08 -0500
Message-ID: <20230417152708.3599-5-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230417152708.3599-1-mario.limonciello@amd.com>
References: <20230417152708.3599-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00001A5D:EE_|PH0PR12MB8007:EE_
X-MS-Office365-Filtering-Correlation-Id: c8431eb7-c4cf-4070-310f-08db3f584435
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rApc3+AEuzwSi9SWSWZgjovSmoKys2/YLmQkAKu1iHYOWP7dUl99NB/Coprhph/Ac8hrQss8G3Yrqplqj2cMHUg7NrHdmgww7qmaKdF1L//dZn8FGUICBiO2lHwck+rq28C0mXXkTSHJMr+BamE62LPnSabPV2dn4rec/gaHdJ97afVpb0juBCFuzBp5A3UT7k15MYsGd/ICxaBU9+QK7uxbc1XB8Sf8hkTBvAB0Yz/HJYaoXaFpLiLFmgQvjMuxCl7+i06FOU26lRkYGbHtCiyK7ZF0YAtJIDImREUjNQvVQJqQRANrxPAO3bV1g5JOQjLauVShkXaXywaz2qp3bAbhr58U44qW+c5CTn1667yhTwZ4RwyR53Eh1yCTBFLECTcEyRsP4k2fSomIIQ/VWFEuvjnVyxbhVXmMINBfVRgZCo+ZgYehBCWz3EYx40JSMmw8GNPgL/LPdkbgTQnn4d4JBnqPg00ix1heY4smHXXTv8YnGN4tap7H/EHBwgHx1/IIfdytUFAoWZ3z3ym/zkpoexKOhBWnQ4GTBdYEcs1qvn6FvhsWUtIfmD5o4H+p5fLepr7nqQaWnPHCd4eDz3KBYUpM2TqI/5HkTmQTJe78W3YEzygFdqzEGtY6/vA0Dx8nVyOGtMByMyDuUGaD+QfQLZCQw93W8AIL/PxSI3yQyaU1QyX5If3rLGQTUmvZHdvVM+Kx79NiQ7XN+l5JZwGztc2vmtSCxPdLnc/c19U=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(346002)(136003)(451199021)(36840700001)(40470700004)(46966006)(36860700001)(82310400005)(4326008)(1076003)(26005)(8936002)(8676002)(36756003)(41300700001)(86362001)(316002)(44832011)(7416002)(5660300002)(70586007)(70206006)(6916009)(54906003)(40460700003)(81166007)(2906002)(7696005)(356005)(82740400003)(6666004)(47076005)(66574015)(186003)(16526019)(2616005)(478600001)(40480700001)(336012)(426003)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2023 15:27:33.5502
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8431eb7-c4cf-4070-310f-08db3f584435
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00001A5D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8007
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

intel_pmc_core displays a warning when the module parameter
`warn_on_s0ix_failures` is set and a suspend didn't get to a HW sleep
state.

Report this to the standard kernel reporting infrastructure so that
userspace software can query after the suspend cycle is done.

Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: David E. Box <david.e.box@linux.intel.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/platform/x86/intel/pmc/core.c | 4 ++++
 drivers/platform/x86/intel/pmc/core.h | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index 925c5d676a43..298f27ba1e10 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -1153,6 +1153,8 @@ static int pmc_core_probe(struct platform_device *pdev)
 	pmc_core_do_dmi_quirks(pmcdev);
 
 	pmc_core_dbgfs_register(pmcdev);
+	pm_report_max_hw_sleep(FIELD_MAX(SLP_S0_RES_COUNTER_MASK) *
+			       pmc_core_adjust_slp_s0_step(pmcdev, 1));
 
 	device_initialized = true;
 	dev_info(&pdev->dev, " initialized\n");
@@ -1214,6 +1216,8 @@ static inline bool pmc_core_is_s0ix_failed(struct pmc_dev *pmcdev)
 	if (pmc_core_dev_state_get(pmcdev, &s0ix_counter))
 		return false;
 
+	pm_report_hw_sleep_time((u32)(s0ix_counter - pmcdev->s0ix_counter));
+
 	if (s0ix_counter == pmcdev->s0ix_counter)
 		return true;
 
diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index 51d73efceaf3..9ca9b9746719 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -16,6 +16,8 @@
 #include <linux/bits.h>
 #include <linux/platform_device.h>
 
+#define SLP_S0_RES_COUNTER_MASK			GENMASK(31, 0)
+
 #define PMC_BASE_ADDR_DEFAULT			0xFE000000
 
 /* Sunrise Point Power Management Controller PCI Device ID */
-- 
2.34.1


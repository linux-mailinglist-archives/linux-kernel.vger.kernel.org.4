Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3566E19A4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 03:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbjDNBYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 21:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjDNBYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 21:24:32 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2054.outbound.protection.outlook.com [40.107.100.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C813E40FD;
        Thu, 13 Apr 2023 18:24:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lA0SPL5yq06GRlTwRFKWkhq87uKmUk80BxgyRkNBHcDx6VH2lwRxgsPBvIpSq9zFhGWao7YyO5zN+3IMRa63Ro5jTYCfj4KicbaJMkgVZ8nmDrbdwKFmuevtCao9CqFhua4vs1nEzL8RNi8i3QIogVv6b4I437aYkJxUbdbCQ7gSnXriRbGzam6y69ThxnllAUo4ASKHI0VMy/dER1OsOMO1NTdBGPRkreK9hAXgyBdSxSPUDxWt7OflF3id7x+oeqnBFVMCf0P9XHF3cevxfkBgL/gFr5kEBauiknzbs/eaozwjFjUL1OWFjLoGsYFORGsc/QnWnUeD6sV7xiDdWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uEGYGPy5OjPx1cD0EI26wT4NCdlfHrDRRS1jFg0AECw=;
 b=lybRjdR8mMIqmsMs1eMdIk2OHzwdMkHKvEM/evf1fUz39ZJ2/rmgi/u3mAMBCM5Vok+thsbrW+obKZvz7wtvATGFWUJPNzKrh1nEMOLGeHj1Pu4oHdY2dvxsnZe9aVZwqc5rteitt76ltxOKVGSjo4P+NEN+HxdvGrjKQqwHsy5VVe9mfEEtXcpNz5aLy/H2Ij33Yix1sarOY5LYBvfFATuJG1CYvs/UWjQ4il6AVxEaVwNdrDPt7V5gyjS1UXkouCvl2x3Wyzs17kTw8sQJmHGoPdjpLk8aNctjuxPNfMB/cEl5YC+WrTUcMHuudUkg3y7tbybxqBUwRSpuyLwBWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uEGYGPy5OjPx1cD0EI26wT4NCdlfHrDRRS1jFg0AECw=;
 b=XWtE5E6DEZgADQtUy/Hm/QwOFJcdVZaluPrcptG+erKnj8uIeDzkBBIHrkEHkveQI2YnrodB7OE/AY6GT1qBBB7TOTmf6Ekn9VuLLHXWflldXd/AOIu5NHMm7G+AnJPliW0k0ER31sAXTXV27zKA/g1ue/Js7pLdcDdoqmWNlgg=
Received: from DM6PR02CA0105.namprd02.prod.outlook.com (2603:10b6:5:1f4::46)
 by MW4PR12MB7189.namprd12.prod.outlook.com (2603:10b6:303:224::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.35; Fri, 14 Apr
 2023 01:24:27 +0000
Received: from DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::15) by DM6PR02CA0105.outlook.office365.com
 (2603:10b6:5:1f4::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.32 via Frontend
 Transport; Fri, 14 Apr 2023 01:24:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT050.mail.protection.outlook.com (10.13.173.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.33 via Frontend Transport; Fri, 14 Apr 2023 01:24:27 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 13 Apr
 2023 20:24:25 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Box David E <david.e.box@intel.com>, <jstultz@google.com>,
        <pavel@ucw.cz>, <svenva@chromium.org>,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>
CC:     <Shyam-sundar.S-k@amd.com>, <rrangel@chromium.org>,
        Jain Rajat <rajatja@google.com>, <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v9 4/4] platform/x86/intel/pmc: core: Report duration of time in HW sleep state
Date:   Thu, 13 Apr 2023 20:23:45 -0500
Message-ID: <20230414012346.1946-5-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230414012346.1946-1-mario.limonciello@amd.com>
References: <20230414012346.1946-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT050:EE_|MW4PR12MB7189:EE_
X-MS-Office365-Filtering-Correlation-Id: 72991e36-f0ee-40ce-41e2-08db3c86fd38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s+1tIQJGxEMVlkVrnZPzlNhaicA4vBpV6P5b8H3dTEx9UQ2fKMTTM06q5bpIXNN0/yyCEuqvrFHryGfbnrJy0U0KlcF6p1Vur1YCoNGxf5NLRasRIgm8L24gwZh/9GynWDXez4ZRhbLn7YaFgMIDUhnlS9024c7eXKxX+2W1auPy/BD/b4z6T5Bk44op1JSYMxpvxpmth2ghLAYGvK/G83fMKPFZv9wrwAaTFnxWDCjAgf9uRNIolSSjnXUcmRSIpcvamMCnF9yUwe37J+FJrzFBQIGOttg4ISJ7+Qo3irT3WJFECxpBr+hWmPTg5nW5NUAAaRHHjuGR+JuXv4RYirKnzm4BxKVefxqYakBDDCWJv7EdjY2oSMsndOJk2DrUOsFWFjx+2zKGafc2X+UoUSWdP5NvfIBEYZsl6yNswm3fmUwiQiz9lg1N2h95t08lPNpO4tnJk/FULacMYEBqQyrP6Fe7KgcicY1SQUJkscGk8nR8Qlj1UcZgr5m+QfvxgT5Wr5lV1u+PtMZ7utstW8e9GpaZHSrOzZRemQ/3k4G8OX/oLiNsg/zfQ/eryWrXjWHbxbG4wSinAwPPH9HTP9SDKMlhGR/UDUJrmh52imR4Q5hOGtIYhGjmAG4pbX1wc4H8BRDwC9B39HICyVOlEKfrLJCp34WFeEENYjhoxE7xirj0pKL94k5BCxgSwHJpELUyuNtwxlIz3wYafQkr2+X4wKxY8JAGAX75ycNwqOc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(39860400002)(396003)(451199021)(46966006)(36840700001)(40470700004)(7416002)(110136005)(4326008)(44832011)(5660300002)(8936002)(54906003)(2906002)(316002)(16526019)(478600001)(70586007)(41300700001)(8676002)(70206006)(186003)(7696005)(6666004)(81166007)(1076003)(356005)(82740400003)(40460700003)(26005)(47076005)(2616005)(83380400001)(66574015)(36756003)(426003)(336012)(82310400005)(40480700001)(86362001)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 01:24:27.3414
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72991e36-f0ee-40ce-41e2-08db3c86fd38
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7189
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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

Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: David E. Box <david.e.box@linux.intel.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v8->v9:
 * Use FIELD_MAX and GENMASK
 * Add tags
v7->v8:
 * Report max sleep as well
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


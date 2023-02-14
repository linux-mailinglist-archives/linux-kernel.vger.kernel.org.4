Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24A6B695B9B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 08:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbjBNH7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 02:59:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbjBNH6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 02:58:49 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2050.outbound.protection.outlook.com [40.107.96.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A97192;
        Mon, 13 Feb 2023 23:58:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bEDojPaTGEY22bQxw4Qe/vMZxnERFZRTte82dbE6iTIjBT90YHL/4SbNy8dTObb2jCjvxI6zT1KXy4rIXhmCw4gygj8DLxtQaG2j0c9BROf5sKXxHBslQs/XEb0GDE5RYehUtFu90VBWsfg2WX8KctSDrBc6x2C7K27iZTqAw+CqN093qa06DE7j4TxZoGW0vtSK3Vt9rPtAF1E34bRPIKNMVMrrE5+k2G0Eplmb5efXSFAJP5+m3KWIOh0xFQVknk/ugbKk4KLoUiN69FTnU6Z5xkOSRoPHuVZ/tQ+mWFi3dqQYL1I58Z3jaaUmCYMzwvy91lKRRj/HVU/B++xK0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6/6/NHxDJPOcNxxBjyh/IXuwTAFStCGWrmuNjYzMzQE=;
 b=fRvChH2UvQw7cSONfNkV2mYbVHCrVca/KDLYc97XhIkbr3VnNNtiAdJlc/l7Keqh9JxqGYOI4oa2Ok6dwCStBS7JdgJOrjs3x7E6R3dJD2NjhimTDBAF/mBBDPQNCbeKRFySKZKm2KFFku1RCdo55dvm8l87enp0XPaGtF58Ss33f6W1fidRnv5IU9hSB2iNpkbbd5schltsnLm740/hMNC+Ng+dY0+7gSIU19bqhqKl247VTfqkN8SUrvONea4AFUysyAun1Yvu8KiY6zt1R8yuIfophhAvA0c4L9rW3s1bImucSeCZaY0nKtl9xpsIetjyVkclrOpwCV/2uJE7JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6/6/NHxDJPOcNxxBjyh/IXuwTAFStCGWrmuNjYzMzQE=;
 b=jNNNsXdmsus0Yk8I0NSBx9lQcPPjDUDtcM0yWDjxzOJVLAaVuTZaENn03O10o2dtgFTqwv+WS/9JQ25qU2lVg+mBoFt6FZM3SBG8f/dmXr2MSC+Ugaq/gwlSmBselAk3ZxQVEYAWEnSTjAsNRTGQg3TTaJ+g7SrlVlhhXcuvMg4=
Received: from DM5PR08CA0032.namprd08.prod.outlook.com (2603:10b6:4:60::21) by
 DM4PR12MB5150.namprd12.prod.outlook.com (2603:10b6:5:391::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.24; Tue, 14 Feb 2023 07:58:32 +0000
Received: from DS1PEPF0000E63F.namprd02.prod.outlook.com
 (2603:10b6:4:60:cafe::81) by DM5PR08CA0032.outlook.office365.com
 (2603:10b6:4:60::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26 via Frontend
 Transport; Tue, 14 Feb 2023 07:58:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E63F.mail.protection.outlook.com (10.167.17.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6111.8 via Frontend Transport; Tue, 14 Feb 2023 07:58:32 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 14 Feb
 2023 01:58:28 -0600
From:   Wyes Karny <wyes.karny@amd.com>
To:     Huang Rui <ray.huang@amd.com>,
        Rafael J Wysocki <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Yuan Perry <Perry.Yuan@amd.com>,
        "Arnd Bergmann" <arnd@arndb.de>
CC:     Mario Limonciello <mario.limonciello@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Wyes Karny <wyes.karny@amd.com>
Subject: [PATCH] cpufreq: amd_pstate: Fix invalid write to MSR_AMD_CPPC_REQ
Date:   Tue, 14 Feb 2023 07:58:11 +0000
Message-ID: <20230214075811.23644-1-wyes.karny@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E63F:EE_|DM4PR12MB5150:EE_
X-MS-Office365-Filtering-Correlation-Id: 55bead9b-82e0-4f6d-9f0c-08db0e61444a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5R/+O3rN1WXO9FmJNKYmoP1ofcY5RGL0Q5tvsmqHsphsqQHnGv2cg4yKMhDFVzjSSEGOOLKYCvi7U3spH7h+WjAcoHXDU9mnOmTxAUDPtgG7IbrhO4I50cygbQLWJH7fFtZLTScehfsGpq4pGdmlz3eHSPNR+W25SOunN6nUMDIq//3rtkOubgvB3iuSi3eGBO82S8ZCKbrVpODVcDLUgsXXJJcl6ngaF7bPSFNgm/bfcT4KSmZB03BwGbht8hnqWAcNeVJZ0niyUdoNJZ/5jeBMB/ybem3UdyX6mh+U1wIFN/QeD+rf5XzVR01zSJPuQOtKXR36X3JEaLiEPnwCXjH3+ob7UBC65vqLmGowezU+CjwaLWUoqaHoD6ZaW+FX0xoYnnviRN7mUI3XcO1t6y+Fk9Jzb9egXKLzXYsK99RVHNK3spnlYSAsWYblGmxPxmQTHOkR4fdJ959GIuIooH4zRq1Ky1IK8gsmyTGX/ZTdZTUyUf6czrBidIYAC8n2VaEU5X2elboVoZiUgK3ic59O+3fWZje7RnGsd0r1/SoawD/yrEBQsTtHu7ZPpbe22eCjrO2hgS9NHeDJq1hg+CSoYO6kqQqtyppwAPL4KiAANUQfcSbackBai4XbialCKdEGVDFIVQljT12X2BWy09wro1KzIPTDYXnvz8eVPNUxxm+PpVXrF/R4ryDy1icY0FNprLP9jW8IM4/Csm7UoXGp3rXnWKewAp4WOlD0UB8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(376002)(39860400002)(346002)(451199018)(40470700004)(46966006)(36840700001)(36860700001)(70586007)(70206006)(81166007)(8676002)(478600001)(4326008)(316002)(54906003)(40480700001)(82740400003)(82310400005)(40460700003)(356005)(7696005)(2616005)(36756003)(5660300002)(41300700001)(16526019)(336012)(47076005)(86362001)(83380400001)(110136005)(1076003)(426003)(6666004)(186003)(26005)(8936002)(44832011)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 07:58:32.2633
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55bead9b-82e0-4f6d-9f0c-08db0e61444a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E63F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5150
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`amd_pstate_set_epp` function uses `cppc_req_cached` and `epp` variable
to update the MSR_AMD_CPPC_REQ register for AMD MSR systems. The recent
commit 7cca9a9851a5 ("cpufreq: amd-pstate: avoid uninitialized variable
use") changed the sequence of updating cppc_req_cached and writing the
MSR_AMD_CPPC_REQ. Therefore while switching from powersave to
performance governor and vice-versa in active mode MSR_AMD_CPPC_REQ is
set with the previous cached value. To fix this: first update the
`cppc_req_cached` variable and then call `amd_pstate_set_epp` function.

- Before commit 7cca9a9851a5 ("cpufreq: amd-pstate: avoid uninitialized
variable use"):

With powersave governor:
[    1.652743] amd_pstate_epp_init: writing to cppc_req_cached = 0x1eff
[    1.652744] amd_pstate_set_epp: writing cppc_req_cached = 0x1eff
[    1.652746] amd_pstate_set_epp: writing min_perf = 30, des_perf = 0, max_perf = 255, epp = 0

Changing to performance governor:
[  300.493842] amd_pstate_epp_init: writing to cppc_req_cached = 0xffff
[  300.493846] amd_pstate_set_epp: writing cppc_req_cached = 0xffff
[  300.493847] amd_pstate_set_epp: writing min_perf = 255, des_perf = 0, max_perf = 255, epp = 0

- After commit 7cca9a9851a5 ("cpufreq: amd-pstate: avoid uninitialized
variable use"):

With powersave governor:
[    1.646037] amd_pstate_set_epp: writing cppc_req_cached = 0xffff
[    1.646038] amd_pstate_set_epp: writing min_perf = 255, des_perf = 0, max_perf = 255, epp = 0
[    1.646042] amd_pstate_epp_init: writing to cppc_req_cached = 0x1eff

Changing to performance governor:
[  687.117401] amd_pstate_set_epp: writing cppc_req_cached = 0x1eff
[  687.117405] amd_pstate_set_epp: writing min_perf = 30, des_perf = 0, max_perf = 255, epp = 0
[  687.117419] amd_pstate_epp_init: writing to cppc_req_cached = 0xffff

- After this fix:

With powersave governor:
[    2.525717] amd_pstate_epp_init: writing to cppc_req_cached = 0x1eff
[    2.525720] amd_pstate_set_epp: writing cppc_req_cached = 0x1eff
[    2.525722] amd_pstate_set_epp: writing min_perf = 30, des_perf = 0, max_perf = 255, epp = 0

Changing to performance governor:
[ 3440.152468] amd_pstate_epp_init: writing to cppc_req_cached = 0xffff
[ 3440.152473] amd_pstate_set_epp: writing cppc_req_cached = 0xffff
[ 3440.152474] amd_pstate_set_epp: writing min_perf = 255, des_perf = 0, max_perf = 255, epp = 0

Fixes: 7cca9a9851a5 ("cpufreq: amd-pstate: avoid uninitialized variable use")
Signed-off-by: Wyes Karny <wyes.karny@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index b8862afef4e4..45c88894fd8e 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1057,27 +1057,28 @@ static void amd_pstate_epp_init(unsigned int cpu)
 
 	cpudata->epp_policy = cpudata->policy;
 
-	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE) {
-		epp = amd_pstate_get_epp(cpudata, value);
-		if (epp < 0)
-			goto skip_epp;
-		/* force the epp value to be zero for performance policy */
-		epp = 0;
-	} else {
-		/* Get BIOS pre-defined epp value */
-		epp = amd_pstate_get_epp(cpudata, value);
-		if (epp)
-			goto skip_epp;
+	/* Get BIOS pre-defined epp value */
+	epp = amd_pstate_get_epp(cpudata, value);
+	if (epp < 0) {
+		/**
+		 * This return value can only be negative for shared_memory
+		 * systems where EPP register read/write not supported.
+		 */
+		goto skip_epp;
 	}
+
+	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)
+		epp = 0;
+
 	/* Set initial EPP value */
 	if (boot_cpu_has(X86_FEATURE_CPPC)) {
 		value &= ~GENMASK_ULL(31, 24);
 		value |= (u64)epp << 24;
 	}
 
+	WRITE_ONCE(cpudata->cppc_req_cached, value);
 	amd_pstate_set_epp(cpudata, epp);
 skip_epp:
-	WRITE_ONCE(cpudata->cppc_req_cached, value);
 	cpufreq_cpu_put(policy);
 }
 
-- 
2.34.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EEDE6D07CC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 16:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbjC3ONj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 10:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbjC3ONh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 10:13:37 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2049.outbound.protection.outlook.com [40.107.95.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6177510F3;
        Thu, 30 Mar 2023 07:13:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=no8/vFkEShT1DlrODsdutv/cfKdaC6DK59NbW0FivukP2Usz/EQdyIx4FZ5EUMi2kNKWdTm7X9idvvvBi8pFLLm8CIhaG2Yw358EidbqsuDpLX2AQMY2DxQ/s7vSGtNDpQrLkMCcvtlszBrki/ibhwn/PjTgtb6wojY6wr4pA689GykZ4W05YaBfg8Mz2YTqBuBqBAbFFU5XYLSMLJsO3ZLYm+nxanJ8d7KUEHWvhpEekJrjd5AoKhamxpwTX68pRUkZSnFHCsr6o3xpuAoXEwTPvusO150dzbX3VeXlKJDrJ7nuSzVLh90pZ4nLCfkQbYte1A/MPw15HR4wv+e2iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6J2TrDscKltltWqslsVfweVH44pnBjX/NbaM33yhoss=;
 b=fMNn/F7aB3Qc8ryIPjjBcwWiviMOqKusfd8/po90WtXeu2IHaE63eSYJ6eF4uFfvJJEmjuJh/S6yVUBYNpJrtb66Caps3QIIjCt5nm4gxEtVnbVsLq8NM3N9CCo6GEwZ6M2jZXlBiWDZrMM3ep8uY+pBKLfjjtli6Lvr+9s2/ZADMFovjhlQAI+LBAZiIiWrgZic5AoHIopkcqygnzDXF7V8jZhYFVnTaPImn8Z/bhwXCEHrXhWesY5/Lylt0KqqkzcZoo6wCrQJuUnpp3CGJjZgLUjmTnoNli4/uqas4elfqn1T1E8kBBncvBWr0rLjXrs3oyyrGrIW/BrpQnlINw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6J2TrDscKltltWqslsVfweVH44pnBjX/NbaM33yhoss=;
 b=QNr6dGQtZfHnk0cUgoJVm7zLx4hE7zcRDAVgDHSOnBTna0gOyRhbk3mg/pUFD5fwVghMCi2qNv/Em8993X/4zw+6gO4M/q/XqKPwr0PmMIuGw8XlRZpbDOxnQBCc45meJ8leiQ+NHrR9YNJCTcrH1F+9QbdHGGPnsDEWX18AgxE=
Received: from MW4PR04CA0296.namprd04.prod.outlook.com (2603:10b6:303:89::31)
 by DS7PR12MB6261.namprd12.prod.outlook.com (2603:10b6:8:97::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Thu, 30 Mar
 2023 14:13:33 +0000
Received: from CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:89:cafe::a7) by MW4PR04CA0296.outlook.office365.com
 (2603:10b6:303:89::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Thu, 30 Mar 2023 14:13:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT046.mail.protection.outlook.com (10.13.174.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.22 via Frontend Transport; Thu, 30 Mar 2023 14:13:33 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 30 Mar
 2023 09:13:29 -0500
From:   Wyes Karny <wyes.karny@amd.com>
To:     <rafael@kernel.org>, <viresh.kumar@linaro.org>, <ray.huang@amd.com>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Wyes Karny <wyes.karny@amd.com>,
        Alexey Kardashevskiy <aik@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH] amd-pstate: Fix amd_pstate mode switch
Date:   Thu, 30 Mar 2023 14:13:14 +0000
Message-ID: <20230330141314.1364083-1-wyes.karny@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT046:EE_|DS7PR12MB6261:EE_
X-MS-Office365-Filtering-Correlation-Id: 30bc3186-53ec-40aa-b1c6-08db3128f22f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j9FAAWVpw7DVYc+43Pm20YC/4GECdLLD4oFrv7jZtoZuYDUwtOVa+XzbPtmyhbZ7ZDEpaVkn1cRVPcrj87nzsbybvmmUidaQjB07JB1R4HtxD6o48Em7BAHFQb/De/98EEydRbdFeicA01txR+JSg1q+3WvXACd3if1TbyJUQITlQU9ninuiPWBeG1Q22/qfuD3wv+wZLcbgSiqt3hVK8ffHh222Q6Ggx2l/iN5CyFRqLWpk6yfNHN8687tmzztWnlvaC7zcKxmysVg0t2y6b9I5fn3tK+l8p9qCelyLcLxGs4dJ82W0CxfjpZTgvY9zGcmUDgxoXVx+cz+7fNvI/07MGN/XNJzKCMHr0LVMvftg+07uZdpJabjWV2rMnNfvSz4rrZPC6WAzPVmM4AQcB/0VEN+Qw+hWGv3XhE7CdtRYfmxqgIuzE9eT2caLd1PRaKxDjvdv46hr7qOStn1PbmsjYJeDHc1MmC/DN9u/47KNWySF12/aWCN6KirxjvzvK+xpSDJ2l9MVjQOfY62jgNYS2/7Tfh5DdFIhb62Q19JUloqQR4m91foUucBC10pFhDefefpWMdWBbGjo/7dlHaUGEXVESYiIDpfKlb0EC2emvuvRgrhC8MvWGtQnc5+1Zfvd1mOD1zdGZSr22w64aV0EfeaYFjJjKBhTNm/cZ3WOij46+zsaLjhbL1kZjMf5RfOCDK/mNEfJjG1XNTFnp1dyqwi4pj3xvPCW07+GD14=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(396003)(376002)(346002)(451199021)(40470700004)(36840700001)(46966006)(16526019)(2906002)(5660300002)(44832011)(82310400005)(7696005)(40460700003)(316002)(8676002)(6636002)(110136005)(36756003)(70586007)(70206006)(54906003)(36860700001)(4326008)(478600001)(40480700001)(82740400003)(41300700001)(83380400001)(356005)(81166007)(2616005)(186003)(86362001)(6666004)(1076003)(26005)(8936002)(426003)(336012)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 14:13:33.3159
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30bc3186-53ec-40aa-b1c6-08db3128f22f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6261
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

amd_pstate mode can be changed by writing the mode name to the `status`
sysfs. But some combinations are not working. Fix this issue by taking
care of the edge cases.

Before the fix the mode change combination test fails:

 #./pst_test.sh
Test passed: from: disable, to
Test passed: from: disable, to disable
Test failed: 1, From mode: disable, to mode: passive
Test failed: 1, From mode: disable, to mode: active
Test failed: 1, From mode: passive, to mode: active
Test passed: from: passive, to disable
Test failed: 1, From mode: passive, to mode: passive
Test failed: 1, From mode: passive, to mode: active
Test failed: 1, From mode: active, to mode: active
Test passed: from: active, to disable
Test failed: 1, From mode: active, to mode: passive
Test failed: 1, From mode: active, to mode: active

After the fix test passes:

 #./pst_test.sh
Test passed: from: disable, to
Test passed: from: disable, to disable
Test passed: from: disable, to passive
Test passed: from: disable, to active
Test passed: from: passive, to active
Test passed: from: passive, to disable
Test passed: from: passive, to passive
Test passed: from: passive, to active
Test passed: from: active, to active
Test passed: from: active, to disable
Test passed: from: active, to passive
Test passed: from: active, to active

Fixes: abd61c08ef349 ("cpufreq: amd-pstate: add driver working mode switch support")

Acked-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Alexey Kardashevskiy <aik@amd.com>
Signed-off-by: Wyes Karny <wyes.karny@amd.com>

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Perry Yuan <Perry.Yuan@amd.com>

---
 drivers/cpufreq/amd-pstate.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 73c7643b2697..8dd46fad151e 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -840,22 +840,20 @@ static int amd_pstate_update_status(const char *buf, size_t size)
 
 	switch(mode_idx) {
 	case AMD_PSTATE_DISABLE:
-		if (!current_pstate_driver)
-			return -EINVAL;
-		if (cppc_state == AMD_PSTATE_ACTIVE)
-			return -EBUSY;
-		cpufreq_unregister_driver(current_pstate_driver);
-		amd_pstate_driver_cleanup();
+		if (current_pstate_driver) {
+			cpufreq_unregister_driver(current_pstate_driver);
+			amd_pstate_driver_cleanup();
+		}
 		break;
 	case AMD_PSTATE_PASSIVE:
 		if (current_pstate_driver) {
 			if (current_pstate_driver == &amd_pstate_driver)
 				return 0;
 			cpufreq_unregister_driver(current_pstate_driver);
-			cppc_state = AMD_PSTATE_PASSIVE;
-			current_pstate_driver = &amd_pstate_driver;
 		}
 
+		current_pstate_driver = &amd_pstate_driver;
+		cppc_state = AMD_PSTATE_PASSIVE;
 		ret = cpufreq_register_driver(current_pstate_driver);
 		break;
 	case AMD_PSTATE_ACTIVE:
@@ -863,10 +861,10 @@ static int amd_pstate_update_status(const char *buf, size_t size)
 			if (current_pstate_driver == &amd_pstate_epp_driver)
 				return 0;
 			cpufreq_unregister_driver(current_pstate_driver);
-			current_pstate_driver = &amd_pstate_epp_driver;
-			cppc_state = AMD_PSTATE_ACTIVE;
 		}
 
+		current_pstate_driver = &amd_pstate_epp_driver;
+		cppc_state = AMD_PSTATE_ACTIVE;
 		ret = cpufreq_register_driver(current_pstate_driver);
 		break;
 	default:
-- 
2.34.1


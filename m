Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A700871613F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 15:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbjE3NOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 09:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232257AbjE3NOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 09:14:12 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on20600.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::600])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C993A92;
        Tue, 30 May 2023 06:14:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VdxJ0aK1sRg1mX4iKnCcOwBkHWdh+F+DEsoHmcorT+K2z0mzlFX1hgOSRzszkZz9FlBGtNkQ2aO7qUWhXsXkkaxcthPF2nhpOJWRgR9rvsJZpAur0X2BNOWW7HXAoUoBNWGXN4k6HHNfIInzEBzMUud5FiSBovbXPdIIZt9ZV4mdCTjXymdrEIoCDnC1sJYsjSm+kjNrG/ku33A+JhUK9d8Qr4wi6+HaT4iCmuNlA0f/iaj7cp9wmLSoQmDg/yLVhGw5VV8IJ7DVHrjz+ww8g9iBlGn2SvdmsQ7FEVkp0PFRJ+0qxYGwNHCXVrBbA4GApQ56gWUbobhXQW9gc5c8jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bzR0cKvRJ+9aZlXCu9vMzM/3LW3j3cxBH8VFBkp3cbQ=;
 b=CdeVN2aUH6/2L/43jBF+dBVqj8/MZCjJ2nss6+5L10hcC/YF5yqCQU7IK4uKHEqgof8ed6NguYIsSXU5W3len8sLfb5uiyjnpm9IkWeRAOEW48pDmjZBaDtdTbFiTBOn9H50a3BucCMZOouKLqSkskcBmgOr0M6BfHzOg+PtavoMSr7N0XuXiybIBX953AwT29RhoRm3f5Zy2t4jbufeioWDqvHQsbgrOuo52s1zAALn3DFOri2pX4IcNpIMlqa2eosnHdJsOwEqIYKoNnqI6JZv2NnfuI6rRyv1OizGhuvLK/yKi6bgJQZ6b5RN6Zzqdp2EUtmOIiQDp25iaMYP7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bzR0cKvRJ+9aZlXCu9vMzM/3LW3j3cxBH8VFBkp3cbQ=;
 b=Gz7eXxP+qSHVZu/gM/bCpsIqMd2S4OmNc8v25Sjq/J6qejN9BSy7srGyzzC1xB4FEzFDcxlvSwfc4o59ow4IptHWA42TNGE2qcC95RVXkPhJNeI69su+JkbUVHkvCY6uQw2s69tEkbuehbHeJefkciV0eZPTztzYsb25rrooCJE=
Received: from MW4PR03CA0003.namprd03.prod.outlook.com (2603:10b6:303:8f::8)
 by CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Tue, 30 May
 2023 13:14:06 +0000
Received: from CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::64) by MW4PR03CA0003.outlook.office365.com
 (2603:10b6:303:8f::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23 via Frontend
 Transport; Tue, 30 May 2023 13:14:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT042.mail.protection.outlook.com (10.13.174.250) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.22 via Frontend Transport; Tue, 30 May 2023 13:14:06 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 30 May
 2023 08:14:02 -0500
From:   Wyes Karny <wyes.karny@amd.com>
To:     <ray.huang@amd.com>, <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC:     <Mario.Limonciello@amd.com>, <Perry.Yuan@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Wyes Karny <wyes.karny@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>
Subject: [PATCH v2] cpufreq/amd-pstate: Write CPPC enable bit per-socket
Date:   Tue, 30 May 2023 13:13:48 +0000
Message-ID: <20230530131348.4135-1-wyes.karny@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT042:EE_|CYYPR12MB8750:EE_
X-MS-Office365-Filtering-Correlation-Id: fbd8be1e-0981-4ed7-9d35-08db610fbf66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 11pBRTSqjQPXKeQQ14mjL5of9Zp/5QJlE4WOhmHiw9Wa+Ixa2oIQWNNfc/N+oXnqRH6nVA/zfiKLgLOnffUStabcCGWs6U5XdPPjjZQhjs1hEUPrcVDgK4/EzL0rL61J1fioupXjpS7mPNPgrEpPVREQ1gtOs7oCUpliG9W/8RqqgjirtjLa4hZKu8isu06xr128uTOcX5UxixlRkWfH1lPoS9WRyT09mC8lyGqnLAthF6GLMndDc9z+8l1WN76mboFAoHB3nWCZEK8oGeCApb+WskaX0FFdwQqKRkSf1d1SshRKHLCSQMnvNnurWW4hI0l7JRU5jPmEExLUNLzm14gBxrndKLpcF4gJCpQ2eWXsHFxP53GEwjYqo6JSD5xMdGGvCglqJmTVGW686tZZoeKGAnjOBoXy7JogOVpaO9NgdOA6HP9REETGVNIVbaP/boAtzXsXx2CAyK0qcMUwU1peTJV0rz/vmQPwHEqpBvuI030An/cBLC753Rg3oFbmpTB0EXhivH37TANdrYS9it/S/LppooNzF9yKR5aLXewVEI/wmlk80f0IAV1XG7CGZ8ZkJugSvdC3Ug/5vRPvyTSt0MmLe28xWZaQTjPCo0hyDLyfc8IVQMjh58JmkGIAYtWb4MJabZlAM/tW3J3qGvOjYRJgdf3XT+BI8FX3GIfe/w6xZPDSZjokck+7QE3WeYLWlTDRNtR1SNBWUQdvwjnoLR8MCzs9Y3C4dtVUORB7Sov1xs7GrOQbywoqxaM30k7J9/MQYrinwV9r1Q+dbkNFsge1j9bwQmwcROGAGEA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(346002)(136003)(451199021)(46966006)(40470700004)(36840700001)(356005)(1076003)(316002)(82310400005)(44832011)(81166007)(186003)(16526019)(7696005)(40480700001)(82740400003)(8676002)(8936002)(41300700001)(40460700003)(6666004)(26005)(5660300002)(47076005)(83380400001)(36756003)(36860700001)(4326008)(70206006)(70586007)(110136005)(54906003)(2906002)(2616005)(86362001)(336012)(478600001)(426003)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 13:14:06.5227
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbd8be1e-0981-4ed7-9d35-08db610fbf66
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8750
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently amd_pstate sets CPPC enable bit in MSR_AMD_CPPC_ENABLE only
for the CPU where the module_init happened. But MSR_AMD_CPPC_ENABLE is
per-socket. This causes CPPC enable bit to set for only one socket for
servers with more than one physical packages. To fix this write
MSR_AMD_CPPC_ENABLE per-socket.

Also, handle duplicate calls for cppc_enable, because it's called from
per-policy/per-core callbacks and can result in duplicate MSR writes.

Before the fix:
amd@amd:~$ sudo rdmsr -a 0xc00102b1 | uniq --count
	192 0
    192 1

After the fix:
amd@amd:~$ sudo rdmsr -a 0xc00102b1 | uniq --count
    384 1

Suggested-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Wyes Karny <wyes.karny@amd.com>
---
v1 -> v2:
- Made CPPC enable read/write per-socket

 drivers/cpufreq/amd-pstate.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 5a3d4aa0f45a..45b9e359f638 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -63,6 +63,7 @@ static struct cpufreq_driver *current_pstate_driver;
 static struct cpufreq_driver amd_pstate_driver;
 static struct cpufreq_driver amd_pstate_epp_driver;
 static int cppc_state = AMD_PSTATE_DISABLE;
+static bool cppc_enabled;
 
 /*
  * AMD Energy Preference Performance (EPP)
@@ -228,7 +229,28 @@ static int amd_pstate_set_energy_pref_index(struct amd_cpudata *cpudata,
 
 static inline int pstate_enable(bool enable)
 {
-	return wrmsrl_safe(MSR_AMD_CPPC_ENABLE, enable);
+	int ret, cpu;
+	unsigned long logical_proc_id_mask = 0;
+
+	if (enable == cppc_enabled)
+		return 0;
+
+	for_each_present_cpu(cpu) {
+		unsigned long logical_id = topology_logical_die_id(cpu);
+
+		if (test_bit(logical_id, &logical_proc_id_mask))
+			continue;
+
+		set_bit(logical_id, &logical_proc_id_mask);
+
+		ret = wrmsrl_safe_on_cpu(cpu, MSR_AMD_CPPC_ENABLE,
+				enable);
+		if (ret)
+			return ret;
+	}
+
+	cppc_enabled = enable;
+	return 0;
 }
 
 static int cppc_enable(bool enable)
@@ -236,6 +258,9 @@ static int cppc_enable(bool enable)
 	int cpu, ret = 0;
 	struct cppc_perf_ctrls perf_ctrls;
 
+	if (enable == cppc_enabled)
+		return 0;
+
 	for_each_present_cpu(cpu) {
 		ret = cppc_set_enable(cpu, enable);
 		if (ret)
@@ -251,6 +276,7 @@ static int cppc_enable(bool enable)
 		}
 	}
 
+	cppc_enabled = enable;
 	return ret;
 }
 
-- 
2.34.1


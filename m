Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5770722A9B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 17:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234745AbjFEPN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 11:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233071AbjFEPNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 11:13:11 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2070.outbound.protection.outlook.com [40.107.101.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0194CE8;
        Mon,  5 Jun 2023 08:12:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YYU8TQdtODqQI75lRA7JqdoIfFdnuioavtgCbyP7bzUoEwZB46Zj41B8wU1AGe1aL+yosczzA3ah3AKOjr3atPVQiwzpDy/oiQEOE1Bm4dgjZp/DxCGpWyM8I/1FgqLjteZSBj9uzOKXA8KGPNd5gel+Z5kyYzWM9VT92D0h3AU4q4G7bu/cybATYPV2TUQbg+Lm3u5wez962ANV/MkshqKtZCoRPlrdkEcexZmZng3wJfIn3YfRibMvxHb9jFtSXzvC8mkfH+CIl+LPMISg3RR1H7aC+qSoJ+RQvMVy3sFghoYBqGSxEq3tFH8Tt2yZa0akcKUvQpCiijuCWEdV/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ChaQ9lNPtNyKNnZV71xB2tlKUgQQktowOWEwvfHQxDQ=;
 b=iQEyaK5VEC/UQ2dmNZsjf5trCJ+94qJBa9+gZ+6O7QBuXWLYMBmiIJDmPYvW/TPbTqmjC8KFYxU0sGfP0D01UqngKWPCy/aLHDTfmKNJ4TTg1BYew5ZYh2VS8vqLlXOtTnXe55wzbaK6PdZWAyPAL2w4JKEsx9VUYFxlJ0qXkI49cHi2ScOD4LlEURE1pnUwol5CixTxCEyoxkZqM6zBqf4C71Iw3Xuz7UW/GTzq6KO5NE2oBdGwwuMksn6UY0MzEl3ClRRzNWSsEjXNGP1vBvrbfctfHxrAtaR6UI254HZ4nSS6AfaposJPVks2gRHdiwQMJOuf7sFsUVqN8URD7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ChaQ9lNPtNyKNnZV71xB2tlKUgQQktowOWEwvfHQxDQ=;
 b=z0ywWqvV1XamHcfFkKNoL12SZ3U/Dm4u+yJvIoJuuO6SzOzkRBf+bbrQjed5wLmPPtBL+5UPM5FaaFaZQY8aVqzFqcxvbBrDojWy0VGL9xfDLpgkfs0QEQf8954A3e+V7E1m1Scyur2NZ9RHXKJX6Uz7GmINJ03o34kivUzcuEA=
Received: from BN0PR10CA0025.namprd10.prod.outlook.com (2603:10b6:408:143::22)
 by LV3PR12MB9117.namprd12.prod.outlook.com (2603:10b6:408:195::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 15:12:06 +0000
Received: from BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:143:cafe::cc) by BN0PR10CA0025.outlook.office365.com
 (2603:10b6:408:143::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Mon, 5 Jun 2023 15:12:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT007.mail.protection.outlook.com (10.13.177.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.33 via Frontend Transport; Mon, 5 Jun 2023 15:12:06 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 5 Jun
 2023 10:12:05 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Huang Rui <ray.huang@amd.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
CC:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Robert Moore <robert.moore@intel.com>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devel@acpica.org>,
        Gautham Ranjal Shenoy <gautham.shenoy@amd.com>,
        "Wyes Karny" <Wyes.Karny@amd.com>, Perry Yuan <perry.yuan@amd.com>,
        "Mario Limonciello" <mario.limonciello@amd.com>
Subject: [PATCH 2/4] cpufreq: amd-pstate: Set a fallback policy based on preferred_profile
Date:   Mon, 5 Jun 2023 10:11:31 -0500
Message-ID: <20230605151133.2615-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230605151133.2615-1-mario.limonciello@amd.com>
References: <20230605151133.2615-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT007:EE_|LV3PR12MB9117:EE_
X-MS-Office365-Filtering-Correlation-Id: 50eba676-5bee-4bf9-ec79-08db65d739e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: usBS75djn7c3byEiLIEfHBeOZ3Nj6jsAIc44AUFg4Nt1oWk50Trw3jjv3VihqXiBfPXAIW0AcB/y3nCv9B4VzKGCW9VkSE5ljnZe+WOCPsrUsBsn6oiILVgORG8CRjakX2t+/Wx0dxsBPCIUkqQ4TN4UqvOl6/lsh5j1RBW8LsB2Rz8GS8m/H1By+UUj3YhW/FGgF+egqT+Ez0HyZY7HK+t/SNz+Jbs90JxPxmplqsQJPPVymzEndXE+1iOBXSu5QhRrCa6xX0AcQRrMUtJBCGuo5ABsoPFhR8Et2Wt7HEtAlx/47qUbJr/2/OWoR3Kv1gyJl2Azn3q4kAwrB2Y3mfQzJI93iFCoOlS9xNCaZMOq97DblUSGu6DQ7Uokqgk65gcBoEKbd5R394JipGKl8nUKQ3Uip0rS0Nr8M0D5vzJ22v2oWcG/G9tmNW9CP04lDOoqxJ8CzZk/FAHbuBTmPQ/097HRvYc9F2BQ5WAJv1PawOvPUxvIXtks8PbH6kITAfmaBYTVUDPc18zTQ6UuGhAQwcPfmLu1mJss2hqobI5+8qVgY/0pHKw+Pzl+0EhoFGNm5QUtu3yLJruIAGk6mQbyC3fSp68FJtpLGcjxVbzVqIuB4nJ33u0AyzwdrQviD7FoLtlvlhkeV+9tN75XscNZ2ILVmLS2OE0WmhrIdMbCTV78LBIfqNVOlJ+pqCK1lURUE1nOra1rwYOrfqofelFumynr7sTHgtMV3XD41xTgIkdPp4/wbP0jH+mfTKG8qVvJK+b7AXCaI2PBgRaVXw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(396003)(346002)(136003)(451199021)(46966006)(40470700004)(36840700001)(70586007)(70206006)(2906002)(478600001)(316002)(4326008)(8936002)(8676002)(41300700001)(54906003)(110136005)(44832011)(5660300002)(6666004)(7696005)(40460700003)(1076003)(26005)(966005)(16526019)(82740400003)(356005)(2616005)(40480700001)(186003)(47076005)(83380400001)(426003)(336012)(81166007)(36860700001)(36756003)(82310400005)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 15:12:06.6357
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50eba676-5bee-4bf9-ec79-08db65d739e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9117
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a user's configuration doesn't explicitly specify the cpufreq
scaling governor then the code currently explicitly falls back to
'powersave'. This default is fine for notebooks and desktops, but
servers and undefined machines should default to 'performance'.

Look at the 'preferred_profile' field from the FADT to set this
policy accordingly.

Link: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/05_ACPI_Software_Programming_Model/ACPI_Software_Programming_Model.html#fixed-acpi-description-table-fadt
Suggested-by: Wyes Karny <Wyes.Karny@amd.com>
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index ddd346a239e0..c9d296ebf81e 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1102,10 +1102,13 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 	policy->max = policy->cpuinfo.max_freq;
 
 	/*
-	 * Set the policy to powersave to provide a valid fallback value in case
+	 * Set the policy to provide a valid fallback value in case
 	 * the default cpufreq governor is neither powersave nor performance.
 	 */
-	policy->policy = CPUFREQ_POLICY_POWERSAVE;
+	if (acpi_pm_profile_server() || acpi_pm_profile_undefined())
+		policy->policy = CPUFREQ_POLICY_PERFORMANCE;
+	else
+		policy->policy = CPUFREQ_POLICY_POWERSAVE;
 
 	if (boot_cpu_has(X86_FEATURE_CPPC)) {
 		ret = rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, &value);
-- 
2.34.1


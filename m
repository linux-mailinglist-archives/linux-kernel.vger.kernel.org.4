Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 852D1655DAC
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Dec 2022 17:35:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbiLYQfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Dec 2022 11:35:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbiLYQfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Dec 2022 11:35:17 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65BD460DB;
        Sun, 25 Dec 2022 08:35:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J2H75r2KtKyRjTMT4QnTzNKY6uDnD6SdRvjUPlZ54hxdeDJkPO7uK4pbRFQT2ol9XADvhiFkl8TX5sqzs2fEyMhATPg7Pt9rI1Akemxix4nDm8BzN/pCGNCuu/Cpu5gUBLP1zuvAjrVw5pEGhhudq5kVHBOY4BweK8I5tS4KDNlN5Xs/+GSY7S468jp5CEYePIFShDQZhuAsKI0OLCKFWta441Tl9ROBxQzRBsRQ1e+nNbBpyouq5gSQtDsbbiggXK6eVgHcDGCfs04LPgfzWVVBDwjjG+r8xOqn1NZOkYHllgeenzKJ4D1VgXUNEnYXHlPM5cw7Gi6wYmqyrUzzgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R3amnQ77wK2Km0IPoODW0UP0G0LauRLRJr69Hwml7CU=;
 b=gjbvcO2R3kSYIOAMR5MZIFWyvo74bobGAxHMNcraetFr/OJFfeH/DBkTNj1vReaBe0/+dR2Gg7XoZE3bMGW+TDEyK9Zmpj7fymOfygwJ4NYe1FEmlzzqSTIljbD0j6lpj+seqQQFKXtuG8rM5WdnKsZccXjfd0Br2XQQX59zSD9aMOF0pnQxQnYpjIHcVA/xGy10aEZpz7nhz5/wgTP1sCd4FqAdTE31kJowVC0kDhaYgRDGxqqu2mc2ixo7U0wI082IQHR1A95R1MuvI6741iXvs29P5TYA8hdBrfg6vYdOLg3dEUx3Uk9oWmQD7OK2o4YV2gC+7g4RtidhpPEodw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R3amnQ77wK2Km0IPoODW0UP0G0LauRLRJr69Hwml7CU=;
 b=pC5zYjHZ4hzFYGawvzKJBSucLK/sFs2g41D0wUaVoynxwqf7fmAy4yvjZhQKzj3xzZFZaNXyOY4hsOO8PnQNlQUO1rQ05rEDt6beCqGuIwlQNpfo2Om1z0HZk5MEKj/Na6B5+VYXqlgVVkACJ2Odt1fqIn3DV8JCjtIb8sWLqg8=
Received: from MW4PR03CA0253.namprd03.prod.outlook.com (2603:10b6:303:b4::18)
 by MW3PR12MB4380.namprd12.prod.outlook.com (2603:10b6:303:5a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.14; Sun, 25 Dec
 2022 16:35:11 +0000
Received: from CO1NAM11FT093.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b4:cafe::41) by MW4PR03CA0253.outlook.office365.com
 (2603:10b6:303:b4::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.15 via Frontend
 Transport; Sun, 25 Dec 2022 16:35:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT093.mail.protection.outlook.com (10.13.175.59) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.16 via Frontend Transport; Sun, 25 Dec 2022 16:35:10 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sun, 25 Dec 2022 10:35:06 -0600
From:   Perry Yuan <perry.yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
        <ray.huang@amd.com>, <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Nathan.Fontenot@amd.com>,
        <Alexander.Deucher@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <wyes.karny@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v9 03/13] cpufreq: intel_pstate: use common macro definition for Energy Preference Performance(EPP)
Date:   Mon, 26 Dec 2022 00:34:32 +0800
Message-ID: <20221225163442.2205660-4-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221225163442.2205660-1-perry.yuan@amd.com>
References: <20221225163442.2205660-1-perry.yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT093:EE_|MW3PR12MB4380:EE_
X-MS-Office365-Filtering-Correlation-Id: 90f3a39e-0ea1-4240-d2a4-08dae695fdf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nL5zGS3aSaVCe2wGyrMOVv1bF62R+hEcFPfkhNdQnJOUY6W/OyQ+m42M+GFJ5zNzDmmaxfJ8drmt3jbu/WMjmpF3HKrN2h5b5uacuzM8VojQeJZtAx8H1SgY51MyoBTEC6B+VqEHGnCgHRZ+ToNgmNIwcIW+QrJKqJWEi2sWvWYtJOWZiREFUN4WYXhyLXVUWfZT6cqTxT69EAcni13gGrCcxG8EaMSTXhXjXgPhyZwqbXuhoPkKPW0Y1Fi4Bo9K9psLlYbaAsKA4HoHETm0FlpaZzO470wLTzV4fk+77tis0zfOmLJ2LwcWEnpWU1uRxIfD9CLcoBTkcF0GTJE8kdkLFO0GhrFJj2a709jgGjk/ZiIO66n7MS+BgHAlnCF6Svb4wkPzhRLteMzxNjDpaPIQoMypKQ4zKCfFGhHwAtWxHa4MovRgqk1f3n/Jtqcu9erwp87+SAHtOEaVG84P1ljQUsfDKMOB16wirRj4Qim+W0lsbbrgRKiyHfUdg9VFSNeZMRv9GfpAxH9GDPY7vWCMK/VqzoMw+JFPwqNnjKLPP+5thhWZtTFzWXaJiBPL7QAe/cMCWgKJSlrfcIYDPAcAGh2nkL3QCylxJnaFu2pIeozt/BWZb7u7ex5cl/u1QIvhCeBnGLepDBqPZLrrtW4FJwhQlq58X62UnNWOHIocYXt86c6dbyo/uR7BDgiOfxqUz07T//1DLxbM0qqbJeq8K2HxesepnAs4AToWZAQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(39860400002)(396003)(346002)(451199015)(40470700004)(46966006)(36840700001)(36756003)(82740400003)(81166007)(356005)(5660300002)(2906002)(70586007)(70206006)(4326008)(8676002)(44832011)(40460700003)(86362001)(83380400001)(36860700001)(316002)(478600001)(336012)(2616005)(54906003)(110136005)(1076003)(41300700001)(40480700001)(8936002)(82310400005)(7696005)(426003)(26005)(6666004)(47076005)(186003)(16526019)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Dec 2022 16:35:10.9561
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90f3a39e-0ea1-4240-d2a4-08dae695fdf0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT093.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4380
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

make the energy preference performance strings and profiles using one
common header for intel_pstate driver, then the amd_pstate epp driver can
use the common header as well. This will simpify the intel_pstate and
amd_pstate driver.

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 drivers/cpufreq/Kconfig.x86    |  2 +-
 drivers/cpufreq/intel_pstate.c | 13 +++----------
 include/linux/cpufreq.h        | 10 ++++++++++
 3 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/cpufreq/Kconfig.x86 b/drivers/cpufreq/Kconfig.x86
index 00476e94db90..f64aef1e093d 100644
--- a/drivers/cpufreq/Kconfig.x86
+++ b/drivers/cpufreq/Kconfig.x86
@@ -36,7 +36,7 @@ config X86_PCC_CPUFREQ
 
 config X86_AMD_PSTATE
 	bool "AMD Processor P-State driver"
-	depends on X86 && ACPI
+	depends on X86 && ACPI && X86_INTEL_PSTATE
 	select ACPI_PROCESSOR
 	select ACPI_CPPC_LIB if X86_64
 	select CPU_FREQ_GOV_SCHEDUTIL if SMP
diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index ad9be31753b6..93a60fdac0fc 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -640,15 +640,7 @@ static int intel_pstate_set_epb(int cpu, s16 pref)
  *	4		power
  */
 
-enum energy_perf_value_index {
-	EPP_INDEX_DEFAULT = 0,
-	EPP_INDEX_PERFORMANCE,
-	EPP_INDEX_BALANCE_PERFORMANCE,
-	EPP_INDEX_BALANCE_POWERSAVE,
-	EPP_INDEX_POWERSAVE,
-};
-
-static const char * const energy_perf_strings[] = {
+const char * const energy_perf_strings[] = {
 	[EPP_INDEX_DEFAULT] = "default",
 	[EPP_INDEX_PERFORMANCE] = "performance",
 	[EPP_INDEX_BALANCE_PERFORMANCE] = "balance_performance",
@@ -656,7 +648,8 @@ static const char * const energy_perf_strings[] = {
 	[EPP_INDEX_POWERSAVE] = "power",
 	NULL
 };
-static unsigned int epp_values[] = {
+
+unsigned int epp_values[] = {
 	[EPP_INDEX_DEFAULT] = 0, /* Unused index */
 	[EPP_INDEX_PERFORMANCE] = HWP_EPP_PERFORMANCE,
 	[EPP_INDEX_BALANCE_PERFORMANCE] = HWP_EPP_BALANCE_PERFORMANCE,
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index d5595d57f4e5..0693269fb775 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -185,6 +185,16 @@ struct cpufreq_freqs {
 	u8 flags;		/* flags of cpufreq_driver, see below. */
 };
 
+enum energy_perf_value_index {
+	EPP_INDEX_DEFAULT = 0,
+	EPP_INDEX_PERFORMANCE,
+	EPP_INDEX_BALANCE_PERFORMANCE,
+	EPP_INDEX_BALANCE_POWERSAVE,
+	EPP_INDEX_POWERSAVE,
+};
+extern const char * const energy_perf_strings[];
+extern unsigned int epp_values[];
+
 /* Only for ACPI */
 #define CPUFREQ_SHARED_TYPE_NONE (0) /* None */
 #define CPUFREQ_SHARED_TYPE_HW	 (1) /* HW does needed coordination */
-- 
2.34.1


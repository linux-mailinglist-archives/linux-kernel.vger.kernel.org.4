Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0136A733C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 19:16:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjCASQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 13:16:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjCASQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 13:16:27 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B1743445;
        Wed,  1 Mar 2023 10:16:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hbMcAd3aeGm5YWnc2+diL0n8I2CH5hxo7a69ek+KfkYPsQofrfql8RQ3B5mStTK2gBKdI/CpT+ocqPpROD2HIVjyzeKKGJeUALsFjY5mQGeWPPdoWR5MMlYsyjFkMwsxZnMcBMcd2k0aEPBNMy2JV/YjlhCvdt6ofHkU1lBQqKplAym2pkm5x6Oh999JWDakqD1QeijL8IqNTZr0liM1Iqr93bWRo/TAvMJvfZDZdZCSgdu4V2mUnkCFKxM6e4miDkaM6/+vMMn4S/bBYvIKQGdlGXZ8lKoAAglodeW2KQ1oFeSq+Y1TeiETdNIXOLNOTJn8Ovw23xRodqKM1sZHYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T3o/qoUInNSxVUYYtI8F7Y8C992qe2rcnQwnoGv0gjU=;
 b=JT4d98AByt6gRlyOmnA4eKVNp+6mZrbYpTgzdCmhVeTEIPOdHyPdrXBAvAfiDuQxSqf2td9jxLWliYQ//0no9Ew5l/lxDHKw9msLkMhOXplQAioGKvbSpur0EiAA/fVa5h7YUVK/XZrbiqt/u5TuAQb8RQ19/IYHTK7m0DVz2QOANB/sV99BJkxpsU786R6U3cshksR+guyCwXGDJcf7GJ4NNa4reMXta0nHlCYNoJ53Ac+0X+iWgAFLQkpD36k5AhT+b/Sk3U2pJ+9M0RN1v0Y1Tz8g9CShvO2Nv3zBOt2pEhZrG6TeegRU526LGMMWE8dQooGLW09ZzaLYKMl4VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T3o/qoUInNSxVUYYtI8F7Y8C992qe2rcnQwnoGv0gjU=;
 b=WPcwuUrfer8eTUWiUJRgjq7EvWwUmgSMLuOQaCQwbo8dpoY8shATDUkDbTn3kzsWJaEySvqJnRXofxpaV9OgCwy6piJRLKiTcpBx0ovEQqNXQORl/rLSE4ciUzaNZ0kILLwJXNUlzEI0Ptx47D7OCzh4e0M8Nl+KFg8UiOdnoQI=
Received: from DM6PR11CA0041.namprd11.prod.outlook.com (2603:10b6:5:14c::18)
 by DS7PR12MB6045.namprd12.prod.outlook.com (2603:10b6:8:86::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.21; Wed, 1 Mar
 2023 18:16:22 +0000
Received: from DS1PEPF0000E651.namprd02.prod.outlook.com
 (2603:10b6:5:14c:cafe::26) by DM6PR11CA0041.outlook.office365.com
 (2603:10b6:5:14c::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30 via Frontend
 Transport; Wed, 1 Mar 2023 18:16:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E651.mail.protection.outlook.com (10.167.18.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.12 via Frontend Transport; Wed, 1 Mar 2023 18:16:22 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 1 Mar
 2023 12:16:16 -0600
From:   Wyes Karny <wyes.karny@amd.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        "Namhyung Kim" <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Borislav Petkov" <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <hpa@zytor.com>,
        Stephane Eranian <eranian@google.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>
CC:     <x86@kernel.org>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <gautham.shenoy@amd.com>,
        <ananth.narayan@amd.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Wyes Karny <wyes.karny@amd.com>
Subject: [RFC PATCH v2 2/2] perf/x86/rapl: Enable Core RAPL for AMD
Date:   Wed, 1 Mar 2023 18:14:49 +0000
Message-ID: <20230301181449.14647-3-wyes.karny@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230301181449.14647-1-wyes.karny@amd.com>
References: <20230301181449.14647-1-wyes.karny@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E651:EE_|DS7PR12MB6045:EE_
X-MS-Office365-Filtering-Correlation-Id: 0af1d1ac-52e1-41c4-2e7c-08db1a811018
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iyWHD8RgcBFO9s97LOdrDQEjnemOfP6j1ETAkrlmAen39J5b2ZEu20ym3jLr9eOYD7ij4u/xq3IRvS6Si3Tkp13+4No/GLiFljYt5N07BueDOHAfcHoV25bTRVM5nPHrUglIs/FuYL7T84IEcZ/dLMeuwP1WAic3SuBa/1djY8dgS1P4SuVehmg0ZbFIGcQ9+pkz9iZ45ogOvEVmw7NENTprd65ROiK4wzbp715+CS4SnSyZzn+OPN7Zm1RHI22RL7SsAQADtSsI2swtyEKI9oBABYytLMFzaOVDobGvqnBcWhmxwYrGz3DI5802/xDFnpGdQwGF8dulR/MQvmPGml6vLc56yAI++j2wWvsKfb/27zL8uTL2aJv8MCBpPSfkdFZBsMLcfnfdOihSMMnNezQOPseZZgbiMKZVcHvQ5ecQwXlK7IufuQNOK36yNwKNx7d+s/UY4FzF83ta/zrP+2LjFtb9dA2a6s8J6WLUidOUp6tydJkcg8fT4/KR9Uw5cAoFXboHj/xd5xp2tlHBUpXqTKnUDXoGXTyWo/UySx3X3djWMIOEnv2rXYomXsoaAfkLdtj5UvGJDC5K8f6lqM22ZP8Lhqu8Kdm7xBihmXaCCQGrZ5PjyBO+ChMInl5noxTrUX7GJilVRL9vAm0m4dVdzzvK7+XKier4WllY+NjRFwfhgxgz1YJ139hpScdJOHyRxwvIK+TfyV2Z/UMRBDDFsyWld5pNTcfJtOKlaQeWPQ8xr3RgP0dTo2voVdzx
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(376002)(39860400002)(396003)(451199018)(36840700001)(40470700004)(46966006)(478600001)(336012)(40460700003)(70206006)(70586007)(83380400001)(5660300002)(110136005)(1076003)(54906003)(8936002)(8676002)(2616005)(41300700001)(16526019)(4326008)(26005)(426003)(6666004)(7696005)(82310400005)(186003)(356005)(47076005)(921005)(316002)(40480700001)(36756003)(82740400003)(36860700001)(7416002)(2906002)(44832011)(81166007)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 18:16:22.4462
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0af1d1ac-52e1-41c4-2e7c-08db1a811018
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E651.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6045
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMD processors support per-package and per-core energy monitoring
through RAPL counters which can be accessed by users running in
supervisor mode.

Core RAPL counters gives power consumption information per core.  For
AMD processors the package level RAPL counter are already exposed to
perf. Expose the core level RAPL counters also.

sudo perf stat -a --per-core -C 0-127 -e power/energy-cores/

Output:
S0-D0-C0           2               8.73 Joules power/energy-cores/
S0-D0-C1           2               8.73 Joules power/energy-cores/
S0-D0-C2           2               8.73 Joules power/energy-cores/
S0-D0-C3           2               8.73 Joules power/energy-cores/
S0-D0-C4           2               8.73 Joules power/energy-cores/

Signed-off-by: Wyes Karny <wyes.karny@amd.com>
---
 arch/x86/events/rapl.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index e6a0c077daf5..9cce8e590cc4 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -546,7 +546,7 @@ static struct perf_msr intel_rapl_spr_msrs[] = {
  * - want to use same event codes across both architectures
  */
 static struct perf_msr amd_rapl_msrs[] = {
-	[PERF_RAPL_PP0]  = { 0, &rapl_events_cores_group, 0, false, 0 },
+	[PERF_RAPL_PP0]  = { MSR_AMD_CORE_ENERGY_STATUS, &rapl_events_cores_group, test_msr, false, RAPL_MSR_MASK },
 	[PERF_RAPL_PKG]  = { MSR_AMD_PKG_ENERGY_STATUS,  &rapl_events_pkg_group,   test_msr, false, RAPL_MSR_MASK },
 	[PERF_RAPL_RAM]  = { 0, &rapl_events_ram_group,   0, false, 0 },
 	[PERF_RAPL_PP1]  = { 0, &rapl_events_gpu_group,   0, false, 0 },
@@ -773,7 +773,8 @@ static struct rapl_model model_spr = {
 };
 
 static struct rapl_model model_amd_hygon = {
-	.events		= BIT(PERF_RAPL_PKG),
+	.events		= BIT(PERF_RAPL_PP0) |
+			  BIT(PERF_RAPL_PKG),
 	.msr_power_unit = MSR_AMD_RAPL_POWER_UNIT,
 	.rapl_msrs      = amd_rapl_msrs,
 };
-- 
2.34.1


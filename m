Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF116248DC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 18:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbiKJR7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 12:59:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbiKJR72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 12:59:28 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2066.outbound.protection.outlook.com [40.107.96.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7585045ED7;
        Thu, 10 Nov 2022 09:59:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IRZreHG+ORThdqKZDli3aJ3IaGztcJlPnFXGNmZSS3VJHGe9MEexxI2oxk7aHybsS0LqLwn5n2EZoScu04MgKp6YnnTFqF63EhMLofF3nCuotGNy/uF8o+UU1YrbhDeqCL6eGegk5OweFKaBBonluQCiRRmPIViGeYyvm+MLC+uYc38xJX/iY1oMrXQi9kYRhh55KFO/E6EqAZBNQUVx36PnpLCHtXv6KrR1EuWhSW6mpuOU2VivaqoKwWkxBrEcOvCnnZSRnYvCsmHtg03jUlINt2UCdK6RAPp0QALXbuEVJf5skE6WYnedUiQK8UhUhY6tv8e0Brx2AJdW44USsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hPT0UmJdFUfvE2v/nVV6GqC34565KJP4VI/WPmG7sMA=;
 b=UGKmypoodukrA1Rwz4r4TF5iCTGy2sGbYfA/uvEadOISIusAYASbgXG8LxGvkaaG6cU969lxtB/MoQg5WQ6Hrn95iTRkxIeXq9bfBRrpcfclyzGayAVy1+rcx2G0wNq+kDKe0djSiXpXCZjKrrQQujAH4kTq1V5t40lnPAlzRh/qW3mYkFHsqhXatnzdwUfmDix9YcFhA5Deudwg5AMCoEJPXt9EsNqAqfcSYiPuS42kEflG8OaeIwAE5FiL/l9YimqgB9z6CqSeyFqHCC8cZb7CaJehhH1NBDjytNPaRrCh3rBiVAY2j4qxiWtqN/fDoZJ/LgkPtFS3ww+Fwm8gdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hPT0UmJdFUfvE2v/nVV6GqC34565KJP4VI/WPmG7sMA=;
 b=QiKtDVlxeKnt/nvSRSsJNS6YRzkoMMtoe0rC3bYa+XzjKWlPFoeBw5SYfMa6xoztLV6iNQkTwXK3VYukdQjjDKnc/Vp6xAKP2IVWqLIA8StscFr00l3verYYVVCnHCxAh2vrtL4wn3OdUOd/89qm7lgRRST5Jv9KkSyc+fakCjI=
Received: from BN9PR03CA0053.namprd03.prod.outlook.com (2603:10b6:408:fb::28)
 by IA1PR12MB7517.namprd12.prod.outlook.com (2603:10b6:208:41a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.12; Thu, 10 Nov
 2022 17:59:23 +0000
Received: from BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fb:cafe::2f) by BN9PR03CA0053.outlook.office365.com
 (2603:10b6:408:fb::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13 via Frontend
 Transport; Thu, 10 Nov 2022 17:59:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT017.mail.protection.outlook.com (10.13.177.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.12 via Frontend Transport; Thu, 10 Nov 2022 17:59:23 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 10 Nov 2022 11:59:19 -0600
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
        <ray.huang@amd.com>, <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Nathan.Fontenot@amd.com>,
        <Alexander.Deucher@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <wyes.karny@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v4 3/9] cpufreq: amd-pstate: change amd-pstate driver to be built-in type
Date:   Fri, 11 Nov 2022 01:58:41 +0800
Message-ID: <20221110175847.3098728-4-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221110175847.3098728-1-Perry.Yuan@amd.com>
References: <20221110175847.3098728-1-Perry.Yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT017:EE_|IA1PR12MB7517:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ded03ca-a9c8-4d9b-d0a9-08dac3454ca6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U0+VArbQF1KcnPz4a9f4rKRBSppdIbuYoSk1X4jvykIDso94z2oWhwaVXBUGqqnsrQIeGcWlW2bgWNAB71J1ulsYgRlBjjOWfZj3mWrh4uspMpEnZ7jOMCx+y2UJad2AlahyItw5y2n91PqZs1k/JQa/2yttvpNxvUpQUS1PMqYb8pFAEN1MbvZ/lsWEuxS/V1lRq7H+/GcbNKWPFS9WTvC4UVWjjAOjRdfoc4EgK1sSw34FZwpaQHgR6F6gqySpO77J1b7iZJN+woPLWnKXPA9PyRuySdpFPntKhV0lfLamWxI+C7wUZCcjuHtLGcqRyREBZTV1+8TG583OROkz55WDS1SNFL6QNdBs0GKfb2vGem9p1FQYSaTn75PRpap2aGfNmRIbxjvKNH48F4HnMN8kMVpoF/nMH9ja+FcNSsc0S5C4abfQxrscd0DVZiE6DfPTR//Ffxvq1emysH7i/zA+uercHnKIMgx+/YhJOz0+tFxTmVVxiEnHvb7NF8C8Kn71iW6fdfz8HfO2S5/9JRJ9/WVlv6Xo4iaOT0dtvTMPWlWXp4OCtXiMjeaBg7lCePjrztCm+31urteqnCksvLxRdCYHbYoZ8uz2Kza5aIPcpWmpZdvakXGWw2kd1GLzoK96vfeIdCQkfD4/2EGMX4KnJQWQAOXmp+Uh7TVqpJKfIpo+2v8IQvuooglsa+WM2LJTP9eW0wd9k5Hk0UQDuPjfnWiXS193+lzbWOhErayy7YITsfzDyzdtVYMUQFJh+aEFJiwAGhlwyDQhtDK/CH+EFKtvfPUq2ti4/h1MoJGdZSLrJUPCO2mWyiTjW+6t
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(136003)(346002)(376002)(451199015)(40470700004)(36840700001)(46966006)(82740400003)(336012)(7696005)(70206006)(36860700001)(8676002)(186003)(2906002)(40460700003)(5660300002)(83380400001)(47076005)(40480700001)(426003)(70586007)(8936002)(86362001)(26005)(4326008)(41300700001)(2616005)(36756003)(1076003)(16526019)(316002)(82310400005)(356005)(478600001)(54906003)(110136005)(6666004)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 17:59:23.2194
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ded03ca-a9c8-4d9b-d0a9-08dac3454ca6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7517
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the `amd-pstate` driver as the built-in type which can help to
load the driver before the acpi_cpufreq driver as the default pstate
driver for the AMD processors.

for the processors do not have the dedicated MSR functions, add
`amd-pstate=legacy_cppc` to grub which enable shared memory interface
to communicate with cppc_acpi module to control pstate hints.

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/cpufreq/Kconfig.x86  |  2 +-
 drivers/cpufreq/amd-pstate.c | 25 +++++++++++++++----------
 2 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/cpufreq/Kconfig.x86 b/drivers/cpufreq/Kconfig.x86
index 310779b07daf..00476e94db90 100644
--- a/drivers/cpufreq/Kconfig.x86
+++ b/drivers/cpufreq/Kconfig.x86
@@ -35,7 +35,7 @@ config X86_PCC_CPUFREQ
 	  If in doubt, say N.
 
 config X86_AMD_PSTATE
-	tristate "AMD Processor P-State driver"
+	bool "AMD Processor P-State driver"
 	depends on X86 && ACPI
 	select ACPI_PROCESSOR
 	select ACPI_CPPC_LIB if X86_64
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index ace7d50cf2ac..85a0b3fb56c2 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -59,10 +59,7 @@
  * we disable it by default to go acpi-cpufreq on these processors and add a
  * module parameter to be able to enable it manually for debugging.
  */
-static bool shared_mem = false;
-module_param(shared_mem, bool, 0444);
-MODULE_PARM_DESC(shared_mem,
-		 "enable amd-pstate on processors with shared memory solution (false = disabled (default), true = enabled)");
+static bool shared_mem __read_mostly;
 
 static struct cpufreq_driver amd_pstate_driver;
 
@@ -653,16 +650,24 @@ static int __init amd_pstate_init(void)
 
 	return ret;
 }
+device_initcall(amd_pstate_init);
 
-static void __exit amd_pstate_exit(void)
+static int __init amd_pstate_param(char *str)
 {
-	cpufreq_unregister_driver(&amd_pstate_driver);
+	if (!str)
+		return -EINVAL;
 
-	amd_pstate_enable(false);
-}
+	/*
+	 * support shared memory type CPPC which has no MSR function.
+	 * enable amd-pstate on processors with shared memory solution
+	 * (amd-pstate=legacy_cppc enabled), it is disabled by default.
+	 */
+	if (!strcmp(str, "legacy_cppc"))
+		shared_mem = true;
 
-module_init(amd_pstate_init);
-module_exit(amd_pstate_exit);
+	return 0;
+}
+early_param("amd-pstate", amd_pstate_param);
 
 MODULE_AUTHOR("Huang Rui <ray.huang@amd.com>");
 MODULE_DESCRIPTION("AMD Processor P-state Frequency Driver");
-- 
2.34.1


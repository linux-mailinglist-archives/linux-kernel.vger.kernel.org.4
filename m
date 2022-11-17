Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61C0162D3F5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 08:19:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239286AbiKQHTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 02:19:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239241AbiKQHTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 02:19:45 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3FE468C52;
        Wed, 16 Nov 2022 23:19:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UTDN1Yhm6A2SR90nXI7tM/ouE1qv6YpPgjC8R9nKBloW/tXA2J5MeN2H6MPMOHtNiY8QUU5duWA70xB3OBAGZZxNMkw+bSSAA6iGoPbnLZM0vi66EVR+7UoyOmPGH3KfFUWUBFM/np5vzBtaOfUByNIcmwB4aqGR8bx2kpoP+B+zzBLC3ImGNnWagHRy5VaDi0oQx/0AA3jSU0magVhRTdfPeIng28t6AVORdZ3lMzuC/6dN+vM4B4rus8aR/uwPe01RVxdpWVEyYwYfjXsdxC9/sNCzPsaHD6T0+fhAIWIwXGKe0kFAFgDpnro7Y9Sr3QoGxx1v94Enbv7zHBN2fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+VcxHfZHgy05iclJ+ckW+zPVRv/XZiM1SzYHvI6AHQM=;
 b=derrIocjw2huByQRDmLkVICReHWWUuF1NnABIHof3zdMnWmo/ym0DqWHbjM6BE+H5pOek33kKM6KBnos8iJ/GBekkWiKUfIZwUfDwFzgKPRkhn3tLXhcMPdgtmAmMY0QznjjnDYnv9uVTHpXuFsYjVr3+EpnjJi64sJWvKULa/82HsYjG30rdw6+/sQw/Vh6Hy4a4q4e7esmKq6Ez8E5XfWTSGHnwfn5HV/RMv/lFq7UA9zB7UU3ivakr2x3cXTM8jxuOia584ASJxpR7zyk4UgGS/bdXwzu87Lsqfu1b5B2bMYnm3JQn51awirUg3KXixeYqvR0amKSsJ2c+OuRJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+VcxHfZHgy05iclJ+ckW+zPVRv/XZiM1SzYHvI6AHQM=;
 b=YhyZWKA/u4QPn/cXNNJ3CtE1V8JjGWWk1+QSn9Lvr8gxDRSv3wgFZY8RLfHEcshKvjMZfMXCwaB9miq18y91GKvrYZ2BzH27cB/FUMb5IMCUQMfJ780rIzayGyvGTR4PYNEudmT+sg0BTlLkjSpnbaIpZ2UFdtihFCCC5Y46y60=
Received: from MW4PR04CA0298.namprd04.prod.outlook.com (2603:10b6:303:89::33)
 by DS7PR12MB6312.namprd12.prod.outlook.com (2603:10b6:8:93::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.17; Thu, 17 Nov 2022 07:19:41 +0000
Received: from CO1NAM11FT082.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:89:cafe::ac) by MW4PR04CA0298.outlook.office365.com
 (2603:10b6:303:89::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18 via Frontend
 Transport; Thu, 17 Nov 2022 07:19:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT082.mail.protection.outlook.com (10.13.175.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Thu, 17 Nov 2022 07:19:41 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 17 Nov 2022 01:19:36 -0600
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <ray.huang@amd.com>,
        <viresh.kumar@linaro.org>, <Mario.Limonciello@amd.com>
CC:     <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Deepak.Sharma@amd.com>, <Shimmer.Huang@amd.com>,
        <Li.Meng@amd.com>, <Xiaojian.Du@amd.com>, <wyes.karny@amd.com>,
        <gautham.shenoy@amd.com>, <ananth.narayan@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v2 2/5] cpufreq: amd-pstate: change amd-pstate driver to be built-in type
Date:   Thu, 17 Nov 2022 15:19:07 +0800
Message-ID: <20221117071910.3347052-3-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221117071910.3347052-1-Perry.Yuan@amd.com>
References: <20221117071910.3347052-1-Perry.Yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT082:EE_|DS7PR12MB6312:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c1c4c90-5988-4516-ba97-08dac86c185d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GRuWTCgBS3nXYKL8ven5p1qlEIuK0tAm2kMmlJAnleZrH77zYaVuU/l3NOZ1eAV+WuC6gGvmp8gSPbGTxDJB86RbxYJmwjMXuxKMGTg+zJu/P1zkXOCy+HaOEu8Y9ostz6cwAD4dIsX6EBGzztZHBr3m6d/2i5uWCLkz7D0j3an9t3zqaVSS+B28Il1wXMePoihs3oE5hqzNAWRz1w+mpKN2mQMfUahfY4bmXUhhgOzb++zEMljFqaCZNnfV50PJTRLfNMFhEZK+EJAb25VztgSv/7jxmkz5GbYQ8YHAq3MoAMW4byZAe6MWhiPSsvEe6vCRK8Vfmiv2GYyRkxd4XsweQC6bDcY9prDwtlR62OjPfcbSDDJlCWU3ZBZc0hsILOr+fl4blVVPTAOJ3CmpBueDJVQXSDcOLiewliw1MUPz+Vbgby4a4t5MiVRRc80R3wR0mKDY2O+WCItsnmJzW4uCFVeHmSMlL3Q+8sr5Hbj7xPPfpLxmhpXSnPNmgdirQRkKTK8KW53HPVhxgzZPT0wHiw3s7nwMIlqVxPYAr8sotGXhHjnAh93gd+pf5SrmttahiYdHdtASbKpbAK3JYIwdTdzaCVXb7xFVpmapA+4nreNgSg8LQq+i8XPhZFaRE5mq/lnhhFAMXMQznpb8lMPazVtubWzvsgtHnVAwNXhWmYxTz0PTw1LyE30UJLBA2o9x46kmU2GhDyIpmz0l48FdZD3/ByID02lJ5rQdEEZ7oSuQ9AXkpZYtTb3WTMUw
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(136003)(396003)(346002)(451199015)(46966006)(36840700001)(40470700004)(47076005)(2616005)(6636002)(54906003)(7696005)(83380400001)(41300700001)(316002)(36860700001)(40460700003)(2906002)(26005)(8936002)(16526019)(5660300002)(40480700001)(426003)(70586007)(336012)(186003)(36756003)(1076003)(8676002)(70206006)(4326008)(478600001)(82310400005)(82740400003)(86362001)(110136005)(6666004)(81166007)(356005)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 07:19:41.5603
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c1c4c90-5988-4516-ba97-08dac86c185d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT082.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6312
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently when the amd-pstate and acpi_cpufreq are both built into
kernel as module driver, amd-pstate will not be loaded by default
in this case.

Change amd-pstate driver as built-in type, it will resolve the loading
sequence problem to allow user to make amd-pstate driver as the default
cpufreq scaling driver.

Fixes: ec437d71db77 ("cpufreq: amd-pstate: Introduce a new AMD P-State driver to support future processors")
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Tested-by: Wyes Karny <wyes.karny@amd.com>
Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/cpufreq/Kconfig.x86  |  2 +-
 drivers/cpufreq/amd-pstate.c | 11 +----------
 2 files changed, 2 insertions(+), 11 deletions(-)

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
index d844c6f97caf..701f49d6d240 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -663,16 +663,7 @@ static int __init amd_pstate_init(void)
 
 	return ret;
 }
-
-static void __exit amd_pstate_exit(void)
-{
-	cpufreq_unregister_driver(&amd_pstate_driver);
-
-	amd_pstate_enable(false);
-}
-
-module_init(amd_pstate_init);
-module_exit(amd_pstate_exit);
+device_initcall(amd_pstate_init);
 
 MODULE_AUTHOR("Huang Rui <ray.huang@amd.com>");
 MODULE_DESCRIPTION("AMD Processor P-state Frequency Driver");
-- 
2.25.1


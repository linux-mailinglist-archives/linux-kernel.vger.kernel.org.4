Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D625C62D144
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 03:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238685AbiKQCwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 21:52:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234662AbiKQCwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 21:52:08 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2072.outbound.protection.outlook.com [40.107.212.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982C045A24;
        Wed, 16 Nov 2022 18:52:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Whe8+pJLVixayToZca7mCfWVNLXr4exBSmtfhOGAuEylHqDn1DLgp53D5Hi6xoBCJ77OI6fzI31Qc+Z2WwlrOK93RtrLYA8uTlFQkFEkwmoTdR4FQlfExAXRYco/IzsZFAeZn7b3l8NIXyVxbzUyWu0v0qQmZ1/3ZpqnyQjZa/19E4wM5u25EGOPzMbVSUJhFvw5TK1KUYulMZZfYXA/HCU1t5fpI5g6hN1lCGUutgAlJauN+Fq0kzbw9VJCYvrGNphBabQeYYkVsn2Ud8lvFeNjJ+AtOyou+BN0uSyooNLooRmQepngFaWJij7u2K9KD+/B9xlZgl+7ZeA3lfmnhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7OiiB0U9F02X9T48xdt0/E/wPxXK4V3G3If9b/U6C14=;
 b=Sspsg5Pb6ljXtZqTWU+2G107RrPmJ0vTW7VgcfDUADFbTFUVqpOsThyppSQdgqs+8XgydBbWweKz8OqC4AAw3yQmsdwUn1vua0bq3WHWVnJHQwjSBZaayD/S1R7nDSdVN/GxgoQOMFtTuVHCpKG2mKhm4eucMiVtzOvu3Y0fBi/Ld7CWFnN1J5sEDAVm/olEqcQrU/XnLMNc1QCC+ClYnLoaJl64Bpu3BxchCkrctIBPva++vPHuZ9hEABo4SkYAI085vMBaNz29A9yp8frqFNJbfNo5Lb/XUGt6o7CKHUjtyphoo2utH1Kjw7idFM6FOMBB8Akt7uT+w6U9zR7XNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7OiiB0U9F02X9T48xdt0/E/wPxXK4V3G3If9b/U6C14=;
 b=tUFht8ZPeaQ9ExACWlWKCcp//eYRXpOt98HRNpIi0PfV3p1rNDsyU+hc0DIq0MOiS0YFcW7mmUseUIivnycF/mwQol8ztUzrIfvmc1chixgUjFUuPtxRuj3yjQ/AHWJ2jeTtDawXHX6VrLf6BPiguxNcdzgQUK8/Ir55RFiAMOY=
Received: from BL1PR13CA0133.namprd13.prod.outlook.com (2603:10b6:208:2bb::18)
 by PH7PR12MB7116.namprd12.prod.outlook.com (2603:10b6:510:1ef::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Thu, 17 Nov
 2022 02:51:59 +0000
Received: from BL02EPF0000EE3D.namprd05.prod.outlook.com
 (2603:10b6:208:2bb:cafe::47) by BL1PR13CA0133.outlook.office365.com
 (2603:10b6:208:2bb::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17 via Frontend
 Transport; Thu, 17 Nov 2022 02:51:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000EE3D.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.11 via Frontend Transport; Thu, 17 Nov 2022 02:51:57 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 16 Nov 2022 20:51:41 -0600
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <ray.huang@amd.com>,
        <viresh.kumar@linaro.org>, <Mario.Limonciello@amd.com>
CC:     <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Deepak.Sharma@amd.com>, <Shimmer.Huang@amd.com>,
        <Li.Meng@amd.com>, <Xiaojian.Du@amd.com>, <wyes.karny@amd.com>,
        <gautham.shenoy@amd.com>, <ananth.narayan@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH 2/5] cpufreq: amd-pstate: change amd-pstate driver to be built-in type
Date:   Thu, 17 Nov 2022 10:49:52 +0800
Message-ID: <20221117024955.3319484-3-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221117024955.3319484-1-Perry.Yuan@amd.com>
References: <20221117024955.3319484-1-Perry.Yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000EE3D:EE_|PH7PR12MB7116:EE_
X-MS-Office365-Filtering-Correlation-Id: c5d12f36-51f2-4159-348e-08dac846b16c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k1IM0MS3QcpBFuk+NFU15PBOcZa1e/RE3LMMQCt7ivZ78J5gchNVXvH7Z1PXvZunibDL8XUoK6vuAFrfVhGZKEXFV8JRliguanSBsX/3ZWeCmIgALwodhodqijp7o7mlTISDC6rCXsf4ii9oyuMOIa7jR35FQU+ff3417D1ElL7dpXUS+yuB1kDMi6dz0/pzAa/jdzUCx6rIp5NiDsxn+Ghf54OLucUYX8IDl+3Pqcpc3reibHfj5PieF2LYfocbEjLerY9sQxjSOx54A0VtWfKA4p3JRymfO4/nPH9ljqlb9CcRimFifnk7yV/pogckCBZOCpMmNMukq/i0gTyRApCBEh5sDaQwHUy3yENFlOhfxGzS5UIK+LxNccRMR9OfvEA+0G0AatXuxmEL/7O9lHKK0Ix4y+FaYuOAkwT0/ZoCLsOF/6U10fUiRFGJHEK/h8mGecQh8xKBJfCDKnmrYFXYqp6ysHJAxyhzFKG+fgrChFUMTsQInmmzRI6dYQUax2MWqpe3kNUPBNUh944K1L29vSfCuEf7KReES4BBQvpRjWpdykgyHTLtoQoMUDnoWCu7V26dcgzhZOrQn3a2JJfIamCDG7lUfN9+lV8P85vtsNqek8nVCyvx2ydEpC+AjTBObI9BN9561Zt8ciTO/UBRnpY4OEAhhueL+NJLJfEMPKNqnRYqIiRrYDAYMmrv7GtoynKmZ8gCbVhghDIc6fGEVrx2MvAWpn8d0LzI9XH8JmUKj3dEmaBvp8hZwhVM7jxak91qOG1Yl9vZS/Wk/xWxLF6xZj2Gv5/Wt+HKy50UGKRFeP1H33Y+ByYDWNvjpFxiKtI6l7aMxBUQ/mblLw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(346002)(39860400002)(136003)(451199015)(40470700004)(36840700001)(46966006)(40480700001)(5660300002)(70586007)(70206006)(8936002)(41300700001)(86362001)(356005)(81166007)(110136005)(2616005)(316002)(82740400003)(2906002)(36756003)(4326008)(16526019)(426003)(6666004)(6636002)(54906003)(336012)(186003)(47076005)(1076003)(478600001)(8676002)(7696005)(82310400005)(26005)(36860700001)(83380400001)(40460700003)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 02:51:57.5801
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5d12f36-51f2-4159-348e-08dac846b16c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000EE3D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7116
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


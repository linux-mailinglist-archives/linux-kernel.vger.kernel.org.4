Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7308C671649
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 09:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjARI3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 03:29:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbjARI0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 03:26:04 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A641A5AB7C;
        Tue, 17 Jan 2023 23:53:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RdZVvdx+Oypv4cMnrsAV9/eJie8DDaCDLwAtLctI0wo//Mw8ca+Mbbqu6YrLiKxZcjM7JdTqvuFcd24xdCDixNZ0PVwK1DzfL1EvezGajavXXeeLG/REHZG+9ccvSax+m7zqRFiKrldH9DpMr2uU8vzpbB1KDtjHZyTrPiCLNkgMcoGdYzfGRwU8QhQ0balqhWAUPX5z1Nb4StJjCsBoLKFLEeBYqy64UjPq14+G4t52+k/p8anTgKzFHMs+/Jaul8vOGyVKNk5F91Lmydq1oQRFfQqDYEUgvYxT6dAePcG6oABP3q8sR+kqU1g+OgEb/DAu23CT0khkVfdngLp+Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/x+50q9XOpj/DHfjRYN5hTfcMIzg12lqGHqvEDE3IfQ=;
 b=Qswq6uqJl6ZFNKCpr05ikvRwDxG3TAK9U7KUx0c+agFxd6XmRisBg8SODH2tmldA8yjdOI0Ac44sbCi3Pz+RN12330VXjFCXIWueyn9VPKAT3rHabII6rWV9J/kL0IdpnwGBOyMMcseoTZHSwVJIKZ/PvW1vgfPRavzHFIefSDWorqGILJGI9KNoLDDK2WXoXb4lqVD7AEG09CltggMDdj7zAXpWjuV2+ABG08/qFSBNauy7GOFI8Z3YWQoK6bd58x8ziqDO2/jlxSAHQpM3caKFec9+A/oyK5hJskHFCv0FOXsCMUWXebYEZTD0EwUh0rmUJG3mUjUmjHEcC3P75A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/x+50q9XOpj/DHfjRYN5hTfcMIzg12lqGHqvEDE3IfQ=;
 b=NVwARZQT41IK6uSST1PFL8+KHWu6VJDWLKR6NAaTeGFXSe4pK03TM9VqlIOTaJHOGGqgC8xeCzr0ITfFKtNNSuJnUKCfpsB9kx6+sNfIJtZ5KyNtP51jw789faH5JZ8oNqHEwvkjR1uegYAWJ4k+6ISoBYPyyyJjc4iNigboKv4=
Received: from MW4PR03CA0126.namprd03.prod.outlook.com (2603:10b6:303:8c::11)
 by IA1PR12MB7518.namprd12.prod.outlook.com (2603:10b6:208:419::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.22; Wed, 18 Jan
 2023 07:53:08 +0000
Received: from CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::6c) by MW4PR03CA0126.outlook.office365.com
 (2603:10b6:303:8c::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.19 via Frontend
 Transport; Wed, 18 Jan 2023 07:53:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT033.mail.protection.outlook.com (10.13.174.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.13 via Frontend Transport; Wed, 18 Jan 2023 07:53:07 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 18 Jan 2023 01:53:03 -0600
From:   Perry Yuan <perry.yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
        <ray.huang@amd.com>, <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Nathan.Fontenot@amd.com>,
        <Alexander.Deucher@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <wyes.karny@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v11 06/11] cpufreq: amd-pstate: implement suspend and resume callbacks
Date:   Wed, 18 Jan 2023 15:52:05 +0800
Message-ID: <20230118075210.447418-7-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230118075210.447418-1-perry.yuan@amd.com>
References: <20230118075210.447418-1-perry.yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT033:EE_|IA1PR12MB7518:EE_
X-MS-Office365-Filtering-Correlation-Id: b08e4b69-bd10-4495-2099-08daf9290989
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E75gUG0GEBx0+7gCoJpoGr03oww7asNi4+OMhNrrVFo960FhJgUorX3sTqohdlaSVn/YrXczaTWDMYcfmiGakomiItbpymIyn4E7un8rWJiut+gbDqSsT74FGlkCove92Qc2lJB+RFhGBTWG4CGdAJB8c7vPi7zVWjAaxNDihxoc/2TPLMKoOkuvehQ5n/fkPF3INCpUd6wLf9YUzcjtR624aBJrdBfA9BKo3LgdCh3+bOssL3piFPpsPl9q1fFKQhbCtsHrdYVz18EIjtr26d6gUljdmEV/JwYazGlwJIUhDxW/z0dvyOjwH3zKWxxuFTM/o7VHYUdKwuafPDD7sgq2+0nPL80xJeNz6vjCPiPrw4BhAxPp+smyTpDzgkAfrg78qzWS7XmSaJDsRsCEA3DqnCbuTukOsYYy4hYfMLdlE2rTkkZIjEQ9ccXDHF7ZSsOvCceBL8HNllcxfkMxxEyI7TMx6Ty2Exc3hHyKwh4wytdITWTfTLsmjl7TLs3KrglsBUPGQGykM4V2rxm1hUSwam1nBwvOs/EGlUqVjS1svOnCC/bHH0oNfEL2P0cp4+Kj754hdQ0OiFlZnEJDRiBFzOcD593fQEdXD5pP2LxwNKt9E6A9XicxTPHe5POf73WdSWjsy56i5D07ngetdbVFjjQcDSWGB/XvWUcMDTCGznG6tWXnPbzqlwz0AM/AEmzx44LNlGg4bA0fYxj0kdQdhF38HoHGMLlSSwqJdmE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(39860400002)(346002)(396003)(451199015)(40470700004)(36840700001)(46966006)(7696005)(478600001)(8676002)(110136005)(36756003)(54906003)(4326008)(70206006)(1076003)(41300700001)(70586007)(82740400003)(316002)(36860700001)(356005)(40480700001)(81166007)(40460700003)(2616005)(16526019)(82310400005)(26005)(336012)(86362001)(47076005)(426003)(44832011)(186003)(5660300002)(83380400001)(15650500001)(2906002)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 07:53:07.3897
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b08e4b69-bd10-4495-2099-08daf9290989
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7518
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Perry Yuan <Perry.Yuan@amd.com>

add suspend and resume support for the AMD processors by amd_pstate_epp
driver instance.

When the CPPC is suspended, EPP driver will set EPP profile to 'power'
profile and set max/min perf to lowest perf value.
When resume happens, it will restore the MSR registers with
previous cached value.

Acked-by: Huang Rui <ray.huang@amd.com>
Tested-by: Wyes Karny <wyes.karny@amd.com>
Reviewed-by: Mario Limonciello <Mario.Limonciello@amd.com>
Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 40 ++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 1472a6382b29..9e1bee060597 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1045,6 +1045,44 @@ static int amd_pstate_epp_verify_policy(struct cpufreq_policy_data *policy)
 	return 0;
 }
 
+static int amd_pstate_epp_suspend(struct cpufreq_policy *policy)
+{
+	struct amd_cpudata *cpudata = policy->driver_data;
+	int ret;
+
+	/* avoid suspending when EPP is not enabled */
+	if (cppc_state != AMD_PSTATE_ACTIVE)
+		return 0;
+
+	/* set this flag to avoid setting core offline*/
+	cpudata->suspended = true;
+
+	/* disable CPPC in lowlevel firmware */
+	ret = amd_pstate_enable(false);
+	if (ret)
+		pr_err("failed to suspend, return %d\n", ret);
+
+	return 0;
+}
+
+static int amd_pstate_epp_resume(struct cpufreq_policy *policy)
+{
+	struct amd_cpudata *cpudata = policy->driver_data;
+
+	if (cpudata->suspended) {
+		mutex_lock(&amd_pstate_limits_lock);
+
+		/* enable amd pstate from suspend state*/
+		amd_pstate_epp_reenable(cpudata);
+
+		mutex_unlock(&amd_pstate_limits_lock);
+
+		cpudata->suspended = false;
+	}
+
+	return 0;
+}
+
 static struct cpufreq_driver amd_pstate_driver = {
 	.flags		= CPUFREQ_CONST_LOOPS | CPUFREQ_NEED_UPDATE_LIMITS,
 	.verify		= amd_pstate_verify,
@@ -1066,6 +1104,8 @@ static struct cpufreq_driver amd_pstate_epp_driver = {
 	.exit		= amd_pstate_epp_cpu_exit,
 	.offline	= amd_pstate_epp_cpu_offline,
 	.online		= amd_pstate_epp_cpu_online,
+	.suspend	= amd_pstate_epp_suspend,
+	.resume		= amd_pstate_epp_resume,
 	.name		= "amd_pstate_epp",
 	.attr		= amd_pstate_epp_attr,
 };
-- 
2.34.1


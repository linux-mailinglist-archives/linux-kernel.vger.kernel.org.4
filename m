Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD5C730F63
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 08:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243817AbjFOGdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 02:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243534AbjFOGcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 02:32:55 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0F826B1;
        Wed, 14 Jun 2023 23:32:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kQYcUnJ3uFatuufn/taHfa82cRxX0hmhkC/E3i7tlHv8db4mX2Gx8Z9lLcEWUIK5lgl92ak8SwGKR1cOXkQU29sYb862TmHemPNaXeAhfo7pI5mOy219AJTT/vsd4tFRd7fU1StGxdYhYvpRvc4k7k2hwf1nsOwpBlpjaBRE2IuYVOJNn8d8tcmP81V1F20KZxQBhj/0/5W8V4ydy9i72qvDqYgtfjC5HHzCFHiLYzhIPwaY7BoYGkk9UU6N2dgZ+HiqUGwed5N9ERk/U7FAgeMcg+siJJSFx+1NwoZF5wNpRdbWoKskTiiAloQ6FnmhOO84u89ZeB4qI3PbcVNlog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pBoLV0cMdEWVDLW6LpTVgN8VA/IqVQV8nNgGK2e84qY=;
 b=g+mzXYojZM9RpstoIb927QNm/ugxk0wNEcixnAlnE7ioZ+/jHcM+41UxL5FGCYZTBtc3pyIyTFAqW0T/Io0UqI0ZRl3kcVbOUl3tv+/dZ+O5TpVQjUfApPXiuMK84CPV7Q5nP8DAQSNYeDQgPaqBKwqf6vjtzioZDbxp4WU5lv3Nw5z6YNqsUoOz4OnWrPhoMNMQH9ZdkED4egzVMsytpoGE41x+LCsne/e2pZ8aP5KG5hkUxFkF10wAYdEk5aaVoDYLWhQtkBAMux2DJwb/MdzaiXbae2tdjlGV4Ex7wRa3b8hii9Br4CYEmDkvm4No+30jsiLg9TavubCGE7vHdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pBoLV0cMdEWVDLW6LpTVgN8VA/IqVQV8nNgGK2e84qY=;
 b=aYeOwEXesg4ftqafCw5FR+EYXeXiY/jgFgf2Tl4CjHNWbE6dB3J6sOtW4qm4y7qYZCKhIidM/Kq0w4nunXEShiA8p/yp1nzfYEStgN10yGCsc2DEluliSLa0cznp9bA+F/YNP/JOjd+vp9kqyvoMfQNNcWH6geUccqYum8eJzIA=
Received: from MW4PR04CA0036.namprd04.prod.outlook.com (2603:10b6:303:6a::11)
 by IA1PR12MB8360.namprd12.prod.outlook.com (2603:10b6:208:3d8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.25; Thu, 15 Jun
 2023 06:32:46 +0000
Received: from CO1NAM11FT102.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6a:cafe::38) by MW4PR04CA0036.outlook.office365.com
 (2603:10b6:303:6a::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.25 via Frontend
 Transport; Thu, 15 Jun 2023 06:32:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT102.mail.protection.outlook.com (10.13.175.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.25 via Frontend Transport; Thu, 15 Jun 2023 06:32:45 +0000
Received: from pyuan-Splinter.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 15 Jun
 2023 01:32:41 -0500
From:   Perry Yuan <perry.yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <viresh.kumar@linaro.org>,
        <Ray.Huang@amd.com>, <Mario.Limonciello@amd.com>
CC:     <Deepak.Sharma@amd.com>, <Wyes.Karny@amd.com>,
        <gautham.shenoy@amd.com>, <Sunpeng.Li@amd.com>,
        <Xinmei.Huang@amd.com>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/4] cpufreq: amd-pstate: Set a fallback policy based on preferred_profile
Date:   Thu, 15 Jun 2023 02:32:25 -0400
Message-ID: <20230615063225.4029929-1-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT102:EE_|IA1PR12MB8360:EE_
X-MS-Office365-Filtering-Correlation-Id: c0078519-0d7d-49ab-c138-08db6d6a54c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 34wXwn/Xlv2zlsOf6OC80BQEGEJNlHdardHBNjuRAfXFWenrjdn0Um2pOzfWwPw0g6HJAPn+VBKi+2goM1wn+VAbMJblIEl0vjKcut8OI/cnBhUt66QcozQiwjza9Ca4hcQsg6IPpf6tw5/okpFWORxOAZNOfwWG/kPY24wRsLWikqqKhcuWu0AgtQGfyUAQQ2T186EAj6lDVW06mDxfhTGznyOoX3l73EUNwfTDoRLWXtENPs5U/bwLizhdeSnjIXF4QR2SmBYXWOE7trhIBkaSW8b178JdH+XIEhxikDhLoolx17KH5446nH7alPk6Fuc3dgb3/aGrV1+6SUEc6ZVOyUQN3aVZfEKJA0OgZQibRQgfMQBeo673LogayP6uQhrsRIx6lrRivBSapCy7+FBxeiwwE92JCbBmC0Sv4iVoXk6ohk35gKLJ8btZsbWjxwCVjrBXc3aV5SlV++JNlekWbp+seLhcAHscgL0G71K44849s/ART4qoeSfa3YLP1I9/6OcLim+m1xOUCDhpinrdcY9HFR+03vwcqOlBOrTULrjpDrFNz/ULEeaF/GO+FBPu18aChz1pUYcE0zblaFuFcY3G8dj3BFLb/n7D1sLrFOpw8yMnhNR6gLU4P96ec2OZtSe64RnElFP/Eh0jvHr39xFUU88LKpKPUwozmvwsDr1WR+DOYJ5gzvpevqXs4b+bLVqZbf8jHVLGY8yxfjd4q4Lnc1F2MWNtg2l6M1ebHUV7nTl5LOLDZlA+KQbXVtNnD4RRGGKG/C2VauGDtw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(346002)(396003)(376002)(451199021)(36840700001)(46966006)(40470700004)(40460700003)(5660300002)(82740400003)(966005)(81166007)(356005)(336012)(2616005)(83380400001)(426003)(1076003)(186003)(16526019)(2906002)(26005)(36860700001)(47076005)(44832011)(478600001)(40480700001)(6666004)(70206006)(316002)(8936002)(8676002)(41300700001)(7696005)(86362001)(82310400005)(70586007)(36756003)(4326008)(6636002)(54906003)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 06:32:45.7923
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0078519-0d7d-49ab-c138-08db6d6a54c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT102.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8360
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mario Limonciello <mario.limonciello@amd.com>

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


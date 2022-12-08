Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70791646E4E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 12:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbiLHLUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 06:20:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiLHLT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 06:19:59 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B519654B09;
        Thu,  8 Dec 2022 03:19:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i9GtRoFXPZw7Qvs26WqD2EN9ybeRILPVuzvG7ysxxJCAKxCWCH0PdF0mFrowzDqKZRge/frCUD5hBgO97WARYzDhxNjlJ19C/wmRXJgsGB7Rcu3m9zGVelxlHkyc6KPCck2L5hV0TMAo69nI0BI3e40xb0K/ZdGOEbEmUoVQfrNuTp7m2P5Q10GLbOaursg2obavuYQhh4hO5EbBJYbYeyo11VUAw1bKfthTZb/oF2EyyFJHP+R3T3cXOXVwWR6ZA7bCt0ncDPuYDvwc9LUWT+rMyK5EzF1cOvZnR2oiMlLu54QBRJ/X5L/N92ti/2CvbWli7yyXJYY3YSfRaXolTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B1gVu4DnZbs+ofVVp3+AcNEQW/ji3We80lzAAEXf7KU=;
 b=og9rFNKMlGUbwSwe2Mu0aYk3xPmcJvPblowtLe/HWXHySPNrBUTV+f17KqaTWbw1XUz94uOyuDlwOLFSYhXizLz9fUTwv8XU/LYdwCSHAPeJwDWnVh0hc9rrGFX5kRm6SPMIHBIWADcXCvHfMdH3DerGZcpkLSBkVgAuo9ZLKfR85v4SKcYdnvMrf2ED1D/Csh+K0AlwXkhouA/HDuIYOqqXHdt82o/LohHUaJo0vpeI0LY7sP3CXDg9eLhGQuXX8p+bUa1td/xUrQuckYkQSteVIvVQQTti9nDa7SPDPAqEGnRFac8rRcQpj9xM15kutzOGXIDrVHCYMzXljpSKag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B1gVu4DnZbs+ofVVp3+AcNEQW/ji3We80lzAAEXf7KU=;
 b=YHbAUU1eh8KAaeqH40wYuRPWepi685j3FWoNIk8T/XMGjgMFo0z+4E0dsZruT16gazEM89VEZMznEp8FiAeOJszkyFoRXjNY7oGZhSmp/a3fXWWQsW1CGZwN6f6e6iXRclI4jycN+O90hpLSWOVoW67x2nwVsWIBbikRGF8sgkA=
Received: from DS7PR05CA0048.namprd05.prod.outlook.com (2603:10b6:8:2f::19) by
 DM6PR12MB4500.namprd12.prod.outlook.com (2603:10b6:5:28f::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.14; Thu, 8 Dec 2022 11:19:51 +0000
Received: from DM6NAM11FT101.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2f:cafe::b9) by DS7PR05CA0048.outlook.office365.com
 (2603:10b6:8:2f::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.5 via Frontend
 Transport; Thu, 8 Dec 2022 11:19:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT101.mail.protection.outlook.com (10.13.172.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.17 via Frontend Transport; Thu, 8 Dec 2022 11:19:51 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 8 Dec 2022 05:19:48 -0600
From:   Perry Yuan <perry.yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
        <ray.huang@amd.com>, <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Nathan.Fontenot@amd.com>,
        <Alexander.Deucher@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <wyes.karny@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 07/13] cpufreq: amd-pstate: implement suspend and resume callbacks
Date:   Thu, 8 Dec 2022 19:18:46 +0800
Message-ID: <20221208111852.386731-8-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221208111852.386731-1-perry.yuan@amd.com>
References: <20221208111852.386731-1-perry.yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT101:EE_|DM6PR12MB4500:EE_
X-MS-Office365-Filtering-Correlation-Id: 7623c094-32df-4f52-dcf4-08dad90e2027
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WyNNlO+3SuMYQvCSd5Oy200kihg1mLsaGk6kKDxZxppYZuT2qbyGRXZE+TltJ0oRZYo0GNV+IdUf7+I4Gbb2SKF6el/knrZPgqpF5jwOc4mk4QKeKH+rwAAT5f2LC9KZ+J7h94Mih3xJfFKAL6CkfS8bSeheKWF4Qc/hPrFj/k7JqrXocuWFfqSB2GZW7XEuJBCLCjOT0Mhsmg+CZpsJy+yGSbMc31kviIsprskGV0tFgEb5BlSJR9U8o0oUxJRyUwW/oWgPp4hPvSuyyNEgM/1DMF20wdaTAU6EOMqXvIMaNjOAaiTx9qVONqPrDFq6w1FQ2ds64lrU3nOHop1ypOd/VRXkOKw+N20wgpA0icTX8IlXGFs788ZQu8uQ+SdduV/rhqk8pzu4HF46IrrrqWPkYpGsa0yF6jc/KfVePU1W8bM0E11qSaescZs+lRj+RGQYy2aHarlHvMtuXV4d2xgQv4NMADGRsxXFWzrV4pjxaJ74+Em3T11QxD5beIqIeknzAB24/Q0LAnj+c96N/02ji1BIVEgEi4oriq7zChizTsPHHCujMqw1UAU50km8XfYhdY0/WFqnM53PATZahH7yoVNqeuJX7mq3G4PZsI9oPew11yXgQj/km3VzCOFkGVfGz6rR/7HTVP3YXwNUlhl3bUhQnO7cZp3+OuF3V2mrGCBPmiu6kVg4fLHyrQ1UnE8wrtV992e/Ab1S5nEnzL+U2KchnqEzRniV3z6sAIg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(396003)(39860400002)(376002)(451199015)(46966006)(40470700004)(36840700001)(7696005)(186003)(2616005)(316002)(26005)(54906003)(70586007)(70206006)(4326008)(8676002)(478600001)(110136005)(16526019)(426003)(8936002)(336012)(36860700001)(15650500001)(83380400001)(47076005)(2906002)(1076003)(41300700001)(5660300002)(36756003)(81166007)(40480700001)(40460700003)(44832011)(82740400003)(356005)(82310400005)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 11:19:51.7818
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7623c094-32df-4f52-dcf4-08dad90e2027
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT101.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4500
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

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 40 ++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 412accab7bda..ea9255bdc9ac 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1273,6 +1273,44 @@ static int amd_pstate_epp_cpu_offline(struct cpufreq_policy *policy)
 	return amd_pstate_cpu_offline(policy);
 }
 
+static int amd_pstate_epp_suspend(struct cpufreq_policy *policy)
+{
+	struct amd_cpudata *cpudata = all_cpu_data[policy->cpu];
+	int ret;
+
+	/* avoid suspending when EPP is not enabled */
+	if (!cppc_active)
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
+	struct amd_cpudata *cpudata = all_cpu_data[policy->cpu];
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
 static void amd_pstate_verify_cpu_policy(struct amd_cpudata *cpudata,
 					   struct cpufreq_policy_data *policy)
 {
@@ -1309,6 +1347,8 @@ static struct cpufreq_driver amd_pstate_epp_driver = {
 	.update_limits	= amd_pstate_epp_update_limits,
 	.offline	= amd_pstate_epp_cpu_offline,
 	.online		= amd_pstate_epp_cpu_online,
+	.suspend	= amd_pstate_epp_suspend,
+	.resume		= amd_pstate_epp_resume,
 	.name		= "amd_pstate_epp",
 	.attr		= amd_pstate_epp_attr,
 };
-- 
2.34.1


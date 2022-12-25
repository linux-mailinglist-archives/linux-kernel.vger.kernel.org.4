Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 910E4655DB8
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Dec 2022 17:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbiLYQg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Dec 2022 11:36:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbiLYQf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Dec 2022 11:35:58 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE1D60EC;
        Sun, 25 Dec 2022 08:35:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ezR3e2vHV+c0rFX/34lGh661DrgKFXd0MFQ0+4S3nVXIVH5qv2V41YNps4gG4U7OxC9AF/+X411QNzfOwf5X9JJhuEhKUiiGpk8o/l9FiWQ9MgEpaV8X4Z+h0rER549QcUZKt22eCHEJqD4TRZP738PXhnvQjdUvdwZzlqggbB9opH16eXLu9gmO/podvG+Ppri2CJyxZu+0FCM+E5QGh5RBElNReJGlA4lboC9G9PHuovSFcqr0852vBJVFDvRBRb63Z3SfjNNfIIzgpdZ8ndr/u/AhCYAqd2jnb41EeyVJDLIz6gI/kxFVBTuqxRxQgj3FvzZBGEgyyTPJ5Xur0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7qAcVvH5GJQbf3CFCt2m9xJOjLkwgQgEmaK7w5hwaSU=;
 b=WI972L7RNcpSyQTbll7eWLqhq8IbyXC1CrmEu28DCE+WKMMGvbj328de0+EgRBuGUjpkgkv+9k6ltCub4seYxsirvE95bl6bmJhkZR5Wy1GJs4P8Nh4siiiuFVEuiRksT9B7gouuNu12cglJ8kjaVy/5BOuKjHykSnjMQ27Yh2LLSpkrpb6Hq/y3RHRJ0LWDpBGh5FxTj6t2424s6ISZ7Pn38a51VLTrBP50/utpH/LXEwzxrYRZ5Ia2/XKZRbRAHR4tbTomuiOv/b58BKroLejFuJzxpqBNFzayTEBYVjmS0GpTRceuOc1kKnwhEa1NsTA6BCvx+ggd4kdTxCt0qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7qAcVvH5GJQbf3CFCt2m9xJOjLkwgQgEmaK7w5hwaSU=;
 b=TVjdvwpogSYzwjUiiInUd8WFNif5ePFM2VsZkdELL88nElBAz5lMlnQOadM81ekmm00WzhpFHVuwsheYm1wl86FkEyrRDHDFeUcZSODU10WNKYj1rHv/G/j3HACQ0ZiB/kXD45rLxjsKRGVcFiUVwOL6njJb2YqzcW2+6ezImY8=
Received: from MW4PR04CA0062.namprd04.prod.outlook.com (2603:10b6:303:6b::7)
 by BY5PR12MB4885.namprd12.prod.outlook.com (2603:10b6:a03:1de::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.14; Sun, 25 Dec
 2022 16:35:27 +0000
Received: from CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::d6) by MW4PR04CA0062.outlook.office365.com
 (2603:10b6:303:6b::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.16 via Frontend
 Transport; Sun, 25 Dec 2022 16:35:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT024.mail.protection.outlook.com (10.13.174.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.16 via Frontend Transport; Sun, 25 Dec 2022 16:35:27 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sun, 25 Dec 2022 10:35:23 -0600
From:   Perry Yuan <perry.yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
        <ray.huang@amd.com>, <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Nathan.Fontenot@amd.com>,
        <Alexander.Deucher@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <wyes.karny@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v9 08/13] cpufreq: amd-pstate: implement suspend and resume callbacks
Date:   Mon, 26 Dec 2022 00:34:37 +0800
Message-ID: <20221225163442.2205660-9-perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT024:EE_|BY5PR12MB4885:EE_
X-MS-Office365-Filtering-Correlation-Id: bd86ff92-e60b-4c9f-b2ad-08dae69607b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wazv4fLCvdA3q1ud+SY4z8n2AAw2aqwQ9VCB8J1CesMMhXYJd4tkMwMIrbtptojDtyr7CY5J2k8gFMUcU8qlPMZK4OVP8Ztvjf2vMPSyS7pk7m+F29w2Khiqe+AekYYoLdzk4HJxmlXvfkqGguVJynBr0r8RUOdT+fvLgiS02UsGdB3dcatuUsPGX+qg23hEx4Q93XvTIrUTGJUzzaxJ4D0VZCflVMYou/SJBiEYSLFx7TP44Eh7AC9Us2g5DwzQFdDebMgXj0e2rHvaZau9an393w/YV7W4bemI5ehmZSRByUIXLFLCsPWDpklRgkortxyw+1BJWrWNihUBh673syirDWD/+GLX2e/OFFjrSSELXRxHwglG2lwuK3RL6EPQDiX1EZZGFoQ9LSZtnqFJdm+yEfBDtqLXnR6YFDZwmOn34Ca6874EZDxzK4+Vyi7/wlTddjhXhbGvJJv9QiggYGDaqtO5OchG5jCqAt4Kzpg+jX5q2/7pWiK3cSexfwXvMBB1kmrGoVzRtJ3kx1HtEXClYkx34XnumVj77Goado7dJ7Icfy3ylrwIKvGFOcKND7xwypAmzzBV8IsvtcH2O9a7HXvDVT+8A5Q+xgGQSdwnZNCcMmAXiJ/YZ5BnOo6KMc+tNfmnV7AxM/Io/lls4Z/CSF53mXCF5CpfFz0jtMbtDVMtj3wbi43C799WPiikIYHIoS5bGoz6ZRAwFfKHFD4tq6Jg0dkXobmzr4146oI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(39850400004)(396003)(376002)(451199015)(36840700001)(46966006)(40470700004)(83380400001)(2906002)(54906003)(40460700003)(110136005)(15650500001)(316002)(44832011)(6666004)(36756003)(2616005)(1076003)(26005)(478600001)(186003)(82740400003)(16526019)(356005)(7696005)(81166007)(47076005)(426003)(36860700001)(336012)(82310400005)(86362001)(40480700001)(4326008)(8676002)(8936002)(41300700001)(5660300002)(70586007)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Dec 2022 16:35:27.3574
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd86ff92-e60b-4c9f-b2ad-08dae69607b2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4885
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
Reviewed-by: Mario Limonciello <Mario.Limonciello@amd.com>
Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 40 ++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index c671f4955766..e3676d1a85c7 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1041,6 +1041,44 @@ static int amd_pstate_epp_verify_policy(struct cpufreq_policy_data *policy)
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
@@ -1062,6 +1100,8 @@ static struct cpufreq_driver amd_pstate_epp_driver = {
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


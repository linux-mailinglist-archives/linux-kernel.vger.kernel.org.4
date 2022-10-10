Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A20B75FA1E6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 18:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiJJQZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 12:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbiJJQYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 12:24:34 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F332375386;
        Mon, 10 Oct 2022 09:24:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jruw3QxNkH9nWayiFI74CBsn7MNke+Sf5UBsGcdqelfoXdgfcoSF6AJjBh2TWozlrX28AKEBSgJgr7+dj0a1Gj6OrarrTjiJJpRHs9z2l7rhc9EZqYZVx5f20njYYnPeZ59yUF3hYZlZa5UeZ+DGBC7EXlcMHO4c0oYSOZPs82f0A3NzHnsw0TYzABomx5lMQmuK5oiX7hWDJRwcpAlkW0HuFnGyHoQseskTeN5PufLn63TPdDZfn4cQit5prLSW7zudqaTPUIMh6IK/MNlC+fwB0G+cIQInw+QSidLH4/l0diSTv3R5ID6gJVQViC5bzybNzktBENmq08KC4S3PvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k8fIPCPTCL2FNMnT1i2aUEuD8QIP5nmLPZOYfpvfyd0=;
 b=EPHWKzYfFB5Z4uwzOX9UHyBWf4mYGqTiZ5t8dtdju6Hot7AeJdM2OpFFVZWpOqjiCDSSVS2+e+iO3SwT5qCLlUVZqlF9yLeKkRe4hfYPnxXTa9ZtuX/GzadXrPTkRDgaHUFxRKEpuBPMtVGu2gMyME9X5j5pElaA45EfCNmbSCY2vdHqQeJLQIZhY7rv9EP+kGAz8Xj3+Kg3BOsh0Ic8a9EWKmKC39azgOQjuHd6zOtdLnpGHu+kLQepBmamQzPMG4SXWhonhG2zA0zPIvgq1n2J+e4c/N61QH6MjpwEyWbTuV5mpY/FdTvPR5/RajgcBR8Nc9GI68hbCYwn6nSYkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k8fIPCPTCL2FNMnT1i2aUEuD8QIP5nmLPZOYfpvfyd0=;
 b=exXVCUT72LstIO6LkE6XuMlMXMrvTqKxGvmJZ1X1hkx3E3Qkjw6SG1WUkI1D8iH64y/uOB0rJaRx6cLA4yT2V3fo8Ag2OQGNZQw/ZTUAGIuq31Jsgyjmvr0KUadQZFbwJBoiF4W3VvL83EPxTEan2CZ4P5vohu1hnZTNE9OyC/M=
Received: from DM6PR18CA0011.namprd18.prod.outlook.com (2603:10b6:5:15b::24)
 by DM4PR12MB7624.namprd12.prod.outlook.com (2603:10b6:8:107::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.20; Mon, 10 Oct
 2022 16:24:03 +0000
Received: from DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:15b:cafe::be) by DM6PR18CA0011.outlook.office365.com
 (2603:10b6:5:15b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.38 via Frontend
 Transport; Mon, 10 Oct 2022 16:24:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT051.mail.protection.outlook.com (10.13.172.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Mon, 10 Oct 2022 16:24:03 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 10 Oct 2022 11:23:59 -0500
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <ray.huang@amd.com>,
        <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Mario.Limonciello@amd.com>,
        <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Shimmer.Huang@amd.com>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>
Subject: [RESEND PATCH V2 9/9] cpufreq: amd-pstate: implement suspend and resume callbacks
Date:   Tue, 11 Oct 2022 00:22:48 +0800
Message-ID: <20221010162248.348141-10-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221010162248.348141-1-Perry.Yuan@amd.com>
References: <20221010162248.348141-1-Perry.Yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT051:EE_|DM4PR12MB7624:EE_
X-MS-Office365-Filtering-Correlation-Id: ae5d1617-25a4-4b2f-7783-08daaadbd866
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gjeUPJu45iczC6rv3+w3BUQQJW5Cf4Ha73WzoVo8Difsk3inRO5DLsCvhzIUKAYfHCttZT+hPlv9SqsyfKuVVioGh7m3FIcp5Wn/cPSbJ57qdQhzSGt8gpX7PjKzK2KptYHeJK69sQiwMr7PS+CmEFxyGFso6W5AckQsFtMH8AU8rBN8wjvJdI5EyhcviO62HNvfuwKTXK6KbFRDrFCVx9VJyvalCd/GSa/UT3m6rgaANbpG3MNHaZ70CRrVjo5j94P++pkAisi47cMA9RB9oJS/w/hNI98mUGKVKyVAXzX2v7ezUDqi6eB40dpSL7xf+l04HFF0vP8Mm/GVHaCQf8UpygkuzhELF6j3AmY+mMCx03yqXZlNLV4nA5uvbX/nPAoH0wFf8rnQReJfOsDBt21f9e9AeIHg7oNEzwq+JeupvwVMqUf6vojW74HC7/KCQrvxJLCZZtA7hQ98biD3WwFT4JIZAoZyqKjUchBUTdA1wN/PzrGypKuUByjAmXz3QnIo6+2pVhes6O4B9D+hcyhVN1c3g+h6hgOmJflhg4J5lEV22TGLXKtIDnmH19c2iQPAfZfXDR5DsQGTMutIPj+WcuCtq86KibvViFhe2KLPWWjkyo12Gq6u1ijrxks+XnUfLGz1yx4ovAOewz5xqjCQQdDcOL9HIh9pUNpbA5WkNcZVyDfubrRZQUHKZoO0xN8qBRfRJqr91LtRjwab8VnPTlkQOHzpGSNUCwh7oRsud/x7mU5h8/7FCAdKd1jDpnPkMDGxaqXZqWb185B02s5AEcTET63qozOARN2ewn9d8viRYnOUb29AwUuktKSdRD682wRwJZe3Vpy0vSd8kw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(396003)(136003)(376002)(451199015)(46966006)(40470700004)(36840700001)(36756003)(70586007)(36860700001)(86362001)(5660300002)(2906002)(1076003)(186003)(2616005)(15650500001)(426003)(81166007)(16526019)(336012)(82310400005)(478600001)(7696005)(8676002)(4326008)(6666004)(26005)(316002)(356005)(83380400001)(41300700001)(47076005)(110136005)(82740400003)(40460700003)(8936002)(54906003)(40480700001)(70206006)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2022 16:24:03.0718
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae5d1617-25a4-4b2f-7783-08daaadbd866
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7624
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index 8d99714022e3..a4683fdddde6 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1472,6 +1472,44 @@ static int amd_pstate_epp_cpu_offline(struct cpufreq_policy *policy)
 	return amd_pstate_cpu_offline(policy);
 }
 
+static int amd_pstate_epp_suspend(struct cpufreq_policy *policy)
+{
+	struct amd_cpudata *cpudata = all_cpu_data[policy->cpu];
+	int ret;
+
+	/* avoid suspending when EPP is not enabled */
+	if (!epp)
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
@@ -1508,6 +1546,8 @@ static struct cpufreq_driver amd_pstate_epp_driver = {
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


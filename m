Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D41D65F89F4
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 09:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbiJIHMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 03:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbiJIHLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 03:11:47 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E472A3336B;
        Sun,  9 Oct 2022 00:11:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e0kEvmq7Fu7Q8VQY2WaFXM3f/F3KMZMAFi/eqVg84WsAnKjMuDgC3II+3nIbD3It8t4rqkroWm/ZpfWh7oAkuo83AtsQ2SnJy+7UEMCH9dWC+G5LeWiAudcqMPW1Um/lEHiuMzg7IpY5Es0UkKfLOWLcvZ+aueGrEbX6PkcMBkiDH89SDmj5mcvq5FSup6049XKd3KtwRmR+umJmVcPDxq/af8zpPolwNaTqwbh4szwlQ5+lMong0Jr81ND0JyT7DEODDBPDguyGto2+T8DzAmujaURx8m+WRQN2EfwLfjJlPisQjGnRz4TyUnM59VDeQdX4kPeaS64LtGFx4zSrIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YmeL10S28uUxf7CpfSdZCwsk0jld7opG7DXjhiKE7Dw=;
 b=Ks6H4RKNd5tfeZ/7zgdQkoOtpCSerbsnLIFaz5gH713RUOt3h6vUcdQZ2vciWJAY89QjjDZJZGb508vdLjMJnIep+UCmeppBDyNSlN+vPykbAT+ppsVas7O7FHdQE2Ycz1aE3X1kay1Fe+jWL88lEmjuO9z9A7pzUh8bCaHp/4mDt+ZhzQceRj+kN5NiICCat1PyPYZv51G4qsM9roI7ITHHbWxutTnoJjyFsQFesT6wnMdjd1/skJmI/SQ7tFCl4kdE5RpTycYPJHTEXr7X8fUQzq5uYY/CtSkrp3BW7FhExWKk51+0UBbkSyi/b/9ibepyJPP/VtAIhbhfw58D8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YmeL10S28uUxf7CpfSdZCwsk0jld7opG7DXjhiKE7Dw=;
 b=L4JfLYdCoqzP+4iAcUwTSZI1YseYJDX1r94fEE+qWuMByc0grZXlPfC6sy+2ipukr6iDxM51jykayjs89a17HHtbMF9OYtVmlNVW3d6zfApMGSDTE3ohLI32CIsHvwxT5+/rB1Hd5VZmvfx8xiD8S7yZ4DYFXj+TLaC11Uv7+AI=
Received: from DS7P222CA0004.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::14) by
 BY5PR12MB4260.namprd12.prod.outlook.com (2603:10b6:a03:206::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Sun, 9 Oct
 2022 07:11:39 +0000
Received: from DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2e:cafe::a0) by DS7P222CA0004.outlook.office365.com
 (2603:10b6:8:2e::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15 via Frontend
 Transport; Sun, 9 Oct 2022 07:11:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT046.mail.protection.outlook.com (10.13.172.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Sun, 9 Oct 2022 07:11:39 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Sun, 9 Oct 2022 02:11:35 -0500
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <ray.huang@amd.com>,
        <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Mario.Limonciello@amd.com>,
        <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Shimmer.Huang@amd.com>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v2 9/9] cpufreq: amd-pstate: implement suspend and resume callbacks
Date:   Sun, 9 Oct 2022 15:10:33 +0800
Message-ID: <20221009071033.21170-10-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221009071033.21170-1-Perry.Yuan@amd.com>
References: <20221009071033.21170-1-Perry.Yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT046:EE_|BY5PR12MB4260:EE_
X-MS-Office365-Filtering-Correlation-Id: 42928b30-f3a0-4e9f-4c13-08daa9c582a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cQlkZJzXs7byXhbSegSLMFMzpdbnHgW3HOcSN1ptQZDRvX4X22qL1MLGbYQ67EZNJWzOYaX2uBabC5eAviB4h+/RVZeo/8rltE6dqvyRueHP41wTjA8VE2EZIG9I0T1kbraIkqiITdhU0ZTD9zH5X+TupfQJp9wXSRlKfScnzGhLYJ3ulbBn1KTkcjLWfr2tSkjDitpRVoGCyB5BXflos85X8GKkEyIvIRN32NKwDio5o9q/+gZi2qUV77sEVbW9Sl4Sgdm3HQX146kNZ/qUsngXPzqrdfCaadBkG/D27imoWqcE5ccPfoplDf026rkkshjHFD9OkBgpjLOJm3KVWsuT02TfWnQyNeLv54N39xPODCUxgwAqyrFef2Z6NOj9e5FWnzDpgFMj3z4M5uWddYWa3xK6Ep1kz4pfichBwmf96D8t4dKdHaYawrSRh9REHd6kh0yhnTuSYGlgdAkn2mJax6hMWQTDOqDOLDRU+Km55ueGDKe8xBbImiHcT5ldA48kUvW5fEhT2W1Bk7DEAkMqBmUdaS97mpoBDJzujRIlG/wmQXN+ADjX8fLHDaGMIWFTUge0Pv6CLtLHLxJo16JjUDFsEPrYvMKMN5xIHST5BNXQnm+sDulVuF9YK0YWmo6xnUIV+Rc4cTj29CylzD00MdiSpYcsgE2yL4MVzjt186qRA7B4qGNvd7nHhRDlxWYkXcbBd/lKyJSC/FN9e4u0rPlZSy8VUNvS9jCLz7RJWY9AQkeupM64MIV962smHgDQJ5EXUHTjBdZRn3rC2jb2mdQKm5AKjvYsCrXBLFx3YEeX9vSOr0Q+HFGupZpfYnFTQAU57OFANtpK5dw7XQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(39850400004)(376002)(346002)(136003)(451199015)(46966006)(40470700004)(36840700001)(8936002)(426003)(81166007)(47076005)(82310400005)(5660300002)(8676002)(4326008)(41300700001)(2616005)(16526019)(1076003)(186003)(70206006)(83380400001)(70586007)(336012)(36860700001)(7696005)(36756003)(86362001)(478600001)(356005)(82740400003)(26005)(15650500001)(316002)(54906003)(110136005)(40460700003)(2906002)(40480700001)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2022 07:11:39.1506
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42928b30-f3a0-4e9f-4c13-08daa9c582a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4260
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
index 1a3ecc2e148a..f93336f69756 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1473,6 +1473,44 @@ static int amd_pstate_epp_cpu_offline(struct cpufreq_policy *policy)
 	return amd_pstate_cpu_offline(policy);
 }
 
+static int amd_pstate_epp_suspend(struct cpufreq_policy *policy)
+{
+	struct amd_cpudata *cpudata = all_cpu_data[policy->cpu];
+	int ret;
+
+	/* avoid suspending when EPP is not enabled */
+	if (!epp_enabled)
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
@@ -1509,6 +1547,8 @@ static struct cpufreq_driver amd_pstate_epp_driver = {
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


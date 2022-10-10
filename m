Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3EA5FA1E0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 18:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbiJJQYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 12:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbiJJQYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 12:24:19 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3055F74E2B;
        Mon, 10 Oct 2022 09:24:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bDa4sRXeq8G8GoARgjJMRy/E+sU0PXg/5550MfFflbkc5LwaTYXOsqTcfYlgA4zfPuaTHTvDJQ22Vv/ebEgVB6us6nLfzSWW+xTcdRcP4M2CZuUUAhv3J+aUvEW5zpK8OnsOhWKLv2GMqwBonuuydWJQSO3jsd9qPbKtx9FYZeldHkZzV0n38L9hJFn7Fnm/UrYTrXz8iPN7qkx2Y/4OKGKP+3wkzvlc8E08XmZ/1R8hdi91WtiiQNHa0INPfjU52MXXu/EiiFRUGt80Z1o6KkDrIEf204Wp5KIbPTK+SdqUSXkqRfofxfwFc16HIzz/nPlub17gmnEe0CaCBxHn8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j6RbdD8vP0cLK2zF7xu4BeRvcrSsOKQNDYJWAbz+HX0=;
 b=jk5oBZOb/4Kcy5ncpRsu3zLfsnpfCowVCtn5aAGSbSJfKv2/LE3KaUy2B/IJM+0D9dj+TU4W4faVbyl+ly81rPXP0NAsFKftGgADQyDoV5DSQXZLQczA6KVyYyIUyLcCnGwW/4t6P9XqCIdEzfXgVXHyUNw+NOmiHDs2YeyAUZN0S+VcMzadGx7JwsJoDKxa5b/oQlULEtjw4Fjgj8x2nY9yURMUstU+aPgjMewEp8HppNUkJwW65Mn18Ui0xFWtYd5iHwOjFOUQd+ivrnR0tAzkl82hBKKp9qT6KPcQmdz7ijsKQ0kDEpcWyTVTz/ScO8wXzl5aCaKu7bHPCal+Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j6RbdD8vP0cLK2zF7xu4BeRvcrSsOKQNDYJWAbz+HX0=;
 b=0FwsydWmSJ77B54+3m2fYUWX3VnB+ElFs9UnnryR4KYpsZ5wywWEmUQSEEjo3ZXWaJ0sGSSHt8ukZrtpoF9Wk8HELKjmgUzK7saI4MAeZeNuglGeFItAdc/jmR4qL6axSf8pxswLr+FJCk3P01zavT8wiwv9ThgwyJcUKY0ZsNA=
Received: from DM6PR04CA0023.namprd04.prod.outlook.com (2603:10b6:5:334::28)
 by CH0PR12MB5233.namprd12.prod.outlook.com (2603:10b6:610:d0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Mon, 10 Oct
 2022 16:23:52 +0000
Received: from DM6NAM11FT101.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:334:cafe::c5) by DM6PR04CA0023.outlook.office365.com
 (2603:10b6:5:334::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15 via Frontend
 Transport; Mon, 10 Oct 2022 16:23:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT101.mail.protection.outlook.com (10.13.172.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Mon, 10 Oct 2022 16:23:52 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 10 Oct 2022 11:23:49 -0500
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <ray.huang@amd.com>,
        <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Mario.Limonciello@amd.com>,
        <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Shimmer.Huang@amd.com>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>
Subject: [RESEND PATCH V2 6/9] cpufreq: amd_pstate: add AMD pstate EPP support for shared memory type processor
Date:   Tue, 11 Oct 2022 00:22:45 +0800
Message-ID: <20221010162248.348141-7-Perry.Yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT101:EE_|CH0PR12MB5233:EE_
X-MS-Office365-Filtering-Correlation-Id: 2542afca-388e-43c6-aa46-08daaadbd22f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x5lYdbT9e/O5ejiHre5WVyWAt9eVNEKSaKreM3mF4ypcdTvOy7X8YHEkixnv1vLy08IR9OulFTOxv4J0nd4vpSa3D3MgBrTwdEtxddEMw006u3jgep1gz+uyeSrAu3VUIo8C7nVJCw89dpMX8Uj286XjlJk8TjnmZ7i5ix0MHbZMZAxw86ICenjYxy+J8Z4Qc+An6THiapT4N6rUk7gWRDlQLICZDuYxubGePw2Xgc+K4/ONQTtnJv0nHNJr/XzimIOkKpSDWRe0H4Y8mkwsi88R9CbvIRlLtvgVN35ao0cDmKpO17ddxqmO7xFzawwXTBTcbtYcESXTDik3dYey1zxAuUrW9SGCTetB1hc3VK7HI372mpLiunJdJD4fVWrJyz4kCa/EAMg+HOHtKnIo7s2c0IQruKYwKOUN8nXX7lRjjfwllSoCCGot5V9qi+Zhle+z+SW/CzVZpcoxu+OqJlXIOeWDdSOidadHJwLPoj3qusXW0l0/LP/c2t59E8OAdfYNL7sCEFjKqAO7QAR94ornHIUwtfYRyoEinF26fkOqNwpRfuyubTEd3jQLRH1mdPng77adUS8fttKmf4JNI2/uYWFSagwIWwbc0hEAWuMhIt/Ox/JjtyGv5IyB4lvHEhiYIA1MSBTjpah2/Mj0SoDzwTGKG3THPbkOjiiUFPwWnx+Pqj5CQ2Nxc3gu30rib3b0CuzUlV+AGW318OfX0IOJ5mNEYYnsUlsaKD4VAJMozh7wu9koHnkC++XLBycATzc5YsJEhdK//FGivStDQU59yR2WrkoaEo7jzMTx/BMNGP9TrqgEnB2Ek+mMqLyugHqbSgpxmCVNboezf7RWea7mSPmoGwy0hC05d1tB8R8oH5wqR5SFa+AMPtCkRxy+
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(396003)(39860400002)(136003)(451199015)(40470700004)(46966006)(36840700001)(316002)(54906003)(36756003)(40480700001)(110136005)(82310400005)(186003)(5660300002)(336012)(16526019)(1076003)(2616005)(426003)(40460700003)(8676002)(70206006)(70586007)(86362001)(478600001)(4326008)(26005)(6666004)(36860700001)(81166007)(47076005)(2906002)(8936002)(41300700001)(356005)(7696005)(82740400003)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2022 16:23:52.6464
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2542afca-388e-43c6-aa46-08daaadbd22f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT101.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5233
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Energy Performance Preference support for AMD SOCs which do not
contain a designated MSR for CPPC support. A shared memory interface
is used for CPPC on these SOCs and the ACPI PCC channel is used to
enable EPP and reset the desired performance.

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 2d28f458589c..08f9e335f97c 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -135,12 +135,25 @@ static inline int pstate_enable(bool enable)
 
 static int cppc_enable(bool enable)
 {
+	struct cppc_perf_ctrls perf_ctrls;
 	int cpu, ret = 0;
 
 	for_each_present_cpu(cpu) {
 		ret = cppc_set_enable(cpu, enable);
 		if (ret)
 			return ret;
+		if (epp) {
+			/* Enable autonomous mode for EPP */
+			ret = cppc_set_auto_epp(cpu, enable);
+			if (ret)
+				return ret;
+
+			/* Set desired perf as zero to allow EPP firmware control */
+			perf_ctrls.desired_perf = 0;
+			ret = cppc_set_perf(cpu, &perf_ctrls);
+			if (ret)
+				return ret;
+		}
 	}
 
 	return ret;
-- 
2.34.1


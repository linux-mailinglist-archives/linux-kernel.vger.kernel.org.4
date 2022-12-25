Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCFB9655DB0
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Dec 2022 17:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbiLYQfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Dec 2022 11:35:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbiLYQfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Dec 2022 11:35:32 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A67C60F2;
        Sun, 25 Dec 2022 08:35:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NKoZMtuCo1poWN6NKHpljutfYhW0TbSWd5WduK3fTQfPGkUSg7BADeYHrbZ626R3llrvWHGl5GxeYkdldqFIvbAa3JCHYmSRmXP1HPbNKqjlh6Y5qZTZvG4YDOeFue79BYluzCt+lyrTHitd/1gqmqwLyiSKTdAIUP0gxO5cu3CoI1utU5yA4LQCqxWSyo2QAfgUS8lOR9l7kgQMlsf9JSfJMWpwM0HgH7BurFtdR9RFg0s8IMPcp1qcyJXufL/qV6LJR12qMtCg+RM0mMmQ4t60WZiGOwRCsWLjWL7z6ZxYwaA+xSZSPPSjkzZ11DzcJR7WzG1MBvRbRbtpvU33Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BKXpjY9aYWFFLNIkFsMgRO96SSIU4dgItG3vbJMFxj8=;
 b=A4MRKa3r27O0Pi+5cOWinolvyYDUkAVrF0LIYqUW8Pb/ij5DJ04G8XZG2V6wfnhURPHyRdSWEqbgDZrZBYb7x0Ns5RiLKWnDXHoMfgDKWh1K/8dEoguVUc4PpmXHhzPw7oo1hvu1K6cMujW73HlttlEQh8VTnW5acNqKK292N/HuQTHDWAXP95LkVCofYB1JqPxGMt6jXmFCB+Q6zXY+5LcMv0jV1HolVH73OQ/PadwoW7TOAfxCNrxluVDZpQSHJKkhQqpNFwyhIlaWTCB0lQrtyH+wqfCcVCS5tXiObvCiECRYwpQ03Z9Bnw3Ye24QcWab4eh2G2qblhGFrhuknA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BKXpjY9aYWFFLNIkFsMgRO96SSIU4dgItG3vbJMFxj8=;
 b=IxyaAxJlkkhfOw0zz8bBIufRrkTIlRL72UXcBzqm6SSs5d7N8nj3NNPEK99H0WIhqjwyuvr8kj2kuK13IrfozrCPKoZFKa5n1MBBTYxp1o/9pHkNZiI7h+MBnH/1pLYxTv7E1kppwEOhqrbKEGyP5oEdjveR4ru7sjxy8LauQVo=
Received: from MW2PR16CA0049.namprd16.prod.outlook.com (2603:10b6:907:1::26)
 by BY5PR12MB4949.namprd12.prod.outlook.com (2603:10b6:a03:1df::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.14; Sun, 25 Dec
 2022 16:35:16 +0000
Received: from CO1NAM11FT082.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::4f) by MW2PR16CA0049.outlook.office365.com
 (2603:10b6:907:1::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.16 via Frontend
 Transport; Sun, 25 Dec 2022 16:35:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT082.mail.protection.outlook.com (10.13.175.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.16 via Frontend Transport; Sun, 25 Dec 2022 16:35:15 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sun, 25 Dec 2022 10:35:10 -0600
From:   Perry Yuan <perry.yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
        <ray.huang@amd.com>, <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Nathan.Fontenot@amd.com>,
        <Alexander.Deucher@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <wyes.karny@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v9 04/13] cpufreq: amd-pstate: fix kernel hang issue while amd-pstate unregistering
Date:   Mon, 26 Dec 2022 00:34:33 +0800
Message-ID: <20221225163442.2205660-5-perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT082:EE_|BY5PR12MB4949:EE_
X-MS-Office365-Filtering-Correlation-Id: 2775602f-91f1-464f-e95d-08dae69600cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sEO9h7c64vS7wrmDp1FZWdt3qTbZzkhIpbZ8X13q8i48wTW1bylnfdoA/6aHqLRZartnOslWfrVUTpnz9ZCcgTsTmX4Z525PhwQJNiczzrtBqp4xxV6z5xnfpe7YkCyWCHrwWyfUc6DuXGiMfKizukvTontxDXJwLSKc6fBV+zfewpPkX+/8U82NWOcQOYB4Bh/q0sy1kgMROQoEbmidx5h6Dt1VA4oMELqZVreq43FitMRj7zbJIC8KuJUDd5aPoOHfZHMmC4sJgEH1KdSnKbFv7CD9FlyhHk7KMxAtpqqaFM63xveq8JAVAwpQZVRZR1sVjyh8Gw1op8vMAIqlBnO4L0z0U7fY5IHEK7vIIRLYHIxDnyanMkofMKa8B/gpppVvJnGfZZ0uoYntge3Qv+sCDhytcQBiWYq9FhIeMQtAutkxFD+50vDYFYZfpNjGwa+B81zsV1E0a/b7VB4gwpSY3HXlz1+ZPLnZnthQcW/qa0t0SCPpaxyfU0MTB/ZChykkjXHjA+KuAnTGnY06Yqicubya4ejEU8iqRYJtbdXsJAHKB6DuK8GcJhnKKb+h7667a7Y2SeciZ3ztmL+MVf3Jw6PqCPVs4uPi8AGTmpEKJSVRt85NFhAQFrC9/LCDU1M9e8Lx62lE6XtdNTwgP4HSY0LavqWT7XKNODKaroQuPaawXdXtkMiOi9mb32SesU7ugkcCrE8H6ibK3LHv0umKb2c3/ivDqMIXST5poq8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(39850400004)(396003)(451199015)(36840700001)(40470700004)(46966006)(70206006)(4326008)(70586007)(8676002)(478600001)(6666004)(36860700001)(36756003)(7696005)(40460700003)(54906003)(110136005)(316002)(186003)(26005)(16526019)(82740400003)(1076003)(2616005)(2906002)(44832011)(82310400005)(40480700001)(336012)(81166007)(356005)(86362001)(41300700001)(47076005)(426003)(8936002)(83380400001)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Dec 2022 16:35:15.7605
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2775602f-91f1-464f-e95d-08dae69600cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT082.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4949
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the amd_pstate_adjust_perf(), there is one cpufreq_cpu_get() call to
increase increments the kobject reference count of policy and make it as
busy. Therefore, a corresponding call to cpufreq_cpu_put() is needed to
decrement the kobject reference count back, it will resolve the kernel
hang issue when unregistering the amd-pstate driver and register the
`amd_pstate_epp` driver instance.

Acked-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Cc: stable@vger.kernel.org
---
 drivers/cpufreq/amd-pstate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 204e39006dda..c17bd845f5fc 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -307,6 +307,7 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
 		max_perf = min_perf;
 
 	amd_pstate_update(cpudata, min_perf, des_perf, max_perf, true);
+	cpufreq_cpu_put(policy);
 }
 
 static int amd_get_min_freq(struct amd_cpudata *cpudata)
-- 
2.34.1


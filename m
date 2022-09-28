Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41D845ED9A7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 12:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233666AbiI1KAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 06:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233539AbiI1KAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 06:00:09 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E32D15E335;
        Wed, 28 Sep 2022 03:00:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MkUv3tXlIX3L/9sKXc21m6oflGatdDftmuVhE8PMqr1Zhc3N60zvIOuiryCgOH3v2KTqguMJh5CDngB0eFYDPqmmNBuH1ki4N2U9gxKrHgFU2vsdHIusAaQjVjy7bPeTv3q3G0q6ajJXlNBLsn0ln7gRSfQFPLWrQ1eTVfE8gsO2x2D+9T+wjBofGOU3qCCyqvVTzMGVdGgeL93QpN24TDkDWgod8b4dmQOkjLyydee50tP1EaVzxU4i6pi++7NGUbRp1ZSX/9I6o1pijes+xUMP+R91YlxUhTfjriOElMk55uthPoN/BzFZXmHYwMSeiVYgYPnmEZCsGNa86JN9ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2sOPt0bO6ePZdgEBUWiyAQ9WgPZDi7UePYKR5Z6quyA=;
 b=m26xb0wX2EX1SsNkL3IA+XiD8/O14WDGFc51+tQsj3GTKMWXQx3l3MrDfDd9lCWBdKkGk8eI84Q+U0/8bo/BQ9JaIdMt/I6uQbkHBQsgfEMoURMy9GIZuHvjgtTNbwy02XC0E5rHU5vrHs3ec/70TtsV7wEVJ5VHDboyoAv8FINYqazsEH69pA6/N0AA2xDRsIM0e3WcmMKIliO7BropHQ+DAJSI3+dHvhBAGfg1lLzUgPPAnd6Mqy7Ggyj+VIqiWJ0SwQCqXXS138wAnerTyjKO9ZkZSLYerW5y+8OJMISRAYr1wFehk+YYKhXKgdvJARcgmNZc/qkPXu3iOLLWJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2sOPt0bO6ePZdgEBUWiyAQ9WgPZDi7UePYKR5Z6quyA=;
 b=z+1J0uZNTvUQSR9YrL7Ko/rirNPh7I8sLoNkkEGWdBlBfzGP4P3GL4ZCcxQrJSd+jfRz+JcB6vkZ3zlony/hS1t14s0ZkepEV7EqbpMXd1qXVHusy6yE/RmuUlmA5NGSZgvuEXW+IuL8SccqMTPlL2zxoPg1NN2lk4vf6C/2gtI=
Received: from MW2PR16CA0070.namprd16.prod.outlook.com (2603:10b6:907:1::47)
 by BY5PR12MB5510.namprd12.prod.outlook.com (2603:10b6:a03:1d2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Wed, 28 Sep
 2022 10:00:04 +0000
Received: from CO1NAM11FT087.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::95) by MW2PR16CA0070.outlook.office365.com
 (2603:10b6:907:1::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.18 via Frontend
 Transport; Wed, 28 Sep 2022 10:00:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT087.mail.protection.outlook.com (10.13.174.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Wed, 28 Sep 2022 10:00:03 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 28 Sep
 2022 04:59:54 -0500
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <peterz@infradead.org>, <acme@kernel.org>
CC:     <ravi.bangoria@amd.com>, <jolsa@kernel.org>, <namhyung@kernel.org>,
        <eranian@google.com>, <irogers@google.com>, <jmario@redhat.com>,
        <leo.yan@linaro.org>, <alisaidi@amazon.com>, <ak@linux.intel.com>,
        <kan.liang@linux.intel.com>, <dave.hansen@linux.intel.com>,
        <hpa@zytor.com>, <mingo@redhat.com>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <tglx@linutronix.de>,
        <bp@alien8.de>, <x86@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sandipan.das@amd.com>, <ananth.narayan@amd.com>,
        <kim.phillips@amd.com>, <santosh.shukla@amd.com>
Subject: [PATCH v3 06/15] perf/x86/amd: Support PERF_SAMPLE_PHY_ADDR
Date:   Wed, 28 Sep 2022 15:27:56 +0530
Message-ID: <20220928095805.596-7-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220928095805.596-1-ravi.bangoria@amd.com>
References: <20220928095805.596-1-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT087:EE_|BY5PR12MB5510:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d171474-0718-48cc-f178-08daa13836f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a6C3e9oymgw0yNFiPya7kLV2pNMpojV+c7uMqd100pNNT3GhtJ/MMwdl9705hI84cWPgWOUR4WOqeT600mf6yun0pNt/GVbL2ACE5iNCpI1Bcr2KtBmStY8FLsn+d9KFFM8DOnaJHqEJ6kqhoQXS9hhbJ0JhuZZU4vTdZ00iAm1N+fLcJAsdevolKr4LKqvPn91LmLeD+lNhp/RVv7CM1+E87ai9ZSGy6RTHdvhvWEyi7vC7Pi5N6ASpu/Hqle9TTjzPFLoH+9d7oxD7dwJUT9AU5m1LfEJ8B7UvihdhoNBt00roOoJzrv9SmgEx04vLMFd7CAqGvE8fr4ExgPin1dPjEV1d1UAT51jAUnmCtgiNxJdsql/O2dq5YRTqLGTB83WAxuXeuOHKu2tgqNYd+Q2zAK9leZnAMSAggocxpiBF36FuHxNrT7rbOeKV4n5z0Fec2K8cJGDRIafpnnICSNiL4m4xf53rGjyh8gySEzxMXXj4mQBYWCTQEF+ba/BkalnXOWu2txnBsWO2VGAXv4HaMOJyRVKyD90AUenp73CJnE0OxWx/CAywf2f12vi2Tmv6yVBWpHsO2BZ2/p1MQYhGnEWtYun8iSQc84a3pJU7I5BC86dsM4YPvd2mAOSma9jKnncqF3zy+6K2zWgPJoy/rILOGo2oAXiGvd/ek2NLaz3KmzyNXX9bqaZ7p3vabQOnCSZznVki8RATa6iCastq+bGk+fOmqRHdnK6qG26W0iNdyOxcWY1bAmVvWv/qhhDREUp+mo8tAvdqSeaAhS1KpZ35QZfK4cSo+QQfolWtzwGtydXgzmhHZVfomcpI
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(376002)(346002)(396003)(451199015)(46966006)(36840700001)(40470700004)(36756003)(54906003)(110136005)(86362001)(82740400003)(81166007)(47076005)(5660300002)(36860700001)(7416002)(356005)(83380400001)(1076003)(2616005)(336012)(16526019)(186003)(426003)(26005)(4326008)(7696005)(316002)(70206006)(70586007)(8676002)(478600001)(8936002)(82310400005)(44832011)(40480700001)(2906002)(41300700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 10:00:03.6799
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d171474-0718-48cc-f178-08daa13836f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT087.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5510
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IBS_DC_PHYSADDR provides the physical data address for the tagged load/
store operation. Populate perf sample physical address using it.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 arch/x86/events/amd/ibs.c | 8 +++++++-
 kernel/events/core.c      | 3 ++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 0ad49105c154..3271735f0070 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -989,6 +989,11 @@ static void perf_ibs_parse_ld_st_data(__u64 sample_type,
 		data->addr = ibs_data->regs[ibs_op_msr_idx(MSR_AMD64_IBSDCLINAD)];
 		data->sample_flags |= PERF_SAMPLE_ADDR;
 	}
+
+	if (sample_type & PERF_SAMPLE_PHYS_ADDR && op_data3.dc_phy_addr_valid) {
+		data->phys_addr = ibs_data->regs[ibs_op_msr_idx(MSR_AMD64_IBSDCPHYSAD)];
+		data->sample_flags |= PERF_SAMPLE_PHYS_ADDR;
+	}
 }
 
 static int perf_ibs_get_offset_max(struct perf_ibs *perf_ibs, u64 sample_type,
@@ -998,7 +1003,8 @@ static int perf_ibs_get_offset_max(struct perf_ibs *perf_ibs, u64 sample_type,
 	    (perf_ibs == &perf_ibs_op &&
 	     (sample_type & PERF_SAMPLE_DATA_SRC ||
 	      sample_type & PERF_SAMPLE_WEIGHT_TYPE ||
-	      sample_type & PERF_SAMPLE_ADDR)))
+	      sample_type & PERF_SAMPLE_ADDR ||
+	      sample_type & PERF_SAMPLE_PHYS_ADDR)))
 		return perf_ibs->offset_max;
 	else if (check_rip)
 		return 3;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index e1ffdb861b53..49bc3b5e6c8a 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7435,7 +7435,8 @@ void perf_prepare_sample(struct perf_event_header *header,
 		header->size += size;
 	}
 
-	if (sample_type & PERF_SAMPLE_PHYS_ADDR)
+	if (sample_type & PERF_SAMPLE_PHYS_ADDR &&
+	    filtered_sample_type & PERF_SAMPLE_PHYS_ADDR)
 		data->phys_addr = perf_virt_to_phys(data->addr);
 
 #ifdef CONFIG_CGROUP_PERF
-- 
2.31.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 629E85ED9A5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 12:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233670AbiI1KAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 06:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233650AbiI1J7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 05:59:51 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE7E2873F;
        Wed, 28 Sep 2022 02:59:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JP39VtrDa7jP2LNLBTDCXCygjy3ABvbn79O+Afje0m074Ov5ZcBsqHhbxrT1ebbO2Fsvv8X6BlvbCyt0g2/fGe7gIQDg8kkha6DyXWhx/+tz5vrzdX3mVNlTqJDT9Luqn5znrQvSfNIze0E01t9LboNofUwgfyGahI4eJtfigvcbIAMqfer4P6yOmCRXfw3ewJRbKp4JgspU6sDfqiu+zMV9pCVhVYJNdR0mMpPGJs5Ug5738ckv7Qj9GgbQBKeFtnrZYiJEWBSRFjdYklj0H8Oirm1y3GYywXJh3CZx7QFoCdDEy8mlCMbWMmS03QgnV0/Hzlb2whk7vyCTZtGOdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JcgdDoBYaGORrvGDjEPp3YyTL6H8XDpZN80WK0p/LK4=;
 b=DEgYEftIgaXp2kdfdYq6NTgkWBmK3v2re/M+hmXDaHc88jtYjUqb21JGOcWGZt4aETjV0/R63hh55DqG7yi2FpRs8u6Z/45S17Snu5XbkYZkEEmp5BeNjw0In3aZ4+utSmQ+AdVqWstYXoBg+jD6xRgnS7eyecw/+aWB+JOKOVCnK6q1fKA33GZACOqAxvZrRbS5yVPGBRABzmCvvFVs7cKn3vN16K5ehxeiiulC62CdzpHhNCDUKq5gzmyi0ZU7pAWW+kUsnGH2ttom76Uu+wZ/nqvbqvG2mvaU0fbj6J50rsNNMmnx8+8WTOcpRykB2T3/LNDQX6EDfFGAdHBXGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JcgdDoBYaGORrvGDjEPp3YyTL6H8XDpZN80WK0p/LK4=;
 b=Ppe5nyLWXQq1Cw4Nv5sOQRRsKZnrNubGcsEJfmtHArvhE0RS5LugPeRDLCJS8x83393NU2QWcNuaf+m896SigFarqTQU5oFYuHuBE82awP5IHG7Jh+B3yWcGE/OzWpoUUMsK3Zr1BGLDjdOodLWmKXfddL/ZiWZ7fuaP8DT96Wk=
Received: from MW4PR04CA0041.namprd04.prod.outlook.com (2603:10b6:303:6a::16)
 by CY8PR12MB7755.namprd12.prod.outlook.com (2603:10b6:930:87::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Wed, 28 Sep
 2022 09:59:46 +0000
Received: from CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6a:cafe::8a) by MW4PR04CA0041.outlook.office365.com
 (2603:10b6:303:6a::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17 via Frontend
 Transport; Wed, 28 Sep 2022 09:59:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT052.mail.protection.outlook.com (10.13.174.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Wed, 28 Sep 2022 09:59:36 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 28 Sep
 2022 04:59:27 -0500
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
Subject: [PATCH v3 04/15] perf/x86/amd: Support PERF_SAMPLE_{WEIGHT|WEIGHT_STRUCT}
Date:   Wed, 28 Sep 2022 15:27:54 +0530
Message-ID: <20220928095805.596-5-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT052:EE_|CY8PR12MB7755:EE_
X-MS-Office365-Filtering-Correlation-Id: ececf9d1-f1d6-4e0d-fcd6-08daa1382cbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ihTgr03x8GyUIxR1C94ZsAfM7YndGmFxgEvWwH9ozDAuKgCGgrZU6wAlgBenGxGJ1IkqPsZJbTpPkbW1WxYHOE5ih8nhlC7DZLG8nqBlXW4DTA5Qkz53IYFFua4D/S4quBg04mFj1MyESS7iG7DGC3ZlqVujyULB5crnO3ws+4bvZ5ZONI7t9PZRW5uNRZAyPRcYkXwYg5LoSyCv8BscGG67k8kOJtDc80qt7R9bJPoGgA9FUsd1RO40UR3+aMEfdqO1xJsJTtAo025/fhYoo6HDYCdDts3c4kOyv0xBnhEmf1oIpHl9yfEjwOUzYFei/s2YBea8hb5Bap6/ezKB6+VGneC0I1h0gFFxD/bDjP1csmGgFYdDz43XLzqFk6ALBSe/znLLyyRe+nW495fscF+mi28wXwOtoR2CQl/GIj2+JpC7jRp1Va6BTbVTHNyxFJ02WwkhzvBaVzQu8d6ILQ5KuPhx8VNZiBXTdQxc3EyUxpdQYR9zPoWfG/1NGgWOgKo6D1KGPOpP2ozlrJ5tx2e7s3CracKo6tr8In6SkfDFOsIDgGjNispOGBVWwKoMy/iP3FE5PZ4qjy4Sls3VypIhmjo7oWi5NT3IstpIa628g6UZRASLzlQ5VSfEiYG6dQXgC+gvG1elqV+dDwBGJOVKupMnQeC8kMDJTqCT9Mca2hAWB7i86LL4l/NYD9hv1OxsgWAkftfSVFqbjBdtN5OkSCa0qjmXsqVv5/oCfCGYMQAycT2j9+HOdTsaxqyYq00sV3IftMaF0W7KrCAvNl4Y4HDgqHs4jrc2PnxZ3+irui5sS4XxSmy95qW1kc+zEuLvuEMymNboAVfvqR/mDxBcRwGWAp2GDOWpjpj+U0k=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(346002)(39860400002)(136003)(451199015)(36840700001)(46966006)(40470700004)(36860700001)(40480700001)(86362001)(54906003)(316002)(110136005)(2616005)(8936002)(36756003)(44832011)(2906002)(70586007)(7696005)(70206006)(8676002)(83380400001)(81166007)(478600001)(82740400003)(1076003)(82310400005)(336012)(16526019)(186003)(41300700001)(4326008)(6666004)(356005)(5660300002)(7416002)(26005)(40460700003)(47076005)(426003)(16393002)(83133001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 09:59:36.2166
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ececf9d1-f1d6-4e0d-fcd6-08daa1382cbc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7755
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IbsDcMissLat indicates the number of clock cycles from when a miss is
detected in the data cache to when the data was delivered to the core.
Similarly, IbsTagToRetCtr provides number of cycles from when the op
was tagged to when the op was retired. Consider these fields for
sample->weight.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
Note:
While opening a new event, perf tool starts with a set of attributes
and goes on reverting some attributes in a predefined order until it
succeeds or run out or all attempts. Here, 1st attempt includes both
WEIGHT_STRUCT and exclude_guest which always fails because IBS does
not support guest filtering. The problem however is, perf reverts
WEIGHT_STRUCT but keeps trying with exclude_guest. Thus, although,
this patch enables WEIGHT_STRUCT support from kernel, using it from
the perf tool needs more changes(not included in this series).

 arch/x86/events/amd/ibs.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index e20caa5cf02f..d883694e0fd4 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -955,6 +955,7 @@ static void perf_ibs_parse_ld_st_data(__u64 sample_type,
 {
 	union ibs_op_data3 op_data3;
 	union ibs_op_data2 op_data2;
+	union ibs_op_data op_data;
 
 	data->data_src.val = PERF_MEM_NA;
 	op_data3.val = ibs_data->regs[ibs_op_msr_idx(MSR_AMD64_IBSOPDATA3)];
@@ -970,6 +971,19 @@ static void perf_ibs_parse_ld_st_data(__u64 sample_type,
 		perf_ibs_get_data_src(ibs_data, data, &op_data2, &op_data3);
 		data->sample_flags |= PERF_SAMPLE_DATA_SRC;
 	}
+
+	if (sample_type & PERF_SAMPLE_WEIGHT_TYPE && op_data3.dc_miss &&
+	    data->data_src.mem_op == PERF_MEM_OP_LOAD) {
+		op_data.val = ibs_data->regs[ibs_op_msr_idx(MSR_AMD64_IBSOPDATA)];
+
+		if (sample_type & PERF_SAMPLE_WEIGHT_STRUCT) {
+			data->weight.var1_dw = op_data3.dc_miss_lat;
+			data->weight.var2_w = op_data.tag_to_ret_ctr;
+		} else if (sample_type & PERF_SAMPLE_WEIGHT) {
+			data->weight.full = op_data3.dc_miss_lat;
+		}
+		data->sample_flags |= PERF_SAMPLE_WEIGHT_TYPE;
+	}
 }
 
 static int perf_ibs_get_offset_max(struct perf_ibs *perf_ibs, u64 sample_type,
@@ -977,7 +991,8 @@ static int perf_ibs_get_offset_max(struct perf_ibs *perf_ibs, u64 sample_type,
 {
 	if (sample_type & PERF_SAMPLE_RAW ||
 	    (perf_ibs == &perf_ibs_op &&
-	     sample_type & PERF_SAMPLE_DATA_SRC))
+	     (sample_type & PERF_SAMPLE_DATA_SRC ||
+	      sample_type & PERF_SAMPLE_WEIGHT_TYPE)))
 		return perf_ibs->offset_max;
 	else if (check_rip)
 		return 3;
-- 
2.31.1


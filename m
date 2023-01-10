Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11CE8663900
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 07:03:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237523AbjAJGDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 01:03:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbjAJGCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 01:02:36 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081EA43D81;
        Mon,  9 Jan 2023 21:59:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cd8u+qdQ6lOztUP9zTvLlPd5CdtJ44aFtl12cwlwicHhF4px0BMgeYwaZ3JDmYg3bHXGCisT/XIusD3N7PZKEmKcFr02OceCKjWgavMjBWCkggdwQ/ok6Y+FSS2SGxvLU6xzuwxfi1sncZjYxhC6ogHUb2wrIXKcqjrm2DXgW6I3LLlWBopof78FG2XyGBBSEl8UvPqVZsNuSpg/rpXli6SHDMyiFSTavSshCEi9wBhlgPqWQCyuUMddI1j/fFlUQsWAKi4YjOKxOFAcnW2IJzsgmz09SRqskZAZrgP6yvKs6m9/Mz7fiMTFqlrM1NjwobGaPaRE8N+zO07wRhapgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q7XFZPF+OcYH3bkWrQyJgfGrfnOyP+E2XnDKaPAbPj4=;
 b=U0ijF+sOfnxX8oZyRgU6IFk/K2mWNShnxa6sRz4wLUgNqjYRDWhbMRVR8IQwfcjvsN2t+viWqPSvi6O/wRNAHBCKipXFEm8Y3QnYlDdYCyJ7Y7DtrYJwOHzOAOhD/DxoYydkbOlfbUrnvSWteDR94hDS9iwC/6IIwgH55lbhD9AmKrJCQYdfaORflRBwqj1/XPGR7WcOcklSCBdXq+e7eRZqri9OXgOALGMVV//+lik/2zvuqTFYQmq137zMMlXngwnA5/3SeXISCrDjF7qj+glsc7Tkp5BgPThuRRRJmWkMPgZxJPgJnxDthIxY8FtTYn9xSLQwDQMfo9yqhkkYig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q7XFZPF+OcYH3bkWrQyJgfGrfnOyP+E2XnDKaPAbPj4=;
 b=kh8OUIGUeB8U5ulMGarlFXQV7nVdhmwSuz2/Mly5dWIAAxDPhqQYql5ZhwCt7eAvyZj7/9HxJs18QA1m0JG69TyHXye3O8pJRrBP8U3zLq4mcWXMmOwpkpgf0+EyO7g3mQxaiWUutdotCmDFCY2oQyY5Kg4DRKvZl/BGxlNcN7o=
Received: from MW4P222CA0009.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::14)
 by BN9PR12MB5114.namprd12.prod.outlook.com (2603:10b6:408:137::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 05:59:34 +0000
Received: from CO1NAM11FT076.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:114:cafe::40) by MW4P222CA0009.outlook.office365.com
 (2603:10b6:303:114::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18 via Frontend
 Transport; Tue, 10 Jan 2023 05:59:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT076.mail.protection.outlook.com (10.13.174.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.16 via Frontend Transport; Tue, 10 Jan 2023 05:59:33 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 9 Jan
 2023 23:59:26 -0600
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <acme@kernel.org>
CC:     <ravi.bangoria@amd.com>, <jolsa@kernel.org>, <namhyung@kernel.org>,
        <irogers@google.com>, <kan.liang@linux.intel.com>,
        <peterz@infradead.org>, <mark.rutland@arm.com>, <mingo@redhat.com>,
        <alexander.shishkin@linux.intel.com>, <james.clark@arm.com>,
        <german.gomez@arm.com>, <leo.yan@linaro.org>,
        <adrian.hunter@intel.com>, <alexey.v.bayduraev@linux.intel.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sandipan.das@amd.com>, <ananth.narayan@amd.com>,
        <santosh.shukla@amd.com>
Subject: [RFC 1/4] perf tool: Simplify machine__create_modules() a bit
Date:   Tue, 10 Jan 2023 11:28:56 +0530
Message-ID: <20230110055859.685-2-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230110055859.685-1-ravi.bangoria@amd.com>
References: <20230110055859.685-1-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT076:EE_|BN9PR12MB5114:EE_
X-MS-Office365-Filtering-Correlation-Id: 179f1bdb-c033-4f1b-2865-08daf2cfd8a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N0H0fZDhpuqyqe2Kx51Z50EF6MrG+ErgDmeraGEVZJDRNCsASrtHEjq4GkKY+MqGBGvGX8u0vI1SH8/4voY91WeCOyMHxHgoRg1cZA+E0QKK7t69M342JFFLcoITlt4zesubsS5UUmch627kDbz4RPb7vv2y9Astcf1SaC8cUJIhLp8eJq6YaZpx2FXFypyGFVbzFRxyBLpov93yoiwIfkWkVluDGzomuckpv8nSZ0uSsQzAaJgpKpTQ636PBjf4vpq6WcRxB/x2B45gvb5534Xp26Yy1SAHbENml5HetqA9GwxvPrbHjJJUnd0X04n4HrxEd/kTVBBcpcEITkzGYMQ4+B8Su6zr+zbGSpImGPkIV3vwhsNkEiHn8H/TQ2MWOY6yyqq9US/MuFVASCsHIawu7Ty5WFOFuwvbLosrjC3Q0BeuSNQq+hTQt4ZGOm5ciuR6az9P+bxNrp1onf/D2irfa78XULNKK4/MQCwGBaEvqUgQ+nIRs9eQfOEFNzdoP6VPni/PL8aTnMagn2n7F1tjh8Kpspbv1FgUCXuvaqCprDpG14ocxs08OLzSLl9k5WBj3QQt32OHI1+AmFCaqCqfdm/DrhTTumjRipsU2BeUZVjV86IZYym9Y4n6PT0cL/FMNNelovh1wyIT1dNqGTeJdIfAA++NdTd2w+/+5NVgvB9u85jVlPACYEi9xgeSGGt4+Fi79moI6h9+37e87r8nkM7K925JrwsFpCAyJnonMGJM9NwDe8x81HODSuO+Tf6QnWgcnhcAgkCn8CjPAg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(136003)(376002)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(36860700001)(82740400003)(6666004)(81166007)(356005)(2906002)(478600001)(186003)(2616005)(7416002)(4744005)(1076003)(8676002)(44832011)(40480700001)(26005)(7696005)(16526019)(5660300002)(316002)(83380400001)(8936002)(36756003)(82310400005)(86362001)(426003)(47076005)(41300700001)(40460700003)(70206006)(4326008)(70586007)(336012)(54906003)(6916009)(101420200003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 05:59:33.2056
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 179f1bdb-c033-4f1b-2865-08daf2cfd8a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT076.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5114
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tweak this function a bit. No need to return twice.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 tools/perf/util/machine.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 803c9d1803dd..ab2919bc0a0d 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1613,10 +1613,8 @@ static int machine__create_modules(struct machine *machine)
 	if (modules__parse(modules, machine, machine__create_module))
 		return -1;
 
-	if (!machine__set_modules_path(machine))
-		return 0;
-
-	pr_debug("Problems setting modules path maps, continuing anyway...\n");
+	if (machine__set_modules_path(machine))
+		pr_debug("Problems setting modules path maps, continuing anyway...\n");
 
 	return 0;
 }
-- 
2.39.0


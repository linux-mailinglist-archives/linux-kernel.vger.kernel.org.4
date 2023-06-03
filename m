Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74717720DDE
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 06:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbjFCErn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 00:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjFCErj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 00:47:39 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2079.outbound.protection.outlook.com [40.107.101.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5097E59;
        Fri,  2 Jun 2023 21:47:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=efXdwnebSmvWPBKvQU87B4Pedb63wnSFGxh72SPadWdwihlUbm7u/DCbJ5UiWkmynfaBYbixAX3R+DR9Ze10rOfdaWKwZKl1x6wBmRJGOOgjd0Kmn9KPb2G5/CbYmD7u8MO9kWzldk1AT2OLA7e1TlX9B7H0OA0tOcii/nzWDKSOaTJDY6+mWi6rO9NclcJVIUv8FGZT+6Bzrtn+Ix/BBby0rYDjrTqjvPrymTrFQ2pz6NHiFE8oot9yBOqYhdEgLzl2D0jdYVoG8DUbdp1kkdQBbCZszcedSzio6YNo7Giux1yNt906uklJxDqpERHiTmAfT28VwCjk3rXxXm1PbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TcfodoBZiXE4glcugY3TSGUlbVkK1tiF7Db6xDO8Cjg=;
 b=X8pmYXikUi30bIy5FTRiAVotsYQXxBjJgEGQHFPstmYoSjjw84aoR0Bpn4aOFB5qINKFdPcWHjkszmQRea3nTFfaYXQsdLg+dMlKTZ1JBYVxBdqfWLu0zPqCRR1YhYyJwEObnoECr9jBgK01N/b3b/r29ErsCIXw4cafXZj4L2240iv+RAewsqHhVgHZTVZtTvZlJv5VYKs7br3C4023J2XMSxvn5lyB7r3ws3LXS2uJV3N3K5heJYuFyi62Pr6xYNUUYmzxxm8Td3/ONaTeYXEzmYr2mZxV1uLuNEn7FOX+mGu+FHnMR3RshLmKHDsKclWs9Vz0YtvnxnDr1ICOAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TcfodoBZiXE4glcugY3TSGUlbVkK1tiF7Db6xDO8Cjg=;
 b=VE5I9SEJeZ6r8iJz1tMfE15Zid+tGpPffykdP7m9vRynCo581ecFuK4sxJ6zECg1kRBd9kwQM4CWP1xtCsnSOPEYm8Dh5C55xRyg9205c48gHokfam2FV418XC/jDFequUJ6Z509882lOvAiIhlzQ9og9dCdnSvDN45lwEhzZ74=
Received: from MW3PR05CA0025.namprd05.prod.outlook.com (2603:10b6:303:2b::30)
 by DM6PR12MB4268.namprd12.prod.outlook.com (2603:10b6:5:223::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Sat, 3 Jun
 2023 04:47:33 +0000
Received: from CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::ab) by MW3PR05CA0025.outlook.office365.com
 (2603:10b6:303:2b::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.12 via Frontend
 Transport; Sat, 3 Jun 2023 04:47:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT026.mail.protection.outlook.com (10.13.175.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.28 via Frontend Transport; Sat, 3 Jun 2023 04:47:32 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 2 Jun
 2023 23:47:20 -0500
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <irogers@google.com>, <acme@kernel.org>, <sfr@canb.auug.org.au>
CC:     <ravi.bangoria@amd.com>, <suzuki.poulose@arm.com>,
        <mike.leach@linaro.org>, <leo.yan@linaro.org>,
        <john.g.garry@oracle.com>, <will@kernel.org>,
        <james.clark@arm.com>, <peterz@infradead.org>, <mingo@redhat.com>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>,
        <adrian.hunter@intel.com>, <kjain@linux.ibm.com>,
        <renyu.zj@linux.alibaba.com>, <kan.liang@linux.intel.com>,
        <zhengjun.xing@linux.intel.com>, <maddy@linux.ibm.com>,
        <atrajeev@linux.vnet.ibm.com>, <wangming01@loongson.cn>,
        <chenhuacai@kernel.org>, <sandipan.das@amd.com>,
        <9erthalion6@gmail.com>, <seanjc@google.com>, <robh@kernel.org>,
        <tmricht@linux.ibm.com>, <tegongkang@gmail.com>,
        <linux-kernel@vger.kernel.org>, <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-perf-users@vger.kernel.org>
Subject: [PATCH v2] perf test amd: Fix build failure with amd-ibs-via-core-pmu.c
Date:   Sat, 3 Jun 2023 10:16:50 +0530
Message-ID: <20230603044650.286-1-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAP-5=fUPZ7+nAcxBp5sFBfxzkOH8kzWkLV0uziHqxYC0cDbbDw@mail.gmail.com>
References: <CAP-5=fUPZ7+nAcxBp5sFBfxzkOH8kzWkLV0uziHqxYC0cDbbDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT026:EE_|DM6PR12MB4268:EE_
X-MS-Office365-Filtering-Correlation-Id: f82908ee-5e1e-4dd3-8b53-08db63eda4ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SZN5aqxu+PAkkEag3rWRuDbRUmCA0C93Fbktp3wI3+WLZfb+bx6MV8qaGxsQWy8TIfWYnhSA6r6g8cwLdFvGYOpCNvvTxs3JyT6pn2+IQkvzP0FJeHYzSjEQRaHVIBt3NoZotZcioOT+B+TrineV0uXrAe3o+CjgVtDm3dD1wgra8U8dkIbX1A2ojrGepaJPV6v6Z2Uk1VYRisFIuAk3MQxjs4P97RHo67EpcW/D4LclAlbJX6lCAM8NFoEun53Dbmg/JUgRvFIGt3GOVedwP9LYQW0r1scGke7T4C09KhZlZqGxM82FcHA38FA/aB7fDGvd41x/bkxydpo4siUO37UyekvUEX3lYtYUFXY2fDSoAyRHmiQmc6l6xuQCbiL1zOhmAOPCHzJm4gKYX9HJEN5RoV4usl8G7/KEkvbPoMfdma/9D2X7zj5ritbJ0i6pwzTFIpk+IoPwDUDWwe+5dhYiG5ZZSWcnnVJAEPj+sEp0QWbeAHjFA7pi/NHL5TP1D/8+drB3mN3XQoZtgDEkNjWdlYf9TAVRW45xrRzLb4B2jbe4017IwkGONwY7FC5aLW36HssTf/aUQ+m5mjsoIR/68XXsBnozYFgCK+KkaJad6Lp33K4GwkL25l4xxkDeMETgtjlUOEOzC9UNqG1t8kYWnDDAB4ckuNI8iNXUKHyOXCsg0aKqsZyTWdHp5/3zFOuwcUekQmdpv1DCYki4zXCT9ASG+CwjuJI2AphkR4L+aNDdEDXpp23LgvxsF7kfVg2PKSeHKgqAgSrqldSV5g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(396003)(346002)(136003)(451199021)(46966006)(40470700004)(36840700001)(40480700001)(81166007)(110136005)(478600001)(8936002)(356005)(40460700003)(54906003)(44832011)(7416002)(7406005)(36756003)(5660300002)(82310400005)(2906002)(8676002)(86362001)(70206006)(4326008)(82740400003)(70586007)(316002)(41300700001)(2616005)(16526019)(186003)(1076003)(26005)(6666004)(7696005)(36860700001)(47076005)(426003)(336012)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2023 04:47:32.7055
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f82908ee-5e1e-4dd3-8b53-08db63eda4ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4268
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since amd-ibs-via-core-pmu.c was applied via Peter's tree, some of
the changes came via Arnaldo's tree did not reflect in this file,
which is causing build failures.

  arch/x86/tests/amd-ibs-via-core-pmu.c:47:25: error: ‘pmus’ undeclared
  (first use in this function)
     47 |         if (list_empty(&pmus))
        |                         ^~~~
  arch/x86/tests/amd-ibs-via-core-pmu.c:48:17: error: implicit declaration
  of function ‘perf_pmu__scan’; did you mean
  perf_pmus__scan’? [-Werror=implicit-function-declaration]
     48 |                 perf_pmu__scan(NULL);
        |                 ^~~~~~~~~~~~~~
        |                 perf_pmus__scan
  arch/x86/tests/amd-ibs-via-core-pmu.c:50:19: error: implicit declaration
  of function ‘perf_pmu__find’; did you mean
  perf_pmus__find’? [-Werror=implicit-function-declaration]
     50 |         ibs_pmu = perf_pmu__find("ibs_op");
        |                   ^~~~~~~~~~~~~~
        |                   perf_pmus__find

Fix those.

Fixes: 1eaf496ed386 ("perf pmu: Separate pmu and pmus")
Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
v1->v2:
  - Remove unnecessary perf_pmus__scan(NULL) as suggested by Ian.

 tools/perf/arch/x86/tests/amd-ibs-via-core-pmu.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/tools/perf/arch/x86/tests/amd-ibs-via-core-pmu.c b/tools/perf/arch/x86/tests/amd-ibs-via-core-pmu.c
index 2902798ca5c1..78b1902f6f59 100644
--- a/tools/perf/arch/x86/tests/amd-ibs-via-core-pmu.c
+++ b/tools/perf/arch/x86/tests/amd-ibs-via-core-pmu.c
@@ -44,10 +44,7 @@ int test__amd_ibs_via_core_pmu(struct test_suite *test __maybe_unused,
 	int ret = TEST_OK;
 	int fd, i;
 
-	if (list_empty(&pmus))
-		perf_pmu__scan(NULL);
-
-	ibs_pmu = perf_pmu__find("ibs_op");
+	ibs_pmu = perf_pmus__find("ibs_op");
 	if (!ibs_pmu)
 		return TEST_SKIP;
 
-- 
2.40.1


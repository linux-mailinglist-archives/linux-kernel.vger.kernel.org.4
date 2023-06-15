Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2B8730E94
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 07:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238767AbjFOFR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 01:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjFOFRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 01:17:24 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C9626A8;
        Wed, 14 Jun 2023 22:17:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TgsvaRSgFfCtB6jIpb5olgtayDYu8PCdkDkiTaBN3k7pgXeEpaD8Lh/rng2pEHSt0Q+D8AHN2VFPUwVA7J2dfv6swsZy0k8g9dkU2nD9Ik4Bt0QehZT+LwdtiAacYBc075hWVinFF5OhsRQHIsgMLngGMxZPbxQr3vLQjc3ZexVftwZ0MnGvNk24u3/K++bmkXqRSmcyqmuuU4WLTYLY0GQRA1aKjc7W7Btue5Avq/1CPhXZaHHeFjgRkNsZ+oR8aJvqht59FTEEbGDEDhK+lW343H20K4jxyeImLlix2F9VPpBRLANJ6JgBjYt3AB5etvZ6vYYt6h+wMNsIBATf8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EA2HwfBc/rc+96wzDGd3Qr9ckbBoPUwIJweGxFy08Ew=;
 b=jJyFyLZ5eI9CDHq8QjJ/A/gVOtpFJar+WXC4T5az5BuiB4YXPQbdFnzWMywGwJjDtVTgT8xli5HNtPSsBU1waX1NxkLZC1v4dttPLIQ9CxOSh1BqrcgUL4IKBKvSUHbj4iTVluLWfLDCDjh12hTeNLqaGNP9LY4Prp2nB+fAXhdlzI5TSjC7ZfgYAKnmsSmyV47tMbQtI/AEoZtmKuEcw76KDKJMLJyVv2V0o2KHaerbgqHWst5Cf6/VSuJfLGRNRYwq3YC6FEow9zmztCqOVZQSkKlX3gq712v/nmysYi7oiLW6A5Au82QA4A5Wqz1G+6cdLJnUTtkXFAHYH4EYug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EA2HwfBc/rc+96wzDGd3Qr9ckbBoPUwIJweGxFy08Ew=;
 b=C1oAJ6HiJY5q26nxCYc6rLUuxNsmyzEZSpHW7bUwWSJ+bQ2sTyuFSyqVC13R3Xorg/ZDftYmMWoTXOy0+VKjHl1ux91rwJwe+h+aDR49qiyKpskBX81QstGsWA3kf1D80oB4Rb/q0Sb/18jzpmKjpGaj9EVMDiwAmBzKTqx97W4=
Received: from PH8PR05CA0013.namprd05.prod.outlook.com (2603:10b6:510:2cc::13)
 by IA0PR12MB8861.namprd12.prod.outlook.com (2603:10b6:208:487::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Thu, 15 Jun
 2023 05:17:19 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:510:2cc:cafe::72) by PH8PR05CA0013.outlook.office365.com
 (2603:10b6:510:2cc::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.26 via Frontend
 Transport; Thu, 15 Jun 2023 05:17:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.27 via Frontend Transport; Thu, 15 Jun 2023 05:17:19 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 15 Jun
 2023 00:17:13 -0500
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <acme@kernel.org>
CC:     <ravi.bangoria@amd.com>, <irogers@google.com>, <jolsa@kernel.org>,
        <namhyung@kernel.org>, <peterz@infradead.org>,
        <james.clark@arm.com>, <alisaidi@amazon.com>, <leo.yan@linaro.org>,
        <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
        <mark.rutland@arm.com>, <maddy@linux.ibm.com>,
        <tmricht@linux.ibm.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sandipan.das@amd.com>,
        <ananth.narayan@amd.com>, <santosh.shukla@amd.com>
Subject: [PATCH v2 0/3] perf mem amd: Fix few logic bugs
Date:   Thu, 15 Jun 2023 10:46:57 +0530
Message-ID: <20230615051700.1833-1-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|IA0PR12MB8861:EE_
X-MS-Office365-Filtering-Correlation-Id: bc85b971-e4fe-47ca-b327-08db6d5fca9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VrPUlcTk6+5lHXjxCp+jsaO+BHRkrOlDjjAN1Oq8FkKFiCQ7cTlOmGSTf5SIjkKF5zx3CJcVCyR0p4ITGfaTCdIy32Uoindp0fzfk6iQGALAgwW44D4EpRAiwxbDwXF/bKkDMlH34kh+mgg5cLZqPuI+GONQU1TLuLlveqmQlHQvCgG0J0faDVr8jXZE/dZk3hoLNTJ/bfmzWCyOKdulSo1U9qq+FiPHSQJvTDIG09qreRcqANyYVpCPZCp/gmxinBnWwKcSIyttMRcHClT73KWW47EdSql1AKs0Ni9XNamlgjZdvwlEPFsSldZ/tVJrp4mc0cuAHH4djC+BEKhSGE6qiA9FGSF4LHxy6Ldt0RGVnSajC7gX5mnyooyHXfCez3Mw8ZgzAP++U1Hqh1/X2vdXMcCyZKnFvuGMXCT//tJn1cuN+FyXNCymp8KsVk83dKr7Ke030uNhrUQ8O9sGa5djiAxLZh2GK7U1loE4/49NWQMa78zmvFKaI7krsRe3Kx43S0Mu9g1AEIkzXb0wF57nfiTgYHTzIOckI7EYnHEi77EP7zp6iO3mvrYLZ20hle+j0lqG1IydJ1jl+cQi504ccSmIvseEXj444KPAWMzytzMHfiXBJjreg8bpFUmMWRscDpWoC4WASZPS28dnW0zQA90wmijPILt3LDiJW0ODkqy54ynaiUQP0bucjBYaGtIlj7Oa7Xs6YClmUkW1H8MqN3FwxVwmUSS6UWoFKB2zSjQB94EIqDdXglDge75+hS9Kvt3X2SUJckVWj+rR6lECh1TTnIRdcwt7bh149YI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(346002)(376002)(136003)(451199021)(46966006)(36840700001)(40470700004)(47076005)(83380400001)(2616005)(26005)(1076003)(41300700001)(316002)(966005)(36860700001)(16526019)(186003)(426003)(6666004)(7696005)(336012)(82310400005)(8936002)(36756003)(86362001)(40460700003)(7416002)(54906003)(44832011)(2906002)(478600001)(5660300002)(8676002)(356005)(70206006)(6916009)(82740400003)(40480700001)(81166007)(70586007)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 05:17:19.1019
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc85b971-e4fe-47ca-b327-08db6d5fca9c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8861
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recent PMU refactoring changes[1] introduced a notion of core vs other
PMUs and made perf mem/c2c code depend only on core PMUs, which is
logically wrong for AMD as perf mem/c2c on AMD depends on IBS OP PMU,
not the core PMU. Although user visible perf mem/c2c functionality is
still working fine, internal code logic is wrong. Fix those.

[1] https://lore.kernel.org/r/20230527072210.2900565-1-irogers@google.com

v1: https://lore.kernel.org/r/20230613095506.547-1-ravi.bangoria@amd.com
v1->v2:
 - Patch #2 of last version is already picked up by Arnaldo. So skip it.
 - Scan all PMUs unconditionally in perf mem code instead of making it
   conditional on arch.

Ravi Bangoria (3):
  perf pmus: Describe semantics of 'core_pmus' and 'other_pmus'
  perf mem amd: Fix perf_pmus__num_mem_pmus()
  perf mem: Scan all PMUs instead of just core ones

 tools/perf/arch/x86/util/pmu.c | 12 ++++++++++++
 tools/perf/util/mem-events.c   | 13 +++++++++----
 tools/perf/util/pmus.c         | 17 ++++++++++++++++-
 3 files changed, 37 insertions(+), 5 deletions(-)

-- 
2.40.1


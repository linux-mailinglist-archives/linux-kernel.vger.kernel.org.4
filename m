Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 280735B815C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 08:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbiINGLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 02:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiINGLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 02:11:35 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2071.outbound.protection.outlook.com [40.107.212.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47910275C2;
        Tue, 13 Sep 2022 23:11:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O7e2Oq+L32LKx6eLMoVo4pmRU637DNW3XmJxKLkBW4sIuDtR/CPaQylP1lEZ6cCdzSdrIMbEY2kYmju7aOCNpwct8PJgq9Lw5zl0cOErKXE4g/xZX/zv0YMnLIFRvPY5mDi/ldIGGy2DDhG4sFsL2qHKd75xs7MciNo/TPzDZphfEQ05xuyeBxoq2TVaC6CTJHcM3c5RVnjcSKfbpLe+9MD3QztM3VVQimT4mhdbC1BLvR70H3X5xxa8HT19AvcWLjJmtHIBOhK041BHIHEI32SJR9jd5uasliMCeExxlnaucf699DjbtNFE+VKD7ckjEKrO47NTaq2cQ8C0yFcS1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GcnFkV2eVXP1QmVXqL+T62whx7WGD0g1hAb/r0OQ9MQ=;
 b=XQ5O14Q/VU5IUHMaB5jO2bop4uo3AjqNxDu60K64NLUarVLgiuRyxXbgjMSBq+NG2+KMod+7kBZB/lW06+nfNzUlARIaec/2cWA8CTfR4+C52qm8PH5M4Pt5bgYkp2luJibF8bwlDpUJAOWDAxpzeFoRCCqhz/X8fuBW8r6bGAeNDCusBeR4XKDhgICPlTuKIUt0eojLNIQ/skNx3uvrccE0CB77EF9IdffolDQbVo2CrQhYF6SF0C+qunudD2tR+Q8IAR/+5E7zkAxq0/t3+sl2bIVcQZ6YDc4uxEE2eDkx9B0k8cTl3TkPVy0zPDSTWRizVy05g2ogo2kY33fnRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GcnFkV2eVXP1QmVXqL+T62whx7WGD0g1hAb/r0OQ9MQ=;
 b=pAQ6DigiI8ekQ2YQeb82tfTA78U1HB5jurGnAZiIYARbJINsxbYKcYFEstgKONKsi+JBqZuoGuc1EnhxlGlE9jE6g8KhF71xB5+ijsDOhf12WCCk/V3IYTC4wLQUb7CBAazVR2TOTzw3GKs7teKnRAOFICtD3dpZoi6RGi+DVag=
Received: from DM6PR04CA0024.namprd04.prod.outlook.com (2603:10b6:5:334::29)
 by BY5PR12MB4097.namprd12.prod.outlook.com (2603:10b6:a03:213::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.16; Wed, 14 Sep
 2022 06:11:31 +0000
Received: from DS1PEPF0000B075.namprd05.prod.outlook.com
 (2603:10b6:5:334:cafe::8) by DM6PR04CA0024.outlook.office365.com
 (2603:10b6:5:334::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.12 via Frontend
 Transport; Wed, 14 Sep 2022 06:11:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000B075.mail.protection.outlook.com (10.167.17.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.12 via Frontend Transport; Wed, 14 Sep 2022 06:11:31 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 14 Sep
 2022 01:11:26 -0500
From:   Meng Li <li.meng@amd.com>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Huang Rui <ray.huang@amd.com>, <linux-pm@vger.kernel.org>
CC:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Deepak Sharma <deepak.sharma@amd.com>,
        "Alex Deucher" <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        Perry Yuan <Perry.Yuan@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Borislav Petkov <bp@alien8.de>, <linux-kernel@vger.kernel.org>,
        Meng Li <li.meng@amd.com>
Subject: [PATCH V3 0/4] Add tbench/gitsource new test cases for amd-pstate-ut
Date:   Wed, 14 Sep 2022 14:11:01 +0800
Message-ID: <20220914061105.1982477-1-li.meng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000B075:EE_|BY5PR12MB4097:EE_
X-MS-Office365-Filtering-Correlation-Id: 64f4ce82-7cd8-4524-6361-08da9617f807
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NwDnVumydC274MjkNEhtdBLD6dA9r56DgNgs8o7dA6KVJ0ogarW5WuDdCAnF/Ol1/kuh5soCW9kcoPkaBeOQCutJdRLHAERhKmz3woKD9nJOMHdPh3ST15VSVvNc09LkI3EeM6yxjquGF50rLr5iJmi5YfKytAMYDimoC0tNWIuQKEwv88RpSqtMgjsskWi+YpSIeE85EpA4LqMNhzeQaGCaMzcuL1oa9Kwj418bszujkxJ/DkANFjO6UB1auDsQlmeY86IdR/p1qYpAg4zBnq9uQKnlu9D+YA7sapCQkT3hYUdJ40UQK9saxvvg1uYhshAX2pZQUIkwl1x4MUl5NiaBpI1bHxvmhxs3zaSnJNcuPuaZHfBCr7Y4wpTaK81QVewe1MIqNab1Xzkqs8ZTlVoEC+fvd6U1RZjGbErmBKo14owLipxdFkzfY8+DT/kTLx2ZYaRsCNyYeRPKx9QdCc9ZqpKWRDFYJjTLPRZ3Fr/0FoqHE7EVviN3hOxZjM60kYoQaxbm21zhwasNpXruIqSKHN9OBTpn7z8Fkr30tfGeQSwKsE9FdkgABfsLuAwqjfE+vvrYsI8cfATrT0t4b/nnMqLTwWKi23jqhjRwRWCuMPpQMw2ssNOjVHq0O7EwamdxbGS9EbkjyyBpMW6i2fqMe/2QvxMFM28iNs8u8wh4WqadgtVRZImDX+Ob2G3SNOocSz6GbqmfiPXZ6XS0RtWSSYdaC4fbFzmFzDMxlc8zhN31Rz6btKsfMYTJ4DQvd3arkt/r2Uzei5xSRiLfPt608Q2MByhx0DEnYfwUJk7ueeqxgGT2EWCwUPW/VqLIRX5OKcwWq1mWyJkMUzRp4nGDHUvMY1UyB8NWkzYTMXIE4e92JfmfWf++ZJsydnYl
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(376002)(346002)(136003)(451199015)(36840700001)(46966006)(40470700004)(83380400001)(336012)(186003)(8676002)(2906002)(26005)(36756003)(82740400003)(86362001)(40480700001)(356005)(47076005)(16526019)(478600001)(41300700001)(1076003)(426003)(70586007)(54906003)(8936002)(36860700001)(2616005)(5660300002)(6666004)(7696005)(4326008)(82310400005)(81166007)(110136005)(40460700003)(316002)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 06:11:31.4900
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64f4ce82-7cd8-4524-6361-08da9617f807
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000B075.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4097
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all:

First, we modify amd-pstate-ut.sh to basic.sh as a basic test, mainly for
AMD P-State kernel drivers. The purpose of this modification is to
facilitate the subsequent addition of gitsource, tbench and other tests.
You can test specific functions by specifying test cases.
Default test all cases, include basic, tbench and gitsource etc.

Secondly, add tbench.sh trigger the tbench testing and monitor the cpu
information.
1) Download and install tbench codes.
2) Run tbench benchmark on specific governors, ondemand or schedutil.
3) Run tbench benchmark comparative test on acpi-cpufreq kernel driver.
4) Get desire performance, frequency, load by perf.
5) Get power consumption and throughput by amd_pstate_trace.py.
6) Analyse test results and save it in file selftest.tbench.csv. 
7) Plot png images about performance, energy and performance per watt
for each test.

Third, add gitsource.sh trigger the gitsource testing and monitor the cpu
information.
1) Download and tar gitsource codes.
2) Run gitsource benchmark on specific governors, ondemand or schedutil.
3) Run tbench benchmark comparative test on acpi-cpufreq kernel driver.
4) Get desire performance, frequency, load by perf.
5) Get power consumption and throughput by amd_pstate_trace.py.
6) Get run time by /usr/bin/time.
7) Analyse test results and save it in file selftest.gitsource.csv. 
8) Plot png images about time, energy and performance per watt
for each test.

Finally, modify rst document to introduce test steps and results etc.

See patch series in below git repo:
V1:https://lore.kernel.org/lkml/20220706073622.672135-1-li.meng@amd.com/
V2:https://lore.kernel.org/lkml/20220804054414.1510764-1-li.meng@amd.com/

Changes from V1->V2:
- selftests: amd-pstate: basic
- - delete main.sh and merge funtions into run.sh
- selftests: amd-pstate: tbench
- - modify ppw to performance per watt for tbench.
- - add comments for performance per watt for tbench.
- - add comparative test on acpi-cpufreq for tbench.
- - calculate drop between amd-pstate and acpi-cpufreq etc.
- - plot images about perfrmance,energy and ppw for tbench.
- selftests: amd-pstate: gitsource
- - modify ppw to performance per watt for gitsource.
- - add comments for performance per watt for gitsource.
- - add comparative test on acpi-cpufreq for gitsource.
- - calculate drop between amd-pstate and acpi-cpufreq etc.
- - plot images about perfrmance,energy and ppw for gitsource.
- Documentation: amd-pstate:
- - modify rst doc, introduce comparative test etc.

Changes from V2->V3:
- selftests: amd-pstate:
- - reduce print logs for governor.
- - add a check to see if tbench and the perf tools are already installed.
- - install tbench package from apt or yum.
- - correct spelling errors from comprison to comparison.

Thanks, 
Jasmine 

Meng Li (4):
  selftests: amd-pstate: Modify amd-pstate-ut.sh to basic.sh.
  selftests: amd-pstate: Trigger tbench benchmark and test cpus
  selftests: amd-pstate: Trigger gitsource benchmark and test cpus
  Documentation: amd-pstate: Add tbench and gitsource test introduction

 Documentation/admin-guide/pm/amd-pstate.rst   | 192 ++++++++-
 tools/testing/selftests/amd-pstate/Makefile   |  11 +-
 .../selftests/amd-pstate/amd-pstate-ut.sh     |  56 ---
 tools/testing/selftests/amd-pstate/basic.sh   |  38 ++
 .../testing/selftests/amd-pstate/gitsource.sh | 345 ++++++++++++++++
 tools/testing/selftests/amd-pstate/run.sh     | 387 ++++++++++++++++++
 tools/testing/selftests/amd-pstate/tbench.sh  | 334 +++++++++++++++
 7 files changed, 1287 insertions(+), 76 deletions(-)
 delete mode 100755 tools/testing/selftests/amd-pstate/amd-pstate-ut.sh
 create mode 100755 tools/testing/selftests/amd-pstate/basic.sh
 create mode 100755 tools/testing/selftests/amd-pstate/gitsource.sh
 create mode 100755 tools/testing/selftests/amd-pstate/run.sh
 create mode 100755 tools/testing/selftests/amd-pstate/tbench.sh

-- 
2.34.1


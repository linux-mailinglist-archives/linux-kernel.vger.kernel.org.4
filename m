Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2DF6097D4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 03:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbiJXBed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 21:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbiJXBea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 21:34:30 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2077.outbound.protection.outlook.com [40.107.100.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0748E20;
        Sun, 23 Oct 2022 18:34:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T2edgC+QyEYYBVcUgEmt+KOt7V0m/bhrRVJ7yWyQiMIAMWN4VBy12Mz3LZVwnY5tUDS9Ah/QkNXmSNzsGinclfGiy2YGblH+bOeCLBc2bFMPxzgPKmIkWM9JeaPhDvY9Q0R9cKSsxsRl23W4vOeNraNk5U3BVmhXVBDMavikCsqQL9H52IU+ceCHSSi3HOCYkYY2rEUpat017SSz8Dmbij3h0LaDRz1Zw1NZPhi4EWumu52NE1CcvOrDRxKeN+HarTElFR6U5AuLNwIavpjNn4e9cjsnngVfW60ELj5UTXuvP9FhFO5X6a73PY9jvbyBsJIHOY47gPSoEZGllrRKbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zk/93aiwPBTE137jjDzT970aMohc/xojPlmdl1vI51o=;
 b=kmTpqIG2AgmzqboLp1l3H0DBFXeb3fZZPdtdyAr5XaSQ9DoXTuA0tAfZPDFnziMFN5f5P0opupxkt6VMCzGpxzmboZBWP/ce0KAPO/InJM0JEfMdvYk4IV6B7Hpj7u+PubNqTijDstbScLCtV0wkcTvilDeGFftycDTyD5Ms8APXCjywrrvLrTuB9jDhhPRwdzQ32gry6GUQWu+mHOjMiub1zkSdsTtRsmvBGOL7D518WsbI1zHpjbtzrQMvRFb8B2BNFezfSGakSoryfK1FpLUryJGMw9x/v57QT9BIz/R6Lmlq45CDWlLmj4SlKvYJHvpXhZMl27EHsSSRAIWP+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zk/93aiwPBTE137jjDzT970aMohc/xojPlmdl1vI51o=;
 b=AzWiSB+ZURIDYnf2NCwGSTdzozZ+U3jpAuzs8qS3XoMh9gze3yy7hLiAd8iUAwVA0w+CbHAmtzzMlKYMoc1NxRPngqzpO6ENk894Ebnsni4dAk2DInDPMJCK5H5memXQLtO2nAkQRB8mbrS2n2gi4de3TxlQlXYSqi1WZ9aKwDc=
Received: from MW4PR04CA0338.namprd04.prod.outlook.com (2603:10b6:303:8a::13)
 by IA1PR12MB7565.namprd12.prod.outlook.com (2603:10b6:208:42f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Mon, 24 Oct
 2022 01:34:19 +0000
Received: from CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::f8) by MW4PR04CA0338.outlook.office365.com
 (2603:10b6:303:8a::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.27 via Frontend
 Transport; Mon, 24 Oct 2022 01:34:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT042.mail.protection.outlook.com (10.13.174.250) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Mon, 24 Oct 2022 01:34:18 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Sun, 23 Oct
 2022 20:34:14 -0500
From:   Meng Li <li.meng@amd.com>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Huang Rui <ray.huang@amd.com>, <linux-pm@vger.kernel.org>
CC:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Deepak Sharma <deepak.sharma@amd.com>,
        "Alex Deucher" <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Shimmer Huang <shimmer.huang@amd.com>,
        "Perry Yuan" <Perry.Yuan@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Borislav Petkov <bp@alien8.de>, <linux-kernel@vger.kernel.org>,
        Meng Li <li.meng@amd.com>
Subject: [PATCH V4 0/4] Add tbench/gitsource new test cases for amd-pstate-ut
Date:   Mon, 24 Oct 2022 09:33:52 +0800
Message-ID: <20221024013356.1639489-1-li.meng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT042:EE_|IA1PR12MB7565:EE_
X-MS-Office365-Filtering-Correlation-Id: b9360983-f2cb-489e-e77c-08dab55fdeb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L6xOLu56ehDHNZItU2APYxOj4pEnMacBLWHJTnChw5uIhjxqnfASiBb1eGnlAj/JgayDvvH687sxGOhnQSA8a5FEKE0ZAYc7wMplh4wdCSqhv8o6EXb76MSGw8nYf2QwhXJmd/39FqIwAKR33UAF9OiHCrgXylU2mdWKRkx89Dx4A0uh845xc/SB3JYe6Zht9D9coWUwm2cmC/VSgvCUG3l1zc3oZKtPGwC4jvBI0eo+FBd5oTrCQgCSUcOHorOjs2fDjGPdOVt0kKQAoZIHjmWlXg0AzVcsUzAHzb0ERSEZICP1RIJQmjkwnuqnKg1nc/yIiH73w6LbF2bgBB9fwAXzTFa1JaYAny1sivwcf8TWnVoyy7yeWmo8ajuFuiUW+oEi+uiv2eujGDswssy35a/w2cGmawTO52zSjkPTp6H6S5xniTWNZiOnyyeYMXrux1fzEpvJvgWnFVq4I8NczAWIry7RQVR2STZyDvC5o1Ar25KQ5yQPqh/vtlo7yoc2itvK6Ae2wLTv0KpNLksLUZAFuYGrpG1MMj6IBdPgQiYfX9hTeO7WewzUmsEyVp1TEE/qZ3ew+eIWbzmsbE5swLeKmc7aGOPyFXnB9rlylSunVCCiPh6v1BhCoO2zFRF9vd0FUmmjjA/GBuPQtmBxsZRrapYscpscB3t16nxIIkSfoVxCYDYXADf8VhSPjJU5JXfBtBfRq57uyJJdn+gmvWY5uRbmBPWRltoVMdkwVvmtJqTNOu4fbqYoVPPyzVQnWe+a3nosEe6Y7y/dhQc5pGQcMeqvL6uRjsNA9BjI76Fp4mqp9g56rQJiTwhSXAPYrNzKjAqdX+Kd6Wdem5OFXoB5R2qUdsN6+N0oorIJteeDZg7UupMrBIBmhemdANwn
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(346002)(376002)(396003)(451199015)(46966006)(40470700004)(36840700001)(4326008)(54906003)(110136005)(8936002)(5660300002)(70586007)(26005)(70206006)(8676002)(6666004)(316002)(41300700001)(7696005)(36756003)(186003)(36860700001)(82740400003)(356005)(81166007)(82310400005)(426003)(40480700001)(336012)(2616005)(16526019)(47076005)(40460700003)(1076003)(2906002)(478600001)(86362001)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 01:34:18.7546
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9360983-f2cb-489e-e77c-08dab55fdeb4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7565
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
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

Third, add gitsource.sh trigger the gitsource testing and monitor the cpu
information.

Finally, modify rst document to introduce test steps and results etc.

See patch series in below git repo:
V1:https://lore.kernel.org/lkml/20220706073622.672135-1-li.meng@amd.com/
V2:https://lore.kernel.org/lkml/20220804054414.1510764-1-li.meng@amd.com/
V3:https://lore.kernel.org/lkml/20220914061105.1982477-1-li.meng@amd.com/

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

Changes from V2->V3:
- selftests: amd-pstate:
- - modify cover letter and commit logs.
- Documentation: amd-pstate:
- - modify some format questions.

Thanks, 
Jasmine 

Meng Li (4):
  selftests: amd-pstate: Modify amd-pstate-ut.sh to basic.sh.
  selftests: amd-pstate: Trigger tbench benchmark and test cpus
  selftests: amd-pstate: Trigger gitsource benchmark and test cpus
  Documentation: amd-pstate: Add tbench and gitsource test introduction

 Documentation/admin-guide/pm/amd-pstate.rst   | 194 ++++++++-
 tools/testing/selftests/amd-pstate/Makefile   |  11 +-
 .../selftests/amd-pstate/amd-pstate-ut.sh     |  56 ---
 tools/testing/selftests/amd-pstate/basic.sh   |  38 ++
 .../testing/selftests/amd-pstate/gitsource.sh | 345 ++++++++++++++++
 tools/testing/selftests/amd-pstate/run.sh     | 387 ++++++++++++++++++
 tools/testing/selftests/amd-pstate/tbench.sh  | 334 +++++++++++++++
 7 files changed, 1288 insertions(+), 77 deletions(-)
 delete mode 100755 tools/testing/selftests/amd-pstate/amd-pstate-ut.sh
 create mode 100755 tools/testing/selftests/amd-pstate/basic.sh
 create mode 100755 tools/testing/selftests/amd-pstate/gitsource.sh
 create mode 100755 tools/testing/selftests/amd-pstate/run.sh
 create mode 100755 tools/testing/selftests/amd-pstate/tbench.sh

-- 
2.34.1


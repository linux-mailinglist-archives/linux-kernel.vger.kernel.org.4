Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB4172DE5D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 11:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240733AbjFMJ4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 05:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239009AbjFMJ4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 05:56:10 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17EE810DC;
        Tue, 13 Jun 2023 02:56:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dfeW7fGLIt3V8H+GXleJbYzttqqu9WizZzqtKhKDKDdhqG1JIqN33k3VQ6reyYHRPPZxbZj9+02FGb2wguv/Hsmc85lZledKDK6k4otTIgawozCRfPamZleQ2ieWB+zj4fHr7dqqlQDoV8t46FCccfeSMZ0AXJ6wd2Cngt7Mwvp8+ghKW06qPY7YG4PeEVDsMupCgOZHfhL5/e3vBrs/N2JYgjDWR+nR4mzBRN1JKar2MAeHRUXAAV8p4n5E4IGGLgQCMCXUbtV+kY7kbrAHMdX45aYyxz7NvFH82BJMzuxvZQ5q6YzvAEA6MzId6fH9ABpmt1UoJUWPEO4KxWCU7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K9R5XpqFam4Vaoe2sw12mtRfiLXFf43hJSNNzh3yjZs=;
 b=kGymmAder6mWWse6Z3oGpH0E4U9paeEjwkW6wZoFqvx0P2qwPWW8Fm/dx0WoLAMhnCJJC2MLfrtRmr8NP1cbyviQEqebqC0y4eShhoamDRE+x+z/HcF+ACAtdecZ9o1SzO2SDS8bjI5KvKUepUXiiL0khprd93S7PLZuFBIMPpIlTRNKb1i31PBfnH8lgWJPW7xuszEw6w4ZkivM1avqMfHpfu4xsoKfwEOzqUwIM69g4U/XgoGVTPdLVUJFyDQifMl6xlthHK5c156gzuYcLQWf3S5H7y4tCIVA6qi++yYkkd19wYPuOXb1O6p1geXevfR6RDX5NYnQT7bcTAJnsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K9R5XpqFam4Vaoe2sw12mtRfiLXFf43hJSNNzh3yjZs=;
 b=428xfKfnBSYT8YuG8h3Bpn7nF6jqILzDu9iFRKjtG0rxns3bPl0vQvTqOgnouwg145tvIc6A10UdR6Zlz9FFn2POUjee615PjBhqUqJNoOlaCsfSt7GP7TWoe178pGWWTJWnLJ3qhV/jBc3ASzs1LyFFEA/+TlO5C14scN68zqU=
Received: from SA0PR12CA0005.namprd12.prod.outlook.com (2603:10b6:806:6f::10)
 by PH7PR12MB6936.namprd12.prod.outlook.com (2603:10b6:510:1ba::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Tue, 13 Jun
 2023 09:56:01 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:806:6f:cafe::56) by SA0PR12CA0005.outlook.office365.com
 (2603:10b6:806:6f::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.35 via Frontend
 Transport; Tue, 13 Jun 2023 09:56:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.23 via Frontend Transport; Tue, 13 Jun 2023 09:56:00 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 13 Jun
 2023 04:55:54 -0500
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <acme@kernel.org>
CC:     <ravi.bangoria@amd.com>, <irogers@google.com>, <jolsa@kernel.org>,
        <namhyung@kernel.org>, <mark.rutland@arm.com>,
        <peterz@infradead.org>, <adrian.hunter@intel.com>,
        <kan.liang@linux.intel.com>, <james.clark@arm.com>,
        <alisaidi@amazon.com>, <leo.yan@linaro.org>, <maddy@linux.ibm.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sandipan.das@amd.com>, <ananth.narayan@amd.com>,
        <santosh.shukla@amd.com>
Subject: [PATCH 0/4] perf mem amd: Fix few logic bugs
Date:   Tue, 13 Jun 2023 15:25:02 +0530
Message-ID: <20230613095506.547-1-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|PH7PR12MB6936:EE_
X-MS-Office365-Filtering-Correlation-Id: ce8c96d3-5d2c-49f3-bad5-08db6bf464c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vV9KDVj2HLzP0SOYGyKJEy6KFrLBrnd3jKIkjw7CDuLAuSheM777mnff/FnQyFqFO8TmO6/6CH6yT8odY+uu1JrrQ1DQsMbLqY34jJ67TC7VdzaOamD0ESqrTBDUCCXqKB+Crc9R8Lhv+fx8BLWLFupKWulGCGRZ8ndXbT33zsLgrtYDg9zacUdaHb06Ic1F1M16qskuc35CwNJudlUsQCaaO+0+4nkvWy3fNf6Up87dVl7CRrJMKP3L4ZP4XPtXJCNnktudiQ2QQROBlrPceOIUjyLvJIyUAfhYybJCDD4HBZ3rPOgx85EHHnByHoQbaqcGZLuwyxcJ+pd2HCGE9WqcdT62kATxwWbeXqeYPEe7U//HrhhYSw+5Jp453KpX4QpIZ2hVT/ELsMEgBScrZCg1YeUTtJdxhFnAIDFnc5gvXyfh5vNtncfTLnewDTBvbOif18Qexbgvf6Ngj3/YkbGQ3y0e6DzIpq3rqaRdncXCd6dKjwis1LOg9N67FaXkkEE1z9x0p2rnwZkosaSozL4aI2VKdj8SDZja8H/cBd9SigRhyrirZbIxVX/CdHhJE5AZPgzmU2s89kOlZwJw1pqoC7MCzUijUs7rqTMIvHDdxPvBc3cU5vTYuGBV7Z+Yi4d19+0ZNC5jJDy2ipqdbm6GEfRcxUifTgL7yDHsyWozYwGnkbrJUPDm8I1Uz0oOHxMttdAT9ufYZgPXguukwIiq7DJX/Qv7B0IForyCB7Dr7xnrcxZdAB1lY2Yl/ks3GFhIK4yysvNlrjgdYA3GUw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(346002)(136003)(396003)(451199021)(36840700001)(46966006)(40470700004)(40460700003)(5660300002)(8936002)(36860700001)(2906002)(47076005)(8676002)(426003)(36756003)(336012)(83380400001)(2616005)(356005)(82740400003)(81166007)(82310400005)(86362001)(40480700001)(1076003)(7416002)(26005)(186003)(44832011)(16526019)(70586007)(6916009)(4326008)(70206006)(6666004)(478600001)(316002)(7696005)(54906003)(41300700001)(966005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 09:56:00.9460
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce8c96d3-5d2c-49f3-bad5-08db6bf464c5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6936
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

Recent pmu refactoring changes[1] introduced a notion of core vs other
pmus and made perf mem/c2c code depend only on core pmus, which is
logically wrong for AMD as perf mem/c2c on AMD depends on IBS OP pmu,
not the core pmu. Although user visible perf mem/c2c functionality is
still working fine, internal code logic is wrong. Fix those.

[1] https://lore.kernel.org/r/20230527072210.2900565-1-irogers@google.com

Ravi Bangoria (4):
  perf pmus: Describe semantics of 'core_pmus' and 'other_pmus'
  perf tool x86: Consolidate is_amd check into single function
  perf mem amd: Fix perf_pmus__num_mem_pmus()
  perf mem amd: Scan all PMUs instead of just core ones

 tools/perf/arch/x86/util/Build        |  1 +
 tools/perf/arch/x86/util/env.c        | 19 +++++++++++++++++++
 tools/perf/arch/x86/util/env.h        |  7 +++++++
 tools/perf/arch/x86/util/evsel.c      | 16 ++--------------
 tools/perf/arch/x86/util/mem-events.c | 24 +++++++-----------------
 tools/perf/arch/x86/util/pmu.c        | 15 +++++++++++++++
 tools/perf/util/mem-events.c          | 16 ++++++++++++----
 tools/perf/util/mem-events.h          |  1 +
 tools/perf/util/pmus.c                | 15 ++++++++++++++-
 9 files changed, 78 insertions(+), 36 deletions(-)
 create mode 100644 tools/perf/arch/x86/util/env.c
 create mode 100644 tools/perf/arch/x86/util/env.h

-- 
2.40.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0B36805CD
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 07:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235330AbjA3GAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 01:00:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbjA3GAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 01:00:10 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2042.outbound.protection.outlook.com [40.107.102.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6AA7244AA;
        Sun, 29 Jan 2023 22:00:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LC9A9LroOOHDLjZ+KQE6fXjUKqss6PUPnHe19OUi/1sW17k6vGc/BuTPTmbcUrBBzIyissH/eU8lgbK2Wx3atzhHgKowQByIqSXtJu9wUlqfX83EU9b4PljqSx4WtqWjiiVD53YoOEaNXYDMuEcgFyH7cY05DoL9SMhZaBXePpjRchZqR/CYH0Xa3XCNTzXVpmNAq27lX1CUC8+FuJhhblayRF6etrcDUDx1FnNeA981D63p43V1h4B4gkf4rGJA50gFq3uv2CUT5/kpjmCTjAx5UBjhGLmJQscrfCQVi9052Zr99Ka7NlyUJJNOPNgYFNbZtAT3XBCYukW4HD+Jag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ipCtlDJKfgtvYn9LBcC1LJMdwUzqfN/blraq8fSSNMg=;
 b=kHPFCcZVAAWMMYJwVmrptp56qrtDCzNs8k08Ke5UL3WNa0zDH7zOHJTXOwgK7p9bLW4OEPs2Zp154W17ncVjSNvQZb12HX59gzFvkHNZCLXFXFcd3LYXxZt5of2/PGkzVAb4oReXXY9pW98Z0LTnygvqZE+MxUc7J6Nmk7kOXIbYN0MHsD+COrG2okdP6iRo/Q3GjezKCnadkJkVo4qhiiuXIbP1EAuLV/5qCVfRLBTODDx1MqnY0n511mUu1+c03opBKUsNihjZVodlCwvMP/qIsZ2DWMeQyRryQP9lQSQ3VgUa9p3CuaWaHN/Yu8oF+ltVR7AnBPVgre++umN9rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ipCtlDJKfgtvYn9LBcC1LJMdwUzqfN/blraq8fSSNMg=;
 b=iMsLBvUu6+qqkLH1O4c8iH4mxVemslu8DJiJnoH5Rod7gtfSD3QI5GaUUB96c19z2h4HucH7E8vSSHTMusdE9XpleN+J7qk70vKEBQC6sV1uARkrXSAoVccqVH5hJ0GbPw883RaiyWe8TlifPp3f1J6EzGTEs+arqGypIzcP8FQ=
Received: from DM6PR02CA0123.namprd02.prod.outlook.com (2603:10b6:5:1b4::25)
 by SA1PR12MB7443.namprd12.prod.outlook.com (2603:10b6:806:2b7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.33; Mon, 30 Jan
 2023 06:00:01 +0000
Received: from DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b4:cafe::99) by DM6PR02CA0123.outlook.office365.com
 (2603:10b6:5:1b4::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36 via Frontend
 Transport; Mon, 30 Jan 2023 06:00:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT025.mail.protection.outlook.com (10.13.172.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6043.21 via Frontend Transport; Mon, 30 Jan 2023 06:00:01 +0000
Received: from sindhu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sun, 29 Jan
 2023 23:59:24 -0600
From:   Sandipan Das <sandipan.das@amd.com>
To:     <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <x86@kernel.org>
CC:     <peterz@infradead.org>, <bp@alien8.de>, <acme@kernel.org>,
        <namhyung@kernel.org>, <jolsa@kernel.org>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>,
        <dave.hansen@linux.intel.com>, <james.clark@arm.com>,
        <irogers@google.com>, <eranian@google.com>,
        <ananth.narayan@amd.com>, <ravi.bangoria@amd.com>,
        <santosh.shukla@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH v3 0/2] tools perf: Add branch speculation info
Date:   Mon, 30 Jan 2023 11:29:14 +0530
Message-ID: <cover.1675057032.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT025:EE_|SA1PR12MB7443:EE_
X-MS-Office365-Filtering-Correlation-Id: 592f0a5d-0e54-4630-9f14-08db0287399d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A0vIm5p6g3aV33pYUy5a/Ye1grGsI8qCumgpYyHfyPNDP2A2lEARUI3yV24SnEP+KtKyQKJWTf0zsFZg0A2rAbrWQeYojTYRoguGfk4RWyufmA+QMvPgQFWNnPKrJJ0OEdyjkFGFT2+uj2S3ylcTC83ZquWSXS6CC1AAe6f4ptKDnfEB+G8BVQDc7ju99715iyoCEEYHWVTKMDoOdNO4g/Ei0qq0vehOSO6SySZT/SFfj4PY6sRgkgoWjqyStk+TBMBv4X9spdkp/Uf5OSHCQpHe4HQx/u5o1VfcQPY0WEJ3OJ2OhetOWR8xXDPTIfkpTFeealQJOPSX5Y0SNUkKBByxQa2ALv+H1cSdKzYM4Uy/AmWV7C80NgnvAtHo5sFVmhYQM4TZDOSoiFhRNbkfSX6XKsXvVLeiGaRqcqS53UquPr+5Mn9VdN4POyoK2zt1S9qypS/n+bRGBug7iL/Bz05bK5q90QWTrbR9cyN8Tw4Z6YT3LE7G6MhMJV2p8ZyzbMWVx8Skt0P0vfdXU1mtxGhI0zo/H5EI/RADLDqp103kOHQf69DlDoX3jRi844BYAN9z/ebNUEKEsrLKJDugLACLjmn3jWQz9KI0DqKNqSKSo9ZHhtav/T76Q57krBI9M4voiDc42HsmZgQhuL87XCJJUtEh7vpjokl3s8wS99R2ZNMqVFsdRc2y8gfqWxZWg9TbSZ/39b8iPrPSW2XfZaIm7YPPQWHL66lMUof4rVn0QTtnmVlT4wDsLwikgGpVvLwlNg8C3wTAryWrVJgHVbfNIOYy5yAFDKc3XbdCVE6vDYuUdSsLnkU0v219FdNB
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(396003)(346002)(376002)(451199018)(46966006)(36840700001)(40470700004)(5660300002)(7416002)(8936002)(41300700001)(2906002)(44832011)(70586007)(8676002)(4326008)(70206006)(316002)(54906003)(110136005)(7696005)(478600001)(966005)(36860700001)(6666004)(16526019)(40460700003)(186003)(26005)(336012)(83380400001)(2616005)(82310400005)(426003)(356005)(82740400003)(40480700001)(86362001)(47076005)(81166007)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 06:00:01.2903
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 592f0a5d-0e54-4630-9f14-08db0287399d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7443
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMD Last Branch Record Extension Version 2 (LbrExtV2) provides branch
speculation information and the perf UAPI is extended to provide this in
a generic way. Make perf tool show this additional information.

The UAPI changes can be found in commit 93315e46b000 ("perf/core: Add
speculation info to branch entries").

Previous versions can be found at:
v2: https://lore.kernel.org/all/cover.1664356751.git.sandipan.das@amd.com/
v1: https://lore.kernel.org/all/cover.1660217326.git.sandipan.das@amd.com/

Changes in v3:
- Drop tools-side UAPI changes as they have already been added by other
  commits.
- Rebase on top of latest perf/core.

Changes in v2:
- Drop msr-index.h related changes for now.
- Rebase on top of latest perf/core.
- Fix UAPI breakage introduced by the ARM64 BRBE changes to perf branch
  entry.

Sandipan Das (2):
  perf script: Show branch speculation info
  perf session: Show branch speculation info in raw dump

 tools/perf/builtin-script.c |  5 +++--
 tools/perf/util/branch.c    | 15 +++++++++++++++
 tools/perf/util/branch.h    |  2 ++
 tools/perf/util/evsel.c     | 15 ++++++++++++---
 tools/perf/util/session.c   |  5 +++--
 5 files changed, 35 insertions(+), 7 deletions(-)

-- 
2.34.1


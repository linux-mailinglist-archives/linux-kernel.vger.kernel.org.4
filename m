Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98A15687D44
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 13:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232055AbjBBM0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 07:26:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjBBM0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 07:26:35 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3813210E7;
        Thu,  2 Feb 2023 04:26:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y5KpUEQm9Irr892PzRiSWgTk32VrayOL4SXlcrLgDyVUK0G66Sf220RrKQQlxYriHUa1lPhaA26kH2VeTK6Lpj2p1S73Bv/ir/3den6Vwg9kK8Ai3iBMRgmdF/76rKooZmfgFFESYi+to53YVf/oBRx4iIPVM7TGNqSu0KM3HCJlMJ3sEJOLEKCYza6hiy3r/QOd1P7rE/XyrqktvZOxMq5MA1rWs4QjrB1qi+OMYNSLYvGGsg8TFuRoxxkvlE2WktZKAivklZtLCcl2OVv7efDEjfkRxmmJbEayTWIOz8tV94C/Lb6S0OoHkGO/O4UsG3tNkhkXP/3lOs2y6LvbSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B+asTgOkATojkqnA/7qoh8wS6Y0zGNIsG//wHPO0zuw=;
 b=MOFB/dG3XGj08fRHH0apslULvzlqn6TBw2Tvgf5o0SNsIxuSai5DCFF3LQrEcrpRujpCy1f+JxtAQ/U/ZaPltLV5YIRnKuisQViUo+phFQU686Q84PJ+bpNrJb7YfpVcskpjFgpxMxfZIrVYPIePs8+FiRTLXOirB3AStQg3gZ900FAw/3AMLpLrZB0DfRIfyesJPpRD0vZBqc0H8ZPn2oY8iBhuEOO6WRft76RxkIKWNuE9aB1Fudw+ep+53uSnILGaxysL8HmfeMisY9FpQW/ZABihQ19PcevFwNNhPiWETWEj5Ir4JscbbjIAeNL4S72OaLOVQuvPMwmbk9k89A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B+asTgOkATojkqnA/7qoh8wS6Y0zGNIsG//wHPO0zuw=;
 b=0eLLJtUK608ZhCtuZXOHbQe/7r5yC3wn4B2xWTOMQ8Qf1aSosrz+JFJYrnpecQ9yVHcoCdSCyQt7FZgH2VHmcrX4aEHr9ywD9VjbsohbvfxzkV/NeLn6GlYhKxFWbEy03ZVAmJvF4lJesPIsfygxggkPu+n+HWPyprnvXuGkKrI=
Received: from DM6PR18CA0006.namprd18.prod.outlook.com (2603:10b6:5:15b::19)
 by SN7PR12MB6669.namprd12.prod.outlook.com (2603:10b6:806:26f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Thu, 2 Feb
 2023 12:26:32 +0000
Received: from DS1PEPF0000E631.namprd02.prod.outlook.com
 (2603:10b6:5:15b:cafe::f4) by DM6PR18CA0006.outlook.office365.com
 (2603:10b6:5:15b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27 via Frontend
 Transport; Thu, 2 Feb 2023 12:26:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E631.mail.protection.outlook.com (10.167.17.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6064.17 via Frontend Transport; Thu, 2 Feb 2023 12:26:31 +0000
Received: from sindhu.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 2 Feb
 2023 06:26:25 -0600
From:   Sandipan Das <sandipan.das@amd.com>
To:     <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <x86@kernel.org>
CC:     <peterz@infradead.org>, <bp@alien8.de>, <acme@kernel.org>,
        <namhyung@kernel.org>, <jolsa@kernel.org>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>,
        <dave.hansen@linux.intel.com>, <james.clark@arm.com>,
        <irogers@google.com>, <eranian@google.com>, <maddy@linux.ibm.com>,
        <kjain@linux.ibm.com>, <tmricht@linux.ibm.com>,
        <ananth.narayan@amd.com>, <ravi.bangoria@amd.com>,
        <santosh.shukla@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH v4 0/4] tools perf: Add branch speculation info
Date:   Thu, 2 Feb 2023 17:56:13 +0530
Message-ID: <cover.1675333809.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E631:EE_|SN7PR12MB6669:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a543eba-3fa7-4014-55b6-08db0518b76d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AgIGaX8oSpODpzgTc/RfUHrIyFNqpEDZ3OJKckMLCQB51lUUhnISybVsf+p3obtMHPu1yLL9sTk7Csv/Cb4TN5dHnxAGZyJHMEdVAYLE8+tyVSh3yHz5cJzVamBlexMal4LYoNeCdhhm0f3OdYaZo7jairVXb6JtkGpi+zOupOp0mdQfIgjLnYH4WsF/uk+k8RSVNJPz7nZ2NYkZixN14kQ1FeRTmBPVJOGMxnmBdehwQj4A4cnX6V9EeS9B9eSuE48evIPsdiQ3wUGaHc9+jen9fdhksFUJhxYVZPp8WJXAiFpKU8DWiCLwjb4gfgkav5LsjaimCzdG53u5PVIvplwp+0h5GY6QdBJ2qryJwLoe90ZYr0pebLTTee7sVqtMnNh9h+d5Wv6PQ9I4zRYzvuGWHwkKyIf10i8Oh0319tIZUawyE4D27MnNl40MkTYUAiJ0IIFYfYfs2wtvOzF13f2kwsM9mn1N5U/gkWdytTvI3OX0C3IrFQkh/klRF1wy9OIfTKfEc368TCWQpUNZ9vovbOLJcNJ8orkDxrngitKZEDSX4w0ol5UUNN5yazBOOACsayOjvJXej0/GuW9vXN+YJa3alkgyx9P7EefhevVMDTKr9NWxDakBa1YTIt1OqCR1EEexZvPgwPVzJZvWk4wgcqRcHynLbXxvCBJCqrTjDAmxX6C8/ddcIC237GblvWZS+ZZLK+j5Xex1KSDit80Y0+ukGhJbl0/lvWCvmf/DpDk33w+4Vn7X90j3ILfIMagx2yJm/QGOrSiW7Hq9+4hiPc2DgiGtJvlLFuQTZH3QLNYzTzSVUp6Ba3t39paP
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(376002)(396003)(136003)(451199018)(46966006)(40470700004)(36840700001)(41300700001)(336012)(81166007)(36860700001)(54906003)(110136005)(8936002)(86362001)(40460700003)(82310400005)(82740400003)(316002)(44832011)(2616005)(7416002)(5660300002)(356005)(40480700001)(426003)(47076005)(2906002)(36756003)(83380400001)(4326008)(966005)(478600001)(16526019)(6666004)(186003)(26005)(70586007)(70206006)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 12:26:31.7025
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a543eba-3fa7-4014-55b6-08db0518b76d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E631.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6669
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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

Requesting help from folks having access to big-endian systems to test
changes in the sample parsing test as I was only able to test these in
a ppc64 simulator.

Previous versions can be found at:
v3: https://lore.kernel.org/all/cover.1675057032.git.sandipan.das@amd.com/
v2: https://lore.kernel.org/all/cover.1664356751.git.sandipan.das@amd.com/
v1: https://lore.kernel.org/all/cover.1660217326.git.sandipan.das@amd.com/

Changes in v4:
- Update tests that were failing due to changes in perf output and
  sample parsing (thanks to Arnaldo for reporting).

Changes in v3:
- Drop tools-side UAPI changes as they have already been added by other
  commits.
- Rebase on top of latest perf/core.

Changes in v2:
- Drop msr-index.h related changes for now.
- Rebase on top of latest perf/core.
- Fix UAPI breakage introduced by the ARM64 BRBE changes to perf branch
  entry.

Sandipan Das (4):
  perf script: Show branch speculation info
  perf session: Show branch speculation info in raw dump
  perf test sample-parsing: Update expected branch flags
  perf test brstack: Update regex to include spec field

 tools/perf/builtin-script.c            |  5 +++--
 tools/perf/tests/sample-parsing.c      |  2 +-
 tools/perf/tests/shell/test_brstack.sh | 18 +++++++++---------
 tools/perf/util/branch.c               | 15 +++++++++++++++
 tools/perf/util/branch.h               |  2 ++
 tools/perf/util/evsel.c                | 15 ++++++++++++---
 tools/perf/util/session.c              |  5 +++--
 7 files changed, 45 insertions(+), 17 deletions(-)

-- 
2.34.1


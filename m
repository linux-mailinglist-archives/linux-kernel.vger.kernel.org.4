Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD686F6967
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 13:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjEDLBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 07:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjEDLBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 07:01:33 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E385267;
        Thu,  4 May 2023 04:01:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O3OP1zm50qzi7+GQPsTl9OSDiS1cC9HW1EAUpRtw5D32LEg9quendC+wTM6Yvbbf/7aeSGZF8IN21w+6FDCgyCNvIq2XZY7H5yeuRNybmxKVIMBxH5dvu+BhSAfv9KMMbA/g9FNmU7a55RgvRmLXWb4JdLQHE3llOKdXwAE0D6yfXO/etq+CSJgf7O1kDGAzk+Kpou+5x6Vlu3vTEUleGH/f50B9KEmJ6HcnT5Uii1xbI25l4m6wovmmYwPIu6oWDNuaPLEdHNr6FYTrDohi5YfMeyQG/TDQsoroEv/HAopUppAn/niF5FhqWX7/YEosnWABSXU0WndosQYJM/LScA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eZZRwxw0UjB16HJlKKUAcKfxCQURFPqKoJRqpPDi8BY=;
 b=Jcon7Qe0YcaRI/JkjKFMnc3MQQ7KT5CRGJ0z3gdoC+NfsATU798AiGbea61wDWgM2LxlWnbi1e5p164Cpr33OZFTJCDhv14+aOGPHUiH/NVXhDNMFNV8F7ShaQg9oSJoMOA/ergDvR+5GWpEUCH7FElauDte16ct567rc2VVBOiWAQZZPIzHTqx3FvtWJtv9ubE64lEHx55DaZiXjZyymqtg+sdnMS0emv9UQqw2lZNIzrG7m+Z1Y91Oejs5MwV2CIAjE762TFClGTJLlnb5mbjQHAIvE+jS/XdgQVzqmfV5obcNJEdFEkOpz9jchDaYc2wI0VU2AIjr0JKes0eG0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eZZRwxw0UjB16HJlKKUAcKfxCQURFPqKoJRqpPDi8BY=;
 b=pVjb1/vucHwLGvCeCZva+yOEoRHhPDPZK8ExIdvXmzVjws+HO/eqVdGxRpx0hBMC1uRpTTAIxEGa1smHMN09wURhx8JWIBEyOXb30n0NjoIHIRELRcn56zNQrjT36vDwYs9yXpL1D67Lmqm2fUswDhpr+oPaxrHJin8xSQHiEb0=
Received: from DM6PR12CA0031.namprd12.prod.outlook.com (2603:10b6:5:1c0::44)
 by SA1PR12MB6917.namprd12.prod.outlook.com (2603:10b6:806:24c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.20; Thu, 4 May
 2023 11:01:24 +0000
Received: from DM6NAM11FT076.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1c0:cafe::b) by DM6PR12CA0031.outlook.office365.com
 (2603:10b6:5:1c0::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27 via Frontend
 Transport; Thu, 4 May 2023 11:01:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT076.mail.protection.outlook.com (10.13.173.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.26 via Frontend Transport; Thu, 4 May 2023 11:01:23 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 4 May
 2023 06:00:18 -0500
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <peterz@infradead.org>
CC:     <ravi.bangoria@amd.com>, <namhyung@kernel.org>,
        <eranian@google.com>, <acme@kernel.org>, <mark.rutland@arm.com>,
        <jolsa@kernel.org>, <irogers@google.com>, <bp@alien8.de>,
        <kan.liang@linux.intel.com>, <adrian.hunter@intel.com>,
        <maddy@linux.ibm.com>, <x86@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sandipan.das@amd.com>, <ananth.narayan@amd.com>,
        <santosh.shukla@amd.com>
Subject: [PATCH v4 0/4] perf: Rework event forwarding logic
Date:   Thu, 4 May 2023 16:29:59 +0530
Message-ID: <20230504110003.2548-1-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT076:EE_|SA1PR12MB6917:EE_
X-MS-Office365-Filtering-Correlation-Id: f36c6e9c-549f-43d4-1fc1-08db4c8ee687
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zrfm4kjnk+/KBCi/5P7ERy6+MnUrVz1EuTbUncQyZnmquhhNiOm4x3Zz8rcodEjW2ToS/vtBnXodVzPPuQ22B4yv/eNQxHcYPOm2VrOH925jlSWe0Ipb2GPJAZJ2Viyeg8eRtFTRoGfzYd81weClQUfteJ3QSMwBZ5LhNZUCxgCUZ9oFKfsk1hDhoxG6ImubEuEsZyUJugBQYjWhklDLnDUAa6SimqSCMRPzg3uI1FS4/DA4yD05WukEuv1Omdp3kMIsIRTbHjv/KaSxXEVtdv1WS0QY3OFj1fiZnPnU/+H2y2Ci3wuimXbhdDkbnnW9hKDKAjiyWuLfXdmpNxQyFJqqn2F3RtC431EVUS+P8wm1qLokg1f+YnQPTkyJM+UD63qNAMBVPkG+iQPWZLj6HIvIBvz6MA+9S8zgZrcVEAHtxfUQBY8Cfw4pCXBB3T7AqZ/LztYrE4V2hKnThA/2UsMufOA3FHcfapwPs+7YxpqMCl4D2G0cmlf5UQ+SmN+kvs3Q/MSR7SVI9Eb+tPP4LrH1xEnI9ep5RRbVAakskupeut9cPrAXM2Ia3Lcs1jCu00OwZxisJvFkGInbJ+2UweEwkH0HQ26OGNWP091lLLU74slycz9egQ5iGYkXVQm0MQlxkM6gLAlcXZ2Zf4rGc4NaJu7jMsF40VoOhJ4CP5VDyV55/v5YrefP4h0L46oLWZFY4uxyyEQc4XRmm1WNcwtfnMIq29XM9dHOuEKnCio=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(39860400002)(346002)(451199021)(46966006)(36840700001)(40470700004)(2906002)(70206006)(70586007)(44832011)(86362001)(2616005)(82310400005)(426003)(36756003)(336012)(7416002)(5660300002)(478600001)(8676002)(8936002)(966005)(40460700003)(6916009)(40480700001)(4326008)(41300700001)(6666004)(54906003)(316002)(7696005)(82740400003)(16526019)(26005)(186003)(81166007)(1076003)(356005)(83380400001)(47076005)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 11:01:23.8801
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f36c6e9c-549f-43d4-1fc1-08db4c8ee687
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT076.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6917
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

Usually, events are opened on the same pmu as requested by user via
perf_event_attr->type argument. But certain special events are
internally redirected to different pmu. Currently such pmus needs to
be treated specially and thus requires some gruesome hacks.

An approach, suggested by Peter Zijlstra, to get rid of these hacks
was to overwrite event attributes with new pmu's attribute values
within the kernel and let perf_event_init() retry opening the event
with overwritten values. This patch series implements it.

v3: https://lore.kernel.org/r/20230425142205.762-1-ravi.bangoria@amd.com
v3->v4:
 - Split pmu linear searching changes into a separate patch with few
   additional changes.
 - Use special pointer value (void *)(~0) instead of introducing new
   variable to skip creating sysfs/dev files.
 - Move AMD IBS unit test under tools/perf/arch/x86/tests/

Patches are prepared on v6.3.

Ravi Bangoria (4):
  perf/core: Rework forwarding of {task|cpu}-clock events
  perf/ibs: Fix interface via core pmu events
  perf/core: Remove pmu linear searching code
  perf test: Add selftest to test IBS invocation via core pmu events

 arch/x86/events/amd/core.c                    |   2 +-
 arch/x86/events/amd/ibs.c                     |  53 ++++----
 arch/x86/include/asm/perf_event.h             |   2 +
 include/linux/perf_event.h                    |  10 ++
 kernel/events/core.c                          | 114 +++++++++---------
 tools/perf/arch/x86/include/arch-tests.h      |   1 +
 tools/perf/arch/x86/tests/Build               |   1 +
 .../arch/x86/tests/amd-ibs-via-core-pmu.c     |  71 +++++++++++
 tools/perf/arch/x86/tests/arch-tests.c        |   2 +
 9 files changed, 168 insertions(+), 88 deletions(-)
 create mode 100644 tools/perf/arch/x86/tests/amd-ibs-via-core-pmu.c

-- 
2.40.0


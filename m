Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 276EF645373
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 06:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiLGFbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 00:31:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiLGFbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 00:31:34 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0764955C8D;
        Tue,  6 Dec 2022 21:31:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jTSvHBtkvS6l88JnhLWCM5VotKcOqjUc1K1CUiagks/y/TvDSkSBBGg44pQEcUsuYyaOlhanzk1VLxTGAXfQzcMr1pD/DsMPvC0sFFjMLpH+g9ekuVyc/vT1emygjJDE++6LkDAYuTKRkqRK4Jzx6MQzRH1rgomTnBz966Xhuh0U7FL34JLbCAQ9cHlWyiNG5ng+utwDx7IbKReV23Bia1kJFPNGUHtYmbUSRRVJvOyup7EWPWsm7bRZCNKtVfIAItrr6q1N5zsY9HRJ81ZEb9vKWXsFKPwarsyxlbRAWtOHg00wQYCMsuApHcdfmzUreryhKAfw5/JaRZyGxcMprw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9bBWT+xD/+lQ9oxtG6zpExUvl2INH9mlEXuiBsLbdmA=;
 b=SCz8WocaOWFn+fppqPu1cGG7HoSQqbT65y5IU2Wc/T3YZlcbkIHxAaezIuvUKg0BD7hIgjB28QEE+oWqy8tjYxWMNGZ8ZQbQkuX9lU1cUpDmYwY16CSwfbxZG2trcj3Sa4bbiz8wCr9fy9hj7vw1JuKu3DvtV/Mkct8hKRTEwJcYiPF2Za+vkdoP6/b16Vb1tN7+c2LRTBADg2y7+itcihW5LKGniBQHCmxQ9Z8ip32iotu1LAcUGKtn2ceQ8UMDTbwUk0aQCmiEBLPGuEMpFbSXaS5Hnzlswos0SS8C2C/DosowbjsNZMzkniC5HQoV8xXEo/608SRHjaDWnILp+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9bBWT+xD/+lQ9oxtG6zpExUvl2INH9mlEXuiBsLbdmA=;
 b=qX+nLjfRFnaQCgarD7uzeGkli1h8RhV2eGOLqh2iaSOvXfZbxWwUvov2fhIyM0dGe0YR3cSY87eAYJqEQQdnFMr4z3hFAQGBPyH14/HSy2yIlG37icTdn3gbx2d+RffIUxaoWRdc4F5uSgXUjy9zUH7VrWUQWMGc6Z7msqe4CTs=
Received: from MW4PR03CA0264.namprd03.prod.outlook.com (2603:10b6:303:b4::29)
 by SA0PR12MB4462.namprd12.prod.outlook.com (2603:10b6:806:95::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 05:31:23 +0000
Received: from CO1NAM11FT113.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b4:cafe::96) by MW4PR03CA0264.outlook.office365.com
 (2603:10b6:303:b4::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Wed, 7 Dec 2022 05:31:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT113.mail.protection.outlook.com (10.13.174.180) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.15 via Frontend Transport; Wed, 7 Dec 2022 05:31:22 +0000
Received: from sindhu.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 6 Dec
 2022 23:31:13 -0600
From:   Sandipan Das <sandipan.das@amd.com>
To:     <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <acme@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <eranian@google.com>,
        <irogers@google.com>, <jhladky@redhat.com>,
        <ravi.bangoria@amd.com>, <ananth.narayan@amd.com>,
        <sandipan.das@amd.com>
Subject: [PATCH 2/4] perf vendor events amd: Add Zen 4 core events
Date:   Wed, 7 Dec 2022 11:00:05 +0530
Message-ID: <20221207053007.336806-3-sandipan.das@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221207053007.336806-1-sandipan.das@amd.com>
References: <20221207053007.336806-1-sandipan.das@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT113:EE_|SA0PR12MB4462:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b94880d-0263-400b-5c4b-08dad81446fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xPZO/vI1w19DdQJdhQ53G+Tv/+qvsfLQg13IfCgKhhBXz0lDCKDoaMIRzIk+HUbaBoahcGHccTecFSXfBRxN2yeuw7hGIY9g72q36c/u0eDfUbn7/vtvMkeTYrXqO4aO9n3dQskqQmkWNHUxYofcopHSl3rhvUMYTN/xqqHopQA4ooE13YwA/IF7m3r1Ixeus3+JEl6lZ5pFU6x0bGg+3hjnG1JLrBEE4PkICxgwgnlGORWzo4f/cdtOs05qiYqbz1cIBCfk4K+Sqo5HMfCoGS80AQoqp0+HVzLLbv257Ss/8hbNQ3DiSP3mynLnxh6B9Lyabwz6Vs+Y3cfSaS+DFLbT/t0Em5KfitQgJov3f2Vvt0jKQP8OYiQdKlXZBeP4oeSpDCGE43QkCCgczSzqGbxv/+sw7yHu+FSArOC4Pb4OCXKsguoEkEvnBZpOPJor/13aomcFgnfFtZe00TJl2HWuyfO8uDhhwxmBlJWU11UfI/A2Hgc9g4aXsqK6ghY4+MmmmpoHscYrOokdRUHAAIjsHdJsx8QqUMD/AWW1UKCwQ+eryQXw3KaZbtys2tTGvYzzNbO9U11snIiRTKeyVUJ1zXhe0+uvbg5WnSb+KC8ojR/xLnIa1RZkDjUbhkMKnoGKMiO2kBrwiAFfrTtkZSPaCf/pmXeLPZRMyIkq5dUi/tAJbA5zfzYhSHcThTYTCKebFy6aHKzdwCPNLcf7PLFGGYGub0YoE8J3LpeBmk8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(39860400002)(396003)(136003)(451199015)(36840700001)(46966006)(40470700004)(36756003)(5660300002)(356005)(81166007)(8936002)(44832011)(86362001)(40460700003)(4326008)(41300700001)(2906002)(7416002)(30864003)(36860700001)(83380400001)(8676002)(54906003)(70206006)(316002)(70586007)(2616005)(110136005)(82740400003)(40480700001)(82310400005)(16526019)(478600001)(186003)(47076005)(426003)(6666004)(26005)(336012)(1076003)(36900700001)(559001)(579004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 05:31:22.6648
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b94880d-0263-400b-5c4b-08dad81446fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT113.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4462
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add core events taken from Section 2.1.15.4 "Core Performance Monitor
Counters" in the Processor Programming Reference (PPR) for AMD Family
19h Model 11h Revision B1 processors. This constitutes events which
capture op dispatch, execution and retirement, branch prediction, L1
and L2 cache activity, TLB activity, etc.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 .../pmu-events/arch/x86/amdzen4/branch.json   |  82 ++
 .../pmu-events/arch/x86/amdzen4/cache.json    | 653 ++++++++++++++
 .../pmu-events/arch/x86/amdzen4/core.json     | 122 +++
 .../arch/x86/amdzen4/floating-point.json      | 818 ++++++++++++++++++
 .../pmu-events/arch/x86/amdzen4/memory.json   | 174 ++++
 .../pmu-events/arch/x86/amdzen4/other.json    | 138 +++
 6 files changed, 1987 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen4/branch.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen4/cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen4/core.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen4/floating-point.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen4/memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen4/other.json

diff --git a/tools/perf/pmu-events/arch/x86/amdzen4/branch.json b/tools/perf/pmu-events/arch/x86/amdzen4/branch.json
new file mode 100644
index 000000000000..208c646c59ca
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/amdzen4/branch.json
@@ -0,0 +1,82 @@
+[
+  {
+    "EventName": "bp_l2_btb_correct",
+    "EventCode": "0x8b",
+    "BriefDescription": "L2 branch prediction overrides existing prediction (speculative)."
+  },
+  {
+    "EventName": "bp_dyn_ind_pred",
+    "EventCode": "0x8e",
+    "BriefDescription": "Dynamic indirect predictions (branch used the indirect predictor to make a prediction)."
+  },
+  {
+    "EventName": "bp_de_redirect",
+    "EventCode": "0x91",
+    "BriefDescription": "Instruction decoder corrects the predicted target and resteers the branch predictor."
+  },
+  {
+    "EventName": "ex_ret_brn",
+    "EventCode": "0xc2",
+    "BriefDescription": "Retired branch instructions (all types of architectural control flow changes, including exceptions and interrupts)."
+  },
+  {
+    "EventName": "ex_ret_brn_misp",
+    "EventCode": "0xc3",
+    "BriefDescription": "Retired branch instructions mispredicted."
+  },
+  {
+    "EventName": "ex_ret_brn_tkn",
+    "EventCode": "0xc4",
+    "BriefDescription": "Retired taken branch instructions (all types of architectural control flow changes, including exceptions and interrupts)."
+  },
+  {
+    "EventName": "ex_ret_brn_tkn_misp",
+    "EventCode": "0xc5",
+    "BriefDescription": "Retired taken branch instructions mispredicted."
+  },
+  {
+    "EventName": "ex_ret_brn_far",
+    "EventCode": "0xc6",
+    "BriefDescription": "Retired far control transfers (far call/jump/return, IRET, SYSCALL and SYSRET, plus exceptions and interrupts). Far control transfers are not subject to branch prediction."
+  },
+  {
+    "EventName": "ex_ret_near_ret",
+    "EventCode": "0xc8",
+    "BriefDescription": "Retired near returns (RET or RET Iw)."
+  },
+  {
+    "EventName": "ex_ret_near_ret_mispred",
+    "EventCode": "0xc9",
+    "BriefDescription": "Retired near returns mispredicted. Each misprediction incurs the same penalty as a mispredicted conditional branch instruction."
+  },
+  {
+    "EventName": "ex_ret_brn_ind_misp",
+    "EventCode": "0xca",
+    "BriefDescription": "Retired indirect branch instructions mispredicted (only EX mispredicts). Each misprediction incurs the same penalty as a mispredicted conditional branch instruction."
+  },
+  {
+    "EventName": "ex_ret_ind_brch_instr",
+    "EventCode": "0xcc",
+    "BriefDescription": "Retired indirect branch instructions."
+  },
+  {
+    "EventName": "ex_ret_cond",
+    "EventCode": "0xd1",
+    "BriefDescription": "Retired conditional branch instructions."
+  },
+  {
+    "EventName": "ex_ret_msprd_brnch_instr_dir_msmtch",
+    "EventCode": "0x1c7",
+    "BriefDescription": "Retired branch instructions mispredicted due to direction mismatch."
+  },
+  {
+    "EventName": "ex_ret_uncond_brnch_instr_mispred",
+    "EventCode": "0x1c8",
+    "BriefDescription": "Retired unconditional indirect branch instructions mispredicted."
+  },
+  {
+    "EventName": "ex_ret_uncond_brnch_instr",
+    "EventCode": "0x1c9",
+    "BriefDescription": "Retired unconditional branch instructions."
+  }
+]
diff --git a/tools/perf/pmu-events/arch/x86/amdzen4/cache.json b/tools/perf/pmu-events/arch/x86/amdzen4/cache.json
new file mode 100644
index 000000000000..323ffd4b1423
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/amdzen4/cache.json
@@ -0,0 +1,653 @@
+[
+  {
+    "EventName": "ls_mab_alloc.load_store_allocations",
+    "EventCode": "0x41",
+    "BriefDescription": "Miss Address Buffer (MAB) entries allocated by a Load-Store (LS) pipe for load-store allocations.",
+    "UMask": "0x3f"
+  },
+  {
+    "EventName": "ls_mab_alloc.hardware_prefetcher_allocations",
+    "EventCode": "0x41",
+    "BriefDescription": "Miss Address Buffer (MAB) entries allocated by a Load-Store (LS) pipe for hardware prefetcher allocations.",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "ls_mab_alloc.all_allocations",
+    "EventCode": "0x41",
+    "BriefDescription": "Miss Address Buffer (MAB) entries allocated by a Load-Store (LS) pipe for all types of allocations.",
+    "UMask": "0x7f"
+  },
+  {
+    "EventName": "ls_dmnd_fills_from_sys.local_l2",
+    "EventCode": "0x43",
+    "BriefDescription": "Demand data cache fills from local L2 cache.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "ls_dmnd_fills_from_sys.local_ccx",
+    "EventCode": "0x43",
+    "BriefDescription": "Demand data cache fills from L3 cache or different L2 cache in the same CCX.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "ls_dmnd_fills_from_sys.near_cache",
+    "EventCode": "0x43",
+    "BriefDescription": "Demand data cache fills from cache of another CCX when the address was in the same NUMA node.",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "ls_dmnd_fills_from_sys.dram_io_near",
+    "EventCode": "0x43",
+    "BriefDescription": "Demand data cache fills from either DRAM or MMIO in the same NUMA node.",
+    "UMask": "0x08"
+  },
+  {
+    "EventName": "ls_dmnd_fills_from_sys.far_cache",
+    "EventCode": "0x43",
+    "BriefDescription": "Demand data cache fills from cache of another CCX when the address was in a different NUMA node.",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "ls_dmnd_fills_from_sys.dram_io_far",
+    "EventCode": "0x43",
+    "BriefDescription": "Demand data cache fills from either DRAM or MMIO in a different NUMA node (same or different socket).",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "ls_dmnd_fills_from_sys.alternate_memories",
+    "EventCode": "0x43",
+    "BriefDescription": "Demand data cache fills from extension memory.",
+    "UMask": "0x80"
+  },
+  {
+    "EventName": "ls_dmnd_fills_from_sys.all",
+    "EventCode": "0x43",
+    "BriefDescription": "Demand data cache fills from all types of data sources.",
+    "UMask": "0xff"
+  },
+  {
+    "EventName": "ls_any_fills_from_sys.local_l2",
+    "EventCode": "0x44",
+    "BriefDescription": "Any data cache fills from local L2 cache.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "ls_any_fills_from_sys.local_ccx",
+    "EventCode": "0x44",
+    "BriefDescription": "Any data cache fills from L3 cache or different L2 cache in the same CCX.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "ls_any_fills_from_sys.local_all",
+    "EventCode": "0x44",
+    "BriefDescription": "Any data cache fills from local L2 cache or L3 cache or different L2 cache in the same CCX.",
+    "UMask": "0x03"
+  },
+  {
+    "EventName": "ls_any_fills_from_sys.near_cache",
+    "EventCode": "0x44",
+    "BriefDescription": "Any data cache fills from cache of another CCX when the address was in the same NUMA node.",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "ls_any_fills_from_sys.dram_io_near",
+    "EventCode": "0x44",
+    "BriefDescription": "Any data cache fills from either DRAM or MMIO in the same NUMA node.",
+    "UMask": "0x08"
+  },
+  {
+    "EventName": "ls_any_fills_from_sys.far_cache",
+    "EventCode": "0x44",
+    "BriefDescription": "Any data cache fills from cache of another CCX when the address was in a different NUMA node.",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "ls_any_fills_from_sys.remote_cache",
+    "EventCode": "0x44",
+    "BriefDescription": "Any data cache fills from cache of another CCX when the address was in the same or a different NUMA node.",
+    "UMask": "0x14"
+  },
+  {
+    "EventName": "ls_any_fills_from_sys.dram_io_far",
+    "EventCode": "0x44",
+    "BriefDescription": "Any data cache fills from either DRAM or MMIO in a different NUMA node (same or different socket).",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "ls_any_fills_from_sys.dram_io_all",
+    "EventCode": "0x44",
+    "BriefDescription": "Any data cache fills from either DRAM or MMIO in any NUMA node (same or different socket).",
+    "UMask": "0x48"
+  },
+  {
+    "EventName": "ls_any_fills_from_sys.far_all",
+    "EventCode": "0x44",
+    "BriefDescription": "Any data cache fills from either cache of another CCX, DRAM or MMIO when the address was in a different NUMA node (same or different socket).",
+    "UMask": "0x50"
+  },
+  {
+    "EventName": "ls_any_fills_from_sys.all_dram_io",
+    "EventCode": "0x44",
+    "BriefDescription": "Any data cache fills from either DRAM or MMIO in any NUMA node (same or different socket).",
+    "UMask": "0x48"
+  },
+  {
+    "EventName": "ls_any_fills_from_sys.alternate_memories",
+    "EventCode": "0x44",
+    "BriefDescription": "Any data cache fills from extension memory.",
+    "UMask": "0x80"
+  },
+  {
+    "EventName": "ls_any_fills_from_sys.all",
+    "EventCode": "0x44",
+    "BriefDescription": "Any data cache fills from all types of data sources.",
+    "UMask": "0xff"
+  },
+  {
+    "EventName": "ls_pref_instr_disp.prefetch",
+    "EventCode": "0x4b",
+    "BriefDescription": "Software prefetch instructions dispatched (speculative) of type PrefetchT0 (move data to all cache levels), T1 (move data to all cache levels except L1) and T2 (move data to all cache levels except L1 and L2).",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "ls_pref_instr_disp.prefetch_w",
+    "EventCode": "0x4b",
+    "BriefDescription": "Software prefetch instructions dispatched (speculative) of type PrefetchW (move data to L1 cache and mark it modifiable).",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "ls_pref_instr_disp.prefetch_nta",
+    "EventCode": "0x4b",
+    "BriefDescription": "Software prefetch instructions dispatched (speculative) of type PrefetchNTA (move data with minimum cache pollution i.e. non-temporal access).",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "ls_pref_instr_disp.all",
+    "EventCode": "0x4b",
+    "BriefDescription": "Software prefetch instructions dispatched (speculative) of all types.",
+    "UMask": "0x07"
+  },
+  {
+    "EventName": "ls_inef_sw_pref.data_pipe_sw_pf_dc_hit",
+    "EventCode": "0x52",
+    "BriefDescription": "Software prefetches that did not fetch data outside of the processor core as the PREFETCH instruction saw a data cache hit.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "ls_inef_sw_pref.mab_mch_cnt",
+    "EventCode": "0x52",
+    "BriefDescription": "Software prefetches that did not fetch data outside of the processor core as the PREFETCH instruction saw a match on an already allocated Miss Address Buffer (MAB).",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "ls_inef_sw_pref.all",
+    "EventCode": "0x52",
+    "BriefDescript6ion": "Software prefetches that did not fetch data outside of the processor core for any reason.",
+    "UMask": "0x03"
+  },
+  {
+    "EventName": "ls_sw_pf_dc_fills.local_l2",
+    "EventCode": "0x59",
+    "BriefDescription": "Software prefetch data cache fills from local L2 cache.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "ls_sw_pf_dc_fills.local_ccx",
+    "EventCode": "0x59",
+    "BriefDescription": "Software prefetch data cache fills from L3 cache or different L2 cache in the same CCX.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "ls_sw_pf_dc_fills.near_cache",
+    "EventCode": "0x59",
+    "BriefDescription": "Software prefetch data cache fills from cache of another CCX in the same NUMA node.",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "ls_sw_pf_dc_fills.dram_io_near",
+    "EventCode": "0x59",
+    "BriefDescription": "Software prefetch data cache fills from either DRAM or MMIO in the same NUMA node.",
+    "UMask": "0x08"
+  },
+  {
+    "EventName": "ls_sw_pf_dc_fills.far_cache",
+    "EventCode": "0x59",
+    "BriefDescription": "Software prefetch data cache fills from cache of another CCX in a different NUMA node.",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "ls_sw_pf_dc_fills.dram_io_far",
+    "EventCode": "0x59",
+    "BriefDescription": "Software prefetch data cache fills from either DRAM or MMIO in a different NUMA node (same or different socket).",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "ls_sw_pf_dc_fills.alternate_memories",
+    "EventCode": "0x59",
+    "BriefDescription": "Software prefetch data cache fills from extension memory.",
+    "UMask": "0x80"
+  },
+  {
+    "EventName": "ls_sw_pf_dc_fills.all",
+    "EventCode": "0x59",
+    "BriefDescription": "Software prefetch data cache fills from all types of data sources.",
+    "UMask": "0xdf"
+  },
+  {
+    "EventName": "ls_hw_pf_dc_fills.local_l2",
+    "EventCode": "0x5a",
+    "BriefDescription": "Hardware prefetch data cache fills from local L2 cache.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "ls_hw_pf_dc_fills.local_ccx",
+    "EventCode": "0x5a",
+    "BriefDescription": "Hardware prefetch data cache fills from L3 cache or different L2 cache in the same CCX.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "ls_hw_pf_dc_fills.near_cache",
+    "EventCode": "0x5a",
+    "BriefDescription": "Hardware prefetch data cache fills from cache of another CCX when the address was in the same NUMA node.",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "ls_hw_pf_dc_fills.dram_io_near",
+    "EventCode": "0x5a",
+    "BriefDescription": "Hardware prefetch data cache fills from either DRAM or MMIO in the same NUMA node.",
+    "UMask": "0x08"
+  },
+  {
+    "EventName": "ls_hw_pf_dc_fills.far_cache",
+    "EventCode": "0x5a",
+    "BriefDescription": "Hardware prefetch data cache fills from cache of another CCX when the address was in a different NUMA node.",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "ls_hw_pf_dc_fills.dram_io_far",
+    "EventCode": "0x5a",
+    "BriefDescription": "Hardware prefetch data cache fills from either DRAM or MMIO in a different NUMA node (same or different socket).",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "ls_hw_pf_dc_fills.alternate_memories",
+    "EventCode": "0x5a",
+    "BriefDescription": "Hardware prefetch data cache fills from extension memory.",
+    "UMask": "0x80"
+  },
+  {
+    "EventName": "ls_hw_pf_dc_fills.all",
+    "EventCode": "0x5a",
+    "BriefDescription": "Hardware prefetch data cache fills from all types of data sources.",
+    "UMask": "0xdf"
+  },
+  {
+    "EventName": "ls_alloc_mab_count",
+    "EventCode": "0x5f",
+    "BriefDescription": "In-flight L1 data cache misses i.e. Miss Address Buffer (MAB) allocations each cycle."
+  },
+  {
+    "EventName": "l2_request_g1.group2",
+    "EventCode": "0x60",
+    "BriefDescription": "L2 cache requests of non-cacheable type (non-cached data and instructions reads, self-modifying code checks).",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "l2_request_g1.l2_hw_pf",
+    "EventCode": "0x60",
+    "BriefDescription": "L2 cache requests: from hardware prefetchers to prefetch directly into L2 (hit or miss).",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "l2_request_g1.prefetch_l2_cmd",
+    "EventCode": "0x60",
+    "BriefDescription": "L2 cache requests: prefetch directly into L2.",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "l2_request_g1.change_to_x",
+    "EventCode": "0x60",
+    "BriefDescription": "L2 cache requests: data cache state change to writable, check L2 for current state.",
+    "UMask": "0x08"
+  },
+  {
+    "EventName": "l2_request_g1.cacheable_ic_read",
+    "EventCode": "0x60",
+    "BriefDescription": "L2 cache requests: instruction cache reads.",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "l2_request_g1.ls_rd_blk_c_s",
+    "EventCode": "0x60",
+    "BriefDescription": "L2 cache requests: data cache shared reads.",
+    "UMask": "0x20"
+  },
+  {
+    "EventName": "l2_request_g1.rd_blk_x",
+    "EventCode": "0x60",
+    "BriefDescription": "L2 cache requests: data cache stores.",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "l2_request_g1.rd_blk_l",
+    "EventCode": "0x60",
+    "BriefDescription": "L2 cache requests: data cache reads including hardware and software prefetch.",
+    "UMask": "0x80"
+  },
+  {
+    "EventName": "l2_request_g1.all_dc",
+    "EventCode": "0x60",
+    "BriefDescription": "L2 cache requests of common types from L1 data cache (including prefetches).",
+    "UMask": "0xe8"
+  },
+  {
+    "EventName": "l2_request_g1.all_no_prefetch",
+    "EventCode": "0x60",
+    "BriefDescription": "L2 cache requests of common types not including prefetches.",
+    "UMask": "0xf9"
+  },
+  {
+    "EventName": "l2_request_g1.all",
+    "EventCode": "0x60",
+    "BriefDescription": "L2 cache requests of all types.",
+    "UMask": "0xff"
+  },
+  {
+    "EventName": "l2_cache_req_stat.ic_fill_miss",
+    "EventCode": "0x64",
+    "BriefDescription": "Core to L2 cache requests (not including L2 prefetch) with status: instruction cache request miss in L2.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "l2_cache_req_stat.ic_fill_hit_s",
+    "EventCode": "0x64",
+    "BriefDescription": "Core to L2 cache requests (not including L2 prefetch) with status: instruction cache hit non-modifiable line in L2.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "l2_cache_req_stat.ic_fill_hit_x",
+    "EventCode": "0x64",
+    "BriefDescription": "Core to L2 cache requests (not including L2 prefetch) with status: instruction cache hit modifiable line in L2.",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "l2_cache_req_stat.ic_hit_in_l2",
+    "EventCode": "0x64",
+    "BriefDescription": "Core to L2 cache requests (not including L2 prefetch) for instruction cache hits.",
+    "UMask": "0x06"
+  },
+  {
+    "EventName": "l2_cache_req_stat.ic_access_in_l2",
+    "EventCode": "0x64",
+    "BriefDescription": "Core to L2 cache requests (not including L2 prefetch) for instruction cache access.",
+    "UMask": "0x07"
+  },
+  {
+    "EventName": "l2_cache_req_stat.ls_rd_blk_c",
+    "EventCode": "0x64",
+    "BriefDescription": "Core to L2 cache requests (not including L2 prefetch) with status: data cache request miss in L2.",
+    "UMask": "0x08"
+  },
+  {
+    "EventName": "l2_cache_req_stat.ic_dc_miss_in_l2",
+    "EventCode": "0x64",
+    "BriefDescription": "Core to L2 cache requests (not including L2 prefetch) for data and instruction cache misses.",
+    "UMask": "0x09"
+  },
+  {
+    "EventName": "l2_cache_req_stat.ls_rd_blk_x",
+    "EventCode": "0x64",
+    "BriefDescription": "Core to L2 cache requests (not including L2 prefetch) with status: data cache store or state change hit in L2.",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "l2_cache_req_stat.ls_rd_blk_l_hit_s",
+    "EventCode": "0x64",
+    "BriefDescription": "Core to L2 cache requests (not including L2 prefetch) with status: data cache read hit non-modifiable line in L2.",
+    "UMask": "0x20"
+  },
+  {
+    "EventName": "l2_cache_req_stat.ls_rd_blk_l_hit_x",
+    "EventCode": "0x64",
+    "BriefDescription": "Core to L2 cache requests (not including L2 prefetch) with status: data cache read hit modifiable line in L2.",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "l2_cache_req_stat.ls_rd_blk_cs",
+    "EventCode": "0x64",
+    "BriefDescription": "Core to L2 cache requests (not including L2 prefetch) with status: data cache shared read hit in L2.",
+    "UMask": "0x80"
+  },
+  {
+    "EventName": "l2_cache_req_stat.dc_hit_in_l2",
+    "EventCode": "0x64",
+    "BriefDescription": "Core to L2 cache requests (not including L2 prefetch) for data cache hits.",
+    "UMask": "0xf0"
+  },
+  {
+    "EventName": "l2_cache_req_stat.ic_dc_hit_in_l2",
+    "EventCode": "0x64",
+    "BriefDescription": "Core to L2 cache requests (not including L2 prefetch) for data and instruction cache hits.",
+    "UMask": "0xf6"
+  },
+  {
+    "EventName": "l2_cache_req_stat.dc_access_in_l2",
+    "EventCode": "0x64",
+    "BriefDescription": "Core to L2 cache requests (not including L2 prefetch) for data cache access.",
+    "UMask": "0xf8"
+  },
+  {
+    "EventName": "l2_cache_req_stat.all",
+    "EventCode": "0x64",
+    "BriefDescription": "Core to L2 cache requests (not including L2 prefetch) for data and instruction cache access.",
+    "UMask": "0xff"
+  },
+  {
+    "EventName": "l2_pf_hit_l2.l2_stream",
+    "EventCode": "0x70",
+    "BriefDescription": "L2 prefetches accepted by the L2 pipeline which hit in the L2 cache of type L2Stream (fetch additional sequential lines into L2 cache).",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "l2_pf_hit_l2.l2_next_line",
+    "EventCode": "0x70",
+    "BriefDescription": "L2 prefetches accepted by the L2 pipeline which hit in the L2 cache of type L2NextLine (fetch the next line into L2 cache).",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "l2_pf_hit_l2.l2_up_down",
+    "EventCode": "0x70",
+    "BriefDescription": "L2 prefetches accepted by the L2 pipeline which hit in the L2 cache of type L2UpDown (fetch the next or previous line into L2 cache for all memory accesses).",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "l2_pf_hit_l2.l2_burst",
+    "EventCode": "0x70",
+    "BriefDescription": "L2 prefetches accepted by the L2 pipeline which hit in the L2 cache of type L2Burst (aggressively fetch additional sequential lines into L2 cache).",
+    "UMask": "0x08"
+  },
+  {
+    "EventName": "l2_pf_hit_l2.l2_stride",
+    "EventCode": "0x70",
+    "BriefDescription": "L2 prefetches accepted by the L2 pipeline which hit in the L2 cache of type L2Stride (fetch additional lines into L2 cache when each access is at a constant distance from the previous).",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "l2_pf_hit_l2.l1_stream",
+    "EventCode": "0x70",
+    "BriefDescription": "L2 prefetches accepted by the L2 pipeline which hit in the L2 cache of type L1Stream (fetch additional sequential lines into L1 cache).",
+    "UMask": "0x20"
+  },
+  {
+    "EventName": "l2_pf_hit_l2.l1_stride",
+    "EventCode": "0x70",
+    "BriefDescription": "L2 prefetches accepted by the L2 pipeline which hit in the L2 cache of type L1Stride (fetch additional lines into L1 cache when each access is a constant distance from the previous).",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "l2_pf_hit_l2.l1_region",
+    "EventCode": "0x70",
+    "BriefDescription": "L2 prefetches accepted by the L2 pipeline which hit in the L2 cache of type L1Region (fetch additional lines into L1 cache when the data access for a given instruction tends to be followed by a consistent pattern of other accesses within a localized region).",
+    "UMask": "0x80"
+  },
+  {
+    "EventName": "l2_pf_hit_l2.all",
+    "EventCode": "0x70",
+    "BriefDescription": "L2 prefetches accepted by the L2 pipeline which hit in the L2 cache of all types.",
+    "UMask": "0xff"
+  },
+  {
+    "EventName": "l2_pf_miss_l2_hit_l3.l2_stream",
+    "EventCode": "0x71",
+    "BriefDescription": "L2 prefetches accepted by the L2 pipeline which miss the L2 cache and hit in the L3 cache of type L2Stream (fetch additional sequential lines into L2 cache).",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "l2_pf_miss_l2_hit_l3.l2_next_line",
+    "EventCode": "0x71",
+    "BriefDescription": "L2 prefetches accepted by the L2 pipeline which miss the L2 cache and hit in the L3 cache of type L2NextLine (fetch the next line into L2 cache).",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "l2_pf_miss_l2_hit_l3.l2_up_down",
+    "EventCode": "0x71",
+    "BriefDescription": "L2 prefetches accepted by the L2 pipeline which miss the L2 cache and hit in the L3 cache of type L2UpDown (fetch the next or previous line into L2 cache for all memory accesses).",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "l2_pf_miss_l2_hit_l3.l2_burst",
+    "EventCode": "0x71",
+    "BriefDescription": "L2 prefetches accepted by the L2 pipeline which miss the L2 cache and hit in the L3 cache of type L2Burst (aggressively fetch additional sequential lines into L2 cache).",
+    "UMask": "0x08"
+  },
+  {
+    "EventName": "l2_pf_miss_l2_hit_l3.l2_stride",
+    "EventCode": "0x71",
+    "BriefDescription": "L2 prefetches accepted by the L2 pipeline which miss the L2 cache and hit in the L3 cache of type L2Stride (fetch additional lines into L2 cache when each access is a constant distance from the previous).",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "l2_pf_miss_l2_hit_l3.l1_stream",
+    "EventCode": "0x71",
+    "BriefDescription": "L2 prefetches accepted by the L2 pipeline which miss the L2 cache and hit in the L3 cache of type L1Stream (fetch additional sequential lines into L1 cache).",
+    "UMask": "0x20"
+  },
+  {
+    "EventName": "l2_pf_miss_l2_hit_l3.l1_stride",
+    "EventCode": "0x71",
+    "BriefDescription": "L2 prefetches accepted by the L2 pipeline which miss the L2 cache and hit in the L3 cache of type L1Stride (fetch additional lines into L1 cache when each access is a constant distance from the previous).",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "l2_pf_miss_l2_hit_l3.l1_region",
+    "EventCode": "0x71",
+    "BriefDescription": "L2 prefetches accepted by the L2 pipeline which miss the L2 cache and hit in the L3 cache of type L1Region (fetch additional lines into L1 cache when the data access for a given instruction tends to be followed by a consistent pattern of other accesses within a localized region).",
+    "UMask": "0x80"
+  },
+  {
+    "EventName": "l2_pf_miss_l2_hit_l3.all",
+    "EventCode": "0x71",
+    "BriefDescription": "L2 prefetches accepted by the L2 pipeline which miss the L2 cache and hit in the L3 cache cache of all types.",
+    "UMask": "0xff"
+  },
+  {
+    "EventName": "l2_pf_miss_l2_l3.l2_stream",
+    "EventCode": "0x72",
+    "BriefDescription": "L2 prefetches accepted by the L2 pipeline which miss the L2 and the L3 caches of type L2Stream (fetch additional sequential lines into L2 cache).",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "l2_pf_miss_l2_l3.l2_next_line",
+    "EventCode": "0x72",
+    "BriefDescription": "L2 prefetches accepted by the L2 pipeline which miss the L2 and the L3 caches of type L2NextLine (fetch the next line into L2 cache).",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "l2_pf_miss_l2_l3.l2_up_down",
+    "EventCode": "0x72",
+    "BriefDescription": "L2 prefetches accepted by the L2 pipeline which miss the L2 and the L3 caches of type L2UpDown (fetch the next or previous line into L2 cache for all memory accesses).",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "l2_pf_miss_l2_l3.l2_burst",
+    "EventCode": "0x72",
+    "BriefDescription": "L2 prefetches accepted by the L2 pipeline which miss the L2 and the L3 caches of type L2Burst (aggressively fetch additional sequential lines into L2 cache).",
+    "UMask": "0x08"
+  },
+  {
+    "EventName": "l2_pf_miss_l2_l3.l2_stride",
+    "EventCode": "0x72",
+    "BriefDescription": "L2 prefetches accepted by the L2 pipeline which miss the L2 and the L3 caches of type L2Stride (fetch additional lines into L2 cache when each access is a constant distance from the previous).",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "l2_pf_miss_l2_l3.l1_stream",
+    "EventCode": "0x72",
+    "BriefDescription": "L2 prefetches accepted by the L2 pipeline which miss the L2 and the L3 caches of type L1Stream (fetch additional sequential lines into L1 cache).",
+    "UMask": "0x20"
+  },
+  {
+    "EventName": "l2_pf_miss_l2_l3.l1_stride",
+    "EventCode": "0x72",
+    "BriefDescription": "L2 prefetches accepted by the L2 pipeline which miss the L2 and the L3 caches of type L1Stride (fetch additional lines into L1 cache when each access is a constant distance from the previous).",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "l2_pf_miss_l2_l3.l1_region",
+    "EventCode": "0x72",
+    "BriefDescription": "L2 prefetches accepted by the L2 pipeline which miss the L2 and the L3 caches of type L1Region (fetch additional lines into L1 cache when the data access for a given instruction tends to be followed by a consistent pattern of other accesses within a localized region).",
+    "UMask": "0x80"
+  },
+  {
+    "EventName": "l2_pf_miss_l2_l3.all",
+    "EventCode": "0x72",
+    "BriefDescription": "L2 prefetches accepted by the L2 pipeline which miss the L2 and the L3 caches of all types.",
+    "UMask": "0xff"
+  },
+  {
+    "EventName": "ic_cache_fill_l2",
+    "EventCode": "0x82",
+    "BriefDescription": "Instruction cache lines (64 bytes) fulfilled from the L2 cache."
+  },
+  {
+    "EventName": "ic_cache_fill_sys",
+    "EventCode": "0x83",
+    "BriefDescription": "Instruction cache lines (64 bytes) fulfilled from system memory or another cache."
+  },
+  {
+    "EventName": "ic_tag_hit_miss.instruction_cache_hit",
+    "EventCode": "0x18e",
+    "BriefDescription": "Instruction cache hits.",
+    "UMask": "0x07"
+  },
+  {
+    "EventName": "ic_tag_hit_miss.instruction_cache_miss",
+    "EventCode": "0x18e",
+    "BriefDescription": "Instruction cache misses.",
+    "UMask": "0x18"
+  },
+  {
+    "EventName": "ic_tag_hit_miss.all_instruction_cache_accesses",
+    "EventCode": "0x18e",
+    "BriefDescription": "Instruction cache accesses of all types.",
+    "UMask": "0x1f"
+  },
+  {
+    "EventName": "op_cache_hit_miss.op_cache_hit",
+    "EventCode": "0x28f",
+    "BriefDescription": "Op cache hits.",
+    "UMask": "0x03"
+  },
+  {
+    "EventName": "op_cache_hit_miss.op_cache_miss",
+    "EventCode": "0x28f",
+    "BriefDescription": "Op cache misses.",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "op_cache_hit_miss.all_op_cache_accesses",
+    "EventCode": "0x28f",
+    "BriefDescription": "Op cache accesses of all types.",
+    "UMask": "0x07"
+  }
+]
diff --git a/tools/perf/pmu-events/arch/x86/amdzen4/core.json b/tools/perf/pmu-events/arch/x86/amdzen4/core.json
new file mode 100644
index 000000000000..a56a41828bd4
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/amdzen4/core.json
@@ -0,0 +1,122 @@
+[
+  {
+    "EventName": "ls_locks.bus_lock",
+    "EventCode": "0x25",
+    "BriefDescription": "Retired Lock instructions which caused a bus lock.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "ls_ret_cl_flush",
+    "EventCode": "0x26",
+    "BriefDescription": "Retired CLFLUSH instructions."
+  },
+  {
+    "EventName": "ls_ret_cpuid",
+    "EventCode": "0x27",
+    "BriefDescription": "Retired CPUID instructions."
+  },
+  {
+    "EventName": "ls_smi_rx",
+    "EventCode": "0x2b",
+    "BriefDescription": "SMIs received."
+  },
+  {
+    "EventName": "ls_int_taken",
+    "EventCode": "0x2c",
+    "BriefDescription": "Interrupts taken."
+  },
+  {
+    "EventName": "ls_not_halted_cyc",
+    "EventCode": "0x76",
+    "BriefDescription": "Core cycles not in halt."
+  },
+  {
+    "EventName": "ex_ret_instr",
+    "EventCode": "0xc0",
+    "BriefDescription": "Retired instructions."
+  },
+  {
+    "EventName": "ex_ret_ops",
+    "EventCode": "0xc1",
+    "BriefDescription": "Retired macro-ops."
+  },
+  {
+    "EventName": "ex_div_busy",
+    "EventCode": "0xd3",
+    "BriefDescription": "Number of cycles the divider is busy."
+  },
+  {
+    "EventName": "ex_div_count",
+    "EventCode": "0xd4",
+    "BriefDescription": "Divide ops executed."
+  },
+  {
+    "EventName": "ex_no_retire.empty",
+    "EventCode": "0xd6",
+    "BriefDescription": "Cycles with no retire due  to the lack of valid ops in the retire queue (may be caused by front-end bottlenecks or pipeline redirects).",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "ex_no_retire.not_complete",
+    "EventCode": "0xd6",
+    "BriefDescription": "Cycles with no retire while the oldest op is waiting to be executed.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "ex_no_retire.other",
+    "EventCode": "0xd6",
+    "BriefDescription": "Cycles with no retire caused by other reasons (retire breaks, traps, faults, etc.).",
+    "UMask": "0x08"
+  },
+  {
+    "EventName": "ex_no_retire.thread_not_selected",
+    "EventCode": "0xd6",
+    "BriefDescription": "Cycles with no retire because thread arbitration did not select the thread.",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "ex_no_retire.load_not_complete",
+    "EventCode": "0xd6",
+    "BriefDescription": "Cycles with no retire while the oldest op is waiting for load data.",
+    "UMask": "0xa2"
+  },
+  {
+    "EventName": "ex_no_retire.all",
+    "EventCode": "0xd6",
+    "BriefDescription": "Cycles with no retire for any reason.",
+    "UMask": "0x1b"
+  },
+  {
+    "EventName": "ls_not_halted_p0_cyc.p0_freq_cyc",
+    "EventCode": "0x120",
+    "BriefDescription": "Reference cycles (P0 frequency) not in halt .",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "ex_ret_ucode_instr",
+    "EventCode": "0x1c1",
+    "BriefDescription": "Retired microcoded instructions."
+  },
+  {
+    "EventName": "ex_ret_ucode_ops",
+    "EventCode": "0x1c2",
+    "BriefDescription": "Retired microcode ops."
+  },
+  {
+    "EventName": "ex_tagged_ibs_ops.ibs_tagged_ops",
+    "EventCode": "0x1cf",
+    "BriefDescription": "Ops tagged by IBS.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "ex_tagged_ibs_ops.ibs_tagged_ops_ret",
+    "EventCode": "0x1cf",
+    "BriefDescription": "Ops tagged by IBS that retired.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "ex_ret_fused_instr",
+    "EventCode": "0x1d0",
+    "BriefDescription": "Retired fused instructions."
+  }
+]
diff --git a/tools/perf/pmu-events/arch/x86/amdzen4/floating-point.json b/tools/perf/pmu-events/arch/x86/amdzen4/floating-point.json
new file mode 100644
index 000000000000..cd7328fb7998
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/amdzen4/floating-point.json
@@ -0,0 +1,818 @@
+[
+  {
+    "EventName": "fp_ret_x87_fp_ops.add_sub_ops",
+    "EventCode": "0x02",
+    "BriefDescription": "Retired x87 floating-point add and subtract ops.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "fp_ret_x87_fp_ops.mul_ops",
+    "EventCode": "0x02",
+    "BriefDescription": "Retired x87 floating-point multiply ops.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "fp_ret_x87_fp_ops.div_sqrt_ops",
+    "EventCode": "0x02",
+    "BriefDescription": "Retired x87 floating-point divide and square root ops.",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "fp_ret_x87_fp_ops.all",
+    "EventCode": "0x02",
+    "BriefDescription": "Retired x87 floating-point ops of all types.",
+    "UMask": "0x07"
+  },
+  {
+    "EventName": "fp_ret_sse_avx_ops.add_sub_flops",
+    "EventCode": "0x03",
+    "BriefDescription": "Retired SSE and AVX floating-point add and subtract ops.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "fp_ret_sse_avx_ops.mult_flops",
+    "EventCode": "0x03",
+    "BriefDescription": "Retired SSE and AVX floating-point multiply ops.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "fp_ret_sse_avx_ops.div_flops",
+    "EventCode": "0x03",
+    "BriefDescription": "Retired SSE and AVX floating-point divide and square root ops.",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "fp_ret_sse_avx_ops.mac_flops",
+    "EventCode": "0x03",
+    "BriefDescription": "Retired SSE and AVX floating-point multiply-accumulate ops (each operation is counted as 2 ops).",
+    "UMask": "0x08"
+  },
+  {
+    "EventName": "fp_ret_sse_avx_ops.bfloat_mac_flops",
+    "EventCode": "0x03",
+    "BriefDescription": "Retired SSE and AVX floating-point bfloat multiply-accumulate ops (each operation is counted as 2 ops).",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "fp_ret_sse_avx_ops.all",
+    "EventCode": "0x03",
+    "BriefDescription": "Retired SSE and AVX floating-point ops of all types.",
+    "UMask": "0x1f"
+  },
+  {
+    "EventName": "fp_retired_ser_ops.x87_ctrl_ret",
+    "EventCode": "0x05",
+    "BriefDescription": "Retired x87 control word mispredict traps due to mispredictions in RC or PC, or changes in exception mask bits.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "fp_retired_ser_ops.x87_bot_ret",
+    "EventCode": "0x05",
+    "BriefDescription": "Retired x87 bottom-executing ops. Bottom-executing ops wait for all older ops to retire before executing.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "fp_retired_ser_ops.sse_ctrl_ret",
+    "EventCode": "0x05",
+    "BriefDescription": "Retired SSE and AVX control word mispredict traps.",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "fp_retired_ser_ops.sse_bot_ret",
+    "EventCode": "0x05",
+    "BriefDescription": "Retired SSE and AVX bottom-executing ops. Bottom-executing ops wait for all older ops to retire before executing.",
+    "UMask": "0x08"
+  },
+  {
+    "EventName": "fp_retired_ser_ops.all",
+    "EventCode": "0x05",
+    "BriefDescription": "Retired SSE and AVX serializing ops of all types.",
+    "UMask": "0x0f"
+  },
+  {
+    "EventName": "fp_ops_retired_by_width.x87_uops_retired",
+    "EventCode": "0x08",
+    "BriefDescription": "Retired x87 floating-point ops.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "fp_ops_retired_by_width.mmx_uops_retired",
+    "EventCode": "0x08",
+    "BriefDescription": "Retired MMX floating-point ops.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "fp_ops_retired_by_width.scalar_uops_retired",
+    "EventCode": "0x08",
+    "BriefDescription": "Retired scalar floating-point ops.",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "fp_ops_retired_by_width.pack_128_uops_retired",
+    "EventCode": "0x08",
+    "BriefDescription": "Retired packed 128-bit floating-point ops.",
+    "UMask": "0x08"
+  },
+  {
+    "EventName": "fp_ops_retired_by_width.pack_256_uops_retired",
+    "EventCode": "0x08",
+    "BriefDescription": "Retired packed 256-bit floating-point ops.",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "fp_ops_retired_by_width.pack_512_uops_retired",
+    "EventCode": "0x08",
+    "BriefDescription": "Retired packed 512-bit floating-point ops.",
+    "UMask": "0x20"
+  },
+  {
+    "EventName": "fp_ops_retired_by_width.all",
+    "EventCode": "0x08",
+    "BriefDescription": "Retired floating-point ops of all widths.",
+    "UMask": "0x3f"
+  },
+  {
+    "EventName": "fp_ops_retired_by_type.scalar_add",
+    "EventCode": "0x0a",
+    "BriefDescription": "Retired scalar floating-point add ops.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "fp_ops_retired_by_type.scalar_sub",
+    "EventCode": "0x0a",
+    "BriefDescription": "Retired scalar floating-point subtract ops.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "fp_ops_retired_by_type.scalar_mul",
+    "EventCode": "0x0a",
+    "BriefDescription": "Retired scalar floating-point multiply ops.",
+    "UMask": "0x03"
+  },
+  {
+    "EventName": "fp_ops_retired_by_type.scalar_mac",
+    "EventCode": "0x0a",
+    "BriefDescription": "Retired scalar floating-point multiply-accumulate ops.",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "fp_ops_retired_by_type.scalar_div",
+    "EventCode": "0x0a",
+    "BriefDescription": "Retired scalar floating-point divide ops.",
+    "UMask": "0x05"
+  },
+  {
+    "EventName": "fp_ops_retired_by_type.scalar_sqrt",
+    "EventCode": "0x0a",
+    "BriefDescription": "Retired scalar floating-point square root ops.",
+    "UMask": "0x06"
+  },
+  {
+    "EventName": "fp_ops_retired_by_type.scalar_cmp",
+    "EventCode": "0x0a",
+    "BriefDescription": "Retired scalar floating-point compare ops.",
+    "UMask": "0x07"
+  },
+  {
+    "EventName": "fp_ops_retired_by_type.scalar_cvt",
+    "EventCode": "0x0a",
+    "BriefDescription": "Retired scalar floating-point convert ops.",
+    "UMask": "0x08"
+  },
+  {
+    "EventName": "fp_ops_retired_by_type.scalar_blend",
+    "EventCode": "0x0a",
+    "BriefDescription": "Retired scalar floating-point blend ops.",
+    "UMask": "0x09"
+  },
+  {
+    "EventName": "fp_ops_retired_by_type.scalar_other",
+    "EventCode": "0x0a",
+    "BriefDescription": "Retired scalar floating-point ops of other types.",
+    "UMask": "0x0e"
+  },
+  {
+    "EventName": "fp_ops_retired_by_type.scalar_all",
+    "EventCode": "0x0a",
+    "BriefDescription": "Retired scalar floating-point ops of all types.",
+    "UMask": "0x0f"
+  },
+  {
+    "EventName": "fp_ops_retired_by_type.vector_add",
+    "EventCode": "0x0a",
+    "BriefDescription": "Retired vector floating-point add ops.",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "fp_ops_retired_by_type.vector_sub",
+    "EventCode": "0x0a",
+    "BriefDescription": "Retired vector floating-point subtract ops.",
+    "UMask": "0x20"
+  },
+  {
+    "EventName": "fp_ops_retired_by_type.vector_mul",
+    "EventCode": "0x0a",
+    "BriefDescription": "Retired vector floating-point multiply ops.",
+    "UMask": "0x30"
+  },
+  {
+    "EventName": "fp_ops_retired_by_type.vector_mac",
+    "EventCode": "0x0a",
+    "BriefDescription": "Retired vector floating-point multiply-accumulate ops.",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "fp_ops_retired_by_type.vector_div",
+    "EventCode": "0x0a",
+    "BriefDescription": "Retired vector floating-point divide ops.",
+    "UMask": "0x50"
+  },
+  {
+    "EventName": "fp_ops_retired_by_type.vector_sqrt",
+    "EventCode": "0x0a",
+    "BriefDescription": "Retired vector floating-point square root ops.",
+    "UMask": "0x60"
+  },
+  {
+    "EventName": "fp_ops_retired_by_type.vector_cmp",
+    "EventCode": "0x0a",
+    "BriefDescription": "Retired vector floating-point compare ops.",
+    "UMask": "0x70"
+  },
+  {
+    "EventName": "fp_ops_retired_by_type.vector_cvt",
+    "EventCode": "0x0a",
+    "BriefDescription": "Retired vector floating-point convert ops.",
+    "UMask": "0x80"
+  },
+  {
+    "EventName": "fp_ops_retired_by_type.vector_blend",
+    "EventCode": "0x0a",
+    "BriefDescription": "Retired vector floating-point blend ops.",
+    "UMask": "0x90"
+  },
+  {
+    "EventName": "fp_ops_retired_by_type.vector_shuffle",
+    "EventCode": "0x0a",
+    "BriefDescription": "Retired vector floating-point shuffle ops (may include instructions not necessarily thought of as including shuffles e.g. horizontal add, dot product, and certain MOV instructions).",
+    "UMask": "0xb0"
+  },
+  {
+    "EventName": "fp_ops_retired_by_type.vector_logical",
+    "EventCode": "0x0a",
+    "BriefDescription": "Retired vector floating-point logical ops.",
+    "UMask": "0xd0"
+  },
+  {
+    "EventName": "fp_ops_retired_by_type.vector_other",
+    "EventCode": "0x0a",
+    "BriefDescription": "Retired vector floating-point ops of other types.",
+    "UMask": "0xe0"
+  },
+  {
+    "EventName": "fp_ops_retired_by_type.vector_all",
+    "EventCode": "0x0a",
+    "BriefDescription": "Retired vector floating-point ops of all types.",
+    "UMask": "0xf0"
+  },
+  {
+    "EventName": "fp_ops_retired_by_type.all",
+    "EventCode": "0x0a",
+    "BriefDescription": "Retired floating-point ops of all types.",
+    "UMask": "0xff"
+  },
+  {
+    "EventName": "sse_avx_ops_retired.mmx_add",
+    "EventCode": "0x0b",
+    "BriefDescription": "Retired MMX integer add.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "sse_avx_ops_retired.mmx_sub",
+    "EventCode": "0x0b",
+    "BriefDescription": "Retired MMX integer subtract ops.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "sse_avx_ops_retired.mmx_mul",
+    "EventCode": "0x0b",
+    "BriefDescription": "Retired MMX integer multiply ops.",
+    "UMask": "0x03"
+  },
+  {
+    "EventName": "sse_avx_ops_retired.mmx_mac",
+    "EventCode": "0x0b",
+    "BriefDescription": "Retired MMX integer multiply-accumulate ops.",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "sse_avx_ops_retired.mmx_cmp",
+    "EventCode": "0x0b",
+    "BriefDescription": "Retired MMX integer compare ops.",
+    "UMask": "0x07"
+  },
+  {
+    "EventName": "sse_avx_ops_retired.mmx_shift",
+    "EventCode": "0x0b",
+    "BriefDescription": "Retired MMX integer shift ops.",
+    "UMask": "0x09"
+  },
+  {
+    "EventName": "sse_avx_ops_retired.mmx_mov",
+    "EventCode": "0x0b",
+    "BriefDescription": "Retired MMX integer MOV ops.",
+    "UMask": "0x0a"
+  },
+  {
+    "EventName": "sse_avx_ops_retired.mmx_shuffle",
+    "EventCode": "0x0b",
+    "BriefDescription": "Retired MMX integer shuffle ops (may include instructions not necessarily thought of as including shuffles e.g. horizontal add, dot product, and certain MOV instructions).",
+    "UMask": "0x0b"
+  },
+  {
+    "EventName": "sse_avx_ops_retired.mmx_pack",
+    "EventCode": "0x0b",
+    "BriefDescription": "Retired MMX integer pack ops.",
+    "UMask": "0x0c"
+  },
+  {
+    "EventName": "sse_avx_ops_retired.mmx_logical",
+    "EventCode": "0x0b",
+    "BriefDescription": "Retired MMX integer logical ops.",
+    "UMask": "0x0d"
+  },
+  {
+    "EventName": "sse_avx_ops_retired.mmx_other",
+    "EventCode": "0x0b",
+    "BriefDescription": "Retired MMX integer multiply ops of other types.",
+    "UMask": "0x0e"
+  },
+  {
+    "EventName": "sse_avx_ops_retired.mmx_all",
+    "EventCode": "0x0b",
+    "BriefDescription": "Retired MMX integer ops of all types.",
+    "UMask": "0x0f"
+  },
+  {
+    "EventName": "sse_avx_ops_retired.sse_avx_add",
+    "EventCode": "0x0b",
+    "BriefDescription": "Retired SSE and AVX integer add ops.",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "sse_avx_ops_retired.sse_avx_sub",
+    "EventCode": "0x0b",
+    "BriefDescription": "Retired SSE and AVX integer subtract ops.",
+    "UMask": "0x20"
+  },
+  {
+    "EventName": "sse_avx_ops_retired.sse_avx_mul",
+    "EventCode": "0x0b",
+    "BriefDescription": "Retired SSE and AVX integer multiply ops.",
+    "UMask": "0x30"
+  },
+  {
+    "EventName": "sse_avx_ops_retired.sse_avx_mac",
+    "EventCode": "0x0b",
+    "BriefDescription": "Retired SSE and AVX integer multiply-accumulate ops.",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "sse_avx_ops_retired.sse_avx_aes",
+    "EventCode": "0x0b",
+    "BriefDescription": "Retired SSE and AVX integer AES ops.",
+    "UMask": "0x50"
+  },
+  {
+    "EventName": "sse_avx_ops_retired.sse_avx_sha",
+    "EventCode": "0x0b",
+    "BriefDescription": "Retired SSE and AVX integer SHA ops.",
+    "UMask": "0x60"
+  },
+  {
+    "EventName": "sse_avx_ops_retired.sse_avx_cmp",
+    "EventCode": "0x0b",
+    "BriefDescription": "Retired SSE and AVX integer compare ops.",
+    "UMask": "0x70"
+  },
+  {
+    "EventName": "sse_avx_ops_retired.sse_avx_clm",
+    "EventCode": "0x0b",
+    "BriefDescription": "Retired SSE and AVX integer CLM ops.",
+    "UMask": "0x80"
+  },
+  {
+    "EventName": "sse_avx_ops_retired.sse_avx_shift",
+    "EventCode": "0x0b",
+    "BriefDescription": "Retired SSE and AVX integer shift ops.",
+    "UMask": "0x90"
+  },
+  {
+    "EventName": "sse_avx_ops_retired.sse_avx_mov",
+    "EventCode": "0x0b",
+    "BriefDescription": "Retired SSE and AVX integer MOV ops.",
+    "UMask": "0xa0"
+  },
+  {
+    "EventName": "sse_avx_ops_retired.sse_avx_shuffle",
+    "EventCode": "0x0b",
+    "BriefDescription": "Retired SSE and AVX integer shuffle ops (may include instructions not necessarily thought of as including shuffles e.g. horizontal add, dot product, and certain MOV instructions).",
+    "UMask": "0xb0"
+  },
+  {
+    "EventName": "sse_avx_ops_retired.sse_avx_pack",
+    "EventCode": "0x0b",
+    "BriefDescription": "Retired SSE and AVX integer pack ops.",
+    "UMask": "0xc0"
+  },
+  {
+    "EventName": "sse_avx_ops_retired.sse_avx_logical",
+    "EventCode": "0x0b",
+    "BriefDescription": "Retired SSE and AVX integer logical ops.",
+    "UMask": "0xd0"
+  },
+  {
+    "EventName": "sse_avx_ops_retired.sse_avx_other",
+    "EventCode": "0x0b",
+    "BriefDescription": "Retired SSE and AVX integer ops of other types.",
+    "UMask": "0xe0"
+  },
+  {
+    "EventName": "sse_avx_ops_retired.sse_avx_all",
+    "EventCode": "0x0b",
+    "BriefDescription": "Retired SSE and AVX integer ops of all types.",
+    "UMask": "0xf0"
+  },
+  {
+    "EventName": "sse_avx_ops_retired.all",
+    "EventCode": "0x0b",
+    "BriefDescription": "Retired SSE, AVX and MMX integer ops of all types.",
+    "UMask": "0xff"
+  },
+  {
+    "EventName": "fp_pack_ops_retired.fp128_add",
+    "EventCode": "0x0c",
+    "BriefDescription": "Retired 128-bit packed floating-point add ops.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "fp_pack_ops_retired.fp128_sub",
+    "EventCode": "0x0c",
+    "BriefDescription": "Retired 128-bit packed floating-point subtract ops.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "fp_pack_ops_retired.fp128_mul",
+    "EventCode": "0x0c",
+    "BriefDescription": "Retired 128-bit packed floating-point multiply ops.",
+    "UMask": "0x03"
+  },
+  {
+    "EventName": "fp_pack_ops_retired.fp128_mac",
+    "EventCode": "0x0c",
+    "BriefDescription": "Retired 128-bit packed floating-point multiply-accumulate ops.",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "fp_pack_ops_retired.fp128_div",
+    "EventCode": "0x0c",
+    "BriefDescription": "Retired 128-bit packed floating-point divide ops.",
+    "UMask": "0x05"
+  },
+  {
+    "EventName": "fp_pack_ops_retired.fp128_sqrt",
+    "EventCode": "0x0c",
+    "BriefDescription": "Retired 128-bit packed floating-point square root ops.",
+    "UMask": "0x06"
+  },
+  {
+    "EventName": "fp_pack_ops_retired.fp128_cmp",
+    "EventCode": "0x0c",
+    "BriefDescription": "Retired 128-bit packed floating-point compare ops.",
+    "UMask": "0x07"
+  },
+  {
+    "EventName": "fp_pack_ops_retired.fp128_cvt",
+    "EventCode": "0x0c",
+    "BriefDescription": "Retired 128-bit packed floating-point convert ops.",
+    "UMask": "0x08"
+  },
+  {
+    "EventName": "fp_pack_ops_retired.fp128_blend",
+    "EventCode": "0x0c",
+    "BriefDescription": "Retired 128-bit packed floating-point blend ops.",
+    "UMask": "0x09"
+  },
+  {
+    "EventName": "fp_pack_ops_retired.fp128_shuffle",
+    "EventCode": "0x0c",
+    "BriefDescription": "Retired 128-bit packed floating-point shuffle ops (may include instructions not necessarily thought of as including shuffles e.g. horizontal add, dot product, and certain MOV instructions).",
+    "UMask": "0x0b"
+  },
+  {
+    "EventName": "fp_pack_ops_retired.fp128_logical",
+    "EventCode": "0x0c",
+    "BriefDescription": "Retired 128-bit packed floating-point logical ops.",
+    "UMask": "0x0d"
+  },
+  {
+    "EventName": "fp_pack_ops_retired.fp128_other",
+    "EventCode": "0x0c",
+    "BriefDescription": "Retired 128-bit packed floating-point ops of other types.",
+    "UMask": "0x0e"
+  },
+  {
+    "EventName": "fp_pack_ops_retired.fp128_all",
+    "EventCode": "0x0c",
+    "BriefDescription": "Retired 128-bit packed floating-point ops of all types.",
+    "UMask": "0x0f"
+  },
+  {
+    "EventName": "fp_pack_ops_retired.fp256_add",
+    "EventCode": "0x0c",
+    "BriefDescription": "Retired 256-bit packed floating-point add ops.",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "fp_pack_ops_retired.fp256_sub",
+    "EventCode": "0x0c",
+    "BriefDescription": "Retired 256-bit packed floating-point subtract ops.",
+    "UMask": "0x20"
+  },
+  {
+    "EventName": "fp_pack_ops_retired.fp256_mul",
+    "EventCode": "0x0c",
+    "BriefDescription": "Retired 256-bit packed floating-point multiply ops.",
+    "UMask": "0x30"
+  },
+  {
+    "EventName": "fp_pack_ops_retired.fp256_mac",
+    "EventCode": "0x0c",
+    "BriefDescription": "Retired 256-bit packed floating-point multiply-accumulate ops.",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "fp_pack_ops_retired.fp256_div",
+    "EventCode": "0x0c",
+    "BriefDescription": "Retired 256-bit packed floating-point divide ops.",
+    "UMask": "0x50"
+  },
+  {
+    "EventName": "fp_pack_ops_retired.fp256_sqrt",
+    "EventCode": "0x0c",
+    "BriefDescription": "Retired 256-bit packed floating-point square root ops.",
+    "UMask": "0x60"
+  },
+  {
+    "EventName": "fp_pack_ops_retired.fp256_cmp",
+    "EventCode": "0x0c",
+    "BriefDescription": "Retired 256-bit packed floating-point compare ops.",
+    "UMask": "0x70"
+  },
+  {
+    "EventName": "fp_pack_ops_retired.fp256_cvt",
+    "EventCode": "0x0c",
+    "BriefDescription": "Retired 256-bit packed floating-point convert ops.",
+    "UMask": "0x80"
+  },
+  {
+    "EventName": "fp_pack_ops_retired.fp256_blend",
+    "EventCode": "0x0c",
+    "BriefDescription": "Retired 256-bit packed floating-point blend ops.",
+    "UMask": "0x90"
+  },
+  {
+    "EventName": "fp_pack_ops_retired.fp256_shuffle",
+    "EventCode": "0x0c",
+    "BriefDescription": "Retired 256-bit packed floating-point shuffle ops (may include instructions not necessarily thought of as including shuffles e.g. horizontal add, dot product, and certain MOV instructions).",
+    "UMask": "0xb0"
+  },
+  {
+    "EventName": "fp_pack_ops_retired.fp256_logical",
+    "EventCode": "0x0c",
+    "BriefDescription": "Retired 256-bit packed floating-point logical ops.",
+    "UMask": "0xd0"
+  },
+  {
+    "EventName": "fp_pack_ops_retired.fp256_other",
+    "EventCode": "0x0c",
+    "BriefDescription": "Retired 256-bit packed floating-point ops of other types.",
+    "UMask": "0xe0"
+  },
+  {
+    "EventName": "fp_pack_ops_retired.fp256_all",
+    "EventCode": "0x0c",
+    "BriefDescription": "Retired 256-bit packed floating-point ops of all types.",
+    "UMask": "0xf0"
+  },
+  {
+    "EventName": "fp_pack_ops_retired.all",
+    "EventCode": "0x0c",
+    "BriefDescription": "Retired packed floating-point ops of all types.",
+    "UMask": "0xff"
+  },
+  {
+    "EventName": "packed_int_op_type.int128_add",
+    "EventCode": "0x0d",
+    "BriefDescription": "Retired 128-bit packed integer add ops.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "packed_int_op_type.int128_sub",
+    "EventCode": "0x0d",
+    "BriefDescription": "Retired 128-bit packed integer subtract ops.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "packed_int_op_type.int128_mul",
+    "EventCode": "0x0d",
+    "BriefDescription": "Retired 128-bit packed integer multiply ops.",
+    "UMask": "0x03"
+  },
+  {
+    "EventName": "packed_int_op_type.int128_mac",
+    "EventCode": "0x0d",
+    "BriefDescription": "Retired 128-bit packed integer multiply-accumulate ops.",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "packed_int_op_type.int128_aes",
+    "EventCode": "0x0d",
+    "BriefDescription": "Retired 128-bit packed integer AES ops.",
+    "UMask": "0x05"
+  },
+  {
+    "EventName": "packed_int_op_type.int128_sha",
+    "EventCode": "0x0d",
+    "BriefDescription": "Retired 128-bit packed integer SHA ops.",
+    "UMask": "0x06"
+  },
+  {
+    "EventName": "packed_int_op_type.int128_cmp",
+    "EventCode": "0x0d",
+    "BriefDescription": "Retired 128-bit packed integer compare ops.",
+    "UMask": "0x07"
+  },
+  {
+    "EventName": "packed_int_op_type.int128_clm",
+    "EventCode": "0x0d",
+    "BriefDescription": "Retired 128-bit packed integer CLM ops.",
+    "UMask": "0x08"
+  },
+  {
+    "EventName": "packed_int_op_type.int128_shift",
+    "EventCode": "0x0d",
+    "BriefDescription": "Retired 128-bit packed integer shift ops.",
+    "UMask": "0x09"
+  },
+  {
+    "EventName": "packed_int_op_type.int128_mov",
+    "EventCode": "0x0d",
+    "BriefDescription": "Retired 128-bit packed integer MOV ops.",
+    "UMask": "0x0a"
+  },
+  {
+    "EventName": "packed_int_op_type.int128_shuffle",
+    "EventCode": "0x0d",
+    "BriefDescription": "Retired 128-bit packed integer shuffle ops (may include instructions not necessarily thought of as including shuffles e.g. horizontal add, dot product, and certain MOV instructions).",
+    "UMask": "0x0b"
+  },
+  {
+    "EventName": "packed_int_op_type.int128_pack",
+    "EventCode": "0x0d",
+    "BriefDescription": "Retired 128-bit packed integer pack ops.",
+    "UMask": "0x0c"
+  },
+  {
+    "EventName": "packed_int_op_type.int128_logical",
+    "EventCode": "0x0d",
+    "BriefDescription": "Retired 128-bit packed integer logical ops.",
+    "UMask": "0x0d"
+  },
+  {
+    "EventName": "packed_int_op_type.int128_other",
+    "EventCode": "0x0d",
+    "BriefDescription": "Retired 128-bit packed integer ops of other types.",
+    "UMask": "0x0e"
+  },
+  {
+    "EventName": "packed_int_op_type.int128_all",
+    "EventCode": "0x0d",
+    "BriefDescription": "Retired 128-bit packed integer ops of all types.",
+    "UMask": "0x0f"
+  },
+  {
+    "EventName": "packed_int_op_type.int256_add",
+    "EventCode": "0x0d",
+    "BriefDescription": "Retired 256-bit packed integer add ops.",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "packed_int_op_type.int256_sub",
+    "EventCode": "0x0d",
+    "BriefDescription": "Retired 256-bit packed integer subtract ops.",
+    "UMask": "0x20"
+  },
+  {
+    "EventName": "packed_int_op_type.int256_mul",
+    "EventCode": "0x0d",
+    "BriefDescription": "Retired 256-bit packed integer multiply ops.",
+    "UMask": "0x30"
+  },
+  {
+    "EventName": "packed_int_op_type.int256_mac",
+    "EventCode": "0x0d",
+    "BriefDescription": "Retired 256-bit packed integer multiply-accumulate ops.",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "packed_int_op_type.int256_cmp",
+    "EventCode": "0x0d",
+    "BriefDescription": "Retired 256-bit packed integer compare ops.",
+    "UMask": "0x70"
+  },
+  {
+    "EventName": "packed_int_op_type.int256_shift",
+    "EventCode": "0x0d",
+    "BriefDescription": "Retired 256-bit packed integer shift ops.",
+    "UMask": "0x90"
+  },
+  {
+    "EventName": "packed_int_op_type.int256_mov",
+    "EventCode": "0x0d",
+    "BriefDescription": "Retired 256-bit packed integer MOV ops.",
+    "UMask": "0xa0"
+  },
+  {
+    "EventName": "packed_int_op_type.int256_shuffle",
+    "EventCode": "0x0d",
+    "BriefDescription": "Retired 256-bit packed integer shuffle ops (may include instructions not necessarily thought of as including shuffles e.g. horizontal add, dot product, and certain MOV instructions).",
+    "UMask": "0xb0"
+  },
+  {
+    "EventName": "packed_int_op_type.int256_pack",
+    "EventCode": "0x0d",
+    "BriefDescription": "Retired 256-bit packed integer pack ops.",
+    "UMask": "0xc0"
+  },
+  {
+    "EventName": "packed_int_op_type.int256_logical",
+    "EventCode": "0x0d",
+    "BriefDescription": "Retired 256-bit packed integer logical ops.",
+    "UMask": "0xd0"
+  },
+  {
+    "EventName": "packed_int_op_type.int256_other",
+    "EventCode": "0x0d",
+    "BriefDescription": "Retired 256-bit packed integer ops of other types.",
+    "UMask": "0xe0"
+  },
+  {
+    "EventName": "packed_int_op_type.int256_all",
+    "EventCode": "0x0d",
+    "BriefDescription": "Retired 256-bit packed integer ops of all types.",
+    "UMask": "0xf0"
+  },
+  {
+    "EventName": "packed_int_op_type.all",
+    "EventCode": "0x0d",
+    "BriefDescription": "Retired packed integer ops of all types.",
+    "UMask": "0xff"
+  },
+  {
+    "EventName": "fp_disp_faults.x87_fill_fault",
+    "EventCode": "0x0e",
+    "BriefDescription": "Floating-point dispatch faults for x87 fills.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "fp_disp_faults.xmm_fill_fault",
+    "EventCode": "0x0e",
+    "BriefDescription": "Floating-point dispatch faults for XMM fills.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "fp_disp_faults.ymm_fill_fault",
+    "EventCode": "0x0e",
+    "BriefDescription": "Floating-point dispatch faults for YMM fills.",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "fp_disp_faults.ymm_spill_fault",
+    "EventCode": "0x0e",
+    "BriefDescription": "Floating-point dispatch faults for YMM spills.",
+    "UMask": "0x08"
+  },
+  {
+    "EventName": "fp_disp_faults.sse_avx_all",
+    "EventCode": "0x0e",
+    "BriefDescription": "Floating-point dispatch faults of all types for SSE and AVX ops.",
+    "UMask": "0x0e"
+  },
+  {
+    "EventName": "fp_disp_faults.all",
+    "EventCode": "0x0e",
+    "BriefDescription": "Floating-point dispatch faults of all types.",
+    "UMask": "0x0f"
+  }
+]
diff --git a/tools/perf/pmu-events/arch/x86/amdzen4/memory.json b/tools/perf/pmu-events/arch/x86/amdzen4/memory.json
new file mode 100644
index 000000000000..cb1517f8f399
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/amdzen4/memory.json
@@ -0,0 +1,174 @@
+[
+  {
+    "EventName": "ls_bad_status2.stli_other",
+    "EventCode": "0x24",
+    "BriefDescription": "Store-to-load conflicts (load unable to complete due to a non-forwardable conflict with an older store).",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "ls_dispatch.ld_dispatch",
+    "EventCode": "0x29",
+    "BriefDescription": "Number of memory load operations dispatched to the load-store unit.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "ls_dispatch.store_dispatch",
+    "EventCode": "0x29",
+    "BriefDescription": "Number of memory store operations dispatched to the load-store unit.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "ls_dispatch.ld_st_dispatch",
+    "EventCode": "0x29",
+    "BriefDescription": "Number of memory load-store operations dispatched to the load-store unit.",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "ls_stlf",
+    "EventCode": "0x35",
+    "BriefDescription": "Store-to-load-forward (STLF) hits."
+  },
+  {
+    "EventName": "ls_st_commit_cancel2.st_commit_cancel_wcb_full",
+    "EventCode": "0x37",
+    "BriefDescription": "Non-cacheable store commits cancelled due to the non-cacheable commit buffer being full.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "ls_l1_d_tlb_miss.tlb_reload_4k_l2_hit",
+    "EventCode": "0x45",
+    "BriefDescription": "L1 DTLB misses with L2 DTLB hits for 4k pages.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "ls_l1_d_tlb_miss.tlb_reload_coalesced_page_hit",
+    "EventCode": "0x45",
+    "BriefDescription": "L1 DTLB misses with L2 DTLB hits for coalesced pages. A coalesced page is a 16k page created from four adjacent 4k pages.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "ls_l1_d_tlb_miss.tlb_reload_2m_l2_hit",
+    "EventCode": "0x45",
+    "BriefDescription": "L1 DTLB misses with L2 DTLB hits for 2M pages.",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "ls_l1_d_tlb_miss.tlb_reload_1g_l2_hit",
+    "EventCode": "0x45",
+    "BriefDescription": "L1 DTLB misses with L2 DTLB hits for 1G pages.",
+    "UMask": "0x08"
+  },
+  {
+    "EventName": "ls_l1_d_tlb_miss.tlb_reload_4k_l2_miss",
+    "EventCode": "0x45",
+    "BriefDescription": "L1 DTLB misses with L2 DTLB misses (page-table walks are requested) for 4k pages.",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "ls_l1_d_tlb_miss.tlb_reload_coalesced_page_miss",
+    "EventCode": "0x45",
+    "BriefDescription": "L1 DTLB misses with L2 DTLB misses (page-table walks are requested) for coalesced pages. A coalesced page is a 16k page created from four adjacent 4k pages.",
+    "UMask": "0x20"
+  },
+  {
+    "EventName": "ls_l1_d_tlb_miss.tlb_reload_2m_l2_miss",
+    "EventCode": "0x45",
+    "BriefDescription": "L1 DTLB misses with L2 DTLB misses (page-table walks are requested) for 2M pages.",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "ls_l1_d_tlb_miss.tlb_reload_1g_l2_miss",
+    "EventCode": "0x45",
+    "BriefDescription": "L1 DTLB misses with L2 DTLB misses (page-table walks are requested) for 1G pages.",
+    "UMask": "0x80"
+  },
+  {
+    "EventName": "ls_l1_d_tlb_miss.all_l2_miss",
+    "EventCode": "0x45",
+    "BriefDescription": "L1 DTLB misses with L2 DTLB misses (page-table walks are requested) for all page sizes.",
+    "UMask": "0xf0"
+  },
+  {
+    "EventName": "ls_l1_d_tlb_miss.all",
+    "EventCode": "0x45",
+    "BriefDescription": "L1 DTLB misses for all page sizes.",
+    "UMask": "0xff"
+  },
+  {
+    "EventName": "ls_misal_loads.ma64",
+    "EventCode": "0x47",
+    "BriefDescription": "64B misaligned (cacheline crossing) loads.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "ls_misal_loads.ma4k",
+    "EventCode": "0x47",
+    "BriefDescription": "4kB misaligned (page crossing) loads.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "ls_tlb_flush.all",
+    "EventCode": "0x78",
+    "BriefDescription": "All TLB Flushes.",
+    "UMask": "0xff"
+  },
+  {
+    "EventName": "bp_l1_tlb_miss_l2_tlb_hit",
+    "EventCode": "0x84",
+    "BriefDescription": "Instruction fetches that miss in the L1 ITLB but hit in the L2 ITLB."
+  },
+  {
+    "EventName": "bp_l1_tlb_miss_l2_tlb_miss.if4k",
+    "EventCode": "0x85",
+    "BriefDescription": "Instruction fetches that miss in both the L1 and L2 ITLBs (page-table walks are requested) for 4k pages.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "bp_l1_tlb_miss_l2_tlb_miss.if2m",
+    "EventCode": "0x85",
+    "BriefDescription": "Instruction fetches that miss in both the L1 and L2 ITLBs (page-table walks are requested) for 2M pages.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "bp_l1_tlb_miss_l2_tlb_miss.if1g",
+    "EventCode": "0x85",
+    "BriefDescription": "Instruction fetches that miss in both the L1 and L2 ITLBs (page-table walks are requested) for 1G pages.",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "bp_l1_tlb_miss_l2_tlb_miss.coalesced_4k",
+    "EventCode": "0x85",
+    "BriefDescription": "Instruction fetches that miss in both the L1 and L2 ITLBs (page-table walks are requested) for coalesced pages. A coalesced page is a 16k page created from four adjacent 4k pages.",
+    "UMask": "0x08"
+  },
+  {
+    "EventName": "bp_l1_tlb_miss_l2_tlb_miss.all",
+    "EventCode": "0x85",
+    "BriefDescription": "Instruction fetches that miss in both the L1 and L2 ITLBs (page-table walks are requested) for all page sizes.",
+    "UMask": "0x0f"
+  },
+  {
+    "EventName": "bp_l1_tlb_fetch_hit.if4k",
+    "EventCode": "0x94",
+    "BriefDescription": "Instruction fetches that hit in the L1 ITLB for 4k or coalesced pages. A coalesced page is a 16k page created from four adjacent 4k pages.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "bp_l1_tlb_fetch_hit.if2m",
+    "EventCode": "0x94",
+    "BriefDescription": "Instruction fetches that hit in the L1 ITLB for 2M pages.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "bp_l1_tlb_fetch_hit.if1g",
+    "EventCode": "0x94",
+    "BriefDescription": "Instruction fetches that hit in the L1 ITLB for 1G pages.",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "bp_l1_tlb_fetch_hit.all",
+    "EventCode": "0x94",
+    "BriefDescription": "Instruction fetches that hit in the L1 ITLB for all page sizes.",
+    "UMask": "0x07"
+  }
+]
diff --git a/tools/perf/pmu-events/arch/x86/amdzen4/other.json b/tools/perf/pmu-events/arch/x86/amdzen4/other.json
new file mode 100644
index 000000000000..a02a9c807289
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/amdzen4/other.json
@@ -0,0 +1,138 @@
+[
+  {
+    "EventName": "resyncs_or_nc_redirects",
+    "EventCode": "0x96",
+    "BriefDescription": "Pipeline restarts not caused by branch mispredicts."
+  },
+  {
+    "EventName": "de_op_queue_empty",
+    "EventCode": "0xa9",
+    "BriefDescription": "Cycles when the op queue is empty. Such cycles indicate that the front-end is not delivering instructions fast enough."
+  },
+  {
+    "EventName": "de_src_op_disp.decoder",
+    "EventCode": "0xaa",
+    "BriefDescription": "Ops fetched from instruction cache and dispatched.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "de_src_op_disp.op_cache",
+    "EventCode": "0xaa",
+    "BriefDescription": "Ops fetched from op cache and dispatched.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "de_src_op_disp.loop_buffer",
+    "EventCode": "0xaa",
+    "BriefDescription": "Ops dispatched from loop buffer.",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "de_src_op_disp.all",
+    "EventCode": "0xaa",
+    "BriefDescription": "Ops dispatched from any source.",
+    "UMask": "0x07"
+  },
+  {
+    "EventName": "de_dis_ops_from_decoder.any_fp_dispatch",
+    "EventCode": "0xab",
+    "BriefDescription": "Number of ops dispatched to the floating-point unit.",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "de_dis_ops_from_decoder.disp_op_type.any_integer_dispatch",
+    "EventCode": "0xab",
+    "BriefDescription": "Number of ops dispatched to the integer execution unit.",
+    "UMask": "0x08"
+  },
+  {
+    "EventName": "de_dis_dispatch_token_stalls1.int_phy_reg_file_rsrc_stall",
+    "EventCode": "0xae",
+    "BriefDescription": "Number of cycles dispatch is stalled for integer physical register file tokens.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "de_dis_dispatch_token_stalls1.load_queue_rsrc_stall",
+    "EventCode": "0xae",
+    "BriefDescription": "Number of cycles dispatch is stalled for Load queue token.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "de_dis_dispatch_token_stalls1.store_queue_rsrc_stall",
+    "EventCode": "0xae",
+    "BriefDescription": "Number of cycles dispatch is stalled for store queue tokens.",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "de_dis_dispatch_token_stalls1.taken_brnch_buffer_rsrc",
+    "EventCode": "0xae",
+    "BriefDescription": "Number of cycles dispatch is stalled for taken branch buffer tokens.",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "de_dis_dispatch_token_stalls1.fp_reg_file_rsrc_stall",
+    "EventCode": "0xae",
+    "BriefDescription": "Number of cycles dispatch is stalled for floating-point register file tokens.",
+    "UMask": "0x20"
+  },
+  {
+    "EventName": "de_dis_dispatch_token_stalls1.fp_sch_rsrc_stall",
+    "EventCode": "0xae",
+    "BriefDescription": "Number of cycles dispatch is stalled for floating-point scheduler tokens.",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "de_dis_dispatch_token_stalls1.fp_flush_recovery_stall",
+    "EventCode": "0xae",
+    "BriefDescription": "Number of cycles dispatch is stalled for floating-point flush recovery.",
+    "UMask": "0x80"
+  },
+  {
+    "EventName": "de_dis_dispatch_token_stalls2.int_sch0_token_stall",
+    "EventCode": "0xaf",
+    "BriefDescription": "Number of cycles dispatch is stalled for integer scheduler queue 0 tokens.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "de_dis_dispatch_token_stalls2.int_sch1_token_stall",
+    "EventCode": "0xaf",
+    "BriefDescription": "Number of cycles dispatch is stalled for integer scheduler queue 1 tokens.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "de_dis_dispatch_token_stalls2.int_sch2_token_stall",
+    "EventCode": "0xaf",
+    "BriefDescription": "Number of cycles dispatch is stalled for integer scheduler queue 2 tokens.",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "de_dis_dispatch_token_stalls2.int_sch3_token_stall",
+    "EventCode": "0xaf",
+    "BriefDescription": "Number of cycles dispatch is stalled for integer scheduler queue 3 tokens.",
+    "UMask": "0x08"
+  },
+  {
+    "EventName": "de_dis_dispatch_token_stalls2.retire_token_stall",
+    "EventCode": "0xaf",
+    "BriefDescription": "Number of cycles dispatch is stalled for retire queue tokens.",
+    "UMask": "0x20"
+  },
+  {
+    "EventName": "de_no_dispatch_per_slot.no_ops_from_frontend",
+    "EventCode": "0x1a0",
+    "BriefDescription": "In each cycle counts dispatch slots left empty because the front-end did not supply ops.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "de_no_dispatch_per_slot.backend_stalls",
+    "EventCode": "0x1a0",
+    "BriefDescription": "In each cycle counts ops unable to dispatch because of back-end stalls.",
+    "UMask": "0x1e"
+  },
+  {
+    "EventName": "de_no_dispatch_per_slot.smt_contention",
+    "EventCode": "0x1a0",
+    "BriefDescription": "In each cycle counts ops unable to dispatch because the dispatch cycle was granted to the other SMT thread.",
+    "UMask": "0x60"
+  }
+]
-- 
2.34.1


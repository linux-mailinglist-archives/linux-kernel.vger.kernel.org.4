Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0097663905
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 07:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237586AbjAJGDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 01:03:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237820AbjAJGCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 01:02:49 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 140234434F;
        Mon,  9 Jan 2023 22:00:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BXYdq6Bqsf0usy5iJ7+myBuH2l4WKCccx/Zw8xt19LBLQsyLuTAmv8hiUUdotjPTet6zymjS5Twez1M091PDeXFWhMacYi1S18nOJQd5zRRWisx/D1GH48CuuG24bpenngh2uGlCHrTX+VCvBkq652YHyP7I4+FhT1YtCy9oW+0i/YV90YbF7kYjgKxzUcatiLddmtXuYN6iT9GAW64s5WPhE8y8VoNogD7VkBfd0h8We6SKGHx2M4qR0UeSjSr9nVKUTrwtN4VPW9ewrRyt5iuZYDWtl+nZqwnFU8URAgGYwijP31750vJHeEgQJBVhr8vegLYEuewU14VWuEp7TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=opDXUbPGOyQRl9ljUbpBM+LGGs5hzMtyGQkKWHuGCEw=;
 b=Dt/ux23bPgVmHpbqC4p4FmePZDtdx2n5pvJ5Ed51qM72IItONlpWZCABOA0YFFWrA+VphhnxCzYlLU8OKa93PLnSdzn/JIlVBUcYQkb9dribjrQsAL9WS4aLELdd74944AGrZGiNIpgYd9mCDmousKBwXRr6Kmh+YgqHD3J03hWG/Jh6rIBPw3apWR0ltFmK9B+c3JxDato9wHDUOrCXrvenDcPjTbQp7YNvE1Zmr+lOr0+9hLX6q6WnCKWrTYaa9A4V4Tbyq3vjXztAPVc0AS3K6FcCsRlO/79eNDR5FgObh1NZATo3I2YFj0HytOaEc2YmHDMVOdCwKH8rMwtjfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=opDXUbPGOyQRl9ljUbpBM+LGGs5hzMtyGQkKWHuGCEw=;
 b=Id47QdmjEgW+7K95QjtGTT8Da4IXpIEHN4fSug+ohNzeifgP2LrwkDnlVsuy85epdpOfG2Ms9ptjj59Hlvdl6WmncaDumdNFTR6JRjL+wB+kc7wUzQhhDvAe+I61BcsMxkkBNNZXNEhTw44icF3VhOo+P1xxFmOKbumYAA3DJDw=
Received: from MW4PR03CA0083.namprd03.prod.outlook.com (2603:10b6:303:b6::28)
 by DM4PR12MB6112.namprd12.prod.outlook.com (2603:10b6:8:aa::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.18; Tue, 10 Jan 2023 06:00:25 +0000
Received: from CO1NAM11FT081.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::36) by MW4PR03CA0083.outlook.office365.com
 (2603:10b6:303:b6::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18 via Frontend
 Transport; Tue, 10 Jan 2023 06:00:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT081.mail.protection.outlook.com (10.13.174.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5986.18 via Frontend Transport; Tue, 10 Jan 2023 06:00:24 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 9 Jan
 2023 23:59:44 -0600
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
Subject: [RFC 4/4] perf tool: Fix non-".text" symbol resolution for kernel modules
Date:   Tue, 10 Jan 2023 11:28:59 +0530
Message-ID: <20230110055859.685-5-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT081:EE_|DM4PR12MB6112:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e43e5e7-e2ac-4e7b-0619-08daf2cff76c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4dmajC0j1tbdd/Kb1o6JDKVT3OQb1W94qs3mqsJDcRu+d5QqX8u8nlDM4hzEWFtY9/pd0+a/WTzguZiSQHN4yGbPVfrx+FvD+WeswmwTx6zwbao5zbug7vc28YSI23bm1nGRyiE7t1cbqJJqdac/dPXHFflgMxNNrbl+oaDBCxeaBzrd2klPpTiCkAh7NxFHBStaXcNnu60q3+Ws4E0Fhiid2centTkBoqbOOqr/mdo71tUdLkU5FBDJXv0+rYpS3a1aP2DJoDDcHtN8ydFgqh4gEc7pRYwbkA7FSGD9acEUatswNjLADRkugvrXpg1FFZcomw7sMCmz+pGXZY91ASRjf4WxF6AwD8ejFQUzCndBHVghJMxc9j0JsQhhP6JxYwOPnusrFu+vM/9/S/iuVmiorkmstSs633KYthVgOqkryotO1zfQAybGbGgYvll+YIZPcpe+nWlOdeKxqcHhwCGNd4aqFqTUWFrXunLOopgnRtcn/j05fDtgb7vvSc6VVAtVhNw5AEu7keeMeKA/qtjJ0NzHC04Sr/1Sd5NXyn80d+iQ1FR3ASRTj7Ts1nEIDvkFQflMzXi3aRNoWW1aRZD2sv2DtGg1uFMPlCTTGjvdjuh+LYskLjOtxxmRGtr7oQjkTVz3GA492AxpRgJOIDLOS2QoHY8PSGfjxwlvp2E/+2NiMKPrv7BIyuylVRgVgGu2WVk4B23cdaXfLtOPD1buP0hK+iP1C4w7F7MbHUkxhVYhH6BwhbkKp1sNDq6j6xXwnrlCRS/yOR0GfXxtwQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(346002)(136003)(396003)(451199015)(40470700004)(46966006)(36840700001)(26005)(40480700001)(478600001)(16526019)(1076003)(336012)(186003)(6916009)(2616005)(8676002)(70586007)(6666004)(41300700001)(70206006)(4326008)(54906003)(7696005)(316002)(47076005)(83380400001)(36860700001)(86362001)(81166007)(82740400003)(40460700003)(356005)(426003)(30864003)(82310400005)(2906002)(7416002)(5660300002)(36756003)(8936002)(44832011)(21314003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 06:00:24.8144
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e43e5e7-e2ac-4e7b-0619-08daf2cff76c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT081.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6112
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel module elf contains executable code in non-".text" sections as
well, for ex: ".noinstr.text". Plus, kernel module's memory layout
differs from it's binary layout because .ko elf does not contain
program header table.

Perf tries to solve it by creating special maps for allocated (SHF_ALLOC)
elf sections, but perf uses elf addresses for map address range and thus
these special maps remains unused because no real ip falls into their
address range.

Solve this by preparing section specific special maps using addresses
provided by sysfs /sys/module/.../sections/. Also save these details via
PERF_RECORD_KMOD_SEC_MAPs in perf.data which can be consumed at perf-
report time.

Without patch:

  # perf record -a -c 5000000
  # perf report
  Overhead  Command          Shared Object           Symbol
    13.20%  qemu-system-x86  [unknown]               [.] 0x00005557527b1973
     6.58%  qemu-system-x86  [kvm_amd]               [k] 0x00000000000151e6
     6.36%  qemu-system-x86  [kernel.vmlinux]        [k] native_load_gdt
     6.21%  qemu-system-x86  [kernel.vmlinux]        [k] native_load_tr_desc
     4.71%  qemu-system-x86  [kvm]                   [k] vcpu_run
     4.52%  qemu-system-x86  [kvm_amd]               [k] svm_vcpu_run
     3.50%  qemu-system-x86  [kvm]                   [k] kvm_cpuid
     2.09%  qemu-system-x86  [kvm]                   [k] kvm_pmu_trigger_event
     1.98%  qemu-system-x86  [kvm_amd]               [k] 0x0000000000015171
     1.05%  qemu-system-x86  [kvm_amd]               [k] svm_handle_exit
     1.04%  qemu-system-x86  [kvm_amd]               [k] 0x00000000000151e2
     0.94%  qemu-system-x86  [kvm_amd]               [k] 0x0000000000015174

  Same perf.data with kallsyms:

  # perf report --kallsyms=/proc/kallsyms
  Overhead  Command          Shared Object           Symbol
    14.22%  qemu-system-x86  [kvm_amd]               [k] __svm_vcpu_run
    13.20%  qemu-system-x86  [unknown]               [.] 0x00005557527b1973
     6.36%  qemu-system-x86  [kernel.vmlinux]        [k] native_load_gdt
     6.21%  qemu-system-x86  [kernel.vmlinux]        [k] native_load_tr_desc
     4.71%  qemu-system-x86  [kvm]                   [k] vcpu_run
     4.52%  qemu-system-x86  [kvm_amd]               [k] svm_vcpu_run
     3.50%  qemu-system-x86  [kvm]                   [k] kvm_cpuid
     2.09%  qemu-system-x86  [kvm]                   [k] kvm_pmu_trigger_event
     1.05%  qemu-system-x86  [kvm_amd]               [k] svm_handle_exit

With patch:

  # perf record -a -c 5000000
  # perf report
  Overhead  Command          Shared Object           Symbol
    13.44%  qemu-system-x86  [kvm-amd].noinstr.text  [k] __svm_vcpu_run
    13.25%  qemu-system-x86  [unknown]               [.] 0x000055f4c6563973
     7.13%  qemu-system-x86  [kernel.vmlinux]        [k] native_load_gdt
     6.00%  qemu-system-x86  [kernel.vmlinux]        [k] native_load_tr_desc
     5.13%  qemu-system-x86  [kvm_amd]               [k] svm_vcpu_run
     4.83%  qemu-system-x86  [kvm]                   [k] vcpu_run
     3.65%  qemu-system-x86  [kvm]                   [k] kvm_cpuid

  Same perf.data with kallsyms:

  # perf report --kallsyms=/proc/kallsyms
  Overhead  Command          Shared Object       Symbol
    13.44%  qemu-system-x86  [kernel.vmlinux]    [k] __svm_vcpu_run
    13.25%  qemu-system-x86  [unknown]           [.] 0x000055f4c6563973
     7.13%  qemu-system-x86  [kernel.vmlinux]    [k] native_load_gdt
     6.00%  qemu-system-x86  [kernel.vmlinux]    [k] native_load_tr_desc
     5.13%  qemu-system-x86  [kernel.vmlinux]    [k] svm_vcpu_run
     4.83%  qemu-system-x86  [kernel.vmlinux]    [k] vcpu_run
     3.65%  qemu-system-x86  [kernel.vmlinux]    [k] kvm_cpuid

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 tools/perf/builtin-annotate.c       |   1 +
 tools/perf/builtin-c2c.c            |   1 +
 tools/perf/builtin-diff.c           |   1 +
 tools/perf/builtin-inject.c         |   1 +
 tools/perf/builtin-kmem.c           |   1 +
 tools/perf/builtin-mem.c            |   1 +
 tools/perf/builtin-record.c         |  14 ++
 tools/perf/builtin-report.c         |   1 +
 tools/perf/builtin-script.c         |  13 ++
 tools/perf/builtin-trace.c          |   1 +
 tools/perf/util/build-id.c          |   1 +
 tools/perf/util/data-convert-bt.c   |   1 +
 tools/perf/util/data-convert-json.c |   1 +
 tools/perf/util/event.c             |  21 +++
 tools/perf/util/event.h             |   5 +
 tools/perf/util/machine.c           | 264 ++++++++++++++++++++++++++++
 tools/perf/util/machine.h           |   2 +
 tools/perf/util/map.c               |   1 +
 tools/perf/util/map.h               |   4 +
 tools/perf/util/session.c           |  11 +-
 tools/perf/util/symbol-elf.c        |   9 +-
 tools/perf/util/symbol.c            |   2 +-
 tools/perf/util/synthetic-events.c  |  61 ++++++-
 23 files changed, 408 insertions(+), 10 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 90458ca6933f..7d315e5f69f6 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -506,6 +506,7 @@ int cmd_annotate(int argc, const char **argv)
 			.auxtrace_info	= perf_event__process_auxtrace_info,
 			.auxtrace	= perf_event__process_auxtrace,
 			.feature	= process_feature_event,
+			.kmod_sec_map	= perf_event__process_kmod_sec_map,
 			.ordered_events = true,
 			.ordering_requires_timestamps = true,
 		},
diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 52d94c7dd836..65e97da8f1cf 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -392,6 +392,7 @@ static struct perf_c2c c2c = {
 		.auxtrace_info  = perf_event__process_auxtrace_info,
 		.auxtrace       = perf_event__process_auxtrace,
 		.auxtrace_error = perf_event__process_auxtrace_error,
+		.kmod_sec_map	= perf_event__process_kmod_sec_map,
 		.ordered_events	= true,
 		.ordering_requires_timestamps = true,
 	},
diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index ed07cc6cca56..c4a60d9074b0 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -476,6 +476,7 @@ static struct perf_diff pdiff = {
 		.lost	= perf_event__process_lost,
 		.namespaces = perf_event__process_namespaces,
 		.cgroup = perf_event__process_cgroup,
+		.kmod_sec_map = perf_event__process_kmod_sec_map,
 		.ordered_events = true,
 		.ordering_requires_timestamps = true,
 	},
diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 3f4e4dd5abf3..5665bf4b9613 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -2180,6 +2180,7 @@ int cmd_inject(int argc, const char **argv)
 			.finished_init	= perf_event__repipe_op2_synth,
 			.compressed	= perf_event__repipe_op4_synth,
 			.auxtrace	= perf_event__repipe_auxtrace,
+			.kmod_sec_map	= perf_event__repipe,
 		},
 		.input_name  = "-",
 		.samples = LIST_HEAD_INIT(inject.samples),
diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
index e20656c431a4..5e472f9fb39c 100644
--- a/tools/perf/builtin-kmem.c
+++ b/tools/perf/builtin-kmem.c
@@ -971,6 +971,7 @@ static struct perf_tool perf_kmem = {
 	.mmap		 = perf_event__process_mmap,
 	.mmap2		 = perf_event__process_mmap2,
 	.namespaces	 = perf_event__process_namespaces,
+	.kmod_sec_map	 = perf_event__process_kmod_sec_map,
 	.ordered_events	 = true,
 };
 
diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
index dedd612eae5e..a5443fb5baf1 100644
--- a/tools/perf/builtin-mem.c
+++ b/tools/perf/builtin-mem.c
@@ -459,6 +459,7 @@ int cmd_mem(int argc, const char **argv)
 			.auxtrace_info  = perf_event__process_auxtrace_info,
 			.auxtrace       = perf_event__process_auxtrace,
 			.auxtrace_error = perf_event__process_auxtrace_error,
+			.kmod_sec_map	= perf_event__process_kmod_sec_map,
 			.ordered_events	= true,
 		},
 		.input_name		 = "perf.data",
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 29dcd454b8e2..1e0285682813 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -3252,6 +3252,19 @@ static int build_id__process_mmap2(struct perf_tool *tool, union perf_event *eve
 	return perf_event__process_mmap2(tool, event, sample, machine);
 }
 
+static int build_id__process_kmod_sec_map(struct perf_tool *tool, union perf_event *event,
+					  struct perf_sample *sample, struct machine *machine)
+{
+	/*
+	 * We already have the kernel maps, put in place via perf_session__create_kernel_maps()
+	 * no need to add them twice.
+	 */
+	if (!(event->header.misc & PERF_RECORD_MISC_USER))
+		return 0;
+
+	return perf_event__process_kmod_sec_map(tool, event, sample, machine);
+}
+
 static int process_timestamp_boundary(struct perf_tool *tool,
 				      union perf_event *event __maybe_unused,
 				      struct perf_sample *sample,
@@ -3320,6 +3333,7 @@ static struct record record = {
 		.mmap2		= build_id__process_mmap2,
 		.itrace_start	= process_timestamp_boundary,
 		.aux		= process_timestamp_boundary,
+		.kmod_sec_map	= build_id__process_kmod_sec_map,
 		.ordered_events	= true,
 	},
 };
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 2ee2ecca208e..b7a9a8f72d63 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1212,6 +1212,7 @@ int cmd_report(int argc, const char **argv)
 			.auxtrace	 = perf_event__process_auxtrace,
 			.event_update	 = perf_event__process_event_update,
 			.feature	 = process_feature_event,
+			.kmod_sec_map	 = perf_event__process_kmod_sec_map,
 			.ordered_events	 = true,
 			.ordering_requires_timestamps = true,
 		},
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 69394ac0a20d..711f77edee60 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2591,6 +2591,17 @@ static int process_mmap2_event(struct perf_tool *tool,
 			   event->mmap2.tid);
 }
 
+static int process_kmod_sec_map_event(struct perf_tool *tool,
+				      union perf_event *event,
+				      struct perf_sample *sample,
+				      struct machine *machine)
+{
+	if (perf_event__process_kmod_sec_map(tool, event, sample, machine) < 0)
+		return -1;
+
+	return print_event(tool, event, sample, machine, event->kmod_sec_map.pid, -1);
+}
+
 static int process_switch_event(struct perf_tool *tool,
 				union perf_event *event,
 				struct perf_sample *sample,
@@ -2775,6 +2786,7 @@ static int __cmd_script(struct perf_script *script)
 	if (script->show_mmap_events) {
 		script->tool.mmap = process_mmap_event;
 		script->tool.mmap2 = process_mmap2_event;
+		script->tool.kmod_sec_map = process_kmod_sec_map_event;
 	}
 	if (script->show_switch_events || (scripting_ops && scripting_ops->process_switch))
 		script->tool.context_switch = process_switch_event;
@@ -3805,6 +3817,7 @@ int cmd_script(int argc, const char **argv)
 			.cpu_map	 = process_cpu_map_event,
 			.throttle	 = process_throttle_event,
 			.unthrottle	 = process_throttle_event,
+			.kmod_sec_map	 = perf_event__process_kmod_sec_map,
 			.ordered_events	 = true,
 			.ordering_requires_timestamps = true,
 		},
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 86e06f136f40..f046a0b8862f 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -4157,6 +4157,7 @@ static int trace__replay(struct trace *trace)
 	trace->tool.tracing_data  = perf_event__process_tracing_data;
 	trace->tool.build_id	  = perf_event__process_build_id;
 	trace->tool.namespaces	  = perf_event__process_namespaces;
+	trace->tool.kmod_sec_map  = perf_event__process_kmod_sec_map;
 
 	trace->tool.ordered_events = true;
 	trace->tool.ordering_requires_timestamps = true;
diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index a839b30c981b..3d26781eb418 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -94,6 +94,7 @@ struct perf_tool build_id__mark_dso_hit_ops = {
 	.exit	= perf_event__exit_del_thread,
 	.attr		 = perf_event__process_attr,
 	.build_id	 = perf_event__process_build_id,
+	.kmod_sec_map	 = perf_event__process_kmod_sec_map,
 	.ordered_events	 = true,
 };
 
diff --git a/tools/perf/util/data-convert-bt.c b/tools/perf/util/data-convert-bt.c
index b842273458b8..200703c15cdc 100644
--- a/tools/perf/util/data-convert-bt.c
+++ b/tools/perf/util/data-convert-bt.c
@@ -1621,6 +1621,7 @@ int bt_convert__perf2ctf(const char *input, const char *path,
 			.tracing_data    = perf_event__process_tracing_data,
 			.build_id        = perf_event__process_build_id,
 			.namespaces      = perf_event__process_namespaces,
+			.kmod_sec_map	 = perf_event__process_kmod_sec_map,
 			.ordered_events  = true,
 			.ordering_requires_timestamps = true,
 		},
diff --git a/tools/perf/util/data-convert-json.c b/tools/perf/util/data-convert-json.c
index ba9d93ce9463..b0e5dbcaccc7 100644
--- a/tools/perf/util/data-convert-json.c
+++ b/tools/perf/util/data-convert-json.c
@@ -326,6 +326,7 @@ int bt_convert__perf2json(const char *input_name, const char *output_name,
 			.auxtrace_info  = perf_event__process_auxtrace_info,
 			.auxtrace       = perf_event__process_auxtrace,
 			.event_update   = perf_event__process_event_update,
+			.kmod_sec_map	= perf_event__process_kmod_sec_map,
 			.ordered_events = true,
 			.ordering_requires_timestamps = true,
 		},
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 1b03061440bc..b13418a773a7 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -297,6 +297,16 @@ size_t perf_event__fprintf_mmap(union perf_event *event, FILE *fp)
 		       event->mmap.filename);
 }
 
+size_t perf_event__fprintf_kmod_sec_map(union perf_event *event, FILE *fp)
+{
+	struct perf_record_kmod_sec_map *ksm = &event->kmod_sec_map;
+
+	return fprintf(fp, " %d: [%#" PRI_lx64 "(%#" PRI_lx64 ") @ %#" PRI_lx64 "]: %c %s %s\n",
+		       ksm->pid, ksm->start, ksm->len, ksm->pgoff,
+		       (event->header.misc & PERF_RECORD_MISC_MMAP_DATA) ? 'r' : 'x',
+		       ksm->data, ksm->data + ksm->sec_name_len + 2);
+}
+
 size_t perf_event__fprintf_mmap2(union perf_event *event, FILE *fp)
 {
 	if (event->header.misc & PERF_RECORD_MISC_MMAP_BUILD_ID) {
@@ -379,6 +389,14 @@ int perf_event__process_mmap2(struct perf_tool *tool __maybe_unused,
 	return machine__process_mmap2_event(machine, event, sample);
 }
 
+int perf_event__process_kmod_sec_map(struct perf_tool *tool __maybe_unused,
+				     union perf_event *event,
+				     struct perf_sample *sample __maybe_unused,
+				     struct machine *machine)
+{
+	return machine__process_kmod_sec_map_event(machine, event);
+}
+
 size_t perf_event__fprintf_task(union perf_event *event, FILE *fp)
 {
 	return fprintf(fp, "(%d:%d):(%d:%d)\n",
@@ -554,6 +572,9 @@ size_t perf_event__fprintf(union perf_event *event, struct machine *machine, FIL
 	case PERF_RECORD_AUX_OUTPUT_HW_ID:
 		ret += perf_event__fprintf_aux_output_hw_id(event, fp);
 		break;
+	case PERF_RECORD_KMOD_SEC_MAP:
+		ret += perf_event__fprintf_kmod_sec_map(event, fp);
+		break;
 	default:
 		ret += fprintf(fp, "\n");
 	}
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 6663a676eadc..90f2eff24f8d 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -310,6 +310,10 @@ int perf_event__process_mmap2(struct perf_tool *tool,
 			     union perf_event *event,
 			     struct perf_sample *sample,
 			     struct machine *machine);
+int perf_event__process_kmod_sec_map(struct perf_tool *tool,
+				     union perf_event *event,
+				     struct perf_sample *sample,
+				     struct machine *machine);
 int perf_event__process_fork(struct perf_tool *tool,
 			     union perf_event *event,
 			     struct perf_sample *sample,
@@ -343,6 +347,7 @@ const char *perf_event__name(unsigned int id);
 size_t perf_event__fprintf_comm(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf_mmap(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf_mmap2(union perf_event *event, FILE *fp);
+size_t perf_event__fprintf_kmod_sec_map(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf_task(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf_aux(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf_itrace_start(union perf_event *event, FILE *fp);
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index ab2919bc0a0d..a98cf3b4599b 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -36,6 +36,7 @@
 #include <internal/lib.h> // page_size
 #include "cgroup.h"
 #include "arm64-frame-pointer-unwind-support.h"
+#include "api/fs/fs.h"
 
 #include <linux/ctype.h>
 #include <symbol/kallsyms.h>
@@ -1595,6 +1596,188 @@ static int machine__create_module(void *arg, const char *name, u64 start,
 	return 0;
 }
 
+/* Works only for host modules. */
+static int __machine_create_modules_sections(struct maps *kmaps, struct map *map,
+					     struct list_head *tmp_map_list)
+{
+	const char *sysfs = sysfs__mountpoint();
+	char path[PATH_MAX];
+	struct dirent *dent;
+	Elf_Scn *sec = NULL;
+	struct dso *sec_dso;
+	struct map *sec_map;
+	size_t shstrndx;
+	GElf_Shdr shdr;
+	char *mod_name;
+	char *sname;
+	int ret = 0;
+	u64 start;
+	int found;
+	DIR *dir;
+	Elf *elf;
+	int fd;
+
+	if (!sysfs)
+		return -1;
+
+	fd = open(map->dso->long_name, O_RDONLY); /* XXX: What if file is compressed? */
+	if (fd < 0)
+		return -errno;
+
+	/* [modulename] => modulename */
+	mod_name = strdup(&map->dso->short_name[1]);
+	if (!mod_name)
+		return -1;
+	mod_name[map->dso->short_name_len - 2] = '\0';
+
+	elf = elf_begin(fd, PERF_ELF_C_READ_MMAP, NULL);
+	if (elf == NULL) {
+		ret = -1;
+		goto out_free_mod_name;
+	}
+
+	if (elf_getshdrstrndx(elf, &shstrndx) != 0) {
+		ret = -errno;
+		goto out_elf_end;
+	}
+
+	snprintf(path, PATH_MAX, "%s/module/%s/sections/", sysfs, mod_name);
+	dir = opendir(path);
+	if (!dir) {
+		ret = -errno;
+		goto out_elf_end;
+	}
+
+	while ((dent = readdir(dir))) {
+		if (!strcmp(dent->d_name, ".") || !strcmp(dent->d_name, ".."))
+			continue;
+
+		found = 0;
+		sec = NULL;
+		while ((sec = elf_nextscn(elf, sec)) != NULL) {
+			gelf_getshdr(sec, &shdr);
+			sname = elf_strptr(elf, shstrndx, shdr.sh_name);
+			if (!sname)
+				continue;
+
+			if (strncmp(dent->d_name, sname, PATH_MAX))
+				continue;
+			found = 1;
+			break;
+		}
+
+		if (!found)
+			continue;
+
+		if (!(shdr.sh_flags & SHF_ALLOC))
+			continue;
+
+		/*
+		 * .init sections are removed once module init is done. But
+		 * their stale addresses remain in sysfs sections list. Later,
+		 * kernel can allocate the same address range to other module,
+		 * and in such cases, addresses provided by sysfs will overlap
+		 * across different modules. Ignore init sections.
+		 */
+		if (strstarts(dent->d_name, ".init"))
+			continue;
+
+		if (!strcmp(dent->d_name, ".text")) {
+			map->end = map->start + shdr.sh_size;
+			map->pgoff = shdr.sh_offset;
+			continue;
+		}
+
+		snprintf(path, PATH_MAX, "module/%s/sections/%s", mod_name, dent->d_name);
+
+		if (sysfs__read_ull(path, (unsigned long long *)&start) < 0)
+			continue;
+
+		sec_dso = dso__new(map->dso->long_name);
+		if (!sec_dso) {
+			ret = -1;
+			goto out;
+		}
+
+		sec_dso->kernel = map->dso->kernel;
+		sec_dso->symtab_type = map->dso->symtab_type;
+		sec_dso->long_name_len = map->dso->long_name_len;
+		sec_dso->short_name = NULL;
+		ret = asprintf((char **)&sec_dso->short_name, "%s%s",
+			       map->dso->short_name, sname);
+		if (ret < 0 || !sec_dso->short_name) {
+			ret = -1;
+			goto out;
+		}
+		sec_dso->short_name_allocated = true;
+
+		sec_map = map__new2(start, sec_dso);
+		dso__put(sec_dso);
+		if (!sec_map) {
+			ret = -1;
+			goto out;
+		}
+
+		sec_map->end = start + shdr.sh_size;
+		sec_map->pgoff = shdr.sh_offset;
+		sec_map->sec_map = true;
+
+		map__kmap(sec_map)->kmaps = kmaps;
+
+		/*
+		 * We are adding this new map in a temporary list. We need
+		 * to keep map->refcnt non-zero until we insert this map in
+		 * machine->kmaps. So don't call map__put() here. It should
+		 * be done by the caller.
+		 */
+		list_add(&sec_map->node, tmp_map_list);
+	}
+
+out:
+	closedir(dir);
+out_elf_end:
+	elf_end(elf);
+out_free_mod_name:
+	free(mod_name);
+	close(fd);
+	return ret;
+}
+
+static int machine_create_modules_sections(struct machine *machine)
+{
+	struct maps *kmaps = machine__kernel_maps(machine);
+	LIST_HEAD(tmp_map_list);
+	struct map *map, *tmp;
+
+	maps__for_each_entry(kmaps, map) {
+		if (!__map__is_kmodule(map) || map->sec_map)
+			continue;
+		/*
+		 * Although we haven't added any section specific maps to
+		 * machine->kmaps yet, we would have changed .text section
+		 * map's address range of prev modules. And we don't have
+		 * a way to revert those back if this function fails. So
+		 * just continue with debug message.
+		 */
+		if (__machine_create_modules_sections(kmaps, map, &tmp_map_list) < 0)
+			pr_debug("Couldn't prepare section maps of %s\n", map->dso->short_name);
+	}
+
+	list_for_each_entry_safe(map, tmp, &tmp_map_list, node) {
+		list_del(&map->node);
+		maps__insert(kmaps, map);
+		/*
+		 * Add it before we drop the reference to map, i.e. while we
+		 * still are sure to have a reference to this DSO via *map->dso.
+		 */
+		dsos__add(&machine->dsos, map->dso);
+		/* kmaps already got it */
+		map__put(map);
+	}
+
+	return 0;
+}
+
 static int machine__create_modules(struct machine *machine)
 {
 	const char *modules;
@@ -1616,6 +1799,13 @@ static int machine__create_modules(struct machine *machine)
 	if (machine__set_modules_path(machine))
 		pr_debug("Problems setting modules path maps, continuing anyway...\n");
 
+	/*
+	 * We don't have access to guest sysfs. So section specific maps
+	 * are created only for host modules.
+	 */
+	if (!machine__is_default_guest(machine))
+		return machine_create_modules_sections(machine);
+
 	return 0;
 }
 
@@ -1982,6 +2172,80 @@ int machine__process_mmap_event(struct machine *machine, union perf_event *event
 	return 0;
 }
 
+/* sec maps are saved only for host modules. */
+int machine__process_kmod_sec_map_event(struct machine *machine, union perf_event *event)
+{
+	struct perf_record_kmod_sec_map *ksm;
+	char *mod_name, *ptr;
+	struct maps *kmaps;
+	struct map *map;
+	struct dso *dso;
+	int ret;
+
+	if (dump_trace)
+		perf_event__fprintf_kmod_sec_map(event, stdout);
+
+	ksm = &event->kmod_sec_map;
+
+	mod_name = strrchr(ksm->data + ksm->sec_name_len + 1, '/') + 1;
+	ptr = strstr(mod_name, ".ko");
+	if (mod_name == (char *)1 || !ptr || ptr == mod_name)
+		goto err;
+
+	dso = dso__new(ksm->data + ksm->sec_name_len + 1);
+	if (!dso)
+		goto err;
+
+	dso->kernel = DSO_SPACE__KERNEL;
+	/* XXX: What about DSO_BINARY_TYPE__SYSTEM_PATH_KMODULE_COMP? */
+	dso->symtab_type = DSO_BINARY_TYPE__SYSTEM_PATH_KMODULE;
+
+	ret = asprintf((char **)&dso->short_name, "[%.*s]%.*s", (int)(ptr - mod_name),
+		       mod_name, ksm->sec_name_len - 1, ksm->data);
+	if (ret < 0 || !dso->short_name) {
+		dso__put(dso);
+		goto err;
+	}
+	dso->short_name_allocated = true;
+	dso->short_name_len = strlen(dso->short_name);
+
+	dso->long_name = strdup(ksm->data + ksm->sec_name_len + 1);
+	if (!dso->long_name) {
+		dso__put(dso);
+		goto err;
+	}
+	dso->long_name_allocated = true;
+	dso->long_name_len = ksm->filename_len - 1;
+
+	map = map__new2(ksm->start, dso);
+	dso__put(dso);
+	if (!map)
+		goto err;
+
+	map->end = map->start + ksm->len;
+	map->pgoff = ksm->pgoff;
+	map->sec_map = 1;
+
+	kmaps = machine__kernel_maps(machine);
+	map__kmap(map)->kmaps = kmaps;
+	maps__insert(kmaps, map);
+
+	/*
+	 * Add it before we drop the reference to sec_map, i.e.
+	 * while we still are sure to have a reference to this
+	 * DSO via *sec_map->dso.
+	 */
+	dsos__add(&machine->dsos, dso);
+	/* kmaps already got it */
+	map__put(map);
+
+	return 0;
+
+err:
+	dump_printf("problem processing PERF_RECORD_KMOD_SEC_MAP, skipping event.\n");
+	return -1;
+}
+
 static void __machine__remove_thread(struct machine *machine, struct thread *th, bool lock)
 {
 	struct threads *threads = machine__threads(machine, th->tid);
diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
index d034ecaf89c1..3524587f7c06 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -146,6 +146,8 @@ int machine__process_mmap_event(struct machine *machine, union perf_event *event
 				struct perf_sample *sample);
 int machine__process_mmap2_event(struct machine *machine, union perf_event *event,
 				 struct perf_sample *sample);
+int machine__process_kmod_sec_map_event(struct machine *machine,
+					union perf_event *event);
 int machine__process_ksymbol(struct machine *machine,
 			     union perf_event *event,
 			     struct perf_sample *sample);
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index f3a3d9b3a40d..8325800581c5 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -114,6 +114,7 @@ void map__init(struct map *map, u64 start, u64 end, u64 pgoff, struct dso *dso)
 	RB_CLEAR_NODE(&map->rb_node);
 	map->erange_warned = false;
 	refcount_set(&map->refcnt, 1);
+	map->sec_map  = false;
 }
 
 struct map *map__new(struct machine *machine, u64 start, u64 len,
diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index 3dcfe06db6b3..4b3fa454ea24 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -20,6 +20,7 @@ struct map {
 		struct rb_node	rb_node;
 		struct list_head node;
 	};
+	/* Range of a map [start, end). */
 	u64			start;
 	u64			end;
 	bool			erange_warned:1;
@@ -36,6 +37,9 @@ struct map {
 	struct dso		*dso;
 	refcount_t		refcnt;
 	u32			flags;
+
+	/* Indicates whether a map is of kernel module's elf section. */
+	bool			sec_map:1;
 };
 
 struct kmap;
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 4f5165cd58de..e1a568a1dcd2 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -999,10 +999,15 @@ static void perf_event__time_conv_swap(union perf_event *event,
 	}
 }
 
-static void perf_event_kmod_sec_map_swap(union perf_event *event __maybe_unused,
-					  bool sample_id_all __maybe_unused)
+static void perf_event_kmod_sec_map_swap(union perf_event *event,
+					 bool sample_id_all __maybe_unused)
 {
-	/* FIXME */
+	event->kmod_sec_map.pid = bswap_32(event->kmod_sec_map.pid);
+	event->kmod_sec_map.start = bswap_64(event->kmod_sec_map.start);
+	event->kmod_sec_map.len = bswap_64(event->kmod_sec_map.len);
+	event->kmod_sec_map.pgoff = bswap_64(event->kmod_sec_map.pgoff);
+	event->kmod_sec_map.sec_name_len = bswap_16(event->kmod_sec_map.sec_name_len);
+	event->kmod_sec_map.filename_len = bswap_16(event->kmod_sec_map.filename_len);
 }
 
 typedef void (*perf_event__swap_op)(union perf_event *event,
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 96767d1b3f1c..8d14faeebb8f 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -1137,6 +1137,7 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 	struct maps *kmaps = kmap ? map__kmaps(map) : NULL;
 	struct map *curr_map = map;
 	struct dso *curr_dso = dso;
+	char *sec_map_name = NULL;
 	Elf_Data *symstrs, *secstrs, *secstrs_run, *secstrs_sym;
 	uint32_t nr_syms;
 	int err = -1;
@@ -1236,6 +1237,10 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 		remap_kernel = true;
 		adjust_kernel_syms = dso->adjust_symbols;
 	}
+
+	if (map->sec_map)
+		sec_map_name = strchr(dso->short_name, ']') + 1;
+
 	elf_symtab__for_each_symbol(syms, nr_syms, idx, sym) {
 		struct symbol *f;
 		const char *elf_name = elf_sym__name(&sym, symstrs);
@@ -1315,6 +1320,8 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 			continue;
 
 		section_name = elf_sec__name(&shdr, secstrs);
+		if (sec_map_name && strcmp(sec_map_name, section_name))
+			continue;
 
 		/* On ARM, symbols for thumb functions have 1 added to
 		 * the symbol address as a flag - remove it */
@@ -1323,7 +1330,7 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 		    (sym.st_value & 1))
 			--sym.st_value;
 
-		if (dso->kernel) {
+		if (dso->kernel && !map->sec_map) {
 			if (dso__process_kernel_symbol(dso, map, &sym, &shdr, kmaps, kmap, &curr_dso, &curr_map,
 						       section_name, adjust_kernel_syms, kmodule, &remap_kernel))
 				goto out_elf_end;
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index a3a165ae933a..2407c047974c 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1121,7 +1121,7 @@ static int do_validate_kcore_modules(const char *filename, struct maps *kmaps)
 	maps__for_each_entry(kmaps, old_map) {
 		struct module_info *mi;
 
-		if (!__map__is_kmodule(old_map)) {
+		if (!__map__is_kmodule(old_map) || old_map->sec_map) {
 			continue;
 		}
 
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 2e145517f192..f8a91113e93b 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -665,6 +665,40 @@ int perf_event__synthesize_cgroups(struct perf_tool *tool __maybe_unused,
 }
 #endif
 
+static void __perf_event__synthesize_modules_sec_map(struct machine *machine,
+						     struct map *map,
+						     union perf_event *event)
+{
+	size_t sec_name_len;
+	size_t size;
+	char *ptr;
+
+	ptr = strchr(map->dso->short_name, ']') + 1;
+	if (!*ptr)
+		return;
+
+	sec_name_len = strlen(ptr);
+	size = PERF_ALIGN(sec_name_len + map->dso->long_name_len + 2, sizeof(u64));
+
+	event->kmod_sec_map.header.type = PERF_RECORD_KMOD_SEC_MAP;
+	event->kmod_sec_map.header.size = sizeof(event->kmod_sec_map)
+					  + size
+					  + machine->id_hdr_size;
+
+	memset(event->kmod_sec_map.data + size, 0, machine->id_hdr_size);
+
+	event->kmod_sec_map.pid = machine->pid;
+	event->kmod_sec_map.start = map->start;
+	event->kmod_sec_map.len = map->end - map->start;
+	event->kmod_sec_map.pgoff = map->pgoff;
+	event->kmod_sec_map.sec_name_len = sec_name_len + 1;
+	event->kmod_sec_map.filename_len = map->dso->long_name_len + 1;
+
+	memcpy(event->kmod_sec_map.data, ptr, sec_name_len + 1);
+	memcpy(event->kmod_sec_map.data + sec_name_len + 2, map->dso->long_name,
+	       map->dso->long_name_len + 1);
+}
+
 static void __perf_event__synthesize_modules_mmap2(struct machine *machine,
 						   struct map *map,
 						   union perf_event *event)
@@ -715,7 +749,7 @@ int perf_event__synthesize_modules(struct perf_tool *tool, perf_event__handler_t
 	int rc = 0;
 	struct map *pos;
 	struct maps *maps = machine__kernel_maps(machine);
-	union perf_event *event;
+	union perf_event *event, *sec_event;
 	size_t size = symbol_conf.buildid_mmap2 ?
 			sizeof(event->mmap2) : sizeof(event->mmap);
 
@@ -726,30 +760,47 @@ int perf_event__synthesize_modules(struct perf_tool *tool, perf_event__handler_t
 		return -1;
 	}
 
+	/* Length of section name and filenames are capped at PATH_MAX */
+	sec_event = zalloc(sizeof(event->kmod_sec_map) + (2 * PATH_MAX) + machine->id_hdr_size);
+	if (sec_event == NULL) {
+		free(event);
+		pr_debug("Not enough memory synthesizing mmap event "
+			 "for kernel modules\n");
+		return -1;
+	}
+
 	/*
 	 * kernel uses 0 for user space maps, see kernel/perf_event.c
 	 * __perf_event_mmap
 	 */
-	if (machine__is_host(machine))
+	if (machine__is_host(machine)) {
 		event->header.misc = PERF_RECORD_MISC_KERNEL;
-	else
+		/* PERF_RECORD_KMOD_SEC_MAP is supported only on Host */
+		sec_event->header.misc = PERF_RECORD_MISC_KERNEL;
+	} else {
 		event->header.misc = PERF_RECORD_MISC_GUEST_KERNEL;
+	}
 
 	maps__for_each_entry(maps, pos) {
 		if (!__map__is_kmodule(pos))
 			continue;
 
-		if (symbol_conf.buildid_mmap2)
+		if (pos->sec_map)
+			__perf_event__synthesize_modules_sec_map(machine, pos, sec_event);
+		else if (symbol_conf.buildid_mmap2)
 			__perf_event__synthesize_modules_mmap2(machine, pos, event);
 		else
 			__perf_event__synthesize_modules_mmap(machine, pos, event);
 
-		if (perf_tool__process_synth_event(tool, event, machine, process) != 0) {
+		rc = perf_tool__process_synth_event(tool, pos->sec_map ? sec_event : event,
+						    machine, process);
+		if (rc) {
 			rc = -1;
 			break;
 		}
 	}
 
+	free(sec_event);
 	free(event);
 	return rc;
 }
-- 
2.39.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFF116638FF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 07:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjAJGCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 01:02:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbjAJGCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 01:02:35 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB7F43E56;
        Mon,  9 Jan 2023 21:59:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S9l70IklQyHrlLwpun3e64ufVIPyDY+DtZEtzW7l4ATgqaVV7LMPoeZbMOcYuNPzbL4P8wUCK2qWSpyxaZ0o4AD06MWL0gkF4rTiSnUHXVR4qTungLEY98gMVPkQy0pf8/qknrvDKMCJ6ZMbci2zqLGd9CevOjEITKLCmDD2rLA0XFnvk9F8c2MwUiTALRolU9RDghCNXK56B9Qk+NrlzHnchLxIwC5WsxBwaJJER+WpKxsUsMb2Fnx2DlXSeyBQNlpGWEk3EijOhQJqJRCzX+hsSV6HJm3U1nb0h5XCchU0kv241lCG4He4AxACQgE5zVJK/fYbr2iZ0xwXUPvuCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+8+zKGvbmZHU4PKluH79T6J0il3vX65DwXfkFTkVmhs=;
 b=fxhMiIupkOAoO2qDUfQdXlcu04wifWaUX1M4GNdrabfsiI9VGFYBSAYHQf6BU/ygzl2JlMFyCl9G+YEm/amOBO4WZP4+OvtIcvyV+QFhkEHKruPOygMJYHl7Y+IvnYvzsMwCSofMM87u8Y/uARavdjkhUbR/cve9jKxWcTI/ap8YVEkvqfF9qDCIw+KkswxJBgxbkqb+TZ9wronuc4p8JRrqYpaWJCk9gmtn5HkQRzBWbyngsTVyq1m0CMUYtmZaJttaJgwOdAOhYtKo/kN9QBtzJWh1KrzoQImp+R8OzXersJNfkZgYQidHsP9RkWJPDC0YzuWa0IKgQeBh3BU0HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+8+zKGvbmZHU4PKluH79T6J0il3vX65DwXfkFTkVmhs=;
 b=4N9CNyOZLc/U77xfV+59MWkYQQxwbSH4Bmv4yPTAVeIUs+7euBEOOR6BgWKXJZ7taIEK+gxlJslOubE3x8JYkfFgb1IlHVKXa1VxEeQr0dDKPFL68Zm0My278qfLmZDdwJoVwxmB6JX7mjiT232uLGPYUZwUk/PBPtBN/LuBBPI=
Received: from MW4PR04CA0384.namprd04.prod.outlook.com (2603:10b6:303:81::29)
 by SA3PR12MB7782.namprd12.prod.outlook.com (2603:10b6:806:31c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 05:59:27 +0000
Received: from CO1NAM11FT082.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::28) by MW4PR04CA0384.outlook.office365.com
 (2603:10b6:303:81::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18 via Frontend
 Transport; Tue, 10 Jan 2023 05:59:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT082.mail.protection.outlook.com (10.13.175.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5986.18 via Frontend Transport; Tue, 10 Jan 2023 05:59:26 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 9 Jan
 2023 23:59:20 -0600
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
Subject: [RFC 0/4] perf tool: Fix non-".text" symbol resolution for kernel modules
Date:   Tue, 10 Jan 2023 11:28:55 +0530
Message-ID: <20230110055859.685-1-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT082:EE_|SA3PR12MB7782:EE_
X-MS-Office365-Filtering-Correlation-Id: e70abc6c-1eb7-43c8-ad39-08daf2cfd4e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lur1cdgLW87xbz1HfTUJskJhSLKbznk4ewtp8CSAdgg1tlevNGIHZBqC1FRY5H/Ep9CC0CukTQcObcwSmC8NRgSn+sXpe8XR8nOsVb600deXEho2FRXyYkELkpYXQOVWkodUu7VQbMjqLEgQGeYIb0K+5gzMGnWsrElCHIv/PDdPvJwqZtIA26w3BfzBlVIae7tKFdJvDyLpEOBDUVizXs9j6AxMLVrx1JtxnPbS8GZ8lFryyAq8uHDnEz5cGl+8tPSdRiYdC8qZ1DIoHjJ/CW2j1JYv+7R6W7mEz/GCuMShwI4xCUnGTMIheivdUxl5mQxCYfN+YIE7XcR5JQWNB4xHR5nH67XYLgI0y1TrKbWpGN191NBIu5SGpsxvzlcuI7kevvzxVYX5VYD3wGQhOVybAIrzhCyqF06oM709hqXJ22ilE+f5Bb53GatropKcPI0Lj4lC3vKOdBEXWBeB8UXLWCaCPTMOuOwie3WZz0OiENsGNmFlZaxucgA98pmUt1v3jDWtMqpc+qIidvdB1vvrftcRnZwCpPdABKpydtR89cxmVcuE02VJjqWvkJ+0oJxOrUDGKqNDw7bmdYmjjHJYLEFIBZKejRR0lC9C1reqyaGqgBnVIkfc1VnNsxj36DRum1s//ZMfI5b/gxz/AyXUUSSwvbfOmFMp3QIVTZF57pHBXuo21JMMxaTV5edzZMqpmn1wc1GGRgiF16TzfwOKVfhtJtC8+KE5Det8Zu8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(346002)(39860400002)(376002)(451199015)(36840700001)(40470700004)(46966006)(8676002)(70586007)(6916009)(316002)(4326008)(7696005)(70206006)(54906003)(356005)(44832011)(2906002)(5660300002)(40460700003)(8936002)(47076005)(81166007)(7416002)(426003)(41300700001)(36756003)(83380400001)(36860700001)(6666004)(478600001)(1076003)(40480700001)(336012)(2616005)(16526019)(82740400003)(26005)(86362001)(186003)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 05:59:26.9110
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e70abc6c-1eb7-43c8-ad39-08daf2cfd4e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT082.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7782
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
provided by sysfs /sys/module/.../sections/. Also save these details in
PERF_RECORD_KMOD_SEC_MAP format in perf.data which can be consumed at
perf-report time.

Without patchset:

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

With patchset:

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

This is an RFC only series. TODOs:
 - I'm just recording module path in PERF_RECORD_KMOD_SEC_MAP. It's very
   much possible that, at perf report time, a module file exists at the
   same path but it's internal layout is different. I think I need to add
   some buildid check. Any ideas?
 - I've enabled host perf-record/report only. It doesn't work for guest
   modules because host does not have access to guest sysfs. I'm yet to
   figure out how to fix it. May be we can add --guest-mod-sysfs option.
   Any ideas?
 - Also, I'm currently assuming that module files are not compressed.
 - I've seen perf build failures when compiling with NO_LIBELF=1.
 - I've seen perf report not honoring --kallsyms in certain conditions.

Prepared on top of acme/perf/core (69b41ac87e4a6)

Ravi Bangoria (4):
  perf tool: Simplify machine__create_modules() a bit
  perf tool: Refactor perf_event__synthesize_modules()
  perf tool: Introduce PERF_RECORD_KMOD_SEC_MAP
  perf tool: Fix non-".text" symbol resolution for kernel modules

 tools/lib/perf/Documentation/libperf.txt |   1 +
 tools/lib/perf/include/perf/event.h      |  25 +++
 tools/perf/builtin-annotate.c            |   1 +
 tools/perf/builtin-c2c.c                 |   1 +
 tools/perf/builtin-diff.c                |   1 +
 tools/perf/builtin-inject.c              |   1 +
 tools/perf/builtin-kmem.c                |   1 +
 tools/perf/builtin-mem.c                 |   1 +
 tools/perf/builtin-record.c              |  14 ++
 tools/perf/builtin-report.c              |   1 +
 tools/perf/builtin-script.c              |  13 ++
 tools/perf/builtin-trace.c               |   1 +
 tools/perf/util/build-id.c               |   1 +
 tools/perf/util/data-convert-bt.c        |   1 +
 tools/perf/util/data-convert-json.c      |   1 +
 tools/perf/util/event.c                  |  22 ++
 tools/perf/util/event.h                  |   5 +
 tools/perf/util/machine.c                | 268 ++++++++++++++++++++++-
 tools/perf/util/machine.h                |   2 +
 tools/perf/util/map.c                    |   1 +
 tools/perf/util/map.h                    |   4 +
 tools/perf/util/session.c                |  17 ++
 tools/perf/util/symbol-elf.c             |   9 +-
 tools/perf/util/symbol.c                 |   2 +-
 tools/perf/util/synthetic-events.c       | 136 +++++++++---
 tools/perf/util/tool.h                   |   3 +-
 26 files changed, 494 insertions(+), 39 deletions(-)

-- 
2.39.0


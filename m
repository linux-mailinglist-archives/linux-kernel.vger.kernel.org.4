Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32F3E663965
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 07:36:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbjAJGgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 01:36:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjAJGgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 01:36:00 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B9D6473;
        Mon,  9 Jan 2023 22:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673332559; x=1704868559;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AB1yk/QpDBPqMLxhjhl2HEk7CNQI6GOPIbl9A+smsbU=;
  b=bsHBHi5Uq7w24U++wIeZXHR+UrqT3/LKzrMKFfIUJ6zPY2I4/NbUTFZ/
   bupm4B2g3NaL9ApnyOYReAShSbodsg8qJrDctKJC6LqrkGoPrIHdEQLcy
   mRV+o8kYAkwy8ldHilVnFON72d5WddvB+0eAUKzNpnRFJGMLdFaykGn0z
   u+d8aYeZFUmlDQZrShMhNGBzBAhQtEfLOErKmX1Z6AbB+Eq2Wdt7xcbyF
   ZdjXu7AQrsl1lBi9oxeh4nuMEp9R5+/mGSoVt3yP+CUVEWyz2hU8gBggI
   H6pqCnxfBsuFCRgGtoBOXyJ0fJYmiIazrZsAG7HvPnjCyiHx+Gm89bDUq
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="321774901"
X-IronPort-AV: E=Sophos;i="5.96,314,1665471600"; 
   d="scan'208";a="321774901"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 22:35:58 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="780963138"
X-IronPort-AV: E=Sophos;i="5.96,314,1665471600"; 
   d="scan'208";a="780963138"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.221.1])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 22:35:52 -0800
Message-ID: <86f43058-a51a-42c7-4d75-564f0e8eef04@intel.com>
Date:   Tue, 10 Jan 2023 08:35:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.1
Subject: Re: [RFC 0/4] perf tool: Fix non-".text" symbol resolution for kernel
 modules
To:     Ravi Bangoria <ravi.bangoria@amd.com>, acme@kernel.org
Cc:     jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        kan.liang@linux.intel.com, peterz@infradead.org,
        mark.rutland@arm.com, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, james.clark@arm.com,
        german.gomez@arm.com, leo.yan@linaro.org,
        alexey.v.bayduraev@linux.intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandipan.das@amd.com, ananth.narayan@amd.com,
        santosh.shukla@amd.com
References: <20230110055859.685-1-ravi.bangoria@amd.com>
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230110055859.685-1-ravi.bangoria@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/01/23 07:58, Ravi Bangoria wrote:
> Kernel module elf contains executable code in non-".text" sections as
> well, for ex: ".noinstr.text". Plus, kernel module's memory layout
> differs from it's binary layout because .ko elf does not contain
> program header table.

Have you looked at using perf record --kcore option.

> 
> Perf tries to solve it by creating special maps for allocated (SHF_ALLOC)
> elf sections, but perf uses elf addresses for map address range and thus
> these special maps remains unused because no real ip falls into their
> address range.
> 
> Solve this by preparing section specific special maps using addresses
> provided by sysfs /sys/module/.../sections/. Also save these details in
> PERF_RECORD_KMOD_SEC_MAP format in perf.data which can be consumed at
> perf-report time.
> 
> Without patchset:
> 
>   # perf record -a -c 5000000
>   # perf report
>   Overhead  Command          Shared Object           Symbol
>     13.20%  qemu-system-x86  [unknown]               [.] 0x00005557527b1973
>      6.58%  qemu-system-x86  [kvm_amd]               [k] 0x00000000000151e6
>      6.36%  qemu-system-x86  [kernel.vmlinux]        [k] native_load_gdt
>      6.21%  qemu-system-x86  [kernel.vmlinux]        [k] native_load_tr_desc
>      4.71%  qemu-system-x86  [kvm]                   [k] vcpu_run
>      4.52%  qemu-system-x86  [kvm_amd]               [k] svm_vcpu_run
>      3.50%  qemu-system-x86  [kvm]                   [k] kvm_cpuid
>      2.09%  qemu-system-x86  [kvm]                   [k] kvm_pmu_trigger_event
>      1.98%  qemu-system-x86  [kvm_amd]               [k] 0x0000000000015171
>      1.05%  qemu-system-x86  [kvm_amd]               [k] svm_handle_exit
>      1.04%  qemu-system-x86  [kvm_amd]               [k] 0x00000000000151e2
>      0.94%  qemu-system-x86  [kvm_amd]               [k] 0x0000000000015174
> 
>   Same perf.data with kallsyms:
> 
>   # perf report --kallsyms=/proc/kallsyms
>   Overhead  Command          Shared Object           Symbol
>     14.22%  qemu-system-x86  [kvm_amd]               [k] __svm_vcpu_run
>     13.20%  qemu-system-x86  [unknown]               [.] 0x00005557527b1973
>      6.36%  qemu-system-x86  [kernel.vmlinux]        [k] native_load_gdt
>      6.21%  qemu-system-x86  [kernel.vmlinux]        [k] native_load_tr_desc
>      4.71%  qemu-system-x86  [kvm]                   [k] vcpu_run
>      4.52%  qemu-system-x86  [kvm_amd]               [k] svm_vcpu_run
>      3.50%  qemu-system-x86  [kvm]                   [k] kvm_cpuid
>      2.09%  qemu-system-x86  [kvm]                   [k] kvm_pmu_trigger_event
>      1.05%  qemu-system-x86  [kvm_amd]               [k] svm_handle_exit
> 
> With patchset:
> 
>   # perf record -a -c 5000000
>   # perf report
>   Overhead  Command          Shared Object           Symbol
>     13.44%  qemu-system-x86  [kvm-amd].noinstr.text  [k] __svm_vcpu_run
>     13.25%  qemu-system-x86  [unknown]               [.] 0x000055f4c6563973
>      7.13%  qemu-system-x86  [kernel.vmlinux]        [k] native_load_gdt
>      6.00%  qemu-system-x86  [kernel.vmlinux]        [k] native_load_tr_desc
>      5.13%  qemu-system-x86  [kvm_amd]               [k] svm_vcpu_run
>      4.83%  qemu-system-x86  [kvm]                   [k] vcpu_run
>      3.65%  qemu-system-x86  [kvm]                   [k] kvm_cpuid
> 
>   Same perf.data with kallsyms:
> 
>   # perf report --kallsyms=/proc/kallsyms
>   Overhead  Command          Shared Object       Symbol
>     13.44%  qemu-system-x86  [kernel.vmlinux]    [k] __svm_vcpu_run
>     13.25%  qemu-system-x86  [unknown]           [.] 0x000055f4c6563973
>      7.13%  qemu-system-x86  [kernel.vmlinux]    [k] native_load_gdt
>      6.00%  qemu-system-x86  [kernel.vmlinux]    [k] native_load_tr_desc
>      5.13%  qemu-system-x86  [kernel.vmlinux]    [k] svm_vcpu_run
>      4.83%  qemu-system-x86  [kernel.vmlinux]    [k] vcpu_run
>      3.65%  qemu-system-x86  [kernel.vmlinux]    [k] kvm_cpuid
> 
> This is an RFC only series. TODOs:
>  - I'm just recording module path in PERF_RECORD_KMOD_SEC_MAP. It's very
>    much possible that, at perf report time, a module file exists at the
>    same path but it's internal layout is different. I think I need to add
>    some buildid check. Any ideas?
>  - I've enabled host perf-record/report only. It doesn't work for guest
>    modules because host does not have access to guest sysfs. I'm yet to
>    figure out how to fix it. May be we can add --guest-mod-sysfs option.
>    Any ideas?
>  - Also, I'm currently assuming that module files are not compressed.
>  - I've seen perf build failures when compiling with NO_LIBELF=1.
>  - I've seen perf report not honoring --kallsyms in certain conditions.
> 
> Prepared on top of acme/perf/core (69b41ac87e4a6)
> 
> Ravi Bangoria (4):
>   perf tool: Simplify machine__create_modules() a bit
>   perf tool: Refactor perf_event__synthesize_modules()
>   perf tool: Introduce PERF_RECORD_KMOD_SEC_MAP
>   perf tool: Fix non-".text" symbol resolution for kernel modules
> 
>  tools/lib/perf/Documentation/libperf.txt |   1 +
>  tools/lib/perf/include/perf/event.h      |  25 +++
>  tools/perf/builtin-annotate.c            |   1 +
>  tools/perf/builtin-c2c.c                 |   1 +
>  tools/perf/builtin-diff.c                |   1 +
>  tools/perf/builtin-inject.c              |   1 +
>  tools/perf/builtin-kmem.c                |   1 +
>  tools/perf/builtin-mem.c                 |   1 +
>  tools/perf/builtin-record.c              |  14 ++
>  tools/perf/builtin-report.c              |   1 +
>  tools/perf/builtin-script.c              |  13 ++
>  tools/perf/builtin-trace.c               |   1 +
>  tools/perf/util/build-id.c               |   1 +
>  tools/perf/util/data-convert-bt.c        |   1 +
>  tools/perf/util/data-convert-json.c      |   1 +
>  tools/perf/util/event.c                  |  22 ++
>  tools/perf/util/event.h                  |   5 +
>  tools/perf/util/machine.c                | 268 ++++++++++++++++++++++-
>  tools/perf/util/machine.h                |   2 +
>  tools/perf/util/map.c                    |   1 +
>  tools/perf/util/map.h                    |   4 +
>  tools/perf/util/session.c                |  17 ++
>  tools/perf/util/symbol-elf.c             |   9 +-
>  tools/perf/util/symbol.c                 |   2 +-
>  tools/perf/util/synthetic-events.c       | 136 +++++++++---
>  tools/perf/util/tool.h                   |   3 +-
>  26 files changed, 494 insertions(+), 39 deletions(-)
> 


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CABF5F7505
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 10:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbiJGIBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 04:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbiJGIAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 04:00:52 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2DF9120BD9;
        Fri,  7 Oct 2022 01:00:40 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id b2so9621185eja.6;
        Fri, 07 Oct 2022 01:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date;
        bh=eBp+iSspJ6jLPN0igIEztrmB52UBV9YgV90fiPtB7Ko=;
        b=XAK/8UCo+Xp1sKuHWwnS1vJi7NMqw6PDbgV89xNaXeN2SRgEnzmDIeTRLYBkHT5++D
         hvP/ICWmBgye46otuP3PT76YJ8Vh1XdK1UT6Yk/RlloA3tQR2y0yHXrCamEZ7YsFCkcD
         F4nqL13H5yYiglnwKrBEXoG2cXb1l7WcmmsT7CxHLllHrxAP1HbC3Tq2CiRmL3GIcbpL
         IkcRYfxxvOuqpaEuHynMMYyaAAaiVh+SFkQdPpaDrfDNtYgLLHrlfI/j1OV3kC0XVnpE
         12AHupV03ogOD1lXK/Ku/rQmbIvq4Hq3az6CyN1hr/WgcXObMGsBDFj479Towl+o4aE3
         iL9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date;
        bh=eBp+iSspJ6jLPN0igIEztrmB52UBV9YgV90fiPtB7Ko=;
        b=0BUokTqTKYKl9a1aEPXlO0C4qqXbNknXLKGEhEVAAtRUmrSxptkjK2uIRADDDUBfAD
         MKrSeubtXuzHQcLlZ2pnHH4qVqH7mlEZtXHyDzJOdr0icZJ7TB0YneBNayUaXEQ0EiaU
         T7qyWjqQvXI6eMt/9VDeN3768/XP691k+TimrHFOLVG1BboWl3KDgDYicdCQOGjI/I73
         +5Vcv1OQP9ZT7bMyb+QWdEdMyEMJ1O2lutYG/KBdFg0dgdpzZ2CFmbL0FIX3+WsMVzih
         +A6NBs9fCggQub05B/ZGINkzLhARUUf+RPWULWuBSIBQ+sz/AOKr6kWxFcvjR5iOKMQ4
         ntsA==
X-Gm-Message-State: ACrzQf3ADfMlTMpboimDBKlqlelBlchRalFZdgZQyBHtBTRB1dm8KYk0
        WouobpbUq7xJrWr7hEYjPbM=
X-Google-Smtp-Source: AMsMyM6rV890gqJlvG4tmSFL6QoXB3SN7Cn96HsN47nWz319yYO4dHBEef4jmb/7U0qaCY40gNCKHQ==
X-Received: by 2002:a17:907:2cd2:b0:78c:ff71:1d84 with SMTP id hg18-20020a1709072cd200b0078cff711d84mr3080041ejc.744.1665129638569;
        Fri, 07 Oct 2022 01:00:38 -0700 (PDT)
Received: from gmail.com (1F2EF191.nat.pool.telekom.hu. [31.46.241.145])
        by smtp.gmail.com with ESMTPSA id bm22-20020a0564020b1600b0044f21c69608sm968072edb.10.2022.10.07.01.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 01:00:37 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Fri, 7 Oct 2022 10:00:36 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] perf event updates for v6.1
Message-ID: <Yz/cpNTSacRMh1FK@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest perf/core git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2022-10-07

   # HEAD: 82aad7ff7ac25c8cf09d491ae23b9823f1901486 perf/hw_breakpoint: Annotate tsk->perf_event_mutex vs ctx->mutex

Perf events updates for v6.1:

 - PMU driver updates:

     - Add AMD Last Branch Record Extension Version 2 (LbrExtV2)
       feature support for Zen 4 processors.

     - Extend the perf ABI to provide branch speculation information,
       if available, and use this on CPUs that have it (eg. LbrExtV2).

     - Improve Intel PEBS TSC timestamp handling & integration.

     - Add Intel Raptor Lake S CPU support.

     - Add 'perf mem' and 'perf c2c' memory profiling support on
       AMD CPUs by utilizing IBS tagged load/store samples.

     - Clean up & optimize various x86 PMU details.

 - HW breakpoints:

     - Big rework to optimize the code for systems with hundreds of CPUs and
       thousands of breakpoints:

        - Replace the nr_bp_mutex global mutex with the bp_cpuinfo_sem
	  per-CPU rwsem that is read-locked during most of the key operations.

	- Improve the O(#cpus * #tasks) logic in toggle_bp_slot()
	  and fetch_bp_busy_slots().

	- Apply micro-optimizations & cleanups.

  - Misc cleanups & enhancements.

  - NOTE: When merged with your latest tree, there will be a new 
          conflict in lib/Kconfig.debug - it's just a context conflict due 
          to the HW_BREAKPOINT_KUNIT_TEST addition from the perf tree 
          clashing with the recent addition of FORTIFY_KUNIT_TEST:

            upstream:  875bfd5276f3 ("fortify: Add KUnit test for FORTIFY_SOURCE internals")
            perf tree: 724c299c6a0e ("perf/hw_breakpoint: Add KUnit test for constraints accounting")

 Thanks,

	Ingo

------------------>
Anshuman Khandual (9):
      perf: Add system error and not in transaction branch types
      perf: Extend branch type classification
      perf: Capture branch privilege information
      perf: Add PERF_BR_NEW_ARCH_[N] map for BRBE on arm64 platform
      perf: Consolidate branch sample filter helpers
      perf/core: Expand PERF_EVENT_FLAG_ARCH
      perf/core: Assert PERF_EVENT_FLAG_ARCH does not overlap with generic flags
      arm64/perf: Assert all platform event flags are within PERF_EVENT_FLAG_ARCH
      x86/perf: Assert all platform event flags are within PERF_EVENT_FLAG_ARCH

Jiri Olsa (1):
      bpf: Check flags for branch stack in bpf_read_branch_records helper

Jules Irenge (1):
      perf/core: Convert snprintf() to scnprintf()

Kan Liang (11):
      perf: Add sample_flags to indicate the PMU-filled sample data
      perf/x86/intel/pebs: Fix PEBS timestamps overwritten
      perf: Use sample_flags for branch stack
      perf: Use sample_flags for weight
      perf: Use sample_flags for data_src
      perf: Use sample_flags for txn
      perf/x86/intel: Optimize FIXED_CTR_CTRL access
      perf/x86: Add new Raptor Lake S support
      perf/x86/msr: Add new Raptor Lake S support
      perf/x86/cstate: Add new Raptor Lake S support
      perf/x86/uncore: Add new Raptor Lake S support

Marco Elver (15):
      perf/hw_breakpoint: Add KUnit test for constraints accounting
      perf/hw_breakpoint: Provide hw_breakpoint_is_used() and use in test
      perf/hw_breakpoint: Clean up headers
      perf/hw_breakpoint: Optimize list of per-task breakpoints
      perf/hw_breakpoint: Mark data __ro_after_init
      perf/hw_breakpoint: Optimize constant number of breakpoint slots
      perf/hw_breakpoint: Make hw_breakpoint_weight() inlinable
      perf/hw_breakpoint: Remove useless code related to flexible breakpoints
      powerpc/hw_breakpoint: Avoid relying on caller synchronization
      locking/percpu-rwsem: Add percpu_is_write_locked() and percpu_is_read_locked()
      perf/hw_breakpoint: Reduce contention with large number of tasks
      perf/hw_breakpoint: Introduce bp_slots_histogram
      perf/hw_breakpoint: Optimize max_bp_pinned_slots() for CPU-independent task targets
      perf/hw_breakpoint: Optimize toggle_bp_slot() for CPU-independent task targets
      perf, hw_breakpoint: Fix use-after-free if perf_event_open() fails

Namhyung Kim (5):
      perf: Use sample_flags for callchain
      perf/bpf: Always use perf callchains if exist
      perf: Kill __PERF_SAMPLE_CALLCHAIN_EARLY
      perf: Use sample_flags for addr
      perf: Use sample_flags for raw_data

Peter Zijlstra (11):
      perf: Add a few assertions
      perf/x86: Add two more x86_pmu methods
      perf/x86/intel: Move the topdown stuff into the intel driver
      perf/x86: Change x86_pmu::limit_period signature
      perf/x86: Add a x86_pmu::limit_period static_call
      perf/x86/intel: Remove x86_pmu::set_topdown_event_period
      perf/x86/intel: Remove x86_pmu::update_topdown_event
      perf/x86/p4: Remove perfctr_second_write quirk
      perf: Fix lockdep_assert_event_ctx()
      perf: Fix pmu_filter_match()
      perf/hw_breakpoint: Annotate tsk->perf_event_mutex vs ctx->mutex

Ravi Bangoria (7):
      perf/mem: Introduce PERF_MEM_LVLNUM_{EXTN_MEM|IO}
      perf/x86/amd: Add IBS OP_DATA2 DataSrc bit definitions
      perf/x86/amd: Support PERF_SAMPLE_DATA_SRC
      perf/x86/amd: Support PERF_SAMPLE_{WEIGHT|WEIGHT_STRUCT}
      perf/x86/amd: Support PERF_SAMPLE_ADDR
      perf/x86/amd: Support PERF_SAMPLE_PHY_ADDR
      perf/uapi: Define PERF_MEM_SNOOPX_PEER in kernel header file

Sandipan Das (13):
      perf/x86/amd/brs: Move feature-specific functions
      perf/x86/amd/core: Refactor branch attributes
      perf/x86/amd/core: Add generic branch record interfaces
      x86/cpufeatures: Add LbrExtV2 feature bit
      perf/x86/amd/lbr: Detect LbrExtV2 support
      perf/x86/amd/lbr: Add LbrExtV2 branch record support
      perf/x86/amd/lbr: Add LbrExtV2 hardware branch filter support
      perf/x86: Move branch classifier
      perf/x86/amd/lbr: Add LbrExtV2 software branch filter support
      perf/x86: Make branch classifier fusion-aware
      perf/x86/amd/lbr: Use fusion-aware branch classifier
      perf/core: Add speculation info to branch entries
      perf/x86/amd/lbr: Add LbrExtV2 branch speculation info support

Stephane Eranian (2):
      perf/x86/utils: Fix uninitialized var in get_branch_type()
      perf/x86/amd/lbr: Adjust LBR regardless of filtering


 arch/powerpc/kernel/hw_breakpoint.c  |  53 ++-
 arch/powerpc/perf/core-book3s.c      |  10 +-
 arch/s390/kernel/perf_cpum_cf.c      |   1 +
 arch/s390/kernel/perf_pai_crypto.c   |   1 +
 arch/sh/include/asm/hw_breakpoint.h  |   5 +-
 arch/x86/events/Makefile             |   2 +-
 arch/x86/events/amd/Makefile         |   2 +-
 arch/x86/events/amd/brs.c            |  69 +++-
 arch/x86/events/amd/core.c           | 210 ++++++------
 arch/x86/events/amd/ibs.c            | 360 ++++++++++++++++++-
 arch/x86/events/amd/lbr.c            | 439 ++++++++++++++++++++++++
 arch/x86/events/core.c               |  61 ++--
 arch/x86/events/intel/core.c         | 101 ++++--
 arch/x86/events/intel/cstate.c       |   1 +
 arch/x86/events/intel/ds.c           |  55 ++-
 arch/x86/events/intel/lbr.c          | 273 ---------------
 arch/x86/events/intel/p4.c           |  37 +-
 arch/x86/events/intel/uncore.c       |   1 +
 arch/x86/events/msr.c                |   1 +
 arch/x86/events/perf_event.h         | 130 +++++--
 arch/x86/events/perf_event_flags.h   |  22 ++
 arch/x86/events/utils.c              | 251 ++++++++++++++
 arch/x86/include/asm/amd-ibs.h       |  16 +
 arch/x86/include/asm/cpufeatures.h   |   2 +-
 arch/x86/include/asm/hw_breakpoint.h |   5 +-
 arch/x86/include/asm/msr-index.h     |   5 +
 arch/x86/include/asm/perf_event.h    |   3 +-
 arch/x86/kernel/cpu/scattered.c      |   1 +
 drivers/perf/arm_spe_pmu.c           |   4 +-
 include/linux/hw_breakpoint.h        |   4 +-
 include/linux/percpu-rwsem.h         |   6 +
 include/linux/perf/arm_pmu.h         |   9 +-
 include/linux/perf_event.h           |  77 ++++-
 include/uapi/linux/perf_event.h      |  57 ++-
 kernel/bpf/stackmap.c                |   4 +-
 kernel/events/Makefile               |   1 +
 kernel/events/core.c                 |  88 +++--
 kernel/events/hw_breakpoint.c        | 648 ++++++++++++++++++++++++++---------
 kernel/events/hw_breakpoint_test.c   | 333 ++++++++++++++++++
 kernel/locking/percpu-rwsem.c        |   6 +
 kernel/trace/bpf_trace.c             |   3 +
 lib/Kconfig.debug                    |  10 +
 42 files changed, 2613 insertions(+), 754 deletions(-)
 create mode 100644 arch/x86/events/amd/lbr.c
 create mode 100644 arch/x86/events/perf_event_flags.h
 create mode 100644 arch/x86/events/utils.c
 create mode 100644 kernel/events/hw_breakpoint_test.c

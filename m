Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57B9A64A8C5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 21:35:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233580AbiLLUfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 15:35:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233572AbiLLUfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 15:35:11 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D8D917E0C;
        Mon, 12 Dec 2022 12:35:10 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id fc4so31229471ejc.12;
        Mon, 12 Dec 2022 12:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=4MmC51vNneBDxR+Ol6/nI/pLRgVHDMLqs6SDquGm7SU=;
        b=GDz9LCcLvFDGFSfek/PatM+Iqvh4yizsaGyLAKghgvnDws86vA4AalauFzKEuBP4LD
         ruHMk3BQGl7ucvvDhu/Xqsqpfg+dAHPXcP4TjzdW9wFPXklMZS5r0t4+WxodQzKgk8Lc
         QmNm/++Mr8o3szSkLywm1JytqiNv/NeR6NE1npaeTcWwRWWLYsv891/DIwKTK4yzgdcS
         diDY0lABQfOlyKYN94Ba3T0IPPfX7IgRnyMfD2TCO3afTTKcGcWwmi+0cFhBgA87MHlG
         skLJYTDtqTn81XrPVEEVsOJ9sfjn/m9jX4+Mmnj5j/jUulHWV7sKLZ1AczY7NeO8AtHS
         ItaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4MmC51vNneBDxR+Ol6/nI/pLRgVHDMLqs6SDquGm7SU=;
        b=QGUlF8m9169B+CGaaDRhjg/0C/k6disx/RmwXwg1dxdHISUrNGkERyyh3T+AZv3Ua1
         VevaVsrS35fakV3iv3YP1UOjO+zTtoVcSo9/NsfRg4I7L5M6Vn50nASlyM3Jqe2ARCWi
         grfLlHBud6uFb68PBnSSkKmCNx8+IByVGns+kCPTvTraWHzoYHL/eluiyaSBUItrzJYQ
         iU/lAha1Y3YJpKONdlyQR2TDmACGbLXR7evdmEDumeI0FlKgB7jEptDd+EXyTMe5ihAE
         1XKBeeKqMzhQb8XYx3Ie+jW4I/StzzIEqs8IMzR5ugdDSmTo8q2AvY8kSsOHel9/t6s8
         x9Fw==
X-Gm-Message-State: ANoB5pm/cm73hY/0Vwh3WCb1GFLrDx6j4Nz67MOhB5P6SQNFHGN50w05
        7PmUpowq5j1GywraN8ucfPQ=
X-Google-Smtp-Source: AA0mqf4zAEoojMVYRqRR9QZUpqN+3hXQDVbkNf5ZA8xF6pemxIFOBZC7KwM2fh9jHS3/oVgTjuXsjg==
X-Received: by 2002:a17:906:7b50:b0:7c1:65d1:c4ca with SMTP id n16-20020a1709067b5000b007c165d1c4camr7093556ejo.33.1670877308493;
        Mon, 12 Dec 2022 12:35:08 -0800 (PST)
Received: from gmail.com (1F2EF155.nat.pool.telekom.hu. [31.46.241.85])
        by smtp.gmail.com with ESMTPSA id rh16-20020a17090720f000b007c0985aa6b0sm3662598ejb.191.2022.12.12.12.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 12:35:07 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 12 Dec 2022 21:35:05 +0100
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
Subject: [GIT PULL] perf event updates for v6.2
Message-ID: <Y5eQeR2tpZ/Bos49@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2022-12-12

   # HEAD: 17b8d847b92d815d1638f0de154654081d66b281 perf/x86/intel/uncore: Fix reference count leak in __uncore_imc_init_box()

[ Conflict heads-up: there's going to be a trivial conflict in 
  kernel/events/core.c when pulling this into your v6.1+ tree. ]

Perf events updates for v6.2:

 - Thoroughly rewrite the data structures that implement perf task context handling,
   with the goal of fixing various quirks and unfeatures both in already merged,
   and in upcoming proposed code.

   The old data structure is the per task and per cpu perf_event_contexts:

         task_struct::perf_events_ctxp[] <-> perf_event_context <-> perf_cpu_context
              ^                                 |    ^     |           ^
              `---------------------------------'    |     `--> pmu ---'
                                                     v           ^
                                                perf_event ------'

   In this new design this is replaced with a single task context and
   a single CPU context, plus intermediate data-structures:

         task_struct::perf_event_ctxp -> perf_event_context <- perf_cpu_context
              ^                           |   ^ ^
              `---------------------------'   | |
                                              | |    perf_cpu_pmu_context <--.
                                              | `----.    ^                  |
                                              |      |    |                  |
                                              |      v    v                  |
                                              | ,--> perf_event_pmu_context  |
                                              | |                            |
                                              | |                            |
                                              v v                            |
                                         perf_event ---> pmu ----------------'

   [ See commit bd2756811766 for more details. ]

   This rewrite was developed by Peter Zijlstra and Ravi Bangoria.

 - Optimize perf_tp_event()

 - Update the Intel uncore PMU driver, extending it with UPI topology discovery
   on various hardware models.

 - Misc fixes & cleanups

 Thanks,

	Ingo

------------------>
Alexander Antonov (11):
      perf/x86/intel/uncore: Generalize IIO topology support
      perf/x86/intel/uncore: Introduce UPI topology type
      perf/x86/intel/uncore: Clear attr_update properly
      perf/x86/intel/uncore: Disable I/O stacks to PMU mapping on ICX-D
      perf/x86/intel/uncore: Generalize get_topology() for SKX PMUs
      perf/x86/intel/uncore: Enable UPI topology discovery for Skylake Server
      perf/x86/intel/uncore: Get UPI NodeID and GroupID
      perf/x86/intel/uncore: Enable UPI topology discovery for Icelake Server
      perf/x86/intel/uncore: Enable UPI topology discovery for Sapphire Rapids
      perf/x86/intel/uncore: Update sysfs-devices-mapping file
      perf/x86/intel/uncore: Make set_mapping() procedure void

Chen Zhongjin (1):
      perf: Fix possible memleak in pmu_dev_alloc()

Colin Ian King (1):
      perf: Remove unused pointer task_ctx

Gaosheng Cui (1):
      perf: Fix IS_ERR() vs NULL check in inherit_event()

Peter Zijlstra (2):
      perf: Rewrite core context handling
      perf: Fix function pointer case

Rafael Mendonca (1):
      perf/x86: Remove unused variable 'cpu_type'

Ravi Bangoria (3):
      perf: Optimize perf_tp_event()
      perf/amd/ibs: Make IBS a core pmu
      perf/core: Don't allow grouping events from different hw pmus

Shaokun Zhang (1):
      perf/x86/amd: Remove the repeated declaration

Xiongfeng Wang (4):
      perf/x86/intel/uncore: Fix reference count leak in sad_cfg_iio_topology()
      perf/x86/intel/uncore: Fix reference count leak in hswep_has_limit_sbox()
      perf/x86/intel/uncore: Fix reference count leak in snr_uncore_mmio_map()
      perf/x86/intel/uncore: Fix reference count leak in __uncore_imc_init_box()


 Documentation/ABI/testing/sysfs-devices-mapping |   30 +-
 arch/arm64/kernel/perf_event.c                  |   18 +-
 arch/powerpc/perf/core-book3s.c                 |    8 +-
 arch/s390/kernel/perf_pai_crypto.c              |    2 +-
 arch/s390/kernel/perf_pai_ext.c                 |    2 +-
 arch/x86/events/amd/brs.c                       |    2 +-
 arch/x86/events/amd/ibs.c                       |    4 +-
 arch/x86/events/amd/lbr.c                       |    6 +-
 arch/x86/events/core.c                          |   48 +-
 arch/x86/events/intel/core.c                    |   23 +-
 arch/x86/events/intel/ds.c                      |    4 +-
 arch/x86/events/intel/lbr.c                     |   30 +-
 arch/x86/events/intel/uncore.h                  |   24 +-
 arch/x86/events/intel/uncore_snb.c              |    3 +
 arch/x86/events/intel/uncore_snbep.c            |  495 +++++-
 arch/x86/events/perf_event.h                    |   31 +-
 drivers/perf/arm_pmu.c                          |   16 +-
 include/linux/perf/arm_pmu.h                    |    2 +-
 include/linux/perf_event.h                      |  125 +-
 include/linux/sched.h                           |    2 +-
 kernel/events/core.c                            | 2120 ++++++++++++-----------
 21 files changed, 1765 insertions(+), 1230 deletions(-)

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E447369CB1B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 13:35:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjBTMfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 07:35:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjBTMfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 07:35:44 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0528B9004;
        Mon, 20 Feb 2023 04:35:43 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id eq27so8756649edb.5;
        Mon, 20 Feb 2023 04:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=z8tzZqldV0v3ozWp6HtnpIchWIjN7Y52ib2G8Slsj7s=;
        b=og6M303pVyaopZpCwFOw9NXNTFAEU3FB6zdn2/LHxhVskqaIivhA+G/4qh3C4mnaXz
         ARF3m5HIxDcF1YWSRDlvbquirIj08WZFahQ+iJwsYptVyu7atbGZQocid4A+RFGB6mY4
         rimAYyLXsQtWCHOJ4moqBH5uJzJ6PiySWK1qgPjNN8NfnUZAUVBtBARq4UfaUT8N1gY3
         QK4ltXvWuzeXY6UR0yjYvsDKCXTPp6kIEwAUjPNIvqfTV7jM4jvsQgkmG0kUyBSPeZ4r
         A3hk38KuGFhHI5t4T5cFagKd8YzjPMkdeBJBShppJqey0lgmjiQ6KJWBGsZHhKIEbaRr
         UH3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z8tzZqldV0v3ozWp6HtnpIchWIjN7Y52ib2G8Slsj7s=;
        b=w7qRQSxYZpLo2ZfMaVK+pLbEsJbW05sXpcAeOXa/2B0kkcgs3Xxq2BCG8drY0ILHA4
         WfqioDyuhQ4WsWppmZWycYn4X426QY/tOAz6SeQTPSKwfGi/R1keTieS9QY9prReVOT9
         eTtTdRT+BhDroeeghM1u6M78RciB4ZiExmy3TZEOwqwntgD9V9N2MkUQWpnbQxpHATVX
         TjtuRyWxIVEY+dAA7vTUNKyfbmnl2TRsrNW2PRuhI9CGk5L4wGxaxDW3Ob5yq1txfyr+
         aDPBF/ZkXe96uFfl8VXFcCiQseWHseJ3ZTXR0cp84gvAeJVakKqOLyDCETkWYkzLkGqE
         teMg==
X-Gm-Message-State: AO0yUKUksmw9JXiwhsSvZ5az51HUKVPqqUlRA2St5qiWqnE2u/6Azyqn
        Tv++Yb1tJXzJ0nY4UiM0klh2nTzP78k=
X-Google-Smtp-Source: AK7set8GRIbKCo9hrGQjVB2E2xw+WQ1cASGnBT2du/KDWvwFVciexiSCYqP98M25BxwKIB7FsrMAsQ==
X-Received: by 2002:a17:907:7f0d:b0:87b:d2b3:67ca with SMTP id qf13-20020a1709077f0d00b0087bd2b367camr10539631ejc.75.1676896541366;
        Mon, 20 Feb 2023 04:35:41 -0800 (PST)
Received: from gmail.com ([31.46.241.99])
        by smtp.gmail.com with ESMTPSA id a19-20020a17090680d300b008d4df095034sm1064563ejx.195.2023.02.20.04.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 04:35:40 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 20 Feb 2023 13:35:34 +0100
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
Subject: [GIT PULL] perf event updates for v6.3
Message-ID: <Y/NpFhW0JUQAmMn3@gmail.com>
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

Please pull the latest perf events tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2023-02-20

   # HEAD: c828441f21ddc819a28b5723a72e3c840e9de1c6 perf/x86/intel/uncore: Add Meteor Lake support

The latest perf updates in this cycle are:

 - Optimize perf_sample_data layout
 - Prepare sample data handling for BPF integration
 - Update the x86 PMU driver for Intel Meteor Lake
 - Restructure the x86 uncore code to fix a SPR (Sapphire Rapids)
   discovery breakage
 - Fix the x86 Zhaoxin PMU driver
 - Cleanups

 Thanks,

	Ingo

------------------>
Chuang Wang (1):
      x86/kprobes: Use switch-case for 0xFF opcodes in prepare_emulation

Kan Liang (14):
      perf: Add PMU_FORMAT_ATTR_SHOW
      perf/x86: Add Meteor Lake support
      perf/x86: Support Retire Latency
      x86/cpufeatures: Add Architectural PerfMon Extension bit
      perf/x86/intel: Support Architectural PerfMon Extension leaf
      perf/x86/cstate: Add Meteor Lake support
      perf/x86/msr: Add Meteor Lake support
      perf/x86/uncore: Factor out uncore_device_to_die()
      perf/x86/uncore: Fix potential NULL pointer in uncore_get_alias_name
      perf/x86/uncore: Ignore broken units in discovery table
      perf/x86/uncore: Add a quirk for UPI on SPR
      perf/x86/uncore: Don't WARN_ON_ONCE() for a broken discovery table
      perf/x86/intel/ds: Fix the conversion from TSC to perf time
      perf/x86/intel/uncore: Add Meteor Lake support

Like Xu (1):
      perf/x86/lbr: Simplify the exposure check for the LBR_INFO registers

Masami Hiramatsu (Google) (1):
      x86/kprobes: Drop removed INT3 handling code

Namhyung Kim (9):
      perf/core: Change the layout of perf_sample_data
      perf/core: Save the dynamic parts of sample data size
      perf/core: Add perf_sample_save_callchain() helper
      perf/core: Add perf_sample_save_raw_data() helper
      perf/core: Add perf_sample_save_brstack() helper
      perf/core: Set data->sample_flags in perf_prepare_sample()
      perf/core: Do not pass header for sample ID init
      perf/core: Introduce perf_prepare_header()
      perf/core: Call perf_prepare_sample() before running BPF

silviazhao (1):
      x86/perf/zhaoxin: Add stepping check for ZXC


 arch/powerpc/perf/core-book3s.c          |   3 +-
 arch/s390/kernel/perf_cpum_cf.c          |   4 +-
 arch/s390/kernel/perf_cpum_sf.c          |   3 +-
 arch/s390/kernel/perf_pai_crypto.c       |   4 +-
 arch/s390/kernel/perf_pai_ext.c          |   4 +-
 arch/x86/events/amd/core.c               |   6 +-
 arch/x86/events/amd/ibs.c                |   9 +-
 arch/x86/events/intel/core.c             | 199 ++++++++++++++++++++++++++---
 arch/x86/events/intel/ds.c               | 133 ++++++++++++++------
 arch/x86/events/intel/lbr.c              |   4 +-
 arch/x86/events/intel/uncore.c           |  41 +++++-
 arch/x86/events/intel/uncore.h           |   5 +
 arch/x86/events/intel/uncore_discovery.c |  60 ++++++---
 arch/x86/events/intel/uncore_discovery.h |  14 ++-
 arch/x86/events/intel/uncore_snb.c       | 161 ++++++++++++++++++++++++
 arch/x86/events/intel/uncore_snbep.c     | 158 ++++++++++++++++++-----
 arch/x86/events/perf_event.h             |  23 ++--
 arch/x86/events/zhaoxin/core.c           |   8 +-
 arch/x86/include/asm/cpufeatures.h       |   1 +
 arch/x86/include/asm/msr-index.h         |   3 +
 arch/x86/include/asm/perf_event.h        |   8 ++
 arch/x86/kernel/kprobes/core.c           |  34 ++---
 include/linux/perf_event.h               | 172 +++++++++++++++++--------
 kernel/events/core.c                     | 207 +++++++++++++++++--------------
 kernel/trace/bpf_trace.c                 |   6 +-
 25 files changed, 953 insertions(+), 317 deletions(-)

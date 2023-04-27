Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 608A76F0CC5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 21:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344072AbjD0T6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 15:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjD0T6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 15:58:08 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97EE4102
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 12:58:06 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-50a14564d17so10236702a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 12:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682625485; x=1685217485;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=989hUtGEXHxQonnOCeEb5WSkYFpgBCEOi68ZJXZiflU=;
        b=KHMtiqtIEQyaAaUY74wM37hOWzOYQAA7bak/Wd/KNMo4RGd8gMPh6DKQ5IrTPjFvQs
         uGtO2NtoV2S76tm1tCFyroXTHoF0LFidchjwiM+53DwT930pW2dpyWrQfvoVqe7Lr+m6
         kmT5tAqfXurlPk9sAonWL5KimRYQShROQ387NCJYnHnt53pz5MAMX+Hq+bWtdjEE5mpp
         P6k/yRp90/cFCfcQhv/AJ8nRZ6O5LLfnfrn13RkuIHmxmwC9t8Pl5DnuhbyApvyR+Qqq
         CGsoEbTL47jmPEY+xHR18zbX0hBjvUM3Oz9V3xU7Jbi2GaJjvi77r7Mclpm3yYYvHVby
         R2SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682625485; x=1685217485;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=989hUtGEXHxQonnOCeEb5WSkYFpgBCEOi68ZJXZiflU=;
        b=ZVnizyh6eaKIxq7ZqKJvl6uIPwoYhZu0p1XM+Q++QdlwubvVvLLwnqQJHzSfT+hKWN
         0AybBYo2lk4JjRrVjHLPRndHeiof9UpsBWZstmC/IyKJ4Nds8nYIENw+k6AT/GvZz/ko
         ST00yV4y3kFunN9RifKtJ8Ry8nsjaUpa/YDo2bict/oOPk4BJGwPGhIUECmlL808uLX6
         kAqQYaF+8LYjWwoRY8XWZcGeLYDMYx9Vf8wnCSLVioUvWXann7lx5Fn7oFQyzKXGPZ1X
         RBElPzRVoqqE/W3/QIeTmHA9uvXQB7rur3LRF9R55K7a02T5TkR9fjaHkiQMgFvsy0X8
         RZPA==
X-Gm-Message-State: AC+VfDxnUWBgHcXqzzSMaM/DEaAoabIRdQVGDZe4RVQXZnp1IdCfBg7u
        HrRf/mmLvwWtxapcP2iqty0=
X-Google-Smtp-Source: ACHHUZ6V2h6Rt9rWgivfbloshfcpXrO/+CvNlN2zw6HfvFnrC+qKuc5rcasvjJ07oQ0+MCqs6gyylA==
X-Received: by 2002:a05:6402:42c8:b0:506:71bd:3931 with SMTP id i8-20020a05640242c800b0050671bd3931mr7911478edc.2.1682625484975;
        Thu, 27 Apr 2023 12:58:04 -0700 (PDT)
Received: from gmail.com ([31.46.243.138])
        by smtp.gmail.com with ESMTPSA id p19-20020a05640210d300b005067d089aafsm8151110edu.11.2023.04.27.12.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 12:58:04 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Thu, 27 Apr 2023 21:58:00 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] locking changes for v6.4
Message-ID: <ZErTyKxjGQvF6EqP@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/NmzouehvMWTPVZ@gmail.com>
X-Spam-Status: No, score=1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Please pull the latest locking/core git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-core-2023-04-27

   # HEAD: 93eff603d6a2bc1895eeb7063dbd0661bb760b74 locking/atomic: Correct (cmp)xhcg instrumentation

Locking changes in v6.4:

 - Introduce local{,64}_try_cmpxchg() - a slightly more optimal
   primitive, which will be used in perf events ring-buffer code.

 - Add more atomic_add_negative() variants, used by rcuref:

 - Add rcuref - A scalable reference count implementation for RCU managed objects

 - Add non-atomic __xchg() variant, use it in a couple of places

 - Misc cleanups and fixes.


NOTE: the internal merge commit of locking/rcuref [1afa833d607b6] merging 
      two commits from a WIP branch has no explanation. I noticed this too
      late, and we can re-do this tree if it's an issue.

 Thanks,

	Ingo

------------------>
Andrzej Hajda (5):
      arch: rename all internal names __xchg to __arch_xchg
      linux/include: add non-atomic version of xchg
      arch/*/uprobes: simplify arch_uretprobe_hijack_return_addr
      llist: simplify __llist_del_all
      drm/i915/gt: use __xchg instead of internal helper

Mark Rutland (1):
      locking/atomic: Correct (cmp)xhcg instrumentation

Sebastian Andrzej Siewior (1):
      locking/rwbase: Mitigate indefinite writer starvation.

Thomas Gleixner (2):
      atomics: Provide atomic_add_negative() variants
      atomics: Provide rcuref - scalable reference counting

Uros Bizjak (4):
      locking/atomic: Add generic try_cmpxchg{,64}_local support
      locking/generic: Wire up local{,64}_try_cmpxchg
      locking/arch: Wire up local_try_cmpxchg
      locking/x86: Define arch_try_cmpxchg_local


 arch/alpha/include/asm/cmpxchg.h                   |  10 +-
 arch/alpha/include/asm/local.h                     |  12 +-
 arch/arc/include/asm/cmpxchg.h                     |   4 +-
 arch/arm/include/asm/cmpxchg.h                     |   7 +-
 arch/arm/probes/uprobes/core.c                     |   8 +-
 arch/arm64/include/asm/cmpxchg.h                   |   7 +-
 arch/arm64/kernel/probes/uprobes.c                 |   9 +-
 arch/csky/kernel/probes/uprobes.c                  |   9 +-
 arch/hexagon/include/asm/cmpxchg.h                 |  10 +-
 arch/ia64/include/asm/cmpxchg.h                    |   2 +-
 arch/ia64/include/uapi/asm/cmpxchg.h               |   4 +-
 arch/loongarch/include/asm/cmpxchg.h               |   4 +-
 arch/loongarch/include/asm/local.h                 |  13 +-
 arch/m68k/include/asm/cmpxchg.h                    |   6 +-
 arch/mips/include/asm/cmpxchg.h                    |   4 +-
 arch/mips/include/asm/local.h                      |  13 +-
 arch/mips/kernel/uprobes.c                         |  10 +-
 arch/openrisc/include/asm/cmpxchg.h                |  10 +-
 arch/parisc/include/asm/cmpxchg.h                  |   4 +-
 arch/powerpc/include/asm/cmpxchg.h                 |   4 +-
 arch/powerpc/include/asm/local.h                   |  11 +
 arch/powerpc/kernel/uprobes.c                      |  10 +-
 arch/riscv/include/asm/atomic.h                    |   2 +-
 arch/riscv/include/asm/cmpxchg.h                   |   4 +-
 arch/riscv/kernel/probes/uprobes.c                 |   9 +-
 arch/s390/include/asm/cmpxchg.h                    |   8 +-
 arch/s390/kernel/uprobes.c                         |   7 +-
 arch/sh/include/asm/cmpxchg.h                      |   4 +-
 arch/sparc/include/asm/cmpxchg_32.h                |   4 +-
 arch/sparc/include/asm/cmpxchg_64.h                |   6 +-
 arch/sparc/kernel/uprobes.c                        |   7 +-
 arch/x86/include/asm/cmpxchg.h                     |   6 +
 arch/x86/include/asm/local.h                       |  13 +-
 arch/xtensa/include/asm/cmpxchg.h                  |   4 +-
 drivers/gpu/drm/i915/gt/intel_engine_cs.c          |   2 +-
 drivers/gpu/drm/i915/gt/intel_engine_heartbeat.c   |   4 +-
 .../gpu/drm/i915/gt/intel_execlists_submission.c   |   4 +-
 drivers/gpu/drm/i915/gt/intel_ggtt.c               |   4 +-
 drivers/gpu/drm/i915/gt/intel_gsc.c                |   2 +-
 drivers/gpu/drm/i915/gt/intel_gt.c                 |   4 +-
 drivers/gpu/drm/i915/gt/intel_gt_pm.c              |   2 +-
 drivers/gpu/drm/i915/gt/intel_lrc.c                |   6 +-
 drivers/gpu/drm/i915/gt/intel_migrate.c            |   2 +-
 drivers/gpu/drm/i915/gt/intel_rc6.c                |   2 +-
 drivers/gpu/drm/i915/gt/intel_rps.c                |   2 +-
 drivers/gpu/drm/i915/gt/selftest_context.c         |   2 +-
 drivers/gpu/drm/i915/gt/selftest_ring_submission.c |   2 +-
 drivers/gpu/drm/i915/gt/selftest_timeline.c        |   2 +-
 drivers/gpu/drm/i915/gt/uc/intel_uc.c              |   2 +-
 drivers/gpu/drm/i915/gt/uc/intel_uc_fw.c           |   2 +-
 drivers/gpu/drm/i915/i915_utils.h                  |   1 +
 include/asm-generic/local.h                        |   1 +
 include/asm-generic/local64.h                      |  12 +-
 include/linux/atomic/atomic-arch-fallback.h        | 230 ++++++++++++++++-
 include/linux/atomic/atomic-instrumented.h         | 152 ++++++++---
 include/linux/atomic/atomic-long.h                 |  38 ++-
 include/linux/llist.h                              |   6 +-
 include/linux/non-atomic/xchg.h                    |  19 ++
 include/linux/rcuref.h                             | 155 ++++++++++++
 include/linux/types.h                              |   6 +
 kernel/locking/rwbase_rt.c                         |   9 -
 lib/Makefile                                       |   2 +-
 lib/rcuref.c                                       | 281 +++++++++++++++++++++
 scripts/atomic/atomics.tbl                         |   2 +-
 scripts/atomic/fallbacks/add_negative              |  11 +-
 scripts/atomic/gen-atomic-fallback.sh              |   4 +
 scripts/atomic/gen-atomic-instrumented.sh          |   8 +-
 67 files changed, 1019 insertions(+), 207 deletions(-)
 create mode 100644 include/linux/non-atomic/xchg.h
 create mode 100644 include/linux/rcuref.h
 create mode 100644 lib/rcuref.c

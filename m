Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 341F173FA97
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 12:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbjF0Kzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 06:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbjF0Kzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 06:55:43 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F3F1FD0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 03:55:36 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f9bdb01ec0so52531415e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 03:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687863334; x=1690455334;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=uxQMab6OLEaBJZnaou43MLZ29JIfoX0v6XrRTCreuzI=;
        b=QjpO2D4i92A2Wv+t8J30qLQatguwY2Vlk+P0PWFNI72AtSIswYoVfV8KiPhWJeMGFA
         BsflkUzO90yNf9PLV9EJ1eKnHX9FY17cSSTol5vyZtik6p6tXF4jSqefnKKwYrbR6ezw
         itRIdc6i0a4ys0wK6BVXnWGn2H2PzFQoSDI4I1Mzo7paXK0aGpx7V8TRB3cQPO691UZ9
         YDO3pv8/fveoU6BRNKa7y4JJoYdNjRbn/bVboncvlogrWne6ZtzAWW+3EtE7TsZr7j86
         uOnMx3GFbK5f4IuhX3Ss+Bqdx4jTS/CH2DJht06c8QDLIsvCVGQXGWWTDpqcqmZCRLzO
         0Mow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687863334; x=1690455334;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uxQMab6OLEaBJZnaou43MLZ29JIfoX0v6XrRTCreuzI=;
        b=i4yEMUyrvA1Qqvoh/nWZ05UG3ikfIxcO/QOhmebs8W0yBjtx49kSrSX0Te7Q3Ktk+Y
         YCB0ackaMMBtEVEZ4JfTGkp/qJcaFYSW2Q/xC5ThkfF8M+Kkw3XL51Z59+PUzAT6ip5h
         TtSbK1HV4BjdBLNFzcMuP0EGMKlWa8V45C132CuEwZsWAPdie7azLyZms5hrYfy83k/p
         RRfBFlrd9oJKkxotLx22hP+hm2GgA1RyYqmePpltrKH26j7VxsMyXRYGP3rWhMzbuw8E
         JrHid6AkfetigIieywgg30zbV009sQjRiDi3qe5Ng0eOpVbzbLmnjTaVKy1un31dmERs
         r9lA==
X-Gm-Message-State: AC+VfDwa0UusSNVU8Ge1cS4xnz2DDkEoutNNOq31C/1AajNO6TO1nbtV
        6pw3WEyjAtqJd9EwUoCbRRI=
X-Google-Smtp-Source: ACHHUZ6cMuE2wkFT5o1kjYksTaAzJYeNV+FptjQSl1VjvtP8t95Zybd3SP7kiEM1Oov6qzkkQs+SHg==
X-Received: by 2002:a1c:7419:0:b0:3f9:b79d:a5fa with SMTP id p25-20020a1c7419000000b003f9b79da5famr16834179wmc.16.1687863334212;
        Tue, 27 Jun 2023 03:55:34 -0700 (PDT)
Received: from gmail.com (1F2EF7E2.nat.pool.telekom.hu. [31.46.247.226])
        by smtp.gmail.com with ESMTPSA id y12-20020a7bcd8c000000b003fa79af15c7sm13441466wmj.2.2023.06.27.03.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 03:55:33 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 27 Jun 2023 12:55:31 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] Locking changes for v6.5
Message-ID: <ZJrAI6cgvy/tZSj2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest locking tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-core-2023-06-27

   # HEAD: b33eb50a92b0a298fa8a6ac350e741c3ec100f6d locking/atomic: scripts: fix ${atomic}_dec_if_positive() kerneldoc

Locking changes for v6.5:

- Introduce cmpxchg128() -- aka. the demise of cmpxchg_double().

  The cmpxchg128() family of functions is basically & functionally
  the same as cmpxchg_double(), but with a saner interface: instead
  of a 6-parameter horror that forced u128 - u64/u64-halves layout
  details on the interface and exposed users to complexity,
  fragility & bugs, use a natural 3-parameter interface with u128 types.

- Restructure the generated atomic headers, and add
  kerneldoc comments for all of the generic atomic{,64,_long}_t
  operations. Generated definitions are much cleaner now,
  and come with documentation.

- Implement lock_set_cmp_fn() on lockdep, for defining an ordering
  when taking multiple locks of the same type. This gets rid of
  one use of lockdep_set_novalidate_class() in the bcache code.

- Fix raw_cpu_generic_try_cmpxchg() bug due to an unintended
  variable shadowing generating garbage code on Clang on certain
  ARM builds.

 Thanks,

	Ingo

------------------>
Kent Overstreet (2):
      lockdep: Add lock_set_cmp_fn() annotation
      bcache: Convert to lock_cmp_fn

Mark Rutland (27):
      locking/atomic: arm: fix sync ops
      locking/atomic: remove fallback comments
      locking/atomic: hexagon: remove redundant arch_atomic_cmpxchg
      locking/atomic: make atomic*_{cmp,}xchg optional
      locking/atomic: arc: add preprocessor symbols
      locking/atomic: arm: add preprocessor symbols
      locking/atomic: hexagon: add preprocessor symbols
      locking/atomic: m68k: add preprocessor symbols
      locking/atomic: parisc: add preprocessor symbols
      locking/atomic: sh: add preprocessor symbols
      locking/atomic: sparc: add preprocessor symbols
      locking/atomic: x86: add preprocessor symbols
      locking/atomic: xtensa: add preprocessor symbols
      locking/atomic: scripts: remove bogus order parameter
      locking/atomic: scripts: remove leftover "${mult}"
      locking/atomic: scripts: factor out order template generation
      locking/atomic: scripts: add trivial raw_atomic*_<op>()
      locking/atomic: treewide: use raw_atomic*_<op>()
      locking/atomic: scripts: build raw_atomic_long*() directly
      locking/atomic: scripts: restructure fallback ifdeffery
      locking/atomic: scripts: split pfx/name/sfx/order
      locking/atomic: scripts: simplify raw_atomic_long*() definitions
      locking/atomic: scripts: simplify raw_atomic*() definitions
      docs: scripts: kernel-doc: accept bitwise negation like ~@var
      locking/atomic: scripts: generate kerneldoc comments
      locking/atomic: treewide: delete arch_atomic_*() kerneldoc
      locking/atomic: scripts: fix ${atomic}_dec_if_positive() kerneldoc

Nathan Chancellor (1):
      percpu: Fix self-assignment of __old in raw_cpu_generic_try_cmpxchg()

Paul E. McKenney (1):
      locking/atomic: docs: Add atomic operations to the driver basic API documentation

Peter Zijlstra (12):
      cyrpto/b128ops: Remove struct u128
      types: Introduce [us]128
      arch: Introduce arch_{,try_}_cmpxchg128{,_local}()
      instrumentation: Wire up cmpxchg128()
      percpu: Add {raw,this}_cpu_try_cmpxchg()
      percpu: Wire up cmpxchg128
      parisc: Raise minimal GCC version
      x86,amd_iommu: Replace cmpxchg_double()
      x86,intel_iommu: Replace cmpxchg_double()
      slub: Replace cmpxchg_double()
      arch: Remove cmpxchg_double
      s390/cpum_sf: Convert to cmpxchg128()


 Documentation/core-api/this_cpu_ops.rst      |    2 -
 Documentation/driver-api/basics.rst          |    8 +-
 arch/alpha/include/asm/atomic.h              |   35 -
 arch/arc/include/asm/atomic-spinlock.h       |    9 +
 arch/arc/include/asm/atomic.h                |   24 -
 arch/arc/include/asm/atomic64-arcv2.h        |   19 +-
 arch/arm/include/asm/assembler.h             |   17 +
 arch/arm/include/asm/atomic.h                |   15 +-
 arch/arm/include/asm/sync_bitops.h           |   29 +-
 arch/arm/lib/bitops.h                        |   14 +-
 arch/arm/lib/testchangebit.S                 |    4 +
 arch/arm/lib/testclearbit.S                  |    4 +
 arch/arm/lib/testsetbit.S                    |    4 +
 arch/arm64/include/asm/atomic.h              |   28 -
 arch/arm64/include/asm/atomic_ll_sc.h        |   56 +-
 arch/arm64/include/asm/atomic_lse.h          |   39 +-
 arch/arm64/include/asm/cmpxchg.h             |   48 +-
 arch/arm64/include/asm/percpu.h              |   30 +-
 arch/csky/include/asm/atomic.h               |   35 -
 arch/hexagon/include/asm/atomic.h            |   69 +-
 arch/ia64/include/asm/atomic.h               |    7 -
 arch/loongarch/include/asm/atomic.h          |   56 -
 arch/m68k/include/asm/atomic.h               |   18 +-
 arch/mips/include/asm/atomic.h               |   11 -
 arch/openrisc/include/asm/atomic.h           |    3 -
 arch/parisc/include/asm/atomic.h             |   27 +-
 arch/powerpc/include/asm/atomic.h            |   24 -
 arch/powerpc/kernel/smp.c                    |   12 +-
 arch/riscv/include/asm/atomic.h              |   72 -
 arch/s390/include/asm/cmpxchg.h              |   32 +-
 arch/s390/include/asm/cpu_mf.h               |    2 +-
 arch/s390/include/asm/percpu.h               |   34 +-
 arch/s390/kernel/perf_cpum_sf.c              |   16 +-
 arch/sh/include/asm/atomic-grb.h             |    9 +
 arch/sh/include/asm/atomic-irq.h             |    9 +
 arch/sh/include/asm/atomic-llsc.h            |    9 +
 arch/sh/include/asm/atomic.h                 |    3 -
 arch/sparc/include/asm/atomic_32.h           |   30 +-
 arch/sparc/include/asm/atomic_64.h           |   29 +-
 arch/x86/include/asm/atomic.h                |   87 -
 arch/x86/include/asm/atomic64_32.h           |   76 -
 arch/x86/include/asm/atomic64_64.h           |   81 -
 arch/x86/include/asm/cmpxchg.h               |   25 -
 arch/x86/include/asm/cmpxchg_32.h            |    2 +-
 arch/x86/include/asm/cmpxchg_64.h            |   67 +-
 arch/x86/include/asm/percpu.h                |  102 +-
 arch/x86/kernel/alternative.c                |    4 +-
 arch/x86/kernel/cpu/mce/core.c               |   16 +-
 arch/x86/kernel/nmi.c                        |    2 +-
 arch/x86/kernel/pvclock.c                    |    4 +-
 arch/x86/kvm/x86.c                           |    2 +-
 arch/x86/lib/Makefile                        |    3 +-
 arch/x86/lib/cmpxchg16b_emu.S                |   43 +-
 arch/x86/lib/cmpxchg8b_emu.S                 |   67 +-
 arch/xtensa/include/asm/atomic.h             |   12 +-
 drivers/iommu/amd/amd_iommu_types.h          |    9 +-
 drivers/iommu/amd/iommu.c                    |   10 +-
 drivers/iommu/intel/irq_remapping.c          |    8 +-
 drivers/md/bcache/btree.c                    |   23 +-
 drivers/md/bcache/btree.h                    |    4 +-
 include/asm-generic/atomic.h                 |    3 -
 include/asm-generic/bitops/atomic.h          |   12 +-
 include/asm-generic/bitops/lock.h            |    8 +-
 include/asm-generic/percpu.h                 |  209 +-
 include/crypto/b128ops.h                     |   14 +-
 include/linux/atomic/atomic-arch-fallback.h  | 5607 +++++++++++++++++---------
 include/linux/atomic/atomic-instrumented.h   | 3459 ++++++++++++++--
 include/linux/atomic/atomic-long.h           | 2122 ++++++----
 include/linux/context_tracking.h             |    4 +-
 include/linux/context_tracking_state.h       |    2 +-
 include/linux/cpumask.h                      |    2 +-
 include/linux/dmar.h                         |  117 +-
 include/linux/jump_label.h                   |    2 +-
 include/linux/lockdep.h                      |    8 +
 include/linux/lockdep_types.h                |    8 +
 include/linux/percpu-defs.h                  |   45 +-
 include/linux/slub_def.h                     |   12 +-
 include/linux/types.h                        |    5 +
 include/uapi/linux/types.h                   |    4 +
 kernel/context_tracking.c                    |   12 +-
 kernel/locking/lockdep.c                     |  118 +-
 kernel/sched/clock.c                         |    2 +-
 lib/crypto/curve25519-hacl64.c               |    2 -
 lib/crypto/poly1305-donna64.c                |    2 -
 mm/slab.h                                    |   53 +-
 mm/slub.c                                    |  139 +-
 scripts/atomic/atomic-tbl.sh                 |  112 +-
 scripts/atomic/atomics.tbl                   |    2 +-
 scripts/atomic/fallbacks/acquire             |    4 -
 scripts/atomic/fallbacks/add_negative        |   14 +-
 scripts/atomic/fallbacks/add_unless          |   15 +-
 scripts/atomic/fallbacks/andnot              |    6 +-
 scripts/atomic/fallbacks/cmpxchg             |    3 +
 scripts/atomic/fallbacks/dec                 |    6 +-
 scripts/atomic/fallbacks/dec_and_test        |   14 +-
 scripts/atomic/fallbacks/dec_if_positive     |    8 +-
 scripts/atomic/fallbacks/dec_unless_positive |    8 +-
 scripts/atomic/fallbacks/fence               |    4 -
 scripts/atomic/fallbacks/fetch_add_unless    |   17 +-
 scripts/atomic/fallbacks/inc                 |    6 +-
 scripts/atomic/fallbacks/inc_and_test        |   14 +-
 scripts/atomic/fallbacks/inc_not_zero        |   13 +-
 scripts/atomic/fallbacks/inc_unless_negative |    8 +-
 scripts/atomic/fallbacks/read_acquire        |    6 +-
 scripts/atomic/fallbacks/release             |    4 -
 scripts/atomic/fallbacks/set_release         |    6 +-
 scripts/atomic/fallbacks/sub_and_test        |   15 +-
 scripts/atomic/fallbacks/try_cmpxchg         |    6 +-
 scripts/atomic/fallbacks/xchg                |    3 +
 scripts/atomic/gen-atomic-fallback.sh        |  276 +-
 scripts/atomic/gen-atomic-instrumented.sh    |   42 +-
 scripts/atomic/gen-atomic-long.sh            |   38 +-
 scripts/atomic/kerneldoc/add                 |   13 +
 scripts/atomic/kerneldoc/add_negative        |   13 +
 scripts/atomic/kerneldoc/add_unless          |   18 +
 scripts/atomic/kerneldoc/and                 |   13 +
 scripts/atomic/kerneldoc/andnot              |   13 +
 scripts/atomic/kerneldoc/cmpxchg             |   14 +
 scripts/atomic/kerneldoc/dec                 |   12 +
 scripts/atomic/kerneldoc/dec_and_test        |   12 +
 scripts/atomic/kerneldoc/dec_if_positive     |   12 +
 scripts/atomic/kerneldoc/dec_unless_positive |   12 +
 scripts/atomic/kerneldoc/inc                 |   12 +
 scripts/atomic/kerneldoc/inc_and_test        |   12 +
 scripts/atomic/kerneldoc/inc_not_zero        |   12 +
 scripts/atomic/kerneldoc/inc_unless_negative |   12 +
 scripts/atomic/kerneldoc/or                  |   13 +
 scripts/atomic/kerneldoc/read                |   12 +
 scripts/atomic/kerneldoc/set                 |   13 +
 scripts/atomic/kerneldoc/sub                 |   13 +
 scripts/atomic/kerneldoc/sub_and_test        |   13 +
 scripts/atomic/kerneldoc/try_cmpxchg         |   15 +
 scripts/atomic/kerneldoc/xchg                |   13 +
 scripts/atomic/kerneldoc/xor                 |   13 +
 scripts/kernel-doc                           |    2 +-
 scripts/min-tool-version.sh                  |    6 +-
 136 files changed, 10107 insertions(+), 4346 deletions(-)
 create mode 100644 scripts/atomic/fallbacks/cmpxchg
 create mode 100644 scripts/atomic/fallbacks/xchg
 create mode 100644 scripts/atomic/kerneldoc/add
 create mode 100644 scripts/atomic/kerneldoc/add_negative
 create mode 100644 scripts/atomic/kerneldoc/add_unless
 create mode 100644 scripts/atomic/kerneldoc/and
 create mode 100644 scripts/atomic/kerneldoc/andnot
 create mode 100644 scripts/atomic/kerneldoc/cmpxchg
 create mode 100644 scripts/atomic/kerneldoc/dec
 create mode 100644 scripts/atomic/kerneldoc/dec_and_test
 create mode 100644 scripts/atomic/kerneldoc/dec_if_positive
 create mode 100644 scripts/atomic/kerneldoc/dec_unless_positive
 create mode 100644 scripts/atomic/kerneldoc/inc
 create mode 100644 scripts/atomic/kerneldoc/inc_and_test
 create mode 100644 scripts/atomic/kerneldoc/inc_not_zero
 create mode 100644 scripts/atomic/kerneldoc/inc_unless_negative
 create mode 100644 scripts/atomic/kerneldoc/or
 create mode 100644 scripts/atomic/kerneldoc/read
 create mode 100644 scripts/atomic/kerneldoc/set
 create mode 100644 scripts/atomic/kerneldoc/sub
 create mode 100644 scripts/atomic/kerneldoc/sub_and_test
 create mode 100644 scripts/atomic/kerneldoc/try_cmpxchg
 create mode 100644 scripts/atomic/kerneldoc/xchg
 create mode 100644 scripts/atomic/kerneldoc/xor

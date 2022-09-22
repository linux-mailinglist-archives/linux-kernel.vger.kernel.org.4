Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C14D15E606C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 13:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbiIVLF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 07:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbiIVLFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 07:05:19 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A6BD5890;
        Thu, 22 Sep 2022 04:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1663844382;
        bh=9PF0WUXMXJr4ttYYrn5/dDzZ2ytq5f5D8QAghnmoM+c=;
        h=From:To:Cc:Subject:Date:From;
        b=jNyaRej48gUWXI8j9oE4gbDoTTzz4+7KxYjeoUwxGWNpaZiXQ3Te4w6uPATKKimEg
         EB6EYgxwxZoxMq38DbQ22Q8zDOIy3rTSQXQuxchxJhJASIm2KaIL+4tTARnyxHORjG
         nJL2P9rnXyukJA7k/it47FSjm0s/SEMrzgmhkBd84oUK6OphEe8Adomi9+FFGU51sO
         u6zh5MC8Z6ogM3+D9Br+GiJ03ntOJXu8lWMK9jvhfHRtuQJ1t/WJrKPdeTcLLfaEin
         whIj5NzRPgp2ceXYlFgyyvAlwoMm3anqUVieM7Eb1DliWebkPdC7LVw1TQGBG/Qfe2
         +ZTlwKjs0uvRQ==
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4MYC3L0tXczNlJ;
        Thu, 22 Sep 2022 06:59:42 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
        Florian Weimer <fw@deneb.enyo.de>, David.Laight@ACULAB.COM,
        carlos@redhat.com, Peter Oskolkov <posk@posk.io>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH v4 00/25] RSEQ node id and virtual cpu id extensions
Date:   Thu, 22 Sep 2022 06:59:15 -0400
Message-Id: <20220922105941.237830-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend the rseq ABI to expose a NUMA node ID and a vm_vcpu_id field.

The NUMA node ID field allows implementing a faster getcpu(2) in libc.

The virtual cpu id allows ideal scaling (down or up) of user-space
per-cpu data structures. The virtual cpu ids allocated within a memory
space are tracked by the scheduler, which takes into account the number
of concurrently running threads, thus implicitly considering the number
of threads, the cpu affinity, the cpusets applying to those threads, and
the number of logical cores on the system.

This series is based on the v5.19 tag.

Thanks,

Mathieu

Mathieu Desnoyers (25):
  rseq: Introduce feature size and alignment ELF auxiliary vector
    entries
  rseq: Introduce extensible rseq ABI
  rseq: Extend struct rseq with numa node id
  selftests/rseq: Use ELF auxiliary vector for extensible rseq
  selftests/rseq: Implement rseq numa node id field selftest
  lib: Invert _find_next_bit source arguments
  lib: Implement find_{first,next}_{zero,one}_and_zero_bit
  cpumask: Implement cpumask_{first,next}_{zero,one}_and_zero
  sched: Introduce per memory space current virtual cpu id
  rseq: Extend struct rseq with per memory space vcpu id
  selftests/rseq: Remove RSEQ_SKIP_FASTPATH code
  selftests/rseq: Implement rseq vm_vcpu_id field support
  selftests/rseq: x86: Template memory ordering and percpu access mode
  selftests/rseq: arm: Template memory ordering and percpu access mode
  selftests/rseq: arm64: Template memory ordering and percpu access mode
  selftests/rseq: mips: Template memory ordering and percpu access mode
  selftests/rseq: ppc: Template memory ordering and percpu access mode
  selftests/rseq: s390: Template memory ordering and percpu access mode
  selftests/rseq: riscv: Template memory ordering and percpu access mode
  selftests/rseq: Implement basic percpu ops vm_vcpu_id test
  selftests/rseq: Implement parametrized vm_vcpu_id test
  selftests/rseq: x86: Implement rseq_load_u32_u32
  selftests/rseq: Implement numa node id vs vm_vcpu_id invariant test
  selftests/rseq: parametrized test: Report/abort on negative cpu id
  tracing/rseq: Add mm_vcpu_id field to rseq_update

 fs/binfmt_elf.c                               |    5 +
 fs/exec.c                                     |    6 +
 include/linux/cpumask.h                       |   86 ++
 include/linux/find.h                          |  123 +-
 include/linux/mm.h                            |   25 +
 include/linux/mm_types.h                      |  110 +-
 include/linux/sched.h                         |    9 +
 include/trace/events/rseq.h                   |    7 +-
 include/uapi/linux/auxvec.h                   |    2 +
 include/uapi/linux/rseq.h                     |   22 +
 init/Kconfig                                  |    4 +
 kernel/fork.c                                 |   11 +-
 kernel/ptrace.c                               |    2 +-
 kernel/rseq.c                                 |   61 +-
 kernel/sched/core.c                           |   49 +
 kernel/sched/sched.h                          |  166 +++
 kernel/signal.c                               |    2 +
 lib/find_bit.c                                |   17 +-
 tools/include/linux/find.h                    |    9 +-
 tools/lib/find_bit.c                          |   17 +-
 tools/testing/selftests/rseq/.gitignore       |    5 +
 tools/testing/selftests/rseq/Makefile         |   20 +-
 .../testing/selftests/rseq/basic_numa_test.c  |  117 ++
 .../selftests/rseq/basic_percpu_ops_test.c    |   46 +-
 tools/testing/selftests/rseq/basic_test.c     |    4 +
 tools/testing/selftests/rseq/compiler.h       |    6 +
 tools/testing/selftests/rseq/param_test.c     |  157 ++-
 tools/testing/selftests/rseq/rseq-abi.h       |   22 +
 tools/testing/selftests/rseq/rseq-arm-bits.h  |  505 +++++++
 tools/testing/selftests/rseq/rseq-arm.h       |  701 +---------
 .../testing/selftests/rseq/rseq-arm64-bits.h  |  392 ++++++
 tools/testing/selftests/rseq/rseq-arm64.h     |  520 +------
 .../testing/selftests/rseq/rseq-bits-reset.h  |   10 +
 .../selftests/rseq/rseq-bits-template.h       |   39 +
 tools/testing/selftests/rseq/rseq-mips-bits.h |  462 +++++++
 tools/testing/selftests/rseq/rseq-mips.h      |  646 +--------
 tools/testing/selftests/rseq/rseq-ppc-bits.h  |  454 +++++++
 tools/testing/selftests/rseq/rseq-ppc.h       |  617 +--------
 .../testing/selftests/rseq/rseq-riscv-bits.h  |  410 ++++++
 tools/testing/selftests/rseq/rseq-riscv.h     |  529 +-------
 tools/testing/selftests/rseq/rseq-s390-bits.h |  474 +++++++
 tools/testing/selftests/rseq/rseq-s390.h      |  495 +------
 tools/testing/selftests/rseq/rseq-skip.h      |   65 -
 tools/testing/selftests/rseq/rseq-x86-bits.h  | 1036 ++++++++++++++
 tools/testing/selftests/rseq/rseq-x86.h       | 1193 +----------------
 tools/testing/selftests/rseq/rseq.c           |   86 +-
 tools/testing/selftests/rseq/rseq.h           |  229 +++-
 .../testing/selftests/rseq/run_param_test.sh  |    5 +
 48 files changed, 5286 insertions(+), 4692 deletions(-)
 create mode 100644 tools/testing/selftests/rseq/basic_numa_test.c
 create mode 100644 tools/testing/selftests/rseq/rseq-arm-bits.h
 create mode 100644 tools/testing/selftests/rseq/rseq-arm64-bits.h
 create mode 100644 tools/testing/selftests/rseq/rseq-bits-reset.h
 create mode 100644 tools/testing/selftests/rseq/rseq-bits-template.h
 create mode 100644 tools/testing/selftests/rseq/rseq-mips-bits.h
 create mode 100644 tools/testing/selftests/rseq/rseq-ppc-bits.h
 create mode 100644 tools/testing/selftests/rseq/rseq-riscv-bits.h
 create mode 100644 tools/testing/selftests/rseq/rseq-s390-bits.h
 delete mode 100644 tools/testing/selftests/rseq/rseq-skip.h
 create mode 100644 tools/testing/selftests/rseq/rseq-x86-bits.h

-- 
2.25.1


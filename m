Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F06B63486C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 21:39:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234900AbiKVUjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 15:39:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234320AbiKVUjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 15:39:47 -0500
X-Greylist: delayed 89243 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 22 Nov 2022 12:39:45 PST
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F49D6B389;
        Tue, 22 Nov 2022 12:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1669149584;
        bh=NMAzq6XfftXBO/HcXtHhXgm94OkSYYLzbKGIA8GTwns=;
        h=From:To:Cc:Subject:Date:From;
        b=HNJIv2GjMVFd9tDS8gYrOg891v+d73j3fKDi3kX4ZtGeQksXPxrrtu2eoZ/vDzyqn
         iCBHEj6eYWyhaqjgfG1yp5W1vIVzs3f6pKcuQ5JLvF9na0NZAcMj5Hc8SSePQB5CDi
         a0NT2fao5Nc/6DRUUJPrBsgmNLLauhZuLM6VXLDvlQxsFYE6ily5ShWquJB77fqCL/
         TYXS1E1+QVkLHhFigwHNWZFqz8VCmJFoiSiQY5vTw6x8YpGwqyN279ZHQIu3GP8wRI
         o0EmXOFxJTZEQlzz+DDPOWs3c5qgO49IauUCIBKftztTIpoiOYTH+Za4XQEZR8pQfS
         zbTnUwcnW8W8Q==
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4NGx2S1mzgzXDR;
        Tue, 22 Nov 2022 15:39:44 -0500 (EST)
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
        Chris Kennelly <ckennelly@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH 00/30] RSEQ node id and mm concurrency id extensions
Date:   Tue, 22 Nov 2022 15:39:02 -0500
Message-Id: <20221122203932.231377-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend the rseq ABI to expose NUMA node ID, mm_cid, and mm_numa_cid
fields.

The NUMA node ID field allows implementing a faster getcpu(2) in libc.

The per-memory-map concurrency id (mm_cid) [1] allows ideal scaling
(down or up) of user-space per-cpu data structures. The concurrency ids
allocated within a memory map are tracked by the scheduler, which takes
into account the number of concurrently running threads, thus implicitly
considering the number of threads, the cpu affinity, the cpusets
applying to those threads, and the number of logical cores on the
system.

The NUMA-aware concurrency id (mm_numa_cid) is similar to the mm_cid,
except that it keeps track of the NUMA node ids with which each cid has
been associated. On NUMA systems, when a NUMA-aware concurrency ID is
observed by user-space to be associated with a NUMA node, it is
guaranteed to never change NUMA node unless a kernel-level NUMA
configuration change happens. This is useful for NUMA-aware per-cpu data
structures running in environments where a process or a set of processes
belonging to cpuset are pinned to a set of cores which belong to a
subset of the system's NUMA nodes.

This series is based on tip/sched/core
commit 52b33d87b9197 ("sched/psi: Use task->psi_flags to clear in CPU migration")

Thanks,

Mathieu

[1] was previously known as vcpu_id in earlier versions of this patch set.

Mathieu Desnoyers (30):
  selftests/rseq: Fix: Fail thread registration when CONFIG_RSEQ=n
  rseq: Introduce feature size and alignment ELF auxiliary vector
    entries
  rseq: Introduce extensible rseq ABI
  rseq: Extend struct rseq with numa node id
  selftests/rseq: Use ELF auxiliary vector for extensible rseq
  selftests/rseq: Implement rseq numa node id field selftest
  sched: Introduce per-memory-map concurrency ID
  rseq: Extend struct rseq with per-memory-map concurrency ID
  selftests/rseq: Remove RSEQ_SKIP_FASTPATH code
  selftests/rseq: Implement rseq mm_cid field support
  selftests/rseq: x86: Template memory ordering and percpu access mode
  selftests/rseq: arm: Template memory ordering and percpu access mode
  selftests/rseq: arm64: Template memory ordering and percpu access mode
  selftests/rseq: mips: Template memory ordering and percpu access mode
  selftests/rseq: ppc: Template memory ordering and percpu access mode
  selftests/rseq: s390: Template memory ordering and percpu access mode
  selftests/rseq: riscv: Template memory ordering and percpu access mode
  selftests/rseq: Implement basic percpu ops mm_cid test
  selftests/rseq: Implement parametrized mm_cid test
  selftests/rseq: parametrized test: Report/abort on negative
    concurrency ID
  tracing/rseq: Add mm_cid field to rseq_update
  lib: Implement find_{first,next,nth}_notandnot_bit,
    find_first_andnot_bit
  cpumask: Implement cpumask_{first,next}_{not,}andnot
  sched: NUMA-aware per-memory-map concurrency ID
  rseq: Extend struct rseq with per-memory-map NUMA-aware Concurrency ID
  selftests/rseq: x86: Implement rseq_load_u32_u32
  selftests/rseq: Implement mm_numa_cid accessors in headers
  selftests/rseq: Implement numa node id vs mm_numa_cid invariant test
  selftests/rseq: Implement mm_numa_cid tests
  tracing/rseq: Add mm_numa_cid field to rseq_update

 fs/binfmt_elf.c                               |    5 +
 fs/exec.c                                     |    4 +
 include/linux/cpumask.h                       |   60 +
 include/linux/find.h                          |  123 +-
 include/linux/mm.h                            |   43 +
 include/linux/mm_types.h                      |  109 +-
 include/linux/sched.h                         |   12 +
 include/trace/events/rseq.h                   |    9 +-
 include/uapi/linux/auxvec.h                   |    2 +
 include/uapi/linux/rseq.h                     |   31 +
 init/Kconfig                                  |    4 +
 kernel/fork.c                                 |   11 +-
 kernel/ptrace.c                               |    2 +-
 kernel/rseq.c                                 |   73 +-
 kernel/sched/core.c                           |   49 +
 kernel/sched/sched.h                          |  192 +++
 kernel/signal.c                               |    2 +
 lib/find_bit.c                                |   42 +
 tools/testing/selftests/rseq/.gitignore       |    9 +
 tools/testing/selftests/rseq/Makefile         |   34 +-
 .../testing/selftests/rseq/basic_numa_test.c  |  117 ++
 .../selftests/rseq/basic_percpu_ops_test.c    |   58 +-
 tools/testing/selftests/rseq/basic_test.c     |    4 +
 tools/testing/selftests/rseq/compiler.h       |    6 +
 tools/testing/selftests/rseq/param_test.c     |  181 ++-
 tools/testing/selftests/rseq/rseq-abi.h       |   31 +
 tools/testing/selftests/rseq/rseq-arm-bits.h  |  505 +++++++
 tools/testing/selftests/rseq/rseq-arm.h       |  707 +---------
 .../testing/selftests/rseq/rseq-arm64-bits.h  |  392 ++++++
 tools/testing/selftests/rseq/rseq-arm64.h     |  532 +-------
 .../testing/selftests/rseq/rseq-bits-reset.h  |   11 +
 .../selftests/rseq/rseq-bits-template.h       |   51 +
 tools/testing/selftests/rseq/rseq-mips-bits.h |  462 +++++++
 tools/testing/selftests/rseq/rseq-mips.h      |  652 +--------
 tools/testing/selftests/rseq/rseq-ppc-bits.h  |  454 +++++++
 tools/testing/selftests/rseq/rseq-ppc.h       |  629 +--------
 .../testing/selftests/rseq/rseq-riscv-bits.h  |  410 ++++++
 tools/testing/selftests/rseq/rseq-riscv.h     |  541 +-------
 tools/testing/selftests/rseq/rseq-s390-bits.h |  474 +++++++
 tools/testing/selftests/rseq/rseq-s390.h      |  501 +------
 tools/testing/selftests/rseq/rseq-skip.h      |   65 -
 tools/testing/selftests/rseq/rseq-x86-bits.h  | 1036 ++++++++++++++
 tools/testing/selftests/rseq/rseq-x86.h       | 1204 +----------------
 tools/testing/selftests/rseq/rseq.c           |   91 +-
 tools/testing/selftests/rseq/rseq.h           |  258 +++-
 .../testing/selftests/rseq/run_param_test.sh  |    5 +
 46 files changed, 5532 insertions(+), 4661 deletions(-)
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


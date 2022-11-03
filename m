Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8EC61893F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 21:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbiKCUFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 16:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbiKCUE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 16:04:58 -0400
X-Greylist: delayed 111496 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 03 Nov 2022 13:04:56 PDT
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71EBA1402E;
        Thu,  3 Nov 2022 13:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1667505895;
        bh=JEwuruCzX8OqiQJkSoNdaMaRC2YnfdyQAI0GUeVuJFU=;
        h=From:To:Cc:Subject:Date:From;
        b=L1I7Wydzu6HA9+hmquJE3oaNH9nVsh6wlNwsrBPO4OO3q3N9rZ1dEj1qJqXyU6vd5
         TrsqvjUf8pTcE5flwRdhVrxpMJLjv9eowXFb6rr5gi80Yu9YtxSikkL54oYYn5pv39
         +7mjQkYBP21BgLZTCjLBk+3+bKMovX76m9Yv/pb0CIE816crc70kUAdKjjE8EoU9tl
         iN7U13/2bFsE6VRivLHuoRZLrIKByBEiU2/q4I/v+yT2ENMfN5od9AyW26YeMYyBox
         egvL4onMm4pZAW94kA6sxdKFIvM8LoXIGw3oC9s8b0RM8QYQPc3ypsakCj/ndEe2Fc
         xfiyQ2Q+d22Vw==
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4N3F926TtQzfnq;
        Thu,  3 Nov 2022 16:04:54 -0400 (EDT)
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
Subject: [PATCH v5 00/24] RSEQ node id and virtual cpu id extensions
Date:   Thu,  3 Nov 2022 16:03:35 -0400
Message-Id: <20221103200359.328736-1-mathieu.desnoyers@efficios.com>
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

This series is based on tip/sched/core
commit 52b33d87b9197 ("sched/psi: Use task->psi_flags to clear in CPU migration")

Thanks,

Mathieu

Mathieu Desnoyers (24):
  rseq: Introduce feature size and alignment ELF auxiliary vector
    entries
  rseq: Introduce extensible rseq ABI
  rseq: Extend struct rseq with numa node id
  selftests/rseq: Use ELF auxiliary vector for extensible rseq
  selftests/rseq: Implement rseq numa node id field selftest
  lib: Implement find_{first,next,nth}_notandnot_bit,
    find_first_andnot_bit
  cpumask: Implement cpumask_{first,next}_{not,}andnot
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
 include/linux/cpumask.h                       |   60 +
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
 kernel/rseq.c                                 |   65 +-
 kernel/sched/core.c                           |   52 +
 kernel/sched/sched.h                          |  168 +++
 kernel/signal.c                               |    2 +
 lib/find_bit.c                                |   42 +
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
 .../testing/selftests/rseq/rseq-bits-reset.h  |   11 +
 .../selftests/rseq/rseq-bits-template.h       |   41 +
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
 46 files changed, 5294 insertions(+), 4669 deletions(-)
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


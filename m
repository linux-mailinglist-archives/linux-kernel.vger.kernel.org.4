Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15AE65BFE7D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 14:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbiIUMzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 08:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbiIUMzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 08:55:16 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E476E4A104;
        Wed, 21 Sep 2022 05:55:13 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MXdZK2CM9z14RgH;
        Wed, 21 Sep 2022 20:51:05 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 21 Sep 2022 20:55:09 +0800
Received: from ubuntu1804.huawei.com (10.67.175.36) by
 dggpemm500013.china.huawei.com (7.185.36.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 21 Sep 2022 20:55:09 +0800
From:   Chen Zhongjin <chenzhongjin@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-perf-users@vger.kernel.org>
CC:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <peterz@infradead.org>,
        <mingo@redhat.com>, <acme@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <namhyung@kernel.org>,
        <jolsa@kernel.org>, <guoren@kernel.org>, <frederic@kernel.org>,
        <vincent.chen@sifive.com>, <ardb@kernel.org>,
        <mhiramat@kernel.org>, <rostedt@goodmis.org>,
        <keescook@chromium.org>, <catalin.marinas@arm.com>,
        <chenzhongjin@huawei.com>
Subject: [PATCH for-next v2 0/4] riscv: Improvments for stacktrace
Date:   Wed, 21 Sep 2022 20:51:23 +0800
Message-ID: <20220921125128.33913-1-chenzhongjin@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.36]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the stacktrace with FRAME_POINTER on riscv has some problem:

1. stacktrace will stop at irq so it can't get the stack frames before
irq entry.
2. stacktrace can't unwind all the real stack frames when there is
k{ret}probes or ftrace.

These are mainly becase when there is a pt_regs on stack, we can't unwind
the stack frame as normal function.

Some architectures (e.g. arm64) create a extra stackframe inside pt_regs.
However this doesn't work for riscv because the ra is not ensured to be
pushed to stack. As explained in:
commit f766f77a74f5("riscv/stacktrace: Fix stack output without ra on the stack top")

So, I choosed the method of x86 that, if there is a pt_regs on stack,
we encoded the frame pointer and save it. When unwinding stack frame,
we can get pt_regs and registers required for unwinding stacks.

In addition, the patch set contains some refactoring of stacktrace.c to
keep the stacktrace code on riscv consistent with other architectures.

Stacktrace before for kretprobes:

  Call Trace:
  ...
  [<ffffffff800d5d48>] __kretprobe_trampoline_handler+0xc2/0x13e
  [<ffffffff808b766c>] trampoline_probe_handler+0x30/0x46
  [<ffffffff800070de>] __kretprobe_trampoline+0x52/0x92
  [<ffffffff0163809c>] kprobe_init+0x9c/0x1000 [kprobe_unwind]
  [<ffffffff800027c8>] do_one_initcall+0x4c/0x1f2
  ...

Stacktrace after:

  Call Trace:
  ...
  [<ffffffff800d5d48>] __kretprobe_trampoline_handler+0xc2/0x13e
  [<ffffffff808b766c>] trampoline_probe_handler+0x30/0x46
  [<ffffffff800070de>] __kretprobe_trampoline+0x52/0x92
+ [<ffffffff01633076>] the_caller+0x2c/0x38 [kprobe_unwind]
  [<ffffffff0163809c>] kprobe_init+0x9c/0x1000 [kprobe_unwind]
  [<ffffffff800027c8>] do_one_initcall+0x4c/0x1f2
  ...

Stacktrace before for ftrace:

  Call Trace:
  ...
  [<ffffffff80006df0>] kprobe_ftrace_handler+0x13e/0x188
  [<ffffffff80008e7e>] ftrace_regs_call+0x8/0x10
  [<ffffffff80002540>] do_one_initcall+0x4c/0x1f2
  [<ffffffff8008a4e6>] do_init_module+0x56/0x210
  ...

  Stacktrace after:

  Call Trace:
  ...
  [<ffffffff016150e0>] handler_pre+0x30/0x4a [kprobe_unwind]
  [<ffffffff800bce96>] aggr_pre_handler+0x60/0x94
  [<ffffffff80006df0>] kprobe_ftrace_handler+0x13e/0x188
  [<ffffffff80008e82>] ftrace_regs_call+0x8/0x10
+ [<ffffffff01615000>] traced_func+0x0/0x1e [kprobe_unwind]
  [<ffffffff80002540>] do_one_initcall+0x4c/0x1f2
  [<ffffffff8008a4ea>] do_init_module+0x56/0x210
  ...

Noticed that the caller of ftrace and probed func of kretprobe
cannot be unwind because they are inside function pro/epilogue.

---
v1 -> v2:
- Merge three patches which add ENCODE_FRAME_POINTER together
- Update commit message
- Delete the KRETPORBES stuff added in unwind_state, we don't need them
to recover the kretporbes ret_addr because we can get it in pt_regs
---
Chen Zhongjin (4):
  riscv: stacktrace: Replace walk_stackframe with arch_stack_walk
  riscv: stacktrace: Introduce unwind functions
  riscv: stacktrace: Save pt_regs in ENCODE_FRAME_POINTER
  riscv: stacktrace: Implement stacktrace for irq

 arch/riscv/include/asm/frame.h                |  45 ++++++
 arch/riscv/include/asm/stacktrace.h           |   9 +-
 arch/riscv/kernel/entry.S                     |   3 +
 arch/riscv/kernel/mcount-dyn.S                |   7 +
 arch/riscv/kernel/perf_callchain.c            |   2 +-
 arch/riscv/kernel/probes/kprobes_trampoline.S |   7 +
 arch/riscv/kernel/stacktrace.c                | 150 ++++++++++++------
 7 files changed, 174 insertions(+), 49 deletions(-)
 create mode 100644 arch/riscv/include/asm/frame.h

-- 
2.17.1


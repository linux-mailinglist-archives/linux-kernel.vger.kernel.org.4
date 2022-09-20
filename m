Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BEED5BE9E0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 17:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbiITPQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 11:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbiITPPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 11:15:51 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316305AC72;
        Tue, 20 Sep 2022 08:15:49 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MX4kz4rknzlW0y;
        Tue, 20 Sep 2022 23:11:39 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 20 Sep 2022 23:15:45 +0800
Received: from ubuntu1804.huawei.com (10.67.175.36) by
 dggpemm500013.china.huawei.com (7.185.36.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 20 Sep 2022 23:15:45 +0800
From:   Chen Zhongjin <chenzhongjin@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-perf-users@vger.kernel.org>
CC:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <peterz@infradead.org>,
        <mingo@redhat.com>, <acme@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <namhyung@kernel.org>,
        <jolsa@kernel.org>, <guoren@kernel.org>, <nsaenzju@redhat.com>,
        <frederic@kernel.org>, <changbin.du@intel.com>,
        <vincent.chen@sifive.com>, <ardb@kernel.org>,
        <mhiramat@kernel.org>, <rostedt@goodmis.org>,
        <keescook@chromium.org>, <catalin.marinas@arm.com>,
        <chenzhongjin@huawei.com>
Subject: [PATCH -next 0/7] riscv: Improvments for stacktrace
Date:   Tue, 20 Sep 2022 23:11:55 +0800
Message-ID: <20220920151202.180057-1-chenzhongjin@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.36]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

Chen Zhongjin (7):
  riscv: stacktrace: Replace walk_stackframe with arch_stack_walk
  riscv: stacktrace: Introduce unwind functions
  riscv: stacktrace: Save pt_regs in encoded fp on irq entry
  riscv: syscall: Don't clobber s0 when syscall
  riscv: stacktrace: Implement stacktrace for irq
  riscv: stacktrace: Fix unwinding on ftrace_regs_call
  riscv: stacktrace: Fix unwinding on __kretporbe_trampoline

 arch/riscv/include/asm/frame.h                |  45 +++++
 arch/riscv/include/asm/stacktrace.h           |  13 +-
 arch/riscv/kernel/entry.S                     |  23 +--
 arch/riscv/kernel/mcount-dyn.S                |   8 +
 arch/riscv/kernel/perf_callchain.c            |   2 +-
 arch/riscv/kernel/probes/kprobes_trampoline.S |   8 +
 arch/riscv/kernel/stacktrace.c                | 155 ++++++++++++------
 7 files changed, 195 insertions(+), 59 deletions(-)
 create mode 100644 arch/riscv/include/asm/frame.h

-- 
2.17.1


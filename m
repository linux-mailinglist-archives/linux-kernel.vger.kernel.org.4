Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E887469A3F8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 03:38:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbjBQCh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 21:37:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjBQCh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 21:37:57 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4E6FC93D3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 18:37:55 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8Bxy5eC6O5jqpoBAA--.803S3;
        Fri, 17 Feb 2023 10:37:54 +0800 (CST)
Received: from localhost.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxPuR+6O5jRPk0AA--.63243S2;
        Fri, 17 Feb 2023 10:37:50 +0800 (CST)
From:   Qing Zhang <zhangqing@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        WANG Xuerui <kernel@xen0n.name>
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/3] LoongArch: Add hardware breakpoints/watchpoints support
Date:   Fri, 17 Feb 2023 10:37:42 +0800
Message-Id: <20230217023745.20800-1-zhangqing@loongson.cn>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxPuR+6O5jRPk0AA--.63243S2
X-CM-SenderInfo: x2kd0wptlqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoWxZry8uw1DKF1fKF4fAr13urg_yoW5Zw1kpF
        ZFkrn5Kr4DKrWfZwsxtw4xur1fGF1xGrW2qa12y34aywnFqr1Fqw4vkryqqa45Aw4rJ340
        qr1rWF4Fga4UAaUanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        b3AYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        n4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6x
        ACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E
        87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82
        IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2Iq
        xVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r
        126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY
        6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67
        AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuY
        vjxU4AhLUUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use perf framework to manage hardware instruction and data breakpoints.
LoongArch defines hardware watchpoint functions for instruction fetch
and load/store operations, after the software configures hardware watchpoints
for instruction fetch and load/store operations. The processor hardware will
monitor the access address of the instruction fetch and load/store operation,
and will trigger the exception of the watchpoint when it meets the conditions
set by the watchpoint.

The hardware monitoring points for instruction fetching and load/store operations
each have a register for the overall configuration of all monitoring points,
a register for recording the status of all monitoring points, and four registers
required for configuration of each watchpoint individually.

Watchpoint related control status register chapters:
https://github.com/loongson/LoongArch-Documentation/releases/download/2022.08.12/
LoongArch-Vol1-v1.02-CN.pdf

Initial version has the following limitations:
- no support for virtualization

Can be tested: e.g.
1. see samples/hw_breakpoint and register_wide_hw_breakpoint.
2. ptrace(PTRACE_SINGLESTEP/..., pid, NULL, NULL)
3. ptrace (PTRACE_SETREGSET, tid, ... , ...)

TODO:
- Add hardware breakpoints/watchpoints for gdb, kgdb

Changes v1 -> v2:
Suggested by Huacai:
- Use irqentry_enter()/irqentry_exit() instead of
  exception_enter()/exception_exit().
- Add ptrace interface to expose hw-breakpoints to debuggers.
- Use 2022-2023.
- Some other changes.

Changes v2 -> v3:
Suggested by Jinyang:
- get_num_brps/wrps, decode/encode_ctrl_reg which the function
  returns directly.
- Remove irrelevant content from the first patch.
- Use macros to avoid using magic values directly.
- Add new arg to indicate it is breakpoint or watchpoint
  to avoid function coupling.
- Remove redundant tab.
- Modify the breakpoint/watchpoint_handler function type to void.
- Some other changes.

Changes v3 -> v4:
Suggested by Jinyang:
- Add judgment prevent rd == pc from causing single step to fail to stop.
- Add code comments to improve readability.
- Use macros in csr_write32.

Qing Zhang (3):
  LoongArch: Add hardware breakpoints/watchpoints support
  LoongArch: Add ptrace single step support
  LoongArch: ptrace: expose hardware breakpoints to debuggers

 arch/loongarch/Kconfig                     |   1 +
 arch/loongarch/include/asm/hw_breakpoint.h | 145 ++++++
 arch/loongarch/include/asm/inst.h          |  39 ++
 arch/loongarch/include/asm/loongarch.h     |  35 +-
 arch/loongarch/include/asm/processor.h     |  14 +-
 arch/loongarch/include/asm/ptrace.h        |   2 +
 arch/loongarch/include/asm/switch_to.h     |   1 +
 arch/loongarch/include/uapi/asm/ptrace.h   |   9 +
 arch/loongarch/kernel/Makefile             |   1 +
 arch/loongarch/kernel/hw_breakpoint.c      | 544 +++++++++++++++++++++
 arch/loongarch/kernel/process.c            |   7 +
 arch/loongarch/kernel/ptrace.c             | 484 ++++++++++++++++++
 arch/loongarch/kernel/traps.c              |  38 +-
 include/uapi/linux/elf.h                   |   2 +
 14 files changed, 1301 insertions(+), 21 deletions(-)
 create mode 100644 arch/loongarch/include/asm/hw_breakpoint.h
 create mode 100644 arch/loongarch/kernel/hw_breakpoint.c

-- 
2.36.0


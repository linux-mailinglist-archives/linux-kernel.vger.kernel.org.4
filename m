Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F301629037
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 03:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237649AbiKOC5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 21:57:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232429AbiKOC4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 21:56:50 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2F6701EAD8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 18:55:29 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8Axbdqg_3JjYB8HAA--.21319S3;
        Tue, 15 Nov 2022 10:55:28 +0800 (CST)
Received: from localhost.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxLuKf_3JjmywTAA--.51398S2;
        Tue, 15 Nov 2022 10:55:27 +0800 (CST)
From:   Qing Zhang <zhangqing@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/9] LoongArch: Add ftrace support
Date:   Tue, 15 Nov 2022 10:55:18 +0800
Message-Id: <20221115025527.13382-1-zhangqing@loongson.cn>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxLuKf_3JjmywTAA--.51398S2
X-CM-SenderInfo: x2kd0wptlqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoWxXFyDuw4UKr1ruw17XF1UZFb_yoWrJrWDpr
        W3ZFn3Gr4UCFs3twnxK34rurn5Ar1xCryaq3ZxJryrCr47Zr1UXw1ktrykXa45t393Gry0
        qF1rWw42gF4qva7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        b7AYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2
        IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4U
        McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2
        IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
        6r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
        AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IY
        s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr
        0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8r9N3UUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series to support basic and dynamic ftrace.

1) -pg
Use `-pg` makes stub like a child function `void _mcount(void *ra)`.
Thus, it can be seen store RA and open stack before `call _mcount`.
Find `open stack` at first, and then find `store RA`.

2) -fpatchable-function-entry=2
The compiler has inserted 2 NOPs before the regular function prologue.
T series registers are available and safe because of LoongArch psABI.

At runtime, replace nop with bl to enable ftrace call and replace bl with
nop to disable ftrace call. The bl requires us to save the original RA value,
so here it saves RA at t0.
details are:

| Compiled   |       Disabled         |        Enabled         |
+------------+------------------------+------------------------+
| nop        | move     t0, ra        | move     t0, ra        |
| nop        | nop                    | bl      ftrace_caller  |
| func_body  | func_body              | func_body              |

The RA value will be recovered by ftrace_regs_entry, and restored into RA
before returning to the regular function prologue. When a function is not
being traced, the move t0, ra is not harmful.

performs a series of startup tests on ftrace and The test cases in selftests
has passed on LoongArch.

Changes in v2:
 - Remove patch "LoongArch: ftrace: Add CALLER_ADDRx macros" there are other
   better ways
 Suggested by Steve:
 - Add HAVE_DYNAMIC_FTRACE_WITH_ARGS support (6/10)
 Suggested by Jinyang:
 - Change addu16id to lu12iw and Adjust module_finalize return value (7/10)
 - Use the "jr" pseudo-instruction where applicable (1/10)
 - Use the "la.pcrel" instead of "la" (3/10)

Changes in v3:
 Reported by Jeff:
 - Fix unwind state when option func_stack_trace (10/10)

Changes in v4:
 - No comments. Just resend the series.
 - Rebased onto v6.0.0-rc4.

Changes in v5:
 - Modify the indentation of Kconfig and small changes

Changes in v6:
 Suggested by Huacai:
 - Adjusting the patch Sequence
 - renamed mcount-dyn.S for consistency

Qing Zhang (9):
  LoongArch/ftrace: Add basic support
  LoongArch/ftrace: Add recordmcount support
  LoongArch/ftrace: Add dynamic function tracer support
  LoongArch/ftrace: Add dynamic function graph tracer support
  LoongArch/ftrace: Add DYNAMIC_FTRACE_WITH_REGS support
  LoongArch/ftrace: Add HAVE_DYNAMIC_FTRACE_WITH_ARGS support
  LoongArch/ftrace: Add HAVE_FUNCTION_GRAPH_RET_ADDR_PTR support
  LoongArch: modules/ftrace: Initialize PLT at load time
  LoongArch: Enable CONFIG_KALLSYMS_ALL and CONFIG_DEBUG_FS

 arch/loongarch/Kconfig                     |   7 +
 arch/loongarch/Makefile                    |   5 +
 arch/loongarch/configs/loongson3_defconfig |   2 +
 arch/loongarch/include/asm/ftrace.h        |  61 +++++
 arch/loongarch/include/asm/inst.h          |  18 ++
 arch/loongarch/include/asm/module.h        |   5 +-
 arch/loongarch/include/asm/module.lds.h    |   1 +
 arch/loongarch/include/asm/unwind.h        |   3 +-
 arch/loongarch/kernel/Makefile             |  13 +
 arch/loongarch/kernel/ftrace.c             |  74 ++++++
 arch/loongarch/kernel/ftrace_dyn.c         | 264 +++++++++++++++++++++
 arch/loongarch/kernel/inst.c               | 127 ++++++++++
 arch/loongarch/kernel/mcount-dyn.S         | 154 ++++++++++++
 arch/loongarch/kernel/mcount.S             |  94 ++++++++
 arch/loongarch/kernel/module-sections.c    |  11 +
 arch/loongarch/kernel/module.c             |  22 ++
 arch/loongarch/kernel/unwind_guess.c       |   4 +-
 arch/loongarch/kernel/unwind_prologue.c    |  46 +++-
 scripts/recordmcount.c                     |  23 ++
 19 files changed, 924 insertions(+), 10 deletions(-)
 create mode 100644 arch/loongarch/include/asm/ftrace.h
 create mode 100644 arch/loongarch/kernel/ftrace.c
 create mode 100644 arch/loongarch/kernel/ftrace_dyn.c
 create mode 100644 arch/loongarch/kernel/mcount-dyn.S
 create mode 100644 arch/loongarch/kernel/mcount.S

-- 
2.36.0


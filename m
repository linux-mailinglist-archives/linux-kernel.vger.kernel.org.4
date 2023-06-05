Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B571721E43
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 08:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjFEGjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 02:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjFEGjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 02:39:18 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 13945E9
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jun 2023 23:39:14 -0700 (PDT)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8AxcPAPg31k7wUAAA--.234S3;
        Mon, 05 Jun 2023 14:39:11 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Axa9YPg31kHQcAAA--.72S2;
        Mon, 05 Jun 2023 14:39:11 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
Subject: [PATCH v5 0/6] Add uprobes support for LoongArch
Date:   Mon,  5 Jun 2023 14:39:04 +0800
Message-Id: <1685947150-4949-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf8Axa9YPg31kHQcAAA--.72S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7KrW8XF48Gr1kKr18CF4Dtrc_yoW8ZF18pF
        srurnxGr45GryfXrZxta43ur1Fyr48GrW2qFnxC34rAw4jqF15Xr18KrZ8CF98t3y5Kry0
        qF1rG3yYga15A3cCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
        8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AK
        xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
        vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
        jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2I
        x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK
        8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
        0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j1WlkUUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v5:
  -- Rebased on 6.4rc5
  -- Like arm64, add user_enable_single_step() in arch_uprobe_pre_xol(),
     add user_disable_single_step() in arch_uprobe_{post,abort}_xol(),
     suggested by Jeff and Huacai offline

v4:
  -- Rebased on 6.4rc1
  -- Fix problem about "perf probe -x /lib64/libc.so.6 malloc"

v3:
  -- Check atomic instructions in insns_not_supported()
  -- Remove five DIE_* definitions in kdebug.h

v2:
  -- Move the functions to inst.c in patch #1
  -- Pass around union for insns_not_supported(),
     insns_need_simulation() and arch_simulate_insn()

v1:
  -- Split the RFC patch #2 into two patches
  -- Use larch_insn_gen_break() to generate break insns
     for kprobes and uprobes
  -- Pass around instruction word instead of union for
     insns_not_supported(), insns_need_simulation() and
     arch_simulate_insn() to avoid type conversion for callers
  -- Add a simple test case for uprobes in the commit message

Tiezhu Yang (6):
  LoongArch: Move three functions from kprobes.c to inst.c
  LoongArch: Add larch_insn_gen_break() to generate break insns
  LoongArch: Use larch_insn_gen_break() for kprobes
  LoongArch: Add uprobes support
  LoongArch: Check atomic instructions in insns_not_supported()
  LoongArch: Remove five DIE_* definitions in kdebug.h

 arch/loongarch/Kconfig               |   3 +
 arch/loongarch/include/asm/inst.h    |  42 ++++++++++
 arch/loongarch/include/asm/kdebug.h  |   5 --
 arch/loongarch/include/asm/kprobes.h |   2 +-
 arch/loongarch/include/asm/uprobes.h |  35 ++++++++
 arch/loongarch/kernel/Makefile       |   1 +
 arch/loongarch/kernel/inst.c         |  54 +++++++++++++
 arch/loongarch/kernel/kprobes.c      |  75 ++++-------------
 arch/loongarch/kernel/traps.c        |   9 +--
 arch/loongarch/kernel/uprobes.c      | 152 +++++++++++++++++++++++++++++++++++
 10 files changed, 306 insertions(+), 72 deletions(-)
 create mode 100644 arch/loongarch/include/asm/uprobes.h
 create mode 100644 arch/loongarch/kernel/uprobes.c

-- 
2.1.0


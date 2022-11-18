Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 214A362ED69
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 07:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241034AbiKRGFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 01:05:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiKRGFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 01:05:23 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E6EBD98255
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 22:05:21 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8Cxq9igIHdjpIcIAA--.23920S3;
        Fri, 18 Nov 2022 14:05:20 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Dx9VagIHdjT1sWAA--.40305S2;
        Fri, 18 Nov 2022 14:05:20 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/4] Add kprobe and kretprobe support for LoongArch
Date:   Fri, 18 Nov 2022 14:05:10 +0800
Message-Id: <1668751514-2998-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf8Dx9VagIHdjT1sWAA--.40305S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoWxJr4xtw4UKr43Ar4xAw4xZwb_yoW8WF47pF
        9rZrn5Gr4rGwn3Jr9xt3WUur1ftw18C3y2ga17try8C3W7XryUArs3KrZxXasYkwsIqr1S
        qr1rW3yYgFyxJa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        b7AYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2
        IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4U
        McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2
        IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
        6r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
        AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IY
        s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr
        0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8j-e5UUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v4:
  -- Remove kprobe_exceptions_notify() in kprobes.c
  -- Call kprobe_breakpoint_handler() and kprobe_singlestep_handler()
     in do_bp()

v3:
  -- Rebase on the latest code
  -- Check the alignment of PC in simu_branch() and simu_pc()
  -- Add ibar in flush_insn_slot()
  -- Rename kprobe_{pre,post}_handler() to {post_}kprobe_handler
  -- Add preempt_disable() and preempt_enable_no_resched()
  -- Remove r0 save/restore and do some minor changes
     in kprobes_trampoline.S
  -- Do not enable CONFIG_KPROBES by default

v2:
  -- Split simu_branch() and simu_pc() into a single patch
  -- Call kprobe_page_fault() in do_page_fault()
  -- Add kprobes_trampoline.S for kretprobe

Tiezhu Yang (4):
  LoongArch: Simulate branch and PC instructions
  LoongArch: Add kprobe support
  LoongArch: Add kretprobe support
  samples/kprobes: Add LoongArch support

 arch/loongarch/Kconfig                     |   2 +
 arch/loongarch/include/asm/inst.h          |  22 ++
 arch/loongarch/include/asm/kprobes.h       |  54 +++++
 arch/loongarch/include/asm/ptrace.h        |   1 +
 arch/loongarch/kernel/Makefile             |   2 +
 arch/loongarch/kernel/inst.c               | 123 +++++++++++
 arch/loongarch/kernel/kprobes.c            | 325 +++++++++++++++++++++++++++++
 arch/loongarch/kernel/kprobes_trampoline.S |  96 +++++++++
 arch/loongarch/kernel/traps.c              |   6 +-
 arch/loongarch/mm/fault.c                  |   4 +
 samples/kprobes/kprobe_example.c           |   8 +
 11 files changed, 639 insertions(+), 4 deletions(-)
 create mode 100644 arch/loongarch/include/asm/kprobes.h
 create mode 100644 arch/loongarch/kernel/kprobes.c
 create mode 100644 arch/loongarch/kernel/kprobes_trampoline.S

-- 
2.1.0


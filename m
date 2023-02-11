Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91F9269303A
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 12:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjBKLQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 06:16:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjBKLQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 06:16:37 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1323830B0D
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 03:16:34 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8BxZ+kReedjsD0RAA--.29203S3;
        Sat, 11 Feb 2023 19:16:33 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxHuQQeedjzBIxAA--.55352S2;
        Sat, 11 Feb 2023 19:16:33 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
Subject: [PATCH] LoongArch: Only call get_timer_irq() once in constant_clockevent_init()
Date:   Sat, 11 Feb 2023 19:16:31 +0800
Message-Id: <1676114191-13386-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf8AxHuQQeedjzBIxAA--.55352S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoWxXrWDKw15Jr43KFWktF4fKrg_yoWrGFyDpr
        1UAr18Gr48Xw17Xr1UGr1DJrZxJ3Zru3W7JFy3Jr13Aw1UXw1UJFyUtrWUWFy8Jr45JF9r
        XF18Jr15tr4UJ3DanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        b7AYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2
        IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r4j6F4U
        McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2
        IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
        6r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
        AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IY
        s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr
        0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8vApUUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Under CONFIG_DEBUG_ATOMIC_SLEEP=y and CONFIG_DEBUG_PREEMPT=y, we can see
the following messages on LoongArch, this is because using might_sleep()
in preemption disable context.

[    0.001127] smp: Bringing up secondary CPUs ...
[    0.001222] Booting CPU#1...
[    0.001244] 64-bit Loongson Processor probed (LA464 Core)
[    0.001247] CPU1 revision is: 0014c012 (Loongson-64bit)
[    0.001250] FPU1 revision is: 00000000
[    0.001252] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:283
[    0.001255] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 0, name: swapper/1
[    0.001257] preempt_count: 1, expected: 0
[    0.001258] RCU nest depth: 0, expected: 0
[    0.001259] Preemption disabled at:
[    0.001261] [<9000000000223800>] arch_dup_task_struct+0x20/0x110
[    0.001272] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.2.0-rc7+ #43
[    0.001275] Hardware name: Loongson Loongson-3A5000-7A1000-1w-A2101/Loongson-LS3A5000-7A1000-1w-A2101, BIOS vUDK2018-LoongArch-V4.0.05132-beta10 12/13/202
[    0.001277] Stack : 0072617764726148 0000000000000000 9000000000222f1c 90000001001e0000
[    0.001286]         90000001001e3be0 90000001001e3be8 0000000000000000 0000000000000000
[    0.001292]         90000001001e3be8 0000000000000040 90000001001e3cb8 90000001001e3a50
[    0.001297]         9000000001642000 90000001001e3be8 be694d10ce4139dd 9000000100174500
[    0.001303]         0000000000000001 0000000000000001 00000000ffffe0a2 0000000000000020
[    0.001309]         000000000000002f 9000000001354116 00000000056b0000 ffffffffffffffff
[    0.001314]         0000000000000000 0000000000000000 90000000014f6e90 9000000001642000
[    0.001320]         900000000022b69c 0000000000000001 0000000000000000 9000000001736a90
[    0.001325]         9000000100038000 0000000000000000 9000000000222f34 0000000000000000
[    0.001331]         00000000000000b0 0000000000000004 0000000000000000 0000000000070000
[    0.001337]         ...
[    0.001339] Call Trace:
[    0.001342] [<9000000000222f34>] show_stack+0x5c/0x180
[    0.001346] [<90000000010bdd80>] dump_stack_lvl+0x60/0x88
[    0.001352] [<9000000000266418>] __might_resched+0x180/0x1cc
[    0.001356] [<90000000010c742c>] mutex_lock+0x20/0x64
[    0.001359] [<90000000002a8ccc>] irq_find_matching_fwspec+0x48/0x124
[    0.001364] [<90000000002259c4>] constant_clockevent_init+0x68/0x204
[    0.001368] [<900000000022acf4>] start_secondary+0x40/0xa8
[    0.001371] [<90000000010c0124>] smpboot_entry+0x60/0x64

Here are the complete call chains:

smpboot_entry()
  start_secondary()
    constant_clockevent_init()
      get_timer_irq()
        irq_find_matching_fwnode()
          irq_find_matching_fwspec()
            mutex_lock()
              might_sleep()
                __might_sleep()
                  __might_resched()

In order to avoid the above issue, we should break the call chains,
using timer_irq_installed variable as check condition to only call
get_timer_irq() once in constant_clockevent_init() is a simple and
proper way.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/kernel/time.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/loongarch/kernel/time.c b/arch/loongarch/kernel/time.c
index a6576de..6263b5a 100644
--- a/arch/loongarch/kernel/time.c
+++ b/arch/loongarch/kernel/time.c
@@ -140,14 +140,15 @@ static int get_timer_irq(void)
 
 int constant_clockevent_init(void)
 {
-	int irq;
+	static int irq;
 	unsigned int cpu = smp_processor_id();
 	unsigned long min_delta = 0x600;
 	unsigned long max_delta = (1UL << 48) - 1;
 	struct clock_event_device *cd;
 	static int timer_irq_installed = 0;
 
-	irq = get_timer_irq();
+	if (timer_irq_installed == 0)
+		irq = get_timer_irq();
 	if (irq < 0)
 		pr_err("Failed to map irq %d (timer)\n", irq);
 
-- 
2.1.0


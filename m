Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 001EC5F0554
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 08:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbiI3Gtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 02:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiI3Gts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 02:49:48 -0400
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C35BDFBF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 23:49:43 -0700 (PDT)
X-QQ-mid: bizesmtp77t1664520081tlxcm33a
Received: from localhost.localdomain ( [113.57.152.160])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 30 Sep 2022 14:41:19 +0800 (CST)
X-QQ-SSF: 01400000000000C0I000000B0000000
X-QQ-FEAT: tPxzKmGTl1eVh5YrMFHeuhV+RqJ7rGLEVxy192I51b1+d+5VLj2BeTci7jehc
        SZitGQ21rsKLrKOrdvCbQed88YIvsYGuqJk/RAjDno4GWM2VQi5cKqRgJYy3VNSfHZGMXM8
        yHSmab0K2S6PgFXnKQAb8/Ks2qBAkDjNZ4w8K3FcVR3RLSp8JI0bdVcSsBsavJrinIO8fe4
        HWVVdRNAYTuuC+A10XXwa5YE5BQw1mGCBUC8YpSwq4kJ+HNth8+wFWjVsSWj4XEOJ+Wy1au
        kazUTqpBV7FQT3p5XhWy58tVU0UFtnehYwY/eICr4BL92M2FJzpSncBi/LISBQwFodlzwLc
        ijKzvB4o+Tsho/man+/2J28UvYDL7GX/syAsDJ5B6uOFfK2cHxlYUepsbmViwQtaOufHTZ4
X-QQ-GoodBg: 1
From:   Zhang Xincheng <zhangxincheng@uniontech.com>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, maz@kernel.org,
        oleksandr@natalenko.name, hdegoede@redhat.com,
        bigeasy@linutronix.de, mark.rutland@arm.com, michael@walle.cc,
        zhangxincheng <zhangxincheng@uniontech.com>
Subject: [PATCH] interrupt: discover and disable very frequent interrupts
Date:   Fri, 30 Sep 2022 14:40:42 +0800
Message-Id: <20220930064042.14564-1-zhangxincheng@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhangxincheng <zhangxincheng@uniontech.com>

In some cases, a peripheral's interrupt will be triggered frequently,
which will keep the CPU processing the interrupt and eventually cause
the RCU to report rcu_sched self-detected stall on the CPU.

[  838.131628] rcu: INFO: rcu_sched self-detected stall on CPU
[  838.137189] rcu:     0-....: (194839 ticks this GP) idle=f02/1/0x4000000000000004
softirq=9993/9993 fqs=97428
[  838.146912] rcu:      (t=195015 jiffies g=6773 q=0)
[  838.151516] Task dump for CPU 0:
[  838.154730] systemd-sleep   R  running task        0  3445      1 0x0000000a

Signed-off-by: zhangxincheng <zhangxincheng@uniontech.com>
Change-Id: I9c92146f2772eae383c16c8c10de028b91e07150
Signed-off-by: zhangxincheng <zhangxincheng@uniontech.com>
---
 include/linux/irqdesc.h |  2 ++
 kernel/irq/spurious.c   | 52 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
index 1cd4e36890fb..a3bd521c3557 100644
--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -102,6 +102,8 @@ struct irq_desc {
 	int			parent_irq;
 	struct module		*owner;
 	const char		*name;
+	u32 gap_count;
+	u64 gap_time;
 } ____cacheline_internodealigned_in_smp;
 
 #ifdef CONFIG_SPARSE_IRQ
diff --git a/kernel/irq/spurious.c b/kernel/irq/spurious.c
index 02b2daf07441..b7162a10d92c 100644
--- a/kernel/irq/spurious.c
+++ b/kernel/irq/spurious.c
@@ -222,6 +222,38 @@ static void __report_bad_irq(struct irq_desc *desc, irqreturn_t action_ret)
 	raw_spin_unlock_irqrestore(&desc->lock, flags);
 }
 
+/*
+ * Some bad hardware will trigger interrupts very frequently, which will
+ * cause the CPU to process hardware interrupts all the time. So when
+ * we find this out, the interrupt should be disabled.
+ */
+static void __report_so_frequently_irq(struct irq_desc *desc, irqreturn_t action_ret)
+{
+	unsigned int irq = irq_desc_get_irq(desc);
+	struct irqaction *action;
+	unsigned long flags;
+
+	printk(KERN_ERR "irq %d: triggered too frequently\n",irq);
+	dump_stack();
+	printk(KERN_ERR "handlers:\n");
+
+	/*
+	 * We need to take desc->lock here. note_interrupt() is called
+	 * w/o desc->lock held, but IRQ_PROGRESS set. We might race
+	 * with something else removing an action. It's ok to take
+	 * desc->lock here. See synchronize_irq().
+	 */
+	raw_spin_lock_irqsave(&desc->lock, flags);
+	for_each_action_of_desc(desc, action) {
+		printk(KERN_ERR "[<%p>] %pf", action->handler, action->handler);
+		if (action->thread_fn)
+			printk(KERN_CONT " threaded [<%p>] %pf",
+					action->thread_fn, action->thread_fn);
+		printk(KERN_CONT "\n");
+	}
+	raw_spin_unlock_irqrestore(&desc->lock, flags);
+}
+
 static void report_bad_irq(struct irq_desc *desc, irqreturn_t action_ret)
 {
 	static int count = 100;
@@ -273,6 +305,26 @@ void note_interrupt(struct irq_desc *desc, irqreturn_t action_ret)
 {
 	unsigned int irq;
 
+	if((desc->gap_count & 0xffff0000) == 0)
+		desc->gap_time = get_jiffies_64();
+
+	desc->gap_count ++;
+
+	if((desc->gap_count & 0x0000ffff) >= 2000) {
+		if((get_jiffies_64() - desc->gap_time) < HZ) {
+			desc->gap_count += 0x00010000;
+			desc->gap_count &= 0xffff0000;
+		} else {
+			desc->gap_count = 0;
+		}
+
+		if((desc->gap_count >> 16) > 30) {
+			__report_so_frequently_irq(desc, action_ret);
+			irq_disable(desc);
+		}
+	}
+
+
 	if (desc->istate & IRQS_POLL_INPROGRESS ||
 	    irq_settings_is_polled(desc))
 		return;
-- 
2.20.1


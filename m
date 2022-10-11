Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F20C85FAEB5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 10:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbiJKIs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 04:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiJKIsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 04:48:54 -0400
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F995F7EB
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 01:48:52 -0700 (PDT)
X-QQ-mid: bizesmtp70t1665478106tvcduh6y
Received: from localhost.localdomain ( [113.57.152.160])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 11 Oct 2022 16:48:25 +0800 (CST)
X-QQ-SSF: 01400000000000C0I000000A0000000
X-QQ-FEAT: bYR630AeiPhVrerovAXuKuzOCurcaDdNa5KVrdcyOwvim68yG6/5rL82Hk7Ti
        F4nFWQYbqv/n2NByPS2SHmEtYnS7P9Realhj5cQWGCp/EdMYbTquaQ+edbUzC9DETP326tG
        bMuTSp6YWMgoOqosE5khnc3MGXv9jzq0NsnUkv6WhXK8Ea6c1bMIfMl29cDUVojgIzZMDAN
        DyYxSUgBI815pOxvpKrGTSHVA2bziz2zLzTdbRb7ySu0qAUxlQm99k6sRBHPtwT4gCt4t5z
        aPdx57RTlRJDcgWbWNH5lWHKQSGR8dnrdKG82qWLOO3NyvtAvVQOzTzncS0F4fLyrHok/Yp
        t9JeeXdP0R7vqLSyczkz9Oxq18SURNQZfQVuP/IZV1/N/KMvBsDx3euGwocrF6p+TGH0TJI
        NJgsjiW4pDk=
X-QQ-GoodBg: 1
From:   Zhang Xincheng <zhangxincheng@uniontech.com>
To:     tglx@linutronix.de
Cc:     maz@kernel.org, wsa+renesas@sang-engineering.com,
        hdegoede@redhat.com, bigeasy@linutronix.de, mark.rutland@arm.com,
        michael@walle.cc, linux-kernel@vger.kernel.org,
        Zhang Xincheng <zhangxincheng@uniontech.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v3] interrupt: debug for discovering frequent interrupts
Date:   Tue, 11 Oct 2022 16:47:59 +0800
Message-Id: <20221011084759.19197-1-zhangxincheng@uniontech.com>
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

In some cases, a peripheral's interrupt will be triggered frequently,
which will keep the CPU processing the interrupt and eventually cause
the RCU to report rcu_sched self-detected stall on the CPU. This patch
provides a way to discover and report which outage is causing the problem.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Zhang Xincheng <zhangxincheng@uniontech.com>
---
 include/linux/irqdesc.h |   5 ++
 kernel/irq/Kconfig      |  25 +++++++++
 kernel/irq/spurious.c   | 121 +++++++++++++++++++++++++++++++++++++---
 3 files changed, 144 insertions(+), 7 deletions(-)

diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
index 1cd4e36890fb..f82b138c68d6 100644
--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -102,6 +102,11 @@ struct irq_desc {
 	int			parent_irq;
 	struct module		*owner;
 	const char		*name;
+#ifdef CONFIG_FREQUENT_IRQ_DEBUG
+	bool have_reported;
+	u32 gap_count;
+	u64 gap_time;
+#endif
 } ____cacheline_internodealigned_in_smp;
 
 #ifdef CONFIG_SPARSE_IRQ
diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
index db3d174c53d4..0b666ef51a08 100644
--- a/kernel/irq/Kconfig
+++ b/kernel/irq/Kconfig
@@ -137,6 +137,31 @@ config GENERIC_IRQ_DEBUGFS
 
 	  If you don't know what to do here, say N.
 
+config FREQUENT_IRQ_DEBUG
+	bool "Support for finding and reporting frequent interrupt"
+	default n
+	help
+
+	  This is a mechanism to detect and report that interrupts
+	  are triggered too frequently.
+
+config COUNT_PER_SECOND
+	int "Interrupt limit per second"
+	depends on FREQUENT_IRQ_DEBUG
+	default "2000"
+	help
+
+	  This is the limit on the number of interrupts triggered per second.
+	  (Max 65535)
+config DURATION_LIMIT
+	int "Duration limit"
+	depends on FREQUENT_IRQ_DEBUG
+	default "30"
+	help
+
+	  The number of interruptions per second exceeds the duration limit of
+	  the limit. (Max 65535)
+
 endmenu
 
 config GENERIC_IRQ_MULTI_HANDLER
diff --git a/kernel/irq/spurious.c b/kernel/irq/spurious.c
index 02b2daf07441..b33751a17260 100644
--- a/kernel/irq/spurious.c
+++ b/kernel/irq/spurious.c
@@ -22,6 +22,16 @@ static DEFINE_TIMER(poll_spurious_irq_timer, poll_spurious_irqs);
 static int irq_poll_cpu;
 static atomic_t irq_poll_active;
 
+#ifdef CONFIG_FREQUENT_IRQ_DEBUG
+#define COUNT_PER_SECOND_MASK	0x0000ffff
+#define DURATION_LIMIT_MASK		0xffff0000
+#define DURATION_LIMIT_COUNT	0x00010000
+#define DURATION_LIMIT_OFFSET	16
+static unsigned int count_per_second = CONFIG_COUNT_PER_SECOND;
+static unsigned int duration_limit = CONFIG_DURATION_LIMIT;
+static bool disable_frequent_irq;
+#endif /* CONFIG_FREQUENT_IRQ_DEBUG */
+
 /*
  * We wait here for a poller to finish.
  *
@@ -189,18 +199,16 @@ static inline int bad_action_ret(irqreturn_t action_ret)
  * (The other 100-of-100,000 interrupts may have been a correctly
  *  functioning device sharing an IRQ with the failing one)
  */
-static void __report_bad_irq(struct irq_desc *desc, irqreturn_t action_ret)
+static void __report_bad_irq(struct irq_desc *desc, irqreturn_t action_ret, const char *msg)
 {
 	unsigned int irq = irq_desc_get_irq(desc);
 	struct irqaction *action;
 	unsigned long flags;
 
 	if (bad_action_ret(action_ret)) {
-		printk(KERN_ERR "irq event %d: bogus return value %x\n",
-				irq, action_ret);
+		printk(msg, irq, action_ret);
 	} else {
-		printk(KERN_ERR "irq %d: nobody cared (try booting with "
-				"the \"irqpoll\" option)\n", irq);
+		printk(msg, irq);
 	}
 	dump_stack();
 	printk(KERN_ERR "handlers:\n");
@@ -228,7 +236,7 @@ static void report_bad_irq(struct irq_desc *desc, irqreturn_t action_ret)
 
 	if (count > 0) {
 		count--;
-		__report_bad_irq(desc, action_ret);
+		__report_bad_irq(desc, action_ret, KERN_ERR "irq event %d: bogus return value %x\n");
 	}
 }
 
@@ -269,6 +277,46 @@ try_misrouted_irq(unsigned int irq, struct irq_desc *desc,
 
 #define SPURIOUS_DEFERRED	0x80000000
 
+#ifdef CONFIG_FREQUENT_IRQ_DEBUG
+/*
+ * Some bad hardware will trigger interrupts very frequently, which will
+ * cause the CPU to process hardware interrupts all the time. We found
+ * and reported it, and disabling it is optional.
+ */
+static void report_frequent_irq(struct irq_desc *desc, irqreturn_t action_ret)
+{
+	if (desc->have_reported)
+		return;
+
+	if ((desc->gap_count & DURATION_LIMIT_MASK) == 0)
+		desc->gap_time = get_jiffies_64();
+
+	desc->gap_count++;
+
+	if ((desc->gap_count & COUNT_PER_SECOND_MASK) >= count_per_second) {
+		if ((get_jiffies_64() - desc->gap_time) < HZ) {
+			desc->gap_count += DURATION_LIMIT_COUNT;
+			desc->gap_count &= DURATION_LIMIT_MASK;
+		} else {
+			desc->gap_count = 0;
+		}
+
+		if ((desc->gap_count >> DURATION_LIMIT_OFFSET) >= duration_limit) {
+			__report_bad_irq(desc, action_ret, KERN_ERR "irq %d: triggered too "
+					"frequently\n");
+			desc->have_reported = true;
+			if (disable_frequent_irq)
+				irq_disable(desc);
+		}
+	}
+}
+
+#else
+static void report_frequent_irq(struct irq_desc *desc, irqreturn_t action_ret)
+{
+}
+#endif /* CONFIG_FREQUENT_IRQ_DEBUG */
+
 void note_interrupt(struct irq_desc *desc, irqreturn_t action_ret)
 {
 	unsigned int irq;
@@ -282,6 +330,8 @@ void note_interrupt(struct irq_desc *desc, irqreturn_t action_ret)
 		return;
 	}
 
+	report_frequent_irq(desc, action_ret);
+
 	/*
 	 * We cannot call note_interrupt from the threaded handler
 	 * because we need to look at the compound of all handlers
@@ -416,7 +466,8 @@ void note_interrupt(struct irq_desc *desc, irqreturn_t action_ret)
 		/*
 		 * The interrupt is stuck
 		 */
-		__report_bad_irq(desc, action_ret);
+		__report_bad_irq(desc, action_ret, KERN_ERR "irq %d: nobody cared (try "
+				"bootingwith the \"irqpoll\" option)\n");
 		/*
 		 * Now kill the IRQ
 		 */
@@ -476,3 +527,59 @@ static int __init irqpoll_setup(char *str)
 }
 
 __setup("irqpoll", irqpoll_setup);
+
+#ifdef CONFIG_FREQUENT_IRQ_DEBUG
+int __init count_per_second_setup(char *str)
+{
+	int ret;
+
+	ret = kstrtouint(str, 10, &count_per_second);
+	if (ret)
+		return 0;
+
+	printk(KERN_INFO "Interrupt limit per second: %u\n", count_per_second);
+
+	return 1;
+}
+
+__setup("count_per_second=", count_per_second_setup);
+module_param(count_per_second, uint, 0644);
+MODULE_PARM_DESC(count_per_second, "Interrupt limit per second. (Max 0x65535)");
+
+int __init duration_limit_setup(char *str)
+{
+	int ret;
+
+	ret = kstrtouint(str, 10, &duration_limit);
+	if (ret)
+		return 0;
+
+	printk(KERN_INFO "Duration limit: %u\n", duration_limit);
+
+	return 1;
+}
+
+__setup("duration_limit=", duration_limit_setup);
+module_param(duration_limit, uint, 0644);
+MODULE_PARM_DESC(duration_limit, "The number of interruptions per second exceeds the duration limit of the limit. (Max 65535)");
+
+int __init disable_frequent_irq_setup(char *str)
+{
+	int ret;
+
+	ret = kstrtobool(str, &disable_frequent_irq);
+	if (ret)
+		return 0;
+
+	if (disable_frequent_irq)
+		printk(KERN_INFO "Disable frequent irq'\n");
+	else
+		printk(KERN_INFO "Don't disable frequent irq'\n");
+
+	return 1;
+}
+
+__setup("disable_frequent_irq=", disable_frequent_irq_setup);
+module_param(disable_frequent_irq, bool, 0644);
+MODULE_PARM_DESC(noirqdebug, "Disable frequent irq when true");
+#endif /* CONFIG_FREQUENT_IRQ_DEBUG */
-- 
2.20.1


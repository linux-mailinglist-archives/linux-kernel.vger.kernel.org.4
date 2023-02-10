Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACEB691BE9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 10:51:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbjBJJvJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 10 Feb 2023 04:51:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbjBJJvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 04:51:07 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE3A635BA
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 01:51:00 -0800 (PST)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4PCppN4FBmz16NVy;
        Fri, 10 Feb 2023 17:48:44 +0800 (CST)
Received: from canpemm500010.china.huawei.com (7.192.105.118) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 10 Feb 2023 17:50:58 +0800
Received: from canpemm500010.china.huawei.com ([7.192.105.118]) by
 canpemm500010.china.huawei.com ([7.192.105.118]) with mapi id 15.01.2375.034;
 Fri, 10 Feb 2023 17:50:58 +0800
From:   "liujian (CE)" <liujian56@huawei.com>
To:     "jstultz@google.com" <jstultz@google.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "liujian (CE)" <liujian56@huawei.com>
Subject: [Question]  softlockup in run_timer_softirq
Thread-Topic: [Question]  softlockup in run_timer_softirq
Thread-Index: Adk9Mp52TMDHbWFhT026wVmv/cydDA==
Date:   Fri, 10 Feb 2023 09:50:58 +0000
Message-ID: <fb8d80434b2148e78c0032c6c70a8b4d@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.176.93]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

During the syz test, we encountered many problems with various timer handler
functions softlockup.

We analyze __run_timers() and find the following problem.

In the while loop of __run_timers(), because there are too many timers or
improper timer handler functions, if the processing time of the expired
timers is always greater than the time wheel's next_expiry, the function
will loop infinitely.

The following extreme test case can be used to reproduce the problem.
An extreme test case[1] is constructed to reproduce the problem.

Is this a problem or an unreasonable use?

Can we limit the running time of __run_timers() [2]?

Does anyone have a good idea to solve this problem? 
Thank you.


[1]
#include <linux/module.h>
#include <linux/slab.h>
#include <asm-generic/delay.h>

static int stop = 1;

// timer num
static int size = 1000;
module_param(size, int, 0644);
MODULE_PARM_DESC(size, "size");

// Timeout of the timer
static int interval = 100;
module_param(interval, int, 0644);
MODULE_PARM_DESC(interval, "");

//elapsed time
static int dt = 200;
module_param(dt, int, 0644);
MODULE_PARM_DESC(dt, "");

struct wrapper {
	struct timer_list timer;
	spinlock_t lock;
};

struct wrapper *wr;

static void timer_func(struct timer_list *t)
{
	struct wrapper *w = from_timer(w, t, timer);

	spin_lock_bh(&(w->lock));
	if (stop == 0) {
		udelay(dt); // elapsed time
	}
	spin_unlock_bh(&(w->lock));

	if (stop == 0) {
		mod_timer(&(w->timer), jiffies + interval);
	}
}

static int __init maint_init(void)
{
	int i;

	wr = (struct wrapper *)kzalloc(size*sizeof(struct wrapper), GFP_KERNEL);

	for (i = 0; i < size; i++) {
		struct wrapper *w = &wr[i];
		spin_lock_init(&(w->lock));
		timer_setup(&(w->timer), timer_func, 0);
		mod_timer(&(w->timer), jiffies + 20);
	}
	stop = 0;

	return 0;
}

static void __exit maint_exit(void)
{
	int i;

	stop = 1;
	udelay(100);
	for (i = 0; i < size; i++) {
		struct wrapper *w = &wr[i];
		del_timer_sync(&(w->timer));
	}
	kfree(wr);

}

module_init(maint_init);
module_exit(maint_exit);
MODULE_LICENSE("GPL");


insmod timer_test.ko size=1000 interval=100 dt=200

[2]
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 63a8ce7177dd..a215916f26cf 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -223,6 +223,9 @@  static DEFINE_MUTEX(timer_keys_mutex);
 static void timer_update_keys(struct work_struct *work);
 static DECLARE_WORK(timer_update_work, timer_update_keys);
 
+static unsigned int sysctl_timer_time_limit = 0;
+
+#ifdef CONFIG_SYSCTL
 #ifdef CONFIG_SMP
 static unsigned int sysctl_timer_migration = 1;
 
@@ -236,7 +239,6 @@  static void timers_update_migration(void)
 		static_branch_disable(&timers_migration_enabled);
 }
 
-#ifdef CONFIG_SYSCTL
 static int timer_migration_handler(struct ctl_table *table, int write,
 			    void *buffer, size_t *lenp, loff_t *ppos)
 {
@@ -249,8 +251,12 @@  static int timer_migration_handler(struct ctl_table *table, int write,
 	mutex_unlock(&timer_keys_mutex);
 	return ret;
 }
+#else
+static inline void timers_update_migration(void) { }
+#endif /* !CONFIG_SMP */
 
 static struct ctl_table timer_sysctl[] = {
+#ifdef CONFIG_SMP
 	{
 		.procname	= "timer_migration",
 		.data		= &sysctl_timer_migration,
@@ -260,6 +266,15 @@  static struct ctl_table timer_sysctl[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_ONE,
 	},
+#endif
+	{
+		.procname	= "timer_time_limit",
+		.data		= &sysctl_timer_time_limit,
+		.maxlen		= sizeof(unsigned int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+	},
 	{}
 };
 
@@ -270,9 +285,6 @@  static int __init timer_sysctl_init(void)
 }
 device_initcall(timer_sysctl_init);
 #endif /* CONFIG_SYSCTL */
-#else /* CONFIG_SMP */
-static inline void timers_update_migration(void) { }
-#endif /* !CONFIG_SMP */
 
 static void timer_update_keys(struct work_struct *work)
 {
@@ -1992,7 +2004,7 @@  void timer_clear_idle(void)
  * __run_timers - run all expired timers (if any) on this CPU.
  * @base: the timer vector to be processed.
  */
-static inline void __run_timers(struct timer_base *base)
+static inline void __run_timers(struct timer_base *base, unsigned long time_limit)
 {
 	struct hlist_head heads[LVL_DEPTH];
 	int levels;
@@ -2020,6 +2032,13 @@  static inline void __run_timers(struct timer_base *base)
 
 		while (levels--)
 			expire_timers(base, heads + levels);
+
+		if (unlikely(time_limit &&
+		    time_after_eq(jiffies, time_limit))) {
+			if (time_after_eq(jiffies, base->next_expiry))
+				raise_softirq(TIMER_SOFTIRQ);
+			break;
+		}
 	}
 	raw_spin_unlock_irq(&base->lock);
 	timer_base_unlock_expiry(base);
@@ -2031,10 +2050,14 @@  static inline void __run_timers(struct timer_base *base)
 static __latent_entropy void run_timer_softirq(struct softirq_action *h)
 {
 	struct timer_base *base = this_cpu_ptr(&timer_bases[BASE_STD]);
+	unsigned long time_limit = 0;
+
+	if (sysctl_timer_time_limit)
+		time_limit = jiffies + msecs_to_jiffies(sysctl_timer_time_limit);
 
-	__run_timers(base);
+	__run_timers(base, time_limit);
 	if (IS_ENABLED(CONFIG_NO_HZ_COMMON))
-		__run_timers(this_cpu_ptr(&timer_bases[BASE_DEF]));
+		__run_timers(this_cpu_ptr(&timer_bases[BASE_DEF]), time_limit);
 }
 
 /*

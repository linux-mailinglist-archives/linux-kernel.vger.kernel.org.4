Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 257785F7C27
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 19:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiJGRUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 13:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbiJGRUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 13:20:02 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3103D437C0
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 10:20:01 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id c2so3461027qvo.11
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 10:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OcKVHCQ6Pd/4Vzw1QCRzTVRvm7neQbEzV4nutXxn8ug=;
        b=Wt5FliQ10CrfG0kZMQqy6bwfByctkio5BJPqZmgD+OX38RyYPbX+OWYsgwYycRXB5j
         0zS/ARi21ZbYCtqXX9LZg+ohFKd3cjj0PP5+eelIFNfIPe4xLJEetYawYWpFCjnye7mK
         qNh282XnB9Jr2RKEWVAvIodPM+FdP2acD3fx4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OcKVHCQ6Pd/4Vzw1QCRzTVRvm7neQbEzV4nutXxn8ug=;
        b=M8QixUgEp4rwZ/7XyA+haTmZUVFmm45Sdw0+c4uC2g8iIThF2d+h85RKhqdqg2NUJV
         e64SEfwQBiH9EN/RvjBNEvDlvrc2yiGFr/EWOvTaX+IsvTFwWI06FdgnrqPX7bAynxhw
         /OdKwBq1c+T523+eh17/J92l9LNx51zikKyOGf++Noct3oNJ57nGZb+L1UjQfCf+b9PF
         euxeNWthuTJpuFPloYXTy6+17NF7ea5bmA97vLUsYEmd7HkcNOj3SvFkMRWujXBNxBNX
         dFHbl0JZoIjlmHaf8GKm8pp0t8yor7FADUTAJiQuY6kT9Z8IXAipUtpmndl3ke86IHnB
         SNxA==
X-Gm-Message-State: ACrzQf1mCLax2VRYq6slsYoLxwbMEdLfG/D4n89ESJBZcqcAhdqzBsv2
        I9qPu06Z3pWyzfDHYskI4nOVSA==
X-Google-Smtp-Source: AMsMyM5bGXzr6NvXOuNsnKGRG14olahEhaAYgCix9BxeR8Xpn1w2eIPo9mChSS+USZgY9chaK0ow7g==
X-Received: by 2002:a05:6214:1d0e:b0:4b1:7c94:5e46 with SMTP id e14-20020a0562141d0e00b004b17c945e46mr4969694qvd.38.1665163200252;
        Fri, 07 Oct 2022 10:20:00 -0700 (PDT)
Received: from localhost (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id bl21-20020a05620a1a9500b006cf38fd659asm2290321qkb.103.2022.10.07.10.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 10:19:59 -0700 (PDT)
Date:   Fri, 7 Oct 2022 17:19:59 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, frederic@kernel.org,
        paulmck@kernel.org, rostedt@goodmis.org, youssefesmat@google.com,
        surenb@google.com
Subject: Re: [PATCH v7 10/11] scsi/scsi_error: Use call_rcu_flush() instead
 of call_rcu()
Message-ID: <Y0BfvzpF1DE10nOg@google.com>
References: <20221004024157.2470238-1-joel@joelfernandes.org>
 <20221004024157.2470238-11-joel@joelfernandes.org>
 <Yz+agsJrvHg18FeC@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yz+agsJrvHg18FeC@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 07, 2022 at 03:18:26AM +0000, Joel Fernandes wrote:
> On Tue, Oct 04, 2022 at 02:41:56AM +0000, Joel Fernandes (Google) wrote:
> > From: Uladzislau Rezki <urezki@gmail.com>
> > 
> > Slow boot time is seen on KVM running typical Linux distributions due to
> > SCSI layer calling call_rcu(). Recent changes to save power may be
> > causing this slowness. Using call_rcu_flush() fixes the issue and brings
> > the boot time back to what it originally was. Convert it.
> > 
> > Signed-off-by: Uladzislau Rezki <urezki@gmail.com>
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> And I successfully setup Debian on KVM and verified that this fixes it, so
> now I have a nice reproducible rig for my
> 'lazy-callback-doing-a-wakeup-detector' (I wrote half the detector thanks to
> ideas from Steve, and will finish the other half tomorrow or so).
> 
> Tested-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Looks like I can catch Vlad's issue with the below patch. Thoughts? Does this
look reasonable for mainline? (I think so as it is self-contained and the
debug option is default off, and could be useful down the line).

[    6.887033 ] rcu: *****************************************************
[    6.891242 ] rcu: RCU: A wake up has been detected from a lazy callback!
[    6.895377 ] rcu: The callback name is: scsi_eh_inc_host_failed
[    6.899084 ] rcu: The task it woke up is: scsi_eh_1 (61)
[    6.902405 ] rcu: This could cause performance issues! Check the stack.
[    6.906532 ] rcu: *****************************************************


[   17.127128 ] rcu: *****************************************************
[   17.131397 ] rcu: RCU: A wake up has been detected from a lazy callback!
[   17.135703 ] rcu: The callback name is: scsi_eh_inc_host_failed
[   17.139485 ] rcu: The task it woke up is: scsi_eh_1 (61)
[   17.142828 ] rcu: This could cause performance issues! Check the stack.
[   17.146962 ] rcu: *****************************************************

And thanks to Steve for the binary search code.

One thing I found is I have to ignore kworkers because there are times when a
work item is queued from a callback and those callbacks don't seem to
contribute to performance issues. So I am filtering these:

[   38.631724 ] rcu: The callback name is: thread_stack_free_rcu
[   38.635317 ] rcu: The task it woke up is: kworker/3:2 (143)

[   39.649332 ] rcu: The callback name is: delayed_put_task_struct
[   39.653037 ] rcu: The task it woke up is: kworker/0:1 (40)

---8<-----------------------

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH] lazy wake debug

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/Kconfig      |   7 ++
 kernel/rcu/lazy-debug.h | 149 ++++++++++++++++++++++++++++++++++++++++
 kernel/rcu/tree.c       |   9 +++
 3 files changed, 165 insertions(+)
 create mode 100644 kernel/rcu/lazy-debug.h

diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index edd632e68497..08c06f739187 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -322,4 +322,11 @@ config RCU_LAZY
 	  To save power, batch RCU callbacks and flush after delay, memory
 	  pressure or callback list growing too big.
 
+config RCU_LAZY_DEBUG
+	bool "RCU callback lazy invocation debugging"
+	depends on RCU_LAZY
+	default n
+	help
+	  Debugging to catch issues caused by delayed RCU callbacks.
+
 endmenu # "RCU Subsystem"
diff --git a/kernel/rcu/lazy-debug.h b/kernel/rcu/lazy-debug.h
new file mode 100644
index 000000000000..fc1cc1cb89f0
--- /dev/null
+++ b/kernel/rcu/lazy-debug.h
@@ -0,0 +1,149 @@
+#include <linux/string.h>
+#include <linux/spinlock.h>
+
+#ifdef CONFIG_RCU_LAZY_DEBUG
+#include <linux/preempt.h>
+#include <trace/events/sched.h>
+
+static DEFINE_PER_CPU(bool, rcu_lazy_cb_exec) = false;
+static DEFINE_PER_CPU(void *, rcu_lazy_ip) = NULL;
+
+static DEFINE_RAW_SPINLOCK(lazy_funcs_lock);
+
+#define FUNC_SIZE 1024
+static unsigned long lazy_funcs[FUNC_SIZE];
+static int nr_funcs;
+
+static void __find_func(unsigned long ip, int *B, int *E, int *N)
+{
+	unsigned long *p;
+	int b, e, n;
+
+	b = n = 0;
+	e = nr_funcs - 1;
+
+	while (b <= e) {
+		n = (b + e) / 2;
+		p = &lazy_funcs[n];
+		if (ip > *p) {
+			b = n + 1;
+		} else if (ip < *p) {
+			e = n - 1;
+		} else
+			break;
+	}
+
+	*B = b;
+	*E = e;
+	*N = n;
+
+	return;
+}
+
+static bool lazy_func_exists(void* ip_ptr)
+{
+	int b, e, n;
+	unsigned long flags;
+	unsigned long ip = (unsigned long)ip_ptr;
+
+	raw_spin_lock_irqsave(&lazy_funcs_lock, flags);
+	__find_func(ip, &b, &e, &n);
+	raw_spin_unlock_irqrestore(&lazy_funcs_lock, flags);
+
+	return b <= e;
+}
+
+static int lazy_func_add(void* ip_ptr)
+{
+	int b, e, n;
+	unsigned long flags;
+	unsigned long ip = (unsigned long)ip_ptr;
+
+	raw_spin_lock_irqsave(&lazy_funcs_lock, flags);
+	if (nr_funcs >= FUNC_SIZE) {
+		raw_spin_unlock_irqrestore(&lazy_funcs_lock, flags);
+		return -1;
+	}
+
+	__find_func(ip, &b, &e, &n);
+
+	if (b > e) {
+		if (n != nr_funcs)
+			memmove(&lazy_funcs[n+1], &lazy_funcs[n],
+				(sizeof(*lazy_funcs) * (nr_funcs - n)));
+
+		lazy_funcs[n] = ip;
+		nr_funcs++;
+	}
+
+	raw_spin_unlock_irqrestore(&lazy_funcs_lock, flags);
+	return 0;
+}
+
+static void rcu_set_lazy_context(void *ip_ptr)
+{
+	bool *flag = this_cpu_ptr(&rcu_lazy_cb_exec);
+	*flag = lazy_func_exists(ip_ptr);
+
+	if (*flag) {
+		*this_cpu_ptr(&rcu_lazy_ip) = ip_ptr;
+	} else {
+		*this_cpu_ptr(&rcu_lazy_ip) = NULL;
+	}
+}
+
+static void rcu_reset_lazy_context(void)
+{
+	bool *flag = this_cpu_ptr(&rcu_lazy_cb_exec);
+	*flag = false;
+}
+
+static bool rcu_is_lazy_context(void)
+{
+	return *(this_cpu_ptr(&rcu_lazy_cb_exec));
+}
+
+static void
+probe_waking(void *ignore, struct task_struct *p)
+{
+	if (WARN_ON(!in_nmi() && !in_hardirq() && rcu_is_lazy_context())) {
+		pr_err("*****************************************************\n");
+		pr_err("RCU: A wake up has been detected from a lazy callback!\n");
+		pr_err("The callback name is: %ps\n", *this_cpu_ptr(&rcu_lazy_ip));
+		pr_err("The task it woke up is: %s (%d)\n", p->comm, p->pid);
+		pr_err("This could cause performance issues! Check the stack.\n");
+		pr_err("*****************************************************\n");
+	}
+}
+
+static void rcu_lazy_debug_init(void)
+{
+	int ret;
+	pr_info("RCU Lazy CB debugging is turned on, system may be slow.\n");
+
+	ret = register_trace_sched_waking(probe_waking, NULL);
+	if (ret)
+		pr_info("RCU: Lazy debug ched_waking probe could not be registered.");
+}
+
+#else
+
+static int lazy_func_add(void* ip_ptr)
+{
+	return -1;
+}
+
+
+static void rcu_set_lazy_context(void *ip_ptr)
+{
+}
+
+static void rcu_reset_lazy_context(void)
+{
+}
+
+static void rcu_lazy_debug_init(void)
+{
+}
+
+#endif
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index c20544c4aa29..ad8d4e52ae92 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -67,6 +67,7 @@
 
 #include "tree.h"
 #include "rcu.h"
+#include "lazy-debug.h"
 
 #ifdef MODULE_PARAM_PREFIX
 #undef MODULE_PARAM_PREFIX
@@ -2245,7 +2246,10 @@ static void rcu_do_batch(struct rcu_data *rdp)
 
 		f = rhp->func;
 		WRITE_ONCE(rhp->func, (rcu_callback_t)0L);
+
+		rcu_set_lazy_context(f);
 		f(rhp);
+		rcu_reset_lazy_context();
 
 		rcu_lock_release(&rcu_callback_map);
 
@@ -2770,6 +2774,10 @@ __call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool lazy)
 	}
 
 	check_cb_ovld(rdp);
+
+	if (lazy)
+		lazy_func_add(func);
+
 	if (rcu_nocb_try_bypass(rdp, head, &was_alldone, flags, lazy))
 		return; // Enqueued onto ->nocb_bypass, so just leave.
 	// If no-CBs CPU gets here, rcu_nocb_try_bypass() acquired ->nocb_lock.
@@ -4805,6 +4813,7 @@ void __init rcu_init(void)
 	rcu_early_boot_tests();
 
 	kfree_rcu_batch_init();
+	rcu_lazy_debug_init();
 	rcu_bootup_announce();
 	sanitize_kthread_prio();
 	rcu_init_geometry();
-- 
2.38.0.rc1.362.ged0d419d3c-goog


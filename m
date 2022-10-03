Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8895E5F39BE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 01:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbiJCXVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 19:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiJCXUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 19:20:47 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56CB1CFE0
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 16:20:45 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id nl8-20020a17090b384800b00205f930565cso5104145pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 16:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=OpL44AhoDepjhQgCA7XT7WjFsWnCkxKd4LK73L1sblU=;
        b=i1qeAFa2M86DdbqZK7B4EvOFe4XIKOy/5pQ3Y7flv0mtafGoRocY7Evwe7GHmgQts5
         iwl8Xwp/4C3t+JYsBuZv5SUkiEyFhldJKAdy3iDKueeI4VAytlMjeEDYxdm2n6gD8/0p
         QE5Y21bp3fpZJfYrWMhOsMlCvRccwrskJow/jJOzFbEe68GrmUZ+jPOIqrMJXd6gIh1p
         YOt/dak6KmXO9QaoDN6bjizpSArmAlXLDRmDr7yh22KK+8GpARiz5zZ7j+ztSU9ZAzm1
         3ODNzM04sskJ1Ho6SE9mAX+hKfjk1CtbUgSlfuHjJQsP9B/O7EjerSXnmt1sUPBsC9uu
         vlBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=OpL44AhoDepjhQgCA7XT7WjFsWnCkxKd4LK73L1sblU=;
        b=llZWoB35OYGXNPqpfALOmLgrUB/lkhRCitTaE8lS03cyIO3bwarJgigYfjn9t/ryK/
         nXnfX3AlKWKYT6VOZHkovAabcKoALuUpQ7Duf0wQzS+6a8RanrqsUAIXBj65reyEsNtN
         l1M5JdRtRYVOKiucaJSG9U6zpwJZIgpzklEKDuM35Z8QXeCz+Y1rbD01BfaRIP+0Pyr8
         U2SgY0UnA2JCkqvmEF8AmCHA1fR3QlZRJvhyVKdviAfK0d0EdMPHgbeQBNpT55pTTHfk
         bt9PWaezUTuuYYkDFVgugyGoznhyHCzsJgIk9cyEcYoewfYBOAAvWg6er5pXY5GrFm3q
         AE6g==
X-Gm-Message-State: ACrzQf3LKnhPD6cwkUhmL407fmhYOkw/QeFZzNdAFD2SKcgXbSv+Nvtq
        GfMk+UYW4Y5pCfxMVX3RjFr0HyrrMQNRUmS7F4O+KXBrWzzZbPR5LZJ3RBWylJo3ArMGJbaPFa4
        gd1y77Ass/RbulwgkkUakn1uVZrzpWrrYGzbgSXcb3WwjXeMQ7Q9f+NNhY+V8y6pmvUNOqZk=
X-Google-Smtp-Source: AMsMyM69kuB/EYt+LGZsbDdPxSn7Kjy2BTNT6+AibEbFFPaee51sYFMff+desTHfSJUV6MCreqmsQzKnnzb0
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a17:902:d2c6:b0:17f:592b:35dd with SMTP id
 n6-20020a170902d2c600b0017f592b35ddmr7784704plc.172.1664839244526; Mon, 03
 Oct 2022 16:20:44 -0700 (PDT)
Date:   Mon,  3 Oct 2022 23:20:33 +0000
In-Reply-To: <20221003232033.3404802-1-jstultz@google.com>
Mime-Version: 1.0
References: <20221003232033.3404802-1-jstultz@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221003232033.3404802-4-jstultz@google.com>
Subject: [RFC PATCH v4 3/3] softirq: defer softirq processing to ksoftirqd if
 CPU is busy with RT
From:   John Stultz <jstultz@google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Pavankumar Kondeti <pkondeti@codeaurora.org>,
        John Dias <joaodias@google.com>,
        "Connor O'Brien" <connoro@google.com>,
        Rick Yiu <rickyiu@google.com>, John Kacur <jkacur@redhat.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Chris Redpath <chris.redpath@arm.com>,
        Abhijeet Dharmapurikar <adharmap@quicinc.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com,
        Satya Durga Srinivasu Prabhala <satyap@codeaurora.org>,
        "J . Avila" <elavila@google.com>, John Stultz <jstultz@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavankumar Kondeti <pkondeti@codeaurora.org>

Defer the softirq processing to ksoftirqd if a RT task is
running or queued on the current CPU. This complements the RT
task placement algorithm which tries to find a CPU that is not
currently busy with softirqs.

Currently NET_TX, NET_RX, BLOCK and IRQ_POLL softirqs are only
deferred as they can potentially run for long time.

Additionally, this patch stubs out ksoftirqd_running() logic,
in the CONFIG_RT_SOFTIRQ_OPTIMIZATION case, as deferring
potentially long-running softirqs will cause the logic to not
process shorter-running softirqs immediately. By stubbing it out
the potentially long running softirqs are deferred, but the
shorter running ones can still run immediately.

This patch includes folded-in fixes by:
  Lingutla Chandrasekhar <clingutla@codeaurora.org>
  Satya Durga Srinivasu Prabhala <satyap@codeaurora.org>
  J. Avila <elavila@google.com>

Cc: John Dias <joaodias@google.com>
Cc: Connor O'Brien <connoro@google.com>
Cc: Rick Yiu <rickyiu@google.com>
Cc: John Kacur <jkacur@redhat.com>
Cc: Qais Yousef <qais.yousef@arm.com>
Cc: Chris Redpath <chris.redpath@arm.com>
Cc: Abhijeet Dharmapurikar <adharmap@quicinc.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: kernel-team@android.com
Signed-off-by: Pavankumar Kondeti <pkondeti@codeaurora.org>
[satyap@codeaurora.org: trivial merge conflict resolution.]
Signed-off-by: Satya Durga Srinivasu Prabhala <satyap@codeaurora.org>
[elavila: Port to mainline, squash with bugfix]
Signed-off-by: J. Avila <elavila@google.com>
[jstultz: Rebase to linus/HEAD, minor rearranging of code,
 included bug fix Reported-by: Qais Yousef <qais.yousef@arm.com> ]
Signed-off-by: John Stultz <jstultz@google.com>
---
v4:
* Fix commit message to accurately note long-running softirqs
  (suggested by Qais)
* Switch to using rt_task(current) (suggested by Qais)
---
 kernel/softirq.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index 35ee79dd8786..c8ce12bbab04 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -87,6 +87,7 @@ static void wakeup_softirqd(void)
 		wake_up_process(tsk);
 }
 
+#ifndef CONFIG_RT_SOFTIRQ_OPTIMIZATION
 /*
  * If ksoftirqd is scheduled, we do not want to process pending softirqs
  * right now. Let ksoftirqd handle this at its own rate, to get fairness,
@@ -101,6 +102,9 @@ static bool ksoftirqd_running(unsigned long pending)
 		return false;
 	return tsk && task_is_running(tsk) && !__kthread_should_park(tsk);
 }
+#else
+#define ksoftirqd_running(pending) (false)
+#endif /* CONFIG_RT_SOFTIRQ_OPTIMIZATION */
 
 #ifdef CONFIG_TRACE_IRQFLAGS
 DEFINE_PER_CPU(int, hardirqs_enabled);
@@ -532,6 +536,21 @@ static inline bool lockdep_softirq_start(void) { return false; }
 static inline void lockdep_softirq_end(bool in_hardirq) { }
 #endif
 
+#ifdef CONFIG_RT_SOFTIRQ_OPTIMIZATION
+static __u32 softirq_deferred_for_rt(__u32 *pending)
+{
+	__u32 deferred = 0;
+
+	if (rt_task(current)) {
+		deferred = *pending & LONG_SOFTIRQ_MASK;
+		*pending &= ~LONG_SOFTIRQ_MASK;
+	}
+	return deferred;
+}
+#else
+#define softirq_deferred_for_rt(x) (0)
+#endif
+
 asmlinkage __visible void __softirq_entry __do_softirq(void)
 {
 	unsigned long end = jiffies + MAX_SOFTIRQ_TIME;
@@ -539,6 +558,7 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 	int max_restart = MAX_SOFTIRQ_RESTART;
 	struct softirq_action *h;
 	bool in_hardirq;
+	__u32 deferred;
 	__u32 pending;
 	int softirq_bit;
 
@@ -550,14 +570,16 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 	current->flags &= ~PF_MEMALLOC;
 
 	pending = local_softirq_pending();
+	deferred = softirq_deferred_for_rt(&pending);
 
 	softirq_handle_begin();
+
 	in_hardirq = lockdep_softirq_start();
 	account_softirq_enter(current);
 
 restart:
 	/* Reset the pending bitmask before enabling irqs */
-	set_softirq_pending(0);
+	set_softirq_pending(deferred);
 	__this_cpu_write(active_softirqs, pending);
 
 	local_irq_enable();
@@ -596,13 +618,16 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 	local_irq_disable();
 
 	pending = local_softirq_pending();
+	deferred = softirq_deferred_for_rt(&pending);
+
 	if (pending) {
 		if (time_before(jiffies, end) && !need_resched() &&
 		    --max_restart)
 			goto restart;
+	}
 
+	if (pending | deferred)
 		wakeup_softirqd();
-	}
 
 	account_softirq_exit(current);
 	lockdep_softirq_end(in_hardirq);
-- 
2.38.0.rc1.362.ged0d419d3c-goog


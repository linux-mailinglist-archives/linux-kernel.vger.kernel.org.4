Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 912B35EAFBB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 20:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbiIZSZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 14:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiIZSYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 14:24:42 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1464D356CB;
        Mon, 26 Sep 2022 11:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MWYFxbe3wzFoZ0mxwRrcCalNF6gTjbmRt3HqAYvT5I8=; b=hoGUiHOCMuaus9O2rKHpbNA99R
        qw2Nyg8YDAm1FkArR8BGVkiF+VazAjl5vfO5wPLpcaUK2oWZiu7SKKr6ZcRAcyTxA2OKfDw1jJ52X
        X3AFxmrY3gOtghd0gh2JfXQAkD0B8JwKRb5LkZCNcyxyfa8n1RYe4cIG4h2cevAKK31mB8VGlDWi3
        oandx0jGog+b6S+nwaDdQPDhY1+Y2d/09sX03h6Lv/PDTgIqtXgpHcjx34OtcdP/t9v9XCSKX159u
        WTeCeErXTK3ZwRCGRsPcnYufPIsuVrMUjeFzVezfcFFdgDNih1gyfSqxrYdvt9XIKngtihGwxbije
        Nls7j6Ww==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ocskG-00G5DZ-25; Mon, 26 Sep 2022 18:22:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 09D7C3001D6;
        Mon, 26 Sep 2022 20:22:18 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B86FC2B6B2F7B; Mon, 26 Sep 2022 20:22:18 +0200 (CEST)
Date:   Mon, 26 Sep 2022 20:22:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christian Borntraeger <borntraeger@linux.ibm.com>
Cc:     bigeasy@linutronix.de, dietmar.eggemann@arm.com,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, mgorman@suse.de, mingo@kernel.org,
        oleg@redhat.com, rjw@rjwysocki.net, rostedt@goodmis.org,
        tj@kernel.org, vincent.guittot@linaro.org, will@kernel.org,
        Marc Hartmayer <mhartmay@linux.ibm.com>,
        Amit Shah <amit@kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH v3 6/6] freezer,sched: Rewrite core freezer logic
Message-ID: <YzHt2nG0Hb7xLlNj@hirez.programming.kicks-ass.net>
References: <20220923072104.2013212-1-borntraeger@linux.ibm.com>
 <56576c3c-fe9b-59cf-95b8-158734320f24@linux.ibm.com>
 <b1d41989-7f4f-eb1d-db35-07a6f6b7a7f5@linux.ibm.com>
 <436fa401-e113-0393-f47a-ed23890364d7@linux.ibm.com>
 <39dfc425-deff-2469-7bcb-4a0e177b31d1@linux.ibm.com>
 <YzGhUZJKV3pKJL3Z@hirez.programming.kicks-ass.net>
 <66463973-923f-624d-3041-72ce76147b3e@linux.ibm.com>
 <YzGrJSLXpocpGIha@hirez.programming.kicks-ass.net>
 <9ec643f3-b935-0119-d8bc-1fbe46c36356@linux.ibm.com>
 <YzHqNiRj2Q5vxdCV@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzHqNiRj2Q5vxdCV@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 08:06:46PM +0200, Peter Zijlstra wrote:

> Let me go git-grep some to see if there's more similar fail.

I've ended up with the below...

---
 include/linux/wait.h | 2 +-
 kernel/hung_task.c   | 8 ++++++--
 kernel/sched/core.c  | 2 +-
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/linux/wait.h b/include/linux/wait.h
index 14ad8a0e9fac..7f5a51aae0a7 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -281,7 +281,7 @@ static inline void wake_up_pollfree(struct wait_queue_head *wq_head)
 
 #define ___wait_is_interruptible(state)						\
 	(!__builtin_constant_p(state) ||					\
-		state == TASK_INTERRUPTIBLE || state == TASK_KILLABLE)		\
+	 (state & (TASK_INTERRUPTIBLE | TASK_WAKEKILL)))
 
 extern void init_wait_entry(struct wait_queue_entry *wq_entry, int flags);
 
diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index f1321c03c32a..4a8a713fd67b 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -191,6 +191,8 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
 	hung_task_show_lock = false;
 	rcu_read_lock();
 	for_each_process_thread(g, t) {
+		unsigned int state;
+
 		if (!max_count--)
 			goto unlock;
 		if (time_after(jiffies, last_break + HUNG_TASK_LOCK_BREAK)) {
@@ -198,8 +200,10 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
 				goto unlock;
 			last_break = jiffies;
 		}
-		/* use "==" to skip the TASK_KILLABLE tasks waiting on NFS */
-		if (READ_ONCE(t->__state) == TASK_UNINTERRUPTIBLE)
+		/* skip the TASK_KILLABLE tasks -- these can be killed */
+		state == READ_ONCE(t->__state);
+		if ((state & TASK_UNINTERRUPTIBLE) &&
+		    !(state & TASK_WAKEKILL))
 			check_hung_task(t, timeout);
 	}
  unlock:
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1095917ed048..12ee5b98e2c4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8885,7 +8885,7 @@ state_filter_match(unsigned long state_filter, struct task_struct *p)
 	 * When looking for TASK_UNINTERRUPTIBLE skip TASK_IDLE (allows
 	 * TASK_KILLABLE).
 	 */
-	if (state_filter == TASK_UNINTERRUPTIBLE && state == TASK_IDLE)
+	if (state_filter == TASK_UNINTERRUPTIBLE && state & TASK_NOLOAD)
 		return false;
 
 	return true;

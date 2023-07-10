Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AFFE74CFA1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 10:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232777AbjGJIOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 04:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232938AbjGJINq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 04:13:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE0DDF;
        Mon, 10 Jul 2023 01:13:45 -0700 (PDT)
Date:   Mon, 10 Jul 2023 08:13:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1688976823;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w4fjr/kcovinH/IMzg7clUPUhwYxaQ0rX1o/NlWtv2I=;
        b=xAN99qqX1BoJZrohuoYPYVGDpIonWaj3jeSHfvJ5vNAmnSxS6j0J5KsqyxPKnNI7LDmleh
        EFxwb52UJFdypLKmxfFvfgAEGDWUdPTyN1q3fZ1uKpYnif9jrmAlvAinEVlAgMiMFRl4gC
        IXybSgv8xWGhPuSOJhjQ8JGG91ncvQSe5bLlpI5EJOwrlIUFTskEs3cnal7mNOBAPuHPRM
        HPP6XMng18ED7u/URCQy/4SQSOuRMdB5KSNzEURZ0mK+0uTKRZPBU+Ny0BFNw04HeeGtTC
        xPa3F6sD91k5X/2ZS3/7uQGRO9yffeO9efzyMwQc23Fb/RmolHl0fDQdz0HP1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1688976823;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w4fjr/kcovinH/IMzg7clUPUhwYxaQ0rX1o/NlWtv2I=;
        b=i/kcXMv03TSszfKwbfAVVZToqqurdKWvhTaaZxgWSM1rD2kunXWP/+8PUjfeD1Ck0wW6ke
        07F0hDI34E4CSjAQ==
From:   "tip-bot2 for Suren Baghdasaryan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/psi: use kernfs polling functions for PSI
 trigger polling
Cc:     Lu Jialin <lujialin4@huawei.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230630005612.1014540-1-surenb@google.com>
References: <20230630005612.1014540-1-surenb@google.com>
MIME-Version: 1.0
Message-ID: <168897682262.404.10162402491972251982.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     aff037078ecaecf34a7c2afab1341815f90fba5e
Gitweb:        https://git.kernel.org/tip/aff037078ecaecf34a7c2afab1341815f90fba5e
Author:        Suren Baghdasaryan <surenb@google.com>
AuthorDate:    Thu, 29 Jun 2023 17:56:12 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 10 Jul 2023 09:52:30 +02:00

sched/psi: use kernfs polling functions for PSI trigger polling

Destroying psi trigger in cgroup_file_release causes UAF issues when
a cgroup is removed from under a polling process. This is happening
because cgroup removal causes a call to cgroup_file_release while the
actual file is still alive. Destroying the trigger at this point would
also destroy its waitqueue head and if there is still a polling process
on that file accessing the waitqueue, it will step on the freed pointer:

do_select
  vfs_poll
                           do_rmdir
                             cgroup_rmdir
                               kernfs_drain_open_files
                                 cgroup_file_release
                                   cgroup_pressure_release
                                     psi_trigger_destroy
                                       wake_up_pollfree(&t->event_wait)
// vfs_poll is unblocked
                                       synchronize_rcu
                                       kfree(t)
  poll_freewait -> UAF access to the trigger's waitqueue head

Patch [1] fixed this issue for epoll() case using wake_up_pollfree(),
however the same issue exists for synchronous poll() case.
The root cause of this issue is that the lifecycles of the psi trigger's
waitqueue and of the file associated with the trigger are different. Fix
this by using kernfs_generic_poll function when polling on cgroup-specific
psi triggers. It internally uses kernfs_open_node->poll waitqueue head
with its lifecycle tied to the file's lifecycle. This also renders the
fix in [1] obsolete, so revert it.

[1] commit c2dbe32d5db5 ("sched/psi: Fix use-after-free in ep_remove_wait_queue()")

Fixes: 0e94682b73bf ("psi: introduce psi monitor")
Closes: https://lore.kernel.org/all/20230613062306.101831-1-lujialin4@huawei.com/
Reported-by: Lu Jialin <lujialin4@huawei.com>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20230630005612.1014540-1-surenb@google.com
---
 include/linux/psi.h       |  5 +++--
 include/linux/psi_types.h |  3 +++
 kernel/cgroup/cgroup.c    |  2 +-
 kernel/sched/psi.c        | 29 +++++++++++++++++++++--------
 4 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/include/linux/psi.h b/include/linux/psi.h
index ab26200..e074587 100644
--- a/include/linux/psi.h
+++ b/include/linux/psi.h
@@ -23,8 +23,9 @@ void psi_memstall_enter(unsigned long *flags);
 void psi_memstall_leave(unsigned long *flags);
 
 int psi_show(struct seq_file *s, struct psi_group *group, enum psi_res res);
-struct psi_trigger *psi_trigger_create(struct psi_group *group,
-			char *buf, enum psi_res res, struct file *file);
+struct psi_trigger *psi_trigger_create(struct psi_group *group, char *buf,
+				       enum psi_res res, struct file *file,
+				       struct kernfs_open_file *of);
 void psi_trigger_destroy(struct psi_trigger *t);
 
 __poll_t psi_trigger_poll(void **trigger_ptr, struct file *file,
diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
index 040c089..f1fd3a8 100644
--- a/include/linux/psi_types.h
+++ b/include/linux/psi_types.h
@@ -137,6 +137,9 @@ struct psi_trigger {
 	/* Wait queue for polling */
 	wait_queue_head_t event_wait;
 
+	/* Kernfs file for cgroup triggers */
+	struct kernfs_open_file *of;
+
 	/* Pending event flag */
 	int event;
 
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index bfe3cd8..f55a40d 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -3730,7 +3730,7 @@ static ssize_t pressure_write(struct kernfs_open_file *of, char *buf,
 	}
 
 	psi = cgroup_psi(cgrp);
-	new = psi_trigger_create(psi, buf, res, of->file);
+	new = psi_trigger_create(psi, buf, res, of->file, of);
 	if (IS_ERR(new)) {
 		cgroup_put(cgrp);
 		return PTR_ERR(new);
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 81fca77..9bb3f2b 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -493,8 +493,12 @@ static u64 update_triggers(struct psi_group *group, u64 now, bool *update_total,
 			continue;
 
 		/* Generate an event */
-		if (cmpxchg(&t->event, 0, 1) == 0)
-			wake_up_interruptible(&t->event_wait);
+		if (cmpxchg(&t->event, 0, 1) == 0) {
+			if (t->of)
+				kernfs_notify(t->of->kn);
+			else
+				wake_up_interruptible(&t->event_wait);
+		}
 		t->last_event_time = now;
 		/* Reset threshold breach flag once event got generated */
 		t->pending_event = false;
@@ -1271,8 +1275,9 @@ int psi_show(struct seq_file *m, struct psi_group *group, enum psi_res res)
 	return 0;
 }
 
-struct psi_trigger *psi_trigger_create(struct psi_group *group,
-			char *buf, enum psi_res res, struct file *file)
+struct psi_trigger *psi_trigger_create(struct psi_group *group, char *buf,
+				       enum psi_res res, struct file *file,
+				       struct kernfs_open_file *of)
 {
 	struct psi_trigger *t;
 	enum psi_states state;
@@ -1331,7 +1336,9 @@ struct psi_trigger *psi_trigger_create(struct psi_group *group,
 
 	t->event = 0;
 	t->last_event_time = 0;
-	init_waitqueue_head(&t->event_wait);
+	t->of = of;
+	if (!of)
+		init_waitqueue_head(&t->event_wait);
 	t->pending_event = false;
 	t->aggregator = privileged ? PSI_POLL : PSI_AVGS;
 
@@ -1388,7 +1395,10 @@ void psi_trigger_destroy(struct psi_trigger *t)
 	 * being accessed later. Can happen if cgroup is deleted from under a
 	 * polling process.
 	 */
-	wake_up_pollfree(&t->event_wait);
+	if (t->of)
+		kernfs_notify(t->of->kn);
+	else
+		wake_up_interruptible(&t->event_wait);
 
 	if (t->aggregator == PSI_AVGS) {
 		mutex_lock(&group->avgs_lock);
@@ -1465,7 +1475,10 @@ __poll_t psi_trigger_poll(void **trigger_ptr,
 	if (!t)
 		return DEFAULT_POLLMASK | EPOLLERR | EPOLLPRI;
 
-	poll_wait(file, &t->event_wait, wait);
+	if (t->of)
+		kernfs_generic_poll(t->of, wait);
+	else
+		poll_wait(file, &t->event_wait, wait);
 
 	if (cmpxchg(&t->event, 1, 0) == 1)
 		ret |= EPOLLPRI;
@@ -1535,7 +1548,7 @@ static ssize_t psi_write(struct file *file, const char __user *user_buf,
 		return -EBUSY;
 	}
 
-	new = psi_trigger_create(&psi_system, buf, res, file);
+	new = psi_trigger_create(&psi_system, buf, res, file, NULL);
 	if (IS_ERR(new)) {
 		mutex_unlock(&seq->lock);
 		return PTR_ERR(new);

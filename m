Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B96C66934A0
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 00:08:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjBKXIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 18:08:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjBKXIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 18:08:21 -0500
Received: from out-126.mta0.migadu.com (out-126.mta0.migadu.com [91.218.175.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26DF61B7
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 15:08:19 -0800 (PST)
Date:   Sat, 11 Feb 2023 18:08:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1676156895;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jeaoWPG8qKepOXCpHP3PyDGxt09p0/Rrs7H163Xd+js=;
        b=DarU0UB2DlLoHXCNgDs2QtsgHpACdjlnav1eTn8N2U9IcXU3fVuPqGhRUOQoXF+MpHrJxQ
        7K6Bs/PBYSGysCtjf47hmJVGaz5jk3hTxJiQ5CSJ4aGzvj76/+38DZkTEq6DuhTh8c3TLR
        ojPzF5B/YNoF/85pFZMmaiID9xvw3hM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Coly Li <colyli@suse.de>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzkaller <syzkaller@googlegroups.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Hillf Danton <hdanton@sina.com>
Subject: Re: [PATCH RFC] drivers/core: Replace lockdep_set_novalidate_class()
 with unique class keys
Message-ID: <Y+gf1SX9MXdBja1z@moria.home.lan>
References: <a67e24eb-b68f-2abc-50af-ae4c2d4cdd95@I-love.SAKURA.ne.jp>
 <20230208080739.1649-1-hdanton@sina.com>
 <1ad499bb-0c53-7529-ff00-e4328823f6fa@I-love.SAKURA.ne.jp>
 <Y+O6toMmAKBSILMf@rowland.harvard.edu>
 <f79e93ef-cfe8-1373-7c36-15d046c0e3c5@I-love.SAKURA.ne.jp>
 <Y+RZ2RKVo9FNMgSe@rowland.harvard.edu>
 <52c7d509-ba9e-a121-60c9-138d7ff3f667@I-love.SAKURA.ne.jp>
 <Y+gLd78vChQERZ6A@rowland.harvard.edu>
 <CAHk-=whXYzkOJZo0xpyYfrhWQg1M7j0OeCojTJ84CN4q9sqb2Q@mail.gmail.com>
 <109c3cc0-2c13-7452-4548-d0155c1aba10@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <109c3cc0-2c13-7452-4548-d0155c1aba10@gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 11, 2023 at 06:06:28PM -0500, Kent Overstreet wrote:
> Yeah, what bcache really needs (and presumably dev->mutex as well) is just
> to disable lockdep checking for self-deadlock of that lock type, since it's
> got its own deadlock avoidance and the subclass thing isn't good enough.
> 
> I've got a patch that should do what we want, replying from my other account
> with it.
-- >8 --
Subject: [PATCH] locking/lockdep: lockdep_set_no_check_recursion()

This adds a method to tell lockdep not to check lock ordering within a
lock class - but to still check lock ordering w.r.t. other lock types.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 include/linux/lockdep.h       |  6 ++++++
 include/linux/lockdep_types.h |  2 +-
 kernel/locking/lockdep.c      | 26 ++++++++++++++++++++++++++
 3 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index e027c504b7..66f28553c6 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -666,4 +666,10 @@ lockdep_rcu_suspicious(const char *file, const int line, const char *s)
 }
 #endif
 
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+void lockdep_set_no_check_recursion(struct lockdep_map *map);
+#else
+static inline void lockdep_set_no_check_recursion(struct lockdep_map *map) {}
+#endif
+
 #endif /* __LINUX_LOCKDEP_H */
diff --git a/include/linux/lockdep_types.h b/include/linux/lockdep_types.h
index d22430840b..506e769b4a 100644
--- a/include/linux/lockdep_types.h
+++ b/include/linux/lockdep_types.h
@@ -128,7 +128,7 @@ struct lock_class {
 	u8				wait_type_inner;
 	u8				wait_type_outer;
 	u8				lock_type;
-	/* u8				hole; */
+	u8				no_check_recursion;
 
 #ifdef CONFIG_LOCK_STAT
 	unsigned long			contention_point[LOCKSTAT_POINTS];
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index cae7d5f0ad..47ffb8df11 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -3023,6 +3023,9 @@ check_deadlock(struct task_struct *curr, struct held_lock *next)
 		if ((next->read == 2) && prev->read)
 			continue;
 
+		if (hlock_class(next)->no_check_recursion)
+			continue;
+
 		/*
 		 * We're holding the nest_lock, which serializes this lock's
 		 * nesting behaviour.
@@ -3084,6 +3087,10 @@ check_prev_add(struct task_struct *curr, struct held_lock *prev,
 		return 2;
 	}
 
+	if (hlock_class(prev) == hlock_class(next) &&
+	    hlock_class(prev)->no_check_recursion)
+		return 2;
+
 	/*
 	 * Prove that the new <prev> -> <next> dependency would not
 	 * create a circular dependency in the graph. (We do this by
@@ -6617,3 +6624,22 @@ void lockdep_rcu_suspicious(const char *file, const int line, const char *s)
 	dump_stack();
 }
 EXPORT_SYMBOL_GPL(lockdep_rcu_suspicious);
+
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+void lockdep_set_no_check_recursion(struct lockdep_map *lock)
+{
+	struct lock_class *class = lock->class_cache[0];
+	unsigned long flags;
+
+	raw_local_irq_save(flags);
+	lockdep_recursion_inc();
+
+	if (!class)
+		class = register_lock_class(lock, 0, 0);
+	if (class)
+		class->no_check_recursion = true;
+	lockdep_recursion_finish();
+	raw_local_irq_restore(flags);
+}
+EXPORT_SYMBOL_GPL(lockdep_set_no_check_recursion);
+#endif
-- 
2.39.1



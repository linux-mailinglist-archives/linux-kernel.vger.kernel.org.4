Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE5E96988C6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 00:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjBOXau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 18:30:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjBOXas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 18:30:48 -0500
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF10A4345F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 15:30:46 -0800 (PST)
Received: by mail-pl1-f173.google.com with SMTP id e12so299544plh.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 15:30:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IYpOhhIEgwbdz7ErS+29oI5s4e0IJn1DFxOYnwu0yoA=;
        b=B9htkcuJndLZVWFzaZa1dkZRsmhfvpELoKmeKqt1U1nueesqw4cd8/Nb01D4BoQ7pO
         uBJjQraH3+Nw3h6FVkFMPcCquf//Y5zxzT0uqFpVWd5seltwvinUD3xIf3IoQ72af2DW
         K2Ix0Uwg81CnZ61UlpLzLmMr1e5rfl+HF5rHn38EsHGMkhnJJKqn82rkg/tJdsh/9jFv
         QdhWz/GqiO6YqjcbrdGZse/4J7ax/OHOMlTIWgYlE/DmpjdgGcMycrW9YQF1Pc63NTZf
         404xfMW4Iknh018+/vMGN7fhjSxizuxHEmX6bX+PDPpKQ3fQ4370pmuSPsiTw3XM1RWt
         pgWw==
X-Gm-Message-State: AO0yUKV2PuTFRb3Tkmu25lu8TlVV1D9DM4JLlDQsJG2A1KK410ism9bN
        E3l6T/cA+pJ4J8Wauw5ziyc=
X-Google-Smtp-Source: AK7set80nWQi1yABYsXEpmQveB6bTjC86fHzmvynMFVBtJEhMPq8I2J4tlQtMfmFxO88DnSBw7il5Q==
X-Received: by 2002:a17:90b:3806:b0:22c:7639:a910 with SMTP id mq6-20020a17090b380600b0022c7639a910mr4778626pjb.25.1676503845945;
        Wed, 15 Feb 2023 15:30:45 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::5:e03a])
        by smtp.gmail.com with ESMTPSA id x9-20020a63b349000000b004f1e87530cesm10788406pgt.91.2023.02.15.15.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 15:30:45 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org
Cc:     rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, kernel-team@meta.com,
        torvalds@linux-foundation.org, ebiederm@xmission.com,
        oleg@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH] tasks: Extract rcu_users out of union
Date:   Wed, 15 Feb 2023 17:30:33 -0600
Message-Id: <20230215233033.889644-1-void@manifault.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 3fbd7ee285b2b ("tasks: Add a count of task RCU users"), a
count on the number of RCU users was added to struct task_struct. This
was done so as to enable the removal of task_rcu_dereference(), and
allow tasks to be protected by RCU even after exiting and being removed
from the runqueue. In this commit, the 'refcount_t rcu_users' field that
keeps track of this refcount was put into a union co-located with
'struct rcu_head rcu', so as to avoid taking up any extra space in
task_struct. This was possible to do safely, because the field was only
ever decremented by a static set of specific callers, and then never
incremented again.

While this restriction of there only being a small, static set of users
of this field has worked fine, it prevents us from leveraging the field
to use RCU to protect tasks in other contexts.

During tracing, for example, it would be useful to be able to collect
some tasks that performed a certain operation, put them in a map, and
then periodically summarize who they are, which cgroup they're in, how
much CPU time they've utilized, etc. While this can currently be done
with 'usage', it becomes tricky when a task is already in a map, or if a
reference should only be taken if a task is valid and will not soon be
reaped. Ideally, we could do something like pass a reference to a map
value, and then try to acquire a reference to the task in an RCU read
region by using refcount_inc_not_zero().

Similarly, in sched_ext, schedulers are using integer pids to remember
tasks, and then looking them up with find_task_by_pid_ns(). This is
slow, error prone, and adds complexity. It would be more convenient and
performant if BPF schedulers could instead store tasks directly in maps,
and then leverage RCU to ensure they can be safely accessed with low
overhead.

Finally, overloading fields like this is error prone. Someone that wants
to use 'rcu_users' could easily overlook the fact that once the rcu
callback is scheduled, the refcount will go back to being nonzero, thus
precluding the use of refcount_inc_not_zero(). Furthermore, as described
below, it's possible to extract the fields of the union without changing
the size of task_struct.

There are several possible ways to enable this:

1. The lightest touch approach is likely the one proposed in this patch,
   which is to simply extract 'rcu_users' and 'rcu' from the union, so
   that scheduling the 'rcu' callback doesn't overwrite the 'rcu_users'
   refcount. If we have a trusted task pointer, this would allow us to
   use refcnt_inc_not_zero() inside of an RCU region to determine if we
   can safely acquire a reference to the task and store it in a map. As
   mentioned below, this can be done without changing the size of
   task_struct, by moving the location of the union to another location
   that has padding gaps we can fill in.

2. Removing 'refcount_t rcu_users', and instead having the entire task
   be freed in an rcu callback. This is likely the most sound overall
   design, though it changes the behavioral semantics exposed to
   callers, who currently expect that a task that's successfully looked
   up in e.g. the pid_list with find_task_by_pid_ns(), can always have a
   'usage' reference acquired on them, as it's guaranteed to be >
   0 until after the next gp. In order for this approach to work, we'd
   have to audit all callers. This approach also slightly changes
   behavior observed by user space by not invoking
   trace_sched_process_free() until the whole task_struct is actually being
   freed, rather than just after it's exited. It also may change
   timings, as memory will be freed in an RCU callback rather than
   immediately when the final 'usage' refcount drops to 0. This also is
   arguably a benefit, as it provides more predictable performance to
   callers who are refcounting tasks.

3. There may be other solutions as well that don't require changing the
   layout of task_struct. For example, we could possibly do something
   complex from the BPF side, such as listen for task exit and remove a
   task from a map when the task is exiting. This would likely require
   significant custom handling for task_struct in the verifier, so a
   more generalizable solution is likely warranted.

As mentioned above, this patch proposes the lightest-touch approach
which allows callers elsewhere in the kernel to use 'rcu_users' to
ensure the lifetime of a task, by extracting 'rcu_users' and 'rcu' from
the union. There is no size change in task_struct with this patch.

Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>
Signed-off-by: David Vernet <void@manifault.com>
---
 include/linux/sched.h | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 4df2b3e76b30..1ab082c9d562 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1318,11 +1318,6 @@ struct task_struct {
 
 	struct tlbflush_unmap_batch	tlb_ubc;
 
-	union {
-		refcount_t		rcu_users;
-		struct rcu_head		rcu;
-	};
-
 	/* Cache last used pipe for splice(): */
 	struct pipe_inode_info		*splice_pipe;
 
@@ -1459,6 +1454,8 @@ struct task_struct {
 	unsigned long			saved_state_change;
 # endif
 #endif
+	struct rcu_head			rcu;
+	refcount_t			rcu_users;
 	int				pagefault_disabled;
 #ifdef CONFIG_MMU
 	struct task_struct		*oom_reaper_list;
-- 
2.39.0


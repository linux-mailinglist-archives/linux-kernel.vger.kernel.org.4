Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF7336C25B2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 00:37:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjCTXhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 19:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjCTXhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 19:37:36 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED6331E38
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 16:37:33 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id s3-20020a632c03000000b0050300a8089aso3013254pgs.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 16:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679355453;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MCz4IwNxm3CO2/v3LkVI4pj4nAJZg4E6BpR/zMapMlw=;
        b=KSsEJIPRq2Y9zTLgQrB8V4MwfgeziPfrZbdI1uJi7RicmTnJDekbv634If36SOi9Fo
         x+DdA+GfDL990k9c0eiK9MGe/TIkJc3RAwQMrpUO0MFQPYE187AWWcdztx4ApZmX9AUh
         j6l174cqyrHdiX3ExY91cys7HZdEGq0zA8NbVl/whxI6pqnj61NoulDZhfDL1vkuEyll
         bgVmQxLY+zpmuu6elJzCiGkmTSHZPq+dVBkkfo/EY03Q8hCV1t6/b5P0fITjF274Qm9f
         RQaeMqGFQkumru9qiLh0eLaotwdbMM7/k4EvLwqiSfBCbaMqSGK6R97X1BKoshl4+zuL
         wIjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679355453;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MCz4IwNxm3CO2/v3LkVI4pj4nAJZg4E6BpR/zMapMlw=;
        b=Rh8SLgJjx8MYNjt55DcLz+sQA12LvNoPL5N0IXEav9AigXZyaB4UmuIJZAdBFD/nvE
         h6S9MnXpPacPBskgUugV1lZA7JNPpYH+4juNexRequTCHTlJrkH9gaW0onM8xEn2S+5q
         hvTdeuW+xDE0+m2u8sELxWMeZYFGpkmE/Ig4e25UsFwtOwXSelVBm+ZDlpyWl0u/SAaG
         lu/6BkknrSs1uC/osnUowsdCHx8c6hqKtPV1ekVXTF0gQ3eBNpgGTCrOQ9XqqVjGFD7i
         /OotXY/Sf0uumT+376OsXf4XbGbXBRAQpZ5cSldVdCN0LSB58BHdOjQOJFimGKquNq/f
         BJ8g==
X-Gm-Message-State: AO0yUKX5cqPJ2uNpwcxNHDZC+lXFqLDIuIg1FEckvmj5boOHQYC5s5EM
        1TzqOOhOwoQglO8RUYfHqDGNiqZZIWgj21rE9llJgLN6Dai4BfXHwyM7SJlQyjGP/cbmKB6uhEU
        HkYfeydfy1iPAan3ggcFaSTnzlxWyTbeawNdkrCMb9+2c9G2/h+fW+oYht5kZKEKMpUOi78w=
X-Google-Smtp-Source: AK7set/MkzlAhXfV+HRaoV78h14/ZgoKwUVnSX0/iAm1BzCg9ZJSzYHCcu7+mMOUexih4A9i3CCj0fHjcLlp
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a65:5205:0:b0:503:7cc9:3f8d with SMTP id
 o5-20020a655205000000b005037cc93f8dmr108548pgp.9.1679355452949; Mon, 20 Mar
 2023 16:37:32 -0700 (PDT)
Date:   Mon, 20 Mar 2023 23:37:09 +0000
In-Reply-To: <20230320233720.3488453-1-jstultz@google.com>
Mime-Version: 1.0
References: <20230320233720.3488453-1-jstultz@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230320233720.3488453-2-jstultz@google.com>
Subject: [PATCH v2 01/12] locking/ww_mutex: Remove wakeups from under mutex::wait_lock
From:   John Stultz <jstultz@google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Joel Fernandes <joelaf@google.com>,
        Qais Yousef <qyousef@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, kernel-team@android.com,
        "Connor O'Brien" <connoro@google.com>,
        John Stultz <jstultz@google.com>
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

From: Peter Zijlstra <peterz@infradead.org>

In preparation to nest mutex::wait_lock under rq::lock we need to remove
wakeups from under it.

Cc: Joel Fernandes <joelaf@google.com>
Cc: Qais Yousef <qyousef@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Zimuzo Ezeozue <zezeozue@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>
Cc: kernel-team@android.com
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Connor O'Brien <connoro@google.com>
Signed-off-by: John Stultz <jstultz@google.com>
---
v2:
* Move wake_q_init() as suggested by Waiman Long
---
 include/linux/ww_mutex.h  |  3 +++
 kernel/locking/mutex.c    |  8 ++++++++
 kernel/locking/ww_mutex.h | 10 ++++++++--
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/include/linux/ww_mutex.h b/include/linux/ww_mutex.h
index bb763085479a..9335b2202017 100644
--- a/include/linux/ww_mutex.h
+++ b/include/linux/ww_mutex.h
@@ -19,6 +19,7 @@
 
 #include <linux/mutex.h>
 #include <linux/rtmutex.h>
+#include <linux/sched/wake_q.h>
 
 #if defined(CONFIG_DEBUG_MUTEXES) || \
    (defined(CONFIG_PREEMPT_RT) && defined(CONFIG_DEBUG_RT_MUTEXES))
@@ -58,6 +59,7 @@ struct ww_acquire_ctx {
 	unsigned int acquired;
 	unsigned short wounded;
 	unsigned short is_wait_die;
+	struct wake_q_head wake_q;
 #ifdef DEBUG_WW_MUTEXES
 	unsigned int done_acquire;
 	struct ww_class *ww_class;
@@ -137,6 +139,7 @@ static inline void ww_acquire_init(struct ww_acquire_ctx *ctx,
 	ctx->acquired = 0;
 	ctx->wounded = false;
 	ctx->is_wait_die = ww_class->is_wait_die;
+	wake_q_init(&ctx->wake_q);
 #ifdef DEBUG_WW_MUTEXES
 	ctx->ww_class = ww_class;
 	ctx->done_acquire = 0;
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index d973fe6041bf..1582756914df 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -676,6 +676,8 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 		}
 
 		raw_spin_unlock(&lock->wait_lock);
+		if (ww_ctx)
+			ww_ctx_wake(ww_ctx);
 		schedule_preempt_disabled();
 
 		first = __mutex_waiter_is_first(lock, &waiter);
@@ -725,6 +727,8 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 		ww_mutex_lock_acquired(ww, ww_ctx);
 
 	raw_spin_unlock(&lock->wait_lock);
+	if (ww_ctx)
+		ww_ctx_wake(ww_ctx);
 	preempt_enable();
 	return 0;
 
@@ -736,6 +740,8 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 	raw_spin_unlock(&lock->wait_lock);
 	debug_mutex_free_waiter(&waiter);
 	mutex_release(&lock->dep_map, ip);
+	if (ww_ctx)
+		ww_ctx_wake(ww_ctx);
 	preempt_enable();
 	return ret;
 }
@@ -946,9 +952,11 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
 	if (owner & MUTEX_FLAG_HANDOFF)
 		__mutex_handoff(lock, next);
 
+	preempt_disable();
 	raw_spin_unlock(&lock->wait_lock);
 
 	wake_up_q(&wake_q);
+	preempt_enable();
 }
 
 #ifndef CONFIG_DEBUG_LOCK_ALLOC
diff --git a/kernel/locking/ww_mutex.h b/kernel/locking/ww_mutex.h
index 56f139201f24..e49ea5336473 100644
--- a/kernel/locking/ww_mutex.h
+++ b/kernel/locking/ww_mutex.h
@@ -161,6 +161,12 @@ static inline void lockdep_assert_wait_lock_held(struct rt_mutex *lock)
 
 #endif /* WW_RT */
 
+void ww_ctx_wake(struct ww_acquire_ctx *ww_ctx)
+{
+	wake_up_q(&ww_ctx->wake_q);
+	wake_q_init(&ww_ctx->wake_q);
+}
+
 /*
  * Wait-Die:
  *   The newer transactions are killed when:
@@ -284,7 +290,7 @@ __ww_mutex_die(struct MUTEX *lock, struct MUTEX_WAITER *waiter,
 #ifndef WW_RT
 		debug_mutex_wake_waiter(lock, waiter);
 #endif
-		wake_up_process(waiter->task);
+		wake_q_add(&ww_ctx->wake_q, waiter->task);
 	}
 
 	return true;
@@ -331,7 +337,7 @@ static bool __ww_mutex_wound(struct MUTEX *lock,
 		 * wakeup pending to re-read the wounded state.
 		 */
 		if (owner != current)
-			wake_up_process(owner);
+			wake_q_add(&ww_ctx->wake_q, owner);
 
 		return true;
 	}
-- 
2.40.0.rc1.284.g88254d51c5-goog


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0E3B708CBE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 02:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbjESASQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 20:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbjESASA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 20:18:00 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1811727
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 17:17:52 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-64354231003so210079b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 17:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684455471; x=1687047471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iX/ZhpMzXlbbJY0luxFlzfIl6BBtLUXwU2QHcxfRKvY=;
        b=XSI7NB1eZIyPUdckMD/JKLwuf0cXmzkCddY5ocuvHZePKVRzHI/hlogPoLC0eULt45
         Klz/uMPHW9KQq0Q1P3EOB1txlfRd8kKpmHw+rS39NId3l64qd3i/z7R/0hqTW9YXDgms
         DHteB4158+2FF09x0Ji/jxX1l33Uhs5scrwIzGhT+DMOGD9+W6Zt8nznh8h7HnmXkvHz
         Jhv8RgBqcj6zBLlbv1s0l3Q6Q+lfijyqThAH4/+UPjyiVLf4m0Ml/jWNHx4Bnp5Z38b6
         XDY2XRYKlnlVu1VeRDFbck9uoKGgCGC9bhRsUQhGu5A+Y67YCV8RFXnUWKm3whSvNVBm
         2lgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684455471; x=1687047471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iX/ZhpMzXlbbJY0luxFlzfIl6BBtLUXwU2QHcxfRKvY=;
        b=QmlbyhurBtY38jME5UmdG3L8q3uaC0pr+ZYltVJldJOIFJ9Ek5WefvX3wMbgiKpsrv
         ep3mWWO/yjTofGbLCPNYm2ftcmK8A/XECY/CQIEekYidv90tgzkxJUf1we+aatZdPY29
         nNXsZDVikWVk3uJkbcDkqvG0bl6B8S9zdeOkICSvLBVGDF5YW9r4E8jQcJ6EP33sVLVd
         Zbx0tBuJFNjjyzQAJ+4ryFmflNg1ZVGmhpe4IBiCet5+230nUOdtrsKxK2R97nD+r2zy
         ABU24zidbkBjBc1rRrDQLN08gjCoxRVGBPawQdumQ78JByv1XiFMsm1gK3RQRzy/Mkkk
         2tNg==
X-Gm-Message-State: AC+VfDzk4N5D98+z4OGM/azKMs47EZVZRI3vTqSY2ZJY8g8O0idfFUxA
        RKen02YwTTGsV9hkthr21P8=
X-Google-Smtp-Source: ACHHUZ5tpeF4eHdHEcVMAXvkOZ0/X4uiLMAJCujAI6XoNwcFHdhwPA/9agal0z1LT5+q3RngdVww0g==
X-Received: by 2002:a05:6a00:1486:b0:5a8:9858:750a with SMTP id v6-20020a056a00148600b005a89858750amr794908pfu.13.1684455471127;
        Thu, 18 May 2023 17:17:51 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id e21-20020a62ee15000000b0062cf75a9e6bsm1847518pfi.131.2023.05.18.17.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 17:17:50 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     jiangshanlai@gmail.com
Cc:     torvalds@linux-foundation.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        joshdon@google.com, brho@google.com, briannorris@chromium.org,
        nhuck@google.com, agk@redhat.com, snitzer@kernel.org,
        void@manifault.com, Tejun Heo <tj@kernel.org>
Subject: [PATCH 08/24] workqueue: Make per-cpu pool_workqueues allocated and released like unbound ones
Date:   Thu, 18 May 2023 14:16:53 -1000
Message-Id: <20230519001709.2563-9-tj@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230519001709.2563-1-tj@kernel.org>
References: <20230519001709.2563-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, all per-cpu pwq's (pool_workqueue's) are allocated directly
through a per-cpu allocation and thus, unlike unbound workqueues, not
reference counted. This difference in lifetime management between the two
types is a bit confusing.

Unbound workqueues are currently accessed through wq->numa_pwq_tbl[] which
isn't suitiable for the planned CPU locality related improvements. The plan
is to unify pwq handling across per-cpu and unbound workqueues so that
they're always accessed through wq->cpu_pwq.

In preparation, this patch makes per-cpu pwq's to be allocated, reference
counted and released the same way as unbound pwq's. wq->cpu_pwq now holds
pointers to pwq's instead of containing them directly.

pwq_unbound_release_workfn() is renamed to pwq_release_workfn() as it's now
also used for per-cpu work items.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/workqueue.c | 74 +++++++++++++++++++++++++---------------------
 1 file changed, 40 insertions(+), 34 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 7addda9b37b9..574d2e12417d 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -257,11 +257,11 @@ struct pool_workqueue {
 
 	/*
 	 * Release of unbound pwq is punted to a kthread_worker. See put_pwq()
-	 * and pwq_unbound_release_workfn() for details. pool_workqueue itself
-	 * is also RCU protected so that the first pwq can be determined without
+	 * and pwq_release_workfn() for details. pool_workqueue itself is also
+	 * RCU protected so that the first pwq can be determined without
 	 * grabbing wq->mutex.
 	 */
-	struct kthread_work	unbound_release_work;
+	struct kthread_work	release_work;
 	struct rcu_head		rcu;
 } __aligned(1 << WORK_STRUCT_FLAG_BITS);
 
@@ -320,7 +320,7 @@ struct workqueue_struct {
 
 	/* hot fields used during command issue, aligned to cacheline */
 	unsigned int		flags ____cacheline_aligned; /* WQ: WQ_* flags */
-	struct pool_workqueue __percpu *cpu_pwq; /* I: per-cpu pwqs */
+	struct pool_workqueue __percpu **cpu_pwq; /* I: per-cpu pwqs */
 	struct pool_workqueue __rcu *numa_pwq_tbl[]; /* PWR: unbound pwqs indexed by node */
 };
 
@@ -1351,13 +1351,11 @@ static void put_pwq(struct pool_workqueue *pwq)
 	lockdep_assert_held(&pwq->pool->lock);
 	if (likely(--pwq->refcnt))
 		return;
-	if (WARN_ON_ONCE(!(pwq->wq->flags & WQ_UNBOUND)))
-		return;
 	/*
 	 * @pwq can't be released under pool->lock, bounce to a dedicated
 	 * kthread_worker to avoid A-A deadlocks.
 	 */
-	kthread_queue_work(pwq_release_worker, &pwq->unbound_release_work);
+	kthread_queue_work(pwq_release_worker, &pwq->release_work);
 }
 
 /**
@@ -1666,7 +1664,7 @@ static void __queue_work(int cpu, struct workqueue_struct *wq,
 	} else {
 		if (req_cpu == WORK_CPU_UNBOUND)
 			cpu = raw_smp_processor_id();
-		pwq = per_cpu_ptr(wq->cpu_pwq, cpu);
+		pwq = *per_cpu_ptr(wq->cpu_pwq, cpu);
 	}
 
 	pool = pwq->pool;
@@ -3987,31 +3985,30 @@ static void rcu_free_pwq(struct rcu_head *rcu)
  * Scheduled on pwq_release_worker by put_pwq() when an unbound pwq hits zero
  * refcnt and needs to be destroyed.
  */
-static void pwq_unbound_release_workfn(struct kthread_work *work)
+static void pwq_release_workfn(struct kthread_work *work)
 {
 	struct pool_workqueue *pwq = container_of(work, struct pool_workqueue,
-						  unbound_release_work);
+						  release_work);
 	struct workqueue_struct *wq = pwq->wq;
 	struct worker_pool *pool = pwq->pool;
 	bool is_last = false;
 
 	/*
-	 * when @pwq is not linked, it doesn't hold any reference to the
+	 * When @pwq is not linked, it doesn't hold any reference to the
 	 * @wq, and @wq is invalid to access.
 	 */
 	if (!list_empty(&pwq->pwqs_node)) {
-		if (WARN_ON_ONCE(!(wq->flags & WQ_UNBOUND)))
-			return;
-
 		mutex_lock(&wq->mutex);
 		list_del_rcu(&pwq->pwqs_node);
 		is_last = list_empty(&wq->pwqs);
 		mutex_unlock(&wq->mutex);
 	}
 
-	mutex_lock(&wq_pool_mutex);
-	put_unbound_pool(pool);
-	mutex_unlock(&wq_pool_mutex);
+	if (wq->flags & WQ_UNBOUND) {
+		mutex_lock(&wq_pool_mutex);
+		put_unbound_pool(pool);
+		mutex_unlock(&wq_pool_mutex);
+	}
 
 	call_rcu(&pwq->rcu, rcu_free_pwq);
 
@@ -4095,8 +4092,7 @@ static void init_pwq(struct pool_workqueue *pwq, struct workqueue_struct *wq,
 	INIT_LIST_HEAD(&pwq->inactive_works);
 	INIT_LIST_HEAD(&pwq->pwqs_node);
 	INIT_LIST_HEAD(&pwq->mayday_node);
-	kthread_init_work(&pwq->unbound_release_work,
-			  pwq_unbound_release_workfn);
+	kthread_init_work(&pwq->release_work, pwq_release_workfn);
 }
 
 /* sync @pwq with the current state of its associated wq and link it */
@@ -4497,20 +4493,25 @@ static int alloc_and_link_pwqs(struct workqueue_struct *wq)
 	int cpu, ret;
 
 	if (!(wq->flags & WQ_UNBOUND)) {
-		wq->cpu_pwq = alloc_percpu(struct pool_workqueue);
+		wq->cpu_pwq = alloc_percpu(struct pool_workqueue *);
 		if (!wq->cpu_pwq)
-			return -ENOMEM;
+			goto enomem;
 
 		for_each_possible_cpu(cpu) {
-			struct pool_workqueue *pwq =
+			struct pool_workqueue **pwq_p =
 				per_cpu_ptr(wq->cpu_pwq, cpu);
-			struct worker_pool *cpu_pools =
-				per_cpu(cpu_worker_pools, cpu);
+			struct worker_pool *pool =
+				&(per_cpu_ptr(cpu_worker_pools, cpu)[highpri]);
 
-			init_pwq(pwq, wq, &cpu_pools[highpri]);
+			*pwq_p = kmem_cache_alloc_node(pwq_cache, GFP_KERNEL,
+						       pool->node);
+			if (!*pwq_p)
+				goto enomem;
+
+			init_pwq(*pwq_p, wq, pool);
 
 			mutex_lock(&wq->mutex);
-			link_pwq(pwq);
+			link_pwq(*pwq_p);
 			mutex_unlock(&wq->mutex);
 		}
 		return 0;
@@ -4529,6 +4530,15 @@ static int alloc_and_link_pwqs(struct workqueue_struct *wq)
 	cpus_read_unlock();
 
 	return ret;
+
+enomem:
+	if (wq->cpu_pwq) {
+		for_each_possible_cpu(cpu)
+			kfree(*per_cpu_ptr(wq->cpu_pwq, cpu));
+		free_percpu(wq->cpu_pwq);
+		wq->cpu_pwq = NULL;
+	}
+	return -ENOMEM;
 }
 
 static int wq_clamp_max_active(int max_active, unsigned int flags,
@@ -4702,7 +4712,7 @@ static bool pwq_busy(struct pool_workqueue *pwq)
 void destroy_workqueue(struct workqueue_struct *wq)
 {
 	struct pool_workqueue *pwq;
-	int node;
+	int cpu, node;
 
 	/*
 	 * Remove it from sysfs first so that sanity check failure doesn't
@@ -4762,12 +4772,8 @@ void destroy_workqueue(struct workqueue_struct *wq)
 	mutex_unlock(&wq_pool_mutex);
 
 	if (!(wq->flags & WQ_UNBOUND)) {
-		wq_unregister_lockdep(wq);
-		/*
-		 * The base ref is never dropped on per-cpu pwqs.  Directly
-		 * schedule RCU free.
-		 */
-		call_rcu(&wq->rcu, rcu_free_wq);
+		for_each_possible_cpu(cpu)
+			put_pwq_unlocked(*per_cpu_ptr(wq->cpu_pwq, cpu));
 	} else {
 		/*
 		 * We're the sole accessor of @wq at this point.  Directly
@@ -4884,7 +4890,7 @@ bool workqueue_congested(int cpu, struct workqueue_struct *wq)
 		cpu = smp_processor_id();
 
 	if (!(wq->flags & WQ_UNBOUND))
-		pwq = per_cpu_ptr(wq->cpu_pwq, cpu);
+		pwq = *per_cpu_ptr(wq->cpu_pwq, cpu);
 	else
 		pwq = unbound_pwq_by_node(wq, cpu_to_node(cpu));
 
-- 
2.40.1


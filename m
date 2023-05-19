Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03FE8708CBD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 02:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjESASG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 20:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbjESAR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 20:17:57 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D681711
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 17:17:50 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-64d2c865e4eso464070b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 17:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684455469; x=1687047469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6v7q4NSZrKhF1BiW0NfAqCkRfXplNOsiBN0pnQXEFmY=;
        b=GOaCYvtZk4/f014gDfMmOxxeZSqtmi8D8HaRGUttcPDxs/ZU2/Rus4hIjVbnf7EwR0
         xNXtO2VI8+mjsBCAYXIN9Uo0om3yzPHxW8EgbUX4seyypPB8ZNDldFE1eMXf+tO/xBH4
         SeGd3UdyPNrcNsnv4c+dA+kyQ2kO+RtVIV7z1Psz6LV53/MnYYDn0qx+7eKIwGlbYg1M
         ZnvxYDqLmuyAd0I8Jdt13o86KmBAsywk4Njt389q9Ncg4744tC0bA88Za4Cgcd74evpx
         H3gFPGTcSOqybwdLzDZSDbKATSCSpOUB3SPyVVUnzxJ69+sZYi4rW0A/jV3+onzx9PbT
         vzLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684455469; x=1687047469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6v7q4NSZrKhF1BiW0NfAqCkRfXplNOsiBN0pnQXEFmY=;
        b=Gg43TuUObBamWzFo8vUhTeGHkqt7cOfdYTalvrSqVIDRjnivXKSYV6303OH4hLogQ4
         JfX73aHBMXKxsHSTB1S6KkbdB2su9YlllVR2hFyfMBXSVU2cfrmFHMoJeemV24azrGR/
         TGElge0oAdcQgR3ObqKEkjs9YVCCBufHtDU5J9kdS4CKpKJv/EzwRZD+kSH90Vg0d9Z8
         vRVCin+w70WBhJS39BT2eS+ybq72pjwX7olTMhgd5Vjv4t0JlL8f15L2FzUyTX/w6yk2
         KdKQvQZ0C/TX+Mga+ZXl30OLReCy9POPdI9P4zTVRuD33B+IQBuNlVak7B0xVF8OxGRw
         0kJQ==
X-Gm-Message-State: AC+VfDxDFXRlEH3yvcJJr8mlAE36GSh9Dm1bYU/kOJ4n2gd7cS6qsfjq
        GMpQRsn1nq/SWPckVOMdtGI=
X-Google-Smtp-Source: ACHHUZ4h3tQY3URpPOywz+t0V6yLDZw9dDCgeGggoV7l1om37Hrt2aQzZ73EyGQFNwN7c4dz/ouh7g==
X-Received: by 2002:a05:6a20:c191:b0:104:859b:9263 with SMTP id bg17-20020a056a20c19100b00104859b9263mr287726pzb.10.1684455469253;
        Thu, 18 May 2023 17:17:49 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id a26-20020aa7865a000000b0063b85893633sm1845384pfo.197.2023.05.18.17.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 17:17:48 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     jiangshanlai@gmail.com
Cc:     torvalds@linux-foundation.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        joshdon@google.com, brho@google.com, briannorris@chromium.org,
        nhuck@google.com, agk@redhat.com, snitzer@kernel.org,
        void@manifault.com, Tejun Heo <tj@kernel.org>
Subject: [PATCH 07/24] workqueue: Use a kthread_worker to release pool_workqueues
Date:   Thu, 18 May 2023 14:16:52 -1000
Message-Id: <20230519001709.2563-8-tj@kernel.org>
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

pool_workqueue release path is currently bounced to system_wq; however, this
is a bit tricky because this bouncing occurs while holding a pool lock and
thus has risk of causing a A-A deadlock. This is currently addressed by the
fact that only unbound workqueues use this bouncing path and system_wq is a
per-cpu workqueue.

While this works, it's brittle and requires a work-around like setting the
lockdep subclass for the lock of unbound pools. Besides, future changes will
use the bouncing path for per-cpu workqueues too making the current approach
unusable.

Let's just use a dedicated kthread_worker to untangle the dependency. This
is just one more kthread for all workqueues and makes the pwq release logic
simpler and more robust.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/workqueue.c | 40 +++++++++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 17 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index f39d04e7e5f9..7addda9b37b9 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -256,12 +256,12 @@ struct pool_workqueue {
 	u64			stats[PWQ_NR_STATS];
 
 	/*
-	 * Release of unbound pwq is punted to system_wq.  See put_pwq()
-	 * and pwq_unbound_release_workfn() for details.  pool_workqueue
-	 * itself is also RCU protected so that the first pwq can be
-	 * determined without grabbing wq->mutex.
+	 * Release of unbound pwq is punted to a kthread_worker. See put_pwq()
+	 * and pwq_unbound_release_workfn() for details. pool_workqueue itself
+	 * is also RCU protected so that the first pwq can be determined without
+	 * grabbing wq->mutex.
 	 */
-	struct work_struct	unbound_release_work;
+	struct kthread_work	unbound_release_work;
 	struct rcu_head		rcu;
 } __aligned(1 << WORK_STRUCT_FLAG_BITS);
 
@@ -389,6 +389,13 @@ static struct workqueue_attrs *unbound_std_wq_attrs[NR_STD_WORKER_POOLS];
 /* I: attributes used when instantiating ordered pools on demand */
 static struct workqueue_attrs *ordered_wq_attrs[NR_STD_WORKER_POOLS];
 
+/*
+ * I: kthread_worker to release pwq's. pwq release needs to be bounced to a
+ * process context while holding a pool lock. Bounce to a dedicated kthread
+ * worker to avoid A-A deadlocks.
+ */
+static struct kthread_worker *pwq_release_worker;
+
 struct workqueue_struct *system_wq __read_mostly;
 EXPORT_SYMBOL(system_wq);
 struct workqueue_struct *system_highpri_wq __read_mostly;
@@ -1347,14 +1354,10 @@ static void put_pwq(struct pool_workqueue *pwq)
 	if (WARN_ON_ONCE(!(pwq->wq->flags & WQ_UNBOUND)))
 		return;
 	/*
-	 * @pwq can't be released under pool->lock, bounce to
-	 * pwq_unbound_release_workfn().  This never recurses on the same
-	 * pool->lock as this path is taken only for unbound workqueues and
-	 * the release work item is scheduled on a per-cpu workqueue.  To
-	 * avoid lockdep warning, unbound pool->locks are given lockdep
-	 * subclass of 1 in get_unbound_pool().
+	 * @pwq can't be released under pool->lock, bounce to a dedicated
+	 * kthread_worker to avoid A-A deadlocks.
 	 */
-	schedule_work(&pwq->unbound_release_work);
+	kthread_queue_work(pwq_release_worker, &pwq->unbound_release_work);
 }
 
 /**
@@ -3948,7 +3951,6 @@ static struct worker_pool *get_unbound_pool(const struct workqueue_attrs *attrs)
 	if (!pool || init_worker_pool(pool) < 0)
 		goto fail;
 
-	lockdep_set_subclass(&pool->lock, 1);	/* see put_pwq() */
 	copy_workqueue_attrs(pool->attrs, attrs);
 	pool->node = target_node;
 
@@ -3982,10 +3984,10 @@ static void rcu_free_pwq(struct rcu_head *rcu)
 }
 
 /*
- * Scheduled on system_wq by put_pwq() when an unbound pwq hits zero refcnt
- * and needs to be destroyed.
+ * Scheduled on pwq_release_worker by put_pwq() when an unbound pwq hits zero
+ * refcnt and needs to be destroyed.
  */
-static void pwq_unbound_release_workfn(struct work_struct *work)
+static void pwq_unbound_release_workfn(struct kthread_work *work)
 {
 	struct pool_workqueue *pwq = container_of(work, struct pool_workqueue,
 						  unbound_release_work);
@@ -4093,7 +4095,8 @@ static void init_pwq(struct pool_workqueue *pwq, struct workqueue_struct *wq,
 	INIT_LIST_HEAD(&pwq->inactive_works);
 	INIT_LIST_HEAD(&pwq->pwqs_node);
 	INIT_LIST_HEAD(&pwq->mayday_node);
-	INIT_WORK(&pwq->unbound_release_work, pwq_unbound_release_workfn);
+	kthread_init_work(&pwq->unbound_release_work,
+			  pwq_unbound_release_workfn);
 }
 
 /* sync @pwq with the current state of its associated wq and link it */
@@ -6419,6 +6422,9 @@ void __init workqueue_init(void)
 	struct worker_pool *pool;
 	int cpu, bkt;
 
+	pwq_release_worker = kthread_create_worker(0, "pool_workqueue_release");
+	BUG_ON(IS_ERR(pwq_release_worker));
+
 	/*
 	 * It'd be simpler to initialize NUMA in workqueue_init_early() but
 	 * CPU to node mapping may not be available that early on some
-- 
2.40.1


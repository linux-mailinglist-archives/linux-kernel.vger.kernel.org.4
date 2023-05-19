Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 236A2708CB7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 02:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbjESARm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 20:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjESARj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 20:17:39 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35592F1
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 17:17:38 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-53469299319so1127285a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 17:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684455457; x=1687047457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ijOnINV0SHkQJNy159mnAmpLWfqt3tq523U1u8jiKVQ=;
        b=EeO6GDlNBKvWAEFas4c/23VJoMXMrUWgruSl5fX8lM6sF2FEHZM7U2Il1X7gEm/uIQ
         Z11MGt//RASQEbBNEyxB0sDjGg4TOJdTUZHUso9TNXCEObyJeU0q9b+pnTPx4tTZZ45E
         byN+10X8aYqRhYfipyl8JheM2EIZk5qYiy/lfZno361b1N7L7ngi3HODqp86Jgu9m7wc
         vvVBLiwjDRXnwFdrrecQfAxjmJa7ib+35zYQIZaKomr7MZ9yO4kenG/ywWXIhK03FrPh
         +BKfYfEvs/3iWNCPWbMrgiApGb1BTkVYsLtHNP05zUmMaX4LDMiDJcHVnHFiag46vGig
         WyYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684455457; x=1687047457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ijOnINV0SHkQJNy159mnAmpLWfqt3tq523U1u8jiKVQ=;
        b=keocbRaaRq5VZ/tsDnCyoyuBaAuAxLU47h6tDsAGK7Fxq1oIqo8t8J7h5ya7MGGG6M
         U1RmZxOpYNN0oOi6F0HAhQc/dE5rw0n6BCDFroaBWtEdSW/rlMYL+2rtEitlmZeUdENx
         zstY27Z9b3OnfUy/5bKuOExXcns8dlczkhpYw/I1L5h3Qsr/wLjSi0L0/YbjnBAVHil3
         t88dJ3Aa5TZSXgSSY2NbDBNTJL4hvo2ZFhyh7BSgMMEn1PrnBlKAFEZb36WkrVUA8rsh
         VF1ulL4dWCEcLM8db+VB7Qjjw3YxJuKQDl4/7oFG9gLnPGPF8WNo9+j0UYAmkSQibxrS
         qarA==
X-Gm-Message-State: AC+VfDxp1TSGnNrNGySF2sL+SoYAidMPkZ9ufyw1btgPUstWrw3lSxCi
        YPeilY0W7kP0TKBmWcjfuTM=
X-Google-Smtp-Source: ACHHUZ6yRO6YMKcPfG9eDDFhbm5P1+b6JFv4c4A6y8gyaEu7sZs8bKTZpBX/w3Q5AT+/7nh3kMJG9g==
X-Received: by 2002:a17:902:d389:b0:1ad:b5b4:e424 with SMTP id e9-20020a170902d38900b001adb5b4e424mr825661pld.38.1684455457335;
        Thu, 18 May 2023 17:17:37 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id u8-20020a170902e5c800b001ac84f87b1dsm2047254plf.155.2023.05.18.17.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 17:17:36 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     jiangshanlai@gmail.com
Cc:     torvalds@linux-foundation.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        joshdon@google.com, brho@google.com, briannorris@chromium.org,
        nhuck@google.com, agk@redhat.com, snitzer@kernel.org,
        void@manifault.com, Tejun Heo <tj@kernel.org>
Subject: [PATCH 01/24] workqueue: Drop the special locking rule for worker->flags and worker_pool->flags
Date:   Thu, 18 May 2023 14:16:46 -1000
Message-Id: <20230519001709.2563-2-tj@kernel.org>
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

worker->flags used to be accessed from scheduler hooks without grabbing
pool->lock for concurrency management. This is no longer true since
6d25be5782e4 ("sched/core, workqueues: Distangle worker accounting from rq
lock"). Also, it's unclear why worker_pool->flags was using the "X" rule.
All relevant users are accessing it under the pool lock.

Let's drop the special "X" rule and use the "L" rule for these flag fields
instead. While at it, replace the CONTEXT comment with
lockdep_assert_held().

This allows worker_set/clr_flags() to be used from context which isn't the
worker itself. This will be used later to implement assinging work items to
workers before waking them up so that workqueue can have better control over
which worker executes which work item on which CPU.

The only actual changes are sanity checks. There shouldn't be any visible
behavior changes.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/workqueue.c          | 17 +++--------------
 kernel/workqueue_internal.h |  2 +-
 2 files changed, 4 insertions(+), 15 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index ee16ddb0647c..9a97db94e1dc 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -121,11 +121,6 @@ enum {
  *
  * L: pool->lock protected.  Access with pool->lock held.
  *
- * X: During normal operation, modification requires pool->lock and should
- *    be done only from local cpu.  Either disabling preemption on local
- *    cpu or grabbing pool->lock is enough for read access.  If
- *    POOL_DISASSOCIATED is set, it's identical to L.
- *
  * K: Only modified by worker while holding pool->lock. Can be safely read by
  *    self, while holding pool->lock or from IRQ context if %current is the
  *    kworker.
@@ -159,7 +154,7 @@ struct worker_pool {
 	int			cpu;		/* I: the associated cpu */
 	int			node;		/* I: the associated node ID */
 	int			id;		/* I: pool ID */
-	unsigned int		flags;		/* X: flags */
+	unsigned int		flags;		/* L: flags */
 
 	unsigned long		watchdog_ts;	/* L: watchdog timestamp */
 	bool			cpu_stall;	/* WD: stalled cpu bound pool */
@@ -901,15 +896,12 @@ static void wake_up_worker(struct worker_pool *pool)
  * @flags: flags to set
  *
  * Set @flags in @worker->flags and adjust nr_running accordingly.
- *
- * CONTEXT:
- * raw_spin_lock_irq(pool->lock)
  */
 static inline void worker_set_flags(struct worker *worker, unsigned int flags)
 {
 	struct worker_pool *pool = worker->pool;
 
-	WARN_ON_ONCE(worker->task != current);
+	lockdep_assert_held(&pool->lock);
 
 	/* If transitioning into NOT_RUNNING, adjust nr_running. */
 	if ((flags & WORKER_NOT_RUNNING) &&
@@ -926,16 +918,13 @@ static inline void worker_set_flags(struct worker *worker, unsigned int flags)
  * @flags: flags to clear
  *
  * Clear @flags in @worker->flags and adjust nr_running accordingly.
- *
- * CONTEXT:
- * raw_spin_lock_irq(pool->lock)
  */
 static inline void worker_clr_flags(struct worker *worker, unsigned int flags)
 {
 	struct worker_pool *pool = worker->pool;
 	unsigned int oflags = worker->flags;
 
-	WARN_ON_ONCE(worker->task != current);
+	lockdep_assert_held(&pool->lock);
 
 	worker->flags &= ~flags;
 
diff --git a/kernel/workqueue_internal.h b/kernel/workqueue_internal.h
index 6b1d66e28269..f6275944ada7 100644
--- a/kernel/workqueue_internal.h
+++ b/kernel/workqueue_internal.h
@@ -48,7 +48,7 @@ struct worker {
 						/* A: runs through worker->node */
 
 	unsigned long		last_active;	/* K: last active timestamp */
-	unsigned int		flags;		/* X: flags */
+	unsigned int		flags;		/* L: flags */
 	int			id;		/* I: worker id */
 
 	/*
-- 
2.40.1


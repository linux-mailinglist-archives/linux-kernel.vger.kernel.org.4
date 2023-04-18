Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 383EC6E6DB8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 22:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232814AbjDRUwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 16:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232758AbjDRUwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 16:52:14 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A8E30F4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 13:52:13 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-63b57c49c4cso2221114b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 13:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681851132; x=1684443132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J6EdDco5kAEeuKH6nEKOLDvgVjOCdHa0MvD6TVeSC7M=;
        b=BuFV1vg/DneWsJbt0BQ0y/Zs1bk80OQakGkNec7UaX7ckHxGZykXJTV7u/6OvvWp0A
         xaFcoxj7SHsmt1gd4jP3KZeJmzOFxkeiEb5bMrVV8USFwm/IRHbM/xMttaMmKrEp0vqe
         A3khJZEG8s+FDgNcLus3eHDGRfzz+8fCB01+SGW6NQFzkOA96EBPEBrnHqs1LwJ5bzqI
         ugJ8ApSGmYTHVDYakMzNPypONeKl4MTfRpxZFN8GZhpzWCvPgSoKGN4cHv4RtPX4jfKy
         kWOJdaT1WG57H/s7+XIS6NngwnyITFxs2QlStf/fkL9HpPbp/erXryHBwMUshjkF1TlH
         M76A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681851132; x=1684443132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J6EdDco5kAEeuKH6nEKOLDvgVjOCdHa0MvD6TVeSC7M=;
        b=XD6P+BEvHZJLdlEFmSRJJ5UbXQY6H8gxXl1DHZz9KtfkiWqHeHaiVVYEqSh1wlQJqq
         Fq6rjA7XYcpdpOgRBwI+UPRMeNMUgAZFOaz0x1Wi+NAj+FQPUZuwoaj2utkiNoNv8kCn
         cCfwXpv7Z+08qxdP2tKreTenqDEps9wdkJVptG2w9iU04sj6rlpolqKT0yiDcaEzo6qZ
         UJ0AlUQozdRMEnpYzrk61ZRH+n2y4moOm9wBJ4/S/AOTCIgkylYXgfu45JH8YBuoKvb9
         ucchrBZDTaOa/MzjPn+tfKrYrJcH/+oqMyhGNq28+Za4bC1nM09cIJfsUX6s2Sl6Trrm
         449w==
X-Gm-Message-State: AAQBX9cCNbpgpyQDQ4jDE4lUKuC/DXzpcXEHTHnKVlyyQv/4Wk8yulqN
        G4LoFC/MnLcMjjiBxRCR3TQ=
X-Google-Smtp-Source: AKy350YtkfUJYO3sp0EZ0w+3KaJXh79S4XNv1dvWSyy0jOht32n1miGnkCECMt00LXIePh9K1YiT8Q==
X-Received: by 2002:a17:902:d50a:b0:1a1:f70c:c81a with SMTP id b10-20020a170902d50a00b001a1f70cc81amr3744687plg.9.1681851132219;
        Tue, 18 Apr 2023 13:52:12 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id ij8-20020a170902ab4800b001a514d75d16sm10003884plb.13.2023.04.18.13.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 13:52:11 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     jiangshanlai@gmail.com
Cc:     torvalds@linux-foundation.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 3/5] workqueue: Move worker_set/clr_flags() upwards
Date:   Tue, 18 Apr 2023 10:51:57 -1000
Message-Id: <20230418205159.724789-4-tj@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230418205159.724789-1-tj@kernel.org>
References: <20230418205159.724789-1-tj@kernel.org>
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

They're gonna be used wq_worker_stopping(). Move them upwards.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
---
 kernel/workqueue.c | 108 ++++++++++++++++++++++-----------------------
 1 file changed, 54 insertions(+), 54 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 6199fbf10cec..b9e8dc54272d 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -859,6 +859,60 @@ static void wake_up_worker(struct worker_pool *pool)
 		wake_up_process(worker->task);
 }
 
+/**
+ * worker_set_flags - set worker flags and adjust nr_running accordingly
+ * @worker: self
+ * @flags: flags to set
+ *
+ * Set @flags in @worker->flags and adjust nr_running accordingly.
+ *
+ * CONTEXT:
+ * raw_spin_lock_irq(pool->lock)
+ */
+static inline void worker_set_flags(struct worker *worker, unsigned int flags)
+{
+	struct worker_pool *pool = worker->pool;
+
+	WARN_ON_ONCE(worker->task != current);
+
+	/* If transitioning into NOT_RUNNING, adjust nr_running. */
+	if ((flags & WORKER_NOT_RUNNING) &&
+	    !(worker->flags & WORKER_NOT_RUNNING)) {
+		pool->nr_running--;
+	}
+
+	worker->flags |= flags;
+}
+
+/**
+ * worker_clr_flags - clear worker flags and adjust nr_running accordingly
+ * @worker: self
+ * @flags: flags to clear
+ *
+ * Clear @flags in @worker->flags and adjust nr_running accordingly.
+ *
+ * CONTEXT:
+ * raw_spin_lock_irq(pool->lock)
+ */
+static inline void worker_clr_flags(struct worker *worker, unsigned int flags)
+{
+	struct worker_pool *pool = worker->pool;
+	unsigned int oflags = worker->flags;
+
+	WARN_ON_ONCE(worker->task != current);
+
+	worker->flags &= ~flags;
+
+	/*
+	 * If transitioning out of NOT_RUNNING, increment nr_running.  Note
+	 * that the nested NOT_RUNNING is not a noop.  NOT_RUNNING is mask
+	 * of multiple flags, not a single flag.
+	 */
+	if ((flags & WORKER_NOT_RUNNING) && (oflags & WORKER_NOT_RUNNING))
+		if (!(worker->flags & WORKER_NOT_RUNNING))
+			pool->nr_running++;
+}
+
 /**
  * wq_worker_running - a worker is running again
  * @task: task waking up
@@ -964,60 +1018,6 @@ work_func_t wq_worker_last_func(struct task_struct *task)
 	return worker->last_func;
 }
 
-/**
- * worker_set_flags - set worker flags and adjust nr_running accordingly
- * @worker: self
- * @flags: flags to set
- *
- * Set @flags in @worker->flags and adjust nr_running accordingly.
- *
- * CONTEXT:
- * raw_spin_lock_irq(pool->lock)
- */
-static inline void worker_set_flags(struct worker *worker, unsigned int flags)
-{
-	struct worker_pool *pool = worker->pool;
-
-	WARN_ON_ONCE(worker->task != current);
-
-	/* If transitioning into NOT_RUNNING, adjust nr_running. */
-	if ((flags & WORKER_NOT_RUNNING) &&
-	    !(worker->flags & WORKER_NOT_RUNNING)) {
-		pool->nr_running--;
-	}
-
-	worker->flags |= flags;
-}
-
-/**
- * worker_clr_flags - clear worker flags and adjust nr_running accordingly
- * @worker: self
- * @flags: flags to clear
- *
- * Clear @flags in @worker->flags and adjust nr_running accordingly.
- *
- * CONTEXT:
- * raw_spin_lock_irq(pool->lock)
- */
-static inline void worker_clr_flags(struct worker *worker, unsigned int flags)
-{
-	struct worker_pool *pool = worker->pool;
-	unsigned int oflags = worker->flags;
-
-	WARN_ON_ONCE(worker->task != current);
-
-	worker->flags &= ~flags;
-
-	/*
-	 * If transitioning out of NOT_RUNNING, increment nr_running.  Note
-	 * that the nested NOT_RUNNING is not a noop.  NOT_RUNNING is mask
-	 * of multiple flags, not a single flag.
-	 */
-	if ((flags & WORKER_NOT_RUNNING) && (oflags & WORKER_NOT_RUNNING))
-		if (!(worker->flags & WORKER_NOT_RUNNING))
-			pool->nr_running++;
-}
-
 /**
  * find_worker_executing_work - find worker which is executing a work
  * @pool: pool of interest
-- 
2.40.0


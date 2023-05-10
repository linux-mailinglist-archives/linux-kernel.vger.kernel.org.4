Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58AC36FD406
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 05:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235403AbjEJDIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 23:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235203AbjEJDIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 23:08:18 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7438C2703
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 20:08:17 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-64115e652eeso47215103b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 20:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683688097; x=1686280097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=am+rUfAJ7ai+nl1efc3YHFFiW5Ye+pXe6lG1R6kUx+E=;
        b=kOX0/BAExhVsRq2YWzEdTANhysH80XK0QGXsWE+VhSM/fHFx69n3o9y07P2pnzWmbE
         1Q5vmQZzw4vbpnEt3gUoZWhRrPj3K0yK1YObNuFmCfCMKa4Pinx+C83I+lfS4CB38tP/
         oz++Ic8fXl4KhSFzTvRlKafUvyRJt3/FaCx5UNQBhEpG/r/VwjWCj4S9RFwkeHE2bc3U
         i4QdE1BIN4WNIqpocQ/27ultAKNbvFrCkRAOoxWz+Gy/etl3l4MmwMX190s6yq3+6PRn
         nWx1vsHNW0RAbisbots4qvvZbGr4cLb77nkQYbZLvT5jftayrYHcACjYXh/VQIZNp6Mr
         KRlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683688097; x=1686280097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=am+rUfAJ7ai+nl1efc3YHFFiW5Ye+pXe6lG1R6kUx+E=;
        b=kTSbqodNRb8CxMkcIYqzWTuAtPEekeEeSfA2uh07tFftDPFM7gcH/lMBMyOJ9hT92D
         lmYH1MTSSnM0pGQu09nQ9Ix6sm5WWOvhcOE11Py4judzh0jHy8oyMHD1RTF6p/0Fp0YH
         54byi9R8vygKW34gu+OYi6SWYHawpU3UjPLhQuzfQRW9vWJmkvhEDteYiAGm3xjOemaX
         Onn8HYGSD3P6P1KqtgQY8q63pCH7iI8Xmx+178gstl4kSirT+cjEbAu3413liXqYzecn
         uVp+p6HcyIdegVBswX42QWOjGNYk7VanidmFhWkbhA3Ca7HYSw0YlVQN6svp1rgElItH
         OXDA==
X-Gm-Message-State: AC+VfDxhun0N6effM/OZkJzQDkcr1bIZcI9yOiGDqS1xdKuL8BseBFfQ
        YnHQfuYNpTD7bqYwvmT/KUE=
X-Google-Smtp-Source: ACHHUZ6Hoz/otyt4Ww4rTUgM3b+Y1a56ZKYaeyh2kB9VSNrPXyHW1MgMR6X5vAlt6p/16wzPx0Xncg==
X-Received: by 2002:a17:902:d50c:b0:1ab:f74:a118 with SMTP id b12-20020a170902d50c00b001ab0f74a118mr20235885plg.19.1683688096577;
        Tue, 09 May 2023 20:08:16 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id j4-20020a17090276c400b00194caf3e975sm2412945plt.208.2023.05.09.20.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 20:08:16 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     jiangshanlai@gmail.com
Cc:     torvalds@linux-foundation.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 3/6] workqueue: Move worker_set/clr_flags() upwards
Date:   Tue,  9 May 2023 17:07:49 -1000
Message-Id: <20230510030752.542340-4-tj@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230510030752.542340-1-tj@kernel.org>
References: <20230510030752.542340-1-tj@kernel.org>
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
index cbcdc11adabd..31f1618d98c2 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -863,6 +863,60 @@ static void wake_up_worker(struct worker_pool *pool)
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
@@ -976,60 +1030,6 @@ work_func_t wq_worker_last_func(struct task_struct *task)
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
2.40.1


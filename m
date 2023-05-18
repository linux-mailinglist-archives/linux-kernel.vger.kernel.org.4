Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7215707846
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 05:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjERDBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 23:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjERDBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 23:01:02 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC50810D7
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 20:00:54 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-643990c5319so1102991b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 20:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684378854; x=1686970854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ga0+M5guknuQtZyJzOHvjX4Dz3Vsr3EDDnoY1uXgoTE=;
        b=kZMVHxpVu/h296FWMuDq4Ld+QXCwAGv99A9lc4Z95TpYBMyr5a/xSKiOIFFXAUbk1p
         44K7dftGa1JJZm4x6V1SFNHPFVVIK0FUo5OXJjTse0V7gi8Zl0s/9skDsZBKYDGKX7jP
         WyUupe4jnxOYZTZQFTGSmjknzdQLeY3SJuuLsMTR6TBdbpljA/cgvlFr7SRiuvyWN8dH
         drPIawIGLZEQM2MZBJnVewTS5L9IaagLViGNDT3Zm+BVs7iCOIQFmnHL7kw1g8LnXwbJ
         6rH4Y+UAsNjz9TQSpTZKfq2xOFyzLT0EXU/2FE6E/v4DfilZ3WaIbjmZI0iEughUCFsH
         tidQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684378854; x=1686970854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ga0+M5guknuQtZyJzOHvjX4Dz3Vsr3EDDnoY1uXgoTE=;
        b=c0Gl1v7cJrHAhMMg4EQmYt3zkK6PmoGO0mpLQjyJOHUOFlxSx8SrvXvRF0lhEZTTkg
         LJ1qn6ISatr3rjOHDBVx+TdANkH13k7F7d9LxzpslKwlEUZGtzRU3hbVyjO8roSctZz5
         p453l5uXEUiEV1a9oyper9ZrsTlPxfzoO0UCKpsqZyLVpfrMwUIQ3pNxWeCWohO3qwQo
         SwAJ/FVy+eOZmUtcaYcWASYW4KjbTRxHDBB+qfupjVdJIb8OJceicNFAspSzvqRad9Zi
         oALwiYOdp27Y7vQsl6N1LDiE3tITuLTRcxufJ8ThF72qGNTLMqZKy/MNKr2uw/XZq/jY
         wkOA==
X-Gm-Message-State: AC+VfDyAZBnq5c9qVh4HLne66IUdlQGxv6Gk0hRZw84krZJoPmQbpSbF
        Tsb0fecuqTHfMrpYN9qPgU8=
X-Google-Smtp-Source: ACHHUZ7o57XTzrwh5J1c3A8NLNK2RhNsI+0W5yDew2g1VRSsuo4+H0I1AeWL1FxnpRc4ROZfUT9HCg==
X-Received: by 2002:a05:6a00:24c6:b0:648:ebb2:3d6 with SMTP id d6-20020a056a0024c600b00648ebb203d6mr2829769pfv.26.1684378853855;
        Wed, 17 May 2023 20:00:53 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:1c2f])
        by smtp.gmail.com with ESMTPSA id a26-20020a62bd1a000000b0063f0c9eadc7sm203331pff.200.2023.05.17.20.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 20:00:53 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     jiangshanlai@gmail.com
Cc:     torvalds@linux-foundation.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 3/7] workqueue: Move worker_set/clr_flags() upwards
Date:   Wed, 17 May 2023 17:00:29 -1000
Message-Id: <20230518030033.4163274-4-tj@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230518030033.4163274-1-tj@kernel.org>
References: <20230518030033.4163274-1-tj@kernel.org>
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

They are going to be used in wq_worker_stopping(). Move them upwards.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
---
 kernel/workqueue.c | 108 ++++++++++++++++++++++-----------------------
 1 file changed, 54 insertions(+), 54 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 60d5b84cccb2..d70bb5be99ce 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -879,6 +879,60 @@ static void wake_up_worker(struct worker_pool *pool)
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
@@ -983,60 +1037,6 @@ work_func_t wq_worker_last_func(struct task_struct *task)
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


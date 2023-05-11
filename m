Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFDF46FF96E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 20:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239218AbjEKSUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 14:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238819AbjEKSTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 14:19:46 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 856487696
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 11:19:44 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6439bbc93b6so6175716b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 11:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683829184; x=1686421184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZTWAQkbcaPX8SKv+21F9cvlNho68RajHcKaNsycJvbc=;
        b=kU752pRjjFvhx4dpLtFlAxLg9JwwMVdo0h6v4yD9qyVVja8cLqBoNygPdrpEo+3P4R
         jR5ON10fwKyVUwRgnLPJG2HXusrClIELoHAUOs3xgtc6+Wf/xGtkFQUHfGotVgaOpzHv
         pUbZq4tTNYhvXnsejm0De0xAUwSJPBqnhqX0Oy6oOrzY5czkE7uY4w1NHoiOi0McTLT5
         H0+w6mgVSO7wj9MszL8gdKAdU5L426BaK4ZvhFL1m2sSrVe5YObe3Ij36w3hDQeKQx0b
         bY2I4BMzvE5/lAPEMyfYRHeIn3/aJ7EbqTzc5dRC/WmL7Csfw3N6dvTqzvhWdgwTuljq
         4Tpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683829184; x=1686421184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZTWAQkbcaPX8SKv+21F9cvlNho68RajHcKaNsycJvbc=;
        b=bhn8W5CT8LXODcIw1b8xKGY9NXSV4brD/5eVQ8wM98BBUofw6cxbdxZ0jENTwUug7A
         kvUMmNFnTr48DTNVrMxM7b7binG0KVKNAjJIXFst9KdF+FWitMXZyL1gbre/7nUsVrsz
         TPqrJc5aIj5VoRIOebL3SkrziabitFVEVhsWSX9yqSFC64ZFujRGVTAksrELcAp+Juab
         Fyycijb+7/UiDtKFnInAfcYraUuXLq8fmBSM6M5s3fZdgjSeHSWUCTyVQG+D7LixmeRP
         zGKvQxc5DHbAfYjk83wR8XAkQXnx/yD1RBbR6sCO5W0zXNLA9uISteOj0LZchxxSpWNF
         eROA==
X-Gm-Message-State: AC+VfDyUdaFzi4eB5ceF07S306TeQaxaXY04cYXxi1n3NbQ1R7x9n/ni
        5GFSgBlnGWvjChWCTO+qjCF4HUERHrY=
X-Google-Smtp-Source: ACHHUZ5T5mHQ94OkaGva1oRCbwxA52+acDouo6gWq1VO3wRuyTzH59S28h8Wxk+QN4THiBx8NNkcFw==
X-Received: by 2002:a05:6a00:2ea0:b0:648:ebb2:3d6 with SMTP id fd32-20020a056a002ea000b00648ebb203d6mr4994823pfb.26.1683829183721;
        Thu, 11 May 2023 11:19:43 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id k4-20020aa790c4000000b0062bc045bf4fsm5822850pfk.19.2023.05.11.11.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 11:19:43 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     jiangshanlai@gmail.com
Cc:     torvalds@linux-foundation.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 3/7] workqueue: Move worker_set/clr_flags() upwards
Date:   Thu, 11 May 2023 08:19:27 -1000
Message-Id: <20230511181931.869812-4-tj@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230511181931.869812-1-tj@kernel.org>
References: <20230511181931.869812-1-tj@kernel.org>
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
index 33ddfaacdf29..452bcb49192a 100644
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


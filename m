Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 375C66FE211
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 18:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbjEJQEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 12:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjEJQEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 12:04:36 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 792776EA1;
        Wed, 10 May 2023 09:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=5coZuc0LWe5T2FSbFcYaWyKlVyK8s2rebedtEDBWqUU=;
        t=1683734675; x=1684944275; b=tyGqsUx05/nKwZiBNLo7yEToj4oSQvDzm/0w3CxKMNU6eat
        MT1LaYNFFZ+bjTpoRwQsHCdQ4rubo/EH6gUCnqf3PWFOkcYy/q2sqz9HlX/wibST4flrl+MD802kH
        3tDYWdYylVLkhxHPFxlVcksdkfWB+FY6TpDVK+O1wzK9KbWNaTtZurZUJ35jSxCv9W1iHL9GhPESr
        cM23jk1audQt+4lpzLk1bJaN/99hIAtrEQus5mJ72h+EvdKE1Sa67JR6bW4xDc5Rp4aqU5eIVtCNj
        hEnIl2mVhHQR9OQzIn0BGsa2i+oyyGebW9eZqde4uwGcU83rGuz9O5cTgGJuQHRQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pwmIr-005Uq9-0R;
        Wed, 10 May 2023 18:04:33 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-wireless@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [RFC PATCH 2/4] workqueue: support holding a mutex for each work
Date:   Wed, 10 May 2023 18:04:26 +0200
Message-Id: <20230510175846.cc21c84b0e6b.I9d3df459c43a78530d9c2046724bb45626402d5f@changeid>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230510160428.175409-1-johannes@sipsolutions.net>
References: <20230510160428.175409-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Add a bit of new infrastructure so that on ordered
workqueues, work will be executed with a specified
mutex held. This can be used to simplify subsystem
implementations, and together with the pause() and
resume() APIs can significantly simplify things in
subsystems using both.

The alternative to this is to manually lock in each
work item, but there can be many of them and this
may require special locking API inside the work
items vs. outside, since the outside might need to
also pause the workqueue.

For example, in wifi, I imagine using this for all
control paths so that wiphy_lock() will also pause
the workqueue, and all works will execute with the
same mutex that is used to implement wiphy_lock()
held. Then, work structs only need to be removed,
without _sync(), removing many potential causes of
locking problems.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/linux/workqueue.h | 30 +++++++++++++++++++++++++++---
 kernel/workqueue.c        | 30 +++++++++++++++++++++++-------
 2 files changed, 50 insertions(+), 10 deletions(-)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 5e2413017a89..9d0a1bf4d5f7 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -387,12 +387,16 @@ extern struct workqueue_struct *system_freezable_wq;
 extern struct workqueue_struct *system_power_efficient_wq;
 extern struct workqueue_struct *system_freezable_power_efficient_wq;
 
+__printf(1, 5) struct workqueue_struct *
+__alloc_workqueue(const char *fmt, unsigned int flags, int max_active,
+		  struct mutex *work_mutex, ...);
+
 /**
  * alloc_workqueue - allocate a workqueue
  * @fmt: printf format for the name of the workqueue
  * @flags: WQ_* flags
  * @max_active: max in-flight work items, 0 for default
- * remaining args: args for @fmt
+ * args: args for @fmt
  *
  * Allocate a workqueue with the specified parameters.  For detailed
  * information on WQ_* flags, please refer to
@@ -401,8 +405,8 @@ extern struct workqueue_struct *system_freezable_power_efficient_wq;
  * RETURNS:
  * Pointer to the allocated workqueue on success, %NULL on failure.
  */
-__printf(1, 4) struct workqueue_struct *
-alloc_workqueue(const char *fmt, unsigned int flags, int max_active, ...);
+#define alloc_workqueue(fmt, flags, max_active, args...) \
+	__alloc_workqueue(fmt, flags, max_active, NULL, ##args)
 
 /**
  * alloc_ordered_workqueue - allocate an ordered workqueue
@@ -421,6 +425,26 @@ alloc_workqueue(const char *fmt, unsigned int flags, int max_active, ...);
 	alloc_workqueue(fmt, WQ_UNBOUND | __WQ_ORDERED |		\
 			__WQ_ORDERED_EXPLICIT | (flags), 1, ##args)
 
+/**
+ * alloc_ordered_workqueue_mtx - allocate an ordered workqueue with work mutex
+ * @fmt: printf format for the name of the workqueue
+ * @flags: WQ_* flags (only WQ_FREEZABLE and WQ_MEM_RECLAIM are meaningful)
+ * @work_mutex: mutex to hold for each work execution
+ * @args: args for @fmt
+ *
+ * Allocate an ordered workqueue.  An ordered workqueue executes at
+ * most one work item at any given time in the queued order.
+ *
+ * The work mutex will be held for each work execution.
+ *
+ * RETURNS:
+ * Pointer to the allocated workqueue on success, %NULL on failure.
+ */
+#define alloc_ordered_workqueue_mtx(fmt, flags, work_mutex, args...)	\
+	__alloc_workqueue(fmt, WQ_UNBOUND | __WQ_ORDERED |		\
+			  __WQ_ORDERED_EXPLICIT | (flags), 1,		\
+			  work_mutex, ##args)
+
 #define create_workqueue(name)						\
 	alloc_workqueue("%s", __WQ_LEGACY | WQ_MEM_RECLAIM, 1, (name))
 #define create_freezable_workqueue(name)				\
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 418d99ff8325..2c573e25690c 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -278,6 +278,8 @@ struct workqueue_struct {
 	struct workqueue_attrs	*unbound_attrs;	/* PW: only for unbound wqs */
 	struct pool_workqueue	*dfl_pwq;	/* PW: only for unbound wqs */
 
+	struct mutex		*work_mutex;	/* user mutex held for work */
+
 #ifdef CONFIG_SYSFS
 	struct wq_device	*wq_dev;	/* I: for sysfs interface */
 #endif
@@ -2387,7 +2389,13 @@ __acquires(&pool->lock)
 	 */
 	lockdep_invariant_state(true);
 	trace_workqueue_execute_start(work);
-	worker->current_func(work);
+	if (unlikely(pwq->wq->work_mutex)) {
+		mutex_lock(pwq->wq->work_mutex);
+		worker->current_func(work);
+		mutex_unlock(pwq->wq->work_mutex);
+	} else {
+		worker->current_func(work);
+	}
 	/*
 	 * While we must be careful to not use "work" after this, the trace
 	 * point will only record its address.
@@ -4404,10 +4412,12 @@ static int init_rescuer(struct workqueue_struct *wq)
 	return 0;
 }
 
-__printf(1, 4)
-struct workqueue_struct *alloc_workqueue(const char *fmt,
-					 unsigned int flags,
-					 int max_active, ...)
+__printf(1, 5)
+struct workqueue_struct *__alloc_workqueue(const char *fmt,
+					   unsigned int flags,
+					   int max_active,
+					   struct mutex *work_mutex,
+					   ...)
 {
 	size_t tbl_size = 0;
 	va_list args;
@@ -4432,6 +4442,10 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
 	if (flags & WQ_UNBOUND)
 		tbl_size = nr_node_ids * sizeof(wq->numa_pwq_tbl[0]);
 
+	/* can only reach this by calling the internal API */
+	if (WARN_ON(!(flags & __WQ_ORDERED_EXPLICIT) && work_mutex))
+		return NULL;
+
 	wq = kzalloc(sizeof(*wq) + tbl_size, GFP_KERNEL);
 	if (!wq)
 		return NULL;
@@ -4442,7 +4456,9 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
 			goto err_free_wq;
 	}
 
-	va_start(args, max_active);
+	wq->work_mutex = work_mutex;
+
+	va_start(args, work_mutex);
 	vsnprintf(wq->name, sizeof(wq->name), fmt, args);
 	va_end(args);
 
@@ -4500,7 +4516,7 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
 	destroy_workqueue(wq);
 	return NULL;
 }
-EXPORT_SYMBOL_GPL(alloc_workqueue);
+EXPORT_SYMBOL_GPL(__alloc_workqueue);
 
 static bool pwq_busy(struct pool_workqueue *pwq)
 {
-- 
2.40.1


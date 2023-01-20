Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4CF7674FBA
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 09:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjATIth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 03:49:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjATItf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 03:49:35 -0500
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 906C979E81
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 00:49:33 -0800 (PST)
Received: from SHSend.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
        by SHSQR01.spreadtrum.com with ESMTP id 30K8mb9x020394;
        Fri, 20 Jan 2023 16:48:37 +0800 (+08)
        (envelope-from zhaoyang.huang@unisoc.com)
Received: from bj03382pcu.spreadtrum.com (10.0.74.65) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Fri, 20 Jan 2023 16:48:35 +0800
From:   "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, <ke.wang@unisoc.com>
Subject: [RFC PATCH] kernel/locking: introduce stack_handle for tracing the callstack
Date:   Fri, 20 Jan 2023 16:48:22 +0800
Message-ID: <1674204502-32123-1-git-send-email-zhaoyang.huang@unisoc.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.74.65]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL: SHSQR01.spreadtrum.com 30K8mb9x020394
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

When deadlock happens, sometimes it is hard to know how the owner get the lock
especially the owner is running when snapshot(ramdump). Introduce stack_handle
to record the trace.

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
 include/linux/rwsem.h  |  9 ++++++++-
 kernel/locking/rwsem.c | 18 ++++++++++++++++++
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
index efa5c32..ad4c591 100644
--- a/include/linux/rwsem.h
+++ b/include/linux/rwsem.h
@@ -16,6 +16,11 @@
 #include <linux/atomic.h>
 #include <linux/err.h>
 
+#define CONFIG_TRACE_RWSEMS
+#ifdef CONFIG_TRACE_RWSEMS
+typedef u32 depot_stack_handle_t;
+#endif
+
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 # define __RWSEM_DEP_MAP_INIT(lockname)			\
 	.dep_map = {					\
@@ -31,7 +36,6 @@
 #ifdef CONFIG_RWSEM_SPIN_ON_OWNER
 #include <linux/osq_lock.h>
 #endif
-
 /*
  * For an uncontended rwsem, count and owner are the only fields a task
  * needs to touch when acquiring the rwsem. So they are put next to each
@@ -60,6 +64,9 @@ struct rw_semaphore {
 #ifdef CONFIG_DEBUG_RWSEMS
 	void *magic;
 #endif
+#ifdef CONFIG_TRACE_RWSEMS
+	depot_stack_handle_t trace_handle;
+#endif
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	struct lockdep_map	dep_map;
 #endif
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 4487359..a12766e 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -28,6 +28,7 @@
 #include <linux/rwsem.h>
 #include <linux/atomic.h>
 #include <trace/events/lock.h>
+#include <linux/stacktrace.h>
 
 #ifndef CONFIG_PREEMPT_RT
 #include "lock_events.h"
@@ -74,6 +75,7 @@
 		list_empty(&(sem)->wait_list) ? "" : "not "))	\
 			debug_locks_off();			\
 	} while (0)
+#define MAX_TRACE		16
 #else
 # define DEBUG_RWSEMS_WARN_ON(c, sem)
 #endif
@@ -174,6 +176,9 @@ static inline void __rwsem_set_reader_owned(struct rw_semaphore *sem,
 		(atomic_long_read(&sem->owner) & RWSEM_NONSPINNABLE);
 
 	atomic_long_set(&sem->owner, val);
+#ifdef CONFIG_TRACE_RWSEMS
+	sem->trace_handle = owner ? set_track_prepare() : NULL;
+#endif
 }
 
 static inline void rwsem_set_reader_owned(struct rw_semaphore *sem)
@@ -397,6 +402,19 @@ enum rwsem_wake_type {
 	return false;
 }
 
+#ifdef CONFIG_TRACE_RWSEMS
+static inline depot_stack_handle_t set_track_prepare(void)
+{
+	depot_stack_handle_t trace_handle;
+	unsigned long entries[MAX_TRACE];
+	unsigned int nr_entries;
+
+	nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 3);
+	trace_handle = stack_depot_save(entries, nr_entries, GFP_NOWAIT);
+
+	return trace_handle;
+}
+#endif
 /*
  * handle the lock release when processes blocked on it that can now run
  * - if we come here from up_xxxx(), then the RWSEM_FLAG_WAITERS bit must
-- 
1.9.1


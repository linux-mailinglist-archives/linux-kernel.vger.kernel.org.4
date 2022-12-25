Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC313655CF8
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Dec 2022 12:55:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbiLYLz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Dec 2022 06:55:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiLYLzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Dec 2022 06:55:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E89ED267A
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 03:55:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 245C760B9C
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 11:55:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A281BC433EF;
        Sun, 25 Dec 2022 11:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671969348;
        bh=RwQyjxEXl7Jyeplt6hWs7So4CHmH2Z4NzeLEZxaefns=;
        h=From:To:Cc:Subject:Date:From;
        b=carjUwsIANq1z3T5rk0aCfvKQGbwtCy1jgPiLScEmv2oxiaj4cyqmR2AMb9lvJtVd
         cebt9yPAxUUzBASNGIu0uCskRzIFTt6hDbdDqgfE2p2JoKymNRQDMmbxog6ziZr3F1
         XP5ZjKXgPzaUOhSkx7WQ/iXzl5JMryZnaKIQwJnTCLlt7COb79N2X0znBcR7ciegIY
         KtkbZcZH3hcf15LLznTeIIxzneTpAbxLO6BxAoeoMCuX8CgYvnYAQAEHHdjm9hEhKk
         8l8a0bh6Ngy2Hp3z3y0wDJZdmjsLxsD2K8Dxq5YUYeLtc/6KOyxKhG7S4usDh5COby
         5IwKQfv8PTdtg==
From:   guoren@kernel.org
To:     peterz@infradead.org, longman@redhat.com
Cc:     linux-kernel@vger.kernel.org, guoren@kernel.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>
Subject: [RFC PATCH] locking/barriers: Introduce smp_cond_load_mask_relaxed & acquire
Date:   Sun, 25 Dec 2022 06:55:29 -0500
Message-Id: <20221225115529.490378-1-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

The current cond_load primitive contains two parts (condition expression
and load value), but the usage of cond_load may require the sub-size
condition expression of the load size. That means hardware could utilize
a mask argument to optimize the wait condition. If the mask argument
size is less than the hardware minimum wait size, the hardware uses its
minimum size.

The patch contains a qspinlock example: When it is at the head of the
waitqueue, it waits for the owner & pending to go away. The forward
progress condition only cares locked_pending part, but it needs to load
the 32-bit lock value as a return.

That also means WFE-liked instruction would need a mask argument of the
load reservation set.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Will Deacon <will@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
---
 include/asm-generic/barrier.h | 22 ++++++++++++++++++++++
 include/linux/atomic.h        |  4 ++++
 kernel/locking/qspinlock.c    |  3 ++-
 3 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
index 961f4d88f9ef..fec61629f769 100644
--- a/include/asm-generic/barrier.h
+++ b/include/asm-generic/barrier.h
@@ -275,6 +275,28 @@ do {									\
 })
 #endif
 
+/**
+ * smp_cond_load_mask_relaxed() - (Spin) wait for cond with ACQUIRE ordering
+ * @ptr: pointer to the variable to wait on
+ * @cond: boolean expression to wait for
+ * @mask: mask *ptr to wait for (effect of 0 is the same with -1)
+ */
+#ifndef smp_cond_load_mask_relaxed
+#define smp_cond_load_mask_relaxed(ptr, cond_expr, mask)	\
+	smp_cond_load_relaxed(ptr, cond_expr)
+#endif
+
+/**
+ * smp_cond_load_mask_acquire() - (Spin) wait for cond with ACQUIRE ordering
+ * @ptr: pointer to the variable to wait on
+ * @cond: boolean expression to wait for
+ * @mask: mask *ptr to wait for (effect of 0 is the same with -1)
+ */
+#ifndef smp_cond_load_mask_acquire
+#define smp_cond_load_mask_acquire(ptr, cond_expr, mask)	\
+	smp_cond_load_acquire(ptr, cond_expr)
+#endif
+
 /*
  * pmem_wmb() ensures that all stores for which the modification
  * are written to persistent storage by preceding instructions have
diff --git a/include/linux/atomic.h b/include/linux/atomic.h
index 8dd57c3a99e9..dc7351945f27 100644
--- a/include/linux/atomic.h
+++ b/include/linux/atomic.h
@@ -27,9 +27,13 @@
 
 #define atomic_cond_read_acquire(v, c) smp_cond_load_acquire(&(v)->counter, (c))
 #define atomic_cond_read_relaxed(v, c) smp_cond_load_relaxed(&(v)->counter, (c))
+#define atomic_cond_read_mask_acquire(v, c, m) smp_cond_load_mask_acquire(&(v)->counter, (c), (m))
+#define atomic_cond_read_mask_relaxed(v, c, m) smp_cond_load_mask_relaxed(&(v)->counter, (c), (m))
 
 #define atomic64_cond_read_acquire(v, c) smp_cond_load_acquire(&(v)->counter, (c))
 #define atomic64_cond_read_relaxed(v, c) smp_cond_load_relaxed(&(v)->counter, (c))
+#define atomic64_cond_read_mask_acquire(v, c, m) smp_cond_load_mask_acquire(&(v)->counter, (c), (m))
+#define atomic64_cond_read_mask_relaxed(v, c, m) smp_cond_load_mask_relaxed(&(v)->counter, (c), (m))
 
 /*
  * The idea here is to build acquire/release variants by adding explicit
diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index ebe6b8ec7cb3..14fdd2ee752c 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -511,7 +511,8 @@ void __lockfunc queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	if ((val = pv_wait_head_or_lock(lock, node)))
 		goto locked;
 
-	val = atomic_cond_read_acquire(&lock->val, !(VAL & _Q_LOCKED_PENDING_MASK));
+	val = atomic_cond_read_mask_acquire(&lock->val, !(VAL & _Q_LOCKED_PENDING_MASK),
+					    _Q_LOCKED_PENDING_MASK);
 
 locked:
 	/*
-- 
2.36.1


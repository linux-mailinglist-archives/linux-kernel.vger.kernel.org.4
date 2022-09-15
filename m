Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A81F15B9CFC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 16:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbiIOOYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 10:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbiIOOXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 10:23:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9693041D11;
        Thu, 15 Sep 2022 07:23:46 -0700 (PDT)
Date:   Thu, 15 Sep 2022 14:23:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1663251825;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6fqgj6qZwblSD7CJXVafHPWquRZrtVqqXkwzgyNPlC8=;
        b=bBOnSm0eRu9KDAXWvFrxYsCXieYlX7shXVTGj85kREbZw8xwXeKcsuWZCCY43Uz2p3GELc
        hNUHTOdsALOyjBfIlowYZGdPhgR3+AhVkuMil8ao/AZ+0BxzzQZjYxa99CuO9abKczOxws
        kDwAmLGXC8EMfwvKVpxlF5tr8La0vv5feWusLteatPH8OkFCHrJ75kx5rrcq4e2G/x1io/
        MmTjaWltI5HTpWlx5wZsth5GQq54FjMXmDzO1ViK8IPWWhzLERiYrJuPZeGWOMtEmLp6zD
        inAY3Qs5mIK0We4l5IM2BkJJovGu4t0hfMfnR5pWgDnoNXxkpIEehWEZ9GbUvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1663251825;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6fqgj6qZwblSD7CJXVafHPWquRZrtVqqXkwzgyNPlC8=;
        b=t4WtuLq+NPVTJKFHpydmnaQzfFpqKqTpk3BWRiLPkuiSXVB3DDNeO7gsBhlW+4W274s0zg
        wy3J5LKKHyuR/eAQ==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking: Detect includes rwlock.h outside of spinlock.h
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <YweemHxJx7O8rjBx@linutronix.de>
References: <YweemHxJx7O8rjBx@linutronix.de>
MIME-Version: 1.0
Message-ID: <166325182404.401.6620593298875827411.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     2747b93ebbede2af2d7bb088b9ddae3193ceede8
Gitweb:        https://git.kernel.org/tip/2747b93ebbede2af2d7bb088b9ddae3193ceede8
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Thu, 25 Aug 2022 18:08:56 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 15 Sep 2022 16:14:02 +02:00

locking: Detect includes rwlock.h outside of spinlock.h

From: Michael S. Tsirkin <mst@redhat.com>

The check for __LINUX_SPINLOCK_H within rwlock.h (and other files)
detects the direct include of the header file if it is at the very
beginning of the include section.
If it is listed later then chances are high that spinlock.h was already
included (including rwlock.h) and the additional listing of rwlock.h
will not cause any failure.

On PREEMPT_RT this additional rwlock.h will lead to compile failures
since it uses a different rwlock implementation.

Add __LINUX_INSIDE_SPINLOCK_H to spinlock.h and check for this instead
of __LINUX_SPINLOCK_H to detect wrong includes. This will help detect
direct includes of rwlock.h with without PREEMPT_RT enabled.

[ bigeasy: add remaining __LINUX_SPINLOCK_H user and rewrite
  commit description. ]

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/YweemHxJx7O8rjBx@linutronix.de
---
 include/linux/rwlock.h           | 2 +-
 include/linux/spinlock.h         | 2 ++
 include/linux/spinlock_api_smp.h | 2 +-
 include/linux/spinlock_api_up.h  | 2 +-
 include/linux/spinlock_rt.h      | 2 +-
 include/linux/spinlock_up.h      | 2 +-
 6 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/linux/rwlock.h b/include/linux/rwlock.h
index 8f416c5..c0ef596 100644
--- a/include/linux/rwlock.h
+++ b/include/linux/rwlock.h
@@ -1,7 +1,7 @@
 #ifndef __LINUX_RWLOCK_H
 #define __LINUX_RWLOCK_H
 
-#ifndef __LINUX_SPINLOCK_H
+#ifndef __LINUX_INSIDE_SPINLOCK_H
 # error "please don't include this file directly"
 #endif
 
diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index 5c0c517..1341f7d 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef __LINUX_SPINLOCK_H
 #define __LINUX_SPINLOCK_H
+#define __LINUX_INSIDE_SPINLOCK_H
 
 /*
  * include/linux/spinlock.h - generic spinlock/rwlock declarations
@@ -492,4 +493,5 @@ int __alloc_bucket_spinlocks(spinlock_t **locks, unsigned int *lock_mask,
 
 void free_bucket_spinlocks(spinlock_t *locks);
 
+#undef __LINUX_INSIDE_SPINLOCK_H
 #endif /* __LINUX_SPINLOCK_H */
diff --git a/include/linux/spinlock_api_smp.h b/include/linux/spinlock_api_smp.h
index 51fa0da..89eb6f4 100644
--- a/include/linux/spinlock_api_smp.h
+++ b/include/linux/spinlock_api_smp.h
@@ -1,7 +1,7 @@
 #ifndef __LINUX_SPINLOCK_API_SMP_H
 #define __LINUX_SPINLOCK_API_SMP_H
 
-#ifndef __LINUX_SPINLOCK_H
+#ifndef __LINUX_INSIDE_SPINLOCK_H
 # error "please don't include this file directly"
 #endif
 
diff --git a/include/linux/spinlock_api_up.h b/include/linux/spinlock_api_up.h
index b8ba00c..819aeba 100644
--- a/include/linux/spinlock_api_up.h
+++ b/include/linux/spinlock_api_up.h
@@ -1,7 +1,7 @@
 #ifndef __LINUX_SPINLOCK_API_UP_H
 #define __LINUX_SPINLOCK_API_UP_H
 
-#ifndef __LINUX_SPINLOCK_H
+#ifndef __LINUX_INSIDE_SPINLOCK_H
 # error "please don't include this file directly"
 #endif
 
diff --git a/include/linux/spinlock_rt.h b/include/linux/spinlock_rt.h
index 835aeda..61c49b1 100644
--- a/include/linux/spinlock_rt.h
+++ b/include/linux/spinlock_rt.h
@@ -2,7 +2,7 @@
 #ifndef __LINUX_SPINLOCK_RT_H
 #define __LINUX_SPINLOCK_RT_H
 
-#ifndef __LINUX_SPINLOCK_H
+#ifndef __LINUX_INSIDE_SPINLOCK_H
 #error Do not include directly. Use spinlock.h
 #endif
 
diff --git a/include/linux/spinlock_up.h b/include/linux/spinlock_up.h
index 1652107..c872042 100644
--- a/include/linux/spinlock_up.h
+++ b/include/linux/spinlock_up.h
@@ -1,7 +1,7 @@
 #ifndef __LINUX_SPINLOCK_UP_H
 #define __LINUX_SPINLOCK_UP_H
 
-#ifndef __LINUX_SPINLOCK_H
+#ifndef __LINUX_INSIDE_SPINLOCK_H
 # error "please don't include this file directly"
 #endif
 

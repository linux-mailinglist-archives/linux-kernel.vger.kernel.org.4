Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2685F742D2C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 21:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233422AbjF2TG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 15:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233560AbjF2TFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 15:05:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF10C359C;
        Thu, 29 Jun 2023 12:02:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7CBEB61632;
        Thu, 29 Jun 2023 19:02:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3658C433CC;
        Thu, 29 Jun 2023 19:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688065331;
        bh=qRBKFNeiJBoqbeHoZJUmMJ3MazBbqECGWW/+9Cqg73Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AFwY5x+rlPHAP/XP3fw3nJRIpU1zHC2LhlOLc/sPORNYgUpVr3nJwuQmqB6LXAjLI
         YUZu0b7mc7d6jCs/ql4MofWGqT89PWEGmpDaXwC4T4drgxKYyy+bWbaZ3ZLT1JGWQy
         bik/0qAN0wn07/bns9PPMLKjCmygpAhtRfpCBtlKpV8LYralG+gu4nDLRq0pq3FMgX
         Oa/OZS2HrS7inExZBJMd2yhcQ4Qbq7L0Ex+3c17L/uWXFapxFfMWPoKxo6r5vkj71j
         J64ETch8UEcP9nxygfNLbQ+salaeJcqL9ZT3hxqmNN/DUaX165fORs4bDSIH/eIXLO
         rE/6EfJC2wNAA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Airlie <airlied@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Tejun Heo <tj@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Sasha Levin <sashal@kernel.org>, llvm@lists.linux.dev
Subject: [PATCH AUTOSEL 5.10 4/4] workqueue: clean up WORK_* constant types, clarify masking
Date:   Thu, 29 Jun 2023 15:02:04 -0400
Message-Id: <20230629190206.908243-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230629190206.908243-1-sashal@kernel.org>
References: <20230629190206.908243-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.185
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>

[ Upstream commit afa4bb778e48d79e4a642ed41e3b4e0de7489a6c ]

Dave Airlie reports that gcc-13.1.1 has started complaining about some
of the workqueue code in 32-bit arm builds:

  kernel/workqueue.c: In function ‘get_work_pwq’:
  kernel/workqueue.c:713:24: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
    713 |                 return (void *)(data & WORK_STRUCT_WQ_DATA_MASK);
        |                        ^
  [ ... a couple of other cases ... ]

and while it's not immediately clear exactly why gcc started complaining
about it now, I suspect it's some C23-induced enum type handlign fixup in
gcc-13 is the cause.

Whatever the reason for starting to complain, the code and data types
are indeed disgusting enough that the complaint is warranted.

The wq code ends up creating various "helper constants" (like that
WORK_STRUCT_WQ_DATA_MASK) using an enum type, which is all kinds of
confused.  The mask needs to be 'unsigned long', not some unspecified
enum type.

To make matters worse, the actual "mask and cast to a pointer" is
repeated a couple of times, and the cast isn't even always done to the
right pointer, but - as the error case above - to a 'void *' with then
the compiler finishing the job.

That's now how we roll in the kernel.

So create the masks using the proper types rather than some ambiguous
enumeration, and use a nice helper that actually does the type
conversion in one well-defined place.

Incidentally, this magically makes clang generate better code.  That,
admittedly, is really just a sign of clang having been seriously
confused before, and cleaning up the typing unconfuses the compiler too.

Reported-by: Dave Airlie <airlied@gmail.com>
Link: https://lore.kernel.org/lkml/CAPM=9twNnV4zMCvrPkw3H-ajZOH-01JVh_kDrxdPYQErz8ZTdA@mail.gmail.com/
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Tejun Heo <tj@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/workqueue.h | 15 ++++++++-------
 kernel/workqueue.c        | 13 ++++++++-----
 2 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 2fa9b311e5663..460c58fa011ae 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -73,7 +73,6 @@ enum {
 	WORK_OFFQ_FLAG_BASE	= WORK_STRUCT_COLOR_SHIFT,
 
 	__WORK_OFFQ_CANCELING	= WORK_OFFQ_FLAG_BASE,
-	WORK_OFFQ_CANCELING	= (1 << __WORK_OFFQ_CANCELING),
 
 	/*
 	 * When a work item is off queue, its high bits point to the last
@@ -84,12 +83,6 @@ enum {
 	WORK_OFFQ_POOL_SHIFT	= WORK_OFFQ_FLAG_BASE + WORK_OFFQ_FLAG_BITS,
 	WORK_OFFQ_LEFT		= BITS_PER_LONG - WORK_OFFQ_POOL_SHIFT,
 	WORK_OFFQ_POOL_BITS	= WORK_OFFQ_LEFT <= 31 ? WORK_OFFQ_LEFT : 31,
-	WORK_OFFQ_POOL_NONE	= (1LU << WORK_OFFQ_POOL_BITS) - 1,
-
-	/* convenience constants */
-	WORK_STRUCT_FLAG_MASK	= (1UL << WORK_STRUCT_FLAG_BITS) - 1,
-	WORK_STRUCT_WQ_DATA_MASK = ~WORK_STRUCT_FLAG_MASK,
-	WORK_STRUCT_NO_POOL	= (unsigned long)WORK_OFFQ_POOL_NONE << WORK_OFFQ_POOL_SHIFT,
 
 	/* bit mask for work_busy() return values */
 	WORK_BUSY_PENDING	= 1 << 0,
@@ -99,6 +92,14 @@ enum {
 	WORKER_DESC_LEN		= 24,
 };
 
+/* Convenience constants - of type 'unsigned long', not 'enum'! */
+#define WORK_OFFQ_CANCELING	(1ul << __WORK_OFFQ_CANCELING)
+#define WORK_OFFQ_POOL_NONE	((1ul << WORK_OFFQ_POOL_BITS) - 1)
+#define WORK_STRUCT_NO_POOL	(WORK_OFFQ_POOL_NONE << WORK_OFFQ_POOL_SHIFT)
+
+#define WORK_STRUCT_FLAG_MASK    ((1ul << WORK_STRUCT_FLAG_BITS) - 1)
+#define WORK_STRUCT_WQ_DATA_MASK (~WORK_STRUCT_FLAG_MASK)
+
 struct work_struct {
 	atomic_long_t data;
 	struct list_head entry;
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index b9041ab881bc8..fa0a0e59b3851 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -679,12 +679,17 @@ static void clear_work_data(struct work_struct *work)
 	set_work_data(work, WORK_STRUCT_NO_POOL, 0);
 }
 
+static inline struct pool_workqueue *work_struct_pwq(unsigned long data)
+{
+	return (struct pool_workqueue *)(data & WORK_STRUCT_WQ_DATA_MASK);
+}
+
 static struct pool_workqueue *get_work_pwq(struct work_struct *work)
 {
 	unsigned long data = atomic_long_read(&work->data);
 
 	if (data & WORK_STRUCT_PWQ)
-		return (void *)(data & WORK_STRUCT_WQ_DATA_MASK);
+		return work_struct_pwq(data);
 	else
 		return NULL;
 }
@@ -712,8 +717,7 @@ static struct worker_pool *get_work_pool(struct work_struct *work)
 	assert_rcu_or_pool_mutex();
 
 	if (data & WORK_STRUCT_PWQ)
-		return ((struct pool_workqueue *)
-			(data & WORK_STRUCT_WQ_DATA_MASK))->pool;
+		return work_struct_pwq(data)->pool;
 
 	pool_id = data >> WORK_OFFQ_POOL_SHIFT;
 	if (pool_id == WORK_OFFQ_POOL_NONE)
@@ -734,8 +738,7 @@ static int get_work_pool_id(struct work_struct *work)
 	unsigned long data = atomic_long_read(&work->data);
 
 	if (data & WORK_STRUCT_PWQ)
-		return ((struct pool_workqueue *)
-			(data & WORK_STRUCT_WQ_DATA_MASK))->pool->id;
+		return work_struct_pwq(data)->pool->id;
 
 	return data >> WORK_OFFQ_POOL_SHIFT;
 }
-- 
2.39.2


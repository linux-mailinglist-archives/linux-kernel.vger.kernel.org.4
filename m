Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73F1F6B673D
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 15:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjCLOl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 10:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjCLOlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 10:41:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A6F4393B;
        Sun, 12 Mar 2023 07:41:16 -0700 (PDT)
Date:   Sun, 12 Mar 2023 14:41:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1678632074;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ySpyZOoTqzSKRmAKJo10i+xEae61uYIC7VjmoPx3Sdk=;
        b=uPLIiYrJgNP5eXFvhBHoRIk1RgiHA9bFXeQresLLondz3YStZgG0sRdwU8h7XgfRBkDbwQ
        NJlXh0ijpeC9tPmKF47xYvX4e/gTh/Y5+VQuLKQHH+gdX7WUMnA6cUfIZwIjjT5E8ulkTj
        FvU7FdPGYmo5JDdmIKCbPylfxfJ3h6jkZAPRcuHtcvvXDNyd/0hpGmHdYJcGZA2N04H8bx
        vDbhiIlukNyJlpJogTU3o3n67Vbt6Ob8qYivgVdHGb5S0+odJX0TZtIoogJrl+H+dTiSyd
        qi17+m4PzZq911R5Iwsi/NbFABCCR4lnXSNRHLjN+FqYUVsbYxhuZDy/4SUsLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1678632074;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ySpyZOoTqzSKRmAKJo10i+xEae61uYIC7VjmoPx3Sdk=;
        b=d5rNLZP2BhRHQIiUsKOskLLrJdT7XH2TTrLDHS7QxM/IGuyWvNX69kqaJcUxXEKUwcice4
        lsACW7gQwTHklOBA==
From:   "tip-bot2 for Andrzej Hajda" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] io_uring: use __xchg if possible
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andi Shyti <andi.shyti@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230118154450.73842-5-andrzej.hajda@intel.com>
References: <20230118154450.73842-5-andrzej.hajda@intel.com>
MIME-Version: 1.0
Message-ID: <167863207362.5837.13623012047790271971.tip-bot2@tip-bot2>
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

Commit-ID:     bd1e2670ebd10ad727b92ddd424cca270314f5ee
Gitweb:        https://git.kernel.org/tip/bd1e2670ebd10ad727b92ddd424cca270314f5ee
Author:        Andrzej Hajda <andrzej.hajda@intel.com>
AuthorDate:    Wed, 18 Jan 2023 16:44:48 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 11 Mar 2023 14:03:59 +01:00

io_uring: use __xchg if possible

Recently introduced helper simplifies the code.

Signed-off-by: Andrzej Hajda <andrzej.hajda@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
Link: https://lore.kernel.org/r/20230118154450.73842-5-andrzej.hajda@intel.com
---
 io_uring/io_uring.c | 7 ++-----
 io_uring/slist.h    | 6 ++----
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index fd1cc35..0cd89a3 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -54,6 +54,7 @@
 #include <linux/fdtable.h>
 #include <linux/mm.h>
 #include <linux/mman.h>
+#include <linux/non-atomic/xchg.h>
 #include <linux/percpu.h>
 #include <linux/slab.h>
 #include <linux/bvec.h>
@@ -1131,8 +1132,6 @@ static void __io_req_find_next_prep(struct io_kiocb *req)
 
 static inline struct io_kiocb *io_req_find_next(struct io_kiocb *req)
 {
-	struct io_kiocb *nxt;
-
 	/*
 	 * If LINK is set, we have dependent requests in this chain. If we
 	 * didn't fail this request, queue the first one up, moving any other
@@ -1141,9 +1140,7 @@ static inline struct io_kiocb *io_req_find_next(struct io_kiocb *req)
 	 */
 	if (unlikely(req->flags & IO_DISARM_MASK))
 		__io_req_find_next_prep(req);
-	nxt = req->link;
-	req->link = NULL;
-	return nxt;
+	return __xchg(&req->link, NULL);
 }
 
 static void ctx_flush_and_put(struct io_ring_ctx *ctx, bool *locked)
diff --git a/io_uring/slist.h b/io_uring/slist.h
index 7c198a4..051e577 100644
--- a/io_uring/slist.h
+++ b/io_uring/slist.h
@@ -2,6 +2,7 @@
 #define INTERNAL_IO_SLIST_H
 
 #include <linux/io_uring_types.h>
+#include <linux/non-atomic/xchg.h>
 
 #define wq_list_for_each(pos, prv, head)			\
 	for (pos = (head)->first, prv = NULL; pos; prv = pos, pos = (pos)->next)
@@ -99,10 +100,7 @@ static inline void wq_list_del(struct io_wq_work_list *list,
 static inline
 struct io_wq_work_node *wq_stack_extract(struct io_wq_work_node *stack)
 {
-	struct io_wq_work_node *node = stack->next;
-
-	stack->next = node->next;
-	return node;
+	return __xchg(&stack->next, stack->next->next);
 }
 
 static inline struct io_wq_work *wq_next_work(struct io_wq_work *work)

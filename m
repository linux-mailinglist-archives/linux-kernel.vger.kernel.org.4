Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4E3649EB5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 13:33:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232239AbiLLMd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 07:33:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232122AbiLLMdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 07:33:03 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B84111A00
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 04:32:59 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id n65-20020a17090a2cc700b0021bc5ef7a14so12080384pjd.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 04:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OkVJDMV1dLbnY0a97cBJ8dALMRcKW3eBADQn81KDV+U=;
        b=eipWx9/prrMwJzeGbMBSVMSc4mPPoBwq9qXM7SCQHwfIqG7At4VURyR3GWLh0lJSYT
         bZYEPzUMMenHa+z146tDJ11mWMNZUEdKd1QaAbJeBdvUE1NmnWURsdavgfWsVhD5YW4n
         Go5wvuGKCcn3gCYRJrx6F/2h7RmNwzJkOx4ziS03wAgEyBnBEOVQwcEzwJPDDnpNtJgB
         8OEyYMVDz0FkhfotU8jr3/h0qai1STtGJmyqoPA5m/+PXi1zD/DBDB+tAjphBUUeTgwX
         2avcWaivcMPuReDR/zMOQ16txxltbIUB9iItbU3EfoiABgKFnABClbYdVrrC95H6l9fh
         8Stg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OkVJDMV1dLbnY0a97cBJ8dALMRcKW3eBADQn81KDV+U=;
        b=HJP7naKjPSi3ANEkdznYtu5EVyui9CFViglXcigxvKg3Q+e9OPgEsqoOwpVbuBt2Ak
         0rkqM+TXxpjg+Swtn+0QjpFv6LzGKRt7R3/3dZbjRpeQy0TzpKas5+PVPPb8qs1TBe8u
         UoWQdI3CMSHSL0NneMBl2F031TjoBBYGj11No+UyawbYZGnkiOMbwKcCxmpqNhPA6xdr
         3E3Gl4RczN59T3uTPUWF+vw/10XKZEdliFhw7n6B9wIkcz/mb17ac25MrU0EtZxWW38a
         HbUt29TFjJCtbKl3Gr8m4Gu7LHJW7m6C8PMZVAun+jJcNvmMPnmKE/cAhOu+R3Gfc0E5
         hCIA==
X-Gm-Message-State: ANoB5pmnKrm2A6A2UOyGvKOIjehrNCUzXPbI853CbGwK2t08DLpcfFTJ
        p1f/oDenE5gC4/hBC9Cv2B1+GA==
X-Google-Smtp-Source: AA0mqf4QiFDwVMRM3HcqDlh/yC5oWizHFHwqJEcIQw6BPGs55pvLq91XwxGWqyj0BtEg5LnyKQ6s1A==
X-Received: by 2002:a17:902:e743:b0:187:34f6:3323 with SMTP id p3-20020a170902e74300b0018734f63323mr23892675plf.59.1670848378982;
        Mon, 12 Dec 2022 04:32:58 -0800 (PST)
Received: from devtp.bytedance.net ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id jw1-20020a170903278100b001869ba04c83sm6219987plb.245.2022.12.12.04.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 04:32:58 -0800 (PST)
From:   wuqiang <wuqiang.matt@bytedance.com>
To:     mhiramat@kernel.org, davem@davemloft.net,
        anil.s.keshavamurthy@intel.com, naveen.n.rao@linux.ibm.com,
        rostedt@goodmis.org, peterz@infradead.org,
        akpm@linux-foundation.org, sander@svanheule.net,
        ebiggers@google.com, dan.j.williams@intel.com, jpoimboe@kernel.org
Cc:     linux-kernel@vger.kernel.org, lkp@intel.com, mattwu@163.com,
        wuqiang <wuqiang.matt@bytedance.com>
Subject: [PATCH v7 4/5] kprobes: freelist.h removed
Date:   Mon, 12 Dec 2022 20:31:52 +0800
Message-Id: <20221212123153.190888-5-wuqiang.matt@bytedance.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221212123153.190888-1-wuqiang.matt@bytedance.com>
References: <20221212123153.190888-1-wuqiang.matt@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch will remove freelist.h from kernel source tree, since the
only use cases (kretprobe and rethook) are converted to objpool.

Signed-off-by: wuqiang <wuqiang.matt@bytedance.com>
---
 include/linux/freelist.h | 129 ---------------------------------------
 1 file changed, 129 deletions(-)
 delete mode 100644 include/linux/freelist.h

diff --git a/include/linux/freelist.h b/include/linux/freelist.h
deleted file mode 100644
index fc1842b96469..000000000000
--- a/include/linux/freelist.h
+++ /dev/null
@@ -1,129 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
-#ifndef FREELIST_H
-#define FREELIST_H
-
-#include <linux/atomic.h>
-
-/*
- * Copyright: cameron@moodycamel.com
- *
- * A simple CAS-based lock-free free list. Not the fastest thing in the world
- * under heavy contention, but simple and correct (assuming nodes are never
- * freed until after the free list is destroyed), and fairly speedy under low
- * contention.
- *
- * Adapted from: https://moodycamel.com/blog/2014/solving-the-aba-problem-for-lock-free-free-lists
- */
-
-struct freelist_node {
-	atomic_t		refs;
-	struct freelist_node	*next;
-};
-
-struct freelist_head {
-	struct freelist_node	*head;
-};
-
-#define REFS_ON_FREELIST 0x80000000
-#define REFS_MASK	 0x7FFFFFFF
-
-static inline void __freelist_add(struct freelist_node *node, struct freelist_head *list)
-{
-	/*
-	 * Since the refcount is zero, and nobody can increase it once it's
-	 * zero (except us, and we run only one copy of this method per node at
-	 * a time, i.e. the single thread case), then we know we can safely
-	 * change the next pointer of the node; however, once the refcount is
-	 * back above zero, then other threads could increase it (happens under
-	 * heavy contention, when the refcount goes to zero in between a load
-	 * and a refcount increment of a node in try_get, then back up to
-	 * something non-zero, then the refcount increment is done by the other
-	 * thread) -- so if the CAS to add the node to the actual list fails,
-	 * decrese the refcount and leave the add operation to the next thread
-	 * who puts the refcount back to zero (which could be us, hence the
-	 * loop).
-	 */
-	struct freelist_node *head = READ_ONCE(list->head);
-
-	for (;;) {
-		WRITE_ONCE(node->next, head);
-		atomic_set_release(&node->refs, 1);
-
-		if (!try_cmpxchg_release(&list->head, &head, node)) {
-			/*
-			 * Hmm, the add failed, but we can only try again when
-			 * the refcount goes back to zero.
-			 */
-			if (atomic_fetch_add_release(REFS_ON_FREELIST - 1, &node->refs) == 1)
-				continue;
-		}
-		return;
-	}
-}
-
-static inline void freelist_add(struct freelist_node *node, struct freelist_head *list)
-{
-	/*
-	 * We know that the should-be-on-freelist bit is 0 at this point, so
-	 * it's safe to set it using a fetch_add.
-	 */
-	if (!atomic_fetch_add_release(REFS_ON_FREELIST, &node->refs)) {
-		/*
-		 * Oh look! We were the last ones referencing this node, and we
-		 * know we want to add it to the free list, so let's do it!
-		 */
-		__freelist_add(node, list);
-	}
-}
-
-static inline struct freelist_node *freelist_try_get(struct freelist_head *list)
-{
-	struct freelist_node *prev, *next, *head = smp_load_acquire(&list->head);
-	unsigned int refs;
-
-	while (head) {
-		prev = head;
-		refs = atomic_read(&head->refs);
-		if ((refs & REFS_MASK) == 0 ||
-		    !atomic_try_cmpxchg_acquire(&head->refs, &refs, refs+1)) {
-			head = smp_load_acquire(&list->head);
-			continue;
-		}
-
-		/*
-		 * Good, reference count has been incremented (it wasn't at
-		 * zero), which means we can read the next and not worry about
-		 * it changing between now and the time we do the CAS.
-		 */
-		next = READ_ONCE(head->next);
-		if (try_cmpxchg_acquire(&list->head, &head, next)) {
-			/*
-			 * Yay, got the node. This means it was on the list,
-			 * which means should-be-on-freelist must be false no
-			 * matter the refcount (because nobody else knows it's
-			 * been taken off yet, it can't have been put back on).
-			 */
-			WARN_ON_ONCE(atomic_read(&head->refs) & REFS_ON_FREELIST);
-
-			/*
-			 * Decrease refcount twice, once for our ref, and once
-			 * for the list's ref.
-			 */
-			atomic_fetch_add(-2, &head->refs);
-
-			return head;
-		}
-
-		/*
-		 * OK, the head must have changed on us, but we still need to decrement
-		 * the refcount we increased.
-		 */
-		refs = atomic_fetch_add(-1, &prev->refs);
-		if (refs == REFS_ON_FREELIST + 1)
-			__freelist_add(prev, list);
-	}
-
-	return NULL;
-}
-
-#endif /* FREELIST_H */
-- 
2.34.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 271F7722F94
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 21:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235663AbjFETRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 15:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235345AbjFETQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 15:16:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C18131;
        Mon,  5 Jun 2023 12:16:21 -0700 (PDT)
Date:   Mon, 05 Jun 2023 19:16:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685992580;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dIi96m4QyCUQHfMrUC8WJDqLTIqs0bPtYIDfR912ZMI=;
        b=xl2OeToJMYSCYavvN2z7aNgJ/GWRTdudvYaLbmy/F0frsyJQTBfLqYO4cd2cVTj54lNZIF
        bXSCzWwL491eyw0654HaggQsvXFkymg8aKRzZIZa0eGkAPL/9rhv4nzztQbVq6Gqym9BCO
        IIDBZh/SJJtmlBLgJLI6WWkieA9jrMFlFGv/6GpcMhpV1VRazCiIFShhSwfINhsvsGmv7p
        bjnNbm7mg3q4mo4EXXnOFhzOO690t/K2KTIeOdC4tXtheAVh9VdVsNdWZT/VDFH+UKu4Y5
        BZE2IP7eaDliyi42awfdE7MoAMftF6FtapdW9Am1d8gl3PbE9S4P3Sz2T01Hsg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685992580;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dIi96m4QyCUQHfMrUC8WJDqLTIqs0bPtYIDfR912ZMI=;
        b=/+FZRc+3P3RxC/oI6Ie0U0EHSbKiM7ZOwh8OpZbQzKZn+pfVIe7fDl5xbltD+bKku/eLj/
        9u6qLXi+C/SEElCQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] seqlock/latch: Provide raw_read_seqcount_latch_retry()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        Michael Kelley <mikelley@microsoft.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230519102715.233598176@infradead.org>
References: <20230519102715.233598176@infradead.org>
MIME-Version: 1.0
Message-ID: <168599257987.404.1603603912054856425.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     d16317de9b412aa7bd3598c607112298e36b4352
Gitweb:        https://git.kernel.org/tip/d16317de9b412aa7bd3598c607112298e36b4352
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 19 May 2023 12:20:59 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 05 Jun 2023 21:11:03 +02:00

seqlock/latch: Provide raw_read_seqcount_latch_retry()

The read side of seqcount_latch consists of:

  do {
    seq = raw_read_seqcount_latch(&latch->seq);
    ...
  } while (read_seqcount_latch_retry(&latch->seq, seq));

which is asymmetric in the raw_ department, and sure enough,
read_seqcount_latch_retry() includes (explicit) instrumentation where
raw_read_seqcount_latch() does not.

This inconsistency becomes a problem when trying to use it from
noinstr code. As such, fix it by renaming and re-implementing
raw_read_seqcount_latch_retry() without the instrumentation.

Specifically the instrumentation in question is kcsan_atomic_next(0)
in do___read_seqcount_retry(). Loosing this annotation is not a
problem because raw_read_seqcount_latch() does not pass through
kcsan_atomic_next(KCSAN_SEQLOCK_REGION_MAX).

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Tested-by: Michael Kelley <mikelley@microsoft.com>  # Hyper-V
Link: https://lore.kernel.org/r/20230519102715.233598176@infradead.org
---
 include/linux/rbtree_latch.h |  2 +-
 include/linux/seqlock.h      | 15 ++++++++-------
 kernel/printk/printk.c       |  2 +-
 kernel/time/sched_clock.c    |  2 +-
 kernel/time/timekeeping.c    |  4 ++--
 5 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/include/linux/rbtree_latch.h b/include/linux/rbtree_latch.h
index 3d1a9e7..6a0999c 100644
--- a/include/linux/rbtree_latch.h
+++ b/include/linux/rbtree_latch.h
@@ -206,7 +206,7 @@ latch_tree_find(void *key, struct latch_tree_root *root,
 	do {
 		seq = raw_read_seqcount_latch(&root->seq);
 		node = __lt_find(key, root, seq & 1, ops->comp);
-	} while (read_seqcount_latch_retry(&root->seq, seq));
+	} while (raw_read_seqcount_latch_retry(&root->seq, seq));
 
 	return node;
 }
diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 3926e90..987a59d 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -671,9 +671,9 @@ typedef struct {
  *
  * Return: sequence counter raw value. Use the lowest bit as an index for
  * picking which data copy to read. The full counter must then be checked
- * with read_seqcount_latch_retry().
+ * with raw_read_seqcount_latch_retry().
  */
-static inline unsigned raw_read_seqcount_latch(const seqcount_latch_t *s)
+static __always_inline unsigned raw_read_seqcount_latch(const seqcount_latch_t *s)
 {
 	/*
 	 * Pairs with the first smp_wmb() in raw_write_seqcount_latch().
@@ -683,16 +683,17 @@ static inline unsigned raw_read_seqcount_latch(const seqcount_latch_t *s)
 }
 
 /**
- * read_seqcount_latch_retry() - end a seqcount_latch_t read section
+ * raw_read_seqcount_latch_retry() - end a seqcount_latch_t read section
  * @s:		Pointer to seqcount_latch_t
  * @start:	count, from raw_read_seqcount_latch()
  *
  * Return: true if a read section retry is required, else false
  */
-static inline int
-read_seqcount_latch_retry(const seqcount_latch_t *s, unsigned start)
+static __always_inline int
+raw_read_seqcount_latch_retry(const seqcount_latch_t *s, unsigned start)
 {
-	return read_seqcount_retry(&s->seqcount, start);
+	smp_rmb();
+	return unlikely(READ_ONCE(s->seqcount.sequence) != start);
 }
 
 /**
@@ -752,7 +753,7 @@ read_seqcount_latch_retry(const seqcount_latch_t *s, unsigned start)
  *			entry = data_query(latch->data[idx], ...);
  *
  *		// This includes needed smp_rmb()
- *		} while (read_seqcount_latch_retry(&latch->seq, seq));
+ *		} while (raw_read_seqcount_latch_retry(&latch->seq, seq));
  *
  *		return entry;
  *	}
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 6a333ad..357a4d1 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -528,7 +528,7 @@ static u64 latched_seq_read_nolock(struct latched_seq *ls)
 		seq = raw_read_seqcount_latch(&ls->latch);
 		idx = seq & 0x1;
 		val = ls->val[idx];
-	} while (read_seqcount_latch_retry(&ls->latch, seq));
+	} while (raw_read_seqcount_latch_retry(&ls->latch, seq));
 
 	return val;
 }
diff --git a/kernel/time/sched_clock.c b/kernel/time/sched_clock.c
index 8464c5a..e8f2fb0 100644
--- a/kernel/time/sched_clock.c
+++ b/kernel/time/sched_clock.c
@@ -77,7 +77,7 @@ notrace struct clock_read_data *sched_clock_read_begin(unsigned int *seq)
 
 notrace int sched_clock_read_retry(unsigned int seq)
 {
-	return read_seqcount_latch_retry(&cd.seq, seq);
+	return raw_read_seqcount_latch_retry(&cd.seq, seq);
 }
 
 unsigned long long notrace sched_clock(void)
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 09d5949..266d028 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -450,7 +450,7 @@ static __always_inline u64 __ktime_get_fast_ns(struct tk_fast *tkf)
 		tkr = tkf->base + (seq & 0x01);
 		now = ktime_to_ns(tkr->base);
 		now += fast_tk_get_delta_ns(tkr);
-	} while (read_seqcount_latch_retry(&tkf->seq, seq));
+	} while (raw_read_seqcount_latch_retry(&tkf->seq, seq));
 
 	return now;
 }
@@ -566,7 +566,7 @@ static __always_inline u64 __ktime_get_real_fast(struct tk_fast *tkf, u64 *mono)
 		basem = ktime_to_ns(tkr->base);
 		baser = ktime_to_ns(tkr->base_real);
 		delta = fast_tk_get_delta_ns(tkr);
-	} while (read_seqcount_latch_retry(&tkf->seq, seq));
+	} while (raw_read_seqcount_latch_retry(&tkf->seq, seq));
 
 	if (mono)
 		*mono = basem + delta;

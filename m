Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED1006E1696
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 23:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjDMVnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 17:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjDMVnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 17:43:45 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91FAC40EE
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 14:43:43 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 186-20020a2510c3000000b00b880000325bso33516350ybq.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 14:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681422223; x=1684014223;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0cXhr/0vViBCou2AobOWelqCRwyRDRt9EBxxuCD7JWc=;
        b=q5EyTw1L+OjKhrdPZfZnE7CuuFCAB3ha/ZJ1IJCFNrCDw+2Yo6TB7XWbH1wiXD9Vmt
         +SZdL1mAoflmzcQRMa10JlA4soOs8o8IOfWObzsx0V5rfNfQgSVTC2ntJR7oHgLunb4o
         j+yJUt49CATat0fNkSPvORmjnV6c0nGUFf+Mrk669jhWOBLK7OC/HtGMg7xeEbnJqB+S
         tvtnIJ6wOyrp3qXdwJlWommwwiGtCi/cFMAwjHG1Vt1I1jrqzwENmAS72EzG8RWuzNqb
         6oEHRjo0gVJdBe9fewwL7Rgzd8JJxZpN131FaY9ifgijNky4elrcZp6o8zzeYk2HX+vd
         UePw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681422223; x=1684014223;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0cXhr/0vViBCou2AobOWelqCRwyRDRt9EBxxuCD7JWc=;
        b=DAv/aGmuFXNJHkSusS05pRuoKQ/7OZRVQXPudx+le0tUkEhHh+7Mb06XEiu+bHhcNZ
         TAEujtD6XKJENpHm6QA2rF30ofAF9UIIY2RljDwZkSVeTYswWTzWw/Xc5bQqDDzgAEDU
         fvt5G7bTHK7sRRLx0n/5bRtgStGLVk1jFVBpmmC6NRVlw0eLDc7ypHTCkBDvrv8VFspN
         mIAS7w5dHHGofhLoHNzMCcXfbOEsVr73/FAr4BB2n9/b4ONIh/UBE+aew8OskEHMi9rJ
         R3QPx1707tcEJiqvlASYKYI1Ht+xjrwiWKCmUXLUq0nG49N0KxDgiCW7s+9Nyzb9BfMi
         h2CA==
X-Gm-Message-State: AAQBX9f1nHhHzCzbn1vrq/ojHB5NsN03CjOeRTYZ520o1TvvPV/ZRyPl
        gg4IyEJuTLQ10ZP3rJnONWLBzYgUbebzYAdtIw==
X-Google-Smtp-Source: AKy350bdpGMqxM8VuJbWEo9RboQytzXx9gu6cIeR9z6xE74PRMs9klWsEvZoauGhXodrEz9E7tUwP+qXnq9ASIfQWg==
X-Received: from kalesh.mtv.corp.google.com ([2620:15c:211:201:9ada:6023:3d9b:2ecc])
 (user=kaleshsingh job=sendgmr) by 2002:a25:774f:0:b0:b8f:66a1:6e1c with SMTP
 id s76-20020a25774f000000b00b8f66a16e1cmr1284338ybc.7.1681422222831; Thu, 13
 Apr 2023 14:43:42 -0700 (PDT)
Date:   Thu, 13 Apr 2023 14:43:26 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230413214326.2147568-1-kaleshsingh@google.com>
Subject: [PATCH] mm: Multi-gen LRU: remove wait_event_killable()
From:   Kalesh Singh <kaleshsingh@google.com>
To:     yuzhao@google.com, minchan@google.com, akpm@linux-foundation.org
Cc:     surenb@google.com, wvw@google.com, android-mm@google.com,
        kernel-team@android.com, Kalesh Singh <kaleshsingh@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        "Jan Alexander Steffens (heftig)" <heftig@archlinux.org>,
        Suleiman Souhlal <suleiman@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Android 14 and later default to MGLRU [1] and field telemetry showed
occasional long tail latency (>100ms) in the reclaim path.

Tracing revealed priority inversion in the reclaim path. In
try_to_inc_max_seq(), when high priority tasks were blocked on
wait_event_killable(), the preemption of the low priority task to call
wake_up_all() caused those high priority tasks to wait longer than
necessary. In general, this problem is not different from others of
its kind, e.g., one caused by mutex_lock(). However, it is specific to
MGLRU because it introduced the new wait queue lruvec->mm_state.wait.

The purpose of this new wait queue is to avoid the thundering herd
problem. If many direct reclaimers rush into try_to_inc_max_seq(),
only one can succeed, i.e., the one to wake up the rest, and the rest
who failed might cause premature OOM kills if they do not wait. So far
there is no evidence supporting this scenario, based on how often the
wait has been hit. And this begs the question how useful the wait
queue is in practice.

Based on Minchan's recommendation, which is in line with his commit
6d4675e60135 ("mm: don't be stuck to rmap lock on reclaim path") and
the rest of the MGLRU code which also uses trylock when possible,
remove the wait queue.

[1] https://android-review.googlesource.com/q/I7ed7fbfd6ef9ce10053347528125dd98c39e50bf

Fixes: bd74fdaea146 ("mm: multi-gen LRU: support page table walks")
Cc: Yu Zhao <yuzhao@google.com>
Cc: Minchan Kim <minchan@kernel.org>
Reported-by: Wei Wang <wvw@google.com>
Suggested-by: Minchan Kim <minchan@kernel.org>
Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---
 include/linux/mmzone.h |   8 +--
 mm/vmscan.c            | 112 +++++++++++++++--------------------------
 2 files changed, 42 insertions(+), 78 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 9fb1b03b83b2..4509ac2b54a6 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -453,18 +453,14 @@ enum {
 struct lru_gen_mm_state {
 	/* set to max_seq after each iteration */
 	unsigned long seq;
-	/* where the current iteration continues (inclusive) */
+	/* where the current iteration continues after */
 	struct list_head *head;
-	/* where the last iteration ended (exclusive) */
+	/* where the last iteration ended before */
 	struct list_head *tail;
-	/* to wait for the last page table walker to finish */
-	struct wait_queue_head wait;
 	/* Bloom filters flip after each iteration */
 	unsigned long *filters[NR_BLOOM_FILTERS];
 	/* the mm stats for debugging */
 	unsigned long stats[NR_HIST_GENS][NR_MM_STATS];
-	/* the number of concurrent page table walkers */
-	int nr_walkers;
 };
 
 struct lru_gen_mm_walk {
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 9c1c5e8b24b8..a038fe70dda0 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3394,18 +3394,13 @@ void lru_gen_del_mm(struct mm_struct *mm)
 	for_each_node(nid) {
 		struct lruvec *lruvec = get_lruvec(memcg, nid);
 
-		/* where the last iteration ended (exclusive) */
+		/* where the current iteration continues after */
+		if (lruvec->mm_state.head == &mm->lru_gen.list)
+			lruvec->mm_state.head = lruvec->mm_state.head->prev;
+
+		/* where the last iteration ended before */
 		if (lruvec->mm_state.tail == &mm->lru_gen.list)
 			lruvec->mm_state.tail = lruvec->mm_state.tail->next;
-
-		/* where the current iteration continues (inclusive) */
-		if (lruvec->mm_state.head != &mm->lru_gen.list)
-			continue;
-
-		lruvec->mm_state.head = lruvec->mm_state.head->next;
-		/* the deletion ends the current iteration */
-		if (lruvec->mm_state.head == &mm_list->fifo)
-			WRITE_ONCE(lruvec->mm_state.seq, lruvec->mm_state.seq + 1);
 	}
 
 	list_del_init(&mm->lru_gen.list);
@@ -3501,68 +3496,54 @@ static bool iterate_mm_list(struct lruvec *lruvec, struct lru_gen_mm_walk *walk,
 			    struct mm_struct **iter)
 {
 	bool first = false;
-	bool last = true;
+	bool last = false;
 	struct mm_struct *mm = NULL;
 	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
 	struct lru_gen_mm_list *mm_list = get_mm_list(memcg);
 	struct lru_gen_mm_state *mm_state = &lruvec->mm_state;
 
 	/*
-	 * There are four interesting cases for this page table walker:
-	 * 1. It tries to start a new iteration of mm_list with a stale max_seq;
-	 *    there is nothing left to do.
-	 * 2. It's the first of the current generation, and it needs to reset
-	 *    the Bloom filter for the next generation.
-	 * 3. It reaches the end of mm_list, and it needs to increment
-	 *    mm_state->seq; the iteration is done.
-	 * 4. It's the last of the current generation, and it needs to reset the
-	 *    mm stats counters for the next generation.
+	 * mm_state->seq is incremented after each iteration of mm_list. There
+	 * are three interesting cases for this page table walker:
+	 * 1. It tries to start a new iteration with a stale max_seq: there is
+	 *    nothing left to do.
+	 * 2. It started the next iteration: it needs to reset the Bloom filter
+	 *    so that a fresh set of PTE tables can be recorded.
+	 * 3. It ended the current iteration: it needs to reset the mm stats
+	 *    counters and tell its caller to increment max_seq.
 	 */
 	spin_lock(&mm_list->lock);
 
 	VM_WARN_ON_ONCE(mm_state->seq + 1 < walk->max_seq);
-	VM_WARN_ON_ONCE(*iter && mm_state->seq > walk->max_seq);
-	VM_WARN_ON_ONCE(*iter && !mm_state->nr_walkers);
 
-	if (walk->max_seq <= mm_state->seq) {
-		if (!*iter)
-			last = false;
+	if (walk->max_seq <= mm_state->seq)
 		goto done;
-	}
 
-	if (!mm_state->nr_walkers) {
-		VM_WARN_ON_ONCE(mm_state->head && mm_state->head != &mm_list->fifo);
+	if (!mm_state->head)
+		mm_state->head = &mm_list->fifo;
 
-		mm_state->head = mm_list->fifo.next;
+	if (mm_state->head == &mm_list->fifo)
 		first = true;
-	}
-
-	while (!mm && mm_state->head != &mm_list->fifo) {
-		mm = list_entry(mm_state->head, struct mm_struct, lru_gen.list);
 
+	do {
 		mm_state->head = mm_state->head->next;
+		if (mm_state->head == &mm_list->fifo) {
+			WRITE_ONCE(mm_state->seq, mm_state->seq + 1);
+			last = true;
+			break;
+		}
 
 		/* force scan for those added after the last iteration */
-		if (!mm_state->tail || mm_state->tail == &mm->lru_gen.list) {
-			mm_state->tail = mm_state->head;
+		if (!mm_state->tail || mm_state->tail == mm_state->head) {
+			mm_state->tail = mm_state->head->next;
 			walk->force_scan = true;
 		}
 
+		mm = list_entry(mm_state->head, struct mm_struct, lru_gen.list);
 		if (should_skip_mm(mm, walk))
 			mm = NULL;
-	}
-
-	if (mm_state->head == &mm_list->fifo)
-		WRITE_ONCE(mm_state->seq, mm_state->seq + 1);
+	} while (!mm);
 done:
-	if (*iter && !mm)
-		mm_state->nr_walkers--;
-	if (!*iter && mm)
-		mm_state->nr_walkers++;
-
-	if (mm_state->nr_walkers)
-		last = false;
-
 	if (*iter || last)
 		reset_mm_stats(lruvec, walk, last);
 
@@ -3590,9 +3571,9 @@ static bool iterate_mm_list_nowalk(struct lruvec *lruvec, unsigned long max_seq)
 
 	VM_WARN_ON_ONCE(mm_state->seq + 1 < max_seq);
 
-	if (max_seq > mm_state->seq && !mm_state->nr_walkers) {
-		VM_WARN_ON_ONCE(mm_state->head && mm_state->head != &mm_list->fifo);
-
+	if (max_seq > mm_state->seq) {
+		mm_state->head = NULL;
+		mm_state->tail = NULL;
 		WRITE_ONCE(mm_state->seq, mm_state->seq + 1);
 		reset_mm_stats(lruvec, NULL, true);
 		success = true;
@@ -4192,10 +4173,6 @@ static int walk_pud_range(p4d_t *p4d, unsigned long start, unsigned long end,
 
 		walk_pmd_range(&val, addr, next, args);
 
-		/* a racy check to curtail the waiting time */
-		if (wq_has_sleeper(&walk->lruvec->mm_state.wait))
-			return 1;
-
 		if (need_resched() || walk->batched >= MAX_LRU_BATCH) {
 			end = (addr | ~PUD_MASK) + 1;
 			goto done;
@@ -4228,8 +4205,14 @@ static void walk_mm(struct lruvec *lruvec, struct mm_struct *mm, struct lru_gen_
 	walk->next_addr = FIRST_USER_ADDRESS;
 
 	do {
+		DEFINE_MAX_SEQ(lruvec);
+
 		err = -EBUSY;
 
+		/* another thread might have called inc_max_seq() */
+		if (walk->max_seq != max_seq)
+			break;
+
 		/* folio_update_gen() requires stable folio_memcg() */
 		if (!mem_cgroup_trylock_pages(memcg))
 			break;
@@ -4462,25 +4445,12 @@ static bool try_to_inc_max_seq(struct lruvec *lruvec, unsigned long max_seq,
 		success = iterate_mm_list(lruvec, walk, &mm);
 		if (mm)
 			walk_mm(lruvec, mm, walk);
-
-		cond_resched();
 	} while (mm);
 done:
-	if (!success) {
-		if (sc->priority <= DEF_PRIORITY - 2)
-			wait_event_killable(lruvec->mm_state.wait,
-					    max_seq < READ_ONCE(lrugen->max_seq));
-		return false;
-	}
+	if (success)
+		inc_max_seq(lruvec, can_swap, force_scan);
 
-	VM_WARN_ON_ONCE(max_seq != READ_ONCE(lrugen->max_seq));
-
-	inc_max_seq(lruvec, can_swap, force_scan);
-	/* either this sees any waiters or they will see updated max_seq */
-	if (wq_has_sleeper(&lruvec->mm_state.wait))
-		wake_up_all(&lruvec->mm_state.wait);
-
-	return true;
+	return success;
 }
 
 /******************************************************************************
@@ -6122,7 +6092,6 @@ void lru_gen_init_lruvec(struct lruvec *lruvec)
 		INIT_LIST_HEAD(&lrugen->folios[gen][type][zone]);
 
 	lruvec->mm_state.seq = MIN_NR_GENS;
-	init_waitqueue_head(&lruvec->mm_state.wait);
 }
 
 #ifdef CONFIG_MEMCG
@@ -6155,7 +6124,6 @@ void lru_gen_exit_memcg(struct mem_cgroup *memcg)
 	for_each_node(nid) {
 		struct lruvec *lruvec = get_lruvec(memcg, nid);
 
-		VM_WARN_ON_ONCE(lruvec->mm_state.nr_walkers);
 		VM_WARN_ON_ONCE(memchr_inv(lruvec->lrugen.nr_pages, 0,
 					   sizeof(lruvec->lrugen.nr_pages)));
 

base-commit: de4664485abbc0529b1eec44d0061bbfe58a28fb
-- 
2.40.0.634.g4ca3ef3211-goog


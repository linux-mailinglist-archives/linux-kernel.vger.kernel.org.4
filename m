Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D92605FA9CE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 03:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbiJKBSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 21:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiJKBSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 21:18:30 -0400
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A10C17695E;
        Mon, 10 Oct 2022 18:18:28 -0700 (PDT)
Received: from SHSend.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
        by SHSQR01.spreadtrum.com with ESMTPS id 29B1GTj5030348
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO);
        Tue, 11 Oct 2022 09:16:29 +0800 (CST)
        (envelope-from zhaoyang.huang@unisoc.com)
Received: from bj03382pcu.spreadtrum.com (10.0.74.65) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Tue, 11 Oct 2022 09:16:28 +0800
From:   "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, <linux-mm@kvack.org>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <ke.wang@unisoc.com>, <steve.kang@unisoc.com>
Subject: [Resend PATCH] mm: use stack_depot for recording kmemleak's backtrace
Date:   Tue, 11 Oct 2022 09:16:04 +0800
Message-ID: <1665450964-27487-1-git-send-email-zhaoyang.huang@unisoc.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.74.65]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL: SHSQR01.spreadtrum.com 29B1GTj5030348
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

Using stack_depot to record kmemleak's backtrace which has been implemented
on slub for reducing redundant information.

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
 mm/kmemleak.c | 43 +++++++++++++++++++++++++++++++++----------
 1 file changed, 33 insertions(+), 10 deletions(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 1eddc01..c9cee3a 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -79,6 +79,7 @@
 #include <linux/mutex.h>
 #include <linux/rcupdate.h>
 #include <linux/stacktrace.h>
+#include <linux/stackdepot.h>
 #include <linux/cache.h>
 #include <linux/percpu.h>
 #include <linux/memblock.h>
@@ -159,8 +160,7 @@ struct kmemleak_object {
 	u32 checksum;
 	/* memory ranges to be scanned inside an object (empty for all) */
 	struct hlist_head area_list;
-	unsigned long trace[MAX_TRACE];
-	unsigned int trace_len;
+	depot_stack_handle_t trace_handle;
 	unsigned long jiffies;		/* creation timestamp */
 	pid_t pid;			/* pid of the current task */
 	char comm[TASK_COMM_LEN];	/* executable name */
@@ -346,8 +346,11 @@ static void print_unreferenced(struct seq_file *seq,
 			       struct kmemleak_object *object)
 {
 	int i;
+	unsigned long *entries;
+	unsigned int nr_entries;
 	unsigned int msecs_age = jiffies_to_msecs(jiffies - object->jiffies);
 
+	nr_entries = stack_depot_fetch(object->trace_handle, &entries);
 	warn_or_seq_printf(seq, "unreferenced object 0x%08lx (size %zu):\n",
 		   object->pointer, object->size);
 	warn_or_seq_printf(seq, "  comm \"%s\", pid %d, jiffies %lu (age %d.%03ds)\n",
@@ -356,10 +359,10 @@ static void print_unreferenced(struct seq_file *seq,
 	hex_dump_object(seq, object);
 	warn_or_seq_printf(seq, "  backtrace:\n");
 
-	for (i = 0; i < object->trace_len; i++) {
-		void *ptr = (void *)object->trace[i];
-		warn_or_seq_printf(seq, "    [<%p>] %pS\n", ptr, ptr);
-	}
+       for (i = 0; i < nr_entries; i++) {
+               void *ptr = (void *)entries[i];
+               warn_or_seq_printf(seq, "    [<%p>] %pS\n", ptr, ptr);
+       }
 }
 
 /*
@@ -378,7 +381,8 @@ static void dump_object_info(struct kmemleak_object *object)
 	pr_notice("  flags = 0x%x\n", object->flags);
 	pr_notice("  checksum = %u\n", object->checksum);
 	pr_notice("  backtrace:\n");
-	stack_trace_print(object->trace, object->trace_len, 4);
+	if(object->trace_handle)
+		stack_depot_print(object->trace_handle);
 }
 
 /*
@@ -591,6 +595,25 @@ static struct kmemleak_object *find_and_remove_object(unsigned long ptr, int ali
 	return object;
 }
 
+#ifdef CONFIG_STACKDEPOT
+static noinline depot_stack_handle_t set_track_prepare(void)
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
+#else
+static inline depot_stack_handle_t set_track_prepare(void)
+{
+	return 0;
+}
+#endif
+
 /*
  * Save stack trace to the given array of MAX_TRACE size.
  */
@@ -654,7 +677,7 @@ static struct kmemleak_object *__create_object(unsigned long ptr, size_t size,
 	}
 
 	/* kernel backtrace */
-	object->trace_len = __save_stack_trace(object->trace);
+	object->trace_handle = set_track_prepare();
 
 	raw_spin_lock_irqsave(&kmemleak_lock, flags);
 
@@ -694,7 +717,6 @@ static struct kmemleak_object *__create_object(unsigned long ptr, size_t size,
 	rb_link_node(&object->rb_node, rb_parent, link);
 	rb_insert_color(&object->rb_node, is_phys ? &object_phys_tree_root :
 					  &object_tree_root);
-
 	list_add_tail_rcu(&object->object_list, &object_list);
 out:
 	raw_spin_unlock_irqrestore(&kmemleak_lock, flags);
@@ -1094,7 +1116,7 @@ void __ref kmemleak_update_trace(const void *ptr)
 	}
 
 	raw_spin_lock_irqsave(&object->lock, flags);
-	object->trace_len = __save_stack_trace(object->trace);
+	object->trace_handle = set_track_prepare();
 	raw_spin_unlock_irqrestore(&object->lock, flags);
 
 	put_object(object);
@@ -2064,6 +2086,7 @@ void __init kmemleak_init(void)
 	if (kmemleak_error)
 		return;
 
+	stack_depot_init();
 	jiffies_min_age = msecs_to_jiffies(MSECS_MIN_AGE);
 	jiffies_scan_wait = msecs_to_jiffies(SECS_SCAN_WAIT * 1000);
 
-- 
1.9.1


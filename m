Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B18B612734
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 04:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiJ3Dnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 23:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiJ3Dnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 23:43:50 -0400
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDEBB2A962
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 20:43:47 -0700 (PDT)
Received: from SHSend.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
        by SHSQR01.spreadtrum.com with ESMTPS id 29U3guO2084239
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO);
        Sun, 30 Oct 2022 11:42:57 +0800 (CST)
        (envelope-from zhaoyang.huang@unisoc.com)
Received: from bj03382pcu.spreadtrum.com (10.0.74.65) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Sun, 30 Oct 2022 11:42:56 +0800
From:   "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <ke.wang@unisoc.com>,
        <steve.kang@unisoc.com>
Subject: [PATCHv3] mm: use stack_depot for recording kmemleak's backtrace
Date:   Sun, 30 Oct 2022 11:42:34 +0800
Message-ID: <1667101354-4669-1-git-send-email-zhaoyang.huang@unisoc.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.74.65]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL: SHSQR01.spreadtrum.com 29U3guO2084239
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
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: ke.wang <ke.wang@unisoc.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Zhaoyang Huang <huangzhaoyang@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
changes of v2: fix bugs of stack_depot_init related issue
changes of v3: have DEBUG_KMEMLEAK select STACK_DEPOT by default
               remove unuse functions
---
---
 lib/Kconfig.debug |  1 +
 mm/kmemleak.c     | 48 +++++++++++++++++++++++++++++-------------------
 2 files changed, 30 insertions(+), 19 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index bcbe60d..0def8e0 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -717,6 +717,7 @@ config DEBUG_KMEMLEAK
 	select STACKTRACE if STACKTRACE_SUPPORT
 	select KALLSYMS
 	select CRC32
+	select STACKDEPOT
 	help
 	  Say Y here if you want to enable the memory leak
 	  detector. The memory allocation/freeing is traced in a way
diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 1eddc01..cedc6f3 100644
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
@@ -343,21 +343,24 @@ static bool unreferenced_object(struct kmemleak_object *object)
  * print_unreferenced function must be called with the object->lock held.
  */
 static void print_unreferenced(struct seq_file *seq,
-			       struct kmemleak_object *object)
+		struct kmemleak_object *object)
 {
 	int i;
+	unsigned long *entries;
+	unsigned int nr_entries;
 	unsigned int msecs_age = jiffies_to_msecs(jiffies - object->jiffies);
 
+	nr_entries = stack_depot_fetch(object->trace_handle, &entries);
 	warn_or_seq_printf(seq, "unreferenced object 0x%08lx (size %zu):\n",
-		   object->pointer, object->size);
+			object->pointer, object->size);
 	warn_or_seq_printf(seq, "  comm \"%s\", pid %d, jiffies %lu (age %d.%03ds)\n",
-		   object->comm, object->pid, object->jiffies,
-		   msecs_age / 1000, msecs_age % 1000);
+			object->comm, object->pid, object->jiffies,
+			msecs_age / 1000, msecs_age % 1000);
 	hex_dump_object(seq, object);
 	warn_or_seq_printf(seq, "  backtrace:\n");
 
-	for (i = 0; i < object->trace_len; i++) {
-		void *ptr = (void *)object->trace[i];
+	for (i = 0; i < nr_entries; i++) {
+		void *ptr = (void *)entries[i];
 		warn_or_seq_printf(seq, "    [<%p>] %pS\n", ptr, ptr);
 	}
 }
@@ -370,15 +373,16 @@ static void print_unreferenced(struct seq_file *seq,
 static void dump_object_info(struct kmemleak_object *object)
 {
 	pr_notice("Object 0x%08lx (size %zu):\n",
-		  object->pointer, object->size);
+			object->pointer, object->size);
 	pr_notice("  comm \"%s\", pid %d, jiffies %lu\n",
-		  object->comm, object->pid, object->jiffies);
+			object->comm, object->pid, object->jiffies);
 	pr_notice("  min_count = %d\n", object->min_count);
 	pr_notice("  count = %d\n", object->count);
 	pr_notice("  flags = 0x%x\n", object->flags);
 	pr_notice("  checksum = %u\n", object->checksum);
 	pr_notice("  backtrace:\n");
-	stack_trace_print(object->trace, object->trace_len, 4);
+	if (object->trace_handle)
+		stack_depot_print(object->trace_handle);
 }
 
 /*
@@ -591,12 +595,18 @@ static struct kmemleak_object *find_and_remove_object(unsigned long ptr, int ali
 	return object;
 }
 
-/*
- * Save stack trace to the given array of MAX_TRACE size.
- */
-static int __save_stack_trace(unsigned long *trace)
+static noinline depot_stack_handle_t set_track_prepare(void)
 {
-	return stack_trace_save(trace, MAX_TRACE, 2);
+	depot_stack_handle_t trace_handle;
+	unsigned long entries[MAX_TRACE];
+	unsigned int nr_entries;
+
+	if (!kmemleak_initialized)
+		return 0;
+	nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 3);
+	trace_handle = stack_depot_save(entries, nr_entries, GFP_NOWAIT);
+
+	return trace_handle;
 }
 
 /*
@@ -654,7 +664,7 @@ static struct kmemleak_object *__create_object(unsigned long ptr, size_t size,
 	}
 
 	/* kernel backtrace */
-	object->trace_len = __save_stack_trace(object->trace);
+	object->trace_handle = set_track_prepare();
 
 	raw_spin_lock_irqsave(&kmemleak_lock, flags);
 
@@ -694,7 +704,6 @@ static struct kmemleak_object *__create_object(unsigned long ptr, size_t size,
 	rb_link_node(&object->rb_node, rb_parent, link);
 	rb_insert_color(&object->rb_node, is_phys ? &object_phys_tree_root :
 					  &object_tree_root);
-
 	list_add_tail_rcu(&object->object_list, &object_list);
 out:
 	raw_spin_unlock_irqrestore(&kmemleak_lock, flags);
@@ -1094,7 +1103,7 @@ void __ref kmemleak_update_trace(const void *ptr)
 	}
 
 	raw_spin_lock_irqsave(&object->lock, flags);
-	object->trace_len = __save_stack_trace(object->trace);
+	object->trace_handle = set_track_prepare();
 	raw_spin_unlock_irqrestore(&object->lock, flags);
 
 	put_object(object);
@@ -2064,6 +2073,7 @@ void __init kmemleak_init(void)
 	if (kmemleak_error)
 		return;
 
+	stack_depot_init();
 	jiffies_min_age = msecs_to_jiffies(MSECS_MIN_AGE);
 	jiffies_scan_wait = msecs_to_jiffies(SECS_SCAN_WAIT * 1000);
 
-- 
1.9.1


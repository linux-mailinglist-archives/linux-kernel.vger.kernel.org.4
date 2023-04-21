Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 120246EA80B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 12:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbjDUKO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 06:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbjDUKOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 06:14:39 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB320A5F0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 03:14:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 53B631FDDC;
        Fri, 21 Apr 2023 10:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1682072076; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NhQ8pvDEDYdK4MH7I174Hpey5DF3W+He8Wm+uYrTkgw=;
        b=E5cBcBJ0NS1SCMaDeyEpm1IRLZaQHjgK1FAE4SYuJ40GAfoaJ6W70GfGcSsWIk3Xe1hfRe
        3PR8N9XM2u1eZB8mD+cvlzlVt4WpBWIskHlztPK4Wi5JFJku1IHWSGEtjMYGHobusXWq96
        vn0t7I0G5Y3PGrtKt1u1P76dOI/WrAM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1682072076;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NhQ8pvDEDYdK4MH7I174Hpey5DF3W+He8Wm+uYrTkgw=;
        b=CWbSShbgBZJ0E617Q6QJQE0QaIJAUC+0i7cKB+O8UWP4cWLAVoqZkpEIGA61IUeWgdD4+D
        lQ5hqFH6RMS1NrDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 88D7A1390E;
        Fri, 21 Apr 2023 10:14:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6KUrHgtiQmRNaAAAMHmgww
        (envelope-from <osalvador@suse.de>); Fri, 21 Apr 2023 10:14:35 +0000
From:   Oscar Salvador <osalvador@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Eric Dumazet <edumazet@google.com>,
        Waiman Long <longman@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v4 1/3] lib/stackdepot: Add a refcount field in stack_record
Date:   Fri, 21 Apr 2023 12:14:13 +0200
Message-Id: <20230421101415.5734-2-osalvador@suse.de>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230421101415.5734-1-osalvador@suse.de>
References: <20230421101415.5734-1-osalvador@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We want to filter out page_owner output and print only those
stacks that have been repeated beyond a certain threshold.
This gives us the chance to get rid of a lot of noise.
In order to do that, we need to keep track of how many repeated stacks
(for allocation) do we have, so we add a new refcount_t field
in the stack_record struct.

Note that this might increase the size of the struct for some
architectures.
E.g: x86_64 is not affected due to alignment, but x86 32bits might.

The alternative would be to have some kind of struct like this:

struct track_stacks {
	struct stack_record *stack;
	struct track_stacks *next;
	refcount_t stack_count;

But ithat would imply to perform more allocations and glue everything
together, which would make the code more complex, so I think that
going with a new field in the struct stack_record is good enough.

Note that on __set_page_owner_handle(), page_owner->handle is set,
and on __reset_page_owner(), page_owner->free_handle is set.

We are interested in page_owner->handle, so when __set_page_owner()
gets called, we derive the stack_record struct from page_owner->handle,
and we increment its refcount_t field; and when __reset_page_owner()
gets called, we derive its stack_record from page_owner->handle()
and we decrement its refcount_t field.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 include/linux/stackdepot.h |  8 ++++-
 lib/stackdepot.c           | 72 ++++++++++++++++++++++++++++++++------
 mm/kasan/common.c          |  3 +-
 mm/page_owner.c            | 13 ++++---
 4 files changed, 79 insertions(+), 17 deletions(-)

diff --git a/include/linux/stackdepot.h b/include/linux/stackdepot.h
index e58306783d8e..b94d33312839 100644
--- a/include/linux/stackdepot.h
+++ b/include/linux/stackdepot.h
@@ -93,7 +93,9 @@ static inline int stack_depot_early_init(void)	{ return 0; }
  */
 depot_stack_handle_t __stack_depot_save(unsigned long *entries,
 					unsigned int nr_entries,
-					gfp_t gfp_flags, bool can_alloc);
+					gfp_t gfp_flags, bool can_alloc,
+					bool counter);
+void stack_depot_dec_count(depot_stack_handle_t handle);
 
 /**
  * stack_depot_save - Save a stack trace to stack depot
@@ -109,6 +111,10 @@ depot_stack_handle_t __stack_depot_save(unsigned long *entries,
  */
 depot_stack_handle_t stack_depot_save(unsigned long *entries,
 				      unsigned int nr_entries, gfp_t gfp_flags);
+depot_stack_handle_t stack_depot_save_action(unsigned long *entries,
+					     unsigned int nr_entries,
+					     gfp_t gfp_flags,
+					     bool counter);
 
 /**
  * stack_depot_fetch - Fetch a stack trace from stack depot
diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index 036da8e295d1..e99f4ef218ef 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -59,6 +59,7 @@ struct stack_record {
 	u32 hash;			/* Hash in the hash table */
 	u32 size;			/* Number of stored frames */
 	union handle_parts handle;
+	refcount_t count;		/* Number of the same repeated stacks */
 	unsigned long entries[];	/* Variable-sized array of frames */
 };
 
@@ -304,6 +305,7 @@ depot_alloc_stack(unsigned long *entries, int size, u32 hash, void **prealloc)
 	stack->handle.offset = pool_offset >> DEPOT_STACK_ALIGN;
 	stack->handle.valid = 1;
 	stack->handle.extra = 0;
+	refcount_set(&stack->count, 1);
 	memcpy(stack->entries, entries, flex_array_size(stack, entries, size));
 	pool_offset += required_size;
 
@@ -349,9 +351,15 @@ static inline struct stack_record *find_stack(struct stack_record *bucket,
 	return NULL;
 }
 
+static void stack_depot_inc_count(struct stack_record *stack)
+{
+	refcount_inc(&stack->count);
+}
+
 depot_stack_handle_t __stack_depot_save(unsigned long *entries,
 					unsigned int nr_entries,
-					gfp_t alloc_flags, bool can_alloc)
+					gfp_t alloc_flags, bool can_alloc,
+					bool counter)
 {
 	struct stack_record *found = NULL, **bucket;
 	union handle_parts retval = { .handle = 0 };
@@ -436,8 +444,11 @@ depot_stack_handle_t __stack_depot_save(unsigned long *entries,
 		/* Stack depot didn't use this memory, free it. */
 		free_pages((unsigned long)prealloc, DEPOT_POOL_ORDER);
 	}
-	if (found)
+	if (found) {
 		retval.handle = found->handle.handle;
+		if (counter)
+			stack_depot_inc_count(found);
+	}
 fast_exit:
 	return retval.handle;
 }
@@ -447,12 +458,20 @@ depot_stack_handle_t stack_depot_save(unsigned long *entries,
 				      unsigned int nr_entries,
 				      gfp_t alloc_flags)
 {
-	return __stack_depot_save(entries, nr_entries, alloc_flags, true);
+	return __stack_depot_save(entries, nr_entries, alloc_flags, true, false);
 }
 EXPORT_SYMBOL_GPL(stack_depot_save);
 
-unsigned int stack_depot_fetch(depot_stack_handle_t handle,
-			       unsigned long **entries)
+depot_stack_handle_t stack_depot_save_action(unsigned long *entries,
+					     unsigned int nr_entries,
+					     gfp_t alloc_flags,
+					     bool counter)
+{
+	return __stack_depot_save(entries, nr_entries, alloc_flags, true, counter);
+}
+EXPORT_SYMBOL_GPL(stack_depot_save_action);
+
+static struct stack_record *stack_depot_getstack(depot_stack_handle_t handle)
 {
 	union handle_parts parts = { .handle = handle };
 	/*
@@ -464,25 +483,56 @@ unsigned int stack_depot_fetch(depot_stack_handle_t handle,
 	size_t offset = parts.offset << DEPOT_STACK_ALIGN;
 	struct stack_record *stack;
 
-	*entries = NULL;
-	if (!handle)
-		return 0;
+	if(!handle)
+		return NULL;
 
 	if (parts.pool_index > pool_index_cached) {
 		WARN(1, "pool index %d out of bounds (%d) for stack id %08x\n",
-			parts.pool_index, pool_index_cached, handle);
-		return 0;
+		parts.pool_index, pool_index_cached, handle);
+		return NULL;
 	}
 	pool = stack_pools[parts.pool_index];
 	if (!pool)
-		return 0;
+		return NULL;
+
 	stack = pool + offset;
+	return stack;
+}
+
+unsigned int stack_depot_fetch(depot_stack_handle_t handle,
+			       unsigned long **entries)
+{
+	struct stack_record *stack;
+
+	*entries = NULL;
+	if (!handle)
+		return 0;
+
+	stack = stack_depot_getstack(handle);
+	if (!stack)
+		return 0;
 
 	*entries = stack->entries;
 	return stack->size;
 }
 EXPORT_SYMBOL_GPL(stack_depot_fetch);
 
+void stack_depot_dec_count(depot_stack_handle_t handle)
+{
+	struct stack_record *stack = NULL;
+
+	stack = stack_depot_getstack(handle);
+	if (stack) {
+		/*
+		 * page_owner creates some stacks via create_dummy_stack().
+		 * We are not interested in those, so make sure we only decrement
+		 * "valid" stacks.
+		 */
+		if (refcount_read(&stack->count) > 1)
+			refcount_dec(&stack->count);
+	}
+}
+
 void stack_depot_print(depot_stack_handle_t stack)
 {
 	unsigned long *entries;
diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index b376a5d055e5..ea0061ea8ae9 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -43,7 +43,8 @@ depot_stack_handle_t kasan_save_stack(gfp_t flags, bool can_alloc)
 	unsigned int nr_entries;
 
 	nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 0);
-	return __stack_depot_save(entries, nr_entries, flags, can_alloc);
+	return __stack_depot_save(entries, nr_entries, flags, can_alloc,
+				  false);
 }
 
 void kasan_set_track(struct kasan_track *track, gfp_t flags)
diff --git a/mm/page_owner.c b/mm/page_owner.c
index 220cdeddc295..b6637524e442 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -107,7 +107,7 @@ static inline struct page_owner *get_page_owner(struct page_ext *page_ext)
 	return (void *)page_ext + page_owner_ops.offset;
 }
 
-static noinline depot_stack_handle_t save_stack(gfp_t flags)
+static noinline depot_stack_handle_t save_stack(gfp_t flags, bool counter)
 {
 	unsigned long entries[PAGE_OWNER_STACK_DEPTH];
 	depot_stack_handle_t handle;
@@ -126,7 +126,7 @@ static noinline depot_stack_handle_t save_stack(gfp_t flags)
 	current->in_page_owner = 1;
 
 	nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 2);
-	handle = stack_depot_save(entries, nr_entries, flags);
+	handle = stack_depot_save_action(entries, nr_entries, flags, counter);
 	if (!handle)
 		handle = failure_handle;
 
@@ -139,6 +139,7 @@ void __reset_page_owner(struct page *page, unsigned short order)
 	int i;
 	struct page_ext *page_ext;
 	depot_stack_handle_t handle;
+	depot_stack_handle_t alloc_handle;
 	struct page_owner *page_owner;
 	u64 free_ts_nsec = local_clock();
 
@@ -146,7 +147,10 @@ void __reset_page_owner(struct page *page, unsigned short order)
 	if (unlikely(!page_ext))
 		return;
 
-	handle = save_stack(GFP_NOWAIT | __GFP_NOWARN);
+	page_owner = get_page_owner(page_ext);
+	alloc_handle = page_owner->handle;
+
+	handle = save_stack(GFP_NOWAIT | __GFP_NOWARN, false);
 	for (i = 0; i < (1 << order); i++) {
 		__clear_bit(PAGE_EXT_OWNER_ALLOCATED, &page_ext->flags);
 		page_owner = get_page_owner(page_ext);
@@ -155,6 +159,7 @@ void __reset_page_owner(struct page *page, unsigned short order)
 		page_ext = page_ext_next(page_ext);
 	}
 	page_ext_put(page_ext);
+	stack_depot_dec_count(alloc_handle);
 }
 
 static inline void __set_page_owner_handle(struct page_ext *page_ext,
@@ -189,7 +194,7 @@ noinline void __set_page_owner(struct page *page, unsigned short order,
 	struct page_ext *page_ext;
 	depot_stack_handle_t handle;
 
-	handle = save_stack(gfp_mask);
+	handle = save_stack(gfp_mask, true);
 
 	page_ext = page_ext_get(page);
 	if (unlikely(!page_ext))
-- 
2.35.3


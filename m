Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 068AF632A82
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 18:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbiKURMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 12:12:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbiKURMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 12:12:17 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A759CFA42
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 09:12:13 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0DB5F1F8BA;
        Mon, 21 Nov 2022 17:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669050732; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kxjbonatpGC5AWy6loCUXxl8UzxiaKRWAVgSkFX/DLQ=;
        b=ZVaRYtFQ3lKV+m9X+CsTTzPG/N5N7Z0vywBD2y1TmsVrNdQPFLRIor9huHDB1eXfWL3Yjz
        PGDz94tNLYW7urSgcXMm4Xzty/f1KvPdWBFCKe3MnjnFir6/lRN3vi3n+6e5Or/pnZgsbx
        JrxvMrwzKGUcsctvUjT+TsAXBVzXvuM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669050732;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kxjbonatpGC5AWy6loCUXxl8UzxiaKRWAVgSkFX/DLQ=;
        b=5m4px0JGX/iZy4A0F6Fxi6SnlYTAwR6CG4YIG8vUhfoMBAHc3m7Othokg+1RhsI4LQsenh
        caEBai4kUa2pPiBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D69CC1377F;
        Mon, 21 Nov 2022 17:12:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2E3EM2uxe2MQeQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 21 Nov 2022 17:12:11 +0000
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>
Cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, patches@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH 08/12] mm, slub: refactor free debug processing
Date:   Mon, 21 Nov 2022 18:11:58 +0100
Message-Id: <20221121171202.22080-9-vbabka@suse.cz>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221121171202.22080-1-vbabka@suse.cz>
References: <20221121171202.22080-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit c7323a5ad078 ("mm/slub: restrict sysfs validation to debug
caches and make it safe"), caches with debugging enabled use the
free_debug_processing() function to do both freeing checks and actual
freeing to partial list under list_lock, bypassing the fast paths.

We will want to use the same path for CONFIG_SLUB_TINY, but without the
debugging checks, so refactor the code so that free_debug_processing()
does only the checks, while the freeing is handled by a new function
free_to_partial_list().

For consistency, change return parameter alloc_debug_processing() from
int to bool and correct the !SLUB_DEBUG variant to return true and not
false. This didn't matter until now, but will in the following changes.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 154 +++++++++++++++++++++++++++++-------------------------
 1 file changed, 83 insertions(+), 71 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index bf726dd00f7d..fd56d7cca9c2 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1368,7 +1368,7 @@ static inline int alloc_consistency_checks(struct kmem_cache *s,
 	return 1;
 }
 
-static noinline int alloc_debug_processing(struct kmem_cache *s,
+static noinline bool alloc_debug_processing(struct kmem_cache *s,
 			struct slab *slab, void *object, int orig_size)
 {
 	if (s->flags & SLAB_CONSISTENCY_CHECKS) {
@@ -1380,7 +1380,7 @@ static noinline int alloc_debug_processing(struct kmem_cache *s,
 	trace(s, slab, object, 1);
 	set_orig_size(s, object, orig_size);
 	init_object(s, object, SLUB_RED_ACTIVE);
-	return 1;
+	return true;
 
 bad:
 	if (folio_test_slab(slab_folio(slab))) {
@@ -1393,7 +1393,7 @@ static noinline int alloc_debug_processing(struct kmem_cache *s,
 		slab->inuse = slab->objects;
 		slab->freelist = NULL;
 	}
-	return 0;
+	return false;
 }
 
 static inline int free_consistency_checks(struct kmem_cache *s,
@@ -1646,17 +1646,17 @@ static inline void setup_object_debug(struct kmem_cache *s, void *object) {}
 static inline
 void setup_slab_debug(struct kmem_cache *s, struct slab *slab, void *addr) {}
 
-static inline int alloc_debug_processing(struct kmem_cache *s,
-	struct slab *slab, void *object, int orig_size) { return 0; }
+static inline bool alloc_debug_processing(struct kmem_cache *s,
+	struct slab *slab, void *object, int orig_size) { return true; }
 
-static inline void free_debug_processing(
-	struct kmem_cache *s, struct slab *slab,
-	void *head, void *tail, int bulk_cnt,
-	unsigned long addr) {}
+static inline bool free_debug_processing(struct kmem_cache *s,
+	struct slab *slab, void *head, void *tail, int *bulk_cnt,
+	unsigned long addr, depot_stack_handle_t handle) { return true; }
 
 static inline void slab_pad_check(struct kmem_cache *s, struct slab *slab) {}
 static inline int check_object(struct kmem_cache *s, struct slab *slab,
 			void *object, u8 val) { return 1; }
+static inline depot_stack_handle_t set_track_prepare(void) { return 0; }
 static inline void set_track(struct kmem_cache *s, void *object,
 			     enum track_item alloc, unsigned long addr) {}
 static inline void add_full(struct kmem_cache *s, struct kmem_cache_node *n,
@@ -2833,38 +2833,28 @@ static inline unsigned long node_nr_objs(struct kmem_cache_node *n)
 }
 
 /* Supports checking bulk free of a constructed freelist */
-static noinline void free_debug_processing(
-	struct kmem_cache *s, struct slab *slab,
-	void *head, void *tail, int bulk_cnt,
-	unsigned long addr)
+static inline bool free_debug_processing(struct kmem_cache *s,
+	struct slab *slab, void *head, void *tail, int *bulk_cnt,
+	unsigned long addr, depot_stack_handle_t handle)
 {
-	struct kmem_cache_node *n = get_node(s, slab_nid(slab));
-	struct slab *slab_free = NULL;
+	bool checks_ok = false;
 	void *object = head;
 	int cnt = 0;
-	unsigned long flags;
-	bool checks_ok = false;
-	depot_stack_handle_t handle = 0;
-
-	if (s->flags & SLAB_STORE_USER)
-		handle = set_track_prepare();
-
-	spin_lock_irqsave(&n->list_lock, flags);
 
 	if (s->flags & SLAB_CONSISTENCY_CHECKS) {
 		if (!check_slab(s, slab))
 			goto out;
 	}
 
-	if (slab->inuse < bulk_cnt) {
+	if (slab->inuse < *bulk_cnt) {
 		slab_err(s, slab, "Slab has %d allocated objects but %d are to be freed\n",
-			 slab->inuse, bulk_cnt);
+			 slab->inuse, *bulk_cnt);
 		goto out;
 	}
 
 next_object:
 
-	if (++cnt > bulk_cnt)
+	if (++cnt > *bulk_cnt)
 		goto out_cnt;
 
 	if (s->flags & SLAB_CONSISTENCY_CHECKS) {
@@ -2886,57 +2876,18 @@ static noinline void free_debug_processing(
 	checks_ok = true;
 
 out_cnt:
-	if (cnt != bulk_cnt)
+	if (cnt != *bulk_cnt) {
 		slab_err(s, slab, "Bulk free expected %d objects but found %d\n",
-			 bulk_cnt, cnt);
-
-out:
-	if (checks_ok) {
-		void *prior = slab->freelist;
-
-		/* Perform the actual freeing while we still hold the locks */
-		slab->inuse -= cnt;
-		set_freepointer(s, tail, prior);
-		slab->freelist = head;
-
-		/*
-		 * If the slab is empty, and node's partial list is full,
-		 * it should be discarded anyway no matter it's on full or
-		 * partial list.
-		 */
-		if (slab->inuse == 0 && n->nr_partial >= s->min_partial)
-			slab_free = slab;
-
-		if (!prior) {
-			/* was on full list */
-			remove_full(s, n, slab);
-			if (!slab_free) {
-				add_partial(n, slab, DEACTIVATE_TO_TAIL);
-				stat(s, FREE_ADD_PARTIAL);
-			}
-		} else if (slab_free) {
-			remove_partial(n, slab);
-			stat(s, FREE_REMOVE_PARTIAL);
-		}
+			 *bulk_cnt, cnt);
+		*bulk_cnt = cnt;
 	}
 
-	if (slab_free) {
-		/*
-		 * Update the counters while still holding n->list_lock to
-		 * prevent spurious validation warnings
-		 */
-		dec_slabs_node(s, slab_nid(slab_free), slab_free->objects);
-	}
-
-	spin_unlock_irqrestore(&n->list_lock, flags);
+out:
 
 	if (!checks_ok)
 		slab_fix(s, "Object at 0x%p not freed", object);
 
-	if (slab_free) {
-		stat(s, FREE_SLAB);
-		free_slab(s, slab_free);
-	}
+	return checks_ok;
 }
 #endif /* CONFIG_SLUB_DEBUG */
 
@@ -3453,6 +3404,67 @@ void *kmem_cache_alloc_node(struct kmem_cache *s, gfp_t gfpflags, int node)
 }
 EXPORT_SYMBOL(kmem_cache_alloc_node);
 
+static noinline void free_to_partial_list(
+	struct kmem_cache *s, struct slab *slab,
+	void *head, void *tail, int bulk_cnt,
+	unsigned long addr)
+{
+	struct kmem_cache_node *n = get_node(s, slab_nid(slab));
+	struct slab *slab_free = NULL;
+	int cnt = bulk_cnt;
+	unsigned long flags;
+	depot_stack_handle_t handle = 0;
+
+	if (s->flags & SLAB_STORE_USER)
+		handle = set_track_prepare();
+
+	spin_lock_irqsave(&n->list_lock, flags);
+
+	if (free_debug_processing(s, slab, head, tail, &cnt, addr, handle)) {
+		void *prior = slab->freelist;
+
+		/* Perform the actual freeing while we still hold the locks */
+		slab->inuse -= cnt;
+		set_freepointer(s, tail, prior);
+		slab->freelist = head;
+
+		/*
+		 * If the slab is empty, and node's partial list is full,
+		 * it should be discarded anyway no matter it's on full or
+		 * partial list.
+		 */
+		if (slab->inuse == 0 && n->nr_partial >= s->min_partial)
+			slab_free = slab;
+
+		if (!prior) {
+			/* was on full list */
+			remove_full(s, n, slab);
+			if (!slab_free) {
+				add_partial(n, slab, DEACTIVATE_TO_TAIL);
+				stat(s, FREE_ADD_PARTIAL);
+			}
+		} else if (slab_free) {
+			remove_partial(n, slab);
+			stat(s, FREE_REMOVE_PARTIAL);
+		}
+	}
+
+	if (slab_free) {
+		/*
+		 * Update the counters while still holding n->list_lock to
+		 * prevent spurious validation warnings
+		 */
+		dec_slabs_node(s, slab_nid(slab_free), slab_free->objects);
+	}
+
+	spin_unlock_irqrestore(&n->list_lock, flags);
+
+	if (slab_free) {
+		stat(s, FREE_SLAB);
+		free_slab(s, slab_free);
+	}
+}
+
 /*
  * Slow path handling. This may still be called frequently since objects
  * have a longer lifetime than the cpu slabs in most processing loads.
@@ -3479,7 +3491,7 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
 		return;
 
 	if (kmem_cache_debug(s)) {
-		free_debug_processing(s, slab, head, tail, cnt, addr);
+		free_to_partial_list(s, slab, head, tail, cnt, addr);
 		return;
 	}
 
-- 
2.38.1


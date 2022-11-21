Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A136632A85
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 18:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbiKURNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 12:13:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbiKURMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 12:12:23 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E5FCEB91
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 09:12:17 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9AC7B1F8BB;
        Mon, 21 Nov 2022 17:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669050732; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X3WZS4NhVY+Kjo4XdjOkZd1dtlHURo50T/wAh28ytNE=;
        b=rdmY920qgTRyWMDU9Lvdi9t9OF9/QhFDxMqQw+V1STkr7+GbgdShYi31aii2Wq88xE/kCw
        +zaHdMmfWfiK81ohGzq3zHdcAbX6vepPHK82mRoA1f479p0Ly63ipmonfkzxoY2VjhfVL/
        /6EQw1GjfEznRtmefD26Q5u9SXxfX8Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669050732;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X3WZS4NhVY+Kjo4XdjOkZd1dtlHURo50T/wAh28ytNE=;
        b=TkTS9+5mYVWVSQ0Z3ri95SsgD2DGEbJkaROTw88M754wmWvi7YsmGDX8ymuzHS3hl3KZNO
        D+slbCc0iTNOp8AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6C22C13B03;
        Mon, 21 Nov 2022 17:12:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AJzHGWyxe2MQeQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 21 Nov 2022 17:12:12 +0000
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
Subject: [PATCH 11/12] mm, slub: don't aggressively inline with CONFIG_SLUB_TINY
Date:   Mon, 21 Nov 2022 18:12:01 +0100
Message-Id: <20221121171202.22080-12-vbabka@suse.cz>
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

SLUB fastpaths use __always_inline to avoid function calls. With
CONFIG_SLUB_TINY we would rather save the memory. Add a
__fastpath_inline macro that's __always_inline normally but empty with
CONFIG_SLUB_TINY.

bloat-o-meter results on x86_64 mm/slub.o:

add/remove: 3/1 grow/shrink: 1/8 up/down: 865/-1784 (-919)
Function                                     old     new   delta
kmem_cache_free                               20     281    +261
slab_alloc_node.isra                           -     245    +245
slab_free.constprop.isra                       -     231    +231
__kmem_cache_alloc_lru.isra                    -     128    +128
__kmem_cache_release                          88      83      -5
__kmem_cache_create                         1446    1436     -10
__kmem_cache_free                            271     142    -129
kmem_cache_alloc_node                        330     127    -203
kmem_cache_free_bulk.part                    826     613    -213
__kmem_cache_alloc_node                      230      10    -220
kmem_cache_alloc_lru                         325      12    -313
kmem_cache_alloc                             325      10    -315
kmem_cache_free.part                         376       -    -376
Total: Before=26103, After=25184, chg -3.52%

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 7f1cd702c3b4..d54466e76503 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -187,6 +187,12 @@ do {					\
 #define USE_LOCKLESS_FAST_PATH()	(false)
 #endif
 
+#ifndef CONFIG_SLUB_TINY
+#define __fastpath_inline __always_inline
+#else
+#define __fastpath_inline
+#endif
+
 #ifdef CONFIG_SLUB_DEBUG
 #ifdef CONFIG_SLUB_DEBUG_ON
 DEFINE_STATIC_KEY_TRUE(slub_debug_enabled);
@@ -3386,7 +3392,7 @@ static __always_inline void maybe_wipe_obj_freeptr(struct kmem_cache *s,
  *
  * Otherwise we can simply pick the next object from the lockless free list.
  */
-static __always_inline void *slab_alloc_node(struct kmem_cache *s, struct list_lru *lru,
+static __fastpath_inline void *slab_alloc_node(struct kmem_cache *s, struct list_lru *lru,
 		gfp_t gfpflags, int node, unsigned long addr, size_t orig_size)
 {
 	void *object;
@@ -3412,13 +3418,13 @@ static __always_inline void *slab_alloc_node(struct kmem_cache *s, struct list_l
 	return object;
 }
 
-static __always_inline void *slab_alloc(struct kmem_cache *s, struct list_lru *lru,
+static __fastpath_inline void *slab_alloc(struct kmem_cache *s, struct list_lru *lru,
 		gfp_t gfpflags, unsigned long addr, size_t orig_size)
 {
 	return slab_alloc_node(s, lru, gfpflags, NUMA_NO_NODE, addr, orig_size);
 }
 
-static __always_inline
+static __fastpath_inline
 void *__kmem_cache_alloc_lru(struct kmem_cache *s, struct list_lru *lru,
 			     gfp_t gfpflags)
 {
@@ -3733,7 +3739,7 @@ static void do_slab_free(struct kmem_cache *s,
 }
 #endif /* CONFIG_SLUB_TINY */
 
-static __always_inline void slab_free(struct kmem_cache *s, struct slab *slab,
+static __fastpath_inline void slab_free(struct kmem_cache *s, struct slab *slab,
 				      void *head, void *tail, void **p, int cnt,
 				      unsigned long addr)
 {
-- 
2.38.1


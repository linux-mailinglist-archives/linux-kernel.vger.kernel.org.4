Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EAD461FAC9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 18:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232624AbiKGRGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 12:06:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232465AbiKGRGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 12:06:00 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8335B1EED1;
        Mon,  7 Nov 2022 09:05:59 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C62E522603;
        Mon,  7 Nov 2022 17:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1667840757; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=te1FgowaQW4ajxXT21DupqE727nwz0E07tdMxGVIwvM=;
        b=eZrg0Bb6FfKs5zUeME2xDzdDaSCW9wKdPIZQUd/jHn2PtVDZ98avwrl1K0MUWTM9GtLiqb
        RuQYoaqynCD851IBxgVlcgj/DmHRdugG9EXIppCwNCAK4LZDbxvws5eTI317gD8+K/qi2b
        qby22iRZ+muOHAIdAqrZg6UuNe4YktM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1667840757;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=te1FgowaQW4ajxXT21DupqE727nwz0E07tdMxGVIwvM=;
        b=VxHcEmvMeK3KoFF2RqyDhg8iYFFenBZHRvDc3WJrXtFo3H4VSLhbie1vkwD0Z/zl5ctK2P
        DnQwl8r2Z2cocXBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9C94A13ADB;
        Mon,  7 Nov 2022 17:05:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GOjFJfU6aWOYfwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 07 Nov 2022 17:05:57 +0000
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Matthew Wilcox <willy@infradead.org>, paulmck@kernel.org,
        rcu@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v2 3/3] mm/sl[au]b: rearrange struct slab fields to allow larger rcu_head
Date:   Mon,  7 Nov 2022 18:05:54 +0100
Message-Id: <20221107170554.7869-4-vbabka@suse.cz>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221107170554.7869-1-vbabka@suse.cz>
References: <20221107170554.7869-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Joel reports [1] that increasing the rcu_head size for debugging
purposes used to work before struct slab was split from struct page, but
now runs into the various SLAB_MATCH() sanity checks of the layout.

This is because the rcu_head in struct page is in union with large
sub-structures and has space to grow without exceeding their size, while
in struct slab (for SLAB and SLUB) it's in union only with a list_head.

On closer inspection (and after the previous patch) we can put all
fields except slab_cache to a union with rcu_head, as slab_cache is
sufficient for the rcu freeing callbacks to work and the rest can be
overwritten by rcu_head without causing issues.

This is only somewhat complicated by the need to keep SLUB's
freelist+counters aligned for cmpxchg_double. As a result the fields
need to be reordered so that slab_cache is first (after page flags) and
the union with rcu_head follows. For consistency, do that for SLAB as
well, although not necessary there.

As a result, the rcu_head field in struct page and struct slab is no
longer at the same offset, but that doesn't matter as there is no
casting that would rely on that in the slab freeing callbacks, so we can
just drop the respective SLAB_MATCH() check.

Also we need to update the SLAB_MATCH() for compound_head to reflect the
new ordering.

While at it, also add a static_assert to check the alignment needed for
cmpxchg_double so mistakes are found sooner than a runtime GPF.

[1] https://lore.kernel.org/all/85afd876-d8bb-0804-b2c5-48ed3055e702@joelfernandes.org/

Reported-by: Joel Fernandes <joel@joelfernandes.org>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 mm/slab.h | 54 ++++++++++++++++++++++++++++++++----------------------
 1 file changed, 32 insertions(+), 22 deletions(-)

diff --git a/mm/slab.h b/mm/slab.h
index 0202a8c2f0d2..b373952eef70 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -11,37 +11,43 @@ struct slab {
 
 #if defined(CONFIG_SLAB)
 
+	struct kmem_cache *slab_cache;
 	union {
-		struct list_head slab_list;
+		struct {
+			struct list_head slab_list;
+			void *freelist;	/* array of free object indexes */
+			void *s_mem;	/* first object */
+		};
 		struct rcu_head rcu_head;
 	};
-	struct kmem_cache *slab_cache;
-	void *freelist;	/* array of free object indexes */
-	void *s_mem;	/* first object */
 	unsigned int active;
 
 #elif defined(CONFIG_SLUB)
 
-	union {
-		struct list_head slab_list;
-		struct rcu_head rcu_head;
-#ifdef CONFIG_SLUB_CPU_PARTIAL
-		struct {
-			struct slab *next;
-			int slabs;	/* Nr of slabs left */
-		};
-#endif
-	};
 	struct kmem_cache *slab_cache;
-	/* Double-word boundary */
-	void *freelist;		/* first free object */
 	union {
-		unsigned long counters;
 		struct {
-			unsigned inuse:16;
-			unsigned objects:15;
-			unsigned frozen:1;
+			union {
+				struct list_head slab_list;
+#ifdef CONFIG_SLUB_CPU_PARTIAL
+				struct {
+					struct slab *next;
+					int slabs;	/* Nr of slabs left */
+				};
+#endif
+			};
+			/* Double-word boundary */
+			void *freelist;		/* first free object */
+			union {
+				unsigned long counters;
+				struct {
+					unsigned inuse:16;
+					unsigned objects:15;
+					unsigned frozen:1;
+				};
+			};
 		};
+		struct rcu_head rcu_head;
 	};
 	unsigned int __unused;
 
@@ -66,9 +72,10 @@ struct slab {
 #define SLAB_MATCH(pg, sl)						\
 	static_assert(offsetof(struct page, pg) == offsetof(struct slab, sl))
 SLAB_MATCH(flags, __page_flags);
-SLAB_MATCH(compound_head, slab_list);	/* Ensure bit 0 is clear */
 #ifndef CONFIG_SLOB
-SLAB_MATCH(rcu_head, rcu_head);
+SLAB_MATCH(compound_head, slab_cache);	/* Ensure bit 0 is clear */
+#else
+SLAB_MATCH(compound_head, slab_list);	/* Ensure bit 0 is clear */
 #endif
 SLAB_MATCH(_refcount, __page_refcount);
 #ifdef CONFIG_MEMCG
@@ -76,6 +83,9 @@ SLAB_MATCH(memcg_data, memcg_data);
 #endif
 #undef SLAB_MATCH
 static_assert(sizeof(struct slab) <= sizeof(struct page));
+#if defined(CONFIG_HAVE_CMPXCHG_DOUBLE) && defined(CONFIG_SLUB)
+static_assert(IS_ALIGNED(offsetof(struct slab, freelist), 2*sizeof(void *)));
+#endif
 
 /**
  * folio_slab - Converts from folio to slab.
-- 
2.38.0


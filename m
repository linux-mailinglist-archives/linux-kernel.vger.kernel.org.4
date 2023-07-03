Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7EE5745E9D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 16:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbjGCOiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 10:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjGCOio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 10:38:44 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32A41B5
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 07:38:43 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-c361777c7f7so6705422276.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 07:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688395123; x=1690987123;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kl2jCAqNCPSkEP0NABub10B8q2+JV/gXjY8VZw9Pkgk=;
        b=G20YFXXdRv/mQ0oqlg19IV+d2kRvg3amgtHZR5NyPDqxiGLxd+3LiNemu3w212yCvH
         l/E8x3ZK4DBfpYr4ihiZP++/4fm2OV6TBqGsa0eWB8/cpWph9DIsdmoQgMHnuhNYwz83
         UcG6OiEXh+2TYCdRmcwb9K1TtjTf4XE1V1gbWrLsIKnl1QM5Ztc2gI2mK+vYfETODso2
         OolO6OspMpmDwUSp8i5vgnPa6Qx4sRa+7ZcvD/H7OX3Myit/g4/R8v+nDr4VbVJQVyB+
         Om+kgoascbCgjyvHI6Xgz41trUhM2g2Ykfx1YcGmFgZ75W6vl5HRV9obNgZOGS5G6Lsg
         SCrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688395123; x=1690987123;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kl2jCAqNCPSkEP0NABub10B8q2+JV/gXjY8VZw9Pkgk=;
        b=NJX5FV4l6Q9j9BRpZLKE+cSAF1wB1q+YSht83Ff35vby/5o3l7tesr8+09XkCgdafo
         g95k30N9DHKzCenqsFonwPmyFi5VGLNnxoAIVSsMd2S82iV5ECecxIuo75uDjs0kU3c2
         H6xPF3H81+7bbUHH3td5YwDjr5Gs6LLqYyL50msdP8p2W1XR4HkspGplSyKl5mrdA1Om
         2H5e5t7C5cRH1RqwJvyB7KqgneT0E2mcbLxUQVtdsUPSaO2Uqri569t23DumeH7bjjK8
         soel+lv9LoCWdk8bJlnawyb5Mc4hV25AFd1GzkO2Xn6dD/SQpXpYDBGsddOpzFsBruII
         enMA==
X-Gm-Message-State: ABy/qLYjfyl33guIQUiWa5ga44aB6FidWNBB730/HrHAl3irU9A77jwZ
        6vgEKSQONoIgT2ZyUxKAs662dNVXOZBEpkW4LA==
X-Google-Smtp-Source: APBJJlErQjF8xVj4u2JEy0UYELOqnNZuWsnTZZV7UShF56diCA1LFrEiwfZhbfPmUmPY8M4bEzXkHKhEfXry7ojHlg==
X-Received: from mr-cloudtop2.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:fb5])
 (user=matteorizzo job=sendgmr) by 2002:a25:6901:0:b0:c17:b9e7:4c2c with SMTP
 id e1-20020a256901000000b00c17b9e74c2cmr121848ybc.6.1688395122873; Mon, 03
 Jul 2023 07:38:42 -0700 (PDT)
Date:   Mon,  3 Jul 2023 14:38:20 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230703143820.152479-1-matteorizzo@google.com>
Subject: [PATCH] mm/slub: refactor freelist to use custom type
From:   Matteo Rizzo <matteorizzo@google.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz
Cc:     roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, jannh@google.com,
        matteorizzo@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jann Horn <jannh@google.com>

Currently the SLUB code represents encoded freelist entries as "void*".
That's misleading, those things are encoded under
CONFIG_SLAB_FREELIST_HARDENED so that they're not actually dereferencable.

Give them their own type, and split freelist_ptr() into one function per
direction (one for encoding, one for decoding).

Signed-off-by: Jann Horn <jannh@google.com>
Co-developed-by: Matteo Rizzo <matteorizzo@google.com>
Signed-off-by: Matteo Rizzo <matteorizzo@google.com>
---
 include/linux/slub_def.h |  6 ++++++
 mm/slub.c                | 37 ++++++++++++++++++++++++++-----------
 2 files changed, 32 insertions(+), 11 deletions(-)

diff --git a/include/linux/slub_def.h b/include/linux/slub_def.h
index deb90cf4bffb..c747820a55b4 100644
--- a/include/linux/slub_def.h
+++ b/include/linux/slub_def.h
@@ -43,6 +43,12 @@ enum stat_item {
 };
 
 #ifndef CONFIG_SLUB_TINY
+/*
+ * freeptr_t represents a SLUB freelist pointer, which might be encoded
+ * and not dereferenceable if CONFIG_SLAB_FREELIST_HARDENED is enabled.
+ */
+typedef struct { unsigned long v; } freeptr_t;
+
 /*
  * When changing the layout, make sure freelist and tid are still compatible
  * with this_cpu_cmpxchg_double() alignment requirements.
diff --git a/mm/slub.c b/mm/slub.c
index e3b5d5c0eb3a..26d0ca02b61d 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -365,8 +365,8 @@ static struct workqueue_struct *flushwq;
  * with an XOR of the address where the pointer is held and a per-cache
  * random number.
  */
-static inline void *freelist_ptr(const struct kmem_cache *s, void *ptr,
-				 unsigned long ptr_addr)
+static inline freeptr_t freelist_ptr_encode(const struct kmem_cache *s,
+					    void *ptr, unsigned long ptr_addr)
 {
 #ifdef CONFIG_SLAB_FREELIST_HARDENED
 	/*
@@ -379,25 +379,40 @@ static inline void *freelist_ptr(const struct kmem_cache *s, void *ptr,
 	 * calls get_freepointer() with an untagged pointer, which causes the
 	 * freepointer to be restored incorrectly.
 	 */
-	return (void *)((unsigned long)ptr ^ s->random ^
-			swab((unsigned long)kasan_reset_tag((void *)ptr_addr)));
+	return (freeptr_t){.v = (unsigned long)ptr ^ s->random ^
+			swab((unsigned long)kasan_reset_tag((void *)ptr_addr))};
 #else
-	return ptr;
+	return (freeptr_t){.v = (unsigned long)ptr};
 #endif
 }
 
+static inline void *freelist_ptr_decode(const struct kmem_cache *s,
+					freeptr_t ptr, unsigned long ptr_addr)
+{
+	void *decoded;
+
+#ifdef CONFIG_SLAB_FREELIST_HARDENED
+	/* See the comment in freelist_ptr_encode */
+	decoded = (void *)(ptr.v ^ s->random ^
+		swab((unsigned long)kasan_reset_tag((void *)ptr_addr)));
+#else
+	decoded = (void *)ptr.v;
+#endif
+	return decoded;
+}
+
 /* Returns the freelist pointer recorded at location ptr_addr. */
 static inline void *freelist_dereference(const struct kmem_cache *s,
 					 void *ptr_addr)
 {
-	return freelist_ptr(s, (void *)*(unsigned long *)(ptr_addr),
+	return freelist_ptr_decode(s, *(freeptr_t *)(ptr_addr),
 			    (unsigned long)ptr_addr);
 }
 
 static inline void *get_freepointer(struct kmem_cache *s, void *object)
 {
 	object = kasan_reset_tag(object);
-	return freelist_dereference(s, object + s->offset);
+	return freelist_dereference(s, (freeptr_t *)(object + s->offset));
 }
 
 #ifndef CONFIG_SLUB_TINY
@@ -421,15 +436,15 @@ __no_kmsan_checks
 static inline void *get_freepointer_safe(struct kmem_cache *s, void *object)
 {
 	unsigned long freepointer_addr;
-	void *p;
+	freeptr_t p;
 
 	if (!debug_pagealloc_enabled_static())
 		return get_freepointer(s, object);
 
 	object = kasan_reset_tag(object);
 	freepointer_addr = (unsigned long)object + s->offset;
-	copy_from_kernel_nofault(&p, (void **)freepointer_addr, sizeof(p));
-	return freelist_ptr(s, p, freepointer_addr);
+	copy_from_kernel_nofault(&p, (freeptr_t *)freepointer_addr, sizeof(p));
+	return freelist_ptr_decode(s, p, freepointer_addr);
 }
 
 static inline void set_freepointer(struct kmem_cache *s, void *object, void *fp)
@@ -441,7 +456,7 @@ static inline void set_freepointer(struct kmem_cache *s, void *object, void *fp)
 #endif
 
 	freeptr_addr = (unsigned long)kasan_reset_tag((void *)freeptr_addr);
-	*(void **)freeptr_addr = freelist_ptr(s, fp, freeptr_addr);
+	*(freeptr_t *)freeptr_addr = freelist_ptr_encode(s, fp, freeptr_addr);
 }
 
 /* Loop over all objects in a slab */

base-commit: a901a3568fd26ca9c4a82d8bc5ed5b3ed844d451
-- 
2.41.0.255.g8b1d071c50-goog


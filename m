Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80912747365
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 15:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbjGDN7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 09:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbjGDN7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 09:59:11 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A37B10E5
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 06:59:10 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-573a92296c7so51294587b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 06:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688479149; x=1691071149;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DC8Xq57VnNVy2UPnztEh7pdyCXoL2+wf6j7oIzU/k0U=;
        b=ied37usOyUZSNNUYFWB/0x9Gp2Xy3VBqOZsdjhUe4raEDydnbYF6HgEiQ3X+pvSQIR
         H6v+ZACeiuklWaHQuyR+PUR4X1/upWRLXxCWvZj8/qbVWoBvWqe/6sKN21wSoOfELlOc
         CD08aaZPDspCmCOvI+LpffHdthodD0JLKmoCGvxQZV3rodZFF55UOJFt2YJXQfDNZYV7
         39xNX8E7YYFfbNKTfbuNdbxVUGDDkGZiDRmib0EsF2Mou0u4OYO/oPWvWmehwRzDFK5D
         Imt+Bwof1BSr+KwKcJJidytEDE5co5ZNs14Yx3ZfgsJkQv3RnObo5szD3Nqeos8pKDEj
         Jhbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688479149; x=1691071149;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DC8Xq57VnNVy2UPnztEh7pdyCXoL2+wf6j7oIzU/k0U=;
        b=KATbMnbnYRAhf9woSnmmzy3+HH3ow/Ug+yaTzylCFc3f9eqoHICZEwXAHIy9AqFNv0
         ldSJHoDqODVBEFeXB8VV1O6NpFp9Hw4xdnjMJUP4Wc6qT+zlR7WP1tUF6oe0jwbMLgkT
         B0NyXADnrBEPbxoRYV1fxJ2uzuefjY+0YUz4Ms8yRhh5Q6xFPnmZE4EkmK5l9DKg0jUt
         KX90coSHrhJqgDrWUT0/cIzqxSvHGt82FnyulODb2kQb2cnqGSCgXFlizsbdZB3jUF54
         /lsouqX71ouN1pJA5Yao9nBW0kch9mAhYMZMpuBURxrno6yEtBe+Fub/GNHF0uH9sFMu
         jCng==
X-Gm-Message-State: ABy/qLZK2JqxpauweEln1ubz2Btg+uSUZnnhC8tGrXh7gynMnDpgeCHx
        vZ2UYJPoaP0djtkJlbqqc2nImf5Fxct/hkwgIw==
X-Google-Smtp-Source: APBJJlHCT8YpmjLt4pwJNPMv9gOj/d3Eu5xEqnXGre+LNmaIV7PZ1W8rT72U+lTdniCwmoOaKpA4OJ+vM5tue1x5Dw==
X-Received: from mr-cloudtop2.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:fb5])
 (user=matteorizzo job=sendgmr) by 2002:a81:4428:0:b0:577:4540:905d with SMTP
 id r40-20020a814428000000b005774540905dmr76533ywa.8.1688479149512; Tue, 04
 Jul 2023 06:59:09 -0700 (PDT)
Date:   Tue,  4 Jul 2023 13:58:34 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230704135834.3884421-1-matteorizzo@google.com>
Subject: [PATCH v2] mm/slub: refactor freelist to use custom type
From:   Matteo Rizzo <matteorizzo@google.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com
Cc:     jannh@google.com, matteorizzo@google.com
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
v2:
	* Fix compilation error with SLUB_TINY
	* Move the freeptr_t typedef to slub.c

 mm/slub.c | 43 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 32 insertions(+), 11 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index e3b5d5c0eb3a..f8cc47eff742 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -360,13 +360,19 @@ static struct workqueue_struct *flushwq;
  * 			Core slab cache functions
  *******************************************************************/

+/*
+ * freeptr_t represents a SLUB freelist pointer, which might be encoded
+ * and not dereferenceable if CONFIG_SLAB_FREELIST_HARDENED is enabled.
+ */
+typedef struct { unsigned long v; } freeptr_t;
+
 /*
  * Returns freelist pointer (ptr). With hardening, this is obfuscated
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
@@ -379,25 +385,40 @@ static inline void *freelist_ptr(const struct kmem_cache *s, void *ptr,
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
@@ -421,15 +442,15 @@ __no_kmsan_checks
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
@@ -441,7 +462,7 @@ static inline void set_freepointer(struct kmem_cache *s, void *object, void *fp)
 #endif

 	freeptr_addr = (unsigned long)kasan_reset_tag((void *)freeptr_addr);
-	*(void **)freeptr_addr = freelist_ptr(s, fp, freeptr_addr);
+	*(freeptr_t *)freeptr_addr = freelist_ptr_encode(s, fp, freeptr_addr);
 }

 /* Loop over all objects in a slab */

base-commit: 24be4d0b46bb0c3c1dc7bacd30957d6144a70dfc
--
2.41.0.255.g8b1d071c50-goog

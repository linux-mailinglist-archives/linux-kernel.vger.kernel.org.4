Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A631B74F09E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 15:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232784AbjGKNqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 09:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbjGKNqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 09:46:38 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D12E6A;
        Tue, 11 Jul 2023 06:46:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0FF911FDA0;
        Tue, 11 Jul 2023 13:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1689083195; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=RXHIYdVmdQJX5tnkNjy37yeBssRnaU5MoOmNGkfF484=;
        b=DVO93ktxjFk3VzkffNtwh1rU0QfweANLsy9oVYvFPGIeNVcpRdrrIpFNYcej2rYKY7sNDM
        bKjN4dQau8CtiYI7D6FON8xDb/M5h8wTke2ei4xM5jMAt+o+bwDX12JNsoetppguRUTmiI
        3TOWlE4qXwwHHyr5h/3JYzS4DmEamL4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1689083195;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=RXHIYdVmdQJX5tnkNjy37yeBssRnaU5MoOmNGkfF484=;
        b=EJTlIqxlmAlFa+9Nk7qpsjsA6kWKHmE0gNx/pb6blh/Evb+jPLWa82Nz2lgRY5oF1+D5vB
        AEpWeIfOau7q79BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C1D2D1390F;
        Tue, 11 Jul 2023 13:46:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NXqMLjpdrWTSYwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 11 Jul 2023 13:46:34 +0000
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        Matteo Rizzo <matteorizzo@google.com>,
        Jann Horn <jannh@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev@googlegroups.com, Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH 1/2] mm/slub: remove redundant kasan_reset_tag() from freelist_ptr calculations
Date:   Tue, 11 Jul 2023 15:46:24 +0200
Message-ID: <20230711134623.12695-3-vbabka@suse.cz>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit d36a63a943e3 ("kasan, slub: fix more conflicts with
CONFIG_SLAB_FREELIST_HARDENED") has introduced kasan_reset_tags() to
freelist_ptr() encoding/decoding when CONFIG_SLAB_FREELIST_HARDENED is
enabled to resolve issues when passing tagged or untagged pointers
inconsistently would lead to incorrect calculations.

Later, commit aa1ef4d7b3f6 ("kasan, mm: reset tags when accessing
metadata") made sure all pointers have tags reset regardless of
CONFIG_SLAB_FREELIST_HARDENED, because there was no other way to access
the freepointer metadata safely with hw tag-based KASAN.

Therefore the kasan_reset_tag() usage in freelist_ptr_encode()/decode()
is now redundant, as all callers use kasan_reset_tag() unconditionally
when constructing ptr_addr. Remove the redundant calls and simplify the
code and remove obsolete comments.

Also in freelist_ptr_encode() introduce an 'encoded' variable to make
the lines shorter and make it similar to the _decode() one.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
These 2 patches build on top of:
https://lore.kernel.org/all/20230704135834.3884421-1-matteorizzo@google.com/

 mm/slub.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index f8cc47eff742..07edad305512 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -374,22 +374,14 @@ typedef struct { unsigned long v; } freeptr_t;
 static inline freeptr_t freelist_ptr_encode(const struct kmem_cache *s,
 					    void *ptr, unsigned long ptr_addr)
 {
+	unsigned long encoded;
+
 #ifdef CONFIG_SLAB_FREELIST_HARDENED
-	/*
-	 * When CONFIG_KASAN_SW/HW_TAGS is enabled, ptr_addr might be tagged.
-	 * Normally, this doesn't cause any issues, as both set_freepointer()
-	 * and get_freepointer() are called with a pointer with the same tag.
-	 * However, there are some issues with CONFIG_SLUB_DEBUG code. For
-	 * example, when __free_slub() iterates over objects in a cache, it
-	 * passes untagged pointers to check_object(). check_object() in turns
-	 * calls get_freepointer() with an untagged pointer, which causes the
-	 * freepointer to be restored incorrectly.
-	 */
-	return (freeptr_t){.v = (unsigned long)ptr ^ s->random ^
-			swab((unsigned long)kasan_reset_tag((void *)ptr_addr))};
+	encoded = (unsigned long)ptr ^ s->random ^ swab(ptr_addr);
 #else
-	return (freeptr_t){.v = (unsigned long)ptr};
+	encoded = (unsigned long)ptr;
 #endif
+	return (freeptr_t){.v = encoded};
 }
 
 static inline void *freelist_ptr_decode(const struct kmem_cache *s,
@@ -398,9 +390,7 @@ static inline void *freelist_ptr_decode(const struct kmem_cache *s,
 	void *decoded;
 
 #ifdef CONFIG_SLAB_FREELIST_HARDENED
-	/* See the comment in freelist_ptr_encode */
-	decoded = (void *)(ptr.v ^ s->random ^
-		swab((unsigned long)kasan_reset_tag((void *)ptr_addr)));
+	decoded = (void *)(ptr.v ^ s->random ^ swab(ptr_addr));
 #else
 	decoded = (void *)ptr.v;
 #endif
-- 
2.41.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59160623499
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 21:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbiKIUbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 15:31:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbiKIUa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 15:30:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FDD019018
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 12:30:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CFF24B82004
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 20:30:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6098AC433C1;
        Wed,  9 Nov 2022 20:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1668025852;
        bh=penp5eGjlAzwEMHIlYfO2UthsDqmi4JE3eNVxwebGdU=;
        h=From:To:Cc:Subject:Date:From;
        b=QDtR/oMNFrNnuSC8rkqWQuyDgSXMdz7cE6sGNbUSY63i7rPywtVF2bs/QeWo1hR6D
         E+ZSTT3gQ1V/p4cp0tg271dSgkqpaQYCwj4Hw+IDg1mhCSpAbyrGxAwL6Aja826eaJ
         t6IFNeMUW7uI0RdE4bX2KpSOHjrhnD9sK5lLsPGY=
From:   Linus Torvalds <torvalds@linux-foundation.org>
To:     Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH 1/4] mm: introduce 'encoded' page pointers with embedded extra bits
Date:   Wed,  9 Nov 2022 12:30:48 -0800
Message-Id: <20221109203051.1835763-1-torvalds@linux-foundation.org>
X-Mailer: git-send-email 2.38.1.284.gfd9468d787
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We already have this notion in parts of the MM code (see the mlock code
with the LRU_PAGE and NEW_PAGE bits), but I'm going to introduce a new
case, and I refuse to do the same thing we've done before where we just
put bits in the raw pointer and say it's still a normal pointer.

So this introduces a 'struct encoded_page' pointer that cannot be used
for anything else than to encode a real page pointer and a couple of
extra bits in the low bits.  That way the compiler can trivially track
the state of the pointer and you just explicitly encode and decode the
extra bits.

Note that this makes the alignment of 'struct page' explicit even for
the case where CONFIG_HAVE_ALIGNED_STRUCT_PAGE is not set.  That is
entirely redundant in almost all cases, since the page structure already
contains several word-sized entries.

However, on m68k, the alignment of even 32-bit data is just 16 bits, and
as such in theory the alignment of 'struct page' could be too.  So let's
just make it very very explicit that the alignment needs to be at least
32 bits, giving us a guarantee of two unused low bits in the pointer.

Now, in practice, our page struct array is aligned much more than that
anyway, even on m68k, and our existing code in mm/mlock.c obviously
already depended on that.  But since the whole point of this change is
to be careful about the type system when hiding extra bits in the
pointer, let's also be explicit about the assumptions we make.

NOTE! This is being very careful in another way too: it has a build-time
assertion that the 'flags' added to the page pointer actually fit in the
two bits.  That means that this helper must be inlined, and can only be
used in contexts where the compiler can statically determine that the
value fits in the available bits.

Link: https://lore.kernel.org/all/Y2tKixpO4RO6DgW5@tuxmaker.boeblingen.de.ibm.com/
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 include/linux/mm_types.h | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 500e536796ca..0a38fcb08d85 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -67,7 +67,7 @@ struct mem_cgroup;
 #ifdef CONFIG_HAVE_ALIGNED_STRUCT_PAGE
 #define _struct_page_alignment	__aligned(2 * sizeof(unsigned long))
 #else
-#define _struct_page_alignment
+#define _struct_page_alignment	__aligned(sizeof(unsigned long))
 #endif
 
 struct page {
@@ -241,6 +241,38 @@ struct page {
 #endif
 } _struct_page_alignment;
 
+/**
+ * struct encoded_page - a nonexistent type marking this pointer
+ *
+ * An 'encoded_page' pointer is a pointer to a regular 'struct page', but
+ * with the low bits of the pointer indicating extra context-dependent
+ * information. Not super-common, but happens in mmu_gather and mlock
+ * handling, and this acts as a type system check on that use.
+ *
+ * We only really have two guaranteed bits in general, although you could
+ * play with 'struct page' alignment (see CONFIG_HAVE_ALIGNED_STRUCT_PAGE)
+ * for more.
+ *
+ * Use the supplied helper functions to endcode/decode the pointer and bits.
+ */
+struct encoded_page;
+#define ENCODE_PAGE_BITS 3ul
+static __always_inline struct encoded_page *encode_page(struct page *page, unsigned long flags)
+{
+	BUILD_BUG_ON(flags > ENCODE_PAGE_BITS);
+	return (struct encoded_page *)(flags | (unsigned long)page);
+}
+
+static inline unsigned long encoded_page_flags(struct encoded_page *page)
+{
+	return ENCODE_PAGE_BITS & (unsigned long)page;
+}
+
+static inline struct page *encoded_page_ptr(struct encoded_page *page)
+{
+	return (struct page *)(~ENCODE_PAGE_BITS & (unsigned long)page);
+}
+
 /**
  * struct folio - Represents a contiguous set of bytes.
  * @flags: Identical to the page flags.
-- 
2.38.1.284.gfd9468d787


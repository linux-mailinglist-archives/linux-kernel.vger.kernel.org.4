Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 795D5621D1B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 20:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiKHTln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 14:41:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiKHTlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 14:41:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C9B27057F
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 11:41:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 12F3661778
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 19:41:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A040C433D6;
        Tue,  8 Nov 2022 19:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1667936500;
        bh=RaRVKzz9Se8UHTQHVas3xIYN6fbXJd+owd3hvoJX9dA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YFGak0IIB8Z5v2pn7OjlJtEcV0XXhvmCHnNCNbLCzZ6G1whB9cFSvgeUhqv5SuDma
         P+4d868qE3obUsgf8P8GfisLxpybgkUMc691B5zG7EOEdcWmOsYtuQvIQMlOSXHEFG
         nKrvrW3TQmBTfeLCpKJ2Tpw9NnbfS61++EIdjMvA=
From:   Linus Torvalds <torvalds@linux-foundation.org>
To:     Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 1/4] mm: introduce 'encoded' page pointers with embedded extra bits
Date:   Tue,  8 Nov 2022 11:41:36 -0800
Message-Id: <20221108194139.57604-1-torvalds@linux-foundation.org>
X-Mailer: git-send-email 2.38.1.284.gfd9468d787
In-Reply-To: <CAHk-=wh6MxaCA4pXpt1F5Bn2__6MxCq0Dr-rES4i=MOL9ibjpg@mail.gmail.com>
References: <CAHk-=wh6MxaCA4pXpt1F5Bn2__6MxCq0Dr-rES4i=MOL9ibjpg@mail.gmail.com>
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
with the LRU_PAGE and NEW_PAGE) bits, but I'm going to introduce a new
case, and I refuse to do the same thing we've done before where we just
put bits in the raw pointer and say it's still a normal pointer.

So this introduces a 'struct encoded_page' pointer that cannot be used
for anything else than to encode a real page pointer and a couple of
extra bits in the low bits.  That way the compiler can trivially track
the state of the pointer and you just explicitly encode and decode the
extra bits.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 include/linux/mm_types.h | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 500e536796ca..b5cffd250784 100644
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
@@ -241,6 +241,37 @@ struct page {
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
+static inline struct encoded_page *encode_page(struct page *page, unsigned long flags)
+{
+	return (struct encoded_page *)(flags | (unsigned long)page);
+}
+
+static inline bool encoded_page_flags(struct encoded_page *page)
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


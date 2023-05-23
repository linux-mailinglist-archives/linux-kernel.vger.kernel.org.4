Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E13670E6DA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 22:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238095AbjEWUvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 16:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232531AbjEWUvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 16:51:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68861DA
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 13:51:04 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684875061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=xu3lh9FcdoeNVU96OzSdewnm6QGeZvQPxHHm1nN5R3o=;
        b=tSDD3fTqiWMazlzB0uscOaBYvMfkKxQ9Yr4u8hfs1K6DD8rg61sijq43Zt/QDRlF/fKD8l
        LdVdWgrNYPDr0EZ2IZj0uGiWiTEEJ4ufALsq/BlBFGTkHF8ALeaJc4Feb8FKsrvxdJgMAY
        xdbWK4lyC1JaSA9JJHvphcdDraUL+RWAlvmxFc2LTfRBcK77dlhyOjZ1M4uUMxA3MjWE3X
        YEWrrKkpjY+I/ITc6mzewzZLbKv8W8apJvXb0z4w4TYsHh28TwOFuy5VRJmLkYHiB4Hajn
        F6lCgkh/XcHysdEgZdDiqyoD9b/I4SeM4cogvr0RhgKlKirBZMG9mU2YJ7pAbQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684875061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=xu3lh9FcdoeNVU96OzSdewnm6QGeZvQPxHHm1nN5R3o=;
        b=kEoXdNpAMbORtwLPhvlREk3m9evosE9L6C3idDDMP4pPPX91PJFznyv0UwrE7alOmVf9FK
        uMwqzrRGezeT6TAQ==
To:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        Shanker Donthineni <sdonthineni@nvidia.com>
Subject: [PATCH v2] maple_tree: Fix a few documentation issues
In-Reply-To: <20230523134646.gelsru64qvny3fi7@revolver>
Date:   Tue, 23 May 2023 22:51:01 +0200
Message-ID: <87ttw2n556.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The documentation of mt_next() claims that it starts the search at the
provided index. That's incorrect as it starts the search after the provided
index.

The documentation of mt_find() is slightly confusing. "Handles locking" is
not really helpful as it does not explain how the "locking" works. Also the
documentation of index talks about a range, while in reality the index
is updated on a succesful search to the index of the found entry plus one.

Fix similar issues for mt_find_after() and mt_prev().

Reword the confusing "Note: Will not return the zero entry." comment on
mt_for_each() and document @__index correctly.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: Address review feedback. Add pointer to documentation, reword the
    zero entry and the index explanations. - Liam
---
 include/linux/maple_tree.h |    5 +++--
 lib/maple_tree.c           |   26 +++++++++++++++++++++-----
 2 files changed, 24 insertions(+), 7 deletions(-)

--- a/include/linux/maple_tree.h
+++ b/include/linux/maple_tree.h
@@ -659,10 +659,11 @@ void *mt_next(struct maple_tree *mt, uns
  * mt_for_each - Iterate over each entry starting at index until max.
  * @__tree: The Maple Tree
  * @__entry: The current entry
- * @__index: The index to update to track the location in the tree
+ * @__index: The index to start the search from. Subsequently used as iterator.
  * @__max: The maximum limit for @index
  *
- * Note: Will not return the zero entry.
+ * This iterator skips all entries, which resolve to a NULL pointer,
+ * e.g. entries which has been reserved with XA_ZERO_ENTRY.
  */
 #define mt_for_each(__tree, __entry, __index, __max) \
 	for (__entry = mt_find(__tree, &(__index), __max); \
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5947,7 +5947,11 @@ EXPORT_SYMBOL_GPL(mas_next);
  * @index: The start index
  * @max: The maximum index to check
  *
- * Return: The entry at @index or higher, or %NULL if nothing is found.
+ * Takes RCU read lock internally to protect the search, which does not
+ * protect the returned pointer after dropping RCU read lock.
+ * See also: Documentation/core-api/maple_tree.rst
+ *
+ * Return: The entry higher than @index or %NULL if nothing is found.
  */
 void *mt_next(struct maple_tree *mt, unsigned long index, unsigned long max)
 {
@@ -6012,7 +6016,11 @@ EXPORT_SYMBOL_GPL(mas_prev);
  * @index: The start index
  * @min: The minimum index to check
  *
- * Return: The entry at @index or lower, or %NULL if nothing is found.
+ * Takes RCU read lock internally to protect the search, which does not
+ * protect the returned pointer after dropping RCU read lock.
+ * See also: Documentation/core-api/maple_tree.rst
+ *
+ * Return: The entry before @index or %NULL if nothing is found.
  */
 void *mt_prev(struct maple_tree *mt, unsigned long index, unsigned long min)
 {
@@ -6487,9 +6495,15 @@ EXPORT_SYMBOL(mtree_destroy);
  * mt_find() - Search from the start up until an entry is found.
  * @mt: The maple tree
  * @index: Pointer which contains the start location of the search
- * @max: The maximum value to check
+ * @max: The maximum value of the search range
  *
- * Handles locking.  @index will be incremented to one beyond the range.
+ * Takes RCU read lock internally to protect the search, which does not
+ * protect the returned pointer after dropping RCU read lock.
+ * See also: Documentation/core-api/maple_tree.rst
+ *
+ * In case that an entry is found @index is updated to point to the next
+ * possible entry independent whether the found entry is occupying a
+ * single index or a range if indices.
  *
  * Return: The entry at or after the @index or %NULL
  */
@@ -6548,7 +6562,9 @@ EXPORT_SYMBOL(mt_find);
  * @index: Pointer which contains the start location of the search
  * @max: The maximum value to check
  *
- * Handles locking, detects wrapping on index == 0
+ * Same as mt_find() except that it checks @index for 0 before
+ * searching. If @index == 0, the search is aborted. This covers a wrap
+ * around of @index to 0 in an iterator loop.
  *
  * Return: The entry at or after the @index or %NULL
  */

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C424E6FE451
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 21:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjEJTBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 15:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjEJTBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 15:01:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3807BE
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 12:01:07 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683745266; h=from:from:reply-to:subject:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type; bh=6VeszvmJNUYN70+RK5o7CAMFbLfrPw5Wbv+HBHpQnkU=;
        b=0uDoQAlU2tDjTgPPhnww90lqnbNn10piVW/W+bhmeFD0p0eFsCkFbE1F24H0kwpyXE+0jh
        6IdPqRkAYhKMjvoXq6/ZET/uLN/UdACiQvi0O88dfwfPkkVJRf4wXw8FhQIM91l19nnHR8
        vS1UmxQU4H3zQI+QkivQhBv7j0Pu4Laq3klS7W4TV51l2Hjor3QwH9fZ7nwae2cWrA1vQA
        Y4qZelXEvuNUUo6eUR4Jk7c36bke4rCzwgBgLeAeamu1hjBvqhzHVmPyoaXLzOjMXZccCW
        ZldaUA0RNQeNouHF5+uT36i0X+GLwHBg3K5KPq2AbOUFmw/1tp09c2djAbnZgg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683745266; h=from:from:reply-to:subject:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type; bh=6VeszvmJNUYN70+RK5o7CAMFbLfrPw5Wbv+HBHpQnkU=;
        b=bQzJF2B85H2QAG7r3taZgh09YXEtuzcYWaVeD/EnJAeFpd7nYPHKacHxt6nF1HDZAAdBQC
        qOMX2x0nqFw3DuDQ==
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        Shanker Donthineni <sdonthineni@nvidia.com>
Subject: [PATCH] maple_tree: Fix a few documentation issues
Subject: 
Date:   Wed, 10 May 2023 21:01:05 +0200
Message-ID: <87mt2cxb7y.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

Remove the completely confusing and pointless "Note: Will not return the
zero entry." comment from mt_for_each() and document @__index correctly.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/maple_tree.h |    4 +---
 lib/maple_tree.c           |   23 ++++++++++++++++++-----
 2 files changed, 19 insertions(+), 8 deletions(-)

--- a/include/linux/maple_tree.h
+++ b/include/linux/maple_tree.h
@@ -659,10 +659,8 @@ void *mt_next(struct maple_tree *mt, uns
  * mt_for_each - Iterate over each entry starting at index until max.
  * @__tree: The Maple Tree
  * @__entry: The current entry
- * @__index: The index to update to track the location in the tree
+ * @__index: The index to start the search from. Subsequently used as iterator.
  * @__max: The maximum limit for @index
- *
- * Note: Will not return the zero entry.
  */
 #define mt_for_each(__tree, __entry, __index, __max) \
 	for (__entry = mt_find(__tree, &(__index), __max); \
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5947,7 +5947,10 @@ EXPORT_SYMBOL_GPL(mas_next);
  * @index: The start index
  * @max: The maximum index to check
  *
- * Return: The entry at @index or higher, or %NULL if nothing is found.
+ * Takes RCU read lock internally to protect the search, which does not
+ * protect the returned pointer after dropping RCU read lock.
+ *
+ * Return: The entry higher than @index or %NULL if nothing is found.
  */
 void *mt_next(struct maple_tree *mt, unsigned long index, unsigned long max)
 {
@@ -6012,7 +6015,10 @@ EXPORT_SYMBOL_GPL(mas_prev);
  * @index: The start index
  * @min: The minimum index to check
  *
- * Return: The entry at @index or lower, or %NULL if nothing is found.
+ * Takes RCU read lock internally to protect the search, which does not
+ * protect the returned pointer after dropping RCU read lock.
+ *
+ * Return: The entry before @index or %NULL if nothing is found.
  */
 void *mt_prev(struct maple_tree *mt, unsigned long index, unsigned long min)
 {
@@ -6487,9 +6493,14 @@ EXPORT_SYMBOL(mtree_destroy);
  * mt_find() - Search from the start up until an entry is found.
  * @mt: The maple tree
  * @index: Pointer which contains the start location of the search
- * @max: The maximum value to check
+ * @max: The maximum value of the search range
+ *
+ * Takes RCU read lock internally to protect the search, which does not
+ * protect the returned pointer after dropping RCU read lock.
  *
- * Handles locking.  @index will be incremented to one beyond the range.
+ * In case that an entry is found @index contains the index of the found
+ * entry plus one, so it can be used as iterator index to find the next
+ * entry.
  *
  * Return: The entry at or after the @index or %NULL
  */
@@ -6548,7 +6559,9 @@ EXPORT_SYMBOL(mt_find);
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

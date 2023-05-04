Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D45066F77A4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 23:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbjEDVBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 17:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjEDVBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 17:01:15 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C737D13290
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 14:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1683230733;
        bh=ejcZRhDyFKbQO0Pq2uphS/at1qd6mS5DdbQdmXOnDzQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RtnX8wDZcF6Jl+yg7Dd9MSRqmNfuJYg1Un9qlf5XhMvxdr7G3SPJ/NC7b1o0U9QqO
         xNNKCrM3RFPuHBRWMX+pbAOtU94c/g8K1MJU0el1F3YlFSF7/SjANB97oUp1US8g0J
         UxTEkVNVZwlmjmGS1aBGe9SsZ3VpWXSKRUvWu3Lqq9qoURob4coNjaJISbSgUX1s3j
         Anak7Axro4o4SYd8WD2cOd+aVuCq5K+uK3qdUX0vVv9SSVXEkiSt7D5CUPNO1DMv+2
         oGikVrgtWGdvksFhIcg3vSW6JI7vKEVlBfKdpSWREnRpNFOL6qvBmK1E8wORIWPnLu
         TE7ZR+jxlRkEg==
Received: from localhost.localdomain (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4QC4Yn0vBhz122d;
        Thu,  4 May 2023 16:05:33 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Howells <dhowells@redhat.com>,
        Ricardo Martinez <ricardo.martinez@linux.intel.com>
Subject: [RFC PATCH 05/13] list.h: Fix parentheses around macro pointer parameter use
Date:   Thu,  4 May 2023 16:05:19 -0400
Message-Id: <20230504200527.1935944-6-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230504200527.1935944-1-mathieu.desnoyers@efficios.com>
References: <20230504200527.1935944-1-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing parentheses around use of macro argument "pos" in those
patterns to ensure operator precedence behaves as expected:

- typeof(*pos)
- pos->member
- "x = y" is changed for "x = (y)", because "y" can be an expression
  containing a comma if it is the result of the expansion of a macro such
  as #define eval(...) __VA_ARGS__, which would cause unexpected operator
  precedence. This use-case is far-fetched, but we have to choose one
  way or the other (with or without parentheses) for consistency,
- x && y is changed for (x) && (y).

Remove useless parentheses around use of macro parameter (head) in the
following pattern:

- list_is_head(pos, (head))

Because comma is the lowest priority operator already, so the extra pair
of parentheses is redundant.

This corrects the following usage pattern where operator precedence is
unexpected:

  LIST_HEAD(testlist);

  struct test {
          struct list_head node;
          int a;
  };

  // pos->member issue
  void f(void)
  {
          struct test *t1;
          struct test **t2 = &t1;

          list_for_each_entry((*t2), &testlist, node) {   /* works */
                  //...
          }
          list_for_each_entry(*t2, &testlist, node) {     /* broken */
                  //...
          }
  }

  // typeof(*pos) issue
  void f2(void)
  {
          struct test *t1 = NULL, *t2;

          t2 = list_prepare_entry((0 + t1), &testlist, node);     /* works */
          t2 = list_prepare_entry(0 + t1, &testlist, node);       /* broken */
  }

Note that the macros in which "pos" is also used as an lvalue probably
don't suffer from the lack of parentheses around "pos" in typeof(*pos),
but add those nevertheless to keep everything consistent.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Ricardo Martinez <ricardo.martinez@linux.intel.com>
---
 include/linux/list.h | 54 ++++++++++++++++++++++----------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/include/linux/list.h b/include/linux/list.h
index f10344dbad4d..d197b1a6f411 100644
--- a/include/linux/list.h
+++ b/include/linux/list.h
@@ -603,7 +603,7 @@ static inline void list_splice_tail_init(struct list_head *list,
  * @head:	the head for your list.
  */
 #define list_for_each(pos, head) \
-	for (pos = (head)->next; !list_is_head(pos, (head)); pos = pos->next)
+	for (pos = (head)->next; !list_is_head(pos, head); pos = (pos)->next)
 
 /**
  * list_for_each_rcu - Iterate over a list in an RCU-safe fashion
@@ -612,8 +612,8 @@ static inline void list_splice_tail_init(struct list_head *list,
  */
 #define list_for_each_rcu(pos, head)		  \
 	for (pos = rcu_dereference((head)->next); \
-	     !list_is_head(pos, (head)); \
-	     pos = rcu_dereference(pos->next))
+	     !list_is_head(pos, head); \
+	     pos = rcu_dereference((pos)->next))
 
 /**
  * list_for_each_continue - continue iteration over a list
@@ -623,7 +623,7 @@ static inline void list_splice_tail_init(struct list_head *list,
  * Continue to iterate over a list, continuing after the current position.
  */
 #define list_for_each_continue(pos, head) \
-	for (pos = pos->next; !list_is_head(pos, (head)); pos = pos->next)
+	for (pos = (pos)->next; !list_is_head(pos, head); pos = (pos)->next)
 
 /**
  * list_for_each_prev	-	iterate over a list backwards
@@ -631,7 +631,7 @@ static inline void list_splice_tail_init(struct list_head *list,
  * @head:	the head for your list.
  */
 #define list_for_each_prev(pos, head) \
-	for (pos = (head)->prev; !list_is_head(pos, (head)); pos = pos->prev)
+	for (pos = (head)->prev; !list_is_head(pos, head); pos = (pos)->prev)
 
 /**
  * list_for_each_safe - iterate over a list safe against removal of list entry
@@ -640,9 +640,9 @@ static inline void list_splice_tail_init(struct list_head *list,
  * @head:	the head for your list.
  */
 #define list_for_each_safe(pos, n, head) \
-	for (pos = (head)->next, n = pos->next; \
-	     !list_is_head(pos, (head)); \
-	     pos = n, n = pos->next)
+	for (pos = (head)->next, n = (pos)->next; \
+	     !list_is_head(pos, head); \
+	     pos = (n), n = (pos)->next)
 
 /**
  * list_for_each_prev_safe - iterate over a list backwards safe against removal of list entry
@@ -651,9 +651,9 @@ static inline void list_splice_tail_init(struct list_head *list,
  * @head:	the head for your list.
  */
 #define list_for_each_prev_safe(pos, n, head) \
-	for (pos = (head)->prev, n = pos->prev; \
-	     !list_is_head(pos, (head)); \
-	     pos = n, n = pos->prev)
+	for (pos = (head)->prev, n = (pos)->prev; \
+	     !list_is_head(pos, head); \
+	     pos = (n), n = (pos)->prev)
 
 /**
  * list_count_nodes - count nodes in the list
@@ -677,7 +677,7 @@ static inline size_t list_count_nodes(struct list_head *head)
  * @member:	the name of the list_head within the struct.
  */
 #define list_entry_is_head(pos, head, member)				\
-	(&pos->member == (head))
+	(&(pos)->member == (head))
 
 /**
  * list_for_each_entry	-	iterate over list of given type
@@ -686,7 +686,7 @@ static inline size_t list_count_nodes(struct list_head *head)
  * @member:	the name of the list_head within the struct.
  */
 #define list_for_each_entry(pos, head, member)				\
-	for (pos = list_first_entry(head, typeof(*pos), member);	\
+	for (pos = list_first_entry(head, typeof(*(pos)), member);	\
 	     !list_entry_is_head(pos, head, member);			\
 	     pos = list_next_entry(pos, member))
 
@@ -697,7 +697,7 @@ static inline size_t list_count_nodes(struct list_head *head)
  * @member:	the name of the list_head within the struct.
  */
 #define list_for_each_entry_reverse(pos, head, member)			\
-	for (pos = list_last_entry(head, typeof(*pos), member);		\
+	for (pos = list_last_entry(head, typeof(*(pos)), member);	\
 	     !list_entry_is_head(pos, head, member); 			\
 	     pos = list_prev_entry(pos, member))
 
@@ -710,7 +710,7 @@ static inline size_t list_count_nodes(struct list_head *head)
  * Prepares a pos entry for use as a start point in list_for_each_entry_continue().
  */
 #define list_prepare_entry(pos, head, member) \
-	((pos) ? : list_entry(head, typeof(*pos), member))
+	((pos) ? : list_entry(head, typeof(*(pos)), member))
 
 /**
  * list_for_each_entry_continue - continue iteration over list of given type
@@ -773,10 +773,10 @@ static inline size_t list_count_nodes(struct list_head *head)
  * @member:	the name of the list_head within the struct.
  */
 #define list_for_each_entry_safe(pos, n, head, member)			\
-	for (pos = list_first_entry(head, typeof(*pos), member),	\
+	for (pos = list_first_entry(head, typeof(*(pos)), member),	\
 		n = list_next_entry(pos, member);			\
 	     !list_entry_is_head(pos, head, member); 			\
-	     pos = n, n = list_next_entry(n, member))
+	     pos = (n), n = list_next_entry(n, member))
 
 /**
  * list_for_each_entry_safe_continue - continue list iteration safe against removal
@@ -792,7 +792,7 @@ static inline size_t list_count_nodes(struct list_head *head)
 	for (pos = list_next_entry(pos, member), 				\
 		n = list_next_entry(pos, member);				\
 	     !list_entry_is_head(pos, head, member);				\
-	     pos = n, n = list_next_entry(n, member))
+	     pos = (n), n = list_next_entry(n, member))
 
 /**
  * list_for_each_entry_safe_from - iterate over list from current point safe against removal
@@ -807,7 +807,7 @@ static inline size_t list_count_nodes(struct list_head *head)
 #define list_for_each_entry_safe_from(pos, n, head, member) 			\
 	for (n = list_next_entry(pos, member);					\
 	     !list_entry_is_head(pos, head, member);				\
-	     pos = n, n = list_next_entry(n, member))
+	     pos = (n), n = list_next_entry(n, member))
 
 /**
  * list_for_each_entry_safe_reverse - iterate backwards over list safe against removal
@@ -820,10 +820,10 @@ static inline size_t list_count_nodes(struct list_head *head)
  * of list entry.
  */
 #define list_for_each_entry_safe_reverse(pos, n, head, member)		\
-	for (pos = list_last_entry(head, typeof(*pos), member),		\
+	for (pos = list_last_entry(head, typeof(*(pos)), member),	\
 		n = list_prev_entry(pos, member);			\
 	     !list_entry_is_head(pos, head, member); 			\
-	     pos = n, n = list_prev_entry(n, member))
+	     pos = (n), n = list_prev_entry(n, member))
 
 /**
  * list_safe_reset_next - reset a stale list_for_each_entry_safe loop
@@ -1033,11 +1033,11 @@ static inline void hlist_move_list(struct hlist_head *old,
 #define hlist_entry(ptr, type, member) container_of(ptr,type,member)
 
 #define hlist_for_each(pos, head) \
-	for (pos = (head)->first; pos ; pos = pos->next)
+	for (pos = (head)->first; pos ; pos = (pos)->next)
 
 #define hlist_for_each_safe(pos, n, head) \
-	for (pos = (head)->first; pos && ({ n = pos->next; 1; }); \
-	     pos = n)
+	for (pos = (head)->first; (pos) && ({ n = (pos)->next; 1; }); \
+	     pos = (n))
 
 #define hlist_entry_safe(ptr, type, member) \
 	({ typeof(ptr) ____ptr = (ptr); \
@@ -1082,8 +1082,8 @@ static inline void hlist_move_list(struct hlist_head *old,
  * @member:	the name of the hlist_node within the struct.
  */
 #define hlist_for_each_entry_safe(pos, n, head, member) 		\
-	for (pos = hlist_entry_safe((head)->first, typeof(*pos), member);\
-	     pos && ({ n = pos->member.next; 1; });			\
-	     pos = hlist_entry_safe(n, typeof(*pos), member))
+	for (pos = hlist_entry_safe((head)->first, typeof(*(pos)), member);\
+	     (pos) && ({ n = (pos)->member.next; 1; });			\
+	     pos = hlist_entry_safe(n, typeof(*(pos)), member))
 
 #endif
-- 
2.25.1


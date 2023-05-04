Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6557A6F775C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 22:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbjEDUsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 16:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbjEDUrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 16:47:55 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 624E9AD32
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 13:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1683230733;
        bh=lMtgOxwdzX0uFY+dt+rni4n4Qsyjrfo6DEFUPcpl8ZU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fFma/8uB9FrnwdLgMUbByiIiA8Hs/uH8qtZGJZRYqQPgadYcdw1PlXB9LDBtfra97
         DeZL1N80zOyn6fvgwXRkthYRIG7bIsKysrcsLGoKj7N+mdmFKYvljaJ8W4RWkoK7BT
         Ih6EfdFIwq0dTqc9z1uevqKs8p59fJdB+xeJp2zZ85vEl6twos79ZLSTDJV/MEUoud
         RRksmMSyHeAZGK7SVbR2JsTPcIf340qNmlPh8lvc7Ex/MnNuBqa+ku09Oh4fDGVgzb
         g2d3IjTPh1hHOQdOrxtb6+iUBTPJ7KftPMIBzVQKrMDo0qUR4ySVQEcnkuvxQxyJyz
         46bI38/F4rnNw==
Received: from localhost.localdomain (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4QC4Yn5ZnSz11lP;
        Thu,  4 May 2023 16:05:33 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Huang Ying <ying.huang@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [RFC PATCH 08/13] llist.h: Fix parentheses around macro pointer parameter use
Date:   Thu,  4 May 2023 16:05:22 -0400
Message-Id: <20230504200527.1935944-9-mathieu.desnoyers@efficios.com>
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
  way or the other (with or without parentheses) for consistency.

The typeof(*pos) lack of parentheses around "pos" is not an issue per se
in the specific macros modified here because "pos" is used as an lvalue,
which should prevent use of any operator causing issue. Still add the
extra parentheses for consistency.

Remove useless parentheses around use of macro parameter (node) in the
following patterns:

- llist_entry((node), typeof(*(pos)), member) is changed for
  llist_entry(node, typeof(*(pos)), member),
- "(pos) = (node)" is changed for "pos = (node)".

Because comma is the lowest priority operator already, so the extra pair
of parentheses is redundant.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Huang Ying <ying.huang@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 include/linux/llist.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/llist.h b/include/linux/llist.h
index 85bda2d02d65..4181b34b557f 100644
--- a/include/linux/llist.h
+++ b/include/linux/llist.h
@@ -114,7 +114,7 @@ static inline void init_llist_head(struct llist_head *list)
  * reverse the order by yourself before traversing.
  */
 #define llist_for_each(pos, node)			\
-	for ((pos) = (node); pos; (pos) = (pos)->next)
+	for (pos = (node); pos; pos = (pos)->next)
 
 /**
  * llist_for_each_safe - iterate over some deleted entries of a lock-less list
@@ -133,7 +133,7 @@ static inline void init_llist_head(struct llist_head *list)
  * reverse the order by yourself before traversing.
  */
 #define llist_for_each_safe(pos, n, node)			\
-	for ((pos) = (node); (pos) && ((n) = (pos)->next, true); (pos) = (n))
+	for (pos = (node); (pos) && (n = (pos)->next, true); pos = (n))
 
 /**
  * llist_for_each_entry - iterate over some deleted entries of lock-less list of given type
@@ -151,9 +151,9 @@ static inline void init_llist_head(struct llist_head *list)
  * reverse the order by yourself before traversing.
  */
 #define llist_for_each_entry(pos, node, member)				\
-	for ((pos) = llist_entry((node), typeof(*(pos)), member);	\
+	for (pos = llist_entry(node, typeof(*(pos)), member);	\
 	     member_address_is_nonnull(pos, member);			\
-	     (pos) = llist_entry((pos)->member.next, typeof(*(pos)), member))
+	     pos = llist_entry((pos)->member.next, typeof(*(pos)), member))
 
 /**
  * llist_for_each_entry_safe - iterate over some deleted entries of lock-less list of given type
@@ -173,10 +173,10 @@ static inline void init_llist_head(struct llist_head *list)
  * reverse the order by yourself before traversing.
  */
 #define llist_for_each_entry_safe(pos, n, node, member)			       \
-	for (pos = llist_entry((node), typeof(*pos), member);		       \
+	for (pos = llist_entry(node, typeof(*(pos)), member);		       \
 	     member_address_is_nonnull(pos, member) &&			       \
-	        (n = llist_entry(pos->member.next, typeof(*n), member), true); \
-	     pos = n)
+		(n = llist_entry((pos)->member.next, typeof(*(n)), member), true); \
+	     pos = (n))
 
 /**
  * llist_empty - tests whether a lock-less list is empty
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88C516F62A7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 03:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjEDB3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 21:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjEDB30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 21:29:26 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D0E10E6;
        Wed,  3 May 2023 18:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1683163763;
        bh=W9zAZi8VwGgVLnwB1Kz05im9spQ0PM5+IFpjRSSrhRE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T42eYDhUFoBj8YmNOv1fempTX+rmzj0Kvxf1H0HbVMrqBzj9xxo4gQHtf/CuRapTS
         04p4EEjGMlIjD0hjdETsMjkhk7SUe+MtKiIgWDqLgXPcSH9ydsw3oJ2BgNGOlyEcRq
         ejvpyd1ZoSsoo+k+wYPFOkdRbG2zXBt9tUSrbwD820ewxxck7mM0jv9/ABCtL0rt0T
         iH81xezNZmomF+nSqlqibjIM8Dn1REJPeRsQu25xk9IMZcFo6fCCQo5Tez7Gxe9Cbc
         oI+3G8MePWonSe3mimYuvV6cPyij7BAaFnyb1EZbF/PdPtuWyM2QbTI2Hgr9yhhmAB
         tDDYa4vw0WCsw==
Received: from localhost.localdomain (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4QBbnv3vlyz11nL;
        Wed,  3 May 2023 21:29:23 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang1.zhang@intel.com>, rcu@vger.kernel.org
Subject: [RFC PATCH 3/4] rculist.h: Fix parentheses around macro pointer parameter use
Date:   Wed,  3 May 2023 21:29:13 -0400
Message-Id: <20230504012914.1797355-3-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230504012914.1797355-1-mathieu.desnoyers@efficios.com>
References: <20230504012914.1797355-1-mathieu.desnoyers@efficios.com>
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

          list_for_each_entry_rcu((*t2), &testlist, node) {       /* works */
                  //...
          }
          list_for_each_entry_rcu(*t2, &testlist, node) { /* broken */
                  //...
          }
  }

The typeof(*pos) lack of parentheses around "pos" is not an issue per se
in the specific macros modified here because "pos" is used as an lvalue,
which should prevent use of any operator causing issue. Still add the
extra parentheses for consistency.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Zqiang <qiang1.zhang@intel.com>
Cc: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 include/linux/rculist.h | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/include/linux/rculist.h b/include/linux/rculist.h
index d29740be4833..d27aeff5447d 100644
--- a/include/linux/rculist.h
+++ b/include/linux/rculist.h
@@ -388,9 +388,9 @@ static inline void list_splice_tail_init_rcu(struct list_head *list,
  */
 #define list_for_each_entry_rcu(pos, head, member, cond...)		\
 	for (__list_check_rcu(dummy, ## cond, 0),			\
-	     pos = list_entry_rcu((head)->next, typeof(*pos), member);	\
-		&pos->member != (head);					\
-		pos = list_entry_rcu(pos->member.next, typeof(*pos), member))
+	     pos = list_entry_rcu((head)->next, typeof(*(pos)), member);\
+		&(pos)->member != (head);				\
+		pos = list_entry_rcu((pos)->member.next, typeof(*(pos)), member))
 
 /**
  * list_for_each_entry_srcu	-	iterate over rcu list of given type
@@ -407,9 +407,9 @@ static inline void list_splice_tail_init_rcu(struct list_head *list,
  */
 #define list_for_each_entry_srcu(pos, head, member, cond)		\
 	for (__list_check_srcu(cond),					\
-	     pos = list_entry_rcu((head)->next, typeof(*pos), member);	\
-		&pos->member != (head);					\
-		pos = list_entry_rcu(pos->member.next, typeof(*pos), member))
+	     pos = list_entry_rcu((head)->next, typeof(*(pos)), member);\
+		&(pos)->member != (head);				\
+		pos = list_entry_rcu((pos)->member.next, typeof(*(pos)), member))
 
 /**
  * list_entry_lockless - get the struct for this entry
@@ -441,9 +441,9 @@ static inline void list_splice_tail_init_rcu(struct list_head *list,
  * but never deleted.
  */
 #define list_for_each_entry_lockless(pos, head, member) \
-	for (pos = list_entry_lockless((head)->next, typeof(*pos), member); \
-	     &pos->member != (head); \
-	     pos = list_entry_lockless(pos->member.next, typeof(*pos), member))
+	for (pos = list_entry_lockless((head)->next, typeof(*(pos)), member); \
+	     &(pos)->member != (head); \
+	     pos = list_entry_lockless((pos)->member.next, typeof(*(pos)), member))
 
 /**
  * list_for_each_entry_continue_rcu - continue iteration over list of given type
@@ -464,9 +464,9 @@ static inline void list_splice_tail_init_rcu(struct list_head *list,
  * position.
  */
 #define list_for_each_entry_continue_rcu(pos, head, member) 		\
-	for (pos = list_entry_rcu(pos->member.next, typeof(*pos), member); \
-	     &pos->member != (head);	\
-	     pos = list_entry_rcu(pos->member.next, typeof(*pos), member))
+	for (pos = list_entry_rcu((pos)->member.next, typeof(*(pos)), member); \
+	     &(pos)->member != (head);	\
+	     pos = list_entry_rcu((pos)->member.next, typeof(*(pos)), member))
 
 /**
  * list_for_each_entry_from_rcu - iterate over a list from current point
@@ -486,8 +486,8 @@ static inline void list_splice_tail_init_rcu(struct list_head *list,
  * after the given position.
  */
 #define list_for_each_entry_from_rcu(pos, head, member)			\
-	for (; &(pos)->member != (head);					\
-		pos = list_entry_rcu(pos->member.next, typeof(*(pos)), member))
+	for (; &(pos)->member != (head);				\
+		pos = list_entry_rcu((pos)->member.next, typeof(*(pos)), member))
 
 /**
  * hlist_del_rcu - deletes entry from hash list without re-initialization
-- 
2.25.1


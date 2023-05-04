Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A71A6F770B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 22:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbjEDUch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 16:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbjEDUcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 16:32:20 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9267E19434;
        Thu,  4 May 2023 13:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1683230733;
        bh=ZEKk2l+avXLFbsd5WjSG9znQ65K2KXiDXgyV8vZ7EJA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IfKCIjYQSXozgD4Wb+wSwBd+stdAcMsdT2i7VdXVhDqafbIW98tLuRfWIBLQZ+upQ
         5cHlYfTa3Xacv7BcJRQjH/KgIlprqL2os0yCC4v5U1jBnVjjzAOo8SbzbhlzvKzMbr
         xsgD+dGSe18n+gif1kzPhm7D/VrQEw+jlmdRLLTOHI+fz8FHAT+PohpHF2J7q1HDPH
         x2iH82MRkVPYP9LF5JDu/DNky5u5fcl2ZbUWmIH8cL3c6qvJNMbGCOILIGskgK9xjy
         OpOb1k8U26ecYsStldMJQXyZQUN/oCdD/EusL/yddPWCrmAcHo8IK1GDvFgkHgoSZ6
         9raHAvS4UD5rg==
Received: from localhost.localdomain (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4QC4Ym5dLWzxRJ;
        Thu,  4 May 2023 16:05:32 -0400 (EDT)
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
Subject: [RFC PATCH 04/13] rculist_bl.h: Fix parentheses around macro pointer parameter use
Date:   Thu,  4 May 2023 16:05:18 -0400
Message-Id: <20230504200527.1935944-5-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230504200527.1935944-1-mathieu.desnoyers@efficios.com>
References: <20230504200527.1935944-1-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing parentheses around use of macro argument "tpos" in those
patterns to ensure operator precedence behaves as expected:

- typeof(*tpos)
- pos->next
- x && y is changed for (x) && (y).

The typeof(*tpos) lack of parentheses around "tpos" is not an issue per se
in the specific macros modified here because "tpos" is used as an lvalue,
which should prevent use of any operator causing issue. Still add the
extra parentheses for consistency.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
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
---
 include/linux/rculist_bl.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/rculist_bl.h b/include/linux/rculist_bl.h
index 0b952d06eb0b..798c0a03bf5c 100644
--- a/include/linux/rculist_bl.h
+++ b/include/linux/rculist_bl.h
@@ -94,8 +94,8 @@ static inline void hlist_bl_add_head_rcu(struct hlist_bl_node *n,
  */
 #define hlist_bl_for_each_entry_rcu(tpos, pos, head, member)		\
 	for (pos = hlist_bl_first_rcu(head);				\
-		pos &&							\
-		({ tpos = hlist_bl_entry(pos, typeof(*tpos), member); 1; }); \
-		pos = rcu_dereference_raw(pos->next))
+		(pos) &&						\
+		({ tpos = hlist_bl_entry(pos, typeof(*(tpos)), member); 1; }); \
+		pos = rcu_dereference_raw((pos)->next))
 
 #endif
-- 
2.25.1


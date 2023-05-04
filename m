Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68F9C6F62A5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 03:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjEDB33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 21:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjEDB3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 21:29:25 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E1A10F1
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 18:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1683163763;
        bh=T39JG5jO81CkJSiSo/IvnzdNLETorvzXw2aS+hjSu+c=;
        h=From:To:Cc:Subject:Date:From;
        b=moiWwAj7t1bORbTueVEJdVtZHDLSrYjYRWg0Ya7ToKbnd4zYjD4MQcvoP2ek5IuNH
         0XoHK7zCvoLl8nO3YSELqXQB3PTJjAoX6vWGxbAOuVQZnjK0PuLBKekH2+whThoh59
         Oq8Xs+zkhzbfZ05Y1FZqLWjxox0B30XJytqjm430IDH/CqkdnVieSeinOlNLuow0Q9
         5QK767dGFzBup0rEo71gw1DLRifcWr6XmL9fAew0b7+yPZvGzyaJKGUIy2yC952HvY
         jA75/BB6gytAt2yrlrdGUvaTkq32a/ZGF5tgB6vDkJ4Q30qxbAmbWEsov3ITRAesGi
         xrzCn2QcLyXFA==
Received: from localhost.localdomain (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4QBbnv0Lflz11wY;
        Wed,  3 May 2023 21:29:23 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang1.zhang@intel.com>
Subject: [RFC PATCH 1/4] rcu: rcupdate.h: Add missing parentheses around macro pointer dereference
Date:   Wed,  3 May 2023 21:29:11 -0400
Message-Id: <20230504012914.1797355-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.25.1
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

linux/rcupdate.h macros use the *p parameter without parentheses, e.g.:

  typeof(*p)

rather than

  typeof(*(p))

The following test-case shows how it can generate confusion due to C
operator precedence being reversed compared to the expectations:

    #define m(p) \
    do { \
            __typeof__(*p) v = 0; \
    } while (0)

    void fct(unsigned long long *p1)
    {
            m(p1 + 1);      /* works */
            m(1 + p1);      /* broken */
    }

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Reviewed-by: Steven Rostedt <rostedt@goodmis.org>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Zqiang <qiang1.zhang@intel.com>
---
 include/linux/rcupdate.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index dcd2cf1e8326..38e84f3d515e 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -430,16 +430,16 @@ static inline void rcu_preempt_sleep_check(void) { }
 
 #ifdef __CHECKER__
 #define rcu_check_sparse(p, space) \
-	((void)(((typeof(*p) space *)p) == p))
+	((void)(((typeof(*(p)) space *)(p)) == (p)))
 #else /* #ifdef __CHECKER__ */
 #define rcu_check_sparse(p, space)
 #endif /* #else #ifdef __CHECKER__ */
 
 #define __unrcu_pointer(p, local)					\
 ({									\
-	typeof(*p) *local = (typeof(*p) *__force)(p);			\
+	typeof(*(p)) *local = (typeof(*(p)) *__force)(p);		\
 	rcu_check_sparse(p, __rcu);					\
-	((typeof(*p) __force __kernel *)(local)); 			\
+	((typeof(*(p)) __force __kernel *)(local));			\
 })
 /**
  * unrcu_pointer - mark a pointer as not being RCU protected
@@ -452,29 +452,29 @@ static inline void rcu_preempt_sleep_check(void) { }
 
 #define __rcu_access_pointer(p, local, space) \
 ({ \
-	typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
+	typeof(*(p)) *local = (typeof(*(p)) *__force)READ_ONCE(p); \
 	rcu_check_sparse(p, space); \
-	((typeof(*p) __force __kernel *)(local)); \
+	((typeof(*(p)) __force __kernel *)(local)); \
 })
 #define __rcu_dereference_check(p, local, c, space) \
 ({ \
 	/* Dependency order vs. p above. */ \
-	typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
+	typeof(*(p)) *local = (typeof(*(p)) *__force)READ_ONCE(p); \
 	RCU_LOCKDEP_WARN(!(c), "suspicious rcu_dereference_check() usage"); \
 	rcu_check_sparse(p, space); \
-	((typeof(*p) __force __kernel *)(local)); \
+	((typeof(*(p)) __force __kernel *)(local)); \
 })
 #define __rcu_dereference_protected(p, local, c, space) \
 ({ \
 	RCU_LOCKDEP_WARN(!(c), "suspicious rcu_dereference_protected() usage"); \
 	rcu_check_sparse(p, space); \
-	((typeof(*p) __force __kernel *)(p)); \
+	((typeof(*(p)) __force __kernel *)(p)); \
 })
 #define __rcu_dereference_raw(p, local) \
 ({ \
 	/* Dependency order vs. p above. */ \
 	typeof(p) local = READ_ONCE(p); \
-	((typeof(*p) __force __kernel *)(local)); \
+	((typeof(*(p)) __force __kernel *)(local)); \
 })
 #define rcu_dereference_raw(p) __rcu_dereference_raw(p, __UNIQUE_ID(rcu))
 
-- 
2.25.1


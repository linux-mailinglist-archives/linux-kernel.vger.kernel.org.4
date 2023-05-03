Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 950996F6017
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 22:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjECUct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 16:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjECUcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 16:32:47 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835E0198C
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 13:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1683145963;
        bh=qNB6O5mVECCPuKgtGErPGROmbcclghgZAShV5yBxuaI=;
        h=From:To:Cc:Subject:Date:From;
        b=no1YqwIX/6oqGAIE4BX0MFBH9H00tUF8S1a7Rp3ST8/qqgk+RD0qNCU6dUWy7Up55
         87HM522afz/NFXZUW+wWRlNHFRjoKu6wPtnzU8W79UU1ruLrptpAMrnXdurov8Afws
         FFpRaOOMVqHrc02dFUXt2s5GP+hlMfx04N+XtXde07EyDIH6yTeGgBnXFdjM7N/wc/
         55DXbnsj32SPXO9VdZdvQZimthqCMNyltnUfUgnUDBBCfb97PmVSZxxv9YUrX7MlBM
         5QfRdpBQl/XfS1NbqH06nNOOfAcdy8e16/fhC+MM0JURh+MeIxJ4MEUVjW2cJqaOek
         7akX+418JyjWg==
Received: from localhost.localdomain (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4QBTCb416Dz11fW;
        Wed,  3 May 2023 16:32:43 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang1.zhang@intel.com>
Subject: [RFC PATCH] rcu: rcupdate.h: Add missing parentheses around macro pointer dereference
Date:   Wed,  3 May 2023 16:32:36 -0400
Message-Id: <20230503203236.1587590-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.25.1
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
index dcd2cf1e8326..1565012fa47f 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -430,16 +430,16 @@ static inline void rcu_preempt_sleep_check(void) { }
 
 #ifdef __CHECKER__
 #define rcu_check_sparse(p, space) \
-	((void)(((typeof(*p) space *)p) == p))
+	((void)(((typeof(*(p)) space *)p) == p))
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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6A065E17B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 01:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240146AbjAEAXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 19:23:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235393AbjAEAXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 19:23:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA04044368;
        Wed,  4 Jan 2023 16:23:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3C677B81983;
        Thu,  5 Jan 2023 00:23:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3BD8C43392;
        Thu,  5 Jan 2023 00:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672878187;
        bh=hrYxt2M86I+YLxkqBWLEpmhGnP0U4qusfW3DVwJ922w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lO+DcO1DQJWobdC4TYtmZNiT4JyEMz7vzZ2AszirxPy8b3kCcyCawRA1PIcMj+mvo
         dsEttD17K3MEfR5RbFKzJAOXwCtFQeWRE9H9SQSiK+7E69bJolQxvUoX6La7NVx88E
         vgIJ53KJz/DFMFbSd+QbAUWujYZDqGr4oKmtBDyXoX0Ma1V7n/scnXiYsSu1ndyEBc
         uGqVzi9+Qwnx0cCJ2fXKlM41Hii2qNSKmCkaCE21nUsVUrIuWYwTxZMfuiJwrEssiv
         a3tCWnViVumHh4vfJpmZ+mAOQXumqEnmtK9MQc3Vw3f6BErUtyufnjg9Zm7m5+qQYc
         ACW0BZvV+6vAg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7BB955C149B; Wed,  4 Jan 2023 16:23:07 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH rcu 05/10] rcu: Make RCU_LOCKDEP_WARN() avoid early lockdep checks
Date:   Wed,  4 Jan 2023 16:23:00 -0800
Message-Id: <20230105002305.1768591-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20230105002257.GA1768487@paulmck-ThinkPad-P17-Gen-1>
References: <20230105002257.GA1768487@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, RCU_LOCKDEP_WARN() checks the condition before checking
to see if lockdep is still enabled.  This is necessary to avoid the
false-positive splats fixed by commit 3066820034b5dd ("rcu: Reject
RCU_LOCKDEP_WARN() false positives").  However, the current state can
result in false-positive splats during early boot before lockdep is fully
initialized.  This commit therefore checks debug_lockdep_rcu_enabled()
both before and after checking the condition, thus avoiding both sets
of false-positive error reports.

Reported-by: Steven Rostedt <rostedt@goodmis.org>
Reported-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Reported-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/rcupdate.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 03abf883a281b..aa86de01aab6d 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -374,11 +374,18 @@ static inline int debug_lockdep_rcu_enabled(void)
  * RCU_LOCKDEP_WARN - emit lockdep splat if specified condition is met
  * @c: condition to check
  * @s: informative message
+ *
+ * This checks debug_lockdep_rcu_enabled() before checking (c) to
+ * prevent early boot splats due to lockdep not yet being initialized,
+ * and rechecks it after checking (c) to prevent false-positive splats
+ * due to races with lockdep being disabled.  See commit 3066820034b5dd
+ * ("rcu: Reject RCU_LOCKDEP_WARN() false positives") for more detail.
  */
 #define RCU_LOCKDEP_WARN(c, s)						\
 	do {								\
 		static bool __section(".data.unlikely") __warned;	\
-		if ((c) && debug_lockdep_rcu_enabled() && !__warned) {	\
+		if (debug_lockdep_rcu_enabled() && (c) &&		\
+		    debug_lockdep_rcu_enabled() && !__warned) {		\
 			__warned = true;				\
 			lockdep_rcu_suspicious(__FILE__, __LINE__, s);	\
 		}							\
-- 
2.31.1.189.g2e36527f23


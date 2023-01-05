Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FEBC65E14A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 01:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234994AbjAEAKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 19:10:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231480AbjAEAJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 19:09:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8360543A1D;
        Wed,  4 Jan 2023 16:09:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C4A686185D;
        Thu,  5 Jan 2023 00:09:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28564C433F2;
        Thu,  5 Jan 2023 00:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672877397;
        bh=+AiKtda+llbq2fzplOX6DNXjkIDDWzakm6PNDaSoAkU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ceQcRjLOz/Rn8fggvDh6YDzDjjtD9/K2vNLtGKS2jDGfc5860/nLKqyseHDt1s8kK
         NH9Q/DncskK9gkJ3SPYPPdVFYM1ow0HSu/3hMJgs+HlxYXAUV0oMFCWqGPmLCFLrTk
         a1RNVUel2N2fdr7zWWVllDK7WKz9vw+RVNhBg402LouHogSDy4xzLLtH+jfiewsoNy
         VdrkOzbj0eZy4kA0Mn/t1rpUWe/4A2/Bvq/MEbLAV7FmffL9KBGU1MVx0AWSdZgQMg
         vnLogOaJuwGCc6iavccKwB76BCOMuqIGgShsxYyAD0V0aVP4zZd0vpcb+0re7fIEPJ
         6b2mJMEclNp2w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C9BF55C1456; Wed,  4 Jan 2023 16:09:56 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 04/15] doc: Update rcu_dereference.rst
Date:   Wed,  4 Jan 2023 16:09:44 -0800
Message-Id: <20230105000955.1767218-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20230105000945.GA1767128@paulmck-ThinkPad-P17-Gen-1>
References: <20230105000945.GA1767128@paulmck-ThinkPad-P17-Gen-1>
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

This commit updates rcu_dereference.rst to reflect RCU additions and
changes over the past few years

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/rcu_dereference.rst | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/Documentation/RCU/rcu_dereference.rst b/Documentation/RCU/rcu_dereference.rst
index 81e828c8313b8..3b739f6243c85 100644
--- a/Documentation/RCU/rcu_dereference.rst
+++ b/Documentation/RCU/rcu_dereference.rst
@@ -19,8 +19,9 @@ Follow these rules to keep your RCU code working properly:
 	can reload the value, and won't your code have fun with two
 	different values for a single pointer!  Without rcu_dereference(),
 	DEC Alpha can load a pointer, dereference that pointer, and
-	return data preceding initialization that preceded the store of
-	the pointer.
+	return data preceding initialization that preceded the store
+	of the pointer.  (As noted later, in recent kernels READ_ONCE()
+	also prevents DEC Alpha from playing these tricks.)
 
 	In addition, the volatile cast in rcu_dereference() prevents the
 	compiler from deducing the resulting pointer value.  Please see
@@ -34,7 +35,7 @@ Follow these rules to keep your RCU code working properly:
 	takes on the role of the lockless_dereference() primitive that
 	was removed in v4.15.
 
--	You are only permitted to use rcu_dereference on pointer values.
+-	You are only permitted to use rcu_dereference() on pointer values.
 	The compiler simply knows too much about integral values to
 	trust it to carry dependencies through integer operations.
 	There are a very few exceptions, namely that you can temporarily
@@ -240,6 +241,7 @@ precautions.  To see this, consider the following code fragment::
 		struct foo *q;
 		int r1, r2;
 
+		rcu_read_lock();
 		p = rcu_dereference(gp2);
 		if (p == NULL)
 			return;
@@ -248,7 +250,10 @@ precautions.  To see this, consider the following code fragment::
 		if (p == q) {
 			/* The compiler decides that q->c is same as p->c. */
 			r2 = p->c; /* Could get 44 on weakly order system. */
+		} else {
+			r2 = p->c - r1; /* Unconditional access to p->c. */
 		}
+		rcu_read_unlock();
 		do_something_with(r1, r2);
 	}
 
@@ -297,6 +302,7 @@ Then one approach is to use locking, for example, as follows::
 		struct foo *q;
 		int r1, r2;
 
+		rcu_read_lock();
 		p = rcu_dereference(gp2);
 		if (p == NULL)
 			return;
@@ -306,7 +312,12 @@ Then one approach is to use locking, for example, as follows::
 		if (p == q) {
 			/* The compiler decides that q->c is same as p->c. */
 			r2 = p->c; /* Locking guarantees r2 == 144. */
+		} else {
+			spin_lock(&q->lock);
+			r2 = q->c - r1;
+			spin_unlock(&q->lock);
 		}
+		rcu_read_unlock();
 		spin_unlock(&p->lock);
 		do_something_with(r1, r2);
 	}
@@ -364,7 +375,7 @@ the exact value of "p" even in the not-equals case.  This allows the
 compiler to make the return values independent of the load from "gp",
 in turn destroying the ordering between this load and the loads of the
 return values.  This can result in "p->b" returning pre-initialization
-garbage values.
+garbage values on weakly ordered systems.
 
 In short, rcu_dereference() is *not* optional when you are going to
 dereference the resulting pointer.
@@ -430,7 +441,7 @@ member of the rcu_dereference() to use in various situations:
 SPARSE CHECKING OF RCU-PROTECTED POINTERS
 -----------------------------------------
 
-The sparse static-analysis tool checks for direct access to RCU-protected
+The sparse static-analysis tool checks for non-RCU access to RCU-protected
 pointers, which can result in "interesting" bugs due to compiler
 optimizations involving invented loads and perhaps also load tearing.
 For example, suppose someone mistakenly does something like this::
-- 
2.31.1.189.g2e36527f23


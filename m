Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63DAE60534F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 00:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbiJSWpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 18:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbiJSWpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 18:45:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7823816E2A9;
        Wed, 19 Oct 2022 15:45:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA157619EE;
        Wed, 19 Oct 2022 22:45:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3667BC433C1;
        Wed, 19 Oct 2022 22:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666219537;
        bh=pV5mo9YkfwujPNnScLsSaaIUnNu98NTR9NAcopA4yPc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RHxjoTnrtsdRpptAneAFdyOGOthkGrCVlE4AusM/6sCSLj7z1vrFU5jsnIzwsCuGE
         ehfoX4T6Y2SsTujRWgaUMqN0wHYwAYlIjCyMZHfYNH2zpU2B6CNGzX/dIiWGjuDGWJ
         nE16T3qE5DRpazl9MpXSAo6Vv5ZJsgwavbma8fnEL9Mj2ssVVOcHXgvGkwnTJYzwC0
         75RNIpapAidL8yFZHXfKo80ejSxndZ9Xoc/LzPKRjpLrMhYGE5wzdhEkk2cB0UjRnn
         DYNcafypYAyzaFWbiU+AHqHtRmo2UKTINZ4buUJ+3Gaql0P34adoPdlgfln0hoEp+w
         qdBPM5b6Jixeg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E09B35C0920; Wed, 19 Oct 2022 15:45:36 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 4/4] doc: Update RCU's lockdep.rst
Date:   Wed, 19 Oct 2022 15:45:35 -0700
Message-Id: <20221019224535.2499245-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20221019224528.GA2499145@paulmck-ThinkPad-P17-Gen-1>
References: <20221019224528.GA2499145@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds a couple of new functions to the documentation.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/lockdep.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/RCU/lockdep.rst b/Documentation/RCU/lockdep.rst
index a94f55991a71c..9308f1bdba05d 100644
--- a/Documentation/RCU/lockdep.rst
+++ b/Documentation/RCU/lockdep.rst
@@ -17,7 +17,9 @@ state::
 	rcu_read_lock_held() for normal RCU.
 	rcu_read_lock_bh_held() for RCU-bh.
 	rcu_read_lock_sched_held() for RCU-sched.
+	rcu_read_lock_any_held() for any of normal RCU, RCU-bh, and RCU-sched.
 	srcu_read_lock_held() for SRCU.
+	rcu_read_lock_trace_held() for RCU Tasks Trace.
 
 These functions are conservative, and will therefore return 1 if they
 aren't certain (for example, if CONFIG_DEBUG_LOCK_ALLOC is not set).
@@ -53,6 +55,8 @@ checking of rcu_dereference() primitives:
 		is invoked by both SRCU readers and updaters.
 	rcu_dereference_raw(p):
 		Don't check.  (Use sparingly, if at all.)
+	rcu_dereference_raw_check(p):
+		Don't do lockdep at all.  (Use sparingly, if at all.)
 	rcu_dereference_protected(p, c):
 		Use explicit check expression "c", and omit all barriers
 		and compiler constraints.  This is useful when the data
-- 
2.31.1.189.g2e36527f23


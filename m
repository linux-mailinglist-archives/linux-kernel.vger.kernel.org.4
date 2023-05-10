Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD71A6FE301
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 19:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236451AbjEJRG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 13:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236367AbjEJRGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 13:06:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ABD6358C;
        Wed, 10 May 2023 10:06:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1FE75636DF;
        Wed, 10 May 2023 17:06:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F747C433EF;
        Wed, 10 May 2023 17:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683738370;
        bh=kQwhUcHnUV1oB8K+SYCdQwdWT6mtPz7OHiOwXCmWFXs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Anbm9VOAYtEtoX7qGLRyHb8ln3njJ14N8ou716QX9jLtd0EpbHyNlc2Ij8OpNmEPC
         JfpGlBBiSXXmTdoJMZpLaSTmod4JNdZFsA1Ok2UZhRgVbN2DRHUNBj9fNr0kb3KYg9
         i3Csz5mZgQ5uogU9/JBg3+gQp/LAULludnnBBF6OSjDCl8M92XV9w//2ZWovyGFt3o
         STHmsrW6Cq2+bTeTAQE95svezqRBeyWRELebPS1TNyPVnLK0MIkhw/nM5Jc0nrszke
         9Vcc7J+uTIlgoKD7UFBqjIq3UCbr9XwsW4kqeqd6NFM9hjW6Qpa4tOLLlpNCgnFjlz
         PkGcd1uMMKl5A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 2BB0ECE126E; Wed, 10 May 2023 10:06:10 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 1/4] rcu/nocb: Protect lazy shrinker against concurrent (de-)offloading
Date:   Wed, 10 May 2023 10:06:04 -0700
Message-Id: <20230510170607.2187978-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <9c5fae22-e25e-4548-b6e9-117495b29e62@paulmck-laptop>
References: <9c5fae22-e25e-4548-b6e9-117495b29e62@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frederic Weisbecker <frederic@kernel.org>

The shrinker may run concurrently with callbacks (de-)offloading. As
such, calling rcu_nocb_lock() is very dangerous because it does a
conditional locking. The worst outcome is that rcu_nocb_lock() doesn't
lock but rcu_nocb_unlock() eventually unlocks, or the reverse, creating
an imbalance.

Fix this with protecting against (de-)offloading using the barrier mutex.
Although if the barrier mutex is contended, which should be rare, then
step aside so as not to trigger a mutex VS allocation
dependency chain.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_nocb.h | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index f2280616f9d5..1a86883902ce 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1336,13 +1336,33 @@ lazy_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
 	unsigned long flags;
 	unsigned long count = 0;
 
+	/*
+	 * Protect against concurrent (de-)offloading. Otherwise nocb locking
+	 * may be ignored or imbalanced.
+	 */
+	if (!mutex_trylock(&rcu_state.barrier_mutex)) {
+		/*
+		 * But really don't insist if barrier_mutex is contended since we
+		 * can't guarantee that it will never engage in a dependency
+		 * chain involving memory allocation. The lock is seldom contended
+		 * anyway.
+		 */
+		return 0;
+	}
+
 	/* Snapshot count of all CPUs */
 	for_each_possible_cpu(cpu) {
 		struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
-		int _count = READ_ONCE(rdp->lazy_len);
+		int _count;
+
+		if (!rcu_rdp_is_offloaded(rdp))
+			continue;
+
+		_count = READ_ONCE(rdp->lazy_len);
 
 		if (_count == 0)
 			continue;
+
 		rcu_nocb_lock_irqsave(rdp, flags);
 		WRITE_ONCE(rdp->lazy_len, 0);
 		rcu_nocb_unlock_irqrestore(rdp, flags);
@@ -1352,6 +1372,9 @@ lazy_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
 		if (sc->nr_to_scan <= 0)
 			break;
 	}
+
+	mutex_unlock(&rcu_state.barrier_mutex);
+
 	return count ? count : SHRINK_STOP;
 }
 
-- 
2.40.1


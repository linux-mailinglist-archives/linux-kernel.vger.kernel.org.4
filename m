Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD336CEE98
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 18:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjC2QEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 12:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbjC2QEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 12:04:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF252558E;
        Wed, 29 Mar 2023 09:03:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F88461DAA;
        Wed, 29 Mar 2023 16:02:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFC75C4339C;
        Wed, 29 Mar 2023 16:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680105735;
        bh=+h4XK6+UI6FKKHszmm1wj9jmGuHr+bG0mxcM6PK0eo8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=We6SppzsOzlK2//1daxu59Df7ANxDJyMznwP+OkNrFmQmFcLdYSH8atr1ezJd2MQj
         WGhWJt5bkH3VrhROVfbJh02EKGkS4HvFe7yGH7qz1L3O1hPSNGdLY0xegZuyYPbhO4
         HFJ39S8in9KjgKsomrNfCm6kkGsr3ndqR6XGOtnZzBDu5NF8SysXHICJOoLTeTUZlf
         t8uQZIL7RyPCnaGpbfjU1TLNYO2Hj0+jgz4c93W2sJu3rtVZTMLioZzU+iPZjGmRfC
         D6tzE56MJESRUNbCdPEERhTIsa0krSKTMJRV4SDPnbDJ+cY+nwa+73GhrVeGcZadG2
         6mVRYA++CYdug==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        rcu <rcu@vger.kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 3/4] rcu/nocb: Recheck lazy callbacks under the ->nocb_lock from shrinker
Date:   Wed, 29 Mar 2023 18:02:02 +0200
Message-Id: <20230329160203.191380-4-frederic@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230329160203.191380-1-frederic@kernel.org>
References: <20230329160203.191380-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ->lazy_len is only checked locklessly. Recheck again under the
->nocb_lock to avoid spending more time on flushing/waking if not
necessary. The ->lazy_len can still increment concurrently (from 1 to
infinity) but under the ->nocb_lock we at least know for sure if there
are lazy callbacks at all (->lazy_len > 0).

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tree_nocb.h | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index c321fce2af8e..dfa9c10d6727 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1358,12 +1358,20 @@ lazy_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
 		if (!rcu_rdp_is_offloaded(rdp))
 			continue;
 
+		if (!READ_ONCE(rdp->lazy_len))
+			continue;
+
+		rcu_nocb_lock_irqsave(rdp, flags);
+		/*
+		 * Recheck under the nocb lock. Since we are not holding the bypass
+		 * lock we may still race with increments from the enqueuer but still
+		 * we know for sure if there is at least one lazy callback.
+		 */
 		_count = READ_ONCE(rdp->lazy_len);
-
-		if (_count == 0)
+		if (!_count) {
+			rcu_nocb_unlock_irqrestore(rdp, flags);
 			continue;
-
-		rcu_nocb_lock_irqsave(rdp, flags);
+		}
 		WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies, false));
 		rcu_nocb_unlock_irqrestore(rdp, flags);
 		wake_nocb_gp(rdp, false);
-- 
2.34.1


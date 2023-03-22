Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA6596C5527
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 20:45:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbjCVTp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 15:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbjCVTpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 15:45:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE7ED32CEB;
        Wed, 22 Mar 2023 12:45:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7BD9A622B1;
        Wed, 22 Mar 2023 19:45:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B7CDC4339B;
        Wed, 22 Mar 2023 19:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679514310;
        bh=mP8fCieTmDyHtxHWglNueIzXLMyc5wglCPH3QTQMCKk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z4SeTifBUVRdEuhbIjeDAFkhZN28kaeoNGLv044rupmYaop8EMvGXNg2ZnWWILzay
         0/ndpYG1LRNCIps3ZYm+OjblNQ2Jx0Z3xyIAkpKvkR1m1tRxv8P7j1HqZY7LEGGRy1
         X0ePCHGOVygrJy6zx3cr2agJePWejOCbV1uAqk+a8eH1knyQ1aUreHgnlv+jkpKuci
         KXqPE/9qDyKZR1ZiG2tgroIW0BCGzx+YdpgkmPLqfpoduP4LSHPPzwj0YANEhzCJeA
         z1vOPQ5UwH7MIwmZQr92YILDBs0gB2vgKDgl5LGO7A2ob8JooFjAcnOmAIp+xfTlVy
         KBFcXUO9lpmjA==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        rcu <rcu@vger.kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 3/4] rcu/nocb: Recheck lazy callbacks under the ->nocb_lock from shrinker
Date:   Wed, 22 Mar 2023 20:44:55 +0100
Message-Id: <20230322194456.2331527-4-frederic@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230322194456.2331527-1-frederic@kernel.org>
References: <20230322194456.2331527-1-frederic@kernel.org>
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
index cb57e8312231..a3dc7465b0b2 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1350,12 +1350,20 @@ lazy_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
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


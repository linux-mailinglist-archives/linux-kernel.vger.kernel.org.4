Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1D6717D0A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 12:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235867AbjEaKSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 06:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235400AbjEaKRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 06:17:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12699134;
        Wed, 31 May 2023 03:17:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 94FB860EFE;
        Wed, 31 May 2023 10:17:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB99EC4339C;
        Wed, 31 May 2023 10:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685528270;
        bh=DNw6SN2JUww7kf2Xz6WH9RgMFZWQt8aiAF4n3naxZ8k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K++9WA8Zkr7l786Wuf62fwfUApIVGQi01biW6e8wGwQHBKgrpQAKkzLRVNJ9FJFEb
         6q65BxMPjwToVuIYiLjc0tsamZrX2LVeun2tYJtaXb1oIs4VZ8f5zNynUVKIFo9Wzf
         7Jp3q2wWzb5lwsh8j8K1CD0ggFseQ83QSaFCPehYErbXWv0Yt9ZbL3UfGolFiebYxL
         vwQS/eSA+ngbVol48R179tOYHhEdlXk0rd5tGNlytVY1fbLl6TGPabqkXjSJASlMwr
         +nWW1+WF/4o4WreAbpmiay1sUBGK2cZsdmmmneQyDHfkZLVJYvUejCepARivd4PRwJ
         52LgxlEAwMn/w==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        rcu <rcu@vger.kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>
Subject: [PATCH 1/9] rcu: Assume IRQS disabled from rcu_report_dead()
Date:   Wed, 31 May 2023 12:17:28 +0200
Message-Id: <20230531101736.12981-2-frederic@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230531101736.12981-1-frederic@kernel.org>
References: <20230531101736.12981-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rcu_report_dead() is the last RCU word from the CPU down through the
hotplug path. It is called in the idle loop right before the CPU shuts
down for good. Because it removes the CPU from the grace period state
machine and reports an ultimate quiescent state if necessary, no further
use of RCU is allowed. Therefore it is expected that IRQs are disabled
upon calling this function and are not to be re-enabled again until the
CPU shuts down.

Remove the IRQs disablement from that function and verify instead that
it is actually called with IRQs disabled as it is expected at that
special point in the idle path.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tree.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index fae9b4e29c93..bc4e7c9b51cb 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4476,11 +4476,16 @@ void rcu_cpu_starting(unsigned int cpu)
  */
 void rcu_report_dead(unsigned int cpu)
 {
-	unsigned long flags, seq_flags;
+	unsigned long flags;
 	unsigned long mask;
 	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
 	struct rcu_node *rnp = rdp->mynode;  /* Outgoing CPU's rdp & rnp. */
 
+	/*
+	 * IRQS must be disabled from now on and until the CPU dies, or an interrupt
+	 * may introduce a new READ-side while it is actually off the QS masks.
+	 */
+	lockdep_assert_irqs_disabled();
 	// Do any dangling deferred wakeups.
 	do_nocb_deferred_wakeup(rdp);
 
@@ -4488,7 +4493,6 @@ void rcu_report_dead(unsigned int cpu)
 
 	/* Remove outgoing CPU from mask in the leaf rcu_node structure. */
 	mask = rdp->grpmask;
-	local_irq_save(seq_flags);
 	arch_spin_lock(&rcu_state.ofl_lock);
 	raw_spin_lock_irqsave_rcu_node(rnp, flags); /* Enforce GP memory-order guarantee. */
 	rdp->rcu_ofl_gp_seq = READ_ONCE(rcu_state.gp_seq);
@@ -4502,8 +4506,6 @@ void rcu_report_dead(unsigned int cpu)
 	WRITE_ONCE(rnp->qsmaskinitnext, rnp->qsmaskinitnext & ~mask);
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 	arch_spin_unlock(&rcu_state.ofl_lock);
-	local_irq_restore(seq_flags);
-
 	rdp->cpu_started = false;
 }
 
-- 
2.40.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0C56FE2DC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 18:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236153AbjEJQ6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 12:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236057AbjEJQ6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 12:58:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D20035A9;
        Wed, 10 May 2023 09:58:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F3F363F51;
        Wed, 10 May 2023 16:58:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AF5FC433A4;
        Wed, 10 May 2023 16:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683737914;
        bh=uNamI0jeV30aO15+YqMLedWVb3YyLF5CZ+DX3DeiM/8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TCfVPN/uCdKj5sO95xFJZhTLccdk99nLvQzoYglN/gBpmK/C7h12YjMim6mufWv04
         wNBGbuPMWIIQaxKzz3SmVD2PUf1xZMEwJy+n+HVZTITmy+f+iSpDJfiC+dKQk5a8Jo
         vJNTqPyxNZKFq3VULjT9pymdIyltTp77pUEffB2Vgw+GPNw6FLwz3Qyb/B/tdwipMq
         7p3KqswaQAuk5QNkaNATaXPsr6xP4uE1za5xKCgM3FjEOZY9x1y8gI/Qna2Ohl5pwl
         Ft0fpcJRB+iEsNGjWcjOm7dz8VN0FMPsCjfpk99ny8VsShhHIoR9KaxAefelnY+JSR
         ZM2JNBf/TcEIA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 967FCCE1349; Wed, 10 May 2023 09:58:33 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 7/8] rcu: Make rcu_cpu_starting() rely on interrupts being disabled
Date:   Wed, 10 May 2023 09:58:31 -0700
Message-Id: <20230510165832.2187453-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cb50897b-1153-4958-8132-f0366667b3a4@paulmck-laptop>
References: <cb50897b-1153-4958-8132-f0366667b3a4@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, rcu_cpu_starting() is written so that it might be invoked
with interrupts enabled.  However, it is always called when interrupts
are disabled, either by rcu_init(), notify_cpu_starting(), or from a
call point prior to the call to notify_cpu_starting().

But why bother requiring that interrupts be disabled?  The purpose is
to allow the rcu_data structure's ->beenonline flag to be set after all
early processing has completed for the incoming CPU, thus allowing this
flag to be used to determine when workqueues have been set up for the
incoming CPU, while still allowing this flag to be used as a diagnostic
within rcu_core().

This commit therefore makes rcu_cpu_starting() rely on interrupts being
disabled.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index faa1c01d2917..23685407dcf6 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4390,15 +4390,16 @@ int rcutree_offline_cpu(unsigned int cpu)
  * Note that this function is special in that it is invoked directly
  * from the incoming CPU rather than from the cpuhp_step mechanism.
  * This is because this function must be invoked at a precise location.
+ * This incoming CPU must not have enabled interrupts yet.
  */
 void rcu_cpu_starting(unsigned int cpu)
 {
-	unsigned long flags;
 	unsigned long mask;
 	struct rcu_data *rdp;
 	struct rcu_node *rnp;
 	bool newcpu;
 
+	lockdep_assert_irqs_disabled();
 	rdp = per_cpu_ptr(&rcu_data, cpu);
 	if (rdp->cpu_started)
 		return;
@@ -4406,7 +4407,6 @@ void rcu_cpu_starting(unsigned int cpu)
 
 	rnp = rdp->mynode;
 	mask = rdp->grpmask;
-	local_irq_save(flags);
 	arch_spin_lock(&rcu_state.ofl_lock);
 	rcu_dynticks_eqs_online();
 	raw_spin_lock(&rcu_state.barrier_lock);
@@ -4425,17 +4425,16 @@ void rcu_cpu_starting(unsigned int cpu)
 	/* An incoming CPU should never be blocking a grace period. */
 	if (WARN_ON_ONCE(rnp->qsmask & mask)) { /* RCU waiting on incoming CPU? */
 		/* rcu_report_qs_rnp() *really* wants some flags to restore */
-		unsigned long flags2;
+		unsigned long flags;
 
-		local_irq_save(flags2);
+		local_irq_save(flags);
 		rcu_disable_urgency_upon_qs(rdp);
 		/* Report QS -after- changing ->qsmaskinitnext! */
-		rcu_report_qs_rnp(mask, rnp, rnp->gp_seq, flags2);
+		rcu_report_qs_rnp(mask, rnp, rnp->gp_seq, flags);
 	} else {
 		raw_spin_unlock_rcu_node(rnp);
 	}
 	arch_spin_unlock(&rcu_state.ofl_lock);
-	local_irq_restore(flags);
 	smp_mb(); /* Ensure RCU read-side usage follows above initialization. */
 }
 
-- 
2.40.1


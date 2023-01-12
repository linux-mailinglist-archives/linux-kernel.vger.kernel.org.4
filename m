Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4938C667EE2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 20:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234111AbjALTTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 14:19:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240122AbjALTSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 14:18:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6519E3BEA2;
        Thu, 12 Jan 2023 11:06:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 73E216213D;
        Thu, 12 Jan 2023 19:06:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA799C433EF;
        Thu, 12 Jan 2023 19:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673550416;
        bh=L6td8u37p3/93Vuok87y1k2WME9s+yPEFii+VbI0kWY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=fNbtgLyQO2odHeu/Alfe4ScVq9Fos9OnyoRZGi/2ETCntIj/JDNqs9aQDepQj+wvK
         cWzEuRGLQ17iqJ6pKlnFnqA4pM5ehRgzJc0IYTvohW0Or7GOp3o29oL25PBGsIB8Oj
         qLrKh70TmNZnwyW6UvRwn2H2AhpzMtFllmPxghXFzNzaqlELsxZguD7cril3x8ys4Z
         xCOnj/A3ZOXuqAx3WDnP+Gpi7l7q0K5RDMYvHveEM/dVkj39Ds+n7VWt0P/Otr1IvZ
         6RopgcW/ZC741pQk5rdh0KeOMnJsdZxAZ9U9BQnD76k/8LgfwKQ0EIBdikCwhp+isK
         LCOJxoTUuUmLQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 6820B5C0AF8; Thu, 12 Jan 2023 11:06:56 -0800 (PST)
Date:   Thu, 12 Jan 2023 11:06:56 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rcu: Fix the start_poll_synchronize_rcu_expedited()
 be invoked very early
Message-ID: <20230112190656.GR4028633@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230112075629.1661429-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230112075629.1661429-1-qiang1.zhang@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 03:56:29PM +0800, Zqiang wrote:
> Currently, the start_poll_synchronize_rcu_expedited() can be invoked
> very early. before rcu_init(), the rcu_data structure's->mynode is not
> initialized, if invoke start_poll_synchronize_rcu_expedited() before
> rcu_init(), will trigger a null rcu_node structure's->exp_seq_poll access.
> 
> This commit add boot_exp_seq_poll_rq member to rcu_state structure to
> store seq number return by invoke start_poll_synchronize_rcu_expedited()
> very early.
> 
> Fixes: d96c52fe4907 ("rcu: Add polled expedited grace-period primitives")
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>

First off, excellent catch, Zqiang!!!

And thank you for Frederic and Joel for your reviews.

But I believe that this can be simplified, for example, as shown in
the (untested) patch below.

Thoughts?

And yes, I did presumptuously add Frederic's and Joel's reviews.
Please let me know if you disagree, and if so what different approach
you would prefer.  (Though of course simple disagreement is sufficient
for me to remove your tag.  Not holding you hostage for improvements,
not yet, anyway!)

							Thanx, Paul

------------------------------------------------------------------------

commit e05af5cb3858e669c9e6b70e0aca708cc70457da
Author: Zqiang <qiang1.zhang@intel.com>
Date:   Thu Jan 12 10:48:29 2023 -0800

    rcu: Permit start_poll_synchronize_rcu_expedited() to be invoked early
    
    According to the commit log of the patch that added it to the kernel,
    start_poll_synchronize_rcu_expedited() can be invoked very early, as
    in long before rcu_init() has been invoked.  But before rcu_init(),
    the rcu_data structure's ->mynode field has not yet been initialized.
    This means that the start_poll_synchronize_rcu_expedited() function's
    attempt to set the CPU's leaf rcu_node structure's ->exp_seq_poll_rq
    field will result in a segmentation fault.
    
    This commit therefore causes start_poll_synchronize_rcu_expedited() to
    set ->exp_seq_poll_rq only after rcu_init() has initialized all CPUs'
    rcu_data structures' ->mynode fields.  It also removes the check from
    the rcu_init() function so that start_poll_synchronize_rcu_expedited(
    is unconditionally invoked.  Yes, this might result in an unnecessary
    boot-time grace period, but this is down in the noise.  Besides, there
    only has to be one call_rcu() invoked prior to scheduler initialization
    to make this boot-time grace period necessary.
    
    Signed-off-by: Zqiang <qiang1.zhang@intel.com>
    Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
    Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 63545d79da51c..f2e3a23778c06 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4937,9 +4937,8 @@ void __init rcu_init(void)
 	else
 		qovld_calc = qovld;
 
-	// Kick-start any polled grace periods that started early.
-	if (!(per_cpu_ptr(&rcu_data, cpu)->mynode->exp_seq_poll_rq & 0x1))
-		(void)start_poll_synchronize_rcu_expedited();
+	// Kick-start in case any polled grace periods started early.
+	(void)start_poll_synchronize_rcu_expedited();
 
 	rcu_test_sync_prims();
 }
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 956cd459ba7f3..3b7abb58157df 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -1068,9 +1068,10 @@ unsigned long start_poll_synchronize_rcu_expedited(void)
 	if (rcu_init_invoked())
 		raw_spin_lock_irqsave(&rnp->exp_poll_lock, flags);
 	if (!poll_state_synchronize_rcu(s)) {
-		rnp->exp_seq_poll_rq = s;
-		if (rcu_init_invoked())
+		if (rcu_init_invoked()) {
+			rnp->exp_seq_poll_rq = s;
 			queue_work(rcu_gp_wq, &rnp->exp_poll_wq);
+		}
 	}
 	if (rcu_init_invoked())
 		raw_spin_unlock_irqrestore(&rnp->exp_poll_lock, flags);

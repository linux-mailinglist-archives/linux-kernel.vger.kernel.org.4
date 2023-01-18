Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11637672650
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 19:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbjARSIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 13:08:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbjARSHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 13:07:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E92956EEC;
        Wed, 18 Jan 2023 10:07:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 207A4B81C66;
        Wed, 18 Jan 2023 18:07:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1BB8C433D2;
        Wed, 18 Jan 2023 18:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674065234;
        bh=ASgMJN11LRkZcvhH2vNd49vPSeWr47r6GOPKrQfkOMg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=mE687v8Zu+Uw01zoSDV+x0Nf0erR6F+JaF83WrhBGZu6qHHb0O2IDsV0yDUNoDkXg
         Q5Zo0/SMOdGD4O6XTpUodtnWMAWTiIdsdssPghBC4UOKhdRpjFXlxYjg1wsPiFoIIL
         453JlqpAV5Rh5PZEMQGj8JtWiS+aExwaGff9N3UBCDlcv7G001nawxo+g8IyUQo9TJ
         JpAgzlRl8sHyExpXBaEnNx8RdlZ0KzRu0BpTCVqMf/rjHQsBDIlnyP0WZKuCCjS8oH
         fyR4x3HkSJyUdi29EhFhf5oiYTFFooGymHpVYqk6neT9lVIYxWUTC7kE9fuNGeclhj
         AKsY1ibf+wxzQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 587BD5C0920; Wed, 18 Jan 2023 10:07:14 -0800 (PST)
Date:   Wed, 18 Jan 2023 10:07:14 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] rcu: Remove impossible wakeup rcu GP kthread action
 from rcu_report_qs_rdp()
Message-ID: <20230118180714.GD2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230118073014.2020743-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118073014.2020743-1-qiang1.zhang@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 03:30:14PM +0800, Zqiang wrote:
> When inovke rcu_report_qs_rdp(), if current CPU's rcu_data structure's ->
> grpmask has not been cleared from the corresponding rcu_node structure's
> ->qsmask, after that will clear and report quiescent state, but in this
> time, this also means that current grace period is not end, the current
> grace period is ongoing, because the rcu_gp_in_progress() currently return
> true, so for non-offloaded rdp, invoke rcu_accelerate_cbs() is impossible
> to return true.
> 
> This commit therefore remove impossible rcu_gp_kthread_wake() calling.
> 
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

Queued (wordsmithed as shown below, as always, please check) for further
testing and review, thank you both!

							Thanx, Paul

------------------------------------------------------------------------

commit fbe3e300ec8b3edd2b8f84dab4dc98947cf71eb8
Author: Zqiang <qiang1.zhang@intel.com>
Date:   Wed Jan 18 15:30:14 2023 +0800

    rcu: Remove never-set needwake assignment from rcu_report_qs_rdp()
    
    The rcu_accelerate_cbs() function is invoked by rcu_report_qs_rdp()
    only if there is a grace period in progress that is still blocked
    by at least one CPU on this rcu_node structure.  This means that
    rcu_accelerate_cbs() should never return the value true, and thus that
    this function should never set the needwake variable and in turn never
    invoke rcu_gp_kthread_wake().
    
    This commit therefore removes the needwake variable and the invocation
    of rcu_gp_kthread_wake() in favor of a WARN_ON_ONCE() on the call to
    rcu_accelerate_cbs().  The purpose of this new WARN_ON_ONCE() is to
    detect situations where the system's opinion differs from ours.
    
    Signed-off-by: Zqiang <qiang1.zhang@intel.com>
    Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index b2c2045294780..7a3085ad0a7df 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1956,7 +1956,6 @@ rcu_report_qs_rdp(struct rcu_data *rdp)
 {
 	unsigned long flags;
 	unsigned long mask;
-	bool needwake = false;
 	bool needacc = false;
 	struct rcu_node *rnp;
 
@@ -1988,7 +1987,12 @@ rcu_report_qs_rdp(struct rcu_data *rdp)
 		 * NOCB kthreads have their own way to deal with that...
 		 */
 		if (!rcu_rdp_is_offloaded(rdp)) {
-			needwake = rcu_accelerate_cbs(rnp, rdp);
+			/*
+			 * The current GP has not yet ended, so it
+			 * should not be possible for rcu_accelerate_cbs()
+			 * to return true.  So complain, but don't awaken.
+			 */
+			WARN_ON_ONCE(rcu_accelerate_cbs(rnp, rdp));
 		} else if (!rcu_segcblist_completely_offloaded(&rdp->cblist)) {
 			/*
 			 * ...but NOCB kthreads may miss or delay callbacks acceleration
@@ -2000,8 +2004,6 @@ rcu_report_qs_rdp(struct rcu_data *rdp)
 		rcu_disable_urgency_upon_qs(rdp);
 		rcu_report_qs_rnp(mask, rnp, rnp->gp_seq, flags);
 		/* ^^^ Released rnp->lock */
-		if (needwake)
-			rcu_gp_kthread_wake();
 
 		if (needacc) {
 			rcu_nocb_lock_irqsave(rdp, flags);

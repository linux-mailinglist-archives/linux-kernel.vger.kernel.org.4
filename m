Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5A44669C7D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 16:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjAMPek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 10:34:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjAMPeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 10:34:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08EB39B281;
        Fri, 13 Jan 2023 07:27:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EBD12B8212E;
        Fri, 13 Jan 2023 15:27:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CA7AC433EF;
        Fri, 13 Jan 2023 15:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673623653;
        bh=mdjjde/kpGhKz7LWQy4Ha4KJulKpEmB/IfM4LXUBeF8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ZOy91bzf8j+p7kuD/QdLpI/BRf8Ov+HaJmoNbgd1BIPqdKVYjAyqpFdKsBjx660nS
         894QZSriFopWyVtoQxIDNcKuaNdDLXwpAY8LJP/H1CUqs9lDjDnvtCrBxV0EKdHa1l
         Xh9GQhh83MYfUCioCwHdlsybkUKDVZY5rLusl6CtXAuRDHNW9vxOXzVzt1poxbM+kN
         BeevhEBmWFEaQJCjDw6J6Afv/1y0/fEE1M4yoM1A+YCmG/NAmLOEUJbegY56WUMgRY
         mcgQai03dVt7lr/PfaPfCHBiV07HqIp0oIitFEpZU4lYDM+IOGc8wrrhModu/RzUBd
         Dw8q47b8VF2fw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 1FF1B5C0964; Fri, 13 Jan 2023 07:27:33 -0800 (PST)
Date:   Fri, 13 Jan 2023 07:27:33 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>
Cc:     "frederic@kernel.org" <frederic@kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] rcu: Fix the start_poll_synchronize_rcu_expedited()
 be invoked very early
Message-ID: <20230113152733.GZ4028633@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230112075629.1661429-1-qiang1.zhang@intel.com>
 <20230112190656.GR4028633@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB588074A87AC454A7F0E42A5ADAC29@PH0PR11MB5880.namprd11.prod.outlook.com>
 <PH0PR11MB588008A9BBAFA6BEEC8685ABDAC29@PH0PR11MB5880.namprd11.prod.outlook.com>
 <20230113144919.GY4028633@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB588004418C299781FE6738BFDAC29@PH0PR11MB5880.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PH0PR11MB588004418C299781FE6738BFDAC29@PH0PR11MB5880.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 03:02:54PM +0000, Zhang, Qiang1 wrote:
> On Fri, Jan 13, 2023 at 12:10:47PM +0000, Zhang, Qiang1 wrote:
> > 
> > > Currently, the start_poll_synchronize_rcu_expedited() can be invoked
> > > very early. before rcu_init(), the rcu_data structure's->mynode is not
> > > initialized, if invoke start_poll_synchronize_rcu_expedited() before
> > > rcu_init(), will trigger a null rcu_node structure's->exp_seq_poll access.
> > > 
> > > This commit add boot_exp_seq_poll_rq member to rcu_state structure to
> > > store seq number return by invoke start_poll_synchronize_rcu_expedited()
> > > very early.
> > > 
> > > Fixes: d96c52fe4907 ("rcu: Add polled expedited grace-period primitives")
> > > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> > >
> > >First off, excellent catch, Zqiang!!!
> > >
> > >And thank you for Frederic and Joel for your reviews.
> > >	
> > >But I believe that this can be simplified, for example, as shown in
> > >the (untested) patch below.
> > >
> > >Thoughts?
> > >
> > >Agree, thanks for wordsmithed  😊.
> > >
> > >
> > >And yes, I did presumptuously add Frederic's and Joel's reviews.
> > >Please let me know if you disagree, and if so what different approach
> > >you would prefer.  (Though of course simple disagreement is sufficient
> > >for me to remove your tag.  Not holding you hostage for improvements,
> > >not yet, anyway!)
> > >
> > >							Thanx, Paul
> > >
> > >------------------------------------------------------------------------
> > >
> > >commit e05af5cb3858e669c9e6b70e0aca708cc70457da
> > >Author: Zqiang <qiang1.zhang@intel.com>
> > >Date:   Thu Jan 12 10:48:29 2023 -0800
> > >
> > >    rcu: Permit start_poll_synchronize_rcu_expedited() to be invoked early
> > >    
> > >    According to the commit log of the patch that added it to the kernel,
> > >    start_poll_synchronize_rcu_expedited() can be invoked very early, as
> > >    in long before rcu_init() has been invoked.  But before rcu_init(),
> > >    the rcu_data structure's ->mynode field has not yet been initialized.
> > >    This means that the start_poll_synchronize_rcu_expedited() function's
> > >    attempt to set the CPU's leaf rcu_node structure's ->exp_seq_poll_rq
> > >    field will result in a segmentation fault.
> > >    
> > >    This commit therefore causes start_poll_synchronize_rcu_expedited() to
> > >    set ->exp_seq_poll_rq only after rcu_init() has initialized all CPUs'
> > >    rcu_data structures' ->mynode fields.  It also removes the check from
> > >    the rcu_init() function so that start_poll_synchronize_rcu_expedited(
> > >    is unconditionally invoked.  Yes, this might result in an unnecessary
> > >    boot-time grace period, but this is down in the noise.  Besides, there
> > >    only has to be one call_rcu() invoked prior to scheduler initialization
> > >    to make this boot-time grace period necessary.
> > 
> > A little confused, why  call_rcu() invoked prior to scheduler initialization to make this boot-time
> > grace period necessary 😊?
> >
> >Because then there will be a callback queued that will require a grace
> >period to run anyway.
> >
> >Or maybe you are asking if those callbacks will really be able to use
> >that first grace period?
> 
> Yes, because even if we queue work to rcu_gp_wq workqueue, this also requires us to wait until
> the workqueue_init() is invoked, our work can be execute. and also need to wait for the
> rcu_gp kthread to be created, after this, our first grace period can begin, the callbacks has the
> opportunity to be called.  the call_rcu() require a grace period, but we require is expedited grace period.

Good catch, thank you!  I will update the commit log accordingly.

							Thanx, Paul

> Thanks
> Zqiang
> 
> >
> >							Thanx, Paul
> 
> > Thanks
> > Zqiang
> > 
> > 
> > >    
> > >    Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> > >    Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
> > >    Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > >    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > >
> > >diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > >index 63545d79da51c..f2e3a23778c06 100644
> > >--- a/kernel/rcu/tree.c
> > >+++ b/kernel/rcu/tree.c
> > >@@ -4937,9 +4937,8 @@ void __init rcu_init(void)
> > > 	else
> > > 		qovld_calc = qovld;
> > > 
> > >-	// Kick-start any polled grace periods that started early.
> > >-	if (!(per_cpu_ptr(&rcu_data, cpu)->mynode->exp_seq_poll_rq & 0x1))
> > >-		(void)start_poll_synchronize_rcu_expedited();
> > >+	// Kick-start in case any polled grace periods started early.
> > >+	(void)start_poll_synchronize_rcu_expedited();
> > > 
> > > 	rcu_test_sync_prims();
> > > }
> > >diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> > >index 956cd459ba7f3..3b7abb58157df 100644
> > >--- a/kernel/rcu/tree_exp.h
> > >+++ b/kernel/rcu/tree_exp.h
> > >@@ -1068,9 +1068,10 @@ unsigned long start_poll_synchronize_rcu_expedited(void)
> > > 	if (rcu_init_invoked())
> > > 		raw_spin_lock_irqsave(&rnp->exp_poll_lock, flags);
> > > 	if (!poll_state_synchronize_rcu(s)) {
> > >-		rnp->exp_seq_poll_rq = s;
> > >-		if (rcu_init_invoked())
> > >+		if (rcu_init_invoked()) {
> > >+			rnp->exp_seq_poll_rq = s;
> > > 			queue_work(rcu_gp_wq, &rnp->exp_poll_wq);
> > >+		}
> > > 	}
> > > 	if (rcu_init_invoked())
> > > 		raw_spin_unlock_irqrestore(&rnp->exp_poll_lock, flags);

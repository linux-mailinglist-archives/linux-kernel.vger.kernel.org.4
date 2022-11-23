Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D58BA63697D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 20:05:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239471AbiKWTFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 14:05:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236582AbiKWTFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 14:05:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE6492B4F;
        Wed, 23 Nov 2022 11:04:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A65EFB81F28;
        Wed, 23 Nov 2022 19:04:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69CF3C433C1;
        Wed, 23 Nov 2022 19:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669230296;
        bh=2H40+uCv6OfFHEKwb+WSQxVdetiB1LxCCOkcoQmcgR4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=dldg2hlFP/84iIEygRYLSseOVTmt5CHvJmYULVugkqMLUMBD2i7an1ouhJ/T35T2g
         Taj3WCDlv24DEiVCzKJe8N0P7k4hqpT8WRlpBqP5LNQXwc8OStD5BvIccwliWNVoNr
         2X/XwIE48c+B7xlF5GF4b5YVftTitfE1rhIMSo53fdTFLzMHEuPQbjMLQf49zXt3ed
         oU+92SrP0ImjVLflTcdcH2x80mbLPQxybobISwvblVdGeFzimMx9B9RhiUjgNVP4eP
         7VN2qfmph9dFVOEarvsXWDneNYzK70z4z+/kgTOsMbAF/GZEW+9Q2zb3POHbC8YT2k
         iMkkLrS/pNUqw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 1630E5C0A3F; Wed, 23 Nov 2022 11:04:56 -0800 (PST)
Date:   Wed, 23 Nov 2022 11:04:56 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] srcu: Add detection of boot CPU srcu_data
 structure's->srcu_cblist
Message-ID: <20221123190456.GE4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221117112050.3942407-1-qiang1.zhang@intel.com>
 <20221117142025.GE839309@lothringen>
 <PH0PR11MB58807CB6626A08CADD822409DA099@PH0PR11MB5880.namprd11.prod.outlook.com>
 <PH0PR11MB5880F073FEFFDD11B1AA0642DA0C9@PH0PR11MB5880.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR11MB5880F073FEFFDD11B1AA0642DA0C9@PH0PR11MB5880.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2022 at 02:01:50AM +0000, Zhang, Qiang1 wrote:
> 
> >On Thu, Nov 17, 2022 at 07:20:50PM +0800, Zqiang wrote:
> > Before SRCU_SIZE_WAIT_CALL srcu_size_state is reached, the srcu
> > callback only insert to boot-CPU srcu_data structure's->srcu_cblist
> > and other CPU srcu_data structure's->srcu_cblist is always empty. so
> > before SRCU_SIZE_WAIT_CALL is reached, need to correctly check boot-CPU
> > pend cbs in srcu_might_be_idle().
> > 
> > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> > ---
> >  kernel/rcu/srcutree.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > index 6af031200580..6d9af9901765 100644
> > --- a/kernel/rcu/srcutree.c
> > +++ b/kernel/rcu/srcutree.c
> > @@ -1098,8 +1098,11 @@ static bool srcu_might_be_idle(struct srcu_struct *ssp)
> >  	unsigned long tlast;
> >  
> >  	check_init_srcu_struct(ssp);
> > -	/* If the local srcu_data structure has callbacks, not idle.  */
> > -	sdp = raw_cpu_ptr(ssp->sda);
> > +	/* If the boot CPU or local srcu_data structure has callbacks, not idle.  */
> > +	if (smp_load_acquire(&ssp->srcu_size_state) < SRCU_SIZE_WAIT_CALL)
> > +		sdp = per_cpu_ptr(ssp->sda, get_boot_cpu_id());
> > +	else
> > +		sdp = raw_cpu_ptr(ssp->sda);
> >
> 
> Hi Paul,  
> 
> For the convert_to_big  default configuration(SRCU_SIZING_AUTO), I found that the srcu is in
> SRCU_SIZE_SMALL state most of the time in the system, I think this change is meaningful.
> 
> Thoughts ?

You are right that this change might make srcu_might_be_idle() return a
more accurate value in the common case.  As things are now, some other
CPU might just now have added a callback, but might not yet have started
that new grace period.  In that case, we might expedite an SRCU grace
period when we would not have otherwise done so.  However, this change
would also increase contention on the get_boot_cpu_id() CPU's srcu_data
structure's ->lock.

So the result of that inaccurate return value is that the first two SRCU
grace periods in a burst might be expedited instead of only the first one,
and even then only if we hit a very narrow race window.

Besides, this same thing can happen if two CPUs do synchronize_srcu()
at the same time after a long-enough pause between grace periods.
Both see no callbacks, so both ask for an expedited grace period.
So again, the first two grace periods are expedited.

As a result, I am having a very hard time justifying the increased
lock contention.

Am I missing something here?

							Thanx, Paul

> Thanks
> Zqiang
> 
> 
> >While at it if someone is interested in documenting/commenting on the meaning of
> >all these SRCU_SIZE_* things, it would be much appreciated!
> >
> >In the initial stage(SRCU_SIZE_SMALL), there is no srcu_node structures, only initialized
> >per-CPU srcu_data structures, at this time, we only use boot-cpu srcu_data structures's ->srcu_cblist
> >to store srcu callbacks.  
> >if the contention of srcu_struct and srcu_data structure's->lock become busy,
> >transition to SRCU_SIZE_ALLOC.  allocated memory for srcu_node structure at end of the SRCU
> >grace period.   
> >if allocated success,  transition to SRCU_SIZE_WAIT_BARRIER,  in this state, invoke
> >srcu_barrier() will iterate over all possible CPUs, but we still only use boot-CPU srcu_cblist to store callbacks.
> >the task calling call_srcu() may have access to a new srcu_node structure or may not, 
> >because call_srcu() is protected by SRCU, we may not transition to SRCU_SIZE_WAIT_CALL quickly,
> >need to wait in this state for a SRCU grace period to end.
> >After transition to SRCU_SIZE_WAIT_CALL, we enqueue srcu callbacks to own srcu_data structures's ->srcu_cblist.
> >
> >Does my description make my commit more detailed?
> >
> >Thanks
> >Zqiang
> >
> >
> 
> 
> >
> >Thanks.
> >
> >  	spin_lock_irqsave_rcu_node(sdp, flags);
> >  	if (rcu_segcblist_pend_cbs(&sdp->srcu_cblist)) {
> >  		spin_unlock_irqrestore_rcu_node(sdp, flags);
> > -- 
> > 2.25.1
> > 

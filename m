Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3134B616957
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 17:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbiKBQlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 12:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbiKBQks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 12:40:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD771C43B;
        Wed,  2 Nov 2022 09:35:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DFC346144F;
        Wed,  2 Nov 2022 16:35:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4876DC433D6;
        Wed,  2 Nov 2022 16:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667406945;
        bh=6Dub98gUvW8R+kNkzvlI6CqMN0EtxuMR/XWvTyJOPu0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Aa2sBnnHljXiPFtN+0yyPh20OV1zqqN6DHESaEyBeZbn3frECnfbXwLHxUqlDZs/s
         QgoHHeZvGL0q00bnknFaaPD9VyUEOnAGUlty2ubuZKEtsZJhyAEa24rW+rfhdBCjPN
         me5ND3ipbli0GpSrZFnf50jek4Y6G7OOqouMxCuzCH96LKA8z+j1SFMkPsvERrLnS1
         Z3D+objzYLbZxhSL9rJv5Hpx0mTW8YmSOdgH5wOed+c5fGGTHEYiD+zZxYaQ5kCeG3
         9dciJgcl3AFsB+t9J6PC5mA9eOXMo3ctFnqCH1sFjKPGonD5EzlCjD/nHDAgB09TTB
         3BNMQvgWOVa9g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E6CEE5C1813; Wed,  2 Nov 2022 09:35:44 -0700 (PDT)
Date:   Wed, 2 Nov 2022 09:35:44 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] rcu/kfree: Do not request RCU when not needed
Message-ID: <20221102163544.GM5600@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221029132856.3752018-1-joel@joelfernandes.org>
 <Y2JkoVV3jaVS4y0Q@pc636>
 <CAEXW_YRZO086TUJCFzuGpAWRpQ-uKD1S5wDipJ9hR9=XddNFSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YRZO086TUJCFzuGpAWRpQ-uKD1S5wDipJ9hR9=XddNFSw@mail.gmail.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 12:13:17PM -0400, Joel Fernandes wrote:
> On Wed, Nov 2, 2022 at 8:37 AM Uladzislau Rezki <urezki@gmail.com> wrote:
> >
> > On Sat, Oct 29, 2022 at 01:28:56PM +0000, Joel Fernandes (Google) wrote:
> > > On ChromeOS, I am (almost) always seeing the optimization trigger.
> > > Tested boot up and trace_printk'ing how often it triggers.
> > >
> > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > ---
> > >  kernel/rcu/tree.c | 18 +++++++++++++++++-
> > >  1 file changed, 17 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index 591187b6352e..3e4c50b9fd33 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -2935,6 +2935,7 @@ struct kfree_rcu_cpu_work {
> > >
> > >  /**
> > >   * struct kfree_rcu_cpu - batch up kfree_rcu() requests for RCU grace period
> > > + * @rdp: The rdp of the CPU that this kfree_rcu corresponds to.
> > >   * @head: List of kfree_rcu() objects not yet waiting for a grace period
> > >   * @bkvhead: Bulk-List of kvfree_rcu() objects not yet waiting for a grace period
> > >   * @krw_arr: Array of batches of kfree_rcu() objects waiting for a grace period
> > > @@ -2964,6 +2965,8 @@ struct kfree_rcu_cpu {
> > >       struct kfree_rcu_cpu_work krw_arr[KFREE_N_BATCHES];
> > >       raw_spinlock_t lock;
> > >       struct delayed_work monitor_work;
> > > +     struct rcu_data *rdp;
> > > +     unsigned long last_gp_seq;
> > >       bool initialized;
> > >       int count;
> > >
> > > @@ -3167,6 +3170,7 @@ schedule_delayed_monitor_work(struct kfree_rcu_cpu *krcp)
> > >                       mod_delayed_work(system_wq, &krcp->monitor_work, delay);
> > >               return;
> > >       }
> > > +     krcp->last_gp_seq = krcp->rdp->gp_seq;
> > >       queue_delayed_work(system_wq, &krcp->monitor_work, delay);
> > >  }
> > >
> > > @@ -3217,7 +3221,17 @@ static void kfree_rcu_monitor(struct work_struct *work)
> > >                       // be that the work is in the pending state when
> > >                       // channels have been detached following by each
> > >                       // other.
> > > -                     queue_rcu_work(system_wq, &krwp->rcu_work);
> > > +                     //
> > > +                     // NOTE about gp_seq wrap: In case of gp_seq overflow,
> > > +                     // it is possible for rdp->gp_seq to be less than
> > > +                     // krcp->last_gp_seq even though a GP might be over. In
> > > +                     // this rare case, we would just have one extra GP.
> > > +                     if (krcp->last_gp_seq &&
> > >
> > This check can be eliminated i think. A kfree_rcu_cpu is defined as
> > static so by default the last_gp_set is set to zero.
> 
> Ack.
> 
> > > @@ -4802,6 +4816,8 @@ static void __init kfree_rcu_batch_init(void)
> > >       for_each_possible_cpu(cpu) {
> > >               struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
> > >
> > > +             krcp->rdp = per_cpu_ptr(&rcu_data, cpu);
> > > +             krcp->last_gp_seq = 0;
> > >
> > Yep. This one can be just dropped.
> >
> > But all the rest looks good :) I will give it a try from test point of
> > view. It is interested from the memory footprint point of view.
> 
> Ack. Thanks. Even though we should not sample rdp->gp_seq, I think it
> is still worth a test.

Just for completeness, the main purpose of rdp->gp_seq is to reject
quiescent states that were seen during already-completed grace periods.

							Thanx, Paul

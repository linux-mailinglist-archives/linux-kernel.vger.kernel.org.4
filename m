Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 922146B1FDC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 10:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbjCIJUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 04:20:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbjCIJUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 04:20:19 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1D2E6E9804;
        Thu,  9 Mar 2023 01:19:54 -0800 (PST)
Date:   Thu, 9 Mar 2023 10:19:43 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>, Julian Anastasov <ja@ssi.bg>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Jens Axboe <axboe@kernel.dk>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Bryan Tan <bryantan@vmware.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Eric Dumazet <edumazet@google.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Ariel Levkovich <lariel@nvidia.com>,
        Theodore Ts'o <tytso@mit.edu>, Jiri Wiesner <jwiesner@suse.de>
Subject: Re: [PATCH 10/13] ipvs: Rename kfree_rcu() to kfree_rcu_mightsleep()
Message-ID: <ZAmkrxguzzsqNFM+@salvia>
References: <20230201150954.409693-1-urezki@gmail.com>
 <Y9qLB6Zyx5atcFUV@salvia>
 <7e87836a-c72-eefd-9c74-fc2637accd2@ssi.bg>
 <Y9qc+lgR1CgdszKs@salvia>
 <Y9qfNV0IX1tBsTxP@pc636>
 <20230309001101.GA155598@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230309001101.GA155598@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2023 at 12:11:01AM +0000, Joel Fernandes wrote:
> Hello,
> 
> On Wed, Feb 01, 2023 at 06:19:49PM +0100, Uladzislau Rezki wrote:
> > On Wed, Feb 01, 2023 at 06:10:18PM +0100, Pablo Neira Ayuso wrote:
> > > On Wed, Feb 01, 2023 at 06:12:04PM +0200, Julian Anastasov wrote:
> > > > 
> > > > 	Hello,
> > > > 
> > > > On Wed, 1 Feb 2023, Pablo Neira Ayuso wrote:
> > > > 
> > > > > Hi,
> > > > > 
> > > > > On Wed, Feb 01, 2023 at 04:09:51PM +0100, Uladzislau Rezki (Sony) wrote:
> > > > > > The kfree_rcu()'s single argument name is deprecated therefore
> > > > > > rename it to kfree_rcu_mightsleep() variant. The goal is explicitly
> > > > > > underline that it is for sleepable contexts.
> > > > > > 
> > > > > > Cc: Julian Anastasov <ja@ssi.bg>
> > > > > > Cc: Pablo Neira Ayuso <pablo@netfilter.org>
> > > > > > Cc: Jiri Wiesner <jwiesner@suse.de>
> > > > > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > > > > ---
> > > > > >  net/netfilter/ipvs/ip_vs_est.c | 2 +-
> > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > > 
> > > > > > diff --git a/net/netfilter/ipvs/ip_vs_est.c b/net/netfilter/ipvs/ip_vs_est.c
> > > > > > index ce2a1549b304..a39baf6d1367 100644
> > > > > > --- a/net/netfilter/ipvs/ip_vs_est.c
> > > > > > +++ b/net/netfilter/ipvs/ip_vs_est.c
> > > > > > @@ -549,7 +549,7 @@ void ip_vs_stop_estimator(struct netns_ipvs *ipvs, struct ip_vs_stats *stats)
> > > > > >  	__set_bit(row, kd->avail);
> > > > > >  	if (!kd->tick_len[row]) {
> > > > > >  		RCU_INIT_POINTER(kd->ticks[row], NULL);
> > > > > > -		kfree_rcu(td);
> > > > > 
> > > > > I also found this kfree_rcu() without rcu_head call a few weeks ago.
> > > > > 
> > > > > @Wiesner, @Julian: Any chance this can be turned into kfree_rcu(td, rcu_head); ?
> > > > 
> > > > 	Yes, as simple as this:
> > > > 
> > > > diff --git a/include/net/ip_vs.h b/include/net/ip_vs.h
> > > > index c6c61100d244..6d71a5ff52df 100644
> > > > --- a/include/net/ip_vs.h
> > > > +++ b/include/net/ip_vs.h
> > > > @@ -461,6 +461,7 @@ void ip_vs_stats_free(struct ip_vs_stats *stats);
> > > >  
> > > >  /* Multiple chains processed in same tick */
> > > >  struct ip_vs_est_tick_data {
> > > > +	struct rcu_head		rcu_head;
> > > >  	struct hlist_head	chains[IPVS_EST_TICK_CHAINS];
> > > >  	DECLARE_BITMAP(present, IPVS_EST_TICK_CHAINS);
> > > >  	DECLARE_BITMAP(full, IPVS_EST_TICK_CHAINS);
> > > > diff --git a/net/netfilter/ipvs/ip_vs_est.c b/net/netfilter/ipvs/ip_vs_est.c
> > > > index df56073bb282..25c7118d9348 100644
> > > > --- a/net/netfilter/ipvs/ip_vs_est.c
> > > > +++ b/net/netfilter/ipvs/ip_vs_est.c
> > > > @@ -549,7 +549,7 @@ void ip_vs_stop_estimator(struct netns_ipvs *ipvs, struct ip_vs_stats *stats)
> > > >  	__set_bit(row, kd->avail);
> > > >  	if (!kd->tick_len[row]) {
> > > >  		RCU_INIT_POINTER(kd->ticks[row], NULL);
> > > > -		kfree_rcu(td);
> > > > +		kfree_rcu(td, rcu_head);
> > > >  	}
> > > >  	kd->est_count--;
> > > >  	if (kd->est_count) {
> > > > 
> > > > 	I was about to reply to Uladzislau Rezki but his patchset
> > > > looks more like a renaming, so I'm not sure how we are about
> > > > to integrate this change, as separate patch or as part of his
> > > > patchset. I don't have preference, just let me know how to
> > > > handle it.
> > > 
> > > @Uladzislau Rezki: Are you fine with dropping this patch from your
> > > series and Julian will send us a patch for inclusion into net-next to
> > > use the kfree_rcu(x, rcu_head) variant?
> > Absolutely. So i will drop it from my series.
> 
> Since this patch was dropped, it is the only case blocking the proper
> integration of this series into linux-next. We want to drop the old API and
> currently we are not able to, thus this revert [1] has to be unfortunately
> carried in linux-next.
>
> For that reason, there are 2 options:
> 
> 1. Can we get the new rcu_head approach for ipvs posted and reviewed with
> suitable Acks?
> 
> 2. Can we carry Vlad's patch to use kfree_rcu_mightsleep() in ipvs and drop
> it later if/when #1 is completed?
> 
> Option 2 has the unfortunate effect that it will conflict with your new
> approach of using rcu_head so I'd rather you fix it that way and get it
> Acked. And once acked, we can also take it via the RCU tree if the net
> maintainers are Ok with that.
> 
> Please advise.

JFYI, this patch is already in linux.git

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e4d0fe71f59dc5137a2793ff7560730d80d1e1f4

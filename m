Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3273D6D55B5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 03:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbjDDBGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 21:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjDDBGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 21:06:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80432C3;
        Mon,  3 Apr 2023 18:06:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF9ED61243;
        Tue,  4 Apr 2023 01:06:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D7AFC433D2;
        Tue,  4 Apr 2023 01:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680570401;
        bh=b6+YNg5qDpc0Av58aQryPk8dnNe0c7qA3itSPakHWS0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ds11Kle7wbBJ1e3nK6amLIDnFx00vIgrnUdFtet3UVAuFSB1WFFrWeedvPjdvfow+
         zdd30QkZopxbQfc25JGgYl8SVoebQR1/FjG2NSkcq7ZtlLFOwNaAPtHetMS/mRSxtd
         SYSvticS3dXEmZzFubl279TtbRBVwTc9aYQ0LsQY2aeHS7M+qnttyP0AjvTnPCmx2e
         O2ZhqnBxjYLpNb1yIt2S9meAnNQt/cvgm20WG61RwU2J7miaVH1baXHcRrCddKKn68
         a+xzyLxUdoKf3S0YjYfk7AMcToastYpi4aB4CyvjragEvpIwJTYvK/8KK8ldAvisyb
         pK5VlMdF0Cz/A==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id CA72315404B4; Mon,  3 Apr 2023 18:06:40 -0700 (PDT)
Date:   Mon, 3 Apr 2023 18:06:40 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org, hch@lst.de,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Sachin Sant <sachinp@linux.ibm.com>,
        "Zhang, Qiang1" <qiang1.zhang@intel.com>
Subject: Re: [PATCH rcu 04/20] srcu: Begin offloading srcu_struct fields to
 srcu_update
Message-ID: <bad21a93-6d1d-4069-b84b-d3dc1a6cf456@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <f1b6cd5f-f0b7-4748-abd5-0dcfef0ce126@paulmck-laptop>
 <20230330224726.662344-4-paulmck@kernel.org>
 <20230404003508.GA254019@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404003508.GA254019@google.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2023 at 12:35:08AM +0000, Joel Fernandes wrote:
> On Thu, Mar 30, 2023 at 03:47:10PM -0700, Paul E. McKenney wrote:
> > The current srcu_struct structure is on the order of 200 bytes in size
> > (depending on architecture and .config), which is much better than the
> > old-style 26K bytes, but still all too inconvenient when one is trying
> > to achieve good cache locality on a fastpath involving SRCU readers.
> > 
> > However, only a few fields in srcu_struct are used by SRCU readers.
> > The remaining fields could be offloaded to a new srcu_update
> > structure, thus shrinking the srcu_struct structure down to a few
> > tens of bytes.  This commit begins this noble quest, a quest that is
> > complicated by open-coded initialization of the srcu_struct within the
> > srcu_notifier_head structure.  This complication is addressed by updating
> > the srcu_notifier_head structure's open coding, given that there does
> > not appear to be a straightforward way of abstracting that initialization.
> > 
> > This commit moves only the ->node pointer to srcu_update.  Later commits
> > will move additional fields.
> > 
> > [ paulmck: Fold in qiang1.zhang@intel.com's memory-leak fix. ]
> > 
> > Link: https://lore.kernel.org/all/20230320055751.4120251-1-qiang1.zhang@intel.com/
> > Suggested-by: Christoph Hellwig <hch@lst.de>
> 
> [..]
> > @@ -236,8 +236,12 @@ static bool init_srcu_struct_nodes(struct srcu_struct *ssp, gfp_t gfp_flags)
> >   */
> >  static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
> >  {
> > +	if (!is_static)
> > +		ssp->srcu_sup = kzalloc(sizeof(*ssp->srcu_sup), GFP_KERNEL);
> > +	if (!ssp->srcu_sup)
> > +		return -ENOMEM;
> >  	ssp->srcu_size_state = SRCU_SIZE_SMALL;
> > -	ssp->node = NULL;
> > +	ssp->srcu_sup->node = NULL;
> >  	mutex_init(&ssp->srcu_cb_mutex);
> >  	mutex_init(&ssp->srcu_gp_mutex);
> >  	ssp->srcu_idx = 0;
> > @@ -249,8 +253,11 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
> >  	ssp->sda_is_static = is_static;
> >  	if (!is_static)
> >  		ssp->sda = alloc_percpu(struct srcu_data);
> > -	if (!ssp->sda)
> > +	if (!ssp->sda) {
> > +		if (!is_static)
> > +			kfree(ssp->srcu_sup);
> >  		return -ENOMEM;
> > +	}
> >  	init_srcu_struct_data(ssp);
> >  	ssp->srcu_gp_seq_needed_exp = 0;
> >  	ssp->srcu_last_gp_end = ktime_get_mono_fast_ns();
> > @@ -259,6 +266,7 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
> 
> [1] Here there is an if (!init_srcu_struct_nodes(...)) that the diff does not show.
> 
> >  			if (!ssp->sda_is_static) {
> >  				free_percpu(ssp->sda);
> >  				ssp->sda = NULL;
> > +				kfree(ssp->srcu_sup);
> >  				return -ENOMEM;
> >  			}
> >  		} else {
> 
> 
> Just a comment about the original code with reference to [1].
> 
> Here if allocations in init_srcu_struct_nodes() fail, it will return false
> and execute the "if (!ssp->sda_is_is_static)" bit.
> 
> So if the allocation in [1] fails, then if sda_is_static is true, we return
> -ENOMEM, however  if sda_is_static is false, we do the following:
> 
>         ssp->srcu_sup->srcu_ssp = ssp;
>         smp_store_release(&ssp->srcu_sup->srcu_gp_seq_needed, 0); /* Init done. */
>         return 0;
> 
> Is that really correct?

Doesn't look like it, now that you mention it.  Good catch, thank you!

> In other words, if init_srcu_struct_nodes() returns false, then passing along
> the return value of init_srcu_struct_nodes() back to the caller of
> init_srcu_struct_fields() depends on whether is_static = true or false. That
> seems a bit wrong to me, init_srcu_struct_fields() should always return
> -ENOMEM  when init_srcu_struct_nodes() fails to allocate memory IMHO, whether
> is_static is true or not.
> 
> Sorry if I missed something subtle, and if the code is correct to begin with.
> Also I feel the return paths could be made better to also fix the above issue
> I mentioned. How about the following diff on top of the series, would it
> work?

Your restructuring looks like an excellent step forward, but given the late
date, it might be best to avoid being in a rush.

I -could- make the following small patch:

	if (READ_ONCE(ssp->srcu_sup->srcu_size_state) == SRCU_SIZE_SMALL && SRCU_SIZING_IS_INIT()) {
		if (!init_srcu_struct_nodes(ssp, GFP_ATOMIC)) {
			if (!ssp->srcu_sup->sda_is_static) {
				free_percpu(ssp->sda);
				ssp->sda = NULL;
				kfree(ssp->srcu_sup);
			}
			return -ENOMEM;
		} else {
			WRITE_ONCE(ssp->srcu_sup->srcu_size_state, SRCU_SIZE_BIG);
		}
	}

Except that this is a pre-existing bug that as far as we know no one
is hitting, so the risk doesn't seem to stack up.  After all, if you
are hitting memory exhaustion at boot or on module load, this bug is
probably the least of your problems.  Even this fix looks to be v6.5
material to me.

So would you be willing to send a patch like the above that fixes the
bug, and another like you have below to get a better error-path
structure?  No hurry, the end of this month is perfectly fine.

And again, good catch!

							Thanx, Paul

> Thanks!
> 
> ---8<-----------------------
> 
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index a887cfc89894..1975d06986fa 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -255,29 +255,30 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
>  	ssp->srcu_sup->sda_is_static = is_static;
>  	if (!is_static)
>  		ssp->sda = alloc_percpu(struct srcu_data);
> -	if (!ssp->sda) {
> -		if (!is_static)
> -			kfree(ssp->srcu_sup);
> -		return -ENOMEM;
> -	}
> +	if (!ssp->sda)
> +		goto err_free_sup;
>  	init_srcu_struct_data(ssp);
>  	ssp->srcu_sup->srcu_gp_seq_needed_exp = 0;
>  	ssp->srcu_sup->srcu_last_gp_end = ktime_get_mono_fast_ns();
>  	if (READ_ONCE(ssp->srcu_sup->srcu_size_state) == SRCU_SIZE_SMALL && SRCU_SIZING_IS_INIT()) {
> -		if (!init_srcu_struct_nodes(ssp, GFP_ATOMIC)) {
> -			if (!ssp->srcu_sup->sda_is_static) {
> -				free_percpu(ssp->sda);
> -				ssp->sda = NULL;
> -				kfree(ssp->srcu_sup);
> -				return -ENOMEM;
> -			}
> -		} else {
> +		if (!init_srcu_struct_nodes(ssp, GFP_ATOMIC))
> +			goto err_free_sda;
> +		else
>  			WRITE_ONCE(ssp->srcu_sup->srcu_size_state, SRCU_SIZE_BIG);
> -		}
>  	}
>  	ssp->srcu_sup->srcu_ssp = ssp;
>  	smp_store_release(&ssp->srcu_sup->srcu_gp_seq_needed, 0); /* Init done. */
>  	return 0;
> +
> +err_free_sda:
> +	if (!is_static) {
> +		free_percpu(ssp->sda);
> +		ssp->sda = NULL;
> +	}
> +err_free_sup:
> +	if (!is_static)
> +		kfree(ssp->srcu_sup);
> +	return -ENOMEM;
>  }
>  
>  #ifdef CONFIG_DEBUG_LOCK_ALLOC

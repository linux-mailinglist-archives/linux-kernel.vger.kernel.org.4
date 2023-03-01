Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2526A74C4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 21:08:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjCAUIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 15:08:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjCAUIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 15:08:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7763976BB;
        Wed,  1 Mar 2023 12:08:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10EB561492;
        Wed,  1 Mar 2023 20:08:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64DF1C433EF;
        Wed,  1 Mar 2023 20:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677701301;
        bh=yCU9LbHC7GjcJmmJI+gM9d9NqJXLtAh1qIs/M611A5o=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=g6HbmwkR8KD4IlNrqhORB5U1JpfNsTJNyQfb7ebcT1zrUoAVhGDnHwLsxnSCDiOfX
         Kd+Q/uSIv7T1Gn1QxOIDPDhngTGPZLxti6OeZywvLaItxXFeW62ALCJfKGHZuKCKzY
         c89cQgWFc/PG50s03LhVDqWn8ZHjAc4WWlNcAj6gMXr7FhSaZMa4ugC60x4lFWDJWz
         SjE0XokCQzeAAAtVJKH6YolelMBiuaBORagGNBOLIs4K3EqjdwVonblb+rOKKtvCkm
         4Kjk6u58cVRlRqrMZwu0QK4BjEtqA9LBupXvpyo78i8b8Wc5A5Qfc50cqPu+TNjxCu
         wD6SbHVUEsC5g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id F30585C03F0; Wed,  1 Mar 2023 12:08:20 -0800 (PST)
Date:   Wed, 1 Mar 2023 12:08:20 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH] rcu: use try_cmpxchg in check_cpu_stall
Message-ID: <20230301200820.GF2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230228155121.3416-1-ubizjak@gmail.com>
 <Y/5mguXPPqdP3MZF@google.com>
 <20230228160324.2a7c1012@gandalf.local.home>
 <20230228212911.GX2948950@paulmck-ThinkPad-P17-Gen-1>
 <20230228164124.77c126d2@gandalf.local.home>
 <CAEXW_YQ515_DOLVUm48GvDADuaY2mSrYTaKa7u6jYDNqBncJww@mail.gmail.com>
 <20230228190846.79b06089@gandalf.local.home>
 <CAFULd4aY3Y8tyLN70oebZDagBebvH0erwRxKDaEX8L83Xo8gYw@mail.gmail.com>
 <20230301113813.4f16a689@gandalf.local.home>
 <CAFULd4aWZ+fvVZ+MEt6JD1rFaQZeO5DDWAHtPKOrx8R8DETFBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFULd4aWZ+fvVZ+MEt6JD1rFaQZeO5DDWAHtPKOrx8R8DETFBw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01, 2023 at 07:43:34PM +0100, Uros Bizjak wrote:
> On Wed, Mar 1, 2023 at 5:38 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > On Wed, 1 Mar 2023 11:28:47 +0100
> > Uros Bizjak <ubizjak@gmail.com> wrote:
> >
> > > These benefits are the reason the change to try_cmpxchg was accepted
> > > also in the linear code elsewhere in the linux kernel, e.g. [2,3] to
> > > name a few commits, with a thumbs-up and a claim that the new code is
> > > actually *clearer* at the merge commit [4].
> >
> > I'll say it here too. I really like Joel's suggestion of having a
> > cmpxchg_success() that does not have the added side effect of modifying the
> > old variable.
> >
> > I think that would allow for the arch optimizations that you are trying to
> > achieve, as well as remove the side effect that might cause issues down the
> > road.
> 
> Attached patch implements this suggestion.

Please help me out here.

Why on earth are we even discussing making this change to code that
normally never executes?  Performance is not a consideration here.

What am I missing here?  Is there some sort of forward-progress
issue that this change addresses?

							Thanx, Paul

> Uros.

> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> index b10b8349bb2a..229263ebba3b 100644
> --- a/kernel/rcu/tree_stall.h
> +++ b/kernel/rcu/tree_stall.h
> @@ -709,6 +709,12 @@ static void print_cpu_stall(unsigned long gps)
>  	set_preempt_need_resched();
>  }
>  
> +#define cmpxchg_success(ptr, old, new)				\
> +({								\
> +	__typeof__(*(ptr)) __tmp = (old);			\
> +	try_cmpxchg((ptr), &__tmp, (new));			\
> +})
> +
>  static void check_cpu_stall(struct rcu_data *rdp)
>  {
>  	bool didstall = false;
> @@ -760,7 +766,7 @@ static void check_cpu_stall(struct rcu_data *rdp)
>  	jn = jiffies + ULONG_MAX / 2;
>  	if (rcu_gp_in_progress() &&
>  	    (READ_ONCE(rnp->qsmask) & rdp->grpmask) &&
> -	    cmpxchg(&rcu_state.jiffies_stall, js, jn) == js) {
> +	    cmpxchg_success(&rcu_state.jiffies_stall, js, jn)) {
>  
>  		/*
>  		 * If a virtual machine is stopped by the host it can look to
> @@ -778,7 +784,7 @@ static void check_cpu_stall(struct rcu_data *rdp)
>  
>  	} else if (rcu_gp_in_progress() &&
>  		   ULONG_CMP_GE(j, js + RCU_STALL_RAT_DELAY) &&
> -		   cmpxchg(&rcu_state.jiffies_stall, js, jn) == js) {
> +		   cmpxchg_success(&rcu_state.jiffies_stall, js, jn)) {
>  
>  		/*
>  		 * If a virtual machine is stopped by the host it can look to


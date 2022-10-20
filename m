Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F20B1606B1A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 00:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbiJTWQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 18:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiJTWQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 18:16:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF906122BCF;
        Thu, 20 Oct 2022 15:16:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B8BE61D28;
        Thu, 20 Oct 2022 22:16:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F464C433D6;
        Thu, 20 Oct 2022 22:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666304164;
        bh=gLRQGPgh6vv1pyqgyAZdU6mSmmdNocASosKJU5FROQ8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=FoZ/OhMbJoPpERRdoMn282AWWkAtAzKzgKn2Visc/y3Thn1wKGZcLB51/408ZbGK6
         kqCqyKBvARECR79VL9TlJyBr4s4BmIB7tupTg+jISsMvS3Y8VAj0nWGwuSG/KdXOVL
         yrBu6fe9meezE4hvYIsnKaKx36nuDL4v5W40+SZyaeg4ABYB7PMTGgBHfqyyNTutGX
         UZmHYqJzaRoU9aovr81BYrM7RiPrBy2DYhnZ3n2W0SemoNPNqc5BdmKVQyBT7UPjmK
         bMLfdGCrQt1pbg16g4XaASjBV6lo/+E/mrnciR62qEy53ba7vNFTnqpqh+h/iA+kev
         TCObGyxgsghKw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 0EB325C1109; Thu, 20 Oct 2022 15:16:04 -0700 (PDT)
Date:   Thu, 20 Oct 2022 15:16:04 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, quic_neeraju@quicinc.com,
        rcu@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH 1/3] srcu: Warn when NMI-unsafe API is used in NMI
Message-ID: <20221020221604.GW5600@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221013172244.1099010-1-frederic@kernel.org>
 <20221013172244.1099010-2-frederic@kernel.org>
 <Y0nmcH0SktDdonyW@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0nmcH0SktDdonyW@google.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 14, 2022 at 10:45:04PM +0000, Joel Fernandes wrote:
> On Thu, Oct 13, 2022 at 07:22:42PM +0200, Frederic Weisbecker wrote:
> > Using the NMI-unsafe reader API from within NMIs is very likely to be
> > buggy for three reasons:
> > 
> > 1) NMIs aren't strictly re-entrant (a pending nested NMI will execute
> >    at the end of the current one) so it should be fine to use a
> >    non-atomic increment here. However breakpoints can still interrupt
> >    NMIs and if a breakpoint callback has a reader on that same ssp, a
> >    racy increment can happen.
> > 
> > 2) If the only reader site for a given ssp is in an NMI, RCU is definetly
> 								  definitely
> >    a better choice over SRCU.
> 
> Just checking - because NMI are by definition not-preemptibe, so SRCU over
> RCU doesn't make much sense right?

Agreed.  But you never know...

> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

I will apply on the next rebase (after today's rebase), thank you!

							Thanx, Paul

> thanks,
> 
>  - Joel
> 
> > 
> > 3) Because of the previous reason (2), an ssp having an SRCU read side
> >    critical section in an NMI is likely to have another one from a task
> >    context.
> > 
> > For all these reasons, warn if an nmi unsafe reader API is used from an
> > NMI.
> > 
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > ---
> >  kernel/rcu/srcutree.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > index c54142374793..8b7ef1031d89 100644
> > --- a/kernel/rcu/srcutree.c
> > +++ b/kernel/rcu/srcutree.c
> > @@ -642,6 +642,8 @@ static void srcu_check_nmi_safety(struct srcu_struct *ssp, bool nmi_safe)
> >  
> >  	if (!IS_ENABLED(CONFIG_PROVE_RCU))
> >  		return;
> > +	/* NMI-unsafe use in NMI is a bad sign */
> > +	WARN_ON_ONCE(!nmi_safe && in_nmi());
> >  	sdp = raw_cpu_ptr(ssp->sda);
> >  	old_nmi_safe_mask = READ_ONCE(sdp->srcu_nmi_safety);
> >  	if (!old_nmi_safe_mask) {
> > -- 
> > 2.25.1
> > 

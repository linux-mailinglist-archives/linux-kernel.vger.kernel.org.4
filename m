Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 904345EFB1A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 18:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235646AbiI2QmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 12:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235195AbiI2QmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 12:42:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDAEE153A76
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 09:42:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A33A161F4D
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 16:42:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06195C433D7;
        Thu, 29 Sep 2022 16:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664469725;
        bh=9+JAay2KY6j6xm1jASu1ajjNIWxzcizOC1IRSt6Lr+Y=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Un/AED6AS11i7tJgaB2hRtq4bt2ttc7YmkXy57jcqWCA1uV4rMPOWSciZAeAyNXIR
         0nz+5eVcKiMN2XHms0qyPGb5SZCt3HGYk3ynmKTf2qsc9LVGaKKud05B0jkF/frF08
         okkzUArojzYLNOxi3ddsupQ0KThZuXEmp7lxm7lMDXCZskKIKqBm0ranYwFelCpjCU
         KH7zPjpUdS+uzJAs/H4JzOh6CqCBK7VNmzj6sDmRvRiNfUReZohf0Kg0NKa02AWS7T
         +oneqFjfktsaFdP4MsZs/yw4ejUtgFJX0K399pdWWOw9KDJi/o2BbpiG2ZUjec70Aa
         yS7ixL17aHbJg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 9B7E15C0BCA; Thu, 29 Sep 2022 09:42:04 -0700 (PDT)
Date:   Thu, 29 Sep 2022 09:42:04 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: RCU vs NOHZ
Message-ID: <20220929164204.GO4196@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <YyN0BKEoDbe4hcIl@hirez.programming.kicks-ass.net>
 <20220915191427.GC246308@paulmck-ThinkPad-P17-Gen-1>
 <YyOnilnwnLKA9ghN@hirez.programming.kicks-ass.net>
 <20220916075817.GE246308@paulmck-ThinkPad-P17-Gen-1>
 <YyQ/zn54D1uoaIc1@hirez.programming.kicks-ass.net>
 <20220917142508.GF246308@paulmck-ThinkPad-P17-Gen-1>
 <YzV5vqoLInptafJm@hirez.programming.kicks-ass.net>
 <20220929152044.GE4196@paulmck-ThinkPad-P17-Gen-1>
 <20220929154618.GA2864141@paulmck-ThinkPad-P17-Gen-1>
 <YzXGdEzkiw+5X8pC@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzXGdEzkiw+5X8pC@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 06:23:16PM +0200, Peter Zijlstra wrote:
> On Thu, Sep 29, 2022 at 08:46:18AM -0700, Paul E. McKenney wrote:
> > On Thu, Sep 29, 2022 at 08:20:44AM -0700, Paul E. McKenney wrote:
> 
> > > > > There is a directly invoked RCU hook for any transition that enables or
> > > > > disables the tick, namely the ct_*_enter() and ct_*_exit() functions,
> > > > > that is, those functions formerly known as rcu_*_enter() and rcu_*_exit().
> > > > 
> > > > Context tracking doesn't know about NOHZ, therefore RCU can't either.
> > > > Context tracking knows about IDLE, but not all IDLE is NOHZ-IDLE.
> > > > 
> > > > Specifically we have:
> > > > 
> > > > 	ct_{idle,irq,nmi,user,kernel}_enter()
> > > > 
> > > > And none of them are related to NOHZ in the slightest. So no, RCU does
> > > > not have a NOHZ callback.
> > > > 
> > > > I'm still thikning you're conflating NOHZ_FULL (stopping the tick when
> > > > in userspace) and regular NOHZ (stopping the tick when idle).
> > 
> > Exactly how are ct_user_enter() and ct_user_exit() completely unrelated
> > to nohz_full CPUs?
> 
> That's the thing; I'm not talking about nohz_full. I'm talking about
> regular nohz. World of difference there.

And indeed, for !nohz_full CPUs, the tick continues throughout userspace
execution.  But you really did have ct_user_enter() and ct_user_exit()
on your list.

And for idle (as opposed to nohz_full userspace execution), there is still
ct_{idle,irq,nmi}_enter().  And RCU does pay attention to these.

So exactly what are you trying to tell me here?  ;-)

> nohz_full is a gimmick that shouldn't be used outside of very specific
> cases. Regular nohz otoh is used by everybody always.

I will let you take that up with the people using it.

							Thanx, Paul

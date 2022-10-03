Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE18E5F2FEA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 13:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbiJCL5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 07:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiJCL5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 07:57:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040BC4F645;
        Mon,  3 Oct 2022 04:57:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B0655B8106E;
        Mon,  3 Oct 2022 11:57:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F481C433D6;
        Mon,  3 Oct 2022 11:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664798239;
        bh=IZiOGNCLznneDfy4glvG+cArR8cL/1LBLIitlhiKGv0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=iB9ieGEJg51ZW/dU/tBRex6wnidNzkSrNibJL1t736pgOuwg5p53FOK1mdhE+xMgJ
         78laQJXh2xVePxQGfZV9fE8zjKaxAqRrpGPThCR3ZT3I/jFl7EcgGm+53xI71eB+iC
         zVMtCnRPG2G3O5Vm1F3qssZPJq4/MlgVXO04uV0HNDR6cjKwcHDsZY5MhMd0B4wEjd
         75LET7OilXitu2yAel+I1L/gRuFuGcqB8nHJf8vZEFQrepgKC+wER3akkdUbDqKqyi
         KHySgUSxf50RUXrtN7D94bWBWkHUORwhQVFtczHRRWjHldPeV+eAWzWniIf/iJnOP7
         DVPJH71QjbCBw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id F082F5C0641; Mon,  3 Oct 2022 04:57:18 -0700 (PDT)
Date:   Mon, 3 Oct 2022 04:57:18 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, rostedt@goodmis.org,
        Thomas Gleixner <tglx@linutronix.de>,
        John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH RFC v2 rcu 3/8] srcu: Check for consistent per-CPU
 per-srcu_struct NMI safety
Message-ID: <20221003115718.GY4196@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220929180714.GA2874192@paulmck-ThinkPad-P17-Gen-1>
 <20220929180731.2875722-3-paulmck@kernel.org>
 <20221002220619.GA298433@lothringen>
 <20221002235103.GW4196@paulmck-ThinkPad-P17-Gen-1>
 <20221003101331.GA304186@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221003101331.GA304186@lothringen>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 03, 2022 at 12:13:31PM +0200, Frederic Weisbecker wrote:
> On Sun, Oct 02, 2022 at 04:51:03PM -0700, Paul E. McKenney wrote:
> > On Mon, Oct 03, 2022 at 12:06:19AM +0200, Frederic Weisbecker wrote:
> > > On Thu, Sep 29, 2022 at 11:07:26AM -0700, Paul E. McKenney wrote:
> > > > This commit adds runtime checks to verify that a given srcu_struct uses
> > > > consistent NMI-safe (or not) read-side primitives on a per-CPU basis.
> > > > 
> > > > Link: https://lore.kernel.org/all/20220910221947.171557773@linutronix.de/
> > > > 
> > > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > > Cc: John Ogness <john.ogness@linutronix.de>
> > > > Cc: Petr Mladek <pmladek@suse.com>
> > > > ---
> > > >  include/linux/srcu.h     |  4 ++--
> > > >  include/linux/srcutiny.h |  4 ++--
> > > >  include/linux/srcutree.h |  9 +++++++--
> > > >  kernel/rcu/srcutree.c    | 38 ++++++++++++++++++++++++++++++++------
> > > >  4 files changed, 43 insertions(+), 12 deletions(-)
> > > > 
> > > > diff --git a/include/linux/srcu.h b/include/linux/srcu.h
> > > > index 2cc8321c0c86..565f60d57484 100644
> > > > --- a/include/linux/srcu.h
> > > > +++ b/include/linux/srcu.h
> > > > @@ -180,7 +180,7 @@ static inline int srcu_read_lock_nmisafe(struct srcu_struct *ssp) __acquires(ssp
> > > >  	int retval;
> > > >  
> > > >  	if (IS_ENABLED(CONFIG_NEED_SRCU_NMI_SAFE))
> > > > -		retval = __srcu_read_lock_nmisafe(ssp);
> > > > +		retval = __srcu_read_lock_nmisafe(ssp, true);
> > > >  	else
> > > >  		retval = __srcu_read_lock(ssp);
> > > 
> > > Shouldn't it be checked also when CONFIG_NEED_SRCU_NMI_SAFE=n ?
> > 
> > You are asking why there is no "true" argument to __srcu_read_lock()?
> > That is because it checks unconditionally.
> 
> It checks unconditionally but it always assumes not to be called as nmisafe.
> 
> For example on x86/arm64/loongarch, the same ssp used with both srcu_read_lock() and
> srcu_read_lock_nmisafe() won't report an issue. But on powerpc it will.
> 
> My point is that strong archs should warn as well on behalf of others, to detect
> mistakes early.

Good point, especially given that x86_64 and arm64 are a rather large
fraction of the uses.  Not critically urgent, but definitely nice to have.

Did you by chance have a suggestion for a nice way to accomplish this?

								Thanx, Paul

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC78D5F2745
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 01:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbiJBXvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 19:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJBXvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 19:51:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C323A3473E;
        Sun,  2 Oct 2022 16:51:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC4D460EE8;
        Sun,  2 Oct 2022 23:51:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AE6EC433C1;
        Sun,  2 Oct 2022 23:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664754664;
        bh=8i2j1Equju5bv3X+GNDN7PBDR6BJY7fFXuyecJ1ahQU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=hqigFUVTeufPfPy+iTvB+26TQjkCMQ850diAR0GpPs3C023RACXOZdBSFYIYh/4gN
         vwMAp6MwsVcHynpp2KPOwKpKYBaA/ukOfsTGOEWs1XIcVllcS/t2qJFfsHI6G1wCwe
         7I5lqmNjNppynIN12ljwixh7mY+cyEGg67gvEmdjQXjIoluQB5jiMv8OaK8cPG1n7s
         jVcKZezTz9/zyHdnkC44ZorprFwYs/s9Y64zOn+Ka9F9rOvLoWz4V0QWpBzUNzq5Ex
         O6fFYBPA0xjF9Fiuhg3QhDdOUEkIKu9y63z/+ivhfnALpNqSybckPyypR4OujUb435
         VxhUZSM48AaXQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id BFE005C0BE3; Sun,  2 Oct 2022 16:51:03 -0700 (PDT)
Date:   Sun, 2 Oct 2022 16:51:03 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, rostedt@goodmis.org,
        Thomas Gleixner <tglx@linutronix.de>,
        John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH RFC v2 rcu 3/8] srcu: Check for consistent per-CPU
 per-srcu_struct NMI safety
Message-ID: <20221002235103.GW4196@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220929180714.GA2874192@paulmck-ThinkPad-P17-Gen-1>
 <20220929180731.2875722-3-paulmck@kernel.org>
 <20221002220619.GA298433@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221002220619.GA298433@lothringen>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 03, 2022 at 12:06:19AM +0200, Frederic Weisbecker wrote:
> On Thu, Sep 29, 2022 at 11:07:26AM -0700, Paul E. McKenney wrote:
> > This commit adds runtime checks to verify that a given srcu_struct uses
> > consistent NMI-safe (or not) read-side primitives on a per-CPU basis.
> > 
> > Link: https://lore.kernel.org/all/20220910221947.171557773@linutronix.de/
> > 
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: John Ogness <john.ogness@linutronix.de>
> > Cc: Petr Mladek <pmladek@suse.com>
> > ---
> >  include/linux/srcu.h     |  4 ++--
> >  include/linux/srcutiny.h |  4 ++--
> >  include/linux/srcutree.h |  9 +++++++--
> >  kernel/rcu/srcutree.c    | 38 ++++++++++++++++++++++++++++++++------
> >  4 files changed, 43 insertions(+), 12 deletions(-)
> > 
> > diff --git a/include/linux/srcu.h b/include/linux/srcu.h
> > index 2cc8321c0c86..565f60d57484 100644
> > --- a/include/linux/srcu.h
> > +++ b/include/linux/srcu.h
> > @@ -180,7 +180,7 @@ static inline int srcu_read_lock_nmisafe(struct srcu_struct *ssp) __acquires(ssp
> >  	int retval;
> >  
> >  	if (IS_ENABLED(CONFIG_NEED_SRCU_NMI_SAFE))
> > -		retval = __srcu_read_lock_nmisafe(ssp);
> > +		retval = __srcu_read_lock_nmisafe(ssp, true);
> >  	else
> >  		retval = __srcu_read_lock(ssp);
> 
> Shouldn't it be checked also when CONFIG_NEED_SRCU_NMI_SAFE=n ?

You are asking why there is no "true" argument to __srcu_read_lock()?
That is because it checks unconditionally.  OK, so why the
"true" argument to __srcu_read_lock_nmisafe(), you ask?  Because
srcu_gp_start_if_needed() needs to call __srcu_read_lock_nmisafe()
while suppressing the checking, which it does by passing in "false".
In turn because srcu_gp_start_if_needed() cannot always tell whether
its srcu_struct is or is not NMI-safe.

							Thanx, Paul

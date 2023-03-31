Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA706D27E6
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 20:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbjCaSfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 14:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjCaSfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 14:35:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA931C1FD;
        Fri, 31 Mar 2023 11:35:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CDA6262AED;
        Fri, 31 Mar 2023 18:35:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D77DC433D2;
        Fri, 31 Mar 2023 18:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680287738;
        bh=79aOJ1giHYcfqq27B0ApvLldLxW67XdeeGemRyFtgUg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=fBJAAtHbweslyvxiUdUqMPJUntejV1ohdCqfFsfBtxy1XAVb70FD0hzsvLRz6/vCY
         1UAdzEF/fIdR6vQBEeAOA8YQCZ0qjJrpqe2EV0ZHHuUlM9hkt8UJr4cnTHKsHGlML9
         IDdFqN1yEE6upAouCP8d8tqzWPqgnYzWfmmXnpf+HB3arUxeAXiPfQSc2wmPJ31TpH
         a3tYftweC+aGQeXJ5JEwa2PU6JtxNajYtDgzPcW8wCYGhRAPxLjyxYWyvVgFi1xKs8
         kXcI/Uz/mksN43MOAH0kHeBvG9hxGcWXCeoHDVSAanMzqBhIVd4CTIDBMGoia6rYER
         mhVq7Msdvdxwg==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id CA1121540476; Fri, 31 Mar 2023 11:35:37 -0700 (PDT)
Date:   Fri, 31 Mar 2023 11:35:37 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org, hch@lst.de,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH rcu 01/20] rcu-tasks: Fix warning for unused
 tasks_rcu_exit_srcu
Message-ID: <5e63ebc8-0292-457a-b0ce-c9a8ba4ef699@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <f1b6cd5f-f0b7-4748-abd5-0dcfef0ce126@paulmck-laptop>
 <20230330224726.662344-1-paulmck@kernel.org>
 <ZCbK7hcVWFEFcPwN@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCbK7hcVWFEFcPwN@lothringen>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31, 2023 at 01:58:38PM +0200, Frederic Weisbecker wrote:
> On Thu, Mar 30, 2023 at 03:47:07PM -0700, Paul E. McKenney wrote:
> > The tasks_rcu_exit_srcu variable is used only by kernels built
> > with CONFIG_TASKS_RCU=y, but is defined for all kernesl with
> > CONFIG_TASKS_RCU_GENERIC=y.  Therefore, in kernels built with
> > CONFIG_TASKS_RCU_GENERIC=y but CONFIG_TASKS_RCU=n, this gives
> > a "defined but not used" warning.
> > 
> > This commit therefore moves this variable under CONFIG_TASKS_RCU.
> > 
> > Link: https://lore.kernel.org/oe-kbuild-all/202303191536.XzMSyzTl-lkp@intel.com/
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > ---
> >  kernel/rcu/tasks.h | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> > index bfb5e1549f2b..185358c2f08d 100644
> > --- a/kernel/rcu/tasks.h
> > +++ b/kernel/rcu/tasks.h
> > @@ -136,8 +136,10 @@ static struct rcu_tasks rt_name =							\
> >  	.kname = #rt_name,								\
> >  }
> >  
> > +#ifdef CONFIG_TASKS_RCU
> >  /* Track exiting tasks in order to allow them to be waited for. */
> >  DEFINE_STATIC_SRCU(tasks_rcu_exit_srcu);
> > +#endif
> 
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

Thank you!  I will apply this on my next rebase.

> BTW should  exit_tasks_rcu_start/stop() be defined as static inline stubs
> whenever !CONFIG_TASKS_RCU ? Currently:
> 
> * if CONFIG_TASKS_RCU_GENERIC=n, the stubs are as usual (static inline)
> 
> * if CONFIG_TASKS_RCU_GENERIC=y && CONFIG_TASKS_RCU=n, then the stubs are
>   defined as empty linked function (is the compiler smart enough to remove
>   the empty call?)

Good point!  They are currently defined as static inline only if there
are no RCU Tasks flavors built into the kernel, so if there was (say)
RCU Tasks Trace but no RCU Tasks, these functions would needlessly be
actual calls to empty functions.

I am not sure that there are any kernels built like this, and this is not
on a fastpath, but I would welcome a patch that made this more precise.
Testing will require a few kernel builds, though.  ;-)

							Thanx, Paul

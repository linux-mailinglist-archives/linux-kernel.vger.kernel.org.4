Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 427CE6BD786
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 18:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjCPRvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 13:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbjCPRvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 13:51:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF613FBA7;
        Thu, 16 Mar 2023 10:51:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 170C2B822F0;
        Thu, 16 Mar 2023 17:50:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDE7BC433D2;
        Thu, 16 Mar 2023 17:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678989053;
        bh=mQI195bsoZhuwsniwL56dTXtb0cJd+PAZxJeRAV03u0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ePaceNB3H0SMAoWUzF3ZtGKzuBojUWdl7jvCZ8euC/dCzORO2IL8fmZ5+Sv3Z5IE6
         Cad8y8c/+DVbEEos9US3KWUtBHu+StnWugPhMiw/zFOumj3/EjsQBqKLr7/nkdlFrb
         jcvrXY2Vco1xmFoT+VdrBPv+2j7WCmdxY5Sxym1muxp+c+ZQE6whJ4kWJlvXcJ0UiA
         4sl4FEAJLW7Zy50gqGOeC4t1utlZWNiErv8rP4F4MyX21sHDrYS3dJ1uqoCZY/YSM9
         5Lotfn+k7jr43M0vFcDBm4KHbS+o+LTTdvlvHnYHL66aQ5gMsYUjVQT+LYE5CAL4+j
         WtsLVKG2nWvsg==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 6BFCF1540395; Thu, 16 Mar 2023 10:50:53 -0700 (PDT)
Date:   Thu, 16 Mar 2023 10:50:53 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] rcu/rcuscale: Stop kfree_scale_thread thread(s)
 after unloading rcuscale
Message-ID: <2bbaa13a-bfcc-45b7-acce-8da59a2a0c32@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <IA1PR11MB61714FEEAF2C46639891401A89BC9@IA1PR11MB6171.namprd11.prod.outlook.com>
 <2B9F2C1A-B274-41EF-8ABE-1E660521BCE4@joelfernandes.org>
 <IA1PR11MB6171C7FEE026F421A3CD6A9689BC9@IA1PR11MB6171.namprd11.prod.outlook.com>
 <CAEXW_YTh18nWTWjLBCRiB2AAH76oD7XrMMMPWZ+9thFSmcPaVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEXW_YTh18nWTWjLBCRiB2AAH76oD7XrMMMPWZ+9thFSmcPaVg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2023 at 10:57:06AM -0400, Joel Fernandes wrote:
> On Thu, Mar 16, 2023 at 9:53 AM Zhuo, Qiuxu <qiuxu.zhuo@intel.com> wrote:
> >
> [...]
> > > >> From: Paul E. McKenney <paulmck@kernel.org> [...]
> > > >>>>
> > > >>>> How about to pull the rcu_scale_cleanup() function after
> > > >> kfree_scale_cleanup().
> > > >>>> This groups kfree_* functions and groups rcu_scale_* functions.
> > > >>>> Then the code would look cleaner.
> > > >>>> So, do you think the changes below are better?
> > > >>>
> > > >>> IMHO, I don't think doing such a code move is better. Just add a new
> > > >>> header file and declare the function there. But see what Paul says
> > > >>> first.
> > > >>
> > > >> This situation is likely to be an early hint that the kvfree_rcu()
> > > >> testing should be split out from kernel/rcu/rcuscale.c.
> > > >
> > > > Another is that it's a bit expensive to create a new header file just
> > > > for eliminating a function declaration. ;-)
> > >
> > > What is so expensive about new files? It is a natural organization structure.
> > >
> > > > So, if no objections, I'd like to send out the v2 patch with the updates below:
> > > >
> > > >   - Move rcu_scale_cleanup() after kfree_scale_cleanup() to eliminate the
> > > >     declaration of kfree_scale_cleanup(). Though this makes the patch bigger,
> > > >     get the file rcuscale.c much cleaner.
> > > >
> > > >   - Remove the unnecessary step "modprobe torture" from the commit
> > > message.
> > > >
> > > >   - Add the description for why move rcu_scale_cleanup() after
> > > >     kfree_scale_cleanup() to the commit message.
> > >
> > > Honestly if you are moving so many lines around, you may as well split it out
> > > into a new module.
> > > The kfree stuff being clubbed in the same file has also been a major
> > > annoyance.
> >
> > I'm OK with creating a new kernel module for these kfree stuffs,
> > but do we really need to do that?

It is not a particularly high priority.

> If it were me doing this, I would try to split it just because in the
> long term I may have to maintain or deal with it.
> 
> I was also thinking a new scale directory _may_ make sense for
> performance tests.
> 
> kernel/rcu/scaletests/kfree.c
> kernel/rcu/scaletests/core.c
> kernel/rcu/scaletests/ref.c
> 
> Or something like that.

I don't believe we are there yet, but...

> and then maybe putt common code into: kernel/rcu/scaletests/common.c

...splitting out the common code within the current directory/file
structure makes a lot of sense to me.  Not that I have checked up on
exactly how much common code there really is.  ;-)

							Thanx, Paul

>  - Joel
> 
> >
> > @paulmck, what's your suggestion for the next step?
> >
> > >  - Joel
> > >
> > >
> > > > Thanks!
> > > > -Qiuxu
> > > >
> > > >> [...]

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D207F703BE1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 20:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245005AbjEOSH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 14:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244997AbjEOSHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 14:07:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A2821071;
        Mon, 15 May 2023 11:04:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 805CA630B1;
        Mon, 15 May 2023 18:04:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4020C433D2;
        Mon, 15 May 2023 18:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684173872;
        bh=w/tD1VgUWIZXjc4ZO9uAIcHfFZfFG43mlWXV784BVlQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=tJ1w317a8iaHz1VGX6pm1812CQT1CvbM4o1OUpBtLFPrhBfqSm1D7A8t3RzBum81C
         tc0CXxzxdPjt+oPiu/ofkSx6oI+QOk/s2nPrImBoHKrqMmtlVwGPjSKakwadtDllsZ
         cVyRiYxlZxsgFQIGh1HaX9l/ltuoxq48wsV4Ky7Vx/cVVXyYkOGRi/JYUbPe/p4L0P
         EYVLyyaIpNL1RPJsKEzLwJRUTXo28flTcu0yN4VW1ARuxJhzY3Zo9YKIJm/a2Ta/Rj
         p6l8rn4JdZoM4cC9Afk+pJUZ4FGdY0nQqpEwqCW4iaWWlBwXBPF3IoaDZ8YsRlNVbV
         0/G+LFrSm9dMw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7E6D1CE0C8D; Mon, 15 May 2023 11:04:32 -0700 (PDT)
Date:   Mon, 15 May 2023 11:04:32 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org,
        Zqiang <qiang1.zhang@intel.com>
Subject: Re: [PATCH rcu 5/6] doc/rcutorture: Add description of
 rcutorture.stall_cpu_block
Message-ID: <a6bcadd6-ec74-4be4-bddf-71439324510a@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <7ffd4a5d-61e9-4b4c-a312-a85bcde08c39@paulmck-laptop>
 <20230510171238.2189921-5-paulmck@kernel.org>
 <CAEXW_YQNRQuPP8GzHMZXWPoLmbpK3rB_+eVXmiRu6RrsihrEpQ@mail.gmail.com>
 <0146f6ad-9a2c-4a28-8992-e054afade42c@paulmck-laptop>
 <CAEXW_YQ0o8f-J3QqQKur7GkY+kxOvtANpFH4uajMGe6ioFErvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEXW_YQ0o8f-J3QqQKur7GkY+kxOvtANpFH4uajMGe6ioFErvw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 10:00:18PM -0700, Joel Fernandes wrote:
> On Thu, May 11, 2023 at 11:11 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Wed, May 10, 2023 at 10:47:36PM -0700, Joel Fernandes wrote:
> > > On Wed, May 10, 2023 at 10:12 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > >
> > > > From: Zqiang <qiang1.zhang@intel.com>
> > > >
> > > > If you build a kernel with CONFIG_PREEMPTION=n and CONFIG_PREEMPT_COUNT=y,
> > > > then run the rcutorture tests specifying stalls as follows:
> > > >
> > > > runqemu kvm slirp nographic qemuparams="-m 1024 -smp 4" \
> > > >         bootparams="console=ttyS0 rcutorture.stall_cpu=30 \
> > > >         rcutorture.stall_no_softlockup=1 rcutorture.stall_cpu_block=1" -d
> > > >
> > > > The tests will produce the following splat:
> > > >
> > > > [   10.841071] rcu-torture: rcu_torture_stall begin CPU stall
> > > > [   10.841073] rcu_torture_stall start on CPU 3.
> > > > [   10.841077] BUG: scheduling while atomic: rcu_torture_sta/66/0x0000000
> > > > ....
> > > > [   10.841108] Call Trace:
> > > > [   10.841110]  <TASK>
> > > > [   10.841112]  dump_stack_lvl+0x64/0xb0
> > > > [   10.841118]  dump_stack+0x10/0x20
> > > > [   10.841121]  __schedule_bug+0x8b/0xb0
> > > > [   10.841126]  __schedule+0x2172/0x2940
> > > > [   10.841157]  schedule+0x9b/0x150
> > > > [   10.841160]  schedule_timeout+0x2e8/0x4f0
> > > > [   10.841192]  schedule_timeout_uninterruptible+0x47/0x50
> > > > [   10.841195]  rcu_torture_stall+0x2e8/0x300
> > > > [   10.841199]  kthread+0x175/0x1a0
> > > > [   10.841206]  ret_from_fork+0x2c/0x50
> > >
> > > Another way to get rid of the warning would be to replace the
> > > cur_ops->readlock() with rcu_read_lock(). Though perhaps that will not
> > > test whether the particular RCU flavor under testing is capable of
> > > causing a stall :-).
> >
> > Exactly!
> >
> > > >         rcutorture.stall_cpu_block= [KNL]
> > > >                         Sleep while stalling if set.  This will result
> > > > -                       in warnings from preemptible RCU in addition
> > > > -                       to any other stall-related activity.
> > > > +                       in warnings from preemptible RCU in addition to
> > > > +                       any other stall-related activity.  Note that
> > > > +                       in kernels built with CONFIG_PREEMPTION=n and
> > > > +                       CONFIG_PREEMPT_COUNT=y, this parameter will
> > > > +                       cause the CPU to pass through a quiescent state.
> > > > +                       Any such quiescent states will suppress RCU CPU
> > > > +                       stall warnings, but the time-based sleep will
> > > > +                       also result in scheduling-while-atomic splats.
> > >
> > > Could change last part to "but may also result in
> > > scheduling-while-atomic splats as preemption might be disabled for
> > > certain RCU flavors in order to cause the stall".
> >
> > Is that needed given the earlier "in kernels built with
> > CONFIG_PREEMPTION=n and CONFIG_PREEMPT_COUNT=y"?
> 
> Hmm, I guess is not clear to the reader without code reading about why
> preempt got disabled. So I would add that last part I mentioned, but I
> am Ok either way, it is just a suggestion.

I will figure something out to more tightly tie this to the previous
CONFIG_PREEMPTION=n.

> > > > +                       Which might or might not be what you want.
> > > > +
> > >
> > > Suggest drop this line ;-).
> >
> > OK, I will bite.  ;-)
> >
> > What is your concern with this line?
> 
> It is not needed IMO.

It actually is, otherwise the various testing services complain about
getting splats.  I will upgrade it to something more explicit.

							Thanx, Paul

> thanks,
> 
>  - Joel
> 
> 
> > > >         rcutorture.stall_cpu_holdoff= [KNL]
> > > >                         Time to wait (s) after boot before inducing stall.
> > > > --
> > > > 2.40.1
> > > >

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB0645F79FF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 16:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbiJGOyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 10:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiJGOyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 10:54:12 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A706966847;
        Fri,  7 Oct 2022 07:54:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B6AC4CE1872;
        Fri,  7 Oct 2022 14:54:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6149C433C1;
        Fri,  7 Oct 2022 14:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665154447;
        bh=nSNo2OllKvBqhjRhBLV7kwuHdL90pchIhWduLmlIpvo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ke2X6SFEccKcRJaEJQ+H0iU+5TckpufEZjDMVMSaYCD+tQr1XlFsNdYxSbVh7JZ59
         a6Jur1q0lsoCjCpIqrXiK8l5P5mN900LjNWYib/KTtyAEhMmFhte06ryIBqDYZ78Bp
         q//ZdRQ+emB3kjk4NPLcmXq2y5648nwB45Y3mduFT01nwpmRc/mJ/g+IuN/Ay6L13n
         3OwpQn0PAGj60azWGrWdiRzcqOgF0ZfoyJzIJbAEdUed7ec6uItLKPonglDGf8uimw
         WA/DpjFwqp482+qD1LOs9XCh7JdmNy4Hszg1kn+0gdi7sONhjXGwvXUFoOzZq8eNWX
         30fIzxUq5nyLg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 884DC5C0546; Fri,  7 Oct 2022 07:54:06 -0700 (PDT)
Date:   Fri, 7 Oct 2022 07:54:06 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, neeraj.iitr10@gmail.com,
        frederic@kernel.org, rostedt@goodmis.org, youssefesmat@google.com,
        surenb@google.com
Subject: Re: [PATCH v7 00/11] rcu: call_rcu() power improvements
Message-ID: <20221007145406.GH4196@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221004024157.2470238-1-joel@joelfernandes.org>
 <20221006185543.GB4196@paulmck-ThinkPad-P17-Gen-1>
 <Y0A6S77d6DFgoKzx@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y0A6S77d6DFgoKzx@pc636>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 07, 2022 at 04:40:11PM +0200, Uladzislau Rezki wrote:
> On Thu, Oct 06, 2022 at 11:55:43AM -0700, Paul E. McKenney wrote:
> > On Tue, Oct 04, 2022 at 02:41:46AM +0000, Joel Fernandes (Google) wrote:
> > > v7 version of RCU lazy patches based on rcu/next branch.
> > > 
> > > To facilitate easier merge, I dropped tracing and other patches and just
> > > implemented the new changes. I will post the tracing patches later along with
> > > rcutop as I need to add new tracepoints that Frederic suggested.
> > > 
> > > Main recent changes:
> > > 1. rcu_barrier() wake up only for lazy bypass list.
> > > 2. Make all call_rcu() default-lazy and add call_rcu_flush() API.
> > > 3. Take care of some callers using call_rcu_flush() API.
> > > 4. Several refactorings suggested by Paul/Frederic.
> > > 5. New call_rcu() to call_rcu_flush() conversions by Joel/Vlad/Paul.
> > > 
> > > I am seeing good performance and power with these patches on real ChromeOS x86
> > > asymmetric hardware.
> > > 
> > > Earlier cover letter with lots of details is here:
> > > https://lore.kernel.org/all/20220901221720.1105021-1-joel@joelfernandes.org/
> > > 
> > > List of recent changes:
> > >     
> > >     [ Frederic Weisbec: Program the lazy timer only if WAKE_NOT, since other
> > >       deferral levels wake much earlier so for those it is not needed. ]
> > >     
> > >     [ Frederic Weisbec: Use flush flags to keep bypass API code clean. ]
> > >     
> > >     [ Frederic Weisbec: Make rcu_barrier() wake up only if main list empty. ]
> > >     
> > >     [ Frederic Weisbec: Remove extra 'else if' branch in rcu_nocb_try_bypass(). ]
> > >     
> > >     [ Joel: Fix issue where I was not resetting lazy_len after moving it to rdp ]
> > >     
> > >     [ Paul/Thomas/Joel: Make call_rcu() default lazy so users don't mess up. ]
> > >     
> > >     [ Paul/Frederic : Cosmetic changes, split out wakeup of nocb thread. ]
> > >     
> > >     [ Vlad/Joel : More call_rcu -> flush conversions ]
> > 
> > Thank you for your continued work on this!
> > 
> > I pulled these into an experimental branch, applied Uladzislau's
> > Tested-by and ran a quick round of rcutorture.
> > 
> > From TREE02, TREE03, and TREE09 I got this:
> > 
> > In file included from kernel/rcu/tree.c:68:
> > kernel/rcu/tree.h:449:13: error: ‘wake_nocb_gp’ used but never defined [-Werror]
> >   449 | static bool wake_nocb_gp(struct rcu_data *rdp, bool force);
> >       |             ^~~~~~~~~~~~
> > 
> > One could argue that this is not a big deal, except that Linus gets a
> > bit tetchy when this sort of thing shows up in mainline.
> > 
> Sorry. I have not tested TREE02, TREE03 and TREE09 scenarios. My goal
> was to check below functionalities:
> 
> - call_rcu_flush() does not introduce any delays once it is queued
> - call_rcu() does not apply pressure on the RCU-machinery from wake-up point of view
> - boot-time is not degraded
> - synchronize_rcu() and rcu_barrier() work as expected
> - if bypass consists of lazy callbacks the *flush() one has to initiate the offloading

I am not blaming you, just making people aware of an issue needing
some resolution.  After all, you only said that you tested it, not that
you tested all possible corner cases on all possible hardware running
all possible workloads.  ;-)

							Thanx, Paul

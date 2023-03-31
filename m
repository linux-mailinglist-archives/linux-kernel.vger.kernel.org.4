Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2756B6D267F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 19:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbjCaRRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 13:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjCaRRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 13:17:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4CDC1BF75
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 10:17:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B84162ABE
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 17:17:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4853C433D2;
        Fri, 31 Mar 2023 17:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680283019;
        bh=9SEYP1bD8f9GCzfYuKQIF0RE1GJYNL9on3r1xN1EBlY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=NH0tvn73mETnuiGYkdPV0zjsHcheG6ToJ//tcag/+lGoQwjbIJUxQJG5Cis5wmxF6
         CesIUMybgfwhKhurBGzvERB9EIQCqwp+0xc5YW4PPEttVXpijRXEA0TuP0liF8F72J
         LPp0rdfmqWPSjyM/KnNR1cZvGxtZHgM2KCzIOxg2ohT2tAN0H3UGjcWSQ6v+7mcDJ1
         ThyZEk1+S70jVWEpyokMqoo8pJUzBs99xLo74RbsyIEc8xoPWisUfNwixfGzs9Kx3y
         ADC2v1/HjCZdijEYjxXivaU6QDPIwN4bONizqfKhnoXjn6BDD23X8JyFpQw5y93pZb
         HqMZdXnq4oyyA==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 24C7A1540476; Fri, 31 Mar 2023 10:16:59 -0700 (PDT)
Date:   Fri, 31 Mar 2023 10:16:59 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: A couple of TSC questions
Message-ID: <3daa086c-b4a0-47a9-8bfc-aac4139013c4@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <b2f07f18-b60b-403b-90ff-937ea32963ee@paulmck-laptop>
 <ZBqOyLByOgvdAve3@feng-clx>
 <acda3fb5-373a-48b1-b78e-eea18da4ccb0@paulmck-laptop>
 <ZCD9SnZSUCkE9Ss+@feng-clx>
 <aaf391d9-98e6-47d8-b402-c90b4a81ae9c@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaf391d9-98e6-47d8-b402-c90b4a81ae9c@paulmck-laptop>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 02:58:54PM -0700, Paul E. McKenney wrote:
> On Mon, Mar 27, 2023 at 10:19:54AM +0800, Feng Tang wrote:
> > On Fri, Mar 24, 2023 at 05:47:33PM -0700, Paul E. McKenney wrote:
> > > On Wed, Mar 22, 2023 at 01:14:48PM +0800, Feng Tang wrote:

[ . . . ]

> > > > > Second, we are very occasionally running into console messages like this:
> > > > > 
> > > > > Measured 2 cycles TSC warp between CPUs, turning off TSC clock.
> > > > > 
> > > > > This comes from check_tsc_sync_source() and indicates that one CPU's
> > > > > TSC read produced a later time than a later read from some other CPU.
> > > > > I am beginning to suspect that these can be caused by unscheduled delays
> > > > > in the TSC synchronization code, but figured I should ask you if you have
> > > > > ever seen these.  And of course, if so, what the usual causes might be.
> > > > 
> > > > I haven't seen this error myself or got similar reports. Usually it
> > > > should be easy to detect once happened, as falling back to HPET
> > > > will trigger obvious performance degradation.
> > > 
> > > And that is exactly what happened.  ;-)
> > > 
> > > > Could you give more detail about when and how it happens, and the
> > > > HW info like how many sockets the platform has. 
> > > 
> > > We are in early days, so I am checking for other experiences.
> > > 
> > > > CC Thomas, Waiman, as they discussed simliar case here:
> > > > https://lore.kernel.org/lkml/87h76ew3sb.ffs@tglx/T/#md4d0a88fb708391654e78312ffa75b481690699f
> > > 
> > > Fun!  ;-)
> 
> Waiman, do you recall what fraction of the benefit was provided by the
> first patch, that is, the one that grouped the sync_lock, last_tsc,
> max_warp, nr_warps, and random_warps global variables into a single
> struct?

And what we are seeing is unlikely to be due to cache-latency-induced
delays.  We see a very precise warp, for example, one system always
has 182 cycles of TSC warp, another 273 cycles, and a third 469 cycles.
Another is at the insanely large value of about 2^64/10, and shows some
variation, but that variation is only about 0.1%.

But any given system only sees warp on about half of its reboots.
Perhaps due to the automation sometimes power cycling?

There are few enough affected systems that investigation will take
some time.

							Thanx, Paul

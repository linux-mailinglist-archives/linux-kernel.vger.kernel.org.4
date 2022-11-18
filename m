Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B64E463049A
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 00:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236682AbiKRXnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 18:43:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237153AbiKRXmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 18:42:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7448CBA7;
        Fri, 18 Nov 2022 15:23:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6470B627C1;
        Fri, 18 Nov 2022 23:23:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD33FC433D7;
        Fri, 18 Nov 2022 23:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668813830;
        bh=7XBXVXhCCU9Em+DNHd2vQ8ORuGvO8P1sSalA66wErCk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=blwOQFIuTxcwSMpQfrpRN3vC+oXQ40d5Lx+Q0/7zTNaBJTFcIK2j+q+GS+VrLqn5K
         B79Cgvf4A9grFKlXAGPPqkY1372eQqdzBUtKiJRKwDkDbr3G0/6ds+KtZjWXsigm6X
         vsXaSRjoqxaoNAL0BfBqbQThoPiMeK3UphY5UqY7q+MiLYEP1oF72dXrBWzBwuanFC
         XouSFG7wXvG9SgmIPoEudeVCIW7/1x2bRf951UUJoJov4aYB+CERze2SH3/yvbxIrG
         rUT2UPdfTMSZeiU9K1cTI+qkRHzn2amvhwVfHBX3NBEmv9HO51kk9FFC3j/w8rtxbE
         7wy4ERwgRrMvw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 6A8A35C0EBE; Fri, 18 Nov 2022 15:23:50 -0800 (PST)
Date:   Fri, 18 Nov 2022 15:23:50 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH 1/2] torture: use for_each_present() loop in
 torture_online_all()
Message-ID: <20221118232350.GA2340322@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221111125126.3319474-1-svens@linux.ibm.com>
 <20221111125126.3319474-2-svens@linux.ibm.com>
 <20221111185331.GA725751@paulmck-ThinkPad-P17-Gen-1>
 <yt9dtu31k0r9.fsf@linux.ibm.com>
 <20221114163009.GE4001@paulmck-ThinkPad-P17-Gen-1>
 <yt9dzgcsiu4p.fsf@linux.ibm.com>
 <20221115134139.GI4001@paulmck-ThinkPad-P17-Gen-1>
 <yt9dr0y29jp3.fsf@linux.ibm.com>
 <20221117150637.GB4001@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117150637.GB4001@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 07:06:37AM -0800, Paul E. McKenney wrote:
> On Thu, Nov 17, 2022 at 07:30:32AM +0100, Sven Schnelle wrote:
> > Hi Paul,
> > 
> > "Paul E. McKenney" <paulmck@kernel.org> writes:
> > 
> > >> > Yes, rcutorture has lower-level checks for CPUs being hotplugged
> > >> > behind its back.  Which might be sufficient.  But this patch is in
> > >> > response to something bad happening if the CPU is also not present in
> > >> > the cpu_present_mask.  Would that same bad thing happen if rcutorture saw
> > >> > the CPU in cpu_online_mask, but by the time it attempted to CPU-hotplug
> > >> > it, that CPU was gone not just from cpu_online_mask, but also from
> > >> > cpu_present_mask?
> > >> >
> > >> > Or are CPUs never removed from cpu_present_mask?
> > >> 
> > >> In the current implementation CPUs can only be added to the
> > >> cpu_present_mask, but never removed. This might change in the future
> > >> when we get support from firmware for that, but the current s390 code
> > >> doesn't do that.
> > >
> > > Very good!
> > >
> > > Then could the patch please check that bits are never removed?
> > > That way the code will complain should firmware support be added.
> > >
> > > 							Thanx, Paul
> > 
> > I'm not sure whether i fully understand that. If the CPU could
> > be removed from the system and the cpu_present_mask, that could
> > happen at any time. So i don't see how we should check about that?
> 
> Well, that is my question to you.  ;-)
> 
> Suppose we have the following sequence of events:
> 
> o	rcutorture sees that CPU 5 is in cpu_present_mask, but offline.
> 
> o	rcutorture therefore decides to online CPU 5.
> 
> o	s390 firmware removes CPU 5, and s390 architecture code then
> 	clears it from the cpu_present_mask.
> 
> o	rcutorture proceeds with onlining CPU 5.
> 
> Don't we then get the same problem that prompted you to change from
> cpu_possible_mask to cpu_present mask?  If not, why can't the rcutorture
> code continue to use cpu_possible_mask?
> 
> If it really is bad to try to online or offline a CPU that is in
> cpu_possible_mask but not in cpu_present_mask, and if CPUs can be removed
> from cpu_present_mask, then we need some way to synchronize the removal
> of CPUs from cpu_present_mask.  There are of course a lot of possible
> ways to do that synchronization, for example, protecting cpu_present_mask
> with a mutex or similar.
> 
> Alternatively, s390 could restrict things.  One way to do that would
> be to turn off rcutorture's use of CPU hotplug when running on s390,
> for example, by using the module parameters provided for that purpose.
> Another way to do that would be to refrain from removing CPUs from
> cpu_present_mask while rcutorture is running.
> 
> Are there other approaches?

For the near term, why not have rcutorture keep a snapshot of
cpu_present_mask, and splat if a CPU is ever removed from that mask?

That would catch any issues, and defer any synchronization decisions to
a time at which we actually have some chance of knowing what is going on.

							Thanx, Paul

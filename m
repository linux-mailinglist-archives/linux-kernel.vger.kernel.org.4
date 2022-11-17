Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA6D62DEFE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 16:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234920AbiKQPGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 10:06:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbiKQPGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 10:06:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D693397;
        Thu, 17 Nov 2022 07:06:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2EC69B82082;
        Thu, 17 Nov 2022 15:06:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE419C433C1;
        Thu, 17 Nov 2022 15:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668697597;
        bh=jDF1meWT5LLs6tM5Fn0NkBlfnYPk4ji56PnzBPM4Tdc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=bVdyYII5L7baFCTHCQVnpNVgAxTfmWIIFWXTJYkcR0myTzx21AL4SMwIXIJGXYtDu
         1iYqekY/zBHMSnfrQFQKWDWdjjamnPssqzuIPuUVgdY/Ubdd7TFze4L64ASmMmU8yt
         clk/r644H45+p7NSX12L8iS28t/mBE/1RPOXj4whMjBD/6gvoiXY9VlFW1JI3EpGuX
         EFyQxQ3TzXtNc3wYrerXHv/xa9giEnp08okuJ8dYqhcDBgTZNkIBAc0pIs1qi7sBMe
         ZVTdQJ93ai4oDDyeg4Cf4Tlt4KMliq0wGUu3CgmBPD6WeMVRhtrMk0aG0FKqWTQAcb
         rdGmz6d1LHUFw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 83AC05C0521; Thu, 17 Nov 2022 07:06:37 -0800 (PST)
Date:   Thu, 17 Nov 2022 07:06:37 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH 1/2] torture: use for_each_present() loop in
 torture_online_all()
Message-ID: <20221117150637.GB4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221111125126.3319474-1-svens@linux.ibm.com>
 <20221111125126.3319474-2-svens@linux.ibm.com>
 <20221111185331.GA725751@paulmck-ThinkPad-P17-Gen-1>
 <yt9dtu31k0r9.fsf@linux.ibm.com>
 <20221114163009.GE4001@paulmck-ThinkPad-P17-Gen-1>
 <yt9dzgcsiu4p.fsf@linux.ibm.com>
 <20221115134139.GI4001@paulmck-ThinkPad-P17-Gen-1>
 <yt9dr0y29jp3.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yt9dr0y29jp3.fsf@linux.ibm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 07:30:32AM +0100, Sven Schnelle wrote:
> Hi Paul,
> 
> "Paul E. McKenney" <paulmck@kernel.org> writes:
> 
> >> > Yes, rcutorture has lower-level checks for CPUs being hotplugged
> >> > behind its back.  Which might be sufficient.  But this patch is in
> >> > response to something bad happening if the CPU is also not present in
> >> > the cpu_present_mask.  Would that same bad thing happen if rcutorture saw
> >> > the CPU in cpu_online_mask, but by the time it attempted to CPU-hotplug
> >> > it, that CPU was gone not just from cpu_online_mask, but also from
> >> > cpu_present_mask?
> >> >
> >> > Or are CPUs never removed from cpu_present_mask?
> >> 
> >> In the current implementation CPUs can only be added to the
> >> cpu_present_mask, but never removed. This might change in the future
> >> when we get support from firmware for that, but the current s390 code
> >> doesn't do that.
> >
> > Very good!
> >
> > Then could the patch please check that bits are never removed?
> > That way the code will complain should firmware support be added.
> >
> > 							Thanx, Paul
> 
> I'm not sure whether i fully understand that. If the CPU could
> be removed from the system and the cpu_present_mask, that could
> happen at any time. So i don't see how we should check about that?

Well, that is my question to you.  ;-)

Suppose we have the following sequence of events:

o	rcutorture sees that CPU 5 is in cpu_present_mask, but offline.

o	rcutorture therefore decides to online CPU 5.

o	s390 firmware removes CPU 5, and s390 architecture code then
	clears it from the cpu_present_mask.

o	rcutorture proceeds with onlining CPU 5.

Don't we then get the same problem that prompted you to change from
cpu_possible_mask to cpu_present mask?  If not, why can't the rcutorture
code continue to use cpu_possible_mask?

If it really is bad to try to online or offline a CPU that is in
cpu_possible_mask but not in cpu_present_mask, and if CPUs can be removed
from cpu_present_mask, then we need some way to synchronize the removal
of CPUs from cpu_present_mask.  There are of course a lot of possible
ways to do that synchronization, for example, protecting cpu_present_mask
with a mutex or similar.

Alternatively, s390 could restrict things.  One way to do that would
be to turn off rcutorture's use of CPU hotplug when running on s390,
for example, by using the module parameters provided for that purpose.
Another way to do that would be to refrain from removing CPUs from
cpu_present_mask while rcutorture is running.

Are there other approaches?

							Thanx, Paul

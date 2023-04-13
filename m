Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3426E143B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 20:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjDMSjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 14:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjDMSjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 14:39:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16FC340C2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 11:39:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1034640CF
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 18:39:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D49AFC433EF;
        Thu, 13 Apr 2023 18:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681411155;
        bh=JIauSLY/BSMNRsvFhlK4tRAvCgTk+6vep3D2bDRVtL0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=MB1zDmXvFrMhVQSOs4gkWOtVPdUn+QeG4eFc/JfRrYqVcDjW21+Bh7PZ0I71zMC8a
         iWoxqEsVLGnAl1Ol9jQMWC5Uj5QwgvXCt3tWcz6VwHaqCoPm9ejsqntE76QvJp55Te
         RI+iyfzAd2v7z7grGbJZ13i/BFRw+71lfgOP1PbeH5VUu8O5+aQ+t5OOcHJFRYLSly
         i8kvmY/Jmhll6d2mAWhbWtb7FmtccYUS3xl0EmS/xTgSvnni5BgrLPgjLG2PJgimXL
         tobtsgBUYmA7mzDUrZH2fOFyNtzhtrm3lT/hZtPc59L/G88v2sOP81Ax1O/80a4XXf
         RKiNHyUL1OlQQ==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 6DFA615404B3; Thu, 13 Apr 2023 11:39:15 -0700 (PDT)
Date:   Thu, 13 Apr 2023 11:39:15 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Waiman Long <longman@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: A couple of TSC questions
Message-ID: <c9680fe4-5f28-4436-84ee-472d1f5befb3@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <ZBqOyLByOgvdAve3@feng-clx>
 <acda3fb5-373a-48b1-b78e-eea18da4ccb0@paulmck-laptop>
 <ZCD9SnZSUCkE9Ss+@feng-clx>
 <aaf391d9-98e6-47d8-b402-c90b4a81ae9c@paulmck-laptop>
 <3daa086c-b4a0-47a9-8bfc-aac4139013c4@paulmck-laptop>
 <293db107-a572-592f-cc27-e59ab81a4e60@redhat.com>
 <ef61060d-9f40-4b44-9a51-026041fe75e1@paulmck-laptop>
 <d0be6b59-11ee-f899-19e5-b84eba003ac8@redhat.com>
 <b2436d38-771b-499d-b6a6-2c42a98df659@paulmck-laptop>
 <ZCrsrGLg53clGN9n@feng-clx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCrsrGLg53clGN9n@feng-clx>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 03, 2023 at 11:11:40PM +0800, Feng Tang wrote:
> On Sun, Apr 02, 2023 at 08:38:37PM -0700, Paul E. McKenney wrote:
> > On Sun, Apr 02, 2023 at 10:05:51PM -0400, Waiman Long wrote:
> > > On 4/2/23 22:00, Paul E. McKenney wrote:
> > > > On Sun, Apr 02, 2023 at 09:04:04PM -0400, Waiman Long wrote:
> > > > > On 3/31/23 13:16, Paul E. McKenney wrote:
> > > > > > On Tue, Mar 28, 2023 at 02:58:54PM -0700, Paul E. McKenney wrote:
> > > > > > > On Mon, Mar 27, 2023 at 10:19:54AM +0800, Feng Tang wrote:
> > > > > > > > On Fri, Mar 24, 2023 at 05:47:33PM -0700, Paul E. McKenney wrote:
> > > > > > > > > On Wed, Mar 22, 2023 at 01:14:48PM +0800, Feng Tang wrote:

[ . . . ]

> > > > > > And what we are seeing is unlikely to be due to cache-latency-induced
> > > > > > delays.  We see a very precise warp, for example, one system always
> > > > > > has 182 cycles of TSC warp, another 273 cycles, and a third 469 cycles.
> > > > > > Another is at the insanely large value of about 2^64/10, and shows some
> > > > > > variation, but that variation is only about 0.1%.
> > > > > > 
> > > > > > But any given system only sees warp on about half of its reboots.
> > > > > > Perhaps due to the automation sometimes power cycling?
> > > > > > 
> > > > > > There are few enough affected systems that investigation will take
> > > > > > some time.
> > > > > Maybe the difference in wrap is due to NUMA distance of the running cpu from
> > > > > the node where the data reside. It will be interesting to see if my patch
> > > > > helps.
> > > > Almost all of them are single-socket systems.
> 
> Interesting to know. I thought most of the TSC sync problems happen
> in multiple socket system. IIRC, Waiman mentioned his platform is a
> Cooper Lake which is for 4S or 8S platform, also Thomas and Peter
> mentioned tsc sync issue on 8S platforms in other threads.
> 
> And your consistent warp of 182 (91 * 2) and 273 (91 * 3) cycles sound
> like 'artificial' :), maybe the TSC_ADJUST MSR was programmed by BIOS
> or other firmware?

And all but one of them is almost assuredly a firmware issue.  But not
an Intel firmware issue, so there is that.  And in that case, the kernel
is doing what it should, yelling about a real problem.

The other is an Intel system, but is a one-off, with other ostensibly
identical systems doing just fine.  So it is likely simply a case of
dying hardware.  I will look closer when I return.

I will be on travel this coming week starting tomorrow (Friday),
Pacific Time.  There may be substantial intervals when I am completely
off the grid.

Have a great week!!!

							Thanx, Paul

> Thanks,
> Feng
> 
> > > > 
> > > > If the problem sticks with a few systems, I should be able to test
> > > > patches no problem.  If it is randomly distributed across the fleet, a
> > > > bit more prework analysis will be called for.  But what is life without
> > > > a challenge?  ;-)
> > > 
> > > If it is happening on a single socket system, maybe it is caused by false
> > > cacheline sharing. It is hard to tell unless we find a way to reproduce it.
> > 
> > But multiple times on a given system with exactly the same number of
> > clock cycles of warp each time?  It should be entertaining tracking this
> > one down.  ;-)
> > 
> > I will take a few scans of the fleet over the coming week and see if
> > there is any consistency.  Here is hoping...
> > 
> > 							Thanx, Paul

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5296D3BA2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 04:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbjDCCAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 22:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjDCCAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 22:00:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D619B769B
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 19:00:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 82A02B8109E
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 02:00:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25BB6C433EF;
        Mon,  3 Apr 2023 02:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680487249;
        bh=NbsL0OwUliS+BxW4P3bSbGX+DJ09pBzPxPq3F28QNj4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=pC9Pbd2zZoBVa0yHP/yV4KEQX//WwYakUhZHX5NNzg4XWBpvyslFipoYwdHaYQ8Ii
         2yKaUGS2+lG4flp0y8NqcNxSfoTySwLRWk5HXlG3TDaIn/GcoY6aL1yZq1UNrdSsjn
         KM+Th9d6UmsVI4dlutld2ZuHY6m2oHshhLJubJSYJxZb3DKsFSoSO6lA+lnIjJBviS
         nZih+AKqPMPRU9JYvloCLh+G/sS0Pfjr74Bcb3X5kLqMKc7bVmUm+p9ftcPgJI8dhH
         /62UCHWikYn06hK37M1I9Y+j53JZH5kXaUeY+d8fId5aQVI+ITUQjshrSW2ysT4d8U
         qenN3qQdwhVmw==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id B3DA6154047C; Sun,  2 Apr 2023 19:00:48 -0700 (PDT)
Date:   Sun, 2 Apr 2023 19:00:48 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Feng Tang <feng.tang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: A couple of TSC questions
Message-ID: <ef61060d-9f40-4b44-9a51-026041fe75e1@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <b2f07f18-b60b-403b-90ff-937ea32963ee@paulmck-laptop>
 <ZBqOyLByOgvdAve3@feng-clx>
 <acda3fb5-373a-48b1-b78e-eea18da4ccb0@paulmck-laptop>
 <ZCD9SnZSUCkE9Ss+@feng-clx>
 <aaf391d9-98e6-47d8-b402-c90b4a81ae9c@paulmck-laptop>
 <3daa086c-b4a0-47a9-8bfc-aac4139013c4@paulmck-laptop>
 <293db107-a572-592f-cc27-e59ab81a4e60@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <293db107-a572-592f-cc27-e59ab81a4e60@redhat.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 02, 2023 at 09:04:04PM -0400, Waiman Long wrote:
> 
> On 3/31/23 13:16, Paul E. McKenney wrote:
> > On Tue, Mar 28, 2023 at 02:58:54PM -0700, Paul E. McKenney wrote:
> > > On Mon, Mar 27, 2023 at 10:19:54AM +0800, Feng Tang wrote:
> > > > On Fri, Mar 24, 2023 at 05:47:33PM -0700, Paul E. McKenney wrote:
> > > > > On Wed, Mar 22, 2023 at 01:14:48PM +0800, Feng Tang wrote:
> > [ . . . ]
> > 
> > > > > > > Second, we are very occasionally running into console messages like this:
> > > > > > > 
> > > > > > > Measured 2 cycles TSC warp between CPUs, turning off TSC clock.
> > > > > > > 
> > > > > > > This comes from check_tsc_sync_source() and indicates that one CPU's
> > > > > > > TSC read produced a later time than a later read from some other CPU.
> > > > > > > I am beginning to suspect that these can be caused by unscheduled delays
> > > > > > > in the TSC synchronization code, but figured I should ask you if you have
> > > > > > > ever seen these.  And of course, if so, what the usual causes might be.
> > > > > > I haven't seen this error myself or got similar reports. Usually it
> > > > > > should be easy to detect once happened, as falling back to HPET
> > > > > > will trigger obvious performance degradation.
> > > > > And that is exactly what happened.  ;-)
> > > > > 
> > > > > > Could you give more detail about when and how it happens, and the
> > > > > > HW info like how many sockets the platform has.
> > > > > We are in early days, so I am checking for other experiences.
> > > > > 
> > > > > > CC Thomas, Waiman, as they discussed simliar case here:
> > > > > > https://lore.kernel.org/lkml/87h76ew3sb.ffs@tglx/T/#md4d0a88fb708391654e78312ffa75b481690699f
> > > > > Fun!  ;-)
> > > Waiman, do you recall what fraction of the benefit was provided by the
> > > first patch, that is, the one that grouped the sync_lock, last_tsc,
> > > max_warp, nr_warps, and random_warps global variables into a single
> > > struct?
> 
> The purpose of the first patch is just to avoid false cacheline sharing
> between the watchdog cpu and another cpu that happens to access a nearby
> data in the same cacheline.
> 
> Now I realize that I should have followed up with this patch series. The
> problem reported in that patch series happen on one system only, I believe.

Thus far I am seeing eight systems, but out of a large number.  So this
is very much preliminary.

> > And what we are seeing is unlikely to be due to cache-latency-induced
> > delays.  We see a very precise warp, for example, one system always
> > has 182 cycles of TSC warp, another 273 cycles, and a third 469 cycles.
> > Another is at the insanely large value of about 2^64/10, and shows some
> > variation, but that variation is only about 0.1%.
> > 
> > But any given system only sees warp on about half of its reboots.
> > Perhaps due to the automation sometimes power cycling?
> > 
> > There are few enough affected systems that investigation will take
> > some time.
> 
> Maybe the difference in wrap is due to NUMA distance of the running cpu from
> the node where the data reside. It will be interesting to see if my patch
> helps.

Almost all of them are single-socket systems.

If the problem sticks with a few systems, I should be able to test
patches no problem.  If it is randomly distributed across the fleet, a
bit more prework analysis will be called for.  But what is life without
a challenge?  ;-)

							Thanx, Paul

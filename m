Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5FD6D3C2D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 05:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbjDCDir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 23:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbjDCDin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 23:38:43 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 335FA8A55
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 20:38:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 187FCCE0E9A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 03:38:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BFABC433EF;
        Mon,  3 Apr 2023 03:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680493118;
        bh=YG0HLmOg1AwXo9vc4n8opH1/k+AHcpd/p8Qd4KDGf0o=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=KepNx+6UjLcJOYFZAdxE8VjgWXgUmYqt+zbhMdFzBgquOaNzDYmHXln2roIbWYwI4
         V/jFlzW9omx+3uY6elGqx0QMPYC4UUqOnlTu6fEPF9f+IeN7Ei2ObIumSVzBmo1Np/
         V56/XaNimp+IHbd+7BLZKVjCg7HWyEYoUY4XjTpK+E5dZ4HJsb1aD6DggaVH8tOstm
         UXAdbTxXUckN24qfMaJD9CCzrvwJEV0ttABIIp3ih/rG2C3jGm9V8XaMDST8adu9bX
         GdAa9Q3PLsqFNSwC/S0GhwukWdn/Np6Y6EsiKmwSqvTgdRaI94fAw74EbumZnyPlwg
         18sKm5RPLPBXQ==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id B76B1154047C; Sun,  2 Apr 2023 20:38:37 -0700 (PDT)
Date:   Sun, 2 Apr 2023 20:38:37 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Feng Tang <feng.tang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: A couple of TSC questions
Message-ID: <b2436d38-771b-499d-b6a6-2c42a98df659@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <b2f07f18-b60b-403b-90ff-937ea32963ee@paulmck-laptop>
 <ZBqOyLByOgvdAve3@feng-clx>
 <acda3fb5-373a-48b1-b78e-eea18da4ccb0@paulmck-laptop>
 <ZCD9SnZSUCkE9Ss+@feng-clx>
 <aaf391d9-98e6-47d8-b402-c90b4a81ae9c@paulmck-laptop>
 <3daa086c-b4a0-47a9-8bfc-aac4139013c4@paulmck-laptop>
 <293db107-a572-592f-cc27-e59ab81a4e60@redhat.com>
 <ef61060d-9f40-4b44-9a51-026041fe75e1@paulmck-laptop>
 <d0be6b59-11ee-f899-19e5-b84eba003ac8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0be6b59-11ee-f899-19e5-b84eba003ac8@redhat.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 02, 2023 at 10:05:51PM -0400, Waiman Long wrote:
> On 4/2/23 22:00, Paul E. McKenney wrote:
> > On Sun, Apr 02, 2023 at 09:04:04PM -0400, Waiman Long wrote:
> > > On 3/31/23 13:16, Paul E. McKenney wrote:
> > > > On Tue, Mar 28, 2023 at 02:58:54PM -0700, Paul E. McKenney wrote:
> > > > > On Mon, Mar 27, 2023 at 10:19:54AM +0800, Feng Tang wrote:
> > > > > > On Fri, Mar 24, 2023 at 05:47:33PM -0700, Paul E. McKenney wrote:
> > > > > > > On Wed, Mar 22, 2023 at 01:14:48PM +0800, Feng Tang wrote:
> > > > [ . . . ]
> > > > 
> > > > > > > > > Second, we are very occasionally running into console messages like this:
> > > > > > > > > 
> > > > > > > > > Measured 2 cycles TSC warp between CPUs, turning off TSC clock.
> > > > > > > > > 
> > > > > > > > > This comes from check_tsc_sync_source() and indicates that one CPU's
> > > > > > > > > TSC read produced a later time than a later read from some other CPU.
> > > > > > > > > I am beginning to suspect that these can be caused by unscheduled delays
> > > > > > > > > in the TSC synchronization code, but figured I should ask you if you have
> > > > > > > > > ever seen these.  And of course, if so, what the usual causes might be.
> > > > > > > > I haven't seen this error myself or got similar reports. Usually it
> > > > > > > > should be easy to detect once happened, as falling back to HPET
> > > > > > > > will trigger obvious performance degradation.
> > > > > > > And that is exactly what happened.  ;-)
> > > > > > > 
> > > > > > > > Could you give more detail about when and how it happens, and the
> > > > > > > > HW info like how many sockets the platform has.
> > > > > > > We are in early days, so I am checking for other experiences.
> > > > > > > 
> > > > > > > > CC Thomas, Waiman, as they discussed simliar case here:
> > > > > > > > https://lore.kernel.org/lkml/87h76ew3sb.ffs@tglx/T/#md4d0a88fb708391654e78312ffa75b481690699f
> > > > > > > Fun!  ;-)
> > > > > Waiman, do you recall what fraction of the benefit was provided by the
> > > > > first patch, that is, the one that grouped the sync_lock, last_tsc,
> > > > > max_warp, nr_warps, and random_warps global variables into a single
> > > > > struct?
> > > The purpose of the first patch is just to avoid false cacheline sharing
> > > between the watchdog cpu and another cpu that happens to access a nearby
> > > data in the same cacheline.
> > > 
> > > Now I realize that I should have followed up with this patch series. The
> > > problem reported in that patch series happen on one system only, I believe.
> > Thus far I am seeing eight systems, but out of a large number.  So this
> > is very much preliminary.
> > 
> > > > And what we are seeing is unlikely to be due to cache-latency-induced
> > > > delays.  We see a very precise warp, for example, one system always
> > > > has 182 cycles of TSC warp, another 273 cycles, and a third 469 cycles.
> > > > Another is at the insanely large value of about 2^64/10, and shows some
> > > > variation, but that variation is only about 0.1%.
> > > > 
> > > > But any given system only sees warp on about half of its reboots.
> > > > Perhaps due to the automation sometimes power cycling?
> > > > 
> > > > There are few enough affected systems that investigation will take
> > > > some time.
> > > Maybe the difference in wrap is due to NUMA distance of the running cpu from
> > > the node where the data reside. It will be interesting to see if my patch
> > > helps.
> > Almost all of them are single-socket systems.
> > 
> > If the problem sticks with a few systems, I should be able to test
> > patches no problem.  If it is randomly distributed across the fleet, a
> > bit more prework analysis will be called for.  But what is life without
> > a challenge?  ;-)
> 
> If it is happening on a single socket system, maybe it is caused by false
> cacheline sharing. It is hard to tell unless we find a way to reproduce it.

But multiple times on a given system with exactly the same number of
clock cycles of warp each time?  It should be entertaining tracking this
one down.  ;-)

I will take a few scans of the fleet over the coming week and see if
there is any consistency.  Here is hoping...

							Thanx, Paul

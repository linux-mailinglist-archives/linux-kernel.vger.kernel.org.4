Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 704DF64E350
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 22:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiLOVjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 16:39:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiLOVjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 16:39:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB25E2BB21;
        Thu, 15 Dec 2022 13:39:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 67DCF61F26;
        Thu, 15 Dec 2022 21:39:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2FADC433EF;
        Thu, 15 Dec 2022 21:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671140340;
        bh=KLN4u/CdDUK5RCz8K9nt56ZrKSnN4zE+POw0bXmlcTY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=f84yWDjmxw4Wk21gxFCvLpp1CpBdO6kK9BN73rgQ442W+IZjdO/1l+gksPzbJMOEZ
         sUhC8UnNVS1KZGe58WXjQvWfGybbwpVu+1In1QMMlzqClx/mfT8waHdskqr8r/hCz0
         DpYW3sbeUwtkXyaJEKFIc1nFzjTpvAlkXej3HuK9ad7wmW/oMLbdPUY60I/Tr0Qagw
         jhZlYt/QrLNJBbfxFmsOg2ZwCUIfRZtKKm0ctvYpwa36pkldC/Np7/D4SLIC2WZpNd
         PzfvMO8zhEOc/to3+Ubdgji1WGAIU8AFLwbS9AxwVYlKoHo5iCFD+d4fYKeU+hzB8W
         BMNBEIS6jydbw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 6351B5C1C5B; Thu, 15 Dec 2022 13:39:00 -0800 (PST)
Date:   Thu, 15 Dec 2022 13:39:00 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>, boqun.feng@gmail.com,
        neeraj.iitr10@gmail.com, urezki@gmail.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] srcu: Yet more detail for
 srcu_readers_active_idx_check() comments
Message-ID: <20221215213900.GQ4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221214191355.GA2596199@paulmck-ThinkPad-P17-Gen-1>
 <20221215165452.GA1957735@lothringen>
 <20221215170834.GH4001@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YTSW9kr3DsJm6hTQ0FfwVbVjzDa8=7H29+ysD10ZCbnHA@mail.gmail.com>
 <20221215195854.GL4001@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YSnwXA6Bn3Av3O0Tm=AnqKULGZJBA3Z7ZaLE814XABU6g@mail.gmail.com>
 <CAEXW_YSGWgkesu7xz8HXVmH82=uN1ESUdPs2Qtkv4isNjGy-Ww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YSGWgkesu7xz8HXVmH82=uN1ESUdPs2Qtkv4isNjGy-Ww@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2022 at 03:33:39PM -0500, Joel Fernandes wrote:
> On Thu, Dec 15, 2022 at 3:03 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> >
> > Hi Paul,
> >
> > On Thu, Dec 15, 2022 at 2:58 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > [...]
> > > > If the first read section's srcu_read_unlock() and its corresponding
> > > > smp_mb()  happened before the flip, then the increment of old idx
> > > > would happen only once. The next srcu_read_lock() will read the new
> > > > index. If the srcu_read_unlock() and it's corresponding smp_mb()
> > > > happened after the flip, the old_idx will be sampled again and can be
> > > > incremented twice. So it depends on how the flip races with
> > > > srcu_read_unlock().
> > >
> > > I do understand that a number of people like reasoning about
> > > memory-barrier ordering, courtesy of the sequentially consistent portions
> > > of the C and C++ memory models, but thinking in terms of the accesses
> > > surrounding the memory barriers has been far less error-prone.
> >
> > Sure, but we are already talking in terms of the access to idx right?
> > That's what we're saying is visible by memory barriers and we are
> > trying to reason here about the ordering (flip does the write to idx
> > and followed by smp_mb(), and there is corresponding read of idx on
> > the srcu_read_lock() side. So we are indeed talking in terms of
> > access, but let me know if I missed something.
> >
> > > > Also, since this is all hard to reason about I started making some
> > > > diagrams, LOL. For your amusement, here is why need to scan both idx
> > > > during grace period detection: https://i.imgur.com/jz4bNKd.png
> > >
> > > Nice!
> > >
> > > I suggest placing a gap between GP 2 and GP 3.  That way, you can make it
> > > very clear that Reader 1's critical section starts after the end of GP 2
> > > (thus clearly never blocking GP 2) and before GP 3 (thus possibly having
> > > a reference to some data that is going to be freed at the end of GP 3).
> > >
> > > I also suggest coloring Reader 1 red and Reader 2 green, given that the
> > > color red generally indicates danger.
> >
> > Thanks for these suggestions! I will make the update. I am planning to
> > make a number of diagrams for other scenarios as well, as it helps
> > visualize. Google drawing is nice for these. I am happy to share these
> > with you all if there is interest :).
> 
> I made these updates, please see: https://i.imgur.com/hoKLvtt.png
> 
> Feel free to use the image for any purpose and thanks ;-)

Very good, thank you!

Would it be possible to have an arrow marked "X" or "reference to X"
from the beginning of the 'Mark "x" for GC' box to the box labeled
'Enter RSCS (access "X")'?

							Thanx, Paul

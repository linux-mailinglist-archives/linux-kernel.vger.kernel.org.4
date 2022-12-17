Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 300A364F7C8
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 06:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbiLQFP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 00:15:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiLQFPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 00:15:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5CF06E9E6;
        Fri, 16 Dec 2022 21:15:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F0A1C60921;
        Sat, 17 Dec 2022 05:15:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5474AC433EF;
        Sat, 17 Dec 2022 05:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671254120;
        bh=radMw15X9qeTFbbSlTf0SfWRvZQR4SUmgAmlVZ0Dkks=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=TJElZYcw3WiLt+sFW2jJLAOm3NFnqwNLphQxnt9FqgBzoWmsSztEcekEiRpJRxFsJ
         p8jF5bKJUqioud7G4QhfgvmnnpIywDSRh5z1/76AEaiZ2tgeHVyr4ga6wMA/maMmHN
         llRMDp2zjz1YWijfTk/vUVyOQcnhVJIA/m3MYD82dktDvCbrUWEig2oJdtxtqttRX3
         GObFol9HdasJJcALoj5grsaPUnGrFnfrhzIoU/hfk/YcCNo7vOLkmksZSgjUp8ygef
         D4i6RXQ9pnfw8H8AS6o7mu0e0yrDELGE8On7RKlI/FdtrwnS8ApyVXJBSgH5skWytg
         zy2nvdJRU0+Cw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id EC0D55C0A2D; Fri, 16 Dec 2022 21:15:19 -0800 (PST)
Date:   Fri, 16 Dec 2022 21:15:19 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>, boqun.feng@gmail.com,
        neeraj.iitr10@gmail.com, urezki@gmail.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] srcu: Yet more detail for
 srcu_readers_active_idx_check() comments
Message-ID: <20221217051519.GI4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221216165144.GA4001@paulmck-ThinkPad-P17-Gen-1>
 <54F1102C-2577-4238-83B3-D38BA7ED9087@joelfernandes.org>
 <CAEXW_YTkeGVJZQCJ-_3ez_BpeMJ0TOYONCv_g76MDh5=M+9x_Q@mail.gmail.com>
 <CAEXW_YSueD31wcNA_=YNiWJfZ80TBypYEXUAwg_XedzRvQ+5HA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEXW_YSueD31wcNA_=YNiWJfZ80TBypYEXUAwg_XedzRvQ+5HA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2022 at 10:21:25PM -0500, Joel Fernandes wrote:
> On Fri, Dec 16, 2022 at 10:19 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> >
> > Hi,
> > On the related subject of this function, I drew a diagram for one of
> > the reasons why per-CPU unlock counts have to be scanned first, for a
> > particular index, before the per-CPU lock counts, and not the other
> > way. Otherwise, a reader that got preempted after reading the index,
> > can suddenly get scheduled during the inactive index's scan, and cause
> > the total lock and unlock counts to falsely match:
> > https://i.imgur.com/79fDWdQ.png
> 
> Better diagram: https://i.imgur.com/PXKJnmW.png
> (Added the preemption reasoning for Reader 0).

Nice!!!

The other way to look at this is using a memory-ordering viewpoint.
This is a member of the message-passing litmus-test family, and the reader
must read the variables in the opposite order that the writer writes them.

(See the infamous test6.pdf file, "MP" pattern.)

							Thanx, Paul

> thanks,
> 
>  - Joel
> 
> 
> > Cheers,
> >
> >  - Joel
> >
> >
> >
> > On Fri, Dec 16, 2022 at 11:54 AM Joel Fernandes <joel@joelfernandes.org> wrote:
> > >
> > >
> > >
> > > > On Dec 16, 2022, at 11:51 AM, Paul E. McKenney <paulmck@kernel.org> wrote:
> > > >
> > > > ﻿On Fri, Dec 16, 2022 at 04:32:39PM +0000, Joel Fernandes wrote:
> > > >> On Thu, Dec 15, 2022 at 05:09:14PM -0800, Paul E. McKenney wrote:
> > > >> [...]
> > > >>>>>> 2. unlock()'s smp_mb() happened before Flip+smp_mb() , now the reader
> > > >>>>>> has no new smp_mb() that happens AFTER the flip happened. So it can
> > > >>>>>> totally sample the old idx again -- that particular reader will
> > > >>>>>> increment twice, but the next time, it will see the flipped one.
> > > >>>>>
> > > >>>>> I will let you transliterate both.  ;-)
> > > >>>>
> > > >>>> I think I see what you mean now :)
> > > >>>>
> > > >>>> I believe the access I am referring to is the read of idx on one side and
> > > >>>> the write to idx on the other. However that is incomplete and I need to
> > > >>>> pair that with some of other access on both sides.
> > > >>>>
> > > >>>> So perhaps this:
> > > >>>>
> > > >>>> Writer does flip + smp_mb + read unlock counts [1]
> > > >>>>
> > > >>>> Reader does:
> > > >>>> read idx + smp_mb() + increment lock counts [2]
> > > >>>>
> > > >>>> And subsequently reader does
> > > >>>> Smp_mb() + increment unlock count. [3]
> > > >>>>
> > > >>>> So [1] races with either [2] or [2]+[3].
> > > >>>>
> > > >>>> Is that fair?
> > > >>>
> > > >>> That does look much better, thank you!
> > > >>
> > > >> Perhaps a comment with an ASCII diagram will help?
> > > >>
> > > >>
> > > >> Case 2:
> > > >> Both the reader and the updater see each other's writes too late, but because
> > > >> of memory barriers on both sides, they will eventually see each other's write
> > > >> with respect to their own. This is similar to the store-buffer problem. This
> > > >> let's a single reader contribute a maximum (unlock minus lock) imbalance of 2.
> > > >>
> > > >> The following diagram shows the subtle worst case followed by a simplified
> > > >> store-buffer explanation.
> > > >>
> > > >> READER                  UPDATER
> > > >> -------------           ----------
> > > >>                           // idx is initially 0.
> > > >> read_lock() {
> > > >>  READ(idx) = 0;
> > > >>  lock[0]++; --------------------------------------------,
> > > >>                           flip() {                      |
> > > >>                              smp_mb();                  |
> > > >>  smp_mb();                                              |
> > > >> }                                                        |
> > > >>                                                         |
> > > >> // RSCS                                                  |
> > > >>                                                         |
> > > >> read_unlock() {                                          |
> > > >>  smp_mb();                                              |
> > > >>                              idx++;  // P               |
> > > >>                              smp_mb();                  |
> > > >>                           }                             |
> > > >>                                                         |
> > > >>                           scan_readers_idx(0) {         |
> > > >>                               count all unlock[0];      |
> > > >>                                   |                     |
> > > >>                                   |                     |
> > > >>  unlock[0]++; //X <--not-counted--`-----,               |
> > > >>                                         |               |
> > > >> }                                        V               `------,
> > > >>                               // Will make sure next scan      |
> > > >>                               // will not miss this unlock (X) |
> > > >>                               // if other side saw flip (P) ,--`
> > > >>                               // Call this MB [1]           |
> > > >>                               // Order write(idx) with      |
> > > >>                               // next scan's unlock.        |
> > > >>                               smp_mb();                 ,---`
> > > >> read_lock() {                                            |
> > > >>  READ(idx)=0;                                           |
> > > >>  lock[0]++; ----------------> count all lock[0];        |
> > > >>  smp_mb();         |     }                              |
> > > >> }     |             |                                    V
> > > >>      |             `---> // Incorrect contribution to lock counting
> > > >>      |                   // upto a maximum of 2 times.
> > > >>      |
> > > >>       `---> // Pairs with MB [1]. Makes sure that
> > > >>             // the next read_lock()'s' idx read (Y) is ordered
> > > >>             // with above write to unlock[0] (X).
> > > >>                            |
> > > >> rcu_read_unlock() {         |
> > > >>  smp_mb(); <---------------`
> > > >>  unlock[0]++;
> > > >> }
> > > >>
> > > >> read_lock() {
> > > >>  READ(idx) = 1; //Y
> > > >>  lock[1]++;
> > > >>  ...
> > > >> }
> > > >>                           scan_readers_idx(0) {
> > > >>                               count all unlock[0]; //Q
> > > >>                               ...
> > > >>
> > > >>
> > > >> thanks,
> > > >>
> > > >> - Joel
> > > >>
> > > >>                          }
> > > >>
> > > >> This makes it similar to the store buffer pattern. Using X, Y, P and Q
> > > >> annotated above, we get:
> > > >>
> > > >> READER                    UPDATER
> > > >> X (write)                 P (write)
> > > >>
> > > >> smp_mb();                 smp_mb();
> > > >>
> > > >> Y (read)                  Q (read)
> > > >
> > > > Given that this diagram is more than 50 lines long, it might go better in
> > > > a design document describing this part of RCU.  Perhaps less detail or
> > > > segmented, but the same general idea as this guy:
> > > >
> > > > Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
> > >
> > > Yes, this sounds like a good place to add it and perhaps we refer to it from the C source file? I can take this up to do over the holidays, if you prefer.
> > >
> > > Thanks,
> > >
> > >   - Joel
> > >
> > >
> > > >
> > > > Thoughts?
> > > >
> > > >                        Thanx, Paul

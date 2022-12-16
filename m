Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85E4064F020
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 18:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbiLPROB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 12:14:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbiLPRN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 12:13:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B863D6F486;
        Fri, 16 Dec 2022 09:13:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5618D61FD7;
        Fri, 16 Dec 2022 17:13:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADAC8C43392;
        Fri, 16 Dec 2022 17:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671210833;
        bh=Ak/KrxWAvOEGVghN8qPaao3p3gxmWCwZ3TbtWtqLEss=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Y83nK8Pe0WSMx5wUME8cdVo9TlXuMvitz9j1r8ztbcdAq31xiN3aXcvOq+I6dtRlL
         7Gadqf44vdHjfcBYiF4h6MN84u6QzzswYYq5CUa7hotFarC8Ajp8pWqXk65lkhZ5Ps
         7qBLp5MTJeOhPgGfV6YlGkZP5duV8qEZzTXewzz/r/ZdqowWay9cD574Y6kpKN/XOB
         iX2KcRCcCm3SYuYnj6fRILh0P0DpBno7Fn4NOco5T+4otWqByZc+58sUTAaRpBe0cw
         /NKNaYW3dAlgrzNw+fZOWP1NzOHoVbiEQApIGDE3cRsexcG7AqRrUr8XGacV8vYaIt
         jXyVPTYrscDCw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 4CBEB5C0AC7; Fri, 16 Dec 2022 09:13:53 -0800 (PST)
Date:   Fri, 16 Dec 2022 09:13:53 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>, boqun.feng@gmail.com,
        neeraj.iitr10@gmail.com, urezki@gmail.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] srcu: Yet more detail for
 srcu_readers_active_idx_check() comments
Message-ID: <20221216171353.GC4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221216165144.GA4001@paulmck-ThinkPad-P17-Gen-1>
 <54F1102C-2577-4238-83B3-D38BA7ED9087@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <54F1102C-2577-4238-83B3-D38BA7ED9087@joelfernandes.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2022 at 11:54:19AM -0500, Joel Fernandes wrote:
> 
> 
> > On Dec 16, 2022, at 11:51 AM, Paul E. McKenney <paulmck@kernel.org> wrote:
> > 
> > ﻿On Fri, Dec 16, 2022 at 04:32:39PM +0000, Joel Fernandes wrote:
> >> On Thu, Dec 15, 2022 at 05:09:14PM -0800, Paul E. McKenney wrote:
> >> [...]
> >>>>>> 2. unlock()'s smp_mb() happened before Flip+smp_mb() , now the reader
> >>>>>> has no new smp_mb() that happens AFTER the flip happened. So it can
> >>>>>> totally sample the old idx again -- that particular reader will
> >>>>>> increment twice, but the next time, it will see the flipped one.
> >>>>> 
> >>>>> I will let you transliterate both.  ;-)
> >>>> 
> >>>> I think I see what you mean now :)
> >>>> 
> >>>> I believe the access I am referring to is the read of idx on one side and
> >>>> the write to idx on the other. However that is incomplete and I need to
> >>>> pair that with some of other access on both sides.
> >>>> 
> >>>> So perhaps this:
> >>>> 
> >>>> Writer does flip + smp_mb + read unlock counts [1]
> >>>> 
> >>>> Reader does:
> >>>> read idx + smp_mb() + increment lock counts [2]
> >>>> 
> >>>> And subsequently reader does
> >>>> Smp_mb() + increment unlock count. [3]
> >>>> 
> >>>> So [1] races with either [2] or [2]+[3].
> >>>> 
> >>>> Is that fair?
> >>> 
> >>> That does look much better, thank you!
> >> 
> >> Perhaps a comment with an ASCII diagram will help?
> >> 
> >> 
> >> Case 2:
> >> Both the reader and the updater see each other's writes too late, but because
> >> of memory barriers on both sides, they will eventually see each other's write
> >> with respect to their own. This is similar to the store-buffer problem. This
> >> let's a single reader contribute a maximum (unlock minus lock) imbalance of 2.
> >> 
> >> The following diagram shows the subtle worst case followed by a simplified
> >> store-buffer explanation.
> >> 
> >> READER                  UPDATER
> >> -------------           ----------
> >>                           // idx is initially 0.
> >> read_lock() {
> >>  READ(idx) = 0;
> >>  lock[0]++; --------------------------------------------,
> >>                           flip() {                      |               
> >>                              smp_mb();                  |
> >>  smp_mb();                                              |
> >> }                                                        |
> >>                                                         |
> >> // RSCS                                                  |
> >>                                                         |
> >> read_unlock() {                                          |
> >>  smp_mb();                                              |
> >>                              idx++;  // P               |
> >>                              smp_mb();                  |
> >>                           }                             |
> >>                                                         |
> >>                           scan_readers_idx(0) {         |
> >>                               count all unlock[0];      |
> >>                                   |                     |
> >>                                   |                     |
> >>  unlock[0]++; //X <--not-counted--`-----,               |
> >>                                         |               |
> >> }                                        V               `------,
> >>                               // Will make sure next scan      |
> >>                               // will not miss this unlock (X) |
> >>                               // if other side saw flip (P) ,--`
> >>                               // Call this MB [1]           |
> >>                               // Order write(idx) with      |
> >>                               // next scan's unlock.        |
> >>                               smp_mb();                 ,---`
> >> read_lock() {                                            |
> >>  READ(idx)=0;                                           |
> >>  lock[0]++; ----------------> count all lock[0];        |
> >>  smp_mb();         |     }                              |
> >> }     |             |                                    V
> >>      |             `---> // Incorrect contribution to lock counting
> >>      |                   // upto a maximum of 2 times.
> >>      |
> >>       `---> // Pairs with MB [1]. Makes sure that
> >>             // the next read_lock()'s' idx read (Y) is ordered
> >>             // with above write to unlock[0] (X).
> >>                            |
> >> rcu_read_unlock() {         |
> >>  smp_mb(); <---------------`
> >>  unlock[0]++; 
> >> }
> >> 
> >> read_lock() {
> >>  READ(idx) = 1; //Y
> >>  lock[1]++;
> >>  ...
> >> }
> >>                           scan_readers_idx(0) {
> >>                               count all unlock[0]; //Q
> >>                               ...
> >> 
> >> 
> >> thanks,
> >> 
> >> - Joel
> >> 
> >>                          }
> >> 
> >> This makes it similar to the store buffer pattern. Using X, Y, P and Q
> >> annotated above, we get:
> >> 
> >> READER                    UPDATER
> >> X (write)                 P (write)
> >> 
> >> smp_mb();                 smp_mb();
> >> 
> >> Y (read)                  Q (read)
> > 
> > Given that this diagram is more than 50 lines long, it might go better in
> > a design document describing this part of RCU.  Perhaps less detail or
> > segmented, but the same general idea as this guy:
> > 
> > Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
> 
> Yes, this sounds like a good place to add it and perhaps we refer to
> it from the C source file? I can take this up to do over the holidays,
> if you prefer.

Indeed, that comment is quite large already, arguably obscuring the code!
It would be good to offload some of it.

							Thanx, Paul

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63E9867BF6B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 22:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjAYV6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 16:58:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjAYV6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 16:58:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EAFC59FC
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 13:58:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4271B614DD
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 21:58:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BF31C433D2;
        Wed, 25 Jan 2023 21:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674683898;
        bh=n0Tong2K39UUp38S+THBPGYw/GEG7tq/pt1VrkScrtk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Vx4yN7NyB2l1FJd5HVgpLk82M9l7rfZXd4V/RhpqAcWr3kkorxw45zvOUQGGQD8GR
         MgClY4w7+dai8gh+gTYgILLuAGNHE6cvKFYyaQU4Io76w6QAOxdG0bz5APU6fr8KKN
         0o6Zaxpm0lpieyGLtYK4P2RSB/94JgKTJxOUHpR9F3SzMvAM/JtrJP/XFU4Rv7ecOc
         jf6pl6cO61sastdB851qHgRmnkLjNuCOb/+c/B6sCCZ1XAFX+u37AmcOFeNVPMeCF5
         0xMelSv+7r+ZmLs/IcrS/rP/p0LohbrSJeGkIp7IQpMnuMx/y0zJdRyR7zdqvWknGA
         iLfTwrWGoSwlQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 27C1E5C0865; Wed, 25 Jan 2023 13:58:18 -0800 (PST)
Date:   Wed, 25 Jan 2023 13:58:18 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Jonas Oberhauser <jonas.oberhauser@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>, will <will@kernel.org>,
        "boqun.feng" <boqun.feng@gmail.com>, npiggin <npiggin@gmail.com>,
        dhowells <dhowells@redhat.com>,
        "j.alglave" <j.alglave@ucl.ac.uk>,
        "luc.maranget" <luc.maranget@inria.fr>, akiyks <akiyks@gmail.com>,
        dlustig <dlustig@nvidia.com>, joel <joel@joelfernandes.org>,
        urezki <urezki@gmail.com>,
        quic_neeraju <quic_neeraju@quicinc.com>,
        frederic <frederic@kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [Patch 2/2] tools/memory-model: Provide exact SRCU semantics
Message-ID: <20230125215818.GR2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <Y9GO3xEYkIQq/qSl@rowland.harvard.edu>
 <Y9GPI/g23YWx+0Ce@rowland.harvard.edu>
 <Y9GPVnK6lQbY6vCK@rowland.harvard.edu>
 <c44183e7-44ae-4be3-bb47-517067a112b5@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c44183e7-44ae-4be3-bb47-517067a112b5@huaweicloud.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2023 at 10:04:29PM +0100, Jonas Oberhauser wrote:
> On 1/25/2023 9:21 PM, Alan Stern wrote:
> > LKMM has long provided only approximate handling of SRCU read-side
> > critical sections.  This has not been a pressing problem because LKMM's
> > traditional handling is correct for the common cases of non-overlapping
> > and properly nested critical sections.  However, LKMM's traditional
> > handling of partially overlapping critical sections incorrectly fuses
> > them into one large critical section.

[ . . . ]

> >   synchronize_srcu(X)  { __srcu{sync-srcu}(X); }
> >   synchronize_srcu_expedited(X)  { __srcu{sync-srcu}(X); }
> > Index: usb-devel/tools/memory-model/lock.cat
> > ===================================================================
> > --- usb-devel.orig/tools/memory-model/lock.cat
> > +++ usb-devel/tools/memory-model/lock.cat
> > @@ -36,9 +36,9 @@ let RU = try RU with emptyset
> >   (* Treat RL as a kind of LF: a read with no ordering properties *)
> >   let LF = LF | RL
> > -(* There should be no ordinary R or W accesses to spinlocks *)
> > -let ALL-LOCKS = LKR | LKW | UL | LF | RU
> > -flag ~empty [M \ IW] ; loc ; [ALL-LOCKS] as mixed-lock-accesses
> > +(* There should be no ordinary R or W accesses to spinlocks or SRCU structs *)
> > +let ALL-LOCKS = LKR | LKW | UL | LF | RU | Srcu-lock | Srcu-unlock | Sync-srcu
> > +flag ~empty [M \ IW \ ALL-LOCKS] ; loc ; [ALL-LOCKS] as mixed-lock-accesses
> 
> Since this was pointed out by Boqun, would it be appropriate to mention him
> in the patch somehow?

Would you be willing to list who contributed what?  Once you and Alan
come to agreement on the list, I would be happy to wordsmith a version
into the commit log.

							Thanx, Paul

> >   (* Link Lock-Reads to their RMW-partner Lock-Writes *)
> >   let lk-rmw = ([LKR] ; po-loc ; [LKW]) \ (po ; po)
> 
> Thanks for your patience,
> jonas
> 

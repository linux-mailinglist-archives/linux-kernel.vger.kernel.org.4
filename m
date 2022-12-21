Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3FE2652A76
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 01:27:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234241AbiLUA1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 19:27:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiLUA1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 19:27:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995C819282;
        Tue, 20 Dec 2022 16:27:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 305746162C;
        Wed, 21 Dec 2022 00:27:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 077B7C433F1;
        Wed, 21 Dec 2022 00:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671582453;
        bh=QZMiVBXSoqyLx9N5rvN6rX9ub6C1WA1HR+6Nwve0IgU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XhQPzt5ZLWLgRAoiTtDiQTndEfBXw2Y+uJLrmGyktVaJSIgnc8u5hCwxgQGPeivGG
         cEthzGEOMxgXeOpXd7xuwRyfvx+JiS6xwh/WWL0+jAxElKHGcAQGLVVG7E+DhjU/xr
         hghHasgmD4sFPa1B92G7Meee/MsSt/iPle+Za45gDgx78j+n9EZHaIvO+Luq9odISE
         dqjxNXdJ1T/9U5NUn3LyfRTC6YP4NHe2i3WVqrPAutUuVKIVVK0ufNWkr1BF/5hnd3
         zYBwBfDMpiGdWKuDWaovPsx1KwQnFwaSrX9NIN3v25ZHFsjxZSoYPMp7fFBMISOpag
         R+ODbPF2MW4mA==
Date:   Wed, 21 Dec 2022 01:27:30 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC 0/2] srcu: Remove pre-flip memory barrier
Message-ID: <20221221002730.GA28629@lothringen>
References: <6438d903-ab97-48c7-c338-9f0bc2686f94@efficios.com>
 <7A9876BA-C375-42A7-A5C9-FD940D2898D7@joelfernandes.org>
 <5bd5ee4a-710a-96bc-abe8-772b2e60f478@efficios.com>
 <CAEXW_YRFbsCzT9iPdVfmeZ5qK+2fnVAwSzxbj1EXmU+vepOKdg@mail.gmail.com>
 <20221220230521.GC26563@lothringen>
 <CAEXW_YRw76oCBevJwFvwRRTyNGJZW2H0Zbg1WNX7D4R3bTvsHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEXW_YRw76oCBevJwFvwRRTyNGJZW2H0Zbg1WNX7D4R3bTvsHw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2022 at 06:46:10PM -0500, Joel Fernandes wrote:
> On Tue, Dec 20, 2022 at 6:05 PM Frederic Weisbecker <frederic@kernel.org> wrote:
> >
> > On Tue, Dec 20, 2022 at 07:06:57PM +0000, Joel Fernandes wrote:
> > > On Tue, Dec 20, 2022 at 7:01 PM Mathieu Desnoyers
> > > <mathieu.desnoyers@efficios.com> wrote:
> > > >
> > > > On 2022-12-20 13:29, Joel Fernandes wrote:
> > > > >
> > > >
> > > > > I do want to finish my memory barrier studies of SRCU over the holidays since I have been deep in the hole with that already. Back to the post flip memory barrier here since I think now even that might not be needed…
> > > >
> > > > I strongly suspect the memory barrier after flip is useless for the same
> > > > reasons I mentioned explaining why the barrier before the flip is useless.
> > > >
> > > > However, we need to double-check that we have memory barriers at the
> > > > beginning and end of synchronize_srcu, and between load of "unlock"
> > > > counters and load of "lock" counters.
> > > >
> > > > Where is the barrier at the beginning of synchronize_srcu ?
> > >
> > > I believe we don't need another memory barrier at the beginning of
> > > synchronize_srcu() (but this part of my SRCU study is still pending
> > > ;)) . The grace period guarantee (read-side critical sections don't
> > > span the GP) is already enforced by the memory barrier between
> > > scanning for all unlocks, and scanning for all locks (Paired with
> > > corresponding memory barriers on the read-side).
> > >
> > > Accordingly, before we scan all locks and match lock == unlock, there
> > > is an smp_mb(). Why is that not sufficient?
> >
> > That's not enough, you still need a barrier between the updater's pre-GP
> > accesses and the scans, so that post-GP read side sees the updater's pre-GP
> > accesses:
> >
> >
> >             UPDATER                        READER
> >             -------                        ------
> >             WRITE A                        WRITE srcu_read_lock
> >             smp_mb() //rcu_seq_snap()      smp_mb()
> >             READ srcu_read_lock //scans    READ A
> 
> But see the comments also in srcu_readers_active_idx_check()
> 
> * Needs to be a smp_mb() as the read side may
> * contain a read from a variable that is written to before the
> * synchronize_srcu() in the write side
> 
> So that appears to be already covered. Or is your point that the scans
> are not happening on the same CPU as the pre-GP writer, as scans are
> happening from workqueue ?

Nah I think you're right. Although I guess we still need the barrier between
updater's pre-gp accesses and srcu_unlock scans...


> 
> Perhaps that comment misled me.
> 
> Confused,
> 
>  - Joel

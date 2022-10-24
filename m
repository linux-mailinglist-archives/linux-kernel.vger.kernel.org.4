Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D23D6098A4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 05:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbiJXDTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 23:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbiJXDSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 23:18:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9103796BE;
        Sun, 23 Oct 2022 20:15:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C045D60FD4;
        Mon, 24 Oct 2022 03:15:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B75EC433D6;
        Mon, 24 Oct 2022 03:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666581341;
        bh=4Xvm6jK59KSpB6qK0TAqSA8L9T7SwXigqw4yDjifrb0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=dAU+g7aX4ijcHi134G1LjCXS+JYLIJ3l18+vr7o3AqaqjQaYYs3+MDxJRTqLzHEoe
         jpRSLwUdhCiXeaBsIz4p7dwAcu76iQey/tLVZi1lCaHptTtCrcRxhlktTLYTw8kVWc
         eQ4sbAs7AnlTndMKuMdQz/jm1V3loxNs1BLX8zkaZULumXds19FZH+vgkP1IDuctvm
         JrA1XvJjs+fOqkWSkO2FCv/O6fBNXOFAZPIB8HaasWWsvEQu3Z4l35eQ+d/A7yBeHC
         OUUrIL3c450VgpaOI1LaYHJ1zmtCTkZO9kBG/uxuJ0DcMErpQ6nD+bkBEMflaoyGkS
         vw+5IUP4EDhTA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id BFB565C0A11; Sun, 23 Oct 2022 20:15:40 -0700 (PDT)
Date:   Sun, 23 Oct 2022 20:15:40 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, rostedt@goodmis.org,
        Uladzislau Rezki <urezki@gmail.com>
Subject: Re: [PATCH rcu 13/14] workqueue: Make queue_rcu_work() use
 call_rcu_flush()
Message-ID: <20221024031540.GU5600@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221019225138.GA2499943@paulmck-ThinkPad-P17-Gen-1>
 <20221019225144.2500095-13-paulmck@kernel.org>
 <CAEXW_YQgSwMYisZVctXkjFu6_5YhFCpL_E5o5H4oJooS5Syp+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YQgSwMYisZVctXkjFu6_5YhFCpL_E5o5H4oJooS5Syp+g@mail.gmail.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 23, 2022 at 08:36:00PM -0400, Joel Fernandes wrote:
> Hello,
> 
> On Wed, Oct 19, 2022 at 6:51 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > From: Uladzislau Rezki <urezki@gmail.com>
> >
> > call_rcu() changes to save power will slow down RCU workqueue items
> > queued via queue_rcu_work(). This may not be an issue, however we cannot
> > assume that workqueue users are OK with long delays. Use
> > call_rcu_flush() API instead which reverts to the old behavio
> 
> On ChromeOS, I can see that queue_rcu_work() is pretty noisy and the
> batching is much better if we can just keep it as call_rcu() instead
> of call_rcu_flush().
> 
> Is there really any reason to keep it as call_rcu_flush() ?  If I
> recall, the real reason Vlad's system was slowing down was because of
> scsi and the queue_rcu_work() conversion was really a red herring.

There are less than 20 invocations of queue_rcu_work(), so it should
be possible look through each.  The low-risk approach is of course to
have queue_rcu_work() use call_rcu_flush().

The next approach might be to have a Kconfig option and/or kernel
boot parameter that allowed a per-system choice.

But it would not hurt to double-check on Android.

							Thanx, Paul

> Vlad, any thoughts?
> 
> thanks,
> 
>  - Joel
> 
> .
> >
> > Signed-off-by: Uladzislau Rezki <urezki@gmail.com>
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > ---
> >  kernel/workqueue.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> > index 7cd5f5e7e0a1b..b4b0e828b529e 100644
> > --- a/kernel/workqueue.c
> > +++ b/kernel/workqueue.c
> > @@ -1771,7 +1771,7 @@ bool queue_rcu_work(struct workqueue_struct *wq, struct rcu_work *rwork)
> >
> >         if (!test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work))) {
> >                 rwork->wq = wq;
> > -               call_rcu(&rwork->rcu, rcu_work_rcufn);
> > +               call_rcu_flush(&rwork->rcu, rcu_work_rcufn);
> >                 return true;
> >         }
> >
> > --
> > 2.31.1.189.g2e36527f23
> >

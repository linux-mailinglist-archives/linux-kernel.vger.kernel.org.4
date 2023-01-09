Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BACB66635E5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 00:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjAIXzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 18:55:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbjAIXzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 18:55:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1420DFCC;
        Mon,  9 Jan 2023 15:55:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6FF78B810B3;
        Mon,  9 Jan 2023 23:55:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A568C433D2;
        Mon,  9 Jan 2023 23:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673308532;
        bh=36W9a7c+G0nl1lcdbIJ/BM2s765cqvTrYCaVHIqcPAw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=AGJHpzHIodkO9gpRBSXl7RpPj7usJlj3xJUsQrbHFxdtqdjGkP/TW0gVpduI7/7Cf
         Y/c9f8MZcYjp5J0i/DctlG4fADgwgACCXuGMElDYHz3kX7MC9zC6vtUrUS8JwIG0Bb
         6qAgFj5mzu+MBqTq4bueZoQ/3pWYA4laHY7Grf5ujxm+6WvOv/gadUUHIxA3glzFHf
         z2qNMWTxrV9rnLImWeIw2MM7VvIx9sdjAR8c6RL5Yy5yLFLmcNshJ3MNsS4lvrVcZw
         gkSoj6LCV3nTbgI9j/NV4fEU5HZDf2bM9Ue3FoTbduKPhzfUgDnhXT5QdkmZkhalPi
         StwTZEHy7YlHA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B3C985C0623; Mon,  9 Jan 2023 15:55:31 -0800 (PST)
Date:   Mon, 9 Jan 2023 15:55:31 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        foo@bar.com
Subject: Re: [PATCH -rcu] rcu: Disable lazy if call_rcu() called when GPs
 expedited
Message-ID: <20230109235531.GB4028633@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230109231416.GA4028633@paulmck-ThinkPad-P17-Gen-1>
 <C461EF52-B060-4871-8C20-30824983E787@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <C461EF52-B060-4871-8C20-30824983E787@joelfernandes.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2023 at 06:20:55PM -0500, Joel Fernandes wrote:
> 
> 
> > On Jan 9, 2023, at 6:14 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
> > 
> > ﻿On Mon, Jan 09, 2023 at 10:17:56PM +0000, Joel Fernandes (Google) wrote:
> >> During suspend, we see failures to suspend 1 in 300-500 suspends.
> >> Looking closer, it appears that we are queuing lazy callbacks even
> >> though rcu_gp_is_expedited(). These delays appear to not be very welcome
> >> by the suspend/resume code as evidenced by these occasional suspend
> >> failures.
> >> 
> >> This commit therefore checks if rcu_gp_is_expedited() and ignores the
> >> lazy hint if so.
> >> 
> >> Ignoring the lazy hint if rcu_gp_is_expedited() makes the 3000
> >> suspend/resume cycles pass reliably on a 12th gen 12-core Intel CPU.
> > 
> > Yow!!!  ;-)
> 
> :-D
> 
> >> Fixes: 3cb278e73be5 ("rcu: Make call_rcu() lazy to save power")
> >> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> >> ---
> >> Paul, could we take this for 6.2 -rc cycle? Thanks.
> >> 
> >> kernel/rcu/tree.c | 5 +++--
> >> 1 file changed, 3 insertions(+), 2 deletions(-)
> >> 
> >> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> >> index 63545d79da51..93eb03f8ed99 100644
> >> --- a/kernel/rcu/tree.c
> >> +++ b/kernel/rcu/tree.c
> >> @@ -2594,12 +2594,12 @@ static void check_cb_ovld(struct rcu_data *rdp)
> >> }
> >> 
> >> static void
> >> -__call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool lazy)
> >> +__call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool lazy_in)
> >> {
> >>    static atomic_t doublefrees;
> >>    unsigned long flags;
> >>    struct rcu_data *rdp;
> >> -    bool was_alldone;
> >> +    bool was_alldone, lazy;
> > 
> > Please put "lazy" in alpha order.  Except that...
> 
> Ah sure.
> 
> > 
> >>    /* Misaligned rcu_head! */
> >>    WARN_ON_ONCE((unsigned long)head & (sizeof(void *) - 1));
> >> @@ -2622,6 +2622,7 @@ __call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool lazy)
> >>    kasan_record_aux_stack_noalloc(head);
> >>    local_irq_save(flags);
> >>    rdp = this_cpu_ptr(&rcu_data);
> >> +    lazy = lazy_in && !rcu_gp_is_expedited();
> > 
> > Doesn't this completely disable laziness on Android?
> 
> Good point, I am not sure but it could be. Maybe it is safer that I add
> a new suspend-indicator then, with corresponding
> suspend entry/exit calls like we do for expedited.
> 
> That way anyone doing it this way will not disable
> lazy fully.
> 
> Thoughts?

Makes sense to me!

Just so you know, there is an overlapping patch series in flight here:

https://lore.kernel.org/all/20221219202910.3063036-1-elliott@hpe.com/

							Thanx, Paul

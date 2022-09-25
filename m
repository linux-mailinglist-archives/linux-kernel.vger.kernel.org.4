Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 881325E9691
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 00:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbiIYWJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 18:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiIYWJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 18:09:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B3AF5B2;
        Sun, 25 Sep 2022 15:09:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 886FFB80E16;
        Sun, 25 Sep 2022 22:09:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A760CC433D6;
        Sun, 25 Sep 2022 22:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664143779;
        bh=VnvAceCiEEgWAbBKn3N4CTwBPlwaUYvhyJOFFHMTWnw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j4v7IrUvcjljrDShpawiZiXnO1Pm8yhzo95ppQ41rLq9YFzTNsQjb2J1oDw41WuRg
         3tfZ8A5UNrq0V+moTCWgoZLc8fR5OnTTFKYleJ5cJ2mU0vxyJTRK+mcNAOJXMWZw7S
         EG9dmvqWCS8MI5MyA0UV1kAmQYfxCzX8/vM84nf7N8LN/0NG99Fp05kWobHTn16tIQ
         xEwrerMQaDL7RzA6jRjw6NF4KuIq9rUCWpbloM52PT8DdHO1LsaQGaUMF0Sfjg1QaM
         WvsJjYXWu7bPythW1TI3SH8XWuXTZaxyLHTu12Oqiy2q4BtwW04+6HZzgoNwsdpa6i
         u3Ekpl8TB1OlA==
Date:   Mon, 26 Sep 2022 00:09:36 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, paulmck@kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH v6 1/4] rcu: Make call_rcu() lazy to save power
Message-ID: <20220925220936.GA182999@lothringen>
References: <20220924224637.GA161871@lothringen>
 <19217A4C-7183-4D78-A714-FBFE7BB20742@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <19217A4C-7183-4D78-A714-FBFE7BB20742@joelfernandes.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 24, 2022 at 07:28:16PM -0400, Joel Fernandes wrote:
> > And then FLUSH_BP_WAKE is probably not needed anymore. 
> 
> It is needed as the API is in tree_nocb.h and we
> have to have that handle the details of laziness
> there rather than tree.c. We could add new apis
> to get rid of flag but it’s cleaner (and Paul seemed
> to be ok with it).

If the wake up is handled outside the flush function, as in the
diff I just posted, there is no more user left of FLUSH_BP_WAKE, IIRC...

> >> @@ -512,9 +598,16 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
> >>    }
> >>    // Need to actually to a wakeup.
> >>    len = rcu_segcblist_n_cbs(&rdp->cblist);
> >> +    bypass_len = rcu_cblist_n_cbs(&rdp->nocb_bypass);
> >> +    lazy_len = READ_ONCE(rdp->lazy_len);
> >>    if (was_alldone) {
> >>        rdp->qlen_last_fqs_check = len;
> >> -        if (!irqs_disabled_flags(flags)) {
> >> +        // Only lazy CBs in bypass list
> >> +        if (lazy_len && bypass_len == lazy_len) {
> >> +            rcu_nocb_unlock_irqrestore(rdp, flags);
> >> +            wake_nocb_gp_defer(rdp, RCU_NOCB_WAKE_LAZY,
> >> +                       TPS("WakeLazy"));
> > 
> > I'm trying to think of a case where rcu_nocb_try_bypass() returns false
> > (queue to regular list) but then call_rcu() -> __call_rcu_nocb_wake() ends up
> > seeing a lazy bypass queue even though we are queueing a non-lazy callback
> > (should have flushed in this case).
> > 
> > Looks like it shouldn't happen, even with concurrent (de-offloading) but just
> > in case, can we add:
> 
> Yes I also feel this couldn’t happen because irq is
> off and nocb lock is held throughout the calls to
> the above 2 functions. Unless I missed the race
> you’re describing?

At least I can't find any either...

> 
> > 
> >      WARN_ON_ONCE(lazy_len != len)
> 
> But this condition can be true even in normal
> circumstances? len also contains DONE CBs
> which are ready to be invoked. Or did I miss
> something?

Duh, good point, nevermind then :-)

Thanks.

> 
> Thanks,
> 
>   - Joel
> 
> > 
> >> +        } else if (!irqs_disabled_flags(flags)) {
> >>            /* ... if queue was empty ... */
> >>            rcu_nocb_unlock_irqrestore(rdp, flags);
> >>            wake_nocb_gp(rdp, false);
> > 
> > Thanks.

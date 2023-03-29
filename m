Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD096CF554
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 23:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjC2VYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 17:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjC2VYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 17:24:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B84E768A;
        Wed, 29 Mar 2023 14:23:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C7A5661E4C;
        Wed, 29 Mar 2023 21:22:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA47FC433EF;
        Wed, 29 Mar 2023 21:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680124968;
        bh=BQEBTl7sXemlMssTlUV/AZAbpGbpWsqCBRUJdakEeN8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FAb5FXtoTcApyMuwm4dPst2MLgRDCinX4ahQVoFRA3pUPBjHgw3XnquAuICIoc+OP
         +6tG6uvJ+f6CwIsn8HRjnO/G9f9aiob2twzKgCBe7fTiDNJOoDOeD0vSErFdsAgD8I
         yZ7wamVfA19W9XtbM6s8U5X0tkOUp8y4BRER/iMDQYSLt98ZOh4hA1fn+DEZHWl2CV
         0achyBigD3KdyOZ8h5e66M902Jc1gr2OhuDepLXELHoyN2AbAW0ZT6jt/vRNsys0tm
         4SaFHjE4VL9+9+lZQydpmgpc8tAJWqNWDgUGmUAhp+xalQDpQNpgXh7UiyNzpT01lS
         4fE8qfdnroPGQ==
Date:   Wed, 29 Mar 2023 23:22:45 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, rcu <rcu@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 3/4] rcu/nocb: Recheck lazy callbacks under the
 ->nocb_lock from shrinker
Message-ID: <ZCSsJW67BnGWzNrI@lothringen>
References: <20230329160203.191380-1-frederic@kernel.org>
 <20230329160203.191380-4-frederic@kernel.org>
 <8df51703-1ee4-4b7b-9e05-90b3650e8ee7@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8df51703-1ee4-4b7b-9e05-90b3650e8ee7@paulmck-laptop>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 01:54:20PM -0700, Paul E. McKenney wrote:
> On Wed, Mar 29, 2023 at 06:02:02PM +0200, Frederic Weisbecker wrote:
> > The ->lazy_len is only checked locklessly. Recheck again under the
> > ->nocb_lock to avoid spending more time on flushing/waking if not
> > necessary. The ->lazy_len can still increment concurrently (from 1 to
> > infinity) but under the ->nocb_lock we at least know for sure if there
> > are lazy callbacks at all (->lazy_len > 0).
> > 
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > ---
> >  kernel/rcu/tree_nocb.h | 16 ++++++++++++----
> >  1 file changed, 12 insertions(+), 4 deletions(-)
> > 
> > diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> > index c321fce2af8e..dfa9c10d6727 100644
> > --- a/kernel/rcu/tree_nocb.h
> > +++ b/kernel/rcu/tree_nocb.h
> > @@ -1358,12 +1358,20 @@ lazy_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
> >  		if (!rcu_rdp_is_offloaded(rdp))
> >  			continue;
> >  
> > +		if (!READ_ONCE(rdp->lazy_len))
> > +			continue;
> 
> Do you depend on the ordering of the above read of ->lazy_len against
> anything in the following, aside from the re-read of ->lazy_len?  (Same
> variable, both READ_ONCE() or stronger, so you do get that ordering.)
> 
> If you do need that ordering, the above READ_ONCE() needs to instead
> be smp_load_acquire() or similar.  If you don't need that ordering,
> what you have is good.

No ordering dependency intended here. The early ->lazy_len read is really just
an optimization here to avoid locking if it *seems* there is nothing to do with
this rdp. But what follows doesn't depend on that read.

Thanks.

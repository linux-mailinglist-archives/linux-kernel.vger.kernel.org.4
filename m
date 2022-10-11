Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7549D5FBB4B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 21:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbiJKTV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 15:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiJKTV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 15:21:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03317491EA
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 12:21:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8E20BB81670
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 19:21:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D972DC433D6;
        Tue, 11 Oct 2022 19:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665516113;
        bh=JNnrUuV0Rvx9FBUBQKdggKr+TZLMhU0XO1KdgMtLlkI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qxkVNt3qPi1VhRtBWsF+ACmR2Wyhxot9oqDX/OIKXXWrjNHr5QhbXs6QOb+sNJ8qZ
         lwVYJuqakoeh3JYoptf5bNJbxashx9+BBXRVGEYzAJ5UWyoTURp9zx66H6SPCnPohP
         F/3PKa5q2zifdVvqnfIeMnSVGCWakJ8HmpN6iquCODWqMuxZa51SoTD4+KVHgToiPd
         h1dkT2Ft2S9Cnu81tMukK3VMzfH6wF2/iCEtfgCAB9yOEJ3dksXkbdDOGpi82Dt3VF
         vDU5BpK/p9DBwE5Zibf9QRacLOsUHbgJ/MEba4dj6hlBg71mnCeaAuIbW9F+WIYKUX
         QbcKWdDv4AchA==
Date:   Tue, 11 Oct 2022 21:21:50 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] rcu/nocb: Spare bypass locking upon normal enqueue
Message-ID: <20221011192150.GA1052160@lothringen>
References: <20221010223956.1041247-1-frederic@kernel.org>
 <20221010223956.1041247-3-frederic@kernel.org>
 <Y0TOSE3ZM/3uHRWX@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0TOSE3ZM/3uHRWX@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2022 at 02:00:40AM +0000, Joel Fernandes wrote:
> On Tue, Oct 11, 2022 at 12:39:56AM +0200, Frederic Weisbecker wrote:
> > When a callback is to be enqueued to the normal queue and not the bypass
> > one, a flush to the bypass queue is always tried anyway. This attempt
> > involves locking the bypass lock unconditionally. Although it is
> > guaranteed not to be contended at this point, because only call_rcu()
> > can lock the bypass lock without holding the nocb lock, it's still not
> > free and the operation can easily be spared most of the time by just
> > checking if the bypass list is empty. The check is safe as nobody can
> > queue nor flush the bypass concurrently.
> > 
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > ---
> >  kernel/rcu/tree_nocb.h | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> > index 094fd454b6c3..30c3d473ffd8 100644
> > --- a/kernel/rcu/tree_nocb.h
> > +++ b/kernel/rcu/tree_nocb.h
> > @@ -423,8 +423,10 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
> >  		if (*was_alldone)
> >  			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
> >  					    TPS("FirstQ"));
> > -		WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, j));
> > -		WARN_ON_ONCE(rcu_cblist_n_cbs(&rdp->nocb_bypass));
> > +		if (rcu_cblist_n_cbs(&rdp->nocb_bypass)) {
> > +			WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, j));
> > +			WARN_ON_ONCE(rcu_cblist_n_cbs(&rdp->nocb_bypass));
> > +		}
> >  		return false; // Caller must enqueue the callback.
> >  	}
> 
> Instead of this, since as you mentioned that the bypass lock is not contended
> in this path, isn't it unnecessary to even check or attempt to acquire the
> lock in call_rcu() path? So how about something like the following, or would
> this not work for some reason?

You're right. But it's a bit error prone and it adds quite some code complication
just for a gain on a rare event (bypass is supposed to be flushed on rare
occasions by the caller).

Thanks.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5C86CF51A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 23:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbjC2VSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 17:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjC2VSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 17:18:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F4B1711;
        Wed, 29 Mar 2023 14:18:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4BAA8B82339;
        Wed, 29 Mar 2023 21:18:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6489DC433D2;
        Wed, 29 Mar 2023 21:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680124707;
        bh=mZC9znfKcV/zjBlAcDLwCyE6p7sQboVe5/zrVpDHKNc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NTLtPNzhXQP5tcgZ7Si/hZy+VQR5xkhbOoCmmzaLJOKfOmr1ae2M3hYFPGjIPN0mI
         vyaaM6NJL6efZk7KTRYS97zQCvWvELKjZGNwGaYt9haWqK82CGhCqkKOyBox71fU2t
         rFgv1aW+iptuB2DD8Cr7cjZOFTvEdQruwn/lqbAMF+ac39rO1PIS4SZ/6PPZXC2e3v
         4bon38GiG4ZgjoxTAdVBaxDjWYzC4bd0lrZJZFbwoD3Lo4izM+MhKDEIQy68xDvJ5y
         4F9D4OhYeQYBRlbbHl/k9XaiKorumiBc5zpX+7UG+OrW3pli+dkvsX9qvoWzWMx6yK
         bvE0XDdpgb3Ww==
Date:   Wed, 29 Mar 2023 23:18:24 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, rcu <rcu@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 1/4] rcu/nocb: Protect lazy shrinker against concurrent
 (de-)offloading
Message-ID: <ZCSrIFtTsv8SkGAF@lothringen>
References: <20230329160203.191380-1-frederic@kernel.org>
 <20230329160203.191380-2-frederic@kernel.org>
 <1c1313c5-5d57-4692-8295-da199da31cb9@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c1313c5-5d57-4692-8295-da199da31cb9@paulmck-laptop>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 01:44:53PM -0700, Paul E. McKenney wrote:
> On Wed, Mar 29, 2023 at 06:02:00PM +0200, Frederic Weisbecker wrote:
> > +		/*
> > +		 * But really don't insist if barrier_mutex is contended since we
> > +		 * can't guarantee that it will never engage in a dependency
> > +		 * chain involving memory allocation. The lock is seldom contended
> > +		 * anyway.
> > +		 */
> > +		return 0;
> > +	}
> > +
> >  	/* Snapshot count of all CPUs */
> >  	for_each_possible_cpu(cpu) {
> >  		struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
> > -		int _count = READ_ONCE(rdp->lazy_len);
> > +		int _count;
> > +
> > +		if (!rcu_rdp_is_offloaded(rdp))
> > +			continue;
> > +
> > +		_count = READ_ONCE(rdp->lazy_len);
> >  
> >  		if (_count == 0)
> >  			continue;
> > +
> 
> And I just might have unconfused myself here.  We get here only if this
> CPU is offloaded, in which case it might also have non-zero ->lazy_len,
> so this is in fact *not* dead code.

Right. Now whether it's really alive remains to be proven ;)

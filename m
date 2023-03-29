Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 800BC6CF6BE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 01:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjC2XNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 19:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjC2XNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 19:13:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD8C5272;
        Wed, 29 Mar 2023 16:12:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 826D161E83;
        Wed, 29 Mar 2023 23:12:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC724C433D2;
        Wed, 29 Mar 2023 23:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680131550;
        bh=32FitxRKOssuC97chejLqod317YrSMh58RaYfXFLdv0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=kYR4CQQ45Mnpf2V9SZpFQTMq//6AVkFTtaWDBjZwnGUK2PjlcyQ/uoJN01UdOwLsg
         X1q3JXP6eZmEsOSFrcOZZNKseOZL7Y3luMl3WRyz40fTyNqQZovd/GjwFFJedn/MKy
         Wavj+BPt7DP7u+/d03Oy8J3yjAApP1/UElFqGj50aoUbsWUuQ1ZRzTz4sSipZM/cAn
         qB2OUlFr4XthIJWwoG1RB3uNsjH0S8bd3paQhWzNz28rL+N9gDNRyq0ocQR09sqBXF
         HKcvvVMAxdbNXTuYLfKlvsoEOSnl+TP2h0oaaRojJMSXn3JyqrqLuuHXU3BoTXxZhx
         BHc3tP1ERflFA==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 6105D154047D; Wed, 29 Mar 2023 16:12:30 -0700 (PDT)
Date:   Wed, 29 Mar 2023 16:12:30 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, rcu <rcu@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 4/4] rcu/nocb: Make shrinker to iterate only NOCB CPUs
Message-ID: <84fd8b61-b6db-4b8e-ac02-89e00b267e77@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230329160203.191380-1-frederic@kernel.org>
 <20230329160203.191380-5-frederic@kernel.org>
 <519aadf0-6acd-43c0-89cf-caab9e229a46@paulmck-laptop>
 <ZCSvKOJqhejuW09u@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCSvKOJqhejuW09u@lothringen>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 11:35:36PM +0200, Frederic Weisbecker wrote:
> On Wed, Mar 29, 2023 at 01:58:06PM -0700, Paul E. McKenney wrote:
> > On Wed, Mar 29, 2023 at 06:02:03PM +0200, Frederic Weisbecker wrote:
> > > Callbacks can only be queued as lazy on NOCB CPUs, therefore iterating
> > > over the NOCB mask is enough for both counting and scanning. Just lock
> > > the mostly uncontended barrier mutex on counting as well in order to
> > > keep rcu_nocb_mask stable.
> > > 
> > > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > 
> > Looks plausible.  ;-)
> > 
> > What are you doing to test this?  For that matter, what should rcutorture
> > be doing to test this?  My guess is that the current callback flooding in
> > rcu_torture_fwd_prog_cr() should do the trick, but figured I should ask.
> 
> All I did was to trigger these shrinker callbacks through debugfs
> (https://docs.kernel.org/admin-guide/mm/shrinker_debugfs.html)
> 
> But rcutorture isn't testing it because:
> 
> - No torture config has CONFIG_RCU_LAZY
> - rcutorture doesn't do any lazy call_rcu() (always calls hurry for the
>   main RCU flavour).
> 
> And I suspect rcutorture isn't ready for accepting the lazy delay, that would
> require some special treatment.

All fair points!

And yes, any non-lazy callback would delazify everything, so as it
is currently constituted, it would not be testing very much of the
lazy-callback state space.

							Thanx, Paul

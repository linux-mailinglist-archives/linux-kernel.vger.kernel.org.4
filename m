Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99FDC6184D5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 17:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbiKCQhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 12:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbiKCQh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 12:37:27 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48EAF2250D;
        Thu,  3 Nov 2022 09:34:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 52273CE25AB;
        Thu,  3 Nov 2022 16:34:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 889ADC433D6;
        Thu,  3 Nov 2022 16:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667493248;
        bh=1Bv/v+/mHhcB6d9gI+g/4wnALLUDPHN6sTCbpCCTzvw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=XU+OyksUyUuh3tc8EVx/z2kSZ4uZlvXpl6koVetu7U1KasNMooKH3geBdAKDVec/4
         6CXOMS18/injViwiAMxK3lzncXVgEe/I1G7462u8e3gfNz1Q2P/Ij81+wkeoGH1D54
         ay+1DJwfd7JQi5+21N3DHf2UAoc3sVygu2Yx9ntTlFlyiyl+y8Dow0GL4h3305CN86
         F2jlcvnP6sc1Ox4SFLt8Uoc4OtukJFy693hka9wD/at0/cCNAH5D/7Iqf+c3Ujy+bW
         wpnd5Mgq5MJ6tYGfi6eRP5kw6Orokn2tiQru89ZQ7L+E2Hd/3O24GD4oKqAGr1jQy/
         Af885LPFDSMAA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 2A8FD5C097E; Thu,  3 Nov 2022 09:34:08 -0700 (PDT)
Date:   Thu, 3 Nov 2022 09:34:08 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] rcu/kfree: Do not request RCU when not needed
Message-ID: <20221103163408.GU5600@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221102184911.GP5600@paulmck-ThinkPad-P17-Gen-1>
 <755B5ED1-653D-4E57-B114-77CDE10A9033@joelfernandes.org>
 <20221102202813.GR5600@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YQ+SxBoNUkPHhC3O0DJNQtZomN_4GPtvaWuDs5sSU4FAw@mail.gmail.com>
 <20221102223516.GT5600@paulmck-ThinkPad-P17-Gen-1>
 <Y2O3w3d3qmTg6VAP@pc638.lan>
 <Y2O8k2U+ACr1N6Fe@pc638.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2O8k2U+ACr1N6Fe@pc638.lan>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 02:05:23PM +0100, Uladzislau Rezki wrote:
> On Thu, Nov 03, 2022 at 01:44:51PM +0100, Uladzislau Rezki wrote:
> > > 
> > > > Though I am thinking, workqueue context is normally used to invoke
> > > > code that can block, and would the issue you mentioned affect those as
> > > > well, or affect RCU when those non-RCU work items block. So for
> > > > example, when other things in the system that can queue things on the
> > > > system_wq and block.  (I might be throwing darts in the dark).
> > > > 
> > > > To be safe, we can implement your suggestion which is basically a form
> > > > of my initial patch.
> > > > 
> > > > Should we add Tejun to the thread?
> > > 
> > > Let's get organized first, but that would be a good thing.  Or I could
> > > reach out to Tejun internally.
> > > 
> > > For but one thing to get organized about, maybe kfree_rcu() should be
> > > using a workqueue with the WQ_MEM_RECLAIM flag set.
> > > 
> > It can be as an option to consider. Because such workqueue has some
> > special priority for better handling of memory releasing. I can have
> > a look at it closer to see how kvfree_rcu() works if it goes with WQ_MEM_RECLAIM.
> > 
> An extra note. It would work well with posted patch because we can
> directly queue the reclaim work to the WQ_MEM_RECLAIM queue.
> 
> As for now RCU-core kthreads like: rcugp, rcuop use "regular"
> queue. I think system_wq one.

Agreed, it is the expedited grace period that uses WQ_MEM_RECLAIM
workqueues.

							Thanx, Paul

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD1E66186A0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 18:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbiKCRwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 13:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231735AbiKCRwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 13:52:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9441C43B;
        Thu,  3 Nov 2022 10:52:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EE461B82530;
        Thu,  3 Nov 2022 17:52:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96A7AC433D6;
        Thu,  3 Nov 2022 17:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667497927;
        bh=Zenn+6jbnDODhRSDzC9hBVXh9GHEta/CVzhrCuwWHCw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=bM+a0APFONgHxxLGMHR74xUMwtAbmWQagYge35W9x3ufuaTzP/XZx8clzl60ayDeM
         p9QnMLukruWAVK8OMu7V+yzrHdhbefidqHVRin2/KdxKN9mOxu6iOBl+95FXMoeHUL
         70BBB3vn+y6IWTNzUg79uNN/jDH6eJFlNwXMMtTigia0xJzLgSe7zSgdPuWnH+IH9g
         i2WF93WjE+y6nkVpqeITk0XQa9fMkbpel2vhVR+dqQCSvxLxZIF9hhW4HvBIDVPMoZ
         JKuKl2vCSShnWcAfi02JXqkJc6+xMVz4r8o+bgqq9MPv/1uXEgghT06LxGAWuheREo
         pGEcZibH+pX4Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 3F86E5C097E; Thu,  3 Nov 2022 10:52:07 -0700 (PDT)
Date:   Thu, 3 Nov 2022 10:52:07 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] rcu/kfree: Do not request RCU when not needed
Message-ID: <20221103175207.GC5600@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221102184911.GP5600@paulmck-ThinkPad-P17-Gen-1>
 <755B5ED1-653D-4E57-B114-77CDE10A9033@joelfernandes.org>
 <20221102202813.GR5600@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YQ+SxBoNUkPHhC3O0DJNQtZomN_4GPtvaWuDs5sSU4FAw@mail.gmail.com>
 <20221102223516.GT5600@paulmck-ThinkPad-P17-Gen-1>
 <Y2O3w3d3qmTg6VAP@pc638.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2O3w3d3qmTg6VAP@pc638.lan>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 01:44:51PM +0100, Uladzislau Rezki wrote:
> > 
> > > Though I am thinking, workqueue context is normally used to invoke
> > > code that can block, and would the issue you mentioned affect those as
> > > well, or affect RCU when those non-RCU work items block. So for
> > > example, when other things in the system that can queue things on the
> > > system_wq and block.  (I might be throwing darts in the dark).
> > > 
> > > To be safe, we can implement your suggestion which is basically a form
> > > of my initial patch.
> > > 
> > > Should we add Tejun to the thread?
> > 
> > Let's get organized first, but that would be a good thing.  Or I could
> > reach out to Tejun internally.
> > 
> > For but one thing to get organized about, maybe kfree_rcu() should be
> > using a workqueue with the WQ_MEM_RECLAIM flag set.
> > 
> It can be as an option to consider. Because such workqueue has some
> special priority for better handling of memory releasing. I can have
> a look at it closer to see how kvfree_rcu() works if it goes with WQ_MEM_RECLAIM.

Sounds good, thank you!

							Thanx, Paul

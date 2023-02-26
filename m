Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6E596A3381
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 19:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjBZSta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 13:49:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjBZSt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 13:49:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA89218AAE
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 10:49:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 53DB860C48
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 18:49:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94DFFC433EF;
        Sun, 26 Feb 2023 18:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677437366;
        bh=JWcnPoFcAWzgXgEOb30xH1KodvSZauHzKlkTgw2kpaQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=dY36Ysplx0XWzz3dOmIVmotgKQWoc/VEhsDOb7hcflnvopHdP1rUWHPCwW8Qg82l6
         6CNPlu2rEhIsjzBzwJP8DMOBZwF/ELj2vYnFNuwHgyniWrfZOOMEFutObGfj3pJ7+W
         8JiCiLM7TyHZfF+/+qOAshUTmZ7K8eblFxkXiUFosxdRwlJrLpVkN0ByzWWXtUE1uK
         Ipk+ClgkpivRt6oM2h/TJ09IbCSWDjXN7l8jijRJlhCoYGqDrtOu9hB6bcz6f5pigk
         2WSQPLUkHIspwYx3/An0lYKJCSeJGNOk8o0SqyWewD6YiTFLUC6qBMOkHNgsT2iZrg
         dbzCjCPuRl2OQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 4008C5C023E; Sun, 26 Feb 2023 10:49:26 -0800 (PST)
Date:   Sun, 26 Feb 2023 10:49:26 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Jonas Oberhauser <jonas.oberhauser@huawei.com>,
        parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com,
        dlustig@nvidia.com, joel@joelfernandes.org, urezki@gmail.com,
        quic_neeraju@quicinc.com, frederic@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] tools/memory-model: Make ppo a subrelation of po
Message-ID: <20230226184926.GA3213523@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230224135251.24989-1-jonas.oberhauser@huaweicloud.com>
 <Y/jYm0AZfPHkIalK@rowland.harvard.edu>
 <20230224183758.GQ2948950@paulmck-ThinkPad-P17-Gen-1>
 <20230226010110.GA1576556@paulmck-ThinkPad-P17-Gen-1>
 <Y/rEH2r9i0BtfxEW@rowland.harvard.edu>
 <20230226030311.GX2948950@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230226030311.GX2948950@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 25, 2023 at 07:03:11PM -0800, Paul E. McKenney wrote:
> On Sat, Feb 25, 2023 at 09:29:51PM -0500, Alan Stern wrote:
> > On Sat, Feb 25, 2023 at 05:01:10PM -0800, Paul E. McKenney wrote:
> > > A few other oddities:
> > > 
> > > litmus/auto/C-LB-Lww+R-OC.litmus
> > > 
> > > 	Both versions flag a data race, which I am not seeing.	It appears
> > > 	to me that P1's store to u0 cannot happen unless P0's store
> > > 	has completed.  So what am I missing here?
> > 
> > The LKMM doesn't believe that a control or data dependency orders a 
> > plain write after a marked read.  Hence in this test it thinks that P1's 
> > store to u0 can happen before the load of x1.  I don't remember why we 
> > did it this way -- probably we just wanted to minimize the restrictions 
> > on when plain accesses can execute.  (I do remember the reason for 
> > making address dependencies induce order; it was so RCU would work.)
> > 
> > The patch below will change what the LKMM believes.  It eliminates the 
> > positive outcome of the litmus test and the data race.  Should it be 
> > adopted into the memory model?
> 
> Excellent question!
> 
> As noted separately, I was conflating the C++ memory model and LKMM.
> 
> > > litmus/auto/C-LB-Lrw+R-OC.litmus
> > > litmus/auto/C-LB-Lww+R-Oc.litmus
> > > litmus/auto/C-LB-Lrw+R-Oc.litmus
> > > litmus/auto/C-LB-Lrw+R-A+R-Oc.litmus
> > > litmus/auto/C-LB-Lww+R-A+R-OC.litmus
> > > 
> > > 	Ditto.  (There are likely more.)
> > 
> > I haven't looked at these but they're probably similar.
> 
> Let me give this patch a go and see what it does.

And it operates as expected, converting Sometimes/data-race results
into Never.

Leaving the question of whether that is what we need.  ;-)

							Thanx, Paul

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 261536BB93E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 17:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232529AbjCOQN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 12:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231792AbjCOQNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 12:13:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF5597FD5;
        Wed, 15 Mar 2023 09:12:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 669D0B81D16;
        Wed, 15 Mar 2023 16:12:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 048C2C4339B;
        Wed, 15 Mar 2023 16:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678896743;
        bh=aDZKa+zI7S0I9Bzu6dU7bXbfDv/bHZGvLfjWumx6l7g=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=NytlMzqoOtUOUEj/IcMhp/haj2KquvS1685kggqO9ot3Px4G5JwtglzPMkyhFdX36
         pUawV6prqpfWYsNvcILIqqPGpTNhV1vYK5PGiGs7UjiYkibNsozj5xYGR4S7cDkMyN
         EcMIyFm/Kqcq++yx9OLBNPhJcRPUuXtW3Pz2oolVlUIF4gHtlZD8/FHQHLOP+yUL+n
         1MFTJzqOhUwSMEAxVRa+1vl6Ez6pyhp45bek1W8F+M2NBWafHHQ/j9S8WkocAVDH+u
         MJLcTL0d+5CMdI3FgzfOKMsVhNPb97iXSPu8an7BC0t4QQXByTdTd2BPcC3fXfHHaF
         hbZ9F9QRIYqpA==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 8A9811540395; Wed, 15 Mar 2023 09:12:22 -0700 (PDT)
Date:   Wed, 15 Mar 2023 09:12:22 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        linux-kernel@vger.kernel.org, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH v3] rcu: Add a minimum time for marking boot as completed
Message-ID: <879f7988-254b-450b-a082-c29d54efb5bb@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <CAEXW_YRTLQpQpOW-+n+X59pmB=4TkV=gdsMiQfBkdK_4wO9Jug@mail.gmail.com>
 <20230307173313.GJ1301832@paulmck-ThinkPad-P17-Gen-1>
 <20230307185443.GA516865@google.com>
 <20230307192726.GL1301832@paulmck-ThinkPad-P17-Gen-1>
 <ZAhYP9a8u05hzsOn@pc636>
 <20230308144528.GR1301832@paulmck-ThinkPad-P17-Gen-1>
 <ZAnXxr9OyFT63xSx@pc636>
 <20230309221056.GB148448@google.com>
 <ZArwZjcEYXAYwmqi@pc636>
 <20230315122148.GF3784687@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315122148.GF3784687@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2023 at 12:21:48PM +0000, Joel Fernandes wrote:
> On Fri, Mar 10, 2023 at 09:55:02AM +0100, Uladzislau Rezki wrote:
> > On Thu, Mar 09, 2023 at 10:10:56PM +0000, Joel Fernandes wrote:
> > > On Thu, Mar 09, 2023 at 01:57:42PM +0100, Uladzislau Rezki wrote:
> > > [..]
> > > > > > > > > See this commit:
> > > > > > > > > 
> > > > > > > > > 3705b88db0d7cc ("rcu: Add a module parameter to force use of
> > > > > > > > > expedited RCU primitives")
> > > > > > > > > 
> > > > > > > > > Antti provided this commit precisely in order to allow Android
> > > > > > > > > devices to expedite the boot process and to shut off the
> > > > > > > > > expediting at a time of Android userspace's choosing.  So Android
> > > > > > > > > has been making this work for about ten years, which strikes me
> > > > > > > > > as an adequate proof of concept.  ;-)
> > > > > > > > 
> > > > > > > > Thanks for the pointer. That's true. Looking at Android sources, I
> > > > > > > > find that Android Mediatek devices at least are setting
> > > > > > > > rcu_expedited to 1 at late stage of their userspace boot (which is
> > > > > > > > weird, it should be set to 1 as early as possible), and
> > > > > > > > interestingly I cannot find them resetting it back to 0!.  Maybe
> > > > > > > > they set rcu_normal to 1? But I cannot find that either. Vlad? :P
> > > > > > > 
> > > > > > > Interesting.  Though this is consistent with Antti's commit log,
> > > > > > > where he talks about expediting grace periods but not unexpediting
> > > > > > > them.
> > > > > > > 
> > > > > > Do you think we need to unexpedite it? :))))
> > > > > 
> > > > > Android runs on smallish systems, so quite possibly not!
> > > > > 
> > > > We keep it enabled and never unexpedite it. The reason is a performance.  I
> > > > have done some app-launch time analysis with enabling and disabling of it.
> > > > 
> > > > An expedited case is much better when it comes to app launch time. It
> > > > requires ~25% less time to run an app comparing with unexpedited variant.
> > > > So we have a big gain here.
> > > 
> > > Wow, that's huge. I wonder if you can dig deeper and find out why that is so
> > > as the callbacks may need to be synchronize_rcu_expedited() then, as it could
> > > be slowing down other usecases! I find it hard to believe, real-time
> > > workloads will run better without those callbacks being always-expedited if
> > > it actually gives back 25% in performance!
> > > 
> > I can dig further, but on a high level i think there are some spots
> > which show better performance if expedited is set. I mean synchronize_rcu()
> > becomes as "less blocking a context" from a time point of view.
> > 
> > The problem of a regular synchronize_rcu() is - it can trigger a big latency
> > delays for a caller. For example for nocb case we do not know where in a list
> > our callback is located and when it is invoked to unblock a caller.
> > 
> > I have already mentioned somewhere. Probably it makes sense to directly wake-up
> > callers from the GP kthread instead and not via nocb-kthread that invokes our callbacks
> > one by one.
> 
> Looking forward to your optimization, I wonder if to overcome the issue Paul
> mentioned about wake up overhead, whether it is possible to find out how many
> tasks there are to wake without much overhead, and for the common case of
> likely one task to wake up which is doing a synchronize_rcu(), wake that up.
> But there could be dragons..

A per-rcu_node count of the number of tasks needing wakeups might work.
But for best results, there would be an array of such numbers indexed
by the low-order bits of the grace-period number (excluding the bottom
status bits).  The callback-offloading code uses such arrays, for example,
though not for counts of sleeping tasks.  (There cannot be that many
rcuo kthreads per group, so there has been no need to count them.)

							Thanx, Paul

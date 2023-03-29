Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D91C26CF4A2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 22:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjC2Up6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 16:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjC2Up4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 16:45:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 034BD1BEB;
        Wed, 29 Mar 2023 13:45:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B31161E3F;
        Wed, 29 Mar 2023 20:45:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE825C433EF;
        Wed, 29 Mar 2023 20:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680122754;
        bh=1+5YpyDjaPtFFf5MPbl997dJhsq0zoHC1zblaUWRAww=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=mEwZQ9fd5pWAZ3QkSlP8im3qFP1EuuAhzALOAzCO+BRrzYx62yNbrShcuxsv0TM1t
         FwbvgsIFC2QMn2S4nepkMqruB8vZ3y2xPZ7Z+yudsLAqSetudxFQmAZHkQKRE3c34K
         oIAKn0HYfB2V6JpZQqDs3bW2zqudFXlgMV+utLh7NNwx7WpfP8AEaaHtNcik51AJzM
         UUUMLaKUDBhB8fyjOiFh9MoEVzy8nn5BhrdcsM8FeORie4l1+2qAdR8jxLaQAIjEQl
         3gSE31k75YK2HC0U5xIJFNNN++dFh4NwM2HyCZXW7pXGSk1INQjBxeIxasiB5xH8Cd
         OYIiEQP/VPAww==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 16061154047D; Wed, 29 Mar 2023 13:45:54 -0700 (PDT)
Date:   Wed, 29 Mar 2023 13:45:54 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, rcu <rcu@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 1/4] rcu/nocb: Protect lazy shrinker against concurrent
 (de-)offloading
Message-ID: <15ba9151-16ad-4c23-a236-918a061bd893@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230322194456.2331527-1-frederic@kernel.org>
 <20230322194456.2331527-2-frederic@kernel.org>
 <c614c542-f2b5-4b39-bbc4-ae5f0a125c81@paulmck-laptop>
 <ZB4fhA1BafN7h2N3@localhost.localdomain>
 <ae1cb391-aeed-4587-8d9d-50909c918fb1@paulmck-laptop>
 <ZCCknqnceazfyzvr@localhost.localdomain>
 <dd853e13-ffcd-4579-adad-80b014e906ef@paulmck-laptop>
 <ZCRiXrQQRNy2aJAS@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCRiXrQQRNy2aJAS@lothringen>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 06:07:58PM +0200, Frederic Weisbecker wrote:
> On Sun, Mar 26, 2023 at 02:45:18PM -0700, Paul E. McKenney wrote:
> > On Sun, Mar 26, 2023 at 10:01:34PM +0200, Frederic Weisbecker wrote:
> > > > > > >  	/* Snapshot count of all CPUs */
> > > > > > >  	for_each_possible_cpu(cpu) {
> > > > > > >  		struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
> > > > > > > -		int _count = READ_ONCE(rdp->lazy_len);
> > > > > > > +		int _count;
> > > > > > > +
> > > > > > > +		if (!rcu_rdp_is_offloaded(rdp))
> > > > > > > +			continue;
> > > > > > 
> > > > > > If the CPU is offloaded, isn't ->lazy_len guaranteed to be zero?
> > > > > > 
> > > > > > Or can it contain garbage after a de-offloading operation?
> > > > > 
> > > > > If it's deoffloaded, ->lazy_len is indeed (supposed to be) guaranteed to be zero.
> > > > > Bypass is flushed and disabled atomically early on de-offloading and the
> > > > > flush resets ->lazy_len.
> > > > 
> > > > Whew!  At the moment, I don't feel strongly about whether or not
> > > > the following code should (1) read the value, (2) warn on non-zero,
> > > > (3) assume zero without reading, or (4) some other option that is not
> > > > occurring to me.  Your choice!
> > > 
> > > (2) looks like a good idea!
> > 
> > Sounds good to me!
> 
> So since we now iterate rcu_nocb_mask after the patchset, there is no more
> deoffloaded rdp to check. Meanwhile I put a WARN in the new series making
> sure that an rdp in rcu_nocb_mask is also offloaded (heh!)

Sounds good, thank you!

							Thanx, Paul

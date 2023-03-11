Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40F776B58EA
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 07:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjCKGYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 01:24:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjCKGYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 01:24:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B05139D24;
        Fri, 10 Mar 2023 22:24:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C6396069D;
        Sat, 11 Mar 2023 06:24:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB050C433D2;
        Sat, 11 Mar 2023 06:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678515874;
        bh=ncKcbI8fIgO1hU5wAo24LQDjRKehz0Paxz9lQzlc/M8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=irvEQ2jUuFikjghSIf1FOWWNeSz7TvkeO0S3B0hGlUbamGhu+/RGDHalXSqR32u36
         YkTLjMwfqK89mJHau/0t9Hw/b8DpJidXuBf5cfxg2zopNeWLPsHt+7K0yKAMPIQK1l
         l1QMAziha3JnyWd/WDhP2BIi6KurzFR3oy3AlBQagB3jk9pdquCyiYQfNXyGTEWTJH
         ol/pm1T8vNqXKMAQOWbC0SkEflbeoJtrsxhk0UQDZz9wxxr4rMQtOeEHXxyREy5qbD
         QQz3qODYUuEwc/RMeNSdv4tJYvhwLIcQe3YEPP/yvPi+NRvR/b8LZ6nEcg1fsSUFy6
         I8uZldgF2hLVQ==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 5CA5C1540377; Fri, 10 Mar 2023 22:24:34 -0800 (PST)
Date:   Fri, 10 Mar 2023 22:24:34 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        linux-kernel@vger.kernel.org, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH v3] rcu: Add a minimum time for marking boot as completed
Message-ID: <8f8a40cd-8b1f-4121-98f7-7a1bdbcaf6a6@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <ZAc+vVZUhXdhpSki@pc636>
 <CAEXW_YRTLQpQpOW-+n+X59pmB=4TkV=gdsMiQfBkdK_4wO9Jug@mail.gmail.com>
 <20230307173313.GJ1301832@paulmck-ThinkPad-P17-Gen-1>
 <20230307185443.GA516865@google.com>
 <20230307192726.GL1301832@paulmck-ThinkPad-P17-Gen-1>
 <ZAhYP9a8u05hzsOn@pc636>
 <20230308144528.GR1301832@paulmck-ThinkPad-P17-Gen-1>
 <ZAnXxr9OyFT63xSx@pc636>
 <20230309221056.GB148448@google.com>
 <ZArwZjcEYXAYwmqi@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZArwZjcEYXAYwmqi@pc636>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 09:55:02AM +0100, Uladzislau Rezki wrote:
> On Thu, Mar 09, 2023 at 10:10:56PM +0000, Joel Fernandes wrote:
> > On Thu, Mar 09, 2023 at 01:57:42PM +0100, Uladzislau Rezki wrote:
> > [..]
> > > > > > > > See this commit:
> > > > > > > > 
> > > > > > > > 3705b88db0d7cc ("rcu: Add a module parameter to force use of
> > > > > > > > expedited RCU primitives")
> > > > > > > > 
> > > > > > > > Antti provided this commit precisely in order to allow Android
> > > > > > > > devices to expedite the boot process and to shut off the
> > > > > > > > expediting at a time of Android userspace's choosing.  So Android
> > > > > > > > has been making this work for about ten years, which strikes me
> > > > > > > > as an adequate proof of concept.  ;-)
> > > > > > > 
> > > > > > > Thanks for the pointer. That's true. Looking at Android sources, I
> > > > > > > find that Android Mediatek devices at least are setting
> > > > > > > rcu_expedited to 1 at late stage of their userspace boot (which is
> > > > > > > weird, it should be set to 1 as early as possible), and
> > > > > > > interestingly I cannot find them resetting it back to 0!.  Maybe
> > > > > > > they set rcu_normal to 1? But I cannot find that either. Vlad? :P
> > > > > > 
> > > > > > Interesting.  Though this is consistent with Antti's commit log,
> > > > > > where he talks about expediting grace periods but not unexpediting
> > > > > > them.
> > > > > > 
> > > > > Do you think we need to unexpedite it? :))))
> > > > 
> > > > Android runs on smallish systems, so quite possibly not!
> > > > 
> > > We keep it enabled and never unexpedite it. The reason is a performance.  I
> > > have done some app-launch time analysis with enabling and disabling of it.
> > > 
> > > An expedited case is much better when it comes to app launch time. It
> > > requires ~25% less time to run an app comparing with unexpedited variant.
> > > So we have a big gain here.
> > 
> > Wow, that's huge. I wonder if you can dig deeper and find out why that is so
> > as the callbacks may need to be synchronize_rcu_expedited() then, as it could
> > be slowing down other usecases! I find it hard to believe, real-time
> > workloads will run better without those callbacks being always-expedited if
> > it actually gives back 25% in performance!
> > 
> I can dig further, but on a high level i think there are some spots
> which show better performance if expedited is set. I mean synchronize_rcu()
> becomes as "less blocking a context" from a time point of view.
> 
> The problem of a regular synchronize_rcu() is - it can trigger a big latency
> delays for a caller. For example for nocb case we do not know where in a list
> our callback is located and when it is invoked to unblock a caller.

True, expedited RCU grace periods do not have this callback-invocation
delay that normal RCU does.

> I have already mentioned somewhere. Probably it makes sense to directly wake-up
> callers from the GP kthread instead and not via nocb-kthread that invokes our callbacks
> one by one.

Makes sense, but it is necessary to be careful.  Wakeups are not fast,
so making the RCU grace-period kthread do them all sequentially is not
a strategy to win.  For example, note that the next expedited grace
period can start before the previous expedited grace period has finished
its wakeups.

							Thanx, Paul

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 700E86EFCAA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 23:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239350AbjDZVzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 17:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231631AbjDZVzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 17:55:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 909C4E46;
        Wed, 26 Apr 2023 14:55:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2CDB762F19;
        Wed, 26 Apr 2023 21:55:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88DEAC433D2;
        Wed, 26 Apr 2023 21:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682546104;
        bh=37Te5xo3oIbkt+a0H+oiua5kcHap23gDcu7sKCg12/U=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=FWhk3GgrnuZFsr8/ua6SsXbf3a+q7oTjblfk3dVq/p/9fUOYYtTmf0gkwGmTaJE6X
         /6mK2kFTdFH597AZpi9lMttGQSyPGA1U+8cufdAjltS0V2VYaktthpVIfh1IMgfzAF
         QwjD467ESV6+0frbnglBNA53kyGbqFBM2RUh58z27rqrLhziOubbunn2dEDrjX7Cu8
         VI3AlXJhiwUJVSFxxtHsjnw34ffUqKoVmipjwxJ5Gyghp1x+w/jsK7lgG9vgNTDAAG
         eVxZsxTi7KjDFSx+gqo3glBFV2n+lnzlXNbiKgdtyabuCzzTqGzZGnf28GF3oC92Qw
         seH+ctJUHBg2w==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 21CC315404B7; Wed, 26 Apr 2023 14:55:04 -0700 (PDT)
Date:   Wed, 26 Apr 2023 14:55:04 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org, riel@surriel.com
Subject: Re: [PATCH RFC rcu] Stop rcu_tasks_invoke_cbs() from using
 never-online CPUs
Message-ID: <c4d39cb7-dbb7-44ad-b90e-71655bdbefd1@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <83d037d1-ef12-4b31-a7b9-7b1ed6c3ae42@paulmck-laptop>
 <ZEmBy0H5T5vQJDUW@slm.duckdns.org>
 <1713f8f6-88d6-41f1-bbc6-045b2e017289@paulmck-laptop>
 <ZEmYFLKspo-rhyp4@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZEmYFLKspo-rhyp4@slm.duckdns.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2023 at 11:31:00AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Wed, Apr 26, 2023 at 02:17:03PM -0700, Paul E. McKenney wrote:
> > But the idea here is to spread the load of queueing the work as well as
> > spreading the load of invoking the callbacks.
> > 
> > I suppose that I could allocate an array of ints, gather the online CPUs
> > into that array, and do a power-of-two distribution across that array.
> > But RCU Tasks allows CPUs to go offline with queued callbacks, so this
> > array would also need to include those CPUs as well as the ones that
> > are online.
> 
> Ah, I see, so it needs to make the distinction between cpus which have never
> been online and are currently offline but used to be online.

But only for as long as the used-to-be-online CPUs have callbacks for
the corresponding flavor of Tasks RCU.  :-/

> > Given that the common-case system has a dense cpus_online_mask, I opted
> > to keep it simple, which is optimal in the common case.
> > 
> > Or am I missing a trick here?
> 
> The worry is that on systems with actual CPU hotplugging, cpu_online_mask
> can be pretty sparse - e.g. 1/4 filled wouldn't be too out there. In such
> cases, the current code would end scheduling the work items on the issuing
> CPU (which is what WORK_CPU_UNBOUND does) 3/4 of the time which probably
> isn't the desired behavior.
> 
> So, I can initialize all per-cpu workqueues for all possible cpus on boot so
> that rcu doesn't have to worry about it but that would still have a similar
> problem of the callbacks not really being spread as intended.

Unless you get a few more users that care about this, it is probably
best to just let RCU deal with it.

For whatever it is worth, I am working a smaller patch that doesn't need
to do cpus_read_lock(), but anyone with short-term needs should stick
with the existing patch.

> I think it depends on how important it is to spread the callback workload
> evenly. If that matters quite a bit, it probably would make sense to
> maintain a cpumask for has-ever-been-online CPUs. Otherwise, do you think it
> can just use an unbound workqueue and forget about manually distributing the
> workload?

If there are not very many callbacks, then you are right that spreading
the load makes no sense.  And the 18-months-ago version of this code in
fact didn't bother spreading.  But new workloads came up that cared about
update-side performance and scalability, which led to the current code.

This code initially just invokes all the callbacks directly, just like
it did unconditionally 18 months ago, due to ->percpu_dequeue_lim being
initialized to 1.  This causes all the RCU Tasks callbacks to be queued
on CPU 0 and to be invoked directly by the grace-period kthread.

But if the call_rcu_tasks_*() code detects too much lock contention on
CPU 0's queue, which indicates that very large numbers of callbacks are
being queued, it switches to per-CPU mode.  In which case, we are likely
to have lots of callbacks on lots of queues, and in that case we really
want to invoke them concurrently.

Then if a later grace period finds that there are no more callbacks, it
switches back to CPU-0 mode.  So this extra workqueue overhead should
happen only on systems with sparse cpu_online_masks that are under heavy
call_rcu_tasks_*() load.

That is the theory, anyway!  ;-)

							Thanx, Paul

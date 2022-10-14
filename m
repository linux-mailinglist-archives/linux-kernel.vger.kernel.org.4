Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70F5C5FF07F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 16:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbiJNOkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 10:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbiJNOka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 10:40:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F2EB6001;
        Fri, 14 Oct 2022 07:40:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 64B01B82348;
        Fri, 14 Oct 2022 14:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B863CC43470;
        Fri, 14 Oct 2022 14:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665758422;
        bh=SKpHJiST+k8iOiDnv23ueRm1Xg3et1PsAlm8SCe2pAw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U6t0J5b4s+NhKQ85bHP8KM0QLJHhkxTrXFgyd0KAne6BELdSqwUmkXPBj3LgBqfy8
         /9r9/5uubgzMbUb5Usgz7V7BG1wVNzSf/J3vF9Let4clbu1OgqDXGti92UMhmsaXj8
         3XEWxY+VXO+n5aHRNBXUmJt9xAc8V6WgE5bWfbE5IthlUTMcyxcBdZ7izc6FI4Oo1d
         xcNDVkVaeSZpmp6EbP5Fo0nrpyiObDoMrpdvLtwPjnLq4L9AMriJYWCrATb3wMWCir
         TX3DKZcQ4y0IKYpG4E6fYcOwBIpC+e9cVg5YZkTOEZDuQo0tcw4Vwq/bFX9vNhXW3q
         ZcmOG6ZNZCSGQ==
Date:   Fri, 14 Oct 2022 16:40:19 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, rostedt@goodmis.org,
        youssefesmat@google.com, surenb@google.com
Subject: Re: [PATCH v8 01/13] rcu: Fix missing nocb gp wake on rcu_barrier()
Message-ID: <20221014144019.GB1108603@lothringen>
References: <20221011180142.2742289-1-joel@joelfernandes.org>
 <20221011180142.2742289-2-joel@joelfernandes.org>
 <20221014142127.GE4221@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221014142127.GE4221@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 14, 2022 at 07:21:27AM -0700, Paul E. McKenney wrote:
> On Tue, Oct 11, 2022 at 06:01:30PM +0000, Joel Fernandes (Google) wrote:
> > From: Frederic Weisbecker <frederic@kernel.org>
> > 
> > Upon entraining a callback to a NOCB CPU, no further wake up is
> > issued on the corresponding nocb_gp kthread. As a result, the callback
> > and all the subsequent ones on that CPU may be ignored, at least until
> > an RCU_NOCB_WAKE_FORCE timer is ever armed or another NOCB CPU belonging
> > to the same group enqueues a callback on an empty queue.
> > 
> > Here is a possible bad scenario:
> > 
> > 1) CPU 0 is NOCB unlike all other CPUs.
> > 2) CPU 0 queues a callback
> 
> Call it CB1.
> 
> > 2) The grace period related to that callback elapses
> > 3) The callback is moved to the done list (but is not invoked yet),
> >    there are no more pending callbacks for CPU 0
> 
> So CB1 is on ->cblist waiting to be invoked, correct?
> 
> > 4) CPU 1 calls rcu_barrier() and sends an IPI to CPU 0
> > 5) CPU 0 entrains the callback but doesn't wake up nocb_gp
> 
> And CB1 must still be there because otherwise the IPI handler would not
> have entrained the callback, correct?  If so, we have both CB1 and the
> rcu_barrier() callback (call it CB2) in ->cblist, but on the done list.
> 
> > 6) CPU 1 blocks forever, unless CPU 0 ever queues enough further
> >    callbacks to arm an RCU_NOCB_WAKE_FORCE timer.
> 
> Except that -something- must have already been prepared to wake up in
> order to invoke CB1.  And that something would invoke CB2 along with CB1,
> given that they are both on the done list.  If there is no such wakeup
> already, then the hang could occur with just CB1, without the help of CB2.

Heh good point. I was confused with CB1 on RCU_DONE_TAIL and the possibility
for CB2 to be entrained on RCU_WAIT_TAIL. But that's indeed not supposed to
happen. Ok so this patch indeed doesn't make sense outside lazy.

> > This is also required to make sure lazy callbacks in future patches
> > don't end up making rcu_barrier() wait for multiple seconds.
> 
> But I do see that the wakeup is needed in the lazy case, and if I remember
> correctly, the ten-second rcu_barrier() delay really did happen.  If I
> understand correctly, for this to happen, all of the callbacks must be
> in the bypass list, that is, ->cblist must be empty.
> 
> So has the scenario steps 1-6 called out above actually happened in the
> absence of lazy callbacks?

Nope, so I guess we can have the pending check around rcu_nocb_flush_bypass()
only...

Thanks!

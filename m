Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0903C6C0BD7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 09:12:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbjCTIM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 04:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjCTIMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 04:12:53 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB49166FA
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 01:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uRL/+OUqGO9rkEe54NmMVO32I9DyVsSNJrIB8u9pKFg=; b=RGEmMuCMuh/SeP1S5FSwVjZBOv
        K6GWR+L2t6yZOyXDhHbjMIYmt24+FfvrbpEgIqXAI5AyHduGb3Fs1ITwDkakr7TR56M3tux6PjPAi
        7CmMYB5+4AYBzdGfdnu0yLQxdnHP/ezPllewqkCWYYEzVXCIotW9xaQdFbX7s0GIjQygH7Bl04nvD
        ZrwblCE++Zu1fjGka3Q/EoeP0I8uWHxzXOWDWwREPe62ZQziLhJ84MsQSWeU7foN1P2p10wv+Q00y
        +QQyxJlSaJoILVXD9js4+5RM+htgxyXBH0XD69xGLLsV9jWQJOhTRFWgos7QR+uoQC0oPZSYcc1QS
        RZOHi0kw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1peAdD-003rLx-11;
        Mon, 20 Mar 2023 08:12:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CCE99300288;
        Mon, 20 Mar 2023 09:12:38 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B66ED2024966D; Mon, 20 Mar 2023 09:12:38 +0100 (CET)
Date:   Mon, 20 Mar 2023 09:12:38 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     mingo@redhat.com, will@kernel.org, linux-kernel@vger.kernel.org,
        boqun.feng@gmail.com
Subject: Re: [PATCH 3/6] locking/rwsem: Rework writer wakeup
Message-ID: <20230320081238.GC2194297@hirez.programming.kicks-ass.net>
References: <20230223122642.491637862@infradead.org>
 <20230223123319.487908155@infradead.org>
 <Y/t1AwGC9OoN/lFc@hirez.programming.kicks-ass.net>
 <Y/uN+89FlTw45uiA@hirez.programming.kicks-ass.net>
 <943686ee-975d-a463-46d1-04b200ac19b1@redhat.com>
 <Y/yGZgz1cJ1+pTt5@hirez.programming.kicks-ass.net>
 <c126f079-88a2-4067-6f94-82f51cf5ff2b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c126f079-88a2-4067-6f94-82f51cf5ff2b@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2023 at 03:16:25PM -0500, Waiman Long wrote:
> On 2/27/23 05:31, Peter Zijlstra wrote:
> > > I do have some concern that early lock transfer to a lock owner that has not
> > > been woken up yet may suppress writer lock stealing from optimistic spinning
> > > causing some performance regression in some cases. Let's see if the test
> > > robot report anything.
> > Ah yes, I suppose that is indeed a possibility. Given this is all under
> > wait_lock and the spinner is not, I was hoping it would still have
> > sufficient time to win. But yes, robots will tell us.
> > 
> I run my rwsem locking microbenchmark on a 2-socket 96-thread x86-64
> system with lock event turned on for 15 secs.
> 
> Before this patchset:
> 
> Running locktest with rwsem [runtime = 15s, r% = 50%, load = 100]
> Threads = 96, Min/Mean/Max = 74,506/91,260/112,409
> Threads = 96, Total Rate = 584,091 op/s; Percpu Rate = 6,084 op/s
> 
> rwsem_opt_fail=127305
> rwsem_opt_lock=4252147
> rwsem_opt_nospin=28920
> rwsem_rlock=2713129
> rwsem_rlock_fail=0
> rwsem_rlock_fast=5
> rwsem_rlock_handoff=280
> rwsem_rlock_steal=1486617
> rwsem_sleep_reader=2713085
> rwsem_sleep_writer=4313369
> rwsem_wake_reader=29876
> rwsem_wake_writer=5829160
> rwsem_wlock=127305
> rwsem_wlock_fail=0
> rwsem_wlock_handoff=2515
> 
> After this patchset:
> 
> Running locktest with rwsem [runtime = 15s, r% = 50%, load = 100]
> Threads = 96, Min/Mean/Max = 26,573/26,749/26,833
> Threads = 96, Total Rate = 171,184 op/s; Percpu Rate = 1,783 op/s
> 
> rwsem_opt_fail=1265481
> rwsem_opt_lock=17939
> rwsem_rlock=1266157
> rwsem_rlock_fail=0
> rwsem_rlock_fast=0
> rwsem_rlock_handoff=0
> rwsem_rlock_steal=551
> rwsem_sleep_reader=1266157
> rwsem_sleep_writer=1265481
> rwsem_wake_reader=26612
> rwsem_wake_writer=0
> rwsem_wlock=1265481
> rwsem_wlock_ehandoff=94
> rwsem_wlock_fail=0
> rwsem_wlock_handoff=94
> 
> So the locking rate is reduced to just 29.3% of the original. Looking at
> the number of successful writer lock stealings from optimistic spinning
> (rwsem_opt_lock), it is reduced from 4252147 to 17939. It is just about
> 0.4% of the original.
> 
> So for workloads that have a lot of writer contention, there will be
> performance regressions. Do you mind if we try to keep the original
> logic of my patchset to allow write lock acquisition in writer slow
> path, but transfer the lock ownership in the wakeup path when handoff
> is required. We can do this with some minor code changes on top of your
> current patchset.

Urgh, sorry, I seem to have lost sight of this... those results,..
sadness :/

Yeah, I suppose there's nothing for it but to have live with that mess,
be very sure to add comments eludicating any future poor sod reading it
as to why the code is the way it is.

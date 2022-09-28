Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 924005ED738
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 10:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233509AbiI1INO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 04:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232770AbiI1INK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 04:13:10 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D26947FFA8
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 01:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=XNnABCsvKxKJzkVsEs2TPEbIu5GxpHrdIGjWeEL3pYI=; b=oRz8Xsor8waiodUIUaLEDA8lYK
        K3jRP9TZz0yeclnvdQhf5yVYrOIHORIMu50IarZ4w1yOEWw/bvdMXdwSnDqGIe29oBeR8b4KIbYzI
        BLupFmCSK01u7W4t2mDB7cqgRsE/EQ5/FuzCUAPUdYsS7ON+Wc3e4E+VMXNTq/5ok7nMmgdxG53hM
        s6/Za5nTJAuXmmdDnIjasPcXMXfrrNjAUo+MBCrLz6JGsN3aBRKmAoYxmwGC4cWssUeripYySci8P
        P9q23HbviblR7iQN5/SvFqR6fNPwCe2+SBpxCuVBgjFEFs9xq02eMdCFZPJZIIrUOCt3jCSK1cDOy
        LjlOGFJw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1odSBI-00GXGI-Dc; Wed, 28 Sep 2022 08:12:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 477DA3001D7;
        Wed, 28 Sep 2022 10:12:34 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id ED25B203B737C; Wed, 28 Sep 2022 10:12:33 +0200 (CEST)
Date:   Wed, 28 Sep 2022 10:12:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Zucheng Zheng <zhengzucheng@huawei.com>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, frederic@kernel.org,
        hucool.lihua@huawei.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] sched/cputime: Fix the time backward issue about
 /proc/stat
Message-ID: <YzQB8afi2rCPvuC1@hirez.programming.kicks-ass.net>
References: <20220928033402.181530-1-zhengzucheng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220928033402.181530-1-zhengzucheng@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022 at 11:34:02AM +0800, Zucheng Zheng wrote:
> From: Zheng Zucheng <zhengzucheng@huawei.com>
> 
> The cputime of cpuN read from /proc/stat has an issue of cputime descent.
> For example, the phenomenon of cputime descent of user is as followed:
> 
> The value read first is 319, and the value read again is 318. As follows:
> first:
>  cat /proc/stat |  grep cpu1
>  cpu1    319    0    496    41665    0    0    0    0    0    0
> again:
>  cat /proc/stat |  grep cpu1
>  cpu1    318    0    497    41674    0    0    0    0    0    0
> 
> The value read from /proc/stat should be monotonically increasing. Otherwise
> user may get incorrect CPU usage.
> 
> The root cause of this problem is that, in the implementation of
> kcpustat_cpu_fetch_vtime, vtime->utime + delta is added to the stack variable
> cpustat instantaneously. If the task is switched between two times, the value
> added to cpustat for the second time may be smaller than that for the first time.
> 
> 				CPU0						CPU1
> First:
> show_stat()
>  ->kcpustat_cpu_fetch()
>   ->kcpustat_cpu_fetch_vtime()
>    ->cpustat[CPUTIME_USER] = kcpustat_cpu(cpu) + vtime->utime + delta       rq->curr is task A
>                                                                             A switch to B，and A->vtime->utime is less than 1 tick
> Then:
> show_stat()
>  ->kcpustat_cpu_fetch()
>   ->kcpustat_cpu_fetch_vtime()
>    ->cpustat[CPUTIME_USER] = kcpustat_cpu(cpu) + vtime->utime + delta;     rq->curr is task B

You're still not explaining where the time gets lost. And the patch is a
horrible band-aid.

What I think you're saying; after staring at this for a while, is that:

  vtime_task_switch_generic()
    __vtime_account_kernel(prev, vtime)
      vtime_account_{guest,system}(tsk, vtime)
        vtime->*time += get_vtime_delta()
	if (vtime->*time >= TICK_NSEC)
	  account_*_time()
	    account_system_index_time()
	      task_group_account_field()
	        __this_cpu_add(kernel_cpustat.cpustat[index], tmp);        <---- here

is not folding time into kernel_cpustat when the task vtime isn't at
least a tick's worth. And then when we switch to another task, we leak
time.

There's another problem here, vtime_task_switch_generic() should use a
single call to sched_clock() to compute the old vtime_delta and set the
new vtime->starttime, otherwise there's a time hole there as well.

This is all quite the maze and it really wants cleaning up, not be made
worse.

So I think you want to do two things:

 - pull kernel_cpustat updates out of task_group_account_field()
   and put them into vtime_task_switch_generic() to be purely
   vtime->starttime based.

 - make vtime_task_switch_generic() use a single sched_clock() call.

I did not audit all the flavours of cputime; there might be fallout, be
sure to cross compile a lot.

Frederic, you agree?

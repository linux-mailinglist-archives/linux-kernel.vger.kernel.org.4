Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D128B6F2F4C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 10:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbjEAI0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 04:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjEAI0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 04:26:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF594E4D
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 01:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=VJiun42Bpzvd+1k6rV3nJx74CzhY6pntqbvnQ5mMw3c=; b=GfQJnGMP1mD3aKOxUKtHKEXpv/
        fsEQ3+eG5qtNPfUJfwsHhdVWUN+uqxzSswTRebkfqPfo04VrokdhTMoMZCRPOwyRYRYI8CesYQCpn
        AhyO8L1r/pK5xANaY9O+cBn2jPJPieYc+J7xkmyY6Uyrj7XUApuR77eNePAWM75OwGlalMMcgVsyz
        DnrCrUHWM6DmYwLjGSgd0fEYM4Um/uhtdlvHmJJPD+ct/jZL0Rd98a1x4obGWeYY+UJIpTJqKo1L9
        EheHqO8MHuZ5l96i9IW/+chccNkRjfWbxQpZbwAXhoZPYHfxDbMeh+cEVqrE2py35QF3TdYwnZoVs
        AFDOHdbQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ptOqs-0079Xf-On; Mon, 01 May 2023 08:25:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8D0FB300379;
        Mon,  1 May 2023 10:25:36 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D22D024827D22; Mon,  1 May 2023 10:25:36 +0200 (CEST)
Date:   Mon, 1 May 2023 10:25:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mike Galbraith <efault@gmx.de>
Cc:     Chen Yu <yu.c.chen@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tim Chen <tim.c.chen@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Abel Wu <wuyun.abel@bytedance.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Honglei Wang <wanghonglei@didichuxing.com>,
        Len Brown <len.brown@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        Tianchen Ding <dtcccc@linux.alibaba.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Don <joshdon@google.com>,
        kernel test robot <yujie.liu@intel.com>,
        Arjan Van De Ven <arjan.van.de.ven@intel.com>,
        Aaron Lu <aaron.lu@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 2/2] sched/fair: Introduce SIS_CURRENT to wake up
 short task on current CPU
Message-ID: <20230501082536.GA1597476@hirez.programming.kicks-ass.net>
References: <cover.1682661027.git.yu.c.chen@intel.com>
 <4081178486e025c89dbb7cc0e62bbfab95fc794a.1682661027.git.yu.c.chen@intel.com>
 <66406be50c8e040870217f5c9131b901d4dd2013.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <66406be50c8e040870217f5c9131b901d4dd2013.camel@gmx.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 29, 2023 at 09:34:06PM +0200, Mike Galbraith wrote:
> On Sat, 2023-04-29 at 07:16 +0800, Chen Yu wrote:
> > [Problem Statement]
> > For a workload that is doing frequent context switches, the throughput
> > scales well until the number of instances reaches a peak point. After
> > that peak point, the throughput drops significantly if the number of
> > instances continue to increase.
> >
> > The will-it-scale context_switch1 test case exposes the issue. The
> > test platform has 2 x 56C/112T and 224 CPUs in total. will-it-scale
> > launches 1, 8, 16 ... instances respectively. Each instance is composed
> > of 2 tasks, and each pair of tasks would do ping-pong scheduling via
> > pipe_read() and pipe_write(). No task is bound to any CPU. It is found
> > that, once the number of instances is higher than 56, the throughput
> > drops accordingly:
> >
> >           ^
> > throughput|
> >           |                 X
> >           |               X   X X
> >           |             X         X X
> >           |           X               X
> >           |         X                   X
> >           |       X
> >           |     X
> >           |   X
> >           | X
> >           |
> >           +-----------------.------------------->
> >                             56
> >                                  number of instances
> 
> Should these buddy pairs not start interfering with one another at 112
> instances instead of 56? NR_CPUS/2 buddy pair instances is the point at
> which trying to turn waker/wakee overlap into throughput should tend
> toward being a loser due to man-in-the-middle wakeup delay pain more
> than offsetting overlap recovery gain, rendering sync wakeup thereafter
> an ever more likely win.
> 
> Anyway..
> 
> What I see in my box, and I bet a virtual nickle it's a player in your
> box as well, is WA_WEIGHT making a mess of things by stacking tasks,
> sometimes very badly.  Below, I start NR_CPUS tbench buddy pairs in
> crusty ole i4790 desktop box with WA_WEIGHT turned off, then turn it on
> remotely as to not have noisy GUI muck up my demo.
> 
> ...
>    8   3155749  3606.79 MB/sec  warmup  38 sec  latency 3.852 ms
>    8   3238485  3608.75 MB/sec  warmup  39 sec  latency 3.839 ms
>    8   3321578  3608.59 MB/sec  warmup  40 sec  latency 3.882 ms
>    8   3404746  3608.09 MB/sec  warmup  41 sec  latency 2.273 ms
>    8   3487885  3607.58 MB/sec  warmup  42 sec  latency 3.869 ms
>    8   3571034  3607.12 MB/sec  warmup  43 sec  latency 3.855 ms
>    8   3654067  3607.48 MB/sec  warmup  44 sec  latency 3.857 ms
>    8   3736973  3608.83 MB/sec  warmup  45 sec  latency 4.008 ms
>    8   3820160  3608.33 MB/sec  warmup  46 sec  latency 3.849 ms
>    8   3902963  3607.60 MB/sec  warmup  47 sec  latency 14.241 ms
>    8   3986117  3607.17 MB/sec  warmup  48 sec  latency 20.290 ms
>    8   4069256  3606.70 MB/sec  warmup  49 sec  latency 28.284 ms
>    8   4151986  3608.35 MB/sec  warmup  50 sec  latency 17.216 ms
>    8   4235070  3608.06 MB/sec  warmup  51 sec  latency 23.221 ms
>    8   4318221  3607.81 MB/sec  warmup  52 sec  latency 28.285 ms
>    8   4401456  3607.29 MB/sec  warmup  53 sec  latency 20.835 ms
>    8   4484606  3607.06 MB/sec  warmup  54 sec  latency 28.943 ms
>    8   4567609  3607.32 MB/sec  warmup  55 sec  latency 28.254 ms
> 
> Where I turned it on is hard to miss.
> 
> Short duration thread pool workers can be stacked all the way to the
> ceiling by WA_WEIGHT during burst wakeups, with wake_wide() not being
> able to intervene due to lack of cross coupling between waker/wakees
> leading to heuristic failure.  A (now long) while ago I caught that
> happening with firefox event threads, it launched 32 of 'em in my 8 rq
> box (hmm), and them being essentially the scheduler equivalent of
> neutrinos (nearly massless), we stuffed 'em all into one rq.. and got
> away with it because those particular threads don't seem to do much of
> anything.  However, were they to go active, the latency hit that we set
> up could have stung mightily. That scenario being highly generic leads
> me to suspect that somewhere out there in the big wide world, folks are
> eating that burst serialization.

I'm thinking WA_BIAS makes this worse...

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D126F6F4322
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 13:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234062AbjEBLzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 07:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234042AbjEBLzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 07:55:17 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D08E4215
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 04:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dzvpN0+w90EwBz+zdtgyM49dx/7XkY+tOVhNgkIPFxU=; b=CZOAitSoNJncwBVckZd8bEEaYu
        +8OjWm1Q5lTP+4GbjTFFqts8Ojvbu9JR4QYJ8wAkbRa0S3fQHXuUGBNVCGPxRNQnpr8+3RoZxVaB6
        c7aZLkYmGJoFVLRchQoi7IO36JdTzpCydFaPQ8PWoyP+e7I3VGi2ugahtGKpDRPpCKRVcMCD8N1Md
        Jjmv5KtWmb2ot08T8nh06JpZ7hGSo9+zuaB/QB/925/nfMkKAtkuDbP6NgEjqmO3Oa1Uz1Ezm5ftj
        42kGzuUS/LS1ImL4uuR4wA569dtXqXtPI0Ir8JxAK5hYCMPs5H+KWclt8PiINqK6CINUiZznaaXpr
        HDcsq8fQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1ptoaE-00GIQD-1N;
        Tue, 02 May 2023 11:54:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 650FC3002BF;
        Tue,  2 May 2023 13:54:08 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4A8C923C5C350; Tue,  2 May 2023 13:54:08 +0200 (CEST)
Date:   Tue, 2 May 2023 13:54:08 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
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
Message-ID: <20230502115408.GC1597538@hirez.programming.kicks-ass.net>
References: <cover.1682661027.git.yu.c.chen@intel.com>
 <4081178486e025c89dbb7cc0e62bbfab95fc794a.1682661027.git.yu.c.chen@intel.com>
 <20230501134827.GB1597538@hirez.programming.kicks-ass.net>
 <ZE/gT7bkmIFkLdkg@chenyu5-mobl1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZE/gT7bkmIFkLdkg@chenyu5-mobl1>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 01, 2023 at 11:52:47PM +0800, Chen Yu wrote:

> > So,... I've been poking around with this a bit today and I'm not seeing
> > it. On my ancient IVB-EP (2*10*2) with the code as in
> > queue/sched/core I get:
> > 
> > netperf                   NO_SIS_CURRENT          %
> >                                      SIS_CURRENT
> > ----------------------- -------------------------------
> > TCP_SENDFILE-1  : Avg:    42001      40783.4   -2.89898
> > TCP_SENDFILE-10 : Avg:    37065.1    36604.4   -1.24295
> > TCP_SENDFILE-20 : Avg:    21004.4    21356.9   1.67822
> > TCP_SENDFILE-40 : Avg:    7079.93    7231.3    2.13802
> > TCP_SENDFILE-80 : Avg:    3582.98    3615.85   0.917393

> > TCP_STREAM-1    : Avg:    37134.5    35095.4   -5.49112
> > TCP_STREAM-10   : Avg:    31260.7    31588.1   1.04732
> > TCP_STREAM-20   : Avg:    17996.6    17937.4   -0.328951
> > TCP_STREAM-40   : Avg:    7710.4     7790.62   1.04041
> > TCP_STREAM-80   : Avg:    2601.51    2903.89   11.6232

> > TCP_RR-1        : Avg:    81167.8    83541.3   2.92419
> > TCP_RR-10       : Avg:    71123.2    69447.9   -2.35549
> > TCP_RR-20       : Avg:    50905.4    52157.2   2.45907
> > TCP_RR-40       : Avg:    46289.2    46350.7   0.13286
> > TCP_RR-80       : Avg:    22024.4    22229.2   0.929878

> > UDP_RR-1        : Avg:    95997.2    96553.3   0.579288
> > UDP_RR-10       : Avg:    83878.5    78998.6   -5.81782
> > UDP_RR-20       : Avg:    61838.8    62926     1.75812
> > UDP_RR-40       : Avg:    56456.1    57115.2   1.16746
> > UDP_RR-80       : Avg:    27635.2    27784.8   0.541339

> > UDP_STREAM-1    : Avg:    52808.2    51908.6   -1.70352
> > UDP_STREAM-10   : Avg:    43115      43561.2   1.03491
> > UDP_STREAM-20   : Avg:    18798.7    20066     6.74142
> > UDP_STREAM-40   : Avg:    13070.5    13110.2   0.303737
> > UDP_STREAM-80   : Avg:    6248.86    6413.09   2.62816


> > tbench

> > WA_WEIGHT, WA_BIAS, NO_SIS_CURRENT (aka, mainline)
> > 
> > Throughput  649.46 MB/sec   2 clients   2 procs  max_latency=0.092 ms
> > Throughput 1370.93 MB/sec   5 clients   5 procs  max_latency=0.140 ms
> > Throughput 1904.14 MB/sec  10 clients  10 procs  max_latency=0.470 ms
> > Throughput 2406.15 MB/sec  20 clients  20 procs  max_latency=0.276 ms
> > Throughput 2419.40 MB/sec  40 clients  40 procs  max_latency=0.414 ms
> > Throughput 2426.00 MB/sec  80 clients  80 procs  max_latency=1.366 ms
> > 
> > WA_WEIGHT, WA_BIAS, SIS_CURRENT (aka, with patches on)
> > 
> > Throughput  646.55 MB/sec   2 clients   2 procs  max_latency=0.104 ms
> > Throughput 1361.06 MB/sec   5 clients   5 procs  max_latency=0.100 ms
> > Throughput 1889.82 MB/sec  10 clients  10 procs  max_latency=0.154 ms
> > Throughput 2406.57 MB/sec  20 clients  20 procs  max_latency=3.667 ms
> > Throughput 2318.00 MB/sec  40 clients  40 procs  max_latency=0.390 ms
> > Throughput 2384.85 MB/sec  80 clients  80 procs  max_latency=1.371 ms
> > 
> > 
> > So what's going on here? I don't see anything exciting happening at the
> > 40 mark. At the same time, I can't seem to reproduce Mike's latency pile
> > up either :/
> > 
> Thank you very much for trying this patch. This patch was found to mainly
> benefit system with large number of CPUs in 1 LLC. Previously I tested
> it on Sapphire Rapids(2x56C/224T) and Ice Lake Server(2x32C/128T)[1], it
> seems to have benefit on them. The benefit seems to come from:
> 1. reducing the waker stacking among many CPUs within 1 LLC

I should be seeing that at 10 cores per LLC. And when we look at the
tbench results (never the most stable -- let me run a few more of those)
it looks like SIS_CURRENT is actually making that worse.

That latency spike at 20 seems stable for me -- and 3ms is rather small,
I've seen it up to 11ms (but typical in the 4-6 range). This does not
happen with NO_SIS_CURRENT and is a fairly big point against these
patches.

> 2. reducing the C2C overhead within 1 LLC

This is due to how L3 became non-inclusive with Skylake? I can't see
that because I don't have anything that recent :/

> So far I did not received performance difference from LKP on desktop
> test boxes. Let me queue the full test on some desktops to confirm
> if this change has any impact on them.

Right, so I've updated my netperf results above to have a relative
difference between NO_SIS_CURRENT and SIS_CURRENT and I see some losses
at the low end. For servers that gets compensated at the high end, but
desktops tend to not get there much.



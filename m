Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD106F31A0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 15:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbjEANtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 09:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbjEANtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 09:49:24 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DDFF132
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 06:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4un/GBS0E9Ckbci8Ety9A/O+PitN7YsBCK6rWJejLCM=; b=LzR5+dKUWjshYTddTS56He48l9
        izvGbocVJ6IxESaREZwjcIY7MtzFas3fnzfsSc7z7XjBR++44MACPYxfT4/ujqI+8LSqeFEwbJM8+
        XEmlO6khvno5TA5CYHdt5xLBHlN56dAduwDZP6T+O8tnWZFZXwQBII9CGqOhzZG1S1l1avVVKwT8K
        MT/9x3fxoHInKUmYhQ5pk9+mLKjwEcDn9Gm7UtVVl3swAcIIJIee9gIXSDXgHTak4x5SjJP6n2G4A
        x6PwHSjyjjLiq9UYBn7lgRZOU7rb0S/cJdspcYuGxmHUkSlUsf2JWpJf3ZMuouNSBn4IeK+A3Ja4m
        cwQbarww==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1ptTtG-00EtZi-0t;
        Mon, 01 May 2023 13:48:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4EF4C300193;
        Mon,  1 May 2023 15:48:27 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3194F20220DBF; Mon,  1 May 2023 15:48:27 +0200 (CEST)
Date:   Mon, 1 May 2023 15:48:27 +0200
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
Message-ID: <20230501134827.GB1597538@hirez.programming.kicks-ass.net>
References: <cover.1682661027.git.yu.c.chen@intel.com>
 <4081178486e025c89dbb7cc0e62bbfab95fc794a.1682661027.git.yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4081178486e025c89dbb7cc0e62bbfab95fc794a.1682661027.git.yu.c.chen@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 29, 2023 at 07:16:56AM +0800, Chen Yu wrote:
> netperf
> =======
> case                    load            baseline(std%)  compare%( std%)
> TCP_RR                  56-threads       1.00 (  1.96)  +15.23 (  4.67)
> TCP_RR                  112-threads      1.00 (  1.84)  +88.83 (  4.37)
> TCP_RR                  168-threads      1.00 (  0.41)  +475.45 (  4.45)
> TCP_RR                  224-threads      1.00 (  0.62)  +806.85 (  3.67)
> TCP_RR                  280-threads      1.00 ( 65.80)  +162.66 ( 10.26)
> TCP_RR                  336-threads      1.00 ( 17.30)   -0.19 ( 19.07)
> TCP_RR                  392-threads      1.00 ( 26.88)   +3.38 ( 28.91)
> TCP_RR                  448-threads      1.00 ( 36.43)   -0.26 ( 33.72)
> UDP_RR                  56-threads       1.00 (  7.91)   +3.77 ( 17.48)
> UDP_RR                  112-threads      1.00 (  2.72)  -15.02 ( 10.78)
> UDP_RR                  168-threads      1.00 (  8.86)  +131.77 ( 13.30)
> UDP_RR                  224-threads      1.00 (  9.54)  +178.73 ( 16.75)
> UDP_RR                  280-threads      1.00 ( 15.40)  +189.69 ( 19.36)
> UDP_RR                  336-threads      1.00 ( 24.09)   +0.54 ( 22.28)
> UDP_RR                  392-threads      1.00 ( 39.63)   -3.90 ( 33.77)
> UDP_RR                  448-threads      1.00 ( 43.57)   +1.57 ( 40.43)
> 
> tbench
> ======
> case                    load            baseline(std%)  compare%( std%)
> loopback                56-threads       1.00 (  0.50)  +10.78 (  0.52)
> loopback                112-threads      1.00 (  0.19)   +2.73 (  0.08)
> loopback                168-threads      1.00 (  0.09)  +173.72 (  0.47)
> loopback                224-threads      1.00 (  0.20)   -2.13 (  0.42)
> loopback                280-threads      1.00 (  0.06)   -0.77 (  0.15)
> loopback                336-threads      1.00 (  0.14)   -0.08 (  0.08)
> loopback                392-threads      1.00 (  0.17)   -0.27 (  0.86)
> loopback                448-threads      1.00 (  0.37)   +0.32 (  0.02)

So,... I've been poking around with this a bit today and I'm not seeing
it. On my ancient IVB-EP (2*10*2) with the code as in
queue/sched/core I get:

netperf           NO_WA_WEIGHT               NO_SIS_CURRENT
                                 NO_WA_BIAS             SIS_CURRENT
-------------------------------------------------------------------
TCP_SENDFILE-1  : Avg: 40495.7    41899.7    42001      40783.4
TCP_SENDFILE-10 : Avg: 37218.6    37200.1    37065.1    36604.4
TCP_SENDFILE-20 : Avg: 21495.1    21516.6    21004.4    21356.9
TCP_SENDFILE-40 : Avg: 6947.24    7917.64    7079.93    7231.3
TCP_SENDFILE-80 : Avg: 4081.91    3572.48    3582.98    3615.85
TCP_STREAM-1    : Avg: 37078.1    34469.4    37134.5    35095.4
TCP_STREAM-10   : Avg: 31532.1    31265.8    31260.7    31588.1
TCP_STREAM-20   : Avg: 17848      17914.9    17996.6    17937.4
TCP_STREAM-40   : Avg: 7844.3     7201.65    7710.4     7790.62
TCP_STREAM-80   : Avg: 2518.38    2932.74    2601.51    2903.89
TCP_RR-1        : Avg: 84347.1    81056.2    81167.8    83541.3
TCP_RR-10       : Avg: 71539.1    72099.5    71123.2    69447.9
TCP_RR-20       : Avg: 51053.3    50952.4    50905.4    52157.2
TCP_RR-40       : Avg: 46370.9    46477.5    46289.2    46350.7
TCP_RR-80       : Avg: 21515.2    22497.9    22024.4    22229.2
UDP_RR-1        : Avg: 96933      100076     95997.2    96553.3
UDP_RR-10       : Avg: 83937.3    83054.3    83878.5    78998.6
UDP_RR-20       : Avg: 61974      61897.5    61838.8    62926
UDP_RR-40       : Avg: 56708.6    57053.9    56456.1    57115.2
UDP_RR-80       : Avg: 26950      27895.8    27635.2    27784.8
UDP_STREAM-1    : Avg: 52808.3    55296.8    52808.2    51908.6
UDP_STREAM-10   : Avg: 45810      42944.1    43115      43561.2
UDP_STREAM-20   : Avg: 19212.7    17572.9    18798.7    20066
UDP_STREAM-40   : Avg: 13105.1    13096.9    13070.5    13110.2
UDP_STREAM-80   : Avg: 6372.57    6367.96    6248.86    6413.09


tbench

NO_WA_WEIGHT, NO_WA_BIAS, NO_SIS_CURRENT

Throughput  626.57 MB/sec   2 clients   2 procs  max_latency=0.095 ms
Throughput 1316.08 MB/sec   5 clients   5 procs  max_latency=0.106 ms
Throughput 1905.19 MB/sec  10 clients  10 procs  max_latency=0.161 ms
Throughput 2428.05 MB/sec  20 clients  20 procs  max_latency=0.284 ms
Throughput 2323.16 MB/sec  40 clients  40 procs  max_latency=0.381 ms
Throughput 2229.93 MB/sec  80 clients  80 procs  max_latency=0.873 ms

WA_WEIGHT, NO_WA_BIAS, NO_SIS_CURRENT

Throughput  575.04 MB/sec   2 clients   2 procs  max_latency=0.093 ms
Throughput 1285.37 MB/sec   5 clients   5 procs  max_latency=0.122 ms
Throughput 1916.10 MB/sec  10 clients  10 procs  max_latency=0.150 ms
Throughput 2422.54 MB/sec  20 clients  20 procs  max_latency=0.292 ms
Throughput 2361.57 MB/sec  40 clients  40 procs  max_latency=0.448 ms
Throughput 2479.70 MB/sec  80 clients  80 procs  max_latency=1.249 ms

WA_WEIGHT, WA_BIAS, NO_SIS_CURRENT (aka, mainline)

Throughput  649.46 MB/sec   2 clients   2 procs  max_latency=0.092 ms
Throughput 1370.93 MB/sec   5 clients   5 procs  max_latency=0.140 ms
Throughput 1904.14 MB/sec  10 clients  10 procs  max_latency=0.470 ms
Throughput 2406.15 MB/sec  20 clients  20 procs  max_latency=0.276 ms
Throughput 2419.40 MB/sec  40 clients  40 procs  max_latency=0.414 ms
Throughput 2426.00 MB/sec  80 clients  80 procs  max_latency=1.366 ms

WA_WEIGHT, WA_BIAS, SIS_CURRENT (aka, with patches on)

Throughput  646.55 MB/sec   2 clients   2 procs  max_latency=0.104 ms
Throughput 1361.06 MB/sec   5 clients   5 procs  max_latency=0.100 ms
Throughput 1889.82 MB/sec  10 clients  10 procs  max_latency=0.154 ms
Throughput 2406.57 MB/sec  20 clients  20 procs  max_latency=3.667 ms
Throughput 2318.00 MB/sec  40 clients  40 procs  max_latency=0.390 ms
Throughput 2384.85 MB/sec  80 clients  80 procs  max_latency=1.371 ms


So what's going on here? I don't see anything exciting happening at the
40 mark. At the same time, I can't seem to reproduce Mike's latency pile
up either :/


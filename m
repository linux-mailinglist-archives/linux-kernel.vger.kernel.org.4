Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3362A6F363F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 20:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbjEASuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 14:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbjEASuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 14:50:11 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDDB9170B
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 11:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=tNHpPVsSHqh9ntkGmaJxJYCBzOSod853rhEIpF0KiJk=; b=payM3TDFyISyozwFIJcDLCxtiZ
        SXTT0sIRRP23H4D2wREtqumgLfhU0ka0D1AHGcOsrQwSzbn6Zi1fBhEsMgIHG668gBbYaKaF48hY8
        frhSTGkSGtgjKwUfeqggoHgUm96u3yYtuN+LjYY5T7QERQd7a7OPmWdSpeEIQPidecVI7liwPOs6l
        7AGSgLMEJNLaroI3td0Ccm1H8UHAMVFKSuIDrhgL42zKUFXWPW57AxgJwEeg86FaOMV4H0Vw+/KtZ
        SFOvpWR0STaZj1n32Rme8MAWXglgpAvqzDfhb75HUTacNZ3XcjRi5w+3/UueXExRosAtyn1Dlh4H5
        OesWO50g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1ptYaR-00Eya9-2z;
        Mon, 01 May 2023 18:49:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4A9B13002BF;
        Mon,  1 May 2023 20:49:20 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 24EBB3074E680; Mon,  1 May 2023 20:49:20 +0200 (CEST)
Date:   Mon, 1 May 2023 20:49:20 +0200
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
Message-ID: <20230501184920.GC1597476@hirez.programming.kicks-ass.net>
References: <cover.1682661027.git.yu.c.chen@intel.com>
 <4081178486e025c89dbb7cc0e62bbfab95fc794a.1682661027.git.yu.c.chen@intel.com>
 <20230501134827.GB1597538@hirez.programming.kicks-ass.net>
 <ce70393575869d65449a59d321a109f10ac82676.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ce70393575869d65449a59d321a109f10ac82676.camel@gmx.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 01, 2023 at 05:32:05PM +0200, Mike Galbraith wrote:
> On Mon, 2023-05-01 at 15:48 +0200, Peter Zijlstra wrote:
> >
> > Throughput  646.55 MB/sec   2 clients   2 procs  max_latency=0.104 ms
> > Throughput 1361.06 MB/sec   5 clients   5 procs  max_latency=0.100 ms
> > Throughput 1889.82 MB/sec  10 clients  10 procs  max_latency=0.154 ms
> > Throughput 2406.57 MB/sec  20 clients  20 procs  max_latency=3.667 ms
> > Throughput 2318.00 MB/sec  40 clients  40 procs  max_latency=0.390 ms
> > Throughput 2384.85 MB/sec  80 clients  80 procs  max_latency=1.371 ms
> >
> >
> > So what's going on here? I don't see anything exciting happening at the
> > 40 mark. At the same time, I can't seem to reproduce Mike's latency pile
> > up either :/
> 
> Are you running tbench in the GUI so the per second output stimulates
> assorted goo?  I'm using KDE fwtw.

Nah, the IVB-EP is headless, doesn't even have systemd on, still running
sysvinit.

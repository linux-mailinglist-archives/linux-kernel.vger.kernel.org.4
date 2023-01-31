Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 154466829C7
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 11:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232318AbjAaKAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 05:00:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbjAaKAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 05:00:19 -0500
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE41A4A217
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 02:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1675159218; x=1706695218;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1hiqqE0Xqm1jejQpMfknaXN5n98nZOzkrcC6EzTFhHI=;
  b=HbUQB1gTOhhVSpAd7ukddWLohzSAOByAmAfb16L3bPDWYr81bQ+vD2GD
   GbX662RbAHsFetK8hFEAmahAM59burSj04weJEqZQfEn7PulCLWUQDQfr
   McxuTue49sZWJGrQdmnl1OrhA8N5LNCJUoa05HtMP72EepwTsZCVse11G
   s=;
X-IronPort-AV: E=Sophos;i="5.97,261,1669075200"; 
   d="scan'208";a="293796957"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-25ac6bd5.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 10:00:13 +0000
Received: from EX13D41EUC002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1d-m6i4x-25ac6bd5.us-east-1.amazon.com (Postfix) with ESMTPS id 4761443AC8;
        Tue, 31 Jan 2023 10:00:06 +0000 (UTC)
Received: from EX19D033EUC004.ant.amazon.com (10.252.61.133) by
 EX13D41EUC002.ant.amazon.com (10.43.164.230) with Microsoft SMTP Server (TLS)
 id 15.0.1497.45; Tue, 31 Jan 2023 10:00:06 +0000
Received: from u40bc5e070a0153.ant.amazon.com (10.43.160.120) by
 EX19D033EUC004.ant.amazon.com (10.252.61.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.24; Tue, 31 Jan 2023 10:00:01 +0000
Date:   Tue, 31 Jan 2023 10:59:55 +0100
From:   Roman Kagan <rkagan@amazon.de>
To:     Chen Yu <yu.c.chen@intel.com>
CC:     Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Zhang Qiao <zhangqiao22@huawei.com>,
        Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [bug-report] possible s64 overflow in max_vruntime()
Message-ID: <Y9jmm5c5vT8WXsl6@u40bc5e070a0153.ant.amazon.com>
Mail-Followup-To: Roman Kagan <rkagan@amazon.de>,
        Chen Yu <yu.c.chen@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Zhang Qiao <zhangqiao22@huawei.com>,
        Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>
References: <73e639d5-702b-0d03-16d9-a965b1963ef6@huawei.com>
 <Y6RRfF5yRew7rdCp@hirez.programming.kicks-ass.net>
 <Y9GG3N5ivVvyETa2@u40bc5e070a0153.ant.amazon.com>
 <Y9J25xMrItpeHIxD@hirez.programming.kicks-ass.net>
 <Y9LG5vkf/4ufJb35@u40bc5e070a0153.ant.amazon.com>
 <Y9O5Fwfib2CVAMwl@hirez.programming.kicks-ass.net>
 <CAKfTPtBMSg2SDXq=sVt99TyM+tEXRFL74EQ57-t5uKYAXUUyLg@mail.gmail.com>
 <Y9iJLQxyXp9+x2aF@chenyu5-mobl1>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y9iJLQxyXp9+x2aF@chenyu5-mobl1>
X-Originating-IP: [10.43.160.120]
X-ClientProxiedBy: EX13D35UWB002.ant.amazon.com (10.43.161.154) To
 EX19D033EUC004.ant.amazon.com (10.252.61.133)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 11:21:17AM +0800, Chen Yu wrote:
> On 2023-01-27 at 17:18:56 +0100, Vincent Guittot wrote:
> > On Fri, 27 Jan 2023 at 12:44, Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Thu, Jan 26, 2023 at 07:31:02PM +0100, Roman Kagan wrote:
> > >
> > > > > All that only matters for small sleeps anyway.
> > > > >
> > > > > Something like:
> > > > >
> > > > >         sleep_time = U64_MAX;
> > > > >         if (se->avg.last_update_time)
> > > > >           sleep_time = cfs_rq_clock_pelt(cfs_rq) - se->avg.last_update_time;
> > > >
> > > > Interesting, why not rq_clock_task(rq_of(cfs_rq)) - se->exec_start, as
> > > > others were suggesting?  It appears to better match the notion of sleep
> > > > wall-time, no?
> > >
> > > Should also work I suppose. cfs_rq_clock takes throttling into account,
> > > but that should hopefully also not be *that* long, so either should
> > > work.
> >
> > yes rq_clock_task(rq_of(cfs_rq)) should be fine too
> >
> > Another thing to take into account is the sleeper credit that the
> > waking task deserves so the detection should be done once it has been
> > subtracted from vruntime.
> >
> > Last point, when a nice -20 task runs on a rq, it will take a bit more
> > than 2 seconds for the vruntime to be increased by more than 24ms (the
> > maximum credit that a waking task can get) so threshold must be
> > significantly higher than 2 sec. On the opposite side, the lowest
> > possible weight of a cfs rq is 2 which means that the problem appears
> > for a sleep longer or equal to 2^54 = 2^63*2/1024. We should use this
> > value instead of an arbitrary 200 days
> Does it mean any threshold between 2 sec and 2^54 nsec should be fine? Because
> 1. Any task sleeps longer than 2 sec will get at most 24 ms(sysctl_sched_latency)
>    'vruntime bonus' when enqueued.
> 2. Although a low weight cfs rq run for 2^54 nsec could trigger the overflow,
>    we can choose threshold lower than 2^54 to avoid any overflow.

This matches my understanding too, so I went ahead with the value
proposed by Peter (1 min) which looked sufficiently far away from either
side.

Roman.



Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879




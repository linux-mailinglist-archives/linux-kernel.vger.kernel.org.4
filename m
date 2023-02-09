Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC4A0690BE4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 15:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbjBIOf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 09:35:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbjBIOfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 09:35:16 -0500
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC2617CEF
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 06:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1675953315; x=1707489315;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=j9OUUueV2mJ2NjwpukC9CwjI9tzt5VSUN5w1dixzncE=;
  b=JfQHupeuYcy0IjbxXIxl6fl5VSurNmju9jDdlhMbQb6ut0EdiTClvQr3
   yaQQD2HNAyo1/9Cw/R2spQflPiScjtsrz5jkGOkoaRRvg9DpDHhQGZV/7
   CVtwzJU+zMjDsH19yAgxMCMVSpOjJxUpk0uBmdGi/+JdNavnxHqBBSYZB
   g=;
X-IronPort-AV: E=Sophos;i="5.97,283,1669075200"; 
   d="scan'208";a="291239588"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-93c3b254.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 14:35:12 +0000
Received: from EX13D39EUC002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1a-m6i4x-93c3b254.us-east-1.amazon.com (Postfix) with ESMTPS id AED1810D116;
        Thu,  9 Feb 2023 14:35:07 +0000 (UTC)
Received: from EX19D033EUC004.ant.amazon.com (10.252.61.133) by
 EX13D39EUC002.ant.amazon.com (10.43.164.187) with Microsoft SMTP Server (TLS)
 id 15.0.1497.45; Thu, 9 Feb 2023 14:35:06 +0000
Received: from u40bc5e070a0153.ant.amazon.com (10.43.162.56) by
 EX19D033EUC004.ant.amazon.com (10.252.61.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.24; Thu, 9 Feb 2023 14:35:02 +0000
Date:   Thu, 9 Feb 2023 15:34:56 +0100
From:   Roman Kagan <rkagan@amazon.de>
To:     Vincent Guittot <vincent.guittot@linaro.org>
CC:     Chen Yu <yu.c.chen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Zhang Qiao <zhangqiao22@huawei.com>,
        Waiman Long <longman@redhat.com>,
        "Ingo Molnar" <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        "Dietmar Eggemann" <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        "Daniel Bristot de Oliveira" <bristot@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [bug-report] possible s64 overflow in max_vruntime()
Message-ID: <Y+UEkFtMgmW1GDIU@u40bc5e070a0153.ant.amazon.com>
Mail-Followup-To: Roman Kagan <rkagan@amazon.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Chen Yu <yu.c.chen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Zhang Qiao <zhangqiao22@huawei.com>,
        Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>
References: <CAKfTPtBMSg2SDXq=sVt99TyM+tEXRFL74EQ57-t5uKYAXUUyLg@mail.gmail.com>
 <Y9iJLQxyXp9+x2aF@chenyu5-mobl1>
 <Y9jmm5c5vT8WXsl6@u40bc5e070a0153.ant.amazon.com>
 <CAKfTPtDUMph262w5OSiSQi-BVcNRf2gN=PdmxYCKEuk-8aYhgA@mail.gmail.com>
 <Y+Kob8kOUFa0FnJN@u40bc5e070a0153.ant.amazon.com>
 <CAKfTPtC8hQ9JysoRNF0egsp+B9+9r4YFC_1-KBnu0GpXts27kw@mail.gmail.com>
 <Y+PlTVfW9Jn1XvYZ@u40bc5e070a0153.ant.amazon.com>
 <CAKfTPtAmLWcaUUrcp8Q_F6FGo2KZrx34vcp+6mw06v9UFi=tMA@mail.gmail.com>
 <Y+T2FLrNtQkfg9bd@u40bc5e070a0153.ant.amazon.com>
 <CAKfTPtC7kq0sX3i_Nba6b=yYWczugYb=t0O7U2F7bLJ6KP19nQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAKfTPtC7kq0sX3i_Nba6b=yYWczugYb=t0O7U2F7bLJ6KP19nQ@mail.gmail.com>
X-Originating-IP: [10.43.162.56]
X-ClientProxiedBy: EX13D30UWB004.ant.amazon.com (10.43.161.51) To
 EX19D033EUC004.ant.amazon.com (10.252.61.133)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 09, 2023 at 02:44:49PM +0100, Vincent Guittot wrote:
> On Thu, 9 Feb 2023 at 14:33, Roman Kagan <rkagan@amazon.de> wrote:
> >
> > On Thu, Feb 09, 2023 at 12:26:12PM +0100, Vincent Guittot wrote:
> > > On Wed, 8 Feb 2023 at 19:09, Roman Kagan <rkagan@amazon.de> wrote:
> > > > On Wed, Feb 08, 2023 at 11:13:35AM +0100, Vincent Guittot wrote:
> > > > > On Tue, 7 Feb 2023 at 20:37, Roman Kagan <rkagan@amazon.de> wrote:
> > > > > >
> > > > > > On Tue, Jan 31, 2023 at 12:10:29PM +0100, Vincent Guittot wrote:
> > > > > > > On Tue, 31 Jan 2023 at 11:00, Roman Kagan <rkagan@amazon.de> wrote:
> > > > > > > > On Tue, Jan 31, 2023 at 11:21:17AM +0800, Chen Yu wrote:
> > > > > > > > > On 2023-01-27 at 17:18:56 +0100, Vincent Guittot wrote:
> > > > > > > > > > On Fri, 27 Jan 2023 at 12:44, Peter Zijlstra <peterz@infradead.org> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Thu, Jan 26, 2023 at 07:31:02PM +0100, Roman Kagan wrote:
> > > > > > > > > > >
> > > > > > > > > > > > > All that only matters for small sleeps anyway.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Something like:
> > > > > > > > > > > > >
> > > > > > > > > > > > >         sleep_time = U64_MAX;
> > > > > > > > > > > > >         if (se->avg.last_update_time)
> > > > > > > > > > > > >           sleep_time = cfs_rq_clock_pelt(cfs_rq) - se->avg.last_update_time;
> > > > > > > > > > > >
> > > > > > > > > > > > Interesting, why not rq_clock_task(rq_of(cfs_rq)) - se->exec_start, as
> > > > > > > > > > > > others were suggesting?  It appears to better match the notion of sleep
> > > > > > > > > > > > wall-time, no?
> > > > > > > > > > >
> > > > > > > > > > > Should also work I suppose. cfs_rq_clock takes throttling into account,
> > > > > > > > > > > but that should hopefully also not be *that* long, so either should
> > > > > > > > > > > work.
> > > > > > > > > >
> > > > > > > > > > yes rq_clock_task(rq_of(cfs_rq)) should be fine too
> > > > > > > > > >
> > > > > > > > > > Another thing to take into account is the sleeper credit that the
> > > > > > > > > > waking task deserves so the detection should be done once it has been
> > > > > > > > > > subtracted from vruntime.
> > > > > > > > > >
> > > > > > > > > > Last point, when a nice -20 task runs on a rq, it will take a bit more
> > > > > > > > > > than 2 seconds for the vruntime to be increased by more than 24ms (the
> > > > > > > > > > maximum credit that a waking task can get) so threshold must be
> > > > > > > > > > significantly higher than 2 sec. On the opposite side, the lowest
> > > > > > > > > > possible weight of a cfs rq is 2 which means that the problem appears
> > > > > > > > > > for a sleep longer or equal to 2^54 = 2^63*2/1024. We should use this
> > > > > > > > > > value instead of an arbitrary 200 days
> > > > > > > > > Does it mean any threshold between 2 sec and 2^54 nsec should be fine? Because
> > > > > > > > > 1. Any task sleeps longer than 2 sec will get at most 24 ms(sysctl_sched_latency)
> > > > > > > > >    'vruntime bonus' when enqueued.
> > > > > > >
> > > > > > > This means that if a task nice -20 runs on cfs rq while your task is
> > > > > > > sleeping 2seconds, the min vruntime of the cfs rq will increase by
> > > > > > > 24ms. If there are 2 nice -20 tasks then the min vruntime will
> > > > > > > increase by 24ms after 4 seconds and so on ...
> > > > > > >
> > > > > > > On the other side, a task nice 19 that runs 1ms will increase its
> > > > > > > vruntime by around 68ms.
> > > > > > >
> > > > > > > So if there is 1 task nice 19 with 11 tasks nice -20 on the same cfs
> > > > > > > rq, the nice -19 one should run 1ms every 65 seconds and this also
> > > > > > > means that the vruntime of task nice -19 should still be above
> > > > > > > min_vruntime after sleeping 60 seconds. Of course this is even worse
> > > > > > > with a child cgroup with the lowest weight (weight of 2 instead of 15)
> > > > > > >
> > > > > > > Just to say that 60 seconds is not so far away and 2^54 should be better IMHO
> > > > > >
> > > > > > If we go this route, what would be the proper way to infer this value?
> > > > > > Looks like
> > > > > >
> > > > > >   (1ull << 63) / NICE_0_LOAD * scale_load(MIN_SHARES)
> > > > >
> > > > > (1ull << 63) / NICE_0_LOAD * MIN_SHARES
> > > >
> > > > On 64bit platforms NICE_0_LOAD == 1L << 20 (i.e. it's also scaled) for
> > > > better precision.  So this will yield 2^63 / 2^20 * 2 = 2^44.  Good
> > > > enough probably but confusing.
> > >
> > > Something like the below should be enough to explain the value
> > >
> > > /*
> > >  * min_vruntime can move forward much faster than real time. The worst case
> > >  * happens when an entity with the min weight always runs on the cfs rq. In this
> > >  * case, the max comparison between vruntime and min_vruntime can fail after a
> > >  * sleep greater than :
> > >  *     (1ull << 63) / NICE_0_LOAD) * MIN_SHARES
> >
> > Sorry if I'm being dense, but aren't NICE_0_LOAD and MIN_SHARES measured
> > in different units: the former is scaled while the latter is not?
> 
> There are 2 usages of MIN_SHARES:
> - one when setting cgroup weight in __sched_group_set_shares() which
> uses  scale_load(MIN_SHARES)
> - one when sharing this weight between the cfs of the group in
> calc_group_shares() : clamp_t(long, shares, MIN_SHARES, tg_shares)
> 
> The 2nd one is the most important in our case that's why I use
> MIN_SHARES and not scale_load(MIN_SHARES)

I see now, thanks a lot for explaining!

I'll post an updated patch later today.

Thanks,
Roman.



Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879




Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA94667D438
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 19:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbjAZSb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 13:31:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjAZSbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 13:31:23 -0500
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E7B83D2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 10:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1674757882; x=1706293882;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oCBJBsZ3KU0GHlm5m7rsh3Rj24+8kbpEK4BWO2sDYKo=;
  b=E+iF6XJVCQpstPWVvR6jxBq5Xtt/K/sFhFAp0D/h9eMhq8MhDNvOqEtG
   OGOH3jb7stBOpDO8ZoGyM2EylGxPRW8Krt0prreQx7mMIRhtZ0KHEM7xU
   FW48l/wjuMdkgQiua47hrlIMe3uzs0adWRmTOUeEdKSonmGlAsP4sCiST
   8=;
X-IronPort-AV: E=Sophos;i="5.97,249,1669075200"; 
   d="scan'208";a="258074147"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-f323d91c.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 18:31:15 +0000
Received: from EX13D39EUC004.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2b-m6i4x-f323d91c.us-west-2.amazon.com (Postfix) with ESMTPS id CEDF541D65;
        Thu, 26 Jan 2023 18:31:13 +0000 (UTC)
Received: from EX19D033EUC004.ant.amazon.com (10.252.61.133) by
 EX13D39EUC004.ant.amazon.com (10.43.164.239) with Microsoft SMTP Server (TLS)
 id 15.0.1497.45; Thu, 26 Jan 2023 18:31:12 +0000
Received: from u40bc5e070a0153.ant.amazon.com (10.43.160.120) by
 EX19D033EUC004.ant.amazon.com (10.252.61.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.7; Thu, 26 Jan 2023 18:31:08 +0000
Date:   Thu, 26 Jan 2023 19:31:02 +0100
From:   Roman Kagan <rkagan@amazon.de>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Zhang Qiao <zhangqiao22@huawei.com>,
        Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        "Vincent Guittot" <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        "Daniel Bristot de Oliveira" <bristot@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [bug-report] possible s64 overflow in max_vruntime()
Message-ID: <Y9LG5vkf/4ufJb35@u40bc5e070a0153.ant.amazon.com>
Mail-Followup-To: Roman Kagan <rkagan@amazon.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Zhang Qiao <zhangqiao22@huawei.com>,
        Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>
References: <73e639d5-702b-0d03-16d9-a965b1963ef6@huawei.com>
 <Y6RRfF5yRew7rdCp@hirez.programming.kicks-ass.net>
 <Y9GG3N5ivVvyETa2@u40bc5e070a0153.ant.amazon.com>
 <Y9J25xMrItpeHIxD@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y9J25xMrItpeHIxD@hirez.programming.kicks-ass.net>
X-Originating-IP: [10.43.160.120]
X-ClientProxiedBy: EX13D35UWB004.ant.amazon.com (10.43.161.230) To
 EX19D033EUC004.ant.amazon.com (10.252.61.133)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 01:49:43PM +0100, Peter Zijlstra wrote:
> On Wed, Jan 25, 2023 at 08:45:32PM +0100, Roman Kagan wrote:
> 
> > The calculation is indeed safe against the overflow of the vruntimes
> > themselves.  However, when the two vruntimes are more than 2^63 apart,
> > their comparison gets inverted due to that s64 overflow.
> 
> Yes, but that's a whole different issue. vruntime are not expected to be
> *that* far apart.
> 
> That is surely the abnormal case. The normal case is wrap around, and
> that happens 'often' and should continue working.
> 
> > And this is what happens here: one scheduling entity has accumulated a
> > vruntime more than 2^63 ahead of another.  Now the comparison is
> > inverted due to s64 overflow, and the latter can't get to the cpu,
> > because it appears to have vruntime (much) bigger than that of the
> > former.
> 
> If it can be 2^63 ahead, it can also be 2^(64+) ahead and nothing will
> help.
> 
> > This situation is reproducible e.g. when one scheduling entity is a
> > multi-cpu hog, and the other is woken up from a long sleep.  Normally
> 
> A very low weight CPU hog?

Right.  In our case this weight was due to the task group consuming
all 448 cpus on the machine; presumably one can achive this on a smaller
machine by tweaking shares of the cgroup.

> > when a task is placed on a cfs_rq, its vruntime is pulled to
> > min_vruntime, to avoid boosting the woken up task.  However in this case
> > the task is so much behind in vruntime that it appears ahead instead,
> > its vruntime is not adjusted in place_entity(), and then it looses the
> > cpu to the current scheduling entity.
> 
> What I think might be a way out here is passing the the sleep wall-time
> (cfs_rq_clock_pelt() time I suppose) to place entity and simply skip the
> magic if 'big'.
> 
> All that only matters for small sleeps anyway.
> 
> Something like:
> 
>         sleep_time = U64_MAX;
>         if (se->avg.last_update_time)
>           sleep_time = cfs_rq_clock_pelt(cfs_rq) - se->avg.last_update_time;

Interesting, why not rq_clock_task(rq_of(cfs_rq)) - se->exec_start, as
others were suggesting?  It appears to better match the notion of sleep
wall-time, no?

Thanks,
Roman.

> 
>         if (sleep_time > 60*NSEC_PER_SEC) { // 1 minute is huge
>           se->vruntime = cfs_rq->min_vruntime;
>           return;
>         }
> 
>         // ... rest of place_entity()
> 
> Hmm... ?



Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879




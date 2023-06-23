Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBAF873B423
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 11:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbjFWJvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 05:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbjFWJvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 05:51:05 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA29B2D49
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 02:50:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dcNQqh0K2TGokZ0zL8MM0mS6sIytlIpadtczyHoZQcvqHThESOkFYDd/wxj99DKhRt7iqcv0zSDmDLsG56cJiu+ysdMb4THWOfzy/Td81MQkBWi2dUaa6ZvLwJkEAyh6q+IZGhyphte08WylVf5Ye0yxRrCRFiNEu736h2MxurnJ2PBEdQDHcCFHemLwwqi7CiRdgzM847hCQ2/fQey585VXgiMv+ysCmY5mZjTeDmvYOLf6jgzfilZ9JgNEjeMnVVyUtIhZ+aiYPK24d9Yg8/Sqnao3VfvzpDlll+FrGE+jPPJdbp9kDD1ynS/2PQkzHT07jHnnueGivEW240zKhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rt+hplchbSOjMGWE/urM2zor5pdCdKboDKad8r++AIY=;
 b=lp+PCyXiVm/kMwoPf2GuLsVpjL4l8Tho66UVm9NVKN1wg+nvPr4ixESGtgvhPxObJWpxAYibRu97G0PvzG5CTH/pasli+VnAiQ6w1r+eP1MGohu3ZO5D9IDNy1L1SouegeSk2rNqYtIg+JoXB5glrD2mq8AJGB+27Sz+BM+T2e64/w9mz63W/r6D5cBoM0uKtZFmu+MGObWw1wFmTzTiBMtRfHRHmObBl2UAkzLp+oeyfDRVuLFlJR/11IWvkxgdTX0IOhauFGvfWlMeLojWhEdPg2BNsFhHANW8lx1iPFBS+k0HjD71Gek0fwyu2u+ZDk/rTdEMdvZOjDb6qFuZew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rt+hplchbSOjMGWE/urM2zor5pdCdKboDKad8r++AIY=;
 b=B2LfznMi9Bm+pRS4cDbv/7kxwf5MfeXBmOEMg/ajAncGfJ1+sb4ra538tMkeaJWc1deduZMQhnsdCcDlVixvZ+sTegFOJJNnouKL4vmo9XFeoz7BogHywc906MQeZetLzJYX/Mg+/Mc9BWiXl+c2FANofUBE7mzUSz/2HwKrwmg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 IA1PR12MB7759.namprd12.prod.outlook.com (2603:10b6:208:420::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Fri, 23 Jun
 2023 09:50:30 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::792f:873a:c975:1999]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::792f:873a:c975:1999%6]) with mapi id 15.20.6521.024; Fri, 23 Jun 2023
 09:50:30 +0000
Date:   Fri, 23 Jun 2023 15:20:15 +0530
From:   "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     David Vernet <void@manifault.com>, linux-kernel@vger.kernel.org,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, joshdon@google.com,
        roman.gushchin@linux.dev, tj@kernel.org, kernel-team@meta.com
Subject: Re: [RFC PATCH 3/3] sched: Implement shared wakequeue in CFS
Message-ID: <ZJVq1+dSkMAsOIKw@BLR-5CG11610CF.amd.com>
References: <20230613052004.2836135-1-void@manifault.com>
 <20230613052004.2836135-4-void@manifault.com>
 <ZI/x+RkSqpct4bM3@BLR-5CG11610CF.amd.com>
 <20230620200822.GC3027191@maniforge>
 <ZJKx/LQwc3bWS5nh@BLR-5CG11610CF.amd.com>
 <20230622014329.GD15990@maniforge>
 <ZJQQXQ/+p4f5FcAd@BLR-5CG11610CF.amd.com>
 <20230622102935.GG4253@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230622102935.GG4253@hirez.programming.kicks-ass.net>
X-ClientProxiedBy: PN2PR01CA0146.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::31) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|IA1PR12MB7759:EE_
X-MS-Office365-Filtering-Correlation-Id: 29dc1e64-5dae-4ab1-7841-08db73cf4722
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l4wyQd9LISijxGCHHqHrIKHOFXwzoV/lbhtNtDj7Tao+oJn3WSy+Vsj8oYX7DhImiP/qWmEgZfQJXbEHgHLdXqUKTHM16OsOL8qSlAhOs6Ioen3SABn6zebKvC3yJ4yLFeGNjZA7XSJMkMRqvR47DK6Uov+fU7LR384jDz7Vo3+yNdpMlVKBHqbcozfn0k4EIQFK5UPJNymIMt8oUydsxpJvtg6l2/U/cMhexn36ddbf3dC9AefS7roGbxxkY435HYHkomgKLg8m/igwazdFtFYFwid3QH4bpqrqFOqS//mpI7gxdD+zJVWvcK92z/Kbt3PFkCGW/Vkt8TWcABSIthqlTOCJ8ZQTLgDNaGT/sWcv8etPQ4KQw5odk4YgH0Z8xhVfuXWB4dnsnfArnkRKQ55IHomOVBufHlyaF+AuZk/G5EDN87mA6rLfKMvmtoxLi4r1bIpenTAW9mug4Y5qao3tiBNuTLvVHudPEP4UVztu4gff1DhDIKpfoktsg41STbK1Eg/xTz00nh3OgS0h+ELDIxDYx1nASPbn66TV6FWy1v7VebRbvGC9RblxU3GZKburwIYWHopsp7hs93EcnHjx02stvnycXBt7YbHInUE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39860400002)(376002)(396003)(366004)(451199021)(41300700001)(316002)(8676002)(8936002)(66556008)(66476007)(4326008)(66946007)(6916009)(2906002)(7416002)(5660300002)(6506007)(6512007)(186003)(26005)(38100700002)(83380400001)(478600001)(86362001)(6486002)(6666004)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LxojtruQ1IH1W2wVKHfNIoK+2htAijdsbwpFFxJ6zRF6l3CKIoUqHTrJurzj?=
 =?us-ascii?Q?QkhA+NtKLNKC3NRO/r8I4wxwdqtmPPsxO/X85lusGSdwO2zBaG2H+jTLVDHo?=
 =?us-ascii?Q?tgu3FeJJh2F/KD9UtNvjU+7YG14IVZY0geoDCNBPgg/SUIgfGQFsgxTTiQCj?=
 =?us-ascii?Q?mCt11XWNXTkjrwR1q/O9gd7I90j0Hbvz6h1S0LImHvMFtF/LKtMf15WSq9qw?=
 =?us-ascii?Q?IBzpHyVonPRrGKKx4UObCrRg0KlGqc67T2rrYGH78Tr3jEaE531zER9MQCBJ?=
 =?us-ascii?Q?SAFbxBG6kc2FM/bdasT9m34EmwodmN9hTW6ILj6K9pcUzP0CzNQX0hGxjRxB?=
 =?us-ascii?Q?/saBQye9MwY5lBzUqmCtw7mbsM9Jt8mrXIlKN9XNTmR51n/vuwnsZZ2U3nDV?=
 =?us-ascii?Q?HhoiIgMhOE2IntxXRsNpuef5tXUEXLm9NRRWVKTobJyzjYvgsnGb9apN0bt0?=
 =?us-ascii?Q?avMozrxLtPp98R+/yB1izWyFzJCCqtttCwmUVsbQkcLCSyKZKuf5JR0UEd+l?=
 =?us-ascii?Q?AP/zRX3XTlV16M9XCn56v2ce4h7zetcXKaL9ylVrGEQDh6zEzEM8m92p0v1z?=
 =?us-ascii?Q?y+lseZ/CURzHdqdKo567IKYx3+dIw/r4BE1GSRtxVx25Bs5xNS8PUaQT5WjB?=
 =?us-ascii?Q?pZqYCN2MUQ4T+xa4MT2ZaFcr5VDVQS6PFHvWiX34r4ZtIfpSkQC3M+z129Pd?=
 =?us-ascii?Q?pE9fs86na19HgJq8HiLD422wWxvYsfGcGn4HujV+6RgqK1jXDyHHRuYV70YX?=
 =?us-ascii?Q?7xiEAC7CEzd7FJ2GlyXzVAuRVaA5VbHBwtJnRZlsd+TQPvUCcDOv5XXjxtP5?=
 =?us-ascii?Q?T5bbVXzVLlHNQxGHuykcdMmV6rZcVCvqw3j+QQD48vH6J79tgntZ2B46bPw+?=
 =?us-ascii?Q?hHKkAl8Z8SYjS1whhFgNfM3h5xs7WaM4UwQoobzRrph3MCSJpbkVNfGcNvk0?=
 =?us-ascii?Q?kDXL1BESNwmiOq5DqnJAsY4vXNlYQh6i50Rj4s/oAC4pmKF9fRhZ72Sk/fxD?=
 =?us-ascii?Q?sP3oov2YV8snT64n6DdQtR9zydyKU/uSxeb1bHrPp52+LH8P6Lb2W4TcBzuM?=
 =?us-ascii?Q?Z0xymsLaX5wKNnm8+C+J0IwezIGxdYSV+Z7zLt0+Hfd9KWKPb+eWVfiI59mB?=
 =?us-ascii?Q?rELJ5mPsMxjBWEuuvpwLkzlP2Aijp9tde7jzFg7W8WYQN7JlODeO7vY1S+rv?=
 =?us-ascii?Q?NEYSv2c2dk/loPm3WB3qmdKOWV/iw4iou7SluQAv9/oTyLGPpQJYxzSQjVlO?=
 =?us-ascii?Q?zW7M99hf5F2SANbQyfsgCYlh+EeAX+m7V5bRsVsIGCbcVC2iYL8wQgKBV6vI?=
 =?us-ascii?Q?7ucqkfeIVIF0oL03kQ2Ln6z2dNLk+Hm6CShLQ8dHgGoVKNt3e3DJrPoJK8zZ?=
 =?us-ascii?Q?co1qSmHbVM3nw2MUBcLeO9PIg7+FbF6/WEXD9ggS3YfbPctIp5+oAlVnj+Mh?=
 =?us-ascii?Q?pEye2hIvzzzSHwYx+U6XH+DlnZgeF29vqjAXqN7VRx9+bWS4WIeT3b3mRTpm?=
 =?us-ascii?Q?rCpeOa4GkfikycbwA4QpeAL1zFw8OvMxSrtqDAq2xOudvhF/QvD3oCUl5aTR?=
 =?us-ascii?Q?vryq1kmqXmYTbd/pUW0hfSah1RWDFZxqL7GDM220?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29dc1e64-5dae-4ab1-7841-08db73cf4722
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 09:50:30.5982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +LhxwIvEzYNmeXaBpjcwzqIJ9WeBElI1A+Eiiel4Vmce8KXzHmYfIzKyq7UMzYtCrR1rrfTx3OFqvGK788DZqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7759
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2023 at 12:29:35PM +0200, Peter Zijlstra wrote:
> On Thu, Jun 22, 2023 at 02:41:57PM +0530, Gautham R. Shenoy wrote:
> 
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -215,21 +215,17 @@ static void swqueue_enqueue(struct rq *rq, struct task_struct *p, int enq_flags)
> >  {
> >  	unsigned long flags;
> >  	struct swqueue *swqueue;
> > -	bool task_migrated = enq_flags & ENQUEUE_MIGRATED;
> > -	bool task_wakeup = enq_flags & ENQUEUE_WAKEUP;
> >  
> >  	/*
> >  	 * Only enqueue the task in the shared wakequeue if:
> >  	 *
> >  	 * - SWQUEUE is enabled
> > -	 * - The task is on the wakeup path
> > -	 * - The task wasn't purposefully migrated to the current rq by
> > -	 *   select_task_rq()
> > -	 * - The task isn't pinned to a specific CPU
> > +	 * - select_idle_sibling() didn't find an idle CPU to enqueue this wakee task.
> >  	 */
> > -	if (!task_wakeup || task_migrated || p->nr_cpus_allowed == 1)
> 
> You lost the nr_cpus_allowed == 1 case, that actually made sense, except
> he didn't don't have a hook in set_cpus_allowed() to fix it back up.
>

I didn't retain the "nr_cpus_allowed == 1" check because
select_task_rq() calls select_task_rq_fair() only when
p->nr_cpus_allowed > 1.

So if p was affined to a single CPU, it would always have
p->sched_add_to_swq set to 0, thereby not queueing it on the 'queue'.


> > +	if (!READ_ONCE(p->sched_add_to_swq))
> >  		return;
> 
> So suppose we fill all CPUs with tasks T_{0..n-n1}, sis finds them a
> nice idle cpu and we don't get queued.

Yes. 

> 
> Then wake up another n tasks T_{n...2n-1}, none of them find an idle
> CPU, as per the above them all taken. These all do get queued.

Yes.

> 
> However, suppose T>=n does a wakeup-preemption, and we end up with T>=n
> running while T<n get queued on the rq, but not the 'queue' (I so hate
> the swqueue name).

Yes. But note that prior to running T>=n on the CPU, it will be
removed from the 'queue'. So if every T>=n preempts the corresponding
T<n, then, the queue becomes empty. And yes, in this case the queue
served no purpose and does not justify the additional overhead.

> 
> Then one CPU has both it's tasks go 'away' and becomes idle.

Yes, and this CPU prior to newidle_balance() will now search the
'queue'.

> 
> At this point the 'queue' contains only running tasks that are not
> migratable and all the tasks that could be migrated are not on the queue
> -- IOW it is completely useless.

At this point, the CPU will call swqueue_pick_next_task() and we can
have one of the three cases:

    * The 'queue' is empty: As mentioned above, the queue didn't do
      anything for the tasks and was cmpletely useless.

    * The task at the head of 'queue' is not runnable on the CPU which
      is going idle. Again, wasted effort of adding this task to the
      queue, because in the current implementation, the task is
      removed from the 'queue' even when it is not runnable on this
      CPU.

    * The 'queue' has some task which can be run on the CPU going
      idle. The task is successfully migrated to this CPU, which no
      longer has to do newidle_balance() and the task has reduced it
      waiting period.

> 
> Is this the intention?

IIUC, the intention is to reduce the avg post-wakeup wait time of the
task by running it on a newidle CPU, when the task's CPU is still busy
running something else. This is assuming that the task won't win
wakeup-preemption. But the flipside is the additional cost of swqueue
enqueue/dequeue.

I have queued a run across a set of benchmarks, but just to get an
idea how the patch performs, I ran hackbench and this is what the
results look like on a 2 Socket Gen3 EPYC configured in NPS=2 with 64
cores 128 threads per socket:

Test:            tip                  tip_swq_disabled        tip_swq_enabled
=============================================================================
1-groups:       3.82 (0.00 pct)       3.84 (-0.52 pct)        3.46 (+9.42 pct)
2-groups:       4.40 (0.00 pct)       4.42 (-0.45 pct)        3.66 (+16.81 pct)
4-groups:       4.84 (0.00 pct)       4.82 (+0.41 pct)        4.50 (+7.02 pct)
8-groups:       5.45 (0.00 pct)       5.43 (+0.36 pct)        5.85 (-7.33 pct)
16-groups:      6.94 (0.00 pct)       6.90 (+0.57 pct)        8.41 (-21.18 pct)
 
We can see that patchset does quite well with 1,2,4 groups, but with 8
and 16 groups as the system becomes overloaded, we can see the
performance degrade. In the overloaded case, I could observe
native_queued_spin_lock_slowpath() looming large in the perf profiles
when the swqueue feature was enabled. So perhaps the cost of swqueue
enqueue/dequeue is not justifiable, especially if the tasks are anyway
going to run on their target CPUs.

I will post more results later.
--
Thanks and Regards
gautham.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3CD6B9660
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 14:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjCNNeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 09:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbjCNNeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 09:34:04 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E8890A18B3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 06:30:26 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5AB044B3;
        Tue, 14 Mar 2023 06:30:46 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E94433F67D;
        Tue, 14 Mar 2023 06:30:00 -0700 (PDT)
Message-ID: <14775160-8202-0bc6-a718-37c7ac1ed1db@arm.com>
Date:   Tue, 14 Mar 2023 14:29:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2] sched/fair: sanitize vruntime of entity being migrated
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Zhang Qiao <zhangqiao22@huawei.com>, linux-kernel@vger.kernel.org,
        mingo@redhat.com, juri.lelli@redhat.com, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, rkagan@amazon.de
References: <20230306132418.50389-1-zhangqiao22@huawei.com>
 <20230309130524.GA273121@hirez.programming.kicks-ass.net>
 <CAKfTPtAf5RrzZRSHtfK+r3QvnFQ-oM3+rJ-z5SB8T4+nUv1aQw@mail.gmail.com>
 <20230309142825.GB273121@hirez.programming.kicks-ass.net>
 <ZAnvCGdlOrWbIC/o@hirez.programming.kicks-ass.net>
 <CAKfTPtADUas2QHZCQyu0ad-JTKRQ=PcsB=o7+PuJNVxHwAzkCQ@mail.gmail.com>
 <ZAs+zV0o9ShO7nLT@vingu-book> <02a08042-e7c4-464d-bc20-9ec4ccdab1ff@arm.com>
 <8c093661-7431-00d8-d703-b8f7a7c8e747@arm.com>
 <CAKfTPtBw9SJxVBcN1qff7jRzE81kXSjbc-rXD6goEBFiXEwbyg@mail.gmail.com>
 <20230314120726.GG1845660@hirez.programming.kicks-ass.net>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20230314120726.GG1845660@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/03/2023 13:07, Peter Zijlstra wrote:
> On Tue, Mar 14, 2023 at 08:41:30AM +0100, Vincent Guittot wrote:
> 
>> I'm going to use something a bit different from your proposal below by
>> merging initial and flag
>> static void place_entity(struct cfs_rq *cfs_rq, struct sched_entity
>> *se, int flags)
>>
>> with flags:
>> 0 for initial placement
>> ENQUEUE_WAKEUP for wakeup
>> ENQUEUE_MIGRATED for migrated task
> 
> So when a task is not running for a long time (our case at hand), then
> there's two cases:
> 
>  - it wakes up locally and place_entity() gets to reset vruntime;
>  - it wakes up remotely and migrate_task_rq_fair() can reset vruntime.
> 
> So if we can rely on ENQUEUE_MIGRATED to differentiate between these
> cases, when wouldn't something like this work?

I guess so. We would avoid rq_clock_task skews or to be forced to pass
state that migrating se's vruntime is too old.

[...]

> @@ -7632,11 +7646,8 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
>  	 * min_vruntime -- the latter is done by enqueue_entity() when placing
>  	 * the task on the new runqueue.
>  	 */
> -	if (READ_ONCE(p->__state) == TASK_WAKING) {
> -		struct cfs_rq *cfs_rq = cfs_rq_of(se);
> -
> +	if (READ_ONCE(p->__state) == TASK_WAKING || reset_vruntime(cfs_rq, se))

Don't you want to call reset_vruntime() specifically on the waking task?

>  		se->vruntime -= u64_u32_load(cfs_rq->min_vruntime);
> -	}
>  
>  	if (!task_on_rq_migrating(p)) {
>  		remove_entity_load_avg(se);


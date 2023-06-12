Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4CD72CC4F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 19:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234715AbjFLRV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 13:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233118AbjFLRVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 13:21:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48BCA10DF
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 10:21:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA59B62C02
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 17:21:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9516DC433EF;
        Mon, 12 Jun 2023 17:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686590512;
        bh=3Pl1Z2+QH5caMhBd0nVTPUyvFG+q8BmXmP+wYqPb9YU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=bQno4bEawPOrB5RYfs/QLs0DeA/zOiJTZS6VwvBZlQCmcSNIcgRXUCfUJEJVtxeYa
         mb8KjAuYsEEf+H+DhIk/sCDc+u9AxuLadmt5E6iuU78gBgb9DlbgaDl2H83DycHFFP
         qqBWf5zxOQCA6d3BBUZHVYit5l3wIslVyfT6onlYm4txqujP75scX+o9/POWxvkvlb
         8q89j5vvN7piQ3MZGsplctx+8kwBzaTHpUsfqWuNu2jd4PAmle7WSTSLWxqFwFz/kL
         jUYNq41D8Y9LtFgFbRFH+VyEBxHIjlpQBlMcDWoGkDIE6/RikM6h3rlaDufD4GVqxE
         b7gjADSUWlRBg==
Message-ID: <b2cd0072-d226-4adb-ddf5-958d9635f881@kernel.org>
Date:   Mon, 12 Jun 2023 16:45:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [RFC PATCH V3 6/6] sched/fair: Implement starvation monitor
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vineeth Pillai <vineeth@bitbyteword.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1686239016.git.bristot@kernel.org>
 <bd9977efff8cc3e002c4b2db02f611167905a99f.1686239016.git.bristot@kernel.org>
 <CAEXW_YT0DmvQo_gfCq5uzpZpf36HmfzXozo9+=sYJp-hZx4qTQ@mail.gmail.com>
Content-Language: en-US
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <CAEXW_YT0DmvQo_gfCq5uzpZpf36HmfzXozo9+=sYJp-hZx4qTQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/12/23 03:57, Joel Fernandes wrote:
> Hello,
> 
> On Thu, Jun 8, 2023 at 11:58 AM Daniel Bristot de Oliveira
> <bristot@kernel.org> wrote:
>>
>> From: Juri Lelli <juri.lelli@redhat.com>
>>
>> Starting deadline server for lower priority classes right away when
>> first task is enqueued might break guarantees, as tasks belonging to
>> intermediate priority classes could be uselessly preempted. E.g., a well
>> behaving (non hog) FIFO task can be preempted by NORMAL tasks even if
>> there are still CPU cycles available for NORMAL tasks to run, as they'll
>> be running inside the fair deadline server for some period of time.
>>
>> To prevent this issue, implement a starvation monitor mechanism that
>> starts the deadline server only if a (fair in this case) task hasn't
>> been scheduled for some interval of time after it has been enqueued.
>> Use pick/put functions to manage starvation monitor status.
> 
> Me and Vineeth were discussing that another way of resolving this
> issue is to use a DL-server for RT as well, and then using a smaller
> deadline  for RT. That way the RT is more likely to be selected due to
> its earlier deadline/period.

It would not be that different from what we have now.

One of the problems of throttling nowadays is that it accounts for a large window
of time, and any "imprecision" can cause the mechanism not to work as expected.

For example, we work on a fully-isolated CPU scenario, where some very sporadic
workload can be placed on the isolated CPU because of per-cpu kernel activities,
e.g., kworkers... We need to let them run, but for a minimal amount of time, for
instance, 20 us, to bound the interference.

The current mechanism does not give this precision because the IRQ accounting
does not account for runtime for the rt throttling (which makes sense). So the
RT throttling has the 20 us stolen from IRQs and keeps running. The same will
happen if we swap the current mechanism with a DL server for the RT.

Also, thinking about short deadlines to fake a fixed priority is... not starting
well. A fixed-priority higher instance is not a property of a deadline-based
scheduler, and Linux has a fixed-priority hierarchy: STOP -> DL -> RT -> CFS...
It is simple, and that is good.

That is why it is better to boost CFS instead of throttling RT. By boosting
CFS, you do not need a server for RT, and we account for anything on top of CFS
for free (IRQ/DL/FIFO...).

> 
> Another approach could be to implement the 0-laxity scheduling as a
> general SCHED_DEADLINE feature, perhaps through a flag. And allow DL
> tasks to opt-in to 0-laxity scheduling unless there are idle cycles.
> And then opt-in the feature for the CFS deadline server task.

A 0-laxity scheduler is not as simple as it sounds, as the priority also depends
on the "C" (runtime, generally WCET), which is hard to find and embeds
pessimism. Also, having such a feature would make other mechanisms harder, as
well as debugging things. For example, proxy-execution or a more precise
schedulability test...

In a paper, the scheduler alone is the solution. In real life, the solution
for problems like locking is as fundamental as the scheduler. We need to keep
things simple to expand on these other topics as well.

So, I do not think we need all the drawbacks of a mixed solution to just fix
the throttling problem, and EDF is more capable and explored for the
general case.

With this patch's idea (and expansions), we can fix the throttling problem
without breaking other behaviors like scheduling order...

> 
> Lastly, if the goal is to remove RT throttling code eventually, are
> you also planning to remove RT group scheduling as well? Are there
> users of RT group scheduling that might be impacted? On the other
> hand, RT throttling / group scheduling code can be left as it is
> (perhaps documenting it as deprecated) and the server stuff can be
> implemented via a CONFIG option.

I think that the idea is to have the DL servers eventually replace the group
schedule. But I also believe that it is better to start by solving the
throttling and then moving to other constructions on top of the mechanism.

-- Daniel
> 
>  - Joel
> 
>> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
>> Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>


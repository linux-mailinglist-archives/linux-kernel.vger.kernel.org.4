Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D90226A6BA2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 12:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjCALXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 06:23:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjCALXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 06:23:51 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 525CF1E9D0
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 03:23:50 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1DF1F2F4;
        Wed,  1 Mar 2023 03:24:33 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B457D3F587;
        Wed,  1 Mar 2023 03:23:47 -0800 (PST)
Message-ID: <43e91964-cd34-2e84-03a3-3903aa94c5e6@arm.com>
Date:   Wed, 1 Mar 2023 12:23:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RFC PATCH] sched/fair: update the vruntime to be max vruntime
 when yield
Content-Language: en-US
To:     Xuewen Yan <xuewen.yan94@gmail.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Qais Yousef <qyousef@layalina.io>,
        Peter Zijlstra <peterz@infradead.org>,
        Xuewen Yan <xuewen.yan@unisoc.com>, mingo@redhat.com,
        juri.lelli@redhat.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com,
        zhaoyang.huang@unisoc.com
References: <20230222080314.2146-1-xuewen.yan@unisoc.com>
 <Y/zO8WZV2kvcU78b@hirez.programming.kicks-ass.net>
 <20230227220735.3kaytmtt53uoegq7@airbuntu>
 <CAB8ipk--trBk-Acsjz7YDb5szPLc93ejPXVXQBJdomZO4OrpGQ@mail.gmail.com>
 <CAKfTPtBdMO6_APib1OBxW+fdAORX8vXdT-W3fWTRffa5-8bGxQ@mail.gmail.com>
 <CAB8ipk96OXJcmp_H5EcagrMUigSFdW_gd4wwGjfjBpyP6hqaTg@mail.gmail.com>
 <CAKfTPtAvuz0SEDX3izcOhZkC+pFddqrSwY+iYO2p7U6N3Z2hRA@mail.gmail.com>
 <20230228133111.6i5tlhvthnfljvmf@airbuntu>
 <CAKfTPtAsxz7s6W2peoVj+EcNVQp6bpO6qhPPTXgfJxVtXHbaKQ@mail.gmail.com>
 <CAB8ipk83Ofywn0T19dHxjJNXfKcd9DD_EopQupeepjSk-XceRQ@mail.gmail.com>
 <CAKfTPtDfSHnd7=ZG2S-x46kxw0Cc0RSXq+_B8Oe46fa3Fa75BA@mail.gmail.com>
 <CAB8ipk9uPMxwEUHkLWbKXQEO1UkwBPWbZb=NF7AE5JHnG8V6Dw@mail.gmail.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <CAB8ipk9uPMxwEUHkLWbKXQEO1UkwBPWbZb=NF7AE5JHnG8V6Dw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xuewen,

On 01/03/2023 09:20, Xuewen Yan wrote:
> On Wed, Mar 1, 2023 at 4:09 PM Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
>>
>> On Wed, 1 Mar 2023 at 08:30, Xuewen Yan <xuewen.yan94@gmail.com> wrote:
>>>
>>> Hi Vincent
>>>
>>> I noticed the following patch:
>>> https://lore.kernel.org/lkml/20230209193107.1432770-1-rkagan@amazon.de/
>>> And I notice the V2 had merged to mainline:
>>> https://lore.kernel.org/all/20230130122216.3555094-1-rkagan@amazon.de/T/#u
>>>
>>> The patch fixed the inversing of the vruntime comparison, and I see
>>> that in my case, there also are some vruntime is inverted.
>>> Do you think which patch will work for our scenario? I would be very
>>> grateful if you could give us some advice.
>>> I would try this patch in our tree.
>>
>> By default use the one that is merged; The difference is mainly a
>> matter of time range. Also be aware that the case of newly migrated
>> task is not fully covered by both patches.
> 
> Okay, Thank you very much!
> 
>>
>> This patch fixes a problem with long sleeping entity in the presence
>> of low weight and always running entities. This doesn't seem to be
>> aligned with the description of your use case
> 
> Thanks for the clarification! We would try it first to see whether it
> could resolve our problem.

Can you not run Vincent's rt-app example on your device and then report
`cat /sys/kernel/debug/sched/debug` of the CPU?

# rt-app /root/rt-app/cfs_yield.json

# cat /sys/kernel/debug/sched/debug
...
cpu#2
  .nr_running                    : 4
  ...
  .curr->pid                     : 2121
  ...

cfs_rq[2]:/autogroup-15
  .exec_clock                    : 0.000000
  .MIN_vruntime                  : 32428.281204
  .min_vruntime                  : 32428.281204
  .max_vruntime                  : 32434.997784
  ...
  .nr_running                    : 4
  .h_nr_running                  : 4

...

 S            task   PID         tree-key  switches  prio     wait-time             sum-exec        sum-sleep
-------------------------------------------------------------------------------------------------------------
 S         cpuhp/2    22      1304.405864        13   120         0.000000         0.270000         0.000000         0.000000 0 0 /
 S     migration/2    23         0.000000         8     0         0.000000         7.460940         0.000000         0.000000 0 0 /
 S     ksoftirqd/2    24    137721.092326        46   120         0.000000         1.821880         0.000000         0.000000 0 0 /
 I    kworker/2:0H    26      2116.827393         4   100         0.000000         0.057220         0.000000         0.000000 0 0 /
 I     kworker/2:1    45    204539.183593       322   120         0.000000       447.975440         0.000000         0.000000 0 0 /
 I     kworker/2:3    80      1778.668364        33   120         0.000000        16.237320         0.000000         0.000000 0 0 /
 I    kworker/2:1H   239    199388.093936        74   100         0.000000         1.892300         0.000000         0.000000 0 0 /
 R         taskA-0  2120     32428.281204       582   120         0.000000      1109.911280         0.000000         0.000000 0 0 /autogroup-15
>R         taskB-1  2121     32430.693304       265   120         0.000000      1103.527660         0.000000         0.000000 0 0 /autogroup-15
 R         taskB-2  2122     32432.137084       264   120         0.000000      1105.006760         0.000000         0.000000 0 0 /autogroup-15
 R         taskB-3  2123     32434.997784       282   120         0.000000      1115.965120         0.000000         0.000000 0 0 /autogroup-15

...

Not sure how Vincent's rt-app file looks like exactly but I crafted
something quick here:

{
        "tasks" : {
                "taskA" : {
                        "cpus" : [2],
                        "yield" : "taskA",
                        "run" : 1000
                },
                "taskB" : {
                        "instance" : 3, 
                        "cpus" : [2],
                        "run" : 1000000
                }
        },
        "global" : { 
                "calibration" : 156,
                "default_policy" : "SCHED_OTHER",
                "duration" : 20
        }
} 

[...]

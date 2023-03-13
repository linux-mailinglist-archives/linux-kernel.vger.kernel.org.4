Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 623B36B7217
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 10:09:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjCMJI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 05:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbjCMJI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 05:08:29 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B2E8C222F3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 02:06:53 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C508E2F4;
        Mon, 13 Mar 2023 02:07:36 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5FAAB3F71A;
        Mon, 13 Mar 2023 02:06:51 -0700 (PDT)
Message-ID: <02a08042-e7c4-464d-bc20-9ec4ccdab1ff@arm.com>
Date:   Mon, 13 Mar 2023 10:06:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2] sched/fair: sanitize vruntime of entity being migrated
Content-Language: en-US
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        Zhang Qiao <zhangqiao22@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        juri.lelli@redhat.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        rkagan@amazon.de
References: <20230306132418.50389-1-zhangqiao22@huawei.com>
 <20230309130524.GA273121@hirez.programming.kicks-ass.net>
 <CAKfTPtAf5RrzZRSHtfK+r3QvnFQ-oM3+rJ-z5SB8T4+nUv1aQw@mail.gmail.com>
 <20230309142825.GB273121@hirez.programming.kicks-ass.net>
 <ZAnvCGdlOrWbIC/o@hirez.programming.kicks-ass.net>
 <CAKfTPtADUas2QHZCQyu0ad-JTKRQ=PcsB=o7+PuJNVxHwAzkCQ@mail.gmail.com>
 <ZAs+zV0o9ShO7nLT@vingu-book>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <ZAs+zV0o9ShO7nLT@vingu-book>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/03/2023 15:29, Vincent Guittot wrote:
> Le jeudi 09 mars 2023 ï¿½ 16:14:38 (+0100), Vincent Guittot a ï¿½crit :
>> On Thu, 9 Mar 2023 at 15:37, Peter Zijlstra <peterz@infradead.org> wrote:
>>>
>>> On Thu, Mar 09, 2023 at 03:28:25PM +0100, Peter Zijlstra wrote:
>>>> On Thu, Mar 09, 2023 at 02:34:05PM +0100, Vincent Guittot wrote:

[...]

>> you mean taking the patch 1/2 that you mentioned here to add a
>> migrated field:
>> https://lore.kernel.org/all/68832dfbb60fda030540b5f4e39c5801942689b1.1648228023.git.tim.c.chen@linux.intel.com/T/#ma5637eb8010f3f4a4abff778af8db705429d003b
>>
>> And assume that the divergence between the rq_clock_task() can be ignored ?
>>
>> That could probably work but we need to replace the (60LL *
>> NSEC_PER_SEC) by ((1ULL << 63) / NICE_0_LOAD) because 60sec divergence
>> would not be unrealistic.
>> and a comment to explain why it's acceptable
> 
> Zhang,
> 
> Could you try the patch below ?
> This is a rebase/merge/update of:
> -patch 1/2 above and 
> -https://lore.kernel.org/lkml/20230209193107.1432770-1-rkagan@amazon.de/
> 
> The proposal accepts a divergence of up to 52 days between the 2 rqs.
> 
> If this work, we will prepare a proper patch

Looks to me that this patch brings back the old numbers:

model name	: Intel(R) Xeon(R) Silver 4314 CPU @ 2.40GHz

perf stat --null --repeat 10 -- perf bench sched messaging -g 50 -l 5000

tip sched/core

a2e90611b9f4 - sched/fair: Remove capacity inversion detection
(2023-02-11 Vincent Guittot)

  5.7295 +- 0.0219 seconds time elapsed  ( +-  0.38% )

829c1651e9c4 - sched/fair: sanitize vruntime of entity being placed
(2023-02-11 Zhang Qiao)

  6.0961 +- 0.0297 seconds time elapsed  ( +-  0.49% )

this patch on top 829c1651e9c4

  5.7165 +- 0.0231 seconds time elapsed  ( +-  0.40% )

[...]



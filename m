Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 294D36CF1B7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 20:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbjC2SHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 14:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjC2SHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 14:07:06 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC564202
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 11:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1680113222;
        bh=I4q7sVbxbsxOMp0vkF/MeXrHQ6uqvJkviKOKeFjHrfk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=TIqWUHkjbjh6h9OjIsmolNu50RL/AKrShDWb4n2drSrT7AuimZA6vRS1nU/DIgjYs
         EIe9Kv3ZMPIji6Wiof/skGqIBZb7b1TYpjOOiDQVKx7VtWcJSOMS9jFmbLk+PhAEXJ
         bNKYr3qbJJwUfInNFf5Pu555zu0ptcYSBYg3Uc90bRtNd02m8QGoA41ORUb1eWZmXJ
         BzglBirg2WKQiqu0pU2OmBL7OuCc17NWeC4PL0bRl47z6OkBTifdAAj/4PPNA288ry
         TUo4RXwQMQoSQFpf19hznfh8hkj+iYB+2oTpQnASL4ZwO3fQGPExyYO3ApnvAlcOvh
         psxFXmMhD5wDQ==
Received: from [172.16.0.188] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4Pmvdf0r0DztPN;
        Wed, 29 Mar 2023 14:07:02 -0400 (EDT)
Message-ID: <474f934d-6c13-6755-fa7a-6116b3159301@efficios.com>
Date:   Wed, 29 Mar 2023 14:07:15 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: rq lock contention due to commit af7f588d8f73
Content-Language: en-US
To:     Aaron Lu <aaron.lu@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
References: <20230327080502.GA570847@ziqianlu-desk2>
 <b5e09943-36e6-c89b-4701-5af6408223e8@efficios.com>
 <20230327140425.GA1090@ziqianlu-desk2>
 <fc66a0a9-aeb3-cc80-83fb-a5c02ee898ca@efficios.com>
 <20230328065809.GB4899@ziqianlu-desk2>
 <c481529e-43d4-a5ce-58ca-12e8ea36aa38@efficios.com>
 <20230329074549.GA65916@ziqianlu-desk2>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20230329074549.GA65916@ziqianlu-desk2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-03-29 03:45, Aaron Lu wrote:
> On Tue, Mar 28, 2023 at 08:39:41AM -0400, Mathieu Desnoyers wrote:
>> On 2023-03-28 02:58, Aaron Lu wrote:
>>> On Mon, Mar 27, 2023 at 03:57:43PM -0400, Mathieu Desnoyers wrote:
>>>> I've just resuscitated my per-runqueue concurrency ID cache patch from an older
>>>> patchset, and posted it as RFC. So far it passed one round of rseq selftests. Can
>>>> you test it in your environment to see if I'm on the right track ?
>>>>
>>>> https://lore.kernel.org/lkml/20230327195318.137094-1-mathieu.desnoyers@efficios.com/
>>>
>>> There are improvements with this patch.
>>>
>>> When running the client side sysbench with nr_thread=56, the lock contention
>>> is gone%; with nr_thread=224(=nr_cpu of this machine), the lock contention
>>> dropped from 75% to 27%.
>>
>> This is a good start!
>>
>> Can you compare this with Peter's approach to modify init/Kconfig, make
>> SCHED_MM_CID a bool, and set it =n in the kernel config ?
>>
>> I just want to see what baseline we should compare against.
>>
>> Another test we would want to try here: there is an arbitrary choice for the
>> runqueue cache array size in my own patch:
>>
>> kernel/sched/sched.h:
>> # define RQ_CID_CACHE_SIZE    8
>>
>> Can you try changing this value for 16 or 32 instead and see if it helps?
> 
> I tried 32. The short answer is: for nr_thread=224 case, using a larger
> value doesn't show obvious difference.
> 
> Here is more detailed info.
> 
> During a 5 minutes run, I captued 5s perf every 30 seconds. To avoid
> getting too huge data recorded by perf since this machine has 224 cpus,
> I picked 4 cpus of each node when doing perf record and here are the results:
> 
> Your RFC patch that did mm_cid rq cache:
> node0_1.profile:    26.07%    26.06%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
> node0_2.profile:    28.38%    28.37%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
> node0_3.profile:    25.44%    25.44%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
> node0_4.profile:    16.14%    16.13%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
> node0_5.profile:    15.17%    15.16%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
> node0_6.profile:     5.23%     5.23%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
> node0_7.profile:     2.64%     2.64%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
> node0_8.profile:     2.87%     2.87%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
> node0_9.profile:     2.73%     2.73%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
> node1_1.profile:    23.78%    23.77%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
> node1_2.profile:    25.11%    25.10%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
> node1_3.profile:    21.97%    21.95%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
> node1_4.profile:    19.37%    19.35%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
> node1_5.profile:    18.85%    18.84%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
> node1_6.profile:    11.22%    11.20%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
> node1_7.profile:     1.65%     1.64%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
> node1_8.profile:     1.68%     1.67%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
> node1_9.profile:     1.57%     1.56%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
> 
> Changing RQ_CID_CACHE_SIZE to 32:
> node0_1.profile:    29.25%    29.24%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
> node0_2.profile:    26.87%    26.87%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
> node0_3.profile:    24.23%    24.23%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
> node0_4.profile:    17.31%    17.30%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
> node0_5.profile:     3.61%     3.60%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
> node0_6.profile:     2.60%     2.59%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
> node0_7.profile:     1.77%     1.77%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
> node0_8.profile:     2.14%     2.13%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
> node0_9.profile:     2.20%     2.20%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
> node1_1.profile:    27.25%    27.24%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
> node1_2.profile:    25.12%    25.11%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
> node1_3.profile:    25.27%    25.26%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
> node1_4.profile:    19.48%    19.47%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
> node1_5.profile:    10.21%    10.20%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
> node1_6.profile:     3.01%     3.00%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
> node1_7.profile:     1.47%     1.47%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
> node1_8.profile:     1.52%     1.51%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
> node1_9.profile:     1.58%     1.56%  [kernel.vmlinux]        [k] native_queued_spin_lock_slowpath
> 
> This workload has a characteristic that in the initial ~2 minutes, it has
> more wakeups and task migrations and that probably can explain why lock
> contention dropped in later profiles.

Yeah my RFC patch adds a rq lock on try to wakeup migrations, which I 
suspect is causing this performance regression.

I've come up with a design for an alternative scheme which should be 
much more lightweight locking-wise. I'll see if I can make it work and 
let you know when I have something to test.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


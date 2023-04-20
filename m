Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5846E956C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 15:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbjDTNKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 09:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjDTNKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 09:10:37 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D7701724
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 06:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1681996234;
        bh=Z1jm6r7KGTEWPQO4zIJhNwGVmGMFVzcsA3PsAxFOrfQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Z/Dgo1c/Fy26rJ1/t2oT42z42mUKm6+y6GOzKrSJFKCtaAdQ2pmGsvvUpTmPFaKSm
         7NnLZQMrpKBGvPgu7h758R0+WqpzlxaAvwNq2WarWjfCMkAqdaXdQpeQuu8kaaSIAj
         gIEw660YxS+F6tagybFb8swsLKeXyqiFvmqha8Mw/3C6gkvIyBf/qdBttZxBx42mDM
         1cObSD0HTqx68M3NMfiOajLBuVhjfa/1kLpSLRZZBoW/PQpPXovx1brWfLLgcm+Jaz
         PF81F5HlaekXwNu48lrm7pWVFwwzUOfi+yQzeHahep5ZpDVL8D1LgEnKbI6a1CNXid
         72sqkXp5kkxAA==
Received: from [172.16.0.91] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4Q2J1Q4DCNzwGm;
        Thu, 20 Apr 2023 09:10:34 -0400 (EDT)
Message-ID: <721f4b8b-c238-53b1-9085-a9dae6a961e1@efficios.com>
Date:   Thu, 20 Apr 2023 09:10:35 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFC PATCH v9 2/2] sched: Fix performance regression introduced
 by mm_cid
Content-Language: en-US
To:     Aaron Lu <aaron.lu@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Olivier Dion <odion@efficios.com>,
        michael.christie@oracle.com
References: <20230419155012.63901-1-mathieu.desnoyers@efficios.com>
 <20230419155012.63901-2-mathieu.desnoyers@efficios.com>
 <20230420095610.GA153295@ziqianlu-desk2>
 <c01ddfc5-9410-14e1-55f7-c24f44447f8a@efficios.com>
 <20230420125048.GA154262@ziqianlu-desk2>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20230420125048.GA154262@ziqianlu-desk2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-20 08:50, Aaron Lu wrote:
> On Thu, Apr 20, 2023 at 08:41:05AM -0400, Mathieu Desnoyers wrote:
>> On 2023-04-20 05:56, Aaron Lu wrote:
>>> On Wed, Apr 19, 2023 at 11:50:12AM -0400, Mathieu Desnoyers wrote:
>>>> Introduce per-mm/cpu current concurrency id (mm_cid) to fix a PostgreSQL
>>>> sysbench regression reported by Aaron Lu.
>>>
>>> mm_cid_get() dropped to 5.x% after I disable CONFIG_DEBUG_PREEMPT, using
>>> __this_cpu_X() doesn't help, I suppose that is because __this_cpu_X()
>>> still needs to fetch mm->pcpu_cid.
>>>
>>> Annotate mm_cid_get():
>>>
>>>          │     static inline int mm_cid_get(struct mm_struct *mm)
>>>          │     {
>>>     0.05 │       push   %rbp
>>>     0.02 │       mov    %rsp,%rbp
>>>          │       push   %r15
>>>          │       push   %r14
>>>          │       push   %r13
>>>          │       push   %r12
>>>          │       push   %rbx
>>>     0.02 │       sub    $0x10,%rsp
>>>          │     struct mm_cid __percpu *pcpu_cid = mm->pcpu_cid;
>>>    71.30 │       mov    0x60(%rdi),%r12
>>>          │     struct cpumask *cpumask;
>>>          │     int cid;
>>>          │
>>>          │     lockdep_assert_rq_held(rq);
>>>          │     cpumask = mm_cidmask(mm);
>>>          │     cid = __this_cpu_read(pcpu_cid->cid);
>>>    28.44 │       mov    %gs:0x8(%r12),%edx
>>>          │     if (mm_cid_is_valid(cid)) {
>>>
>>>
>>> sched_mm_cid_migrate_to() is 4.x% and its annotation :
>>>
>>>          │     dst_pcpu_cid = per_cpu_ptr(mm->pcpu_cid, cpu_of(dst_rq));
>>>          │       mov     -0x30(%rbp),%rax
>>>    54.53 │       mov     0x60(%r13),%rbx
>>>    19.61 │       movslq  0xaf0(%rax),%r15
>>>
>>> The reason why accessing mm->pcpu_cid is so costly is still a myth to
>>> me...
>>
>> Then we clearly have another member of mm_struct on the same cache line as
>> pcpu_cid which is bouncing all over the place and causing false-sharing. Any
>> idea which field(s) are causing this ?
> 
> That's my first reaction too but as I said in an earlier reply:
> https://lore.kernel.org/lkml/20230419080606.GA4247@ziqianlu-desk2/
> I've tried to place pcpu_cid into a dedicate cacheline with no other
> fields sharing a cacheline with it in mm_struct but it didn't help...

I see two possible culprits there:

1) The mm_struct pcpu_cid field is suffering from false-sharing. I would be
    interested to look at your attempt to move it to a separate cache line to
    try to figure out what is going on.

2) (Maybe?) The task_struct mm field is suffering from false-sharing and stalling
    the next instruction which needs to use its value to fetch the mm->pcpu_cid
    field. We could try moving the task_struct mm field into its own cache line to
    see if it helps.

Thanks,

Mathieu

> 
> Thanks,
> Aaron

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


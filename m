Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B956D6D6310
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 15:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235111AbjDDNgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 09:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235116AbjDDNgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 09:36:12 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46484C2E
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 06:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1680615345;
        bh=Q3zzaU8OJ7SujJ7Qn+zJDO63bhmu4n16qzbZQvS9wT4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=PcmjDr4TDP+X32BhXg5EpCw7Akhx+fw+B3oLeKPIaN+2rN7RGznx0vUVxmU01dhyz
         /skLlqy1pt4+uLfZOFX/DZxyjkg3lgLe5s6oGRMbor/py9BZb540UGpMY7jPc7NnoH
         MJZivfYemdMLoLrTgDVy3zATGCzkS6X1HYSwhT6ejUj6yjGNSzaQpvANdFUFZbiRaX
         mUU1z+ueEDkyDth0Md3CDAARy1Thl9TN3jn/UEbh+L2xDAO8JGRCRXQUc7x5NFEEJU
         Y27RBL1ZscN9SDdE7eHRO018a4ji/OU+BRC4pNr1dyf8c2+NzQJxmOuHa40bqvR4NL
         RZTmv8amTkxQg==
Received: from [172.16.0.188] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4PrTKs2LvRztx9;
        Tue,  4 Apr 2023 09:35:45 -0400 (EDT)
Message-ID: <e2da64d2-2551-07d8-8905-9a374fdb0591@efficios.com>
Date:   Tue, 4 Apr 2023 09:24:54 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFC PATCH] sched: Fix performance regression introduced by
 mm_cid
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Aaron Lu <aaron.lu@intel.com>
References: <20230403181342.210896-1-mathieu.desnoyers@efficios.com>
 <20230404090507.GB284733@hirez.programming.kicks-ass.net>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20230404090507.GB284733@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RDNS_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-04 05:05, Peter Zijlstra wrote:
> On Mon, Apr 03, 2023 at 02:13:42PM -0400, Mathieu Desnoyers wrote:
>>   void sched_mm_cid_exit_signals(struct task_struct *t)
>>   {
>>   	struct mm_struct *mm = t->mm;
>> -	unsigned long flags;
>> +	struct rq_flags rf;
>> +	struct rq *rq;
>>   
>>   	if (!mm)
>>   		return;
>> -	local_irq_save(flags);
>> +
>> +	preempt_disable();
>> +	rq = this_rq();
>> +	rq_lock_irqsave(rq, &rf);
>>   	mm_cid_put(mm, t->mm_cid);
>> -	t->mm_cid = -1;
>> +	t->last_mm_cid = t->mm_cid = -1;
>>   	t->mm_cid_active = 0;
>> -	local_irq_restore(flags);
>> +	rq_unlock_irqrestore(rq, &rf);
>> +	preempt_enable();
>>   }
> 
> FWIW a *slightly* cheaper form is:
> 
> 	preempt_disable();
> 	rq = this_rq();
> 	rq_lock_irqsave(rq, &rf);
> 	preempt_enable_noresched(); /* holding spinlock */
> 	...
> 	rq_unlock_irqrestore(rq, &rf);

Good point, updated for next round.

Thanks,

Mathieu



-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


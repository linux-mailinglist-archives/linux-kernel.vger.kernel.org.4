Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02A95621D30
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 20:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbiKHTp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 14:45:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiKHTpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 14:45:21 -0500
Received: from smtpout.efficios.com (smtpout.efficios.com [IPv6:2607:5300:203:5aae::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519D31D654;
        Tue,  8 Nov 2022 11:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1667936717;
        bh=N9FGx501778vNVrOHYv7pAKWQyx42YqgfZDZQz7Kpgk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=k3iNJAuKTFU1zCZs/molOCmMlgz/rjg/gx2J96nBs8Qmowxl5/5/XbzmM8ddiN31j
         HH4vY1V+Uxx11sHIUyU0mRQmfs0aMLSZ5a/hDbv13H4spU7VQ8qf8+L/eIZWvDnQ6N
         gZlzjsswfTAW1xCXAv7yESvj2OK11CO1cnMXGS9n2glgaqwBEkIBADosDHvorRPBwl
         nf+qFoDKxJndZCKSQczBv5XFZUTh3oSyQyJxyTvL1kBrAuE05fxgs5r+fvXxkMOCp1
         QER9Qns99zg8tw80p/vMPMxUTTon9pMOpqjOGnuM1kh53FKdiK+OBDXP+4MLO/tg01
         RlnUMNIryPV9Q==
Received: from [172.16.0.153] (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4N6JV51LvbzgHZ;
        Tue,  8 Nov 2022 14:45:17 -0500 (EST)
Message-ID: <916c7a1f-fddd-77d6-6f91-6d3c196e1d86@efficios.com>
Date:   Tue, 8 Nov 2022 14:45:24 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v5 08/24] sched: Introduce per memory space current
 virtual cpu id
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
        Florian Weimer <fw@deneb.enyo.de>, David.Laight@aculab.com,
        carlos@redhat.com, Peter Oskolkov <posk@posk.io>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        Chris Kennelly <ckennelly@google.com>
References: <20221103200359.328736-1-mathieu.desnoyers@efficios.com>
 <20221103200359.328736-9-mathieu.desnoyers@efficios.com>
 <Y2pS4gC1MHw+mX3x@hirez.programming.kicks-ass.net>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <Y2pS4gC1MHw+mX3x@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-11-08 08:00, Peter Zijlstra wrote:
> On Thu, Nov 03, 2022 at 04:03:43PM -0400, Mathieu Desnoyers wrote:
> 
>> diff --git a/fs/exec.c b/fs/exec.c
>> index 349a5da91efe..93eb88f4053b 100644
>> --- a/fs/exec.c
>> +++ b/fs/exec.c
>> @@ -1013,6 +1013,9 @@ static int exec_mmap(struct mm_struct *mm)
>>   	tsk->active_mm = mm;
>>   	tsk->mm = mm;
>>   	lru_gen_add_mm(mm);
>> +	mm_init_vcpu_lock(mm);
>> +	mm_init_vcpumask(mm);
>> +	mm_init_node_vcpumask(mm);
>>   	/*
>>   	 * This prevents preemption while active_mm is being loaded and
>>   	 * it and mm are being updated, which could cause problems for
> 
>> @@ -1150,6 +1154,9 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
>>   
>>   	mm->user_ns = get_user_ns(user_ns);
>>   	lru_gen_init_mm(mm);
>> +	mm_init_vcpu_lock(mm);
>> +	mm_init_vcpumask(mm);
>> +	mm_init_node_vcpumask(mm);
>>   	return mm;
>>   
>>   fail_nocontext:
> 
> Why isn't all that a single mm_init_vcpu(mm) or something ?

Good point, I'll update that.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


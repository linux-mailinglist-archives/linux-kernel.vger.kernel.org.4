Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 523DF712A9E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 18:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbjEZQ14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 12:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjEZQ1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 12:27:54 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2BA5BC;
        Fri, 26 May 2023 09:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1685118470;
        bh=53Ui1FacFGLMIwxIRV2cMJLHjiRqHs6B8HmABbhs+ok=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=WH+9Dt9InAm2ndwOMg6kV+/mrTfRoUe1yE4vvSuYItQNeK0QnIfP5TT3mblSN5BK3
         d2DpBf8Epv0tZyrlbNet456RlhOhwVIM0LGsRdfcZd8Fz790NTHtjFGRkdy3O0ax1R
         OU2QgzJncJ+jXDLlh1U5V05uTEWwRObdEcAkbr+p+7iwMu/fBKEqNc0LqwRMNpcXfi
         C7yJ6yXPVVkizuOeQuXtM8u56xFAYA1mDZaO8Hmp9nxqPq104iSKRYpbQTlDMnpQV2
         3Y5/k5zmn74yt3PvWIIz6G7HDOs4PK6FLr4I9tuCdxPbKraaHzFyqzI8PlaZGzFaql
         3xGLWcxGDmZNw==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4QSVhP75bxz13hj;
        Fri, 26 May 2023 12:27:49 -0400 (EDT)
Message-ID: <d806769b-c568-fa7c-f7aa-ded9ffea11b4@efficios.com>
Date:   Fri, 26 May 2023 12:27:51 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC][PATCH 2/2] sched: Use fancy new guards
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     torvalds@linux-foundation.org, keescook@chromium.org,
        pbonzini@redhat.com, linux-kernel@vger.kernel.org,
        ojeda@kernel.org, ndesaulniers@google.com, mingo@redhat.com,
        will@kernel.org, longman@redhat.com, boqun.feng@gmail.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, josh@joshtriplett.org,
        jiangshanlai@gmail.com, qiang1.zhang@intel.com,
        rcu@vger.kernel.org, tj@kernel.org, tglx@linutronix.de
References: <20230526150549.250372621@infradead.org>
 <20230526151947.027972233@infradead.org>
 <2023052626-blunderer-delegator-4b82@gregkh>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <2023052626-blunderer-delegator-4b82@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/26/23 12:25, Greg KH wrote:
> On Fri, May 26, 2023 at 05:05:51PM +0200, Peter Zijlstra wrote:
>> Convert kernel/sched/core.c to use the fancy new guards to simplify
>> the error paths.
> 
> That's slightly crazy...
> 
> I like the idea, but is this really correct:
> 
> 
>>
>> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>> ---
>>   kernel/sched/core.c  | 1223 +++++++++++++++++++++++----------------------------
>>   kernel/sched/sched.h |   39 +
>>   2 files changed, 595 insertions(+), 667 deletions(-)
>>
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -1097,24 +1097,21 @@ int get_nohz_timer_target(void)
>>   
>>   	hk_mask = housekeeping_cpumask(HK_TYPE_TIMER);
>>   
>> -	rcu_read_lock();
>> -	for_each_domain(cpu, sd) {
>> -		for_each_cpu_and(i, sched_domain_span(sd), hk_mask) {
>> -			if (cpu == i)
>> -				continue;
>> +	void_scope(rcu) {
>> +		for_each_domain(cpu, sd) {
>> +			for_each_cpu_and(i, sched_domain_span(sd), hk_mask) {
>> +				if (cpu == i)
>> +					continue;
>>   
>> -			if (!idle_cpu(i)) {
>> -				cpu = i;
>> -				goto unlock;
>> +				if (!idle_cpu(i))
>> +					return i;
> 
> You can call return from within a "scope" and it will clean up properly?
> 
> I tried to read the cpp "mess" but couldn't figure out how to validate
> this at all, have a set of tests for this somewhere?
> 
> Anyway, the naming is whack, but I don't have a proposed better name,
> except you might want to put "scope_" as the prefix not the suffix, but
> then that might look odd to, so who knows.

FWIW C++ has std::scoped_lock. So perhaps using a similar wording may help ?

Thanks,

Mathieu

> 
> But again, the idea is good, it might save us lots of "you forgot to
> clean this up on the error path" mess that we are getting constant churn
> for these days...
> 
> thanks,
> 
> greg k-h

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


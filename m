Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 366306C7054
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 19:37:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbjCWShJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 14:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbjCWShH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 14:37:07 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66DD8198
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 11:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1679596623;
        bh=OkhPr6SOvA+pRU6TU08dl58iBF2llThykUHRT+ucT1c=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=nfgSvF3ApIHP8wQBRrfEk4qZzx6AKxK0MON5uMwbMi7jOVsL9rCakDrXaYV3ji7/O
         dRz9D91GBBAolJbxhTXl20rbdl4/yUuVXosoWv5eonIQx/8b04WtZ3JcV85rSQskdP
         qJrOiFMBxYaM6yHV+7tchCVlUH9u0eqVfv8LNWjDqUTUA+zfG5ogpTg+EXmS361v97
         JPHWe2vnKP4jzE94vGqfqg5VohvcRWW4D6wD+wN594EhPCWz1RSYuHyVI/7n8JS2j4
         H9z/7gP1FKc4yrx3hePnjbXEpQkDeEes0uR8KLa6Py0TKguldn3i7pJk+qMeSFhm7I
         Y2ATVU1NED3HQ==
Received: from [172.16.0.188] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4PjDb309KlzsgZ;
        Thu, 23 Mar 2023 14:37:03 -0400 (EDT)
Message-ID: <ed29379c-d683-7140-ba82-b3fe8e4d49a5@efficios.com>
Date:   Thu, 23 Mar 2023 14:37:15 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] tracepoint: Fix CFI failures with tp_stub_func
To:     Steven Rostedt <rostedt@goodmis.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        "Jose E. Marchesi" <jose.marchesi@oracle.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <20230323114012.2162285-1-mark.rutland@arm.com>
 <20230323085321.0f8d1b98@gandalf.local.home>
 <ZBxX/uu/s5IKBQOw@FVFF77S0Q05N.cambridge.arm.com>
 <ZBx9+ZyiF6LoKbPr@FVFF77S0Q05N.cambridge.arm.com>
 <20230323123455.36dd83f6@gandalf.local.home>
Content-Language: en-US
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20230323123455.36dd83f6@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RDNS_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-03-23 12:34, Steven Rostedt wrote:
> On Thu, 23 Mar 2023 16:27:37 +0000
> Mark Rutland <mark.rutland@arm.com> wrote:
> 
>> On Thu, Mar 23, 2023 at 01:45:34PM +0000, Mark Rutland wrote:
>>> On Thu, Mar 23, 2023 at 08:53:21AM -0400, Steven Rostedt wrote:
>>>> On Thu, 23 Mar 2023 11:40:12 +0000
>>>> Mark Rutland <mark.rutland@arm.com> wrote:
>>
>>>>> diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
>>>>> index 6811e43c1b5c2..1640926441910 100644
>>>>> --- a/include/linux/tracepoint.h
>>>>> +++ b/include/linux/tracepoint.h
>>>>> @@ -303,6 +303,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>>>>>   	__section("__tracepoints_strings") = #_name;			\
>>>>>   	extern struct static_call_key STATIC_CALL_KEY(tp_func_##_name);	\
>>>>>   	int __traceiter_##_name(void *__data, proto);			\
>>>>> +	void __tracestub_##_name(void *, proto);			\
>>>>>   	struct tracepoint __tracepoint_##_name	__used			\
>>>>>   	__section("__tracepoints") = {					\
>>>>>   		.name = __tpstrtab_##_name,				\
>>>>> @@ -310,6 +311,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>>>>>   		.static_call_key = &STATIC_CALL_KEY(tp_func_##_name),	\
>>>>>   		.static_call_tramp = STATIC_CALL_TRAMP_ADDR(tp_func_##_name), \
>>>>>   		.iterator = &__traceiter_##_name,			\
>>>>> +		.stub = &__tracestub_##_name,				\
>>>>>   		.regfunc = _reg,					\
>>>>>   		.unregfunc = _unreg,					\
>>>>>   		.funcs = NULL };					\
>>>>> @@ -330,6 +332,9 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>>>>>   		}							\
>>>>>   		return 0;						\
>>>>>   	}								\
>>>>> +	void __tracestub_##_name(void *__data, proto)			\
>>>>> +	{								\
>>>>> +	}								\
>>>>
>>>> I purposely did not do this because this adds over a thousand stub
>>>> functions! It adds one for *every* tracepoint (and that is a superset of
>>>> trace events).
>>>>
>>>> Is there some other way we could do this?
>>>>
>>>> C really really needs a way to make a generic void do_nothing(...) function!
>>>>
>>>> I added some compiler folks to the Cc to hear our grievances.
>>>
>>> I pulled in Sami, who did much of the kCFI work, and PeterZ too...
>>>
>>> We can't have a generic function that's compatible will all function
>>> prototypes, since that mechanism would undermine the CFI scheme. Either callers
>>> would always have to omit the check, or we're have to have a special "always
>>> compatible" type hash, and both would be gigantic targets for attack.
>>>
>>> Can we avoid the stub entirely? e.g. make hte call conditional on the func
>>> pointer not being some bad value (e.g. like the error pointers?). That way we
>>> could avoid the call, and we wouldn't need the stub implementation.
>>
>> Along those lines (and as Peter also suggested over IRC), would something like
>> the below be preferable?
> 
> So we had this discussion a while ago:
> 
> See befe6d946551 ("tracepoint: Do not fail unregistering a probe due to memory failure")
> 
> Where I believe one answer was to use NULL instead of a stub.
> 
> I have to go back and re-read that thread. Mathieu was involved with all
> this too.
> 
> And as I mentioned in my other reply. There was a more complex solution
> that could handle this if the stub solution ended up being an issue.
> 
> Repeated again so Mathieu doesn't have to search for it.
> 
>      [ Note, this version does use undefined compiler behavior (assuming that
>        a stub function with no parameters or return, can be called by a location
>        that thinks it has parameters but still no return value. Static calls
>        do the same thing, so this trick is not without precedent.
> 
>        There's another solution that uses RCU tricks and is more complex, but
>        can be an alternative if this solution becomes an issue.
> 
>        Link: https://lore.kernel.org/lkml/20210127170721.58bce7cc@gandalf.local.home/
>      ]

Ugh. The last thing we need there is more RCU complexity. My brain is still recovering
from fixing the last time the introduction of static calls special-cases ended up subtly
breaking tracepoints.

> 
> -- Steve
> 
> 
>>
>> Mark.
>>
>> ---->8----
>> diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
>> index 6811e43c1b5c..b8017e906049 100644
>> --- a/include/linux/tracepoint.h
>> +++ b/include/linux/tracepoint.h
>> @@ -33,6 +33,8 @@ struct trace_eval_map {
>>   
>>   #define TRACEPOINT_DEFAULT_PRIO	10
>>   
>> +void tp_stub_func(void);
>> +
>>   extern struct srcu_struct tracepoint_srcu;
>>   
>>   extern int
>> @@ -324,6 +326,8 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>>   		if (it_func_ptr) {					\
>>   			do {						\
>>   				it_func = READ_ONCE((it_func_ptr)->func); \
>> +				if (it_func == tp_stub_func)		\
>> +					continue;			\

Along the lines of my earlier proposal:

https://lore.kernel.org/all/1889971276.46615.1605559047845.JavaMail.zimbra@efficios.com/

We could reserve (void *)0x1 as a stub value rather than adding an explicit stub function
if we end up skipping the call anyway. The check could be:

#define TP_STUB_FN	((void *)0x1)

if (unlikely(it_func == TP_STUB_FN))
   continue;

And we would only need that check for CONFIG_HAVE_STATIC_CALL=y right ?

Thanks,

Mathieu


>>   				__data = (it_func_ptr)->data;		\
>>   				((void(*)(void *, proto))(it_func))(__data, args); \
>>   			} while ((++it_func_ptr)->func);		\
>> diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
>> index 8d1507dd0724..dcf5a637429f 100644
>> --- a/kernel/tracepoint.c
>> +++ b/kernel/tracepoint.c
>> @@ -99,7 +99,7 @@ struct tp_probes {
>>   };
>>   
>>   /* Called in removal of a func but failed to allocate a new tp_funcs */
>> -static void tp_stub_func(void)
>> +void tp_stub_func(void)
>>   {
>>   	return;
>>   }
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A93B764BB33
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 18:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235808AbiLMRkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 12:40:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236046AbiLMRkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 12:40:10 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8CBB6EE1E
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 09:40:09 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E6DA22F4;
        Tue, 13 Dec 2022 09:40:49 -0800 (PST)
Received: from [192.168.89.251] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4D2113F73B;
        Tue, 13 Dec 2022 09:40:08 -0800 (PST)
Message-ID: <48c3eaa4-e896-16c4-af7f-a7e4f0541f01@arm.com>
Date:   Tue, 13 Dec 2022 17:40:06 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [for-next][PATCH 02/11] tracing: Add __cpumask to denote a trace
 event field that is a cpumask_t
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Valentin Schneider <vschneid@redhat.com>
References: <20221124145019.782980678@goodmis.org>
 <20221124145045.743308431@goodmis.org>
 <6dda5e1d-9416-b55e-88f3-31d148bc925f@arm.com>
 <20221212111256.3cf68f3e@gandalf.local.home>
 <8448372a-6911-e920-b630-15af850adcae@arm.com>
 <20221212185330.639bf491@gandalf.local.home>
 <764f8b9a-2111-c260-7f2c-89eb9f0ac7a3@arm.com>
 <20221213101111.335ae0e7@gandalf.local.home>
From:   Douglas Raillard <douglas.raillard@arm.com>
In-Reply-To: <20221213101111.335ae0e7@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-12-2022 15:11, Steven Rostedt wrote:
> On Tue, 13 Dec 2022 14:20:12 +0000
> Douglas Raillard <douglas.raillard@arm.com> wrote:
> 
> 
>>>>>
>>>>> The above is for the kernel to build.
>>>>
>>>> That was my understanding that the comparison issue is related to in-kernel filtering ?
>>>> If that's the case, I completely agree that the type kernel code sees does not _have_
>>>> to be the same thing that is exposed to userspace if that simplifies the problem.
>>>
>>> Yes, and note the patch I sent out to fix this.
>>
>> I did, that's some seriously fast TAT :)
> 
> I'm going to pull that one in and start testing, so I can push it out in
> this merge window.
> 
> 
> 
>>> That third part may be difficult with the above issue I mentioned.
>>>
>>> Just do:
>>>
>>>    git grep '__field(' | cut -d',' -f1 | cut -d'(' -f2 | sed -e 's/[    ]*//'
>>>    | sort -u
>>>
>>> to see what's in the kernel.
>>
>> There are lots of types, but as long as the caller knows what to ask for, it shouldn't be an issue.
>> Pretty printing the trace is obviously an important aspect and ideally requires the parser to know
>> how to format everything.
>>
>> But when it comes to other processing in a compiled language, it's not a big burden to let people
>> declare the events they require and the expected fields + types so they can get the data into their
>> own struct (e.g. as with serde or any equivalent technology).
> 
> That's what is done today. The size and offset is how the tools can get to
> the data and it knows what to do with it.
> 
> I'm not sure how rust can handle this type of opaque type scheme.

In a similar way, the user asks to parse e.g. an UnsignedLongArray and
the lib returns either the 32bit or 64bit variant, with mismatching endianness
fixed up (so the data are in host endianness). The caller has to handle both 32bit
and 64bits cases so everything is type safe.

> 
> 
>>> Note, I put much more effort into the offset, size and sign than the type.
>>> But is this only for the arrays that you have these restrictions, or any
>>> field type?
>>
>> In terms of borken pretty printing, it's a general issue not limited to dynamic arrays.
> 
> Yeah, the pretty printing can easily fail, as it can have anything that the
> kernel can do. Including calling functions that are not available to user
> space. This is why the fallback is always back to size, offset and sign.
> 
>> The only ways pretty printing for an opaque type can possibly work for new types the parser has no
>> specific knowledge of are:
>> 1. The type is not actually opaque, i.e. it comes with some decoding schema (just like the events have
>>      a schema listing their fields + types)
>> 2. The type is opaque, but also ships with an executable description of how to print it.
>>      E.g. if there was a WASM/eBPF/whatever bytecode printing routine made available to userspace.
>>
>> Option (2) is not so appealing as it's both hard to achieve and only allows a fixed set of
>> behaviors for a type. Option (1) is a lot easier and allows the behaviors to be defined
>> on the user side.
>>
>> Wild idea: include the BTF blob in the trace.dat header so no type is opaque anymore. The printing
>> issue is not entirely solved this way (e.g. cpumask still needs some plugin to be displayed as a list
>> of CPUs), but we could at least print all structs in "raw" mode and enum symbolically.
> 
> And how big is that blob?

Less than 3MB AFAIR. For comparison, /proc/kallsyms takes 11MB on my machine.
In one of my test traces, it's 17MB. Maybe it's compressed in trace.dat v7 though, haven't checked.
  

> I'm not against the idea, but I would like it to only hold what is needed

I suppose it's doable to derive a subset of the info with some efforts.

> 
>>
>> That could also allow creating a quick&dirty way of defining a proper event (aka not trace_printk()):
> 
> 
> I prefer not to have "quick&dirty" ;-)

I'm not saying that I would like to see such quick and dirty events upstream, but the reality around me is
that ftrace events is the only sane way of having an idea what the scheduler does. This means people need
to create experiments all the time with ad-hoc trace events, on top of the trace events that we attach to
tracepoints via a module. Currently, people use trace_printk() for that, which comes with some significant
amount of work and pain (mostly regex speed).

That said having just looked at bprint, I could probably support trace_printk() format strings with simple
struct member access (i.e. no __printflags shenanigans etc) as normal events relatively easily. It's even
possible to use the fmt string pointer as an "event ID". Still a shame that all the event field format infra
basically gets duplicated in a printf format string ...

> 
>>
>> 	#define SIMPLE_TRACE_EVENT(type, fields) \
>> 	struct type fields;	
>> 	TRACE_EVENT(type, \
>> 		TP_PROTO(struct type *data), \
>> 		TP_ARGS(data), \
>> 		TP_STRUCT__entry(__field(struct type, data)), \
>> 		TP_fast_assign(__entry->data = *data;), \
>> 		TP_printk("print in raw mode to display the data"), \
>> 	);
>> 	#define SIMPLE_TRACE(type, fields) trace_struct_##type(&(struct type)fields)
>>
>>
>> 	SIMPLE_TRACE_EVENT(myevent, {
>> 		char name[11];
>> 		int foobar;
>> 	});
>> 	
>> 	SIMPLE_TRACE(myevent, {.name = "hello", .foobar = 42});
> 
> 
>>
>> The format string could be either kernel-generated based on BTF or userspace could be expected
>> to make its own use of BTF.
> 
> What's the use case for the above?

An equivalent to trace_printk() that exposes its fields in the "normal" way rather than having to parse
the format string and a comma-separated list of C expressions. Life is too short to write C interpreters.
Parsing BTF is at least a finite amount of work. But I guess it would be easy to handle only "REC->field"
expressions.

-- Douglas

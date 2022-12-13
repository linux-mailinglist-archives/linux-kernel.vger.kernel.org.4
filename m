Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57AF364B731
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 15:20:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235698AbiLMOUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 09:20:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235626AbiLMOUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 09:20:12 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D335D1FF9A
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 06:20:10 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 326BE2F4;
        Tue, 13 Dec 2022 06:20:51 -0800 (PST)
Received: from [192.168.89.251] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 52C443F71E;
        Tue, 13 Dec 2022 06:20:09 -0800 (PST)
Message-ID: <764f8b9a-2111-c260-7f2c-89eb9f0ac7a3@arm.com>
Date:   Tue, 13 Dec 2022 14:20:12 +0000
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
From:   Douglas Raillard <douglas.raillard@arm.com>
In-Reply-To: <20221212185330.639bf491@gandalf.local.home>
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

On 12-12-2022 23:53, Steven Rostedt wrote:
> On Mon, 12 Dec 2022 22:19:17 +0000
> Douglas Raillard <douglas.raillard@arm.com> wrote:
> 
>>>>>      field:__data_loc cpumask_t *[] mask;    offset:36;      size:4; signed:0;
>>>
>>> The current parsing tools break the above into:
>>>
>>>    "field:" "__data_loc" <some-type> "[]" <var-name> ";" "offset:"
>>>    <offset> ";" "size:" "<size>" ";" "signed:" <signed> ";"
>>>
>>> Where the <some-type> really can be anything, and in lots of cases, it is.
>>> Thus its only a hint for the tooling, and has never been limited to what
>>> they are.
>>
>> While we are having a look at that, what is the exact format of "<some-type>" ?
> 
> It's literally anything that the kernel excepts and can be in a kernel
> structure. As the macro in the kernel defines both the internal structure
> and what gets printed in the field. This is why the parsing tooling never
> was very strict on <some-type> because a lot of times its something that it
> does not recognize. Any new type added in a trace event will show up here.
> 
> 
>>>
>>> The above is for the kernel to build.
>>
>> That was my understanding that the comparison issue is related to in-kernel filtering ?
>> If that's the case, I completely agree that the type kernel code sees does not _have_
>> to be the same thing that is exposed to userspace if that simplifies the problem.
> 
> Yes, and note the patch I sent out to fix this.

I did, that's some seriously fast TAT :)

>>
>>>>
>>>> How is tooling expected to distinguish between a real dynamic array of pointers
>>>> from a type that is using dynamic arrays as an "implementation detail"
>>>> with a broken type description ? Any reasonable
>>>> interpretation of that type by the consuming tool will be broken
>>>> unless it specifically knows about __data_loc cpumask*[].
>>>
>>> I'm curious to what the tool does differently with the above. What tool are
>>> you using? Does it just give up on how to print it?
>>
>> I'm implementing the Rust libtraceevent/libtracecmd prototype. The use case I'm trying
> 
> Duh! Of course. This is what we discussed at the tracing summit. I just now
> noticed your name ;-)
> 
>> to address in my first draft is:
>>
>> * a parser for trace.dat exposing a stable API that does not need to be updated every day.
>> * A serde backend using that parser
>> * Any "fancy" type (i.e. that is not a basic scalar type or string) is handled by
>>     the consumer of the deserializer. This means the backend must be able to fallback
>>     on providing sensible raw data that can be processed by the user.
> 
> That third part may be difficult with the above issue I mentioned.
> 
> Just do:
> 
>   git grep '__field(' | cut -d',' -f1 | cut -d'(' -f2 | sed -e 's/[    ]*//'
>   | sort -u
> 
> to see what's in the kernel.

There are lots of types, but as long as the caller knows what to ask for, it shouldn't be an issue.
Pretty printing the trace is obviously an important aspect and ideally requires the parser to know
how to format everything.

But when it comes to other processing in a compiled language, it's not a big burden to let people
declare the events they require and the expected fields + types so they can get the data into their
own struct (e.g. as with serde or any equivalent technology).

> 
>>
>> In a more general way, I'm trying to structure the code so that the generic trace.dat parsing
>> lib will be able to handle opaque types by returning a sensibly-typed buffer to the caller. The
>> caller then decodes it the way it wants. This would apply equally well to a C API.
>>
>> That is especially important for user-defined fancy types, e.g. in a kernel module. We cannot
>> reasonably expect users to modify the parsing library itself when they could handle the
>> decoding on their side with an annotation and a custom decoder [1].
>>
>> Beyond that, any tool that reads the trace and pretty prints it is bound to provide
>> broken printing for these types: there will be a date T1 where a new fancy type is introduced
>> in the trace. Until date T2 when the tool gets explicit support for the type, it will
>> display the thing as an array of pointers. Interpreting a bitmask as an array of pointer makes
>> no sense for anyone (machine or human). It so happens that unsigned long == ptr size so it
>> kind of makes sense for cpumask, but an opaque type might internally be u8[], in which case,
>> printing as void* [] is meaningless. It would likely be better to display a placeholder
>> or a plain u8[]. The "semantic_type" field property proposal is an improvement of that.
> 
> Note, I put much more effort into the offset, size and sign than the type.
> But is this only for the arrays that you have these restrictions, or any
> field type?

In terms of borken pretty printing, it's a general issue not limited to dynamic arrays.
The only ways pretty printing for an opaque type can possibly work for new types the parser has no
specific knowledge of are:
1. The type is not actually opaque, i.e. it comes with some decoding schema (just like the events have
    a schema listing their fields + types)
2. The type is opaque, but also ships with an executable description of how to print it.
    E.g. if there was a WASM/eBPF/whatever bytecode printing routine made available to userspace.

Option (2) is not so appealing as it's both hard to achieve and only allows a fixed set of
behaviors for a type. Option (1) is a lot easier and allows the behaviors to be defined
on the user side.

Wild idea: include the BTF blob in the trace.dat header so no type is opaque anymore. The printing
issue is not entirely solved this way (e.g. cpumask still needs some plugin to be displayed as a list
of CPUs), but we could at least print all structs in "raw" mode and enum symbolically.

That could also allow creating a quick&dirty way of defining a proper event (aka not trace_printk()):

	#define SIMPLE_TRACE_EVENT(type, fields) \
	struct type fields;	
	TRACE_EVENT(type, \
		TP_PROTO(struct type *data), \
		TP_ARGS(data), \
		TP_STRUCT__entry(__field(struct type, data)), \
		TP_fast_assign(__entry->data = *data;), \
		TP_printk("print in raw mode to display the data"), \
	);
	#define SIMPLE_TRACE(type, fields) trace_struct_##type(&(struct type)fields)


	SIMPLE_TRACE_EVENT(myevent, {
		char name[11];
		int foobar;
	});
	
	SIMPLE_TRACE(myevent, {.name = "hello", .foobar = 42});

The format string could be either kernel-generated based on BTF or userspace could be expected
to make its own use of BTF.

> 
>>
>>
>>> )
>>>> However, the set of types using that trick is unbounded so forward
>>>> compatibilty is impossible to ensure. On top of that, an actual
>>>> dynamic array of cpumask pointers becomes impossible to represent.
>>>
>>> I never thought about a user case where we print out an array of cpumask
>>> pointers.
>>
>> That case (array of pointer) might be a bit far fetched but kernel already contains
>> weird stuff such as pointers to opaque struct, I suppose as a way of giving a unique
>> ID to something. The solution we settle on for cpumask should be applicable to any opaque
>> type present and future so baking such limitations in the foundations of the event system
>> does not sound like a terribly good idea.
> 
> The above should be moot by now, as my new patch removes the "*" pointer.
> 
>>
>> After reflecting on how the caller of the deserializer can process opaque data, I came
>> to the conclusion that it will have to know the underlying type (unsigned long[]) and
>> ask for an enum such as:
>>
>> enum UnsignedLongArray {
>> 	Bit32(Vec<u32>),
>> 	Bit64(Vec<u64>),
>> }
>>
>> When asked for UnsignedLongArray, the serde backend will use the ABI info from the trace
>> to select the appropriate variant.
>>
>>>    
>>>>
>>>> You might object that if the tool does not know about cpumask,
>>>> it does not matter "how it breaks" as the display will be useless anyway,
>>>> but that is not true. A parsing library might just parse up to
>>>> its knowledge limit and return the most elaborate it can for a given field.
>>>> It's acceptable for that representation to not be elaborated with the full
>>>> semantic expected by the end user, but it should not return
>>>> something that is lying on its nature. For example, it would be sane for
>>>> the user to assert the size of an array of pointers to be a multiple
>>>> of a pointer size. cpumask is currently an array of unsigned long but there is
>>>> nothing preventing a similar type to be based on an array of u8.
>>>> Such a type would also have different endianness handling and the resulting buffer
>>>> would be garbage.
>>>>
>>>>
>>>> To fix that issue, I propose to expose the following to userspace:
>>>> 1. The binary representation type (unsigned long[] in cpumask case).
>>>> 2. An (ordered list of) semantic type that may or may not be the same as 1.
>>>>
>>>> Type (1) can be used to guarantee correct handling of endianness and a reasonable
>>>> default display, while (2) allows any sort of fancy interpretation, all that while preserving
>>>> forward compatibility. For cpumask, this would give:
>>>> 1. unsigned long []
>>>> 2. bitmask, cpumask
>>>>
>>>> A consumer could know about bitmask as they are likely used in multiple places,
>>>> but not about cpumask specifically (e.g. assuming cpumask is a type recently introduced).
>>>> Displaying as a list of bits set in the mask would already allow proper formatting, and
>>>> knowing it's actually a cpumask can allow fancier behaviors.
>>>>
>>>>    From an event format perspective, this could preserve reasonable backward compat
>>>> by simply adding another property:
>>>>
>>>>      field:__data_loc unsigned long[] mask;    offset:36;      size:4; signed:0; semantic_type:bitmask,cpumask;
>>>>
>>>> By default, "semantic_type" would simply have the same value as the normal type.
>>>
>>> The problem with the above is that it adds a new field, and I have to check
>>> if that doesn't break existing tooling.
>>
>> Yes, I was hesitating to propose that as well. I think it would be reasonable to allow for this
>> sort of extension in man trace.dat in the future but maybe that's something for version 8.
>> In my implementation I parse that to a map anyway, so unknown properties will simply be ignored.
>>
>>> Another possibility is that I can add parsing to the format that is exposed
>>> to user space and simply s/__cpumask *[]/__cpumask[]/
>>>
>>> Which will get rid of the pointer array of cpu masks.
>>
>> My main concern is if the item size info becomes available in the future as a field property,
>> we won't be able to make dynamic arrays of opaque types if the array notation is
>> already taken for single items.
> 
> I believe we already have opaque type arrays.
> 
> And the current libtraceevent allows for plugins that will override the
> print-fmt parsing to allow for the plugin to know how to parse it properly.
> 
> 
>>
>> So really ideally we want "__data_loc cpumask" and not "__data_loc cpumask[]", as the latter is an
>> array of cpumasks, and the former a single one. Or maybe something like "__data_loc SINGLE_cpumask[]".
> 
> The [] just means that the size is not defined, and that current tools will
> parse it correctly, even if it does not know what cpumask is.
> 
> An array of cpumask_t is redundant, as it really becomes one bigger
> cpumask_t.

It's not. A list of 21 CPU affinity masks in a system with 5 CPUs is definitely not the same thing as one mask
of size 105. Yes they are isomorphic but so is a task's comm (15 char * 7 bits = 105 bits). We are trying to
express what the data represent, not merely the amount of info required to encode them.

Now I'm not saying that we can create such array of cpumasks using dynamic arrays in the current
state of the kernel macro infrastructure, but it's an implementation detail. That should be able to evolve
independently of the data model exposed to userspace.

> 
>> That format would still be parseable by current userspace tools as an opaque type since SINGLE_cpumask
>> is a valid C identifier.
>>
>> Beyond extensibility, it would make __data_loc inconsistent:
>> * for basic types like u32, it's completely expected to be an actual array.
>> * but for opaque types, it's expected to be a single item and not an array at all.
>>
>>>    
>>>>
>>>> This applies to any type, not just dynamic arrays.
>>>>   
>>>
>>> Let me know if the above does break existing user space and I'll revert it.
>>
>> I could experiment with trace-cmd but I'm not familiar with everything out there decoding that.
>> The parser I'm working on is 1.5 week old and unreleased so no change would be an issue as long
>> as it's possible to distinguish new formats from old ones (to process old traces).
>>
> 
> [ /me goes and does some testing ...]
> 
> Actually, the cpumask[] fails to parse regardless it seems, so I'm free to
> change this anyway I want and still not cause regressions.
> 
> This means I can make it this:
> 
>    field:__data_loc cpumask_t mask;    offset:36;      size:4; signed:0;
> 
> 
> and it should not cause any regression, as it already fails as this is new
> anyway.
> 
> I get this from the sample module:
> 
>      event-sample-861   [000]    99.584942: foo_bar:              [FAILED TO PARSE] foo=hello bar=3 list=ARRAY[01, 00, 00, 00, 02, 00, 00, 00, 03, 00, 00, 00] str=Frodo cpus=ARRAY[ff, 00, 00, 00, 00, 00, 00, 00] cpum=ARRAY[ff, 00, 00, 00, 00, 00, 00, 00] vstr=iter=3

Niiice. So we can have both real arrays of things like an "__data_loc pid_t[]" and at the same
time have types that happen to need dynamic amount of storage like cpumask_t. So __data_loc can
now be treated almost like a new type qualifier.

The only case I can think of where parsing would not follow regular C abstract declaration syntax is a type like that:

	__data_loc int [3][]

The outer-most array is by definition the dynamic one, so "[]". In normal C, [3] and [] would be swapped as
the outer-most array comes first. That's not too bad though as it is not ambiguous and easy to fixup directly
in the parse tree.

-- Douglas


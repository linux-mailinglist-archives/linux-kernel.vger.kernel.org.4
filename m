Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 274C564AA1D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 23:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233729AbiLLWTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 17:19:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233690AbiLLWTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 17:19:23 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4C418BF79
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 14:19:17 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6894F2F4;
        Mon, 12 Dec 2022 14:19:57 -0800 (PST)
Received: from [192.168.89.251] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B1ECB3F5A1;
        Mon, 12 Dec 2022 14:19:15 -0800 (PST)
Message-ID: <8448372a-6911-e920-b630-15af850adcae@arm.com>
Date:   Mon, 12 Dec 2022 22:19:17 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [for-next][PATCH 02/11] tracing: Add __cpumask to denote a trace
 event field that is a cpumask_t
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Valentin Schneider <vschneid@redhat.com>
References: <20221124145019.782980678@goodmis.org>
 <20221124145045.743308431@goodmis.org>
 <6dda5e1d-9416-b55e-88f3-31d148bc925f@arm.com>
 <20221212111256.3cf68f3e@gandalf.local.home>
Content-Language: en-US
From:   Douglas Raillard <douglas.raillard@arm.com>
In-Reply-To: <20221212111256.3cf68f3e@gandalf.local.home>
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

On 12-12-2022 16:12, Steven Rostedt wrote:
> On Mon, 12 Dec 2022 14:53:27 +0000
> Douglas Raillard <douglas.raillard@arm.com> wrote:
> 
>> On 24-11-2022 14:50, Steven Rostedt wrote:
>>> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
>>>
>>> The trace events have a __bitmask field that can be used for anything
>>> that requires bitmasks. Although currently it is only used for CPU
>>> masks, it could be used in the future for any type of bitmasks.
>>>
>>> There is some user space tooling that wants to know if a field is a CPU
>>> mask and not just some random unsigned long bitmask. Introduce
>>> "__cpumask()" helper functions that work the same as the current
>>> __bitmask() helpers but displays in the format file:
>>>
>>>     field:__data_loc cpumask_t *[] mask;    offset:36;      size:4; signed:0;
> 
> The current parsing tools break the above into:
> 
>   "field:" "__data_loc" <some-type> "[]" <var-name> ";" "offset:"
>   <offset> ";" "size:" "<size>" ";" "signed:" <signed> ";"
> 
> Where the <some-type> really can be anything, and in lots of cases, it is.
> Thus its only a hint for the tooling, and has never been limited to what
> they are.

While we are having a look at that, what is the exact format of "<some-type>" ?
The only way it can truly be any type is if it's an declaration specifier followed by
an abstract declarator, e.g. like in a func prototype where parameters can be anonymous, as
shown by the "parameter_declaration" rule in:
http://www.lysator.liu.se/c/ANSI-C-grammar-y.html#declaration-specifiers

At least that is how I implemented the parsing and it works for sure for all what I saw in traces
plus more.

> 
>>>
>>> Instead of:
>>>
>>>     field:__data_loc unsigned long[] mask;  offset:32;      size:4; signed:0;
>>>
>>> The main difference is the type. Instead of "unsigned long" it is
>>> "cpumask_t *". Note, this type field needs to be a real type in the
>>> __dynamic_array() logic that both __cpumask and__bitmask use, but the
>>> comparison field requires it to be a scalar type whereas cpumask_t is a
>>> structure (non-scalar). But everything works when making it a pointer.
> 
> The above is for the kernel to build.

That was my understanding that the comparison issue is related to in-kernel filtering ?
If that's the case, I completely agree that the type kernel code sees does not _have_
to be the same thing that is exposed to userspace if that simplifies the problem.

>>
>> How is tooling expected to distinguish between a real dynamic array of pointers
>> from a type that is using dynamic arrays as an "implementation detail"
>> with a broken type description ? Any reasonable
>> interpretation of that type by the consuming tool will be broken
>> unless it specifically knows about __data_loc cpumask*[].
> 
> I'm curious to what the tool does differently with the above. What tool are
> you using? Does it just give up on how to print it?

I'm implementing the Rust libtraceevent/libtracecmd prototype. The use case I'm trying
to address in my first draft is:

* a parser for trace.dat exposing a stable API that does not need to be updated every day.
* A serde backend using that parser
* Any "fancy" type (i.e. that is not a basic scalar type or string) is handled by
   the consumer of the deserializer. This means the backend must be able to fallback
   on providing sensible raw data that can be processed by the user.

In a more general way, I'm trying to structure the code so that the generic trace.dat parsing
lib will be able to handle opaque types by returning a sensibly-typed buffer to the caller. The
caller then decodes it the way it wants. This would apply equally well to a C API.

That is especially important for user-defined fancy types, e.g. in a kernel module. We cannot
reasonably expect users to modify the parsing library itself when they could handle the
decoding on their side with an annotation and a custom decoder [1].

Beyond that, any tool that reads the trace and pretty prints it is bound to provide
broken printing for these types: there will be a date T1 where a new fancy type is introduced
in the trace. Until date T2 when the tool gets explicit support for the type, it will
display the thing as an array of pointers. Interpreting a bitmask as an array of pointer makes
no sense for anyone (machine or human). It so happens that unsigned long == ptr size so it
kind of makes sense for cpumask, but an opaque type might internally be u8[], in which case,
printing as void* [] is meaningless. It would likely be better to display a placeholder
or a plain u8[]. The "semantic_type" field property proposal is an improvement of that.


> )
>> However, the set of types using that trick is unbounded so forward
>> compatibilty is impossible to ensure. On top of that, an actual
>> dynamic array of cpumask pointers becomes impossible to represent.
> 
> I never thought about a user case where we print out an array of cpumask
> pointers.

That case (array of pointer) might be a bit far fetched but kernel already contains
weird stuff such as pointers to opaque struct, I suppose as a way of giving a unique
ID to something. The solution we settle on for cpumask should be applicable to any opaque
type present and future so baking such limitations in the foundations of the event system
does not sound like a terribly good idea.

After reflecting on how the caller of the deserializer can process opaque data, I came
to the conclusion that it will have to know the underlying type (unsigned long[]) and
ask for an enum such as:

enum UnsignedLongArray {
	Bit32(Vec<u32>),
	Bit64(Vec<u64>),
}

When asked for UnsignedLongArray, the serde backend will use the ABI info from the trace
to select the appropriate variant.

> 
>>
>> You might object that if the tool does not know about cpumask,
>> it does not matter "how it breaks" as the display will be useless anyway,
>> but that is not true. A parsing library might just parse up to
>> its knowledge limit and return the most elaborate it can for a given field.
>> It's acceptable for that representation to not be elaborated with the full
>> semantic expected by the end user, but it should not return
>> something that is lying on its nature. For example, it would be sane for
>> the user to assert the size of an array of pointers to be a multiple
>> of a pointer size. cpumask is currently an array of unsigned long but there is
>> nothing preventing a similar type to be based on an array of u8.
>> Such a type would also have different endianness handling and the resulting buffer
>> would be garbage.
>>
>>
>> To fix that issue, I propose to expose the following to userspace:
>> 1. The binary representation type (unsigned long[] in cpumask case).
>> 2. An (ordered list of) semantic type that may or may not be the same as 1.
>>
>> Type (1) can be used to guarantee correct handling of endianness and a reasonable
>> default display, while (2) allows any sort of fancy interpretation, all that while preserving
>> forward compatibility. For cpumask, this would give:
>> 1. unsigned long []
>> 2. bitmask, cpumask
>>
>> A consumer could know about bitmask as they are likely used in multiple places,
>> but not about cpumask specifically (e.g. assuming cpumask is a type recently introduced).
>> Displaying as a list of bits set in the mask would already allow proper formatting, and
>> knowing it's actually a cpumask can allow fancier behaviors.
>>
>>   From an event format perspective, this could preserve reasonable backward compat
>> by simply adding another property:
>>
>>     field:__data_loc unsigned long[] mask;    offset:36;      size:4; signed:0; semantic_type:bitmask,cpumask;
>>
>> By default, "semantic_type" would simply have the same value as the normal type.
> 
> The problem with the above is that it adds a new field, and I have to check
> if that doesn't break existing tooling.

Yes, I was hesitating to propose that as well. I think it would be reasonable to allow for this
sort of extension in man trace.dat in the future but maybe that's something for version 8.
In my implementation I parse that to a map anyway, so unknown properties will simply be ignored.

> Another possibility is that I can add parsing to the format that is exposed
> to user space and simply s/__cpumask *[]/__cpumask[]/
> 
> Which will get rid of the pointer array of cpu masks.

My main concern is if the item size info becomes available in the future as a field property,
we won't be able to make dynamic arrays of opaque types if the array notation is
already taken for single items.

So really ideally we want "__data_loc cpumask" and not "__data_loc cpumask[]", as the latter is an
array of cpumasks, and the former a single one. Or maybe something like "__data_loc SINGLE_cpumask[]".
That format would still be parseable by current userspace tools as an opaque type since SINGLE_cpumask
is a valid C identifier.

Beyond extensibility, it would make __data_loc inconsistent:
* for basic types like u32, it's completely expected to be an actual array.
* but for opaque types, it's expected to be a single item and not an array at all.

> 
>>
>> This applies to any type, not just dynamic arrays.
>>
> 
> Let me know if the above does break existing user space and I'll revert it.

I could experiment with trace-cmd but I'm not familiar with everything out there decoding that.
The parser I'm working on is 1.5 week old and unreleased so no change would be an issue as long
as it's possible to distinguish new formats from old ones (to process old traces).


> -- Steve

Douglas


[1] Vague example of how a user application would use serde and the trace parser:

// Serde doc: https://serde.rs/
use serde::Deserialize;

// The yet-to-exist trace parser, pulled from crates.io like any other dependency.
// The user is not expected to modify that ftraceparser code, just the same way you
// are not expected to modify libtraceevent to make use of it in your own application.
use ftraceparser::read_trace;


// Top-level enum that contains a variant for each event of interest.
#[derive(Deserialize)]
enum TraceEvent {
	#[serde(rename = "sched_switch")]
	EventSchedSwitch(EventSchedSwitchFields),

	// This includes a custom event, that is e.g. defined in a kernel module, or
	// maybe it's a brand new event that the userspace tooling does not handle yet.
	// No ftraceparser code has knowledge of that type.
	#[serde(rename = "my_custom_event")]
	MyCustomEvent(MyCustomEventFields),
}

#[derive(Deserialize)]
pub struct EventSchedSwitchFields {
     pub common_comm: Comm,
     pub common_pid: PID,
     pub common_cpu: CPU,
     pub prev_comm: Comm,
     pub next_comm: Comm,
     pub prev_state: u32,
     pub prev_pid: PID,
     pub next_pid: PID,
     pub next_prio: Prio,
     pub prev_prio: Prio,
}

// Custom event struct, with one field containing an opaque fancy type
// that the parser does not know about (e.g. the event is added by a kernel
// module, or a kernel dev has a custom junk patch with quick&dirty debugging aids)
pub struct MyCustomEventFields {
	#[serde(deserialize_with = "decode_fancy")]
	fancy_field: Fancy,
}


// If we use the automatic Deserialize implementation provided by #[derive(Deserialize)],
// it will be under the assumptions that the parser is able to split the trace in Fancy's
// fields (or a sequence if it was a simple wrapper around an array type) so they can be mapped
// on that struct's fields. This is by definition not possible because the parser have no clue about
// the content of Fancy. ftraceparser only knows how to split the fields of MyCustomEventFields because
// of the format in the header. No such format header exists for Fancy.
// We therefore use a custom "decode_fancy()" function where we ask for a byte buffer and decode it manually.
// We could also provide a manual Deserialize implementation to avoid needing "#[serde(deserialize_with=...)]".
struct Fancy {
	...
}

fn decode_fancy<D>(deserializer: D) {
	// Request a buffer of bytes and decode it into a Fancy value. All the trace parser needs to know
	// is how to get the chunk of data we asked, we handle the rest here.
}



fn process(event: TraceEvent) {
	...
}

fn main() {
	...

	// Read the trace, asking for an iterator of TraceEvent values.
	let events = read_trace::<TraceEvent>("path/to/trace.dat");
	for event in events {
		process(event);
	}
}



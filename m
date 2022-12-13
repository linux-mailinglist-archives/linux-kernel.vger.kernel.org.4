Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 257CE64BE3E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 22:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236182AbiLMVOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 16:14:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235112AbiLMVOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 16:14:16 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 799A322291
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 13:14:14 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A92A42F4;
        Tue, 13 Dec 2022 13:14:54 -0800 (PST)
Received: from [192.168.89.251] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 175B13F71E;
        Tue, 13 Dec 2022 13:14:12 -0800 (PST)
Message-ID: <868545e9-cd70-db30-7cde-3390712ff23e@arm.com>
Date:   Tue, 13 Dec 2022 21:14:15 +0000
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
 <48c3eaa4-e896-16c4-af7f-a7e4f0541f01@arm.com>
 <20221213144408.0b78d2c3@gandalf.local.home>
From:   Douglas Raillard <douglas.raillard@arm.com>
In-Reply-To: <20221213144408.0b78d2c3@gandalf.local.home>
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

On 13-12-2022 19:44, Steven Rostedt wrote:
> On Tue, 13 Dec 2022 17:40:06 +0000
> Douglas Raillard <douglas.raillard@arm.com> wrote:
> 
>>> I prefer not to have "quick&dirty" ;-)
>>
>> I'm not saying that I would like to see such quick and dirty events upstream, but the reality around me is
>> that ftrace events is the only sane way of having an idea what the scheduler does. This means people need
>> to create experiments all the time with ad-hoc trace events, on top of the trace events that we attach to
>> tracepoints via a module. Currently, people use trace_printk() for that, which comes with some significant
>> amount of work and pain (mostly regex speed).
> 
> Have you seen custom events?
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/samples/trace_events/trace_custom_sched.h
> 

That's interesting, thanks. I currently define a new regular event along with a tp probe that I attach to the tp of interest.
The probe is then calling trace_mycustom_event(). However:
* Some events are emitted from multiple tracepoints. TRACE_CUSTOM_EVENT() can only attach to one tp, but maybe it's solvable
   with an event class.
* The tracepoint may or may not exist (we deal with all sorts of kernels including Android and our own dev kernel with extra tps).
   I use __find_tracepoint() and tracepoint_probe_register() to handle that.
* The module we have [1] is organized as a set of features that can be enabled dynamically by name as insmod parameter.
   The probe is registered only if the corresponding event feature is enabled. This allows an event feature to have
   side effects that would not be tolerable unless you want that specific event.

However TRACE_CUSTOM_EVENT() sounds great for simpler use cases, especially as (some) maintainers are much happier
with new tracepoints (no stable ABI) than new events (too easy for userspace to consume, ABI and tears when it breaks ensues)

[1] https://github.com/ARM-software/lisa/tree/master/lisa/_assets/kmodules/sched_tp


>>
>> That said having just looked at bprint, I could probably support trace_printk() format strings with simple
>> struct member access (i.e. no __printflags shenanigans etc) as normal events relatively easily. It's even
>> possible to use the fmt string pointer as an "event ID". Still a shame that all the event field format infra
>> basically gets duplicated in a printf format string ...
> 
> It's the easiest thing to do in the kernel. The below is probably too much
> work for people to use. The fact that it's just a string and does not have
> any type information is one of the main reasons I force it not to be in
> mainline (hence the nasty banner when it is added).
> 
>>
>>>    
>>>>
>>>> 	#define SIMPLE_TRACE_EVENT(type, fields) \
>>>> 	struct type fields;	
>>>> 	TRACE_EVENT(type, \
>>>> 		TP_PROTO(struct type *data), \
>>>> 		TP_ARGS(data), \
>>>> 		TP_STRUCT__entry(__field(struct type, data)), \
>>>> 		TP_fast_assign(__entry->data = *data;), \
>>>> 		TP_printk("print in raw mode to display the data"), \
>>>> 	);
>>>> 	#define SIMPLE_TRACE(type, fields) trace_struct_##type(&(struct type)fields)
>>>>
>>>>
>>>> 	SIMPLE_TRACE_EVENT(myevent, {
>>>> 		char name[11];
>>>> 		int foobar;
>>>> 	});
>>>> 	
>>>> 	SIMPLE_TRACE(myevent, {.name = "hello", .foobar = 42});
>>>
>>>    
>>>>
>>>> The format string could be either kernel-generated based on BTF or userspace could be expected
>>>> to make its own use of BTF.
>>>
>>> What's the use case for the above?
>>
>> An equivalent to trace_printk() that exposes its fields in the "normal" way rather than having to parse
>> the format string and a comma-separated list of C expressions. Life is too short to write C interpreters.
>> Parsing BTF is at least a finite amount of work. But I guess it would be easy to handle only "REC->field"
>> expressions.
> 
> But the above isn't that much simpler than writing a trace event.



The user would simply need this:

	SIMPLE_TRACE_EVENT(myevent, {
		char name[11];
		int foobar;
	});

	SIMPLE_TRACE(myevent, {.name = "hello", .foobar = 42});

Instead of currently that:

	TRACE_EVENT(myevent
		TP_PROTO(struct type *name[11], int foobar),
		TP_ARGS(name, foobar),
		TP_STRUCT__entry(
			__field(name[11], name),
			__field(int, foobar),
			),
		TP_fast_assign(
			__entry->name = *name;
			__entry->foobar = *foobar;
		),
		TP_printk("name=%s foobar=%i", __entry->name, __entry->foobar), \
	);

	trace_myevent(...);

We went from 3 lines of declaration to 12. "foobar" is repeated 7 times. While I agree that in the grand
scheme of things it's totally acceptable, people want to make that happen in 1 line, not have to repeat
themselves 7 times and then faff around with the #define CREATE_TRACE_POINTS etc.


> When I use trace_printk(), I seldom use it with tooling. And for the few times I
> have written tools to parse printk, the printk formats are very easily
> parsed, as I control them. Heck, I'd just do colon delimited string.

In the sort of things we do, people will want to put a trace_printk() to log a signal, and then get it as an overlay
on an existing per-task plot in a Jupyter notebook. This needs to take less than 15s (kernel compilation + reboot excluded).
So that means:

* We _always_ use tooling. In that case, tooling calls trace-cmd, parses output and loads it in a pandas dataframe, and from
   there either you do computations on it or you simply plot it (matplotlib, plotly, bokeh, whatever).

* As a result, the format must be machine-parsable in a robust way. The parser is written once and for all, no-one wants
   to have to write a regex to load a throw-away event. If whatever is provided requires customization to work on such a simple
   field-extraction case it's considered broken.

* The current format is ok-ish and works well for a human eye, but for all other purposes it's just a bad version of JSON:
	* untyped, you never know if a value is an integer or a string containing an integer. Any data pipeline
           will need to know that, even in dynamically typed language like Python (see numpy/pandas).

	* unquoted/escaped string. If I have a "comm" field, I'll end up with "comm=mytask foobar=1",
           but also "comm=mytask with spaces foobar=1" and why not "comm=mytask=1 foobar=1". So far, I never encountered
           task names with "=" in the wild but it would break parsing without hope of fixing. Android traces are full of tasks
           with spaces in their names, which makes the regex a lot less obvious and likely quite slower as well.
	
	* It's custom. That alone means (1) there is no off-the-shelve solution and (2) custom solutions will be slower, especially
           in languages like Python. You can find tons of JSON parsers, including ones using SIMD. Trying to match that speed with
	  a pure python implementation is not even remotely feasible, so it would require a C extension module, leading to having
	  to distribute a bunch of prebuilt binaries etc, which is _a lot_ more work than "import json; json.loads(a_line)".

So all that to say that concisely defining a structured event with a schema known by the tooling is _very_ valuable when you get
passed eyeballing a trace. The good news is that trace_printk() does provide a schema with its format string, it's just annoying
that it's a pure duplication of infrastructure wrt to other events that have their fields format reported in another way. Also
it's less powerful but we can live with that for quick experiments.

Maybe it would be feasible to write a function that takes a printk fmt string as input and creates a matching synthetic event. This
way we still get a regular event from userspace PoV, with the ease of definition of a format string in the code.

-- Douglas

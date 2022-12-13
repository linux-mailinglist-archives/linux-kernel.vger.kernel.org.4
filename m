Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 554BE64B825
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 16:11:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235722AbiLMPLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 10:11:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbiLMPLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 10:11:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8245813E36
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 07:11:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 45759B81212
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 15:11:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A280C433F0;
        Tue, 13 Dec 2022 15:11:13 +0000 (UTC)
Date:   Tue, 13 Dec 2022 10:11:11 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Douglas Raillard <douglas.raillard@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Valentin Schneider <vschneid@redhat.com>
Subject: Re: [for-next][PATCH 02/11] tracing: Add __cpumask to denote a
 trace event field that is a cpumask_t
Message-ID: <20221213101111.335ae0e7@gandalf.local.home>
In-Reply-To: <764f8b9a-2111-c260-7f2c-89eb9f0ac7a3@arm.com>
References: <20221124145019.782980678@goodmis.org>
        <20221124145045.743308431@goodmis.org>
        <6dda5e1d-9416-b55e-88f3-31d148bc925f@arm.com>
        <20221212111256.3cf68f3e@gandalf.local.home>
        <8448372a-6911-e920-b630-15af850adcae@arm.com>
        <20221212185330.639bf491@gandalf.local.home>
        <764f8b9a-2111-c260-7f2c-89eb9f0ac7a3@arm.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Dec 2022 14:20:12 +0000
Douglas Raillard <douglas.raillard@arm.com> wrote:


> >>>
> >>> The above is for the kernel to build.  
> >>
> >> That was my understanding that the comparison issue is related to in-kernel filtering ?
> >> If that's the case, I completely agree that the type kernel code sees does not _have_
> >> to be the same thing that is exposed to userspace if that simplifies the problem.  
> > 
> > Yes, and note the patch I sent out to fix this.  
> 
> I did, that's some seriously fast TAT :)

I'm going to pull that one in and start testing, so I can push it out in
this merge window.



> > That third part may be difficult with the above issue I mentioned.
> > 
> > Just do:
> > 
> >   git grep '__field(' | cut -d',' -f1 | cut -d'(' -f2 | sed -e 's/[    ]*//'
> >   | sort -u
> > 
> > to see what's in the kernel.  
> 
> There are lots of types, but as long as the caller knows what to ask for, it shouldn't be an issue.
> Pretty printing the trace is obviously an important aspect and ideally requires the parser to know
> how to format everything.
> 
> But when it comes to other processing in a compiled language, it's not a big burden to let people
> declare the events they require and the expected fields + types so they can get the data into their
> own struct (e.g. as with serde or any equivalent technology).

That's what is done today. The size and offset is how the tools can get to
the data and it knows what to do with it.

I'm not sure how rust can handle this type of opaque type scheme.


> > Note, I put much more effort into the offset, size and sign than the type.
> > But is this only for the arrays that you have these restrictions, or any
> > field type?  
> 
> In terms of borken pretty printing, it's a general issue not limited to dynamic arrays.

Yeah, the pretty printing can easily fail, as it can have anything that the
kernel can do. Including calling functions that are not available to user
space. This is why the fallback is always back to size, offset and sign.

> The only ways pretty printing for an opaque type can possibly work for new types the parser has no
> specific knowledge of are:
> 1. The type is not actually opaque, i.e. it comes with some decoding schema (just like the events have
>     a schema listing their fields + types)
> 2. The type is opaque, but also ships with an executable description of how to print it.
>     E.g. if there was a WASM/eBPF/whatever bytecode printing routine made available to userspace.
> 
> Option (2) is not so appealing as it's both hard to achieve and only allows a fixed set of
> behaviors for a type. Option (1) is a lot easier and allows the behaviors to be defined
> on the user side.
> 
> Wild idea: include the BTF blob in the trace.dat header so no type is opaque anymore. The printing
> issue is not entirely solved this way (e.g. cpumask still needs some plugin to be displayed as a list
> of CPUs), but we could at least print all structs in "raw" mode and enum symbolically.

And how big is that blob?

I'm not against the idea, but I would like it to only hold what is needed.

> 
> That could also allow creating a quick&dirty way of defining a proper event (aka not trace_printk()):


I prefer not to have "quick&dirty" ;-)

> 
> 	#define SIMPLE_TRACE_EVENT(type, fields) \
> 	struct type fields;	
> 	TRACE_EVENT(type, \
> 		TP_PROTO(struct type *data), \
> 		TP_ARGS(data), \
> 		TP_STRUCT__entry(__field(struct type, data)), \
> 		TP_fast_assign(__entry->data = *data;), \
> 		TP_printk("print in raw mode to display the data"), \
> 	);
> 	#define SIMPLE_TRACE(type, fields) trace_struct_##type(&(struct type)fields)
> 
> 
> 	SIMPLE_TRACE_EVENT(myevent, {
> 		char name[11];
> 		int foobar;
> 	});
> 	
> 	SIMPLE_TRACE(myevent, {.name = "hello", .foobar = 42});


> 
> The format string could be either kernel-generated based on BTF or userspace could be expected
> to make its own use of BTF.

What's the use case for the above?

> 

> >>
> >> So really ideally we want "__data_loc cpumask" and not "__data_loc cpumask[]", as the latter is an
> >> array of cpumasks, and the former a single one. Or maybe something like "__data_loc SINGLE_cpumask[]".  
> > 
> > The [] just means that the size is not defined, and that current tools will
> > parse it correctly, even if it does not know what cpumask is.
> > 
> > An array of cpumask_t is redundant, as it really becomes one bigger
> > cpumask_t.  
> 
> It's not. A list of 21 CPU affinity masks in a system with 5 CPUs is definitely not the same thing as one mask
> of size 105. Yes they are isomorphic but so is a task's comm (15 char * 7 bits = 105 bits). We are trying to
> express what the data represent, not merely the amount of info required to encode them.
> 
> Now I'm not saying that we can create such array of cpumasks using dynamic arrays in the current
> state of the kernel macro infrastructure, but it's an implementation detail. That should be able to evolve
> independently of the data model exposed to userspace.
> 
> >   
> >> That format would still be parseable by current userspace tools as an opaque type since SINGLE_cpumask
> >> is a valid C identifier.
> >>
> >> Beyond extensibility, it would make __data_loc inconsistent:
> >> * for basic types like u32, it's completely expected to be an actual array.
> >> * but for opaque types, it's expected to be a single item and not an array at all.
> >>  
> >>>      
> >>>>
> >>>> This applies to any type, not just dynamic arrays.
> >>>>     
> >>>
> >>> Let me know if the above does break existing user space and I'll revert it.  
> >>
> >> I could experiment with trace-cmd but I'm not familiar with everything out there decoding that.
> >> The parser I'm working on is 1.5 week old and unreleased so no change would be an issue as long
> >> as it's possible to distinguish new formats from old ones (to process old traces).
> >>  
> > 
> > [ /me goes and does some testing ...]
> > 
> > Actually, the cpumask[] fails to parse regardless it seems, so I'm free to
> > change this anyway I want and still not cause regressions.
> > 
> > This means I can make it this:
> > 
> >    field:__data_loc cpumask_t mask;    offset:36;      size:4; signed:0;
> > 
> > 
> > and it should not cause any regression, as it already fails as this is new
> > anyway.
> > 
> > I get this from the sample module:
> > 
> >      event-sample-861   [000]    99.584942: foo_bar:              [FAILED TO PARSE] foo=hello bar=3 list=ARRAY[01, 00, 00, 00, 02, 00, 00, 00, 03, 00, 00, 00] str=Frodo cpus=ARRAY[ff, 00, 00, 00, 00, 00, 00, 00] cpum=ARRAY[ff, 00, 00, 00, 00, 00, 00, 00] vstr=iter=3  
> 
> Niiice. So we can have both real arrays of things like an "__data_loc pid_t[]" and at the same
> time have types that happen to need dynamic amount of storage like cpumask_t. So __data_loc can
> now be treated almost like a new type qualifier.
> 
> The only case I can think of where parsing would not follow regular C abstract declaration syntax is a type like that:
> 
> 	__data_loc int [3][]
> 
> The outer-most array is by definition the dynamic one, so "[]". In normal C, [3] and [] would be swapped as
> the outer-most array comes first. That's not too bad though as it is not ambiguous and easy to fixup directly
> in the parse tree.
> 

Well, currently we do not have a way to create the above, so I'm not
worried.

-- Steve

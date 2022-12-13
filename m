Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E755864BD77
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 20:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236648AbiLMToQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 14:44:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235584AbiLMToN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 14:44:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4928E0BB
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 11:44:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 806F46171D
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 19:44:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35099C433EF;
        Tue, 13 Dec 2022 19:44:10 +0000 (UTC)
Date:   Tue, 13 Dec 2022 14:44:08 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Douglas Raillard <douglas.raillard@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Valentin Schneider <vschneid@redhat.com>
Subject: Re: [for-next][PATCH 02/11] tracing: Add __cpumask to denote a
 trace event field that is a cpumask_t
Message-ID: <20221213144408.0b78d2c3@gandalf.local.home>
In-Reply-To: <48c3eaa4-e896-16c4-af7f-a7e4f0541f01@arm.com>
References: <20221124145019.782980678@goodmis.org>
        <20221124145045.743308431@goodmis.org>
        <6dda5e1d-9416-b55e-88f3-31d148bc925f@arm.com>
        <20221212111256.3cf68f3e@gandalf.local.home>
        <8448372a-6911-e920-b630-15af850adcae@arm.com>
        <20221212185330.639bf491@gandalf.local.home>
        <764f8b9a-2111-c260-7f2c-89eb9f0ac7a3@arm.com>
        <20221213101111.335ae0e7@gandalf.local.home>
        <48c3eaa4-e896-16c4-af7f-a7e4f0541f01@arm.com>
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

On Tue, 13 Dec 2022 17:40:06 +0000
Douglas Raillard <douglas.raillard@arm.com> wrote:

> > I prefer not to have "quick&dirty" ;-)  
> 
> I'm not saying that I would like to see such quick and dirty events upstream, but the reality around me is
> that ftrace events is the only sane way of having an idea what the scheduler does. This means people need
> to create experiments all the time with ad-hoc trace events, on top of the trace events that we attach to
> tracepoints via a module. Currently, people use trace_printk() for that, which comes with some significant
> amount of work and pain (mostly regex speed).

Have you seen custom events?

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/samples/trace_events/trace_custom_sched.h


> 
> That said having just looked at bprint, I could probably support trace_printk() format strings with simple
> struct member access (i.e. no __printflags shenanigans etc) as normal events relatively easily. It's even
> possible to use the fmt string pointer as an "event ID". Still a shame that all the event field format infra
> basically gets duplicated in a printf format string ...

It's the easiest thing to do in the kernel. The below is probably too much
work for people to use. The fact that it's just a string and does not have
any type information is one of the main reasons I force it not to be in
mainline (hence the nasty banner when it is added).

> 
> >   
> >>
> >> 	#define SIMPLE_TRACE_EVENT(type, fields) \
> >> 	struct type fields;	
> >> 	TRACE_EVENT(type, \
> >> 		TP_PROTO(struct type *data), \
> >> 		TP_ARGS(data), \
> >> 		TP_STRUCT__entry(__field(struct type, data)), \
> >> 		TP_fast_assign(__entry->data = *data;), \
> >> 		TP_printk("print in raw mode to display the data"), \
> >> 	);
> >> 	#define SIMPLE_TRACE(type, fields) trace_struct_##type(&(struct type)fields)
> >>
> >>
> >> 	SIMPLE_TRACE_EVENT(myevent, {
> >> 		char name[11];
> >> 		int foobar;
> >> 	});
> >> 	
> >> 	SIMPLE_TRACE(myevent, {.name = "hello", .foobar = 42});  
> > 
> >   
> >>
> >> The format string could be either kernel-generated based on BTF or userspace could be expected
> >> to make its own use of BTF.  
> > 
> > What's the use case for the above?  
> 
> An equivalent to trace_printk() that exposes its fields in the "normal" way rather than having to parse
> the format string and a comma-separated list of C expressions. Life is too short to write C interpreters.
> Parsing BTF is at least a finite amount of work. But I guess it would be easy to handle only "REC->field"
> expressions.

But the above isn't that much simpler than writing a trace event. When I
use trace_printk(), I seldom use it with tooling. And for the few times I
have written tools to parse printk, the printk formats are very easily
parsed, as I control them. Heck, I'd just do colon delimited string.

-- Steve


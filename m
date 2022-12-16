Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 127BA64F379
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 22:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiLPVtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 16:49:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbiLPVtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 16:49:08 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353C0A44C;
        Fri, 16 Dec 2022 13:49:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 531D9CE1F19;
        Fri, 16 Dec 2022 21:49:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82FBBC433EF;
        Fri, 16 Dec 2022 21:49:02 +0000 (UTC)
Date:   Fri, 16 Dec 2022 16:49:00 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ross Zwisler <zwisler@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH] tracing: Add a way to filter function addresses to
 function names
Message-ID: <20221216164900.2563a5d4@gandalf.local.home>
In-Reply-To: <Y5zlaWEVdBSJhQR/@google.com>
References: <20221214125209.09d736dd@gandalf.local.home>
        <Y5zlaWEVdBSJhQR/@google.com>
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

On Fri, 16 Dec 2022 14:38:49 -0700
Ross Zwisler <zwisler@google.com> wrote:

> On Wed, Dec 14, 2022 at 12:52:09PM -0500, Steven Rostedt wrote:
> > From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> > 
> > There's been several times where an event records a function address in
> > its field and I needed to filter on that address for a specific function
> > name. It required looking up the function in kallsyms, finding its size,
> > and doing a compare of "field >= function_start && field < function_end".  
> 
> This is amazingly useful!

Thanks!

> 
> > But this would change from boot to boot and is unreliable in scripts.
> > Also, it is useful to have this at boot up, where the addresses will not
> > be known. For example, on the boot command line:
> > 
> >   trace_trigger="initcall_finish.traceoff if initcall_finish.function == acpi_init"  
> 
> I think this should actually be:
> 
>   trace_trigger="initcall_finish.traceoff if func.function == acpi_init"
>                                              ^^^^
> 
> right?  'func' is the function pointer in the format:

Oops. Yes.

> 
>   [ /sys/kernel/debug/tracing/events/initcall/initcall_finish ]
>   # cat format
>   name: initcall_finish
>   ID: 20
>   format:
>           field:unsigned short common_type;	offset:0;	size:2;	signed:0;
>           field:unsigned char common_flags;	offset:2;	size:1;	signed:0;
>           field:unsigned char common_preempt_count;	offset:3;	size:1;	signed:0;
>           field:int common_pid;	offset:4;	size:4;	signed:1;
> 
>           field:initcall_t func;	offset:8;	size:8;	signed:0;
>           field:int ret;	offset:16;	size:4;	signed:1;
> 
>   print fmt: "func=%pS ret=%d", REC->func, REC->ret
> 
> > To implement this, add a ".function" prefix, that will check that the
> > field is of size long, and the only operations allowed (so far) are "=="
> > and "!=".
> > 
> > Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> > ---  
> 
> <>
> 
> > @@ -1393,6 +1414,12 @@ static int parse_pred(const char *str, void *data,
> >  		i += len;
> >  	}
> >  
> > +	/* See if the field is a user space string */  
> 
> Is this comment correct, or was it just copied from the .ustring handling
> above?  We aren't doing any string sanitization (strncpy_from_kernel_nofault()
> and friends) AFAICT, just doing a kernel symbol lookup.

Oops again ;)

> 
> Maybe:
> 
>   /* See if this is a kernel function name */

Sure.

> 
> ?
> 
> > +	if ((len = str_has_prefix(str + i, ".function"))) {
> > +		function = true;
> > +		i += len;
> > +	}
> > +
> >  	while (isspace(str[i]))
> >  		i++;
> >  
> > @@ -1423,7 +1450,57 @@ static int parse_pred(const char *str, void *data,
> >  	pred->offset = field->offset;
> >  	pred->op = op;
> >  
> > -	if (ftrace_event_is_function(call)) {
> > +	if (function) {
> > +		/* The field must be the same size as long */
> > +		if (field->size != sizeof(long)) {
> > +			parse_error(pe, FILT_ERR_ILLEGAL_FIELD_OP, pos + i);
> > +			goto err_free;
> > +		}
> > +
> > +		/* Function only works with '==' or '!=' and an unquoted string */
> > +		switch (op) {
> > +		case OP_NE:
> > +		case OP_EQ:
> > +			break;
> > +		default:
> > +			parse_error(pe, FILT_ERR_INVALID_OP, pos + i);
> > +			goto err_free;
> > +		}
> > +
> > +		if (isdigit(str[i])) {
> > +			ret = kstrtol(num_buf, 0, &ip);
> > +			if (ret) {
> > +				parse_error(pe, FILT_ERR_INVALID_VALUE, pos + i);
> > +				goto err_free;
> > +			}  
> 
> Maybe I'm holding it by the wrong end, but can we actually use this to filter
> based on an address?  Hex doesn't work (as you'd expect from looking at
> kstrol()), but decimal doesn't work for me either:
> 
>   [ /sys/kernel/debug/tracing/events/kmem/kmalloc ]
>   # echo "traceoff:1 if call_site.function == 0xffffffff96ca4240" > trigger
> 
>   [ /sys/kernel/debug/tracing/events/kmem/kmalloc ]
>   # echo "traceoff:1 if call_site.function == 18446744071944421952" > trigger
>   bash: echo: write error: Invalid argument

Thanks for letting me know. I didn't test this and it should work. I'll
look into it.

> 
> Should this interface insist that users use function names that we can look
> up?

It may pick the wrong function if there are more than one function with the
same name. Passing by address will guarantee it will be the right function.

Thanks for the review!

-- Steve

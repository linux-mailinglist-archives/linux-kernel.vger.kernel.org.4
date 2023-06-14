Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB4FB73004B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 15:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245061AbjFNNn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 09:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245057AbjFNNn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 09:43:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D7D1FEB;
        Wed, 14 Jun 2023 06:43:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 808A063FCE;
        Wed, 14 Jun 2023 13:43:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66290C433C0;
        Wed, 14 Jun 2023 13:43:55 +0000 (UTC)
Date:   Wed, 14 Jun 2023 09:43:53 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] tracing: Add a debug_trace_printk() function
Message-ID: <20230614094353.2cf1bae5@gandalf.local.home>
In-Reply-To: <e2f3ce97329d488d8ecd4fea5fbdb4f6@AcuMS.aculab.com>
References: <20230612193337.0fb0d3ca@gandalf.local.home>
        <e2f3ce97329d488d8ecd4fea5fbdb4f6@AcuMS.aculab.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jun 2023 09:57:33 +0000
David Laight <David.Laight@ACULAB.COM> wrote:

> From: Steven Rostedt
> > Sent: 13 June 2023 00:34
> > 
> > From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> > 
> > While doing some tracing and kernel debugging, I found that some of my
> > trace_printk()s were being lost in the noise of the other code that was
> > being traced. Having a way to write trace_printk() not in the top level
> > trace buffer would have been useful.
> > 
> > There was also a time I needed to debug ftrace itself, where
> > trace_printk() did not hit the paths that were being debugged. But because
> > the trace that was being debugged, was going into the top level ring
> > buffer, it was causing issues for seeing what is to be traced.
> > 
> > To solve both of the above, add a debug_trace_printk() that can be used
> > just like trace_printk() except that it goes into a "debug" instance
> > buffer instead. This can be used at boot up as well.  
> ...
> > +#ifdef CONFIG_FTRACE_DEBUG_PRINT
> > +	debug_trace = trace_array_get_by_name("debug");
> > +	if (WARN_ON(!debug_trace))
> > +		return;
> > +	trace_array_init_printk(debug_trace);
> > +#endif  
> 
> I was wondering if that could be done whenever the "debug"
> trace_array is created?
> (perhaps only if trace_prink() has been used?)
> Since (AFAICT) it could be created at any time??
> 
> So you wouldn't really need an extra kernel knob?
> (Except to get the boot time trace diverted.)
> The trace could go to the global buffer if the debug one
> isn't created.

I'd rather not touch trace_printk(), that would just confuse people more.

Anyway, I'm not going to apply this. I have other ideas on how to
accomplish this. But for now, I wanted it in my patchwork to remind me to
do those other methods. In the mean time, I can just apply this patch
when I need to.

> 
> OTOH I'm missing what trace_array_init_prink() does?
> It seems to just call alloc_percpu_trace_buffer() with
> no arguments.
> 
> It looks like alloc_percpu_trace_buffer() is called if there
> are any trace_printk() formats in the main kernel.
> Hopefully they aren't just in modules??

No, they are allocated if a module uses them too. Try it out. Load a module
with trace_printk() and you'll see that banner print out.

-- Steve

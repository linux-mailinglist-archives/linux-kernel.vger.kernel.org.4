Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A28D372CB9F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 18:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237045AbjFLQeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 12:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbjFLQeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 12:34:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9797E195
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 09:34:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3498D62B96
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 16:34:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D3F4C433D2;
        Mon, 12 Jun 2023 16:34:09 +0000 (UTC)
Date:   Mon, 12 Jun 2023 12:34:07 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: fix memcpy size when copying stack entries
Message-ID: <20230612123407.5ebcabdf@gandalf.local.home>
In-Reply-To: <20230612160748.4082850-1-svens@linux.ibm.com>
References: <20230612160748.4082850-1-svens@linux.ibm.com>
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

On Mon, 12 Jun 2023 18:07:48 +0200
Sven Schnelle <svens@linux.ibm.com> wrote:

> Noticed the following warning during boot:
> 
> [    2.316341] Testing tracer wakeup:
> [    2.383512] ------------[ cut here ]------------
> [    2.383517] memcpy: detected field-spanning write (size 104) of single field "&entry->caller" at kernel/trace/trace.c:3167 (size 64)
> 
> The reason seems to be that the maximum number of entries is calculated
> from the size of the fstack->calls array which is 128. But later the same
> size is used to memcpy() the entries to entry->callers, which has only
> room for eight elements. Therefore use the minimum of both arrays as limit.
> 
> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
> ---
>  kernel/trace/trace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 64a4dde073ef..988d664c13ec 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -3146,7 +3146,7 @@ static void __ftrace_trace_stack(struct trace_buffer *buffer,
>  	barrier();
>  
>  	fstack = this_cpu_ptr(ftrace_stacks.stacks) + stackidx;
> -	size = ARRAY_SIZE(fstack->calls);
> +	size = min(ARRAY_SIZE(entry->caller), ARRAY_SIZE(fstack->calls));

No, this is not how it works, and this breaks the stack tracing code.

>  
>  	if (regs) {
>  		nr_entries = stack_trace_save_regs(regs, fstack->calls,

I guess we need to add some type of annotation to make the memcpy()
checking happy.

Let me explain what is happening. By default the stack trace has a minimum
of 8 entries (defined by struct stack_entry, which is used to show to user
space the default size - for backward compatibility).

Let's take a look at the code in more detail:

/* What is the size of the temp buffer to use to find the stack? */
	size = ARRAY_SIZE(fstack->calls);

	if (regs) {
/* Fills in the stack into the temp buffer */
		nr_entries = stack_trace_save_regs(regs, fstack->calls,
						   size, skip);
	} else {
/* Also fills in the stack into the temp buffer */
		nr_entries = stack_trace_save(fstack->calls, size, skip);
	}

/* Calculate the size from the number of entries stored in the temp buffer */

	size = nr_entries * sizeof(unsigned long);

/* Now reserve space on the ring buffer */
	event = __trace_buffer_lock_reserve(buffer, TRACE_STACK,

/*
 * Notice how it calculates the size! It subtracts the sizeof
 *  entry->caller and then adds size again!
 */
				    (sizeof(*entry) - sizeof(entry->caller)) + size,
				    trace_ctx);
	if (!event)
		goto out;

/* Point entry to the ring buffer data */
	entry = ring_buffer_event_data(event);

/* Now copy the stack to the location for the data on the ftrace ring buffer */
	memcpy(&entry->caller, fstack->calls, size);
	entry->size = nr_entries;

The old way use to just record the 8 entries, but that was not very useful
in real world analysis. Your patch takes that away. Might as well just
record directly into the ring buffer again like it use to.

Yes the above may be special, but your patch breaks it.

NAK on the patch, but I'm willing to update this to make your tooling
handle this special case.

-- Steve

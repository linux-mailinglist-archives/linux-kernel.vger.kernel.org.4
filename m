Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4035750AF0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 16:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232463AbjGLO11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 10:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232432AbjGLO1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 10:27:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ABF92114
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 07:26:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD95B617FB
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 14:26:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBE51C433C7;
        Wed, 12 Jul 2023 14:26:22 +0000 (UTC)
Date:   Wed, 12 Jul 2023 10:26:21 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: fix memcpy size when copying stack entries
Message-ID: <20230712102621.4c588de9@gandalf.local.home>
In-Reply-To: <20230712101434.4613b3ec@gandalf.local.home>
References: <20230612160748.4082850-1-svens@linux.ibm.com>
        <20230612123407.5ebcabdf@gandalf.local.home>
        <yt9dy1koey7h.fsf@linux.ibm.com>
        <20230613113737.1e07c892@gandalf.local.home>
        <yt9dttva8gxt.fsf@linux.ibm.com>
        <yt9dilap442k.fsf@linux.ibm.com>
        <20230712101434.4613b3ec@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jul 2023 10:14:34 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 12 Jul 2023 16:06:27 +0200
> Sven Schnelle <svens@linux.ibm.com> wrote:
> 
> > > No, still getting the same warning:
> > >
> > > [    2.302776] memcpy: detected field-spanning write (size 104) of single field "stack" at kernel/trace/trace.c:3178 (size 64)    
> > 
> > BTW, i'm seeing the same error on x86 with current master when
> > CONFIG_FORTIFY_SOURCE=y and CONFIG_SCHED_TRACER=y:  
> 
> As I don't know how the fortifier works, nor what exactly it is checking,
> do you have any idea on how to quiet it?
> 
> This is a false positive, as I described before.


Hmm, maybe this would work?

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 4529e264cb86..20122eeccf97 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3118,6 +3118,7 @@ static void __ftrace_trace_stack(struct trace_buffer *buffer,
 	struct ftrace_stack *fstack;
 	struct stack_entry *entry;
 	int stackidx;
+	void *ptr;
 
 	/*
 	 * Add one, for this function and the call to save_stack_trace()
@@ -3161,9 +3162,25 @@ static void __ftrace_trace_stack(struct trace_buffer *buffer,
 				    trace_ctx);
 	if (!event)
 		goto out;
-	entry = ring_buffer_event_data(event);
+	ptr = ring_buffer_event_data(event);
+	entry = ptr;
+
+	/*
+	 * For backward compatibility reasons, the entry->caller is an
+	 * array of 8 slots to store the stack. This is also exported
+	 * to user space. The amount allocated on the ring buffer actually
+	 * holds enough for the stack specified by nr_entries. This will
+	 * go into the location of entry->caller. Due to string fortifiers
+	 * checking the size of the destination of memcpy() it triggers
+	 * when it detects that size is greater than 8. To hide this from
+	 * the fortifiers, we use "ptr" and pointer arithmetic to assign caller.
+	 *
+	 * The below is really just:
+	 *   memcpy(&entry->caller, fstack->calls, size);
+	 */
+	ptr += offsetof(typeof(*entry), caller);
+	memcpy(ptr, fstack->calls, size);
 
-	memcpy(&entry->caller, fstack->calls, size);
 	entry->size = nr_entries;
 
 	if (!call_filter_check_discard(call, entry, buffer, event))


-- Steve

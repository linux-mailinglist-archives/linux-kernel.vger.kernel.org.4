Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1696972E781
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 17:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242626AbjFMPiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 11:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240124AbjFMPiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 11:38:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6AAF19BC
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 08:37:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 81AE962E83
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 15:37:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C23CC433D9;
        Tue, 13 Jun 2023 15:37:38 +0000 (UTC)
Date:   Tue, 13 Jun 2023 11:37:37 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: fix memcpy size when copying stack entries
Message-ID: <20230613113737.1e07c892@gandalf.local.home>
In-Reply-To: <yt9dy1koey7h.fsf@linux.ibm.com>
References: <20230612160748.4082850-1-svens@linux.ibm.com>
        <20230612123407.5ebcabdf@gandalf.local.home>
        <yt9dy1koey7h.fsf@linux.ibm.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
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

On Tue, 13 Jun 2023 07:19:14 +0200
Sven Schnelle <svens@linux.ibm.com> wrote:

> > Yes the above may be special, but your patch breaks it.  
> 
> Indeed, i'm feeling a bit stupid for sending that patch, should have
> used my brain during reading the source. Thanks for the explanation.

Does this quiet the fortifier?

-- Steve

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 64a4dde073ef..1bac7df1f4b6 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3118,6 +3118,7 @@ static void __ftrace_trace_stack(struct trace_buffer *buffer,
 	struct ftrace_stack *fstack;
 	struct stack_entry *entry;
 	int stackidx;
+	void *stack;
 
 	/*
 	 * Add one, for this function and the call to save_stack_trace()
@@ -3163,7 +3164,18 @@ static void __ftrace_trace_stack(struct trace_buffer *buffer,
 		goto out;
 	entry = ring_buffer_event_data(event);
 
-	memcpy(&entry->caller, fstack->calls, size);
+	/*
+	 * For backward compatibility reasons, the entry->caller is an
+	 * array of 8 slots to store the stack. This is also exported
+	 * to user space. The amount allocated on the ring buffer actually
+	 * holds enough for the stack specified by nr_entries. This will
+	 * go into the location of entry->caller. Due to string fortifiers
+	 * checking the size of the destination of memcpy() it triggers
+	 * when it detects that size is greater than 8. To hide this from
+	 * the fortifiers, use a different pointer "stack".
+	 */
+	stack = (void *)&entry->caller;
+	memcpy(stack, fstack->calls, size);
 	entry->size = nr_entries;
 
 	if (!call_filter_check_discard(call, entry, buffer, event))

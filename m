Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E99D45F6B24
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 18:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbiJFQDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 12:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbiJFQDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 12:03:12 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64FECABD47;
        Thu,  6 Oct 2022 09:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zm6xeXW0jCLbsA/duPDusxJlDbKzTuDSlIfxsNlzugc=; b=EOo9MOrsq5fgau58Ph4wmN1PWq
        EknZ/8ivg7z3KXTpTrUHcnXW1aesXrgbIaX/FdJ/lwZ09KgrTtclp0/94wy0cAgW4kweUSnA1KnW8
        Rt+iVdFAvqrmOvytcaJlHMZZxx0E0ZE3XpVniOakbvavlXnGtDbH/zk9YXb4SnGEcjm8T336dMX/1
        h0sOmbnodCnBN4Uqq3h2d3+R5UA+/Aqxip+uLPzNO5FseocDzSAUKAnnQKQkqP24xevppN6NSL01b
        OYNjabvOxm+jsjaJp4FUfzCDlPG+XXHGNvTQcSQMrcbTF2P3rrVXb8YL7ZyUsIH9KB5hTbTaQvLvI
        5bFwx8cw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ogTKs-001GSf-9e; Thu, 06 Oct 2022 16:02:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 47397300137;
        Thu,  6 Oct 2022 18:02:57 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0995220ACE696; Thu,  6 Oct 2022 18:02:57 +0200 (CEST)
Date:   Thu, 6 Oct 2022 18:02:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH] perf: Fix missing SIGTRAPs
Message-ID: <Yz78MMMJ74tBw0gu@hirez.programming.kicks-ass.net>
References: <20220927121322.1236730-1-elver@google.com>
 <Yz7ZLaT4jW3Y9EYS@hirez.programming.kicks-ass.net>
 <Yz7fWw8duIOezSW1@elver.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yz7fWw8duIOezSW1@elver.google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2022 at 03:59:55PM +0200, Marco Elver wrote:

> That one I could fix up with:
> 
>  | diff --git a/kernel/events/core.c b/kernel/events/core.c
>  | index 9319af6013f1..2f1d51b50be7 100644
>  | --- a/kernel/events/core.c
>  | +++ b/kernel/events/core.c
>  | @@ -6563,6 +6563,7 @@ static void perf_pending_task(struct callback_head *head)
>  |  	 * If we 'fail' here, that's OK, it means recursion is already disabled
>  |  	 * and we won't recurse 'further'.
>  |  	 */
>  | +	preempt_disable_notrace();
>  |  	rctx = perf_swevent_get_recursion_context();
>  |  
>  |  	if (event->pending_work) {
>  | @@ -6573,6 +6574,7 @@ static void perf_pending_task(struct callback_head *head)
>  |  
>  |  	if (rctx >= 0)
>  |  		perf_swevent_put_recursion_context(rctx);
>  | +	preempt_enable_notrace();
>  |  }
>  |  
>  |  #ifdef CONFIG_GUEST_PERF_EVENTS

Right, thanks! It appears I only have lockdep enabled but not the
preempt warning :/

> But following that, I get:
> 

>  | WARNING: CPU: 3 PID: 13018 at kernel/events/core.c:2288 event_sched_out+0x3f2/0x410 kernel/events/core.c:2288

I'm taking this is (my line numbers are slightly different):

	WARN_ON_ONCE(event->pending_work);



> So something isn't quite right yet. Unfortunately I don't have a good
> reproducer. :-/

This can happen if we get two consecutive event_sched_out() and both
instances will have pending_sigtrap set. This can happen when the event
that has sigtrap set also triggers in kernel space.

You then get task_work list corruption and *boom*.

I'm thinking the below might be the simplest solution; we can only send
a single signal after all.


--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2293,9 +2293,10 @@ event_sched_out(struct perf_event *event
 			 */
 			local_dec(&event->ctx->nr_pending);
 		} else {
-			WARN_ON_ONCE(event->pending_work);
-			event->pending_work = 1;
-			task_work_add(current, &event->pending_task, TWA_RESUME);
+			if (!event->pending_work) {
+				event->pending_work = 1;
+				task_work_add(current, &event->pending_task, TWA_RESUME);
+			}
 		}
 	}
 

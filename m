Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EEA75F765F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 11:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiJGJhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 05:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiJGJhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 05:37:47 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9192BE01
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 02:37:44 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id u21so6225219edi.9
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 02:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LH9uOMgE/N45WO2wenwuwG6vNOy7NLHsypVs9cw/6bM=;
        b=lsFbyXl33hkfxl40Mg0YTzeWJ5VYdqe4UOTCor+QWvEcgkHHWPhAotJnJhrz4fPfAJ
         f4qJs86NHVqMzL1K5oVyWxMKgxEx39cVqik6laTm+MhmTNPVhwQvdLIwOWrSbUBXBgkO
         cb4grWQwTrHt46XTJrZp7euH1UskYnC4zLAfYJyNROllolyrd6rQklNEAmXG07MXBAbS
         v1rdXvXXlon7DzRAcTOSV8US81L83h5cOtwDrbs3pzeyVKwa148+92MR8cHZ+icsqrdb
         1wLo7/8jY1VCFVuBz1wrz7VrkoPy20r4rnR2DThv+weq/cKax8JUphjfhpt/mGh55+NO
         zz1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LH9uOMgE/N45WO2wenwuwG6vNOy7NLHsypVs9cw/6bM=;
        b=OKphDvfpCLm20LH60S+hxjY+fNshPI7KyKnfruA487MeVNCbEC8nOFiYUtoJjoaFEc
         QdhXWN7RbLBzWvue7y1NFo+JRJUBptZWc8XsveHznKW8xQZQWCUgjQeQMuwAqEMTOHfx
         nf6eiGVJJGqlYEAGfM4J2C/7B6O6NDf5ThPm7oxQK/RuFPkcW6I9Goq7yBXrYPNYFIBF
         B9DJ4xu5DFsUyGr3fTB0QB39GaezVe68ailwciPRD5+yzVxR9+iAbLzX3d3pZW7EO+LG
         FaHLAxvA8DT9d+JnTfQkKwqZoIObO42keiY2xz1teYV0SbCw3xKebg5YLOWOiylx5I10
         Zehw==
X-Gm-Message-State: ACrzQf2ngKETH9rJ+yqfl4x9INB9WC3ghc8XOz2QwK+tu7ywxpO+OvP2
        qyQg6w+QrtrQrhN2sb1MSCPsWw==
X-Google-Smtp-Source: AMsMyM6+dwbvfGWcg4xNUwrGVeGOH7x6P6KRvyjRkF0GzrQdIGVWE2cvEKgzrLe0vhZ3DM2O8rGnoQ==
X-Received: by 2002:a05:6402:42c7:b0:45a:2d91:741f with SMTP id i7-20020a05640242c700b0045a2d91741fmr1000007edc.39.1665135462718;
        Fri, 07 Oct 2022 02:37:42 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:9c:201:4e4:454c:b135:33f2])
        by smtp.gmail.com with ESMTPSA id o29-20020a509b1d000000b00459c5c2138csm1123758edi.32.2022.10.07.02.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 02:37:41 -0700 (PDT)
Date:   Fri, 7 Oct 2022 11:37:34 +0200
From:   Marco Elver <elver@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH] perf: Fix missing SIGTRAPs
Message-ID: <Yz/zXpF1yLshrJm/@elver.google.com>
References: <20220927121322.1236730-1-elver@google.com>
 <Yz7ZLaT4jW3Y9EYS@hirez.programming.kicks-ass.net>
 <Yz7fWw8duIOezSW1@elver.google.com>
 <Yz78MMMJ74tBw0gu@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yz78MMMJ74tBw0gu@hirez.programming.kicks-ass.net>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2022 at 06:02PM +0200, Peter Zijlstra wrote:

> This can happen if we get two consecutive event_sched_out() and both
> instances will have pending_sigtrap set. This can happen when the event
> that has sigtrap set also triggers in kernel space.
> 
> You then get task_work list corruption and *boom*.
> 
> I'm thinking the below might be the simplest solution; we can only send
> a single signal after all.

That worked. In addition I had to disable the ctx->task != current check
if we're in task_work, because presumably the event might have already
been disabled/moved??

At least with all the below fixups, things seem to work (tests +
light fuzzing).

Thanks,
-- Marco

------ >8 ------

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 9319af6013f1..29ed6e58906b 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2285,9 +2285,10 @@ event_sched_out(struct perf_event *event,
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
 
@@ -6455,18 +6456,19 @@ void perf_event_wakeup(struct perf_event *event)
 	}
 }
 
-static void perf_sigtrap(struct perf_event *event)
+static void perf_sigtrap(struct perf_event *event, bool in_task_work)
 {
 	/*
 	 * We'd expect this to only occur if the irq_work is delayed and either
 	 * ctx->task or current has changed in the meantime. This can be the
 	 * case on architectures that do not implement arch_irq_work_raise().
 	 */
-	if (WARN_ON_ONCE(event->ctx->task != current))
+	if (WARN_ON_ONCE(!in_task_work && event->ctx->task != current))
 		return;
 
 	/*
-	 * perf_pending_irq() can race with the task exiting.
+	 * Both perf_pending_task() and perf_pending_irq() can race with the
+	 * task exiting.
 	 */
 	if (current->flags & PF_EXITING)
 		return;
@@ -6496,7 +6498,7 @@ static void __perf_pending_irq(struct perf_event *event)
 		if (event->pending_sigtrap) {
 			event->pending_sigtrap = 0;
 			local_dec(&event->ctx->nr_pending);
-			perf_sigtrap(event);
+			perf_sigtrap(event, false);
 		}
 		if (event->pending_disable) {
 			event->pending_disable = 0;
@@ -6563,16 +6565,18 @@ static void perf_pending_task(struct callback_head *head)
 	 * If we 'fail' here, that's OK, it means recursion is already disabled
 	 * and we won't recurse 'further'.
 	 */
+	preempt_disable_notrace();
 	rctx = perf_swevent_get_recursion_context();
 
 	if (event->pending_work) {
 		event->pending_work = 0;
 		local_dec(&event->ctx->nr_pending);
-		perf_sigtrap(event);
+		perf_sigtrap(event, true);
 	}
 
 	if (rctx >= 0)
 		perf_swevent_put_recursion_context(rctx);
+	preempt_enable_notrace();
 }
 
 #ifdef CONFIG_GUEST_PERF_EVENTS

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5769636750
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 18:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239107AbiKWRen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 12:34:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238855AbiKWRek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 12:34:40 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF8F86A6B
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 09:34:39 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id z4so15898871wrr.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 09:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RbL6CVFUsGZnQegHCOffwveCKnK0tV1d+Cc144fypdM=;
        b=QLw8eHQX2ZscrPI4SI9ePUOTKeF/r90vkgfYGCOn6gWfuMHkWWCJYmwvoJGAQaBYSK
         3t/HlG1oKDTlbfGHRhGw01w9tjNkY334WqM1nRv9Bg/FiZq2WdB3C0/bjSmcEOCT3NAh
         eXn5x/Sd0v5101QApW8fwrMaXjsEBK+vBkBBtj3SI/bR8slXVz7Ao/PxEF3Qo/56QQ1Z
         Qzs02Tl1cQlUHocuRd8uZr/IqpSKYmw/fZM947TS1V9hJEBqLPNkiuBsWNANNdHrmA2K
         bXATLx4OVYuPF8XZVdYATGyt3T3P/ze2wvw0ZoA1o4QHVjomepbP+GfnTCOzTfmFjWpI
         e3Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RbL6CVFUsGZnQegHCOffwveCKnK0tV1d+Cc144fypdM=;
        b=juetVpNfGkK5qbxXge7ExvQVH9UFIzxR/GTGauk04XvlpHjlEbengUeg4pYUQAdeUr
         HC8mQ6qKo5n/+5RwOlD7rwM36R2WcyDCcgCwG8kBSfcAql1eWPMkZGoLReeKiKKlOG1K
         CfYqpi65AvlEoxTzxMlKFQVvK0VrTNAp/CEPU3MMOOVRSpI/Pm0zhS8YY5OLq9FU0Bah
         kH+DR3oKrIqibFnS7Rk5booptYClH2EMaUqdtCmyA/bVYbv7da+MxHgTaPMUf9ynGD8e
         CTXUN0bt1Hgm8wiPIDuwtPyPf7qlOPTAFXkFAnOnx5TZzRgbfdfRYn4ttJ644E/mSQTa
         Y+SA==
X-Gm-Message-State: ANoB5ploVtO3pOERA0sexsu85pSfMaqJM7YnQb8gPmHEHWcsSrlHBgld
        ERE7zL09bzSVsZ1/c2xNmaytEQ==
X-Google-Smtp-Source: AA0mqf6tHp30GxqwijbILxJgbUDlb553zr4zOAwEO3QoJnyfHJBVCf3M+irmZP0oW4KrCDdPxGTBVw==
X-Received: by 2002:a5d:604b:0:b0:236:6442:3a48 with SMTP id j11-20020a5d604b000000b0023664423a48mr8304029wrt.41.1669224877339;
        Wed, 23 Nov 2022 09:34:37 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:9c:201:5fb5:228c:93d7:c5d8])
        by smtp.gmail.com with ESMTPSA id v14-20020adfe28e000000b0022e36c1113fsm2263330wri.13.2022.11.23.09.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 09:34:36 -0800 (PST)
Date:   Wed, 23 Nov 2022 18:34:30 +0100
From:   Marco Elver <elver@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+9228d6098455bb209ec8@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] KASAN: use-after-free Read in task_work_run (2)
Message-ID: <Y35Zpi8WxOW3GqCO@elver.google.com>
References: <000000000000e7513905ebf4346f@google.com>
 <20221027030304.3017-1-hdanton@sina.com>
 <CANpmjNM-FNsMn4FR2murHHKt6jsVUDCO=ETmNQe-f+jrQ+4nHg@mail.gmail.com>
 <Y340Y2iwy3YubOk1@elver.google.com>
 <Y35J4383T5rAjSjO@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y35J4383T5rAjSjO@hirez.programming.kicks-ass.net>
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

On Wed, Nov 23, 2022 at 05:27PM +0100, Peter Zijlstra wrote:
[...]
> So perhaps both the above..
> 
> Does that actually work?

It does seem to work, thanks.

Tested-by: Marco Elver <elver@google.com>

Patches didn't apply cleanly somehow, so I reconstructed it -- this is
what I tested on top of v6.1-rc6:

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 5ddc88592ff8..ca6f1158ff58 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2291,6 +2291,7 @@ event_sched_out(struct perf_event *event,
 		    !event->pending_work) {
 			event->pending_work = 1;
 			dec = false;
+			WARN_ON_ONCE(!atomic_long_inc_not_zero(&event->refcount));
 			task_work_add(current, &event->pending_task, TWA_RESUME);
 		}
 		if (dec)
@@ -2336,6 +2337,7 @@ group_sched_out(struct perf_event *group_event,
 
 #define DETACH_GROUP	0x01UL
 #define DETACH_CHILD	0x02UL
+#define DETACH_DEAD	0x04UL
 
 /*
  * Cross CPU call to remove a performance event
@@ -2356,12 +2358,20 @@ __perf_remove_from_context(struct perf_event *event,
 		update_cgrp_time_from_cpuctx(cpuctx, false);
 	}
 
+	/*
+	 * Ensure event_sched_out() switches to OFF, at the very least
+	 * this avoids raising perf_pending_task() at this time.
+	 */
+	if (flags & DETACH_DEAD)
+		event->pending_disable = 1;
 	event_sched_out(event, cpuctx, ctx);
 	if (flags & DETACH_GROUP)
 		perf_group_detach(event);
 	if (flags & DETACH_CHILD)
 		perf_child_detach(event);
 	list_del_event(event, ctx);
+	if (flags & DETACH_DEAD)
+		event->state = PERF_EVENT_STATE_DEAD;
 
 	if (!ctx->nr_events && ctx->is_active) {
 		if (ctx == &cpuctx->ctx)
@@ -5127,9 +5137,7 @@ int perf_event_release_kernel(struct perf_event *event)
 
 	ctx = perf_event_ctx_lock(event);
 	WARN_ON_ONCE(ctx->parent_ctx);
-	perf_remove_from_context(event, DETACH_GROUP);
 
-	raw_spin_lock_irq(&ctx->lock);
 	/*
 	 * Mark this event as STATE_DEAD, there is no external reference to it
 	 * anymore.
@@ -5141,8 +5149,7 @@ int perf_event_release_kernel(struct perf_event *event)
 	 * Thus this guarantees that we will in fact observe and kill _ALL_
 	 * child events.
 	 */
-	event->state = PERF_EVENT_STATE_DEAD;
-	raw_spin_unlock_irq(&ctx->lock);
+	perf_remove_from_context(event, DETACH_GROUP|DETACH_DEAD);
 
 	perf_event_ctx_unlock(event, ctx);
 
@@ -6583,6 +6590,8 @@ static void perf_pending_task(struct callback_head *head)
 	if (rctx >= 0)
 		perf_swevent_put_recursion_context(rctx);
 	preempt_enable_notrace();
+
+	put_event(event);
 }
 
 #ifdef CONFIG_GUEST_PERF_EVENTS

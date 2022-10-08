Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ACA15F8451
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 10:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiJHIlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 04:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiJHIlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 04:41:37 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5747410563
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 01:41:36 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id w10so9825786edd.4
        for <linux-kernel@vger.kernel.org>; Sat, 08 Oct 2022 01:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WxdcSrBOGO9MYgndz6qzjn61BZYNh2xTD3igd7MSm5c=;
        b=nmR1Fi0PdzdMHZAyOKlzQqOUaEpdYIN8DD9ZEgkgrPLoFUPVTfpTAMOrdmKzL7MqBr
         /KKuy2dI5684FfSWWA4M7FAR9pTEM7kYYF433eJSYqOW8lb8h9y9LblCGzNUbrw9ppOi
         zCSNGlg1eZFhDFsKlrfvcIEeyILfI5ffIRPTPPsLR1HtC3ygkqrDyOUEttB7muWDmFCC
         dbPlF1uTHhHS75TJswE6JHGncNCbsvT4csytWCE5ekP2BmeIN8hUnaf+tj1F+iUNmx7S
         lghppvBIMQoKczZ4sT/fGAyB544J4u0R5R1CU3DEgmF6uIcMrGZ4yg9svwFNXvW9J0z2
         V/+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WxdcSrBOGO9MYgndz6qzjn61BZYNh2xTD3igd7MSm5c=;
        b=3l79JoWww/spW1Zz0eTITkbageqTa94to0A8LbmdLMJrP7fF4Wg7npk/jZDTsB3cwj
         3j+IKaWKZ63mjo9YOa8a6X6Q2iMqUoiTc6sI5iCr+kNg5N4/hunLvXWno/VRL+FfRXYp
         zEf04Qc9QHyZoX+dfruqtqUQCsfEgBZ3k69yNYGQ/v0dVF2+dLKz8kfFrkaE31BMNeHq
         8Fbru5ZznVLJQSgg98eF1azsMRfyjxro8hKyBpBMrkVo95fYo9uN6fXBzvrWeIsxINh+
         r97tAOlVhqAnoEawd7SRWMF/C+545tN15EDjPMNEocO5ej0oJTAfjaR/8EorQ5/L2skX
         VHMg==
X-Gm-Message-State: ACrzQf3Vm4Mf5MH3RdbfvZxoDLOktITS6ezllDu3EnrABNqxxhKt4C4B
        qCxgVpfRH3O67UyIY+SV3lRKbg==
X-Google-Smtp-Source: AMsMyM7BA312x0VvaeqVc6OyWCdkvRRS95nVi0wubI3ieh9d+sm/H19oBxjutMnBaGx+lHDhHxzaQQ==
X-Received: by 2002:a05:6402:1842:b0:458:e6f2:bd3d with SMTP id v2-20020a056402184200b00458e6f2bd3dmr7973061edy.169.1665218494605;
        Sat, 08 Oct 2022 01:41:34 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:9c:201:6029:e851:8078:4621])
        by smtp.gmail.com with ESMTPSA id d6-20020a50f686000000b00459e3a3f3ddsm3081688edn.79.2022.10.08.01.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Oct 2022 01:41:33 -0700 (PDT)
Date:   Sat, 8 Oct 2022 10:41:28 +0200
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
Message-ID: <Y0E3uG7jOywn7vy3@elver.google.com>
References: <20220927121322.1236730-1-elver@google.com>
 <Yz7ZLaT4jW3Y9EYS@hirez.programming.kicks-ass.net>
 <Yz7fWw8duIOezSW1@elver.google.com>
 <Yz78MMMJ74tBw0gu@hirez.programming.kicks-ass.net>
 <Yz/zXpF1yLshrJm/@elver.google.com>
 <Y0Ak/D05KhJeKaed@hirez.programming.kicks-ass.net>
 <Y0AwaxcJNOWhMKXP@elver.google.com>
 <Y0BQYxewPB/6KWLz@elver.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0BQYxewPB/6KWLz@elver.google.com>
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

On Fri, Oct 07, 2022 at 06:14PM +0200, Marco Elver wrote:
> On Fri, Oct 07, 2022 at 03:58PM +0200, Marco Elver wrote:
> > On Fri, Oct 07, 2022 at 03:09PM +0200, Peter Zijlstra wrote:
> > > On Fri, Oct 07, 2022 at 11:37:34AM +0200, Marco Elver wrote:
> > > 
> > > > That worked. In addition I had to disable the ctx->task != current check
> > > > if we're in task_work, because presumably the event might have already
> > > > been disabled/moved??
> > > 
> > > Uhmmm... uhhh... damn. (wall-time was significantly longer)
> > > 
> > > Does this help?
> > 
> > No unfortunately - still see:
> > 
> > [   82.300827] ------------[ cut here ]------------
> > [   82.301680] WARNING: CPU: 0 PID: 976 at kernel/events/core.c:6466 perf_sigtrap+0x60/0x70
> 
> Whenever the warning fires, I see that event->state is OFF.

The below patch to the sigtrap_threads test can repro the issue (when
run lots of them concurrently again). It also illustrates the original
problem we're trying to solve, where the event never gets rearmed again
and the test times out (doesn't happen with the almost-working fix).

Thanks,
-- Marco

------ >8 ------

From 98d225bda6d94dd793a1d0c77ae4b301c364166e Mon Sep 17 00:00:00 2001
From: Marco Elver <elver@google.com>
Date: Sat, 8 Oct 2022 10:26:58 +0200
Subject: [PATCH] selftests/perf_events: Add a SIGTRAP stress test with
 disables

Add a SIGTRAP stress test that exercises repeatedly enabling/disabling
an event while it concurrently keeps firing.

Signed-off-by: Marco Elver <elver@google.com>
---
 .../selftests/perf_events/sigtrap_threads.c   | 35 +++++++++++++++++--
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/perf_events/sigtrap_threads.c b/tools/testing/selftests/perf_events/sigtrap_threads.c
index 6d849dc2bee0..d1d8483ac628 100644
--- a/tools/testing/selftests/perf_events/sigtrap_threads.c
+++ b/tools/testing/selftests/perf_events/sigtrap_threads.c
@@ -62,6 +62,8 @@ static struct perf_event_attr make_event_attr(bool enabled, volatile void *addr,
 		.remove_on_exec = 1, /* Required by sigtrap. */
 		.sigtrap	= 1, /* Request synchronous SIGTRAP on event. */
 		.sig_data	= TEST_SIG_DATA(addr, id),
+		.exclude_kernel = 1, /* To allow */
+		.exclude_hv     = 1, /* running as !root */
 	};
 	return attr;
 }
@@ -93,9 +95,13 @@ static void *test_thread(void *arg)
 
 	__atomic_fetch_add(&ctx.tids_want_signal, tid, __ATOMIC_RELAXED);
 	iter = ctx.iterate_on; /* read */
-	for (i = 0; i < iter - 1; i++) {
-		__atomic_fetch_add(&ctx.tids_want_signal, tid, __ATOMIC_RELAXED);
-		ctx.iterate_on = iter; /* idempotent write */
+	if (iter >= 0) {
+		for (i = 0; i < iter - 1; i++) {
+			__atomic_fetch_add(&ctx.tids_want_signal, tid, __ATOMIC_RELAXED);
+			ctx.iterate_on = iter; /* idempotent write */
+		}
+	} else {
+		while (ctx.iterate_on);
 	}
 
 	return NULL;
@@ -208,4 +214,27 @@ TEST_F(sigtrap_threads, signal_stress)
 	EXPECT_EQ(ctx.first_siginfo.si_perf_data, TEST_SIG_DATA(&ctx.iterate_on, 0));
 }
 
+TEST_F(sigtrap_threads, signal_stress_with_disable)
+{
+	const int target_count = NUM_THREADS * 3000;
+	int i;
+
+	ctx.iterate_on = -1;
+
+	EXPECT_EQ(ioctl(self->fd, PERF_EVENT_IOC_ENABLE, 0), 0);
+	pthread_barrier_wait(&self->barrier);
+	while (__atomic_load_n(&ctx.signal_count, __ATOMIC_RELAXED) < target_count) {
+		EXPECT_EQ(ioctl(self->fd, PERF_EVENT_IOC_DISABLE, 0), 0);
+		EXPECT_EQ(ioctl(self->fd, PERF_EVENT_IOC_ENABLE, 0), 0);
+	}
+	ctx.iterate_on = 0;
+	for (i = 0; i < NUM_THREADS; i++)
+		ASSERT_EQ(pthread_join(self->threads[i], NULL), 0);
+	EXPECT_EQ(ioctl(self->fd, PERF_EVENT_IOC_DISABLE, 0), 0);
+
+	EXPECT_EQ(ctx.first_siginfo.si_addr, &ctx.iterate_on);
+	EXPECT_EQ(ctx.first_siginfo.si_perf_type, PERF_TYPE_BREAKPOINT);
+	EXPECT_EQ(ctx.first_siginfo.si_perf_data, TEST_SIG_DATA(&ctx.iterate_on, 0));
+}
+
 TEST_HARNESS_MAIN
-- 
2.38.0.rc1.362.ged0d419d3c-goog


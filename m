Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53EF05F50C1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 10:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbiJEIYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 04:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiJEIYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 04:24:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A22E4055E;
        Wed,  5 Oct 2022 01:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EnWe5Z/LqqGP1/UejfDNmVCgj3ooQI9F6kvj8QuOzms=; b=kJMPjhN6skcw0f6p3ee8QvlAeZ
        qSgfJKl8jg8OWEcu5ut/rcJcgYyBvVtVcBpjd/I06gFPaY7ZZKT2iOiCdIQMO1m+e+p5KZYyYBijV
        o7jnrrKr1Hui2SXNLr+UwKUt0mR7un/g5JjQ1KWIu2B1ONnb+HVtfBrCFjSYpEcrPus90RGDVCWCS
        EaV5p1RaNLwla28CtM8hCj8DL3H+gE6YcKFPKdyrhch/P6iriMjQdBR0CMX1vlaMjL9U/JK5HYpBu
        xumcjIG5ufEY0zN38PF/SzIsXsX8C4q1aBrMl+8QTn+kaomXjV8AQiLMK6PnH5iPImPlwZT1Kej1/
        TyOUT2PA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ofzh4-000Ded-KV; Wed, 05 Oct 2022 08:23:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3CF75300137;
        Wed,  5 Oct 2022 10:23:50 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EB6552018BB82; Wed,  5 Oct 2022 10:23:49 +0200 (CEST)
Date:   Wed, 5 Oct 2022 10:23:49 +0200
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
Subject: Re: [PATCH] perf: Fix missing SIGTRAPs due to pending_disable abuse
Message-ID: <Yz0/FfW4kwSK/p9c@hirez.programming.kicks-ass.net>
References: <20220927121322.1236730-1-elver@google.com>
 <YzM/BUsBnX18NoOG@hirez.programming.kicks-ass.net>
 <YzNu5bgASbuVi0S3@elver.google.com>
 <YzQcqe9p9C5ZbjZ1@elver.google.com>
 <YzRgcnMXWuUZ4rlt@elver.google.com>
 <Yzxou9HB/1XjMXWI@hirez.programming.kicks-ass.net>
 <CANpmjNPwiL279B5id5dPF821aXYdTUqsfDNAtB4q7jXX+41Qgg@mail.gmail.com>
 <Yz00IjTZjlsKlNvy@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yz00IjTZjlsKlNvy@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 05, 2022 at 09:37:06AM +0200, Peter Zijlstra wrote:
> On Tue, Oct 04, 2022 at 07:33:55PM +0200, Marco Elver wrote:
> > It looks reasonable, but obviously needs to pass tests. :-)
> 
> Ikr :-)
> 
> > Also, see comment below (I think you're still turning signals
> > asynchronous, which we shouldn't do).
> 
> Indeed so; I tried fixing that this morning, but so far that doesn't
> seem to want to actually cure things :/ I'll need to stomp on this
> harder.
> 
> Current hackery below. The main difference is that instead of trying to
> restart the irq_work on sched_in, sched_out will now queue a task-work.
> 
> The event scheduling is done from 'regular' IRQ context and as such
> there should be a return-to-userspace for the relevant task in the
> immediate future (either directly or after scheduling).
> 
> Alas, something still isn't right...

Oh, lol, *groan*... this fixes it:

Now to find a sane way to inhibit this while a sig thing is pending :/

diff --git a/kernel/events/core.c b/kernel/events/core.c
index b981b879bcd8..92b6a2f6de1a 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3426,7 +3434,7 @@ static void perf_event_context_sched_out(struct task_struct *task, int ctxn,
 		 */
 		raw_spin_lock(&ctx->lock);
 		raw_spin_lock_nested(&next_ctx->lock, SINGLE_DEPTH_NESTING);
-		if (context_equiv(ctx, next_ctx)) {
+		if (0 && context_equiv(ctx, next_ctx)) {
 
 			WRITE_ONCE(ctx->task, next);
 			WRITE_ONCE(next_ctx->task, task);

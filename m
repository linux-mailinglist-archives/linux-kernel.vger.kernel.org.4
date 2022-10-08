Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28AF25F8539
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 14:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbiJHMmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 08:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiJHMmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 08:42:07 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C578740E3A;
        Sat,  8 Oct 2022 05:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1AqpcDikuJJT8s474v7vbDua4kAtza8/IGevf4nKFXc=; b=WWuA7kbAMVy1DUlBskWANcJ9T4
        tnZI20WPOmrYt45dhakCYVMbaIaH042Y3OCV7uaS8ULUsdzyX9f2n0XQU/HbiCO4aAvMzc0ybLUVh
        hfgVo7vd5Cbv25UJ7UF1RnmLmxloU4y51XEYGWQM1ehQPA1xKUAXAn8NVM2PYDLI+qAomw9nKZEGb
        UvCuh0UM6DUXS50+X/9lnyo+RcrVTbMxMqcDxF10tqzgjM49yoagaE6FHOASPUL0EIxQNCpBl2fyd
        y2TKQVjSN9TafZE1IQVic7S1+//nxSWbzuSapUQGXBY3xvCvvK/QzjC2P1mgz+HYYhUwq51THEBZ1
        aUD92QYA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oh99J-001i1F-Ak; Sat, 08 Oct 2022 12:41:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EF64330017D;
        Sat,  8 Oct 2022 14:41:47 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AC72B2BD85715; Sat,  8 Oct 2022 14:41:47 +0200 (CEST)
Date:   Sat, 8 Oct 2022 14:41:47 +0200
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
Message-ID: <Y0FwC1yo1pcyL9J/@hirez.programming.kicks-ass.net>
References: <20220927121322.1236730-1-elver@google.com>
 <Yz7ZLaT4jW3Y9EYS@hirez.programming.kicks-ass.net>
 <Yz7fWw8duIOezSW1@elver.google.com>
 <Yz78MMMJ74tBw0gu@hirez.programming.kicks-ass.net>
 <Yz/zXpF1yLshrJm/@elver.google.com>
 <Y0Ak/D05KhJeKaed@hirez.programming.kicks-ass.net>
 <Y0AwaxcJNOWhMKXP@elver.google.com>
 <Y0BQYxewPB/6KWLz@elver.google.com>
 <Y0E3uG7jOywn7vy3@elver.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0E3uG7jOywn7vy3@elver.google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 08, 2022 at 10:41:28AM +0200, Marco Elver wrote:
> The below patch to the sigtrap_threads test can repro the issue (when
> run lots of them concurrently again). It also illustrates the original
> problem we're trying to solve, where the event never gets rearmed again
> and the test times out (doesn't happen with the almost-working fix).

Excellent, that helps. Also, I'm an idiot ;-)

The below seems to fix it for me.

---
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3441,7 +3448,8 @@ static void perf_event_context_sched_out
 			perf_pmu_disable(pmu);
 
 			/* PMIs are disabled; ctx->nr_pending is stable. */
-			if (local_read(&ctx->nr_pending)) {
+			if (local_read(&ctx->nr_pending) ||
+			    local_read(&next_ctx->nr_pending)) {
 				/*
 				 * Must not swap out ctx when there's pending
 				 * events that rely on the ctx->task relation.

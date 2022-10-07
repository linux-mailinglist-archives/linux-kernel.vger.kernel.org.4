Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B61F5F789F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 15:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbiJGNJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 09:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbiJGNJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 09:09:29 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 664C5CBFD2;
        Fri,  7 Oct 2022 06:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0BeKBcF7ouX2G91odn0fVr+GuMOLBqXSocw/B9YMzNQ=; b=nEqRyilqSYRnop1hcQ4p+Obmvq
        iH/L/WeUXcWmsKz+z/g7DKlYcUt9aVvfYj+ghXrJeQ9KDfoiy60mF8aySpZlJq+Q0wovEuM1RXtHY
        c1LClyOdf4SCgCtiiFPO0QzXchdPa8c7iWfcovXPCpI6ojPoLNzdbevq1Z59E4MXYsV2NjrkRJyYy
        7KPGzL1sSLlcx46Yh0kezEeQJfMTzPzHKnTg9uLbzb+lGVT58bgnT4rI/7znt7OJ6/IQxIzyPHY2C
        YmNnHiKedAD4xJnHc6oQ0/4gYHCJhnrIP4BdRMkVwBGGrImWyUfYkm1qPA6p1na2fR+EgSvkXP5tu
        1LTISozw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ogn6L-001THF-Il; Fri, 07 Oct 2022 13:09:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0D51A300155;
        Fri,  7 Oct 2022 15:09:17 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E2DB92BDA8BD6; Fri,  7 Oct 2022 15:09:16 +0200 (CEST)
Date:   Fri, 7 Oct 2022 15:09:16 +0200
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
Message-ID: <Y0Ak/D05KhJeKaed@hirez.programming.kicks-ass.net>
References: <20220927121322.1236730-1-elver@google.com>
 <Yz7ZLaT4jW3Y9EYS@hirez.programming.kicks-ass.net>
 <Yz7fWw8duIOezSW1@elver.google.com>
 <Yz78MMMJ74tBw0gu@hirez.programming.kicks-ass.net>
 <Yz/zXpF1yLshrJm/@elver.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yz/zXpF1yLshrJm/@elver.google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 07, 2022 at 11:37:34AM +0200, Marco Elver wrote:

> That worked. In addition I had to disable the ctx->task != current check
> if we're in task_work, because presumably the event might have already
> been disabled/moved??

Uhmmm... uhhh... damn. (wall-time was significantly longer)

Does this help?

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6490,8 +6490,8 @@ static void __perf_pending_irq(struct pe
 	if (cpu == smp_processor_id()) {
 		if (event->pending_sigtrap) {
 			event->pending_sigtrap = 0;
-			local_dec(&event->ctx->nr_pending);
 			perf_sigtrap(event);
+			local_dec(&event->ctx->nr_pending);
 		}
 		if (event->pending_disable) {
 			event->pending_disable = 0;
@@ -6563,8 +6563,8 @@ static void perf_pending_task(struct cal
 
 	if (event->pending_work) {
 		event->pending_work = 0;
-		local_dec(&event->ctx->nr_pending);
 		perf_sigtrap(event);
+		local_dec(&event->ctx->nr_pending);
 	}
 
 	if (rctx >= 0)

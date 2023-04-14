Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C43626E1E1C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 10:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjDNIZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 04:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjDNIYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 04:24:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525C36E9D;
        Fri, 14 Apr 2023 01:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=23TvM9bAd6O+vHiDc7KhaDWib6wc5fh99kV9pfSTlzs=; b=U89+tYLRZHqGWm+mumhNbqHQSE
        B09d69SBqhsesq8phfol9XQLQm1RrREFVN6wJvUq/k/lr0ernylbw1flFlK7nKiuR1csanCgBRbkw
        eBS+b62GEd+lIRC4j7ln8WYBywKM6SRS31kqWL2QVK4bGGb/UerGlSX0IauBq/rBREfpbEWsuoNt2
        5oUBr3qM5YAIEIV2keuV6L738xZimulw47fZn5YFaqBpRFQCMz+jvcvMvZY7Ai/8CZoHhxnTUQQRq
        H6Ck5u0N44+F095zyUDfeyeg7Nb4YzygHLnD80ml9S3AQbacWcJO/SYO+eSuScTcV2u5gCoEZ6PLa
        gSpVjmXA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pnEiV-008aEj-G0; Fri, 14 Apr 2023 08:23:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 089903001E4;
        Fri, 14 Apr 2023 10:23:35 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DA50320248CE4; Fri, 14 Apr 2023 10:23:34 +0200 (CEST)
Date:   Fri, 14 Apr 2023 10:23:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yang Jihong <yangjihong1@huawei.com>
Cc:     mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, eranian@google.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v3] perf/core: Fix hardlockup failure caused by
 perf throttle
Message-ID: <20230414082334.GU4253@hirez.programming.kicks-ass.net>
References: <20230227023508.102230-1-yangjihong1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230227023508.102230-1-yangjihong1@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2023 at 10:35:08AM +0800, Yang Jihong wrote:
> commit e050e3f0a71bf ("perf: Fix broken interrupt rate throttling")
> introduces a change in throttling threshold judgment. Before this,
> compare hwc->interrupts and max_samples_per_tick, then increase
> hwc->interrupts by 1, but this commit reverses order of these two
> behaviors, causing the semantics of max_samples_per_tick to change.
> In literal sense of "max_samples_per_tick", if hwc->interrupts ==
> max_samples_per_tick, it should not be throttled, therefore, the judgment
> condition should be changed to "hwc->interrupts > max_samples_per_tick".
> 
> In fact, this may cause the hardlockup to fail, The minimum value of
> max_samples_per_tick may be 1, in this case, the return value of
> __perf_event_account_interrupt function is 1.
> As a result, nmi_watchdog gets throttled, which would stop PMU (Use x86
> architecture as an example, see x86_pmu_handle_irq).
> 
> Fixes: e050e3f0a71b ("perf: Fix broken interrupt rate throttling")
> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
> ---
>  kernel/events/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index f79fd8b87f75..0540a8653906 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -9434,7 +9434,7 @@ __perf_event_account_interrupt(struct perf_event *event, int throttle)
>  	} else {
>  		hwc->interrupts++;
>  		if (unlikely(throttle
> -			     && hwc->interrupts >= max_samples_per_tick)) {
> +			     && hwc->interrupts > max_samples_per_tick)) {
>  			__this_cpu_inc(perf_throttled_count);
>  			tick_dep_set_cpu(smp_processor_id(), TICK_DEP_BIT_PERF_EVENTS);
>  			hwc->interrupts = MAX_INTERRUPTS;

Thanks, I've made a slight edit to fix the && placement.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF1F96B6754
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 15:54:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjCLOym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 10:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjCLOyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 10:54:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A587D1ADFD;
        Sun, 12 Mar 2023 07:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KH8tQFD6+tSiQOT1PfAjpOv+D/Fe0N+sgUQBc9cq624=; b=Co5lzFiJvwM5i18Hf55xUJOJph
        fBo561VYQN40SnrTJ3KRBJ/PqK4eBf8dm119k0Me17OhdmmWRBYDy/Irgn7ow1bSDhr63ywCmukN2
        eVr9VUAT/xCnljLv+EDJeoo8uxJCt/3I0tguH082ZjjfDeVEChImzd6iK1qUVHgWPsxprBnuGlbhc
        sGVSZpHU2IL5jKkogMIATBwrS0EL94M/4PC8fo41Fog9juREVrbEUfcE3zKwttc+ZL0n7ZpdqEO6s
        GZ4/ZKP3pDqMOmHPbbeor6zSmHP6pZr0PGBYXsv6wc2lwFYdThfCstDHZLHdrJb5E4B+o3N6kfd6/
        A3KHym4w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pbN5f-00B73x-Pr; Sun, 12 Mar 2023 14:54:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6A7773001E5;
        Sun, 12 Mar 2023 15:54:26 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 448DD20831B69; Sun, 12 Mar 2023 15:54:26 +0100 (CET)
Date:   Sun, 12 Mar 2023 15:54:26 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     namhyung@kernel.org, eranian@google.com, acme@kernel.org,
        mark.rutland@arm.com, jolsa@kernel.org, irogers@google.com,
        bp@alien8.de, x86@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, sandipan.das@amd.com,
        ananth.narayan@amd.com, santosh.shukla@amd.com
Subject: Re: [PATCH v2 2/3] perf/ibs: Fix interface via core pmu events
Message-ID: <20230312145426.GA1757905@hirez.programming.kicks-ass.net>
References: <20230309101111.444-1-ravi.bangoria@amd.com>
 <20230309101111.444-3-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230309101111.444-3-ravi.bangoria@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2023 at 03:41:10PM +0530, Ravi Bangoria wrote:
> diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
> index 8c45b198b62f..81d67b899371 100644
> --- a/arch/x86/events/amd/core.c
> +++ b/arch/x86/events/amd/core.c
> @@ -371,10 +371,15 @@ static inline int amd_has_nb(struct cpu_hw_events *cpuc)
>  static int amd_pmu_hw_config(struct perf_event *event)
>  {
>  	int ret;
> +	u64 dummy;
>  
> -	/* pass precise event sampling to ibs: */
> -	if (event->attr.precise_ip && get_ibs_caps())
> -		return -ENOENT;
> +	if (event->attr.precise_ip) {
> +		/* pass precise event sampling to ibs by returning -ESRCH */
> +		if (get_ibs_caps() && !ibs_core_pmu_event(event, &dummy))
> +			return -ESRCH;
> +		else
> +			return -ENOENT;
> +	}
>  
>  	if (has_branch_stack(event) && !x86_pmu.lbr_nr)
>  		return -EOPNOTSUPP;
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index f79fd8b87f75..e990c71ba34a 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -11639,18 +11639,26 @@ static struct pmu *perf_init_event(struct perf_event *event)
>  			goto again;
>  		}
>  
> +		/*
> +		 * pmu->event_init() should return -ESRCH only when it
> +		 * wants to forward the event to other pmu.
> +		 */
> +		if (ret == -ESRCH)
> +			goto try_all;
> +
>  		if (ret)
>  			pmu = ERR_PTR(ret);
>  
>  		goto unlock;
>  	}
>  
> +try_all:
>  	list_for_each_entry_rcu(pmu, &pmus, entry, lockdep_is_held(&pmus_srcu)) {
>  		ret = perf_try_init_event(pmu, event);
>  		if (!ret)
>  			goto unlock;
>  
> -		if (ret != -ENOENT) {
> +		if (ret != -ENOENT && ret != -ESRCH) {
>  			pmu = ERR_PTR(ret);
>  			goto unlock;
>  		}

Urgh.. So amd_pmu_hw_config() knows what PMU it should be but has no
real way to communicate this, so you make it try all of them again.

Now, we already have a gruesome hack in there, and I'm thikning you
should use that instead of adding yet another one. Note:

		if (ret == -ENOENT && event->attr.type != type && !extended_type) {
			type = event->attr.type;
			goto again;

So if you have amd_pmu_hw_config() do:

	event->attr.type = ibs_pmu.type;
	return -ENOENT;

it should all just work no?

And now thinking about this, I'm thinking we can clean up the whole
swevent mess too, a little something like the below perhaps... Then it
might just be possible to remove that list_for_each_entry_rcu()
entirely.

Hmm?


---
diff --git a/kernel/events/core.c b/kernel/events/core.c
index f79fd8b87f75..26130d1ca40b 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9951,6 +9951,9 @@ static void sw_perf_event_destroy(struct perf_event *event)
 	swevent_hlist_put();
 }
 
+static struct pmu perf_cpu_clock; /* fwd declaration */
+static struct pmu perf_task_clock;
+
 static int perf_swevent_init(struct perf_event *event)
 {
 	u64 event_id = event->attr.config;
@@ -9966,7 +9969,11 @@ static int perf_swevent_init(struct perf_event *event)
 
 	switch (event_id) {
 	case PERF_COUNT_SW_CPU_CLOCK:
+		event->attr.type = perf_cpu_clock.type;
+		return -ENOENT;
+
 	case PERF_COUNT_SW_TASK_CLOCK:
+		event->attr.type = perf_task_clock.type;
 		return -ENOENT;
 
 	default:

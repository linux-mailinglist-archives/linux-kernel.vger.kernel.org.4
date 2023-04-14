Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BBBC6E20BE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 12:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbjDNK3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 06:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjDNK3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 06:29:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D314510FC
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 03:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mabrkjJN0IeQKhxInoEIAYe6rjhJQoOGlkU97HBs3Fo=; b=olAEilK25HkCq4rMrRoXo/KjK4
        +CHuqZTrBYRivlqpmQ/gbNuoBLwgETiuAsXdy1zfjgBeM17IDKN98jswwkJtB7qmNS6t3J+UIrGun
        buYNcZinwg/StlfEpfSe1em+utA9cNRdrtYU+A01PoM82ph/c3UctYu3x7hM3MHILQ5IK5Ps08anS
        mXVW6r/Wlfv173+gZztQujyFwSIxzMcwvwVtRSWPKvmh7ntYoFukcr9inEKKLjt0WPy9x0geGkDsr
        YIDJNfpMCPnIkaw5PcrThh7K2r3R8nZcMqACUAISixTTXYt9zCRZC4ugdKoDNRun+n66VTA2f4TLL
        uOYTcQnA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pnGg3-008fen-Bv; Fri, 14 Apr 2023 10:29:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4CDD83002A3;
        Fri, 14 Apr 2023 12:29:09 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E517E265F26D4; Fri, 14 Apr 2023 12:29:08 +0200 (CEST)
Date:   Fri, 14 Apr 2023 12:29:08 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org, eranian@google.com,
        ak@linux.intel.com
Subject: Re: [PATCH V3] perf/x86/intel/ds: Flush the PEBS buffer in PEBS
 enable
Message-ID: <20230414102908.GC83892@hirez.programming.kicks-ass.net>
References: <20230410181309.827175-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230410181309.827175-1-kan.liang@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 10, 2023 at 11:13:09AM -0700, kan.liang@linux.intel.com wrote:

>  arch/x86/events/intel/ds.c | 39 ++++++++++++++++++++++++++------------
>  1 file changed, 27 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
> index 3a77f4336df7..4639d4c1e98d 100644
> --- a/arch/x86/events/intel/ds.c
> +++ b/arch/x86/events/intel/ds.c
> @@ -1257,20 +1257,18 @@ pebs_update_state(bool needed_cb, struct cpu_hw_events *cpuc,
>  	if (x86_pmu.intel_cap.pebs_baseline && add) {
>  		u64 pebs_data_cfg;
>  
> -		/* Clear pebs_data_cfg and pebs_record_size for first PEBS. */
> -		if (cpuc->n_pebs == 1) {
> +		/* Clear pebs_data_cfg for first PEBS. */
> +		if (cpuc->n_pebs == 1)
>  			cpuc->pebs_data_cfg = 0;
> -			cpuc->pebs_record_size = sizeof(struct pebs_basic);
> -		}
>  
>  		pebs_data_cfg = pebs_update_adaptive_cfg(event);
>  
> -		/* Update pebs_record_size if new event requires more data. */
> -		if (pebs_data_cfg & ~cpuc->pebs_data_cfg) {
> +		/*
> +		 * Only update the pebs_data_cfg here. The pebs_record_size
> +		 * will be updated later when the new pebs_data_cfg takes effect.
> +		 */
> +		if (pebs_data_cfg & ~cpuc->pebs_data_cfg)
>  			cpuc->pebs_data_cfg |= pebs_data_cfg;
> -			adaptive_pebs_record_size_update();
> -			update = true;
> -		}
>  	}
>  
>  	if (update)
		pebs_update_threshold(cpuc);

Now, pebs_update_threshold() will actually use
->pebs_record_size, but afaict the above now has a path through (for
example for the first event) where update is true but ->pebs_record_size
is unset/stale.

I think it all works out, but it is quite a mess and hard to follow.

> @@ -1331,6 +1329,13 @@ static void intel_pmu_pebs_via_pt_enable(struct perf_event *event)
>  	wrmsrl(base + idx, value);
>  }
>  
> +static inline void intel_pmu_drain_large_pebs(struct cpu_hw_events *cpuc)
> +{
> +	if (cpuc->n_pebs == cpuc->n_large_pebs &&
> +	    cpuc->n_pebs != cpuc->n_pebs_via_pt)
> +		intel_pmu_drain_pebs_buffer();
> +}

Its been a minute since I looked at this code; but why only for large
pebs? Surely flushing is quick when the DS is actually empty and that
stops us having to worry if there's races where there might be a single
entry in.

>  void intel_pmu_pebs_enable(struct perf_event *event)
>  {
>  	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> @@ -1350,6 +1355,18 @@ void intel_pmu_pebs_enable(struct perf_event *event)
>  	if (x86_pmu.intel_cap.pebs_baseline) {
>  		hwc->config |= ICL_EVENTSEL_ADAPTIVE;
>  		if (cpuc->pebs_data_cfg != cpuc->active_pebs_data_cfg) {
> +			/*
> +			 * A system-wide PEBS event with the large PEBS
> +			 * config may still be enabled when switching the
> +			 * context. Some PEBS records for the system-wide
> +			 * PEBS may be generated while the old event has
> +			 * been scheduled out but the new one hasn't been
> +			 * scheduled in. It's not enough to only flush the
> +			 * buffer when a PEBS event is disable.
> +			 */

Perhaps just:

			/*
			 * drain_pebs() assumes uniform record size;
			 * hence we need to drain when changing said
			 * size.
			 */


> +			intel_pmu_drain_large_pebs(cpuc);
> +			adaptive_pebs_record_size_update();
> +			pebs_update_threshold(cpuc);
>  			wrmsrl(MSR_PEBS_DATA_CFG, cpuc->pebs_data_cfg);
>  			cpuc->active_pebs_data_cfg = cpuc->pebs_data_cfg;
>  		}

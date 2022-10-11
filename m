Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7245FB174
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 13:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbiJKLaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 07:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbiJKLaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 07:30:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4DCB33877;
        Tue, 11 Oct 2022 04:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0RPB2UDDdxR9Nzxfl8rEmcnylTIR/tDD2ldWTb0Kmvs=; b=hziRi25xfV1WtaQCf+wZ+lUUHW
        HCP8gOpLFD3xVbSNywDC0dzI9vamllBUAtUzbavKasldT7wmhJtBf/HBcE+cvwiMautCbRRvCknpA
        LJ5olLBWSkSJaIqdyw1e3wEtHzzkbmVcGBytLgKUKiuFQSZ6zFEp8XrohwUgfx8WDNZG5VDqzaczJ
        bO1n+ye2iJGY0mYVurlcly1f5rpOyZGp0N9F5sZS96kx3ZLBx+4H2D1SLnekULz22/MyDlTfNxkj9
        RdU20AeHKx/+CREAHI02Py8DKasBTEjGrmtum7gcM2uFkyw6vqHY+c+BXCKcV8Hy0pnH42P/ISrAM
        R99LFxAw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oiDS9-004uvD-72; Tue, 11 Oct 2022 11:29:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D56913000E3;
        Tue, 11 Oct 2022 13:29:35 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BAF812997FB9A; Tue, 11 Oct 2022 13:29:35 +0200 (CEST)
Date:   Tue, 11 Oct 2022 13:29:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, songliubraving@fb.com,
        eranian@google.com, ak@linux.intel.com, mark.rutland@arm.com,
        frederic@kernel.org, maddy@linux.ibm.com, irogers@google.com,
        will@kernel.org, robh@kernel.org, mingo@redhat.com,
        catalin.marinas@arm.com, ndesaulniers@google.com,
        srw@sladewatkins.net, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandipan.das@amd.com, ananth.narayan@amd.com, kim.phillips@amd.com,
        santosh.shukla@amd.com
Subject: Re: [PATCH v2] perf: Rewrite core context handling
Message-ID: <Y0VTn0qLWd925etP@hirez.programming.kicks-ass.net>
References: <20221008062424.313-1-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221008062424.313-1-ravi.bangoria@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 08, 2022 at 11:54:24AM +0530, Ravi Bangoria wrote:

> +static void perf_event_swap_task_ctx_data(struct perf_event_context *prev_ctx,
> +					  struct perf_event_context *next_ctx)
> +{
> +	struct perf_event_pmu_context *prev_epc, *next_epc;
> +
> +	if (!prev_ctx->nr_task_data)
> +		return;
> +
> +	prev_epc = list_first_entry(&prev_ctx->pmu_ctx_list,
> +				    struct perf_event_pmu_context,
> +				    pmu_ctx_entry);
> +	next_epc = list_first_entry(&next_ctx->pmu_ctx_list,
> +				    struct perf_event_pmu_context,
> +				    pmu_ctx_entry);
> +
> +	while (&prev_epc->pmu_ctx_entry != &prev_ctx->pmu_ctx_list &&
> +	       &next_epc->pmu_ctx_entry != &next_ctx->pmu_ctx_list) {
> +
> +		WARN_ON_ONCE(prev_epc->pmu != next_epc->pmu);
> +
> +		/*
> +		 * PMU specific parts of task perf context can require
> +		 * additional synchronization. As an example of such
> +		 * synchronization see implementation details of Intel
> +		 * LBR call stack data profiling;
> +		 */
> +		if (prev_epc->pmu->swap_task_ctx)
> +			prev_epc->pmu->swap_task_ctx(prev_epc, next_epc);
> +		else
> +			swap(prev_epc->task_ctx_data, next_epc->task_ctx_data);

Did I forget to advance the iterators here?

> +	}
> +}


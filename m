Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 515495FB40F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 16:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbiJKODi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 10:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiJKODc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 10:03:32 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B946FA14;
        Tue, 11 Oct 2022 07:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=D73BjQfIrSTnj6EqtQCxORHOxjQyNOc/wJqBUfiO9Q8=; b=SABjHiClB4JQLpcyV5/NJW5d3o
        7qiqIFwxs3yuoRYvHYEUmakkgOL5QJruLYYiLrB8KNBxvc9M0m1MoPYCe3IOz0IAw0eNWihsAXV/P
        5Y+f4dExVkJIGRYxLQbJ5kAOwfVu5T6Pm67GO++RvcH0pmN82akGPlefH2VZrln++lzM7rjbIHmLX
        OGbnU3htHC2Rq9KOnboXIhUwg0DEfnfpXfP1N++I2+o6Ukub7Ckdu6lBrxmW1FB4Cb9KB7FurUxMk
        eNByW8y5b+lmZE8M/V8PaAIkYFv7qB7CIAzpDcxJNW9ZAkwV7KHd56f56h5fcbaZVr9iX5gjnz055
        cLqo9vfg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oiFqT-002aUL-ES; Tue, 11 Oct 2022 14:02:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 557723000E3;
        Tue, 11 Oct 2022 16:02:56 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 449D529AC89DB; Tue, 11 Oct 2022 16:02:56 +0200 (CEST)
Date:   Tue, 11 Oct 2022 16:02:56 +0200
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
Message-ID: <Y0V3kOWInrvCvVtk@hirez.programming.kicks-ass.net>
References: <20221008062424.313-1-ravi.bangoria@amd.com>
 <Y0VTn0qLWd925etP@hirez.programming.kicks-ass.net>
 <ba47d079-6d97-0412-69a0-fa15999b5024@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba47d079-6d97-0412-69a0-fa15999b5024@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2022 at 06:49:55PM +0530, Ravi Bangoria wrote:
> On 11-Oct-22 4:59 PM, Peter Zijlstra wrote:
> > On Sat, Oct 08, 2022 at 11:54:24AM +0530, Ravi Bangoria wrote:
> > 
> >> +static void perf_event_swap_task_ctx_data(struct perf_event_context *prev_ctx,
> >> +					  struct perf_event_context *next_ctx)
> >> +{
> >> +	struct perf_event_pmu_context *prev_epc, *next_epc;
> >> +
> >> +	if (!prev_ctx->nr_task_data)
> >> +		return;
> >> +
> >> +	prev_epc = list_first_entry(&prev_ctx->pmu_ctx_list,
> >> +				    struct perf_event_pmu_context,
> >> +				    pmu_ctx_entry);
> >> +	next_epc = list_first_entry(&next_ctx->pmu_ctx_list,
> >> +				    struct perf_event_pmu_context,
> >> +				    pmu_ctx_entry);
> >> +
> >> +	while (&prev_epc->pmu_ctx_entry != &prev_ctx->pmu_ctx_list &&
> >> +	       &next_epc->pmu_ctx_entry != &next_ctx->pmu_ctx_list) {
> >> +
> >> +		WARN_ON_ONCE(prev_epc->pmu != next_epc->pmu);
> >> +
> >> +		/*
> >> +		 * PMU specific parts of task perf context can require
> >> +		 * additional synchronization. As an example of such
> >> +		 * synchronization see implementation details of Intel
> >> +		 * LBR call stack data profiling;
> >> +		 */
> >> +		if (prev_epc->pmu->swap_task_ctx)
> >> +			prev_epc->pmu->swap_task_ctx(prev_epc, next_epc);
> >> +		else
> >> +			swap(prev_epc->task_ctx_data, next_epc->task_ctx_data);
> > 
> > Did I forget to advance the iterators here?
> 
> Yeah. Seems so. I overlooked it too.

OK; so I'm not slowly going crazy staring at this code ;-) Let me go add
it now then. :-)

But first I gotta taxi the kids around for a bit, bbl.

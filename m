Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B738C5E6625
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 16:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbiIVOsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 10:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiIVOsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 10:48:51 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE0377F11F
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 07:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lrHnKMPOzUeAyfSj/3BoDegtk/niQrwVfh0GEj+d7Uc=; b=B1ZDODj11PNlMHBsJ7MXDwoMCv
        4Z1tGWH9fyF4smjyjyJGGKDONjrpkLHP4+S2ztuz6YRK4TtvVC17mpiXjgxyYFfwU7bUzhl/dadYL
        eTGKTdspqtdeEY1wNHGZYhAPA7QLHTpbS+gbbd3r+iFYbi/nubFPtu1jjlbBNDceug0qO61tinb1o
        KQbJsIPK6WhjImKmu0WmpJdiOAsIRFe84Dy4zm+MfVB3YHZJGMGGBNNYJJiXlWw//3mduRYI9Ev0N
        jFWnnkbR2PLiH1Uqgnt7wDPJYcnGSTIo9xX5wbRsLNUrIS1Ly/elPOUgHgEuYjnShTKHbqqwzKT7w
        KyX3QgZA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1obNVD-00Eymr-Nn; Thu, 22 Sep 2022 14:48:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8482D300169;
        Thu, 22 Sep 2022 16:48:34 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 68BF0203E5B5F; Thu, 22 Sep 2022 16:48:34 +0200 (CEST)
Date:   Thu, 22 Sep 2022 16:48:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Stephane Eranian <eranian@google.com>,
        Kan Liang <kan.liang@linux.intel.com>
Subject: Re: [PATCH 1/2] perf: Use sample_flags for addr
Message-ID: <Yyx1wv06cL0pkQ6H@hirez.programming.kicks-ass.net>
References: <20220921220032.2858517-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220921220032.2858517-1-namhyung@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2022 at 03:00:31PM -0700, Namhyung Kim wrote:
> Use the new sample_flags to indicate whether the addr field is filled by
> the PMU driver.  As most PMU drivers pass 0, it can set the flag only if
> it has a non-zero value.  And use 0 in perf_sample_output() if it's not
> filled already.

So no objection to the general idea; just a question

> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 368bdc4f563f..f4a13579b0e8 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -1028,7 +1028,6 @@ struct perf_sample_data {
>  	 * minimize the cachelines touched.
>  	 */
>  	u64				sample_flags;
> -	u64				addr;
>  	struct perf_raw_record		*raw;
>  	u64				period;
>  
> @@ -1040,6 +1039,7 @@ struct perf_sample_data {
>  	union perf_sample_weight	weight;
>  	union  perf_mem_data_src	data_src;
>  	u64				txn;
> +	u64				addr;
>  
>  	u64				type;
>  	u64				ip;

Is there a reason you placed the variable where you did?

I'm thinking we should look at what perf-tool thinks is the common set
of SAMPLE flags and make sure those fields are grouped in as little
cachelines as possible.

Things like @ip and @type, which are basically *always* set, should
definitely be on top, no?



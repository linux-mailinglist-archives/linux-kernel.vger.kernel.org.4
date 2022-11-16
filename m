Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B32662BC88
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 12:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233489AbiKPLvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 06:51:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233383AbiKPLvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 06:51:14 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D1EF94093C;
        Wed, 16 Nov 2022 03:39:33 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E13701477;
        Wed, 16 Nov 2022 03:39:39 -0800 (PST)
Received: from [10.1.39.20] (e121896.cambridge.arm.com [10.1.39.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5008C3F663;
        Wed, 16 Nov 2022 03:39:31 -0800 (PST)
Message-ID: <86c42368-cbbb-2e13-ce7d-31865a12bb81@arm.com>
Date:   Wed, 16 Nov 2022 11:39:29 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 09/12] perf test: Add 'brstack' test workload
Content-Language: en-US
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Leo Yan <leo.yan@linaro.org>,
        German Gomez <german.gomez@arm.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
References: <20221110181920.84900-1-namhyung@kernel.org>
 <20221110181920.84900-10-namhyung@kernel.org>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20221110181920.84900-10-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/11/2022 18:19, Namhyung Kim wrote:
[...]
> +
> +#define BENCH_RUNS 999999
> +
> +static volatile int cnt;
> +
> +static void brstack_bar(void) {
> +}				/* return */
> +
> +static void brstack_foo(void) {
> +	brstack_bar();		/* call */
> +}				/* return */
> +
> +static void brstack_bench(void) {
> +	void (*brstack_foo_ind)(void) = brstack_foo;
> +
> +	if ((cnt++) % 3)	/* branch (cond) */
> +		brstack_foo();	/* call */
> +	brstack_bar();		/* call */
> +	brstack_foo_ind();	/* call (ind) */
> +}
> +
> +static int brstack(int argc, const char **argv)
> +{
> +	if (argc > 0)
> +		cnt = atoi(argv[0]);
> +
> +	while (1) {
> +		if ((cnt++) > BENCH_RUNS)
> +			break;

Hi Namhyung,

I'm reading this as you can specify the number of loops as an argument.

In that case should it be more like this?

        int num_loops = argc>0 ? atoi(argv[0]) : BENCH_RUNS;

	if ((cnt++) > num_loops)
		break;

> +		brstack_bench();/* call */
> +	}			/* branch (uncond) */
> +	return 0;
> +}
> +
> +DEFINE_WORKLOAD(brstack);

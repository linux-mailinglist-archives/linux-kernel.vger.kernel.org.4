Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33FD1708892
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 21:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbjERTrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 15:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjERTra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 15:47:30 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326D0E67;
        Thu, 18 May 2023 12:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684439249; x=1715975249;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=9caYYmPafBroM32BqFYVElb6P+CxhxuZ14TrqGfddUo=;
  b=GRFs9XJJitfM41Vg43ZHwV3tlOhAUjzkKOtOokwRWoXquZ6etrUs/Dxi
   LniNCJUYuTucwrcPIIxtR0aP25LdIzFtHXDPjTi6gQHtGL9sek1gilWM2
   5U915bi8j9sVDhwDaecO6dXZri2eS0sd91pB2QBCnk11vmyL82E8xS5dF
   QC1Y8FvjVJv21/hNyYdI8DNxUNWxG7Ei2N/2PFcq23JnkB64wJRp8AfGw
   aIRBfcGYiA6Cj3jVxVj8sAA9ongcQPbQOeWhaH4H+9iHdau8HqJWU1KcB
   u90pnOiH6TSiXIi9MWT8Qs2An6gMwqqtO1ISE1qdZKXlyAQgZflPKd5BL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="415635044"
X-IronPort-AV: E=Sophos;i="6.00,175,1681196400"; 
   d="scan'208";a="415635044"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 12:47:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="876556715"
X-IronPort-AV: E=Sophos;i="6.00,175,1681196400"; 
   d="scan'208";a="876556715"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 18 May 2023 12:47:28 -0700
Received: from [10.209.99.208] (kliang2-mobl1.ccr.corp.intel.com [10.209.99.208])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 286A7580BE4;
        Thu, 18 May 2023 12:47:26 -0700 (PDT)
Message-ID: <2abe618d-a2c4-3b22-ac9d-37bc91d05d41@linux.intel.com>
Date:   Thu, 18 May 2023 15:47:25 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v1 1/2] perf expr: Make the evaluation of & and | logical
 and lazy
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@arm.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ahmad Yasin <ahmad.yasin@intel.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Weilin Wang <weilin.wang@intel.com>,
        Edward Baker <edward.baker@intel.com>
References: <20230504195803.3331775-1-irogers@google.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20230504195803.3331775-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-05-04 3:58 p.m., Ian Rogers wrote:
> Currently the & and | operators are only used in metric thresholds
> like (from the tma_retiring metric):
> tma_retiring > 0.7 | tma_heavy_operations > 0.1
> 
> Thresholds are always computed when present, but a lack events may
> mean the threshold can't be computed. This happens with the option
> --metric-no-threshold for say the metric tma_retiring on Tigerlake
> model CPUs. To fully compute the threshold tma_heavy_operations is
> needed and it needs the extra events of IDQ.MS_UOPS,
> UOPS_DECODED.DEC0, cpu/UOPS_DECODED.DEC0,cmask=1/ and
> IDQ.MITE_UOPS. So --metric-no-threshold is a useful option to reduce
> the number of events needed and potentially multiplexing of events.
> 
> Rather than just fail threshold computations like this, we may know a
> result from just the left or right-hand side. So, for tma_retiring if
> its value is "> 0.7" we know it is over the threshold. This allows the
> metric to have the threshold coloring, when possible, without all the
> counters being programmed.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---

The patch works well on my machine.

Tested-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan
>  tools/perf/tests/expr.c | 40 +++++++++++++++++++
>  tools/perf/util/expr.y  | 86 +++++++++++++++++++++++++++++++++--------
>  2 files changed, 109 insertions(+), 17 deletions(-)
> 
> diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
> index cbf0e0c74906..45c7fedb797a 100644
> --- a/tools/perf/tests/expr.c
> +++ b/tools/perf/tests/expr.c
> @@ -184,6 +184,46 @@ static int test__expr(struct test_suite *t __maybe_unused, int subtest __maybe_u
>  			NULL, ctx) == 0);
>  	TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) == 0);
>  
> +	/* The expression is a constant 0.0 without needing to evaluate EVENT1. */
> +	expr__ctx_clear(ctx);
> +	TEST_ASSERT_VAL("find ids",
> +			expr__find_ids("0 & EVENT1 > 0", NULL, ctx) == 0);
> +	TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) == 0);
> +	expr__ctx_clear(ctx);
> +	TEST_ASSERT_VAL("find ids",
> +			expr__find_ids("EVENT1 > 0 & 0", NULL, ctx) == 0);
> +	TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) == 0);
> +	expr__ctx_clear(ctx);
> +	TEST_ASSERT_VAL("find ids",
> +			expr__find_ids("1 & EVENT1 > 0", NULL, ctx) == 0);
> +	TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) == 1);
> +	TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids, "EVENT1", &val_ptr));
> +	expr__ctx_clear(ctx);
> +	TEST_ASSERT_VAL("find ids",
> +			expr__find_ids("EVENT1 > 0 & 1", NULL, ctx) == 0);
> +	TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) == 1);
> +	TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids, "EVENT1", &val_ptr));
> +
> +	/* The expression is a constant 1.0 without needing to evaluate EVENT1. */
> +	expr__ctx_clear(ctx);
> +	TEST_ASSERT_VAL("find ids",
> +			expr__find_ids("1 | EVENT1 > 0", NULL, ctx) == 0);
> +	TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) == 0);
> +	expr__ctx_clear(ctx);
> +	TEST_ASSERT_VAL("find ids",
> +			expr__find_ids("EVENT1 > 0 | 1", NULL, ctx) == 0);
> +	TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) == 0);
> +	expr__ctx_clear(ctx);
> +	TEST_ASSERT_VAL("find ids",
> +			expr__find_ids("0 | EVENT1 > 0", NULL, ctx) == 0);
> +	TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) == 1);
> +	TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids, "EVENT1", &val_ptr));
> +	expr__ctx_clear(ctx);
> +	TEST_ASSERT_VAL("find ids",
> +			expr__find_ids("EVENT1 > 0 | 0", NULL, ctx) == 0);
> +	TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) == 1);
> +	TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids, "EVENT1", &val_ptr));
> +
>  	/* Test toplogy constants appear well ordered. */
>  	expr__ctx_clear(ctx);
>  	TEST_ASSERT_VAL("#num_cpus", expr__parse(&num_cpus, ctx, "#num_cpus") == 0);
> diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
> index 250e444bf032..6b110f9f95c9 100644
> --- a/tools/perf/util/expr.y
> +++ b/tools/perf/util/expr.y
> @@ -123,20 +123,6 @@ static struct ids handle_id(struct expr_parse_ctx *ctx, char *id,
>   * constant value using OP. Its invariant that there are no ids.  If computing
>   * ids for non-constants union the set of IDs that must be computed.
>   */
> -#define BINARY_LONG_OP(RESULT, OP, LHS, RHS)				\
> -	if (!compute_ids || (is_const(LHS.val) && is_const(RHS.val))) { \
> -		assert(LHS.ids == NULL);				\
> -		assert(RHS.ids == NULL);				\
> -		if (isnan(LHS.val) || isnan(RHS.val)) {			\
> -			RESULT.val = NAN;				\
> -		} else {						\
> -			RESULT.val = (long)LHS.val OP (long)RHS.val;	\
> -		}							\
> -		RESULT.ids = NULL;					\
> -	} else {							\
> -	        RESULT = union_expr(LHS, RHS);				\
> -	}
> -
>  #define BINARY_OP(RESULT, OP, LHS, RHS)					\
>  	if (!compute_ids || (is_const(LHS.val) && is_const(RHS.val))) { \
>  		assert(LHS.ids == NULL);				\
> @@ -213,9 +199,75 @@ expr: NUMBER
>  }
>  | ID				{ $$ = handle_id(ctx, $1, compute_ids, /*source_count=*/false); }
>  | SOURCE_COUNT '(' ID ')'	{ $$ = handle_id(ctx, $3, compute_ids, /*source_count=*/true); }
> -| expr '|' expr { BINARY_LONG_OP($$, |, $1, $3); }
> -| expr '&' expr { BINARY_LONG_OP($$, &, $1, $3); }
> -| expr '^' expr { BINARY_LONG_OP($$, ^, $1, $3); }
> +| expr '|' expr
> +{
> +	if (is_const($1.val) && is_const($3.val)) {
> +		assert($1.ids == NULL);
> +		assert($3.ids == NULL);
> +		$$.ids = NULL;
> +		$$.val = (fpclassify($1.val) == FP_ZERO && fpclassify($3.val) == FP_ZERO) ? 0 : 1;
> +	} else if (is_const($1.val)) {
> +		assert($1.ids == NULL);
> +		if (fpclassify($1.val) == FP_ZERO) {
> +			$$ = $3;
> +		} else {
> +			$$.val = 1;
> +			$$.ids = NULL;
> +			ids__free($3.ids);
> +		}
> +	} else if (is_const($3.val)) {
> +		assert($3.ids == NULL);
> +		if (fpclassify($3.val) == FP_ZERO) {
> +			$$ = $1;
> +		} else {
> +			$$.val = 1;
> +			$$.ids = NULL;
> +			ids__free($1.ids);
> +		}
> +	} else {
> +		$$ = union_expr($1, $3);
> +	}
> +}
> +| expr '&' expr
> +{
> +	if (is_const($1.val) && is_const($3.val)) {
> +		assert($1.ids == NULL);
> +		assert($3.ids == NULL);
> +		$$.val = (fpclassify($1.val) != FP_ZERO && fpclassify($3.val) != FP_ZERO) ? 1 : 0;
> +		$$.ids = NULL;
> +	} else if (is_const($1.val)) {
> +		assert($1.ids == NULL);
> +		if (fpclassify($1.val) != FP_ZERO) {
> +			$$ = $3;
> +		} else {
> +			$$.val = 0;
> +			$$.ids = NULL;
> +			ids__free($3.ids);
> +		}
> +	} else if (is_const($3.val)) {
> +		assert($3.ids == NULL);
> +		if (fpclassify($3.val) != FP_ZERO) {
> +			$$ = $1;
> +		} else {
> +			$$.val = 0;
> +			$$.ids = NULL;
> +			ids__free($1.ids);
> +		}
> +	} else {
> +		$$ = union_expr($1, $3);
> +	}
> +}
> +| expr '^' expr
> +{
> +	if (is_const($1.val) && is_const($3.val)) {
> +		assert($1.ids == NULL);
> +		assert($3.ids == NULL);
> +		$$.val = (fpclassify($1.val) == FP_ZERO) != (fpclassify($3.val) == FP_ZERO) ? 1 : 0;
> +		$$.ids = NULL;
> +	} else {
> +		$$ = union_expr($1, $3);
> +	}
> +}
>  | expr '<' expr { BINARY_OP($$, <, $1, $3); }
>  | expr '>' expr { BINARY_OP($$, >, $1, $3); }
>  | expr '+' expr { BINARY_OP($$, +, $1, $3); }

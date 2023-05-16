Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0917046AA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 09:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbjEPHko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 03:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjEPHkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 03:40:43 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF3F2690;
        Tue, 16 May 2023 00:40:39 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-96aa0cab88dso754430666b.1;
        Tue, 16 May 2023 00:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684222838; x=1686814838;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/wQZn//CGe7+K2GqKzKrwn7d0YEVExyW7SoiXjaCuEA=;
        b=BF4cySnnIE51miOa5sJV6Ea5OhpNrPr4mrkPuoUq7bAYBg3gj0evsBCNBHcn99PXkf
         op8qHkpgWa6g5anBmsUpyJ4lIpPIrXgs7dsrzb/Vcvvk6/VVr1oWDBfEXfivlA7Q7844
         tVFvJEN1hMLq7qKl7IKvbsxclVwMck85AllCYLgfChcD/0DefTI+J/9eL1BAyR+RbGuo
         uFi7SABoEUBtcPwkhoMMYJz/F7cIOZF1MfyFGjRyeYQiO/aGXFwqSZ/0vefo3u5d18nY
         dvNzJEW7JQOeazIU114IWmnbK1SA653ou+9uPZ0HyXs7kpk0UqwWTZixsVG6r2rSN0Aj
         MICQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684222838; x=1686814838;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/wQZn//CGe7+K2GqKzKrwn7d0YEVExyW7SoiXjaCuEA=;
        b=dGNbaVAw8bgAWXLEjHcyurXSDa0bQ4TlBFlQAxaehrwBBYl4QHBYdAKcYrMUaron0t
         DIqWPtBK2XXQ4YQol7oWnV86co+AvfSR2wD/GfuHitB8u0Y5c3049adxkULCAxEYwXqb
         AKpQx0+J3MneTbOHZZypwQRSONZBBIJpoPvtkvv46Lq8kNhMphVT1Y3WkYdAlDPkJuks
         vb7EwTI31o4R2C+XAsYyN3tofMBj88KfeQwGx6GeEI4Q86IU9C5uT86X8JMoUlVuFzFX
         LfGpoyFI85RWKaRQaFam5uixTufvFGrdvnAeel52os2c7Tfekux6aurX57nbRAbxfRoO
         iwwg==
X-Gm-Message-State: AC+VfDyvHikGErVp8FihstsqW61/7/Ni0gVQLuye9A/LaScBAlH97yxF
        VliTNIyQ52uhv8prbewS9Yw=
X-Google-Smtp-Source: ACHHUZ6/oyokjYydgVAHBsq30ik7SCbvdOz8OrTjxLmR6ZRUuZeA7F380IDWMw95s+omX7P1hcWviA==
X-Received: by 2002:a17:907:c19:b0:960:7643:c970 with SMTP id ga25-20020a1709070c1900b009607643c970mr38743981ejc.26.1684222837739;
        Tue, 16 May 2023 00:40:37 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id rh2-20020a17090720e200b0094f698073e0sm10489521ejb.123.2023.05.16.00.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 00:40:37 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Tue, 16 May 2023 09:40:35 +0200
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
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
Subject: Re: [PATCH v1 1/2] perf expr: Make the evaluation of & and | logical
 and lazy
Message-ID: <ZGMzc20dvBRk2Eys@krava>
References: <20230504195803.3331775-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230504195803.3331775-1-irogers@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 04, 2023 at 12:58:02PM -0700, Ian Rogers wrote:
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

lgtm

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> ---
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
> -- 
> 2.40.1.521.gf1e218fcd8-goog
> 

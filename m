Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C13B703220
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 18:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242141AbjEOQFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 12:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242557AbjEOQEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 12:04:43 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501A61706
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 09:04:11 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-3f38824a025so1500391cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 09:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684166649; x=1686758649;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FWCtorT274ZT9r6ATdV2o5UGKfkf1JsTgc/fOLqiwZ8=;
        b=JuZ66xOnbOHlXuFnciEplSd/CAbN2LFCSQSWonCmUx9oPujrui5Z2TN2OAmVqDP7W+
         7SabfHKKL4rvpdqhq2JGjyr9OEI2cb36CuDmamFcR9LApG4tsutCHkN5KjicP4x+Nh7m
         mYMhG6+YynmJADkujfvlsj6PmV1MFTLjQijlNuk97IL7vMT0EgSw72EVHoQyJeBp4ACF
         0JSDc9sGizzGGNkHjNXjhx2OScmRyhZyADIRaqz+jxu7ArC/CLjLNCGanyfANaxeDLWd
         aKOt7m4ryqyXxRjWyz1uspUY+39vzcNg/tN6dQSTQ4PZs1IBUyk+N2moy5UUXYRySK1P
         ERdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684166649; x=1686758649;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FWCtorT274ZT9r6ATdV2o5UGKfkf1JsTgc/fOLqiwZ8=;
        b=GQCE3idu02HiTmCXAYo5Fy0IPioo399Jkhe9mjOK2hzapW24brc8mbTnZuK+qdSdo6
         EM8Djgi6oTTKpArsdttg4lqkqAQcgTG2prKAhtAzZJkKUiqtfcS2Fp4+GxEHuQZKbbHj
         sTg1I04yCvL7E7/qLrDJ4uvbgsiMFvj0pCGOAdCOWMQjW4GqI42MDwhn4fTlu8++lqgl
         9BZzlSqMefeOFVfp4wBuxlye1IiGt6p8/ApKmLFrWO4QQhTlbsuAwHxf7xHVh9vxPGgq
         BLUVvoS5AT1A7UM9VBgtvqhuUOrRtB3D5arx/4XTdmgYeAEnK1HcclhgyjSXL+fsNRS1
         cNrA==
X-Gm-Message-State: AC+VfDx98uHJAB5DXqwkJwi5nbp8MKJtVzQN87K0SXYre4pKESVMO7pB
        uRsR/sbpRo/URezDt26cYQSDdib2IC1QErrgwzJotA==
X-Google-Smtp-Source: ACHHUZ7sH+2NKPcj3dtd8YtHwYs4HOnOtTAB4Legi8W1w3+KV/OLrmPaW+JrP7dcLA5HEGWYjw885My7f6ncieqRFwk=
X-Received: by 2002:a05:622a:18d:b0:3f0:af20:1a37 with SMTP id
 s13-20020a05622a018d00b003f0af201a37mr891419qtw.15.1684166648708; Mon, 15 May
 2023 09:04:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230504195803.3331775-1-irogers@google.com>
In-Reply-To: <20230504195803.3331775-1-irogers@google.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 15 May 2023 09:03:57 -0700
Message-ID: <CAP-5=fURdgOXQzZmO1gMy6ziYqWkM7B7TP=V-chXm8Kj_zWXXw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] perf expr: Make the evaluation of & and | logical
 and lazy
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 4, 2023 at 12:58=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> Currently the & and | operators are only used in metric thresholds
> like (from the tma_retiring metric):
> tma_retiring > 0.7 | tma_heavy_operations > 0.1
>
> Thresholds are always computed when present, but a lack events may
> mean the threshold can't be computed. This happens with the option
> --metric-no-threshold for say the metric tma_retiring on Tigerlake
> model CPUs. To fully compute the threshold tma_heavy_operations is
> needed and it needs the extra events of IDQ.MS_UOPS,
> UOPS_DECODED.DEC0, cpu/UOPS_DECODED.DEC0,cmask=3D1/ and
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

Ping.

Thanks,
Ian

> ---
>  tools/perf/tests/expr.c | 40 +++++++++++++++++++
>  tools/perf/util/expr.y  | 86 +++++++++++++++++++++++++++++++++--------
>  2 files changed, 109 insertions(+), 17 deletions(-)
>
> diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
> index cbf0e0c74906..45c7fedb797a 100644
> --- a/tools/perf/tests/expr.c
> +++ b/tools/perf/tests/expr.c
> @@ -184,6 +184,46 @@ static int test__expr(struct test_suite *t __maybe_u=
nused, int subtest __maybe_u
>                         NULL, ctx) =3D=3D 0);
>         TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) =3D=3D 0);
>
> +       /* The expression is a constant 0.0 without needing to evaluate E=
VENT1. */
> +       expr__ctx_clear(ctx);
> +       TEST_ASSERT_VAL("find ids",
> +                       expr__find_ids("0 & EVENT1 > 0", NULL, ctx) =3D=
=3D 0);
> +       TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) =3D=3D 0);
> +       expr__ctx_clear(ctx);
> +       TEST_ASSERT_VAL("find ids",
> +                       expr__find_ids("EVENT1 > 0 & 0", NULL, ctx) =3D=
=3D 0);
> +       TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) =3D=3D 0);
> +       expr__ctx_clear(ctx);
> +       TEST_ASSERT_VAL("find ids",
> +                       expr__find_ids("1 & EVENT1 > 0", NULL, ctx) =3D=
=3D 0);
> +       TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) =3D=3D 1);
> +       TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids, "EVENT1", &va=
l_ptr));
> +       expr__ctx_clear(ctx);
> +       TEST_ASSERT_VAL("find ids",
> +                       expr__find_ids("EVENT1 > 0 & 1", NULL, ctx) =3D=
=3D 0);
> +       TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) =3D=3D 1);
> +       TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids, "EVENT1", &va=
l_ptr));
> +
> +       /* The expression is a constant 1.0 without needing to evaluate E=
VENT1. */
> +       expr__ctx_clear(ctx);
> +       TEST_ASSERT_VAL("find ids",
> +                       expr__find_ids("1 | EVENT1 > 0", NULL, ctx) =3D=
=3D 0);
> +       TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) =3D=3D 0);
> +       expr__ctx_clear(ctx);
> +       TEST_ASSERT_VAL("find ids",
> +                       expr__find_ids("EVENT1 > 0 | 1", NULL, ctx) =3D=
=3D 0);
> +       TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) =3D=3D 0);
> +       expr__ctx_clear(ctx);
> +       TEST_ASSERT_VAL("find ids",
> +                       expr__find_ids("0 | EVENT1 > 0", NULL, ctx) =3D=
=3D 0);
> +       TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) =3D=3D 1);
> +       TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids, "EVENT1", &va=
l_ptr));
> +       expr__ctx_clear(ctx);
> +       TEST_ASSERT_VAL("find ids",
> +                       expr__find_ids("EVENT1 > 0 | 0", NULL, ctx) =3D=
=3D 0);
> +       TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) =3D=3D 1);
> +       TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids, "EVENT1", &va=
l_ptr));
> +
>         /* Test toplogy constants appear well ordered. */
>         expr__ctx_clear(ctx);
>         TEST_ASSERT_VAL("#num_cpus", expr__parse(&num_cpus, ctx, "#num_cp=
us") =3D=3D 0);
> diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
> index 250e444bf032..6b110f9f95c9 100644
> --- a/tools/perf/util/expr.y
> +++ b/tools/perf/util/expr.y
> @@ -123,20 +123,6 @@ static struct ids handle_id(struct expr_parse_ctx *c=
tx, char *id,
>   * constant value using OP. Its invariant that there are no ids.  If com=
puting
>   * ids for non-constants union the set of IDs that must be computed.
>   */
> -#define BINARY_LONG_OP(RESULT, OP, LHS, RHS)                           \
> -       if (!compute_ids || (is_const(LHS.val) && is_const(RHS.val))) { \
> -               assert(LHS.ids =3D=3D NULL);                             =
   \
> -               assert(RHS.ids =3D=3D NULL);                             =
   \
> -               if (isnan(LHS.val) || isnan(RHS.val)) {                 \
> -                       RESULT.val =3D NAN;                              =
 \
> -               } else {                                                \
> -                       RESULT.val =3D (long)LHS.val OP (long)RHS.val;   =
 \
> -               }                                                       \
> -               RESULT.ids =3D NULL;                                     =
 \
> -       } else {                                                        \
> -               RESULT =3D union_expr(LHS, RHS);                         =
 \
> -       }
> -
>  #define BINARY_OP(RESULT, OP, LHS, RHS)                                 =
       \
>         if (!compute_ids || (is_const(LHS.val) && is_const(RHS.val))) { \
>                 assert(LHS.ids =3D=3D NULL);                             =
   \
> @@ -213,9 +199,75 @@ expr: NUMBER
>  }
>  | ID                           { $$ =3D handle_id(ctx, $1, compute_ids, =
/*source_count=3D*/false); }
>  | SOURCE_COUNT '(' ID ')'      { $$ =3D handle_id(ctx, $3, compute_ids, =
/*source_count=3D*/true); }
> -| expr '|' expr { BINARY_LONG_OP($$, |, $1, $3); }
> -| expr '&' expr { BINARY_LONG_OP($$, &, $1, $3); }
> -| expr '^' expr { BINARY_LONG_OP($$, ^, $1, $3); }
> +| expr '|' expr
> +{
> +       if (is_const($1.val) && is_const($3.val)) {
> +               assert($1.ids =3D=3D NULL);
> +               assert($3.ids =3D=3D NULL);
> +               $$.ids =3D NULL;
> +               $$.val =3D (fpclassify($1.val) =3D=3D FP_ZERO && fpclassi=
fy($3.val) =3D=3D FP_ZERO) ? 0 : 1;
> +       } else if (is_const($1.val)) {
> +               assert($1.ids =3D=3D NULL);
> +               if (fpclassify($1.val) =3D=3D FP_ZERO) {
> +                       $$ =3D $3;
> +               } else {
> +                       $$.val =3D 1;
> +                       $$.ids =3D NULL;
> +                       ids__free($3.ids);
> +               }
> +       } else if (is_const($3.val)) {
> +               assert($3.ids =3D=3D NULL);
> +               if (fpclassify($3.val) =3D=3D FP_ZERO) {
> +                       $$ =3D $1;
> +               } else {
> +                       $$.val =3D 1;
> +                       $$.ids =3D NULL;
> +                       ids__free($1.ids);
> +               }
> +       } else {
> +               $$ =3D union_expr($1, $3);
> +       }
> +}
> +| expr '&' expr
> +{
> +       if (is_const($1.val) && is_const($3.val)) {
> +               assert($1.ids =3D=3D NULL);
> +               assert($3.ids =3D=3D NULL);
> +               $$.val =3D (fpclassify($1.val) !=3D FP_ZERO && fpclassify=
($3.val) !=3D FP_ZERO) ? 1 : 0;
> +               $$.ids =3D NULL;
> +       } else if (is_const($1.val)) {
> +               assert($1.ids =3D=3D NULL);
> +               if (fpclassify($1.val) !=3D FP_ZERO) {
> +                       $$ =3D $3;
> +               } else {
> +                       $$.val =3D 0;
> +                       $$.ids =3D NULL;
> +                       ids__free($3.ids);
> +               }
> +       } else if (is_const($3.val)) {
> +               assert($3.ids =3D=3D NULL);
> +               if (fpclassify($3.val) !=3D FP_ZERO) {
> +                       $$ =3D $1;
> +               } else {
> +                       $$.val =3D 0;
> +                       $$.ids =3D NULL;
> +                       ids__free($1.ids);
> +               }
> +       } else {
> +               $$ =3D union_expr($1, $3);
> +       }
> +}
> +| expr '^' expr
> +{
> +       if (is_const($1.val) && is_const($3.val)) {
> +               assert($1.ids =3D=3D NULL);
> +               assert($3.ids =3D=3D NULL);
> +               $$.val =3D (fpclassify($1.val) =3D=3D FP_ZERO) !=3D (fpcl=
assify($3.val) =3D=3D FP_ZERO) ? 1 : 0;
> +               $$.ids =3D NULL;
> +       } else {
> +               $$ =3D union_expr($1, $3);
> +       }
> +}
>  | expr '<' expr { BINARY_OP($$, <, $1, $3); }
>  | expr '>' expr { BINARY_OP($$, >, $1, $3); }
>  | expr '+' expr { BINARY_OP($$, +, $1, $3); }
> --
> 2.40.1.521.gf1e218fcd8-goog
>

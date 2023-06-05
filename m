Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35664722DB2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 19:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234896AbjFERcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 13:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234583AbjFERcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 13:32:31 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3966798
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 10:32:30 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-33d928a268eso14575ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 10:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685986349; x=1688578349;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZshFYyq0L62kSyIdVgRWRK042dyZJOn9HYiwHN6D3gw=;
        b=nETNHxZZw+vTDFQ/qXc6wRhWJd2piX+BMCcp+PflMe6YRKr9vk1q3JiH0NFgSf9/7c
         PgSHAn/zC5hW9EuHiCGpOMyU6TJhkBw63kSKo7z8qQJ/yQAvxkLeuP8syKWu6iaZJeb+
         /ggrs/Kd9nNpUfvyprfC2FnqLOsDxsIj0adw913vBKgBMw/ofeMCdEVOwc33DKuYR1wM
         KW1k1Za+oIxJVCHZ+qukzAZCJ1BjUmoLKBEqzr+5yegBvOIhynmhA5VQM8peptQ0wyuD
         xDSGlpjsqdW+7YroTc5pZYorhDSMgAO2+4A74XANA4Spkrm8yP6ujgRNs1n2wJ4aRSN1
         KJUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685986349; x=1688578349;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZshFYyq0L62kSyIdVgRWRK042dyZJOn9HYiwHN6D3gw=;
        b=d7iofOzUs1meFQwz/oRDBrD2aU93HKE4s54/Bf9c14FfeNOjn72JL/Ol5pOXt54/aw
         a0EaKhW7QDbrMowQSZ/PG5v8SBgnaQn8sOUIxgdtxEJhwSzG+7kMeH1ui9gNkEorSe+A
         bYJAfu1ZD2cQbfWbllV1EWBWPuNvCRjPh8RGyQ3JwW4bPba0E/QyAsJGEirziApFn894
         3FJ7Cv3eIesAOT6h9kYh7qxIcub/2lKhLMPIXYTji7Z6QT0gXUQ+ePoruHObvvt35Eof
         mTIJwbsx5cSUAX1hI1uR+e3mSkhsqpUtDNYXRCIQaHyMUOI3ivuWDR4x1Uk/GrnhKRWN
         aLFw==
X-Gm-Message-State: AC+VfDw7GmMYuTLuGCWKHxuh2GmlKhVKZ1z3hdezQs+AZCz2og5ihSwF
        D0DSLPx48Qb0DsIjGmj5RvBox+VM3mInyasEY5bnbQ==
X-Google-Smtp-Source: ACHHUZ6C1sM2Q54vUr0z3LjucUQfMb2qizx4+3ZrGQ3NCvCWk+F91bkmmdyWrDsah8oX8ss6dHh0IvSeJIJp9eaX4Wg=
X-Received: by 2002:a05:6e02:1d82:b0:32a:f2a9:d1b7 with SMTP id
 h2-20020a056e021d8200b0032af2a9d1b7mr13562ila.10.1685986349429; Mon, 05 Jun
 2023 10:32:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230504195803.3331775-1-irogers@google.com> <2abe618d-a2c4-3b22-ac9d-37bc91d05d41@linux.intel.com>
In-Reply-To: <2abe618d-a2c4-3b22-ac9d-37bc91d05d41@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 5 Jun 2023 10:32:18 -0700
Message-ID: <CAP-5=fX_j-iwuHBekCDFzQUGaOqigTXtyUa6npNCuR7ktF-3_A@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] perf expr: Make the evaluation of & and | logical
 and lazy
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
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
        Edward Baker <edward.baker@intel.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2023 at 12:47=E2=80=AFPM Liang, Kan <kan.liang@linux.intel.=
com> wrote:
>
>
>
> On 2023-05-04 3:58 p.m., Ian Rogers wrote:
> > Currently the & and | operators are only used in metric thresholds
> > like (from the tma_retiring metric):
> > tma_retiring > 0.7 | tma_heavy_operations > 0.1
> >
> > Thresholds are always computed when present, but a lack events may
> > mean the threshold can't be computed. This happens with the option
> > --metric-no-threshold for say the metric tma_retiring on Tigerlake
> > model CPUs. To fully compute the threshold tma_heavy_operations is
> > needed and it needs the extra events of IDQ.MS_UOPS,
> > UOPS_DECODED.DEC0, cpu/UOPS_DECODED.DEC0,cmask=3D1/ and
> > IDQ.MITE_UOPS. So --metric-no-threshold is a useful option to reduce
> > the number of events needed and potentially multiplexing of events.
> >
> > Rather than just fail threshold computations like this, we may know a
> > result from just the left or right-hand side. So, for tma_retiring if
> > its value is "> 0.7" we know it is over the threshold. This allows the
> > metric to have the threshold coloring, when possible, without all the
> > counters being programmed.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
>
> The patch works well on my machine.
>
> Tested-by: Kan Liang <kan.liang@linux.intel.com>
>
> Thanks,
> Kan

Arnaldo, could we take this set?

Thanks,
Ian

> >  tools/perf/tests/expr.c | 40 +++++++++++++++++++
> >  tools/perf/util/expr.y  | 86 +++++++++++++++++++++++++++++++++--------
> >  2 files changed, 109 insertions(+), 17 deletions(-)
> >
> > diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
> > index cbf0e0c74906..45c7fedb797a 100644
> > --- a/tools/perf/tests/expr.c
> > +++ b/tools/perf/tests/expr.c
> > @@ -184,6 +184,46 @@ static int test__expr(struct test_suite *t __maybe=
_unused, int subtest __maybe_u
> >                       NULL, ctx) =3D=3D 0);
> >       TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) =3D=3D 0);
> >
> > +     /* The expression is a constant 0.0 without needing to evaluate E=
VENT1. */
> > +     expr__ctx_clear(ctx);
> > +     TEST_ASSERT_VAL("find ids",
> > +                     expr__find_ids("0 & EVENT1 > 0", NULL, ctx) =3D=
=3D 0);
> > +     TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) =3D=3D 0);
> > +     expr__ctx_clear(ctx);
> > +     TEST_ASSERT_VAL("find ids",
> > +                     expr__find_ids("EVENT1 > 0 & 0", NULL, ctx) =3D=
=3D 0);
> > +     TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) =3D=3D 0);
> > +     expr__ctx_clear(ctx);
> > +     TEST_ASSERT_VAL("find ids",
> > +                     expr__find_ids("1 & EVENT1 > 0", NULL, ctx) =3D=
=3D 0);
> > +     TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) =3D=3D 1);
> > +     TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids, "EVENT1", &va=
l_ptr));
> > +     expr__ctx_clear(ctx);
> > +     TEST_ASSERT_VAL("find ids",
> > +                     expr__find_ids("EVENT1 > 0 & 1", NULL, ctx) =3D=
=3D 0);
> > +     TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) =3D=3D 1);
> > +     TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids, "EVENT1", &va=
l_ptr));
> > +
> > +     /* The expression is a constant 1.0 without needing to evaluate E=
VENT1. */
> > +     expr__ctx_clear(ctx);
> > +     TEST_ASSERT_VAL("find ids",
> > +                     expr__find_ids("1 | EVENT1 > 0", NULL, ctx) =3D=
=3D 0);
> > +     TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) =3D=3D 0);
> > +     expr__ctx_clear(ctx);
> > +     TEST_ASSERT_VAL("find ids",
> > +                     expr__find_ids("EVENT1 > 0 | 1", NULL, ctx) =3D=
=3D 0);
> > +     TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) =3D=3D 0);
> > +     expr__ctx_clear(ctx);
> > +     TEST_ASSERT_VAL("find ids",
> > +                     expr__find_ids("0 | EVENT1 > 0", NULL, ctx) =3D=
=3D 0);
> > +     TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) =3D=3D 1);
> > +     TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids, "EVENT1", &va=
l_ptr));
> > +     expr__ctx_clear(ctx);
> > +     TEST_ASSERT_VAL("find ids",
> > +                     expr__find_ids("EVENT1 > 0 | 0", NULL, ctx) =3D=
=3D 0);
> > +     TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) =3D=3D 1);
> > +     TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids, "EVENT1", &va=
l_ptr));
> > +
> >       /* Test toplogy constants appear well ordered. */
> >       expr__ctx_clear(ctx);
> >       TEST_ASSERT_VAL("#num_cpus", expr__parse(&num_cpus, ctx, "#num_cp=
us") =3D=3D 0);
> > diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
> > index 250e444bf032..6b110f9f95c9 100644
> > --- a/tools/perf/util/expr.y
> > +++ b/tools/perf/util/expr.y
> > @@ -123,20 +123,6 @@ static struct ids handle_id(struct expr_parse_ctx =
*ctx, char *id,
> >   * constant value using OP. Its invariant that there are no ids.  If c=
omputing
> >   * ids for non-constants union the set of IDs that must be computed.
> >   */
> > -#define BINARY_LONG_OP(RESULT, OP, LHS, RHS)                         \
> > -     if (!compute_ids || (is_const(LHS.val) && is_const(RHS.val))) { \
> > -             assert(LHS.ids =3D=3D NULL);                             =
   \
> > -             assert(RHS.ids =3D=3D NULL);                             =
   \
> > -             if (isnan(LHS.val) || isnan(RHS.val)) {                 \
> > -                     RESULT.val =3D NAN;                              =
 \
> > -             } else {                                                \
> > -                     RESULT.val =3D (long)LHS.val OP (long)RHS.val;   =
 \
> > -             }                                                       \
> > -             RESULT.ids =3D NULL;                                     =
 \
> > -     } else {                                                        \
> > -             RESULT =3D union_expr(LHS, RHS);                         =
 \
> > -     }
> > -
> >  #define BINARY_OP(RESULT, OP, LHS, RHS)                               =
       \
> >       if (!compute_ids || (is_const(LHS.val) && is_const(RHS.val))) { \
> >               assert(LHS.ids =3D=3D NULL);                             =
   \
> > @@ -213,9 +199,75 @@ expr: NUMBER
> >  }
> >  | ID                         { $$ =3D handle_id(ctx, $1, compute_ids, =
/*source_count=3D*/false); }
> >  | SOURCE_COUNT '(' ID ')'    { $$ =3D handle_id(ctx, $3, compute_ids, =
/*source_count=3D*/true); }
> > -| expr '|' expr { BINARY_LONG_OP($$, |, $1, $3); }
> > -| expr '&' expr { BINARY_LONG_OP($$, &, $1, $3); }
> > -| expr '^' expr { BINARY_LONG_OP($$, ^, $1, $3); }
> > +| expr '|' expr
> > +{
> > +     if (is_const($1.val) && is_const($3.val)) {
> > +             assert($1.ids =3D=3D NULL);
> > +             assert($3.ids =3D=3D NULL);
> > +             $$.ids =3D NULL;
> > +             $$.val =3D (fpclassify($1.val) =3D=3D FP_ZERO && fpclassi=
fy($3.val) =3D=3D FP_ZERO) ? 0 : 1;
> > +     } else if (is_const($1.val)) {
> > +             assert($1.ids =3D=3D NULL);
> > +             if (fpclassify($1.val) =3D=3D FP_ZERO) {
> > +                     $$ =3D $3;
> > +             } else {
> > +                     $$.val =3D 1;
> > +                     $$.ids =3D NULL;
> > +                     ids__free($3.ids);
> > +             }
> > +     } else if (is_const($3.val)) {
> > +             assert($3.ids =3D=3D NULL);
> > +             if (fpclassify($3.val) =3D=3D FP_ZERO) {
> > +                     $$ =3D $1;
> > +             } else {
> > +                     $$.val =3D 1;
> > +                     $$.ids =3D NULL;
> > +                     ids__free($1.ids);
> > +             }
> > +     } else {
> > +             $$ =3D union_expr($1, $3);
> > +     }
> > +}
> > +| expr '&' expr
> > +{
> > +     if (is_const($1.val) && is_const($3.val)) {
> > +             assert($1.ids =3D=3D NULL);
> > +             assert($3.ids =3D=3D NULL);
> > +             $$.val =3D (fpclassify($1.val) !=3D FP_ZERO && fpclassify=
($3.val) !=3D FP_ZERO) ? 1 : 0;
> > +             $$.ids =3D NULL;
> > +     } else if (is_const($1.val)) {
> > +             assert($1.ids =3D=3D NULL);
> > +             if (fpclassify($1.val) !=3D FP_ZERO) {
> > +                     $$ =3D $3;
> > +             } else {
> > +                     $$.val =3D 0;
> > +                     $$.ids =3D NULL;
> > +                     ids__free($3.ids);
> > +             }
> > +     } else if (is_const($3.val)) {
> > +             assert($3.ids =3D=3D NULL);
> > +             if (fpclassify($3.val) !=3D FP_ZERO) {
> > +                     $$ =3D $1;
> > +             } else {
> > +                     $$.val =3D 0;
> > +                     $$.ids =3D NULL;
> > +                     ids__free($1.ids);
> > +             }
> > +     } else {
> > +             $$ =3D union_expr($1, $3);
> > +     }
> > +}
> > +| expr '^' expr
> > +{
> > +     if (is_const($1.val) && is_const($3.val)) {
> > +             assert($1.ids =3D=3D NULL);
> > +             assert($3.ids =3D=3D NULL);
> > +             $$.val =3D (fpclassify($1.val) =3D=3D FP_ZERO) !=3D (fpcl=
assify($3.val) =3D=3D FP_ZERO) ? 1 : 0;
> > +             $$.ids =3D NULL;
> > +     } else {
> > +             $$ =3D union_expr($1, $3);
> > +     }
> > +}
> >  | expr '<' expr { BINARY_OP($$, <, $1, $3); }
> >  | expr '>' expr { BINARY_OP($$, >, $1, $3); }
> >  | expr '+' expr { BINARY_OP($$, +, $1, $3); }

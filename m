Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB206EE4A1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 17:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234419AbjDYPSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 11:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234186AbjDYPSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 11:18:37 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2808135A4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 08:18:36 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id e9e14a558f8ab-316d901b2ecso93595ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 08:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682435915; x=1685027915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fvIBVLsfW56x3fBaiRDZP1332+ZMNGLtqLvs93A+xco=;
        b=AqI3twC9+h2lSUnI8NDba/4ZbQG0kzFHP2++jAWw0o4nJapfkF2yYX7Xk+QKxZlYka
         Dl9CNguK3805ADh26vTtUorPEMNhGAX5ur4QLBOEmFGWpVmuGuC2pAGVyJLPFOMX2+8u
         YpeG7upoD3cg6mh/BUoB4lxroUkWp6hblBojwIJyIE9n5IOBZIJP4C1AgAHJu1kLUUWv
         1gGPNqSZbS5XqAzlf27z8rPb9vQi1otZnNih+oSCtdIhEXucxXJy5O72flqnlVpSDfYQ
         mPbqfvSq7PQX4310+1eUh+Pb3tombsKLhsZCe74YH3C5oiFnuhvrUB+xcmWqMTbGvb9O
         M+qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682435915; x=1685027915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fvIBVLsfW56x3fBaiRDZP1332+ZMNGLtqLvs93A+xco=;
        b=EEeieculCesoZBDU01IBVJ/XOkmcp2PuAXdMrd1La2ycWmLVgSfRQb3l05ie22UT6V
         NrY9Z1RRjbCYtqHnGCig5xjQWxHbo4gFrJt4E6M+WpMyj1T1qh174+P7ayX7BmLtTx2B
         w89TRZiBsHUcit0cqijKByHhXh1P9Musqhb1lEEY0n+mzffJSuqSMsDDzqXYreXzc9aT
         Vx5A+9CWC0ClUYhB7z9U9vaeC0kCcit3HCb0Kn6wYBZ3vLgfcz9FPFN821IxvaOMa5V2
         Vmsq4G4BgxZET4CQawgvMggkbY6StpGb6ZXVgSp39X+dsSPAmU8+/JOkyyl96qXn48x/
         9PWg==
X-Gm-Message-State: AC+VfDxDG6tIAKT3mpmWV0O7hJWHtBH1J4KkCN/wc1C3xSMq7GPE7yue
        giETmGiMb4wLjwnQYg6vB9CxLNtiX3/fx8t5CfgYqg==
X-Google-Smtp-Source: ACHHUZ6G5G3vfuO2EYA60+WM/o4leJ9jXzeEQr2Q2iHgofYQxPcTdLqQPPnn+MSHVg+gr3vrUwvCQCNnC8dKBjVlsXo=
X-Received: by 2002:a92:cdac:0:b0:329:333e:4e79 with SMTP id
 g12-20020a92cdac000000b00329333e4e79mr258181ild.1.1682435915217; Tue, 25 Apr
 2023 08:18:35 -0700 (PDT)
MIME-Version: 1.0
References: <877cu0827a.fsf@oldenburg.str.redhat.com>
In-Reply-To: <877cu0827a.fsf@oldenburg.str.redhat.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 25 Apr 2023 08:18:23 -0700
Message-ID: <CAP-5=fWGUcCrq0rHc0YRGWsgyXZDEAo03MaXXbR46Q7KZ3=-qQ@mail.gmail.com>
Subject: Re: [PATCH] perf: Avoid implicit function declarations in lexer/parse interface
To:     Florian Weimer <fweimer@redhat.com>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Justin M. Forbes" <jforbes@fedoraproject.org>
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

On Tue, Apr 25, 2023 at 7:29=E2=80=AFAM Florian Weimer <fweimer@redhat.com>=
 wrote:
>
> In future compilers, -Wno-implicit-function-declaration may not bring
> back support for implicit function declarations, a feature that was
> removed from the C language in C99.  Instead, declare the yylex
> functions using the appropriate argument types.  The solution chosen
> here is not ideal because the prototypes are not verified against
> the function implementations, but the way bison and flex generate
> code make it difficult to share the prototype.
>
> This change should prevent build failures with future compilers which
> no longer support implicit function declarations by default.
>
> Signed-off-by: Florian Weimer <fweimer@redhat.com>

This seems non-standard. Isn't the issue that we're not including the
appropriate <...>-flex.h ? The use of yylex for the function name
obfuscates this a bit. For example:

pmu-flex.h:
...
#ifdef yylex
#define perf_pmu_lex_ALREADY_DEFINED
#else
#define yylex perf_pmu_lex
#endif
...
/* Default declaration of generated scanner - a define so the user can
* easily add parameters.
*/
#ifndef YY_DECL
#define YY_DECL_IS_OURS 1

extern int yylex \
              (YYSTYPE * yylval_param , yyscan_t yyscanner);

#define YY_DECL int yylex \
              (YYSTYPE * yylval_param , yyscan_t yyscanner)
#endif /* !YY_DECL */
...

Thanks,
Ian

> ---
>  tools/perf/util/Build          | 2 +-
>  tools/perf/util/expr.y         | 1 +
>  tools/perf/util/parse-events.y | 1 +
>  tools/perf/util/pmu.y          | 2 ++
>  4 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> index 918b501f9bd8..4a3ec6b0bbf6 100644
> --- a/tools/perf/util/Build
> +++ b/tools/perf/util/Build
> @@ -283,7 +283,7 @@ CFLAGS_expr-flex.o          +=3D $(flex_flags)
>  bison_flags :=3D -DYYENABLE_NLS=3D0
>  BISON_GE_35 :=3D $(shell expr $(shell $(BISON) --version | grep bison | =
sed -e 's/.\+ \([0-9]\+\).\([0-9]\+\)/\1\2/g') \>\=3D 35)
>  ifeq ($(BISON_GE_35),1)
> -  bison_flags +=3D -Wno-unused-parameter -Wno-nested-externs -Wno-implic=
it-function-declaration -Wno-switch-enum -Wno-unused-but-set-variable -Wno-=
unknown-warning-option
> +  bison_flags +=3D -Wno-unused-parameter -Wno-nested-externs -Wno-switch=
-enum -Wno-unused-but-set-variable -Wno-unknown-warning-option
>  else
>    bison_flags +=3D -w
>  endif
> diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
> index 635e562350c5..e5731da2e3d9 100644
> --- a/tools/perf/util/expr.y
> +++ b/tools/perf/util/expr.y
> @@ -53,6 +53,7 @@
>  %destructor { ids__free($$.ids); } <ids>
>
>  %{
> +int expr_lex(YYSTYPE *, void *);
>  static void expr_error(double *final_val __maybe_unused,
>                        struct expr_parse_ctx *ctx __maybe_unused,
>                        bool compute_ids __maybe_unused,
> diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-event=
s.y
> index be8c51770051..9dbab19885f3 100644
> --- a/tools/perf/util/parse-events.y
> +++ b/tools/perf/util/parse-events.y
> @@ -18,6 +18,7 @@
>  #include "parse-events.h"
>  #include "parse-events-bison.h"
>
> +int parse_events_lex(YYSTYPE *, YYLTYPE *, void *);
>  void parse_events_error(YYLTYPE *loc, void *parse_state, void *scanner, =
char const *msg);
>
>  #define ABORT_ON(val) \
> diff --git a/tools/perf/util/pmu.y b/tools/perf/util/pmu.y
> index e675d79a0274..8405f9e6535c 100644
> --- a/tools/perf/util/pmu.y
> +++ b/tools/perf/util/pmu.y
> @@ -16,6 +16,8 @@ do { \
>                  YYABORT; \
>  } while (0)
>
> +int perf_pmu_lex(void);
> +
>  %}
>
>  %token PP_CONFIG
>
> base-commit: 173ea743bf7a9eef04460e03b00ba267cc52aee2
>

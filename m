Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8C856EE70C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 19:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234782AbjDYRkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 13:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234904AbjDYRks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 13:40:48 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4CC615448
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 10:40:28 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-3ef34c49cb9so174501cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 10:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682444426; x=1685036426;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sE5LEcqfiBv4mIeB9VkSoLWTQxOUSgKZK6VAk/PRnk4=;
        b=3NrCpSc8/XjqneMXMYPytaKrcRh2J1hyXdu2y+FeJo+aweNmRyF90b2ESPl6XTLo9E
         6lXVSLg9q0MsIbLgf0v4+vj4tnFOJxWYMwZyEjy4Jq/wrRbI2rnyazjRMJrhsSQOotQG
         EeWFMblgWmTPZpKEXQLqTEiYUKHijxkudbMgPBN4DdnqYllXgleCoZ5lxRi28wOpvvnS
         fnNdKN7fGyIMhYl7LbAGO/6YWza6KFo2OMKPPLhExSg/ZsLyo8X1vug+/m08gtsI4IBk
         fvyg+UlEVSJnceQwRRz57yGhuxHqn9Pdt9oCrKHV31Xi5GOxiL4M23jg2gR1e2f04rCy
         Uzlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682444426; x=1685036426;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sE5LEcqfiBv4mIeB9VkSoLWTQxOUSgKZK6VAk/PRnk4=;
        b=k/T2GJtYApgfb049cit0NZYA6MxXCvYxv5T2MIGEiThGC5Lmyh/ylg26dAIOTUTALF
         geZYL5sfoNfY8MU5lu+b6yDBPxO7ygM5C+6hkoCqUtlFCbd1pdc/rv5fGT8gfIhiSaQ0
         0AFyKKDamoqY5GCaDaHbRo4lLGDpNdHtqdaiW7Ux+SzQcROFHHu/STTCFBs9jNLRQ2ii
         DKLsi8Lka2CVqbL95uZWXShBsVK5LmlQe8ew2RI500xIw4GJnjHQ+yOww6C1eHtV0n7s
         ZusoGJja4R8qHrzQta0UMSYC6iUTYslqhBomPoaytT1+SrW4pyuGxSBB+lRwN/eIH/Qw
         d4Rg==
X-Gm-Message-State: AAQBX9fnshCVL5wMTIZ301m7GtTvegBjO9uManTTsVm0pbqhp0Ssa1Z/
        Hnt/osU0ohtwmgY9133qE5Bw7YaIEBCZgf5tbhRNnA==
X-Google-Smtp-Source: AKy350a/le6QBqVasegHtBez39G12Z42IfmF3VOI7c6nqWUNFzt2dNc/wXcqZRx9VUsgldTI6aY0vYBIralDZjapjgw=
X-Received: by 2002:a05:622a:1822:b0:3ed:210b:e698 with SMTP id
 t34-20020a05622a182200b003ed210be698mr354819qtc.7.1682444425991; Tue, 25 Apr
 2023 10:40:25 -0700 (PDT)
MIME-Version: 1.0
References: <87sfcn7uot.fsf@oldenburg.str.redhat.com>
In-Reply-To: <87sfcn7uot.fsf@oldenburg.str.redhat.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 25 Apr 2023 10:40:14 -0700
Message-ID: <CAP-5=fXZv+KCdCN05wVUcAwDCZAgXjWunoaviGBQEiUPqNwOmg@mail.gmail.com>
Subject: Re: [PATCH v2] perf: Avoid implicit function declarations in
 lexer/parse interface
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

On Tue, Apr 25, 2023 at 10:12=E2=80=AFAM Florian Weimer <fweimer@redhat.com=
> wrote:
>
> In future compilers, -Wno-implicit-function-declaration may not bring
> back support for implicit function declarations, a feature that was
> removed from the C language in C99.  Instead of relying on implicit
> declarations, include the flex-generated header from the
> bison-generated C code.
>
> he expr-flex.h header needs to be included later than the others

nit: s/he/The/

> because at the early point, the definition of YYSTYPE is not yet
> available.
>
> Signed-off-by: Florian Weimer <fweimer@redhat.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks for fighting the build wrt parallel dependencies!
Ian

> ---
> v2: Include the flex-generated files instead of manually-written prototyp=
es.
>
>  tools/perf/util/Build          | 10 +++++++++-
>  tools/perf/util/expr.y         |  2 ++
>  tools/perf/util/parse-events.y |  1 +
>  tools/perf/util/pmu.y          |  1 +
>  4 files changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> index 918b501f9bd8..92897068c362 100644
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
> @@ -340,3 +340,11 @@ $(OUTPUT)util/vsprintf.o: ../lib/vsprintf.c FORCE
>  $(OUTPUT)util/list_sort.o: ../lib/list_sort.c FORCE
>         $(call rule_mkdir)
>         $(call if_changed_dep,cc_o_c)
> +
> +# These dependencies ensure that the flex-generated .h file is
> +# available at the time the bison-generated .c sources are compiled.
> +# Do not depend on the generated .h file to prevent triggering
> +# parallel flex invocations for the same two output files.
> +$(OUTPUT)util/expr-bison.o : $(OUTPUT)util/expr-flex.c
> +$(OUTPUT)util/parse-events-bison.o : $(OUTPUT)util/parse-events-flex.c
> +$(OUTPUT)util/pmu-bison.o : $(OUTPUT)util/pmu-flex.c
> diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
> index 635e562350c5..99581193ca4c 100644
> --- a/tools/perf/util/expr.y
> +++ b/tools/perf/util/expr.y
> @@ -53,6 +53,8 @@
>  %destructor { ids__free($$.ids); } <ids>
>
>  %{
> +#include "expr-flex.h"
> +
>  static void expr_error(double *final_val __maybe_unused,
>                        struct expr_parse_ctx *ctx __maybe_unused,
>                        bool compute_ids __maybe_unused,
> diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-event=
s.y
> index be8c51770051..67a7f70c4767 100644
> --- a/tools/perf/util/parse-events.y
> +++ b/tools/perf/util/parse-events.y
> @@ -17,6 +17,7 @@
>  #include "evsel.h"
>  #include "parse-events.h"
>  #include "parse-events-bison.h"
> +#include "parse-events-flex.h"
>
>  void parse_events_error(YYLTYPE *loc, void *parse_state, void *scanner, =
char const *msg);
>
> diff --git a/tools/perf/util/pmu.y b/tools/perf/util/pmu.y
> index e675d79a0274..2170f1ac7b74 100644
> --- a/tools/perf/util/pmu.y
> +++ b/tools/perf/util/pmu.y
> @@ -9,6 +9,7 @@
>  #include <linux/bitmap.h>
>  #include <string.h>
>  #include "pmu.h"
> +#include "pmu-flex.h"
>
>  #define ABORT_ON(val) \
>  do { \
>
> base-commit: 173ea743bf7a9eef04460e03b00ba267cc52aee2
>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA4672EC4D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 21:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjFMTuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 15:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240687AbjFMTuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 15:50:04 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74153B3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 12:50:03 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-3f9a81da5d7so60891cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 12:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686685802; x=1689277802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uiwK+c3shku5mREPjPPIbDPLp06FmfIkxVv/peYpdhg=;
        b=TnAAGQCbLALzkKEvlkhYbhXMQWZ4Ctqb6kwyvm4gDD4BLinxVQnGzj00bq7SwHwFNj
         4nUfooS3H/bkNjIAtogGygRqYR4UBhr7IuwpynnLZwvTtFWtX3H8SfBxKVVeu3OCc5UA
         t2AQJeLg8R+vtrcPQVn/vkOtleD9ztm1pJ5u49VY84/7hx1pSdqL2rKAvOex9sRaCLdw
         N5a5RLpgVvI1ZwCnR0dZtXvTKn3LWt+yFdqNNZYH7nM+Ww2srGlZf3VdWTZPG5B5umMk
         ADEbAHt2HkE98Czpkok7S0CMtniE+w5zdAbh3W5MfO1ka2NuEliH/RFa/S9rTg/X1Qzp
         0ZGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686685802; x=1689277802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uiwK+c3shku5mREPjPPIbDPLp06FmfIkxVv/peYpdhg=;
        b=buO8rr6Su+o3kef0SvWPrEIJneE2ud/8uS/ILeqbtPZqmHi3fM0SQ+HF574y6CrP/7
         14aEDJBdvzNVs9CVzUwJN8I9Rf0TK/ZS79tWk4adZxznc1mGQYK6tfuc/fAv57eRPDyS
         HDkboq7lDnHXSBBGg8KMfwBJmRhZ7XPBu9INNk7MJF6oCpYq3UAp4r4e2Wep9ettGjAg
         Th7JWxnlhk6zoNyQI8s+F+M+JImwPXE/6lahYLMT4sbr4fKGGvUKMC1ZbtBYFKr/8T3W
         Zf68ljlWoTDqICTHEFQMuFutc2o7ND85eyD8eNfp8k35pjTEBWCXtaUqMuYqg/jQCsJF
         QH7g==
X-Gm-Message-State: AC+VfDwx3/Px8ubG02MTmbEPPtbMnUyOZrIXq51B3v8kzaLUxzp9qtl7
        9wNRUpuq3d179N4YAhXjH9KN/Pdj7y1PRc34m5tcWA==
X-Google-Smtp-Source: ACHHUZ6E77oZrHBGCT+3cFfRXukoJ0ixAtMWb7//DIzfjXGb4cOr1QzOZAgC6CNJrGOT0pLplID6VDvqa33GJyRMqMA=
X-Received: by 2002:a05:622a:40d:b0:3f8:e0a:3e66 with SMTP id
 n13-20020a05622a040d00b003f80e0a3e66mr26083qtx.3.1686685802435; Tue, 13 Jun
 2023 12:50:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230613095506.547-1-ravi.bangoria@amd.com> <20230613095506.547-3-ravi.bangoria@amd.com>
In-Reply-To: <20230613095506.547-3-ravi.bangoria@amd.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 13 Jun 2023 12:49:50 -0700
Message-ID: <CAP-5=fUDng69kYZ5ecA_5FBKZWNxtMCUSM+BxO-7ndesG7xrvQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] perf tool x86: Consolidate is_amd check into single function
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     acme@kernel.org, jolsa@kernel.org, namhyung@kernel.org,
        mark.rutland@arm.com, peterz@infradead.org,
        adrian.hunter@intel.com, kan.liang@linux.intel.com,
        james.clark@arm.com, alisaidi@amazon.com, leo.yan@linaro.org,
        maddy@linux.ibm.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, sandipan.das@amd.com,
        ananth.narayan@amd.com, santosh.shukla@amd.com
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

On Tue, Jun 13, 2023 at 2:56=E2=80=AFAM Ravi Bangoria <ravi.bangoria@amd.co=
m> wrote:
>
> There are multiple places where x86 specific code determines AMD vs
> Intel arch and acts based on that. Consolidate those checks into a
> single function.
>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/arch/x86/util/Build        |  1 +
>  tools/perf/arch/x86/util/env.c        | 19 +++++++++++++++++++
>  tools/perf/arch/x86/util/env.h        |  7 +++++++
>  tools/perf/arch/x86/util/evsel.c      | 16 ++--------------
>  tools/perf/arch/x86/util/mem-events.c | 19 ++-----------------
>  5 files changed, 31 insertions(+), 31 deletions(-)
>  create mode 100644 tools/perf/arch/x86/util/env.c
>  create mode 100644 tools/perf/arch/x86/util/env.h
>
> diff --git a/tools/perf/arch/x86/util/Build b/tools/perf/arch/x86/util/Bu=
ild
> index 195ccfdef7aa..005907cb97d8 100644
> --- a/tools/perf/arch/x86/util/Build
> +++ b/tools/perf/arch/x86/util/Build
> @@ -10,6 +10,7 @@ perf-y +=3D evlist.o
>  perf-y +=3D mem-events.o
>  perf-y +=3D evsel.o
>  perf-y +=3D iostat.o
> +perf-y +=3D env.o
>
>  perf-$(CONFIG_DWARF) +=3D dwarf-regs.o
>  perf-$(CONFIG_BPF_PROLOGUE) +=3D dwarf-regs.o
> diff --git a/tools/perf/arch/x86/util/env.c b/tools/perf/arch/x86/util/en=
v.c
> new file mode 100644
> index 000000000000..33b87f8ac1cc
> --- /dev/null
> +++ b/tools/perf/arch/x86/util/env.c
> @@ -0,0 +1,19 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include "linux/string.h"
> +#include "util/env.h"
> +#include "env.h"
> +
> +bool x86__is_amd_cpu(void)
> +{
> +       struct perf_env env =3D { .total_mem =3D 0, };
> +       static int is_amd; /* 0: Uninitialized, 1: Yes, -1: No */
> +
> +       if (is_amd)
> +               goto ret;
> +
> +       perf_env__cpuid(&env);
> +       is_amd =3D env.cpuid && strstarts(env.cpuid, "AuthenticAMD") ? 1 =
: -1;
> +
> +ret:
> +       return is_amd >=3D 1 ? true : false;
> +}
> diff --git a/tools/perf/arch/x86/util/env.h b/tools/perf/arch/x86/util/en=
v.h
> new file mode 100644
> index 000000000000..d78f080b6b3f
> --- /dev/null
> +++ b/tools/perf/arch/x86/util/env.h
> @@ -0,0 +1,7 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _X86_ENV_H
> +#define _X86_ENV_H
> +
> +bool x86__is_amd_cpu(void);
> +
> +#endif /* _X86_ENV_H */
> diff --git a/tools/perf/arch/x86/util/evsel.c b/tools/perf/arch/x86/util/=
evsel.c
> index 25da46c8cca9..512c2d885d24 100644
> --- a/tools/perf/arch/x86/util/evsel.c
> +++ b/tools/perf/arch/x86/util/evsel.c
> @@ -8,6 +8,7 @@
>  #include "linux/string.h"
>  #include "evsel.h"
>  #include "util/debug.h"
> +#include "env.h"
>
>  #define IBS_FETCH_L3MISSONLY   (1ULL << 59)
>  #define IBS_OP_L3MISSONLY      (1ULL << 16)
> @@ -78,23 +79,10 @@ void arch__post_evsel_config(struct evsel *evsel, str=
uct perf_event_attr *attr)
>  {
>         struct perf_pmu *evsel_pmu, *ibs_fetch_pmu, *ibs_op_pmu;
>         static int warned_once;
> -       /* 0: Uninitialized, 1: Yes, -1: No */
> -       static int is_amd;
>
> -       if (warned_once || is_amd =3D=3D -1)
> +       if (warned_once || !x86__is_amd_cpu())
>                 return;
>
> -       if (!is_amd) {
> -               struct perf_env *env =3D evsel__env(evsel);
> -
> -               if (!perf_env__cpuid(env) || !env->cpuid ||
> -                   !strstarts(env->cpuid, "AuthenticAMD")) {
> -                       is_amd =3D -1;
> -                       return;
> -               }
> -               is_amd =3D 1;
> -       }
> -
>         evsel_pmu =3D evsel__find_pmu(evsel);
>         if (!evsel_pmu)
>                 return;
> diff --git a/tools/perf/arch/x86/util/mem-events.c b/tools/perf/arch/x86/=
util/mem-events.c
> index 32879d12a8d5..a8a782bcb121 100644
> --- a/tools/perf/arch/x86/util/mem-events.c
> +++ b/tools/perf/arch/x86/util/mem-events.c
> @@ -5,6 +5,7 @@
>  #include "map_symbol.h"
>  #include "mem-events.h"
>  #include "linux/string.h"
> +#include "env.h"
>
>  static char mem_loads_name[100];
>  static bool mem_loads_name__init;
> @@ -27,28 +28,12 @@ static struct perf_mem_event perf_mem_events_amd[PERF=
_MEM_EVENTS__MAX] =3D {
>         E("mem-ldst",   "ibs_op//",     "ibs_op"),
>  };
>
> -static int perf_mem_is_amd_cpu(void)
> -{
> -       struct perf_env env =3D { .total_mem =3D 0, };
> -
> -       perf_env__cpuid(&env);
> -       if (env.cpuid && strstarts(env.cpuid, "AuthenticAMD"))
> -               return 1;
> -       return -1;
> -}
> -
>  struct perf_mem_event *perf_mem_events__ptr(int i)
>  {
> -       /* 0: Uninitialized, 1: Yes, -1: No */
> -       static int is_amd;
> -
>         if (i >=3D PERF_MEM_EVENTS__MAX)
>                 return NULL;
>
> -       if (!is_amd)
> -               is_amd =3D perf_mem_is_amd_cpu();
> -
> -       if (is_amd =3D=3D 1)
> +       if (x86__is_amd_cpu())
>                 return &perf_mem_events_amd[i];
>
>         return &perf_mem_events_intel[i];
> --
> 2.40.1
>

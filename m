Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0574A72E725
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 17:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241357AbjFMP0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 11:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242900AbjFMP0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 11:26:13 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801661BEB
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 08:26:10 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-3f9a81da5d7so293221cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 08:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686669969; x=1689261969;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SGcsTjigiwsVCHhce7TrLNCGSp3EdOdru0xINbTB9k4=;
        b=f5TKtpmTN9wf7BKxj6Uajjmt5oxcxBG4/knBASSpMcFt//NbRtP/z1Lg+NYOoRocKf
         uHoZuwJzvPZqeEoniwzYWx1FE99oJEfR37uviUCbs3cSDRqmOnSfoqNmP/gRHEFvJZiu
         VthOAu6laAUoPz4in9VIBxUyi5ggwP8wnRejBGedJ1KLMSuUsnGeE3uUgJC1S89sQdfW
         1w71MQMQBV9gHBBb5Vb311u9PzsGhvwjetweYlHGizEhUT41p5qVxFBreUPATE5/0Rmr
         g5xii4u641utrKTeirKfaGrAst4laGTACW2E8Hv98dRSPvUKMiHoi6Hs1wyo/88npeNL
         rvBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686669969; x=1689261969;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SGcsTjigiwsVCHhce7TrLNCGSp3EdOdru0xINbTB9k4=;
        b=U4chEsZ4xuhYcoOxz3fJt2Ex4Ll50eb2j5RSkBEnlvBNIN2khw69bZLfebaM6V8R6w
         0+b43Hd+QtCna6QVdk+9RKXyELTXq+crtT/iTLhiIO3Tv95y685qCPHC/U7LxQz3CZlC
         HWk+A8uhF0vM023zN+Mw5ZHitioex44oPyonRwtun5X1bOTZyqmGsoMebmFfeTRx1c7/
         3yYu9xUW4wxlWSByRqruUYKUxdliWSMy4DB8qQhpLUjlinUN5Ax5c9O7PvR7m/LwEWV2
         ZhcN/bEL7KIGAC1hGZzdHZ+Xlh+jJNzXEav2RHboBIPJQZXF+o1QvtfW98Rb8hu4XIje
         3GIg==
X-Gm-Message-State: AC+VfDwsIAUARVEu5UgpAXSSVmb1NJQQ4HOd3ojc+c3ItopTAEVCp1Qj
        rOqRB7Z2eqyurIpxK+tH4xT1JSyczEzg4vY97HKpZg==
X-Google-Smtp-Source: ACHHUZ5Z4kvR+02A8wyJ6TdV6v5xPpAhjbhwmXGnjDl3xuFuioDV2sog3K1wSVuWftI69WmSKIKd4r0sXNJt6SjvyXs=
X-Received: by 2002:a05:622a:46:b0:3f9:b8c2:f2d3 with SMTP id
 y6-20020a05622a004600b003f9b8c2f2d3mr96993qtw.19.1686669969458; Tue, 13 Jun
 2023 08:26:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230613095506.547-1-ravi.bangoria@amd.com> <20230613095506.547-4-ravi.bangoria@amd.com>
In-Reply-To: <20230613095506.547-4-ravi.bangoria@amd.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 13 Jun 2023 08:25:58 -0700
Message-ID: <CAP-5=fW0R2Dkwvw0twdzL5GrLy6jy0CXmFHYCsZtC8UQnZ4mVQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] perf mem amd: Fix perf_pmus__num_mem_pmus()
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
> AMD cpus does not contain hybrid cores. Also, perf mem/c2c on AMD
> internally uses IBS OP PMU, not the core PMU.
>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> ---
>  tools/perf/arch/x86/util/pmu.c | 15 +++++++++++++++
>  tools/perf/util/pmus.c         |  2 +-
>  2 files changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/util/pm=
u.c
> index 3c0de3370d7e..8a20d28d9927 100644
> --- a/tools/perf/arch/x86/util/pmu.c
> +++ b/tools/perf/arch/x86/util/pmu.c
> @@ -14,6 +14,8 @@
>  #include "../../../util/intel-bts.h"
>  #include "../../../util/pmu.h"
>  #include "../../../util/fncache.h"
> +#include "../../../util/pmus.h"
> +#include "env.h"
>
>  struct pmu_alias {
>         char *name;
> @@ -168,3 +170,16 @@ char *pmu_find_alias_name(const char *name)
>
>         return __pmu_find_alias_name(name);
>  }
> +
> +int perf_pmus__num_mem_pmus(void)
> +{
> +       /*
> +        * AMD does not have hybrid cores and also uses IBS OP
> +        * pmu for perf mem/c2c.
> +        */
> +       if (x86__is_amd_cpu())
> +               return 1;

The code and comment seem out of sync here. For the hybrid part
perf_pmus__num_core_pmus() will yield 1 if there is no hybrid, so we
can just use perf_pmus__num_core_pmus(). For the IBS OP part, does
that mean that AMD should have 2 mem pmus? Or is IBS OP a core PMU?
Can we add this as an example in the core/other documentation in patch
1, as you've done for ARM, for clarity.

Thanks,
Ian

> +
> +       /* Intel uses core pmus for perf mem/c2c */
> +       return perf_pmus__num_core_pmus();
> +}
> diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
> index e505d2fef828..0ed943932945 100644
> --- a/tools/perf/util/pmus.c
> +++ b/tools/perf/util/pmus.c
> @@ -240,7 +240,7 @@ const struct perf_pmu *perf_pmus__pmu_for_pmu_filter(=
const char *str)
>         return NULL;
>  }
>
> -int perf_pmus__num_mem_pmus(void)
> +int __weak perf_pmus__num_mem_pmus(void)
>  {
>         /* All core PMUs are for mem events. */
>         return perf_pmus__num_core_pmus();
> --
> 2.40.1
>

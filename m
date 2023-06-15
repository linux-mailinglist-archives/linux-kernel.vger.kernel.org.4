Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76F08730EFE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 08:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243546AbjFOGDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 02:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243468AbjFOGCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 02:02:39 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6642706
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 23:02:24 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id e9e14a558f8ab-3409d944009so95245ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 23:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686808944; x=1689400944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FRupDGzcteqnPXSd6H5J8n7N0z7on34qMKZKjt9pAoo=;
        b=dbxYDd6CmvA/LSSCiKJfyhUXM1aorCs+8k748It2a4+/XEiiJwoPWoXjr7VjkiRJGB
         S7uLbNuKPrd75REmMqDUV8epf4jhZYxY3EFQIOEIV3Xjwo841LKtmQRSvYuUBaU+OP9T
         VHR9u2rXNMr02vw7PAVGpKKy5+BEWUNRLHnkdRuR8WpJtX8E5dHp6w0tLe0wMi5VTq40
         PvGXeNWqJreu4QVcqKc2rkheir+IBNcja+5wkESZm/ltW5eeKMy+AzUp5LpU46Hb2E61
         TdcXnnyDWJbOCLclwAz0AbDTkV3VMmgsh/XOOllT1Q3O4O8cdpLeuttkEhMJsylMxm+G
         bidQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686808944; x=1689400944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FRupDGzcteqnPXSd6H5J8n7N0z7on34qMKZKjt9pAoo=;
        b=Qg//Vdy7TNb7E+27upbEfaTDefLOOxFnsGwciLk4Fe8dtb11j6jjwIKtziDCbb9pz4
         7F0uUor/yllnSan9Vdxo4HOiwQoZ37dw0SdQ5AWEutNqfM1v0ph94PyxmdNjxnpseS7M
         WaG36MbgJ2wUTiw+L0baWYXhqxNpB6HqDZjrAZ5fwK1cOolhg1dyz1+DWNDpchzQaAgI
         O3ndMnV4/wwLwpqnkAeLeZ2efUFGcLPMo/zWEj8vHlkkMe0q8U5GMrP244Of6v5LuK3O
         1SGTja7HKxNhGRCOjCQsMCFpdVGMAjwy8xS8t3tt/uuv5/70dQ2fylesenQ+/7Wpz6Ck
         Koew==
X-Gm-Message-State: AC+VfDyGT1LvJhSLEoIDeAQJ2iVgLNvJtJIIxJ/bVOxuvhsDlDzf1rZN
        9PZyjg48IL+dmGJbTT3CqRgxw1seRrQ5047c+p+TTA==
X-Google-Smtp-Source: ACHHUZ54un10oa7v0GDX8DjzPpJxHFFBm/9QmTG1vovZ/1lPKU99LeEoIcdf0J8kCVFqZrJQ0Yc8argaNiLBPww0G+8=
X-Received: by 2002:a05:6e02:152d:b0:337:c28c:3d0f with SMTP id
 i13-20020a056e02152d00b00337c28c3d0fmr169676ilu.6.1686808944230; Wed, 14 Jun
 2023 23:02:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230615051700.1833-1-ravi.bangoria@amd.com> <20230615051700.1833-3-ravi.bangoria@amd.com>
In-Reply-To: <20230615051700.1833-3-ravi.bangoria@amd.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 14 Jun 2023 23:02:12 -0700
Message-ID: <CAP-5=fWkzHufJXV-iRAGifv_z11AOc5LKOyL-QvYL_N+gSPvzw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] perf mem amd: Fix perf_pmus__num_mem_pmus()
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     acme@kernel.org, jolsa@kernel.org, namhyung@kernel.org,
        peterz@infradead.org, james.clark@arm.com, alisaidi@amazon.com,
        leo.yan@linaro.org, adrian.hunter@intel.com,
        kan.liang@linux.intel.com, mark.rutland@arm.com,
        maddy@linux.ibm.com, tmricht@linux.ibm.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandipan.das@amd.com, ananth.narayan@amd.com,
        santosh.shukla@amd.com
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

On Wed, Jun 14, 2023 at 10:18=E2=80=AFPM Ravi Bangoria <ravi.bangoria@amd.c=
om> wrote:
>
> perf mem/c2c on AMD internally uses IBS OP PMU, not the core PMU. Also,
> AMD platforms does not have heterogeneous PMUs.
>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> ---
>  tools/perf/arch/x86/util/pmu.c | 12 ++++++++++++
>  tools/perf/util/pmus.c         |  2 +-
>  2 files changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/util/pm=
u.c
> index 3c0de3370d7e..f3534a791e79 100644
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
> @@ -168,3 +170,13 @@ char *pmu_find_alias_name(const char *name)
>
>         return __pmu_find_alias_name(name);
>  }
> +
> +int perf_pmus__num_mem_pmus(void)
> +{
> +       /* AMD uses IBS OP pmu for perf mem/c2c */

nit: could we just add:
AMD uses IBS OP pmu and not a core PMU for perf mem/c2c

Thanks,
Ian

> +       if (x86__is_amd_cpu())
> +               return 1;
> +
> +       /* Intel uses core pmus for perf mem/c2c */
> +       return perf_pmus__num_core_pmus();
> +}
> diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
> index 8c50ab8894b7..a2032c1b7644 100644
> --- a/tools/perf/util/pmus.c
> +++ b/tools/perf/util/pmus.c
> @@ -242,7 +242,7 @@ const struct perf_pmu *perf_pmus__pmu_for_pmu_filter(=
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

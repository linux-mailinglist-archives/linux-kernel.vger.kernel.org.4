Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF10688CA9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 02:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbjBCBlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 20:41:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231903AbjBCBlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 20:41:39 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C8D87594
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 17:41:36 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id y1so3403485wru.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 17:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rothOJAx61IhY6WBzLgJ0pLvV1L69tGtBH8EM756NO8=;
        b=JGGtJ43mQQSjD5iDplV0TKr5vkx/VXre07uHn16ZwJoqK0iPdnRFzazXeDBOc7drVf
         iA0hyjJJhKMHtfH3J1Dlkupz5f3mvNhyF4tWWBBqrdkFifGWfW9vpiP1LYtm1tANuk5x
         CDkTWs5aoqcOApygErzXmNuu4KVA8GufFtqBRQC7GQDvOiJnodRDgjgOpWpiY69JlNvB
         hDUGM9TfhF2P6C/nUPpC3ICMfxp6eOUe40TgBJKFqZfK5ZUtLJYNCc+2Ua8JNjpE5nZD
         DOTe6XGkYm+xIa2VVRfMFDypR9RQhzOvDmr5R+sFK2m6siyVBbM+pn0sDza4ltIdKkYe
         /KRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rothOJAx61IhY6WBzLgJ0pLvV1L69tGtBH8EM756NO8=;
        b=jihXtveia3plIEQjF6wRdl0vhyr/armD1OSVHlJt9d2UBVi13V+TZwvz74YBHl8si0
         kf6EAVgy4SvIRynQYLKyI+HyXr8LYtVTy6U1eKD09sLaCUT4CUEJpK3zdgkGhQDm+KLV
         K3JiPFQzXx1GnXaine9y6d0pzYFwK4+zb1Y3AKqwiR6oa6G84dnosQC46vc9xRREzoGI
         M8+FuoRXIz/+w/HImSj4gSoTEnxEiTnauoF9VCtXcRqjVfGvtqch0HDOCDsjGPsKfrdf
         N2lK3tOIKGN4yy3IBeekH0MJ//4VeTxF8ntfgRuBN/qUET/Fxfc4U1JCKCZFtgxunKX0
         LYzw==
X-Gm-Message-State: AO0yUKXr6PxAs3AOPulYQe0YvTGvcFc/Qj+5t3vwtEf6wGpIqQAN4hN9
        bqlgvO2vL9Dv24W7QN9cxQHUUEcVI6ruyXi/ana9EA==
X-Google-Smtp-Source: AK7set9KcFxcgBgOvFlB4117j0vmSRXNYNO65A30gArABQfkcUEfrN38aSMQU2A/k5B0ndvaCL9HCt0EhVPjdSUZ6Oc=
X-Received: by 2002:adf:e351:0:b0:2bf:eba5:b652 with SMTP id
 n17-20020adfe351000000b002bfeba5b652mr196573wrj.19.1675388494864; Thu, 02 Feb
 2023 17:41:34 -0800 (PST)
MIME-Version: 1.0
References: <20230203014014.75720-1-irogers@google.com>
In-Reply-To: <20230203014014.75720-1-irogers@google.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 2 Feb 2023 17:41:22 -0800
Message-ID: <CAP-5=fX0ohsCUspm7NowDy2bmSr2cJfp=iaStK4EAdVy7zBHGA@mail.gmail.com>
Subject: Re: [PATCH v1] perf pmu: Fix aarch64 build
To:     John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        Kang Minchul <tegongkang@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sandipan Das <sandipan.das@amd.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        linuxppc-dev@lists.ozlabs.org, Kajol Jain <kjain@linux.ibm.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 2, 2023 at 5:40 PM Ian Rogers <irogers@google.com> wrote:
>
> ARM64 overrides a weak function but a previous change had broken the
> build.
>
> Fixes: 8cefeb8bd336 ("perf pmu-events: Introduce pmu_metrics_table")

As 8cefeb8bd336 ("perf pmu-events: Introduce pmu_metrics_table") is
only on tmp.perf/core then it may be best to just squash this fix into
that.

Thanks,
Ian

> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/arch/arm64/util/pmu.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/perf/arch/arm64/util/pmu.c b/tools/perf/arch/arm64/util/pmu.c
> index 2779840d8896..fa143acb4c8d 100644
> --- a/tools/perf/arch/arm64/util/pmu.c
> +++ b/tools/perf/arch/arm64/util/pmu.c
> @@ -22,6 +22,8 @@ static struct perf_pmu *pmu__find_core_pmu(void)
>                         return NULL;
>
>                 return pmu;
> +       }
> +       return NULL;
>  }
>
>  const struct pmu_metrics_table *pmu_metrics_table__find(void)
> --
> 2.39.1.519.gcb327c4b5f-goog
>

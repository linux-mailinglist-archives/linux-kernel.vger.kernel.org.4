Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CADE1654E65
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 10:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236140AbiLWJ3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 04:29:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbiLWJ3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 04:29:11 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBDF037216
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 01:29:08 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id n3so2961812pfq.10
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 01:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0c5uQIzUMFPTSbbQ86A0yRd8TLwSNBpE9O+juif18EE=;
        b=ixRPnZh7PBuHquRZp04QddLNm57wOmg8Jkw8bStWz28mynaiinHw0I/GLjIbjsiszz
         2JAj2NStes/sKiGN4N4RxWPrwjN/QOhWky89xdRaLyWpdQIbzFfpVtT94Ex4SWb/L5qG
         ynoh8LxGEIM7CwUU5lB1Biz0qsDCr7RfNe4MbuKQX9jUY50jr2NJahJtmbIQwlyM/NIp
         pxDe/OFzDmvygaqHFSd/GBE0oqCcf0rbumt5mR8R599q6qiOhnGztxLEjUjbOuVufj0M
         mLM640szQA7wCYTGuP5yPKZFEXsJkelc6fEaZzViDjO4FN6gFrrAawYAiyGUScV+xbsz
         Ub+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0c5uQIzUMFPTSbbQ86A0yRd8TLwSNBpE9O+juif18EE=;
        b=293xk67uk2wKi0kg30gHt0Ovxm5Odf96B+QVTAm6+wok/H6hjuweMm0GCcUzyX+VV+
         q/ht6FgXC+RoekmRnSZODIW2fs2nPGR+SrMrtW0yd37HqAVHxNDLCNUzE646zUDfrcf4
         6rVoYacvlEFqgPaKurrJyIozGLKkCd5qgL41s5CILKjKNoUV0YW6hYwiYHaXtZxta5Uv
         Mxb/Hs06iyPfQk2rZMeQJMvsrjDc+OVkSp5hVB0V3ub21hyCTyRXRpWGpYfX6YBfJPGe
         rQ7jgQiSJk7L04KvprnWdhBYTkDeJJOZRLOAREB50t0dilJ2AqfAQb+UNUUYkTP/BJM8
         yOLg==
X-Gm-Message-State: AFqh2kpXuo7X7+Ev90V/kj9xdz8ndOHNKTEVsLae2FGACp+WApp5OlbL
        6GqhPa8WVNjm+7hx6Eq2iX8Wlka1/Zaa5bj/Br2gPQ==
X-Google-Smtp-Source: AMrXdXuP5EyB+7hlNutRLuRJZ7C40I8tzH0xlF3Htp+vW28V6P245fhBRr9zDQo8gOhUG7c6p+rJKRmcloJESxOXfo0=
X-Received: by 2002:a62:64cd:0:b0:56b:94f5:400c with SMTP id
 y196-20020a6264cd000000b0056b94f5400cmr552324pfb.31.1671787748255; Fri, 23
 Dec 2022 01:29:08 -0800 (PST)
MIME-Version: 1.0
References: <20221222160328.3639989-1-james.clark@arm.com> <20221222160328.3639989-7-james.clark@arm.com>
In-Reply-To: <20221222160328.3639989-7-james.clark@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Fri, 23 Dec 2022 09:28:56 +0000
Message-ID: <CAJ9a7VjbF2DFRHOtdCt=3o+iNrA++swpJBx9v5-R9Ky8tc4Mvw@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] perf cs_etm: Record ts_source in AUXTRACE_INFO for
 ETMv4 and ETE
To:     James Clark <james.clark@arm.com>
Cc:     linux-perf-users@vger.kernel.org, tanmay@marvell.com,
        sgoutham@marvell.com, gcherian@marvell.com, lcherian@marvell.com,
        bbhushan2@marvell.com, German Gomez <german.gomez@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

There was a discussion some time ago in one of our coresight regular
dev meetings about this.

Can we just use only the necessary bits that TS source needs and leave
the remaining bits from the 64 as unused  for future expansion - i..e
use this as a bitfield rather than have 64 bits occupied for what is
effectively a 2 bit value.

Perhaps call the full value something other than TS_SOURCE and have a
TS_SOURCE field with a known safe unset value.

Thanks

Mike

On Thu, 22 Dec 2022 at 16:07, James Clark <james.clark@arm.com> wrote:
>
> From: German Gomez <german.gomez@arm.com>
>
> Read the value of ts_source exposed by the driver and store it in the
> ETMv4 and ETE header. If the interface doesn't exist (such as in older
> Kernels), defaults to a safe value of -1.
>
> Signed-off-by: German Gomez <german.gomez@arm.com>
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  tools/perf/arch/arm/util/cs-etm.c | 48 +++++++++++++++++++++++++++++++
>  tools/perf/util/cs-etm-base.c     |  2 ++
>  tools/perf/util/cs-etm.h          |  2 ++
>  3 files changed, 52 insertions(+)
>
> diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
> index b526ffe550a5..481e170cd3f1 100644
> --- a/tools/perf/arch/arm/util/cs-etm.c
> +++ b/tools/perf/arch/arm/util/cs-etm.c
> @@ -53,6 +53,7 @@ static const char * const metadata_etmv4_ro[] = {
>         [CS_ETMV4_TRCIDR2]              = "trcidr/trcidr2",
>         [CS_ETMV4_TRCIDR8]              = "trcidr/trcidr8",
>         [CS_ETMV4_TRCAUTHSTATUS]        = "mgmt/trcauthstatus",
> +       [CS_ETMV4_TS_SOURCE]            = "ts_source",
>  };
>
>  static const char * const metadata_ete_ro[] = {
> @@ -62,6 +63,7 @@ static const char * const metadata_ete_ro[] = {
>         [CS_ETE_TRCIDR8]                = "trcidr/trcidr8",
>         [CS_ETE_TRCAUTHSTATUS]          = "mgmt/trcauthstatus",
>         [CS_ETE_TRCDEVARCH]             = "mgmt/trcdevarch",
> +       [CS_ETE_TS_SOURCE]              = "ts_source",
>  };
>
>  static bool cs_etm_is_etmv4(struct auxtrace_record *itr, int cpu);
> @@ -613,6 +615,32 @@ static int cs_etm_get_ro(struct perf_pmu *pmu, int cpu, const char *path)
>         return val;
>  }
>
> +static int cs_etm_get_ro_signed(struct perf_pmu *pmu, int cpu, const char *path)
> +{
> +       char pmu_path[PATH_MAX];
> +       int scan;
> +       int val = 0;
> +
> +       /* Get RO metadata from sysfs */
> +       snprintf(pmu_path, PATH_MAX, "cpu%d/%s", cpu, path);
> +
> +       scan = perf_pmu__scan_file(pmu, pmu_path, "%d", &val);
> +       if (scan != 1)
> +               pr_err("%s: error reading: %s\n", __func__, pmu_path);
> +
> +       return val;
> +}
> +
> +static bool cs_etm_pmu_path_exists(struct perf_pmu *pmu, int cpu, const char *path)
> +{
> +       char pmu_path[PATH_MAX];
> +
> +       /* Get RO metadata from sysfs */
> +       snprintf(pmu_path, PATH_MAX, "cpu%d/%s", cpu, path);
> +
> +       return perf_pmu__file_exists(pmu, pmu_path);
> +}
> +
>  #define TRCDEVARCH_ARCHPART_SHIFT 0
>  #define TRCDEVARCH_ARCHPART_MASK  GENMASK(11, 0)
>  #define TRCDEVARCH_ARCHPART(x)    (((x) & TRCDEVARCH_ARCHPART_MASK) >> TRCDEVARCH_ARCHPART_SHIFT)
> @@ -654,6 +682,16 @@ static void cs_etm_save_etmv4_header(__u64 data[], struct auxtrace_record *itr,
>                                                metadata_etmv4_ro[CS_ETMV4_TRCIDR8]);
>         data[CS_ETMV4_TRCAUTHSTATUS] = cs_etm_get_ro(cs_etm_pmu, cpu,
>                                                      metadata_etmv4_ro[CS_ETMV4_TRCAUTHSTATUS]);
> +
> +       /* Kernels older than 5.19 may not expose ts_source */
> +       if (cs_etm_pmu_path_exists(cs_etm_pmu, cpu, metadata_etmv4_ro[CS_ETMV4_TS_SOURCE]))
> +               data[CS_ETMV4_TS_SOURCE] = (__u64) cs_etm_get_ro_signed(cs_etm_pmu, cpu,
> +                               metadata_etmv4_ro[CS_ETMV4_TS_SOURCE]);
> +       else {
> +               pr_warning("[%03d] pmu file 'ts_source' not found. Fallback to safe value (-1)\n",
> +                          cpu);
> +               data[CS_ETMV4_TS_SOURCE] = (__u64) -1;
> +       }
>  }
>
>  static void cs_etm_save_ete_header(__u64 data[], struct auxtrace_record *itr, int cpu)
> @@ -679,6 +717,16 @@ static void cs_etm_save_ete_header(__u64 data[], struct auxtrace_record *itr, in
>         /* ETE uses the same registers as ETMv4 plus TRCDEVARCH */
>         data[CS_ETE_TRCDEVARCH] = cs_etm_get_ro(cs_etm_pmu, cpu,
>                                                 metadata_ete_ro[CS_ETE_TRCDEVARCH]);
> +
> +       /* Kernels older than 5.19 may not expose ts_source */
> +       if (cs_etm_pmu_path_exists(cs_etm_pmu, cpu, metadata_ete_ro[CS_ETE_TS_SOURCE]))
> +               data[CS_ETE_TS_SOURCE] = (__u64) cs_etm_get_ro_signed(cs_etm_pmu, cpu,
> +                               metadata_ete_ro[CS_ETE_TS_SOURCE]);
> +       else {
> +               pr_warning("[%03d] pmu file 'ts_source' not found. Fallback to safe value (-1)\n",
> +                          cpu);
> +               data[CS_ETE_TS_SOURCE] = (__u64) -1;
> +       }
>  }
>
>  static void cs_etm_get_metadata(int cpu, u32 *offset,
> diff --git a/tools/perf/util/cs-etm-base.c b/tools/perf/util/cs-etm-base.c
> index 282042c6e944..5f48b756c4cf 100644
> --- a/tools/perf/util/cs-etm-base.c
> +++ b/tools/perf/util/cs-etm-base.c
> @@ -36,6 +36,7 @@ static const char * const cs_etmv4_priv_fmts[] = {
>         [CS_ETMV4_TRCIDR2]      = "     TRCIDR2                        %llx\n",
>         [CS_ETMV4_TRCIDR8]      = "     TRCIDR8                        %llx\n",
>         [CS_ETMV4_TRCAUTHSTATUS] = "    TRCAUTHSTATUS                  %llx\n",
> +       [CS_ETMV4_TS_SOURCE]    = "     TS_SOURCE                      %lld\n",
>  };
>
>  static const char * const cs_ete_priv_fmts[] = {
> @@ -50,6 +51,7 @@ static const char * const cs_ete_priv_fmts[] = {
>         [CS_ETE_TRCIDR8]        = "     TRCIDR8                        %llx\n",
>         [CS_ETE_TRCAUTHSTATUS]  = "     TRCAUTHSTATUS                  %llx\n",
>         [CS_ETE_TRCDEVARCH]     = "     TRCDEVARCH                     %llx\n",
> +       [CS_ETE_TS_SOURCE]      = "     TS_SOURCE                      %lld\n",
>  };
>
>  static const char * const param_unk_fmt =
> diff --git a/tools/perf/util/cs-etm.h b/tools/perf/util/cs-etm.h
> index c5925428afa9..ad790930bcbc 100644
> --- a/tools/perf/util/cs-etm.h
> +++ b/tools/perf/util/cs-etm.h
> @@ -71,6 +71,7 @@ enum {
>         CS_ETMV4_TRCIDR2,
>         CS_ETMV4_TRCIDR8,
>         CS_ETMV4_TRCAUTHSTATUS,
> +       CS_ETMV4_TS_SOURCE,
>         CS_ETMV4_PRIV_MAX,
>  };
>
> @@ -92,6 +93,7 @@ enum {
>         CS_ETE_TRCIDR8,
>         CS_ETE_TRCAUTHSTATUS,
>         CS_ETE_TRCDEVARCH,
> +       CS_ETE_TS_SOURCE,
>         CS_ETE_PRIV_MAX
>  };
>
> --
> 2.25.1
>


-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK

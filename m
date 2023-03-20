Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C18946C1EAB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 18:57:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbjCTR5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 13:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbjCTR5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 13:57:01 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A5CB2FCCC
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 10:51:56 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-3e0965f70ecso201411cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 10:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679334636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yoD1JKY0k161o4QHbzp4GglNNV3tuJfP9sIdaBe/tSQ=;
        b=LuOXElhkL5uV0fqt/FiMZBnMP0RcQQ1EwDqAJ4PkZckn2UxZng/S/rmcHgZKAwLKrz
         2pmile5FUYUJrxnXkOmRyqD1FMn+IaR7TmUgMchApZb6n3gteLagbDK1gA7cdAJOhtUP
         33vxu5Dnvn0CzWPDePl7jV0rBZzoTsw9Ag++n0IKkVlWyLlHq/+O41VOV4z3ljQ8BtDb
         GqyJlrNZsarrBULnUuSZ8Noy+jPMKmFqcVvT5cBcLFyDVNg4u/FlwJq8ft7vWUwqi1Dl
         Z5/s22a9dsX+weBQMWhRWuTtsHtrPG3Mvj1ECudidhhQar1A9gg7gp7V8wIrUFdXGn0V
         4LHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679334636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yoD1JKY0k161o4QHbzp4GglNNV3tuJfP9sIdaBe/tSQ=;
        b=5BKE2YbMcr6/JzfLmAPhagIT2Su/W0sYygbO58o8yUpLG6+pCrAaK5QetbdZ1Tsw8b
         1hwEkHZcGa9mI0Ro3jb4Ria19aa5rvyFD0DP3QG8g8kq/URPtsnfhOtOnCeWvS+/GjEr
         SejSw2LvdEKaAkiRl0gGi5U9p1Uvmn8CWDp/DeN47YDILQ1D5WH7lalblldIjIn/8/c4
         vmbh1q2+bQrljiypezV5NPV3+zIyZ1Q9sG2ZemS+04FF9KhPFVrFI4Zdnd0Y9s7AR+KX
         FTC8Z6ZhpiN6mULHaoMn92oL5Erk9SiO0ODwYNrK7vprTUPVXhVShhwx+4Od4+YgV7P6
         MohA==
X-Gm-Message-State: AO0yUKVqri4O3ULhhGLhzUp5yB4AZTlIOVydvnODVaNnit0cI+5nkSAE
        sWeDNER5jpspdeP12OJ4+tvC8vKS+GdQaVmUqj3Hpw==
X-Google-Smtp-Source: AK7set8kHEVP+t6ZHXZFLaxn+nBauLfQe1PZ5kpaSUhxq1eSagWU8CZHLMeGMlCta7rcc0LYB6zlLiF1Y7styXAdznM=
X-Received: by 2002:a05:622a:1ba3:b0:3e2:3de:371f with SMTP id
 bp35-20020a05622a1ba300b003e203de371fmr242217qtb.15.1679334636095; Mon, 20
 Mar 2023 10:50:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230320151509.1137462-1-james.clark@arm.com> <20230320151509.1137462-5-james.clark@arm.com>
In-Reply-To: <20230320151509.1137462-5-james.clark@arm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 20 Mar 2023 10:50:24 -0700
Message-ID: <CAP-5=fXan9Lvy-==HAdWxJ016StbzXY=jT=PC2oQz7VFGzthyQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] perf report: Add 'simd' sort field
To:     James Clark <james.clark@arm.com>
Cc:     linux-perf-users@vger.kernel.org, Anshuman.Khandual@arm.com,
        German Gomez <german.gomez@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Mar 20, 2023 at 8:15=E2=80=AFAM James Clark <james.clark@arm.com> w=
rote:
>
> From: German Gomez <german.gomez@arm.com>
>
> Add 'simd' sort field to visualize SIMD ops in perf-report.
>
> Rows are labeled with the SIMD isa, and the type of predicate (if any):
>
>   - [p] partial predicate
>   - [e] empty predicate (no elements in the vector being used)
>
> Example with Arm SPE and SVE (Scalable Vector Extension):
>
>   #include <arm_sve.h>
>
>   double src[1025], dst[1025];
>
>   int main(void) {
>     svfloat64_t vc =3D svdup_f64(1);
>     for(;;)
>       for(int i =3D 0; i < 1025; i +=3D svcntd())
>       {
>         svbool_t pg =3D svwhilelt_b64(i, 1025);
>         svfloat64_t vsrc =3D svld1(pg, &src[i]);
>         svfloat64_t vdst =3D svadd_x(pg, vsrc, vc);
>         svst1(pg, &dst[i], vdst);
>       }
>     return 0;
>   }
>
>   ... compiled using "gcc-11 -march=3Darmv8-a+sve -O3"
>
> Profiling on a platform that implements FEAT_SVE and FEAT_SPEv1p1:
>
>   $ perf record -e arm_spe_0// -- ./a.out
>   $ perf report --itrace=3Di1i -s overhead,pid,simd,sym
>
>   Overhead      Pid:Command   Simd     Symbol
>   ........  ................  .......  ......................
>
>     53.76%    10758:program            [.] main
>     46.14%    10758:program   [.] SVE  [.] main
>      0.09%    10758:program   [p] SVE  [.] main
>
> The report shows 0.09% of the sampled SVE operations use partial
> predicates due to src and dst arrays not being multiples of the vector
> register lengths.
>
> Signed-off-by: German Gomez <german.gomez@arm.com>
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  tools/perf/Documentation/perf-report.txt |  1 +
>  tools/perf/util/hist.c                   |  1 +
>  tools/perf/util/hist.h                   |  1 +
>  tools/perf/util/sort.c                   | 47 ++++++++++++++++++++++++
>  tools/perf/util/sort.h                   |  2 +
>  5 files changed, 52 insertions(+)
>
> diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Docume=
ntation/perf-report.txt
> index c242e8da6b1a..cfd502f7e6da 100644
> --- a/tools/perf/Documentation/perf-report.txt
> +++ b/tools/perf/Documentation/perf-report.txt
> @@ -117,6 +117,7 @@ OPTIONS
>         - addr: (Full) virtual address of the sampled instruction
>         - retire_lat: On X86, this reports pipeline stall of this instruc=
tion compared
>           to the previous instruction in cycles. And currently supported =
only on X86
> +       - simd: Flags describing a SIMD operation. "e" for empty Arm SVE =
predicate. "p" for partial Arm SVE predicate

nit: the line wrap looks off here.

Thanks,
Ian

>
>         By default, comm, dso and symbol keys are used.
>         (i.e. --sort comm,dso,symbol)
> diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
> index 3670136a0074..0c11f50abfec 100644
> --- a/tools/perf/util/hist.c
> +++ b/tools/perf/util/hist.c
> @@ -745,6 +745,7 @@ __hists__add_entry(struct hists *hists,
>                 .weight =3D sample->weight,
>                 .ins_lat =3D sample->ins_lat,
>                 .p_stage_cyc =3D sample->p_stage_cyc,
> +               .simd_flags =3D sample->simd_flags,
>         }, *he =3D hists__findnew_entry(hists, &entry, al, sample_self);
>
>         if (!hists->has_callchains && he && he->callchain_size !=3D 0)
> diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
> index 86a677954279..afc9f1c7f4dc 100644
> --- a/tools/perf/util/hist.h
> +++ b/tools/perf/util/hist.h
> @@ -81,6 +81,7 @@ enum hist_column {
>         HISTC_ADDR_FROM,
>         HISTC_ADDR_TO,
>         HISTC_ADDR,
> +       HISTC_SIMD,
>         HISTC_NR_COLS, /* Last entry */
>  };
>
> diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
> index 093a0c8b2e3d..e11e68ecf0a2 100644
> --- a/tools/perf/util/sort.c
> +++ b/tools/perf/util/sort.c
> @@ -139,6 +139,52 @@ struct sort_entry sort_thread =3D {
>         .se_width_idx   =3D HISTC_THREAD,
>  };
>
> +/* --sort simd */
> +
> +static int64_t
> +sort__simd_cmp(struct hist_entry *left, struct hist_entry *right)
> +{
> +       if (left->simd_flags.arch !=3D right->simd_flags.arch)
> +               return (int64_t) left->simd_flags.arch - right->simd_flag=
s.arch;
> +
> +       return (int64_t) left->simd_flags.pred - right->simd_flags.pred;
> +}
> +
> +static const char *hist_entry__get_simd_name(struct simd_flags *simd_fla=
gs)
> +{
> +       u64 arch =3D simd_flags->arch;
> +
> +       if (arch & SIMD_OP_FLAGS_ARCH_SVE)
> +               return "SVE";
> +       else
> +               return "n/a";
> +}
> +
> +static int hist_entry__simd_snprintf(struct hist_entry *he, char *bf,
> +                                    size_t size, unsigned int width __ma=
ybe_unused)
> +{
> +       const char *name;
> +
> +       if (!he->simd_flags.arch)
> +               return repsep_snprintf(bf, size, "");
> +
> +       name =3D hist_entry__get_simd_name(&he->simd_flags);
> +
> +       if (he->simd_flags.pred & SIMD_OP_FLAGS_PRED_EMPTY)
> +               return repsep_snprintf(bf, size, "[e] %s", name);
> +       else if (he->simd_flags.pred & SIMD_OP_FLAGS_PRED_PARTIAL)
> +               return repsep_snprintf(bf, size, "[p] %s", name);
> +
> +       return repsep_snprintf(bf, size, "[.] %s", name);
> +}
> +
> +struct sort_entry sort_simd =3D {
> +       .se_header      =3D "Simd   ",
> +       .se_cmp         =3D sort__simd_cmp,
> +       .se_snprintf    =3D hist_entry__simd_snprintf,
> +       .se_width_idx   =3D HISTC_SIMD,
> +};
> +
>  /* --sort comm */
>
>  /*
> @@ -2142,6 +2188,7 @@ static struct sort_dimension common_sort_dimensions=
[] =3D {
>         DIM(SORT_ADDR, "addr", sort_addr),
>         DIM(SORT_LOCAL_RETIRE_LAT, "local_retire_lat", sort_local_p_stage=
_cyc),
>         DIM(SORT_GLOBAL_RETIRE_LAT, "retire_lat", sort_global_p_stage_cyc=
),
> +       DIM(SORT_SIMD, "simd", sort_simd)
>  };
>
>  #undef DIM
> diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
> index 22f437c3476f..ecfb7f1359d5 100644
> --- a/tools/perf/util/sort.h
> +++ b/tools/perf/util/sort.h
> @@ -111,6 +111,7 @@ struct hist_entry {
>         u64                     p_stage_cyc;
>         u8                      cpumode;
>         u8                      depth;
> +       struct simd_flags       simd_flags;
>
>         /* We are added by hists__add_dummy_entry. */
>         bool                    dummy;
> @@ -241,6 +242,7 @@ enum sort_type {
>         SORT_ADDR,
>         SORT_LOCAL_RETIRE_LAT,
>         SORT_GLOBAL_RETIRE_LAT,
> +       SORT_SIMD,
>
>         /* branch stack specific sort keys */
>         __SORT_BRANCH_STACK,
> --
> 2.34.1
>

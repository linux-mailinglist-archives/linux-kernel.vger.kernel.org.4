Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B453D74FC42
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 02:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbjGLAkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 20:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbjGLAj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 20:39:57 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A22DC
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 17:39:55 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-401d1d967beso84151cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 17:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689122394; x=1691714394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Qi+NFcxNlwSMhHVIm1XbE+dm6bAXeyc8TxwV12I5zs=;
        b=lAhA9pFnWALmfIs57wN1MTNxcSnUeATy8ZhYy/PfHuD1E+QKi0aGiCGKn2e4YXoxJg
         zOP2ju5TZ+a4ctAkNmJWdEJjUc4NtKNM1vcWWYNThKsGMMphwBaZK3k2Yau/btA/idFI
         2uNybOiniuG6j5G4/Btpr2K8HtDNJ+TVXyooQ+Y/kh26dKn1fHD6pVkKNhqhnjYpE1J3
         KF3LL6d8DKt75DWiVb3IQxlzuHdCPOh9Ww7w+GptbMtXs87KwDfNfB5aqg9VI2ThoJrS
         vbrtv1iPHVsZjHxtUDWUQfHvBjuVQvu9nLoubr3x/DuiWC+kD3jqpz8/NxrThcear92A
         cNPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689122394; x=1691714394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Qi+NFcxNlwSMhHVIm1XbE+dm6bAXeyc8TxwV12I5zs=;
        b=O6K/QDmKs7SsONtENQTofQBwUN+BB8STSjpF0mSIF53pek9oqlRGl4pT9GeTlrK1YW
         wN0IQE3sHno3NKXvB4RYcRDN9gjjoKAa5NiblolPstSGkxO5BuNz9TOP9dU1Ie1SJS2f
         Yq/E91wbBxTXvdXlEetxpw4YTRuHoQ3DVabULI8hMq9qD+wNJKyzwriylgfTgS0Xahuw
         yY4p7/YyPHThdXGMzrspMjOV0d33keOzOGZiUg2ODlv3eus6w6Aqqxlu6MMxC9XlBivX
         xFFDtJr0uDRf9mvZ+F+/EaXBNs4wd7w8R6IctxtlV2aRHSxXw28Hu1tGTZWKsQsUn5vb
         i7Vg==
X-Gm-Message-State: ABy/qLbfMpwjwBvW6NDvHhijXJ0gD0ILY8G0Hnc++Gpy2BGRzQUWYXtT
        CdAX7A11IcY0zbZVXwP1R7GuhPkXK4k3/BtgRifZNg==
X-Google-Smtp-Source: APBJJlEEKt4uYqH8nXVXABTDUxZKUtSbt4Fp9xXEZ7gvKxprWzqeokhS48si8HSRpAJdh4yAXKmMUTCteMON1u1om/M=
X-Received: by 2002:a05:622a:1a27:b0:403:58e8:2d96 with SMTP id
 f39-20020a05622a1a2700b0040358e82d96mr59153qtb.7.1689122394094; Tue, 11 Jul
 2023 17:39:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230711100218.1651995-1-james.clark@arm.com> <20230711100218.1651995-3-james.clark@arm.com>
In-Reply-To: <20230711100218.1651995-3-james.clark@arm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 11 Jul 2023 17:39:42 -0700
Message-ID: <CAP-5=fUJavikRkhm601ws+=yB3As1X0Au9Fr-5Z=BemGW9xjyw@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] perf jevents: Match on highest version of Arm json
 file available
To:     James Clark <james.clark@arm.com>
Cc:     linux-perf-users@vger.kernel.org, renyu.zj@linux.alibaba.com,
        john.g.garry@oracle.com, namhyung@kernel.org, acme@kernel.org,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Nick Forrington <nick.forrington@arm.com>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 3:02=E2=80=AFAM James Clark <james.clark@arm.com> w=
rote:
>
> Currently variant and revision fields are masked out of the MIDR so
> there can only be one set of jsons per CPU. In a later commit multiple
> revisions of Neoverse N2 json files will be provided. This can be used
> when a change is made to a new CPU version that fixes an event or metric
> formula.
>
> The highest valid version of json files should be used. For example if
> r0p0 and r1p0 JSON files are both provided, then r0p0 files will be used
> for all CPU versions up to (not including) r1p0, and then from r1p0
> onwards the r1p0 files will be used. To make this work the mapfile has
> to be reverse sorted on the CPUID field so that the highest is found
> first. It's possible, but error prone, to do this manually so instead
> add an explicit sort into jevents.py. If the CPUID is a string then the
> rows are string sorted rather than numerically.
>
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  tools/perf/arch/arm64/util/header.c          | 61 +++++++++++++++-----
>  tools/perf/pmu-events/arch/arm64/mapfile.csv | 12 +++-
>  tools/perf/pmu-events/jevents.py             | 49 +++++++++-------
>  tools/perf/tests/pmu-events.c                | 34 +++++++++++
>  4 files changed, 119 insertions(+), 37 deletions(-)
>
> diff --git a/tools/perf/arch/arm64/util/header.c b/tools/perf/arch/arm64/=
util/header.c
> index 80b9f6287fe2..637ad21721c2 100644
> --- a/tools/perf/arch/arm64/util/header.c
> +++ b/tools/perf/arch/arm64/util/header.c
> @@ -1,3 +1,6 @@
> +#include <linux/kernel.h>
> +#include <linux/bits.h>
> +#include <linux/bitfield.h>
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <perf/cpumap.h>
> @@ -10,14 +13,12 @@
>
>  #define MIDR "/regs/identification/midr_el1"
>  #define MIDR_SIZE 19
> -#define MIDR_REVISION_MASK      0xf
> -#define MIDR_VARIANT_SHIFT      20
> -#define MIDR_VARIANT_MASK       (0xf << MIDR_VARIANT_SHIFT)
> +#define MIDR_REVISION_MASK      GENMASK(3, 0)
> +#define MIDR_VARIANT_MASK      GENMASK(23, 20)
>
>  static int _get_cpuid(char *buf, size_t sz, struct perf_cpu_map *cpus)
>  {
>         const char *sysfs =3D sysfs__mountpoint();
> -       u64 midr =3D 0;
>         int cpu;
>
>         if (!sysfs || sz < MIDR_SIZE)
> @@ -44,21 +45,11 @@ static int _get_cpuid(char *buf, size_t sz, struct pe=
rf_cpu_map *cpus)
>                 }
>                 fclose(file);
>
> -               /* Ignore/clear Variant[23:20] and
> -                * Revision[3:0] of MIDR
> -                */
> -               midr =3D strtoul(buf, NULL, 16);
> -               midr &=3D (~(MIDR_VARIANT_MASK | MIDR_REVISION_MASK));
> -               scnprintf(buf, MIDR_SIZE, "0x%016lx", midr);
>                 /* got midr break loop */
>                 break;
>         }
>
>         perf_cpu_map__put(cpus);
> -
> -       if (!midr)
> -               return EINVAL;
> -
>         return 0;
>  }
>
> @@ -99,3 +90,45 @@ char *get_cpuid_str(struct perf_pmu *pmu)
>
>         return buf;
>  }
> +
> +
> +int strcmp_cpuid_str(const char *mapcpuid, const char *idstr)
> +{
> +       u64 map_id =3D strtoull(mapcpuid, NULL, 16);
> +       char map_id_variant =3D FIELD_GET(MIDR_VARIANT_MASK, map_id);
> +       char map_id_revision =3D FIELD_GET(MIDR_REVISION_MASK, map_id);
> +       u64 id =3D strtoull(idstr, NULL, 16);
> +       char id_variant =3D FIELD_GET(MIDR_VARIANT_MASK, id);
> +       char id_revision =3D FIELD_GET(MIDR_REVISION_MASK, id);
> +       u64 id_fields =3D ~(MIDR_VARIANT_MASK | MIDR_REVISION_MASK);
> +
> +       /* Compare without version first */
> +       if ((map_id & id_fields) !=3D (id & id_fields))
> +               return 1;
> +
> +       /*
> +        * ID matches, now compare version.
> +        *
> +        * Arm revisions (like r0p0) are compared here like two digit sem=
ver
> +        * values eg. 1.3 < 2.0 < 2.1 < 2.2. The events json file with th=
e
> +        * highest matching version is used.
> +        *
> +        *  r =3D high value =3D 'Variant' field in MIDR
> +        *  p =3D low value  =3D 'Revision' field in MIDR
> +        *
> +        * Because the Variant field is further to the left, iterating th=
rough a
> +        * reverse sorted mapfile.csv gives the correct comparison behavi=
or.
> +        * This relies on jevents.py sorting the list in print_mapping_ta=
ble().
> +        */
> +       if (id_variant > map_id_variant)
> +               return 0;
> +
> +       if (id_variant =3D=3D map_id_variant && id_revision >=3D map_id_r=
evision)
> +               return 0;
> +
> +       /*
> +        * variant is less than mapfile variant or variants are the same =
but
> +        * the revision doesn't match. Return no match.
> +        */
> +       return 1;
> +}
> diff --git a/tools/perf/pmu-events/arch/arm64/mapfile.csv b/tools/perf/pm=
u-events/arch/arm64/mapfile.csv
> index 32674ddd2b63..3a90fe650863 100644
> --- a/tools/perf/pmu-events/arch/arm64/mapfile.csv
> +++ b/tools/perf/pmu-events/arch/arm64/mapfile.csv
> @@ -3,7 +3,17 @@
>  #
>  # where
>  #      MIDR    Processor version
> -#              Variant[23:20] and Revision [3:0] should be zero.
> +#              Variant[23:20] and Revision [3:0] should be set to the
> +#               lowest supported version for that set of JSON files.
> +#               Multiple versions of the same CPU can be provided and
> +#               the highest version JSON files available will be used.
> +#
> +#               For example for a single set of JSONs, if variant and
> +#               revision are both set to 0 then the JSONs will match all
> +#               CPU versions. If another set is provided with variant
> +#               set to 1, the previous JSONs will match all versions up
> +#               to r1p0, and then r1p0 CPUs and above will start to
> +#               match the next set of JSONs provided.
>  #      Version could be used to track version of of JSON file
>  #              but currently unused.
>  #      JSON/file/pathname is the path to JSON file, relative
> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jev=
ents.py
> index 12e80bb7939b..c6a848f8d93a 100755
> --- a/tools/perf/pmu-events/jevents.py
> +++ b/tools/perf/pmu-events/jevents.py
> @@ -620,28 +620,34 @@ const struct pmu_events_map pmu_events_map[] =3D {
>  },
>  """)
>      else:
> +      def int_or_string_key(row):
> +        try:
> +          return int(row[0], 0)
> +        except:
> +          return row[0]
>        with open(f'{_args.starting_dir}/{arch}/mapfile.csv') as csvfile:
> -        table =3D csv.reader(csvfile)
> -        first =3D True
> -        for row in table:
> -          # Skip the first row or any row beginning with #.
> -          if not first and len(row) > 0 and not row[0].startswith('#'):
> -            event_tblname =3D file_name_to_table_name('pmu_events_', [],=
 row[2].replace('/', '_'))
> -            if event_tblname in _event_tables:
> -              event_size =3D f'ARRAY_SIZE({event_tblname})'
> -            else:
> -              event_tblname =3D 'NULL'
> -              event_size =3D '0'
> -            metric_tblname =3D file_name_to_table_name('pmu_metrics_', [=
], row[2].replace('/', '_'))
> -            if metric_tblname in _metric_tables:
> -              metric_size =3D f'ARRAY_SIZE({metric_tblname})'
> -            else:
> -              metric_tblname =3D 'NULL'
> -              metric_size =3D '0'
> -            if event_size =3D=3D '0' and metric_size =3D=3D '0':
> -              continue
> -            cpuid =3D row[0].replace('\\', '\\\\')
> -            _args.output_file.write(f"""{{
> +        table =3D [row for row in csv.reader(csvfile)]
> +      # Strip the first row or any row beginning with #.
> +      table =3D [row for row in table[1:] if len(row) > 0 and not row[0]=
.startswith('#')]
> +      # Sort on CPUID field for predictable >=3D version comparisons lat=
er on
> +      table =3D sorted(table, key=3Dint_or_string_key, reverse=3DTrue)
> +      for row in table:

nit: kind of weird diff is seeing this as changed, the rest is
explainable by the switch to the list comprehension.

> +        event_tblname =3D file_name_to_table_name('pmu_events_', [], row=
[2].replace('/', '_'))
> +        if event_tblname in _event_tables:
> +          event_size =3D f'ARRAY_SIZE({event_tblname})'
> +        else:
> +          event_tblname =3D 'NULL'
> +          event_size =3D '0'
> +        metric_tblname =3D file_name_to_table_name('pmu_metrics_', [], r=
ow[2].replace('/', '_'))
> +        if metric_tblname in _metric_tables:
> +          metric_size =3D f'ARRAY_SIZE({metric_tblname})'
> +        else:
> +          metric_tblname =3D 'NULL'
> +          metric_size =3D '0'
> +        if event_size =3D=3D '0' and metric_size =3D=3D '0':
> +          continue
> +        cpuid =3D row[0].replace('\\', '\\\\')
> +        _args.output_file.write(f"""{{
>  \t.arch =3D "{arch}",
>  \t.cpuid =3D "{cpuid}",
>  \t.event_table =3D {{
> @@ -654,7 +660,6 @@ const struct pmu_events_map pmu_events_map[] =3D {
>  \t}}
>  }},
>  """)
> -          first =3D False
>
>    _args.output_file.write("""{
>  \t.arch =3D 0,
> diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.=
c
> index 64383fc34ef1..e730d4792bbe 100644
> --- a/tools/perf/tests/pmu-events.c
> +++ b/tools/perf/tests/pmu-events.c
> @@ -14,6 +14,7 @@
>  #include "util/evlist.h"
>  #include "util/expr.h"
>  #include "util/hashmap.h"
> +#include "util/header.h"
>  #include "util/parse-events.h"
>  #include "metricgroup.h"
>  #include "stat.h"
> @@ -1027,6 +1028,38 @@ static int test__parsing_threshold(struct test_sui=
te *test __maybe_unused,
>         return pmu_for_each_sys_metric(test__parsing_threshold_callback, =
NULL);
>  }
>
> +static int test__cpuid_match(struct test_suite *test __maybe_unused,
> +                                      int subtest __maybe_unused)
> +{
> +#ifdef __aarch64__

This feels like it should be in: tools/perf/arch/arm64/tests/

Thanks,
Ian

> +       /* midr with no leading zeros matches */
> +       if (strcmp_cpuid_str("0x410fd0c0", "0x00000000410fd0c0"))
> +               return -1;
> +       /* Upper case matches */
> +       if (strcmp_cpuid_str("0x410fd0c0", "0x00000000410FD0C0"))
> +               return -1;
> +       /* r0p0 =3D r0p0 matches */
> +       if (strcmp_cpuid_str("0x00000000410fd480", "0x00000000410fd480"))
> +               return -1;
> +       /* r0p1 > r0p0 matches */
> +       if (strcmp_cpuid_str("0x00000000410fd480", "0x00000000410fd481"))
> +               return -1;
> +       /* r1p0 > r0p0 matches*/
> +       if (strcmp_cpuid_str("0x00000000410fd480", "0x00000000411fd480"))
> +               return -1;
> +       /* r0p0 < r0p1 doesn't match */
> +       if (!strcmp_cpuid_str("0x00000000410fd481", "0x00000000410fd480")=
)
> +               return -1;
> +       /* r0p0 < r1p0 doesn't match */
> +       if (!strcmp_cpuid_str("0x00000000411fd480", "0x00000000410fd480")=
)
> +               return -1;
> +       /* Different CPU doesn't match */
> +       if (!strcmp_cpuid_str("0x00000000410fd4c0", "0x00000000430f0af0")=
)
> +               return -1;
> +#endif
> +       return 0;
> +}
> +
>  static struct test_case pmu_events_tests[] =3D {
>         TEST_CASE("PMU event table sanity", pmu_event_table),
>         TEST_CASE("PMU event map aliases", aliases),
> @@ -1034,6 +1067,7 @@ static struct test_case pmu_events_tests[] =3D {
>                          "some metrics failed"),
>         TEST_CASE("Parsing of PMU event table metrics with fake PMUs", pa=
rsing_fake),
>         TEST_CASE("Parsing of metric thresholds with fake PMUs", parsing_=
threshold),
> +       TEST_CASE("CPUID matching", cpuid_match),
>         { .name =3D NULL, }
>  };
>
> --
> 2.34.1
>

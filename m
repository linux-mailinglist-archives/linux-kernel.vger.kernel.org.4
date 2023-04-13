Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE57D6E12B6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 18:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjDMQsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 12:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjDMQsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 12:48:52 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0BA6AD27
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 09:48:38 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3ee6c339cceso107195e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 09:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681404517; x=1683996517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fHprD9Rn7Zx8evKYbPVpv6COzXploeyos5dQLKdqVKM=;
        b=5PVrfKdKl3rXJJJy0Z2TZMBolvx0mDi5HUVZ9og5bWGwdsfaAOGL+A5EU+nZPvYMuX
         fXP/jiJ5UHiPieRYpZvD+5a/LY8vGF2ekvC3Lab8jLusYVlWdJYV1H1x96egQCEHFIc+
         Do1ANZ0I9IRS+tGhZiVU+9YpitdVYxeZ190udVTTB+4uOcs4DupPyM8pkr0h4+q+Ssrq
         M+Oe1BnlhTQivZy+E5tmh800WMvKr0HdBkpBYa7H1d+j1LBPIWV1BzEmGTj9SRgCEU07
         UBqnhTFJWFaR9p2WpxjVnjiPJj1t9pOljGiLlqxFnQY4Enr3FJ+i02BkPAa+mujbdSgh
         RXiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681404517; x=1683996517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fHprD9Rn7Zx8evKYbPVpv6COzXploeyos5dQLKdqVKM=;
        b=HBOKpeY5bTAu8If7MgF2u0NAc47V016ncJXsdS0mry+OMNiCdnqs8Ikc1tc5+ageWk
         X7L8feaAV7M/UiUIpB8of4MoPSBXZIv9TLkrSxyQOpm5VCQREk+FV4+DGG4G5ZWFVLwt
         AG5D+vbg+XuupNDKW9dgfvdEgdKtek1KHFHqOmSvDG2CcQ6/ovbk8BhSW1+oKvHCQWB1
         O2RFiyNtFaTIKq6fopftoyGDAEEhRsTC4h4E7aOw78RVvBnUBTtRqarPwhCCQpyY1ZvP
         dniP9ksCgCTtLaPz4D57lJ76a/b7nCtkFKis+dALnQQBh96GaFX320Jmcf/6oCbA3mD5
         LFHg==
X-Gm-Message-State: AAQBX9eoNGBbzLOPjynZcggnnWp0R4Ab+TsJYo0VSSBPiOPUmjKcCbPM
        75IOoJJBtmNgM2FuF/0c+owaNkW4vIKOlsPziXcPDQ==
X-Google-Smtp-Source: AKy350arCFD3KZPhhGyfy1fVLyy723Qk/c1slRSALL8X/0oUQ/mHddyZH7gsVwiGj0q8HDuJJ/TIqQYBcHKnAWS1aGs=
X-Received: by 2002:a05:600c:5125:b0:3f0:330b:eddb with SMTP id
 o37-20020a05600c512500b003f0330beddbmr761088wms.0.1681404516795; Thu, 13 Apr
 2023 09:48:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230413062006.1056-1-kprateek.nayak@amd.com> <20230413062006.1056-3-kprateek.nayak@amd.com>
In-Reply-To: <20230413062006.1056-3-kprateek.nayak@amd.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 13 Apr 2023 09:48:24 -0700
Message-ID: <CAP-5=fXkfkMUJiRiqWh0-J1KGkPdGniVq7RRN1HnDm39Xv0LFA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 2/2] perf: Add option for --per-cache aggregation
To:     K Prateek Nayak <kprateek.nayak@amd.com>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, ravi.bangoria@amd.com,
        sandipan.das@amd.com, ananth.narayan@amd.com,
        gautham.shenoy@amd.com, eranian@google.com, puwen@hygon.cn
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

On Wed, Apr 12, 2023 at 11:22=E2=80=AFPM K Prateek Nayak <kprateek.nayak@am=
d.com> wrote:
>
> Processors based on chiplet architecture, such as AMD EPYC and Hygon do
> not expose the chiplet details in the sysfs CPU topology information.
> However, this information can be derived from the per CPU cache level
> information from the sysfs.
>
> perf stat has already supported aggregation based on topology
> information using core ID, socket ID, etc. It'll be useful to aggregate
> based on the cache topology to detect problems like imbalance and
> cache-to-cache sharing at various cache levels.
>
> This patch adds support for "--per-cache" option for aggregation at a
> particular cache level. Also update the docs and related test. The
> output will be like:
>
>   $ sudo perf stat --per-cache=3DL3 -a -e ls_dmnd_fills_from_sys.ext_cach=
e_remote -- sleep 5
>
>    Performance counter stats for 'system wide':
>
>   S0-D0-L3-ID0             16         12,644,599      ls_dmnd_fills_from_=
sys.ext_cache_remote
>   S0-D0-L3-ID8             16         13,847,598      ls_dmnd_fills_from_=
sys.ext_cache_remote
>   S0-D0-L3-ID16            16            223,592      ls_dmnd_fills_from_=
sys.ext_cache_remote
>   S0-D0-L3-ID24            16              7,775      ls_dmnd_fills_from_=
sys.ext_cache_remote
>   S0-D0-L3-ID32            16             31,302      ls_dmnd_fills_from_=
sys.ext_cache_remote
>   S0-D0-L3-ID40            16             17,722      ls_dmnd_fills_from_=
sys.ext_cache_remote
>   S0-D0-L3-ID48            16              8,272      ls_dmnd_fills_from_=
sys.ext_cache_remote
>   S0-D0-L3-ID56            16              5,765      ls_dmnd_fills_from_=
sys.ext_cache_remote
>   S1-D1-L3-ID64            16         18,227,173      ls_dmnd_fills_from_=
sys.ext_cache_remote
>   S1-D1-L3-ID72            16         20,926,878      ls_dmnd_fills_from_=
sys.ext_cache_remote
>   S1-D1-L3-ID80            16             13,705      ls_dmnd_fills_from_=
sys.ext_cache_remote
>   S1-D1-L3-ID88            16             24,062      ls_dmnd_fills_from_=
sys.ext_cache_remote
>   S1-D1-L3-ID96            16             27,891      ls_dmnd_fills_from_=
sys.ext_cache_remote
>   S1-D1-L3-ID104           16             13,480      ls_dmnd_fills_from_=
sys.ext_cache_remote
>   S1-D1-L3-ID112           16             12,656      ls_dmnd_fills_from_=
sys.ext_cache_remote
>   S1-D1-L3-ID120           16             21,881      ls_dmnd_fills_from_=
sys.ext_cache_remote
>
> Also support perf stat record and perf stat report with the ability to
> specify a different cache level to aggregate data at when running perf
> stat report.
>
> Suggested-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
> ---
> Changelog:
> o v2->v3
>   - Cache IDs are now derived from the shared_cpus_list making
>     aggregation possible on older kernels that do not expose the IDs.
>   - Updated the comments based on the new ID assignment strategy.
>   - Better handle the case when specifying a level is possible as it is
>     less than or equal to MAX_CACHE_LVL but it does not exist on the
>     machine. In such cased ID will be -1.
>
>       $ sudo perf stat --per-cache=3DL4 -a -e cycles -- sleep 5
>
>         Performance counter stats for 'system wide':
>
>         S0-D0-L4-ID-1           128         51,328,613      cycles
>         S1-D1-L4-ID-1           128        125,132,221      cycles
>
> o v1->v2
>   - Fix cache level parsing logic. Previously, giving "--per-cache=3D2" w=
as
>     considered valid but that was not the intention. Only parse strings
>     of form LX or lX where x is the cache level and can range from 1 to
>     MAX_CACHE_LVL.
> ---
>  tools/lib/perf/include/perf/cpumap.h          |   5 +
>  tools/lib/perf/include/perf/event.h           |   3 +-
>  tools/perf/Documentation/perf-stat.txt        |  16 ++
>  tools/perf/builtin-stat.c                     | 144 +++++++++++++++++-
>  .../tests/shell/lib/perf_json_output_lint.py  |   4 +-
>  tools/perf/tests/shell/stat+csv_output.sh     |  14 ++
>  tools/perf/tests/shell/stat+json_output.sh    |  13 ++

I think you can break this patch apart. You can add the feature, then
enable the CSV test, then the json test, etc. When adding the feature
you can also probably split the changes of "struct aggr_cpu_id" from
the display/enablement logic. Overall it looks good!

Thanks,
Ian

>  tools/perf/util/cpumap.c                      | 118 ++++++++++++++
>  tools/perf/util/cpumap.h                      |  28 ++++
>  tools/perf/util/event.c                       |   7 +-
>  tools/perf/util/stat-display.c                |  17 +++
>  tools/perf/util/stat-shadow.c                 |   1 +
>  tools/perf/util/stat.h                        |   2 +
>  tools/perf/util/synthetic-events.c            |   1 +
>  14 files changed, 366 insertions(+), 7 deletions(-)
>
> diff --git a/tools/lib/perf/include/perf/cpumap.h b/tools/lib/perf/includ=
e/perf/cpumap.h
> index 3f43f770cdac..8724dde79342 100644
> --- a/tools/lib/perf/include/perf/cpumap.h
> +++ b/tools/lib/perf/include/perf/cpumap.h
> @@ -11,6 +11,11 @@ struct perf_cpu {
>         int cpu;
>  };
>
> +struct perf_cache {
> +       int cache_lvl;
> +       int cache;
> +};
> +
>  struct perf_cpu_map;
>
>  LIBPERF_API struct perf_cpu_map *perf_cpu_map__dummy_new(void);
> diff --git a/tools/lib/perf/include/perf/event.h b/tools/lib/perf/include=
/perf/event.h
> index ad47d7b31046..f3ceb2f96593 100644
> --- a/tools/lib/perf/include/perf/event.h
> +++ b/tools/lib/perf/include/perf/event.h
> @@ -378,7 +378,8 @@ enum {
>         PERF_STAT_CONFIG_TERM__AGGR_MODE        =3D 0,
>         PERF_STAT_CONFIG_TERM__INTERVAL         =3D 1,
>         PERF_STAT_CONFIG_TERM__SCALE            =3D 2,
> -       PERF_STAT_CONFIG_TERM__MAX              =3D 3,
> +       PERF_STAT_CONFIG_TERM__AGGR_LEVEL       =3D 3,
> +       PERF_STAT_CONFIG_TERM__MAX              =3D 4,
>  };
>
>  struct perf_record_stat_config_entry {
> diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Document=
ation/perf-stat.txt
> index 18abdc1dce05..5784131146a1 100644
> --- a/tools/perf/Documentation/perf-stat.txt
> +++ b/tools/perf/Documentation/perf-stat.txt
> @@ -308,6 +308,14 @@ use --per-die in addition to -a. (system-wide).  The=
 output includes the
>  die number and the number of online processors on that die. This is
>  useful to gauge the amount of aggregation.
>
> +--per-cache::
> +Aggregate counts per cache instance for system-wide mode measurements.  =
By
> +default, the aggregation happens for the cache level at the highest inde=
x
> +in the system. To specify a particular level, mention the cache level
> +alongside the option in the format [Ll][1-9][0-9]*. For example:
> +Using option "--per-cache=3Dl3" or "--per-cache=3DL3" will aggregate the
> +information at the boundary of the level 3 cache in the system.
> +
>  --per-core::
>  Aggregate counts per physical processor for system-wide mode measurement=
s.  This
>  is a useful mode to detect imbalance between physical cores.  To enable =
this mode,
> @@ -379,6 +387,14 @@ Aggregate counts per processor socket for system-wid=
e mode measurements.
>  --per-die::
>  Aggregate counts per processor die for system-wide mode measurements.
>
> +--per-cache::
> +Aggregate counts per cache instance for system-wide mode measurements.  =
By
> +default, the aggregation happens for the cache level at the highest inde=
x
> +in the system. To specify a particular level, mention the cache level
> +alongside the option in the format [Ll][1-9][0-9]*. For example: Using
> +option "--per-cache=3Dl3" or "--per-cache=3DL3" will aggregate the
> +information at the boundary of the level 3 cache in the system.
> +
>  --per-core::
>  Aggregate counts per physical processor for system-wide mode measurement=
s.
>
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index fa7c40956d0f..744890898c13 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -203,6 +203,7 @@ struct perf_stat {
>         struct perf_cpu_map     *cpus;
>         struct perf_thread_map *threads;
>         enum aggr_mode           aggr_mode;
> +       u32                      aggr_level;
>  };
>
>  static struct perf_stat                perf_stat;
> @@ -210,8 +211,9 @@ static struct perf_stat             perf_stat;
>
>  static volatile sig_atomic_t done =3D 0;
>
> -static struct perf_stat_config stat_config =3D {
> +struct perf_stat_config stat_config =3D {
>         .aggr_mode              =3D AGGR_GLOBAL,
> +       .aggr_level             =3D MAX_CACHE_LVL + 1,
>         .scale                  =3D true,
>         .unit_width             =3D 4, /* strlen("unit") */
>         .run_count              =3D 1,
> @@ -1160,6 +1162,55 @@ static int parse_hybrid_type(const struct option *=
opt,
>         return 0;
>  }
>
> +static int parse_cache_level(const struct option *opt,
> +                            const char *str,
> +                            int unset __maybe_unused)
> +{
> +       int level;
> +       u32 *aggr_mode =3D (u32 *)opt->value;
> +       u32 *aggr_level =3D (u32 *)opt->data;
> +
> +       /*
> +        * If no string is specified, aggregate based on the topology of
> +        * Last Level Cache (LLC). Since the LLC level can change from
> +        * architecture to architecture, set level greater than
> +        * MAX_CACHE_LVL which will be interpreted as LLC.
> +        */
> +       if (str =3D=3D NULL) {
> +               level =3D MAX_CACHE_LVL + 1;
> +               goto out;
> +       }
> +
> +       /*
> +        * The format to specify cache level is LX or lX where X is the
> +        * cache level.
> +        */
> +       if (strlen(str) !=3D 2 || (str[0] !=3D 'l' && str[0] !=3D 'L')) {
> +               pr_err("Cache level must be of form L[1-%d], or l[1-%d]\n=
",
> +                      MAX_CACHE_LVL,
> +                      MAX_CACHE_LVL);
> +               return -EINVAL;
> +       }
> +
> +       level =3D atoi(&str[1]);
> +       if (level < 1) {
> +               pr_err("Cache level must be of form L[1-%d], or l[1-%d]\n=
",
> +                      MAX_CACHE_LVL,
> +                      MAX_CACHE_LVL);
> +               return -EINVAL;
> +       }
> +
> +       if (level > MAX_CACHE_LVL) {
> +               pr_err("perf only supports max cache level of %d.\n"
> +                      "Consider increasing MAX_CACHE_LVL\n", MAX_CACHE_L=
VL);
> +               return -EINVAL;
> +       }
> +out:
> +       *aggr_mode =3D AGGR_CACHE;
> +       *aggr_level =3D level;
> +       return 0;
> +}
> +
>  static struct option stat_options[] =3D {
>         OPT_BOOLEAN('T', "transaction", &transaction_run,
>                     "hardware transaction statistics"),
> @@ -1237,6 +1288,9 @@ static struct option stat_options[] =3D {
>                      "aggregate counts per processor socket", AGGR_SOCKET=
),
>         OPT_SET_UINT(0, "per-die", &stat_config.aggr_mode,
>                      "aggregate counts per processor die", AGGR_DIE),
> +       OPT_CALLBACK_OPTARG(0, "per-cache", &stat_config.aggr_mode, &stat=
_config.aggr_level,
> +                           "cache level", "aggregate count at this cache=
 level (Default: LLC)",
> +                           parse_cache_level),
>         OPT_SET_UINT(0, "per-core", &stat_config.aggr_mode,
>                      "aggregate counts per physical processor core", AGGR=
_CORE),
>         OPT_SET_UINT(0, "per-thread", &stat_config.aggr_mode,
> @@ -1298,6 +1352,7 @@ static struct option stat_options[] =3D {
>
>  static const char *const aggr_mode__string[] =3D {
>         [AGGR_CORE] =3D "core",
> +       [AGGR_CACHE] =3D "cache",
>         [AGGR_DIE] =3D "die",
>         [AGGR_GLOBAL] =3D "global",
>         [AGGR_NODE] =3D "node",
> @@ -1319,6 +1374,12 @@ static struct aggr_cpu_id perf_stat__get_die(struc=
t perf_stat_config *config __m
>         return aggr_cpu_id__die(cpu, /*data=3D*/NULL);
>  }
>
> +static struct aggr_cpu_id perf_stat__get_cache_id(struct perf_stat_confi=
g *config __maybe_unused,
> +                                                 struct perf_cpu cpu)
> +{
> +       return aggr_cpu_id__cache(cpu, /*data=3D*/NULL);
> +}
> +
>  static struct aggr_cpu_id perf_stat__get_core(struct perf_stat_config *c=
onfig __maybe_unused,
>                                               struct perf_cpu cpu)
>  {
> @@ -1371,6 +1432,12 @@ static struct aggr_cpu_id perf_stat__get_die_cache=
d(struct perf_stat_config *con
>         return perf_stat__get_aggr(config, perf_stat__get_die, cpu);
>  }
>
> +static struct aggr_cpu_id perf_stat__get_cache_id_cached(struct perf_sta=
t_config *config,
> +                                                        struct perf_cpu =
cpu)
> +{
> +       return perf_stat__get_aggr(config, perf_stat__get_cache_id, cpu);
> +}
> +
>  static struct aggr_cpu_id perf_stat__get_core_cached(struct perf_stat_co=
nfig *config,
>                                                      struct perf_cpu cpu)
>  {
> @@ -1402,6 +1469,8 @@ static aggr_cpu_id_get_t aggr_mode__get_aggr(enum a=
ggr_mode aggr_mode)
>                 return aggr_cpu_id__socket;
>         case AGGR_DIE:
>                 return aggr_cpu_id__die;
> +       case AGGR_CACHE:
> +               return aggr_cpu_id__cache;
>         case AGGR_CORE:
>                 return aggr_cpu_id__core;
>         case AGGR_NODE:
> @@ -1425,6 +1494,8 @@ static aggr_get_id_t aggr_mode__get_id(enum aggr_mo=
de aggr_mode)
>                 return perf_stat__get_socket_cached;
>         case AGGR_DIE:
>                 return perf_stat__get_die_cached;
> +       case AGGR_CACHE:
> +               return perf_stat__get_cache_id_cached;
>         case AGGR_CORE:
>                 return perf_stat__get_core_cached;
>         case AGGR_NODE:
> @@ -1537,6 +1608,60 @@ static struct aggr_cpu_id perf_env__get_die_aggr_b=
y_cpu(struct perf_cpu cpu, voi
>         return id;
>  }
>
> +static void perf_env__get_cache_id_for_cpu(struct perf_cpu cpu, struct p=
erf_env *env,
> +                                          u32 cache_level, struct aggr_c=
pu_id *id)
> +{
> +       int i;
> +       int caches_cnt =3D env->caches_cnt;
> +       struct cpu_cache_level *caches =3D env->caches;
> +
> +       id->cache_lvl =3D (cache_level > MAX_CACHE_LVL) ? 0: cache_level;
> +       id->cache =3D -1;
> +
> +       if (!caches_cnt)
> +               return;
> +
> +       for (i =3D caches_cnt - 1; i > -1; --i) {
> +               struct perf_cpu_map *cpu_map;
> +               int map_contains_cpu;
> +
> +               /*
> +                * If user has not specified a level, find the fist level=
 with
> +                * the cpu in the map. Since building the map is expensiv=
e, do
> +                * this only if levels match.
> +                */
> +               if (cache_level <=3D MAX_CACHE_LVL && caches[i].level !=
=3D cache_level)
> +                       continue;
> +
> +               cpu_map =3D perf_cpu_map__new(caches[i].map);
> +               map_contains_cpu =3D perf_cpu_map__idx(cpu_map, cpu);
> +               perf_cpu_map__put(cpu_map);
> +
> +               if (map_contains_cpu !=3D -1) {
> +                       id->cache_lvl =3D caches[i].level;
> +                       id->cache =3D cpu__get_cache_id_from_map(cpu, cac=
hes[i].map);
> +                       return;
> +               }
> +       }
> +}
> +
> +static struct aggr_cpu_id perf_env__get_cache_aggr_by_cpu(struct perf_cp=
u cpu,
> +                                                         void *data)
> +{
> +       struct perf_env *env =3D data;
> +       struct aggr_cpu_id id =3D aggr_cpu_id__empty();
> +
> +       if (cpu.cpu !=3D -1) {
> +               u32 cache_level =3D (perf_stat.aggr_level) ?: stat_config=
.aggr_level;
> +
> +               id.socket =3D env->cpu[cpu.cpu].socket_id;
> +               id.die =3D env->cpu[cpu.cpu].die_id;
> +               perf_env__get_cache_id_for_cpu(cpu, env, cache_level, &id=
);
> +       }
> +
> +       return id;
> +}
> +
>  static struct aggr_cpu_id perf_env__get_core_aggr_by_cpu(struct perf_cpu=
 cpu, void *data)
>  {
>         struct perf_env *env =3D data;
> @@ -1605,6 +1730,12 @@ static struct aggr_cpu_id perf_stat__get_die_file(=
struct perf_stat_config *confi
>         return perf_env__get_die_aggr_by_cpu(cpu, &perf_stat.session->hea=
der.env);
>  }
>
> +static struct aggr_cpu_id perf_stat__get_cache_file(struct perf_stat_con=
fig *config __maybe_unused,
> +                                                   struct perf_cpu cpu)
> +{
> +       return perf_env__get_cache_aggr_by_cpu(cpu, &perf_stat.session->h=
eader.env);
> +}
> +
>  static struct aggr_cpu_id perf_stat__get_core_file(struct perf_stat_conf=
ig *config __maybe_unused,
>                                                    struct perf_cpu cpu)
>  {
> @@ -1636,6 +1767,8 @@ static aggr_cpu_id_get_t aggr_mode__get_aggr_file(e=
num aggr_mode aggr_mode)
>                 return perf_env__get_socket_aggr_by_cpu;
>         case AGGR_DIE:
>                 return perf_env__get_die_aggr_by_cpu;
> +       case AGGR_CACHE:
> +               return perf_env__get_cache_aggr_by_cpu;
>         case AGGR_CORE:
>                 return perf_env__get_core_aggr_by_cpu;
>         case AGGR_NODE:
> @@ -1659,6 +1792,8 @@ static aggr_get_id_t aggr_mode__get_id_file(enum ag=
gr_mode aggr_mode)
>                 return perf_stat__get_socket_file;
>         case AGGR_DIE:
>                 return perf_stat__get_die_file;
> +       case AGGR_CACHE:
> +               return perf_stat__get_cache_file;
>         case AGGR_CORE:
>                 return perf_stat__get_core_file;
>         case AGGR_NODE:
> @@ -2207,7 +2342,8 @@ static struct perf_stat perf_stat =3D {
>                 .stat           =3D perf_event__process_stat_event,
>                 .stat_round     =3D process_stat_round_event,
>         },
> -       .aggr_mode =3D AGGR_UNSET,
> +       .aggr_mode      =3D AGGR_UNSET,
> +       .aggr_level     =3D 0,
>  };
>
>  static int __cmd_report(int argc, const char **argv)
> @@ -2219,6 +2355,10 @@ static int __cmd_report(int argc, const char **arg=
v)
>                      "aggregate counts per processor socket", AGGR_SOCKET=
),
>         OPT_SET_UINT(0, "per-die", &perf_stat.aggr_mode,
>                      "aggregate counts per processor die", AGGR_DIE),
> +       OPT_CALLBACK_OPTARG(0, "per-cache", &perf_stat.aggr_mode, &perf_s=
tat.aggr_level,
> +                           "cache level",
> +                           "aggregate count at this cache level (Default=
: LLC)",
> +                           parse_cache_level),
>         OPT_SET_UINT(0, "per-core", &perf_stat.aggr_mode,
>                      "aggregate counts per physical processor core", AGGR=
_CORE),
>         OPT_SET_UINT(0, "per-node", &perf_stat.aggr_mode,
> diff --git a/tools/perf/tests/shell/lib/perf_json_output_lint.py b/tools/=
perf/tests/shell/lib/perf_json_output_lint.py
> index 97598d14e532..62489766b93c 100644
> --- a/tools/perf/tests/shell/lib/perf_json_output_lint.py
> +++ b/tools/perf/tests/shell/lib/perf_json_output_lint.py
> @@ -14,6 +14,7 @@ ap.add_argument('--system-wide', action=3D'store_true')
>  ap.add_argument('--event', action=3D'store_true')
>  ap.add_argument('--per-core', action=3D'store_true')
>  ap.add_argument('--per-thread', action=3D'store_true')
> +ap.add_argument('--per-cache', action=3D'store_true')
>  ap.add_argument('--per-die', action=3D'store_true')
>  ap.add_argument('--per-node', action=3D'store_true')
>  ap.add_argument('--per-socket', action=3D'store_true')
> @@ -46,6 +47,7 @@ def check_json_output(expected_items):
>        'counter-value': lambda x: is_counter_value(x),
>        'cgroup': lambda x: True,
>        'cpu': lambda x: isint(x),
> +      'cache': lambda x: True,
>        'die': lambda x: True,
>        'event': lambda x: True,
>        'event-runtime': lambda x: isfloat(x),
> @@ -82,7 +84,7 @@ try:
>      expected_items =3D 7
>    elif args.interval or args.per_thread or args.system_wide_no_aggr:
>      expected_items =3D 8
> -  elif args.per_core or args.per_socket or args.per_node or args.per_die=
:
> +  elif args.per_core or args.per_socket or args.per_node or args.per_die=
 or args.per_cache_instance:
>      expected_items =3D 9
>    else:
>      # If no option is specified, don't check the number of items.
> diff --git a/tools/perf/tests/shell/stat+csv_output.sh b/tools/perf/tests=
/shell/stat+csv_output.sh
> index 324fc9e6edd7..6cdf2fd386d5 100755
> --- a/tools/perf/tests/shell/stat+csv_output.sh
> +++ b/tools/perf/tests/shell/stat+csv_output.sh
> @@ -26,6 +26,7 @@ function commachecker()
>         ;; "--per-socket")      exp=3D8
>         ;; "--per-node")        exp=3D8
>         ;; "--per-die")         exp=3D8
> +       ;; "--per-cache")       exp=3D8
>         esac
>
>         while read line
> @@ -123,6 +124,18 @@ check_per_thread()
>         echo "[Success]"
>  }
>
> +check_per_cache_instance()
> +{
> +       echo -n "Checking CSV output: per cache instance "
> +       if ParanoidAndNotRoot 0
> +       then
> +               echo "[Skip] paranoid and not root"
> +               return
> +       fi
> +       perf stat -x$csv_sep --per-cache -a true 2>&1 | commachecker --pe=
r-cache
> +       echo "[Success]"
> +}
> +
>  check_per_die()
>  {
>         echo -n "Checking CSV output: per die "
> @@ -197,6 +210,7 @@ if [ $skip_test -ne 1 ]
>  then
>         check_system_wide_no_aggr
>         check_per_core
> +       check_per_cache_instance
>         check_per_die
>         check_per_socket
>  else
> diff --git a/tools/perf/tests/shell/stat+json_output.sh b/tools/perf/test=
s/shell/stat+json_output.sh
> index 2c4212c641ed..d79a6e0d4042 100755
> --- a/tools/perf/tests/shell/stat+json_output.sh
> +++ b/tools/perf/tests/shell/stat+json_output.sh
> @@ -100,6 +100,18 @@ check_per_thread()
>         echo "[Success]"
>  }
>
> +check_per_cache_instance()
> +{
> +       echo -n "Checking json output: per cache_instance "
> +       if ParanoidAndNotRoot 0
> +       then
> +               echo "[Skip] paranoia and not root"
> +               return
> +       fi
> +       perf stat -j --per-cache -a true 2>&1 | $PYTHON $pythonchecker --=
per-cache
> +       echo "[Success]"
> +}
> +
>  check_per_die()
>  {
>         echo -n "Checking json output: per die "
> @@ -174,6 +186,7 @@ if [ $skip_test -ne 1 ]
>  then
>         check_system_wide_no_aggr
>         check_per_core
> +       check_per_cache_instance
>         check_per_die
>         check_per_socket
>  else
> diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
> index 5e564974fba4..98dd308fcd21 100644
> --- a/tools/perf/util/cpumap.c
> +++ b/tools/perf/util/cpumap.c
> @@ -3,6 +3,8 @@
>  #include "cpumap.h"
>  #include "debug.h"
>  #include "event.h"
> +#include "header.h"
> +#include "stat.h"
>  #include <assert.h>
>  #include <dirent.h>
>  #include <stdio.h>
> @@ -227,6 +229,10 @@ static int aggr_cpu_id__cmp(const void *a_pointer, c=
onst void *b_pointer)
>                 return a->socket - b->socket;
>         else if (a->die !=3D b->die)
>                 return a->die - b->die;
> +       else if (a->cache_lvl !=3D b->cache_lvl)
> +               return a->cache_lvl - b->cache_lvl;
> +       else if (a->cache !=3D b->cache)
> +               return a->cache - b->cache;
>         else if (a->core !=3D b->core)
>                 return a->core - b->core;
>         else
> @@ -310,6 +316,112 @@ struct aggr_cpu_id aggr_cpu_id__die(struct perf_cpu=
 cpu, void *data)
>         return id;
>  }
>
> +extern struct perf_stat_config stat_config;
> +
> +int cpu__get_cache_id_from_map(struct perf_cpu cpu, char *map)
> +{
> +       int id;
> +       struct perf_cpu_map *cpu_map =3D perf_cpu_map__new(map);
> +
> +       /*
> +        * If the map contains no CPU, consider the current CPU to
> +        * be the first online CPU in the cache domain else use the
> +        * first online CPU of the cache domain as the ID.
> +        */
> +       if (perf_cpu_map__empty(cpu_map))
> +               id =3D cpu.cpu;
> +       else
> +               id =3D perf_cpu_map__cpu(cpu_map, 0).cpu;
> +
> +       /* Free the perf_cpu_map used to find the cache ID */
> +       perf_cpu_map__put(cpu_map);
> +
> +       return id;
> +}
> +int cpu__get_cache_details(struct perf_cpu cpu, struct perf_cache *cache=
)
> +{
> +       int ret =3D 0;
> +       struct cpu_cache_level caches[MAX_CACHE_LVL];
> +       u32 cache_level =3D stat_config.aggr_level;
> +       u32 i =3D 0, caches_cnt =3D 0;
> +
> +       cache->cache_lvl =3D (cache_level > MAX_CACHE_LVL)? 0: cache_leve=
l;
> +       cache->cache =3D -1;
> +
> +       ret =3D build_caches_for_cpu(cpu.cpu, caches, &caches_cnt);
> +       if (ret) {
> +               /*
> +                * If caches_cnt is not 0, cpu_cache_level data
> +                * was allocated when building the topology.
> +                * Free the allocated data before returning.
> +                */
> +               if (caches_cnt)
> +                       goto free_caches;
> +
> +               return ret;
> +       }
> +
> +       if (!caches_cnt)
> +               return -1;
> +
> +       /*
> +        * Save the data for the highest level if no
> +        * level was specified by the user.
> +        */
> +       if (cache_level > MAX_CACHE_LVL) {
> +               int max_level_index =3D 0;
> +
> +               for (i =3D 1; i < caches_cnt; ++i) {
> +                       if (caches[i].level > caches[max_level_index].lev=
el)
> +                               max_level_index =3D i;
> +               }
> +
> +               cache->cache_lvl =3D caches[max_level_index].level;
> +               cache->cache =3D cpu__get_cache_id_from_map(cpu, caches[m=
ax_level_index].map);
> +
> +               /* Reset i to 0 to free entire caches[] */
> +               i =3D 0;
> +               goto free_caches;
> +       }
> +
> +       for (i =3D 0; i < caches_cnt; ++i) {
> +               if (caches[i].level =3D=3D cache_level) {
> +                       cache->cache_lvl =3D cache_level;
> +                       cache->cache =3D cpu__get_cache_id_from_map(cpu, =
caches[i].map);
> +               }
> +
> +               cpu_cache_level__free(&caches[i]);
> +       }
> +
> +free_caches:
> +       /*
> +        * Free all the allocated cpu_cache_level data.
> +        */
> +       while (i < caches_cnt)
> +               cpu_cache_level__free(&caches[i++]);
> +
> +       return ret;
> +}
> +
> +struct aggr_cpu_id aggr_cpu_id__cache(struct perf_cpu cpu, void *data)
> +{
> +       int ret;
> +       struct aggr_cpu_id id;
> +       struct perf_cache cache;
> +
> +       id =3D aggr_cpu_id__die(cpu, data);
> +       if (aggr_cpu_id__is_empty(&id))
> +               return id;
> +
> +       ret =3D cpu__get_cache_details(cpu, &cache);
> +       if (ret)
> +               return id;
> +
> +       id.cache_lvl =3D cache.cache_lvl;
> +       id.cache =3D cache.cache;
> +       return id;
> +}
> +
>  int cpu__get_core_id(struct perf_cpu cpu)
>  {
>         int value, ret =3D cpu__get_topology_int(cpu.cpu, "core_id", &val=
ue);
> @@ -684,6 +796,8 @@ bool aggr_cpu_id__equal(const struct aggr_cpu_id *a, =
const struct aggr_cpu_id *b
>                 a->node =3D=3D b->node &&
>                 a->socket =3D=3D b->socket &&
>                 a->die =3D=3D b->die &&
> +               a->cache_lvl =3D=3D b->cache_lvl &&
> +               a->cache =3D=3D b->cache &&
>                 a->core =3D=3D b->core &&
>                 a->cpu.cpu =3D=3D b->cpu.cpu;
>  }
> @@ -694,6 +808,8 @@ bool aggr_cpu_id__is_empty(const struct aggr_cpu_id *=
a)
>                 a->node =3D=3D -1 &&
>                 a->socket =3D=3D -1 &&
>                 a->die =3D=3D -1 &&
> +               a->cache_lvl =3D=3D -1 &&
> +               a->cache =3D=3D -1 &&
>                 a->core =3D=3D -1 &&
>                 a->cpu.cpu =3D=3D -1;
>  }
> @@ -705,6 +821,8 @@ struct aggr_cpu_id aggr_cpu_id__empty(void)
>                 .node =3D -1,
>                 .socket =3D -1,
>                 .die =3D -1,
> +               .cache_lvl =3D -1,
> +               .cache =3D -1,
>                 .core =3D -1,
>                 .cpu =3D (struct perf_cpu){ .cpu =3D -1 },
>         };
> diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
> index c2f5824a3a22..686ef904f57b 100644
> --- a/tools/perf/util/cpumap.h
> +++ b/tools/perf/util/cpumap.h
> @@ -20,6 +20,13 @@ struct aggr_cpu_id {
>         int socket;
>         /** The die id as read from /sys/devices/system/cpu/cpuX/topology=
/die_id. */
>         int die;
> +       /** The cache level as read from /sys/devices/system/cpu/cpuX/cac=
he/indexY/level */
> +       int cache_lvl;
> +       /**
> +        * The cache instance ID, which is the first CPU in the
> +        * /sys/devices/system/cpu/cpuX/cache/indexY/shared_cpu_list
> +        */
> +       int cache;
>         /** The core id as read from /sys/devices/system/cpu/cpuX/topolog=
y/core_id. */
>         int core;
>         /** CPU aggregation, note there is one CPU for each SMT thread. *=
/
> @@ -76,6 +83,20 @@ int cpu__get_socket_id(struct perf_cpu cpu);
>   * /sys/devices/system/cpu/cpuX/topology/die_id for the given CPU.
>   */
>  int cpu__get_die_id(struct perf_cpu cpu);
> +/**
> + * Calculate the cache instance ID from the map in
> + * /sys/devices/system/cpu/cpuX/cache/indexY/shared_cpu_list
> + * Cache instance ID is the first CPU reported in the shared_cpu_list fi=
le.
> + */
> +int cpu__get_cache_id_from_map(struct perf_cpu cpu, char *map);
> +/**
> + * cpu__get_cache_id - Returns 0 if successful in populating the
> + * cache level and cache id. Cache level is read from
> + * /sys/devices/system/cpu/cpuX/cache/indexY/level where as cache instan=
ce ID
> + * is the first CPU reported by
> + * /sys/devices/system/cpu/cpuX/cache/indexY/shared_cpu_list
> + */
> +int cpu__get_cache_details(struct perf_cpu cpu, struct perf_cache *cache=
);
>  /**
>   * cpu__get_core_id - Returns the core id as read from
>   * /sys/devices/system/cpu/cpuX/topology/core_id for the given CPU.
> @@ -116,6 +137,13 @@ struct aggr_cpu_id aggr_cpu_id__socket(struct perf_c=
pu cpu, void *data);
>   * aggr_cpu_id_get_t.
>   */
>  struct aggr_cpu_id aggr_cpu_id__die(struct perf_cpu cpu, void *data);
> +/**
> + * aggr_cpu_id__cache - Create an aggr_cpu_id with cache instache ID, ca=
che
> + * level, die and socket populated with the cache instache ID, cache lev=
el,
> + * die and socket for cpu. The function signature is compatible with
> + * aggr_cpu_id_get_t.
> + */
> +struct aggr_cpu_id aggr_cpu_id__cache(struct perf_cpu cpu, void *data);
>  /**
>   * aggr_cpu_id__core - Create an aggr_cpu_id with the core, die and sock=
et
>   * populated with the core, die and socket for cpu. The function signatu=
re is
> diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
> index 1fa14598b916..faf0df3c5b95 100644
> --- a/tools/perf/util/event.c
> +++ b/tools/perf/util/event.c
> @@ -135,9 +135,10 @@ void perf_event__read_stat_config(struct perf_stat_c=
onfig *config,
>                         config->__val =3D event->data[i].val;     \
>                         break;
>
> -               CASE(AGGR_MODE, aggr_mode)
> -               CASE(SCALE,     scale)
> -               CASE(INTERVAL,  interval)
> +               CASE(AGGR_MODE,  aggr_mode)
> +               CASE(SCALE,      scale)
> +               CASE(INTERVAL,   interval)
> +               CASE(AGGR_LEVEL, aggr_level)
>  #undef CASE
>                 default:
>                         pr_warning("unknown stat config term %" PRI_lu64 =
"\n",
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-displa=
y.c
> index 1b5cb20efd23..82ec668bc3ba 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -36,6 +36,7 @@
>
>  static int aggr_header_lens[] =3D {
>         [AGGR_CORE]     =3D 18,
> +       [AGGR_CACHE]    =3D 22,
>         [AGGR_DIE]      =3D 12,
>         [AGGR_SOCKET]   =3D 6,
>         [AGGR_NODE]     =3D 6,
> @@ -46,6 +47,7 @@ static int aggr_header_lens[] =3D {
>
>  static const char *aggr_header_csv[] =3D {
>         [AGGR_CORE]     =3D       "core,cpus,",
> +       [AGGR_CACHE]    =3D       "cache,cpus,",
>         [AGGR_DIE]      =3D       "die,cpus,",
>         [AGGR_SOCKET]   =3D       "socket,cpus,",
>         [AGGR_NONE]     =3D       "cpu,",
> @@ -56,6 +58,7 @@ static const char *aggr_header_csv[] =3D {
>
>  static const char *aggr_header_std[] =3D {
>         [AGGR_CORE]     =3D       "core",
> +       [AGGR_CACHE]    =3D       "cache",
>         [AGGR_DIE]      =3D       "die",
>         [AGGR_SOCKET]   =3D       "socket",
>         [AGGR_NONE]     =3D       "cpu",
> @@ -193,6 +196,10 @@ static void print_aggr_id_std(struct perf_stat_confi=
g *config,
>         case AGGR_CORE:
>                 snprintf(buf, sizeof(buf), "S%d-D%d-C%d", id.socket, id.d=
ie, id.core);
>                 break;
> +       case AGGR_CACHE:
> +               snprintf(buf, sizeof(buf), "S%d-D%d-L%d-ID%d",
> +                        id.socket, id.die, id.cache_lvl, id.cache);
> +               break;
>         case AGGR_DIE:
>                 snprintf(buf, sizeof(buf), "S%d-D%d", id.socket, id.die);
>                 break;
> @@ -239,6 +246,10 @@ static void print_aggr_id_csv(struct perf_stat_confi=
g *config,
>                 fprintf(output, "S%d-D%d-C%d%s%d%s",
>                         id.socket, id.die, id.core, sep, nr, sep);
>                 break;
> +       case AGGR_CACHE:
> +               fprintf(config->output, "S%d-D%d-L%d-ID%d%s%d%s",
> +                       id.socket, id.die, id.cache_lvl, id.cache, sep, n=
r, sep);
> +               break;
>         case AGGR_DIE:
>                 fprintf(output, "S%d-D%d%s%d%s",
>                         id.socket, id.die, sep, nr, sep);
> @@ -284,6 +295,10 @@ static void print_aggr_id_json(struct perf_stat_conf=
ig *config,
>                 fprintf(output, "\"core\" : \"S%d-D%d-C%d\", \"aggregate-=
number\" : %d, ",
>                         id.socket, id.die, id.core, nr);
>                 break;
> +       case AGGR_CACHE:
> +               fprintf(output, "\"cache\" : \"S%d-D%d-L%d-ID%d\", \"aggr=
egate-number\" : %d, ",
> +                       id.socket, id.die, id.cache_lvl, id.cache, nr);
> +               break;
>         case AGGR_DIE:
>                 fprintf(output, "\"die\" : \"S%d-D%d\", \"aggregate-numbe=
r\" : %d, ",
>                         id.socket, id.die, nr);
> @@ -1126,6 +1141,7 @@ static void print_header_interval_std(struct perf_s=
tat_config *config,
>         case AGGR_NODE:
>         case AGGR_SOCKET:
>         case AGGR_DIE:
> +       case AGGR_CACHE:
>         case AGGR_CORE:
>                 fprintf(output, "#%*s %-*s cpus",
>                         INTERVAL_LEN - 1, "time",
> @@ -1422,6 +1438,7 @@ void evlist__print_counters(struct evlist *evlist, =
struct perf_stat_config *conf
>
>         switch (config->aggr_mode) {
>         case AGGR_CORE:
> +       case AGGR_CACHE:
>         case AGGR_DIE:
>         case AGGR_SOCKET:
>         case AGGR_NODE:
> diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.=
c
> index 806b32156459..f080905a3ece 100644
> --- a/tools/perf/util/stat-shadow.c
> +++ b/tools/perf/util/stat-shadow.c
> @@ -20,6 +20,7 @@
>   * AGGR_GLOBAL: Use CPU 0
>   * AGGR_SOCKET: Use first CPU of socket
>   * AGGR_DIE: Use first CPU of die
> + * AGGR_CACHE: Use first CPU of cache level instance
>   * AGGR_CORE: Use first CPU of core
>   * AGGR_NONE: Use matching CPU
>   * AGGR_THREAD: Not supported?
> diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
> index bf1794ebc916..848b3b3f5819 100644
> --- a/tools/perf/util/stat.h
> +++ b/tools/perf/util/stat.h
> @@ -74,6 +74,7 @@ enum aggr_mode {
>         AGGR_GLOBAL,
>         AGGR_SOCKET,
>         AGGR_DIE,
> +       AGGR_CACHE,
>         AGGR_CORE,
>         AGGR_THREAD,
>         AGGR_UNSET,
> @@ -139,6 +140,7 @@ typedef struct aggr_cpu_id (*aggr_get_id_t)(struct pe=
rf_stat_config *config, str
>
>  struct perf_stat_config {
>         enum aggr_mode           aggr_mode;
> +       u32                      aggr_level;
>         bool                     scale;
>         bool                     no_inherit;
>         bool                     identifier;
> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthet=
ic-events.c
> index 9ab9308ee80c..2fe648be1e7d 100644
> --- a/tools/perf/util/synthetic-events.c
> +++ b/tools/perf/util/synthetic-events.c
> @@ -1373,6 +1373,7 @@ int perf_event__synthesize_stat_config(struct perf_=
tool *tool,
>         ADD(AGGR_MODE,  config->aggr_mode)
>         ADD(INTERVAL,   config->interval)
>         ADD(SCALE,      config->scale)
> +       ADD(AGGR_LEVEL, config->aggr_level)
>
>         WARN_ONCE(i !=3D PERF_STAT_CONFIG_TERM__MAX,
>                   "stat config terms unbalanced\n");
> --
> 2.34.1
>

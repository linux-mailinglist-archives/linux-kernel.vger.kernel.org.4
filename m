Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE7C8707039
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 19:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjEQR6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 13:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjEQR6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 13:58:16 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2947B213D
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 10:58:14 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-338458a9304so14495ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 10:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684346293; x=1686938293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pcyJBM80MlPrx/ldkt3QmnqvRMbUpDuDG8MhrjdENxc=;
        b=kgHh0m9w2q3OvXlwiSUie6IG0a6C57iaEiyINchrB9KVovPks5Q1Vs/DKD4maemIc2
         yfIoHtUGECqPSqSZCO1P8Dcz6ORo5yS3Cge4u4k9VpOSZPunUesRfnq/byAF4EhzbKfl
         VroVW5xM5Vjn9EEpJMyEN+uPcWNuZy0RLqrbLxle+4NphcA6vYMGZsu/R6Vb5HF++0WM
         EgOC4CpaV6H/FGe8l0c87Bp4/d1j52rePrJX5N2OKL/S0xrU1HQWqLa2fVV/u1o1UL7L
         lWSA0+F5gMCwOjEsThjruACLK5FF9ObmyyueNeSvdo75qBuXzgrl2azdElW7FmMhGV6W
         kuLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684346293; x=1686938293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pcyJBM80MlPrx/ldkt3QmnqvRMbUpDuDG8MhrjdENxc=;
        b=VeGMWqtML9aA5h4oaM0mAsnqM16EYSwlU1mNCfSZXRTX4BiuFnniUm7KkOK2TJWh8z
         fbEnEzVyHjqQFCzQCKJOoEKNJMrHcw5TigTETP5pIdXLLoqZkgqefNCCibLebTCECHC9
         0gDhyLKlxXwOY6jSUAC8PWcgT6Oq5VC/zHMPmUesEx8J5K1bhxkcId9APcS7sOCmbHFh
         1u0IvxwpfLG3BFQ/JyJSx5DoxP+F3o5oEDj49arSitRArZVEcvjdgnYlOnzn5rn58kEo
         XHDzz8bZF/0graQROlVzdC9NrahPpJ8hTUfxYc42pSDG8dDSeW/iKgsqUB70IztLoZy1
         NcTw==
X-Gm-Message-State: AC+VfDx09SLRYGnCVdJDZdbb+ptR3rQ5xjZWXAZE8YpraC9zKyRpM/OD
        7POqqTGw7m0rUO8YdvlO6C806Z3uvB3EVBciWwRpW0ga8cWdydtrfAU=
X-Google-Smtp-Source: ACHHUZ4umteNOqSyCI41LORfg6ked3tigTjFe+YLfMLDLNV3TGMRs5xH6JWaDgdD4XzxZ2GuLAIby3l98oluociSFr8=
X-Received: by 2002:a05:6e02:156e:b0:337:c28c:3d0f with SMTP id
 k14-20020a056e02156e00b00337c28c3d0fmr16973ilu.6.1684346293217; Wed, 17 May
 2023 10:58:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230517172745.5833-1-kprateek.nayak@amd.com>
In-Reply-To: <20230517172745.5833-1-kprateek.nayak@amd.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 17 May 2023 10:58:01 -0700
Message-ID: <CAP-5=fUCvQNsW0Tnj7Q8sjFTqTEC9YUbFxAedRFtA=5zUe7BVA@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] perf stat: Add option to aggregate data based on
 the cache topology
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
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 10:22=E2=80=AFAM K Prateek Nayak <kprateek.nayak@am=
d.com> wrote:
>
> Motivation behind this feature is to aggregate the data at the LLC level
> for chiplet based processors which currently do not expose the chiplet
> details in sysfs cpu topology information.
>
> For the completeness of the feature, the series adds ability to
> aggregate data at any cache level. Following is the example of the
> output on a dual socket Zen3 processor with 2 x 64C/128T containing 8
> chiplet per socket.
>
>   $ sudo perf stat --per-cache -a -e ls_dmnd_fills_from_sys.ext_cache_rem=
ote --\
>     taskset -c 0-15,64-79,128-143,192-207\
>     perf bench sched messaging -p -t -l 100000 -g 8
>
>     # Running 'sched/messaging' benchmark:
>     # 20 sender and receiver threads per group
>     # 8 groups =3D=3D 320 threads run
>
>     Total time: 7.648 [sec]
>
>     Performance counter stats for 'system wide':
>
>     S0-D0-L3-ID0             16         17,145,912      ls_dmnd_fills_fro=
m_sys.ext_cache_remote
>     S0-D0-L3-ID8             16         14,977,628      ls_dmnd_fills_fro=
m_sys.ext_cache_remote
>     S0-D0-L3-ID16            16            262,539      ls_dmnd_fills_fro=
m_sys.ext_cache_remote
>     S0-D0-L3-ID24            16              3,140      ls_dmnd_fills_fro=
m_sys.ext_cache_remote
>     S0-D0-L3-ID32            16             27,403      ls_dmnd_fills_fro=
m_sys.ext_cache_remote
>     S0-D0-L3-ID40            16             17,026      ls_dmnd_fills_fro=
m_sys.ext_cache_remote
>     S0-D0-L3-ID48            16              7,292      ls_dmnd_fills_fro=
m_sys.ext_cache_remote
>     S0-D0-L3-ID56            16              2,464      ls_dmnd_fills_fro=
m_sys.ext_cache_remote
>     S1-D1-L3-ID64            16         22,489,306      ls_dmnd_fills_fro=
m_sys.ext_cache_remote
>     S1-D1-L3-ID72            16         21,455,257      ls_dmnd_fills_fro=
m_sys.ext_cache_remote
>     S1-D1-L3-ID80            16             11,619      ls_dmnd_fills_fro=
m_sys.ext_cache_remote
>     S1-D1-L3-ID88            16             30,978      ls_dmnd_fills_fro=
m_sys.ext_cache_remote
>     S1-D1-L3-ID96            16             37,628      ls_dmnd_fills_fro=
m_sys.ext_cache_remote
>     S1-D1-L3-ID104           16             13,594      ls_dmnd_fills_fro=
m_sys.ext_cache_remote
>     S1-D1-L3-ID112           16             10,164      ls_dmnd_fills_fro=
m_sys.ext_cache_remote
>     S1-D1-L3-ID120           16             11,259      ls_dmnd_fills_fro=
m_sys.ext_cache_remote
>
>           7.779171484 seconds time elapsed
>
> The series also adds support for perf stat record and perf stat report
> to aggregate data at various cache levels. Following is an example of
> recording with aggregation at L2 level and reporting the same data with
> aggregation at L3 level.
>
>   $ sudo perf stat record --per-cache=3DL2 -a -e ls_dmnd_fills_from_sys.e=
xt_cache_remote --\
>     taskset -c 0-15,64-79,128-143,192-207\
>     perf bench sched messaging -p -t -l 100000 -g 8
>
>     # Running 'sched/messaging' benchmark:
>     # 20 sender and receiver threads per group
>     # 8 groups =3D=3D 320 threads run
>
>     Total time: 7.318 [sec]
>
>     Performance counter stats for 'system wide':
>
>     S0-D0-L2-ID0              2          2,171,980      ls_dmnd_fills_fro=
m_sys.ext_cache_remote
>     S0-D0-L2-ID1              2          2,048,494      ls_dmnd_fills_fro=
m_sys.ext_cache_remote
>     S0-D0-L2-ID2              2          2,120,293      ls_dmnd_fills_fro=
m_sys.ext_cache_remote
>     S0-D0-L2-ID3              2          2,224,725      ls_dmnd_fills_fro=
m_sys.ext_cache_remote
>     S0-D0-L2-ID4              2          2,021,618      ls_dmnd_fills_fro=
m_sys.ext_cache_remote
>     S0-D0-L2-ID5              2          1,995,331      ls_dmnd_fills_fro=
m_sys.ext_cache_remote
>     S0-D0-L2-ID6              2          2,163,029      ls_dmnd_fills_fro=
m_sys.ext_cache_remote
>     S0-D0-L2-ID7              2          2,104,623      ls_dmnd_fills_fro=
m_sys.ext_cache_remote
>     S0-D0-L2-ID8              2          1,948,776      ls_dmnd_fills_fro=
m_sys.ext_cache_remote
>     ...
>     S0-D0-L2-ID63             2              2,648      ls_dmnd_fills_fro=
m_sys.ext_cache_remote
>     S1-D1-L2-ID64             2          2,963,323      ls_dmnd_fills_fro=
m_sys.ext_cache_remote
>     S1-D1-L2-ID65             2          2,856,629      ls_dmnd_fills_fro=
m_sys.ext_cache_remote
>     S1-D1-L2-ID66             2          2,901,725      ls_dmnd_fills_fro=
m_sys.ext_cache_remote
>     S1-D1-L2-ID67             2          3,046,120      ls_dmnd_fills_fro=
m_sys.ext_cache_remote
>     S1-D1-L2-ID68             2          2,637,971      ls_dmnd_fills_fro=
m_sys.ext_cache_remote
>     S1-D1-L2-ID69             2          2,680,029      ls_dmnd_fills_fro=
m_sys.ext_cache_remote
>     S1-D1-L2-ID70             2          2,672,259      ls_dmnd_fills_fro=
m_sys.ext_cache_remote
>     S1-D1-L2-ID71             2          2,638,768      ls_dmnd_fills_fro=
m_sys.ext_cache_remote
>     S1-D1-L2-ID72             2          3,308,642      ls_dmnd_fills_fro=
m_sys.ext_cache_remote
>     S1-D1-L2-ID73             2          3,064,473      ls_dmnd_fills_fro=
m_sys.ext_cache_remote
>     S1-D1-L2-ID74             2          3,023,379      ls_dmnd_fills_fro=
m_sys.ext_cache_remote
>     S1-D1-L2-ID75             2          2,975,119      ls_dmnd_fills_fro=
m_sys.ext_cache_remote
>     S1-D1-L2-ID76             2          2,952,677      ls_dmnd_fills_fro=
m_sys.ext_cache_remote
>     S1-D1-L2-ID77             2          2,981,695      ls_dmnd_fills_fro=
m_sys.ext_cache_remote
>     S1-D1-L2-ID78             2          3,455,916      ls_dmnd_fills_fro=
m_sys.ext_cache_remote
>     S1-D1-L2-ID79             2          2,959,540      ls_dmnd_fills_fro=
m_sys.ext_cache_remote
>     S1-D1-L2-ID80             2              4,977      ls_dmnd_fills_fro=
m_sys.ext_cache_remote
>     ...
>     S1-D1-L2-ID127            2              3,359      ls_dmnd_fills_fro=
m_sys.ext_cache_remote
>
>           7.451725897 seconds time elapsed
>
>   $ sudo perf stat report --per-cache=3DL3
>
>     Performance counter stats for '...':
>
>     S0-D0-L3-ID0             16         16,850,093      ls_dmnd_fills_fro=
m_sys.ext_cache_remote
>     S0-D0-L3-ID8             16         16,001,493      ls_dmnd_fills_fro=
m_sys.ext_cache_remote
>     S0-D0-L3-ID16            16            301,011      ls_dmnd_fills_fro=
m_sys.ext_cache_remote
>     S0-D0-L3-ID24            16             26,276      ls_dmnd_fills_fro=
m_sys.ext_cache_remote
>     S0-D0-L3-ID32            16             48,958      ls_dmnd_fills_fro=
m_sys.ext_cache_remote
>     S0-D0-L3-ID40            16             43,799      ls_dmnd_fills_fro=
m_sys.ext_cache_remote
>     S0-D0-L3-ID48            16             16,771      ls_dmnd_fills_fro=
m_sys.ext_cache_remote
>     S0-D0-L3-ID56            16             12,544      ls_dmnd_fills_fro=
m_sys.ext_cache_remote
>     S1-D1-L3-ID64            16         22,396,824      ls_dmnd_fills_fro=
m_sys.ext_cache_remote
>     S1-D1-L3-ID72            16         24,721,441      ls_dmnd_fills_fro=
m_sys.ext_cache_remote
>     S1-D1-L3-ID80            16             29,426      ls_dmnd_fills_fro=
m_sys.ext_cache_remote
>     S1-D1-L3-ID88            16             54,348      ls_dmnd_fills_fro=
m_sys.ext_cache_remote
>     S1-D1-L3-ID96            16             41,557      ls_dmnd_fills_fro=
m_sys.ext_cache_remote
>     S1-D1-L3-ID104           16             10,084      ls_dmnd_fills_fro=
m_sys.ext_cache_remote
>     S1-D1-L3-ID112           16             14,361      ls_dmnd_fills_fro=
m_sys.ext_cache_remote
>     S1-D1-L3-ID120           16             24,446      ls_dmnd_fills_fro=
m_sys.ext_cache_remote
>
>            7.451725897 seconds time elapsed
>
> The aggregate at S0-D0-L3-ID0 is the sum of S0-D0-L2-ID0 to S0-D0-L3-ID7
> as L3 containing CPU0 contains the L2 instance of CPU0 to CPU7.
>
> Cache IDs are derived from the shared_cpus_list file in the cache
> topology. This allows for --per-cache aggregation of data on a kernel
> which does not expose the cache instance ID in the sysfs. Running perf
> stat will give the following output on the same system with cache
> instance ID hidden:
>
>   $ ls /sys/devices/system/cpu/cpu0/cache/index0/
>
>     coherency_line_size  level  number_of_sets  physical_line_partition
>     shared_cpu_list  shared_cpu_map  size  type  uevent
>     ways_of_associativity
>
>   $ sudo perf stat --per-cache -a -e ls_dmnd_fills_from_sys.ext_cache_rem=
ote --\
>     taskset -c 0-15,64-79,128-143,192-207\
>     perf bench sched messaging -p -t -l 100000 -g 8
>
>     # Running 'sched/messaging' benchmark:
>     # 20 sender and receiver threads per group
>     # 8 groups =3D=3D 320 threads run
>
>          Total time: 6.949 [sec]
>
>      Performance counter stats for 'system wide':
>
>     S0-D0-L3-ID0             16          5,297,615      ls_dmnd_fills_fro=
m_sys.ext_cache_remote
>     S0-D0-L3-ID8             16          4,347,868      ls_dmnd_fills_fro=
m_sys.ext_cache_remote
>     S0-D0-L3-ID16            16            416,593      ls_dmnd_fills_fro=
m_sys.ext_cache_remote
>     S0-D0-L3-ID24            16              4,346      ls_dmnd_fills_fro=
m_sys.ext_cache_remote
>     S0-D0-L3-ID32            16              5,506      ls_dmnd_fills_fro=
m_sys.ext_cache_remote
>     S0-D0-L3-ID40            16             15,845      ls_dmnd_fills_fro=
m_sys.ext_cache_remote
>     S0-D0-L3-ID48            16             24,164      ls_dmnd_fills_fro=
m_sys.ext_cache_remote
>     S0-D0-L3-ID56            16              4,543      ls_dmnd_fills_fro=
m_sys.ext_cache_remote
>     S1-D1-L3-ID64            16         41,610,374      ls_dmnd_fills_fro=
m_sys.ext_cache_remote
>     S1-D1-L3-ID72            16         38,393,688      ls_dmnd_fills_fro=
m_sys.ext_cache_remote
>     S1-D1-L3-ID80            16             22,188      ls_dmnd_fills_fro=
m_sys.ext_cache_remote
>     S1-D1-L3-ID88            16             22,918      ls_dmnd_fills_fro=
m_sys.ext_cache_remote
>     S1-D1-L3-ID96            16             39,230      ls_dmnd_fills_fro=
m_sys.ext_cache_remote
>     S1-D1-L3-ID104           16              6,236      ls_dmnd_fills_fro=
m_sys.ext_cache_remote
>     S1-D1-L3-ID112           16             66,846      ls_dmnd_fills_fro=
m_sys.ext_cache_remote
>     S1-D1-L3-ID120           16             72,713      ls_dmnd_fills_fro=
m_sys.ext_cache_remote
>
>            7.098471410 seconds time elapsed
>
> Few notes:
>
> - This series makes breaking change when saving the aggregation details
>   as the cache level needs to be saved along with the aggregation
>   method.
>
> - This series assumes that caches at same level will be shared by same
>   set of threads. The implementation will run into an issue if, say L1i
>   is thread local, but L1d is shared by the SMT siblings on the core.
>
> This series cleanly applies on top perf-tool branch from Arnaldo's tree
> (https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/log/?h=3D=
perf-tools)
> at commit 760ebc45746b ("perf lock contention: Add empty 'struct rq' to
> satisfy libbpf 'runqueue' type verification")
> ---
> Changelog:
> o v3->v4:
>   - Dropped the RFC tag.
>   - Break down Patch 2 from v3 into smaller patches (kind of!)
>   - Fixed couple of errors in docs and comments.
>
> o v2->v3:
>   - Dropped patches 1 and 2 that saved and retrieved the cache instance
>     ID when saving the cache data.
>   - The above is unnecessary as the IDs are being derived from the first
>     online CPU in the cache domain for a given cache instance.
>   - Improvements to handling cases where a cache level is not present
>     but the level is allowed by MAX_CACHE_LVL.
>   - Updated details in cover letter.
>
> o v1->v2
>   - Set cache instance ID to 0 if the file cannot be read.
>   - Fix cache level parsing function.
>   - Updated details in cover letter.
> ---
> K Prateek Nayak (5):
>   perf: Extract building cache level for a CPU into separate function
>   perf stat: Setup the foundation to allow aggregation based on cache
>     topology
>   perf stat: Save cache level information when running perf stat record
>   perf stat: Add "--per-cache" aggregation option and document the same
>   pert stat: Add tests for the "--per-cache" option

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

>  tools/lib/perf/include/perf/cpumap.h          |   5 +
>  tools/lib/perf/include/perf/event.h           |   3 +-
>  tools/perf/Documentation/perf-stat.txt        |  16 ++
>  tools/perf/builtin-stat.c                     | 144 +++++++++++++++++-
>  .../tests/shell/lib/perf_json_output_lint.py  |   4 +-
>  tools/perf/tests/shell/stat+csv_output.sh     |  14 ++
>  tools/perf/tests/shell/stat+json_output.sh    |  13 ++
>  tools/perf/util/cpumap.c                      | 119 +++++++++++++++
>  tools/perf/util/cpumap.h                      |  28 ++++
>  tools/perf/util/event.c                       |   7 +-
>  tools/perf/util/header.c                      |  62 +++++---
>  tools/perf/util/header.h                      |   4 +
>  tools/perf/util/stat-display.c                |  17 +++
>  tools/perf/util/stat.h                        |   2 +
>  tools/perf/util/synthetic-events.c            |   1 +
>  15 files changed, 409 insertions(+), 30 deletions(-)
>
> --
> 2.34.1
>

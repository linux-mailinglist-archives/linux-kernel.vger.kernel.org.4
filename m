Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3818A6F6FEF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 18:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjEDQ2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 12:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjEDQ2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 12:28:38 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5941984
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 09:28:33 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id e9e14a558f8ab-32f4e0f42a7so549535ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 09:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683217713; x=1685809713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9+VP3uaKzWcb6ZT765WK3PqiJOkmOv7Wd1FEYE1adxQ=;
        b=pyuv8v4iubf2f73ykjeTCk5GaXz2MiECBM6bup/C/NXaN9cAwKrDTIg7k/LAuBmQLB
         viNHdlA9JcmoT4hk0lT8HKNYcq6Kv94b7o8tdV5yScO6WruRYLvdG57tzkS+EDgaesXm
         9UuVBX42y8ordCZMJNau3MX1kBUvyIqoSlQtMXvnOf9v3QIhfjPevMklmTfHRhZWD/Ud
         raId0TItu2gSAfJ9/4uGL/xAcWhkwexGPLgOm9euCgrHwrUvIR0alBnFN/OAhod0fjEa
         6GmueNk/itVNuYlGjGJUiq1VHZKxNJM2/8tV3mTkS6BP0a3pYkVl+PmMvNg1hMfdV/cG
         6nkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683217713; x=1685809713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9+VP3uaKzWcb6ZT765WK3PqiJOkmOv7Wd1FEYE1adxQ=;
        b=R6GJH+v2LdtV1aLTKuWniEuS4smL7R8LZdKqSrr4JaMOWCDJdW+b8rHm4ADn8mZKna
         vkHUn9Q6IAarHQSmoYBa8UdCGaM98K4N2in+TGo/5ecBedD/daxb2qrEJy/chK86Pgq4
         ISCLU99KJQ5GIbYkNzktaHjk3xdFj55LO2fBVnvzgNvG6XQi5zggD8xkn9gB3vO4iIwW
         zDFcAoyZkMChvA3HMcZR/Ua3caHbICEIsLsDEpG5b+JvntC203TfYA5n4t5DXDeUu7dF
         OO0FCkUUt9IJQZpBraIti81DMH8lK+ytdrtQbx47G712u0MepUum++8cfpM5B+EZGHJL
         lXyg==
X-Gm-Message-State: AC+VfDwcDFwFWiUZ9Zdher0ZcdD0p/P98bYmULcSYExox6DxZt7sRnHN
        DJrgehGY30BbM8ZdJXhiNPKdkY52yHU/fjFeSqYnxQ==
X-Google-Smtp-Source: ACHHUZ4ZPLptbystmtU6trjEckG8NUNPWsLG3nKkmqFCf8jC+wSuxd2Bn8iMtwsBlnJr/5XYF9Sv1VNeLfJP8hepHQA=
X-Received: by 2002:a92:c24d:0:b0:313:93c8:e71f with SMTP id
 k13-20020a92c24d000000b0031393c8e71fmr241253ilo.19.1683217713083; Thu, 04 May
 2023 09:28:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230504160845.2065510-1-james.clark@arm.com>
In-Reply-To: <20230504160845.2065510-1-james.clark@arm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 4 May 2023 09:28:21 -0700
Message-ID: <CAP-5=fX+PB9_UVPxwpHwcesupu_8f2c8bp5KOHrG9WAFH4VBpw@mail.gmail.com>
Subject: Re: [PATCH] perf: arm64: Fix build with refcount checking
To:     James Clark <james.clark@arm.com>
Cc:     linux-perf-users@vger.kernel.org,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
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
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
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

On Thu, May 4, 2023 at 9:09=E2=80=AFAM James Clark <james.clark@arm.com> wr=
ote:
>
> With EXTRA_CFLAGS=3D-DREFCNT_CHECKING=3D1 and build-test, some unwrapped
> map accesses appear. Wrap it in the new accessor to fix the error:
>
>   error: 'struct perf_cpu_map' has no member named 'map'
>
> Signed-off-by: James Clark <james.clark@arm.com>

Thanks James and sorry for the breakage!
Acked-by: Ian Rogers <irogers@google.com>

Ian

> ---
>  tools/perf/arch/arm64/util/header.c | 4 ++--
>  tools/perf/arch/arm64/util/pmu.c    | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/arch/arm64/util/header.c b/tools/perf/arch/arm64/=
util/header.c
> index d730666ab95d..80b9f6287fe2 100644
> --- a/tools/perf/arch/arm64/util/header.c
> +++ b/tools/perf/arch/arm64/util/header.c
> @@ -29,8 +29,8 @@ static int _get_cpuid(char *buf, size_t sz, struct perf=
_cpu_map *cpus)
>                 char path[PATH_MAX];
>                 FILE *file;
>
> -               scnprintf(path, PATH_MAX, "%s/devices/system/cpu/cpu%d"MI=
DR,
> -                               sysfs, cpus->map[cpu]);
> +               scnprintf(path, PATH_MAX, "%s/devices/system/cpu/cpu%d" M=
IDR,
> +                         sysfs, RC_CHK_ACCESS(cpus)->map[cpu].cpu);
>
>                 file =3D fopen(path, "r");
>                 if (!file) {
> diff --git a/tools/perf/arch/arm64/util/pmu.c b/tools/perf/arch/arm64/uti=
l/pmu.c
> index fa143acb4c8d..ef1ed645097c 100644
> --- a/tools/perf/arch/arm64/util/pmu.c
> +++ b/tools/perf/arch/arm64/util/pmu.c
> @@ -18,7 +18,7 @@ static struct perf_pmu *pmu__find_core_pmu(void)
>                  * The cpumap should cover all CPUs. Otherwise, some CPUs=
 may
>                  * not support some events or have different event IDs.
>                  */
> -               if (pmu->cpus->nr !=3D cpu__max_cpu().cpu)
> +               if (RC_CHK_ACCESS(pmu->cpus)->nr !=3D cpu__max_cpu().cpu)
>                         return NULL;
>
>                 return pmu;
> --
> 2.34.1
>

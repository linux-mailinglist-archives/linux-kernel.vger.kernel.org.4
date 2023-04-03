Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF9A6D4EF4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 19:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233163AbjDCR2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 13:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233157AbjDCR2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 13:28:43 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D7742686
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 10:28:42 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-3e392e10cc4so1227821cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 10:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680542921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kpn/KhpcP085eDxsf1VEIL2CtSKS0wIReF1Y4W2z19c=;
        b=XgJ794ouvra+MVbtDLpmz4jtm+tMYqwW2TkPDR8PKHTT9bEJ3/wRIinznK7/OzP3FV
         AvV9vUfk8ZDAccFM0CznBH32GyrNOElTkjLU2waU3JF+bRR9xGduqeacTjEkfUgf6ol1
         nNq7zhy7D/+ID4L9vy+LHwXIxrFib1M1QsDd8uTZeUcSlMrFcQJBGmCCfVlu39bmzdaU
         422fXqMxcZ/TP/oksICpVJa6gkQrVdi3FLiWZs3UP2+KhgsrRxib6c2GqyfgAXbyRoOf
         9yQSJOCLzhA74esY+LF1K0g4TzDVhDXQ4fp4pqwl1b/dUPq+OzWDKQRE21P8mrWneBmV
         iiHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680542921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kpn/KhpcP085eDxsf1VEIL2CtSKS0wIReF1Y4W2z19c=;
        b=lLCRKRNPkeCYt4mldV5VAbAfkzMnjvc8pThHeMD57dqfvxzJwR40dx+7JYZPfXzkzY
         xx7/VsPf30PCJzIweWRaEo+dfMmaJudqsKzdvR7Pt64qLSTo8HZVtDIoonW/RDf1Ohay
         Z3uYOrhJKSVcPajhipCZy7ULQTfWOBewVyZ1IK9i9zk5ZO2QCje9vVZAPvpwN54gK+bh
         EvgDH3oklIrzw77prUSaC19FsmdM5iu+UaREhkMD8mpEBdAXg6hkbjJqhYgN77nvQXbd
         /cLTN38wRCr9/n6cNm0hWwLkJ+eY3KAU2sMjpIRZQYEgp6267QQ5VcPD2t1QibAvAVWI
         3ocA==
X-Gm-Message-State: AAQBX9d1cA07yiZUb6nSPyMBmkjFl6Lb1/Onmv2uZHB9S4pf9QYirXvJ
        4dl77MN1L99o+XCCh0yrg1Rde6akRRLlXIeKhN7SyWC+yRvtHGAqOxs=
X-Google-Smtp-Source: AKy350bniYi5ynkqBSd9hBEWXjYTcJaAliiQRAyJOa7hZawpnpmnboOy31c1b1qsKam08fr/5HXcNydQ9Xt3VtLO+H0=
X-Received: by 2002:a05:622a:1813:b0:3b3:20d8:a84 with SMTP id
 t19-20020a05622a181300b003b320d80a84mr9710qtc.2.1680542921010; Mon, 03 Apr
 2023 10:28:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230331202949.810326-1-namhyung@kernel.org>
In-Reply-To: <20230331202949.810326-1-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 3 Apr 2023 10:28:28 -0700
Message-ID: <CAP-5=fWC1v+vsi-qmYXy8VMKXOsscYobucwS3GZw=gycdnAc3w@mail.gmail.com>
Subject: Re: [PATCHSET 0/9] perf tools: Update pmu scan using openat() (v1)
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31, 2023 at 1:29=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hello,
>
> This patchset changes PMU info scanning on sysfs using openat()
> basically.  I got reports of occasional contention on the
> opening files in sysfs.  While the root cause was a separate
> issue, I discovered some inefficiencies in the perf code.
>
> To scan PMUs, it roughly does something like below:
>
>   dir =3D opendir("/sys/bus/event_source/devices");
>   while (dentry =3D readdir(dir)) {
>     char buf[PATH_MAX];
>
>     snprintf(buf, sizeof(buf), "%s/%s",
>              "/sys/bus/event_source/devices", dentry->d_name);
>     fd =3D open(buf, O_RDONLY);
>     ...
>   }
>
> But this is not good since it needs to copy the string to build the
> absolute pathname, and it makes redundant pathname walk (from the /sys)
> in the kernel unnecessarily.  We can use openat(2) to open the file in
> the given directory.
>
> Add a couple of new helper to return the file descriptor of PMU
> directory so that it can use it with relative paths.
>
>  * perf_pmu__event_source_devices_fd()
>    - returns a fd for the PMU root ("/sys/bus/event_source/devices")
>
>  * perf_pmu__pathname_fd()
>    - returns a fd for "<pmu>/<file>" under the PMU root
>
> Now the above code can be converted something like below:
>
>   dirfd =3D perf_pmu__event_source_devices_fd();
>   dir =3D fdopendir(dirfd);
>   while (dentry =3D readdir(dir)) {
>     fd =3D openat(dirfd, dentry->d_name, O_RDONLY);
>     ...
>   }
>
> I added a benchmark for pmu-scan and it showed a slight speedup
> in the normal case too.
>
>   $ ./perf.old bench internals pmu-scan
>   # Running 'internals/pmu-scan' benchmark:
>   Computing performance of sysfs PMU event scan for 100 times
>     Average PMU scanning took: 6670.970 usec (+- 13.022 usec)
>
>   $ ./perf.new bench internals pmu-scan
>   # Running 'internals/pmu-scan' benchmark:
>   Computing performance of sysfs PMU event scan for 100 times
>     Average PMU scanning took: 6296.980 usec (+- 14.891 usec)
>
> The 5~6% of improvement might be small but it may have bigger impact
> when the system is contended.
>
> You can get the code from 'perf/pmu-scan-v1' branch in
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git
>
> Thanks,
> Namhyung

Some nice stack size savings too. The reentrant fix was pre-existing. Serie=
s:
Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> Namhyung Kim (9):
>   perf list: Use relative path for tracepoint scan
>   perf tools: Fix a asan issue in parse_events_multi_pmu_add()
>   perf pmu: Add perf_pmu__destroy() function
>   perf bench: Add pmu-scan benchmark
>   perf pmu: Use relative path for sysfs scan
>   perf pmu: Use relative path in perf_pmu__caps_parse()
>   perf pmu: Use relative path in setup_pmu_alias_list()
>   perf pmu: Add perf_pmu__{open,scan}_file_at()
>   perf intel-pt: Use perf_pmu__scan_file_at() if possible
>
>  tools/perf/arch/x86/util/intel-pt.c |  52 ++++--
>  tools/perf/arch/x86/util/pmu.c      |  13 +-
>  tools/perf/bench/Build              |   1 +
>  tools/perf/bench/bench.h            |   1 +
>  tools/perf/bench/pmu-scan.c         | 184 ++++++++++++++++++
>  tools/perf/builtin-bench.c          |   1 +
>  tools/perf/tests/pmu.c              |   9 +-
>  tools/perf/util/parse-events.c      |   2 +-
>  tools/perf/util/pmu.c               | 278 ++++++++++++++++++++--------
>  tools/perf/util/pmu.h               |  12 +-
>  tools/perf/util/print-events.c      |  26 ++-
>  11 files changed, 466 insertions(+), 113 deletions(-)
>  create mode 100644 tools/perf/bench/pmu-scan.c
>
>
> base-commit: 417c6adfb155f906f0441cc1034827f6e2b3c372
> --
> 2.40.0.348.gf938b09366-goog
>

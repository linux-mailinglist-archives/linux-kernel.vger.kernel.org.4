Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E91A46F2679
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 23:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbjD2VCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 17:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjD2VCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 17:02:10 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C82D1997
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 14:02:06 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-32f4e0f42a7so295035ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 14:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682802125; x=1685394125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WpzsyG65Q6wbW3VKw2zdL/sAWMWDjU/AwwPSbLiyPYw=;
        b=gr2sv8uFyYuMOKVwad4npbupff+oa4Xobk3nrQWpMBqulnGRrllbD1k3bOtbXNOHOk
         819SCSgaLcbKcnnr0356lMMFT+xo8fR8H97qgi1kKo2T+Mb2BGKeDdHBZd+1wy3uL6zD
         G1DrSuVVU4gbSngUaWrENnSWIzaYQRx4HmSjAGs0faq3drdEmilhUEh1xpoZVVCJ5Moa
         YMR0ucuwdG9kcOBFJU6E0zjgIjFUDNtZyqTOw9rYt2vaiT6DFSe3g2Uxh8CWJXkgDyMN
         8fBjN8Bnor6qyI7QxfVCPKftWV60wtd1AIhrb+emyxSX531lStNScCoKvL2vKr61X38A
         aIiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682802125; x=1685394125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WpzsyG65Q6wbW3VKw2zdL/sAWMWDjU/AwwPSbLiyPYw=;
        b=MRzPR6RT1MEM9yFA6TMFXAxpBuaf7G5eo2AyjnboYsLtlxLkPUX+BWwQRY5pVQ9ZDu
         BjlyacWgT1Y5Yl/YhSe4D3pGwDZZhstfLhQ5rmm5jfwHrgrFT/wtZSvzrLdFPgdG1AIo
         3raFzbGSHTfy3ZDzJgzlOMqiRol7mo0ZV+n0SgkJJDxv6694ZcUqI12lEByvboRBM/7i
         qmn3LHcJ1I/5gjG0tL+KJaUfja8yC+/j0ZGiGh2RVF+88Nq3iM/djT9pdtDYs9GUFPC8
         UeBkVR5ffvsWKJ5q1wWYmk+2UC+QTaI/J2gNqysysr3ipTgHofTUYhww5Q0HuZUo5S23
         m+5A==
X-Gm-Message-State: AC+VfDxe0IRk9oU+RmBY9niT/LumVOxgpsBsjUBgly4ROrhOCIkt3hk7
        F3fPHWT/927VG+zqmFpb6QzuYMZhPY6O+pZjmbv6aA==
X-Google-Smtp-Source: ACHHUZ6/QErfgNLoYp0FQiQuiCfqJnBan2fToPNDl9aCZG3QeLYwipqJ1dP6etYKjx3rhGQB34DTY+n2a+kimFb8bvw=
X-Received: by 2002:a05:6e02:1a2e:b0:32b:1de1:17de with SMTP id
 g14-20020a056e021a2e00b0032b1de117demr208219ile.2.1682802125210; Sat, 29 Apr
 2023 14:02:05 -0700 (PDT)
MIME-Version: 1.0
References: <1682329456-19418-1-git-send-email-renyu.zj@linux.alibaba.com>
In-Reply-To: <1682329456-19418-1-git-send-email-renyu.zj@linux.alibaba.com>
From:   Ian Rogers <irogers@google.com>
Date:   Sat, 29 Apr 2023 14:01:52 -0700
Message-ID: <CAP-5=fX1E_qZwmch-gKcarLGkWwmxZj9dM2XuQKrBLeDRfqg7Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Add JSON metrics for arm CMN and Yitian710 DDR
To:     Jing Zhang <renyu.zj@linux.alibaba.com>
Cc:     John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org,
        Zhuo Song <zhuo.song@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2023 at 2:44=E2=80=AFAM Jing Zhang <renyu.zj@linux.alibaba.=
com> wrote:
>
> Changes since RFC:
> - Refact arm-cmn PMU identifier.
> - Not add arm-cmn PMU aliasing currently because it's Eventcode is
>   difficult to define.
> - Rename ali_drw PMU identifier and Unit name.
> - Divide ali_drw PMU metric and aliasing into two patches.
>
> Add an identifier sysfs file for the yitian710 SoC DDR and arm CMN to
> allow userspace to identify the specific implementation of the device,
> so that the perf tool can match the corresponding uncore events and
> metrics through the identifier. Then added several general CMN700 metrics
> and yitian710 soc DDR metrics.
>
> $perf list:
> ...
> ali_drw:
>   hif_rmw
>        [A Read-Modify-Write Op at HIF interface. 64B. Unit: ali_drw]
>   hif_hi_pri_rd
>        [A high priority Read at HIF interface. 64B. Unit: ali_drw]
>   hif_rd
>        [A Read Op at HIF interface. 64B. Unit: ali_drw]
>   hif_rd_or_wr
>        [A Write or Read Op at HIF interface. 64B. Unit: ali_drw]
>   hif_wr
>        [A Write Op at HIF interface. 64B. Unit: ali_drw]
> ...
>
> $perf stat -M ddr_read_bandwidth.all ./test
>
> Performance counter stats for 'system wide':
>
>             38,150      hif_rd        #  2.4 MB/s  ddr_read_bandwidth.all
>      1,000,957,941 ns   duration_time
>
>        1.000957941 seconds time elapsed
>
> Jing Zhang (5):
>   driver/perf: Add identifier sysfs file for CMN
>   perf vendor events: Add JSON metrics for CMN-700
>   driver/perf: Add identifier sysfs file for Yitian 710 DDR
>   perf jevents: Add support for Yitian 710 DDR PMU aliasing
>   perf vendor events: Add JSON metrics for Yitian 710 DDR

The perf tool changes all make sense. John Garry is more of an expert
on the ARM part of this than me though.
Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

>  drivers/perf/alibaba_uncore_drw_pmu.c              |  27 ++
>  drivers/perf/arm-cmn.c                             |  49 +++
>  .../arch/arm64/arm/cmn700/sys/metrics.json         |  74 ++++
>  .../arm64/freescale/yitian710/sys/ali_drw.json     | 373 +++++++++++++++=
++++++
>  .../arm64/freescale/yitian710/sys/metrics.json     |  20 ++
>  tools/perf/pmu-events/jevents.py                   |   2 +
>  6 files changed, 545 insertions(+)
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cmn700/sys/metri=
cs.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/yitian710/=
sys/ali_drw.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/yitian710/=
sys/metrics.json
>
> --
> 1.8.3.1
>

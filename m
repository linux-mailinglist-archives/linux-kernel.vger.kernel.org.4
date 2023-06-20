Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF6F47374E0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 21:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbjFTTE5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 20 Jun 2023 15:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbjFTTEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 15:04:45 -0400
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB0494;
        Tue, 20 Jun 2023 12:04:44 -0700 (PDT)
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-77e364a9a87so146973239f.3;
        Tue, 20 Jun 2023 12:04:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687287883; x=1689879883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qRkodGX0aqajT2WrVBIl/TXSiJnu1TTBK12nUg6B4M4=;
        b=jVyGD6Ue5vV8/LOpz4SbS/AwB4gf0VIqOOug5o5GXqm+eBvuhz6IkDMGKsMrQSe2Kh
         8fuIVD79R3xBCghr+BXioEzlZVltUINJ8x+T0sjPY/xqev3M5jI318pFtO3pf+T+m5Ui
         JsEqxeDX6BBbLAU08XKVGUftAl1x82XC9T4gjMJyIB0IZJcuNbJi4FeXt1vsBhIYEvQe
         6wijGwA86YAgDqKjKg8tiqziWkG2/yNP0DKTGzlLucihqfUu9LKREPcg3PLoO8G/biPs
         +mtqMKLuVeCRB+TlQL3XVhiCSNhmlGY3Uoo+SXCWVCaWaSQ1toP4yIDsCwCdVMQvYfgq
         WkDA==
X-Gm-Message-State: AC+VfDy4vW/+W0j1JDKOP0t1ySDj4+A2uaCcaL1xMSHUCbxkLQGw0vti
        mnYpkNZ8B1l7DL77rV4pQGBvh7kT0eoaTq7wIAA=
X-Google-Smtp-Source: ACHHUZ5dnlrfdyRHtp6eHjOUTrC6h1aftRAXpdjUTAQrvx9KDxH+XgxKDVdIo+zFgJ+Cr97RDtLu80N8qByWL8A+6IM=
X-Received: by 2002:a6b:f102:0:b0:763:b459:a701 with SMTP id
 e2-20020a6bf102000000b00763b459a701mr14493358iog.1.1687287883261; Tue, 20 Jun
 2023 12:04:43 -0700 (PDT)
MIME-Version: 1.0
References: <1687245156-61215-1-git-send-email-renyu.zj@linux.alibaba.com>
In-Reply-To: <1687245156-61215-1-git-send-email-renyu.zj@linux.alibaba.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 20 Jun 2023 12:04:31 -0700
Message-ID: <CAM9d7cj3v58m8NcsEK4sYsk_dbQDAq71hYo7DV=xaQa_rZyPYg@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] Add JSON metrics for Yitian710 DDR
To:     Jing Zhang <renyu.zj@linux.alibaba.com>
Cc:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        John Garry <john.g.garry@oracle.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Ian Rogers <irogers@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org,
        Zhuo Song <zhuo.song@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Jun 20, 2023 at 12:17 AM Jing Zhang <renyu.zj@linux.alibaba.com> wrote:
>
> Hi all,
>
> I add an identifier sysfs file for the yitian710 SoC DDR to allow
> userspace to identify the specific implementation of the device,
> so that the perf tool can match the corresponding uncore events and
> metrics through the identifier. Then added yitian710 SoC DDR
> metrics and events alias.
>
> Change since v3:
> - Split the CMN and ali_drw patches. This patchset only contains
>   ali_drw PMU related patches. The CMN metric related patches will
>   be in another patchset.
> - Link: https://lore.kernel.org/all/1685438374-33287-1-git-send-email-renyu.zj@linux.alibaba.com/
>
> $perf list:
> ...
> ali_drw:
>   chi_rxdat
>        [A packet at CHI RXDAT interface (write data). Unit: ali_drw]
>   chi_rxrsp
>        [A packet at CHI RXRSP interface. Unit: ali_drw]
>   chi_txdat
>        [A packet at CHI TXDAT interface (read data). Unit: ali_drw]
>   chi_txreq
>        [A packet at CHI TXREQ interface (request). Unit: ali_drw]
>   cycle
>        [The ddr cycle. Unit: ali_drw]
> ...
> ali_drw:
>   ddr_read_bandwidth.all
>        [The ddr read bandwidth(MB/s). Unit: ali_drw ]
>   ddr_write_bandwidth.all
>        [The ddr write bandwidth(MB/s). Unit: ali_drw ]
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
> Jing Zhang (4):
>   driver/perf: Add identifier sysfs file for Yitian 710 DDR
>   perf jevents: Add support for Yitian 710 DDR PMU aliasing
>   perf vendor events: Add JSON metrics for Yitian 710 DDR
>   docs: perf: Update metric usage for Alibaba's T-Head PMU driver

So patch 1 is for the kernel, and patch 2-4 depend on it, right?

I'm curious why the first patch is needed, presumably the PMU
should have 'ali_drw' in the name already.  Do we use substring
match for the compat name in the JSON metric?

Thanks,
Namhyung

>
>  Documentation/admin-guide/perf/alibaba_pmu.rst     |   5 +
>  drivers/perf/alibaba_uncore_drw_pmu.c              |  27 ++
>  .../arm64/freescale/yitian710/sys/ali_drw.json     | 373 +++++++++++++++++++++
>  .../arm64/freescale/yitian710/sys/metrics.json     |  20 ++
>  tools/perf/pmu-events/jevents.py                   |   1 +
>  5 files changed, 426 insertions(+)
>  create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/yitian710/sys/ali_drw.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/yitian710/sys/metrics.json
>
> --
> 1.8.3.1
>

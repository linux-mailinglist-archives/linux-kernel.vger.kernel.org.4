Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D65E2743023
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 00:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbjF2WIq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 29 Jun 2023 18:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjF2WIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 18:08:44 -0400
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D25C71BDB;
        Thu, 29 Jun 2023 15:08:42 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-c413d8224e3so54498276.0;
        Thu, 29 Jun 2023 15:08:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688076522; x=1690668522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BL7VqxKomzdMLSFIfqy41Rb4lDArQ9pvzshCeviE3a8=;
        b=UZ6KCznqMqhvOxapJloR2wyK9YymTc1inpfXEbQCP6g5rsSFZZQRQMxI5641PTHnEh
         gP2EmG1ytNofPCbcBzf+slzTCroI6HEBeWwFtx09gPSGZImD72hYFt2kEsiePfMipq+1
         WNS7px9FKlCP+I/daYoDnchPhXeqjm6JOuFIt3EzG994Z2usUJkCKU8Dy5qA1JSi/5jk
         NvqgYTNL/L4+Xzo4Fmsb8y1PAe0lNMYReKHkFv/Sz+QF5YmE8LMKo7J0hO39gLbCxfCl
         edQrNSxzNTeI0MpxywRCnyZ2Zr9aPSEdPUIAKnLf+JDrzp5qBEKeVsoFFQwr7244EEck
         1JlQ==
X-Gm-Message-State: ABy/qLYiMP8u46AQ/QDlzD/uKDRajvb66mYOVavOmJpxSCF4P7vMqVZq
        eUrZnH+Fsvbt8WcL55JLhzaqZDNKuhMr13S8dGw=
X-Google-Smtp-Source: APBJJlH+qevXON7QcPePSKwWTm7z+StA2xVdgCCACPBAmRctOn6Y0nq11V7P6TQiLjZFYqIBxkk7A5itAEW4yjTukQc=
X-Received: by 2002:a25:d390:0:b0:c0b:7483:5ced with SMTP id
 e138-20020a25d390000000b00c0b74835cedmr1002412ybf.33.1688076521872; Thu, 29
 Jun 2023 15:08:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230628102949.2598096-1-john.g.garry@oracle.com>
In-Reply-To: <20230628102949.2598096-1-john.g.garry@oracle.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 29 Jun 2023 15:08:30 -0700
Message-ID: <CAM9d7ciBWjNHOfouNKSFy2q88Cs4-6F8EjGqGpFdwb6QTShaew@mail.gmail.com>
Subject: Re: [PATCH RFC 0/9] perf tool: sys event metric support re-write
To:     John Garry <john.g.garry@oracle.com>
Cc:     acme@kernel.org, irogers@google.com, jolsa@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        renyu.zj@linux.alibaba.com, shangxiaojing@huawei.com,
        zhangshaokun@hisilicon.com, qiangqing.zhang@nxp.com,
        kjain@linux.ibm.com, kan.liang@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Jun 28, 2023 at 3:30 AM John Garry <john.g.garry@oracle.com> wrote:
>
> The current sys event metric support has some issues, like:
> - It is broken that we only match a metric based on PMU compat, but not
>   Unit as well, as reported by Jing Zhang <renyu.zj@linux.alibaba.com>
> - No real self-test support
> - Not able to use resolvable metrics
> - Need to specify event PMU Unit and Compat for metric, which should not
>   be necessary
>
> This series changes sys event metric support to match metrics based on
> evaluating each term in the metric expression and then ensuring it
> matches an event from the same associated pmu_sys_events table.
>
> Why an RFC?
> - Even though main motivation here was to improve self-test support, that
>   has proved quite tricky and nothing has been added yet.
>   My desire is to test the feature that we match metrics for a specific
>   SoC when PMUs with matching HW identifier are present. So I would hope
>   to add sys metrics for many SoCs in ../pmu-events/arch/test/
> - I still need to suppress logs from metricgroup_sys_metric_supported()
>   indirect calls to functions like parse_events_multi_pmu_add(),
>   generating logs like
>   "smmuv3_pmcg.wr_sent_sp -> smmuv3_pmcg_50/event=0x86/" - we should only
>   see those logs for when really adding the metric in calling add_metric()
>
> Based on 82fe2e45cdb0 (acme/tmp.perf/core, acme/tmp.perf-tools-next, acme/perf/core, acme/perf-tools-next) perf pmus: Check if we can encode the PMU number in perf_event_attr.type

We moved to new repos from acme to perf/perf-tools and perf/perf-tools-next.
You'd better rebase the series onto perf-tools-next (branch name is the same).

Thanks,
Namhyung


>
> John Garry (9):
>   perf metrics: Delete metricgroup_add_iter_data.table
>   perf metrics: Don't iter sys metrics if we already found a CPU match
>   perf metrics: Pass cpu and sys tables to metricgroup__add_metric()
>   perf jevents: Add sys_events_find_events_table()
>   perf pmu: Refactor pmu_add_sys_aliases_iter_fn()
>   perf metrics: Add metricgroup_sys_metric_supported()
>   perf metrics: Test metric match in metricgroup__sys_event_iter()
>   perf metrics: Stop metricgroup__add_metric_sys_event_iter if already
>     matched
>   perf vendor events arm64: Remove unnecessary metric Unit and Compat
>     specifiers
>
>  .../arm64/freescale/imx8mm/sys/metrics.json   |   4 -
>  .../arm64/freescale/imx8mn/sys/metrics.json   |   4 -
>  .../arm64/freescale/imx8mq/sys/metrics.json   |   4 -
>  .../arm64/hisilicon/hip09/sys/uncore-cpa.json |   4 -
>  tools/perf/pmu-events/empty-pmu-events.c      |   6 +
>  tools/perf/pmu-events/jevents.py              |  11 ++
>  tools/perf/pmu-events/pmu-events.h            |   3 +
>  tools/perf/tests/expand-cgroup.c              |   2 +-
>  tools/perf/tests/parse-metric.c               |   2 +-
>  tools/perf/tests/pmu-events.c                 |  29 ++-
>  tools/perf/util/metricgroup.c                 | 182 +++++++++++++++---
>  tools/perf/util/metricgroup.h                 |   3 +-
>  tools/perf/util/pmu.c                         |  20 +-
>  tools/perf/util/pmu.h                         |   2 +
>  14 files changed, 220 insertions(+), 56 deletions(-)
>
> --
> 2.35.3
>

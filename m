Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC6EB644BD2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 19:34:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbiLFSec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 13:34:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbiLFSd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 13:33:57 -0500
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897DAB0
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 10:32:47 -0800 (PST)
Received: by mail-io1-f44.google.com with SMTP id n63so5836264iod.7
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 10:32:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yJNdYg7nhpbE7eLuWkPjftG0OmGqzbWfULhFDpv/6vs=;
        b=JrbRLMkBpubKgDIZjre7dk21SPDob7CR7hjoyZEq1BaUElRV+SN9tfafvWZ10PxByk
         ha4vc+2o0iwSi07yAom/2L0n61MCt8gzWTqdtrWCh0HTHro4RuZgEXLyIxq+VJp61L3c
         fNQCtoq7deldJH6w+OrSE/TQ+uu8JQDZkHsGPBgtFJJHSHm8ydZW3WbjPruCkI+kMgNh
         Oy5SUbjUKXMf9ARyreRAlg3Iq60XSQK2Li98JlixcL7iGXqAuVIhwsA353VsPJXCp75g
         iREFQqaV5LtB0bi2GsUoC0KYrU52RRBYukS65UWmMtWtdEj3ceH82w00rCbzJrKcQVub
         W91w==
X-Gm-Message-State: ANoB5plGygS24ElCTyzIy3Ol/nhquhCH+THX6WLh4eTvMRQYFIJQahgQ
        qacJ1lj5ydeLfNkT81KvM/S5iQvZUcOwav1QY6A=
X-Google-Smtp-Source: AA0mqf5SBrThAm6G7KbpJFc4fzXog7XjJkQw7NSGBNRIVH+3GBO1TxlvAGT4qbZ6Aj4KdhFj9+CNwR4mG51adwLiprQ=
X-Received: by 2002:a02:7409:0:b0:375:4727:8625 with SMTP id
 o9-20020a027409000000b0037547278625mr33264537jac.300.1670351566715; Tue, 06
 Dec 2022 10:32:46 -0800 (PST)
MIME-Version: 1.0
References: <20221206154406.41941-1-petar.gligor@gmail.com>
In-Reply-To: <20221206154406.41941-1-petar.gligor@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 6 Dec 2022 10:32:35 -0800
Message-ID: <CAM9d7cizPC3p0-Z1oYsDPofwNfZHyKYiJR5JXEcS31Q=mgzcLg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] perf: introduce perf based task analyzer
To:     Petar Gligoric <petar.gligor@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Petar Gligoric <petar.gligoric@rohde-schwarz.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Dec 6, 2022 at 7:44 AM Petar Gligoric <petar.gligor@gmail.com> wrote:
>
> From: Petar Gligoric <petar.gligoric@rohde-schwarz.com>
>
> This patch-series introduces the task analyzer and adds the feature to
> output csv files for further analysis in thirds party script
> (e.g. pandas and friends).
>
> The task analyzer dissects recorded perf.data files based on
> sched:sched_switch events. It outputs useful information for the user
> of each task, like times between schedule in/schedule out of the same
> task.
>
>     Switched-In      Switched-Out CPU      PID      TID             Comm    Runtime     Time Out-In
> 15576.658891407   15576.659156086   4     2412     2428            gdbus        265            1949
> 15576.659111320   15576.659455410   0     2412     2412      gnome-shell        344            2267
> 15576.659491326   15576.659506173   2       74       74      kworker/2:1         15           13145
> [...]
>
> The user can modify the output to his liking and his necessity. He can
> either limit the output to tasks he wants or filter tasks he does not
> present in the output. The output can also be limited via the time or
> specific tasks can be highlight via colors. A combination of those
> options is also possible.
> Additionally the user can print out a summary of all tasks, which is a
> table of information from all tasks throughout the whole trace.
> Information, like total runtime, how many times the tasks have been
> scheduled in, what the max runtime was and when it occurred, just to
> name few.
>
> Summary
>     Task Information                       Runtime Information
> PID   TID            Comm Runs Accumulated    Mean  Median  Min   Max          Max At
>  14    14     ksoftirqd/0   13         334      26      15    9   127 15571.621211956
>  15    15     rcu_preempt  133        1778      13      13    2    33 15572.581176024
>  16    16     migration/0    3          49      16      13   12    24 15571.608915425
> [...]
>
> The standard task as well as the summary can be printed in either
> nanoseconds, milliseconds or microseconds(standard).
> Both standard as well as summary can be saved in a user specified file
> in csv format.

Have you looked at 'perf sched timehist' ?
I think it has the common functionality and can be easily extended if there's
missing one.

Thanks,
Namhyung

>
> v2:
>  - Add tests for new perf task-analyzer suggested by Ian Rogers
>
> Hagen Paul Pfeifer (1):
>   perf script: introduce task analyzer
>
> Petar Gligoric (2):
>   perf script: task-analyzer add csv support
>   perf test: Add new task-analyzer tests
>
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
>
>  .../scripts/python/bin/tasks-analyzer-record  |   2 +
>  .../scripts/python/bin/tasks-analyzer-report  |   3 +
>  tools/perf/scripts/python/tasks-analyzer.py   | 937 ++++++++++++++++++
>  3 files changed, 942 insertions(+)
>  create mode 100755 tools/perf/scripts/python/bin/tasks-analyzer-record
>  create mode 100755 tools/perf/scripts/python/bin/tasks-analyzer-report
>  create mode 100755 tools/perf/scripts/python/tasks-analyzer.py
> --
> 2.30.2
>

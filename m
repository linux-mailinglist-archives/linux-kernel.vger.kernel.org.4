Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5E862CE79
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 00:05:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233727AbiKPXFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 18:05:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbiKPXFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 18:05:05 -0500
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B926317CD;
        Wed, 16 Nov 2022 15:05:05 -0800 (PST)
Received: by mail-ot1-f51.google.com with SMTP id db10-20020a0568306b0a00b0066d43e80118so32697otb.1;
        Wed, 16 Nov 2022 15:05:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sch7gU4JnEJeZm0TBzlZLEZhC+3AQoj3+UVYWjWRf4Y=;
        b=VWxEk9L4tyQ8ZIkHG3Eat02HjroRu2diUWrcuAAa26m82dYJ9p7O1D9jLG8DJ1gp98
         2SGOaysvYYk5VsZy1lTsVF5gBAjAFR8w0Y7AaxX6webhD1H9wasdunPprxoOsF6nYEHM
         Upw4sCmes+DX3Vf3IwhyZG5xJuYZzFa1UnNRoxDUNfWhXwhrnJYIQyeLAb55FyHycMZe
         5ZiebClQRbfxm9mC53Fc1swB5G694C6tDx32TGtH7lO+zakIHRxmbpWQev6z1CC6iNou
         V8aGUEIYVLk3XQVAMt8VLRCOZ6nUy55QC1irQawLJA4WgVKDzo52uufxq7sCags1zpSK
         xlvg==
X-Gm-Message-State: ANoB5pnv0XPJpYSC8bJsQ5evv+TdKnHirhbiU9KscrC6IcREh4g9bHfu
        uqNAZWKsHg4banNCl52UQTBCGSphGtiuwggbuaXCOUsC
X-Google-Smtp-Source: AA0mqf7TtJVP83TCvzFw7lohwMhWEajHyRUN2mHS1nCyxot6jnARFVNR6lxYPj/Vz0BYXz65jqK06TvbSxJFTIxBW0g=
X-Received: by 2002:a05:6830:1215:b0:66d:78b8:7b1a with SMTP id
 r21-20020a056830121500b0066d78b87b1amr175243otp.206.1668639904228; Wed, 16
 Nov 2022 15:05:04 -0800 (PST)
MIME-Version: 1.0
References: <20221114210723.2749751-1-irogers@google.com> <20221114210723.2749751-11-irogers@google.com>
 <Y3OX1pcclKCgbpeT@kernel.org>
In-Reply-To: <Y3OX1pcclKCgbpeT@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 16 Nov 2022 15:04:52 -0800
Message-ID: <CAM9d7ch3SkBzjXUsGXKTqQzAkvCpm1jOmf5YEf609t1v=4v0wg@mail.gmail.com>
Subject: Re: [PATCH v3 10/10] perf list: Add json output option
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Weilin Wang <weilin.wang@intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Xin Gao <gaoxin@cdjrlc.com>, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Nov 15, 2022 at 5:44 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Mon, Nov 14, 2022 at 01:07:23PM -0800, Ian Rogers escreveu:
> > Output events and metrics in a json format by overriding the print
> > callbacks. Currently other command line options aren't supported and
> > metrics are repeated once per metric group.
>
> Applied the patch with a few fixes and added this to the last cset:
>
> commit c9367a0658ebcfe8ab0bc4af2648f144c64b53a4
> Author: Ian Rogers <irogers@google.com>
> Date:   Mon Nov 14 13:07:23 2022 -0800
>
>     perf list: Add JSON output option
>
>     Output events and metrics in a JSON format by overriding the print
>     callbacks. Currently other command line options aren't supported and
>     metrics are repeated once per metric group.
>
>     Committer testing:
>
>       $ perf list cache
>
>       List of pre-defined events (to be used in -e or -M):
>
>         L1-dcache-load-misses                              [Hardware cache event]
>         L1-dcache-loads                                    [Hardware cache event]
>         L1-dcache-prefetches                               [Hardware cache event]
>         L1-icache-load-misses                              [Hardware cache event]
>         L1-icache-loads                                    [Hardware cache event]
>         branch-load-misses                                 [Hardware cache event]
>         branch-loads                                       [Hardware cache event]
>         dTLB-load-misses                                   [Hardware cache event]
>         dTLB-loads                                         [Hardware cache event]
>         iTLB-load-misses                                   [Hardware cache event]
>         iTLB-loads                                         [Hardware cache event]
>       $ perf list --json cache
>       [
>       {
>               "Unit": "cache",

It's confusing to call it 'unit', but we have it in the JSON metrics, sigh..

Thanks,
Namhyung


>               "EventName": "L1-dcache-load-misses",
>               "EventType": "Hardware cache event"
>       },
>       {
>               "Unit": "cache",
>               "EventName": "L1-dcache-loads",
>               "EventType": "Hardware cache event"
>       },
>       {
>               "Unit": "cache",
>               "EventName": "L1-dcache-prefetches",
>               "EventType": "Hardware cache event"
>       },
>       {
>               "Unit": "cache",
>               "EventName": "L1-icache-load-misses",
>               "EventType": "Hardware cache event"
>       },
>       {
>               "Unit": "cache",
>               "EventName": "L1-icache-loads",
>               "EventType": "Hardware cache event"
>       },
>       {
>               "Unit": "cache",
>               "EventName": "branch-load-misses",
>               "EventType": "Hardware cache event"
>       },
>       {
>               "Unit": "cache",
>               "EventName": "branch-loads",
>               "EventType": "Hardware cache event"
>       },
>       {
>               "Unit": "cache",
>               "EventName": "dTLB-load-misses",
>               "EventType": "Hardware cache event"
>       },
>       {
>               "Unit": "cache",
>               "EventName": "dTLB-loads",
>               "EventType": "Hardware cache event"
>       },
>       {
>               "Unit": "cache",
>               "EventName": "iTLB-load-misses",
>               "EventType": "Hardware cache event"
>       },
>       {
>               "Unit": "cache",
>               "EventName": "iTLB-loads",
>               "EventType": "Hardware cache event"
>       }
>       ]
>       $
>
>     Signed-off-by: Ian Rogers <irogers@google.com>
>     Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>     Cc: Adrian Hunter <adrian.hunter@intel.com>
>     Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>     Cc: Caleb Biggers <caleb.biggers@intel.com>
>     Cc: Jiri Olsa <jolsa@kernel.org>
>     Cc: Kajol Jain <kjain@linux.ibm.com>
>     Cc: Kan Liang <kan.liang@linux.intel.com>
>     Cc: Leo Yan <leo.yan@linaro.org>
>     Cc: Mark Rutland <mark.rutland@arm.com>
>     Cc: Namhyung Kim <namhyung@kernel.org>
>     Cc: Perry Taylor <perry.taylor@intel.com>
>     Cc: Peter Zijlstra <peterz@infradead.org>
>     Cc: Ravi Bangoria <ravi.bangoria@amd.com>
>     Cc: Rob Herring <robh@kernel.org>
>     Cc: Sandipan Das <sandipan.das@amd.com>
>     Cc: Stephane Eranian <eranian@google.com>
>     Cc: Weilin Wang <weilin.wang@intel.com>
>     Cc: Xin Gao <gaoxin@cdjrlc.com>
>     Cc: Xing Zhengjun <zhengjun.xing@linux.intel.com>
>     Link: http://lore.kernel.org/lkml/20221114210723.2749751-11-irogers@google.com
>     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

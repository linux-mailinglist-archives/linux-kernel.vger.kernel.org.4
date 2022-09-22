Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A590E5E5986
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 05:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbiIVDSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 23:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbiIVDSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 23:18:01 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F894B07F8
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 20:12:53 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id e10-20020a05600c4e4a00b003b4eff4ab2cso446809wmq.4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 20:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Wd9ftuEwHwKbDkxBGNbylsY5yCJ2iRQCnP9zwsuCZ2o=;
        b=ho7NgWD6lzDtWBRZynC6jNXepKfnr4YDUc2Vy9tfDSm9siA8edqz+K/5LRwPk0Ld3y
         GIIxG6xZ5NHfqE+X0Ts3vTCAja/8jU5FRKBRUhmQXfnIi38SF5wx3qfMdtXm6pDBWeGk
         Fj6cWcJB56pEPdNOoZJNK+CXlbiB1m/x0m8Vgs3Idj6dF9Xh2aFqIvwemkD0WxRPw/ku
         ED9AX3x/RoMZoFbUhGDUkjuS+QUDJhIw7DLDWayxwz1/6FOQzSVjEl8WfHyp8sRN9gND
         1bvSR0fvCs78hWrm+MRs/gT5Fx5P/C+IK2Tfru2f89vXZFDJbfNpVx+y2e/k66XXCXrM
         vSaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Wd9ftuEwHwKbDkxBGNbylsY5yCJ2iRQCnP9zwsuCZ2o=;
        b=Ts6yUNCaPJD/QgS3S2auWEF4D8XuABCSYf68znuXhrfW87IY3EwL35Z9iCq5RGJqM6
         IUz5dPi8yLsaN/EoO+9sSQrwgykGsf8AKbOst8rHFDQ9gOhlS7nljmpQ0g3HmZ8qHbZs
         riQqvjfBWRvQekd9zOQcCmgyCmaxAtn8y5eqn+KFJcSRQiBsrFGZQemjYWsefOPGcf36
         FxJcQdBMtU3gkIDPdyoIbSWA+1+D2H18RE8D6gFNPMq5StFj5P9fe7ZOPLngLFS45tFV
         XDTmsrMFIUEC9+1d/PtWbOO27oyfP2QYAUGB0hRQ9W8kSLAr3pav4cdBYs8PDInb0uud
         aGNw==
X-Gm-Message-State: ACrzQf3ICxrziw/8N/lseC5Kbn4SumEoVcvQVUxHu3FTCr5v4MDuSfVO
        +Tpp8y9cW4EBM6JzQP4CEsgbqUza2RjRaUX2QsZWZw==
X-Google-Smtp-Source: AMsMyM5t3vz/zrrCjjUxW+dnrpnqbYfj/aN9ERUd+QxRtCvGtx2SmkY/F223oIAmZppSgJrYDSFCwDhJv/vwfrJYMp0=
X-Received: by 2002:a7b:c048:0:b0:3b4:fb26:f0f3 with SMTP id
 u8-20020a7bc048000000b003b4fb26f0f3mr3650986wmc.115.1663816371685; Wed, 21
 Sep 2022 20:12:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220922014904.3665674-1-zhengjun.xing@linux.intel.com>
In-Reply-To: <20220922014904.3665674-1-zhengjun.xing@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 21 Sep 2022 20:12:38 -0700
Message-ID: <CAP-5=fUecPUJ-Z5WwbjVgA6b6r3-MmmfpjE+iw_pAK_K+rhxMA@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf print-events: Fix "perf list" can not display
 the PMU prefix for some hybrid cache events
To:     zhengjun.xing@linux.intel.com
Cc:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@intel.com, jolsa@kernel.org,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, ak@linux.intel.com,
        kan.liang@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
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

On Wed, Sep 21, 2022 at 6:47 PM <zhengjun.xing@linux.intel.com> wrote:
>
> From: Zhengjun Xing <zhengjun.xing@linux.intel.com>
>
> Some hybrid hardware cache events are only available on one CPU PMU. For
> example, 'L1-dcache-load-misses' is only available on cpu_core. We have
> supported in the perf list clearly reporting this info, the function works
> fine before but recently the argument "config" in API is_event_supported()
> is changed from "u64" to "unsigned int" which caused a regression, the
> "perf list" then can not display the PMU prefix for some hybrid cache
> events. For the hybrid systems, the PMU type ID is stored at config[63:32],
> define config to "unsigned int" will miss the PMU type ID information, then
> the regression happened, the config should be defined as "u64".
>
> Before:
>  # ./perf list |grep "Hardware cache event"
>   L1-dcache-load-misses                              [Hardware cache event]
>   L1-dcache-loads                                    [Hardware cache event]
>   L1-dcache-stores                                   [Hardware cache event]
>   L1-icache-load-misses                              [Hardware cache event]
>   L1-icache-loads                                    [Hardware cache event]
>   LLC-load-misses                                    [Hardware cache event]
>   LLC-loads                                          [Hardware cache event]
>   LLC-store-misses                                   [Hardware cache event]
>   LLC-stores                                         [Hardware cache event]
>   branch-load-misses                                 [Hardware cache event]
>   branch-loads                                       [Hardware cache event]
>   dTLB-load-misses                                   [Hardware cache event]
>   dTLB-loads                                         [Hardware cache event]
>   dTLB-store-misses                                  [Hardware cache event]
>   dTLB-stores                                        [Hardware cache event]
>   iTLB-load-misses                                   [Hardware cache event]
>   node-load-misses                                   [Hardware cache event]
>   node-loads                                         [Hardware cache event]
>
> After:
>  # ./perf list |grep "Hardware cache event"
>   L1-dcache-loads                                    [Hardware cache event]
>   L1-dcache-stores                                   [Hardware cache event]
>   L1-icache-load-misses                              [Hardware cache event]
>   LLC-load-misses                                    [Hardware cache event]
>   LLC-loads                                          [Hardware cache event]
>   LLC-store-misses                                   [Hardware cache event]
>   LLC-stores                                         [Hardware cache event]
>   branch-load-misses                                 [Hardware cache event]
>   branch-loads                                       [Hardware cache event]
>   cpu_atom/L1-icache-loads/                          [Hardware cache event]
>   cpu_core/L1-dcache-load-misses/                    [Hardware cache event]
>   cpu_core/node-load-misses/                         [Hardware cache event]
>   cpu_core/node-loads/                               [Hardware cache event]
>   dTLB-load-misses                                   [Hardware cache event]
>   dTLB-loads                                         [Hardware cache event]
>   dTLB-store-misses                                  [Hardware cache event]
>   dTLB-stores                                        [Hardware cache event]
>   iTLB-load-misses                                   [Hardware cache event]
>
> Fixes: 9b7c7728f4e4 ("perf parse-events: Break out tracepoint and printing")
> Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Acked-by: Ian Rogers <irogers@google.com>

Sorry for this breakage, I suspect that a long review on the
refactoring CL meant that I missed the intervening fix. Can we add a
test on this? It would need to be hybrid specific and skip otherwise.

Thanks,
Ian

> ---
>  tools/perf/util/print-events.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/print-events.c b/tools/perf/util/print-events.c
> index ba1ab5134685..04050d4f6db8 100644
> --- a/tools/perf/util/print-events.c
> +++ b/tools/perf/util/print-events.c
> @@ -239,7 +239,7 @@ void print_sdt_events(const char *subsys_glob, const char *event_glob,
>         strlist__delete(sdtlist);
>  }
>
> -static bool is_event_supported(u8 type, unsigned int config)
> +static bool is_event_supported(u8 type, u64 config)
>  {
>         bool ret = true;
>         int open_return;
> --
> 2.25.1
>

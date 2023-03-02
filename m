Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AAA26A8B86
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 23:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjCBWKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 17:10:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjCBWK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 17:10:29 -0500
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FEEF15568;
        Thu,  2 Mar 2023 14:10:28 -0800 (PST)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-536be69eadfso8858597b3.1;
        Thu, 02 Mar 2023 14:10:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677795028;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zhQo+b+1L2wPuwPzC2ELNrP0CnHtD1+PEmOhfxOBoQU=;
        b=KHwQe6NIzphc1VNd4yxdEeKGpJWfySzJP0mDqseWe/OeKo2F3QrVBB/6YKJNMF7dzS
         mgCZTTuwyBce55Rnh9TM85Yq63L6U6vBDiyMyL1hUn2gTA9tATojdOw3+V54F/W0un2Q
         n/UsL43t9/Xw6CYfABqk0J0ze8Eqe0H2xKIw8SD1nXCumg7AOBRb6zImyvxhEjz9JhOg
         ZJyVkxbAQn6IL9GmlPiD98KdHBFaRxd/+6XLTJadkBko44ijTseG3eVufLqrRbCUE0ld
         RBSIMsB0xmjNeo38Yi4UY2guzl2df8IcHV6xaGCKMD4Qsyk0PoeMJ33w9eITP4XhV7WQ
         Qt1g==
X-Gm-Message-State: AO0yUKWm24W4yKshFVy7tibdO4OFQsrt/vlEnLTN44fxFrDysqzY3r1g
        lDVK55yYfsmwTnorTA754BJjilLDXv0eSahtr0I=
X-Google-Smtp-Source: AK7set+T4K6DFTJ2cBU3SFmBEfq0p84TKpv76uCYD+Bugbz6Adt1eE0eqkhewHa2Qr4TzZYALgnzvNKpebxbk/AjZkI=
X-Received: by 2002:a81:b609:0:b0:52f:24ac:9575 with SMTP id
 u9-20020a81b609000000b0052f24ac9575mr7051994ywh.3.1677795027610; Thu, 02 Mar
 2023 14:10:27 -0800 (PST)
MIME-Version: 1.0
References: <20230302092109.367-1-ravi.bangoria@amd.com> <20230302092109.367-2-ravi.bangoria@amd.com>
In-Reply-To: <20230302092109.367-2-ravi.bangoria@amd.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 2 Mar 2023 14:10:16 -0800
Message-ID: <CAM9d7cjEvjcYwjA+HfsDHKDX8FGZCECTZ8vDMPHBUSqfQSCOfA@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf/ibs: Fix interface via core pmu events
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     peterz@infradead.org, eranian@google.com, acme@kernel.org,
        mark.rutland@arm.com, jolsa@kernel.org, irogers@google.com,
        bp@alien8.de, x86@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, sandipan.das@amd.com,
        ananth.narayan@amd.com, santosh.shukla@amd.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ravi,

On Thu, Mar 2, 2023 at 1:22 AM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
>
> Although, IBS pmu can be invoked via it's own interface, indirect
> IBS invocation via core pmu event is also supported with fixed set
> of events: cpu-cycles:p, r076:p (same as cpu-cycles:p) and r0C1:p
> (micro-ops) for user convenience.
>
> This indirect IBS invocation is broken since commit 66d258c5b048
> ("perf/core: Optimize perf_init_event()"), which added RAW pmu
> under pmu_idr list and thus if event_init() fails with RAW pmu,
> it started returning error instead of trying other pmus.
>
> Fix it by introducing new pmu capability PERF_PMU_CAP_FORWARD_EVENT.
> Kernel will try to open event on other pmus if user requested pmu,
> having this capability, fails to open event.
>
> Without patch:
>   $ sudo ./perf record -C 0 -e r076:p -- sleep 1
>   Error:
>   The r076:p event is not supported.
>
> With patch:
>   $ sudo ./perf record -C 0 -e r076:p -- sleep 1
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 0.341 MB perf.data (37 samples) ]
>
> This new capability does not have a notion of forward pmu mapping.
> i.e. it doesn't know which pmu(or set of pmus) the event should be
> forwarded to. As of now, only AMD core pmu forwards a set of events
> to IBS pmu when precise_ip attribute is set and thus trying with all
> pmus works. But if more pmus start using this capability, some sort
> of forward pmu mapping needs to be introduced through which the event
> can directly get forwarded to only mapped pmus. Otherwise, trying all
> pmus can inadvertently open event on wrong pmu.
>
> Fixes: 66d258c5b048 ("perf/core: Optimize perf_init_event()")
> Reported-by: Stephane Eranian <eranian@google.com>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> ---
>  arch/x86/events/amd/core.c   |  5 +++++
>  arch/x86/events/core.c       |  2 ++
>  arch/x86/events/perf_event.h |  3 +++
>  include/linux/perf_event.h   |  1 +
>  kernel/events/core.c         | 11 ++++++++---
>  5 files changed, 19 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
> index 8c45b198b62f..f4c67362cfde 100644
> --- a/arch/x86/events/amd/core.c
> +++ b/arch/x86/events/amd/core.c
> @@ -1264,6 +1264,11 @@ static __initconst const struct x86_pmu amd_pmu = {
>         .cpu_dead               = amd_pmu_cpu_dead,
>
>         .amd_nb_constraints     = 1,
> +       /*
> +        * Raw events with precise attribute set needs to be
> +        * forwarded to IBS pmu.
> +        */
> +       .capabilities           = PERF_PMU_CAP_FORWARD_EVENT,
>  };
>
>  static ssize_t branches_show(struct device *cdev,
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index d096b04bf80e..3f27b44f337a 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -2156,6 +2156,8 @@ static int __init init_hw_perf_events(void)
>         if (err)
>                 goto out1;
>
> +       pmu.capabilities |= x86_pmu.capabilities;
> +
>         if (!is_hybrid()) {
>                 err = perf_pmu_register(&pmu, "cpu", PERF_TYPE_RAW);
>                 if (err)
> diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
> index d6de4487348c..41e792bb442d 100644
> --- a/arch/x86/events/perf_event.h
> +++ b/arch/x86/events/perf_event.h
> @@ -941,6 +941,9 @@ struct x86_pmu {
>         int                             num_hybrid_pmus;
>         struct x86_hybrid_pmu           *hybrid_pmu;
>         u8 (*get_hybrid_cpu_type)       (void);
> +
> +       /* Capabilities that needs to be forwarded to pmu->capabilities */
> +       int                             capabilities;
>  };
>
>  struct x86_perf_task_context_opt {
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index d5628a7b5eaa..4459e0918e28 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -292,6 +292,7 @@ struct perf_event_pmu_context;
>  #define PERF_PMU_CAP_NO_EXCLUDE                        0x0080
>  #define PERF_PMU_CAP_AUX_OUTPUT                        0x0100
>  #define PERF_PMU_CAP_EXTENDED_HW_TYPE          0x0200
> +#define PERF_PMU_CAP_FORWARD_EVENT             0x0400
>
>  struct perf_output_handle;
>
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index a5a51dfdd622..c3f59d937280 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -11633,9 +11633,13 @@ static struct pmu *perf_init_event(struct perf_event *event)
>                         goto fail;
>
>                 ret = perf_try_init_event(pmu, event);
> -               if (ret == -ENOENT && event->attr.type != type && !extended_type) {
> -                       type = event->attr.type;
> -                       goto again;
> +               if (ret == -ENOENT) {
> +                       if (event->attr.type != type && !extended_type) {
> +                               type = event->attr.type;
> +                               goto again;
> +                       }
> +                       if (pmu->capabilities & PERF_PMU_CAP_FORWARD_EVENT)
> +                               goto try_all;

Wouldn't it be better to use a different error code to indicate
it's about precise_ip (or forwarding in general)?  Otherwise
other invalid config might cause the forwarding unnecessarily..

Thanks,
Namhyung


>                 }
>
>                 if (ret)
> @@ -11644,6 +11648,7 @@ static struct pmu *perf_init_event(struct perf_event *event)
>                 goto unlock;
>         }
>
> +try_all:
>         list_for_each_entry_rcu(pmu, &pmus, entry, lockdep_is_held(&pmus_srcu)) {
>                 ret = perf_try_init_event(pmu, event);
>                 if (!ret)
> --
> 2.39.2
>

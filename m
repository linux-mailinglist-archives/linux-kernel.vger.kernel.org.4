Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7394D5FBA31
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 20:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbiJKSVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 14:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbiJKSVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 14:21:12 -0400
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995C876444
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 11:21:07 -0700 (PDT)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-1324e7a1284so16894834fac.10
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 11:21:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ykVcV3A400m9NxlSb65FAH9wpHldwOsYk0FbUGPxnrE=;
        b=uvKq5Y+obbuTfxr3h1OCNfTlSraKqhN0K71Z5pRc9PaCFUkDNDxu/CNIjQ2F1C1Ekv
         WhMQocTcSpgul+k83iqzPAedJ18WNN+/PEZBU/wQGQrOV6l6TnH5o0u5FPGhtL061a3h
         B7S/40k2rpB7e/ssIXKJSPwbPENK4nxmOgMA1FtL9bO7vV+dbHNpL8etGep+AAbXT6dc
         bSXgHKiFZJ1sijJt6UqLgFfa+bSlT1lNeaXDU63C+UfHl1yYFiBV/mM8B1xLMDzJxr0z
         Vt+tVTjQ8tx6dd4HaFchIQuahF03am5/u11j5rZ4Xoyb7eEm6XHcbXpe0b9Bg5URSa20
         AvFg==
X-Gm-Message-State: ACrzQf3vPUNhF/Vr4vq0Wjp8M0CBY56EpoOzFJUhpltiIjPlpLeGfYHE
        eLcluah+QNGkE8PRBjgvPuv+U7vEdZVcPaNBXDyl261j
X-Google-Smtp-Source: AMsMyM6OS+6Ubu4P8PTnnSf5RE9wtQeNXRiIumMF7R9sXA/QtTvsG2L716MzPL2QK7wDv6kk5/FWkWJKVDGySsBiQLE=
X-Received: by 2002:a05:6870:4184:b0:136:5e73:b40e with SMTP id
 y4-20020a056870418400b001365e73b40emr254845oac.209.1665512466355; Tue, 11 Oct
 2022 11:21:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220901130959.1285717-1-kan.liang@linux.intel.com> <20220901130959.1285717-3-kan.liang@linux.intel.com>
In-Reply-To: <20220901130959.1285717-3-kan.liang@linux.intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 11 Oct 2022 11:20:54 -0700
Message-ID: <CAM9d7cgWDVAq8-11RbJ2uGfwkKD6fA-OMwOKDrNUrU_=8MgEjg@mail.gmail.com>
Subject: Re: [PATCH V2 2/6] perf/x86/intel/pebs: Fix PEBS timestamps overwritten
To:     Kan Liang <kan.liang@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>, andreas.kogler.0x@gmail.com,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>
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

Hello,

On Thu, Sep 1, 2022 at 6:10 AM <kan.liang@linux.intel.com> wrote:
>
> From: Kan Liang <kan.liang@linux.intel.com>
>
> The PEBS TSC-based timestamps do not appear correctly in the final
> perf.data output file from perf record.
>
> The data->time field setup by PEBS in the setup_pebs_fixed_sample_data()
> is later overwritten by perf_events generic code in
> perf_prepare_sample(). There is an ordering problem.
>
> Set the sample flags when the data->time is updated by PEBS.
> The data->time field will not be overwritten anymore.

I have a report that it breaks the symbolization of samples.
It seems time is not in sync between perf_clock and PEBS.

One thing I noticed is that the system has a config option
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y.
Looking at the code, it seems sched_clock is doing some
adjustments in that case.  So I'm not sure if it'd work well
on those systems.

Thoughts?

Thanks,
Namhyung


>
> Reported-by: Andreas Kogler <andreas.kogler.0x@gmail.com>
> Reported-by: Stephane Eranian <eranian@google.com>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  arch/x86/events/intel/ds.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
> index de1f55d51784..01cbe26225c2 100644
> --- a/arch/x86/events/intel/ds.c
> +++ b/arch/x86/events/intel/ds.c
> @@ -1643,8 +1643,10 @@ static void setup_pebs_fixed_sample_data(struct perf_event *event,
>          * We can only do this for the default trace clock.
>          */
>         if (x86_pmu.intel_cap.pebs_format >= 3 &&
> -               event->attr.use_clockid == 0)
> +               event->attr.use_clockid == 0) {
>                 data->time = native_sched_clock_from_tsc(pebs->tsc);
> +               data->sample_flags |= PERF_SAMPLE_TIME;
> +       }
>
>         if (has_branch_stack(event))
>                 data->br_stack = &cpuc->lbr_stack;
> @@ -1705,8 +1707,10 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
>         perf_sample_data_init(data, 0, event->hw.last_period);
>         data->period = event->hw.last_period;
>
> -       if (event->attr.use_clockid == 0)
> +       if (event->attr.use_clockid == 0) {
>                 data->time = native_sched_clock_from_tsc(basic->tsc);
> +               data->sample_flags |= PERF_SAMPLE_TIME;
> +       }
>
>         /*
>          * We must however always use iregs for the unwinder to stay sane; the
> --
> 2.35.1
>

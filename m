Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D21635FC90A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 18:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbiJLQUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 12:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbiJLQUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 12:20:33 -0400
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D281027FED;
        Wed, 12 Oct 2022 09:20:32 -0700 (PDT)
Received: by mail-oi1-f172.google.com with SMTP id u15so13698993oie.2;
        Wed, 12 Oct 2022 09:20:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tAIs7AwhS/GOOfzZdFmQPH0C0QhvdyIwmaA0cNPLVEA=;
        b=udPPao2DTT4urstb9istE7eGq5u0GpRDQ5jxFZvsKoJ06yWA/A/7nUKxXZmIvp9u7w
         4LPFGcQB+1r52zOqG6szZ/zfB9POqjWH3wtk2nL5cXNOTwuvOb6FH55OZG8cwC7YJoXq
         E6lKU5Mc4/p8G5cIDiAmoqFnaX4KNgYcnsK679nxg2DVHkBcvtGxqo9nfuptqGED3Plb
         B4cgSm1NkKiBo8l5mHoV1h2JqxS6OGu5pwI9kfuglGvssiOzJGaML5IqXgvtPrO9m2sW
         7Ch14QMFEtVdQwFfAMbVSznrtasylGGcacm5WBu8Hrc+TLOXwhOQk6HKPff/I+hYouq+
         htvw==
X-Gm-Message-State: ACrzQf29T+YoNtxcIs//aaibqbaPHRVeCavYjtZXSs8JaTQmHnUiM5Ll
        NnKEaVE0HrWS7sfIgB+FyLYSJr7Cfxvk1ED0IMQE/KeM
X-Google-Smtp-Source: AMsMyM6zcRK5WW66x5f3Qi5yVUogVRAUQtGeAnSwRuKvDsW1ndU5IBxvURGWsqOiTKi4c4hsFeqCWCx7336ysKMWVY0=
X-Received: by 2002:a05:6870:82ac:b0:133:34b:6f10 with SMTP id
 q44-20020a05687082ac00b00133034b6f10mr2977935oae.218.1665591621232; Wed, 12
 Oct 2022 09:20:21 -0700 (PDT)
MIME-Version: 1.0
References: <20221012082259.22394-1-adrian.hunter@intel.com> <20221012082259.22394-2-adrian.hunter@intel.com>
In-Reply-To: <20221012082259.22394-2-adrian.hunter@intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 12 Oct 2022 09:20:10 -0700
Message-ID: <CAM9d7ciW1wF7YGszv4KQ_KRUhCeBVynQsuRi2+NoRAYgy3xsRw@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf intel-pt: Fix segfault in intel_pt_print_info()
 with uClibc
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
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

Hi Adrian,

On Wed, Oct 12, 2022 at 1:23 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> uClibc segfaulted because NULL was passed as the format to fprintf().

Sounds like glibc has a NULL check in fprintf().

>
> That happened because one of the format strings was missing and
> intel_pt_print_info() didn't check that before calling fprintf().
>
> Add the missing format string, and check format is not NULL before calling
> fprintf().
>
> Fixes: 11fa7cb86b56 ("perf tools: Pass Intel PT information for decoding MTC and CYC")
> Cc: stable@vger.kernel.org
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
>  tools/perf/util/intel-pt.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
> index b34cb3dec1aa..e3548ddef254 100644
> --- a/tools/perf/util/intel-pt.c
> +++ b/tools/perf/util/intel-pt.c
> @@ -4046,6 +4046,7 @@ static const char * const intel_pt_info_fmts[] = {
>         [INTEL_PT_SNAPSHOT_MODE]        = "  Snapshot mode       %"PRId64"\n",
>         [INTEL_PT_PER_CPU_MMAPS]        = "  Per-cpu maps        %"PRId64"\n",
>         [INTEL_PT_MTC_BIT]              = "  MTC bit             %#"PRIx64"\n",
> +       [INTEL_PT_MTC_FREQ_BITS]        = "  MTC freq bits       %#"PRIx64"\n",
>         [INTEL_PT_TSC_CTC_N]            = "  TSC:CTC numerator   %"PRIu64"\n",
>         [INTEL_PT_TSC_CTC_D]            = "  TSC:CTC denominator %"PRIu64"\n",
>         [INTEL_PT_CYC_BIT]              = "  CYC bit             %#"PRIx64"\n",
> @@ -4060,8 +4061,12 @@ static void intel_pt_print_info(__u64 *arr, int start, int finish)
>         if (!dump_trace)
>                 return;
>
> -       for (i = start; i <= finish; i++)
> -               fprintf(stdout, intel_pt_info_fmts[i], arr[i]);
> +       for (i = start; i <= finish; i++) {
> +               const char *fmt = intel_pt_info_fmts[i];
> +
> +               if (fmt)
> +                       fprintf(stdout, fmt, arr[i]);
> +       }
>  }
>
>  static void intel_pt_print_info_str(const char *name, const char *str)
> --
> 2.25.1
>

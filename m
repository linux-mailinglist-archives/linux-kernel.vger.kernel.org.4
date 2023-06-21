Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DEC7739297
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 00:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjFUWe6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 21 Jun 2023 18:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjFUWe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 18:34:57 -0400
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27A4211F;
        Wed, 21 Jun 2023 15:34:25 -0700 (PDT)
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-3f9dd2fabe2so53586241cf.3;
        Wed, 21 Jun 2023 15:34:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687386845; x=1689978845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lRd90z8fVQ5qpNwaOR11CKaR1UJ7gK5rX/z4Tbk7UDY=;
        b=dJE3rUUaQfKuYLxZiQM2Bpl4IZMIAXzV69AiEt+eRnvksBgsnEOXEiFlk0ZvM+KOEI
         k4JRQ2yzP3bz4GRtuMcyDkJpS8API38xPP/1Ia2HjRED2niWMJBVC01FjJot79fQ3iqo
         FQ+GuV7QDv2fibicmp/VIOi6e6j7fb8QsB1RJn7/jmJ48/K5ay/bKp2jYZTe5tlrBX4E
         ElO18ndWKted7nd2aGl3E/30ONUSH9I6zQpj+27zgVJosSk4oiP2xxue0z2Shxxluncw
         4kh9Bo1JMbg0xaB08FNX+YIoGzcjQ2qLeTem7YGdYvs+d2pKL2niN49OZTrEmG6SWkJW
         7Ojw==
X-Gm-Message-State: AC+VfDw5RF9W/dU96Iel85WdBZ1HB+3sXnpfwzp8uXHuvqG3NF49XqeJ
        hvcULppNhVIUm1Jzey7W3rMCMHAD9UvKC1z7LYU=
X-Google-Smtp-Source: ACHHUZ54v5kArKZsw9c7Td8SAowZC+Z8B2vhqA2VbELytJBQcIWMamMCAMaOVLVHmHjDrGF0wSnD3jf8U517E4kHFjU=
X-Received: by 2002:ac8:5f48:0:b0:3f4:8612:6d84 with SMTP id
 y8-20020ac85f48000000b003f486126d84mr19919267qta.60.1687386844860; Wed, 21
 Jun 2023 15:34:04 -0700 (PDT)
MIME-Version: 1.0
References: <3b0abd4a-6450-c282-65ff-ec0c7df67b03@amd.com> <20230621062359.201-1-ravi.bangoria@amd.com>
In-Reply-To: <20230621062359.201-1-ravi.bangoria@amd.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 21 Jun 2023 15:33:53 -0700
Message-ID: <CAM9d7chbpiSJ6eSu9_Gs7aLZZb58gtHsvH9tsE-U4eM1eyDvKQ@mail.gmail.com>
Subject: Re: [PATCH] perf evsel amd: Fix IBS error message
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     acme@kernel.org, peterz@infradead.org, irogers@google.com,
        jolsa@kernel.org, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandipan.das@amd.com, ananth.narayan@amd.com,
        santosh.shukla@amd.com
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

Hi Ravi,

On Tue, Jun 20, 2023 at 11:24 PM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
>
> AMD IBS can do per-process profiling[1] and is no longer restricted to
> per-cpu or systemwide only. Remove stale error message.
>
> Before:
>   $ sudo ./perf record -e "{ibs_op//,ibs_op//}" -C 0
>   Error:
>   AMD IBS may only be available in system-wide/per-cpu mode.
>   Try using -a, or -C and workload affinity

It was strange that the -C option was given already.

>
> After:
>   $ sudo ./perf record -e "{ibs_op//,ibs_op//}" -C 0
>   Error:
>   The sys_perf_event_open() syscall returned with 22 (Invalid
>   argument) for event (ibs_op//).
>   /bin/dmesg | grep -i perf may provide additional information.

It can run newer perf tools on an old kernel but the old error
message seems to be invalid anyway.  So I'm ok with removing it.

>
> [1] https://git.kernel.org/torvalds/c/30093056f7b2
>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> ---
>  tools/perf/util/evsel.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 356c07f03be6..65b0b70830f0 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -3092,14 +3092,10 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
>                         return scnprintf(msg, size,
>         "Invalid event (%s) in per-thread mode, enable system wide with '-a'.",
>                                         evsel__name(evsel));
> -               if (is_amd(arch, cpuid)) {
> -                       if (is_amd_ibs(evsel)) {
> -                               if (evsel->core.attr.exclude_kernel)
> -                                       return scnprintf(msg, size,
> +               if (is_amd(arch, cpuid) && is_amd_ibs(evsel)) {
> +                       if (evsel->core.attr.exclude_kernel) {
> +                               return scnprintf(msg, size,
>         "AMD IBS can't exclude kernel events.  Try running at a higher privilege level.");

I'm not sure if it's enough.  The IBS PMUs have CAP_NO_EXCLUDE then
it can't exclude user events too, right?

Thanks,
Namhyung


> -                               if (!evsel->core.system_wide)
> -                                       return scnprintf(msg, size,
> -       "AMD IBS may only be available in system-wide/per-cpu mode.  Try using -a, or -C and workload affinity");
>                         }
>                 }
>
> --
> 2.41.0
>

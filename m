Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 854F86A0FD3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 19:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjBWSy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 13:54:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjBWSyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 13:54:25 -0500
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B113C21;
        Thu, 23 Feb 2023 10:54:24 -0800 (PST)
Received: by mail-ed1-f54.google.com with SMTP id da10so47039737edb.3;
        Thu, 23 Feb 2023 10:54:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iFkkN6SndkOAPbxloVJ2reL3IITekRJdKjzqSG3u/50=;
        b=vgQSMjhVC718JVnDYDDx+wQnKFUqwFNHZ3d979/fEbBh2B1ELf3sd4DOS5SeLbpYn8
         1IN9N3mxveya4fe2tTj9N17ARjZy4KKAjqD67QkSEyVNtw5wB7MiFUMMJG2BKZsRGVs/
         7oHkBkVJbjkMeyg3sJn0yl2huNLdIsDNniZ7cR+ojhmrbicdJnYOwXexQ0NhE0BCZOYR
         RyU4GrjWmiSi0Sc3uko4r1TJzuxrsxuL+chW8XhbDEwz2w0LMC+Sq2ZYCyptES5kYOVU
         pHjkx/yzapQzuQxTIwIc/mAxJx17oz50PCXCsTQMAG/jQoGjWDQQMWvVacM5TLa26aK1
         fG2g==
X-Gm-Message-State: AO0yUKWhqNl9SDf6TD3pUArT3Ofo2ta6ri7bVymjXx7Ft3QyYz6ZCbEw
        Z94+8OAIC25r1S1SzcIB6bNILVNgyY8rR2038TFC4aKk
X-Google-Smtp-Source: AK7set8ikzX9SFwilG92f1+WBqpUO/xB4g5wmby3yK2W/KcDhUg5lcvMCZmJAb+QOVn46ft3349ieMYxptp1QqivG0Q=
X-Received: by 2002:a17:906:9251:b0:8ce:cb8f:3747 with SMTP id
 c17-20020a170906925100b008cecb8f3747mr6941704ejx.5.1677178462806; Thu, 23 Feb
 2023 10:54:22 -0800 (PST)
MIME-Version: 1.0
References: <20230222064526.1971688-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20230222064526.1971688-1-srinivas.pandruvada@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 23 Feb 2023 19:54:11 +0100
Message-ID: <CAJZ5v0gR9xjycvqYakbr8k2iwQmvwJY=5Rn9htoMD-uu40bQeA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Update Balance performance EPP for
 Sapphire Rapids
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     rafael@kernel.org, lenb@kernel.org, viresh.kumar@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Wed, Feb 22, 2023 at 7:45 AM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> While majority of server OS distributions are deployed with performance
> governor as the default, some distributions like Ubuntu uses powersave
> governor as the default.
>
> While the powersave governor has much lower power, the performance is
> lower than +25% for several workloads compared to performance governor.
>
> One report is published by www.Phoronix.com showing difference of 37%.
>
> The goal here is to keep mean performance delta of powersave governor
> from performance governor around 10% to 12% by running wide variety
> of server workloads. For some bursty workload, this delta can be still
> large, as ramp up of frequency will still lag with powersave governor
> irrespective of EPP setting. The performance governor always requests
> maximum frequency.
>
> Based on experiments, EPP of 0x00, 0x10, 0x20, the performance delta for
> powersave governor is around 12%. But the EPP 0x20 has 18% lower average
> power.
>
> Also experimets are done by raising intel_pstate sysfs min_perf_pct as
> high as 50%. This didn't bring in any additional improvements compared
> to just changing EPP.
>
> From the Alder Lake processor generation, intel_pstate driver has
> capability to update EPP for the default balance_performance based
> on the CPU model. Use the same method to update the default
> balance_performance EPP for the Sapphire Rapids processor to 0x20.
>
> Link: https://www.phoronix.com/review/centos-clear-spr/6
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/cpufreq/intel_pstate.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index fd73d6d2b808..32a4004d155d 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -3372,6 +3372,7 @@ static const struct x86_cpu_id intel_epp_balance_perf[] = {
>          * AlderLake Mobile CPUs.
>          */
>         X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L, 102),
> +       X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X, 32),
>         {}
>  };
>
> --

Applied as 6.3-rc material with some edits in the subject and changelog.

Thanks!

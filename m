Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 238996BEFD5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 18:38:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbjCQRi3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 17 Mar 2023 13:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbjCQRi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 13:38:27 -0400
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E1B28E56;
        Fri, 17 Mar 2023 10:38:24 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id z21so23384742edb.4;
        Fri, 17 Mar 2023 10:38:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679074703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3VVTjDJmm2lzmDZ4EXfD/IuNUWCmUKCPv9+gvR5MmV0=;
        b=i/iVzaZK7UeBh8+yveL6dXFByslzvLT+PBgoQVvtBIdnDseKBuzBGfZSjEre53TFmL
         2y7hsx1XUZCZypCvj6h337gP0HhlgTQhieHAfSdVC3pEdKXYhxTfeCDyqbMD/gX6d8zW
         pP3JAhNypGEhrn97H1ybLA5SyNghtnrIuZOwDfyZxASgs2M+ieDLkxGvQwqmaqVwrVlo
         +ktCZenudMB5r48VBO+4QKSuw+rFo6MdW3YMJ4E7+S712S1Jc9HMkCRfgW8BECWreLfV
         IaH0WlB/NDtYOHmABBqnhTUN+L488nsFWaFSFrNqYS89KbsZijdfRNXshZHTMPw6g7Ky
         StWg==
X-Gm-Message-State: AO0yUKVYUThX1wbJy3ep1XHhXRGKUFxL5hu9B2OqcrmdyWfAoiaCUnMZ
        diNaYCPNThHfP83HjpcU2RzYv6E+QgVZNllX/n+EHpyf
X-Google-Smtp-Source: AK7set8XGEdnu1BsUTauQyYoAVFdivlT+2sHVsQhz1UkxF2v5KcQy5eyHquCr4DrEfRmPLgJIDs+9X4k+b8ZfpMA1gw=
X-Received: by 2002:a17:907:a649:b0:931:ce20:db82 with SMTP id
 vu9-20020a170907a64900b00931ce20db82mr98584ejc.2.1679074702745; Fri, 17 Mar
 2023 10:38:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230303041411.3161780-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20230303041411.3161780-1-srinivas.pandruvada@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 17 Mar 2023 18:38:11 +0100
Message-ID: <CAJZ5v0g6b0=daCgNnH6sh1WJfkQYUOnCUj1QSxPERnP8Sz=tOQ@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Enable HWP IO boost for all servers
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     rafael@kernel.org, lenb@kernel.org, viresh.kumar@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 3, 2023 at 5:14 AM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> The HWP IO boost results in slight improvements for IO performance on
> both Ice Lake and Sapphire Rapid servers.
>
> Currently there is a CPU model check for Skylake desktop and server along
> with the ACPI PM profile for performance and enterprise servers to enable
> IO boost.
>
> Remove the CPU model check, so that all current server models enable HWP
> IO boost by default.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/cpufreq/intel_pstate.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index cb4beec27555..8edbc0856892 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -2384,12 +2384,6 @@ static const struct x86_cpu_id intel_pstate_cpu_ee_disable_ids[] = {
>         {}
>  };
>
> -static const struct x86_cpu_id intel_pstate_hwp_boost_ids[] = {
> -       X86_MATCH(SKYLAKE_X,            core_funcs),
> -       X86_MATCH(SKYLAKE,              core_funcs),
> -       {}
> -};
> -
>  static int intel_pstate_init_cpu(unsigned int cpunum)
>  {
>         struct cpudata *cpu;
> @@ -2408,12 +2402,9 @@ static int intel_pstate_init_cpu(unsigned int cpunum)
>                 cpu->epp_default = -EINVAL;
>
>                 if (hwp_active) {
> -                       const struct x86_cpu_id *id;
> -
>                         intel_pstate_hwp_enable(cpu);
>
> -                       id = x86_match_cpu(intel_pstate_hwp_boost_ids);
> -                       if (id && intel_pstate_acpi_pm_profile_server())
> +                       if (intel_pstate_acpi_pm_profile_server())
>                                 hwp_boost = true;
>                 }
>         } else if (hwp_active) {
> --

Applied as 6.4 material, thanks!

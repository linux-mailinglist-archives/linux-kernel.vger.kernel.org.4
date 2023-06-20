Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBC9B736908
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 12:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbjFTKT7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 20 Jun 2023 06:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjFTKTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 06:19:54 -0400
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC38CA2;
        Tue, 20 Jun 2023 03:19:53 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-98273ae42d0so143882266b.0;
        Tue, 20 Jun 2023 03:19:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687256392; x=1689848392;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KZUCH9LTrRvHBUjWoUivrfovuP0Wd096/5/MmH/TQL8=;
        b=eLuz4UIOmmij43ihld2YnBT3tV2Pxs0CQcZsv6MTd9X63R+JRAVyfovS5+tyIcg1CM
         gvFaWrej0X4oklXzoe26ntM/3LJq5Do+KA/Ni8TNSA6gtk+rYvaR5xpSpqY94atcT8A+
         bKZUdkHfTCtj+W8lUB7hlNZTu1agzWgkOSQgcN9fH9CpVKi9wnUhCR+UHXdQaRUYdTy/
         W5LnS9Dvf+kiAoA4PkkTpOqf7HijrqZq9xpRJQ/FdhZ/JjaGga8eWf5YWZ1xXLWrb0tB
         YoifPHtMY/5u7uoXlbHYyakHxLIdGn5OBFhJRE1tGfcvq8DFQfSMRmBF+cx2mU2PlILQ
         2Frw==
X-Gm-Message-State: AC+VfDz1upcOKTbBKzOPIqOMtAHDInYM3EoIasAyGQ512NcxHgiafk1Z
        FUgR8pqj87D8VQSgVm4gm16jbfO9dCZ2/ZNbv50=
X-Google-Smtp-Source: ACHHUZ7mNfssA+opB1qFOLJgxd1MESUlm1hIrfsU1mTGIqwgdXpGWpC16FHZw1zvG6ewXHsz6WMI8xoyRrzu/RBAoFs=
X-Received: by 2002:a17:906:151:b0:988:3a6d:fb80 with SMTP id
 17-20020a170906015100b009883a6dfb80mr6801815ejh.1.1687256392277; Tue, 20 Jun
 2023 03:19:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230612030321.3097627-1-perry.yuan@amd.com>
In-Reply-To: <20230612030321.3097627-1-perry.yuan@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 20 Jun 2023 12:19:35 +0200
Message-ID: <CAJZ5v0isvR-cKN7x7THEN_sbzdNYUMNXx9OVwgif_TQ0tYgvoA@mail.gmail.com>
Subject: Re: [PATCH v2] cpufreq: amd-pstate: Set default governor to schedutil
To:     Perry Yuan <perry.yuan@amd.com>
Cc:     rafael.j.wysocki@intel.com, viresh.kumar@linaro.org,
        Ray.Huang@amd.com, Mario.Limonciello@amd.com,
        Deepak.Sharma@amd.com, Wyes.Karny@amd.com, gautham.shenoy@amd.com,
        Sunpeng.Li@amd.com, Xinmei.Huang@amd.com, Xiaojian.Du@amd.com,
        Li.Meng@amd.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Mon, Jun 12, 2023 at 5:04 AM Perry Yuan <perry.yuan@amd.com> wrote:
>
> From: Mario Limonciello <mario.limonciello@amd.com>
>
> The Kconfig currently defaults the governor to schedutil on x86_64
> only when intel-pstate and SMP have been selected.
>
> If the kernel is built only with amd-pstate, the default governor
> should also be schedutil.
>
> Cc: Sun Peng (Leo) Li <sunpeng.li@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> Reviewed-by: Leo Li <sunpeng.li@amd.com>
> Acked-by: Huang Rui <ray.huang@amd.com>
> Tested-by: Perry Yuan <Perry.Yuan@amd.com>
> ---
>  drivers/cpufreq/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
> index 2c839bd2b051..a1c51abddbc5 100644
> --- a/drivers/cpufreq/Kconfig
> +++ b/drivers/cpufreq/Kconfig
> @@ -38,7 +38,7 @@ choice
>         prompt "Default CPUFreq governor"
>         default CPU_FREQ_DEFAULT_GOV_USERSPACE if ARM_SA1110_CPUFREQ
>         default CPU_FREQ_DEFAULT_GOV_SCHEDUTIL if ARM64 || ARM
> -       default CPU_FREQ_DEFAULT_GOV_SCHEDUTIL if X86_INTEL_PSTATE && SMP
> +       default CPU_FREQ_DEFAULT_GOV_SCHEDUTIL if (X86_INTEL_PSTATE || X86_AMD_PSTATE) && SMP
>         default CPU_FREQ_DEFAULT_GOV_PERFORMANCE
>         help
>           This option sets which CPUFreq governor shall be loaded at
> --

Applied as 6.5 material, thanks!

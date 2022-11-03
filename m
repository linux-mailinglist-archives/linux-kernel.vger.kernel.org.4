Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA25C618728
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 19:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbiKCSM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 14:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbiKCSMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 14:12:25 -0400
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C26F6B;
        Thu,  3 Nov 2022 11:12:20 -0700 (PDT)
Received: by mail-qk1-f172.google.com with SMTP id k26so1699366qkg.2;
        Thu, 03 Nov 2022 11:12:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BcS1TkH8ThTkQl6q5umAgQ39Rvhb04Vxao2fTgYI9x8=;
        b=uhG385aJIcoVcKRVwMFBlu8f6QJaA6Ex7A14Pga4AI/LPI7awlmuK+lsE3g2yyvQK0
         2PWchOCoPn2BQtOBreNA4I6z3En62LEQ1OXGzA2MEhGObOtD7+RXvIzzXV+bKyzgQp4K
         g5EY/5FYAMvXrCyiyKgKmouN/tTTb84iWsR5FIAN0veW288PqDAemyZO8Vyt/fV81GbJ
         WNOSGBjmSrkJl6C29oWEIcHskt1lSgx6Q3UH5WGUMFn8oMZ4YN5cCzTe2kqbANuF73dp
         7JZZV71n/MdTowSy2nXbUaefn0DNUwigLYXv3g90ecSRh2MnLQn9Drs4yFjVQj3C8cKD
         vLTQ==
X-Gm-Message-State: ACrzQf1t0nEwDi+0Y4ZD/Zc6TW5UPBCRFDOOOmU7UbQrKGudLMHtrbYa
        rZgotc8XOfIde8j0sdVex0aaVEPrr2+BLxH78Yc=
X-Google-Smtp-Source: AMsMyM49+sF3PR/wyVNOvkxA3hQJY5xVrPHzYcTnivwkur2R1VxP620dNNbPjs+22VxLqnF9K+lrs5ZsNGUefSNioaQ=
X-Received: by 2002:a05:620a:1476:b0:6fa:4c67:83ec with SMTP id
 j22-20020a05620a147600b006fa4c6783ecmr11380447qkl.23.1667499139371; Thu, 03
 Nov 2022 11:12:19 -0700 (PDT)
MIME-Version: 1.0
References: <20221008195244.53813-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20221008195244.53813-1-andriy.shevchenko@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 3 Nov 2022 19:12:08 +0100
Message-ID: <CAJZ5v0hzZYdO+U0yrgazZGv243soFv2StB88NZQLr-evs5KreA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] cpufreq: ACPI: Use str_enabled_disabled() helper
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 8, 2022 at 9:52 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Use str_enabled_disabled() helper instead of open coding the same.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/cpufreq/acpi-cpufreq.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
> index 1bb2b90ebb21..8597ab0a84b5 100644
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -19,6 +19,7 @@
>  #include <linux/compiler.h>
>  #include <linux/dmi.h>
>  #include <linux/slab.h>
> +#include <linux/string_helpers.h>
>
>  #include <linux/acpi.h>
>  #include <linux/io.h>
> @@ -135,8 +136,8 @@ static int set_boost(struct cpufreq_policy *policy, int val)
>  {
>         on_each_cpu_mask(policy->cpus, boost_set_msr_each,
>                          (void *)(long)val, 1);
> -       pr_debug("CPU %*pbl: Core Boosting %sabled.\n",
> -                cpumask_pr_args(policy->cpus), val ? "en" : "dis");
> +       pr_debug("CPU %*pbl: Core Boosting %s.\n",
> +                cpumask_pr_args(policy->cpus), str_enabled_disabled(val));
>
>         return 0;
>  }
> --

Applied as 6.2 material, thanks!

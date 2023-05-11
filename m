Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 631DE6FEFCF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 12:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237753AbjEKKVi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 11 May 2023 06:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237745AbjEKKVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 06:21:35 -0400
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 570F77EDD;
        Thu, 11 May 2023 03:21:33 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-94a342f4c8eso206922166b.0;
        Thu, 11 May 2023 03:21:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683800492; x=1686392492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+tNn2ImqAxVvjZLgCq06qxUog0HBwoGB+ClgoaQIorQ=;
        b=YbFMJXD2m/r/Tj3Y5Wr2K1/mXujoe9uXbLPaRj5es0V9qjP7TwthkCStrs2Jgh8Mte
         Zrtev2j2vMdXhuncqvcNjavecHY5nW+Ojg+NDOwPUjRf2heCDwIkgO7B+ymWpFqe165G
         TuhgVJFTT8SeYy62cc+E0DMi4BWwQLGxRDU45wi5wNQXBBmZW3Zwtefd9qLDH17Iq6Sv
         rq/B8OB0shK57axHi3Hv7VnKHQBrxuMgXj42T1koBK1LPukqQ6KpaPzKOhFcyBdv0Fa1
         R1Dmx2swONAXranCpclGQebWpcmMuGsw4PpARSMJdrxaFQF+mBW+YhSble+fcrRXVOOc
         8ZTw==
X-Gm-Message-State: AC+VfDw4xW9bd8IuTKbS9lslP/cjhG52eN4ivonqbdQaT/hfKqczMyaf
        n59cFsPwhgCE4EvLntyk1Lk//yrVfcOFQzmfs3s=
X-Google-Smtp-Source: ACHHUZ4rlkQGRhCNlJY90hYGN5W50p4e3mg/6E9zN/yEWBlMShoeFO4MdKZOkJpXzkrqkSsCNtDJF6/r8skUZnLXUz4=
X-Received: by 2002:a17:906:7794:b0:94e:d688:fca6 with SMTP id
 s20-20020a170906779400b0094ed688fca6mr16292988ejm.0.1683800491607; Thu, 11
 May 2023 03:21:31 -0700 (PDT)
MIME-Version: 1.0
References: <96f7ea2c952075030ab8d24ee2d3983e1b144f36.1683795616.git.viresh.kumar@linaro.org>
In-Reply-To: <96f7ea2c952075030ab8d24ee2d3983e1b144f36.1683795616.git.viresh.kumar@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 11 May 2023 12:21:18 +0200
Message-ID: <CAJZ5v0iU1aLRd447x=4_ng7JoGCiptw3ps5gzFcG_kVwGa2wPg@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: sparc: Don't allocate cpufreq_driver dynamically
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Markus Elfring <Markus.Elfring@web.de>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 11:01 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> There is no point allocating the cpufreq driver dynamically and add so
> much complexity in the driver.
>
> Do what is done for other cpufreq drivers and statically allocate the
> cpufreq driver.
>
> Reported-by: Markus Elfring <Markus.Elfring@web.de>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
> Looks like I wrote this back in April and forgot to send it :(

Oh well.

>  drivers/cpufreq/sparc-us2e-cpufreq.c | 58 ++++++++--------------------
>  drivers/cpufreq/sparc-us3-cpufreq.c  | 58 ++++++++--------------------
>  2 files changed, 34 insertions(+), 82 deletions(-)
>
> diff --git a/drivers/cpufreq/sparc-us2e-cpufreq.c b/drivers/cpufreq/sparc-us2e-cpufreq.c
> index 92acbb25abb3..d3510cfdb3eb 100644
> --- a/drivers/cpufreq/sparc-us2e-cpufreq.c
> +++ b/drivers/cpufreq/sparc-us2e-cpufreq.c
> @@ -20,8 +20,6 @@
>  #include <asm/asi.h>
>  #include <asm/timer.h>
>
> -static struct cpufreq_driver *cpufreq_us2e_driver;
> -
>  struct us2e_freq_percpu_info {
>         struct cpufreq_frequency_table table[6];
>  };
> @@ -300,12 +298,19 @@ static int __init us2e_freq_cpu_init(struct cpufreq_policy *policy)
>
>  static int us2e_freq_cpu_exit(struct cpufreq_policy *policy)
>  {
> -       if (cpufreq_us2e_driver)
> -               us2e_freq_target(policy, 0);
> -
> +       us2e_freq_target(policy, 0);
>         return 0;
>  }
>
> +static struct cpufreq_driver cpufreq_us2e_driver = {
> +       .name = "UltraSPARC-IIe",
> +       .init = us2e_freq_cpu_init,
> +       .verify = cpufreq_generic_frequency_table_verify,
> +       .target_index = us2e_freq_target,
> +       .get = us2e_freq_get,
> +       .exit = us2e_freq_cpu_exit,
> +};
> +
>  static int __init us2e_freq_init(void)
>  {
>         unsigned long manuf, impl, ver;
> @@ -319,39 +324,15 @@ static int __init us2e_freq_init(void)
>         impl  = ((ver >> 32) & 0xffff);
>
>         if (manuf == 0x17 && impl == 0x13) {
> -               struct cpufreq_driver *driver;
> -
> -               ret = -ENOMEM;
> -               driver = kzalloc(sizeof(*driver), GFP_KERNEL);
> -               if (!driver)
> -                       goto err_out;
> -
> -               us2e_freq_table = kzalloc((NR_CPUS * sizeof(*us2e_freq_table)),
> -                       GFP_KERNEL);
> +               us2e_freq_table = kzalloc(NR_CPUS * sizeof(*us2e_freq_table),
> +                                         GFP_KERNEL);
>                 if (!us2e_freq_table)
> -                       goto err_out;
> -
> -               driver->init = us2e_freq_cpu_init;
> -               driver->verify = cpufreq_generic_frequency_table_verify;
> -               driver->target_index = us2e_freq_target;
> -               driver->get = us2e_freq_get;
> -               driver->exit = us2e_freq_cpu_exit;
> -               strcpy(driver->name, "UltraSPARC-IIe");
> +                       return -ENOMEM;
>
> -               cpufreq_us2e_driver = driver;
> -               ret = cpufreq_register_driver(driver);
> +               ret = cpufreq_register_driver(&cpufreq_us2e_driver);
>                 if (ret)
> -                       goto err_out;
> +                       kfree(us2e_freq_table);
>
> -               return 0;
> -
> -err_out:
> -               if (driver) {
> -                       kfree(driver);
> -                       cpufreq_us2e_driver = NULL;
> -               }
> -               kfree(us2e_freq_table);
> -               us2e_freq_table = NULL;
>                 return ret;
>         }
>
> @@ -360,13 +341,8 @@ static int __init us2e_freq_init(void)
>
>  static void __exit us2e_freq_exit(void)
>  {
> -       if (cpufreq_us2e_driver) {
> -               cpufreq_unregister_driver(cpufreq_us2e_driver);
> -               kfree(cpufreq_us2e_driver);
> -               cpufreq_us2e_driver = NULL;
> -               kfree(us2e_freq_table);
> -               us2e_freq_table = NULL;
> -       }
> +       cpufreq_unregister_driver(&cpufreq_us2e_driver);
> +       kfree(us2e_freq_table);
>  }
>
>  MODULE_AUTHOR("David S. Miller <davem@redhat.com>");
> diff --git a/drivers/cpufreq/sparc-us3-cpufreq.c b/drivers/cpufreq/sparc-us3-cpufreq.c
> index e41b35b16afd..91d1ed558136 100644
> --- a/drivers/cpufreq/sparc-us3-cpufreq.c
> +++ b/drivers/cpufreq/sparc-us3-cpufreq.c
> @@ -19,8 +19,6 @@
>  #include <asm/head.h>
>  #include <asm/timer.h>
>
> -static struct cpufreq_driver *cpufreq_us3_driver;
> -
>  struct us3_freq_percpu_info {
>         struct cpufreq_frequency_table table[4];
>  };
> @@ -144,12 +142,19 @@ static int __init us3_freq_cpu_init(struct cpufreq_policy *policy)
>
>  static int us3_freq_cpu_exit(struct cpufreq_policy *policy)
>  {
> -       if (cpufreq_us3_driver)
> -               us3_freq_target(policy, 0);
> -
> +       us3_freq_target(policy, 0);
>         return 0;
>  }
>
> +static struct cpufreq_driver cpufreq_us3_driver = {
> +       .name = "UltraSPARC-III",
> +       .init = us3_freq_cpu_init,
> +       .verify = cpufreq_generic_frequency_table_verify,
> +       .target_index = us3_freq_target,
> +       .get = us3_freq_get,
> +       .exit = us3_freq_cpu_exit,
> +};
> +
>  static int __init us3_freq_init(void)
>  {
>         unsigned long manuf, impl, ver;
> @@ -167,39 +172,15 @@ static int __init us3_freq_init(void)
>              impl == CHEETAH_PLUS_IMPL ||
>              impl == JAGUAR_IMPL ||
>              impl == PANTHER_IMPL)) {
> -               struct cpufreq_driver *driver;
> -
> -               ret = -ENOMEM;
> -               driver = kzalloc(sizeof(*driver), GFP_KERNEL);
> -               if (!driver)
> -                       goto err_out;
> -
> -               us3_freq_table = kzalloc((NR_CPUS * sizeof(*us3_freq_table)),
> -                       GFP_KERNEL);
> +               us3_freq_table = kzalloc(NR_CPUS * sizeof(*us3_freq_table),
> +                                        GFP_KERNEL);
>                 if (!us3_freq_table)
> -                       goto err_out;
> -
> -               driver->init = us3_freq_cpu_init;
> -               driver->verify = cpufreq_generic_frequency_table_verify;
> -               driver->target_index = us3_freq_target;
> -               driver->get = us3_freq_get;
> -               driver->exit = us3_freq_cpu_exit;
> -               strcpy(driver->name, "UltraSPARC-III");
> +                       return -ENOMEM;
>
> -               cpufreq_us3_driver = driver;
> -               ret = cpufreq_register_driver(driver);
> +               ret = cpufreq_register_driver(&cpufreq_us3_driver);
>                 if (ret)
> -                       goto err_out;
> +                       kfree(us3_freq_table);
>
> -               return 0;
> -
> -err_out:
> -               if (driver) {
> -                       kfree(driver);
> -                       cpufreq_us3_driver = NULL;
> -               }
> -               kfree(us3_freq_table);
> -               us3_freq_table = NULL;
>                 return ret;
>         }
>
> @@ -208,13 +189,8 @@ static int __init us3_freq_init(void)
>
>  static void __exit us3_freq_exit(void)
>  {
> -       if (cpufreq_us3_driver) {
> -               cpufreq_unregister_driver(cpufreq_us3_driver);
> -               kfree(cpufreq_us3_driver);
> -               cpufreq_us3_driver = NULL;
> -               kfree(us3_freq_table);
> -               us3_freq_table = NULL;
> -       }
> +       cpufreq_unregister_driver(&cpufreq_us3_driver);
> +       kfree(us3_freq_table);
>  }
>
>  MODULE_AUTHOR("David S. Miller <davem@redhat.com>");
> --
> 2.31.1.272.g89b43f80a514
>

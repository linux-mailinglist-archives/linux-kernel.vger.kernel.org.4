Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 967966F16E5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 13:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239683AbjD1Lho convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 28 Apr 2023 07:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231822AbjD1Lhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 07:37:41 -0400
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A221F59FB;
        Fri, 28 Apr 2023 04:37:40 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-94f59fbe2cbso280472866b.1;
        Fri, 28 Apr 2023 04:37:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682681859; x=1685273859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pQiAdmvtnwSb14cjiMRaVpHdjTkVg4P9ZJ6La/hDMEU=;
        b=YnHhrlJqThjMfhttHi0UKColRYCW+VNH+8p6WSzKrTdmsPidLH4qPE5Hf4JmzVIt4Q
         y1s4+4Zw2yxrR782iDd/4VWVj9aBXfjjPvxnwY3dICQzFLrVzhWJy4ovBkpKbNJyGXiL
         TN8Cyf3Bn2wAZzhR6wLC0wSxNkLQDIfswekCC64zo8+ycVu5EdubwcptkVh7WiYW6b16
         +X30/5JkPKn28A4xmNMKsVtotqzBwabEaWrEwenNJ5JrumD8l/EGM0SHc4OkOaCpJepg
         Mz4QIQqR9E43VpX4q3YD2Szub6z4GXlhP9e2KfIKFZPB6/6j2wrj5HhWh5EsBsRJa6vP
         twrg==
X-Gm-Message-State: AC+VfDyCOrcM9rXELEraPCPcDZAcglJ7In1ZgZ9UyYgk/0idiM3iU49a
        hur45jVbu3TK04DMh506wOjBrhNEUuDcl6efY0w=
X-Google-Smtp-Source: ACHHUZ7b83N+99IjPNrm9q4SfjsN0/3pu7yue2W8TTat+5Di3COuETAjaTyh9pN0yPc4hXwcjAl94wgjwcrGshwc6vQ=
X-Received: by 2002:a17:906:7a51:b0:94e:63ae:5b9b with SMTP id
 i17-20020a1709067a5100b0094e63ae5b9bmr2033742ejo.7.1682681858835; Fri, 28 Apr
 2023 04:37:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230428070314.225560-1-wangyouwan@126.com>
In-Reply-To: <20230428070314.225560-1-wangyouwan@126.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 28 Apr 2023 13:37:26 +0200
Message-ID: <CAJZ5v0jT0tiwQtTpg-YeptVYq_t80o0nW3O7d9OBDmAxdv8=Dw@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: create cooling device based on ACPI
To:     wangyouwan@126.com
Cc:     rafael@kernel.org, viresh.kumar@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Fri, Apr 28, 2023 at 9:19 AM <wangyouwan@126.com> wrote:
>
> From: youwan Wang <wangyouwan@126.com>
>
> When using the "scpi_cpufreq" driver, an error
> occurs:cpufreq_cooling: OF node not available for cpu*.
> The current computer motherboard is using ACPI firmware.
> Go to see that the error is caused by calling the
> "of_cpufreq_cooling_register" interface.
> comment:create cpufreq cooling device based on DT.
>
> Signed-off-by: youwan Wang <wangyouwan@126.com>
> ---
>  drivers/cpufreq/cpufreq.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 6b52ebe5a890..3418c68959d5 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1528,8 +1528,13 @@ static int cpufreq_online(unsigned int cpu)
>         if (cpufreq_driver->ready)
>                 cpufreq_driver->ready(policy);
>
> -       if (cpufreq_thermal_control_enabled(cpufreq_driver))
> +       if (cpufreq_thermal_control_enabled(cpufreq_driver)) {
> +#ifdef CONFIG_ACPI
> +               policy->cdev = cpufreq_cooling_register(policy);
> +#else
>                 policy->cdev = of_cpufreq_cooling_register(policy);
> +#endif

Please avoid adding #ifdefs like this in random places.

Moreover, what if the kernel supports ACPI and the platform is DT-based?

> +       }
>
>         pr_debug("initialization complete\n");
>
> --

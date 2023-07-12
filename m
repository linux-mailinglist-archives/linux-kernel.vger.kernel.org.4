Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF91E750519
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 12:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232994AbjGLKsT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 12 Jul 2023 06:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232797AbjGLKsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 06:48:08 -0400
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5F91BCB;
        Wed, 12 Jul 2023 03:47:59 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-98dfd15aae1so151048066b.0;
        Wed, 12 Jul 2023 03:47:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689158878; x=1689763678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FBf7P03VtocA1nNbhaM+M3D9kEJJvv5cz8tiGs3DEMo=;
        b=BY3r0zm0X6JAzgO+u7b7ano+dYgwM4lIYZx1xVYw8MnV07Hx37/FC6SBqJQHFh+Qqw
         GcJlU6TCzsGVTQa/StXGdYIb3Oh+l0aN8UlMsEBFW1aSCeE3+CC2VyKGoIovQgyvge5K
         t0nCGVGTDdmStvmxOpFty1p2GJOwsjJQpUDqR/UEN6vu0j8Qrp+eQiBqjK27PeSPOCht
         T8DWXU223/V0vWPaekcplv9v09G8kgw0uJ5h/rjA/HiTOHWMfaGwHqK1tS8mQ5TRYRhj
         Fw3ez9T4Ixc2wUWqaJsA5rFh5Pz5MlRLA8EsJNi9q6R2lxTSczS7L+rt0LJi1B/1ZY6L
         dNiw==
X-Gm-Message-State: ABy/qLbuEnjFNnA4FlBsbacSapGU9J0GZ2nSTjPCB37hGXQRu5jwQgB9
        0tTYcJX5eter4eqlCjI2MqATV7r8IDWEJZPGXjI=
X-Google-Smtp-Source: APBJJlGbMICmDqqDtX5p0z9jhhBjX4oYDCo1Ean6OHuONlaJVrgJ5j16tkEezVX/U0EiMJL0VAM+jNFiBCibZj8h7xc=
X-Received: by 2002:a17:906:7a5e:b0:993:d7d2:7f1c with SMTP id
 i30-20020a1709067a5e00b00993d7d27f1cmr13115583ejo.5.1689158878215; Wed, 12
 Jul 2023 03:47:58 -0700 (PDT)
MIME-Version: 1.0
References: <94682b1572da4a3c6afd31bddf93b797f73fff5e.1689055100.git.viresh.kumar@linaro.org>
In-Reply-To: <94682b1572da4a3c6afd31bddf93b797f73fff5e.1689055100.git.viresh.kumar@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 12 Jul 2023 12:47:46 +0200
Message-ID: <CAJZ5v0gjY4V0g2y5OcjxWFP-koTnqytbtntXWeaCCqXhReeq9A@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: sparc: Don't mark cpufreq callbacks with __init
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 5:58 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> These callbacks can be called again by the cpufreq core after the driver
> is initialized and must be kept around. We currently get section
> mismatch build warnings.
>
> Don't mark them with __init.
>
> Fixes: dcfce7c2cee4 ("cpufreq: sparc: Don't allocate cpufreq_driver dynamically")
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> Rafael,
>
> Please apply this for -rc2. Thanks.

Done, thanks!

>  drivers/cpufreq/sparc-us2e-cpufreq.c | 2 +-
>  drivers/cpufreq/sparc-us3-cpufreq.c  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cpufreq/sparc-us2e-cpufreq.c b/drivers/cpufreq/sparc-us2e-cpufreq.c
> index d3510cfdb3eb..2783d3d55fce 100644
> --- a/drivers/cpufreq/sparc-us2e-cpufreq.c
> +++ b/drivers/cpufreq/sparc-us2e-cpufreq.c
> @@ -269,7 +269,7 @@ static int us2e_freq_target(struct cpufreq_policy *policy, unsigned int index)
>         return smp_call_function_single(cpu, __us2e_freq_target, &index, 1);
>  }
>
> -static int __init us2e_freq_cpu_init(struct cpufreq_policy *policy)
> +static int us2e_freq_cpu_init(struct cpufreq_policy *policy)
>  {
>         unsigned int cpu = policy->cpu;
>         unsigned long clock_tick = sparc64_get_clock_tick(cpu) / 1000;
> diff --git a/drivers/cpufreq/sparc-us3-cpufreq.c b/drivers/cpufreq/sparc-us3-cpufreq.c
> index 91d1ed558136..6c3657679a88 100644
> --- a/drivers/cpufreq/sparc-us3-cpufreq.c
> +++ b/drivers/cpufreq/sparc-us3-cpufreq.c
> @@ -117,7 +117,7 @@ static int us3_freq_target(struct cpufreq_policy *policy, unsigned int index)
>         return smp_call_function_single(cpu, update_safari_cfg, &new_bits, 1);
>  }
>
> -static int __init us3_freq_cpu_init(struct cpufreq_policy *policy)
> +static int us3_freq_cpu_init(struct cpufreq_policy *policy)
>  {
>         unsigned int cpu = policy->cpu;
>         unsigned long clock_tick = sparc64_get_clock_tick(cpu) / 1000;
> --

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1430E6DAC2A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 13:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240607AbjDGLXL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 7 Apr 2023 07:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240260AbjDGLXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 07:23:09 -0400
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F41D5FC8;
        Fri,  7 Apr 2023 04:23:08 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-93434918b67so144120766b.0;
        Fri, 07 Apr 2023 04:23:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680866587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H22T/yjbIlv40VndTuYM1BBNLs0U+57UTH8G/Ew4gkE=;
        b=GTMxNU/diEWkCtEBWPAtaA7RzHM+kNXBwrTFJSU/gw8soImtql0akZ+sIxAigjc5QI
         ffFU+83Eiu8n+VqPR+MBnglt/JQbV4gromJLe4znHZMGaSpBULTWKupA6Z0dG7E8EILD
         P4lx3xPsAs47ub2qIPvD3LSpwPUpxoXF0DQhFc30IatsVl5fVpxMO+ImF+VTRVu2fJFf
         yoO4oENmr3/71HsZMClN8h0kICWwjBQEPxGLQM3zZxDM/TasaJUB9g3FInmW2DYEQ3iw
         zEJ6mB/NCpfEegAA/CQuYVsaXTtPWWwVQv1GOVWMm/w3ofYY5Io9FMjznrzgyeHQOOQP
         olrg==
X-Gm-Message-State: AAQBX9cFz8ERoEgbE3zBW0cd1xjpt/H7OAi6JH3ImNkYR8Lf0mV8LdUu
        O35GgJCK/xE3ZEJaeSa8pwdZsmIMIwvzhclmc2Z3/oDF
X-Google-Smtp-Source: AKy350bKkBb+ciOaOKgeVGyVXNHKVDb6UJJ3PWrBU+Bs7qJeaNH5l+o6jCCdOc5eZWP0WfJWJUyKamkqN1MtaEjOvXI=
X-Received: by 2002:a50:a6d5:0:b0:4fb:2593:846 with SMTP id
 f21-20020a50a6d5000000b004fb25930846mr1283693edc.3.1680866587032; Fri, 07 Apr
 2023 04:23:07 -0700 (PDT)
MIME-Version: 1.0
References: <8c788b8029b3a11f012915dad6154e7cc481f997.1680563899.git.viresh.kumar@linaro.org>
In-Reply-To: <8c788b8029b3a11f012915dad6154e7cc481f997.1680563899.git.viresh.kumar@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 7 Apr 2023 13:22:55 +0200
Message-ID: <CAJZ5v0h0d3pidPC8iK2LA36nVJEHXY_2et8G0fjjVnpbyGy5+Q@mail.gmail.com>
Subject: Re: [PATCH V2] cpufreq: drivers with target_index() must set freq_table
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Yajun Deng <yajun.deng@linux.dev>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 4, 2023 at 1:39 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Since the cpufreq core directly uses freq_table, for cpufreq drivers
> that set their target_index() callback, make it mandatory for them to
> set the same.
>
> Since this is set per policy and normally from policy->init(), do this
> from cpufreq_table_validate_and_sort() which gets called right after
> ->init().
>
> Reported-by: Yajun Deng <yajun.deng@linux.dev>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> V2: Move declaration to cpufreq.h.
>
>  drivers/cpufreq/cpufreq.c    | 5 +++++
>  drivers/cpufreq/freq_table.c | 7 ++++++-
>  include/linux/cpufreq.h      | 1 +
>  3 files changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 6d8fd3b8dcb5..09131c54703f 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -73,6 +73,11 @@ static inline bool has_target(void)
>         return cpufreq_driver->target_index || cpufreq_driver->target;
>  }
>
> +bool has_target_index(void)
> +{
> +       return !!cpufreq_driver->target_index;
> +}
> +
>  /* internal prototypes */
>  static unsigned int __cpufreq_get(struct cpufreq_policy *policy);
>  static int cpufreq_init_governor(struct cpufreq_policy *policy);
> diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
> index 90bfc27ed1ba..c4d4643b6ca6 100644
> --- a/drivers/cpufreq/freq_table.c
> +++ b/drivers/cpufreq/freq_table.c
> @@ -355,8 +355,13 @@ int cpufreq_table_validate_and_sort(struct cpufreq_policy *policy)
>  {
>         int ret;
>
> -       if (!policy->freq_table)
> +       if (!policy->freq_table) {
> +               /* Freq table must be passed by drivers with target_index() */
> +               if (has_target_index())
> +                       return -EINVAL;
> +
>                 return 0;
> +       }
>
>         ret = cpufreq_frequency_table_cpuinfo(policy, policy->freq_table);
>         if (ret)
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 65623233ab2f..541013487a0e 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -237,6 +237,7 @@ bool cpufreq_supports_freq_invariance(void);
>  struct kobject *get_governor_parent_kobj(struct cpufreq_policy *policy);
>  void cpufreq_enable_fast_switch(struct cpufreq_policy *policy);
>  void cpufreq_disable_fast_switch(struct cpufreq_policy *policy);
> +bool has_target_index(void);
>  #else
>  static inline unsigned int cpufreq_get(unsigned int cpu)
>  {
> --

Applied as 6.4 material, thanks!

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44608731D32
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 17:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241858AbjFOP5m convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 15 Jun 2023 11:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbjFOP5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 11:57:40 -0400
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93847273E;
        Thu, 15 Jun 2023 08:57:39 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-9787d11a410so181857666b.0;
        Thu, 15 Jun 2023 08:57:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686844658; x=1689436658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sm9fY4fNQuAWXQzX5fCrHR40yXo8pF4xEqMnMicx6sQ=;
        b=YPTNFV0kT8HlfLvORSQDYkkNADf3jIczBW5/IenS+GQoYdI0labfVA2EcvzpnovSLM
         qR2wRNhyuqoZYcXaSpiWBvblVQWPsGs3C5eHxjpUQWJSXJu3TIxqQ+KzA0ThLg3i6c/s
         eCHzdAtp9qcJPqteVTxVHPZCUbPA6oFn7YKrg06cYauEA5vW0zlW0rYYEqbINFV1+TxA
         vLo6XMECreFOMjNMuaeMyy8DIQ50sYrFMRMqbaOdWMlLFrY7ZNrDAzD6pH22C5oM6xsD
         +HnuCrVeSEwNQf5kbVbkpSqMm2ai/pmU23MfIqlV+JK5hTHRNuk2lOQMW6/5xs95AMhX
         o5Rg==
X-Gm-Message-State: AC+VfDzfi4x6GUG+x5zO6cohwwXEotp4eNLZ5BNzwvmHLlRM6kD3NGAk
        maWt4zWA1uvHmalm26xb+71rll5nxhh2JYPtR0H8GNrQ
X-Google-Smtp-Source: ACHHUZ5Xs2HR0y49cfq/kYQWBqzcNWy1cQnc+TwiiPzmHj7zxbzetXBcVd1FN36ieFOhZfXg+6mLkVQKPlWJc7HliXw=
X-Received: by 2002:a17:906:7785:b0:976:7c67:4bf8 with SMTP id
 s5-20020a170906778500b009767c674bf8mr14238671ejm.5.1686844657811; Thu, 15 Jun
 2023 08:57:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230615063333.4030395-1-perry.yuan@amd.com>
In-Reply-To: <20230615063333.4030395-1-perry.yuan@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 15 Jun 2023 17:57:26 +0200
Message-ID: <CAJZ5v0hMEuiv71RoEfyBJ_Z83AvMWXfEvt9kBU2SmZyXvKSx4w@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] cpufreq: intel_pstate: Use the acpi_pm_profile_server()
 symbol
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 8:35 AM Perry Yuan <perry.yuan@amd.com> wrote:
>
> From: Mario Limonciello <mario.limonciello@amd.com>
>
> Avoid duplication of functionality by using the generic symbol.
> This does have a functional change that intel-pstate will now
> match "SOHO server" as well.

And why do you think that it is a good idea to change this behavior?

> Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> ---
>  drivers/cpufreq/intel_pstate.c | 19 ++++---------------
>  1 file changed, 4 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 2548ec92faa2..6401338971c7 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -313,18 +313,9 @@ static DEFINE_MUTEX(intel_pstate_limits_lock);
>
>  #ifdef CONFIG_ACPI
>
> -static bool intel_pstate_acpi_pm_profile_server(void)
> -{
> -       if (acpi_gbl_FADT.preferred_profile == PM_ENTERPRISE_SERVER ||
> -           acpi_gbl_FADT.preferred_profile == PM_PERFORMANCE_SERVER)
> -               return true;
> -
> -       return false;
> -}
> -
>  static bool intel_pstate_get_ppc_enable_status(void)
>  {
> -       if (intel_pstate_acpi_pm_profile_server())
> +       if (acpi_pm_profile_server())
>                 return true;
>
>         return acpi_ppc;
> @@ -481,10 +472,6 @@ static inline void intel_pstate_exit_perf_limits(struct cpufreq_policy *policy)
>  {
>  }
>
> -static inline bool intel_pstate_acpi_pm_profile_server(void)
> -{
> -       return false;
> -}
>  #endif /* CONFIG_ACPI */
>
>  #ifndef CONFIG_ACPI_CPPC_LIB
> @@ -2407,8 +2394,10 @@ static int intel_pstate_init_cpu(unsigned int cpunum)
>                 if (hwp_active) {
>                         intel_pstate_hwp_enable(cpu);
>
> -                       if (intel_pstate_acpi_pm_profile_server())
> +#ifdef CONFIG_ACPI
> +                       if (acpi_pm_profile_server())
>                                 hwp_boost = true;
> +#endif
>                 }
>         } else if (hwp_active) {
>                 /*
> --
> 2.34.1
>

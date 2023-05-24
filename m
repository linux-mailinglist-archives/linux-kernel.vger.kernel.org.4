Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76F9170FD20
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 19:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235485AbjEXRru convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 24 May 2023 13:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231446AbjEXRrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 13:47:48 -0400
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017691B0;
        Wed, 24 May 2023 10:47:23 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-96fc07d7e6bso29977966b.1;
        Wed, 24 May 2023 10:47:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684950442; x=1687542442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MtHsKfwHpJ/MA8hmcGf3XA0dHKGtuHV+9hRCpO7LUUQ=;
        b=YbRSDzMKa4jU5aZFXUWeYeO9W8pvI2ZNPxhznCKYmIcKOgXtPAzg/bgdNOGwMjuq0w
         xjT2OkYWUxHulq+QISGoK+VFfwJtgVJnrWrw0SEiTZRLS4BJY1E2F8NsUZ//5/bXLulB
         ucxyN3+Lo5FOOWKBH+XTHOA79+mlsKwha8NHIeYgFBbuZeDsCrOIFxzsse6Xaa0NehBh
         u0zDuV9VfKlovPGo8WPjPj2qhY3npQ7Itu83Fqd7rTM9ilkz/i+6BRrjxtKVVIKeobTI
         2RmZN+uTxNGumuvZUm6XsscgyTllQlqVji966qm9+WY6eXPghKn5DbDm4ViT18WDpT11
         uKvw==
X-Gm-Message-State: AC+VfDy1W1Tjml2M8LpTlwOyGj14eAMYqT0Hfg0e67z9jIpuz+MsmnuR
        djFz5r9PaI+DhtPqyaGa3dM9BgTPCSqp9FxUx/aTef59
X-Google-Smtp-Source: ACHHUZ7wV5rpKfHlT4Qvg5kxQ7ILIFzV9E6zc6/Zo7WWoX8XyhFI0scNMfjaJOLlZP/M2c0c5gL6LM9eBkeEvdEzDtQ=
X-Received: by 2002:a17:906:7a52:b0:965:9db5:3823 with SMTP id
 i18-20020a1709067a5200b009659db53823mr15874562ejo.3.1684950442317; Wed, 24
 May 2023 10:47:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230517162817.8538-1-wyes.karny@amd.com> <20230517162817.8538-2-wyes.karny@amd.com>
In-Reply-To: <20230517162817.8538-2-wyes.karny@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 24 May 2023 19:47:11 +0200
Message-ID: <CAJZ5v0h+frxNpTz4GsjQ=OdbXXnTgLB=ufA5P2pNjbDF_FhNUQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] amd_pstate: Add ->fast_switch() callback
To:     Wyes Karny <wyes.karny@amd.com>
Cc:     ray.huang@amd.com, rafael@kernel.org, viresh.kumar@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        gautham.shenoy@amd.com
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

On Wed, May 17, 2023 at 6:29 PM Wyes Karny <wyes.karny@amd.com> wrote:
>
> From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
>
> Schedutil normally calls the adjust_perf callback for drivers with
> adjust_perf callback available and fast_switch_possible flag set.
> However, when frequency invariance is disabled and schedutil tries to
> invoke fast_switch. So, there is a chance of kernel crash if this
> function pointer is not set. To protect against this scenario add
> fast_switch callback to amd_pstate driver.
>
> Fixes: 1d215f0319c2 ("cpufreq: amd-pstate: Add fast switch function for AMD P-State")
>
> Signed-off-by: Wyes Karny <wyes.karny@amd.com>
> Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 36 ++++++++++++++++++++++++++++++------
>  1 file changed, 30 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 5a3d4aa0f45a..45711fc0a856 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -444,9 +444,8 @@ static int amd_pstate_verify(struct cpufreq_policy_data *policy)
>         return 0;
>  }
>
> -static int amd_pstate_target(struct cpufreq_policy *policy,
> -                            unsigned int target_freq,
> -                            unsigned int relation)
> +static int amd_pstate_update_freq(struct cpufreq_policy *policy,
> +                                 unsigned int target_freq, bool fast_switch)
>  {
>         struct cpufreq_freqs freqs;
>         struct amd_cpudata *cpudata = policy->driver_data;
> @@ -465,14 +464,37 @@ static int amd_pstate_target(struct cpufreq_policy *policy,
>         des_perf = DIV_ROUND_CLOSEST(target_freq * cap_perf,
>                                      cpudata->max_freq);
>
> -       cpufreq_freq_transition_begin(policy, &freqs);
> +       WARN_ON(fast_switch && !policy->fast_switch_enabled);
> +       /*
> +        * If fast_switch is desired, then there aren't any registered
> +        * transition notifiers. See comment for
> +        * cpufreq_enable_fast_switch().
> +        */
> +       if (!fast_switch)
> +               cpufreq_freq_transition_begin(policy, &freqs);
> +
>         amd_pstate_update(cpudata, min_perf, des_perf,
> -                         max_perf, false, policy->governor->flags);
> -       cpufreq_freq_transition_end(policy, &freqs, false);
> +                       max_perf, fast_switch, policy->governor->flags);
> +
> +       if (!fast_switch)
> +               cpufreq_freq_transition_end(policy, &freqs, false);
>
>         return 0;
>  }
>
> +static int amd_pstate_target(struct cpufreq_policy *policy,
> +                            unsigned int target_freq,
> +                            unsigned int relation)
> +{
> +       return amd_pstate_update_freq(policy, target_freq, false);
> +}
> +
> +static unsigned int amd_pstate_fast_switch(struct cpufreq_policy *policy,
> +                                 unsigned int target_freq)
> +{
> +       return amd_pstate_update_freq(policy, target_freq, true);
> +}
> +
>  static void amd_pstate_adjust_perf(unsigned int cpu,
>                                    unsigned long _min_perf,
>                                    unsigned long target_perf,
> @@ -715,6 +737,7 @@ static int amd_pstate_cpu_exit(struct cpufreq_policy *policy)
>
>         freq_qos_remove_request(&cpudata->req[1]);
>         freq_qos_remove_request(&cpudata->req[0]);
> +       policy->fast_switch_possible = false;
>         kfree(cpudata);
>
>         return 0;
> @@ -1309,6 +1332,7 @@ static struct cpufreq_driver amd_pstate_driver = {
>         .flags          = CPUFREQ_CONST_LOOPS | CPUFREQ_NEED_UPDATE_LIMITS,
>         .verify         = amd_pstate_verify,
>         .target         = amd_pstate_target,
> +       .fast_switch    = amd_pstate_fast_switch,
>         .init           = amd_pstate_cpu_init,
>         .exit           = amd_pstate_cpu_exit,
>         .suspend        = amd_pstate_cpu_suspend,
> --

Applied along with the [2/3], thanks!

Do you need them in 6.4 or would 6.5 be sufficient?  Also do you need
them to go into "stable"?

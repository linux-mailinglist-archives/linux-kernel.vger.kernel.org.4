Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E167870FD52
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 19:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236429AbjEXR5Y convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 24 May 2023 13:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232141AbjEXR5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 13:57:22 -0400
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE27E7;
        Wed, 24 May 2023 10:57:21 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-9739440b60bso9866166b.0;
        Wed, 24 May 2023 10:57:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684951040; x=1687543040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uDaTsBUf1OgMPXWfUFesGffUSXTmr0WAjmxiqPIpJXM=;
        b=jRZfssBO3Z0gAtjQ7xkVHLa+731DjhHuYjFSr6S9NShyOiF355PJ8XuNmn9PqIdV3n
         ouLPrw6Y7u/802DpxNnnUJ5JWhJz2PxR55a+2q9E3FqnC4AUbBsRqCUblWu/ogCelILh
         VL4QWhuSF0NWLmZV00QgIViqHjultpapAdBBTngR2J5qah9XNvdqI9A3tIX6kH2a4f6b
         xGNdfaFMOhS9mwClZ9Pn3/6X50TbSDk0ssNEk0FdbulvsGlE+LXAnZtMTYxVEAJrPwPM
         /9J1KCQNEj/5umErEpZSz485pGaErA8Fj2dUIPPWtip+Ww7Fcukf8fgKIu8aX0gOgkdL
         sqTQ==
X-Gm-Message-State: AC+VfDw+TBxF1V5zhmYzOAbYKUzfZYh5r9EmzPJjZB2E30NoJVBCNPWE
        oyISjjLhqjbRvxiiIwm+qvsk7irXo5wZHS8DU0Y=
X-Google-Smtp-Source: ACHHUZ4criG6PnfbTYVLtyJdpKEmKZbgfsMT1E18yEjxhfz0rkOiO5USzlAnLe2+r0DjL6eMAtPtsBBsSZqbyRSy70s=
X-Received: by 2002:a17:906:5199:b0:965:9602:3ee1 with SMTP id
 y25-20020a170906519900b0096596023ee1mr15757691ejk.2.1684951039851; Wed, 24
 May 2023 10:57:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230518055819.71585-1-wyes.karny@amd.com>
In-Reply-To: <20230518055819.71585-1-wyes.karny@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 24 May 2023 19:57:08 +0200
Message-ID: <CAJZ5v0iR0tvS74s+EnzaSN-7urAWZGPgOEF4OTgaKgWNFueOgw@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: amd-pstate: Update policy->cur for adjust perf
To:     Wyes Karny <wyes.karny@amd.com>
Cc:     ray.huang@amd.com, rafael@kernel.org, viresh.kumar@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        gautham.shenoy@amd.com
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

On Thu, May 18, 2023 at 7:58 AM Wyes Karny <wyes.karny@amd.com> wrote:
>
> Driver should update policy->cur after updating the frequency.
> Currently amd_pstate doesn't update policy->cur when `adjust_perf`
> is used. Which causes /proc/cpuinfo to show wrong cpu frequency.
> Fix this by updating policy->cur with correct frequency value in
> adjust_perf function callback.
>
> - Before the fix: (setting min freq to 1.5 MHz)
>
> [root@amd]# cat /proc/cpuinfo | grep "cpu MHz" | sort | uniq --count
>       1 cpu MHz         : 1777.016
>       1 cpu MHz         : 1797.160
>       1 cpu MHz         : 1797.270
>     189 cpu MHz         : 400.000
>
> - After the fix: (setting min freq to 1.5 MHz)
>
> [root@amd]# cat /proc/cpuinfo | grep "cpu MHz" | sort | uniq --count
>       1 cpu MHz         : 1753.353
>       1 cpu MHz         : 1756.838
>       1 cpu MHz         : 1776.466
>       1 cpu MHz         : 1776.873
>       1 cpu MHz         : 1777.308
>       1 cpu MHz         : 1779.900
>     183 cpu MHz         : 1805.231
>       1 cpu MHz         : 1956.815
>       1 cpu MHz         : 2246.203
>       1 cpu MHz         : 2259.984
>
> Fixes: 1d215f0319c2 ("cpufreq: amd-pstate: Add fast switch function for AMD P-State")
>
> Signed-off-by: Wyes Karny <wyes.karny@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 5a3d4aa0f45a..736dab69ba1e 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -479,12 +479,14 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
>                                    unsigned long capacity)
>  {
>         unsigned long max_perf, min_perf, des_perf,
> -                     cap_perf, lowest_nonlinear_perf;
> +                     cap_perf, lowest_nonlinear_perf, max_freq;
>         struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
>         struct amd_cpudata *cpudata = policy->driver_data;
> +       unsigned int target_freq;
>
>         cap_perf = READ_ONCE(cpudata->highest_perf);
>         lowest_nonlinear_perf = READ_ONCE(cpudata->lowest_nonlinear_perf);
> +       max_freq = READ_ONCE(cpudata->max_freq);
>
>         des_perf = cap_perf;
>         if (target_perf < capacity)
> @@ -501,6 +503,10 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
>         if (max_perf < min_perf)
>                 max_perf = min_perf;
>
> +       des_perf = clamp_t(unsigned long, des_perf, min_perf, max_perf);
> +       target_freq = div_u64(des_perf * max_freq, max_perf);
> +       policy->cur = target_freq;
> +
>         amd_pstate_update(cpudata, min_perf, des_perf, max_perf, true,
>                         policy->governor->flags);
>         cpufreq_cpu_put(policy);
> --

Applied under an edited subject, thanks!

I think you'd like this to go into 6.4 and "stable", right?

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D17196E651B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 14:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbjDRM5V convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 18 Apr 2023 08:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjDRM5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 08:57:19 -0400
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D373581;
        Tue, 18 Apr 2023 05:57:18 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5067716f9e7so582832a12.0;
        Tue, 18 Apr 2023 05:57:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681822637; x=1684414637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o7EH+OiQQWS3SSmVWRfh6k6IhcaxgkbEID60apQt6+E=;
        b=PVqEirSWOCUi8HZdnZrD4zI3GKCMp3b5Kym3GOUKFYchEkplTl7AxiNDVo+aRkHzl3
         0h2EJAwzkmtFyQurMeleM/CwEJ9juaPs5ATKujiwUcgcwosrWcvuxMM580YCrbqC/qNi
         skOHTaUWw8ojNWEuv38UoFYZUhK3lTAz4SzZJqFYa54gw1d4/I9L4XEinuUqw+ozjZ0n
         JMV+90Cfd2SCuWyVKNTJNewr0YJ7osz/CAYd34Wlh+pVomLY0SO3MQIa9ofvuxqVGKhL
         79N8nIy3ua1pg5jI9XwvBTR4hXHDRm1wfLkDvd29DwPmFv0UHGa+0jmExjWo+iyfhfsG
         yuSQ==
X-Gm-Message-State: AAQBX9fNO99PCyKooTehtwCU7VMCLKJQbBsRq6WWQqv8cCkq9cNj63s0
        43hBkoOHS84Zgvy5CnxFVtULyLE/hNAeYU6vB+8=
X-Google-Smtp-Source: AKy350YcISS/PquK9G1zrP4kh7Hc7lKIaI1otJM07VGdGGwnWApG2qhYMDdnuFyynrQZ6TQon16a+qaeftwSYRWpg2U=
X-Received: by 2002:a05:6402:2692:b0:506:6c2a:528f with SMTP id
 w18-20020a056402269200b005066c2a528fmr15872373edd.4.1681822636603; Tue, 18
 Apr 2023 05:57:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230418113459.12860-1-sumitg@nvidia.com> <20230418113459.12860-2-sumitg@nvidia.com>
In-Reply-To: <20230418113459.12860-2-sumitg@nvidia.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 18 Apr 2023 14:57:05 +0200
Message-ID: <CAJZ5v0iMcVZMd3YpEC++BZzCwOM2ocYQuK98tm9gQq0fjO41gg@mail.gmail.com>
Subject: Re: [Patch 1/6] cpufreq: use correct unit when verify cur freq
To:     Sumit Gupta <sumitg@nvidia.com>
Cc:     viresh.kumar@linaro.org, rafael@kernel.org,
        ionela.voinescu@arm.com, mark.rutland@arm.com,
        sudeep.holla@arm.com, lpieralisi@kernel.org,
        catalin.marinas@arm.com, will@kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, treding@nvidia.com,
        jonathanh@nvidia.com, vsethi@nvidia.com, sdonthineni@nvidia.com,
        sanjayc@nvidia.com, ksitaraman@nvidia.com, bbasu@nvidia.com
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

On Tue, Apr 18, 2023 at 1:35 PM Sumit Gupta <sumitg@nvidia.com> wrote:
>
> From: Sanjay Chandrashekara <sanjayc@nvidia.com>
>
> cpufreq_verify_current_freq checks if the frequency returned by
> the hardware has a slight delta with the valid frequency value
> last set and returns "policy->cur" if the delta is within "1 MHz".
> In the comparison, "policy->cur" is in "kHz" but it's compared
> against HZ_PER_MHZ. So, the comparison range becomes "1 GHz".
> Fix this by comparing against KHZ_PER_MHZ instead of HZ_PER_MHZ.
>
> Fixes: f55ae08c8987 ("cpufreq: Avoid unnecessary frequency updates due to mismatch")
> Signed-off-by: Sanjay Chandrashekara <sanjayc@nvidia.com>
> [ sumit gupta: Commit message update ]
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>  drivers/cpufreq/cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 8b0509f89f1b..6b52ebe5a890 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1732,7 +1732,7 @@ static unsigned int cpufreq_verify_current_freq(struct cpufreq_policy *policy, b
>                  * MHz. In such cases it is better to avoid getting into
>                  * unnecessary frequency updates.
>                  */
> -               if (abs(policy->cur - new_freq) < HZ_PER_MHZ)
> +               if (abs(policy->cur - new_freq) < KHZ_PER_MHZ)
>                         return policy->cur;
>
>                 cpufreq_out_of_sync(policy, new_freq);
> --

So this is a fix that can be applied separately from the rest of the
series, isn't it?

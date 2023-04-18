Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2D36E688C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 17:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbjDRPrV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 18 Apr 2023 11:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjDRPrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 11:47:19 -0400
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9969B6A78;
        Tue, 18 Apr 2023 08:47:18 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-94a342f4c8eso123189466b.0;
        Tue, 18 Apr 2023 08:47:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681832837; x=1684424837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/C5xzvKXqZCUa27kLtUoyGZHoFI/e2eInwPXH6CQKpg=;
        b=GF8/a8V3xSJ+OKGlN/dIVkefG2Q6gJSjp1AQrwz2Fs+QeHeDqnf4btM+spe3bocixx
         yezFRJMUBgymyxJOyGsYDliA12ptp9WvXkfSp3Sf8pB2iLG6hxFRKxZ9evnphNkmrwOm
         dQx+lqrNaPP7m9fOx9/LijHI5s+9HJQfEZnrvM+XqOPTwp2cVcESoFz5/Mx/CAR9wVyx
         70NKjLEgQIwlTqF0BwYH1w2e4wSowX6UZzI4iGD1IEC2GQHO67X0LToISJ3QgO5AISFh
         yzxPBb2BCHYLW/I4XBjN2RmC+4Hr4UNOaTyEbCnl1YOiXCNxuYn7Doa9CyS2vPvzXM+3
         +8Xg==
X-Gm-Message-State: AAQBX9eSea+GVfvKl5LGlbZlYZ4oDiYfOyRarFiCBRHcGJorHKB2GB+T
        b3vpNFZivIQ1kRCK83MIqJ7eEHe9NkaZAMQZZAw=
X-Google-Smtp-Source: AKy350bR1pRIrCDZkJlL+PMiZMWZJeYK2qJ+XLvLIYMJTyiImERuWcqTTASca8hy0sWmGrAGieeqdZl5XqmIPznM90w=
X-Received: by 2002:a17:906:7a45:b0:94e:9235:d77e with SMTP id
 i5-20020a1709067a4500b0094e9235d77emr11000217ejo.3.1681832837131; Tue, 18 Apr
 2023 08:47:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230418113459.12860-1-sumitg@nvidia.com> <20230418113459.12860-2-sumitg@nvidia.com>
 <CAJZ5v0iMcVZMd3YpEC++BZzCwOM2ocYQuK98tm9gQq0fjO41gg@mail.gmail.com> <05feec0c-c94a-a0e7-3636-1927f6621cb9@nvidia.com>
In-Reply-To: <05feec0c-c94a-a0e7-3636-1927f6621cb9@nvidia.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 18 Apr 2023 17:47:06 +0200
Message-ID: <CAJZ5v0hU1rDrkqHzKG=NiFmSNh+-8gQWLWOXsMKrhg8BOO1V_g@mail.gmail.com>
Subject: Re: [Patch 1/6] cpufreq: use correct unit when verify cur freq
To:     Sumit Gupta <sumitg@nvidia.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, viresh.kumar@linaro.org,
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

On Tue, Apr 18, 2023 at 3:32 PM Sumit Gupta <sumitg@nvidia.com> wrote:
>
>
>
> On 18/04/23 18:27, Rafael J. Wysocki wrote:
> > External email: Use caution opening links or attachments
> >
> >
> > On Tue, Apr 18, 2023 at 1:35 PM Sumit Gupta <sumitg@nvidia.com> wrote:
> >>
> >> From: Sanjay Chandrashekara <sanjayc@nvidia.com>
> >>
> >> cpufreq_verify_current_freq checks if the frequency returned by
> >> the hardware has a slight delta with the valid frequency value
> >> last set and returns "policy->cur" if the delta is within "1 MHz".
> >> In the comparison, "policy->cur" is in "kHz" but it's compared
> >> against HZ_PER_MHZ. So, the comparison range becomes "1 GHz".
> >> Fix this by comparing against KHZ_PER_MHZ instead of HZ_PER_MHZ.
> >>
> >> Fixes: f55ae08c8987 ("cpufreq: Avoid unnecessary frequency updates due to mismatch")
> >> Signed-off-by: Sanjay Chandrashekara <sanjayc@nvidia.com>
> >> [ sumit gupta: Commit message update ]
> >> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> >> ---
> >>   drivers/cpufreq/cpufreq.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> >> index 8b0509f89f1b..6b52ebe5a890 100644
> >> --- a/drivers/cpufreq/cpufreq.c
> >> +++ b/drivers/cpufreq/cpufreq.c
> >> @@ -1732,7 +1732,7 @@ static unsigned int cpufreq_verify_current_freq(struct cpufreq_policy *policy, b
> >>                   * MHz. In such cases it is better to avoid getting into
> >>                   * unnecessary frequency updates.
> >>                   */
> >> -               if (abs(policy->cur - new_freq) < HZ_PER_MHZ)
> >> +               if (abs(policy->cur - new_freq) < KHZ_PER_MHZ)
> >>                          return policy->cur;
> >>
> >>                  cpufreq_out_of_sync(policy, new_freq);
> >> --
> >
> > So this is a fix that can be applied separately from the rest of the
> > series, isn't it?
>
> Yes.

So applied as 6.4 material.

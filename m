Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB9670FCF4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 19:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236043AbjEXRpr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 24 May 2023 13:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235952AbjEXRpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 13:45:44 -0400
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53CBDE5F;
        Wed, 24 May 2023 10:45:06 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-94ea38c90ccso31055566b.1;
        Wed, 24 May 2023 10:45:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684950305; x=1687542305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=snWan0OEQt+zA5xYjeMRb7pV8yuQ1oJNvMel69SqIZw=;
        b=OetKplGA0YMKgE9oCUQkNTOmgjk/LCK0fL8q5X+CqDKckuZUh2yzpazNWWpIKhH+wj
         qsBg/Exo0IBP7IgTDbCSKo6dEMQ7I9hSl034LaHBmTM8OydT2DuSO5QRwubaLVQBs1kB
         B6zlILE2Xo4e5ng4njYS2yLochJ38gf+16bB6hVuJfCkLA5fBTf7jNIf/tjYaYXMQWCh
         eA/lsMmDe8794qHP1pbZQycGcUDk4PRMYe8qepVYX0ojqRRTni4gx6WeDEKt//HsAaaZ
         UgvOWJjLF4iqUZ8/aT1Xm2gWlUz0oEEEyTi7BTIaExRNdcfoeG+dPmQbpCWAKLon7HAI
         GBYQ==
X-Gm-Message-State: AC+VfDxrLlv1HRXVgCZMZpZlclq+2+35dDfPMlKAfAiR40UdTUJTCOee
        NryDxyZ4BxuEeDpDaRoolCNeGKuimSFynSaRQIADdB7lgVM=
X-Google-Smtp-Source: ACHHUZ70tUjBY1nqtSU6XcGiPqwWef0icBJnZ5b8IrhwvOw/C9DirxgMBQ/VxL5fYMvzCwPqmPk1nj3ILqQn/MeuWRw=
X-Received: by 2002:a17:906:6495:b0:8d2:78c5:1d4e with SMTP id
 e21-20020a170906649500b008d278c51d4emr18279435ejm.5.1684950304470; Wed, 24
 May 2023 10:45:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230517162817.8538-1-wyes.karny@amd.com> <20230517162817.8538-4-wyes.karny@amd.com>
In-Reply-To: <20230517162817.8538-4-wyes.karny@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 24 May 2023 19:44:53 +0200
Message-ID: <CAJZ5v0gte_QAt1MXXXhpGUTEAC3Eo8LCY6N+=uSFi0NRBG-Omw@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] cpufreq: Return failure if fast_switch is not set
 and fast_switch_possible is set
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

On Wed, May 17, 2023 at 6:30 PM Wyes Karny <wyes.karny@amd.com> wrote:
>
> If fast_switch_possible flag is set by the scaling driver, the governor
> is free to select fast_switch function even if adjust_perf is set.  Some
> scaling drivers which use adjust_perf don't set fast_switch thinking
> that the governor would never fall back to fast_switch. But the governor
> can fall back to fast_switch even in runtime if frequency invariance is
> disabled due to some reason. This could crash the kernel if the driver
> didn't set the fast_switch function pointer.
>
> Therefore, return failure in cpufreq_online function if fast_switch is
> not set and fast_switch_possible is set.
>
> Signed-off-by: Wyes Karny <wyes.karny@amd.com>
> ---
>  drivers/cpufreq/cpufreq.c | 5 +++++
>  include/linux/cpufreq.h   | 4 +++-
>  2 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 6b52ebe5a890..7835ba4fa34c 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1376,6 +1376,11 @@ static int cpufreq_online(unsigned int cpu)
>                         goto out_free_policy;
>                 }
>
> +               if (policy->fast_switch_possible && !cpufreq_driver->fast_switch) {
> +                       pr_err("fast_switch_possible is enabled but fast_switch callback is not set\n");
> +                       ret = -EINVAL;
> +                       goto out_destroy_policy;
> +               }

The driver registration can fail if the driver has ->adjust_perf
without ->fast_switch.  Then the check above would not be necessary
any more.

>                 /*
>                  * The initialization has succeeded and the policy is online.
>                  * If there is a problem with its frequency table, take it
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 26e2eb399484..8cdf77bb3bc1 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -340,7 +340,9 @@ struct cpufreq_driver {
>         /*
>          * ->fast_switch() replacement for drivers that use an internal
>          * representation of performance levels and can pass hints other than
> -        * the target performance level to the hardware.
> +        * the target performance level to the hardware. If driver is setting this,
> +        * then it needs to set fast_switch also. Because in certain scenario scale
> +        * invariance could be disabled and governor can switch back to fast_switch.

I would say something like "This can only be set if ->fast_switch is
set too, because in those cases (under specific conditions) scale
invariance can be disabled, which causes the schedutil governor to
fall back to the latter."

>          */
>         void            (*adjust_perf)(unsigned int cpu,
>                                        unsigned long min_perf,
> --
> 2.34.1
>

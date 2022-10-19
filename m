Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2308E6044C4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 14:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232427AbiJSMOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 08:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232935AbiJSMOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 08:14:05 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD5E1C2090;
        Wed, 19 Oct 2022 04:50:24 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id s3so11429336qtn.12;
        Wed, 19 Oct 2022 04:50:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f6pXDQz9XHum5BRL37fQvqtMyYdJ8Q0/PFYhMyqRhmg=;
        b=Q1QuGQu9kcBXR6IM1gHTbp2qGt+ijXs/BRI4ySCmmmS8zrVPbwSC2++VY8QhfAd0aG
         hg17zr5jogxSVY9Sn3m5m51bHU2tMq2DEZj7B7tqdPT74c4vtBKOJTHO2fTDUjNhvlDf
         wAtc6bvnJeGsgOwIxSyIr394HdHxadKCEbSW5H2u39abMNjySVk+6H8/yQbTWEBCPmK0
         ro1Ivw3UoxdoJ6YL8A4yyy1+jLZQ//eOz0mm86jVfnQC/hptu54qgUwNZZPJjeMQQJZu
         APk75mfMdxaoLEeHAmYIChAtBFLBtdZoXJsTEY/nOo4+DtQgkSc1ngT2sCMWkswO/Gpi
         kv6w==
X-Gm-Message-State: ACrzQf36XK1c8nXfmEofA+i/gaUgPAYc9qoGHjV8sdCSAxoxMB4avZcZ
        0w1Dzb4/Zca1tzqBMj9hXRaYzpmOJu9zag5fFNE=
X-Google-Smtp-Source: AMsMyM6k1Gf6jEZxabu8Q7RNxuT/7g8aD8D9CuVKV2ZJDfYMmiMOhx5t42A+tgNfaXQiHJS8T70Ak8YxTx89UfUoYT8=
X-Received: by 2002:a05:622a:11c7:b0:39c:b4bc:7030 with SMTP id
 n7-20020a05622a11c700b0039cb4bc7030mr5936809qtk.17.1666180070299; Wed, 19 Oct
 2022 04:47:50 -0700 (PDT)
MIME-Version: 1.0
References: <1666168845-67690-1-git-send-email-guanjun@linux.alibaba.com> <1666168845-67690-2-git-send-email-guanjun@linux.alibaba.com>
In-Reply-To: <1666168845-67690-2-git-send-email-guanjun@linux.alibaba.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 19 Oct 2022 13:47:39 +0200
Message-ID: <CAJZ5v0h=tPw8K30_yTh6rq3Pbnvx2MzQH5+kiMq3UAeUFXGWRA@mail.gmail.com>
Subject: Re: [PATCH 1/1] cpufreq: Fix show()/store() issue for hotplugging
 offline CPU
To:     Guanjun <guanjun@linux.alibaba.com>
Cc:     schspa@gmail.com, rafael@kernel.org, viresh.kumar@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        zelin.deng@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 10:40 AM Guanjun <guanjun@linux.alibaba.com> wrote:
>
> From: Zelin Deng <zelin.deng@linux.alibaba.com>
>
> After brought one CPU offline, lscpu returned failure:
>
> lscpu: cannot read /sys/devices/system/cpu/cpu64/cpufreq/cpuinfo_max_freq: Device or resource busy
>
> which had blocked all outputs of lscpu.

OK, so the policy->cpus mask is empty and -EBUSY is returned.

What's wrong?

> This is not the case mentioned in commit d4627a287e251, as the policy
> had been created successfully but is inactive due to CPU gets offline.

Yes, that's when policy_is_inactive(policy) returns "true" IIUC.

> To fix this issue, just add an addtional check whether CPU is online or
> not.

Which is racy.

Please explain the problem in the first place.

> Fixes: d4627a287e251 ("cpufreq: Abort show()/store() for half-initialized policies")
> Signed-off-by: Zelin Deng <zelin.deng@linux.alibaba.com>
> Signed-off-by: Guanjun <guanjun@linux.alibaba.com>
> ---
>  drivers/cpufreq/cpufreq.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 69b3d61852ac..aa238ba7d2fe 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -956,8 +956,12 @@ static ssize_t show(struct kobject *kobj, struct attribute *attr, char *buf)
>                 return -EIO;
>
>         down_read(&policy->rwsem);
> -       if (likely(!policy_is_inactive(policy)))
> -               ret = fattr->show(policy, buf);
> +       if (unlikely(policy_is_inactive(policy) && cpu_online(policy->cpu)))
> +               goto err;
> +
> +       ret = fattr->show(policy, buf);
> +
> +err:
>         up_read(&policy->rwsem);
>
>         return ret;
> @@ -974,8 +978,12 @@ static ssize_t store(struct kobject *kobj, struct attribute *attr,
>                 return -EIO;
>
>         down_write(&policy->rwsem);
> -       if (likely(!policy_is_inactive(policy)))
> -               ret = fattr->store(policy, buf, count);
> +       if (unlikely(policy_is_inactive(policy) && cpu_online(policy->cpu)))
> +               goto err;
> +
> +       ret = fattr->store(policy, buf, count);
> +
> +err:
>         up_write(&policy->rwsem);
>
>         return ret;
> --
> 2.32.0.GIT
>

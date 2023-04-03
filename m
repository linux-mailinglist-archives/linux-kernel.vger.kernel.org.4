Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77A9B6D4BD6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 17:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232760AbjDCP2i convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 3 Apr 2023 11:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232544AbjDCP2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 11:28:36 -0400
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7399510E7;
        Mon,  3 Apr 2023 08:28:35 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id w9so118919727edc.3;
        Mon, 03 Apr 2023 08:28:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680535714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DiSKLnH8s6Gs1Z3VpHAX6KBIc26fK0fuzBM84eLhSpY=;
        b=vHkeZAALKS4gef428sYpZViPj9Piasvyy/RVED8q0mP0+yHMCRoFni+koXofgqj+U1
         VkQmH+L3uqiFZC4pJfshmKEvN6JQBLHC/+jD/1yH7ZY/XT0IPjzkF3vvqF8iaEr3Ho7Q
         QkCJZOPMp5A19kt6LBmAA+UyvupxCQ/l1gG883RGlyDXs1z0hcV57CJn7rcrmr+lGASH
         CtcOEJilGKLGGaJLOedj0b4TjPEBB/utaAHZaNTywrRAin8iZOTUbwEauPN1Iosf+gQ1
         yEtsvMkFAXPPiG+XMo3BJU9WNYaO6/hNs+nGSnsu2FLX2Zl8PIwNiPa1sGQn+rs8R0Z7
         Dueg==
X-Gm-Message-State: AAQBX9dYYGf/BuIbSfgis5ArbipG6hDtBti65P4eB9yguVHg7Xfel/oU
        r48eL7aAJhaKlh3vfBGDTeVNY04UKny6jBABjjsCIbEC
X-Google-Smtp-Source: AKy350bBTP0RUd3cX3G8pswzZ8eldAiYzVe36XfKOv5lU7So16xU6XTQkLouAGDJS2Pe7qn5X2UGx5SIoKapJfnhm44=
X-Received: by 2002:a17:907:d02:b0:931:6921:bdbb with SMTP id
 gn2-20020a1709070d0200b009316921bdbbmr17344454ejc.2.1680535713826; Mon, 03
 Apr 2023 08:28:33 -0700 (PDT)
MIME-Version: 1.0
References: <53d4ed4e5b18a59a48790434f8146fb207e11c49.1680494945.git.viresh.kumar@linaro.org>
In-Reply-To: <53d4ed4e5b18a59a48790434f8146fb207e11c49.1680494945.git.viresh.kumar@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 3 Apr 2023 17:28:20 +0200
Message-ID: <CAJZ5v0h4AUP92Wuprfoy2ErhiktTvRquyc9-iMwzt6d=HaqYMg@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: drivers with target_index() must set freq_table
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Yajun Deng <yajun.deng@linux.dev>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 3, 2023 at 6:09 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
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
>  drivers/cpufreq/cpufreq.c    | 5 +++++
>  drivers/cpufreq/freq_table.c | 9 ++++++++-
>  2 files changed, 13 insertions(+), 1 deletion(-)
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

This needs to go into a header (as a static inline) or the prototype
of it needs to go into a header.

> +
>  /* internal prototypes */
>  static unsigned int __cpufreq_get(struct cpufreq_policy *policy);
>  static int cpufreq_init_governor(struct cpufreq_policy *policy);
> diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
> index 90bfc27ed1ba..c6fc5b0ea91f 100644
> --- a/drivers/cpufreq/freq_table.c
> +++ b/drivers/cpufreq/freq_table.c
> @@ -10,6 +10,8 @@
>  #include <linux/cpufreq.h>
>  #include <linux/module.h>
>
> +bool has_target_index(void);
> +
>  /*********************************************************************
>   *                     FREQUENCY TABLE HELPERS                       *
>   *********************************************************************/
> @@ -355,8 +357,13 @@ int cpufreq_table_validate_and_sort(struct cpufreq_policy *policy)
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
> --
> 2.31.1.272.g89b43f80a514
>

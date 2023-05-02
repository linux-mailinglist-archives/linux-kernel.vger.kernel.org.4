Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB226F4648
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 16:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234100AbjEBOpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 10:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233896AbjEBOpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 10:45:30 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A56EA1708
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 07:45:28 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-b9d8e8898eeso5746866276.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 07:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683038728; x=1685630728;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NTBZ86MIa71wdhLiJNVYf2ScZ/YF/VVN/KJT6PzGP/s=;
        b=aH8mipMhXlRPfGIt53xIx10PTcU3921Ln8uaf4xgONWzNjnyaKGggUn0eeDFyvNUuc
         m4AsQOW00J89ts1hmJZOtdSWkyL3fjjaOc8ocENdqM9/QdDvCVZoj75hCsqXmGP0rJp7
         qfzaDRWbJH+B3tU2nzN9o1SLkc4BnivrfRJWNOjbPnhxQJFwdr0UjecDM7XzRqdpjjRo
         ssNvflVz9IN5Y9g55II4YpFpKsamUpM3dFIZHHxjW+jMQ5g5y1eE2JOh53eF8OHQkCBB
         soWjSiJ5sebGVHuIb1DMdRHQDzufOniOpmXX3pxNYoqABWMl2Szp0e754m+a+srIgA9C
         3NvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683038728; x=1685630728;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NTBZ86MIa71wdhLiJNVYf2ScZ/YF/VVN/KJT6PzGP/s=;
        b=OEFqj0QvZUDDZxIiHv44uo9NS3jWcEvJW1wp2PVF+IlA+CtXzEL+iaU6yMgXHT0ubD
         9TZyxUk08vqLM+3RFDSRDPVZgDHzJEpw/pFF0si1rWJPQ5BU4RpQDBwrZnYaMhdA2kZi
         iLoQylcKgErfq/tGxE6bZhJOGVFIfdzHBKC/+dyhwDgmIwXDutYAfOiyK7yib/r8oqQJ
         JAh3uqOBMDEpGcz57JLDU9c+yf4NE4fMR1lD4+q+f6axwsunh1Qcy+RHS3PQJD1LyEfh
         qNEm2UX98ibQdcrRiH83nOLcI8yfr1AH7p+SNFp8uCIGCXjP2Xe9MztF9hYg3VpUAcK+
         dUbQ==
X-Gm-Message-State: AC+VfDwHAD+z64eSGRFJZSAxP+XpdOhuO92Q1KomzCfvGpDMQ115c936
        asrD7av9jdWcGfTu83voEfL2SEYisR6fRtZro83b3w==
X-Google-Smtp-Source: ACHHUZ5qZiUNmAsvaStVmdKd0XzydKOgSQ/xrcQAJSaGleuVOqeU2KmB/hNCXa6HhLhV9h8ddsC+a2OyqkzhSp6TSew=
X-Received: by 2002:a25:ac93:0:b0:b99:860a:87d6 with SMTP id
 x19-20020a25ac93000000b00b99860a87d6mr18240890ybi.35.1683038727829; Tue, 02
 May 2023 07:45:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230424110933.3908-1-quic_mkshah@quicinc.com> <20230424110933.3908-3-quic_mkshah@quicinc.com>
In-Reply-To: <20230424110933.3908-3-quic_mkshah@quicinc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 2 May 2023 16:44:52 +0200
Message-ID: <CAPDyKFowJheraoMdJSyhdXB_FcT1oeiAwqrF8eGLC3FNVqhzCg@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] cpuidle: psci: Move enabling OSI mode after power
 domains creation
To:     andersson@kernel.org, Maulik Shah <quic_mkshah@quicinc.com>
Cc:     dianders@chromium.org, swboyd@chromium.org, wingers@google.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, sudeep.holla@arm.com,
        jwerner@chromium.org, quic_lsrao@quicinc.com,
        quic_rjendra@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Apr 2023 at 13:10, Maulik Shah <quic_mkshah@quicinc.com> wrote:
>
> A switch from OSI to PC mode is only possible if all CPUs other than the
> calling one are OFF, either through a call to CPU_OFF or not yet booted.
>
> Currently OSI mode is enabled before power domains are created. In cases
> where CPUidle states are not using hierarchical CPU topology the bail out
> path tries to switch back to PC mode which gets denied by firmware since
> other CPUs are online at this point and creates inconsistent state as
> firmware is in OSI mode and Linux in PC mode.
>
> This change moves enabling OSI mode after power domains are created,
> this would makes sure that hierarchical CPU topology is used before
> switching firmware to OSI mode.
>
> Fixes: 70c179b49870 ("cpuidle: psci: Allow PM domain to be initialized even if no OSI mode")
> Signed-off-by: Maulik Shah <quic_mkshah@quicinc.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Bjorn, can you pick up this series for 6.4-rc[n]? Moreover, I think it
would be a good idea to tag both patch 1 and patch 2 for stable
kernels.

Kind regards
Uffe

> ---
>  drivers/cpuidle/cpuidle-psci-domain.c | 39 +++++++++------------------
>  1 file changed, 13 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
> index c2d6d9c3c930..b88af1262f1a 100644
> --- a/drivers/cpuidle/cpuidle-psci-domain.c
> +++ b/drivers/cpuidle/cpuidle-psci-domain.c
> @@ -120,20 +120,6 @@ static void psci_pd_remove(void)
>         }
>  }
>
> -static bool psci_pd_try_set_osi_mode(void)
> -{
> -       int ret;
> -
> -       if (!psci_has_osi_support())
> -               return false;
> -
> -       ret = psci_set_osi_mode(true);
> -       if (ret)
> -               return false;
> -
> -       return true;
> -}
> -
>  static void psci_cpuidle_domain_sync_state(struct device *dev)
>  {
>         /*
> @@ -152,15 +138,12 @@ static int psci_cpuidle_domain_probe(struct platform_device *pdev)
>  {
>         struct device_node *np = pdev->dev.of_node;
>         struct device_node *node;
> -       bool use_osi;
> +       bool use_osi = psci_has_osi_support();
>         int ret = 0, pd_count = 0;
>
>         if (!np)
>                 return -ENODEV;
>
> -       /* If OSI mode is supported, let's try to enable it. */
> -       use_osi = psci_pd_try_set_osi_mode();
> -
>         /*
>          * Parse child nodes for the "#power-domain-cells" property and
>          * initialize a genpd/genpd-of-provider pair when it's found.
> @@ -170,33 +153,37 @@ static int psci_cpuidle_domain_probe(struct platform_device *pdev)
>                         continue;
>
>                 ret = psci_pd_init(node, use_osi);
> -               if (ret)
> -                       goto put_node;
> +               if (ret) {
> +                       of_node_put(node);
> +                       goto exit;
> +               }
>
>                 pd_count++;
>         }
>
>         /* Bail out if not using the hierarchical CPU topology. */
>         if (!pd_count)
> -               goto no_pd;
> +               return 0;
>
>         /* Link genpd masters/subdomains to model the CPU topology. */
>         ret = dt_idle_pd_init_topology(np);
>         if (ret)
>                 goto remove_pd;
>
> +       /* let's try to enable OSI. */
> +       ret = psci_set_osi_mode(use_osi);
> +       if (ret)
> +               goto remove_pd;
> +
>         pr_info("Initialized CPU PM domain topology using %s mode\n",
>                 use_osi ? "OSI" : "PC");
>         return 0;
>
> -put_node:
> -       of_node_put(node);
>  remove_pd:
> +       dt_idle_pd_remove_topology(np);
>         psci_pd_remove();
> +exit:
>         pr_err("failed to create CPU PM domains ret=%d\n", ret);
> -no_pd:
> -       if (use_osi)
> -               psci_set_osi_mode(false);
>         return ret;
>  }
>
> --
> 2.17.1
>

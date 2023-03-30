Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E86336D047F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 14:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbjC3MUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 08:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbjC3MUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 08:20:34 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB5476BE
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 05:20:32 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-54606036bb3so185040057b3.6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 05:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680178832;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ebh62fyj9Rt/xb8D6XtV5BDFOP4hP6TmDr82O5nhPvU=;
        b=nIj81mbOXrsamPzxEfchJuVfNpnMNDMcwsIk45/lsgM5LwyhFJxuo8rXKJoZllk40x
         12hodu1fv1PNBT6Ft7M69+JlccJFEKE9cHUqtz239iyPS3B1sqKEhrT4Xs0BcsYs3HtX
         Z6ZWFnd3KiNI70T6+2Yxs6aRxqqMFgzvDRk7/h1Tkx64WSNxcDog/jXz86i7F5O3wbq3
         yc7S4PPUOGrF2aPS12iml5NU5tNfX4Yc8/703Ipe5elK4Or9wvBuLtIvgZPzDh8GGjEi
         AYb6r8A0g+CoMBbG/rV2bvYgF8kVwq4xpXTs66TA4HMFbGhEMcDGT/B/vpJOzK5FMJBq
         9DlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680178832;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ebh62fyj9Rt/xb8D6XtV5BDFOP4hP6TmDr82O5nhPvU=;
        b=rEs/aW4UbmaVpbRsvuMGhxRhiwJ5nazt0Ly2/bI7crplN91hEHYhmBUV5jn90vt8cm
         0SoSH6Woh25GL57R5CcgldUBh1cY7ljDnU9HwMQWvB7O08LaurQ1YMe7WukvPl87XnHp
         0l+DGm61/RgyuLsV+fcF1gQXs1DovVADJjW21Jueu0pJ/qwMS9PCRnkkGT36OjX8KdS8
         HIyi6DDa0xN9no5A3zow+Wqy4rsAr4ZWUKFxAhJuGz28jWtVjNQ3n1L9D3qAvbkucBqu
         9fQ5tht3/nHibR4WT33vmoHJ387fATPs6wwo8HCJi73DWam8OD5I2RQo0x7gpsTwcr6s
         96Pg==
X-Gm-Message-State: AAQBX9eHNKuxke/HFaLcDpMsuBIA9ywIbmo+oYuVrdmWq5wUBDhRXtgf
        619z6dDZ2+dxoMswH9lnh+4/NEyE0ZIO+ywpgok0eA==
X-Google-Smtp-Source: AKy350aaJJxisjmNpWLi/TstJOZL0OlnT7uMy9eW7eVk6QPpqhA559oMKyRJP+f3cklGyDWvBQilFpkKrudxImVgRC8=
X-Received: by 2002:a81:ad04:0:b0:52e:e095:d840 with SMTP id
 l4-20020a81ad04000000b0052ee095d840mr178158ywh.0.1680178832001; Thu, 30 Mar
 2023 05:20:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230330084250.32600-1-quic_mkshah@quicinc.com> <20230330084250.32600-2-quic_mkshah@quicinc.com>
In-Reply-To: <20230330084250.32600-2-quic_mkshah@quicinc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 30 Mar 2023 14:19:55 +0200
Message-ID: <CAPDyKFo++9u5B+Prnzwn4NkYUVy3YLC5hx2tDSBU34OjaSDOEQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] cpuidle: psci: Move enabling OSI mode after power
 domains creation
To:     Maulik Shah <quic_mkshah@quicinc.com>
Cc:     andersson@kernel.org, dianders@chromium.org, swboyd@chromium.org,
        wingers@google.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        sudeep.holla@arm.com, jwerner@chromium.org, quic_lsrao@quicinc.com,
        quic_rjendra@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Mar 2023 at 10:43, Maulik Shah <quic_mkshah@quicinc.com> wrote:
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
> ---
>  drivers/cpuidle/cpuidle-psci-domain.c | 29 +++++++--------------------
>  1 file changed, 7 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
> index 11316c3b14ca..d81f6ae35002 100644
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
> @@ -178,13 +161,18 @@ static int psci_cpuidle_domain_probe(struct platform_device *pdev)
>
>         /* Bail out if not using the hierarchical CPU topology. */
>         if (!pd_count)
> -               goto no_pd;
> +               goto remove_pd;
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

If this fails, subdomains that were added in
dt_idle_pd_init_topology() should be removed too. In other words, we
need a add a new helper function in drivers/cpuidle/dt_idle_genpd.c,
that we can call before calling psci_pd_remove() for this error path.

> +
>         pr_info("Initialized CPU PM domain topology using %s mode\n",
>                 use_osi ? "OSI" : "PC");
>         return 0;
> @@ -194,9 +182,6 @@ static int psci_cpuidle_domain_probe(struct platform_device *pdev)
>  remove_pd:
>         psci_pd_remove();
>         pr_err("failed to create CPU PM domains ret=%d\n", ret);
> -no_pd:
> -       if (use_osi)
> -               psci_set_osi_mode(false);
>         return ret;
>  }
>

Other than the above, this looks good to me.

Kind regards
Uffe

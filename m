Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C57EF6E5BC4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 10:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbjDRINJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 04:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbjDRINI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 04:13:08 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED54659DF
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 01:13:06 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-555bc7f6746so2987327b3.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 01:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681805586; x=1684397586;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VCiNu1mOtB7laUM4bFCLww5HGe90bX5kQCMaz63PSvg=;
        b=uzbsajfvzhMME2BbITiqUYlU5JmDHTOBbzrynZ8UB9jovx8iStQe0oFs0+sb9CD2c5
         en04wTDEnp4Y08px8o3TnO70QysiactEsoaFebfFydHRVttStiEddPcuD4M+XLePSnP7
         CE0xk7DAdExtDFo8Gua+G6R3JNWJJWlWKB6tuDr/fevhCWCAqnYfCf1GqjULT5qgNBIf
         2GEyDh82sTVHgIpAlfG40ZTNV17svod4n1r6BUr48pX31McQPN+TnuKZ1HN2pqUGkFt0
         oEInSPUsRd2bzzr2WkPA5JxtMZ4TbZibZzFfdi4tVrd6yrbcfQy8gb9RnV4/1vR1PKgx
         RyyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681805586; x=1684397586;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VCiNu1mOtB7laUM4bFCLww5HGe90bX5kQCMaz63PSvg=;
        b=XNJEZCpCuXAelPkPbSonEvnTyR6rlloUNYqf1WiASWPkmqpabKBYW5h6C7tTUsslfX
         lv8G704Kw6WgXSG67V2wPsmx/rkmWPYTsy3O8FzUI9dW7Wwc0K+iGFLZMZZWfF1rFUaN
         ED4UVepCVHqMi6vITPjl09aqf4U6I9ka9BOSv5PYJMQitfXGW6arXTfEc/x4IuhzQxp4
         YI/YKDzPC0GATQ5xHpzRQbPfOfZnNcDXy1U0zTyKcCxhB8CzUGFMvjMisvA8CA3YzDlH
         WrP2x1zVXA8Wo3ye225VPIEWVgTc9kD5iKH/18/jMEkBXcp/4WU93mOrxlNnHOZpYBMb
         qDhQ==
X-Gm-Message-State: AAQBX9ccxv44y9tLLTmnJgVEZswxg0VS9D0V0oxyAIWu+8kVV9uySbsw
        9e9GP2bp5CXjfKO92oB5DCLuNm+mJe7MD5bU7cBGbQ==
X-Google-Smtp-Source: AKy350ZywKW3umEFRPuEXLr49A90pYI8xBxXLbq4XkCJ4luVxZdyxE426uVcMC2dvbm4Il8k1fcAWgge3csmlCitul8=
X-Received: by 2002:a81:6ac3:0:b0:54f:bb34:1a0 with SMTP id
 f186-20020a816ac3000000b0054fbb3401a0mr17171311ywc.33.1681805586119; Tue, 18
 Apr 2023 01:13:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230414055502.23920-1-quic_mkshah@quicinc.com> <20230414055502.23920-3-quic_mkshah@quicinc.com>
In-Reply-To: <20230414055502.23920-3-quic_mkshah@quicinc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 18 Apr 2023 10:12:30 +0200
Message-ID: <CAPDyKFo5UhOca-DvOKOZWcBrcK8ONdSO8-M=8fE6kkwkPuoCww@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] cpuidle: psci: Move enabling OSI mode after power
 domains creation
To:     Maulik Shah <quic_mkshah@quicinc.com>
Cc:     andersson@kernel.org, dianders@chromium.org, swboyd@chromium.org,
        wingers@google.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        sudeep.holla@arm.com, jwerner@chromium.org, quic_lsrao@quicinc.com,
        quic_rjendra@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Apr 2023 at 07:55, Maulik Shah <quic_mkshah@quicinc.com> wrote:
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
>  drivers/cpuidle/cpuidle-psci-domain.c | 37 +++++++++------------------
>  1 file changed, 12 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
> index c2d6d9c3c930..c3993df24eef 100644
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
> @@ -178,25 +161,29 @@ static int psci_cpuidle_domain_probe(struct platform_device *pdev)
>
>         /* Bail out if not using the hierarchical CPU topology. */
>         if (!pd_count)
> -               goto no_pd;
> +               goto remove_pd;

We should return 0 here instead, right?

>
>         /* Link genpd masters/subdomains to model the CPU topology. */
>         ret = dt_idle_pd_init_topology(np);
>         if (ret)
> -               goto remove_pd;
> +               goto remove_pd_topology;

This looks wrong to me. Shouldn't we continue to goto the "remove_pd"
label for this error path?

> +
> +       /* let's try to enable OSI. */
> +       ret = psci_set_osi_mode(use_osi);
> +       if (ret)
> +               goto remove_pd_topology;
>
>         pr_info("Initialized CPU PM domain topology using %s mode\n",
>                 use_osi ? "OSI" : "PC");
>         return 0;
>
> -put_node:
> -       of_node_put(node);
> +remove_pd_topology:
> +       dt_idle_pd_remove_topology(np);
>  remove_pd:
>         psci_pd_remove();
> +put_node:
> +       of_node_put(node);

This of_node_put() should only be called if we break the
"for_each_child_of_node" loop above because of an error, I think.
Perhaps it's cleaner to just move this within the loop?

>         pr_err("failed to create CPU PM domains ret=%d\n", ret);
> -no_pd:
> -       if (use_osi)
> -               psci_set_osi_mode(false);
>         return ret;
>  }
>

Kind regards
Uffe

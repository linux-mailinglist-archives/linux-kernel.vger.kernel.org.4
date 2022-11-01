Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5A5E6147A6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 11:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbiKAKYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 06:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiKAKYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 06:24:31 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4547A186DA
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 03:24:30 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id l6so12803012pjj.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 03:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=G27PB63jY0z3/fpHB0BQ1Kdye9lV/ZHggnYFcrsKWco=;
        b=waf112C4P4YwSrlWJHHTQ+XL8dK8D8M/8vd4OqgemEhLBpZ14CYDPFdowGZa5MFU1z
         jioD9q0xKQ4OdY08CbTweE83kGjXJhBKrUp32FK0H3KvvgnTaC+qvaMlXNpGxUfFMfeQ
         OrFhXK3NvX2fOK/fkvnkg+J1fr1nMb2ugki8hqn7IcL/oZAB4oiqRhN1m5pEMf/Ic6VE
         8pm+fyNfKphPL7b6JhJFlkZZAdD36YLkJLu2CliQa1o053sK0xYtMKIhXb6AgklobYAK
         H0yF4cQKosIAOp/6WHpWCdFqsJ+RoIeHIYWIsE10mJ3tu2PIH0EBCuZPnWYPMpf01Ppr
         8G4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G27PB63jY0z3/fpHB0BQ1Kdye9lV/ZHggnYFcrsKWco=;
        b=ts3Y5byPjnolL+JXjo/YD5P4gYa4KTtmLfDzPel36uslDALSWtDJCNarVnFV4r6W0N
         x41nWwijwFmqvKgFUnA//jbRHMyUn9bsdvFV/yArXfdjKU2IZYBul4f/vGHuI0QcJsxd
         lwab0DMzAPcys6gxEfTsi9x+7XrRcbpacyGkKy+h/zwJDBdsAkNLu1dcsGfMTRUqvvsG
         yqp5HPKnWzbdVkSYwM+S8U7hdz6y6WBeebm0Yj2PCJZoh/fD5GtkqP0zQEngbgRQLh+T
         w/1oQR61Md/DggYe0fVUJ3KSwWglO+yI5xhHw8CbmmV4B280oRrNB5VUTfvXLRnBcH0/
         BPpQ==
X-Gm-Message-State: ACrzQf3qhuWCgeIYn/LPADPj7vbEyoFK6CqyfVJgoP7j08AJi92yrOc8
        2o3nc1AobenRfoeXIo/zl4ExkiMr+fC4Ci5dSCAlqA==
X-Google-Smtp-Source: AMsMyM5eUWamxWYHu2qfyxXqJaaASparm/ZC0aj1msADqcNmEgV6HAKHuoMMfn5ZqNt1YK9DTcMtvM5pZYkXjAXVDvg=
X-Received: by 2002:a17:90b:4d07:b0:1ef:521c:f051 with SMTP id
 mw7-20020a17090b4d0700b001ef521cf051mr37408581pjb.164.1667298269801; Tue, 01
 Nov 2022 03:24:29 -0700 (PDT)
MIME-Version: 1.0
References: <20221101024736.1509207-1-shawn.guo@linaro.org> <20221101024736.1509207-2-shawn.guo@linaro.org>
In-Reply-To: <20221101024736.1509207-2-shawn.guo@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 1 Nov 2022 11:23:53 +0100
Message-ID: <CAPDyKFoyoMvfLcEKj2OBBky8KZc3jBp8y_UfYqpGH9ETfSJ5yQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] PM: domains: Pass generic PM noirq hooks to genpd_finish_suspend()
To:     Shawn Guo <shawn.guo@linaro.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Nov 2022 at 03:47, Shawn Guo <shawn.guo@linaro.org> wrote:
>
> While argument `poweroff` works fine for genpd_finish_suspend() to handle
> distinction between suspend and poweroff, it won't scale if we want to
> use it for freeze as well.  Pass generic PM noirq hooks as arguments
> instead, so that the function can possibly cover freeze case too.
>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe


> ---
>  drivers/base/power/domain.c | 25 +++++++++++++------------
>  1 file changed, 13 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 6471b559230e..54f6b0dd35fb 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -1189,12 +1189,15 @@ static int genpd_prepare(struct device *dev)
>   * genpd_finish_suspend - Completion of suspend or hibernation of device in an
>   *   I/O pm domain.
>   * @dev: Device to suspend.
> - * @poweroff: Specifies if this is a poweroff_noirq or suspend_noirq callback.
> + * @suspend_noirq: Generic suspend_noirq callback.
> + * @resume_noirq: Generic resume_noirq callback.
>   *
>   * Stop the device and remove power from the domain if all devices in it have
>   * been stopped.
>   */
> -static int genpd_finish_suspend(struct device *dev, bool poweroff)
> +static int genpd_finish_suspend(struct device *dev,
> +                               int (*suspend_noirq)(struct device *dev),
> +                               int (*resume_noirq)(struct device *dev))
>  {
>         struct generic_pm_domain *genpd;
>         int ret = 0;
> @@ -1203,10 +1206,7 @@ static int genpd_finish_suspend(struct device *dev, bool poweroff)
>         if (IS_ERR(genpd))
>                 return -EINVAL;
>
> -       if (poweroff)
> -               ret = pm_generic_poweroff_noirq(dev);
> -       else
> -               ret = pm_generic_suspend_noirq(dev);
> +       ret = suspend_noirq(dev);
>         if (ret)
>                 return ret;
>
> @@ -1217,10 +1217,7 @@ static int genpd_finish_suspend(struct device *dev, bool poweroff)
>             !pm_runtime_status_suspended(dev)) {
>                 ret = genpd_stop_dev(genpd, dev);
>                 if (ret) {
> -                       if (poweroff)
> -                               pm_generic_restore_noirq(dev);
> -                       else
> -                               pm_generic_resume_noirq(dev);
> +                       resume_noirq(dev);
>                         return ret;
>                 }
>         }
> @@ -1244,7 +1241,9 @@ static int genpd_suspend_noirq(struct device *dev)
>  {
>         dev_dbg(dev, "%s()\n", __func__);
>
> -       return genpd_finish_suspend(dev, false);
> +       return genpd_finish_suspend(dev,
> +                                   pm_generic_suspend_noirq,
> +                                   pm_generic_resume_noirq);
>  }
>
>  /**
> @@ -1353,7 +1352,9 @@ static int genpd_poweroff_noirq(struct device *dev)
>  {
>         dev_dbg(dev, "%s()\n", __func__);
>
> -       return genpd_finish_suspend(dev, true);
> +       return genpd_finish_suspend(dev,
> +                                   pm_generic_poweroff_noirq,
> +                                   pm_generic_restore_noirq);
>  }
>
>  /**
> --
> 2.25.1
>

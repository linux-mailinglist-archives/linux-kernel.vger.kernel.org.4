Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 093E46147AB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 11:25:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbiKAKZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 06:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbiKAKZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 06:25:18 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 046CB186DA
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 03:25:17 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id s196so13046266pgs.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 03:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UzaP6H2n+Ux6mF9ntbtY3HjcdPLfyeY4b4+5jsw9NFc=;
        b=K67YoO89ft4OBL/cSXdU99CvmQEG1lOVf9vlR+HxtxzxPYUQsnSF2vaI3zExgs0hYD
         Koq54uyKFu1cRMvkxZ2/onlABECMos8mSgc01OdYuyjX3WG+Ji+ii93IoVkgFQBQD8qT
         Q1jxR0Kk7Ks3Y/RJT+XPM64hEfRRHOjE5fetDH7VqGUXSI+CS4bjfQEw07FZfpYy1BDE
         jQOsqABfyekEkiZ0Y5c9A6/Yxg+REJDvPb0xLm/AIQJ0jMX5nNBHdyJbZhBY5j4nwQGA
         ALCrM5L9oA33IKub6rhhUB2WoAXCpDYrJFDmFMNbR3Odtp05ehCj5foR8KrRmOR8yfVp
         SCmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UzaP6H2n+Ux6mF9ntbtY3HjcdPLfyeY4b4+5jsw9NFc=;
        b=ojcZJ+h3e0/dayEDh1o3nkeGkLpP0DqnH1KRYv3Efe5eKsTAcSW0TVzUJN32rh2VPo
         hVIE0JKlCr/gWIC7SN1WIkRpBbEYYfQh3l5mVxO7+DgUFO950/Z7BYznDRx8WQpyRmXu
         DnqBOyBEZkxXXM1WaPyXoV9Tv1h5xhcF1ssiBaovUUIUn4yBLlDDAyORvIpCK2FS2v7i
         XVO5G9rR5oVkspdq7WBzavCkWW0iK6vyHb3ikramgEwPgrIgN1adrTayDBVTFPzLDl78
         /LJZAystYSJCS9UGO2gnxvbU71l0JCe67Dg3suyP/ofBs4+Oi2YN0DZwSbzsYueFXxgx
         x36w==
X-Gm-Message-State: ACrzQf3Bu0ejuIvHFBuBbwhLIsI/3wifvMtfCORjz00iPgJViwWjaowW
        A3epAM/+RBf3BjkWR0I3fgNYixxaXyPZn32NU7Tqlg==
X-Google-Smtp-Source: AMsMyM5YqrlZpuviaO+utF1dLtIVzEV1mde0FZoUPJC4rIXXDmiDVGuVbe04MtPn8QqNGjBJCo9eCCSGeD4BZilYZLk=
X-Received: by 2002:a63:464d:0:b0:441:5968:cd0e with SMTP id
 v13-20020a63464d000000b004415968cd0emr17219844pgk.595.1667298316520; Tue, 01
 Nov 2022 03:25:16 -0700 (PDT)
MIME-Version: 1.0
References: <20221101024736.1509207-1-shawn.guo@linaro.org> <20221101024736.1509207-4-shawn.guo@linaro.org>
In-Reply-To: <20221101024736.1509207-4-shawn.guo@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 1 Nov 2022 11:24:39 +0100
Message-ID: <CAPDyKFo-S7s4dSf33TOv2SBFEKW6oUKoMjg5vDPxf1OpY5=kAw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] PM: domains: Power off[on] domain in hibernate
 .freeze[thaw]_noirq hook
To:     Shawn Guo <shawn.guo@linaro.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
> On platforms which use SHUTDOWN as hibernation mode, the genpd noirq
> hooks will be called like below.
>
>     genpd_freeze_noirq()         genpd_restore_noirq()
>           =E2=86=93                            =E2=86=91
>     Create snapshot image        Restore system
>           =E2=86=93                            =E2=86=91
>     genpd_thaw_noirq()           Read snapshot image
>           =E2=86=93                            =E2=86=91
>     Write snapshot image         Kernel boot
>           =E2=86=93                            =E2=86=91
>     power_down()                 Power on device
>
> As of today suspend hooks genpd_suspend[resume]_noirq() manages domain
> on/off state, but hibernate hooks genpd_freeze[thaw]_noirq() doesn't.
> This results in a different behavior of domain power state between suspen=
d
> and hibernate freeze, i.e. domain is powered off for the former while on
> for the later.  It causes a problem on platforms like i.MX where the
> domain needs to be powered on/off by calling clock and regulator interfac=
e.
> When the platform restores from hibernation, the domain is off in hardwar=
e
> and genpd_restore_noirq() tries to power it on, but will never succeed
> because software state of domain (clock and regulator) is left on from th=
e
> last hibernate freeze, so kernel thinks that clock and regulator are
> enabled while they are actually not turned on in hardware.  The
> consequence would be that devices in the power domain will access
> registers without clock or power, and cause hardware lockup.
>
> Power off[on] domain in hibernate .freeze[thaw]_noirq hook for reasons:
>
> - Align the behavior between suspend and hibernate freeze.
> - Have power state of domains stay in sync between hardware and software
>   for hibernate freeze, and thus fix the lockup issue seen on i.MX
>   platform.
>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/base/power/domain.c | 35 ++++-------------------------------
>  1 file changed, 4 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index b81baeb38d81..28c9e04e3488 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -1323,24 +1323,11 @@ static int genpd_resume_noirq(struct device *dev)
>   */
>  static int genpd_freeze_noirq(struct device *dev)
>  {
> -       const struct generic_pm_domain *genpd;
> -       int ret =3D 0;
> -
>         dev_dbg(dev, "%s()\n", __func__);
>
> -       genpd =3D dev_to_genpd(dev);
> -       if (IS_ERR(genpd))
> -               return -EINVAL;
> -
> -       ret =3D pm_generic_freeze_noirq(dev);
> -       if (ret)
> -               return ret;
> -
> -       if (genpd->dev_ops.stop && genpd->dev_ops.start &&
> -           !pm_runtime_status_suspended(dev))
> -               ret =3D genpd_stop_dev(genpd, dev);
> -
> -       return ret;
> +       return genpd_finish_suspend(dev,
> +                                   pm_generic_freeze_noirq,
> +                                   pm_generic_thaw_noirq);
>  }
>
>  /**
> @@ -1352,23 +1339,9 @@ static int genpd_freeze_noirq(struct device *dev)
>   */
>  static int genpd_thaw_noirq(struct device *dev)
>  {
> -       const struct generic_pm_domain *genpd;
> -       int ret =3D 0;
> -
>         dev_dbg(dev, "%s()\n", __func__);
>
> -       genpd =3D dev_to_genpd(dev);
> -       if (IS_ERR(genpd))
> -               return -EINVAL;
> -
> -       if (genpd->dev_ops.stop && genpd->dev_ops.start &&
> -           !pm_runtime_status_suspended(dev)) {
> -               ret =3D genpd_start_dev(genpd, dev);
> -               if (ret)
> -                       return ret;
> -       }
> -
> -       return pm_generic_thaw_noirq(dev);
> +       return genpd_finish_resume(dev, pm_generic_thaw_noirq);
>  }
>
>  /**
> --
> 2.25.1
>

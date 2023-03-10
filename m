Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A71996B4BD6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 17:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbjCJQAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 11:00:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjCJP7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 10:59:47 -0500
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D377010DE57
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 07:54:56 -0800 (PST)
Received: by mail-ua1-x935.google.com with SMTP id s23so3816722uae.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 07:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1678463696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m9lGiLB1lEwMSjkrCTWHQZ/8zcOfwInRl7UwDtArVSU=;
        b=C46AmGmDmfwAdLj2SgY1PW7ZWR+LC+Gmr/dZv1uSFCIid1PZM4MLTZy90LvLGDOG6T
         XHe5nQGK5R7JfzvqbVFO6VMtsOmyCNOQESsV0hwJtjuoCY4LbcvPRAJDqGnQUKS0aJT1
         TsUDSHrWhC958ugTLQHBZCrnILOQbOJeKzuIpUSu8fnGdIFVtGU1kbS8m/7/zx5AGJEl
         WTEZDX/6QyQZ/P2jTUHx5VlJxogVIXOHP8CbZWyskt8oak8iIEs6S42KMrgeNop7mcop
         jQojiHdw25lIL5d5kGOpe2G4Mf68JjB5PnFKOcdT3RAAEfcrZ1Vg1UlkrH9fsMDJWQLD
         gYPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678463696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m9lGiLB1lEwMSjkrCTWHQZ/8zcOfwInRl7UwDtArVSU=;
        b=fjY8fLMixG89u7LKHvtfBapVJvwqqGeCawbxHkKY3HL/gDCtCSjlQsXFODbUxi4Jex
         S94c6jKq+sSkW2gsp9f+8QJBD9VT8J/qmfWIhLjxKv/ARk4Y5LYhm8qjtTEa+vDEtIPP
         pmbhpYtHa+jmNdl+Zc7NKljHYwu1ax1CQrnqCkT+Hh/bDgSDoW75iVdQoKczHLu17ci5
         Y0EHd4MoES51rn94w/t9ez9tfG2ol6Npz6rLz9QpzlH1EttNqcdrv3TlDuPvNoP3Akot
         7dPR/DeUB+dzeyUXV9A0TyRb/gPCMQlv7OTYlvfhkn4AqApfMxKWxDSNCgEykyVOy42U
         79PA==
X-Gm-Message-State: AO0yUKUK6gV87kx/jgDRjOY6hJdcZJo7XtozdM+DOer8Em+4U0nbJY9D
        yL4++oAX+h1Mvv6d8DuXWOXiQ8ons3lLmow1Lq/Xvg==
X-Google-Smtp-Source: AK7set/uLrctXAmLmCXI3O92TwFhdhy57q28oF6cfBKTGPlwcWFkmvc8sDNaWExJPn+GdXgRaEw1O7wKjSCRbjG2fyM=
X-Received: by 2002:ab0:4a12:0:b0:68e:2dce:3162 with SMTP id
 q18-20020ab04a12000000b0068e2dce3162mr16916689uae.2.1678463695960; Fri, 10
 Mar 2023 07:54:55 -0800 (PST)
MIME-Version: 1.0
References: <20230309184636.84124-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230309184636.84124-1-andriy.shevchenko@linux.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 10 Mar 2023 16:54:44 +0100
Message-ID: <CAMRc=MdAQ27K_tm2+pzQULo7NtV4wUBPM3fX-9a+snXWTQUh0A@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] gpio: sim: Deactivate device in reversed order
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 9, 2023 at 7:46=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Run the steps to deactivate device in the reserved order to what
> it has been done in gpio_sim_device_activate_unlocked().
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/gpio/gpio-sim.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpio-sim.c b/drivers/gpio/gpio-sim.c
> index e5dfd636c63c..a1c8702f362c 100644
> --- a/drivers/gpio/gpio-sim.c
> +++ b/drivers/gpio/gpio-sim.c
> @@ -953,9 +953,9 @@ static void gpio_sim_device_deactivate_unlocked(struc=
t gpio_sim_device *dev)
>
>         swnode =3D dev_fwnode(&dev->pdev->dev);
>         platform_device_unregister(dev->pdev);
> +       gpio_sim_remove_hogs(dev);
>         gpio_sim_remove_swnode_recursive(swnode);
>         dev->pdev =3D NULL;
> -       gpio_sim_remove_hogs(dev);
>  }
>
>  static ssize_t
> --
> 2.39.1
>

Meh, doesn't really fix any problem but applied anyway for consistency.

Thanks,
Bart

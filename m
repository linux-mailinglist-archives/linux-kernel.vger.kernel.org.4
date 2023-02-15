Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7845697E9A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 15:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbjBOOn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 09:43:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjBOOnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 09:43:55 -0500
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B8F14EAC
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 06:43:54 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-501c3a414acso274504927b3.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 06:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ga39QTsy+z+m6NyTC7ZtkFH0kMl3HCJFlPDjuWsRCWk=;
        b=U8p4AERjm1Lc3YZ7T+TlMGqRY40l2Na0nQvgNEMfY5Va6AhzuV+WvbVhijMw9eW2HY
         1Ssw2ZRTxZD2a3aWcS4Bskkin0pC6SDjPXDirKJjQxHmgsr/LxtWia0H07SUueLe3cd0
         Fz2CmKxy3z/KV363+Ni/976R0aiofLVVtzbJVDUUhQIFTWzqQ8yJu7TQONZ1DJ9DX6nz
         7cy9vMpvsysDuhhTVa93efaKniU8TkUS27YVjqfFa4KPoWzgSqIjlM7kXlMe2wxwxi7n
         JnF2o4yPbHwZgyYV4dq9FtCYsEjkC/IJwWGKxu3/lf9aHkUAiE5NITBHcEpWEnosuCEW
         FFVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ga39QTsy+z+m6NyTC7ZtkFH0kMl3HCJFlPDjuWsRCWk=;
        b=kWzYgt2txLdyDOkUvD6OfRKmTuK/wHfKjUfMzGFv9y2lhiWIy1I3xRfXp+eFWxmk6i
         QyaIdb+KnsnD3xDndzQsLmYY+PsUAzovN93QGU+TrcRIPUeosvhhEFb2HopsDC7AraMg
         YQKkqmvpS1zb9XnsdH6Gw6CN165A4iNNSNF1yhKEyxXdy6Jpstxc12n65SJVM9f8WsFX
         O8bjVfGG0fu5mf/xtxGN8PFuH5BEAo74Nkdu5YjglESAbVE4RXjMj5WvKfui1czPxxQF
         hjKbT6eRTHNcCofabFQYAa6mN2gLv+v0NL9WODbAONVRUAvmJUzmbyZM+4f+kBaKoqz4
         OdNA==
X-Gm-Message-State: AO0yUKUELyk4vBFy8eGk5ZagxBUhwJArSkgQgEoD27neBLW+TvdD8Lbr
        oJNAUepNoIykxkBhjetsnrOMkeeVOISfqQ3wnmcNow==
X-Google-Smtp-Source: AK7set8QDwgi+2WYBs7jbHO1kq1hZku7IWBRjrps5059OlF1v3nu7z62weSmEN4CYag/RCS63I3P5y145+a8zVOVNwg=
X-Received: by 2002:a5b:c3:0:b0:83a:dd71:5b70 with SMTP id d3-20020a5b00c3000000b0083add715b70mr324341ybp.35.1676472233624;
 Wed, 15 Feb 2023 06:43:53 -0800 (PST)
MIME-Version: 1.0
References: <20230215092421.143199-1-alexander.stein@ew.tq-group.com>
In-Reply-To: <20230215092421.143199-1-alexander.stein@ew.tq-group.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 15 Feb 2023 15:43:41 +0100
Message-ID: <CACRpkdZbcs4zgGtuF5U4_JghHJ=A31T8jp2NTcN68P2Eh2azxg@mail.gmail.com>
Subject: Re: [PATCH 1/1] gpiolib: allow device numbering using OF alias
To:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Johan Hovold <johan@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Markus Niebel <Markus.Niebel@ew.tq-group.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Top-posting because important people are missing from the to:line.

It seems you are trying to enforce topology here,
i.e. hammering down what should come first, second etc, despite the
probe order.

First the DT people need to acknowledge that this is a valid way to use
device tree aliases. I'm not so sure about that. Remember that DT
is mostly OS neutral, but we do have aliases for some use cases that
can be the same tricky in any OS.

Second I want Johan Hovolds input on this from the Linux sysfs side, as
he keeps reminding me that sysfs already has topology and should be
discovered from there (loosely paraphrased from memory). It might
be that you are fixing something that should not be fixed.

Please keep the new respondents on subsequent postings.

Yours,
Linus Walleij

On Wed, Feb 15, 2023 at 10:24 AM Alexander Stein
<alexander.stein@ew.tq-group.com> wrote:

> From: Markus Niebel <Markus.Niebel@ew.tq-group.com>
>
> This is useful e.g. for the following cases
>
> - GPIO IP name order is not aligned with SOC addresses
>   (i.MX93 from NXP)
> - reproducible naming for GPIO expander chips
>
> The implementation is a mix of the one found for MMC and RTC.
>
> Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
> imx93 specifies alias for 4 on-chip GPIO controllers. But they are
> ignored:
> $ ls -o -g /sys/bus/gpio/devices/
> total 0
> lrwxrwxrwx 1 0 Feb 15 10:03 gpiochip0 -> ../../../devices/platform/soc@0/42000000.bus/42530000.i2c/i2c-2/2-0071/gpiochip0
> lrwxrwxrwx 1 0 Feb 15 10:03 gpiochip1 -> ../../../devices/platform/soc@0/42000000.bus/42530000.i2c/i2c-2/2-0072/gpiochip1
> lrwxrwxrwx 1 0 Feb 15 10:03 gpiochip2 -> ../../../devices/platform/soc@0/43810080.gpio/gpiochip2
> lrwxrwxrwx 1 0 Feb 15 10:03 gpiochip3 -> ../../../devices/platform/soc@0/43820080.gpio/gpiochip3
> lrwxrwxrwx 1 0 Feb 15 10:03 gpiochip4 -> ../../../devices/platform/soc@0/43830080.gpio/gpiochip4
> lrwxrwxrwx 1 0 Feb 15 10:03 gpiochip5 -> ../../../devices/platform/soc@0/47400080.gpio/gpiochip5
> lrwxrwxrwx 1 0 Feb 15 10:03 gpiochip6 -> ../../../devices/platform/soc@0/42000000.bus/42530000.i2c/i2c-2/2-0070/gpiochip6
>
> With this patch this becomes:
> $ ls -o -g /sys/bus/gpio/devices/
> total 0
> lrwxrwxrwx 1 0 Feb 15 10:18 gpiochip0 -> ../../../devices/platform/soc@0/47400080.gpio/gpiochip0
> lrwxrwxrwx 1 0 Feb 15 10:18 gpiochip1 -> ../../../devices/platform/soc@0/43810080.gpio/gpiochip1
> lrwxrwxrwx 1 0 Feb 15 10:18 gpiochip2 -> ../../../devices/platform/soc@0/43820080.gpio/gpiochip2
> lrwxrwxrwx 1 0 Feb 15 10:18 gpiochip3 -> ../../../devices/platform/soc@0/43830080.gpio/gpiochip3
> lrwxrwxrwx 1 0 Feb 15 10:18 gpiochip4 -> ../../../devices/platform/soc@0/42000000.bus/42530000.i2c/i2c-2/2-0071/gpiochip4
> lrwxrwxrwx 1 0 Feb 15 10:18 gpiochip5 -> ../../../devices/platform/soc@0/42000000.bus/42530000.i2c/i2c-2/2-0072/gpiochip5
> lrwxrwxrwx 1 0 Feb 15 10:18 gpiochip6 -> ../../../devices/platform/soc@0/42000000.bus/42530000.i2c/i2c-2/2-0070/gpiochip6
>
>  drivers/gpio/gpiolib.c | 33 +++++++++++++++++++++++++++++----
>  1 file changed, 29 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index 19bd23044b01..4d606ad522ac 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -663,10 +663,25 @@ static void gpiochip_setup_devs(void)
>         }
>  }
>
> +/**
> + * gpio_first_nonreserved_index() - get the first index that is not reserved
> + */
> +static int gpio_first_nonreserved_index(void)
> +{
> +       int max;
> +
> +       max = of_alias_get_highest_id("gpio");
> +       if (max < 0)
> +               return 0;
> +
> +       return max + 1;
> +}
> +
>  int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
>                                struct lock_class_key *lock_key,
>                                struct lock_class_key *request_key)
>  {
> +       int index, alias_id, min_idx;
>         struct fwnode_handle *fwnode = NULL;
>         struct gpio_device *gdev;
>         unsigned long flags;
> @@ -696,12 +711,22 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
>
>         device_set_node(&gdev->dev, gc->fwnode);
>
> -       gdev->id = ida_alloc(&gpio_ida, GFP_KERNEL);
> -       if (gdev->id < 0) {
> -               ret = gdev->id;
> -               goto err_free_gdev;
> +       alias_id = of_alias_get_id(to_of_node(gc->fwnode), "gpio");
> +       if (alias_id >= 0) {
> +               index = ida_simple_get(&gpio_ida, alias_id, alias_id + 1,
> +                                      GFP_KERNEL);
> +       } else {
> +               min_idx = gpio_first_nonreserved_index();
> +               index = ida_simple_get(&gpio_ida, min_idx, 0,
> +                                      GFP_KERNEL);
> +               if (index < 0) {
> +                       ret = gdev->id;
> +                       goto err_free_gdev;
> +               }
>         }
>
> +       gdev->id = index;
> +
>         ret = dev_set_name(&gdev->dev, GPIOCHIP_NAME "%d", gdev->id);
>         if (ret)
>                 goto err_free_ida;
> --
> 2.34.1
>

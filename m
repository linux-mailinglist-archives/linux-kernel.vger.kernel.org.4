Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2792D73114A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 09:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245266AbjFOHtn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 15 Jun 2023 03:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245282AbjFOHtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 03:49:11 -0400
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E3C630FD;
        Thu, 15 Jun 2023 00:48:41 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-bd729434fa0so1528930276.1;
        Thu, 15 Jun 2023 00:48:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686815321; x=1689407321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LdjFuszznIUW8xr9SCUVhRejLGTT8nUEiVZj8JgCoLQ=;
        b=CPvqqvyaCylwhejObkvScfL467ADgaAAcz1DQDkHCrfHBuamcKrZdNH0pG4+WNp7QK
         mfG6sCA9oGmQ70z33Nf3rQSC2tmo2VbfnGpZ+Qrmbu9bhgrXvZKqicAyAptN9ypjzTB1
         vqjJnIK+OxUkzk/6DdyuKUZo1kYXWMxSMgy/9wBfq6P8EMPCxSQmBO6Q9ex3VOV0jprv
         B/SibivuXIgevuzcOS3g3ra9VkSv2eUz5Zg3ledgxDAi3WDD/YtNgy0a9rRCCbPonWR6
         y1KijH/X1KnqWyukp/BoOAY19KSXY5EpkuysLpGtFMAKz2gG9vFCXrlaOe984NsTgR5b
         lP+w==
X-Gm-Message-State: AC+VfDwGkrQ5pEcFkWLSWrrtqVnKXcxExelFBA0wt1hTDYB+YfcNIb43
        DcbdhpAHeYh23X/5ZGDcpFY6IPpQ8Hfq/A==
X-Google-Smtp-Source: ACHHUZ7buAO8cuqEpR6YWYLfcPX6YkCggNHXA7cTcomIuQinjB9i+ZcfdRfyET+txBJmx6vVsNwMpA==
X-Received: by 2002:a25:b106:0:b0:bce:f883:e0b2 with SMTP id g6-20020a25b106000000b00bcef883e0b2mr4339177ybj.42.1686815320709;
        Thu, 15 Jun 2023 00:48:40 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id d12-20020a25bc4c000000b00ba8c2f3e1a4sm3850077ybk.56.2023.06.15.00.48.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jun 2023 00:48:40 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-bd77424c886so1539610276.0;
        Thu, 15 Jun 2023 00:48:40 -0700 (PDT)
X-Received: by 2002:a25:e086:0:b0:ba8:3613:76a8 with SMTP id
 x128-20020a25e086000000b00ba8361376a8mr5120255ybg.41.1686815320379; Thu, 15
 Jun 2023 00:48:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230614231446.3687-1-andriy.shevchenko@linux.intel.com> <20230614231446.3687-4-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230614231446.3687-4-andriy.shevchenko@linux.intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 15 Jun 2023 09:48:27 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVaJ2Fqc5+YFCO9isUebUaeZE31T3C+SXDeVXOii=Ra4A@mail.gmail.com>
Message-ID: <CAMuHMdVaJ2Fqc5+YFCO9isUebUaeZE31T3C+SXDeVXOii=Ra4A@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] gpio: aggregator: Set up a parser of delay line parameters
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Thu, Jun 15, 2023 at 1:14 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> The aggregator mode can also handle properties of the platform,
> that do not belong to the GPIO controller itself. One of such
> a property is a signal delay line. Set up a parser to support it.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks for your patch!

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

One suggestion for improvement below...

> --- a/drivers/gpio/gpio-aggregator.c
> +++ b/drivers/gpio/gpio-aggregator.c
> @@ -525,7 +580,9 @@ static int gpio_aggregator_probe(struct platform_device *pdev)
>                         return PTR_ERR(descs[i]);
>         }
>
> -       fwd = gpiochip_fwd_create(dev, n, descs);
> +       delay_line = fwnode_device_is_compatible(dev_fwnode(dev), "gpio-delay");

Please do not use explicit checks for compatible values in .probe()
methods.  Instead, use device_get_match_data() to get the feature
flag(s).  This will also make it easier to scale to other external
components later.

> +
> +       fwd = gpiochip_fwd_create(dev, n, descs, delay_line);
>         if (IS_ERR(fwd))
>                 return PTR_ERR(fwd);
>
> @@ -534,6 +591,15 @@ static int gpio_aggregator_probe(struct platform_device *pdev)
>  }
>
>  static const struct of_device_id gpio_aggregator_dt_ids[] = {
> +       /*
> +        * The GPIO delay provides a way to configure platform specific delays
> +        * for GPIO ramp-up or ramp-down delays. This can serve the following
> +        * purposes:
> +        * - Open-drain output using an RC filter
> +        */
> +       {
> +               .compatible = "gpio-delay",

.data = (void *)FWD_FEATURE_DELAY,

> +       },
>         /*
>          * Add GPIO-operated devices controlled from userspace below,
>          * or use "driver_override" in sysfs.

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

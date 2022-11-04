Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9E9619B12
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 16:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbiKDPLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 11:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbiKDPLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 11:11:31 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E51D4CE32
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 08:11:30 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id l190so4766950vsc.10
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 08:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PkvW3lSqaRFA2a/vroCWPZgNvfiJtFw3n7Yp+y1WOPE=;
        b=74qBGEpssbK0voV/oXQ4xaI8mwd02nUF4wdJUixPX1vK8oS0YL6Ew1sg9iiKyXNYF9
         8YNbRoatOm4x5cmdbL1JVyd1nc0vTvqLVDZIb/V2COu4J1lW4xEcEl9JFDt7VM+3WIQT
         A3xabc4VEkaeuOjWaE2ksnH3Sbt3U820pRNhzOnSKDStSFMarh/oCWekNjHePo6OdHMk
         6IbbwvEoJoc1xfO1ULcc3A85FvS9rG9yNhSf6x3P7C6JYCTHNEMUicuHOcfSE5QYTk1s
         C3Ylh6QcM6hDYflO0A/upG34wTQlEjipm1FzggSfcijyTRO05UFusi2UL3+UvJ26GOf+
         5/Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PkvW3lSqaRFA2a/vroCWPZgNvfiJtFw3n7Yp+y1WOPE=;
        b=rvEZv80MmGojcYYOozRF2J+jInQRLj3T17PBldhrFC4Ps1FrB1uQOMlAPjOSpGLYjJ
         f39pnJPV7Eihwp1FPZ/ML7gK3hZU3SuTyeio1DJbQu/HIeQ5Di1CnLuHIFnFAXzZ8ypl
         Fl6pV/I0qBe/45Pdy/4+39U79tAj3scQMQLdiX+xAwUWY5/166Krix8fkRvPMG+NpcSU
         NsTBnpBZLtsofoNAH6TD7U5FAhIlARYBpd233WUnK96JwRnN+19XrqSJiV49Bqli+u+V
         iSA4jBG0SdLtlCAU6k/SeuyLHlODvOznHqV37vyl02URA3vZY3hbQ5S8reTqljle5cpg
         0DvA==
X-Gm-Message-State: ACrzQf0bGbxm/j449dSaW87HULV4ZpJHOdNf1xQvHiNa+kiTSmD4boiv
        Ye05j+cYTJxL8luAKpwALs5WXAUp+BDv8ll7b5L92Q==
X-Google-Smtp-Source: AMsMyM4zU7vMY26vydmRcP3ejuAVFl61NZtySd0WDvxBfguuniTXFFGlLDV0XuGZTWUYzzOZqAOT+pz+i/Q4LSKA6qQ=
X-Received: by 2002:a05:6102:5788:b0:3a6:764d:1382 with SMTP id
 dh8-20020a056102578800b003a6764d1382mr20524929vsb.13.1667574689999; Fri, 04
 Nov 2022 08:11:29 -0700 (PDT)
MIME-Version: 1.0
References: <20221103203005.25743-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20221103203005.25743-1-andriy.shevchenko@linux.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 4 Nov 2022 16:11:19 +0100
Message-ID: <CAMRc=MeBM+iny7g4DEA-BgTWMnr_Bj1bmrpiKWGqp1nqkjbUDQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpiolib: of: Make use of device_match_of_node()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 3, 2022 at 9:29 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Make use of device_match_of_node() instead of open coding its
> functionality.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/gpio/gpiolib-of.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
> index 52616848a37c..4b91e19366a8 100644
> --- a/drivers/gpio/gpiolib-of.c
> +++ b/drivers/gpio/gpiolib-of.c
> @@ -85,7 +85,7 @@ static int of_gpiochip_match_node_and_xlate(struct gpio_chip *chip, void *data)
>  {
>         struct of_phandle_args *gpiospec = data;
>
> -       return chip->gpiodev->dev.of_node == gpiospec->np &&
> +       return device_match_of_node(&chip->gpiodev->dev, gpiospec->np) &&
>                                 chip->of_xlate &&
>                                 chip->of_xlate(chip, gpiospec, NULL) >= 0;
>  }
> --
> 2.35.1
>

Applied, thanks!

Bartosz

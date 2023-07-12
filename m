Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4FB750754
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 13:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbjGLL7I convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 12 Jul 2023 07:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232279AbjGLL7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 07:59:04 -0400
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D2E1BEB;
        Wed, 12 Jul 2023 04:58:48 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-57d24970042so14591017b3.2;
        Wed, 12 Jul 2023 04:58:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689163113; x=1691755113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XL5LmVWL8jdLeDSEFDFJkLxnGlhZpHUyPFm8MNn0Y6M=;
        b=Y8IHRvuH+rmzqi/Ym+YMTBJ+0LHLRPUCXti/r3AbaQpQ9rlIwRqO4vTh97Kdoesh8g
         Pcanzfo2umZ224BEDkFufTf+OTEnQiY3bDZGaV8t34b+u4uR6BHrBmf4tKy2TBGdPxnI
         2zgnIX0Wu3NNVrTKsrCajVdIGmdQaEeount0vvo9NbxlnME4wvOqL8ArT+wQjnY46z+V
         yB+35nFLw7RP4N5E5oeVB9w4jD73rGH7DWpLHMAx3pHy+FgAb7YZKC5L7wztQOyMAMD1
         JkwEXdqC0968ATBCERQxkVfFiVCnCDbc5ok0PIpTzKmytFp4LhIVU6P0mS0TSU4SIsg4
         FSzQ==
X-Gm-Message-State: ABy/qLYvjp1DtfM6IzMuB9xjy9WTjOtoFm3lswdX/Faw7SRkWgu6qDid
        Uts6Q/6Yu9zf7maoGPjP46TynRq+U8T5ig==
X-Google-Smtp-Source: APBJJlFCcrC9/SwwErGjwvqYomDm5iDfAIwqr0Gx5iu+UqqUNiqkxjCDbBdtUeB3nLz60KlpxhIf4g==
X-Received: by 2002:a81:84ca:0:b0:56d:3b1a:8641 with SMTP id u193-20020a8184ca000000b0056d3b1a8641mr16063476ywf.23.1689163113193;
        Wed, 12 Jul 2023 04:58:33 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id a187-20020a818ac4000000b0057a9a46e2b7sm1117006ywg.80.2023.07.12.04.58.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 04:58:32 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-bd0a359ca35so6048798276.3;
        Wed, 12 Jul 2023 04:58:32 -0700 (PDT)
X-Received: by 2002:a25:9d8d:0:b0:c5d:1407:f2bc with SMTP id
 v13-20020a259d8d000000b00c5d1407f2bcmr15097657ybp.17.1689163112630; Wed, 12
 Jul 2023 04:58:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230712113731.3306-1-wsa+renesas@sang-engineering.com> <20230712113731.3306-4-wsa+renesas@sang-engineering.com>
In-Reply-To: <20230712113731.3306-4-wsa+renesas@sang-engineering.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 12 Jul 2023 13:58:19 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVthAaoyV2FMabjva=oRFxJQ+qW9fzu6X5b8gpCBdXFAw@mail.gmail.com>
Message-ID: <CAMuHMdVthAaoyV2FMabjva=oRFxJQ+qW9fzu6X5b8gpCBdXFAw@mail.gmail.com>
Subject: Re: [PATCH 3/3] gnss: ubx: add support for the reset gpio
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-renesas-soc@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wolfram,

On Wed, Jul 12, 2023 at 1:40 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> Tested with a Renesas KingFisher board. Because my GNSS device is hooked
> up via UART and I2C simultaneously, I could verify functionality by
> opening/closing the GNSS device using UART and see if the corresponding
> I2C device was visible on the bus.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Thanks for your patch!

> --- a/drivers/gnss/ubx.c
> +++ b/drivers/gnss/ubx.c
> @@ -29,6 +31,8 @@ static int ubx_set_active(struct gnss_serial *gserial)
>         if (ret)
>                 return ret;
>
> +       gpiod_set_value_cansleep(data->reset_gpio, 0);
> +
>         return 0;
>  }
>
> @@ -41,6 +45,8 @@ static int ubx_set_standby(struct gnss_serial *gserial)
>         if (ret)
>                 return ret;
>
> +       gpiod_set_value_cansleep(data->reset_gpio, 1);

Please assert reset before disabling the regulator, for symmetry
with ubx_set_active().

> +
>         return 0;
>  }
>
> @@ -90,6 +96,13 @@ static int ubx_probe(struct serdev_device *serdev)
>         if (ret < 0 && ret != -ENODEV)
>                 goto err_free_gserial;
>
> +       /* Start with reset asserted (GPIO must be active low!) */

Does it have to be active low?
The description in your DT bindings suggest both active low and active
high are possible.

I think you just wanted to express that GPIOD_OUT_HIGH means asserted,
i.e. low for the common case of an active-low reset?

> +       data->reset_gpio = devm_gpiod_get_optional(&serdev->dev, "reset", GPIOD_OUT_HIGH);
> +       if (IS_ERR(data->reset_gpio)) {
> +               ret = PTR_ERR(data->reset_gpio);
> +               goto err_free_gserial;
> +       }
> +
>         ret = gnss_serial_register(gserial);
>         if (ret)
>                 goto err_free_gserial;

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

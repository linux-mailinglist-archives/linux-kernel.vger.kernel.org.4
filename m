Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09DA4743AEC
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 13:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232732AbjF3LfE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 30 Jun 2023 07:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjF3LfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 07:35:02 -0400
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D871FC1;
        Fri, 30 Jun 2023 04:35:00 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-bc379e4c1cbso1712193276.2;
        Fri, 30 Jun 2023 04:35:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688124899; x=1690716899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O0jKDszbwIvx4kQhb6inc5XRGib++KkoEFXZhbmslHA=;
        b=Gw/xiIkDLdQ7+5CLpxdu6e9LSKpeIyVSdDn/0b/QyHlHtenXb2OYvo29sPengMd7tI
         MUw+DveNlOmSqaqGIciHifliPvHaasvfMW4ezBoJqRtnM09tyXvPTuQyPff49cMrwRcZ
         AqxxGoNTBOk/1zgIZuXpd6fbIGIJ0oKt+2VhI/dVncmckDmltimwzwe7xMhQhELAT/C6
         T4N2wLd/jqJZlhbhuSUnk/Elnq1Hy97xf/VUrZCUZ5eKGZj9j25pwfIAEKe7z6E1tbh9
         HA3TosZ0jkNGiykAAOBrHnpPgBEWC295ACwOhMiCxlJwEy88D6NeWn2NYmosQ8sN6RcF
         3K7g==
X-Gm-Message-State: ABy/qLYTGHfesV0ZLA3Rf7peWaR+rwOnyGykiU48QKXXaJ/38kjDteSA
        GGCyHKzVrRsTURfGqh0eMLEdbXB0DxRC+BaW
X-Google-Smtp-Source: APBJJlFWlZN78BLMjQYPVNFloVUD7mCa5m1q8YCqZJ1vEJTqVWgszk3ds0pWTLhK0PqtXb/H6E37Hw==
X-Received: by 2002:a25:778e:0:b0:bcb:3280:57fc with SMTP id s136-20020a25778e000000b00bcb328057fcmr2394929ybc.53.1688124899334;
        Fri, 30 Jun 2023 04:34:59 -0700 (PDT)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id p203-20020a2542d4000000b00bc41075297fsm2930798yba.23.2023.06.30.04.34.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jun 2023 04:34:58 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-bd729434fa0so1719750276.1;
        Fri, 30 Jun 2023 04:34:57 -0700 (PDT)
X-Received: by 2002:a25:34a:0:b0:bac:69be:9494 with SMTP id
 71-20020a25034a000000b00bac69be9494mr2301273ybd.36.1688124897049; Fri, 30 Jun
 2023 04:34:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230504173618.142075-1-sebastian.reichel@collabora.com> <20230504173618.142075-6-sebastian.reichel@collabora.com>
In-Reply-To: <20230504173618.142075-6-sebastian.reichel@collabora.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 30 Jun 2023 13:34:44 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWRoNXrkD8ty4pUpFA-qQCMVF3wzXTCHFW4jYSy+dXivg@mail.gmail.com>
Message-ID: <CAMuHMdWRoNXrkD8ty4pUpFA-qQCMVF3wzXTCHFW4jYSy+dXivg@mail.gmail.com>
Subject: Re: [PATCH v8 05/14] mfd: rk808: split into core and i2c
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Diederik de Haas <didi.debian@cknow.org>,
        Vincent Legoll <vincent.legoll@gmail.com>
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

Hi Sebastian,

On Thu, May 4, 2023 at 7:38 PM Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
> Split rk808 into a core and an i2c part in preparation for
> SPI support.
>
> Acked-for-MFD-by: Lee Jones <lee@kernel.org>
> Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com> # for RTC
> Tested-by: Diederik de Haas <didi.debian@cknow.org> # Rock64, Quartz64 Model A + B
> Tested-by: Vincent Legoll <vincent.legoll@gmail.com> # Pine64 QuartzPro64
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Thanks for your patch, which is now commit c20e8c5b1203af37 ("mfd:
rk808: Split into core and i2c") in linus/master stable/master

> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1183,12 +1183,17 @@ config MFD_RC5T583
>           Additional drivers must be enabled in order to use the
>           different functionality of the device.
>
> -config MFD_RK808
> +config MFD_RK8XX
> +       bool

Is there any specific reason why this cannot be modular, like most (all?)
of its users that select it?

> +       select MFD_CORE
> +
> +config MFD_RK8XX_I2C
>         tristate "Rockchip RK805/RK808/RK809/RK817/RK818 Power Management Chip"
>         depends on I2C && OF
>         select MFD_CORE
>         select REGMAP_I2C
>         select REGMAP_IRQ
> +       select MFD_RK8XX
>         help
>           If you say yes here you get support for the RK805, RK808, RK809,
>           RK817 and RK818 Power Management chips.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

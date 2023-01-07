Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 246BF661111
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 19:37:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232783AbjAGSg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 13:36:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjAGSgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 13:36:24 -0500
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F0C941674;
        Sat,  7 Jan 2023 10:36:23 -0800 (PST)
Received: by mail-ua1-x934.google.com with SMTP id cb7so1075332uab.13;
        Sat, 07 Jan 2023 10:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=p9+QPgugxjt+ok3jQy5AZsqaB/CBReMof4Vva20JyTw=;
        b=JgAs1Yi3CAVP25JWaaCq7u7iTwZAQsjjY+fU7RZyEss6GYtV1zx40eKcFrKGqe8zze
         8e6wmHJeNH7DP3Y7T+CpeHWxoPrYBit1gVLNmwZkX23JFhcBtbJ14wyq8lUs0+efJOYf
         oKZZJRPpYAAqXY6alikcge/jZEMsH8vAR4UYMchOsZ87+2XR+esXrzzNGYKq7GdDO+SA
         Ae9hojCyOaV77d8GfqB2g7zmsp6dRNkBMBxC8KiyNLh+gH3FBuSZU7f820lHfr0bHQGJ
         paWyM0ToYVGGyGnsX1MjU9JxAFxpYq8X7bFy3UOuBrW5XUc66bcd6EBfsea0ecqb3DbY
         +8qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p9+QPgugxjt+ok3jQy5AZsqaB/CBReMof4Vva20JyTw=;
        b=K6U+sx1vc2rDp2hS3je9dGeDIF6+7L2qtKBFe8ShRdwZZ266C6a2+DMxg6qpFMvqgH
         bPUJDJ1VorD5aS0VcWbPOX+4Zk1a/pHVGsat+yI+LEihiaZWGiCoCcQvKPnihfmMGayz
         3mOgtfr5DYTHQk+ZEvLE9LusDYSHtdfDkiZBrzcMliUZjpRoscoadEf175fDRhrRBrnk
         6kdycarEN6GaNTdKzevtnindltxt84euEXSZgatGJpqZ/0wVK4VSncSvk78xt4md9uY2
         FWRebBskHeE5c+MXYpn/qvPA9D65jOnabnimBS6Vrv4LgHic0duHuCz7atwiwc8Q7sXx
         ZiLA==
X-Gm-Message-State: AFqh2kpQHoe+q97NZNvIUfH6ZdqSnDPi6Qsx5RPpsIORVrWqQWPFS9ei
        1vquT/89G9xRylpwVGTzqe/gFxsFa02IHs0a0hs=
X-Google-Smtp-Source: AMrXdXsC4+XoFVzdaZzPJ1qw3hDeR5OYKSrynUJf7bTB3YaU4XJL6iExElgiF/9ErIrtj6qDNeuQYZIk0jqip/uUzOs=
X-Received: by 2002:ab0:49ab:0:b0:54e:2c35:5a4f with SMTP id
 e40-20020ab049ab000000b0054e2c355a4fmr3479206uad.118.1673116582187; Sat, 07
 Jan 2023 10:36:22 -0800 (PST)
MIME-Version: 1.0
References: <20221215150214.1109074-1-hugo@hugovil.com> <20221215150214.1109074-10-hugo@hugovil.com>
In-Reply-To: <20221215150214.1109074-10-hugo@hugovil.com>
From:   Bruno Thomsen <bruno.thomsen@gmail.com>
Date:   Sat, 7 Jan 2023 19:36:06 +0100
Message-ID: <CAH+2xPDpdDZzE7z-caaVV53fy+RQCcYweNyYFu133YOyao2e6A@mail.gmail.com>
Subject: Re: [PATCH v3 09/14] rtc: pcf2127: set PWRMNG value for PCF2131
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Den tor. 15. dec. 2022 kl. 16.19 skrev Hugo Villeneuve <hugo@hugovil.com>:
>
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
>
> Default PWRMNG[2:0] bits are set to 000b for PCF2127/29, but to
> 111b for PCF2131.
>
> Set these bits to 000b to select same mode as PCF2127/29.
>
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Reviewed-by: Bruno Thomsen <bruno.thomsen@gmail.com>

I think it's a good idea[1] but there have been concerns about
setting default values in the past[2]. In case somebody needs
a different behaviour they should add a device tree property.

[1] https://lore.kernel.org/linux-rtc/20190910143945.9364-1-bruno.thomsen@gmail.com/
[2] https://lore.kernel.org/linux-rtc/20191211163354.GC1463890@piout.net/

> ---
>  drivers/rtc/rtc-pcf2127.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
> index 68af4d0438b8..241189ee4a05 100644
> --- a/drivers/rtc/rtc-pcf2127.c
> +++ b/drivers/rtc/rtc-pcf2127.c
> @@ -53,6 +53,7 @@
>  #define PCF2127_BIT_CTRL3_BLF                  BIT(2)
>  #define PCF2127_BIT_CTRL3_BF                   BIT(3)
>  #define PCF2127_BIT_CTRL3_BTSE                 BIT(4)
> +#define PCF2127_CTRL3_PWRMNG_MASK              GENMASK(7, 5)
>  /* Control register 4 */
>  #define PCF2131_REG_CTRL4              0x03
>  #define PCF2131_BIT_CTRL4_TSF4                 BIT(4)
> @@ -1129,6 +1130,20 @@ static int pcf2127_probe(struct device *dev, struct regmap *regmap,
>         regmap_clear_bits(pcf2127->regmap, PCF2127_REG_CTRL1,
>                                 PCF2127_BIT_CTRL1_POR_OVRD);
>
> +       /* Make sure PWRMNG[2:0] is set to 000b. This is the default for
> +        * PCF2127/29, but not for PCF2131 (default of 111b).
> +        *
> +        * PWRMNG[2:0]  = 000b:
> +        *   battery switch-over function is enabled in standard mode;
> +        *   battery low detection function is enabled
> +        */
> +       ret = regmap_clear_bits(pcf2127->regmap, PCF2127_REG_CTRL3,
> +                               PCF2127_CTRL3_PWRMNG_MASK);
> +       if (ret < 0) {
> +               dev_err(dev, "PWRMNG config failed\n");
> +               return ret;
> +       }
> +
>         ret = regmap_read(pcf2127->regmap, pcf2127->cfg->reg_clkout, &val);
>         if (ret < 0)
>                 return ret;
> --
> 2.30.2
>

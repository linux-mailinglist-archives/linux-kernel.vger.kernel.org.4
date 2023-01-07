Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE3C266104E
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 17:57:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbjAGQ53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 11:57:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjAGQ51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 11:57:27 -0500
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6B23DBD3;
        Sat,  7 Jan 2023 08:57:26 -0800 (PST)
Received: by mail-vs1-xe2f.google.com with SMTP id k4so4516140vsc.4;
        Sat, 07 Jan 2023 08:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DbS9UB/SJ5k2YJwgrWDl5kW5ItzZerle5a3seDFzOhI=;
        b=BF1fdsz2wKTHkT7r4Z82JPH7nD+EVsX5qe6ItXYwrJnK3zGDlgLTnzg7oFiffVrdEt
         bKvffDY0I9FxAE2g1ATo9ElvLTKrCA6U6syUYyUQQqtNtt3mrviipSBGAI6mhF3qSgUg
         a6lBsC9PlpZ7y3WT9sB8ZAKpslfOj4qvArJ76FUjgLvGps9CPfbJRK23UQ67o1ETl/NU
         U3GhUdXI/cRBRIRUC1ucfU1lDgjO9pdMf80MeaKYfNPEHRqJeQpg/8o6pfVC6S4OqRkS
         W2dUxTY4bdpt2UDfUl+sEbbZ2QoKjZUW9j9OvUItFCrMDv595SI0quucBqiDK+/kCZvV
         LFFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DbS9UB/SJ5k2YJwgrWDl5kW5ItzZerle5a3seDFzOhI=;
        b=d6RoTbR21VYykicShvYvy4WU+KU6D5cFL7UfOaLbBZjochSYYGmtS5Sdyxq6eRgWKs
         GBhI0rnynmena+ShxiCgp/Sj106MWCcH2qto+DdC7zpDU295KemD2EXPxi/4O8KP06oj
         WkKA7VU8QrjJiiTsOPDEO8C6r10/iW8udsZTuCUG5CC9/++/uXqFQgDPI1y2Rl5Mkl7J
         exhqw/H6E0XbRyInEr9p1SjBivneSJaNtqbsR/bga5Fd/v6fAAa/I+lHy4QXYUwbH1FZ
         7BVDERG1dc2Y1RX/l1ZthMqWscXZ2Su6X5QmZ2fQkE8xw4Pqh7VUIrrJCksDVhG3HoLU
         v3tQ==
X-Gm-Message-State: AFqh2krYyxra3zlpQ360QCzDmdju74BrrEb60qVq/9fBlbXkYHsV3vao
        Jpp2KGJmwA6Wn7MdVyNdDoAed1J03bausKHhR3ccW58eAu801g==
X-Google-Smtp-Source: AMrXdXuMz/OZbyQVg3JZ1ZSfm4k9J9X+KyBpYNtbjn9U1d6e31Zuut/Cp0ElhB6SHXqGqzOPHuvwABNdvcV2PlitU1k=
X-Received: by 2002:a67:fe44:0:b0:3ce:3974:4558 with SMTP id
 m4-20020a67fe44000000b003ce39744558mr3396112vsr.0.1673110645579; Sat, 07 Jan
 2023 08:57:25 -0800 (PST)
MIME-Version: 1.0
References: <20221215150214.1109074-1-hugo@hugovil.com> <20221215150214.1109074-4-hugo@hugovil.com>
In-Reply-To: <20221215150214.1109074-4-hugo@hugovil.com>
From:   Bruno Thomsen <bruno.thomsen@gmail.com>
Date:   Sat, 7 Jan 2023 17:57:09 +0100
Message-ID: <CAH+2xPAK__rxbk1mt_7=YW111SBTPtA+1WVAhumC82Vah0ZY8g@mail.gmail.com>
Subject: Re: [PATCH v3 03/14] rtc: pcf2127: adapt for alarm registers at any offset
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

Den tor. 15. dec. 2022 kl. 16.20 skrev Hugo Villeneuve <hugo@hugovil.com>:
>
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
>
> This will simplify the implementation of new variants into this driver.
>
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>

I have tested the entire patch series on
imx7d-flex-concentrator.dts[1] using pcf2127,
and have not observed any issues but I don't use the alarm and CLKOUT functions.

Reviewed-by: Bruno Thomsen <bruno.thomsen@gmail.com>

[1] https://elixir.bootlin.com/linux/latest/source/arch/arm/boot/dts/imx7d-flex-concentrator.dts

> ---
>  drivers/rtc/rtc-pcf2127.c | 42 ++++++++++++++++++++++-----------------
>  1 file changed, 24 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
> index fb0caacaabee..db0cb784c0c9 100644
> --- a/drivers/rtc/rtc-pcf2127.c
> +++ b/drivers/rtc/rtc-pcf2127.c
> @@ -56,11 +56,14 @@
>  /* Time and date registers bits */
>  #define PCF2127_BIT_SC_OSF                     BIT(7)
>  /* Alarm registers */
> -#define PCF2127_REG_ALARM_SC           0x0A
> -#define PCF2127_REG_ALARM_MN           0x0B
> -#define PCF2127_REG_ALARM_HR           0x0C
> -#define PCF2127_REG_ALARM_DM           0x0D
> -#define PCF2127_REG_ALARM_DW           0x0E
> +#define PCF2127_REG_ALARM_BASE         0x0A
> +/* Alarm registers offsets (starting from base register) */
> +#define PCF2127_OFFSET_ALARM_SC                0
> +#define PCF2127_OFFSET_ALARM_MN                1
> +#define PCF2127_OFFSET_ALARM_HR                2
> +#define PCF2127_OFFSET_ALARM_DM                3
> +#define PCF2127_OFFSET_ALARM_DW                4
> +/* Alarm bits */
>  #define PCF2127_BIT_ALARM_AE                   BIT(7)
>  /* CLKOUT control register */
>  #define PCF2127_REG_CLKOUT             0x0f
> @@ -110,6 +113,7 @@ struct pcf21xx_config {
>         unsigned int has_nvmem:1;
>         unsigned int has_bit_wd_ctl_cd0:1;
>         u8 regs_td_base; /* Time/data base registers. */
> +       u8 regs_alarm_base; /* Alarm function base registers. */
>  };
>
>  struct pcf2127 {
> @@ -402,18 +406,18 @@ static int pcf2127_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
>         if (ret)
>                 return ret;
>
> -       ret = regmap_bulk_read(pcf2127->regmap, PCF2127_REG_ALARM_SC, buf,
> -                              sizeof(buf));
> +       ret = regmap_bulk_read(pcf2127->regmap, pcf2127->cfg->regs_alarm_base,
> +                              buf, sizeof(buf));
>         if (ret)
>                 return ret;
>
>         alrm->enabled = ctrl2 & PCF2127_BIT_CTRL2_AIE;
>         alrm->pending = ctrl2 & PCF2127_BIT_CTRL2_AF;
>
> -       alrm->time.tm_sec = bcd2bin(buf[0] & 0x7F);
> -       alrm->time.tm_min = bcd2bin(buf[1] & 0x7F);
> -       alrm->time.tm_hour = bcd2bin(buf[2] & 0x3F);
> -       alrm->time.tm_mday = bcd2bin(buf[3] & 0x3F);
> +       alrm->time.tm_sec = bcd2bin(buf[PCF2127_OFFSET_ALARM_SC] & 0x7F);
> +       alrm->time.tm_min = bcd2bin(buf[PCF2127_OFFSET_ALARM_MN] & 0x7F);
> +       alrm->time.tm_hour = bcd2bin(buf[PCF2127_OFFSET_ALARM_HR] & 0x3F);
> +       alrm->time.tm_mday = bcd2bin(buf[PCF2127_OFFSET_ALARM_DM] & 0x3F);
>
>         return 0;
>  }
> @@ -447,14 +451,14 @@ static int pcf2127_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
>         if (ret)
>                 return ret;
>
> -       buf[0] = bin2bcd(alrm->time.tm_sec);
> -       buf[1] = bin2bcd(alrm->time.tm_min);
> -       buf[2] = bin2bcd(alrm->time.tm_hour);
> -       buf[3] = bin2bcd(alrm->time.tm_mday);
> -       buf[4] = PCF2127_BIT_ALARM_AE; /* Do not match on week day */
> +       buf[PCF2127_OFFSET_ALARM_SC] = bin2bcd(alrm->time.tm_sec);
> +       buf[PCF2127_OFFSET_ALARM_MN] = bin2bcd(alrm->time.tm_min);
> +       buf[PCF2127_OFFSET_ALARM_HR] = bin2bcd(alrm->time.tm_hour);
> +       buf[PCF2127_OFFSET_ALARM_DM] = bin2bcd(alrm->time.tm_mday);
> +       buf[PCF2127_OFFSET_ALARM_DW] = PCF2127_BIT_ALARM_AE; /* Do not match on week day */
>
> -       ret = regmap_bulk_write(pcf2127->regmap, PCF2127_REG_ALARM_SC, buf,
> -                               sizeof(buf));
> +       ret = regmap_bulk_write(pcf2127->regmap, pcf2127->cfg->regs_alarm_base,
> +                               buf, sizeof(buf));
>         if (ret)
>                 return ret;
>
> @@ -659,12 +663,14 @@ static struct pcf21xx_config pcf21xx_cfg[] = {
>                 .has_nvmem = 1,
>                 .has_bit_wd_ctl_cd0 = 1,
>                 .regs_td_base = PCF2127_REG_TIME_DATE_BASE,
> +               .regs_alarm_base = PCF2127_REG_ALARM_BASE,
>         },
>         [PCF2129] = {
>                 .max_register = 0x19,
>                 .has_nvmem = 0,
>                 .has_bit_wd_ctl_cd0 = 0,
>                 .regs_td_base = PCF2127_REG_TIME_DATE_BASE,
> +               .regs_alarm_base = PCF2127_REG_ALARM_BASE,
>         },
>  };
>
> --
> 2.30.2
>

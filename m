Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E895E661056
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 18:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjAGRCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 12:02:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjAGRCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 12:02:12 -0500
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E47740C14;
        Sat,  7 Jan 2023 09:02:12 -0800 (PST)
Received: by mail-vs1-xe2e.google.com with SMTP id x65so4499497vsb.13;
        Sat, 07 Jan 2023 09:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ut7y6LwE6+TXt94aDe6UhDlh2RKFMtpvXvxQcoIWjvk=;
        b=Z5pPnl0gUaN3fIqaMg1NYm9RBEWAlz+S9VpBNUssb7IRBFMlJm7DZ/vJrZntBLJYr2
         OBDc7qvP2nGGfbW16FXtdjboZZu5uKxIuVQb3MxQ4KySaC/898uQNbogVvy0i0hboFlw
         cz9xkgyjCWTWGiSUL2TTzKWwEFJhMjBiGnx6TAF4o7SgylAVGQIrHzr/I91L0iXjhQKc
         ajPCH4dLNbfW+Ib4LMRrKdIJVKY+9Mt8yhawJcEjux6di8SO2FyliZ3RV87FARkNEjAx
         YMnsGnbvQv6w9QU67VrZHoawWS7WMS8Wu/T1Y50XOY4qM6kfFpooPgL9M2Fx6/7Lla4E
         auvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ut7y6LwE6+TXt94aDe6UhDlh2RKFMtpvXvxQcoIWjvk=;
        b=UNySeMp3PloKpIgv0VnN6lB3bQIoNDvgzW3qT7xL4686qSLt7TTYa5c0uBPRXWn/y/
         J4HhRfz/hu0lYYzdPNQLMjXsyrbT/QmkOKp8zP00sBHiSR1d531Nhz0BrtgyGDNhUQzV
         /vGrtvc85V+/ShfFuQlQE/EUHhAeG6VABrZJtGusyqGF+26yWt0h+YMDhvm4qxnADxXK
         2lzHZaAF8VSNohaqmF0HDKuGMdrLWoY1DvdQS/7bR5oHu3E/KMZTLReXCDTlfaSV2u12
         NDoiPPzTk4SSyMDrHrP/OHwlQ9tD7BPyk8XiOU1RTV2Oo2oxx6hzt0PtZ92fMAxnWqR6
         oNAA==
X-Gm-Message-State: AFqh2kpqo7BYKvhbpXmPAaqwFBkO+mn6FdIwSjaPBz7IuKdI0hX6xUQ1
        4bF1f3x/y4d/LdvF13X9bGPNy4iG8/MtAud6uNkrBAaQL+vUgA==
X-Google-Smtp-Source: AMrXdXvHJf9VqlQ5TbDfSXStJGdwwfclPy09+mhcqjnlIfuQFjHOGYpbLKLzsiPMLb1gh8akE7Ud6e8/1waMevuBPvo=
X-Received: by 2002:a67:5c03:0:b0:3ce:a7c5:3757 with SMTP id
 q3-20020a675c03000000b003cea7c53757mr2541058vsb.63.1673110931272; Sat, 07 Jan
 2023 09:02:11 -0800 (PST)
MIME-Version: 1.0
References: <20221215150214.1109074-1-hugo@hugovil.com> <20221215150214.1109074-6-hugo@hugovil.com>
In-Reply-To: <20221215150214.1109074-6-hugo@hugovil.com>
From:   Bruno Thomsen <bruno.thomsen@gmail.com>
Date:   Sat, 7 Jan 2023 18:01:55 +0100
Message-ID: <CAH+2xPBAQ0vYfLNHSmVBt8hRotzot-Cs7OSEu+q2Bv3eA+5Nsg@mail.gmail.com>
Subject: Re: [PATCH v3 05/14] rtc: pcf2127: adapt for CLKOUT register at any offset
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
> This will simplify the implementation of new variants into this driver.
>
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Reviewed-by: Bruno Thomsen <bruno.thomsen@gmail.com>

> ---
>  drivers/rtc/rtc-pcf2127.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
> index 5d8c06e32dce..38816ad065eb 100644
> --- a/drivers/rtc/rtc-pcf2127.c
> +++ b/drivers/rtc/rtc-pcf2127.c
> @@ -116,6 +116,7 @@ struct pcf21xx_config {
>         u8 regs_alarm_base; /* Alarm function base registers. */
>         u8 reg_wd_ctl; /* Watchdog control register. */
>         u8 reg_wd_val; /* Watchdog value register. */
> +       u8 reg_clkout; /* Clkout register. */
>  };
>
>  struct pcf2127 {
> @@ -668,6 +669,7 @@ static struct pcf21xx_config pcf21xx_cfg[] = {
>                 .regs_alarm_base = PCF2127_REG_ALARM_BASE,
>                 .reg_wd_ctl = PCF2127_REG_WD_CTL,
>                 .reg_wd_val = PCF2127_REG_WD_VAL,
> +               .reg_clkout = PCF2127_REG_CLKOUT,
>         },
>         [PCF2129] = {
>                 .max_register = 0x19,
> @@ -677,6 +679,7 @@ static struct pcf21xx_config pcf21xx_cfg[] = {
>                 .regs_alarm_base = PCF2127_REG_ALARM_BASE,
>                 .reg_wd_ctl = PCF2127_REG_WD_CTL,
>                 .reg_wd_val = PCF2127_REG_WD_VAL,
> +               .reg_clkout = PCF2127_REG_CLKOUT,
>         },
>  };
>
> @@ -756,12 +759,12 @@ static int pcf2127_probe(struct device *dev, struct regmap *regmap,
>         regmap_clear_bits(pcf2127->regmap, PCF2127_REG_CTRL1,
>                                 PCF2127_BIT_CTRL1_POR_OVRD);
>
> -       ret = regmap_read(pcf2127->regmap, PCF2127_REG_CLKOUT, &val);
> +       ret = regmap_read(pcf2127->regmap, pcf2127->cfg->reg_clkout, &val);
>         if (ret < 0)
>                 return ret;
>
>         if (!(val & PCF2127_BIT_CLKOUT_OTPR)) {
> -               ret = regmap_set_bits(pcf2127->regmap, PCF2127_REG_CLKOUT,
> +               ret = regmap_set_bits(pcf2127->regmap, pcf2127->cfg->reg_clkout,
>                                       PCF2127_BIT_CLKOUT_OTPR);
>                 if (ret < 0)
>                         return ret;
> --
> 2.30.2
>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB766610C0
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 19:18:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbjAGSSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 13:18:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjAGSSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 13:18:14 -0500
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF2991CFF4;
        Sat,  7 Jan 2023 10:18:13 -0800 (PST)
Received: by mail-vs1-xe32.google.com with SMTP id v127so268207vsb.12;
        Sat, 07 Jan 2023 10:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Z/GRMjDgT48jRfAFGb2uOibdVksbJjC1KC+OPBUllYg=;
        b=At+P0MjbS/YAzK02cHZLVHTnCuhC0GvUcA3sK4qi1hWbJ1vMP9JDBKZ6lo7uG9Q0em
         lOV1ZyRCU2K8dDYXkVpsdnIwJJrjDQF45U0SCMSzWL+ey7SZ7cu2VKJxEAlHxfrlxYBP
         3LSNS2idXpdzaEPn1Hi3i08C0fp7VDXbpPeYnrhgL6yXpr6P0L7pPWO6A++rQSUrRliT
         /CqEuXp8tfcYBQzhsApXJ1ruiugOO7QVxZRFGznrzjWCUgtJ9Tu0a/b+7uj4QA+ObZfE
         PUyAblGUXUBihesc4Rp9rswN4yBtUD5Wmvj+AU6yUpsg0e4SLBZwSRv7B1JoORxdHI7w
         ASHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z/GRMjDgT48jRfAFGb2uOibdVksbJjC1KC+OPBUllYg=;
        b=syD3wXe+fHbksX+V7YmPU197L9DtDgAmEIboijPgUgkX9ifR1Ja7AE9K9bttZV/84L
         +rYrKmprnJuC9fzJtUg0+lEh0xgUcF5J4nC9qfzRAZ01j5WfZy/2U1coRvzPX4iPP9J7
         Ol+yOBuMoLyc+FT8zC6YinZwY7/+Lhy3+QcFiMuweLbYbi8fsj6FKzrKHRtxXjGD430E
         OfmV8oQjk22TDE2mV2ILyxN/cPczL6jdYK77yEzQ7vr5eeEmgQHujTMwaeNQrv+5W/YP
         52ZZMdDo1dZPTfLZfmlF0iOtmSJlpl9VFsApwzZwzFP+HzaZpFFeTt/NtTYCKgHO5/8j
         uN6Q==
X-Gm-Message-State: AFqh2kp4b1VXx7OEgKkb7UeE0a0I5uIZi8LKpMQUIH301vZfqM/6ZME7
        35icOv1Ru3kDNh3gGpCn4fab//tIy24wI3ismIU=
X-Google-Smtp-Source: AMrXdXvVn4Fbql/T7F01FNheMwFDx0tr4F2lGyxduu7CqDBgoSH5+xBdqIlQtG5cbH/0NgMcNL2OQrwcnWExEjDv06Q=
X-Received: by 2002:a67:fe44:0:b0:3ce:3974:4558 with SMTP id
 m4-20020a67fe44000000b003ce39744558mr3447558vsr.0.1673115493045; Sat, 07 Jan
 2023 10:18:13 -0800 (PST)
MIME-Version: 1.0
References: <20221215150214.1109074-1-hugo@hugovil.com> <20221215150214.1109074-9-hugo@hugovil.com>
In-Reply-To: <20221215150214.1109074-9-hugo@hugovil.com>
From:   Bruno Thomsen <bruno.thomsen@gmail.com>
Date:   Sat, 7 Jan 2023 19:17:57 +0100
Message-ID: <CAH+2xPAPysgrZAsUwzRGPnAMxRs7Pz24QML4a3P55WygHpEzTQ@mail.gmail.com>
Subject: Re: [PATCH v3 08/14] rtc: pcf2127: add support for PCF2131 interrupts
 on output INT_A
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
> The PCF2127 and PCF2129 have one output interrupt pin. The PCF2131 has
> two, named INT_A and INT_B. The hardware support that any interrupt
> source can be routed to either one or both of them.
>
> Force all interrupt sources to go to the INT A pin.
>
> Support to route any interrupt source to INT A/B pins is not supported
> by this driver at the moment.
>
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Reviewed-by: Bruno Thomsen <bruno.thomsen@gmail.com>

> ---
>  drivers/rtc/rtc-pcf2127.c | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>
> diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
> index 4148e135f935..68af4d0438b8 100644
> --- a/drivers/rtc/rtc-pcf2127.c
> +++ b/drivers/rtc/rtc-pcf2127.c
> @@ -191,6 +191,7 @@ struct pcf21xx_config {
>         int max_register;
>         unsigned int has_nvmem:1;
>         unsigned int has_bit_wd_ctl_cd0:1;
> +       unsigned int has_int_a_b:1; /* PCF2131 supports two interrupt outputs. */
>         u8 regs_td_base; /* Time/data base registers. */
>         u8 regs_alarm_base; /* Alarm function base registers. */
>         u8 reg_wd_ctl; /* Watchdog control register. */
> @@ -879,6 +880,7 @@ static struct pcf21xx_config pcf21xx_cfg[] = {
>                 .max_register = 0x1d,
>                 .has_nvmem = 1,
>                 .has_bit_wd_ctl_cd0 = 1,
> +               .has_int_a_b = 0,
>                 .regs_td_base = PCF2127_REG_TIME_DATE_BASE,
>                 .regs_alarm_base = PCF2127_REG_ALARM_BASE,
>                 .reg_wd_ctl = PCF2127_REG_WD_CTL,
> @@ -902,6 +904,7 @@ static struct pcf21xx_config pcf21xx_cfg[] = {
>                 .max_register = 0x19,
>                 .has_nvmem = 0,
>                 .has_bit_wd_ctl_cd0 = 0,
> +               .has_int_a_b = 0,
>                 .regs_td_base = PCF2127_REG_TIME_DATE_BASE,
>                 .regs_alarm_base = PCF2127_REG_ALARM_BASE,
>                 .reg_wd_ctl = PCF2127_REG_WD_CTL,
> @@ -925,6 +928,7 @@ static struct pcf21xx_config pcf21xx_cfg[] = {
>                 .max_register = 0x36,
>                 .has_nvmem = 0,
>                 .has_bit_wd_ctl_cd0 = 0,
> +               .has_int_a_b = 1,
>                 .regs_td_base = PCF2131_REG_TIME_DATE_BASE,
>                 .regs_alarm_base = PCF2131_REG_ALARM_BASE,
>                 .reg_wd_ctl = PCF2131_REG_WD_CTL,
> @@ -1017,6 +1021,28 @@ static int pcf2127_enable_ts(struct device *dev, int ts_id)
>         return ret;
>  }
>
> +/* Route all interrupt sources to INT A pin. */
> +static int pcf2127_configure_interrupt_pins(struct device *dev)
> +{
> +       struct pcf2127 *pcf2127 = dev_get_drvdata(dev);
> +       int ret;
> +
> +       /* Mask bits need to be cleared to enable corresponding
> +        * interrupt source.
> +        */
> +       ret = regmap_write(pcf2127->regmap,
> +                          PCF2131_REG_INT_A_MASK1, 0);
> +       if (ret)
> +               return ret;
> +
> +       ret = regmap_write(pcf2127->regmap,
> +                          PCF2131_REG_INT_A_MASK2, 0);
> +       if (ret)
> +               return ret;
> +
> +       return ret;
> +}
> +
>  static int pcf2127_probe(struct device *dev, struct regmap *regmap,
>                          int alarm_irq, const char *name, const struct pcf21xx_config *config)
>  {
> @@ -1076,6 +1102,15 @@ static int pcf2127_probe(struct device *dev, struct regmap *regmap,
>                 set_bit(RTC_FEATURE_ALARM, pcf2127->rtc->features);
>         }
>
> +       if (pcf2127->cfg->has_int_a_b) {
> +               /* Configure int A/B pins, independently of alarm_irq. */
> +               ret = pcf2127_configure_interrupt_pins(dev);
> +               if (ret) {
> +                       dev_err(dev, "failed to configure interrupt pins\n");
> +                       return ret;
> +               }
> +       }
> +
>         if (pcf2127->cfg->has_nvmem) {
>                 struct nvmem_config nvmem_cfg = {
>                         .priv = pcf2127,
> --
> 2.30.2
>

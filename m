Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4521661052
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 18:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjAGQ76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 11:59:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjAGQ74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 11:59:56 -0500
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76313DBD3;
        Sat,  7 Jan 2023 08:59:55 -0800 (PST)
Received: by mail-ua1-x92c.google.com with SMTP id u3so1048385uae.0;
        Sat, 07 Jan 2023 08:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wuuEdP1jV/IJ6+m7T8W/2mjhQd285LO9rN5Efm0s4XM=;
        b=dUbt8moScTy5Aj/ZgCaUsKM0Ek8ZT79W/Bbm287mIp7OIQcXsLXEYKM7b7RURozV9F
         PBG02rCAihkmLlap+ILaG3pvfvaSVDhY0V01ZousKP62ZIuBwt7wogzqcHajRcjvnNo2
         1y7sfH1q/CHDiJYbx0+1J1hZjPFDPMKLAvSIn5YXaMndHXVIMm3RIHtdlh9KqKqHIDts
         H5NRGN1HM3GM34E4cKO0UDFINqveJdi/elMcnGa6DjzHkvEU+Tf1O7IG5QHusZyjugmB
         U+nfKtBZ4E2OTE/1tnC8RMvzLJJdItU/8f8JvsISGTOmXyMD8MYPfEKQvkEd4UJ982/Y
         +d3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wuuEdP1jV/IJ6+m7T8W/2mjhQd285LO9rN5Efm0s4XM=;
        b=t39mwonipa1jsF9ns8VK/vl4tDwuzALqe6KaWewnXPCg69eHsLKaSV7pF5ui/3xlVc
         kf5QfUSPgexhIYjSpAtbyfcxBBv6hV43DpGQOinXfDR+RLG3EdTJhvHkMHcukCZcNUAZ
         SkYs9QBa/oZWKgkwmH+wHS0I8zDSZUR7IguBnlfrNnm7LnKb3S21io3oOLlV6GmkM91J
         iA5AylERGsyb5orQQGH1MBcrjtTFPTALnXem+CXFYo1qtlE7q02UTvD2J4ElpyKYLvvx
         S4ROVgQ3AxjEskpCepU07WyJl5jwmgIfIw/q2tAms7qhv1ezT8gSsSYHkzLVEUvV+o3E
         K4SA==
X-Gm-Message-State: AFqh2koB9+7s8v0uaHBRw+LQTJevMXb+iST5jhP3+hN/OEnQOnsFuaBo
        IvHeLYYAx7YaPfcYKZ1bloZ+oMjW9ygrtyRmyNA=
X-Google-Smtp-Source: AMrXdXscY4+Jc4RPKoIYNLHbDOLVdMVnIkGr2x8PCbBCET9DVX+AVU8EVMt4SwNCL4DpM83OdgYM9HRNpYy3wihXMWQ=
X-Received: by 2002:ab0:624a:0:b0:5cb:ae3d:8c72 with SMTP id
 p10-20020ab0624a000000b005cbae3d8c72mr1123920uao.120.1673110794845; Sat, 07
 Jan 2023 08:59:54 -0800 (PST)
MIME-Version: 1.0
References: <20221215150214.1109074-1-hugo@hugovil.com> <20221215150214.1109074-5-hugo@hugovil.com>
In-Reply-To: <20221215150214.1109074-5-hugo@hugovil.com>
From:   Bruno Thomsen <bruno.thomsen@gmail.com>
Date:   Sat, 7 Jan 2023 17:59:38 +0100
Message-ID: <CAH+2xPA6x_RcN7Z0h6DtsAY9KgrHTgixpB_fFZR_S=16+sRt-A@mail.gmail.com>
Subject: Re: [PATCH v3 04/14] rtc: pcf2127: adapt for WD registers at any offset
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
Tested-by: Bruno Thomsen <bruno.thomsen@gmail.com>

> ---
>  drivers/rtc/rtc-pcf2127.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
> index db0cb784c0c9..5d8c06e32dce 100644
> --- a/drivers/rtc/rtc-pcf2127.c
> +++ b/drivers/rtc/rtc-pcf2127.c
> @@ -114,6 +114,8 @@ struct pcf21xx_config {
>         unsigned int has_bit_wd_ctl_cd0:1;
>         u8 regs_td_base; /* Time/data base registers. */
>         u8 regs_alarm_base; /* Alarm function base registers. */
> +       u8 reg_wd_ctl; /* Watchdog control register. */
> +       u8 reg_wd_val; /* Watchdog value register. */
>  };
>
>  struct pcf2127 {
> @@ -297,7 +299,7 @@ static int pcf2127_wdt_ping(struct watchdog_device *wdd)
>  {
>         struct pcf2127 *pcf2127 = watchdog_get_drvdata(wdd);
>
> -       return regmap_write(pcf2127->regmap, PCF2127_REG_WD_VAL, wdd->timeout);
> +       return regmap_write(pcf2127->regmap, pcf2127->cfg->reg_wd_val, wdd->timeout);
>  }
>
>  /*
> @@ -331,7 +333,7 @@ static int pcf2127_wdt_stop(struct watchdog_device *wdd)
>  {
>         struct pcf2127 *pcf2127 = watchdog_get_drvdata(wdd);
>
> -       return regmap_write(pcf2127->regmap, PCF2127_REG_WD_VAL,
> +       return regmap_write(pcf2127->regmap, pcf2127->cfg->reg_wd_val,
>                             PCF2127_WD_VAL_STOP);
>  }
>
> @@ -380,7 +382,7 @@ static int pcf2127_watchdog_init(struct device *dev, struct pcf2127 *pcf2127)
>         watchdog_set_drvdata(&pcf2127->wdd, pcf2127);
>
>         /* Test if watchdog timer is started by bootloader */
> -       ret = regmap_read(pcf2127->regmap, PCF2127_REG_WD_VAL, &wdd_timeout);
> +       ret = regmap_read(pcf2127->regmap, pcf2127->cfg->reg_wd_val, &wdd_timeout);
>         if (ret)
>                 return ret;
>
> @@ -664,6 +666,8 @@ static struct pcf21xx_config pcf21xx_cfg[] = {
>                 .has_bit_wd_ctl_cd0 = 1,
>                 .regs_td_base = PCF2127_REG_TIME_DATE_BASE,
>                 .regs_alarm_base = PCF2127_REG_ALARM_BASE,
> +               .reg_wd_ctl = PCF2127_REG_WD_CTL,
> +               .reg_wd_val = PCF2127_REG_WD_VAL,
>         },
>         [PCF2129] = {
>                 .max_register = 0x19,
> @@ -671,6 +675,8 @@ static struct pcf21xx_config pcf21xx_cfg[] = {
>                 .has_bit_wd_ctl_cd0 = 0,
>                 .regs_td_base = PCF2127_REG_TIME_DATE_BASE,
>                 .regs_alarm_base = PCF2127_REG_ALARM_BASE,
> +               .reg_wd_ctl = PCF2127_REG_WD_CTL,
> +               .reg_wd_val = PCF2127_REG_WD_VAL,
>         },
>  };
>
> @@ -772,7 +778,7 @@ static int pcf2127_probe(struct device *dev, struct regmap *regmap,
>          * as T. Bits labeled as T must always be written with
>          * logic 0.
>          */
> -       ret = regmap_update_bits(pcf2127->regmap, PCF2127_REG_WD_CTL,
> +       ret = regmap_update_bits(pcf2127->regmap, pcf2127->cfg->reg_wd_ctl,
>                                  PCF2127_BIT_WD_CTL_CD1 |
>                                  PCF2127_BIT_WD_CTL_CD0 |
>                                  PCF2127_BIT_WD_CTL_TF1 |
> --
> 2.30.2
>

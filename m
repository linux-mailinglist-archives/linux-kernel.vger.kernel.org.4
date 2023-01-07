Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 933BE661120
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 19:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232904AbjAGSon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 13:44:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbjAGSol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 13:44:41 -0500
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2C348590;
        Sat,  7 Jan 2023 10:44:40 -0800 (PST)
Received: by mail-ua1-x934.google.com with SMTP id l13so1080264uai.8;
        Sat, 07 Jan 2023 10:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9xzR1DJJSuan2w2vQzTsA6ged/gdW4jgpqQAkJ5mVuA=;
        b=ifMbeNz1CdnJgHtfm0szvGr3qiwbeUkO6s46cHlwrdUuIYCKxXdHe0jrWswkoTBNt5
         kuZY9T8oVx65TO3oovzC5AEYmpLkMW4UcOAUqDFkoxLpoqGU+unmz6pLaYVqsO3tGlhn
         i9zX6OOhYuYPTM5vp892OQjfr43nUiHW9YlE8OCqrswppDRcUSHI/IIQ85gimYzRQWDz
         oF2UuzlpExHWVVv41LIiKMQYj+/ZVw8grBOc7vLYfTnF0dSzUYPumBL75ZstG9sNXDK0
         eBGRTtvKPpAR1XPKy8SU6DVdq1cUOoC0qqz2JzZTquwCr3LUpUaSdhMv7y15LdowBx8r
         pSlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9xzR1DJJSuan2w2vQzTsA6ged/gdW4jgpqQAkJ5mVuA=;
        b=P1NDlKivLRIDLydBnamCcjQ+z1W4kIZART9lenxCUu71Jsk5+l9bm664b5V4Wqk2y6
         LMvzOm7N4ecaK/s5KeJAOWgws0kQ7Hs7D/pXrjsTAM5bKVXxazojuwSAAAPmc0LQSzgv
         +RP5hyJ2nOGCOBFzUZH/yncoE90q58+Zm8SSYOgTUjLLdklzlM9wn+EAm90fiUXZ9i9N
         a6AvlUlwD0azvd/aZNsSFxm/Xt7XoPOShtu0DNwlxgWBCbHRIEi1dcUYXKuvWBzqC+Nq
         8vXXkF93zySKriWKZmuUTfz+6hixLxNHJX7enNGW6Qs+l2VSA50IKnEkU6rcrJ1IGyJf
         jqqQ==
X-Gm-Message-State: AFqh2kr6pDD0qCraW+fMhW10afBw126INCO2YLTVcMtAjWJAK1aYuRsy
        f7PDYSaOAfU3oJAUM1VfL64SUvTEdgarT7rorPM=
X-Google-Smtp-Source: AMrXdXsrGRHfUJwfVunDcb4pJdXLioeTkqrHPw7jSqxZ6z8n0dpoKtsebGR9O1EyIyZY7KhrhFNRW9hlvSAzPp8oaDM=
X-Received: by 2002:ab0:624a:0:b0:5cb:ae3d:8c72 with SMTP id
 p10-20020ab0624a000000b005cbae3d8c72mr1214583uao.120.1673117079280; Sat, 07
 Jan 2023 10:44:39 -0800 (PST)
MIME-Version: 1.0
References: <20221215150214.1109074-1-hugo@hugovil.com> <20221215150214.1109074-12-hugo@hugovil.com>
In-Reply-To: <20221215150214.1109074-12-hugo@hugovil.com>
From:   Bruno Thomsen <bruno.thomsen@gmail.com>
Date:   Sat, 7 Jan 2023 19:44:23 +0100
Message-ID: <CAH+2xPBD4ezWPzMj4YzF63duWnw3_af6KkC7eq1EWS=5F_5NGw@mail.gmail.com>
Subject: Re: [PATCH v3 11/14] rtc: pcf2127: adapt time/date registers write
 sequence for PCF2131
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
> The sequence for updating the time/date registers is slightly
> different between PCF2127/29 and PCF2131.
>
> For PCF2127/29, during write operations, the time counting
> circuits (memory locations 03h through 09h) are automatically blocked.
>
> For PCF2131, time/date registers write access requires setting the
> STOP bit and sending the clear prescaler instruction (CPR). STOP then
> needs to be released once write operation is completed.
>
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> ---
>  drivers/rtc/rtc-pcf2127.c | 38 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 37 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
> index e4b78b9c03f9..11fbdab6bf01 100644
> --- a/drivers/rtc/rtc-pcf2127.c
> +++ b/drivers/rtc/rtc-pcf2127.c
> @@ -39,6 +39,7 @@
>  #define PCF2127_REG_CTRL1              0x00
>  #define PCF2127_BIT_CTRL1_POR_OVRD             BIT(3)
>  #define PCF2127_BIT_CTRL1_TSF1                 BIT(4)
> +#define PCF2127_BIT_CTRL1_STOP                 BIT(5)
>  /* Control register 2 */
>  #define PCF2127_REG_CTRL2              0x01
>  #define PCF2127_BIT_CTRL2_AIE                  BIT(1)
> @@ -70,6 +71,7 @@
>  #define PCF2131_REG_SR_RESET           0x05
>  #define PCF2131_SR_RESET_READ_PATTERN  0b00100100 /* Fixed pattern. */
>  #define PCF2131_SR_RESET_RESET_CMD     0x2C /* SR is bit 3. */
> +#define PCF2131_SR_RESET_CPR_CMD       0xA4 /* CPR is bit 7. */

Replace 0xA4 with (BIT(2) | BIT(5) | BIT(7)) or
(PCF2131_SR_RESET_READ_PATTERN | BIT(7))

>  /* Time and date registers */
>  #define PCF2127_REG_TIME_DATE_BASE     0x03
>  #define PCF2131_REG_TIME_DATE_BASE     0x07 /* Register 0x06 is 100th seconds,
> @@ -307,7 +309,31 @@ static int pcf2127_rtc_set_time(struct device *dev, struct rtc_time *tm)
>         /* year */
>         buf[i++] = bin2bcd(tm->tm_year - 100);
>
> -       /* write register's data */
> +       /* Write access to time registers:
> +        * PCF2127/29: no special action required.
> +        * PCF2131:    requires setting the STOP bit. STOP bit needs to
> +        *             be cleared after time registers are updated.
> +        *             It is also recommended to set CPR bit, although
> +        *             write access will work without it.
> +        */
> +       if (pcf2127->cfg->has_reset_reg) {
> +               err = regmap_update_bits(pcf2127->regmap, PCF2127_REG_CTRL1,
> +                                        PCF2127_BIT_CTRL1_STOP,
> +                                        PCF2127_BIT_CTRL1_STOP);
> +               if (err) {
> +                       dev_err(dev, "setting STOP bit failed\n");
> +                       return err;
> +               }
> +
> +               err = regmap_write(pcf2127->regmap, pcf2127->cfg->reg_reset,
> +                                  PCF2131_SR_RESET_CPR_CMD);
> +               if (err) {
> +                       dev_err(dev, "sending CPR cmd failed\n");
> +                       return err;
> +               }
> +       }
> +
> +       /* write time register's data */
>         err = regmap_bulk_write(pcf2127->regmap, pcf2127->cfg->regs_td_base, buf, i);
>         if (err) {
>                 dev_err(dev,
> @@ -315,6 +341,16 @@ static int pcf2127_rtc_set_time(struct device *dev, struct rtc_time *tm)
>                 return err;
>         }
>
> +       if (pcf2127->cfg->has_reset_reg) {
> +               /* Clear STOP bit (PCF2131 only) after write is completed. */
> +               err = regmap_update_bits(pcf2127->regmap, PCF2127_REG_CTRL1,
> +                                        PCF2127_BIT_CTRL1_STOP, 0);
> +               if (err) {
> +                       dev_err(dev, "clearing STOP bit failed\n");
> +                       return err;
> +               }
> +       }
> +
>         return 0;
>  }
>
> --
> 2.30.2
>

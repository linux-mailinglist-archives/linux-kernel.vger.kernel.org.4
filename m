Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4928065095D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 10:34:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbiLSJea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 04:34:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231621AbiLSJe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 04:34:26 -0500
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 787E3BE2F;
        Mon, 19 Dec 2022 01:34:25 -0800 (PST)
Received: by mail-vs1-xe35.google.com with SMTP id 3so8099254vsq.7;
        Mon, 19 Dec 2022 01:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JsufPZ/PDQrfMm1hSp3gjvny5V1CnXS77H3cVlLWxxM=;
        b=g3AWRX5WeuS8Yn4OI4zEeeAE2Y5ltaDFHP2wkAqfxa7Xinm8+dyMYpEJjYW1oz9uUE
         irS2YWjmybAHq1B8i63vbsy3VRQLY3nBpkZOXILWwwj6oJO5tOmo0j4xMnEiBqyRqvVt
         1Y5O5D0VznsIzz9L+IQV5W7JiMZq1Gv+EFmzgTo3KbZs5OLWIHDIs2OuCuTeiQvBPJWm
         9D5xV0nTiYyYPPYhShGZBl84kaupSiTlbQJ9BbNxrzoCyeWBK+JXdn0yyuS6aQKaGjVU
         l1dCCWGdXZR9a8p7BvUIyuegtlvD7Hz4mpW1LZtkHCnK0PfPXWgHDbU7IgQ270+v5WCH
         1Q3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JsufPZ/PDQrfMm1hSp3gjvny5V1CnXS77H3cVlLWxxM=;
        b=KTZFb4yOaSXXNR2jWrP5vN0kJ3wpJAivfSqZ1JMJ5yyxHA2UGm/m+zOS16ALR81u1V
         rnV42vjmmlzKWDcW3ruNlBrdneIbPqRBVAt6pTZTisLP9/uPxrCvaINFEVqI3sLkc5Un
         IzOfae/nWsovRDzGCd6oyeONKW76QPYmo8oGkfhem9r9C3tXoU+/xMY5mSKWYpEo7Mnj
         9f7p1/G+R8goHrjY+EXue6TXqVEdRqsaCbfjkV96QkiLsSXXeQOwndQcR677teJkCSb2
         IPfiS4W5qRplzlqxgMutSOHnY9M2pGAQa6+QuFP7njtgkmg0cwJ8pBXj8/5JOnUev5DX
         AJ1w==
X-Gm-Message-State: ANoB5pm9GrXACG+75XL/laomDABSvwOJoy9Zd8kfOawUNVi1AMHwju08
        fsg5zb9QMqviu8dYegHnbxhDpRzh1Gmn2YLwfEc=
X-Google-Smtp-Source: AA0mqf5VVXoCN9GD+IhUtn4vyIlqoJuZABk9ZBGcXEjr79I4pE2Y9MRMBcxZ7TZIRpBLvYyRvXcE1lwJ6CddX/rHawA=
X-Received: by 2002:a05:6102:11e3:b0:3b5:1fe4:f1c2 with SMTP id
 e3-20020a05610211e300b003b51fe4f1c2mr2767780vsg.0.1671442464567; Mon, 19 Dec
 2022 01:34:24 -0800 (PST)
MIME-Version: 1.0
References: <20221215150214.1109074-1-hugo@hugovil.com> <20221215150214.1109074-3-hugo@hugovil.com>
In-Reply-To: <20221215150214.1109074-3-hugo@hugovil.com>
From:   Bruno Thomsen <bruno.thomsen@gmail.com>
Date:   Mon, 19 Dec 2022 10:34:08 +0100
Message-ID: <CAH+2xPAMiQYsAcCDx5Cy3Wo6eVSEJh7ijnZywxD8uHYWP4beFQ@mail.gmail.com>
Subject: Re: [PATCH v3 02/14] rtc: pcf2127: adapt for time/date registers at
 any offset
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
> Some variants (PCF2131) have a 100th seconds register. This register is
> currently not supported in this driver.
>
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> ---
>  drivers/rtc/rtc-pcf2127.c | 68 ++++++++++++++++++++++-----------------
>  1 file changed, 39 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
> index b9a5d47a439f..fb0caacaabee 100644
> --- a/drivers/rtc/rtc-pcf2127.c
> +++ b/drivers/rtc/rtc-pcf2127.c
> @@ -44,14 +44,17 @@
>  #define PCF2127_BIT_CTRL3_BF                   BIT(3)
>  #define PCF2127_BIT_CTRL3_BTSE                 BIT(4)
>  /* Time and date registers */
> -#define PCF2127_REG_SC                 0x03
> +#define PCF2127_REG_TIME_DATE_BASE     0x03
> +/* Time and date registers offsets (starting from base register) */
> +#define PCF2127_OFFSET_TD_SC           0
> +#define PCF2127_OFFSET_TD_MN           1
> +#define PCF2127_OFFSET_TD_HR           2
> +#define PCF2127_OFFSET_TD_DM           3
> +#define PCF2127_OFFSET_TD_DW           4
> +#define PCF2127_OFFSET_TD_MO           5
> +#define PCF2127_OFFSET_TD_YR           6
> +/* Time and date registers bits */
>  #define PCF2127_BIT_SC_OSF                     BIT(7)
> -#define PCF2127_REG_MN                 0x04
> -#define PCF2127_REG_HR                 0x05
> -#define PCF2127_REG_DM                 0x06
> -#define PCF2127_REG_DW                 0x07
> -#define PCF2127_REG_MO                 0x08
> -#define PCF2127_REG_YR                 0x09
>  /* Alarm registers */
>  #define PCF2127_REG_ALARM_SC           0x0A
>  #define PCF2127_REG_ALARM_MN           0x0B
> @@ -106,6 +109,7 @@ struct pcf21xx_config {
>         int max_register;
>         unsigned int has_nvmem:1;
>         unsigned int has_bit_wd_ctl_cd0:1;
> +       u8 regs_td_base; /* Time/data base registers. */

There is only one base register, so no need to add s.
I think td is an odd short, so maybe u8 reg_time_base.

/Bruno

>  };
>
>  struct pcf2127 {
> @@ -125,27 +129,31 @@ struct pcf2127 {
>  static int pcf2127_rtc_read_time(struct device *dev, struct rtc_time *tm)
>  {
>         struct pcf2127 *pcf2127 = dev_get_drvdata(dev);
> -       unsigned char buf[10];
> +       unsigned char buf[7];
> +       unsigned int ctrl3;
>         int ret;
>
>         /*
>          * Avoid reading CTRL2 register as it causes WD_VAL register
>          * value to reset to 0 which means watchdog is stopped.
>          */
> -       ret = regmap_bulk_read(pcf2127->regmap, PCF2127_REG_CTRL3,
> -                              (buf + PCF2127_REG_CTRL3),
> -                              ARRAY_SIZE(buf) - PCF2127_REG_CTRL3);
> -       if (ret) {
> -               dev_err(dev, "%s: read error\n", __func__);
> +       ret = regmap_read(pcf2127->regmap, PCF2127_REG_CTRL3, &ctrl3);
> +       if (ret)
>                 return ret;
> -       }
>
> -       if (buf[PCF2127_REG_CTRL3] & PCF2127_BIT_CTRL3_BLF)
> +       if (ctrl3 & PCF2127_BIT_CTRL3_BLF)
>                 dev_info(dev,
>                         "low voltage detected, check/replace RTC battery.\n");
>
> +       ret = regmap_bulk_read(pcf2127->regmap, pcf2127->cfg->regs_td_base,
> +                              buf, sizeof(buf));
> +       if (ret) {
> +               dev_err(dev, "%s: read error\n", __func__);
> +               return ret;
> +       }
> +
>         /* Clock integrity is not guaranteed when OSF flag is set. */
> -       if (buf[PCF2127_REG_SC] & PCF2127_BIT_SC_OSF) {
> +       if (buf[PCF2127_OFFSET_TD_SC] & PCF2127_BIT_SC_OSF) {
>                 /*
>                  * no need clear the flag here,
>                  * it will be cleared once the new date is saved
> @@ -158,18 +166,18 @@ static int pcf2127_rtc_read_time(struct device *dev, struct rtc_time *tm)
>         dev_dbg(dev,
>                 "%s: raw data is cr3=%02x, sec=%02x, min=%02x, hr=%02x, "
>                 "mday=%02x, wday=%02x, mon=%02x, year=%02x\n",
> -               __func__, buf[PCF2127_REG_CTRL3], buf[PCF2127_REG_SC],
> -               buf[PCF2127_REG_MN], buf[PCF2127_REG_HR],
> -               buf[PCF2127_REG_DM], buf[PCF2127_REG_DW],
> -               buf[PCF2127_REG_MO], buf[PCF2127_REG_YR]);
> -
> -       tm->tm_sec = bcd2bin(buf[PCF2127_REG_SC] & 0x7F);
> -       tm->tm_min = bcd2bin(buf[PCF2127_REG_MN] & 0x7F);
> -       tm->tm_hour = bcd2bin(buf[PCF2127_REG_HR] & 0x3F); /* rtc hr 0-23 */
> -       tm->tm_mday = bcd2bin(buf[PCF2127_REG_DM] & 0x3F);
> -       tm->tm_wday = buf[PCF2127_REG_DW] & 0x07;
> -       tm->tm_mon = bcd2bin(buf[PCF2127_REG_MO] & 0x1F) - 1; /* rtc mn 1-12 */
> -       tm->tm_year = bcd2bin(buf[PCF2127_REG_YR]);
> +               __func__, ctrl3, buf[PCF2127_OFFSET_TD_SC],
> +               buf[PCF2127_OFFSET_TD_MN], buf[PCF2127_OFFSET_TD_HR],
> +               buf[PCF2127_OFFSET_TD_DM], buf[PCF2127_OFFSET_TD_DW],
> +               buf[PCF2127_OFFSET_TD_MO], buf[PCF2127_OFFSET_TD_YR]);
> +
> +       tm->tm_sec = bcd2bin(buf[PCF2127_OFFSET_TD_SC] & 0x7F);
> +       tm->tm_min = bcd2bin(buf[PCF2127_OFFSET_TD_MN] & 0x7F);
> +       tm->tm_hour = bcd2bin(buf[PCF2127_OFFSET_TD_HR] & 0x3F); /* rtc hr 0-23 */
> +       tm->tm_mday = bcd2bin(buf[PCF2127_OFFSET_TD_DM] & 0x3F);
> +       tm->tm_wday = buf[PCF2127_OFFSET_TD_DW] & 0x07;
> +       tm->tm_mon = bcd2bin(buf[PCF2127_OFFSET_TD_MO] & 0x1F) - 1; /* rtc mn 1-12 */
> +       tm->tm_year = bcd2bin(buf[PCF2127_OFFSET_TD_YR]);
>         tm->tm_year += 100;
>
>         dev_dbg(dev, "%s: tm is secs=%d, mins=%d, hours=%d, "
> @@ -207,7 +215,7 @@ static int pcf2127_rtc_set_time(struct device *dev, struct rtc_time *tm)
>         buf[i++] = bin2bcd(tm->tm_year - 100);
>
>         /* write register's data */
> -       err = regmap_bulk_write(pcf2127->regmap, PCF2127_REG_SC, buf, i);
> +       err = regmap_bulk_write(pcf2127->regmap, pcf2127->cfg->regs_td_base, buf, i);
>         if (err) {
>                 dev_err(dev,
>                         "%s: err=%d", __func__, err);
> @@ -650,11 +658,13 @@ static struct pcf21xx_config pcf21xx_cfg[] = {
>                 .max_register = 0x1d,
>                 .has_nvmem = 1,
>                 .has_bit_wd_ctl_cd0 = 1,
> +               .regs_td_base = PCF2127_REG_TIME_DATE_BASE,
>         },
>         [PCF2129] = {
>                 .max_register = 0x19,
>                 .has_nvmem = 0,
>                 .has_bit_wd_ctl_cd0 = 0,
> +               .regs_td_base = PCF2127_REG_TIME_DATE_BASE,
>         },
>  };
>
> --
> 2.30.2
>

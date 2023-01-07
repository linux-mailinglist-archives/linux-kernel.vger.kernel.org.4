Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 482AF661047
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 17:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbjAGQuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 11:50:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjAGQt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 11:49:58 -0500
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8746392F7;
        Sat,  7 Jan 2023 08:49:57 -0800 (PST)
Received: by mail-ua1-x936.google.com with SMTP id z23so1034628uae.7;
        Sat, 07 Jan 2023 08:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hsZTXn6L0RBqAggtbzDtQAakusN7Yx/qfznNmyC9Usw=;
        b=NRiiUikcK+AopKzpw9m0U12OjZ5VGEJ8JGLsDFMzWUoIT/B6En+y2oa813GHBAjdDC
         EGED9+jaATyMgwZXuQJVrpn7KrbgshRJv6YEFLC/8HPZzAkhsfNfpWEFGpmZVF2sj0O8
         XM+nfaS4Cjy8zy5yRL6jwYDY6/h6WYAl5/MSoz2dpYWEXzJzB3uol3gVX+TOu3lEjrJj
         Zj0lfmmYpyv8+4fz3S4DdsQ/3uAAOe2AkDUv40NGcavErc1HMeP1ZjO3/7eWVJ20GexO
         cROuyH6VLHo++2MQlsWG7aVB9ong1LU9Y7UoOce/wT4tO6nbL8iHfx8HzTRW4o7vIY7n
         91+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hsZTXn6L0RBqAggtbzDtQAakusN7Yx/qfznNmyC9Usw=;
        b=x3pJ5rNXu+QrooikkYpioKtWxGvZqgSR6k8kMzCQlBoPxYYYJIlhQmKkcY99j6f5i1
         PkvkqBwHpErfUqyIZYjeyeAtYZ22fm3dfjmcxqEFZS32vSeqQ6gmqeYxBDZdqX/5dhMp
         eG11YJ8sCmCK24NY+0j7YPsiC03GrD4DtoaNv95r8u+qFAvoms9316h/9K3FZ9VhnPok
         3E3yeCNUMDTi/qiDBZxeSErFVDijEbxtnWKyTCMmtxK1m7UYaZMJxTIvG1VA3kXPfvbK
         KsDafsEbD8Q3ez1FNMVj8WJHWtP5os7IiVSUN6lk3xaK1bw4smdkVmygvBytGbinsojf
         OhPQ==
X-Gm-Message-State: AFqh2kre85RhvXOS6+CEQkkFK5NBC0eqUOuyTLde4ZpojtLuLr8vM3j1
        Ii8WMYd/ARcmsx7U4pST8nlUKKGcuXUvKTPpZLU=
X-Google-Smtp-Source: AMrXdXtnf8oTi1w6spCDGcn/lRFWWPxxSeRvoFTuEAUsT9KILAbQ9OAZIhjcVaKQ3DeysqgI20qaNiev5iQDlZ8dERE=
X-Received: by 2002:ab0:2a06:0:b0:426:ec0:5dfa with SMTP id
 o6-20020ab02a06000000b004260ec05dfamr6103390uar.14.1673110196843; Sat, 07 Jan
 2023 08:49:56 -0800 (PST)
MIME-Version: 1.0
References: <20221215150214.1109074-1-hugo@hugovil.com> <20221215150214.1109074-3-hugo@hugovil.com>
 <CAH+2xPAMiQYsAcCDx5Cy3Wo6eVSEJh7ijnZywxD8uHYWP4beFQ@mail.gmail.com>
In-Reply-To: <CAH+2xPAMiQYsAcCDx5Cy3Wo6eVSEJh7ijnZywxD8uHYWP4beFQ@mail.gmail.com>
From:   Bruno Thomsen <bruno.thomsen@gmail.com>
Date:   Sat, 7 Jan 2023 17:49:40 +0100
Message-ID: <CAH+2xPBqJoGqYbRAn90J95CgczLFVwiGN+nqGt7CZddq1jCR1A@mail.gmail.com>
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

Den man. 19. dec. 2022 kl. 10.34 skrev Bruno Thomsen <bruno.thomsen@gmail.com>:
>
> Den tor. 15. dec. 2022 kl. 16.20 skrev Hugo Villeneuve <hugo@hugovil.com>:
> >
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> >
> > This will simplify the implementation of new variants into this driver.
> >
> > Some variants (PCF2131) have a 100th seconds register. This register is
> > currently not supported in this driver.
> >
> > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > ---
> >  drivers/rtc/rtc-pcf2127.c | 68 ++++++++++++++++++++++-----------------
> >  1 file changed, 39 insertions(+), 29 deletions(-)
> >
> > diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
> > index b9a5d47a439f..fb0caacaabee 100644
> > --- a/drivers/rtc/rtc-pcf2127.c
> > +++ b/drivers/rtc/rtc-pcf2127.c
> > @@ -44,14 +44,17 @@
> >  #define PCF2127_BIT_CTRL3_BF                   BIT(3)
> >  #define PCF2127_BIT_CTRL3_BTSE                 BIT(4)
> >  /* Time and date registers */
> > -#define PCF2127_REG_SC                 0x03
> > +#define PCF2127_REG_TIME_DATE_BASE     0x03
> > +/* Time and date registers offsets (starting from base register) */
> > +#define PCF2127_OFFSET_TD_SC           0

Maybe do the same change for register defines as the pc721xx_config
struct parameter. This will also match what you did in patch 3 with
alarm registers.

- PCF2127_REG_TIME_DATE_BASE
+ PCF2127_REG_TIME_BASE

- PCF2127_OFFSET_TD_SC
+ PCF2127_OFFSET_TIME_SC

etc.

> > +#define PCF2127_OFFSET_TD_MN           1
> > +#define PCF2127_OFFSET_TD_HR           2
> > +#define PCF2127_OFFSET_TD_DM           3
> > +#define PCF2127_OFFSET_TD_DW           4
> > +#define PCF2127_OFFSET_TD_MO           5
> > +#define PCF2127_OFFSET_TD_YR           6
> > +/* Time and date registers bits */
> >  #define PCF2127_BIT_SC_OSF                     BIT(7)
> > -#define PCF2127_REG_MN                 0x04
> > -#define PCF2127_REG_HR                 0x05
> > -#define PCF2127_REG_DM                 0x06
> > -#define PCF2127_REG_DW                 0x07
> > -#define PCF2127_REG_MO                 0x08
> > -#define PCF2127_REG_YR                 0x09
> >  /* Alarm registers */
> >  #define PCF2127_REG_ALARM_SC           0x0A
> >  #define PCF2127_REG_ALARM_MN           0x0B
> > @@ -106,6 +109,7 @@ struct pcf21xx_config {
> >         int max_register;
> >         unsigned int has_nvmem:1;
> >         unsigned int has_bit_wd_ctl_cd0:1;
> > +       u8 regs_td_base; /* Time/data base registers. */
>
> There is only one base register, so no need to add s.
> I think td is an odd short, so maybe u8 reg_time_base.
>
> /Bruno
>
> >  };
> >
> >  struct pcf2127 {
> > @@ -125,27 +129,31 @@ struct pcf2127 {
> >  static int pcf2127_rtc_read_time(struct device *dev, struct rtc_time *tm)
> >  {
> >         struct pcf2127 *pcf2127 = dev_get_drvdata(dev);
> > -       unsigned char buf[10];
> > +       unsigned char buf[7];
> > +       unsigned int ctrl3;
> >         int ret;
> >
> >         /*
> >          * Avoid reading CTRL2 register as it causes WD_VAL register
> >          * value to reset to 0 which means watchdog is stopped.
> >          */
> > -       ret = regmap_bulk_read(pcf2127->regmap, PCF2127_REG_CTRL3,
> > -                              (buf + PCF2127_REG_CTRL3),
> > -                              ARRAY_SIZE(buf) - PCF2127_REG_CTRL3);
> > -       if (ret) {
> > -               dev_err(dev, "%s: read error\n", __func__);
> > +       ret = regmap_read(pcf2127->regmap, PCF2127_REG_CTRL3, &ctrl3);
> > +       if (ret)
> >                 return ret;
> > -       }
> >
> > -       if (buf[PCF2127_REG_CTRL3] & PCF2127_BIT_CTRL3_BLF)
> > +       if (ctrl3 & PCF2127_BIT_CTRL3_BLF)
> >                 dev_info(dev,
> >                         "low voltage detected, check/replace RTC battery.\n");
> >
> > +       ret = regmap_bulk_read(pcf2127->regmap, pcf2127->cfg->regs_td_base,
> > +                              buf, sizeof(buf));
> > +       if (ret) {
> > +               dev_err(dev, "%s: read error\n", __func__);
> > +               return ret;
> > +       }
> > +
> >         /* Clock integrity is not guaranteed when OSF flag is set. */
> > -       if (buf[PCF2127_REG_SC] & PCF2127_BIT_SC_OSF) {
> > +       if (buf[PCF2127_OFFSET_TD_SC] & PCF2127_BIT_SC_OSF) {
> >                 /*
> >                  * no need clear the flag here,
> >                  * it will be cleared once the new date is saved
> > @@ -158,18 +166,18 @@ static int pcf2127_rtc_read_time(struct device *dev, struct rtc_time *tm)
> >         dev_dbg(dev,
> >                 "%s: raw data is cr3=%02x, sec=%02x, min=%02x, hr=%02x, "
> >                 "mday=%02x, wday=%02x, mon=%02x, year=%02x\n",
> > -               __func__, buf[PCF2127_REG_CTRL3], buf[PCF2127_REG_SC],
> > -               buf[PCF2127_REG_MN], buf[PCF2127_REG_HR],
> > -               buf[PCF2127_REG_DM], buf[PCF2127_REG_DW],
> > -               buf[PCF2127_REG_MO], buf[PCF2127_REG_YR]);
> > -
> > -       tm->tm_sec = bcd2bin(buf[PCF2127_REG_SC] & 0x7F);
> > -       tm->tm_min = bcd2bin(buf[PCF2127_REG_MN] & 0x7F);
> > -       tm->tm_hour = bcd2bin(buf[PCF2127_REG_HR] & 0x3F); /* rtc hr 0-23 */
> > -       tm->tm_mday = bcd2bin(buf[PCF2127_REG_DM] & 0x3F);
> > -       tm->tm_wday = buf[PCF2127_REG_DW] & 0x07;
> > -       tm->tm_mon = bcd2bin(buf[PCF2127_REG_MO] & 0x1F) - 1; /* rtc mn 1-12 */
> > -       tm->tm_year = bcd2bin(buf[PCF2127_REG_YR]);
> > +               __func__, ctrl3, buf[PCF2127_OFFSET_TD_SC],
> > +               buf[PCF2127_OFFSET_TD_MN], buf[PCF2127_OFFSET_TD_HR],
> > +               buf[PCF2127_OFFSET_TD_DM], buf[PCF2127_OFFSET_TD_DW],
> > +               buf[PCF2127_OFFSET_TD_MO], buf[PCF2127_OFFSET_TD_YR]);
> > +
> > +       tm->tm_sec = bcd2bin(buf[PCF2127_OFFSET_TD_SC] & 0x7F);
> > +       tm->tm_min = bcd2bin(buf[PCF2127_OFFSET_TD_MN] & 0x7F);
> > +       tm->tm_hour = bcd2bin(buf[PCF2127_OFFSET_TD_HR] & 0x3F); /* rtc hr 0-23 */
> > +       tm->tm_mday = bcd2bin(buf[PCF2127_OFFSET_TD_DM] & 0x3F);
> > +       tm->tm_wday = buf[PCF2127_OFFSET_TD_DW] & 0x07;
> > +       tm->tm_mon = bcd2bin(buf[PCF2127_OFFSET_TD_MO] & 0x1F) - 1; /* rtc mn 1-12 */
> > +       tm->tm_year = bcd2bin(buf[PCF2127_OFFSET_TD_YR]);
> >         tm->tm_year += 100;
> >
> >         dev_dbg(dev, "%s: tm is secs=%d, mins=%d, hours=%d, "
> > @@ -207,7 +215,7 @@ static int pcf2127_rtc_set_time(struct device *dev, struct rtc_time *tm)
> >         buf[i++] = bin2bcd(tm->tm_year - 100);
> >
> >         /* write register's data */
> > -       err = regmap_bulk_write(pcf2127->regmap, PCF2127_REG_SC, buf, i);
> > +       err = regmap_bulk_write(pcf2127->regmap, pcf2127->cfg->regs_td_base, buf, i);
> >         if (err) {
> >                 dev_err(dev,
> >                         "%s: err=%d", __func__, err);
> > @@ -650,11 +658,13 @@ static struct pcf21xx_config pcf21xx_cfg[] = {
> >                 .max_register = 0x1d,
> >                 .has_nvmem = 1,
> >                 .has_bit_wd_ctl_cd0 = 1,
> > +               .regs_td_base = PCF2127_REG_TIME_DATE_BASE,
> >         },
> >         [PCF2129] = {
> >                 .max_register = 0x19,
> >                 .has_nvmem = 0,
> >                 .has_bit_wd_ctl_cd0 = 0,
> > +               .regs_td_base = PCF2127_REG_TIME_DATE_BASE,
> >         },
> >  };
> >
> > --
> > 2.30.2
> >

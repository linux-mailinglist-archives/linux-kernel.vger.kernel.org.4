Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60F0B651065
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 17:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbiLSQ1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 11:27:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbiLSQ1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 11:27:30 -0500
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EBEEB492;
        Mon, 19 Dec 2022 08:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:Mime-Version:
        References:In-Reply-To:Message-Id:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=yz2My1ZtMOzXmoRi2234/xeBrOI2A4PzXUb5qN8cY8I=; b=RyxWc76gKJW8eM5ZfpkXur2L6u
        CddUyI2zZSn0PK90LnFRLoHSZ2LZBvMvrd8GwBVVmj0RNHDzevXVcQbp4XgnBaunY5XLrExSMn+Ej
        AOC60fhacnVb2pkVcYJXmVbSJ5nvYLMRrwrnjKEpPwnRXOesBYlX0EKFoims1wj2iTOI=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:48608 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1p7Iz6-0001Vy-06; Mon, 19 Dec 2022 11:27:24 -0500
Date:   Mon, 19 Dec 2022 11:27:23 -0500
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Bruno Thomsen <bruno.thomsen@gmail.com>
Cc:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
Message-Id: <20221219112723.ad5caf2b2da9b02a54a9aecb@hugovil.com>
In-Reply-To: <CAH+2xPAMiQYsAcCDx5Cy3Wo6eVSEJh7ijnZywxD8uHYWP4beFQ@mail.gmail.com>
References: <20221215150214.1109074-1-hugo@hugovil.com>
        <20221215150214.1109074-3-hugo@hugovil.com>
        <CAH+2xPAMiQYsAcCDx5Cy3Wo6eVSEJh7ijnZywxD8uHYWP4beFQ@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH v3 02/14] rtc: pcf2127: adapt for time/date registers at
 any offset
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Dec 2022 10:34:08 +0100
Bruno Thomsen <bruno.thomsen@gmail.com> wrote:

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

Hi,
it makes sense, I will fix it in V4.

I will also fix the comment "Time/data" -> "Time/date".

Hugo.


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
> 


-- 
Hugo Villeneuve <hugo@hugovil.com>

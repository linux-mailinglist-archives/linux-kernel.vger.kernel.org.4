Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF9C66785CC
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 20:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232270AbjAWTHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 14:07:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232139AbjAWTHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 14:07:08 -0500
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A8230194;
        Mon, 23 Jan 2023 11:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:Mime-Version:
        References:In-Reply-To:Message-Id:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=BL5etvgVmx5nN3ROwYBtJIgI/Ohtp7CHYizRYB08amM=; b=MeG35cAFNk4Khbd7My3FmS5A2c
        fD6xeYFpC+T31s1Tri6iFQfK6Wl64h28fJUWlSGPPqikso1VIXei4jNdInS44gRJSYUAp1+nXum4O
        539ftqDeF4P0fs+226csriBTnPXwOXYiAuk/f/Zv2XsrmLy2vjU4/v9yzdTndJM8kz04=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:41496 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1pK29K-0003aV-JL; Mon, 23 Jan 2023 14:06:36 -0500
Date:   Mon, 23 Jan 2023 14:06:34 -0500
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Bruno Thomsen <bruno.thomsen@gmail.com>
Cc:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
Message-Id: <20230123140634.10d3be57924139fa098878f9@hugovil.com>
In-Reply-To: <CAH+2xPBHTRLpQRBtGe40bJ3k-wWf5LfXjOhHu2x5uuyvCk84Fw@mail.gmail.com>
References: <20221215150214.1109074-1-hugo@hugovil.com>
        <20221215150214.1109074-8-hugo@hugovil.com>
        <CAH+2xPBHTRLpQRBtGe40bJ3k-wWf5LfXjOhHu2x5uuyvCk84Fw@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH v3 07/14] rtc: pcf2127: add support for PCF2131 RTC
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Jan 2023 19:15:00 +0100
Bruno Thomsen <bruno.thomsen@gmail.com> wrote:

> Den tor. 15. dec. 2022 kl. 16.20 skrev Hugo Villeneuve <hugo@hugovil.com>:
> >
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> >
> > This RTC is very similar in functionality to the PCF2127/29.
> >
> > Basically it:
> >   -supports two new control registers at offsets 4 and 5
> >   -supports a new reset register (not implemented in this driver)
> >   -supports 4 tamper detection functions instead of 1
> >   -has no nvmem (like the PCF2129)
> >   -has two output interrupt pins
> >
> > Because of that, most of the register addresses are very different,
> > although they still follow the same layout. For example, the tamper
> > registers have a different base address, but the offsets are all the same.
> >
> > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > ---
> >  drivers/rtc/Kconfig       |   4 +-
> >  drivers/rtc/rtc-pcf2127.c | 234 ++++++++++++++++++++++++++++++++++----
> >  2 files changed, 215 insertions(+), 23 deletions(-)
> >
> > diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> > index 2bb640d1521d..3d4043ce0057 100644
> > --- a/drivers/rtc/Kconfig
> > +++ b/drivers/rtc/Kconfig
> > @@ -910,9 +910,9 @@ config RTC_DRV_PCF2127
> >         select REGMAP_SPI if SPI_MASTER
> >         select WATCHDOG_CORE if WATCHDOG
> >         help
> > -         If you say yes here you get support for the NXP PCF2127/29 RTC
> > +         If you say yes here you get support for the NXP PCF2127/29/31 RTC
> >           chips with integrated quartz crystal for industrial applications.
> > -         Both chips also have watchdog timer and tamper switch detection
> > +         These chips also have watchdog timer and tamper switch detection
> >           features.
> >
> >           PCF2127 has an additional feature of 512 bytes battery backed
> > diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
> > index 3265878edc48..4148e135f935 100644
> > --- a/drivers/rtc/rtc-pcf2127.c
> > +++ b/drivers/rtc/rtc-pcf2127.c
> > @@ -1,16 +1,26 @@
> >  // SPDX-License-Identifier: GPL-2.0-only
> >  /*
> > - * An I2C and SPI driver for the NXP PCF2127/29 RTC
> > + * An I2C and SPI driver for the NXP PCF2127/29/31 RTC
> >   * Copyright 2013 Til-Technologies
> > + * Copyright 2021 DimOnOff
> >   *
> >   * Author: Renaud Cerrato <r.cerrato@til-technologies.fr>
> >   *
> >   * Watchdog and tamper functions
> >   * Author: Bruno Thomsen <bruno.thomsen@gmail.com>
> >   *
> > + * PCF2131 support
> > + * Author: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > + *
> >   * based on the other drivers in this same directory.
> >   *
> > - * Datasheet: https://www.nxp.com/docs/en/data-sheet/PCF2127.pdf
> > + * Datasheets: https://www.nxp.com/docs/en/data-sheet/PCF2127.pdf
> > + *             https://www.nxp.com/docs/en/data-sheet/PCF2131DS.pdf
> > + */
> > +
> > +/*
> > + * The following features are not yet implemented for the PCF2131:
> > + *   - support for 1/100th seconds
> >   */
> >
> >  #include <linux/i2c.h>
> > @@ -43,8 +53,30 @@
> >  #define PCF2127_BIT_CTRL3_BLF                  BIT(2)
> >  #define PCF2127_BIT_CTRL3_BF                   BIT(3)
> >  #define PCF2127_BIT_CTRL3_BTSE                 BIT(4)
> > +/* Control register 4 */
> > +#define PCF2131_REG_CTRL4              0x03
> > +#define PCF2131_BIT_CTRL4_TSF4                 BIT(4)
> > +#define PCF2131_BIT_CTRL4_TSF3                 BIT(5)
> > +#define PCF2131_BIT_CTRL4_TSF2                 BIT(6)
> > +#define PCF2131_BIT_CTRL4_TSF1                 BIT(7)
> > +/* Control register 5 */
> > +#define PCF2131_REG_CTRL5              0x04
> > +#define PCF2131_BIT_CTRL5_TSIE4                        BIT(4)
> > +#define PCF2131_BIT_CTRL5_TSIE3                        BIT(5)
> > +#define PCF2131_BIT_CTRL5_TSIE2                        BIT(6)
> > +#define PCF2131_BIT_CTRL5_TSIE1                        BIT(7)
> > +/* Software reset register */
> > +#define PCF2131_REG_SR_RESET           0x05
> > +#define PCF2131_SR_RESET_READ_PATTERN  0b00100100 /* Fixed pattern. */
> 
> Replace 0b00100100 with (BIT(2) | BIT(5))

Removed this define as the reset signature is no longer verified.


> > +#define PCF2131_SR_RESET_RESET_CMD     0x2C /* SR is bit 3. */
> 
> Replace 0x2C with (BIT(2) | BIT(3) | BIT(5)) or
> (PCF2131_SR_RESET_READ_PATTERN | BIT(3))
> and then drop the comment.

Done.


> 
> >  /* Time and date registers */
> >  #define PCF2127_REG_TIME_DATE_BASE     0x03
> > +#define PCF2131_REG_TIME_DATE_BASE     0x07 /* Register 0x06 is 100th seconds,
> > +                                             * but we do not support it. By
> > +                                             * using offset 0x07, we can be
> > +                                             * compatible with existing
> > +                                             * time/date functions.
> > +                                             */
> 
> I think you should add this rather big comment above
> #define PCF2131_REG_TIME_DATE_BASE 0x07

Removed comment as suggested by Alexandre.

> 
> and rename the define to PCF2131_REG_TIME_BASE.

Done.


> 
> >  /* Time and date registers offsets (starting from base register) */
> >  #define PCF2127_OFFSET_TD_SC           0
> >  #define PCF2127_OFFSET_TD_MN           1
> > @@ -57,6 +89,7 @@
> >  #define PCF2127_BIT_SC_OSF                     BIT(7)
> >  /* Alarm registers */
> >  #define PCF2127_REG_ALARM_BASE         0x0A
> > +#define PCF2131_REG_ALARM_BASE         0x0E
> >  /* Alarm registers offsets (starting from base register) */
> >  #define PCF2127_OFFSET_ALARM_SC                0
> >  #define PCF2127_OFFSET_ALARM_MN                1
> > @@ -67,16 +100,26 @@
> >  #define PCF2127_BIT_ALARM_AE                   BIT(7)
> >  /* CLKOUT control register */
> >  #define PCF2127_REG_CLKOUT             0x0f
> > +#define PCF2131_REG_CLKOUT             0x13
> >  #define PCF2127_BIT_CLKOUT_OTPR                        BIT(5)
> >  /* Watchdog registers */
> >  #define PCF2127_REG_WD_CTL             0x10
> > +#define PCF2131_REG_WD_CTL             0x35
> >  #define PCF2127_BIT_WD_CTL_TF0                 BIT(0)
> >  #define PCF2127_BIT_WD_CTL_TF1                 BIT(1)
> >  #define PCF2127_BIT_WD_CTL_CD0                 BIT(6)
> >  #define PCF2127_BIT_WD_CTL_CD1                 BIT(7)
> >  #define PCF2127_REG_WD_VAL             0x11
> > +#define PCF2131_REG_WD_VAL             0x36
> >  /* Tamper timestamp1 registers */
> >  #define PCF2127_REG_TS1_BASE           0x12
> > +#define PCF2131_REG_TS1_BASE           0x14
> > +/* Tamper timestamp2 registers */
> > +#define PCF2131_REG_TS2_BASE           0x1B
> > +/* Tamper timestamp3 registers */
> > +#define PCF2131_REG_TS3_BASE           0x22
> > +/* Tamper timestamp4 registers */
> > +#define PCF2131_REG_TS4_BASE           0x29
> >  /* Tamper timestamp registers common offsets (starting from base register) */
> >  #define PCF2127_OFFSET_TS_CTL          0
> >  #define PCF2127_OFFSET_TS_SC           1
> > @@ -92,11 +135,22 @@
> >   * RAM registers
> >   * PCF2127 has 512 bytes general-purpose static RAM (SRAM) that is
> >   * battery backed and can survive a power outage.
> > - * PCF2129 doesn't have this feature.
> > + * PCF2129/31 doesn't have this feature.
> >   */
> >  #define PCF2127_REG_RAM_ADDR_MSB       0x1A
> >  #define PCF2127_REG_RAM_WRT_CMD                0x1C
> >  #define PCF2127_REG_RAM_RD_CMD         0x1D
> > +/* Interrupt mask registers */
> > +#define PCF2131_REG_INT_A_MASK1                0x31
> > +#define PCF2131_REG_INT_A_MASK2                0x32
> > +#define PCF2131_REG_INT_B_MASK1                0x33
> > +#define PCF2131_REG_INT_B_MASK2                0x34
> > +#define PCF2131_BIT_INT_BLIE           BIT(0)
> > +#define PCF2131_BIT_INT_BIE            BIT(1)
> > +#define PCF2131_BIT_INT_AIE            BIT(2)
> > +#define PCF2131_BIT_INT_WD_CD          BIT(3)
> > +#define PCF2131_BIT_INT_SI             BIT(4)
> > +#define PCF2131_BIT_INT_MI             BIT(5)
> >
> >  /* Watchdog timer value constants */
> >  #define PCF2127_WD_VAL_STOP            0
> > @@ -110,6 +164,14 @@
> >                 PCF2127_BIT_CTRL2_AF | \
> >                 PCF2127_BIT_CTRL2_WDTF | \
> >                 PCF2127_BIT_CTRL2_TSF2)
> > +#define PCF2131_CTRL2_IRQ_MASK ( \
> > +               PCF2127_BIT_CTRL2_AF | \
> > +               PCF2127_BIT_CTRL2_WDTF)
> > +#define PCF2131_CTRL4_IRQ_MASK ( \
> > +               PCF2131_BIT_CTRL4_TSF4 | \
> > +               PCF2131_BIT_CTRL4_TSF3 | \
> > +               PCF2131_BIT_CTRL4_TSF2 | \
> > +               PCF2131_BIT_CTRL4_TSF1)
> >
> >  struct pcf21xx_ts_config {
> >         u8 regs_base; /* Base register to read timestamp values. */
> > @@ -370,7 +432,7 @@ static int pcf2127_wdt_set_timeout(struct watchdog_device *wdd,
> >  }
> >
> >  static const struct watchdog_info pcf2127_wdt_info = {
> > -       .identity = "NXP PCF2127/PCF2129 Watchdog",
> > +       .identity = "NXP PCF2127/29/31 Watchdog",
> >         .options = WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT,
> >  };
> >
> > @@ -555,30 +617,64 @@ static void pcf2127_rtc_ts_snapshot(struct device *dev, int ts_id)
> >  static irqreturn_t pcf2127_rtc_irq(int irq, void *dev)
> >  {
> >         struct pcf2127 *pcf2127 = dev_get_drvdata(dev);
> > -       unsigned int ctrl1, ctrl2;
> > +       unsigned int ctrl2;
> >         int ret = 0;
> >
> > -       ret = regmap_read(pcf2127->regmap, PCF2127_REG_CTRL1, &ctrl1);
> > -       if (ret)
> > -               return IRQ_NONE;
> > -
> >         ret = regmap_read(pcf2127->regmap, PCF2127_REG_CTRL2, &ctrl2);
> >         if (ret)
> >                 return IRQ_NONE;
> >
> > -       if (!(ctrl1 & PCF2127_CTRL1_IRQ_MASK || ctrl2 & PCF2127_CTRL2_IRQ_MASK))
> > -               return IRQ_NONE;
> > +       if (pcf2127->cfg->ts_count == 1) {
> > +               /* PCF2127/29 */
> > +               unsigned int ctrl1;
> > +
> > +               ret = regmap_read(pcf2127->regmap, PCF2127_REG_CTRL1, &ctrl1);
> > +               if (ret)
> > +                       return IRQ_NONE;
> > +
> > +               if (!(ctrl1 & PCF2127_CTRL1_IRQ_MASK || ctrl2 & PCF2127_CTRL2_IRQ_MASK))
> > +                       return IRQ_NONE;
> >
> > -       if (ctrl1 & PCF2127_BIT_CTRL1_TSF1 || ctrl2 & PCF2127_BIT_CTRL2_TSF2)
> > -               pcf2127_rtc_ts_snapshot(dev, 0);
> > +               if (ctrl1 & PCF2127_BIT_CTRL1_TSF1 || ctrl2 & PCF2127_BIT_CTRL2_TSF2)
> > +                       pcf2127_rtc_ts_snapshot(dev, 0);
> >
> > -       if (ctrl1 & PCF2127_CTRL1_IRQ_MASK)
> > -               regmap_write(pcf2127->regmap, PCF2127_REG_CTRL1,
> > -                       ctrl1 & ~PCF2127_CTRL1_IRQ_MASK);
> > +               if (ctrl1 & PCF2127_CTRL1_IRQ_MASK)
> > +                       regmap_write(pcf2127->regmap, PCF2127_REG_CTRL1,
> > +                                    ctrl1 & ~PCF2127_CTRL1_IRQ_MASK);
> > +
> > +               if (ctrl2 & PCF2127_CTRL2_IRQ_MASK)
> > +                       regmap_write(pcf2127->regmap, PCF2127_REG_CTRL2,
> > +                                    ctrl2 & ~PCF2127_CTRL2_IRQ_MASK);
> > +       } else {
> > +               /* PCF2131. */
> > +               unsigned int ctrl4;
> > +
> > +               ret = regmap_read(pcf2127->regmap, PCF2131_REG_CTRL4, &ctrl4);
> > +               if (ret)
> > +                       return IRQ_NONE;
> >
> > -       if (ctrl2 & PCF2127_CTRL2_IRQ_MASK)
> > -               regmap_write(pcf2127->regmap, PCF2127_REG_CTRL2,
> > -                       ctrl2 & ~PCF2127_CTRL2_IRQ_MASK);
> > +               if (!(ctrl4 & PCF2131_CTRL4_IRQ_MASK || ctrl2 & PCF2131_CTRL2_IRQ_MASK))
> > +                       return IRQ_NONE;
> > +
> > +               if (ctrl4 & PCF2131_CTRL4_IRQ_MASK) {
> > +                       int i;
> > +                       int tsf_bit = PCF2131_BIT_CTRL4_TSF1; /* Start at bit 7. */
> > +
> > +                       for (i = 0; i < pcf2127->cfg->ts_count; i++) {
> > +                               if (ctrl4 & tsf_bit)
> > +                                       pcf2127_rtc_ts_snapshot(dev, i);
> > +
> > +                               tsf_bit = tsf_bit >> 1;
> > +                       }
> > +
> > +                       regmap_write(pcf2127->regmap, PCF2131_REG_CTRL4,
> > +                                    ctrl4 & ~PCF2131_CTRL4_IRQ_MASK);
> > +               }
> > +
> > +               if (ctrl2 & PCF2131_CTRL2_IRQ_MASK)
> > +                       regmap_write(pcf2127->regmap, PCF2127_REG_CTRL2,
> > +                                    ctrl2 & ~PCF2131_CTRL2_IRQ_MASK);
> > +       }
> >
> >         if (ctrl2 & PCF2127_BIT_CTRL2_AF)
> >                 rtc_update_irq(pcf2127->rtc, 1, RTC_IRQF | RTC_AF);
> > @@ -650,6 +746,27 @@ static ssize_t timestamp0_store(struct device *dev,
> >         return timestamp_store(dev, attr, buf, count, 0);
> >  };
> >
> > +static ssize_t timestamp1_store(struct device *dev,
> > +                               struct device_attribute *attr,
> > +                               const char *buf, size_t count)
> > +{
> > +       return timestamp_store(dev, attr, buf, count, 1);
> > +};
> > +
> > +static ssize_t timestamp2_store(struct device *dev,
> > +                               struct device_attribute *attr,
> > +                               const char *buf, size_t count)
> > +{
> > +       return timestamp_store(dev, attr, buf, count, 2);
> > +};
> > +
> > +static ssize_t timestamp3_store(struct device *dev,
> > +                               struct device_attribute *attr,
> > +                               const char *buf, size_t count)
> > +{
> > +       return timestamp_store(dev, attr, buf, count, 3);
> > +};
> > +
> >  static ssize_t timestamp_show(struct device *dev,
> >                               struct device_attribute *attr, char *buf,
> >                               int ts_id)
> > @@ -714,16 +831,46 @@ static ssize_t timestamp0_show(struct device *dev,
> >         return timestamp_show(dev, attr, buf, 0);
> >  };
> >
> > +static ssize_t timestamp1_show(struct device *dev,
> > +                              struct device_attribute *attr, char *buf)
> > +{
> > +       return timestamp_show(dev, attr, buf, 1);
> > +};
> > +
> > +static ssize_t timestamp2_show(struct device *dev,
> > +                              struct device_attribute *attr, char *buf)
> > +{
> > +       return timestamp_show(dev, attr, buf, 2);
> > +};
> > +
> > +static ssize_t timestamp3_show(struct device *dev,
> > +                              struct device_attribute *attr, char *buf)
> > +{
> > +       return timestamp_show(dev, attr, buf, 3);
> > +};
> > +
> >  static DEVICE_ATTR_RW(timestamp0);
> > +static DEVICE_ATTR_RW(timestamp1);
> > +static DEVICE_ATTR_RW(timestamp2);
> > +static DEVICE_ATTR_RW(timestamp3);
> >
> >  static struct attribute *pcf2127_attrs[] = {
> >         &dev_attr_timestamp0.attr,
> >         NULL
> >  };
> >
> > +static struct attribute *pcf2131_attrs[] = {
> > +       &dev_attr_timestamp0.attr,
> > +       &dev_attr_timestamp1.attr,
> > +       &dev_attr_timestamp2.attr,
> > +       &dev_attr_timestamp3.attr,
> > +       NULL
> > +};
> > +
> >  enum pcf21xx_type {
> >         PCF2127,
> >         PCF2129,
> > +       PCF2131,
> >         PCF21XX_LAST_ID
> >  };
> >
> > @@ -774,6 +921,48 @@ static struct pcf21xx_config pcf21xx_cfg[] = {
> >                         .attrs  = pcf2127_attrs,
> >                 },
> >         },
> > +       [PCF2131] = {
> > +               .max_register = 0x36,
> > +               .has_nvmem = 0,
> > +               .has_bit_wd_ctl_cd0 = 0,
> > +               .regs_td_base = PCF2131_REG_TIME_DATE_BASE,
> > +               .regs_alarm_base = PCF2131_REG_ALARM_BASE,
> > +               .reg_wd_ctl = PCF2131_REG_WD_CTL,
> > +               .reg_wd_val = PCF2131_REG_WD_VAL,
> > +               .reg_clkout = PCF2131_REG_CLKOUT,
> > +               .ts_count = 4,
> > +               .ts[0] = {
> > +                       .regs_base = PCF2131_REG_TS1_BASE,
> > +                       .low_reg   = PCF2131_REG_CTRL4,
> > +                       .low_bit   = PCF2131_BIT_CTRL4_TSF1,
> 
> Set .inter_bit to 0 as it's used/read in timestamp_store() to
> control flow in if-condition.

Done for all 4 ts[] structures.


> 
> > +                       .ie_reg    = PCF2131_REG_CTRL5,
> > +                       .ie_bit    = PCF2131_BIT_CTRL5_TSIE1,
> > +               },
> > +               .ts[1] = {
> > +                       .regs_base = PCF2131_REG_TS2_BASE,
> > +                       .low_reg   = PCF2131_REG_CTRL4,
> > +                       .low_bit   = PCF2131_BIT_CTRL4_TSF2,
> > +                       .ie_reg    = PCF2131_REG_CTRL5,
> > +                       .ie_bit    = PCF2131_BIT_CTRL5_TSIE2,
> > +               },
> > +               .ts[2] = {
> > +                       .regs_base = PCF2131_REG_TS3_BASE,
> > +                       .low_reg   = PCF2131_REG_CTRL4,
> > +                       .low_bit   = PCF2131_BIT_CTRL4_TSF3,
> > +                       .ie_reg    = PCF2131_REG_CTRL5,
> > +                       .ie_bit    = PCF2131_BIT_CTRL5_TSIE3,
> > +               },
> > +               .ts[3] = {
> > +                       .regs_base = PCF2131_REG_TS4_BASE,
> > +                       .low_reg   = PCF2131_REG_CTRL4,
> > +                       .low_bit   = PCF2131_BIT_CTRL4_TSF4,
> > +                       .ie_reg    = PCF2131_REG_CTRL5,
> > +                       .ie_bit    = PCF2131_BIT_CTRL5_TSIE4,
> > +               },
> > +               .attribute_group = {
> > +                       .attrs  = pcf2131_attrs,
> > +               },
> > +       },
> >  };
> >
> >  /*
> > @@ -922,7 +1111,7 @@ static int pcf2127_probe(struct device *dev, struct regmap *regmap,
> >          * Watchdog timer enabled and reset pin /RST activated when timed out.
> >          * Select 1Hz clock source for watchdog timer.
> >          * Note: Countdown timer disabled and not available.
> > -        * For pca2129, pcf2129, only bit[7] is for Symbol WD_CD
> > +        * For pca2129, pcf2129 and pcf2131, only bit[7] is for Symbol WD_CD
> >          * of register watchdg_tim_ctl. The bit[6] is labeled
> >          * as T. Bits labeled as T must always be written with
> >          * logic 0.
> > @@ -982,6 +1171,7 @@ static const struct of_device_id pcf2127_of_match[] = {
> >         { .compatible = "nxp,pcf2127", .data = &pcf21xx_cfg[PCF2127] },
> >         { .compatible = "nxp,pcf2129", .data = &pcf21xx_cfg[PCF2129] },
> >         { .compatible = "nxp,pca2129", .data = &pcf21xx_cfg[PCF2129] },
> > +       { .compatible = "nxp,pcf2131", .data = &pcf21xx_cfg[PCF2131] },
> >         {}
> >  };
> >  MODULE_DEVICE_TABLE(of, pcf2127_of_match);
> > @@ -1069,6 +1259,7 @@ static const struct i2c_device_id pcf2127_i2c_id[] = {
> >         { "pcf2127", PCF2127 },
> >         { "pcf2129", PCF2129 },
> >         { "pca2129", PCF2129 },
> > +       { "pcf2131", PCF2131 },
> >         { }
> >  };
> >  MODULE_DEVICE_TABLE(i2c, pcf2127_i2c_id);
> > @@ -1190,6 +1381,7 @@ static const struct spi_device_id pcf2127_spi_id[] = {
> >         { "pcf2127", PCF2127 },
> >         { "pcf2129", PCF2129 },
> >         { "pca2129", PCF2129 },
> > +       { "pcf2131", PCF2131 },
> >         { }
> >  };
> >  MODULE_DEVICE_TABLE(spi, pcf2127_spi_id);
> > @@ -1254,5 +1446,5 @@ static void __exit pcf2127_exit(void)
> >  module_exit(pcf2127_exit)
> >
> >  MODULE_AUTHOR("Renaud Cerrato <r.cerrato@til-technologies.fr>");
> > -MODULE_DESCRIPTION("NXP PCF2127/29 RTC driver");
> > +MODULE_DESCRIPTION("NXP PCF2127/29/31 RTC driver");
> >  MODULE_LICENSE("GPL v2");
> > --
> > 2.30.2
> >
> 


-- 
Hugo Villeneuve <hugo@hugovil.com>

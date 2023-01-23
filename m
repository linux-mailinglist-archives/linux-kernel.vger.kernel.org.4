Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38D28678316
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 18:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233717AbjAWR1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 12:27:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233653AbjAWR1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 12:27:16 -0500
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11CF32F7A3;
        Mon, 23 Jan 2023 09:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:Mime-Version:
        References:In-Reply-To:Message-Id:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=GrRBC1CSAlithprtwej5NYCZ2OlzkUl1j98wc+4lZwY=; b=LVDpAnzgtGPq/GZ9BdcOiXvctk
        KAlJiWkxeLcKGwTZNIkwqL9ALbU2sodwL0GLnEGdmwEVtWMqPKeEEscI+ZLHu5c9InnCukAXDhgH5
        LFn8VykDyBdqG3eR6uasTMTrD8Jb+8+/HtBEEP0M+rAW6y5O4wwUnGMtlxRRJLFPw2q0=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:41492 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1pK0az-0002xt-FZ; Mon, 23 Jan 2023 12:27:02 -0500
Date:   Mon, 23 Jan 2023 12:27:01 -0500
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     a.zummo@towertech.it, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
Message-Id: <20230123122701.1548311030689f85b733fcbb@hugovil.com>
In-Reply-To: <Y8rkA/N6RqSzgXpt@mail.local>
References: <20221215150214.1109074-1-hugo@hugovil.com>
        <20221215150214.1109074-8-hugo@hugovil.com>
        <Y8rkA/N6RqSzgXpt@mail.local>
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

On Fri, 20 Jan 2023 19:57:07 +0100
Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:

> On 15/12/2022 10:02:08-0500, Hugo Villeneuve wrote:
> >  	  PCF2127 has an additional feature of 512 bytes battery backed
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
> 
> For the record, I don't really like that because git will be the
> authoritative source for the copyright. This will only end up being
> outdated info (as it is already)

Removed.

> 
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
> 
> This will never be added so I would remove that comment

Done.

> 
> >   */
> >  
> >  #include <linux/i2c.h>
> > @@ -43,8 +53,30 @@
> >  #define PCF2127_BIT_CTRL3_BLF			BIT(2)
> >  #define PCF2127_BIT_CTRL3_BF			BIT(3)
> >  #define PCF2127_BIT_CTRL3_BTSE			BIT(4)
> > +/* Control register 4 */
> > +#define PCF2131_REG_CTRL4		0x03
> > +#define PCF2131_BIT_CTRL4_TSF4			BIT(4)
> > +#define PCF2131_BIT_CTRL4_TSF3			BIT(5)
> > +#define PCF2131_BIT_CTRL4_TSF2			BIT(6)
> > +#define PCF2131_BIT_CTRL4_TSF1			BIT(7)
> > +/* Control register 5 */
> > +#define PCF2131_REG_CTRL5		0x04
> > +#define PCF2131_BIT_CTRL5_TSIE4			BIT(4)
> > +#define PCF2131_BIT_CTRL5_TSIE3			BIT(5)
> > +#define PCF2131_BIT_CTRL5_TSIE2			BIT(6)
> > +#define PCF2131_BIT_CTRL5_TSIE1			BIT(7)
> > +/* Software reset register */
> > +#define PCF2131_REG_SR_RESET		0x05
> > +#define PCF2131_SR_RESET_READ_PATTERN	0b00100100 /* Fixed pattern. */
> > +#define PCF2131_SR_RESET_RESET_CMD	0x2C /* SR is bit 3. */
> >  /* Time and date registers */
> >  #define PCF2127_REG_TIME_DATE_BASE	0x03
> > +#define PCF2131_REG_TIME_DATE_BASE	0x07 /* Register 0x06 is 100th seconds,
> > +					      * but we do not support it. By
> > +					      * using offset 0x07, we can be
> > +					      * compatible with existing
> > +					      * time/date functions.
> > +					      */
> 
> Because we will never support 100th of seconds, this comment is not
> useful

Removed.

> 
> >  /* Time and date registers offsets (starting from base register) */
> >  #define PCF2127_OFFSET_TD_SC		0
> >  #define PCF2127_OFFSET_TD_MN		1
> > @@ -57,6 +89,7 @@
> >  #define PCF2127_BIT_SC_OSF			BIT(7)
> >  /* Alarm registers */
> >  #define PCF2127_REG_ALARM_BASE		0x0A
> > +#define PCF2131_REG_ALARM_BASE		0x0E
> 
> I'd keep the defines ordered by address, so you could move all the
> PCF2131 defines after the PCF2127 ones

Done.


> 
> >  /* Alarm registers offsets (starting from base register) */
> >  #define PCF2127_OFFSET_ALARM_SC		0
> >  #define PCF2127_OFFSET_ALARM_MN		1
> > @@ -67,16 +100,26 @@
> >  #define PCF2127_BIT_ALARM_AE			BIT(7)
> >  /* CLKOUT control register */
> >  #define PCF2127_REG_CLKOUT		0x0f
> > +#define PCF2131_REG_CLKOUT		0x13
> >  #define PCF2127_BIT_CLKOUT_OTPR			BIT(5)
> >  /* Watchdog registers */
> >  #define PCF2127_REG_WD_CTL		0x10
> > +#define PCF2131_REG_WD_CTL		0x35
> >  #define PCF2127_BIT_WD_CTL_TF0			BIT(0)
> >  #define PCF2127_BIT_WD_CTL_TF1			BIT(1)
> >  #define PCF2127_BIT_WD_CTL_CD0			BIT(6)
> >  #define PCF2127_BIT_WD_CTL_CD1			BIT(7)
> >  #define PCF2127_REG_WD_VAL		0x11
> > +#define PCF2131_REG_WD_VAL		0x36
> >  /* Tamper timestamp1 registers */
> >  #define PCF2127_REG_TS1_BASE		0x12
> > +#define PCF2131_REG_TS1_BASE		0x14
> > +/* Tamper timestamp2 registers */
> > +#define PCF2131_REG_TS2_BASE		0x1B
> > +/* Tamper timestamp3 registers */
> > +#define PCF2131_REG_TS3_BASE		0x22
> > +/* Tamper timestamp4 registers */
> > +#define PCF2131_REG_TS4_BASE		0x29
> >  /* Tamper timestamp registers common offsets (starting from base register) */
> >  #define PCF2127_OFFSET_TS_CTL		0
> >  #define PCF2127_OFFSET_TS_SC		1
> > @@ -92,11 +135,22 @@
> >   * RAM registers
> >   * PCF2127 has 512 bytes general-purpose static RAM (SRAM) that is
> >   * battery backed and can survive a power outage.
> > - * PCF2129 doesn't have this feature.
> > + * PCF2129/31 doesn't have this feature.
> >   */
> >  #define PCF2127_REG_RAM_ADDR_MSB	0x1A
> >  #define PCF2127_REG_RAM_WRT_CMD		0x1C
> >  #define PCF2127_REG_RAM_RD_CMD		0x1D
> > +/* Interrupt mask registers */
> > +#define PCF2131_REG_INT_A_MASK1		0x31
> > +#define PCF2131_REG_INT_A_MASK2		0x32
> > +#define PCF2131_REG_INT_B_MASK1		0x33
> > +#define PCF2131_REG_INT_B_MASK2		0x34
> > +#define PCF2131_BIT_INT_BLIE		BIT(0)
> > +#define PCF2131_BIT_INT_BIE		BIT(1)
> > +#define PCF2131_BIT_INT_AIE		BIT(2)
> > +#define PCF2131_BIT_INT_WD_CD		BIT(3)
> > +#define PCF2131_BIT_INT_SI		BIT(4)
> > +#define PCF2131_BIT_INT_MI		BIT(5)
> >  
> >  /* Watchdog timer value constants */
> >  #define PCF2127_WD_VAL_STOP		0
> > @@ -110,6 +164,14 @@
> >  		PCF2127_BIT_CTRL2_AF | \
> >  		PCF2127_BIT_CTRL2_WDTF | \
> >  		PCF2127_BIT_CTRL2_TSF2)
> > +#define PCF2131_CTRL2_IRQ_MASK ( \
> > +		PCF2127_BIT_CTRL2_AF | \
> > +		PCF2127_BIT_CTRL2_WDTF)
> > +#define PCF2131_CTRL4_IRQ_MASK ( \
> > +		PCF2131_BIT_CTRL4_TSF4 | \
> > +		PCF2131_BIT_CTRL4_TSF3 | \
> > +		PCF2131_BIT_CTRL4_TSF2 | \
> > +		PCF2131_BIT_CTRL4_TSF1)
> >  
> >  struct pcf21xx_ts_config {
> >  	u8 regs_base; /* Base register to read timestamp values. */
> > @@ -370,7 +432,7 @@ static int pcf2127_wdt_set_timeout(struct watchdog_device *wdd,
> >  }
> >  
> >  static const struct watchdog_info pcf2127_wdt_info = {
> > -	.identity = "NXP PCF2127/PCF2129 Watchdog",
> > +	.identity = "NXP PCF2127/29/31 Watchdog",
> 
> This change may break userspace tools as this is exposed to userspace

Ok, removed.


> Alexandre Belloni, co-owner and COO, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

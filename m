Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 107CE67897D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 22:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232387AbjAWVX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 16:23:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbjAWVXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 16:23:55 -0500
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA9830B15;
        Mon, 23 Jan 2023 13:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:Mime-Version:
        References:In-Reply-To:Message-Id:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=17xF72TkOudZ1GH2KkrHuQYUcqBX4WbXM/q285Cqrn4=; b=XnQVbU04G+ibmyCKDQvP0W/GEB
        rihr8unbovHcUxwXBhjEJUVsCn46FK+HKV0ITvrF1CbDz0bfVHFkjz8k2YcDbyMdZZbmJlZ3t+e2v
        oo9rlBLWBPbv206BCcoZFy7MzmIAvU/92OwtsYWKntnyWM/m1NfjN6bToeeOoN9/ZXSY=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:41506 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1pK3qb-0004rC-35; Mon, 23 Jan 2023 15:55:23 -0500
Date:   Mon, 23 Jan 2023 15:55:20 -0500
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Bruno Thomsen <bruno.thomsen@gmail.com>
Cc:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
Message-Id: <20230123155520.22a20149745dcbd536536e8f@hugovil.com>
In-Reply-To: <CAH+2xPBD4ezWPzMj4YzF63duWnw3_af6KkC7eq1EWS=5F_5NGw@mail.gmail.com>
References: <20221215150214.1109074-1-hugo@hugovil.com>
        <20221215150214.1109074-12-hugo@hugovil.com>
        <CAH+2xPBD4ezWPzMj4YzF63duWnw3_af6KkC7eq1EWS=5F_5NGw@mail.gmail.com>
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
Subject: Re: [PATCH v3 11/14] rtc: pcf2127: adapt time/date registers write
 sequence for PCF2131
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Jan 2023 19:44:23 +0100
Bruno Thomsen <bruno.thomsen@gmail.com> wrote:

> Den tor. 15. dec. 2022 kl. 16.19 skrev Hugo Villeneuve <hugo@hugovil.com>:
> >
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> >
> > The sequence for updating the time/date registers is slightly
> > different between PCF2127/29 and PCF2131.
> >
> > For PCF2127/29, during write operations, the time counting
> > circuits (memory locations 03h through 09h) are automatically blocked.
> >
> > For PCF2131, time/date registers write access requires setting the
> > STOP bit and sending the clear prescaler instruction (CPR). STOP then
> > needs to be released once write operation is completed.
> >
> > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > ---
> >  drivers/rtc/rtc-pcf2127.c | 38 +++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 37 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
> > index e4b78b9c03f9..11fbdab6bf01 100644
> > --- a/drivers/rtc/rtc-pcf2127.c
> > +++ b/drivers/rtc/rtc-pcf2127.c
> > @@ -39,6 +39,7 @@
> >  #define PCF2127_REG_CTRL1              0x00
> >  #define PCF2127_BIT_CTRL1_POR_OVRD             BIT(3)
> >  #define PCF2127_BIT_CTRL1_TSF1                 BIT(4)
> > +#define PCF2127_BIT_CTRL1_STOP                 BIT(5)
> >  /* Control register 2 */
> >  #define PCF2127_REG_CTRL2              0x01
> >  #define PCF2127_BIT_CTRL2_AIE                  BIT(1)
> > @@ -70,6 +71,7 @@
> >  #define PCF2131_REG_SR_RESET           0x05
> >  #define PCF2131_SR_RESET_READ_PATTERN  0b00100100 /* Fixed pattern. */
> >  #define PCF2131_SR_RESET_RESET_CMD     0x2C /* SR is bit 3. */
> > +#define PCF2131_SR_RESET_CPR_CMD       0xA4 /* CPR is bit 7. */
> 
> Replace 0xA4 with (BIT(2) | BIT(5) | BIT(7)) or
> (PCF2131_SR_RESET_READ_PATTERN | BIT(7))

Done.

 
> >  /* Time and date registers */
> >  #define PCF2127_REG_TIME_DATE_BASE     0x03
> >  #define PCF2131_REG_TIME_DATE_BASE     0x07 /* Register 0x06 is 100th seconds,
> > @@ -307,7 +309,31 @@ static int pcf2127_rtc_set_time(struct device *dev, struct rtc_time *tm)
> >         /* year */
> >         buf[i++] = bin2bcd(tm->tm_year - 100);
> >
> > -       /* write register's data */
> > +       /* Write access to time registers:
> > +        * PCF2127/29: no special action required.
> > +        * PCF2131:    requires setting the STOP bit. STOP bit needs to
> > +        *             be cleared after time registers are updated.
> > +        *             It is also recommended to set CPR bit, although
> > +        *             write access will work without it.
> > +        */
> > +       if (pcf2127->cfg->has_reset_reg) {
> > +               err = regmap_update_bits(pcf2127->regmap, PCF2127_REG_CTRL1,
> > +                                        PCF2127_BIT_CTRL1_STOP,
> > +                                        PCF2127_BIT_CTRL1_STOP);
> > +               if (err) {
> > +                       dev_err(dev, "setting STOP bit failed\n");
> > +                       return err;
> > +               }
> > +
> > +               err = regmap_write(pcf2127->regmap, pcf2127->cfg->reg_reset,
> > +                                  PCF2131_SR_RESET_CPR_CMD);
> > +               if (err) {
> > +                       dev_err(dev, "sending CPR cmd failed\n");
> > +                       return err;
> > +               }
> > +       }
> > +
> > +       /* write time register's data */
> >         err = regmap_bulk_write(pcf2127->regmap, pcf2127->cfg->regs_td_base, buf, i);
> >         if (err) {
> >                 dev_err(dev,
> > @@ -315,6 +341,16 @@ static int pcf2127_rtc_set_time(struct device *dev, struct rtc_time *tm)
> >                 return err;
> >         }
> >
> > +       if (pcf2127->cfg->has_reset_reg) {
> > +               /* Clear STOP bit (PCF2131 only) after write is completed. */
> > +               err = regmap_update_bits(pcf2127->regmap, PCF2127_REG_CTRL1,
> > +                                        PCF2127_BIT_CTRL1_STOP, 0);
> > +               if (err) {
> > +                       dev_err(dev, "clearing STOP bit failed\n");
> > +                       return err;
> > +               }
> > +       }
> > +
> >         return 0;
> >  }
> >
> > --
> > 2.30.2
> >
> 


-- 
Hugo Villeneuve <hugo@hugovil.com>

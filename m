Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9ED7739029
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 21:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbjFUTgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 15:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjFUTgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 15:36:19 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129B71989;
        Wed, 21 Jun 2023 12:36:15 -0700 (PDT)
X-GND-Sasl: alexandre.belloni@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1687376174;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t2IbrcNzQNr/fmkdLl77sKepHEuqtDNp0dRZtoi2jnM=;
        b=Je/33w7wN8peztYmhMOKG59d4LYTqq9ZW6pXS5GVcPdtjGF596LGjli5jIjbW+5wTS7tM1
        n4ExkXx2NkcsmkBnlicRXMFp7QydUJ3fTUOQPY36vtUpY3NNTQ4iH2NQCuUI2Fp4CnOTB5
        UPDuvfZYRHB+xVaTnj3lKZEMzGT2LoRp/HZ/bRYSI0l3tsiVilZg8ANY/39JZ2Zk8jLtqZ
        wocgzy0mF7IZkSV/BH306ZpZE0zJWURZ8hHr8Lc/VwsDLBexUT+81LVl2esJ1uhdcMfMOj
        YErVFYxSUCgAzxGVbvDUVxqM1LGPbfSuNeiwPf6LybkkRn9DazvOqKeXtrI7WA==
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CCE3C1BF204;
        Wed, 21 Jun 2023 19:36:13 +0000 (UTC)
Date:   Wed, 21 Jun 2023 21:36:13 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     a.zummo@towertech.it, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH v3 11/14] rtc: pcf2127: adapt time/date registers write
 sequence for PCF2131
Message-ID: <20230621193613d25ceb92@mail.local>
References: <20221215150214.1109074-1-hugo@hugovil.com>
 <20221215150214.1109074-12-hugo@hugovil.com>
 <Y8rK1dgpNJaSy/Gb@mail.local>
 <20230123165741.b7c93d439841860f4ab9b0c8@hugovil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123165741.b7c93d439841860f4ab9b0c8@hugovil.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/01/2023 16:57:41-0500, Hugo Villeneuve wrote:
> On Fri, 20 Jan 2023 18:09:41 +0100
> Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:
> 
> > On 15/12/2022 10:02:12-0500, Hugo Villeneuve wrote:
> > > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > > 
> > > The sequence for updating the time/date registers is slightly
> > > different between PCF2127/29 and PCF2131.
> > > 
> > > For PCF2127/29, during write operations, the time counting
> > > circuits (memory locations 03h through 09h) are automatically blocked.
> > > 
> > > For PCF2131, time/date registers write access requires setting the
> > > STOP bit and sending the clear prescaler instruction (CPR). STOP then
> > > needs to be released once write operation is completed.
> > > 
> > > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > > ---
> > >  drivers/rtc/rtc-pcf2127.c | 38 +++++++++++++++++++++++++++++++++++++-
> > >  1 file changed, 37 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
> > > index e4b78b9c03f9..11fbdab6bf01 100644
> > > --- a/drivers/rtc/rtc-pcf2127.c
> > > +++ b/drivers/rtc/rtc-pcf2127.c
> > > @@ -39,6 +39,7 @@
> > >  #define PCF2127_REG_CTRL1		0x00
> > >  #define PCF2127_BIT_CTRL1_POR_OVRD		BIT(3)
> > >  #define PCF2127_BIT_CTRL1_TSF1			BIT(4)
> > > +#define PCF2127_BIT_CTRL1_STOP			BIT(5)
> > >  /* Control register 2 */
> > >  #define PCF2127_REG_CTRL2		0x01
> > >  #define PCF2127_BIT_CTRL2_AIE			BIT(1)
> > > @@ -70,6 +71,7 @@
> > >  #define PCF2131_REG_SR_RESET		0x05
> > >  #define PCF2131_SR_RESET_READ_PATTERN	0b00100100 /* Fixed pattern. */
> > >  #define PCF2131_SR_RESET_RESET_CMD	0x2C /* SR is bit 3. */
> > > +#define PCF2131_SR_RESET_CPR_CMD	0xA4 /* CPR is bit 7. */
> > >  /* Time and date registers */
> > >  #define PCF2127_REG_TIME_DATE_BASE	0x03
> > >  #define PCF2131_REG_TIME_DATE_BASE	0x07 /* Register 0x06 is 100th seconds,
> > > @@ -307,7 +309,31 @@ static int pcf2127_rtc_set_time(struct device *dev, struct rtc_time *tm)
> > >  	/* year */
> > >  	buf[i++] = bin2bcd(tm->tm_year - 100);
> > >  
> > > -	/* write register's data */
> > > +	/* Write access to time registers:
> > > +	 * PCF2127/29: no special action required.
> > > +	 * PCF2131:    requires setting the STOP bit. STOP bit needs to
> > > +	 *             be cleared after time registers are updated.
> > > +	 *             It is also recommended to set CPR bit, although
> > > +	 *             write access will work without it.
> > > +	 */
> > > +	if (pcf2127->cfg->has_reset_reg) {
> > 
> > This should probably be tied to the actual rtc model rather than the
> > presence of the reset register.
> > You MUST clear CPR to be able to set the time precisely.
> 
> In fact you must actually SET the CPR bit to clear the prescaler, confusing!
> 
> I was already setting the CPR bit (clearing prescaler), so I modified the confusing comment.
> 
> The CPR bit is only present IF the reset register is also present, that is why I simply used the presence of the reset register to take the correct action. This avoids to define a new bit or matching on a device model for that functionality (adding newer models could potentially mean modifying the model match).
> 
> But if you absolutely want to match on the model, I would like to know how you would like to practically do it (maybe an example)?
> 

You can keep pcf21xx_type around, in pcf21xx_config for example.

> 
> 
> > 
> > > +		err = regmap_update_bits(pcf2127->regmap, PCF2127_REG_CTRL1,
> > > +					 PCF2127_BIT_CTRL1_STOP,
> > > +					 PCF2127_BIT_CTRL1_STOP);
> > > +		if (err) {
> > > +			dev_err(dev, "setting STOP bit failed\n");
> > 
> > This really needs to be less verbose. There is nothing a user can really
> > do after having seen this message. Having an error in userspace will
> > anyway prompt the user to retry the operation which is the only action
> > it can do.
> 
> I converted the dev_err messages to dev_dbg.
> 
> In the original driver and in the same function, there is also a dev_err to handle regmap_bulk_write() failure. Do you suggest that we also make it less verbose:
> 
> err = regmap_bulk_write(pcf2127->regmap, pcf2127->cfg->reg_time_base, buf, i);
>  	if (err) {
>  		dev_err(dev,
> 
> ???

yes, you can remove it as part of your previous patches.

> 
> 
> > > +			return err;
> > > +		}
> > > +
> > > +		err = regmap_write(pcf2127->regmap, pcf2127->cfg->reg_reset,
> > > +				   PCF2131_SR_RESET_CPR_CMD);
> > > +		if (err) {
> > > +			dev_err(dev, "sending CPR cmd failed\n");
> > > +			return err;
> > > +		}
> > > +	}
> > > +
> > > +	/* write time register's data */
> > >  	err = regmap_bulk_write(pcf2127->regmap, pcf2127->cfg->regs_td_base, buf, i);
> > >  	if (err) {
> > >  		dev_err(dev,
> > > @@ -315,6 +341,16 @@ static int pcf2127_rtc_set_time(struct device *dev, struct rtc_time *tm)
> > >  		return err;
> > >  	}
> > >  
> > > +	if (pcf2127->cfg->has_reset_reg) {
> > > +		/* Clear STOP bit (PCF2131 only) after write is completed. */
> > > +		err = regmap_update_bits(pcf2127->regmap, PCF2127_REG_CTRL1,
> > > +					 PCF2127_BIT_CTRL1_STOP, 0);
> > > +		if (err) {
> > > +			dev_err(dev, "clearing STOP bit failed\n");
> > > +			return err;
> > > +		}
> > > +	}
> > > +
> > >  	return 0;
> > >  }
> > >  
> > > -- 
> > > 2.30.2
> > > 
> > 
> > -- 
> > Alexandre Belloni, co-owner and COO, Bootlin
> > Embedded Linux and Kernel engineering
> > https://bootlin.com
> > 
> 
> 
> -- 
> Hugo Villeneuve <hugo@hugovil.com>

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

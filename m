Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C832E6B80E8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 19:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbjCMSlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 14:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbjCMSlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 14:41:32 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392F4BDED;
        Mon, 13 Mar 2023 11:40:52 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 27EC2C0004;
        Mon, 13 Mar 2023 18:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1678732717;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k1+MjdmXNuTv59ueGFw6eLAhE82WHrOY9UQ4cRVrTxE=;
        b=U11sgBJ84Y3UqG8M+uI5dRdBBgItHWoEyPo/yvkqBz7/hJxhN5lSqulrBPGw6foGEdCeOW
        tnt7mJPOoxeiSDcaqHO9j1cu/XSCBwwElyuIaloDg3Oi1dQn+Hm7VKTbEPYd0I0kwdOcZ6
        R8zNcbAvgoo/1utb5R+VtZqPCygFwSe+XcvcmOEmJazKFvlHcgKBSPnSsAFrC92s+3F1MG
        ja1+oDf2YWU6DJb1J4TYtBlRMjUaaOamsXER5iEYUXCeTEsIaSGqnsyx9SRd/FpSDQaFNv
        K/GwKkhQN4K4RSKhwcdRgKvRyDCw7A/wiN+ehqdTzLCOCOG4/hz6XM2iVIVx7A==
Date:   Mon, 13 Mar 2023 19:38:36 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Sean Anderson <sean.anderson@seco.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] rtc: abx80x: Add nvmem support
Message-ID: <20230313183836e276d826@mail.local>
References: <20221222214532.1873718-1-sean.anderson@seco.com>
 <e029e39b-196d-ee4b-318d-6dc950b2b26c@seco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e029e39b-196d-ee4b-318d-6dc950b2b26c@seco.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/03/2023 11:28:30-0400, Sean Anderson wrote:
> On 12/22/22 16:45, Sean Anderson wrote:
> > This adds support for the 256-byte internal RAM. There are two windows
> > which can be used to access this RAM: 64 bytes at 0x40 (the "standard"
> > address space) and 128 bytes at 0x80 (the "alternate" address space). We
> > use the standard address space because it is also accessible over SPI
> > (if such a port is ever done). We are limited to 32-byte reads for SMBus
> > compatibility, so there's no advantage to using the alternate address
> > space.
> > 
> > There are some reserved bits in the EXTRAM register, and the datasheet
> > doesn't say what to do with them. I've opted to skip a read/modify/write
> > and just write the whole thing. If this driver is ever converted to
> > regmap, this would be a good place to use regmap_update_bits.
> > 
> > Signed-off-by: Sean Anderson <sean.anderson@seco.com>
> > ---
> > 
> > Changes in v4:
> > - Remove unused variable
> > 
> > Changes in v3:
> > - Use devm_rtc_nvmem_register
> > - Remove ifdefs
> > 
> > Changes in v2:
> > - Fix building on non-arm platforms
> > 
> >  drivers/rtc/rtc-abx80x.c | 77 ++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 77 insertions(+)
> > 
> > diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
> > index 9b0138d07232..74ff820f5481 100644
> > --- a/drivers/rtc/rtc-abx80x.c
> > +++ b/drivers/rtc/rtc-abx80x.c
> > @@ -11,6 +11,7 @@
> >   */
> >  
> >  #include <linux/bcd.h>
> > +#include <linux/bitfield.h>
> >  #include <linux/i2c.h>
> >  #include <linux/module.h>
> >  #include <linux/of_device.h>
> > @@ -87,6 +88,16 @@
> >  #define ABX8XX_TRICKLE_STANDARD_DIODE	0x8
> >  #define ABX8XX_TRICKLE_SCHOTTKY_DIODE	0x4
> >  
> > +#define ABX8XX_REG_EXTRAM	0x3f
> > +#define ABX8XX_EXTRAM_XADS	GENMASK(1, 0)
> > +
> > +#define ABX8XX_SRAM_BASE	0x40
> > +#define ABX8XX_SRAM_WIN_SIZE	0x40
> > +#define ABX8XX_RAM_SIZE		256
> > +
> > +#define NVMEM_ADDR_LOWER	GENMASK(5, 0)
> > +#define NVMEM_ADDR_UPPER	GENMASK(7, 6)
> > +
> >  static u8 trickle_resistors[] = {0, 3, 6, 11};
> >  
> >  enum abx80x_chip {AB0801, AB0803, AB0804, AB0805,
> > @@ -673,6 +684,68 @@ static int abx80x_setup_watchdog(struct abx80x_priv *priv)
> >  }
> >  #endif
> >  
> > +static int abx80x_nvmem_xfer(struct abx80x_priv *priv, unsigned int offset,
> > +			     void *val, size_t bytes, bool write)
> > +{
> > +	int ret;
> > +
> > +	while (bytes) {
> > +		u8 extram, reg, len, lower, upper;
> > +
> > +		lower = FIELD_GET(NVMEM_ADDR_LOWER, offset);
> > +		upper = FIELD_GET(NVMEM_ADDR_UPPER, offset);
> > +		extram = FIELD_PREP(ABX8XX_EXTRAM_XADS, upper);
> > +		reg = ABX8XX_SRAM_BASE + lower;
> > +		len = min(lower + bytes, (size_t)ABX8XX_SRAM_WIN_SIZE) - lower;
> > +		len = min_t(u8, len, I2C_SMBUS_BLOCK_MAX);
> > +
> > +		ret = i2c_smbus_write_byte_data(priv->client, ABX8XX_REG_EXTRAM,
> > +						extram);
> > +		if (ret)
> > +			return ret;
> > +
> > +		if (write)
> > +			ret = i2c_smbus_write_i2c_block_data(priv->client, reg,
> > +							     len, val);
> > +		else
> > +			ret = i2c_smbus_read_i2c_block_data(priv->client, reg,
> > +							    len, val);
> > +		if (ret)
> > +			return ret;
> > +
> > +		offset += len;
> > +		val += len;
> > +		bytes -= len;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int abx80x_nvmem_read(void *priv, unsigned int offset, void *val,
> > +			     size_t bytes)
> > +{
> > +	return abx80x_nvmem_xfer(priv, offset, val, bytes, false);
> > +}
> > +
> > +static int abx80x_nvmem_write(void *priv, unsigned int offset, void *val,
> > +			      size_t bytes)
> > +{
> > +	return abx80x_nvmem_xfer(priv, offset, val, bytes, true);
> > +}
> > +
> > +static int abx80x_setup_nvmem(struct abx80x_priv *priv)
> > +{
> > +	struct nvmem_config config = {
> > +		.type = NVMEM_TYPE_BATTERY_BACKED,
> > +		.reg_read = abx80x_nvmem_read,
> > +		.reg_write = abx80x_nvmem_write,
> > +		.size = ABX8XX_RAM_SIZE,
> > +		.priv = priv,
> > +	};
> > +
> > +	return devm_rtc_nvmem_register(priv->rtc, &config);
> > +}
> > +
> >  static int abx80x_probe(struct i2c_client *client,
> >  			const struct i2c_device_id *id)
> >  {
> > @@ -824,6 +897,10 @@ static int abx80x_probe(struct i2c_client *client,
> >  			return err;
> >  	}
> >  
> > +	err = abx80x_setup_nvmem(priv);
> > +	if (err)
> > +		return err;
> > +
> >  	if (client->irq > 0) {
> >  		dev_info(&client->dev, "IRQ %d supplied\n", client->irq);
> >  		err = devm_request_threaded_irq(&client->dev, client->irq, NULL,
> 
> ping?

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/rtc/rtc-abx80x.c?id=e90ff8ede777b98b44611b416b1ae6be94258335

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17AB5675AD0
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 18:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbjATRJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 12:09:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjATRJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 12:09:46 -0500
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75625E518;
        Fri, 20 Jan 2023 09:09:43 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id D7796240002;
        Fri, 20 Jan 2023 17:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1674234582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=myWp3hlcHqqlVGQIEKVfM20rsbgiVRXVUPlmU3K+WOw=;
        b=jsyYQJeiEdwD+RZBwAW0I/DLh+supNvKpJ3c/Lj2Vm769a3dAUofgNr0XTPYG08w0HX4Rk
        NqLHErXQggJd3motE2lTEJ7FSmLcS4sZzxbiYTBZQxmPbkFDKl4+IVXExmK89ZBsqkZuXW
        nwzyj30HRlfate0730Bqf5HE4ex0Vg/Ves/VKTY9qa0anXfLKcQLQ0jeoF5OW2AOVfwfpJ
        HcYHWkOaFhURq+3KlBuX3dtnq1WZOrCp9J6+E8MvhmQxQIS6er+fhWNyIWWv5c4OqfzTDv
        ic82FdLizcDTz8rLBDIhZJXsPVZxOlUNcAj99lpIj6GWZt1UbmeAbPKEKXCdYA==
Date:   Fri, 20 Jan 2023 18:09:41 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     a.zummo@towertech.it, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH v3 11/14] rtc: pcf2127: adapt time/date registers write
 sequence for PCF2131
Message-ID: <Y8rK1dgpNJaSy/Gb@mail.local>
References: <20221215150214.1109074-1-hugo@hugovil.com>
 <20221215150214.1109074-12-hugo@hugovil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221215150214.1109074-12-hugo@hugovil.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/12/2022 10:02:12-0500, Hugo Villeneuve wrote:
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
>  #define PCF2127_REG_CTRL1		0x00
>  #define PCF2127_BIT_CTRL1_POR_OVRD		BIT(3)
>  #define PCF2127_BIT_CTRL1_TSF1			BIT(4)
> +#define PCF2127_BIT_CTRL1_STOP			BIT(5)
>  /* Control register 2 */
>  #define PCF2127_REG_CTRL2		0x01
>  #define PCF2127_BIT_CTRL2_AIE			BIT(1)
> @@ -70,6 +71,7 @@
>  #define PCF2131_REG_SR_RESET		0x05
>  #define PCF2131_SR_RESET_READ_PATTERN	0b00100100 /* Fixed pattern. */
>  #define PCF2131_SR_RESET_RESET_CMD	0x2C /* SR is bit 3. */
> +#define PCF2131_SR_RESET_CPR_CMD	0xA4 /* CPR is bit 7. */
>  /* Time and date registers */
>  #define PCF2127_REG_TIME_DATE_BASE	0x03
>  #define PCF2131_REG_TIME_DATE_BASE	0x07 /* Register 0x06 is 100th seconds,
> @@ -307,7 +309,31 @@ static int pcf2127_rtc_set_time(struct device *dev, struct rtc_time *tm)
>  	/* year */
>  	buf[i++] = bin2bcd(tm->tm_year - 100);
>  
> -	/* write register's data */
> +	/* Write access to time registers:
> +	 * PCF2127/29: no special action required.
> +	 * PCF2131:    requires setting the STOP bit. STOP bit needs to
> +	 *             be cleared after time registers are updated.
> +	 *             It is also recommended to set CPR bit, although
> +	 *             write access will work without it.
> +	 */
> +	if (pcf2127->cfg->has_reset_reg) {

This should probably be tied to the actual rtc model rather than the
presence of the reset register.
You MUST clear CPR to be able to set the time precisely.

> +		err = regmap_update_bits(pcf2127->regmap, PCF2127_REG_CTRL1,
> +					 PCF2127_BIT_CTRL1_STOP,
> +					 PCF2127_BIT_CTRL1_STOP);
> +		if (err) {
> +			dev_err(dev, "setting STOP bit failed\n");

This really needs to be less verbose. There is nothing a user can really
do after having seen this message. Having an error in userspace will
anyway prompt the user to retry the operation which is the only action
it can do.

> +			return err;
> +		}
> +
> +		err = regmap_write(pcf2127->regmap, pcf2127->cfg->reg_reset,
> +				   PCF2131_SR_RESET_CPR_CMD);
> +		if (err) {
> +			dev_err(dev, "sending CPR cmd failed\n");
> +			return err;
> +		}
> +	}
> +
> +	/* write time register's data */
>  	err = regmap_bulk_write(pcf2127->regmap, pcf2127->cfg->regs_td_base, buf, i);
>  	if (err) {
>  		dev_err(dev,
> @@ -315,6 +341,16 @@ static int pcf2127_rtc_set_time(struct device *dev, struct rtc_time *tm)
>  		return err;
>  	}
>  
> +	if (pcf2127->cfg->has_reset_reg) {
> +		/* Clear STOP bit (PCF2131 only) after write is completed. */
> +		err = regmap_update_bits(pcf2127->regmap, PCF2127_REG_CTRL1,
> +					 PCF2127_BIT_CTRL1_STOP, 0);
> +		if (err) {
> +			dev_err(dev, "clearing STOP bit failed\n");
> +			return err;
> +		}
> +	}
> +
>  	return 0;
>  }
>  
> -- 
> 2.30.2
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

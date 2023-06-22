Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC13273982F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 09:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjFVHfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 03:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjFVHfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 03:35:03 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F02781992;
        Thu, 22 Jun 2023 00:35:00 -0700 (PDT)
X-GND-Sasl: alexandre.belloni@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1687419299;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fjdI8hAWq8rRbopuLAzW8xGOPk9XesOe6kfQHrFp7GY=;
        b=BQE82NsrS8NeEQAYG+vpPyS2ZyKfdgdGzizBBatseeR6pqop6UvHtR3dRMldKcmwrRARvD
        HbU411bxng9hD83QWODyC9QFsvicyEANhFHHD6vY2rMn9jNxBpTzWCG7lovKfm9lYJ4PrC
        KEywegX+HSatfXBzzCeUmnTsaC9Ph0i8WlCYmSPC0GiDe0Dk43T9mvCIhLFsR1EifXPhLn
        vu76MMHxCSgp/+53+/Q5V1B2BL/7dSB1rwVQDAnSg5ZNo0mtNQi3ABKkiYatD85c4+vMkM
        VfYob9ubzxYkRzW/W/q0ghtxsP6S6D8wrc5S4idzYGNPgBbOqkYEgRQDbEIVUg==
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2A40860011;
        Thu, 22 Jun 2023 07:34:59 +0000 (UTC)
Date:   Thu, 22 Jun 2023 09:34:58 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Andrej Picej <andrej.picej@norik.com>
Cc:     a.zummo@towertech.it, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, upstream@phytec.de
Subject: Re: [PATCH v2] rtc: rv3028: Improve trickle charger logic
Message-ID: <20230622073458dcd9f636@mail.local>
References: <20230622071609.4032736-1-andrej.picej@norik.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230622071609.4032736-1-andrej.picej@norik.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/06/2023 09:16:09+0200, Andrej Picej wrote:
> Property "trickle-resistor-ohms" allows us to set trickle charger
> resistor. However there is no possibility to disable it afterwards.
> 
> From now on, disable trickle charger circuit in case device-tree
> property "trickle-resistor-ohms" is set to -1.
> 
> Additionally, lets make sure we only update internal EEPROM in case of a
> change. This prevents wear due to excessive EEPROM writes on each probe.
> 
> Signed-off-by: Andrej Picej <andrej.picej@norik.com>
> ---
> Changes in v2:
> - disable trickle charger if device tree property trickle-resistor-ohms
>   is set to -1.

What about using aux-voltage-chargeable which is the generic property
for this?

> ---
>  drivers/rtc/rtc-rv3028.c | 45 +++++++++++++++++++++++++++++-----------
>  1 file changed, 33 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-rv3028.c b/drivers/rtc/rtc-rv3028.c
> index ec5d7a614e2d..da2ae81fe7c8 100644
> --- a/drivers/rtc/rtc-rv3028.c
> +++ b/drivers/rtc/rtc-rv3028.c
> @@ -859,7 +859,8 @@ static int rv3028_probe(struct i2c_client *client)
>  {
>  	struct rv3028_data *rv3028;
>  	int ret, status;
> -	u32 ohms;
> +	s32 ohms;
> +	int val_old, val;
>  	struct nvmem_config nvmem_cfg = {
>  		.name = "rv3028_nvram",
>  		.word_size = 1,
> @@ -937,22 +938,42 @@ static int rv3028_probe(struct i2c_client *client)
>  	if (ret)
>  		return ret;
>  
> -	/* setup trickle charger */
> -	if (!device_property_read_u32(&client->dev, "trickle-resistor-ohms",
> -				      &ohms)) {
> -		int i;
> +	ret = regmap_read(rv3028->regmap, RV3028_BACKUP, &val_old);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* mask out only trickle charger bits */
> +	val_old = val_old & (RV3028_BACKUP_TCE | RV3028_BACKUP_TCR_MASK);
>  
> -		for (i = 0; i < ARRAY_SIZE(rv3028_trickle_resistors); i++)
> -			if (ohms == rv3028_trickle_resistors[i])
> -				break;
> +	/* setup trickle charger */
> +	if (!of_property_read_s32(client->dev.of_node, "trickle-resistor-ohms",
> +				  &ohms)) {
> +		/* disable trickle charger if trickle-resistor-ohms = <(-1)>; */
> +		if (ohms == -1) {
> +			val = val_old & ~RV3028_BACKUP_TCE;
> +		} else {
> +			int i;
> +
> +			for (i = 0; i < ARRAY_SIZE(rv3028_trickle_resistors); i++)
> +				if (ohms == rv3028_trickle_resistors[i])
> +					break;
> +
> +			if (i < ARRAY_SIZE(rv3028_trickle_resistors)) {
> +				/* enable trickle charger and its resistor */
> +				val = RV3028_BACKUP_TCE | i;
> +			} else {
> +				dev_warn(&client->dev, "invalid trickle resistor value\n");
> +				/* don't update the trickle charger regs */
> +				val = val_old;
> +			}
> +		}
>  
> -		if (i < ARRAY_SIZE(rv3028_trickle_resistors)) {
> +		/* only update EEPROM if changes are necessary */
> +		if (val_old != val) {
>  			ret = rv3028_update_cfg(rv3028, RV3028_BACKUP, RV3028_BACKUP_TCE |
> -						 RV3028_BACKUP_TCR_MASK, RV3028_BACKUP_TCE | i);
> +						RV3028_BACKUP_TCR_MASK, val);
>  			if (ret)
>  				return ret;
> -		} else {
> -			dev_warn(&client->dev, "invalid trickle resistor value\n");
>  		}
>  	}
>  
> -- 
> 2.25.1
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

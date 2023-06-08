Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68752727B77
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 11:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235869AbjFHJcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 05:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235920AbjFHJcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 05:32:02 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08BD269F;
        Thu,  8 Jun 2023 02:31:57 -0700 (PDT)
X-GND-Sasl: alexandre.belloni@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686216716;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=boUO7AbfUx/teSNCY9bln7sYeo44GDsRPu688vn24pw=;
        b=YpDUaf0FwhyHopzRCBMN8OjrRv29D11VK93SeAOyi+g/VAotO2gDadMBoBrX1lG6y+IO7J
        Yp8D4O9bJTNfa1okZiK3Cmh6K7d11+rsOP5I7HAop/Qcc/k7SJZCztluSbKCX230EaW6rK
        fd5HASmEM/TNicxW79iLLUKEa6ayVhX4stdjsI+sQV1d7JaOYp+HaYo0YLOGx+Z2M1a8fw
        mEVRrj/cwWKEe0fF+j5e6E+yh3tNjrEiXv2Y5mmg5odxYei/0/wEVjyyazOukeahVgWpHc
        4sFXOIp5qMsKDWewQmyBurpDaop6ZAI/qc4X44SmpC9dmd5Lhd7b9iHMKG2Qtw==
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D156EE0003;
        Thu,  8 Jun 2023 09:31:55 +0000 (UTC)
Date:   Thu, 8 Jun 2023 11:31:55 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Andrej Picej <andrej.picej@norik.com>
Cc:     a.zummo@towertech.it, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, upstream@phytec.de
Subject: Re: [PATCH] rtc: rv3028: Improve trickle charger logic
Message-ID: <20230608093155cedff41a@mail.local>
References: <20230608090446.2899646-1-andrej.picej@norik.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230608090446.2899646-1-andrej.picej@norik.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 08/06/2023 11:04:46+0200, Andrej Picej wrote:
> +	ret = regmap_read(rv3028->regmap, RV3028_BACKUP, &val_old);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* mask out only trickle charger bits */
> +	val_old = val_old & (RV3028_BACKUP_TCE | RV3028_BACKUP_TCR_MASK);
> +
>  	/* setup trickle charger */
> -	if (!device_property_read_u32(&client->dev, "trickle-resistor-ohms",
> -				      &ohms)) {
> +	if (device_property_read_u32(&client->dev, "trickle-resistor-ohms", &ohms)) {
> +		/* disable the trickle charger */
> +		val = 0;

You can't do that, this will break existing users that may set the
trickle charger from their bootloader for example.

> +	} else {
>  		int i;
>  
>  		for (i = 0; i < ARRAY_SIZE(rv3028_trickle_resistors); i++)
> @@ -947,15 +957,21 @@ static int rv3028_probe(struct i2c_client *client)
>  				break;
>  
>  		if (i < ARRAY_SIZE(rv3028_trickle_resistors)) {
> -			ret = rv3028_update_cfg(rv3028, RV3028_BACKUP, RV3028_BACKUP_TCE |
> -						 RV3028_BACKUP_TCR_MASK, RV3028_BACKUP_TCE | i);
> -			if (ret)
> -				return ret;
> +			/* enable the trickle charger and setup its resistor accordingly */
> +			val = RV3028_BACKUP_TCE | i;
>  		} else {
>  			dev_warn(&client->dev, "invalid trickle resistor value\n");
>  		}
>  	}
>  
> +	/* only update EEPROM if changes are necessary */
> +	if (val_old != val) {
> +		ret = rv3028_update_cfg(rv3028, RV3028_BACKUP, RV3028_BACKUP_TCE |
> +					RV3028_BACKUP_TCR_MASK, val);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	ret = rtc_add_group(rv3028->rtc, &rv3028_attr_group);
>  	if (ret)
>  		return ret;
> -- 
> 2.25.1
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

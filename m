Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65575694D96
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 18:03:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjBMRDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 12:03:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjBMRDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 12:03:48 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6BA91BC8;
        Mon, 13 Feb 2023 09:03:45 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 0FDFB1BF204;
        Mon, 13 Feb 2023 17:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1676307823;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g20IozxcPu/cLozwZlBnvYiVCX7Gf7LJ+VUCodqo4Qo=;
        b=Svr+D2e3zApWrdKfaG63ay91RuLQvKIF31fC8jNcY8zj2Rtc6dqCxxxMUGwJ/0jTrusqr/
        899+WlhhOzbG6TvkKEnOFkEDupKUb2ZBRcrLBkMShFFAgqgCk6WJ0jAO3/5bB6vsh2AF76
        +vGpyY1PTCwJNcGriksZ/3ZQ9rXPhhCXtF72jkKtJ6SxXOXIehjrZ3OC0i4QroZD5hiQ9u
        SZg50wozvBI4EVHzcksBmhlCW3CJ5F6n5c5jBqNCaz54zhKOe188RFlEUtgHU1RCDxUC+w
        WtzBPj5twGvpXKX25p3xUJdGR1viMXsWgFHZhk2JDmxzCUcz2Z7d5a3IvKAkMQ==
Date:   Mon, 13 Feb 2023 18:03:42 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Javier Carrasco <javier.carrasco@wolfvision.net>
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Riesch <michael.riesch@wolfvision.net>
Subject: Re: [PATCH 1/2] rtc: pcf85363: add support for the
 quartz-load-femtofarads property
Message-ID: <Y+ptbuZWXrVigvKz@mail.local>
References: <20230213095018.2255225-1-javier.carrasco@wolfvision.net>
 <12dc51e4-622e-4a26-8bde-2795d77ce36e.e0c24246-04d4-485f-8d5f-1cc8fbefd095.f44d6731-6fc0-4ea1-bc6d-c08581fb532e@emailsignatures365.codetwo.com>
 <20230213095018.2255225-2-javier.carrasco@wolfvision.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230213095018.2255225-2-javier.carrasco@wolfvision.net>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/02/2023 10:50:17+0100, Javier Carrasco wrote:
> The quartz oscillator load capacitance of the PCF85263 and PCF85363 can
> be adjusted to 6 pF, 7 pF (default) and 12.5 pF with the CL[1:0] bits in
> the oscillator control register (address 25h).
> 
> Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
> ---
>  drivers/rtc/rtc-pcf85363.c | 37 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 36 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/rtc/rtc-pcf85363.c b/drivers/rtc/rtc-pcf85363.c
> index c05b722f0060..941f9264cf0a 100644
> --- a/drivers/rtc/rtc-pcf85363.c
> +++ b/drivers/rtc/rtc-pcf85363.c
> @@ -101,6 +101,10 @@
>  #define PIN_IO_INTA_OUT	2
>  #define PIN_IO_INTA_HIZ	3
>  
> +#define OSC_CAP_SEL	GENMASK(1, 0)
> +#define OSC_CAP_6000	0x01
> +#define OSC_CAP_12500	0x02
> +
>  #define STOP_EN_STOP	BIT(0)
>  
>  #define RESET_CPR	0xa4
> @@ -117,6 +121,32 @@ struct pcf85x63_config {
>  	unsigned int num_nvram;
>  };
>  
> +static int pcf85363_load_capacitance(struct pcf85363 *pcf85363, struct device_node *node)
> +{
> +	u32 load = 7000;
> +	u8 value = 0;
> +
> +	of_property_read_u32(node, "quartz-load-femtofarads", &load);
> +
> +	switch (load) {
> +	default:
> +		dev_warn(&pcf85363->rtc->dev, "Unknown quartz-load-femtofarads value: %d. Assuming 7000",
> +			 load);
> +		fallthrough;
> +	case 7000:
> +		break;
> +	case 6000:
> +		value |= OSC_CAP_6000;

Why are you using the |= operator?

> +		break;
> +	case 12500:
> +		value |= OSC_CAP_12500;
> +		break;
> +	}
> +
> +	return regmap_update_bits(pcf85363->regmap, CTRL_OSCILLATOR,
> +				  OSC_CAP_SEL, value);
> +}
> +
>  static int pcf85363_rtc_read_time(struct device *dev, struct rtc_time *tm)
>  {
>  	struct pcf85363 *pcf85363 = dev_get_drvdata(dev);
> @@ -372,7 +402,7 @@ static int pcf85363_probe(struct i2c_client *client)
>  			.reg_write = pcf85363_nvram_write,
>  		},
>  	};
> -	int ret, i;
> +	int ret, i, err;
>  
>  	if (data)
>  		config = data;
> @@ -394,6 +424,11 @@ static int pcf85363_probe(struct i2c_client *client)
>  	if (IS_ERR(pcf85363->rtc))
>  		return PTR_ERR(pcf85363->rtc);
>  
> +	err = pcf85363_load_capacitance(pcf85363, client->dev.of_node);
> +	if (err < 0)
> +		dev_warn(&client->dev, "failed to set xtal load capacitance: %d",
> +			 err);
> +
>  	pcf85363->rtc->ops = &rtc_ops;
>  	pcf85363->rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
>  	pcf85363->rtc->range_max = RTC_TIMESTAMP_END_2099;
> -- 
> 2.37.2
> 
> 
> Javier Carrasco 
> Research and Development
> 
> Wolfvision GmbH 
> Oberes Ried 14 | 6833 Klaus | Austria 
> Tel: +43 5523 52250 <tel:+43552352250> | Mail: javier.carrasco@wolfvision.net <mailto:javier.carrasco@wolfvision.net>
> 
> Website: wolfvision.com <www.wolfvision.com> 
> Firmenbuch / Commercial Register: FN283521v Feldkirch/Austria
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

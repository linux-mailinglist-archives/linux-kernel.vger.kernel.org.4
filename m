Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3993B72C6F0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 16:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236966AbjFLOHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 10:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236919AbjFLOHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 10:07:51 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C197A1;
        Mon, 12 Jun 2023 07:07:50 -0700 (PDT)
X-GND-Sasl: alexandre.belloni@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686578868;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8aq38QKEdBNE3WxYWJheQyTs9iqtlahhv2aTRlxzgBk=;
        b=jX/+gtEvZoMiCDMJQBDkRjnIA75s/XfCX8/t5AcvlG7vXZeNRBoaBtjXehnuNVWxuohyLU
        03L7RexpLqk48DZWg1hLmnd2vmAX9ONYNrQa4jg+lMtPDNPsDrHQYZJXwxOoY/cH593v6R
        FX3w4WIkWFu7CVNLKf3g0ulSeMYS3OCnNiWABqg2o1pm7cbl5v0Z6Ex9ok6lsaHJYw0Qcf
        yeX0fVBTTVFRBejk8pEcOwaRStQYG8w8XUyk6JN3jDS9Z4BxLmVZgKK1n7/Jn9rIwiR1VW
        gZvFczwipksArk6wYIfVUWCaQ749oQkODZFfTcb5S5N4fRFHoa7yW88DR2mKGg==
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 187BA1C0012;
        Mon, 12 Jun 2023 14:07:46 +0000 (UTC)
Date:   Mon, 12 Jun 2023 16:07:46 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/8] rtc: isl12022: implement RTC_VL_READ and RTC_VL_CLR
 ioctls
Message-ID: <2023061214074623dcc0cf@mail.local>
References: <20230612113059.247275-1-linux@rasmusvillemoes.dk>
 <20230612113059.247275-6-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612113059.247275-6-linux@rasmusvillemoes.dk>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/06/2023 13:30:55+0200, Rasmus Villemoes wrote:
> Hook up support for reading the values of the SR_LBAT85 and SR_LBAT75
> bits. Translate the former to "battery low", and the latter to
> "battery empty or not-present".
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  drivers/rtc/rtc-isl12022.c | 41 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/drivers/rtc/rtc-isl12022.c b/drivers/rtc/rtc-isl12022.c
> index cb8f1d92e116..1b6659a9b33a 100644
> --- a/drivers/rtc/rtc-isl12022.c
> +++ b/drivers/rtc/rtc-isl12022.c
> @@ -203,7 +203,48 @@ static int isl12022_rtc_set_time(struct device *dev, struct rtc_time *tm)
>  	return regmap_bulk_write(regmap, ISL12022_REG_SC, buf, sizeof(buf));
>  }
>  
> +static int isl12022_read_sr(struct regmap *regmap)
> +{
> +	int ret;
> +	u32 val;
> +
> +	ret = regmap_read(regmap, ISL12022_REG_SR, &val);
> +	if (ret < 0)
> +		return ret;
> +	return val;
> +}
> +
> +static int isl12022_rtc_ioctl(struct device *dev, unsigned int cmd, unsigned long arg)
> +{
> +	struct regmap *regmap = dev_get_drvdata(dev);
> +	u32 user = 0;
> +	int ret;
> +
> +	switch (cmd) {
> +	case RTC_VL_READ:
> +		ret = isl12022_read_sr(regmap);
> +		if (ret < 0)
> +			return ret;
> +
> +		if (ret & ISL12022_SR_LBAT85)
> +			user |= RTC_VL_BACKUP_LOW;
> +
> +		if (ret & ISL12022_SR_LBAT75)
> +			user |= RTC_VL_BACKUP_EMPTY;
> +
> +		return put_user(user, (u32 __user *)arg);
> +
> +	case RTC_VL_CLR:
> +		return regmap_clear_bits(regmap, ISL12022_REG_SR,
> +					 ISL12022_SR_LBAT85 | ISL12022_SR_LBAT75);

I'm against using RTC_VL_CLR for this as it deletes important
information (i.e. the date is probably invalid). You should let the RTC
clear the bits once the battery has been changed:

"The LBAT75 bit is set when the
VBAT has dropped below the pre-selected trip level, and will self
clear when the VBAT is above the pre-selected trip level at the
next detection cycle either by manual or automatic trigger."

> +
> +	default:
> +		return -ENOIOCTLCMD;
> +	}
> +}
> +
>  static const struct rtc_class_ops isl12022_rtc_ops = {
> +	.ioctl		= isl12022_rtc_ioctl,
>  	.read_time	= isl12022_rtc_read_time,
>  	.set_time	= isl12022_rtc_set_time,
>  };
> -- 
> 2.37.2
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

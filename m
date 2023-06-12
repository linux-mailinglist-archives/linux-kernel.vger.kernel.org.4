Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 836E572C7FE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 16:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237590AbjFLOSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 10:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237981AbjFLOSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 10:18:03 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8565A4217;
        Mon, 12 Jun 2023 07:15:41 -0700 (PDT)
X-GND-Sasl: alexandre.belloni@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686579319;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JHme2Jc90CM+3uR1LvpKHCswp5LiVS3SDAsg2avUjr4=;
        b=ZPPPCB/Pd5MH5nDnJs4Dxn2EuPgKqf+VoJZz6e6q+gBxCy+M9uUxyV3+XUUXkIifx7g+5S
        ZvSZBDEaaE4OsXENv5DDdSOwZzmD8dX6w2iWEyPB/ycbht6OeblmSMz/uWreO66eKQcXRu
        H/cbfrdkPTXUTHq8dNXFbFh1p8uceAGLkIt5GLkYrJcGubVnYtCxk9EH0jCSX/MP63xXsi
        nUGWckZxvrEPb+S5wL6bkBiB7qHaVAxz72fGDIXlwwZyYjgb4W05m48QXwqQmvD/9yT1yw
        2HBkpYxqOBim8oX6dB3v7OO6YeHAJ6BKRsV/xZ1oV4uMIs8Kw8xFtiIuxjRJvg==
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 73585E0011;
        Mon, 12 Jun 2023 14:15:18 +0000 (UTC)
Date:   Mon, 12 Jun 2023 16:15:18 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] rtc: isl12022: trigger battery level detection
 during probe
Message-ID: <20230612141518c2119835@mail.local>
References: <20230612113059.247275-1-linux@rasmusvillemoes.dk>
 <20230612113059.247275-7-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612113059.247275-7-linux@rasmusvillemoes.dk>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/06/2023 13:30:56+0200, Rasmus Villemoes wrote:
> Since the meaning of the SR_LBAT85 and SR_LBAT75 bits are different in
> battery backup mode, they may very well be set after power on, and
> stay set for up to a minute (i.e. until the battery detection in VDD
> mode happens when the seconds counter hits 59). This would mean that
> userspace doing a ioctl(RTC_VL_READ) early on could get a false
> positive.
> 
> The battery level detection can also be triggered by explicitly
> writing a 1 to the TSE bit in the BETA register. Do that once during
> boot (well, probe), and emit a single warning to the kernel log if the
> battery is already low.
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  drivers/rtc/rtc-isl12022.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/rtc/rtc-isl12022.c b/drivers/rtc/rtc-isl12022.c
> index 1b6659a9b33a..690dbb446d1a 100644
> --- a/drivers/rtc/rtc-isl12022.c
> +++ b/drivers/rtc/rtc-isl12022.c
> @@ -280,8 +280,25 @@ static void isl12022_set_trip_levels(struct device *dev)
>  	mask = ISL12022_REG_VB85_MASK | ISL12022_REG_VB75_MASK;
>  
>  	ret = regmap_update_bits(regmap, ISL12022_REG_PWR_VBAT, mask, val);
> -	if (ret)
> +	if (ret) {
>  		dev_warn(dev, "unable to set battery alarm levels: %d\n", ret);
> +		return;
> +	}
> +
> +	ret = regmap_write_bits(regmap, ISL12022_REG_BETA,
> +				ISL12022_BETA_TSE, ISL12022_BETA_TSE);
> +	if (ret) {
> +		dev_warn(dev, "unable to trigger battery level detection: %d\n", ret);

This is too verbose, there is no action for the user upon getting this
message.


Setting TSE also enables temperature compensation, which may be an
undesirable side effect. Shouldn't this be reverted if necessary?


> +		return;
> +	}
> +
> +	ret = isl12022_read_sr(regmap);
> +	if (ret < 0) {
> +		dev_warn(dev, "unable to read status register: %d\n", ret);
> +	} else if (ret & (ISL12022_SR_LBAT85 | ISL12022_SR_LBAT75)) {
> +		dev_warn(dev, "battery voltage is below %u%%\n",
> +			 (ret & ISL12022_SR_LBAT75) ? 75 : 85);

This message is useless, I'd drop the whole block.

> +	}
>  }
>  
>  static int isl12022_probe(struct i2c_client *client)
> -- 
> 2.37.2
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

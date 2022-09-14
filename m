Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3893E5B8B64
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 17:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbiINPJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 11:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbiINPI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 11:08:59 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E373C7821A;
        Wed, 14 Sep 2022 08:08:54 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 7746F2000A;
        Wed, 14 Sep 2022 15:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1663168131;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jundDmS1/qHdei81rVhVYU34/R/dU4gkDqIIWwD94zo=;
        b=aGTYWhQJahHaVgpZl/Lq+zyUeG3flk28rIbezUTpz7i4l+IXIUIjW75rT8OqZvSJfCNvbd
        zMaUzxtXJZSvZJkwhLvSuIms140xcV184RIGnGUvnTVwbUhrYc6THZS1bCOY2M5e2iMazp
        oRtg4a5ICxGZpG1QiZWUXJLHvN4kpoIlBLSv0Ic32+Ba3KG4/+thgK2ElGh0f20z1kTGfC
        ZWw21IJ3N5Z10BHbEpzGMG1oFd8eRCvauDpoaN/tOUcdXPw/HyzMD7xrsg5le7TJSDtGqD
        G4Sk8tZuFepTc+nng0TmjZm0+WooNEspt40p+zTrjj+bui4PaUz0jqsZKf8Htg==
Date:   Wed, 14 Sep 2022 17:08:49 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] rtc: isl12022: simplify some expressions
Message-ID: <YyHugb47cJPNuHbs@mail.local>
References: <20220830100152.698506-1-linux@rasmusvillemoes.dk>
 <20220830100152.698506-3-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830100152.698506-3-linux@rasmusvillemoes.dk>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 30/08/2022 12:01:48+0200, Rasmus Villemoes wrote:
> These instances of '&client->dev' might as well be spelled 'dev', since
> 'client' has been computed from 'dev' via 'client =
> to_i2c_client(dev)'.
> 
> Later patches will get rid of that local variable 'client', so remove
> these unnecessary references so those later patches become easier to
> read.
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  drivers/rtc/rtc-isl12022.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-isl12022.c b/drivers/rtc/rtc-isl12022.c
> index 2dc19061cf5f..5e6bb9153c89 100644
> --- a/drivers/rtc/rtc-isl12022.c
> +++ b/drivers/rtc/rtc-isl12022.c
> @@ -112,13 +112,13 @@ static int isl12022_rtc_read_time(struct device *dev, struct rtc_time *tm)
>  		return ret;
>  
>  	if (buf[ISL12022_REG_SR] & (ISL12022_SR_LBAT85 | ISL12022_SR_LBAT75)) {
> -		dev_warn(&client->dev,
> +		dev_warn(dev,

While at it, I would prefer that one to also become a dev_dbg

>  			 "voltage dropped below %u%%, "
>  			 "date and time is not reliable.\n",
>  			 buf[ISL12022_REG_SR] & ISL12022_SR_LBAT85 ? 85 : 75);
>  	}
>  
> -	dev_dbg(&client->dev,
> +	dev_dbg(dev,
>  		"%s: raw data is sec=%02x, min=%02x, hr=%02x, "
>  		"mday=%02x, mon=%02x, year=%02x, wday=%02x, "
>  		"sr=%02x, int=%02x",
> @@ -141,7 +141,7 @@ static int isl12022_rtc_read_time(struct device *dev, struct rtc_time *tm)
>  	tm->tm_mon = bcd2bin(buf[ISL12022_REG_MO] & 0x1F) - 1;
>  	tm->tm_year = bcd2bin(buf[ISL12022_REG_YR]) + 100;
>  
> -	dev_dbg(&client->dev, "%s: secs=%d, mins=%d, hours=%d, "
> +	dev_dbg(dev, "%s: secs=%d, mins=%d, hours=%d, "

You probably want to convert that to %ptR

>  		"mday=%d, mon=%d, year=%d, wday=%d\n",
>  		__func__,
>  		tm->tm_sec, tm->tm_min, tm->tm_hour,
> @@ -158,7 +158,7 @@ static int isl12022_rtc_set_time(struct device *dev, struct rtc_time *tm)
>  	int ret;
>  	uint8_t buf[ISL12022_REG_DW + 1];
>  
> -	dev_dbg(&client->dev, "%s: secs=%d, mins=%d, hours=%d, "
> +	dev_dbg(dev, "%s: secs=%d, mins=%d, hours=%d, "

ditto

>  		"mday=%d, mon=%d, year=%d, wday=%d\n",
>  		__func__,
>  		tm->tm_sec, tm->tm_min, tm->tm_hour,
> @@ -173,8 +173,7 @@ static int isl12022_rtc_set_time(struct device *dev, struct rtc_time *tm)
>  		/* Check if WRTC (write rtc enable) is set factory default is
>  		 * 0 (not set) */
>  		if (!(buf[0] & ISL12022_INT_WRTC)) {
> -			dev_info(&client->dev,
> -				 "init write enable and 24 hour format\n");
> +			dev_info(dev, "init write enable and 24 hour format\n");

I guess that one should simply be removed

>  
>  			/* Set the write enable bit. */
>  			ret = isl12022_write_reg(client,
> -- 
> 2.37.2
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

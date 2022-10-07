Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AFBF5F7D8E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 20:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiJGS5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 14:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiJGS5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 14:57:44 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D4E59F758;
        Fri,  7 Oct 2022 11:57:42 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 99517E0002;
        Fri,  7 Oct 2022 18:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1665169060;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iqBW2CwPxuqJw20irWWxJEKN6J5WBAj+ycFaQ0mdrf8=;
        b=br9j/u8pRrPuAON2MA6foE9JwLxCHNIbtr+cWeaZgAOYc8KZX2CIqmdgn1KmVY9zkf9IkL
        mRLkz33QOO+e0J5exw/Raa3dhMBVId5WIozRJkycxOpAJApcijLv2KmVMZXgs4LYhacLg8
        lmyxboqeter8PDQfzJ26Fp7p8BM888D94cF7aett03kg8fC4E3rNcidYvj2izNgwEs/zat
        Bnpb1LctKgZnMwDk4zyUUifKzM4CnaD+6kGDhtbvo6Wmv9OUtsQsrr6VDLJxpsRTjtNqN4
        i2Hav/uDnjbbz31v5CrCwNmDNInn450JvenUm4kg6ugmRNSdKVFoFcz5uRvo1g==
Date:   Fri, 7 Oct 2022 20:57:40 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Sean Anderson <sean.anderson@seco.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: abx80x: Don't warn about oscillator failure after
 PoR
Message-ID: <Y0B2pNv8otKkLs1D@mail.local>
References: <20221007163712.2193966-1-sean.anderson@seco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221007163712.2193966-1-sean.anderson@seco.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 07/10/2022 12:37:12-0400, Sean Anderson wrote:
> According to the datasheet, the "oscillator failure" bit is set
> 
> > ...on a power on reset, when both the system and battery voltages have
> > dropped below acceptable levels. It is also set if an Oscillator Failure
> > occurs....
> 
> From testing, this bit is also set if a software reset is initiated.
> 
> This bit has a confusing name; it really tells us whether the time data
> is valid. We clear it when writing the time. If it is still set, that
> means there is a persistent issue (such as an oscillator failure),
> instead of a transient one (such as power loss).
> 
> Because there are several other reasons which might cause this bit
> to be set (including booting for the first time or a battery failure),
> do not warn about oscillator failures willy-nilly. This may cause system
> integrators to waste time looking into the wrong line of investigation.
> 
> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
> ---
> 
>  drivers/rtc/rtc-abx80x.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
> index 9b0138d07232..1eb752e4e39d 100644
> --- a/drivers/rtc/rtc-abx80x.c
> +++ b/drivers/rtc/rtc-abx80x.c
> @@ -115,6 +115,7 @@ struct abx80x_priv {
>  	struct rtc_device *rtc;
>  	struct i2c_client *client;
>  	struct watchdog_device wdog;
> +	bool wrote_time;
>  };
>  
>  static int abx80x_write_config_key(struct i2c_client *client, u8 key)
> @@ -167,6 +168,7 @@ static int abx80x_enable_trickle_charger(struct i2c_client *client,
>  static int abx80x_rtc_read_time(struct device *dev, struct rtc_time *tm)
>  {
>  	struct i2c_client *client = to_i2c_client(dev);
> +	struct abx80x_priv *priv = i2c_get_clientdata(client);
>  	unsigned char buf[8];
>  	int err, flags, rc_mode = 0;
>  
> @@ -181,7 +183,18 @@ static int abx80x_rtc_read_time(struct device *dev, struct rtc_time *tm)
>  			return flags;
>  
>  		if (flags & ABX8XX_OSS_OF) {
> -			dev_err(dev, "Oscillator failure, data is invalid.\n");

Simply remove the line.

> +			/*
> +			 * The OF bit can be set either because of a reset
> +			 * (PoR/Software reset) or because of an oscillator
> +			 * failure. Effectively, it indicates that the stored
> +			 * time is invalid. When we write the time, we clear
> +			 * this bit. If it stays set, then this indicates an
> +			 * oscillator failure.
> +			 */
> +			if (priv->wrote_time)
> +				dev_err(dev, "Oscillator failure\n");
> +			else
> +				dev_info(dev, "Time data invalid\n");
>  			return -EINVAL;
>  		}
>  	}
> @@ -207,6 +220,7 @@ static int abx80x_rtc_read_time(struct device *dev, struct rtc_time *tm)
>  static int abx80x_rtc_set_time(struct device *dev, struct rtc_time *tm)
>  {
>  	struct i2c_client *client = to_i2c_client(dev);
> +	struct abx80x_priv *priv = i2c_get_clientdata(client);
>  	unsigned char buf[8];
>  	int err, flags;
>  
> @@ -240,6 +254,7 @@ static int abx80x_rtc_set_time(struct device *dev, struct rtc_time *tm)
>  		dev_err(&client->dev, "Unable to write oscillator status register\n");
>  		return err;
>  	}
> +	priv->wrote_time = true;
>  
>  	return 0;
>  }
> -- 
> 2.35.1.1320.gc452695387.dirty
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

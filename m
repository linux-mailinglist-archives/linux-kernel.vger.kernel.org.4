Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0766A72AA4E
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 10:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbjFJIbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 04:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbjFJIbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 04:31:40 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E004F2718;
        Sat, 10 Jun 2023 01:31:37 -0700 (PDT)
X-GND-Sasl: alexandre.belloni@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686385896;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OK8Q4QRjn4O3LEpDvvgIC+0ZRQV/BQxETmAgTgYPCO4=;
        b=BWM/pGjsGVLKFet0yE0Oc813Y+lJ4mUt1mo2P6/srAsGiMNPRquuzfFbFBdYg58xLvI5u4
        gZHmp0dtrZ7YPXW5GrvbV1/jy1zt6/Vx4Umrt83vLzXHaAojtJLnaEAYRUjUbUJTjyUyAv
        9Teqk4e2enhoNCBhDuZ++UdaIZNyKPvJzrLkoGrv3eOHMaiFuy5prYf+Rge8E7Xii+HUSG
        7QK9c96p5CFgImZZ7MwK6ViOCPV/XkxZLf1XBYfa1mHYJQAOJVuxDyTnulpAjc4IKWPJdm
        7MaiIKAPlPYzY2FL2mujx5bwn7CUm21IVnrpu9mBupkXIXlKcNZhzf5OY9+XkA==
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 25D07C0005;
        Sat, 10 Jun 2023 08:31:36 +0000 (UTC)
Date:   Sat, 10 Jun 2023 10:31:35 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Jan Kiszka <jan.kiszka@siemens.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rtc: pcf-8563: Report previously detected low-voltage
 via RTC_VL_BACKUP_LOW
Message-ID: <20230610083135e40dd2f6@mail.local>
References: <da84b6b1-a9d8-ce46-16a9-e1a2d495240c@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da84b6b1-a9d8-ce46-16a9-e1a2d495240c@siemens.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jan,

On 09/06/2023 23:04:12+0200, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> The VL bit in the seconds register remains set only until seconds are
> written under main power. As this often happens during boot-up after
> picking up a network time, make sure to preserve the low battery state
> across this, caching it and returning it via the RTC_VL_BACKUP_LOW bit.
> 
> To permit userspace clearing this state during runtime, also implement
> RTC_VL_CLR that works against the cached state.
> 
> This is emulating RTCs which have a battery voltage check that works
> under main power as well.
> 

Emulating doesn't work well and I deliberately chose to not implement
it. For example, in your scenario, if you boot twice without using
VL_READ, you anyway have lost the information. This makes emulating
unreliabl. The fix you need is in userspace where you have to ensure you
read the status before setting the time.

> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  drivers/rtc/rtc-pcf8563.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-pcf8563.c b/drivers/rtc/rtc-pcf8563.c
> index 7e720472213c..f8c6cdb9a39d 100644
> --- a/drivers/rtc/rtc-pcf8563.c
> +++ b/drivers/rtc/rtc-pcf8563.c
> @@ -81,6 +81,7 @@ struct pcf8563 {
>  #ifdef CONFIG_COMMON_CLK
>  	struct clk_hw		clkout_hw;
>  #endif
> +	bool low_bat;
>  };
>  
>  static int pcf8563_read_block_data(struct i2c_client *client, unsigned char reg,
> @@ -207,6 +208,7 @@ static int pcf8563_rtc_read_time(struct device *dev, struct rtc_time *tm)
>  		return err;
>  
>  	if (buf[PCF8563_REG_SC] & PCF8563_SC_LV) {
> +		pcf8563->low_bat = true;
>  		dev_err(&client->dev,
>  			"low voltage detected, date/time is not reliable.\n");
>  		return -EINVAL;
> @@ -277,6 +279,8 @@ static int pcf8563_rtc_set_time(struct device *dev, struct rtc_time *tm)
>  static int pcf8563_rtc_ioctl(struct device *dev, unsigned int cmd, unsigned long arg)
>  {
>  	struct i2c_client *client = to_i2c_client(dev);
> +	struct pcf8563 *pcf8563 = i2c_get_clientdata(client);
> +	unsigned int state = 0;
>  	int ret;
>  
>  	switch (cmd) {
> @@ -284,9 +288,16 @@ static int pcf8563_rtc_ioctl(struct device *dev, unsigned int cmd, unsigned long
>  		ret = i2c_smbus_read_byte_data(client, PCF8563_REG_SC);
>  		if (ret < 0)
>  			return ret;
> -
> -		return put_user(ret & PCF8563_SC_LV ? RTC_VL_DATA_INVALID : 0,
> -				(unsigned int __user *)arg);
> +		if (ret & PCF8563_SC_LV) {
> +			state |= RTC_VL_DATA_INVALID;
> +			pcf8563->low_bat = true;
> +		}
> +		if (pcf8563->low_bat)
> +			state |= RTC_VL_BACKUP_LOW;
> +		return put_user(state, (unsigned int __user *)arg);
> +	case RTC_VL_CLR:
> +		pcf8563->low_bat = false;
> +		return 0;
>  	default:
>  		return -ENOIOCTLCMD;
>  	}
> -- 
> 2.35.3

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

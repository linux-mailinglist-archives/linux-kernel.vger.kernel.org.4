Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3E7C6A9924
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 15:11:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjCCOLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 09:11:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjCCOLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 09:11:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8D85D897;
        Fri,  3 Mar 2023 06:11:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A9F41B818D7;
        Fri,  3 Mar 2023 14:11:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5295C4339E;
        Fri,  3 Mar 2023 14:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677852704;
        bh=rcz5yj2YfYuXUPK0B0fgsHEPcDvF6WUxXgCeRhOTR9U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NIE9s2W2HoLF80+qAryoeuKAgZ5hVt+7/MGti1aKOW8RX7B0fojLJ2GXv2hfFcgSA
         YW+PXJ6T9FSQmKZbvltjQBrP8D6dmOZPZCCOySDLg/FI/yZTNmOOibDC9zgI9p/KEz
         Cd1Vv9sCLqwwFhlUIhyd36/taIvHz3jGDEWHKsh2jotjFTQjc8dW98hszBw32hsmRO
         e2xlmz9926HzTbrvVMqzzBa8grtLTd6mZTeX3Mi1bTMBHINsIw9g5tXlx2fOXExXWC
         Zqk5lITTyfJgkmU0er0bSafbf2RObcKuyRXxtLBWl6A/7lskvYzJXaWk/aBskyH8O6
         FSIPVDWFjshnA==
Date:   Fri, 3 Mar 2023 14:11:39 +0000
From:   Lee Jones <lee@kernel.org>
To:     Florian Eckert <fe@dev.tdt.de>
Cc:     u.kleine-koenig@pengutronix.de, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, pavel@ucw.cz, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, Eckert.Florian@googlemail.com
Subject: Re: [PATCH v7 2/2] trigger: ledtrig-tty: add additional modes
Message-ID: <20230303141139.GP2420672@google.com>
References: <20230222083335.847655-1-fe@dev.tdt.de>
 <20230222083335.847655-3-fe@dev.tdt.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230222083335.847655-3-fe@dev.tdt.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Feb 2023, Florian Eckert wrote:

> Add additional modes to trigger the selected LED.
> The following modes are supported:
> 
> Tx/Rx:	Flash LED on data transmission (default)
> CTS:	DCE Ready to accept data from the DTE.
> DSR:	DCE is ready to receive and send data.
> CAR:	DCE is receiving a carrier from a remote DTE.
> RNG:	DCE has detected an incoming ring signal.
> 
> The mode can be changed for example with the following command:
> echo "CTS" > /sys/class/leds/<led>/mode
> 
> This would turn on the LED, when the DTE(modem) signals the DCE that it
> is ready to accept data.
> 
> Signed-off-by: Florian Eckert <fe@dev.tdt.de>
> ---
>  .../ABI/testing/sysfs-class-led-trigger-tty   |  17 ++
>  drivers/leds/trigger/ledtrig-tty.c            | 145 ++++++++++++++++--
>  2 files changed, 147 insertions(+), 15 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-led-trigger-tty b/Documentation/ABI/testing/sysfs-class-led-trigger-tty
> index 2bf6b24e781b..1c28e6c61d19 100644
> --- a/Documentation/ABI/testing/sysfs-class-led-trigger-tty
> +++ b/Documentation/ABI/testing/sysfs-class-led-trigger-tty
> @@ -4,3 +4,20 @@ KernelVersion:	5.10
>  Contact:	linux-leds@vger.kernel.org
>  Description:
>  		Specifies the tty device name of the triggering tty
> +
> +What:		/sys/class/leds/<led>/mode
> +Date:		January 2023
> +KernelVersion:	6.3
> +Description:
> +		Specifies the operating to trigger the LED.

The operating ... ?  "mode"?

> +		The following operating modes are supported:
> +
> +		* Tx/Rx: Flash LED on data transmission (default)
> +		* CTS:   DCE Ready to accept data from the DTE.
> +		  LED on if line is high.
> +		* DSR:   DCE is ready to receive and send data.
> +		  LED on if line is high.
> +		* CAR:   DCE has detected a carrier from a remote DTE.
> +		  LED on if line is high.
> +		* RNG:   DCE has detected an incoming ring signal.
> +		  LED on if line is high.

Seeing as this is unchanging, how about you mention it once globally?

> diff --git a/drivers/leds/trigger/ledtrig-tty.c b/drivers/leds/trigger/ledtrig-tty.c
> index f62db7e520b5..7c4c171c8745 100644
> --- a/drivers/leds/trigger/ledtrig-tty.c
> +++ b/drivers/leds/trigger/ledtrig-tty.c
> @@ -7,6 +7,15 @@
>  #include <linux/tty.h>
>  #include <uapi/linux/serial.h>
>  
> +enum tty_led_mode {
> +	TTY_LED_CNT,

What's CNT?  Is it documented somewhere else?  Ah, I see below that this
is Tx/Rx.  Odd name, what does it mean?  Defines and Enums should be
self documenting IMHO.

> +	TTY_LED_CTS,
> +	TTY_LED_DSR,
> +	TTY_LED_CAR,
> +	TTY_LED_RNG,
> +	__TTY_LED_LAST = TTY_LED_RNG

Do you have to prepend with _'s?

> +};
> +
>  struct ledtrig_tty_data {
>  	struct led_classdev *led_cdev;
>  	struct delayed_work dwork;
> @@ -14,6 +23,15 @@ struct ledtrig_tty_data {
>  	const char *ttyname;
>  	struct tty_struct *tty;
>  	int rx, tx;
> +	enum tty_led_mode mode;
> +};
> +
> +static const char * const mode[] = {
> +	[TTY_LED_CNT] = "Tx/Rx", // Trasmit Data / Receive Data

C++ style comments?

> +	[TTY_LED_CTS] = "CTS", // CTS Clear To Send
> +	[TTY_LED_DSR] = "DSR", // DSR Data Set Ready
> +	[TTY_LED_CAR] = "CAR", // CAR Data Carrier Detect (DCD)
> +	[TTY_LED_RNG] = "RNG", // RNG Ring Indicator (RI)
>  };
>  
>  static void ledtrig_tty_restart(struct ledtrig_tty_data *trigger_data)
> @@ -21,6 +39,70 @@ static void ledtrig_tty_restart(struct ledtrig_tty_data *trigger_data)
>  	schedule_delayed_work(&trigger_data->dwork, 0);
>  }
>  
> +static ssize_t ledtrig_tty_mode_show(char *buf, enum tty_led_mode tty_mode)
> +{
> +	int len = 0;
> +	int i;
> +
> +	for (i = 0; i <= __TTY_LED_LAST; i++) {
> +		bool hit = tty_mode == i;
> +		bool last = i == __TTY_LED_LAST;
> +
> +		len += sysfs_emit_at(buf, len, "%s%s%s%s",
> +				  hit ? "[" : "",
> +				  mode[i],
> +				  hit ? "]" : "",
> +				  last ? "" : " ");
> +	}
> +
> +	len += sysfs_emit_at(buf, len, "\n");
> +
> +	return len;
> +}
> +
> +static ssize_t tty_led_mode_show(struct device *dev,
> +			 struct device_attribute *attr, char *buf)

This may be a personal preference, but I'd rather see alignment with the '('.

> +{
> +	struct ledtrig_tty_data *trigger_data = led_trigger_get_drvdata(dev);
> +	enum tty_led_mode tty_mode;
> +
> +	mutex_lock(&trigger_data->mutex);
> +	tty_mode = trigger_data->mode;
> +	mutex_unlock(&trigger_data->mutex);
> +
> +	return ledtrig_tty_mode_show(buf, tty_mode);
> +}
> +
> +static ssize_t tty_led_mode_store(struct device *dev,
> +			  struct device_attribute *attr, const char *buf,
> +			  size_t size)
> +{
> +	struct ledtrig_tty_data *trigger_data = led_trigger_get_drvdata(dev);
> +	ssize_t ret = size;
> +	enum tty_led_mode tty_mode = __TTY_LED_LAST;

Nit: Can you reverse these 2 lines to make my OCD happy please?

> +	int i;
> +
> +	/* Check for new line in string*/

' ' before the '*'.

> +	if (size > 0 && buf[size - 1] == '\n')
> +		size -= 1;
> +
> +	for (i = 0; i <= __TTY_LED_LAST; i++)
> +		if (strncmp(buf, mode[i], size) == 0) {
> +			tty_mode = i;
> +			break;
> +		}
> +
> +	if (i > __TTY_LED_LAST)
> +		return -EINVAL;
> +
> +	mutex_lock(&trigger_data->mutex);
> +	trigger_data->mode = tty_mode;
> +	mutex_unlock(&trigger_data->mutex);
> +
> +	return ret;
> +}
> +static DEVICE_ATTR_RW(tty_led_mode);
> +
>  static ssize_t ttyname_show(struct device *dev,
>  			    struct device_attribute *attr, char *buf)
>  {
> @@ -76,6 +158,18 @@ static ssize_t ttyname_store(struct device *dev,
>  }
>  static DEVICE_ATTR_RW(ttyname);
>  
> +static void ledtrig_tty_flags(struct ledtrig_tty_data *trigger_data,
> +		unsigned int flag)

This can be on a single line.  Please use 100-chars throughout.

> +{
> +	unsigned int status;
> +
> +	status = tty_get_mget(trigger_data->tty);
> +	if (status & flag)
> +		led_set_brightness_sync(trigger_data->led_cdev, LED_ON);
> +	else
> +		led_set_brightness_sync(trigger_data->led_cdev, LED_OFF);
> +}
> +
>  static void ledtrig_tty_work(struct work_struct *work)
>  {
>  	struct ledtrig_tty_data *trigger_data =
> @@ -113,21 +207,38 @@ static void ledtrig_tty_work(struct work_struct *work)
>  		trigger_data->tty = tty;
>  	}
>  
> -	ret = tty_get_icount(trigger_data->tty, &icount);
> -	if (ret) {
> -		dev_info(trigger_data->tty->dev, "Failed to get icount, stopped polling\n");
> -		mutex_unlock(&trigger_data->mutex);
> -		return;
> -	}
> -
> -	if (icount.rx != trigger_data->rx ||
> -	    icount.tx != trigger_data->tx) {
> -		led_set_brightness_sync(trigger_data->led_cdev, LED_ON);
> -
> -		trigger_data->rx = icount.rx;
> -		trigger_data->tx = icount.tx;
> -	} else {
> -		led_set_brightness_sync(trigger_data->led_cdev, LED_OFF);
> +	switch (trigger_data->mode) {
> +	case TTY_LED_CTS:
> +		ledtrig_tty_flags(trigger_data, TIOCM_CTS);
> +		break;
> +	case TTY_LED_DSR:
> +		ledtrig_tty_flags(trigger_data, TIOCM_DSR);
> +		break;
> +	case TTY_LED_CAR:
> +		ledtrig_tty_flags(trigger_data, TIOCM_CAR);
> +		break;
> +	case TTY_LED_RNG:
> +		ledtrig_tty_flags(trigger_data, TIOCM_RNG);
> +		break;
> +	case TTY_LED_CNT:

I believe this requires a 'fall-through' statement.

Documentation/process/deprecated.rst

> +	default:
> +		ret = tty_get_icount(trigger_data->tty, &icount);
> +		if (ret) {
> +			dev_info(trigger_data->tty->dev, "Failed to get icount, stopped polling\n");
> +			mutex_unlock(&trigger_data->mutex);
> +			return;
> +		}
> +
> +		if (icount.rx != trigger_data->rx ||
> +		    icount.tx != trigger_data->tx) {

One line, etc.

> +			led_set_brightness_sync(trigger_data->led_cdev, LED_ON);
> +
> +			trigger_data->rx = icount.rx;
> +			trigger_data->tx = icount.tx;
> +		} else {
> +			led_set_brightness_sync(trigger_data->led_cdev, LED_OFF);
> +		}
> +		break;
>  	}
>  
>  out:
> @@ -137,6 +248,7 @@ static void ledtrig_tty_work(struct work_struct *work)
>  
>  static struct attribute *ledtrig_tty_attrs[] = {
>  	&dev_attr_ttyname.attr,
> +	&dev_attr_tty_led_mode.attr,
>  	NULL
>  };
>  ATTRIBUTE_GROUPS(ledtrig_tty);
> @@ -149,6 +261,9 @@ static int ledtrig_tty_activate(struct led_classdev *led_cdev)
>  	if (!trigger_data)
>  		return -ENOMEM;
>  
> +	/* set default mode */

Nit: "Set"

> +	trigger_data->mode = TTY_LED_CNT;
> +
>  	led_set_trigger_data(led_cdev, trigger_data);
>  
>  	INIT_DELAYED_WORK(&trigger_data->dwork, ledtrig_tty_work);
> -- 
> 2.30.2
> 

-- 
Lee Jones [李琼斯]

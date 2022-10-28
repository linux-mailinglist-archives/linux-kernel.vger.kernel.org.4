Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D661B611A0E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 20:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbiJ1SWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 14:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbiJ1SWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 14:22:21 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id AC974244196
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 11:22:16 -0700 (PDT)
Received: (qmail 90288 invoked by uid 1000); 28 Oct 2022 14:22:15 -0400
Date:   Fri, 28 Oct 2022 14:22:15 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Ray Chi <raychi@google.com>
Cc:     gregkh@linuxfoundation.org, m.grzeschik@pengutronix.de,
        albertccwang@google.com, pumahsu@google.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH RESEND v4] usb: core: stop USB enumeration if too many
 retries
Message-ID: <Y1wd1wCLnx14QJuJ@rowland.harvard.edu>
References: <20221028102505.217565-1-raychi@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221028102505.217565-1-raychi@google.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 06:25:05PM +0800, Ray Chi wrote:
> When a broken USB accessory connects to a USB host, usbcore might
> keep doing enumeration retries. If the host has a watchdog mechanism,
> the kernel panic will happen on the host.
> 
> This patch provides an attribute early_stop to limit the numbers of retries
> for each port of a hub. If a port was marked with early_stop attribute,
> unsuccessful connection attempts will fail quickly. In addition, if an
> early_stop port has failed to initialize, it will ignore all future
> connection events until early_stop attribute is clear.
> 
> Signed-off-by: Ray Chi <raychi@google.com>

This seems basically okay, but I would have put the tests right at the 
starts of the retry loops.  This will make the logic much more 
obviously correct.

> diff --git a/Documentation/ABI/testing/sysfs-bus-usb b/Documentation/ABI/testing/sysfs-bus-usb
> index 568103d3376e..545c2dd97ed0 100644
> --- a/Documentation/ABI/testing/sysfs-bus-usb
> +++ b/Documentation/ABI/testing/sysfs-bus-usb
> @@ -264,6 +264,17 @@ Description:
>  		attached to the port will not be detected, initialized,
>  		or enumerated.
>  
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index bbab424b0d55..5510dbef3243 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -3081,6 +3081,48 @@ static int hub_port_reset(struct usb_hub *hub, int port1,
>  	return status;
>  }
>  
> +/*
> + * hub_port_stop_enumerate - stop USB enumeration or ignore port events
> + * @hub: target hub
> + * @port1: port num of the port
> + * @retries: port retries number of hub_port_init()
> + *
> + * Return:
> + *    true: ignore port actions/events or give up connection attempts.
> + *    false: keep original behavior.
> + *
> + * This function will be based on retries to check whether the port which is
> + * marked with early_stop attribute would stop enumeration or ignore events.
> + *
> + * Note:
> + * This function didn't change anything if early_stop is not set, and it will
> + * prevent all connection attempts when early_stop is set and the attempts of
> + * the port are more than 1.
> + */
> +static bool hub_port_stop_enumerate(struct usb_hub *hub, int port1, int retries)
> +{
> +	struct usb_port *port_dev = hub->ports[port1 - 1];
> +
> +	if (port_dev->early_stop) {
> +		if (port_dev->ignore_event)
> +			return true;
> +
> +		/*
> +		 * We want unsuccessful attempts to fail quickly.
> +		 * Since some devices may need one failure during
> +		 * port initialization, we allow two tries but no
> +		 * more.
> +		 */
> +		if (retries < 1)

Change "< 1" to "< 2".  This is in better agreement with the comment, 
which will make it easier for readers to understand.

> +			return false;
> +
> +		port_dev->ignore_event = 1;
> +	} else
> +		port_dev->ignore_event = 0;
> +
> +	return port_dev->ignore_event;
> +}
> +
>  /* Check if a port is power on */
>  int usb_port_is_power_on(struct usb_hub *hub, unsigned int portstatus)
>  {
> @@ -4855,6 +4897,11 @@ hub_port_init(struct usb_hub *hub, struct usb_device *udev, int port1,
>  					buf->bMaxPacketSize0;
>  			kfree(buf);
>  
> +			if (r < 0 && hub_port_stop_enumerate(hub, port1, retries)) {
> +				retval = r;
> +				goto fail;
> +			}

Then instead of putting this here, put:

			if (hub_port_stop_enumerate(hub, port1, retries)) {
				retval = -ENODEV;
				break;
			}

at line 4799.

> +
>  			retval = hub_port_reset(hub, port1, udev, delay, false);
>  			if (retval < 0)		/* error or disconnect */
>  				goto fail;
> @@ -5387,6 +5434,9 @@ static void hub_port_connect(struct usb_hub *hub, int port1, u16 portstatus,
>  		if ((status == -ENOTCONN) || (status == -ENOTSUPP))
>  			break;
>  
> +		if (hub_port_stop_enumerate(hub, port1, i))
> +			break;

And instead of putting this here, at line 5249 put:

		if (hub_port_stop_enumerate(hub, port1, i)) {
			status = -ENODEV;
			break;
		}

> +
>  		/* When halfway through our retry count, power-cycle the port */
>  		if (i == (PORT_INIT_TRIES - 1) / 2) {
>  			dev_info(&port_dev->dev, "attempt power cycle\n");
> @@ -5614,6 +5664,10 @@ static void port_event(struct usb_hub *hub, int port1)
>  	if (!pm_runtime_active(&port_dev->dev))
>  		return;
>  
> +	/* skip port actions if ignore_event is true*/
> +	if (hub_port_stop_enumerate(hub, port1, 0))
> +		return;

The relation between the comment and the code isn't obvious.  Instead, 
do:

	/* Skip initialization and enumeration if ignore_event is true */
	if (port_dev->ignore_event)
		return;

(Notice the space character you left out at the end of the comment.)

> +
>  	if (hub_handle_remote_wakeup(hub, port1, portstatus, portchange))
>  		connect_change = 1;
>  
> @@ -5934,6 +5988,9 @@ static int usb_reset_and_verify_device(struct usb_device *udev)
>  		ret = hub_port_init(parent_hub, udev, port1, i);
>  		if (ret >= 0 || ret == -ENOTCONN || ret == -ENODEV)
>  			break;
> +
> +		if (hub_port_stop_enumerate(parent_hub, port1, i))
> +			goto stop_enumerate;

And instead of putting this here, at line 5930 put:

		if (hub_port_stop_enumerate(parent_hub, port1, i)) {
			ret = -ENODEV;
			break;
		}

Alan Stern

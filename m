Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6825BCCF3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 15:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbiISNVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 09:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbiISNVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 09:21:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE692A959;
        Mon, 19 Sep 2022 06:21:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CCCC761C5A;
        Mon, 19 Sep 2022 13:21:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 330FEC433D6;
        Mon, 19 Sep 2022 13:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663593704;
        bh=hZS6MzobL+bSd/8qqpnr03/CZFdi1wPNppEVe3Cs1Lg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iq5dE1QYgWVYU7xNFqQJzMhc0ui2c3BkFXvAmIaQ7wGhOllJHKMsXu8+smgvsXMYx
         djqzI1skQcyWXayUJlcejAizJhTWEoV9DKJQy/0Wq09ws+G3zk+Kl18uU6YrvsZYcH
         4QmqiRmafRCqH1vWSEZ5ha6yYhA6hVXQTJX5htMtommFun4mHTWGC84Qb7tEACQRiX
         mHz0r9uaPOW7u34BPZ3d6hGgEfro4qhxHq5Wrbk3hDyqRocuh40PVjHwZSikw9tQxN
         qOPOpLELJauOoyk/Ihbd0jlfhhaLZVZO72HJL/LzlUvpQP1H57A3Ow++VA+SvSSylC
         jcKzB6m9zU5gg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oaGia-0005Og-BX; Mon, 19 Sep 2022 15:21:49 +0200
Date:   Mon, 19 Sep 2022 15:21:48 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] USB: serial: ftdi_sio: Convert to use dev_groups
Message-ID: <Yyhs7CW1iZKGfKab@hovoldconsulting.com>
References: <20220914071334.2820756-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914071334.2820756-1-jiasheng@iscas.ac.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 03:13:34PM +0800, Jiasheng Jiang wrote:
> The driver core supports the ability to handle the creation and removal
> of device-specific sysfs files in a race-free manner.

> Moreover, it can
> guarantee the success of creation.

I don't believe this is true, driver core just handles the errors.

> Therefore, it should be better to
> convert to use dev_groups.
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
> Changelog:
> 
> v4 -> v5:
> 
> 1. Use a forward declaration for ftdi_sio_groups.
> 2. Correct ftdi_sio_attr_is_visible() implementation.
> 
> v3 -> v4:
> 
> 1. Move the code and remove the pre-definitions.
> 
> v2 -> v3:
> 
> 1. Add is_visible to filter the unneeded files.
> 
> v1 -> v2:
> 
> 1. Change the title.
> 2. Switch to use an attribute group.
> ---
>  drivers/usb/serial/ftdi_sio.c | 60 +++++++++++++++++------------------
>  1 file changed, 29 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
> index d5a3986dfee7..660181064cda 100644
> --- a/drivers/usb/serial/ftdi_sio.c
> +++ b/drivers/usb/serial/ftdi_sio.c
> @@ -1108,10 +1108,13 @@ static u32 ftdi_232bm_baud_to_divisor(int baud);
>  static u32 ftdi_2232h_baud_base_to_divisor(int baud, int base);
>  static u32 ftdi_2232h_baud_to_divisor(int baud);
>  
> +extern const struct attribute_group *ftdi_sio_groups[];

Why did you use extern here? Should be static.

> +
>  static struct usb_serial_driver ftdi_sio_device = {
>  	.driver = {
>  		.owner =	THIS_MODULE,
>  		.name =		"ftdi_sio",
> +		.dev_groups =	ftdi_sio_groups,
>  	},
>  	.description =		"FTDI USB Serial Device",
>  	.id_table =		id_table_combined,
> @@ -1729,38 +1732,19 @@ static ssize_t event_char_store(struct device *dev,
>  }
>  static DEVICE_ATTR_WO(event_char);
>  
> -static int create_sysfs_attrs(struct usb_serial_port *port)
> +static umode_t ftdi_sio_attr_is_visible(struct kobject *kobj,
> +					 struct attribute *attr, int idx)

I'd drop the "sio" infix from all of these new symbols and just call
this one ftdi_is_visible().

>  {
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct usb_serial_port *port = container_of(dev, struct usb_serial_port, dev);
>  	struct ftdi_private *priv = usb_get_serial_port_data(port);
> -	int retval = 0;
> +	umode_t mode = attr->mode;
>  
>  	/* XXX I've no idea if the original SIO supports the event_char
>  	 * sysfs parameter, so I'm playing it safe.  */
>  	if (priv->chip_type != SIO) {
> -		dev_dbg(&port->dev, "sysfs attributes for %s\n", ftdi_chip_name[priv->chip_type]);
> -		retval = device_create_file(&port->dev, &dev_attr_event_char);
> -		if ((!retval) &&
> -		    (priv->chip_type == FT232BM ||
> -		     priv->chip_type == FT2232C ||
> -		     priv->chip_type == FT232RL ||
> -		     priv->chip_type == FT2232H ||
> -		     priv->chip_type == FT4232H ||
> -		     priv->chip_type == FT232H ||
> -		     priv->chip_type == FTX)) {
> -			retval = device_create_file(&port->dev,
> -						    &dev_attr_latency_timer);
> -		}
> -	}
> -	return retval;
> -}
> -
> -static void remove_sysfs_attrs(struct usb_serial_port *port)
> -{
> -	struct ftdi_private *priv = usb_get_serial_port_data(port);
> -
> -	/* XXX see create_sysfs_attrs */
> -	if (priv->chip_type != SIO) {
> -		device_remove_file(&port->dev, &dev_attr_event_char);
> +		if (attr == &dev_attr_event_char.attr)
> +			return mode;
>  		if (priv->chip_type == FT232BM ||
>  		    priv->chip_type == FT2232C ||
>  		    priv->chip_type == FT232RL ||
> @@ -1768,12 +1752,29 @@ static void remove_sysfs_attrs(struct usb_serial_port *port)
>  		    priv->chip_type == FT4232H ||
>  		    priv->chip_type == FT232H ||
>  		    priv->chip_type == FTX) {
> -			device_remove_file(&port->dev, &dev_attr_latency_timer);
> +			if (attr == &dev_attr_latency_timer.attr)
> +				return mode;
>  		}
>  	}
> -
> +	return 0;
>  }
>  
> +static struct attribute *ftdi_sio_attrs[] = {
> +	&dev_attr_event_char.attr,
> +	&dev_attr_latency_timer.attr,
> +	NULL,

nit: no need for comma after NULL.

> +};
> +
> +static const struct attribute_group ftdi_sio_group = {
> +	.attrs = ftdi_sio_attrs,
> +	.is_visible = ftdi_sio_attr_is_visible,
> +};
> +
> +const struct attribute_group *ftdi_sio_groups[] = {

Missing static.

> +	&ftdi_sio_group,
> +	NULL
> +};
> +
>  #ifdef CONFIG_GPIOLIB
>  
>  static int ftdi_set_bitmode(struct usb_serial_port *port, u8 mode)
> @@ -2251,7 +2252,6 @@ static int ftdi_sio_port_probe(struct usb_serial_port *port)
>  	if (read_latency_timer(port) < 0)
>  		priv->latency = 16;
>  	write_latency_timer(port);
> -	create_sysfs_attrs(port);
>  
>  	result = ftdi_gpio_init(port);
>  	if (result < 0) {
> @@ -2377,8 +2377,6 @@ static void ftdi_sio_port_remove(struct usb_serial_port *port)
>  
>  	ftdi_gpio_remove(port);
>  
> -	remove_sysfs_attrs(port);
> -
>  	kfree(priv);
>  }

But in general this looks good now.

There has been some recent changes to how this driver handles device
types so I rebased this patch on top, fixed up the above and amended the
commit message. The result is here:

	https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git/commit/?h=usb-next&id=0f6632e2e8beb6a1e0895c1309dd0b84b805c202

Thanks.

Johan

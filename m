Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 789376195A7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 12:52:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiKDLwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 07:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbiKDLwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 07:52:16 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7FD2B622
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 04:52:14 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oqvF6-0006WZ-Vz; Fri, 04 Nov 2022 12:52:13 +0100
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id F41D9112DEF;
        Fri,  4 Nov 2022 11:52:11 +0000 (UTC)
Date:   Fri, 4 Nov 2022 12:52:11 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc:     linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] can: etas_es58x: report the firmware version through
 ethtool
Message-ID: <20221104115211.533zif7ip4f5tvky@pengutronix.de>
References: <20221104073659.414147-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pe2igov4xrzd5dah"
Content-Disposition: inline
In-Reply-To: <20221104073659.414147-1-mailhol.vincent@wanadoo.fr>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pe2igov4xrzd5dah
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 04.11.2022 16:36:59, Vincent Mailhol wrote:
> ES58x devices report below information in their usb product info
> string:
>=20
>   * the firmware version
>   * the bootloader version
>   * the hardware revision
>=20
> Report the firmware version through ethtool_drvinfo::fw_version.
> Because struct ethtool_drvinfo has no fields to report the boatloader
> version nor the hardware revision, continue to print these in the
> kernel log (c.f. es58x_print_product_info()).
>=20
> While doing so, bump up copyright year of each modified files.
>=20
> Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> ---
>  drivers/net/can/usb/etas_es58x/es581_4.c    |   5 +-
>  drivers/net/can/usb/etas_es58x/es58x_core.c | 140 +++++++++++++-------
>  drivers/net/can/usb/etas_es58x/es58x_core.h |  11 +-
>  drivers/net/can/usb/etas_es58x/es58x_fd.c   |   5 +-
>  4 files changed, 108 insertions(+), 53 deletions(-)
>=20
> diff --git a/drivers/net/can/usb/etas_es58x/es581_4.c b/drivers/net/can/u=
sb/etas_es58x/es581_4.c
> index 1bcdcece5ec7..1d6ae7b279cf 100644
> --- a/drivers/net/can/usb/etas_es58x/es581_4.c
> +++ b/drivers/net/can/usb/etas_es58x/es581_4.c
> @@ -6,7 +6,7 @@
>   *
>   * Copyright (c) 2019 Robert Bosch Engineering and Business Solutions. A=
ll rights reserved.
>   * Copyright (c) 2020 ETAS K.K.. All rights reserved.
> - * Copyright (c) 2020, 2021 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> + * Copyright (c) 2020-2022 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
>   */
> =20
>  #include <linux/kernel.h>
> @@ -492,7 +492,8 @@ const struct es58x_parameters es581_4_param =3D {
>  	.tx_bulk_max =3D ES581_4_TX_BULK_MAX,
>  	.urb_cmd_header_len =3D ES581_4_URB_CMD_HEADER_LEN,
>  	.rx_urb_max =3D ES58X_RX_URBS_MAX,
> -	.tx_urb_max =3D ES58X_TX_URBS_MAX
> +	.tx_urb_max =3D ES58X_TX_URBS_MAX,
> +	.prod_info_delim =3D ','

Nitpick: you can add a trailing "," here, makes the diff smaller on the
next change :)

>  };
> =20
>  const struct es58x_operators es581_4_ops =3D {
> diff --git a/drivers/net/can/usb/etas_es58x/es58x_core.c b/drivers/net/ca=
n/usb/etas_es58x/es58x_core.c
> index 51294b717040..7c20a73169f3 100644
> --- a/drivers/net/can/usb/etas_es58x/es58x_core.c
> +++ b/drivers/net/can/usb/etas_es58x/es58x_core.c
> @@ -7,7 +7,7 @@
>   *
>   * Copyright (c) 2019 Robert Bosch Engineering and Business Solutions. A=
ll rights reserved.
>   * Copyright (c) 2020 ETAS K.K.. All rights reserved.
> - * Copyright (c) 2020, 2021 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> + * Copyright (c) 2020-2022 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
>   */
> =20
>  #include <linux/ethtool.h>
> @@ -1978,10 +1978,6 @@ static const struct net_device_ops es58x_netdev_op=
s =3D {
>  	.ndo_eth_ioctl =3D can_eth_ioctl_hwts,
>  };
> =20
> -static const struct ethtool_ops es58x_ethtool_ops =3D {
> -	.get_ts_info =3D can_ethtool_op_get_ts_info_hwts,
> -};
> -
>  /**
>   * es58x_set_mode() - Change network device mode.
>   * @netdev: CAN network device.
> @@ -2062,6 +2058,96 @@ static void es58x_init_priv(struct es58x_device *e=
s58x_dev,
>  	can->do_set_mode =3D es58x_set_mode;
>  }
> =20
> +/**
> + * es58x_get_product_info() - Get the product information.
> + * @es58x_dev: ES58X device.
> + * @prod_info: Buffer where to store the product information.
> + * @prod_info_len: Length of @prod_info.
> + *
> + * Do a synchronous call to get the product information.
> + *
> + * Return: zero on success, errno when any error occurs.
> + */
> +static int es58x_get_product_info(struct es58x_device *es58x_dev,
> +				  char *prod_info, size_t prod_info_len)
> +{
> +	struct usb_device *udev =3D es58x_dev->udev;
> +	const int es58x_prod_info_idx =3D 6;
> +	int ret;
> +
> +	ret =3D usb_string(udev, es58x_prod_info_idx, prod_info, prod_info_len);
> +	if (ret < 0) {
> +		dev_err(es58x_dev->dev,
> +			"%s: Could not read the product info: %pe\n",
> +			__func__, ERR_PTR(ret));
> +		return ret;
> +	}
> +	if (ret >=3D prod_info_len - 1) {
> +		dev_warn(es58x_dev->dev,
> +			 "%s: Buffer is too small, result might be truncated\n",
> +			 __func__);
> +	}

You can use usb_cache_string() that puts the requested string into a
kmalloc()ed buffer:

| https://elixir.bootlin.com/linux/v6.0/source/drivers/usb/core/message.c#L=
1018

=2E..and avoids having the large stack frame.

> +
> +	return 0;
> +}
> +
> +/**
> + * es58x_print_product_info() - Print the product information.
> + * @es58x_dev: ES58X device.
> + *
> + * Return: zero on success, errno when any error occurs.
> + */
> +static int es58x_print_product_info(struct es58x_device *es58x_dev)
> +{
> +	char prod_info[ES58X_USB_STRING_SIZE];

Stack size in the kernel is limited.

> +	int ret;
> +
> +	ret =3D es58x_get_product_info(es58x_dev, prod_info, sizeof(prod_info));
> +	if (ret =3D=3D 0)
> +		dev_info(es58x_dev->dev, "Product info: %s\n", prod_info);
> +
> +	return ret;
> +}
> +
> +/**
> + * es58x_get_drvinfo() - Get the driver name and firmware version.
> + * @netdev: CAN network device.
> + * @drvinfo: Driver information.
> + *
> + * Populate @drvinfo with the driver name and the firwmware version.
> + */
> +static void es58x_get_drvinfo(struct net_device *netdev,
> +			      struct ethtool_drvinfo *drvinfo)
> +{
> +	struct es58x_device *es58x_dev =3D es58x_priv(netdev)->es58x_dev;
> +	char prod_info[ES58X_USB_STRING_SIZE];
> +	char *start, *end;
> +
> +	strscpy(drvinfo->driver, KBUILD_MODNAME, sizeof(drvinfo->driver));
> +
> +	if (es58x_get_product_info(es58x_dev, prod_info, sizeof(prod_info)) < 0)
> +		return;
> +
> +	/* The firmware prefix is either "FW_V" or "FW:" */
> +	start =3D strstr(prod_info, "FW");
> +	if (!start)
> +		return;
> +	/* Go to first digit */
> +	while (!isdigit(*start))
> +		start++;

Don't trust the input. Check for end of string before accessing it.

> +
> +	end =3D strchr(start, es58x_dev->param->prod_info_delim);
> +	if (!end || end - start >=3D sizeof(drvinfo->fw_version))
> +		return;
> +
> +	strscpy(drvinfo->fw_version, start, end - start + 1);

Are you misusing strscpy() here? The last parameter should be the size
of the dest buffer, not the src buffer.

> +}
> +
> +static const struct ethtool_ops es58x_ethtool_ops =3D {
> +	.get_drvinfo =3D es58x_get_drvinfo,
> +	.get_ts_info =3D can_ethtool_op_get_ts_info_hwts,
> +};
> +
>  /**
>   * es58x_init_netdev() - Initialize the network device.
>   * @es58x_dev: ES58X device.
> @@ -2119,48 +2205,6 @@ static void es58x_free_netdevs(struct es58x_device=
 *es58x_dev)
>  	}
>  }
> =20
> -/**
> - * es58x_get_product_info() - Get the product information and print them.
> - * @es58x_dev: ES58X device.
> - *
> - * Do a synchronous call to get the product information.
> - *
> - * Return: zero on success, errno when any error occurs.
> - */
> -static int es58x_get_product_info(struct es58x_device *es58x_dev)
> -{
> -	struct usb_device *udev =3D es58x_dev->udev;
> -	const int es58x_prod_info_idx =3D 6;
> -	/* Empirical tests show a prod_info length of maximum 83,
> -	 * below should be more than enough.
> -	 */
> -	const size_t prod_info_len =3D 127;
> -	char *prod_info;
> -	int ret;
> -
> -	prod_info =3D kmalloc(prod_info_len, GFP_KERNEL);
> -	if (!prod_info)
> -		return -ENOMEM;
> -
> -	ret =3D usb_string(udev, es58x_prod_info_idx, prod_info, prod_info_len);
> -	if (ret < 0) {
> -		dev_err(es58x_dev->dev,
> -			"%s: Could not read the product info: %pe\n",
> -			__func__, ERR_PTR(ret));
> -		goto out_free;
> -	}
> -	if (ret >=3D prod_info_len - 1) {
> -		dev_warn(es58x_dev->dev,
> -			 "%s: Buffer is too small, result might be truncated\n",
> -			 __func__);
> -	}
> -	dev_info(es58x_dev->dev, "Product info: %s\n", prod_info);
> -
> - out_free:
> -	kfree(prod_info);
> -	return ret < 0 ? ret : 0;
> -}
> -
>  /**
>   * es58x_init_es58x_dev() - Initialize the ES58X device.
>   * @intf: USB interface.
> @@ -2243,7 +2287,7 @@ static int es58x_probe(struct usb_interface *intf,
>  	if (IS_ERR(es58x_dev))
>  		return PTR_ERR(es58x_dev);
> =20
> -	ret =3D es58x_get_product_info(es58x_dev);
> +	ret =3D es58x_print_product_info(es58x_dev);
>  	if (ret)
>  		return ret;
> =20
> diff --git a/drivers/net/can/usb/etas_es58x/es58x_core.h b/drivers/net/ca=
n/usb/etas_es58x/es58x_core.h
> index 640fe0a1df63..3a9f6582c06d 100644
> --- a/drivers/net/can/usb/etas_es58x/es58x_core.h
> +++ b/drivers/net/can/usb/etas_es58x/es58x_core.h
> @@ -6,7 +6,7 @@
>   *
>   * Copyright (c) 2019 Robert Bosch Engineering and Business Solutions. A=
ll rights reserved.
>   * Copyright (c) 2020 ETAS K.K.. All rights reserved.
> - * Copyright (c) 2020, 2021 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> + * Copyright (c) 2020-2022 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
>   */
> =20
>  #ifndef __ES58X_COMMON_H__
> @@ -49,6 +49,12 @@
>  /* A magic number sent by the ES581.4 to inform it is alive. */
>  #define ES58X_HEARTBEAT 0x11
> =20
> +/* USB strings are at most 127 characters and es58x devices only use
> + * ASCII (i.e. one byte). Also, the maximum observed length is 83
> + * bytes.
> + */
> +#define ES58X_USB_STRING_SIZE (127 + 1)
> +
>  /**
>   * enum es58x_driver_info - Quirks of the device.
>   * @ES58X_DUAL_CHANNEL: Device has two CAN channels. If this flag is
> @@ -306,6 +312,8 @@ struct es58x_priv {
>   * @urb_cmd_header_len: Length of the URB command header.
>   * @rx_urb_max: Number of RX URB to be allocated during device probe.
>   * @tx_urb_max: Number of TX URB to be allocated during device probe.
> + * @prod_info_delim: delimiter of the different fields in the USB
> + *	product information string.
>   */
>  struct es58x_parameters {
>  	const struct can_bittiming_const *bittiming_const;
> @@ -324,6 +332,7 @@ struct es58x_parameters {
>  	u8 urb_cmd_header_len;
>  	u8 rx_urb_max;
>  	u8 tx_urb_max;
> +	char prod_info_delim;
>  };
> =20
>  /**
> diff --git a/drivers/net/can/usb/etas_es58x/es58x_fd.c b/drivers/net/can/=
usb/etas_es58x/es58x_fd.c
> index c97ffa71fd75..3d781b89df4a 100644
> --- a/drivers/net/can/usb/etas_es58x/es58x_fd.c
> +++ b/drivers/net/can/usb/etas_es58x/es58x_fd.c
> @@ -8,7 +8,7 @@
>   *
>   * Copyright (c) 2019 Robert Bosch Engineering and Business Solutions. A=
ll rights reserved.
>   * Copyright (c) 2020 ETAS K.K.. All rights reserved.
> - * Copyright (c) 2020, 2021 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> + * Copyright (c) 2020-2022 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
>   */
> =20
>  #include <linux/kernel.h>
> @@ -550,7 +550,8 @@ const struct es58x_parameters es58x_fd_param =3D {
>  	.tx_bulk_max =3D ES58X_FD_TX_BULK_MAX,
>  	.urb_cmd_header_len =3D ES58X_FD_URB_CMD_HEADER_LEN,
>  	.rx_urb_max =3D ES58X_RX_URBS_MAX,
> -	.tx_urb_max =3D ES58X_TX_URBS_MAX
> +	.tx_urb_max =3D ES58X_TX_URBS_MAX,
> +	.prod_info_delim =3D '-'
>  };
> =20
>  const struct es58x_operators es58x_fd_ops =3D {
> --=20
> 2.37.4

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--pe2igov4xrzd5dah
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmNk/OgACgkQrX5LkNig
0122rggApdQk1+LSgFh4UUKtQwxAg45Ufi3VXGvTZ48AnBlGNojLsrjVpKLkHk+H
r9LjpvNtAUameA4gNlzEmnaVvaApcaGa8tk1dc/EypQmXsKedzf5HG/gy7G/MrfI
xVPuQbM7U2iDrKkrbFSYKmWj/ElC7AmfgDYx9v2+lqlN1HtAHHTlvS4JcMCq3Y5o
9NHA4BAMOEcmCzAP+xMfeH23KwYF3pOIiTPqsNYcqJADv8mz4UBaHxut5QS7pqjk
N3KegZHLC7etrZ+NxHC/83BVNsstsIhpEjZZlWMvwlawDktUr59B6/Y1GcpkHdrV
pgzSNLLgr90fseiDAJ6fXLd9bUuLbQ==
=l+aB
-----END PGP SIGNATURE-----

--pe2igov4xrzd5dah--

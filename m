Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 357645F2479
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 20:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbiJBSGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 14:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiJBSGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 14:06:15 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7EE23A498
        for <linux-kernel@vger.kernel.org>; Sun,  2 Oct 2022 11:06:13 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mgr@pengutronix.de>)
        id 1of3Lh-0002AG-Tz; Sun, 02 Oct 2022 20:05:57 +0200
Received: from mgr by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mgr@pengutronix.de>)
        id 1of3Lg-0003mI-UG; Sun, 02 Oct 2022 20:05:56 +0200
Date:   Sun, 2 Oct 2022 20:05:56 +0200
From:   Michael Grzeschik <mgr@pengutronix.de>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: uvc: Fix clearing of vdev
Message-ID: <20221002180556.GB19990@pengutronix.de>
References: <20221002174430.3065870-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OwLcNYc0lM97+oe1"
Content-Disposition: inline
In-Reply-To: <20221002174430.3065870-1-linux@roeck-us.net>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mgr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OwLcNYc0lM97+oe1
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Guenter!

Thanks for the Patch.

On Sun, Oct 02, 2022 at 10:44:30AM -0700, Guenter Roeck wrote:
>Commit e4ce9ed835bc ("usb: gadget: uvc: ensure the vdev is unset")
>introduced code to clear the video device on video device registration.
>However, it uses sizeof(uvc->video) instead of sizeof(uvc->vdev) to clear
>uvc->vdev. This may result in the following build error.
>
>In function 'fortify_memset_chk',
>    inlined from 'uvc_register_video'
>    at drivers/usb/gadget/function/f_uvc.c:424:2:
>include/linux/fortify-string.h:301:25: error:
>	call to '__write_overflow_field' declared with attribute warning:
>		detected write beyond size of field
>
>The problem is exposed by commit 9b91a6523078 ("usb: gadget: uvc: increase
>worker prio to WQ_HIGHPRI") which increases the size of struct uvc_video.
>
>Fixes: e4ce9ed835bc ("usb: gadget: uvc: ensure the vdev is unset")
>Cc: Michael Grzeschik <m.grzeschik@pengutronix.de>
>Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>---
> drivers/usb/gadget/function/f_uvc.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/usb/gadget/function/f_uvc.c b/drivers/usb/gadget/func=
tion/f_uvc.c
>index e6948cf8def3..836601227155 100644
>--- a/drivers/usb/gadget/function/f_uvc.c
>+++ b/drivers/usb/gadget/function/f_uvc.c
>@@ -421,7 +421,7 @@ uvc_register_video(struct uvc_device *uvc)
> 	int ret;
>
> 	/* TODO reference counting. */
>-	memset(&uvc->vdev, 0, sizeof(uvc->video));
>+	memset(&uvc->vdev, 0, sizeof(uvc->vdev));
> 	uvc->vdev.v4l2_dev =3D &uvc->v4l2_dev;
> 	uvc->vdev.v4l2_dev->dev =3D &cdev->gadget->dev;
> 	uvc->vdev.fops =3D &uvc_v4l2_fops;
>--=20
>2.36.2

This was already addressed by the following patch some days ago.

https://lore.kernel.org/linux-usb/202209290106.E6EFD95D4@keescook/T/#t

Thanks,
Michael

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--OwLcNYc0lM97+oe1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElXvEUs6VPX6mDPT8C+njFXoeLGQFAmM50wIACgkQC+njFXoe
LGRSrg//VArKntf4kpQ2tKi+1yNBR18vZfhU67VSAbnM/XnlF7zyKdCdxUahXCsk
viJWZHvDyQ8GDhQxC0CZQbvrA2SCHsOUsXEJWwGWg+wqsRwE0m39iBzT32XfmV8f
h3Tden7szeEjfT+h9sar7ibIBZEGfwNgLnG6NOEabeI2ABJyxVrnMfA+B36hcEWE
BoW2MHoo2Fnv/vAOMHr+b0WRRWsyShW+0ciM8sgEw0IVhsQdm2WIo/8vYz3JHUFH
wneYnyCUVlTJm7dj0PoxrjPoZRCd3xL46CAJSpVe35wUI5beyEEFWcoDyM/dlOvM
K4D5GaDW6FbLf3loAfumtpE05nUvciLdLMfkqogf/Dr8UwiXxwCDHyx8VIyCOxwB
Gt7io2NbAZwlgpdtKwRAwsEqVp09HubI/FW1tBvQ3wa/h6ed3gYfycKEYjAOMwX0
jiJzWeQvULkECmCcflosV28W3H3eJnTdOcH7ZYoTfWZktGooS8WzzRyldSFlJ1h2
YXDdpI7kNg7tOxOPg8lZdSx2GceN9YbcDM8OukvfYnuZmscAWw2e4dqmbmxiXHeL
lHmo+sjxjesrkCwkgd9EH/Po9kgHe9PfHk/VROirb46JS1S/t6uFPmsrBmkOfuvM
v7ZnIw19fCELrCup8vqSlruaGizBYK+y7SzOHU1b0V870aFrlTI=
=SUhP
-----END PGP SIGNATURE-----

--OwLcNYc0lM97+oe1--

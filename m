Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF3D270590E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 22:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjEPUoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 16:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjEPUo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 16:44:28 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C191FFE;
        Tue, 16 May 2023 13:44:27 -0700 (PDT)
Received: from mercury (unknown [185.209.196.239])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 254A8660298C;
        Tue, 16 May 2023 21:44:26 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1684269866;
        bh=I7KXLZTgJ4zrYUvvkCc2P3Hif13L3bHyvvcy0tpFK7Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n6jzj8Us9bbAb9V52JGJDcSLdCSo8H4iZU+wTPIeq/ReQ8uLNRP3yRtJfT+IRhVmm
         36yTeG5KbLiU4r2RxggQ8SreivmjO/1rrIrgGQ/YyYfrIhhn4aN5S4it+Wl68qsq3Y
         RnAAuE5I5c10697VoNp0HpFJ6KjsmCY/gGSB+G0jmQSj88DcdOwkKiF25ZA/6by6pB
         VBFTo7D6DS1e28YzCvhBHblOZl0QmgrcPP0UkAo8K9TnS8rWN06/V7g8UjIiteqXN8
         bJGyWAuJiC5V5AOxK/OxEYHYyadXCM7ydFUtuePmZsEU8qdQmfrRtraC0OM+IJ2mEk
         JjZdM+iQJnCTg==
Received: by mercury (Postfix, from userid 1000)
        id 4BCCE10623DF; Tue, 16 May 2023 22:44:23 +0200 (CEST)
Date:   Tue, 16 May 2023 22:44:23 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: hide unused usbfs_notify_suspend/resume functions
Message-ID: <20230516204423.ffnkpj3sxqjqcf6k@mercury.elektranox.org>
References: <20230516202103.558301-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5xcgqfv34dhd5wj5"
Content-Disposition: inline
In-Reply-To: <20230516202103.558301-1-arnd@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5xcgqfv34dhd5wj5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, May 16, 2023 at 10:17:42PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> The declaration is in an #ifdef, which causes warnings when building
> with 'make W=3D1' and without CONFIG_PM:
>=20
> drivers/usb/core/devio.c:742:6: error: no previous prototype for 'usbfs_n=
otify_suspend'
> drivers/usb/core/devio.c:747:6: error: no previous prototype for 'usbfs_n=
otify_resume'
>=20
> Use the same #ifdef check around the function definitions to avoid
> the warnings and slightly shrink the USB core.
>=20
> Fixes: 7794f486ed0b ("usbfs: Add ioctls for runtime power management")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

I have no clue why I'm CC'd, but patch LGTM:

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  drivers/usb/core/devio.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
> index e501a03d6c70..1622ad35428d 100644
> --- a/drivers/usb/core/devio.c
> +++ b/drivers/usb/core/devio.c
> @@ -738,6 +738,7 @@ static int driver_resume(struct usb_interface *intf)
>  	return 0;
>  }
> =20
> +#ifdef CONFIG_PM
>  /* The following routines apply to the entire device, not interfaces */
>  void usbfs_notify_suspend(struct usb_device *udev)
>  {
> @@ -756,6 +757,7 @@ void usbfs_notify_resume(struct usb_device *udev)
>  	}
>  	mutex_unlock(&usbfs_mutex);
>  }
> +#endif
> =20
>  struct usb_driver usbfs_driver =3D {
>  	.name =3D		"usbfs",
> --=20
> 2.39.2
>=20

--5xcgqfv34dhd5wj5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmRj6yYACgkQ2O7X88g7
+pp0OQ//ZQss/5uMjQhEjQpfxrBJo5eLerF64z8T+gqnbV1wM6ae+NMmOpDpd8/U
rd19ODVBYvA98Hv7MTWrTfD5vQZ0s11q5yuEgJIQjKMxEzhi549A8Kv0c3/ehRSB
doALXrcqogFTbT0etk7nN/2ViRUQc4GAi2AERUG81ZXknBwIRMWjTVsF9UlZ0LFD
6LNpo1rnpC+f7iu21WcznTrjUxsQD9K0v5BSSXga265V4Smay62Z1GEYxWT2ouws
xtiE21k2az/6Jty3YLiuxW6v09SOjxlOWiNRP3ImvE4gzRu8w/1Dr9da6L5CMAKZ
KPOe9rXuRsZHU9kAdCZm6CiyCYCenSWQ0zXz2qmVhEVbtZ83ob9o/sLHas5FjcZX
87u5IxGXaPqG6jGn+XphlTLBn2Ba8G5ZK9bQeo9EWKWNUh2iEm/vCb4Znvmyeycq
c8nqDAk1K6waUZxbjQBmxG7dJoR27lcjCcImwWQqerRtmiywVnM5w8YRrhWiWv25
0H03nZHdbYXauYSaM1+G1RZJcgrIsHQk9biANauo6Gf8EOr5FeFuloXuWECiaWjR
vB2bhCCkLLzbX5Cf3F+kc7vc6DYKFS1R776VArrIYcQ7Nb0NxunhhvBHKA4Jj9rv
AKndSA5CHyLqcx694goFaHGRmhpeH8lDz1VLGSQC7jPFw22KT1E=
=JcHR
-----END PGP SIGNATURE-----

--5xcgqfv34dhd5wj5--

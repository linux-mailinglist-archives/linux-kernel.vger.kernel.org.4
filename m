Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53D686C66AF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 12:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbjCWLeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 07:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbjCWLdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 07:33:47 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E5230B35;
        Thu, 23 Mar 2023 04:33:41 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 9E0261C0E45; Thu, 23 Mar 2023 12:33:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1679571219;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9nIoTOf+aBh7wDZ3L9p1FQFEmX4vdpHOItLw07ujFBg=;
        b=OmycBx7+lc5RNazv7e3RB0IrGvQWwPSO4JEHqcJc81WUZpF1foR6T9BCoOybODGzIXxAIP
        cP31fawzYf5fewU8qD4RiX9DJg4Mnx9lgp/Rf6/tg2rcwDOJZReudKYHYLWq7eetTiIV8y
        RW2HObJpQtjcBfSmx3AmAW0UF5qV2WU=
Date:   Thu, 23 Mar 2023 12:33:39 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Joseph Strauss <jstrauss@mailbox.org>
Cc:     lee@kernel.org, jansimon.moeller@gmx.de, conor@kernel.org,
        christophe.jaillet@wanadoo.fr, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Add multicolor support to BlinkM LED driver
Message-ID: <ZBw5E4ecNvfgd0RB@duo.ucw.cz>
References: <20221228010958.9670-1-jstrauss@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="bsx+dbfh8TSfU6VM"
Content-Disposition: inline
In-Reply-To: <20221228010958.9670-1-jstrauss@mailbox.org>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bsx+dbfh8TSfU6VM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> In the blinkm_probe function, the multicolor LED class is registered
> after the regular LED classes. The blinkm_set_mc_brightness() function
> had to be added to calculate the three color components and then set the
> fields of the blinkm_data structure accordingly.

It needs to be either single multicolor LED or three separate
LEDs. But not both at the same time.

> +++ b/Documentation/leds/leds-blinkm.rst
> @@ -13,9 +13,27 @@ The device accepts RGB and HSB color values through se=
parate commands.
>  Also you can store blinking sequences as "scripts" in
>  the controller and run them. Also fading is an option.
> =20
> -The interface this driver provides is 2-fold:
> +The interface this driver provides is 3-fold:
> =20
> -a) LED class interface for use with triggers
> +a) LED multicolor class interface for use with triggers
> +#######################################################
> +
> +The registration follows the scheme::
> +
> +  blinkm-<i2c-bus-nr>-<i2c-device-nr>-multi
> +
> +  $ ls -h /sys/class/leds/blinkm-1-9-multi
> +  brightness  device  max_brightness  multi_index  multi_intensity  powe=
r  subsystem  trigger  uevent
> +

Yeah, that does not really match the
naming. /sys/class/leds/blinkm-1-9:rgb:indicator ? See
Documentation/leds/well-known-leds.txt and possibly extend it so that
future general-purpose LEDs use similar naming.=20

> +b) LED class interface for use with triggers
>  ############################################
>

So the b) should be removed.

> =20
> -b) Sysfs group to control rgb, fade, hsb, scripts ...
> +c) Sysfs group to control rgb, fade, hsb, scripts ...
>  #####################################################
>

And c) should be deprecated and removed in future.

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--bsx+dbfh8TSfU6VM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZBw5EwAKCRAw5/Bqldv6
8uNUAKCrHOUyebPbRqUpmizwUYiOHnYruACgnShycXKCmr31mqT4M9r2pRsUDZk=
=iebB
-----END PGP SIGNATURE-----

--bsx+dbfh8TSfU6VM--

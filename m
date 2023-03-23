Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFAA96C670B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 12:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbjCWLqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 07:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbjCWLqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 07:46:53 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2DF030B09;
        Thu, 23 Mar 2023 04:46:52 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id B850D1C0E45; Thu, 23 Mar 2023 12:46:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1679572011;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k0rrIvndFDk2UOKYFKfhmbgQ2OShZHYtdx/lmRxqCsI=;
        b=B4nklH9msojf8m6XTHzD04Hi0iBL4hGsnxkDsCXlp6meILDSgRM4e6uIF21lGD2WR8rJwO
        lLaZk4QXxCrzJSzyfGxr3o3hCI0obMg3oYEEOA9eeqDh2Lcl0diOugZ1ET5QU/PS8ETkdh
        tGPD0VTucYf1px0Er2zhCWJRFKJGvb8=
Date:   Thu, 23 Mar 2023 12:46:51 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     Lee Jones <lee@kernel.org>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH 2/2] leds: max597x: Add support for max597x
Message-ID: <ZBw8K/YwrQZzt3BP@duo.ucw.cz>
References: <20230322124316.2147143-1-Naresh.Solanki@9elements.com>
 <20230322124316.2147143-2-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="WvSCQyaudfTEwz4M"
Content-Disposition: inline
In-Reply-To: <20230322124316.2147143-2-Naresh.Solanki@9elements.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WvSCQyaudfTEwz4M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> max597x is hot swap controller with indication led support.
> This driver uses DT property to configure led during boot time &
> also provide the led control in sysfs.

Can you provide dts example showing how you'll use it?

> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>

> +static int max597x_setup_led(struct device *dev, struct regmap *regmap, =
struct device_node *nc,
> +			     u32 reg)
> +{
=2E..
> +	ret =3D led_classdev_register(dev, &led->led);
> +	return 0;
> +}
> +
> +static int max597x_led_probe(struct platform_device *pdev)
> +{
=2E..
> +	for_each_available_child_of_node(led_node, child) {
> +		u32 reg;
> +
> +		if (of_property_read_u32(child, "reg", &reg))
> +			continue;
> +
> +		if (reg >=3D MAX597X_NUM_LEDS) {
> +			dev_err(&i2c->dev, "invalid LED (%u >=3D %d)\n", reg,
> +				MAX597X_NUM_LEDS);
> +			continue;
> +		}
> +
> +		ret =3D max597x_setup_led(&i2c->dev, regmap, child, reg);
> +		if (ret < 0) {
> +			of_node_put(child);
> +			return ret;
> +		}

This will cause crashes. After you successfully registered one LED,
you can't just bail out.

BR,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--WvSCQyaudfTEwz4M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZBw8KwAKCRAw5/Bqldv6
8r+4AJ9ueTFs2ZtMyw+f+QrsDX6XsZKc2ACcDQ/MIxL3p+o+WwJ0oFt/r3gvAAw=
=4Jjm
-----END PGP SIGNATURE-----

--WvSCQyaudfTEwz4M--

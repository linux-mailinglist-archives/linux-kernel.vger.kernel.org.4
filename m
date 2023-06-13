Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B145972E59E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 16:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242582AbjFMOWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 10:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235921AbjFMOWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 10:22:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06194EC;
        Tue, 13 Jun 2023 07:22:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0BFFA61846;
        Tue, 13 Jun 2023 14:22:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4A36C433F0;
        Tue, 13 Jun 2023 14:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686666160;
        bh=HhYD3JuRz7if0a7jlwfSjRUiZkCdi6uHJj+m0ZT47eY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oYkGKbz3KDGxIF/jJ+H42/VW/4dh3/H1Pr7VP7xpcU/Op/lhjsE3P0FQaWooW9w4Y
         iulaEOir/bzBNzwWsRIo4Z+e9qCdni7QS2JuVmKxPgRnQmooNJCmgTqNKTvlTxHRzG
         qDvimneaSLuBcObl6xmle2Z1yz32Joy/v+GN6z4rBxKbwmW3Q9VlPO7tZ9/7Z7VYVc
         j68hoGMLZ5gyF699eKVghzXc4BWeAGIJlpMgqaPDE98PL/tjltE2uKmclCD5FDT9Er
         Rc3X297eSltupFIUVzVXeiRXkHQq/RvNz9Qz9JqnhJBD2x7Sj+SHuN1+m1H5ZAd/Vq
         37qe9M6MUPVhQ==
Date:   Tue, 13 Jun 2023 15:22:35 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Okan Sahin <okan.sahin@analog.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v1 2/2] regulator: max77857: Add ADI MAX77857/MAX77831
 Regulator Support
Message-ID: <6e75f1b5-db99-43c8-aae9-132269b2eb89@sirena.org.uk>
References: <20230613080552.4492-1-okan.sahin@analog.com>
 <20230613080552.4492-3-okan.sahin@analog.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="O1QQbi+LWYO5tBXP"
Content-Disposition: inline
In-Reply-To: <20230613080552.4492-3-okan.sahin@analog.com>
X-Cookie: Not a flying toy.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--O1QQbi+LWYO5tBXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 13, 2023 at 11:05:50AM +0300, Okan Sahin wrote:

> +struct regmap_config max77857_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.cache_type = REGCACHE_RBTREE,

Please use the more modern REGCACHE_MAPLE for new devices.

> +static irqreturn_t max77857_irq_handler(int irq, void *data)
> +{
> +	struct regulator_dev *rdev = data;
> +	enum max77857_id id = (enum max77857_id)rdev_get_drvdata(rdev);
> +	struct device *dev = &rdev->dev;
> +	unsigned long flags = 0;
> +	unsigned int status;
> +	int ret;
> +
> +	switch (id) {
> +	case ID_MAX77831:
> +	case ID_MAX77857:
> +		ret = regmap_read(rdev->regmap, MAX77857_REG_INT_SRC, &status);
> +		break;
> +	default:
> +		return IRQ_HANDLED;
> +	}

We just completely ignore the interrupt if it's not one of the supported
devices, that seems wrong - it looks likee those devices don't have the
support for interrupts at all and so should never get here?  If the
interrupt does go off then this is likely to lead to problems.  I think
it'd be better if the driver just didn't request the interrupt for
devices that it doesn't support interrupts for, if there's no interrupt
support in the hardware for those it could also complain if one is
specified though that's optional.

> +	if (ret) {
> +		dev_err(dev, "cannot read status\n");
> +		return IRQ_HANDLED;
> +	}

IRQ_NONE.

--O1QQbi+LWYO5tBXP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSIe6oACgkQJNaLcl1U
h9CuNQf+KFgyY6janu6dhTtJn4QR9TZ65kzcshdAxrYQ37D1QUPNq8H2MUfnMoMW
K19+vVoPm9DfKAFyasTEk4vhzSWqu+uWiIXwC1NWUq29JyPKq0NIzaxPIgLCgDi/
ZDGBCwYg9yZE7Y3Gu6vQoo6Xn9u5mCYX4HWKcFNGFPHNuASC213kPMPeLx/S8UkS
OjzW0s9LPYrm/Dq/ZGcL6lkNBixD0gqjarU2HsA14hqWhnIR9+NfbboScNRv1o2a
6AHKQVY29PCJ2ndCPqWQeZBOCZXZatL46OlbhnrUER0aGtsw+oJzpI+jXBBIThZw
XGzBa1k2sxE4zeEC7KA4qVNpnHKhcg==
=OgFa
-----END PGP SIGNATURE-----

--O1QQbi+LWYO5tBXP--

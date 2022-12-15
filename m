Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 826B864DEF6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 17:48:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbiLOQsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 11:48:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbiLOQsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 11:48:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB0B628E3F;
        Thu, 15 Dec 2022 08:48:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A89A3B81AAC;
        Thu, 15 Dec 2022 16:48:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 248B5C433EF;
        Thu, 15 Dec 2022 16:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671122895;
        bh=k/MuK0maRjEn29AKxj/xZEEoOcdxA4jI1I+IlWSsZMY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EgUkCLCkQXn8qF9Azhe1zQlsqQLde3VKZTBMpvKcGsE+yUCeDih24OfkcD/k70Nt7
         h1RLbTGT1PhuV9QOBvpWxhFmnltr3b2WbHx133tH5qTG7pXuc0OJSsvvQzFfgF1xpe
         A8Ytv3EgCrvF5+u2zfw0gQZEsdrDwA7SFa6NJ5gIAERqyKF52ZVxdrzihjH1iR074y
         SK2uG0CcQT73QwbhN3Y3RSOOaHlf1l1ndGYlNfS0oHGcPNouwhYpKCpHSrNS7CIIy8
         mLPky/9aYm8GYPUpH7nyTi88LWqaz5MQR0tvFiUeKIRUuv5qMVDtv+8AZd0elbzJCp
         SelXn06irKtpw==
Date:   Thu, 15 Dec 2022 16:48:08 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Tony Lindgren <tony@atomide.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jerome Neanne <jneanne@baylibre.com>,
        Arnd Bergmann <arnd@arndb.de>, Axel Lin <axel.lin@ingics.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: tps65219: fix Wextra warning
Message-ID: <Y5tPyOqSNud7LumS@sirena.org.uk>
References: <20221215164140.821796-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CNY87ZmGG8e5pMia"
Content-Disposition: inline
In-Reply-To: <20221215164140.821796-1-arnd@kernel.org>
X-Cookie: Today is what happened to yesterday.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CNY87ZmGG8e5pMia
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 15, 2022 at 05:41:28PM +0100, Arnd Bergmann wrote:

> -		tps65219_get_rdev_by_name(irq_type->regulator_name, rdevtbl, rdev);
> -		if (rdev < 0) {
> +		error = tps65219_get_rdev_by_name(irq_type->regulator_name, rdevtbl, rdev);
> +		if (error) {
>  			dev_err(tps->dev, "Failed to get rdev for %s\n",
>  				irq_type->regulator_name);
> -			return -EINVAL;
> +			return error;

This will shut up the warning but is leaving the use of the
uninitialised rdev (which I'm kind of disappointed the static checkers
didn't pick up on).  rdev needs to be passed by reference into the
function, or set from the return value.

--CNY87ZmGG8e5pMia
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmObT8gACgkQJNaLcl1U
h9A56wf+KMJeJLzvGylmGlwpC+1nI1ay6zHq3+IQlWP2UfgwCxdPQh/ACRlpHxvu
HzO/0yvtKoVHfqSYZULSfe+w2tgH9IcICUubXxFRbquoEifpw0MJG8vzXk3zQpHD
dBj4f9Ycur/1LCF/c5OUeV+L0nwJ3NTY8u64VfqiVaaC4gJQ/XK3TM+c1qJsfyX6
kZCDcxmBhbFWm3jFzhKyNT1WGZC7jSffNCJUSal8hXBrHoV0PCfVME1m8cxUtub+
S/f7PGKOjTjg8hM3plzTkTW0tTKxazJ4rOzJOiFbgUIZQttnIYcMc4c0iAloGv0z
6n32PLZbiY4rcthDpV8JdQdvVAF9og==
=aj/9
-----END PGP SIGNATURE-----

--CNY87ZmGG8e5pMia--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEC4663EFC1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 12:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbiLALne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 06:43:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbiLALn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 06:43:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8768895804
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 03:43:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA4B361FAD
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 11:43:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 093FDC433D6;
        Thu,  1 Dec 2022 11:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669895004;
        bh=b32humZu+PKcy8aKXenWyUF4vn9xYLfzYQwwwXYV6iM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZNmP9cYw7XrR9Fi8RI2ERKG09CjpM13Han0ROS4DngQb9nsxxEjbE2m3By5K6nflD
         yN52W8Cn8A2smqxX/2MlNHsGPsEBe6F7ZGzwV6Lq9alN+zR2CX84B1mLnWsEk2jCoW
         QvQI9lE4tlVpwAO6xrmEnqnaqMv2VflFwll5IyFG4lqVhTJlGuGmW5ppnKDzSYuTz7
         JZr/JDu9q9IVVmHzdnB3GAHmbwMFYRbM3/4pCX+nRadpcmZMA9qQCkd5dvCbahW7YN
         CSzOQKTUzQ4EMZspOGw6dz2qrVgVMC+b4KGjCjbZ/E3DKYxuYOGuhDlX1N1yl6Bj7P
         Cnz1T2Si1AMKg==
Date:   Thu, 1 Dec 2022 11:43:18 +0000
From:   Mark Brown <broonie@kernel.org>
To:     cy_huang <u0084500@gmail.com>
Cc:     lgirdwood@gmail.com, lee@kernel.org, matthias.bgg@gmail.com,
        yangyingliang@huawei.com, chiaen_wu@richtek.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        ChiYuan Huang <cy_huang@richtek.com>
Subject: Re: [PATCH 1/2] regulator: mt6370: Fix potential UAF issue
Message-ID: <Y4iTVmOA5P/aN2yb@sirena.org.uk>
References: <1669797463-24887-1-git-send-email-u0084500@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jonyXJ7Ofmg6Ee47"
Content-Disposition: inline
In-Reply-To: <1669797463-24887-1-git-send-email-u0084500@gmail.com>
X-Cookie: Isn't this my STOP?!
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jonyXJ7Ofmg6Ee47
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 30, 2022 at 04:37:42PM +0800, cy_huang wrote:

> The original code uses i2c dev as the parent in order to reuse
> the 'regulator_of_get_init_data'. But this will cause regulation
> constraint devres attached to i2c dev, not the mfd cell platform
> device.

This is a general issue which will affect a lot of MFDs, we would be
better to fix this by changing the API to provide a device to be used
for the devres allocations separately to the one used for looking up the
DT.

--jonyXJ7Ofmg6Ee47
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmOIk1YACgkQJNaLcl1U
h9CAEAf+OLCtX/qUZlN1eE3kJF4yWWC2wCV8ARG5w6+YoIv3EjUJGyHkXsdCQ9KP
D4nDhttbavKDqseq+3MXE8WpQBqjpH0ib8cjpwrRKgnyREOpkcKRDLGMbZjiN54Y
iiCizyQeZc4YKjgO3/If3xwrXhx1pScpT1wm5KJPj/pd7EaZUrReHtf6oZpvRL/4
jiqXoqOwZLVaq4xP1rBY/NAgk6Dxt8RwxfjoiDBXXj8i7lbpAIuEn6ytL2DVPj5Q
HDEJ5jB+ezP2OuPEVsc1Y1U0pCdJW6qDHilWbz2iwcwNzp7auHtYY70MhOcRq6x4
haVGL6pyAZeo0va9vqQdvltZB9XTqw==
=/yVC
-----END PGP SIGNATURE-----

--jonyXJ7Ofmg6Ee47--

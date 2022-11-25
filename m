Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A24D6639047
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 20:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiKYTbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 14:31:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiKYTbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 14:31:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6113B4A051
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 11:30:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0F727B82BF6
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 19:30:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF153C433C1;
        Fri, 25 Nov 2022 19:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669404656;
        bh=4R2wkemNfL7NoiM642AxpmAB/0zST92cwO+Erb3Pb5c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EuaD6P5BcqyDYBPiAZYLIwszZOPVAFF29sQNBTKFr6fqvvkxfnMlxRNEByBkfCwUx
         wu3+62ul2xeMZy/iNqIk09ARExLNyd1RkluzePbJQyNJ8h1zVBWW3lWkLABziE9c58
         saW6o0So1OXCuZEqcwfDtO8AAtE5MFTKb3LtI1QqbzdVI9q1oubms/NMgWwpzHWF8O
         Z58zVeOzCzFTjoBU9dE0VTPY8NBbnxvYM/pheZdF33Lh6zB4eUCRvCPsyU6NjQ46Id
         MxL1uGJJQGne8rykdPoKtT8MXVql6SMMRz/J1xZo0Xoly7y6zGH4P6s3e5rc+A/ha0
         4l2yAIrVFaDgA==
Date:   Fri, 25 Nov 2022 19:30:52 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] regmap: cache: downgrade log level for no cache
 defaults message
Message-ID: <Y4EX7DLt/Lvde/SJ@sirena.org.uk>
References: <20220921071054.3132504-1-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yp5XM8ipNl8d+MS7"
Content-Disposition: inline
In-Reply-To: <20220921071054.3132504-1-alexander.stein@ew.tq-group.com>
X-Cookie: Time and tide wait for no man.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yp5XM8ipNl8d+MS7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 21, 2022 at 09:10:54AM +0200, Alexander Stein wrote:

> Having no cache defaults is not a mistake, especially for devices
> which do have some kind of strapping values which can't be provided
> statically. For this case a warning is the wrong log level, the initial
> cache values do need to be read form hardware. Reduce level to info.

>  	if (!map->reg_defaults_raw) {
>  		bool cache_bypass = map->cache_bypass;
> -		dev_warn(map->dev, "No cache defaults, reading back from HW\n");
> +		dev_info(map->dev, "No cache defaults, reading back from HW\n");

This is a warning which is only generated in the case where we have a
non-sparse cache where we won't read from the hardware in the csae of
missing values and will instead just substitute zero as a default value.
It's warning that we might end up changing values for the device
unexpectedly in the case of a read/modify/write cycle that doesn't
actually check what the device currently has set.

In this case if you can't use a rbtree cache I would recommend
bootstrapping by initially reading without a cache first to get the
default values, then replacing the regmap with one that uses the
defaults you just read.  You'll need some care over suspend/resume
though.

--yp5XM8ipNl8d+MS7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmOBF+sACgkQJNaLcl1U
h9CK6Qf/ZjTUtwgqo+qDCVj8jMeBqAXGwcxD7fv7GCC4hf6NeeNQeATHZAfR/gJv
9FoQkYcJ6D/rQQdlwn9tcyEn4ulO/UAav4OWqSLAVi/D/iiW7NPURyiBwdovQVub
Kn0wH/byMDMGLilxr8haxi8GJKcEusVQj9DwWOqOPSC9kilP1m20VwDczdEk9M0d
6R9q2laPG6Ehmd2w/FljR9qZuZyJE98TfPkwrz/XQGmf1T6brDyA1/kNMokk0dt+
MPe66HGeCTH0n63W6IReKZ6AJrvdTlBXAz7uYkoRyz8dbSzUCKAJOOSyKbCeJJ6/
rgtCL4GO3GegcbjxDm2O4z03MwsgbA==
=UX2o
-----END PGP SIGNATURE-----

--yp5XM8ipNl8d+MS7--

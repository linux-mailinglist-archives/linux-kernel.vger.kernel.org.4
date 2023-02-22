Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D44969FEB9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 23:51:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233041AbjBVWvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 17:51:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232885AbjBVWvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 17:51:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA394344B
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 14:51:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AD7FCB818D0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 22:51:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE9C5C433D2;
        Wed, 22 Feb 2023 22:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677106280;
        bh=g9Fsue6nIStp1cqyqdgrx4djABr9vzsaLBQd3+YHmDg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hIRz8lKbmHyLqwWP9vkg18huHtaRcHZZ6GXCjw6a/oRNb+Uk3VyD5ajSgWpnH/17P
         sJYqAS0mdjmGZuoMSfxm6numOJhBvakgxAaOo6D5wZgb8FyfxQ3iJyE2fx+NXfvSpW
         5rQLjfGtnbyO1MzQaLpvXZSA/9DQ+Qca1YTv49gi2bEH4QlxFSuB4LFxs2fhT960Dl
         kTmVHSx4F4DIhxYSNxqNF32wzA4BUmBe1V7ye/hNghzAqZDu2JEGs4W3q1tjyTl4go
         dXNcU1E+vEx+1Ng12IKP69aj463oNV2YAvyPIeL0FBdi6xoFl4s7FWPCiJQawBVq0c
         +cUNaq+vt6ILw==
Date:   Wed, 22 Feb 2023 22:51:17 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Tony Lindgren <tony@atomide.com>,
        Doug Anderson <dianders@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Luca Weiss <luca.weiss@fairphone.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC v1 4/4] regulator: core: Move regulator supply resolving to
 the probe function
Message-ID: <Y/acZQdDPSIuW2Ya@sirena.org.uk>
References: <20230218083252.2044423-1-saravanak@google.com>
 <20230218083252.2044423-5-saravanak@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rOGk3fj4b/OTShxS"
Content-Disposition: inline
In-Reply-To: <20230218083252.2044423-5-saravanak@google.com>
X-Cookie: Serving suggestion.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rOGk3fj4b/OTShxS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 18, 2023 at 12:32:51AM -0800, Saravana Kannan wrote:
> We can simplify the regulator's supply resolving code if we resolve the
> supply in the regulator's probe function. This allows us to:
>=20
> - Consolidate the supply resolution code to one place.
> - Avoid the need for recursion by allow driver core to take care of
>   handling dependencies.
> - Avoid races and simplify locking by reusing the guarantees provided by
>   driver core.
> - Avoid last minute/lazy resolving during regulator_get().
> - Simplify error handling because we can assume the supply has been
>   resolved once a regulator is probed.
> - Allow driver core to use device links/fw_devlink, where available, to
>   resolve the regulator supplies in the optimal order.

It would be good if you had noted the issues with moving the
constraint initialistion that you mentioned elsewhere in the
thread here - from the review I've done thus far that is the
biggest issue this creates - it means that we will not do any
needed hardware configuration until all the parents have sorted
themselves out (which may never even happen), increasing the
amount of time that the system is running out of spec.

> +	if (r && r->dev.links.status =3D=3D DL_DEV_DRIVER_BOUND)
>  		return r;
> =20
>  	r =3D regulator_lookup_by_name(supply);
> -	if (r)
> +	if (r && r->dev.links.status =3D=3D DL_DEV_DRIVER_BOUND)
>  		return r;
> =20
>  	return ERR_PTR(-ENODEV);

This will return -ENODEV in the case where we have found a device
but it didn't probe yet.  It's probably more appropriate to
return -EPROBE_DEFER like we do when we know about a DT link.
This is also adding a leak of the get_device() from the looks of
it.

Shouldn't this be using device_is_bound() rather than peering at
the links?  Or alternatively if device_is_bound() does something
different to peering at the links isn't that really confusing?

> @@ -2050,13 +2050,6 @@ static int regulator_resolve_supply(struct regulat=
or_dev *rdev)
>  		}
>  	}
> =20
> -	/* Recursively resolve the supply of the supply */
> -	ret =3D regulator_resolve_supply(r);
> -	if (ret < 0) {
> -		put_device(&r->dev);
> -		goto out;
> -	}
> -
>  	/*
>  	 * Recheck rdev->supply with rdev->mutex lock held to avoid a race
>  	 * between rdev->supply null check and setting rdev->supply in

Your commit message says this should avoid the need to worry
about locking so much so do we still need to recheck things?  We
still seem to be doing all the same things we were doing before.

--rOGk3fj4b/OTShxS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmP2nGIACgkQJNaLcl1U
h9C6KAf9FP9BIl4N/72UZKQ5Zeq+XEgdwLMXxEeH8TWQ+J4IfeIlVAeOOpgqWwYk
rXtQgtPtJ7JnGhz1N1s+3NoHNS9IYgP4DLDsLp8FulLyHpQaCt8/rtrvWaWyMOsT
vM70QMzpcIZHWGzGUVCpEruLEpVUJYlqttl0vPXsPi0pp6QIGffMvl9HS9CNDxf2
HQ2IEOY3rbaHzsILYDbkM1R7iI/468dsGSrE5X14SWe1/wa52x+YaZUjj0aVQkEc
FR2yUsoO97pfZvBSbwWzMUymcBaK3HcOO2tpDfsYbUjLjojKfPsykMSC3GSqKs/N
8cbc6zwWRyMvnn70y33ByQl7RBW2sg==
=BuAR
-----END PGP SIGNATURE-----

--rOGk3fj4b/OTShxS--

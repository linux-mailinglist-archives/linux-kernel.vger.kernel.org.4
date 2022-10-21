Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7616076BD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 14:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbiJUMQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 08:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiJUMQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 08:16:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2F91B76DE;
        Fri, 21 Oct 2022 05:16:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 664DDB82B8F;
        Fri, 21 Oct 2022 12:16:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09DFAC433D6;
        Fri, 21 Oct 2022 12:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666354567;
        bh=AZrwO8m1MVhavEmOX2Pgser7WjDD2UtoPK/tV8kWTyk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WhrC+YOGCNfCi1TJzB/l/KC4LpkDIzrjP/8I6ei9IE/6i5O4s4DuEyKiFdW0w6QB9
         2mYttRlNn8jhFbwNH1v2DOQEUE0EBP0x9nRKJVUgbweawDOED68PwsiHf7sbpJjY1u
         bPEyFlM9M1VSk0WtlguTNNmtfjo9vky0GnMGjVtWm71igm5Le/Rlp/o4FJjcFxx2LH
         q47Kld6U3PKAU2BVAEOhGq/VKn1u+H/xRIym1fB5QaAocTwzB6MNgjvMOFQfVTWCf3
         Yu+PEwv5kIzGlKr5rmXGSUa5k7OxAVB2uXBwweVSPnbRl/fqLYH8FhSiGZ+lmz0h2l
         U2yynoHIzD5Gw==
Date:   Fri, 21 Oct 2022 13:16:01 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH v4 1/5] spi: pxa2xx: Respect Intel SSP type given by a
 property
Message-ID: <Y1KNgS6xQ1VhMjo1@sirena.org.uk>
References: <20221020194500.10225-1-andriy.shevchenko@linux.intel.com>
 <20221020194500.10225-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EozblBpYpdUvyyT7"
Content-Disposition: inline
In-Reply-To: <20221020194500.10225-2-andriy.shevchenko@linux.intel.com>
X-Cookie: PURGE COMPLETE.
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EozblBpYpdUvyyT7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 20, 2022 at 10:44:56PM +0300, Andy Shevchenko wrote:

> Allow to set the Intel SSP type by reading the property.
> Only apply this to the known MFD enumerated devices.

> +	/* For MFD enumerated devices always ask for a property */
> +	mfd_enumerated =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "=
lpss_priv");
> +	if (mfd_enumerated) {
> +		status =3D device_property_read_u32(dev, "intel,spi-pxa2xx-type", &val=
ue);
> +		if (status)
> +			return ERR_PTR(status);
> +	}
> +
>  	if (pcidev)
>  		pcidev_id =3D pci_match_id(pxa2xx_spi_pci_compound_match, pcidev);
> =20
>  	match =3D device_get_match_data(&pdev->dev);
>  	if (match)
>  		type =3D (enum pxa_ssp_type)match;
> +	else if (value > SSP_UNDEFINED && value < SSP_MAX)
> +		type =3D (enum pxa_ssp_type)value;

This is quite hard to follow, partly because value isn't exactly a clear
variable name and partly because the initialisation to SSP_UNDEFINED,
the attempt to read via device property and this if/else chain are split
up and not clearly joined up with each other.  This is partly an issue
with the existing code but the extra layer of spreading things
throughout the function being added amplifies things a bit.

--EozblBpYpdUvyyT7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNSjYAACgkQJNaLcl1U
h9DHMAf/awXXyV1wIfNDdb8VdzX2h6Oo+NhjzeWTW6mqR8QYreCViWuYB+DLkB8e
/ocScpW/io9nceUP+GsGOwfugXDv/57ZHMXr7t3oX79HOeqYBmE0gw0qe+4Ff6fv
WNOZ/0HJ0EzRhEZsyy0xf245mjLte7fgWtWsijhkLkh3Nz5VVvPq1obZuAzi+lQD
J5sFf7P5KcaAvReA7pPShtgg0L9ZxecV1tlyghrckHno+ONL92P8IdOwYBtV6L9v
XA1DGqRw1tJtPxNfI5dobDi2G1epb7K3MYY7E/sODYRp4CEI6ANksfJg+D2dFakE
BcFfKJt8nI/8pAv0JLdh4Cx/mGiP+A==
=rcgR
-----END PGP SIGNATURE-----

--EozblBpYpdUvyyT7--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83D576511CE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 19:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232299AbiLSS1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 13:27:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232171AbiLSS1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 13:27:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A509F13DE5;
        Mon, 19 Dec 2022 10:27:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C05F60EF0;
        Mon, 19 Dec 2022 18:27:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8DE7C433EF;
        Mon, 19 Dec 2022 18:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671474461;
        bh=xAutBeg6BQt+MbEQLX7XBV5I/cOstTnhbUcf8B4nddg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MCZi7Gu3TtYwSuRjEmoJ7WFPYiV0XEdgzIY1hnbIt/MkyAu06dfwQvdudZY2xeHFm
         8k72t/Wv/Yna0sx0Zo+jkQmEja0KTRZOSniwgv2Fs+/uHWfgPyazJQa51bFHOwMDn2
         30FssTvmcXwfAbOtYULFbP7eDcuKT0KNgW4tf4ZoA48mtHiR1oILPQVbprrrx9KiP+
         jn/oGLoWthLentthQPrkJH3kZC7Sjt5M4G8ks/v0sdID6Ebj+vUSLKCf4qCFZ1Ac3+
         0WMwGhkFR+JDBm415D8DPR2JTsZRJUK9wKyGdKbUdWsgaEXHj7t3dhCSZWLZp6Nlc5
         rcfNSJk7nzKXg==
Date:   Mon, 19 Dec 2022 18:27:36 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Witold Sadowski <wsadowski@marvell.com>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, jpawar@cadence.com,
        pthombar@cadence.com, konrad@cadence.com, wbartczak@marvell.com,
        wzmuda@marvell.com
Subject: Re: [PATCH 6/7] spi: cadence: Add Marvell IP modification changes
Message-ID: <Y6CtGEmi0wZUKaxT@sirena.org.uk>
References: <20221219144254.20883-1-wsadowski@marvell.com>
 <20221219144254.20883-7-wsadowski@marvell.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SFzu49Gqzv33Vgn9"
Content-Disposition: inline
In-Reply-To: <20221219144254.20883-7-wsadowski@marvell.com>
X-Cookie: Pay toll ahead.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SFzu49Gqzv33Vgn9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 19, 2022 at 06:42:53AM -0800, Witold Sadowski wrote:
> Add support for Marvell IP modification - clock divider,
> and PHY config, and IRQ clearing.
> Clock divider block is build into Cadence XSPI controller
> and is connected directly to 800MHz clock.
> As PHY config is not set directly in IP block, driver can
> load custom PHY configuration values.

What is a PHY in the context of a SPI controller?

> +config SPI_CADENCE_MRVL_XSPI
> +	tristate "Marvell mods for XSPI controller"
> +	depends on SPI_CADENCE_XSPI
> +
> +	help

Extra blank line (does this work?).  It's not clear to me that there's
enough code here to justify a Kconfig.

> +	/*Reset DLL*/

Please follow the kernel coding style.

> @@ -328,6 +468,9 @@ static int cdns_xspi_controller_init(struct cdns_xspi=
_dev *cdns_xspi)
>  		return -EIO;
>  	}
> =20
> +	writel(FIELD_PREP(CDNS_XSPI_CTRL_WORK_MODE, CDNS_XSPI_WORK_MODE_STIG),
> +	       cdns_xspi->iobase + CDNS_XSPI_CTRL_CONFIG_REG);
> +

This is done unconditionally, will other instances in the IP be OK with
it?  Should it be a separate commit since it's affecting everything?

> +#if IS_ENABLED(CONFIG_SPI_CADENCE_MRVL_XSPI)
> +	writel(CDNS_MSIX_CLEAR_IRQ, cdns_xspi->auxbase + CDNS_XSPI_SPIX_INTR_AU=
X);
> +#endif

This is not how we do support for variants of an IP, we need to support
a single kernel image for many different systems so variant handling
needs to be done with runtime selection not build time selection.
Please handle this in a similar way to how other drivers handle support
for multiple devices.

> +#if IS_ENABLED(CONFIG_SPI_CADENCE_MRVL_XSPI)
> +static int cdns_xspi_setup(struct spi_device *spi_dev)
> +{
> +	struct cdns_xspi_dev *cdns_xspi =3D spi_master_get_devdata(spi_dev->mas=
ter);
> +
> +	cdns_xspi_setup_clock(cdns_xspi, spi_dev->max_speed_hz);
> +
> +	return 0;
> +}
> +#endif

Note that setup() might be called while other transfers are in progress
and should not affect them.

--SFzu49Gqzv33Vgn9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmOgrRcACgkQJNaLcl1U
h9DRowf+IWsO+ZFAL6JzW8v29pswhR5YDWepTysfhcwtWAwaj0Cdge9jQclR7oUv
asHeFFOznShv/HYdRf+NogBxb7Lj93+ylKHGQeMhxq4+xnR15PMhDZWpQ8P49wX6
IN8F9iBGRBG7zM7KnwqqhUm5pLNpy/NTydoRFU9vfRbwbRpUkdCxU9ZypjJEJzHO
MF4/UDmiaVDfbPdAffqwRqvfndDSFfDprCXG7n7v4ZmsXTBiUHW/HZWLA1okWZpd
hxQjssti/7OYAmdWVbr+OBjvzMyCHGe5EPRXXfuFVpk6py1oVqD9qIZrEsmHRsLd
L2aq6GWBx+12K+gYClbcMw2BDzmFeQ==
=AawN
-----END PGP SIGNATURE-----

--SFzu49Gqzv33Vgn9--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 640FC6CD8AF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 13:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjC2LoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 07:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbjC2LoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 07:44:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14A844AC;
        Wed, 29 Mar 2023 04:43:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E9C361CD5;
        Wed, 29 Mar 2023 11:43:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51C06C433D2;
        Wed, 29 Mar 2023 11:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680090235;
        bh=apVF3uvZGAkOtU19RE249GS5clB9mJ34H9YjFDzYdlA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sjwQ7OfskZMWFZuzPL9Va4EWkv2xBm83c5eniEw0G/WpRgGN6Z7GI9hgCnF8YmMaE
         4JTqNBdCvva0b2gZb/iKVW3kS/Rw1KZOvc/Te5rxDbZFXNfuASOZ3/yVExxKUF91G9
         fu/M9f3UzaIgC2aPkERf6lJTZRsW/LF/3dwKw6aojv5pTd+/XR01WHg+7IQ9S+bdvQ
         aSIdIJXry7Pi9kx9mLCUHdo1l61HwUX1M9hH7oddu38AoRukQnQLGqnCuTOy0v7thk
         P3hFWIvtQsklQth7PWdKW472l31GQXdduw/uguqqin2vP19N42Tgr+aNAXABauTMaC
         TI8gfThyYwhAw==
Date:   Wed, 29 Mar 2023 12:43:52 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Piyush Malgujar <pmalgujar@marvell.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        jannadurai@marvell.com, cchavva@marvell.com,
        Suneel Garapati <sgarapati@marvell.com>
Subject: Re: [PATCH 1/2] spi: octeontx2: Add support for octeontx2 spi
 controller
Message-ID: <ZCQkeKEpgANkE/GD@sirena.org.uk>
References: <20230327180753.2279-1-pmalgujar@marvell.com>
 <20230327180753.2279-2-pmalgujar@marvell.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6syUKnOpmLuBATAM"
Content-Disposition: inline
In-Reply-To: <20230327180753.2279-2-pmalgujar@marvell.com>
X-Cookie: Single tasking: Just Say No.
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6syUKnOpmLuBATAM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 27, 2023 at 11:07:52AM -0700, Piyush Malgujar wrote:

> +static int tbi_clk_en = 1;
> +module_param(tbi_clk_en, uint, 0644);
> +MODULE_PARM_DESC(tbi_clk_en,
> +		 "Use Fixed Time Base 100MHz Reference Clock (0=Disable, 1=Enable [default])");
> +
> +static int cfg_mode_delay = 30;
> +module_param(cfg_mode_delay, uint, 0644);
> +MODULE_PARM_DESC(cfg_mode_delay,
> +		 "Delay in micro-seconds for mode change in MPI CFG register (30 [default])");

These don't look like they should be configurable at runtime,
either DT or (especially in the second case) just have the driver
do the right thing.

> +static void octeontx2_spi_wait_ready(struct octeontx2_spi *p)
> +{
> +	union mpix_sts mpi_sts;
> +	unsigned int loops = 0;
> +
> +	mpi_sts.u64 = 0;
> +	do {
> +		if (loops++)
> +			__delay(500);
> +		mpi_sts.u64 = readq(p->register_base + OCTEONTX2_SPI_STS(p));
> +	} while (mpi_sts.s.busy);

Might want a cpu_relax() in there.

> +	p->cs_enax |= (0xFull << 12);
> +	mpi_cfg.u64 |= p->cs_enax;
> +
> +	if (mpi_cfg.u64 != p->last_cfg) {
> +		p->last_cfg = mpi_cfg.u64;
> +		writeq(mpi_cfg.u64, p->register_base + OCTEONTX2_SPI_CFG(p));
> +		mpi_cfg.u64 = readq(p->register_base + OCTEONTX2_SPI_CFG(p));
> +		udelay(cfg_mode_delay); /* allow CS change to settle */
> +	}

It looks like the hardware has independent control of chip select
so should just implement a set_cs() operation.  That seems to be
the only thing stopping the driver using transfer_one() instead
of transfer_one_message() so it should do that too and save more
code.

> +	p->clk = devm_clk_get(dev, NULL);
> +	if (IS_ERR(p->clk)) {
> +		p->clk = devm_clk_get(dev, "sclk");
> +		p->sys_freq = 0;
> +	} else {
> +		ret = clk_prepare_enable(p->clk);
> +		if (!ret)
> +			p->sys_freq = clk_get_rate(p->clk);
> +	}

We don't need to enable sclk or care about errors?  That seems
buggy.  The driver should just rely on the clock API here.

> +	if (!p->sys_freq)
> +		p->sys_freq = SYS_FREQ_DEFAULT;
> +	if (tbi_clk_en)
> +		p->sys_freq = TBI_FREQ;

We never seem to do anything to actually configure this in the
hardware.

--6syUKnOpmLuBATAM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQkJHgACgkQJNaLcl1U
h9CCpQf/ROa3ORsfAQSS4xHGQMm/s36AvI57fT4Pi/2kKWDu5hEC8pPThSR2QLGv
hKQvq0OnMD9hKhJ3Ndvv/sjo1qqUWxM4n4rQqxWf8qym9BnUGWzHqYLQ+Rw8HYy7
P50YLzd8tWnhDzn97C06r3ZmXUk6N0bDOHuip+wCQuhB8seh3UuBcIPoNE2llwuA
Nqz+7JYFQtT3BLuSv8Ek8QDP7dFwqlmIhQMKaiW3ezWDBLNYPb1t3Ww2fbVlLBmJ
VQbMUA4kyfkl/MvwbBAq8djVaSqxhswc6ZBQwCyArBvH2E3KGaqxY4n58CHH5/42
rYSLmRr4UDv2bLDJYd/cjJuohmVTBg==
=eDrQ
-----END PGP SIGNATURE-----

--6syUKnOpmLuBATAM--

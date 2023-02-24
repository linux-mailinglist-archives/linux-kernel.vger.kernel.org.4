Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9806A1FF7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 17:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbjBXQrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 11:47:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjBXQrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 11:47:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A5BD6B147;
        Fri, 24 Feb 2023 08:47:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B903C61939;
        Fri, 24 Feb 2023 16:47:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50B1FC433EF;
        Fri, 24 Feb 2023 16:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677257230;
        bh=ryAsd2+vCOoBlB6xR8OQqB35I8gBsHd+OBXGc85+ozc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N73c7pDb4SSPRbQ0fsyeA5BbFAfEKKa+3WUWFfYvk+9Lxamp8LOargaWANrc+FCUZ
         joacL0gRQOAeYv37z3HEylh5/mfEdCJuwC3CuZVP0rU5ZyKSvI9mbCv6yJb6oojXgh
         ToUKAzIXcD4wy8jR3E+UnaDggSCybuxxICFY6ZmfntsXUdVwkwZztHAC9BIrxLI+ht
         cq9zqqx+b5L5a/dtDrXQoGTrUQj9iRQ6HKNXI6094XYMwzHDUSVTuKexbG/K1Cw1c8
         CmmqCVn5jEHN01TAEjsgRYQGLYyJy5QxK7CqAds1ZmdX19Xnlfbx5uLjyRhS3eqybb
         Z39tKMrR6dNrA==
Date:   Fri, 24 Feb 2023 16:47:05 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Krishna Yarlagadda <kyarlagadda@nvidia.com>
Cc:     linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com, skomatineni@nvidia.com, ldewangan@nvidia.com
Subject: Re: [PATCH] spi: tegra210-quad: Fix iterator outside loop
Message-ID: <Y/jqCRAenwbqc1Uu@sirena.org.uk>
References: <20230224163513.27290-1-kyarlagadda@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kU7eO+WfDSUysTOv"
Content-Disposition: inline
In-Reply-To: <20230224163513.27290-1-kyarlagadda@nvidia.com>
X-Cookie: The early worm gets the bird.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kU7eO+WfDSUysTOv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 24, 2023 at 10:05:13PM +0530, Krishna Yarlagadda wrote:

>  		msg->actual_length += xfer->len;
> +		if (!xfer->cs_change && transfer_phase == DATA_TRANSFER) {
> +			tegra_qspi_transfer_end(spi);
> +			spi_transfer_delay_exec(xfer);
> +		}
>  		transfer_phase++;
>  	}
> -	if (!xfer->cs_change) {
> -		tegra_qspi_transfer_end(spi);
> -		spi_transfer_delay_exec(xfer);
> -	}

This looks like it'll do the wrong thing and do a change on every
transfer if cs_change isn't set?

--kU7eO+WfDSUysTOv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmP46ggACgkQJNaLcl1U
h9D5sAf/ZFxIFrE6cDc+2bBL87DGFVmf4tz5wBnVZ5Ii3/J8onmDc8f7r+sUiEIk
+6B+kCZi0LECvQF229p03DvHT+Rgkq831RHFDCk2rBf89+JliLbk/mSqBUvZbNPL
1m2wtT/eY4OX0AUnVskE9zt3axB/q3QcZVHiWPmbIpYG0dJDnrdc94EuMhcojOAw
RWAE9HOtDc4X2yZjIdpp62awChHF7YNiZhxhRNFtZJGpQHTMvJA74mhrzIw/LwJC
etzUBaeUzN8ewSCaWMSuo3Bg3sojy2LfccQ5Wp5/dU9wn1mBTfEdKy25RQbxd0ZG
sFFc4V+T5pBEPX9NxPcZMBJXjyyO6w==
=TkdM
-----END PGP SIGNATURE-----

--kU7eO+WfDSUysTOv--

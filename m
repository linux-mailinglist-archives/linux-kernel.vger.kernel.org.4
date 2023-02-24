Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2E26A20EE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 18:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjBXR4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 12:56:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjBXR4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 12:56:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E37466ADFF;
        Fri, 24 Feb 2023 09:56:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A3E82B81C9C;
        Fri, 24 Feb 2023 17:56:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D536C433EF;
        Fri, 24 Feb 2023 17:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677261368;
        bh=fuldWUUBCCEEzxhrkX1CaEUawk3xj50XRZkkElRSkRE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E35m6+htE4e7PfwS+0PZMeTNATf3SegeLzonaktUBkX6sHWR8g95eBcWACwgGtFLn
         1mSZNP15mTD6E6QmJsO35jPbO2QRlv7GR4kmi7rU6wCYtNNscnb8eFUPt3n2JhSSJ0
         a3zoxcuX8BSfA3IbZyGQHSeffbwy+vr/wOKvv+30nfR12HKupk8pvQfYSNh3i43Usd
         i67oBHij1cCzdkcyhsPBDQUsOVL4nXiDzP2Yy2xo0zlttQafzY9l5QnLPTRW9Mnz5D
         Ar2N0WZZnFb1mRDspQv+3tsqnvi/W3tmorszIvW4i65AxsmT040jd8I/1devnaDb1m
         i/icyeiXlG/tg==
Date:   Fri, 24 Feb 2023 17:56:03 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Krishna Yarlagadda <kyarlagadda@nvidia.com>
Cc:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>
Subject: Re: [PATCH] spi: tegra210-quad: Fix iterator outside loop
Message-ID: <Y/j6MxmOkZj/TKej@sirena.org.uk>
References: <20230224163513.27290-1-kyarlagadda@nvidia.com>
 <Y/jqCRAenwbqc1Uu@sirena.org.uk>
 <DM4PR12MB5769BDB91342A9768207BD84C3A89@DM4PR12MB5769.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1Y5caIOx58tpWex7"
Content-Disposition: inline
In-Reply-To: <DM4PR12MB5769BDB91342A9768207BD84C3A89@DM4PR12MB5769.namprd12.prod.outlook.com>
X-Cookie: The early worm gets the bird.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1Y5caIOx58tpWex7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 24, 2023 at 04:50:00PM +0000, Krishna Yarlagadda wrote:

> > >  		msg->actual_length += xfer->len;
> > > +		if (!xfer->cs_change && transfer_phase == DATA_TRANSFER)
> > {
> > > +			tegra_qspi_transfer_end(spi);
> > > +			spi_transfer_delay_exec(xfer);
> > > +		}
> > >  		transfer_phase++;
> > >  	}
> > > -	if (!xfer->cs_change) {
> > > -		tegra_qspi_transfer_end(spi);
> > > -		spi_transfer_delay_exec(xfer);
> > > -	}

> > This looks like it'll do the wrong thing and do a change on every
> > transfer if cs_change isn't set?

> This condition is hit only in data phase which is end of message.

Shouldn't this just be moved into the DATA_TRANSFER case statement?

--1Y5caIOx58tpWex7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmP4+jIACgkQJNaLcl1U
h9CuNAf/RnnVBXixt5TqUSG5Q9M0PuUVwE2dM/ySiYNHqJNe/wvfnMzahIoev4cd
5nSTnwqNPI4oLsPsYNsWUa306BdMmOKKK0nPibXbzIuCX2xEjY69OBqEQqg0A990
5CQpLlOLbEOy7+Ecnv8jmNuydgPu3F8Wxwzjw9ceD+P1viyE4514AuCL/9Oet02w
zuE3IDrSOSdjmakcsj5vUVktj3GFQXOgNBP/ex0aFZgJJq3IjtI5e8yINHiJZx52
DClt6OMO0zh/Gbob/aYGrp7+8df2CkAO4c85I8CAXwO3vsGfLv0qedlRGB9sd/BL
uhKhhhaB+MF56Tsf9WnDURGmxskHkg==
=amcU
-----END PGP SIGNATURE-----

--1Y5caIOx58tpWex7--

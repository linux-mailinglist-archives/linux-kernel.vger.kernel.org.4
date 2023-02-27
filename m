Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76CFD6A4999
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 19:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjB0SXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 13:23:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjB0SXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 13:23:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D80A23C48;
        Mon, 27 Feb 2023 10:23:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C4ED0B80D98;
        Mon, 27 Feb 2023 18:23:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8131C433D2;
        Mon, 27 Feb 2023 18:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677522200;
        bh=g05SUzOomoczQcseeL7WN/vjyWJiGXywhrb9CqYLotM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L9pHUjCv431F7D65LDI4xe+OC1UJLSlev88G/DJDFHHzoQWeqlxyuoLBqi6bm/hP8
         b3mC4NZ0t1k8EMCWb3ZqBqL4R3u/764ys71oMVgInz07OnN7Pxp1zL7Y8O8pgTfl2d
         05om83+jPiBbee0rajBd6sjpafls5QiQfolp+gkyDz6P/CRDvZQ1eZBoAwvlkj4ktV
         ve1DbnQt+wCwnwHSlx2GoPwMJ6FUUhDOXCNnP31GM+zndaSmmXkULZPvu6mb9nSaY4
         OuEFyL60DFJHmAs+oRDO6DxCjMnNwPJ6WnjnGrYirgTj0ZekhnCyixZ4ifKJPa3U/o
         ttfT3XRMYx+/w==
Date:   Mon, 27 Feb 2023 18:23:14 +0000
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
Message-ID: <Y/z1Eu3DUaU/Dbfh@sirena.org.uk>
References: <20230224163513.27290-1-kyarlagadda@nvidia.com>
 <Y/jqCRAenwbqc1Uu@sirena.org.uk>
 <DM4PR12MB5769BDB91342A9768207BD84C3A89@DM4PR12MB5769.namprd12.prod.outlook.com>
 <Y/j6MxmOkZj/TKej@sirena.org.uk>
 <DM4PR12MB576994B630B7D8F43BD21F73C3AF9@DM4PR12MB5769.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2HZkfV0rKk8TfY0+"
Content-Disposition: inline
In-Reply-To: <DM4PR12MB576994B630B7D8F43BD21F73C3AF9@DM4PR12MB5769.namprd12.prod.outlook.com>
X-Cookie: On the eighth day, God created FORTRAN.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2HZkfV0rKk8TfY0+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 27, 2023 at 10:36:18AM +0000, Krishna Yarlagadda wrote:

> > > > > -	if (!xfer->cs_change) {
> > > > > -		tegra_qspi_transfer_end(spi);
> > > > > -		spi_transfer_delay_exec(xfer);
> > > > > -	}
> > updating the length of the message.
> > > > This looks like it'll do the wrong thing and do a change on every
> > > > transfer if cs_change isn't set?

> > > This condition is hit only in data phase which is end of message.

> > Shouldn't this just be moved into the DATA_TRANSFER case statement?
> Calling transfer_end after updating message length.

Something seems to be mangled with your quoting/new text here so it's a
bit unclear what you're saying here but if you're saying that this is
due to needing to call tegra_qspi_transfer_end() after updating the
length I'm not sure why - AFAICT that function doesn't reference the
transfer length at all, it just writes out a command to configure the
chip select?  There's no issue with the message being finalised since
that happens in the caller.

--2HZkfV0rKk8TfY0+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmP89REACgkQJNaLcl1U
h9BSoQf/exwMXkkgkpWrC/U9YS7grsX08GeZwu7g4nFvvAFnAMqcVB3rTRbLGKAM
DkkyfNvw9vFtYJmBq3WdfLkRuQ9iHAzREsq38jnYeso9vP6b3xleFb2yfXB1IXEM
A+CNWasqvA5IFo0jx1fQBxpAaMBGr6IEKvTS2xjewMItIr4JXkfNCBVuSUvREat2
xKxZMH+pQvRSF3oSa2w6sOGnwYAyglqcppDsO5AzdZJ+cXoQkwBPHwxWcXE/ZsxR
MAFGb8V7/08Nh0r7v8LUhXpa5qtgnH3S/QzPXFeJCf+GGjP+KRp035YLj6z2EkcS
Dj8zVpN0Yo5PnjAe8bMNonu5hO4q2w==
=eiGn
-----END PGP SIGNATURE-----

--2HZkfV0rKk8TfY0+--

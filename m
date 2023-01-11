Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F477666656
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 23:42:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234049AbjAKWmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 17:42:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234740AbjAKWlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 17:41:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF06C222;
        Wed, 11 Jan 2023 14:41:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A35B6B81D76;
        Wed, 11 Jan 2023 22:41:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D472DC433D2;
        Wed, 11 Jan 2023 22:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673476906;
        bh=iJc04xf432xUiDMocOnmf3RAIKw9PGxoDrge6aTW7GI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BSEv2H7VebbwNy7z582w7LdipwyiRvo75PZUAkK2CtbxHYCJIURIjTSrA2o8+fMrm
         IEzcX5E11U8mBl/61H6oFVmJX3Hl6R16/diovshiE0V3jy88WQ7Hn7Cjn81Hn1XZGu
         EhGJZ7PZpDx2vm2W3/pVih8GGc6k9XGkMrmpfHSzSEHnKLoaQQrC07D/tQt/OpFDri
         f9FfU9qlaVE02tK5TSHt3wJ0V9y3U6cfJKBf377uFXBUytVNBkSqRAJ+OOTij3B7Yz
         PgLswz5YL3Yw57uEZVfrda10XJNp09ZKmPUX9nr4N/5D+Y44IaPs/zcVqgwEu9VQdb
         iYu2oFMBUH05w==
Date:   Wed, 11 Jan 2023 22:41:40 +0000
From:   Mark Brown <broonie@kernel.org>
To:     William Zhang <william.zhang@broadcom.com>
Cc:     Linux SPI List <linux-spi@vger.kernel.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        anand.gore@broadcom.com, tomer.yacoby@broadcom.com,
        dan.beygelman@broadcom.com, joel.peshkin@broadcom.com,
        f.fainelli@gmail.com, jonas.gorski@gmail.com,
        kursad.oney@broadcom.com, dregan@mail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/16] spi: bcm63xx-hsspi: Add polling mode support
Message-ID: <Y787JLl9Hdp0sWsC@sirena.org.uk>
References: <20230106200809.330769-1-william.zhang@broadcom.com>
 <20230106200809.330769-8-william.zhang@broadcom.com>
 <Y7iW38Fsj0nIewDm@sirena.org.uk>
 <ec84b84b-41be-32ad-2e76-afac59a621d0@broadcom.com>
 <Y7xloRuHk5BHSOCb@sirena.org.uk>
 <ca22c9af-34bc-e857-881c-263f70a405e8@broadcom.com>
 <Y73rl8feUOnChWKF@sirena.org.uk>
 <dee51504-ccd2-3c27-ffc8-2e392f2bd781@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1UceDFP/xmlKQ8dg"
Content-Disposition: inline
In-Reply-To: <dee51504-ccd2-3c27-ffc8-2e392f2bd781@broadcom.com>
X-Cookie: Life is not for everyone.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1UceDFP/xmlKQ8dg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 11, 2023 at 12:13:43PM -0800, William Zhang wrote:

> Thanks for the explanation. I saw the spi-uniphier.c and spi-bcm2835.c doing
> the trick you mentioned(thanks Kursad for pointing out).  In our case, even
> the maximum fifo size usage(512bytes), the polling still have better
> performance than interrupt. The MTD test result included in this patch is
> based on maximum fifo usage. So there is no benefit to switch to interrupt
> based on transfer size.

> Does the spi framework has any requirement on how much time that the
> driver's transfer_one function can spend?  I can see the polling function
> might take quite some time in busy loop if the clock is low, for example, at
> 100Hz(slowest clock this controller can go), it takes 512x8/100Hz ~= 41ms to
> complete.  If this is something in concern,  I can do the interrupt switch
> based on a time limit value if interrupt is available.

There's no fixed limit, some hardware just doesn't have DMA.  Some
doesn't even have interrupts which is even better.  If there's always a
clear benefit for using PIO then just do that, perhaps creating a sysfs
hook to allow people to switch to DMA if they need it (rather than
requiring people to update their DT, this is really a runtime
performance tradeoff rather than a description of the hardware).  If
there's a point at which the performance is very similar then it's
probably worth switching to DMA there to lower the CPU usage, but if
it's always faster to use PIO then just defaulting to PIO seems like the
best option.

--1UceDFP/xmlKQ8dg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmO/OyMACgkQJNaLcl1U
h9BNlgf9H7h7nFgPexNhok68PzYM2PTxKc53uRr1ddQwuYLg5cEgrLbZhpjONzKw
H2at7UqiJzfu7eD8mQ4lUWHJcCU3eEfXqsBrokbE13ME+xK1HmSJ8E8e4txOlymK
IIRscuM/aDtXE5oS2SDefmHYZHnDkGBjXe3n61EU2jTXHK0R5PEkB49sxdgf2v2f
nXwGwDHqyjV2ZroFCemZ7NrWdVB62QV4tfTZ3FY59dMxX5QPjRKaJjgb4evbwklt
arcRT/pWbx76wUrvUV8LnfnegDbcMmKzmP/+h1YzKDJmTSLSQnU1dlnYdTNIrEsh
OVTgqgFGD5z9y4fcawqE2dj8ycfPYw==
=tvzC
-----END PGP SIGNATURE-----

--1UceDFP/xmlKQ8dg--

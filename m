Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F03C3716FBF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 23:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233489AbjE3Va5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 17:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbjE3Vaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 17:30:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B4DE8;
        Tue, 30 May 2023 14:30:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8BB7160B74;
        Tue, 30 May 2023 21:30:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 869C2C433EF;
        Tue, 30 May 2023 21:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685482253;
        bh=PrlL1qfJ4X4PgO5aGdikpfSveOZTNv2Z4rqYo4OiJts=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iBLPvGkJZb7R3XA/E6T8YvG3XN3DGpqP+dWwEAjFyBXDGCduGXbXAq87fVbsr2MLp
         JCRGsqL8OjIS7OoZJV8H6VAT7RvnFilBArfPFhq2v/H8IECnEiskUYB1tDdwx8Seaq
         zzjYXil1T7WjAoNC7cVfQTKVQmZMoz42iM4N+mzCxvPPwy48NSWEbUz4NJ6ZJUqXDF
         rWbjPpjQpkA5/r0r4F8/P1WgC3iPCgGNPbYqM5Mv2u8seoTuyTR9gh72kit3EGIMMX
         DKOzBWAZNwrqDv73tchVsncDT35LregvMV1mNTFEr3rSan8EnhhEhfRqCBpPkh0HR6
         4plYDAsXS+qeA==
Date:   Tue, 30 May 2023 22:30:46 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     lee@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linus.walleij@linaro.org, vkoul@kernel.org, robh+dt@kernel.org,
        conor+dt@kernel.org, lgirdwood@gmail.com,
        yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/6] spi: cs42l43: Add SPI controller support
Message-ID: <171e2054-e41c-46a5-b478-f699909c5bd7@sirena.org.uk>
References: <20230530122112.1314458-1-ckeepax@opensource.cirrus.com>
 <20230530122112.1314458-6-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LUy+8fUc7Rrtf09J"
Content-Disposition: inline
In-Reply-To: <20230530122112.1314458-6-ckeepax@opensource.cirrus.com>
X-Cookie: I've read SEVEN MILLION books!!
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LUy+8fUc7Rrtf09J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 30, 2023 at 01:21:11PM +0100, Charles Keepax wrote:

A couple of small things:

> +static unsigned int cs42l43_clock_divs[16] = {
> +	2, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30
> +};

Do we need to specify the size of the array?  I just had to count the
number of initialisers :(   Should probably also be const.

> +		for (; buf < block - (sizeof(u32) - 1); buf += sizeof(u32))
> +			regmap_write(regmap, CS42L43_TX_DATA, *(const u32 *)buf);

We're passing a byte stream through a u32 here - are you sure this is
endian safe?

--LUy+8fUc7Rrtf09J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmR2awUACgkQJNaLcl1U
h9BLMAf7B1to2LkSkIjsJGp1+2cKMbTn+WNW6z2CuH5pGIv8uv6hHT/yakD/DAtD
xqM8doMGB7ckoPBvhosXpSmd7TODf4nrrADZEB9yL5ZgAyPl9tgk7ZrNldZUr8bV
KBRZASEbj3MNDA4EzBe8oG7jn3vwgF+Yes6wYzvhiUkQFL1alr7u/7IQ4lJlKWTL
hnYHrP4S/2ZbZzJO16dLz47zIYMAtERArGEfrKYdQ1rmWazZMGFJ8MwboxkC8ZMQ
gR2K6dVAAsncxp3ruAEB520UX7td4j1tm2rcJgyNTbgXbJsn7wVZ882YEXAF24L8
oRslOoGjnPOB9/vkdOYSL79Zyx1Xyg==
=Yi++
-----END PGP SIGNATURE-----

--LUy+8fUc7Rrtf09J--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84D346D62F5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 15:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234341AbjDDNds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 09:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234481AbjDDNdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 09:33:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FECB1710;
        Tue,  4 Apr 2023 06:33:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 760C8632ED;
        Tue,  4 Apr 2023 13:33:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ACFAC433D2;
        Tue,  4 Apr 2023 13:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680615192;
        bh=mNbOU7xuGoBEYIuAeOXwalRr9mQiImjiyHioFrwCpbY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PYad8Y09zS90YAGfHjTQhF8eKoJ0nHdxAH3WsOrzCCyE0reSxAqiChIAxmT6Qa7kB
         D5Hj0M42gAqibHziun3b7XW5k6nQFMosRsp6ZVPWTC7QSLMuyAZB2wu0deFLUyqRBD
         NOrlJPP8ZYYu6n9dfkMDI6trZzD8GzTeJ8GVYe+zqZl8tnmU0MYUuXFwWHF+TqJPno
         Q5ASqbtdl5EM8d+xHCxLjGxf9njmPQLNbTCcF35sx+VBNANzezQltrP/Yh5BT0wl27
         v4y8r19N+ll9xxR6fACn9kR70+Pgm3n690sOC0iHTw/VXytC5zsAIxwl5tduShLyks
         145M24X0DJCaA==
Date:   Tue, 4 Apr 2023 14:33:06 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jaewon Kim <jaewon02.kim@samsung.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andi Shyti <andi@etezian.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Rob Herring <robh+dt@kernel.org>, linux-spi@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Chanho Park <chanho61.park@samsung.com>
Subject: Re: [PATCH 3/3] spi: s3c64xx: support interrupt based pio mode
Message-ID: <49b335e6-78a7-4f80-a844-bacef804849e@sirena.org.uk>
References: <20230404060011.108561-1-jaewon02.kim@samsung.com>
 <CGME20230404061409epcas2p2b12a9cac014907e3930795cb67cb6040@epcas2p2.samsung.com>
 <20230404060011.108561-4-jaewon02.kim@samsung.com>
 <61a67466-3467-4f71-bc27-d660e37c08ac@sirena.org.uk>
 <e01900f0-e5ac-d2f9-9e1b-c5cc35d21713@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8I2SOfqEj79ZOI8K"
Content-Disposition: inline
In-Reply-To: <e01900f0-e5ac-d2f9-9e1b-c5cc35d21713@samsung.com>
X-Cookie: Being ugly isn't illegal.  Yet.
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8I2SOfqEj79ZOI8K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 04, 2023 at 10:15:05PM +0900, Jaewon Kim wrote:
> On 23. 4. 4. 21:58, Mark Brown wrote:

> > Is there some lower limit where it's still worth using polling, for
> > example for just one or two bytes like a register address?  Taking an
> > interrupt isn't free...

> I did not considers lower limit.
> According to your review, interrupt seems to be called too often.
> However, It can't prevent the CPU utilization going to 100% during spi=20
> transmission.

It's not so much that the interrupt could be called too often as that
the time taken to take the interrupt (including all the overhead the CPU
has) might be large compared to what busy waiting would take if the
transfer is very small.  If the FIFO is deep enough and the transfer is
long enough to use that then you start to see a win from interrupts.

> We will give more consideration and deliver a better solution to the=20
> next patch version.

Great.

--8I2SOfqEj79ZOI8K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQsJxEACgkQJNaLcl1U
h9Bicwf+IGoOzSXyZBgGXE8HPLU++uPBbikKvcSeB0Q/xa38kvp7mbL/FPKQv6Ih
r1ci/kFUzUZZEHxjZfJOe7uVaV2bZMCo1UZphoP22Zb+zH6yomfVlDZT65Lo0NeL
eW3D1MEa+ZbJObdsFYBzMMni1PENOTNQIhhqXJdWjBvt+4gGd3j71oDO33RChyw2
0jqVlVnLHDtXM1YLFS8pod3jlNJv1M1UtqdJ8IzFWSenjVBMIfpRm+OIYNsMS2bu
MrEyykoqB9OJVuIlb27pCv9I4z+9yznCSw2WvCAYB8pVSuXxdlA7DIv2DiHUUFKy
iLrdAfhscaa/x+nc1bVr7MAL++68Kw==
=OzOm
-----END PGP SIGNATURE-----

--8I2SOfqEj79ZOI8K--

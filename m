Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E00264A442
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 16:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232374AbiLLPhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 10:37:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232290AbiLLPg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 10:36:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1836F959B;
        Mon, 12 Dec 2022 07:36:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B0BB2B80D53;
        Mon, 12 Dec 2022 15:36:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A28F1C433EF;
        Mon, 12 Dec 2022 15:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670859416;
        bh=3xjGxpTU+uAlErxm+6V13eo7pAhpayNah3d0WO3wiak=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ankc2UWgSEwXXsJNdufE3nbPUAcqxg6QNkfU64wkwb5y1YetnuV1L037jyLlkva4X
         ohtZQhosg4nDJ7p5su7G34J7AWRTA7bJHWUC8Au61QKpSZ/sK0bLqxhQ49Tmjvtdrj
         0TunmuHfbcuJrGLA66Z5an+mH9CUoj53HQsj10/2vDoXmbhJFE/H6GT9pTzSHYFHOy
         M2SMlVDPkdqiejzdinA/gI0OXHWo1kTKa/NDOt+ry9726IdKNQTlMckg/s0jzlBvpK
         j4BAooH92FmNo49cYOY7qSwPsJa58mJikw5h4Mh49MlUtEnmq6YSo7myQNRJXd8zaU
         6CtYQXfXvMq9A==
Date:   Mon, 12 Dec 2022 15:36:51 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v1] spi: xtensa-xtfpga: Fix a double put() in
 xtfpga_spi_remove()
Message-ID: <Y5dKk+uw3UcW2Pu1@sirena.org.uk>
References: <7946a26c6e53a4158f0f5bad5276d8654fd59415.1670673147.git.christophe.jaillet@wanadoo.fr>
 <CAMo8BfKCv9j-ftKWU+B27g1oHBB_=EZhGBH7qymyVAeF10JcnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EHvVr8XnbtwPXPXJ"
Content-Disposition: inline
In-Reply-To: <CAMo8BfKCv9j-ftKWU+B27g1oHBB_=EZhGBH7qymyVAeF10JcnQ@mail.gmail.com>
X-Cookie: It was Penguin lust... at its ugliest.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EHvVr8XnbtwPXPXJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 10, 2022 at 06:48:02AM -0800, Max Filippov wrote:
> Hi Christophe,
>=20
> On Sat, Dec 10, 2022 at 3:52 AM Christophe JAILLET
> <christophe.jaillet@wanadoo.fr> wrote:

> > 'master' is allocated with devm_spi_alloc_master(), there is no need to
> > put it explicitly in the remove function.

> >         spi_bitbang_stop(&xspi->bitbang);
> > -       spi_master_put(master);

> This put is matching the get in the spi_bitbang_start.
> It was discussed here:
> https://lore.kernel.org/linux-spi/CAMo8BfJaD7pG_iutY8jordysjChyzhTpVSqpxX=
h3QoZsj2QmaQ@mail.gmail.com/

Probably worth a comment though since it is a bit of a gotcha.  Ideally
we'd improve this in the bitbang code but that's harder.

--EHvVr8XnbtwPXPXJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmOXSpIACgkQJNaLcl1U
h9BT0Qf+NdrWJWMDdjoqnd5CyDhVDKdBCD/mS40Y9yT/7kC/kmCpKV3k5xsYhfxl
TLdaRq5V3JYZX9L/jCwANwlCm9+hFNp+X2BMeum0UnPQ3tqmf1HXUw1JudlRpb/7
k4h6vxqi5b4vd4bAeLztmRpN999BHuZPnR5lfbnCMLCJHGe2WIR63+fUJDVs20z4
sMLRCVN9hQbLN3qSp6CKdCdwPXrJf9O0H/2oLtwjEB2qG9F9Z3M9pHGBZceRR3tV
hdhpXl1deQauicERPLIG5O1lXhTF5oqgU2Wx3qFfY1hlWykwBiumjFSNfDRkhYjO
sff6XWL/4MqS9TkWh2YuDoxHeFscbQ==
=sjZz
-----END PGP SIGNATURE-----

--EHvVr8XnbtwPXPXJ--

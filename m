Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7136A64065F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 13:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbiLBMH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 07:07:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232364AbiLBMHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 07:07:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20F621E3C
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 04:07:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3416462289
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 12:07:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E96C7C433C1;
        Fri,  2 Dec 2022 12:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669982873;
        bh=QL08V1CblNQ344sEitshQJpL3YPFWoVO6Z8OdfPPB0U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RJrww0dSL0LWtWKJq6omLZUVF6wGmYVGbogyRMVshRt/x+pnUwtssR0yJkJKxqpKm
         HP+5vkWiQpUpW9x1aawnO7AwhG3XHsEIOYFoHqDdpi+BZX3Pk8wc7wtmiMHu0QQdaY
         6ORvwdx+l3rFedkeLdV8rPt9Gn9wTOZL0dYiLZ3EMvsRIPt+7USWmML33zxgu28s1E
         h0pDAZcoJM6XBThoRykOUc61HmEEOyCOvv+svsklTUAtT5dgBzp6hl0HE1m8tuvc1w
         edRdZDhGCZ83dzoW3/HGWG53G4m4cERrA10RyxtFh+T2iFawEiC65oKz6+pecbQjVG
         +uwcYuOFnwu7g==
Date:   Fri, 2 Dec 2022 12:08:13 +0000
From:   Mark Brown <broonie@kernel.org>
To:     ChiYuan Huang <u0084500@gmail.com>
Cc:     lgirdwood@gmail.com, lee@kernel.org, matthias.bgg@gmail.com,
        yangyingliang@huawei.com, chiaen_wu@richtek.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        ChiYuan Huang <cy_huang@richtek.com>
Subject: Re: [PATCH 1/2] regulator: mt6370: Fix potential UAF issue
Message-ID: <Y4nqrcw3LGfj3OZR@sirena.org.uk>
References: <1669797463-24887-1-git-send-email-u0084500@gmail.com>
 <Y4iTVmOA5P/aN2yb@sirena.org.uk>
 <CADiBU3-gr1OrH0_OtuWyAN8WwvZtPghC6zfB3NYuVTq4b+DZBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IykTNXYspChJUhfV"
Content-Disposition: inline
In-Reply-To: <CADiBU3-gr1OrH0_OtuWyAN8WwvZtPghC6zfB3NYuVTq4b+DZBw@mail.gmail.com>
X-Cookie: Ego sum ens omnipotens.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IykTNXYspChJUhfV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 02, 2022 at 11:35:35AM +0800, ChiYuan Huang wrote:
> Mark Brown <broonie@kernel.org> =E6=96=BC 2022=E5=B9=B412=E6=9C=881=E6=97=
=A5 =E9=80=B1=E5=9B=9B =E6=99=9A=E4=B8=8A7:43=E5=AF=AB=E9=81=93=EF=BC=9A
> > > The original code uses i2c dev as the parent in order to reuse
> > > the 'regulator_of_get_init_data'. But this will cause regulation
> > > constraint devres attached to i2c dev, not the mfd cell platform
> > > device.

> > This is a general issue which will affect a lot of MFDs, we would be
> > better to fix this by changing the API to provide a device to be used
> > for the devres allocations separately to the one used for looking up the
> > DT.

> Not to affect too much, the better way may change the 'regulator_register=
' API.
> Append it as regulator_register(dev, .....
> This could separate device object with devres allocation and DT lookup.

Yes, I think so - a new optional argument.

--IykTNXYspChJUhfV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmOJ6qwACgkQJNaLcl1U
h9BboQf/fkr05047bYXQZwnpRvQs/KoEOmkQQY7wZUDoqQSBwDGwjV8wi2Z2sAo3
lq4q5n1FW9Qtbk26Ui68g9Zt7hIUZFUOm8af//67agU/fvV8fKwNa/haBywcp8yw
cwKyW6Ih4LOTSOPJtukyx9Jm0Qu+gZHYh/p4YGq8Lw4C5bUjQDPvr2HeMVhl8oc1
uCphypPS/RV46dFBIM714iq7Hpb3w9ted0qh2+LrGchXYq43SQPeK6auKlu+xVcT
3MhEYJVohvXkIAnvZ5WYu3EUgi5KG6zHmWW6f69wW6gjoo+9zuytnJQBHjgq/zRJ
x1c5vobZCCUD0YkFLG5tlq4ZobYw9Q==
=wnjD
-----END PGP SIGNATURE-----

--IykTNXYspChJUhfV--

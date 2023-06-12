Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAEA572C91E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 17:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238384AbjFLPAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 11:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238381AbjFLPAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 11:00:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 724C6107
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 08:00:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1000662A55
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 15:00:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ECFDC433EF;
        Mon, 12 Jun 2023 15:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686582013;
        bh=QtZWXAHvARlQLvUd2fC00RV4UP1psA0SwlOlfB2V/As=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y4/8d661R1Q/OpFd20gUTSV9oA9EBifEfTX31anNh7NWx/9KEcI+fJWCIYsvROI+S
         0tmtdKPM5nXRXRFGbYuAU+EoiBkXyXVn/c3xqTdw4IYoE551hmCXXuhs4FzbK3sJVa
         NbMmplEROpb7MDVFTJIm1G3h4YEEbLbfe12WM5ll6s1dFiUwvIQjE0zTm8NXyaxl43
         hpvmZrGiprc0RuAsW2LA8wZLE5eMooAd6YMSD1EMD7KIez62Rk7QwW9AzEfFchgZs+
         GehU0GCr7KURGKiWflOLge8L0QUFEzeBUOPwAGlNDgJOxJlv+xN3w/uT0I+oUFd4PB
         QUsBHaeIf07fQ==
Date:   Mon, 12 Jun 2023 16:00:06 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Waqar Hameed <waqar.hameed@axis.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, kernel@axis.com
Subject: Re: [PATCH] regmap: Add debugfs file for forcing field writes
Message-ID: <443d4c43-080e-48b2-80ee-13e2df10c6eb@sirena.org.uk>
References: <pndttvcu3ut.fsf@axis.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3/JsMC4KPqvSmkpY"
Content-Disposition: inline
In-Reply-To: <pndttvcu3ut.fsf@axis.com>
X-Cookie: If it heals good, say it.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3/JsMC4KPqvSmkpY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 12, 2023 at 04:53:35PM +0200, Waqar Hameed wrote:
> `_regmap_update_bits` checks if the current register value differs from
> the new value, and only writes to the register if they differ. When
> testing hardware drivers, it might be desirable to always force a
> register write, for example when writing to a `regmap_field`.
>=20
> This enables and simplifies testing and verification of the hardware
> interaction. For example, when using a hardware mock/simulation model,
> one can then more easily verify that the driver makes the correct
> expected register writes during certain events. Add a bool variable
> `force_write_field` and a corresponding debugfs entry.

If we're going to do something like this which could interfere with
driver operation then it should be guarded like the write support is so
that people using it have to modify the kernel to get the feature, or at
the very least taint the kernel.  This is less invasive but still might
cause issues if someone is relying on read/modify/write behaviour.

--3/JsMC4KPqvSmkpY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSHMvUACgkQJNaLcl1U
h9AnHAf/Vin2gCAyJvas7TYlyP/CfB4dknneqdWm5jp6cdfU4AGv/XSc1H2JOeKK
QwS4GX11KbgyOYG9ZaN1yDktuTyeTvKany+WlRk0/s/Fkrk9GVCkTgIMWlCuTc2I
fG8DfH9yaw3lwT3B8U8qEsyxhXsXbrKiW8Fxpx7F+Gjaa8bn8IOdRLcyo4VeXBSn
xwufXm/kn5xg/bcd6AFQsS7IDO3FWn9x/84Bvg1UEHAxbr8aukuI9wmP2oMODcsW
eZgJVwjwf2a+Xg8+iLgszYuXz1zB6nWOD7v72mIHk9HTLQKb2yKJ34xVz08cmg8t
pc6jLWoCQ3fgtHcsRdtfC4GvWp6S/g==
=IjNN
-----END PGP SIGNATURE-----

--3/JsMC4KPqvSmkpY--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15F9D733C0F
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 00:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233081AbjFPWC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 18:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbjFPWC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 18:02:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C08119
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 15:02:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 396D16157B
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 22:02:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30A07C433C8;
        Fri, 16 Jun 2023 22:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686952975;
        bh=zcOm/QwiBNheO0cSdv1r2bufZYMqBBT/qtFj2cPBYJo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oBZlngykMVNo8QKpI0x7rcvf+9r21iMCxXk0GqYiwk6XeMzPbLUo8/KdzeO1EWfPZ
         E4jPmrJn4et7kdyCpAJVOnC6qo3Bwm6lVQZLFDSUIztrDA5iiGLOk3sPELjOPGzDlq
         iqqQtKXlE62shQspLarYnQe5IS7cVThNCHNSwvCSWQq+FQpolOhzkmHPMDlCg/DryO
         ApqTLyeQ3HezzxdiPqtBnaM8IWFZKz3o9a8qlDrZaWpjFaElW4rbZeQ7bWZYphnllc
         LlmORlj2QuFlY7qKMf/e/iyUoW1K80O+shHBGZZulDEk5zmNPCZpT5iUvQwdkC3U1U
         rI2ffhgyFj26A==
Date:   Fri, 16 Jun 2023 23:02:51 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Russ Weight <russell.h.weight@intel.com>
Cc:     Jim Wylder <jwylder@google.com>,
        "Gerlach, Matthew" <matthew.gerlach@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [BUG] _regmap_raw_write() - divide-by-zero
Message-ID: <ab5b9153-5031-4a54-9966-d0eddd3e76a1@sirena.org.uk>
References: <02da121f-d6f1-73de-1805-4b331ccbc547@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LXUNKlwqyb2J9CuH"
Content-Disposition: inline
In-Reply-To: <02da121f-d6f1-73de-1805-4b331ccbc547@intel.com>
X-Cookie: P-K4
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LXUNKlwqyb2J9CuH
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 16, 2023 at 02:58:24PM -0700, Russ Weight wrote:

> > +=A0=A0=A0=A0 size_t max_data =3D map->max_raw_write - map->format.reg_=
bytes -
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 map->form=
at.pad_bytes;

> For the SPI-Avalon implementation, the values used to calculate max_data =
are:

> regmap->max_raw_write =3D 4
> regmap->format->reg_bytes =3D 4
> regmap->format->pad_bytes =3D 0
>=20
> So the above calculation for max_data is: max_data =3D (4 - 4 - 0) =3D 0

How does this bus work?  The device can accept a maximum of 4 bytes of
data but the register is 4 bytes in length so there's no space to
transmit a value.

--LXUNKlwqyb2J9CuH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSM3AoACgkQJNaLcl1U
h9C04wf/R0aO0xgZLnWO5ZY88919MwHEhk1/1ihZOO2yafV9hBbq3r/BplYs2LSX
IxdT8oTT90bNxK7knllKOLyDbZXSYsKlwQ5O68Uj5/Cj4Np3WlREstIVTP5kGdxb
mm81K9DDY2Cu02QqsCTtcRxXrIEhZc9xECOYxT61CQykSBMvRyL22Y+jO3XQWuDI
IayCDwhv/74WR8+FxvceW1CTUdlqDhjNj+xOGkt5e3A3TJC9jw3qlNMhDGImFY31
UhMIALWEI1LvX2TvOeb7HegdKsKzEmsVDU/o6oZUf/NHHw1eBr6kJcWsUtaNaI7N
3N4SH5Wbp5XBsV5n3pos/QtLl+F95g==
=7syZ
-----END PGP SIGNATURE-----

--LXUNKlwqyb2J9CuH--

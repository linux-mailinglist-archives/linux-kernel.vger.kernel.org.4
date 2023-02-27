Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCEE36A427A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 14:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjB0NUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 08:20:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbjB0NUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 08:20:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE311E5E0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 05:19:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EDA5160E09
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 13:19:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F28C8C433D2;
        Mon, 27 Feb 2023 13:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677503991;
        bh=q7U2xzke593RtQxPnhYcUl3f0qGcllsfoS/yBNWq+58=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qkXjt/4f/7qpXmazwXHs5alEHuGNvKTzMwkH+Z9JgRbHSsemuNZx7xEH/Ikd0bcVh
         FzbIZWY+gRtRP4ypDpTR99eBRcg4wF6yFWGmYxVIuo+IPqPjJT6613cuyjwjpIpYQG
         kbDowUJOOpR9MmGlhDpbMSmqu5AAu3PIUKIgHvgLmL7lniPeQYxQuHiNXUdNBdTl8l
         m8s+gqaq8xSvzVs03DEHdsBQMIA216Qrgk16NW3GQMGgN/eoQrQ9toF+3AeF+F78rR
         L3wc7vDKBQEDiEFCmQj+H9tTtI0SLETvvwhG+2gVyTMGg04EgRfeLnDcxmfKt00k6V
         d2B9g1RV3AM5A==
Date:   Mon, 27 Feb 2023 13:19:46 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Sascha Hauer <sha@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: About regulator error events
Message-ID: <Y/yt8nzVuO4sUg3v@sirena.org.uk>
References: <20230227130542.GM32097@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pINIVsOxWDmKzuCu"
Content-Disposition: inline
In-Reply-To: <20230227130542.GM32097@pengutronix.de>
X-Cookie: On the eighth day, God created FORTRAN.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pINIVsOxWDmKzuCu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 27, 2023 at 02:05:42PM +0100, Sascha Hauer wrote:
> I have a board here which has some current limited power switches on it
> and I wonder if I can do something reasonable with the error interrupt
> pins these switches have.

Just noticed that Matti (who's been doing a bunch of work here) wasn't
CCed so adding him.

> The devices do not have a communication channel, instead they only have
> an enable pin and an error interrupt pin. See
> https://www.diodes.com/assets/Datasheets/AP22652_53_52A_53A.pdf for a
> datasheet.  The devices come in two variants, one goes into current
> limiting mode in case of overcurrent and the other variant switches off
> until it gets re-enabled again.
>=20
> At first sight it seemed logical to me to wire up the error interrupt
> pins to REGULATOR_EVENT_OVER_CURRENT events. That was easy to do, but
> now the question is: What can a regulator consumer do with these events?
>=20
> The strategy I had in mind was to disable the regulator, enable it again
> to see if the errors persists and if it does, permanently disable the
> device.  Disabling the regulator only works though when there's only one
> consumer.  With multiple consumers only the enable count decreases, but
> the regulator itself stays enabled. This means implementing such a
> policy at the consumer side is not generally possible. Implementing a
> policy in the regulator core seems awkward as well, as a good strategy
> likely differs between different consumers.
>=20
> A first good step might be to notify the user somehow. While we can get
> the overcurrent status of a regulator from
> /sys/class/regulator/*/over_current there doesn't seem to be any way to
> get a regulator event in userspace, right?  Would patches changing that
> be welcomed?
>=20
> There doesn't seem to be much prior art for handling regulator error
> events in the kernel. It would be great to get some input what others do
> in this situation, or to get some ideas what they would do if they had
> the time to do so ;)
>=20
> Sascha
>=20
> --=20
> Pengutronix e.K.                           |                             |
> Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--pINIVsOxWDmKzuCu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmP8rfIACgkQJNaLcl1U
h9BIAAf9EdwlthF5Bi25GDzhA1opCmMP1AUBGw/rh/jl0creSfO7ArhMNz2thZU2
2bpeG9C2Q+LRTIb9KEFDud6bAKMKR4NM4kOs9aCYyLzYGfwPkIMazevinW7ptBl+
NsXeGUN23GMSPbSjA40TyOeUd+W8sumYzZSC4/VxreiJH/qFN5X77F5juoZfwj0+
Q2RdQRFp9oKzE2sVksiaEPfeAoss5KrlDA6i4IGMa2zdmMMccwgz1jiuD43/3FY2
BPVzrZ13J0oViuxsByjVleh7F8uQmJPf8pA+ftUPTSi2JEld5nkeCvTSAG+FZjCq
E6IBpfM/yojLv/MibgAP7LClVyCjHQ==
=h+H3
-----END PGP SIGNATURE-----

--pINIVsOxWDmKzuCu--

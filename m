Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92592716BA7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 19:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbjE3RzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 13:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233352AbjE3RzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 13:55:08 -0400
Received: from vm3.sequanux.org (static.55.155.9.5.clients.your-server.de [5.9.155.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 116A18F;
        Tue, 30 May 2023 10:55:05 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by vm3.sequanux.org (Postfix) with ESMTP id D173D10810A;
        Tue, 30 May 2023 19:54:46 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at vm3.sequanux.org
Received: from vm3.sequanux.org ([127.0.0.1])
        by localhost (vm3.sequanux.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id WDJsLisvj2oh; Tue, 30 May 2023 19:54:02 +0200 (CEST)
Received: from localhost (ns3093303.ip-145-239-244.eu [145.239.244.120])
        by vm3.sequanux.org (Postfix) with ESMTPSA id 48AD61080DD;
        Tue, 30 May 2023 19:54:02 +0200 (CEST)
Date:   Tue, 30 May 2023 19:53:48 +0200
From:   simon.guinot@sequanux.org
To:     andy.shevchenko@gmail.com
Cc:     Linus Walleij <linus.walleij@linaro.org>, xingtong_wu@163.com,
        brgl@bgdev.pl, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, henning.schild@siemens.com,
        xingtong.wu@siemens.com
Subject: Re: [PATCH v2 1/1] gpio-f7188x: fix base values conflicts with other
 gpio pins
Message-ID: <ZHY4LFyyIGSMiMbm@localhost>
References: <20230529025011.2806-1-xingtong_wu@163.com>
 <20230529025011.2806-2-xingtong_wu@163.com>
 <ZHSZ9cK78qc5QeZD@localhost>
 <CACRpkdbiRsJqxVZPNLvLPK-MzEhyjSBGffuaTgP7tt40pGGoRw@mail.gmail.com>
 <ZHSunJyh2AU1eb0H@localhost>
 <ZHUmHkbM-l_pRaY3@surfacebook>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EvqLGyp/gUyZKEKs"
Content-Disposition: inline
In-Reply-To: <ZHUmHkbM-l_pRaY3@surfacebook>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EvqLGyp/gUyZKEKs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 30, 2023 at 01:24:30AM +0300, andy.shevchenko@gmail.com wrote:
> Mon, May 29, 2023 at 03:54:36PM +0200, simon.guinot@sequanux.org kirjoitt=
i:
> > On Mon, May 29, 2023 at 03:03:28PM +0200, Linus Walleij wrote:
> > > On Mon, May 29, 2023 at 2:27=E2=80=AFPM <simon.guinot@sequanux.org> w=
rote:
> > >=20
> > > > It would be nice if a pin number found in the device datasheet could
> > > > still be converted into a Linux GPIO number by adding the base of t=
he
> > > > first bank.
> > >=20
> > > We actively discourage this kind of mapping because of reasons stated
> > > in drivers/gpio/TODO: we want dynamic number allocation to be the
> > > norm.
> >=20
> > Sure but it would be nice to have a dynamic base applied to a controller
> > (and not to each chip of this controller), and to respect the interval
> > between the chips (as stated in the controllers datasheets).
>=20
> What you want is against the architecture. To fix this, you might change
> the architecture of the driver to have one chip for the controller, but
> it's quite questionable change. Also how can you guarantee ordering of
> the enumeration? You probably need to *disable* SMP on the boot time.
> This will still be fragile as long as GPIO chip can be unbound at run
> time. Order can be changed.
>=20
> So, the patch is good and the correct way to go.
>=20
> P.S. The root cause is that hardware engineers and documentation writers
> do not consider their hardware in the multi-tasking, multi-user general
> purpose operating system, such as Linux. I believe the ideal fix is to fi=
x the
> documentation (datasheet).

Some GPIO controllers (as Super-I/O) are multifunctional devices and
pins are multiplexed. Some can be configured to act as GPIOs and some
cannot. So there are holes. It is an hardware reality and not only an
issue due to poorly written documents (even if there are issues with
them too).

Today we work around these holes by splitting the GPIOs between several
chips. As a consequence "hardware" GPIO numbers don't exist in Linux. It
requires some work from a user to first find the chip a GPIO belongs to
and then compute the number. It is not terrible. But on some machines
with a lot of GPIO controllers and chips it can be quite challenging
(especially when ACPI is involved).

I am only saying it would be nice for Linux users if they could use
hardware GPIO numbers (i.e. as read in hardware documents).

But I understand everything that has been said by everyone and I agree.

Simon

--EvqLGyp/gUyZKEKs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEXW8DgovlR3VS5hA0zyg/RDPmszoFAmR2OCQACgkQzyg/RDPm
szpPrw//enZ4mLittCgaLn/8YMFwXMhlnKDLW2YrB6Slv+QFiC7akPgvmtyjUO1q
MyZiB8O3CGjIY1MFVyqmFgRvpJMINO/6bSqEty4iQwCOD41G9SUM7Bg1XKKvbbfl
ww0mwpcbLaxFM2bS1cLpVJwVBOjkg3Qt+sU8IhFjfWl3KpRSuNf313iv3DwjiUdM
iWzwu3H8UXVpPFMfvyu1uV5oA5BrlAyjaFuStzGC98k5KMUcrwvDK6pHeQtD2lc1
gIghw8LKPYKV0HfPMt7a9bTDDWCBAD4hUrzxnZq6hURFDFkyEfDc7R1FX5WWazCj
9aCuTnFg1c8zdPuWjBL5vQIRU8da5acjDMDvjoKEZcM0c71U0sPYXv047ZVHOuXD
OykUQnhCxuMRZqRo24It8NMZ6aZaDFzfAiixo2gw5bBOH99habvTr1dJntnkNzb1
lF2cAJAwDvPVXDyNrgJx3pUv039znVGvBS8Gdc1WSPhUMqRYZrnn+gNWfIR2HWPh
NaBR7DWn9XHaZ794HtLUDvi2F4rh+drBuTYWDDUCOL4hiJhShgkJxyRVUzE7456O
ud4AIyHpI/ROBLNkUuJcICdowM7D3R4+g6JiTpzOqUOO2s58hxDb+tRsbbUdhZ6T
1FmsehJgwsmnKtW/YehVdtMeCOlMLP8lWvZi4OCa7RyRHqpQbl0=
=lWq6
-----END PGP SIGNATURE-----

--EvqLGyp/gUyZKEKs--

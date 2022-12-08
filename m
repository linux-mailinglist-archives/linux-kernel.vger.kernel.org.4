Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCEF6474C5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 17:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbiLHQ6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 11:58:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbiLHQ60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 11:58:26 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF7DC7680B
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 08:58:24 -0800 (PST)
Received: from mercury (dyndsl-095-033-158-150.ewe-ip-backbone.de [95.33.158.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 37808660036A;
        Thu,  8 Dec 2022 16:58:23 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1670518703;
        bh=P2McKGJSYN/Q/1FW5RmK5ZByLS6xD9ZsyWAFpvSazLQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e118TZyzWDQwjJJIZcgD/2Wt+9lxQnJj+N+K3mYy+d8Abp7rxfo72+Xjn2oFRq+5r
         1u0wEbvPdxeFiSwuuvxA66W7MzGF/4RP2ALM/D2TpNrN/sQMpzZ3Zra+9jBrWyWG4S
         YIjmuGF81I/LgZHroMgDtORcYTrF3MeWNxW2u4jjYM2WVFGy7R2h3MNqtTAwZBQet/
         AnHmN9m9y3JHejeidWwr86w0bSLLgb/uMcZZMI+G1V6hKt0CP78R3KnNcxHx/KWFqS
         unL7wM5DZLq5mlimoSMr7GeyxBzsm0SIAny4WcNmooqemWRXqDBJnfBSw10LwOFNDL
         oDj+stbG+nZIQ==
Received: by mercury (Postfix, from userid 1000)
        id B74FD1060F43; Thu,  8 Dec 2022 17:58:20 +0100 (CET)
Date:   Thu, 8 Dec 2022 17:58:20 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Harry Song <jundongsong1@gmail.com>
Cc:     Marc Zyngier <maz@kernel.org>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] irqchip/gic-v3-its: remove the shareability of ITS
Message-ID: <20221208165820.5maej4we3mfdeprm@mercury.elektranox.org>
References: <20221207135223.3938-1-jundongsong1@gmail.com>
 <86a63zkzru.wl-maz@kernel.org>
 <CAJqh2T+h2oHZoxc5-zbjPWEGFUVnTs9JB04Dh-sR4WeUMYrj2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2m3s3tijkpchtwwb"
Content-Disposition: inline
In-Reply-To: <CAJqh2T+h2oHZoxc5-zbjPWEGFUVnTs9JB04Dh-sR4WeUMYrj2A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2m3s3tijkpchtwwb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Dec 08, 2022 at 10:28:29AM +0800, Harry Song wrote:
> On Wed, Dec 7, 2022 at 11:19 PM Marc Zyngier <maz@kernel.org> wrote:
> >
> > On Wed, 07 Dec 2022 13:52:23 +0000,
> > Harry Song <jundongsong1@gmail.com> wrote:
> > >
> > > I know this is a very wrong patch, but my platform
> > > has an abnormal ITS problem caused by data consistency:
> > > My chip does not support Cache Coherent Interconnect (CCI).
> >
> > That doesn't mean much. Nothing mandates to have a CCI, and plenty of
> > systems have other ways to maintain coherency.
> >
> > > By default, ITS driver is the inner memory attribute.
> > > gits_write_cbaser() is used to write the inner memory
> > > attribute. But hw doesn't return the hardware's non-shareable
> > > property,so I don't think reading GITS_CBASER and GICR_PROPBASER
> > > here will get the real property of the current hardware: inner
> > > or outer shareable is not supported, so I would like to know
> > > whether ITS driver cannot be used on chips without CCI, or
> > > what method can be used to use ITS driver on chips without CCI?
> >
> > It's not about CCI or not CCI. It is about which shareability domain
> > your ITS is in.
> >
> > And it doesn't only affect the ITS. It also affects the
> > redistributors, and anything that accesses memory.
> >
>=20
> Yes, my current chip is Rockchip platform (rk3588), so is it because the =
chip
> is not designed as a proper shared domain for ITS, so the exception of
> ITS is caused?
>=20
> > >
> > > The current patch is designed to make ITS think that the current
> > > chip has no inner or outer memory properties, and then use
> > > its by flushing dcache.
> > >
> > > This is the log for bug reports without patches:
> > >
> > > [    0.000000] GICv3: CPU0: found redistributor 0 region 0:0x00000000=
03460000
> > > [    0.000000] ITS [mem 0x03440000-0x0345ffff]
> > > [    0.000000] ITS@0x0000000003440000: allocated 8192 Devices @418500=
00 (indirect, esz 8, psz 64K, shr 0)
> > > [    0.000000] ITS@0x0000000003440000: allocated 32768 Interrupt Coll=
ections @41860000 (flat, esz 2, psz 64K, shr 0)
> > > [    0.000000] GICv3: using LPI property table @0x0000000041870000
> > > [    0.000000] GICv3: CPU0: using allocated LPI pending table @0x0000=
000041880000
> > > [    0.000000] ITS queue timeout (64 1)
> > > [    0.000000] ITS cmd its_build_mapc_cmd failed
> > > [    0.000000] ITS queue timeout (128 1)
> > > [    0.000000] ITS cmd its_build_invall_cmd failed
> >
> > Ah, this suspiciously looks like a Rockchip machine...
> >
> > >
> > > Signed-off-by: Harry Song <jundongsong1@gmail.com>
> > > ---
> > >
> > > I am very sorry to bother you. This problem has been bothering me
> > > for several weeks.  I am looking forward to your reply.
> >
> > If you have such issue, this needs to be handled as per-platform
> > quirk. I'm not putting such generic hacks in the driver.
> >
> >         M.
> >
> > --
> > Without deviation from the norm, progress is not possible.
>=20
> Are there currently other chip platforms that have this problem, and then=
 ITS
> is already compatible with the problem? Please tell me how to submit
> hacks patch for rk3588 platform?
>=20
> If the hacks patch cannot be submitted, please tell me whether it
> requires the next generation
> chip to have any design requirements for ITS?
>=20
> Design ITS and CPU to be the same inner memory property?

Previous rockchip generation has the same bug and it got discussed
here:

https://lore.kernel.org/lkml/871rbdt4tu.wl-maz@kernel.org/T/#m5dbc70ff308d8=
1e98dd0d797e23d3fbf9c353245

You can use this DT as base with mainline to avoid ITS:

https://lore.kernel.org/all/20221205172350.75234-1-sebastian.reichel@collab=
ora.com/

-- Sebastian

--2m3s3tijkpchtwwb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmOSF6EACgkQ2O7X88g7
+pq3+Q//TSgzJ5/1+3Y73ppgbI3jfueKQZ0E0fcEZZL8mXJYez1q6FoCyViuU5/D
+jGmunhzUOYBDVswf10iQ68vRNBMrCa8mubr62++EaSRahHLBshL49HNDgiZrLv8
X1XciBGmtZFnUWdTECc74fXfEYC4CPR2XCpY5tVCRrj3h/4PkAskaMvEGMUzt1dd
hPaowB/anhq/HRkBGnvIfPm2vx3+aZHeAU93emryJCcIYgbxyMMUNfqy6okS0u5C
iSStghNHb7opGrjWblbc5JiBnOLARbqm3dnf4bp5eFuk+fq5ntHK+gw26Hms0D+W
npFXfx0YVNNLHAtnkcdqwC/ps1Ai5EZWGbw2ULtthe6yVXBdsSUzw28cN/4Bzkuw
bHZ2URilImQzxWMqRCU6SAwbhu6JYtCFRetmqY2u0PJ6daKNp/8o2+OsGI/SxOQl
MBEEUBPyqRfrE7C0vMHsjLdMj2OhL3ryr6ayyDuJbkj2axPhAhozlZPhTF7ymCXu
92lLqOtvKeYMEwl06YHJquJ9dyYWDIclgOg/4kyu1k7zs2QdPhYrYVW59zKNvwUO
aPjkHVcZQ7rVl3pmM0exFy7V2j8jq5PdgYMf1BEMzHI9djclQTFloxPG4jWzkiGr
3eLjnBsGWKJ1LwSWHKZ4K0NRg8I2bxSY4pLWNiFweKy+dArR3FQ=
=ondU
-----END PGP SIGNATURE-----

--2m3s3tijkpchtwwb--

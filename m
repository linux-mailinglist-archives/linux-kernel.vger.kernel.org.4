Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3625774ED81
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 14:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjGKMBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 08:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbjGKMBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 08:01:39 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06FA4E77;
        Tue, 11 Jul 2023 05:01:37 -0700 (PDT)
Received: from mercury (dyndsl-091-248-213-212.ewe-ip-backbone.de [91.248.213.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3BE4E6607007;
        Tue, 11 Jul 2023 13:01:35 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689076895;
        bh=VpEG3ri1MmPk1vvBqKyVzFd1wmdbrZrML5Y0FqY4wUg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HQDJgxlTR8vo1RaEsB3D+nH2+IRG9QN4tbrCrAaA85UTPwMmgGSzMeLBmp8bq8Ej6
         pgwZP23sqCYBHYEmhmfwkK6ZwddZDGY5nvAyjCHRxCLhh+PU1kHLVi4qEYii04KpmG
         cZIBzK40pXQjgo62B5RaZ5YhAs3eAX9lyz/b27cO1rLw+fmbUEzB/bIkdWz6tNdnsD
         l37m5GS8joB/wsoJ81rU7USdQhqBwTSytws8Gf8fo6kkpx4AITWu33A+o3yUYXuRI2
         WpJS6erpP2P9LRQMv/o3BmpdZLgyRs0csbkK1sM9hkgaBX9fGW0SBkbzX/Ag+Cs0tn
         nvbJMMzvoOh0A==
Received: by mercury (Postfix, from userid 1000)
        id 34BCD106765E; Tue, 11 Jul 2023 14:01:33 +0200 (CEST)
Date:   Tue, 11 Jul 2023 14:01:33 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Amit Kumar Mahapatra via Alsa-devel 
        <alsa-devel@alsa-project.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>,
        Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-riscv@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Sanjay R Mehta <sanju.mehta@amd.com>,
        Radu Pirea <radu_nicolae.pirea@upb.ro>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH v2 05/15] spi: Remove code duplication in
 spi_add_device_locked()
Message-ID: <20230711120133.45drgk46y4cz7aut@mercury.elektranox.org>
References: <20230710154932.68377-1-andriy.shevchenko@linux.intel.com>
 <20230710154932.68377-6-andriy.shevchenko@linux.intel.com>
 <7557bada-3076-4d6e-a5c5-d368433706e2@sirena.org.uk>
 <ZK03rBqoQ0IZz617@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fcthwhge3iyvg2gl"
Content-Disposition: inline
In-Reply-To: <ZK03rBqoQ0IZz617@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fcthwhge3iyvg2gl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jul 11, 2023 at 02:06:20PM +0300, Andy Shevchenko wrote:
> On Mon, Jul 10, 2023 at 06:16:22PM +0100, Mark Brown wrote:
> > On Mon, Jul 10, 2023 at 06:49:22PM +0300, Andy Shevchenko wrote:
> > > Seems by unknown reason, probably some kind of mis-rebase,
> > > the commit 0c79378c0199 ("spi: add ancillary device support")
> > > adds a dozen of duplicating lines of code. Drop them.
> > >=20
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > ---
> > >  drivers/spi/spi.c | 11 -----------
> > >  1 file changed, 11 deletions(-)
> > >=20
> > > diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> > > index c99ee4164f11..46cbda383228 100644
> > > --- a/drivers/spi/spi.c
> > > +++ b/drivers/spi/spi.c
> > > @@ -712,17 +712,6 @@ EXPORT_SYMBOL_GPL(spi_add_device);
> > >  static int spi_add_device_locked(struct spi_device *spi)
> > >  {
> > >  	struct spi_controller *ctlr =3D spi->controller;
> > > -	struct device *dev =3D ctlr->dev.parent;
> > > -
> > > -	/* Chipselects are numbered 0..max; validate. */
> > > -	if (spi_get_chipselect(spi, 0) >=3D ctlr->num_chipselect) {
> > > -		dev_err(dev, "cs%d >=3D max %d\n", spi_get_chipselect(spi, 0),
> > > -			ctlr->num_chipselect);
> > > -		return -EINVAL;
> > > -	}
> > > -
> > > -	/* Set the bus ID string */
> > > -	spi_dev_set_name(spi);
> >=20
> > I see that this is duplicating spi_add_device() (and we really could do
> > better with code sharing there I think) but I can't immediately see
> > where the duplication that's intended to be elimiated is here - where
> > else in the one call path that spi_add_device_locked() has would we do
> > the above?  Based on the changelog I was expecting to see some
> > duplicated code in the function itself.
>=20
> Oh, by some reason Sebastian wasn't in this rather long Cc list.
> Added him.
>=20
> Reading again I don't see any useful explanation why that piece of code h=
as to
> be duplicated among these two functions. It's 100% a copy.
>=20
> Sebastian, can you shed some light here?

The patch in this thread is obviously wrong. It results in the
checks never beeing called for spi_add_device_locked(). The copy is
in spi_add_device() and those two are not calling into each other.

But it should be fine to move the code to the start of
__spi_add_device(), which allows removing the duplication. In that
case the code will be run with the add_lock held, which is probably
what I was worried about two years ago. Looking at it again, the
lock is held anyways in case of spi_add_device_locked().

Greetings,

-- Sebastian

--fcthwhge3iyvg2gl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmStRJIACgkQ2O7X88g7
+pp6dQ//QWqSMddfA8JIA4/cd4pYKRoojbIso2JQaAhIWBB48KjH/GX7xoNCH4Ig
MRloAncuXxqH1quGGpphBRJL2bAKVRcinKKtYdwCyM6P422hjD5GqVDKOr2H1u2f
4+wWcKeKNk5ect4iYj/kRZYYpdlJzxK1hsd7bCwBCz3I0k7rlxqIg5td7e/7Q7CC
4bvNEtL0Ub1iB+vzDNoqNKN48Bp87xr+kM1wSDsDhPqf1TrTmxgOFIYNmy2x+XuV
20ZRE4olEfUMFlPNNCaAurOPVZmclVstzBUwRhU7uVBH4/ZnbY02wsklP0D8SbV8
inFOurRiLtWaRSQfkwMEF2DAp4l5a6eWVyuy5Rf0mdVmgq9bgeXFycbiYkOM6Gsz
aQ0g5SV64PYZSwPljucB28GrWfLdDNlp693elljAeDElhbF1bqhbVozqhkyfH5Ih
J4wpwr/DgZaW31B0V/sQVlJTIRtjAmIRgydid81aaSOzXmW0B+Pu74EU/cMNcy0f
iSGRdSPX+eA5OPNHQWPz1RQvJOHMVrMBXTdSCeVzZdV4VSTZSv9/LL922e9qK2DB
yGQTeUox+5d2hdcQlSmo+LQGhiZiiJ9qoVWPsWjhNwbb3fh3HCSP9X/BJHNNGzqr
WU6SN8gRjCaL3/i5pT08DOL6WdKhn/qo8EzCnOBxloSjD2uF1Ic=
=v6T3
-----END PGP SIGNATURE-----

--fcthwhge3iyvg2gl--

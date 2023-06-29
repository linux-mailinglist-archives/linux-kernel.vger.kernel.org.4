Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18615742BE1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 20:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbjF2SWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 14:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbjF2SWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 14:22:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC5530D1;
        Thu, 29 Jun 2023 11:22:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 87880615C7;
        Thu, 29 Jun 2023 18:22:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37851C433C9;
        Thu, 29 Jun 2023 18:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688062939;
        bh=LmVKEvlfrCp38ndlcJ7ai+4hhJf5wPQVkKslwbu0qPY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bM5jGVlShIhjToBk4/RHKtk65h9U6/dvQKgESlS3VCPAItIb/EKkk38ASYooRGk+3
         64pGbSu8o0n+EYB8nX7j46JLz7Y8CLI3UJC8biCX4I2WLyZZLBDkRdgMoFr0UiDwdX
         bvgTYiXjI4MMZj2dTLODfktzG/6zgu5do4ZhbAv4dCBKSzoxdLTuq0VjtLK6i/6tQF
         K/MRkJyeut+QpTBkI6sWLJUK+wt2vUB/kR2eF799K0Ds8h67p2stsasOvnrgw0cs8Y
         UNvwU1CuGxNZjTcZ9Bi+PoTAdJeVNUMV7FUfXuG2QG5EJi6mmPz++qJzb7eb3rxbn4
         GJ90eTMRprwIA==
Date:   Thu, 29 Jun 2023 19:22:10 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Lee Jones <lee@kernel.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        "Sahin, Okan" <Okan.Sahin@analog.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        "Bolboaca, Ramona" <Ramona.Bolboaca@analog.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        "Tilki, Ibrahim" <Ibrahim.Tilki@analog.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v7 5/5] mfd: max77541: Add ADI MAX77541/MAX77540 PMIC
 Support
Message-ID: <920531c8-b5c1-409a-9cda-3ec77ba944e7@sirena.org.uk>
References: <CAL_Jsq+Z64tuMO8a2Y=2GrXZ8q0L4Z2avCiphsn0HOOC71Dzjg@mail.gmail.com>
 <20230628134013.GH10378@google.com>
 <472a4d86-3bfb-4c2b-a099-f1254dd01e24@sirena.org.uk>
 <20230629072500.GA2110266@google.com>
 <d070eecd-cb3b-4968-803e-1817a1a4359a@sirena.org.uk>
 <20230629155134.GB2110266@google.com>
 <7987cbbe-55bc-49a9-b63a-7f1906bf5f74@sirena.org.uk>
 <CAL_Jsq+AQrv7EGMtEkB-2cBCvA4mLHuMbyQ=f39yQkYPkvfVww@mail.gmail.com>
 <998ef8d8-594e-45e3-9aa3-ec9061cf7f11@sirena.org.uk>
 <CAL_JsqK1X-oZHerE9qhcPZ=mFsm7rJa3KxWGBqV3znHHfr6vaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jmO1Z9R8VzyzQrxj"
Content-Disposition: inline
In-Reply-To: <CAL_JsqK1X-oZHerE9qhcPZ=mFsm7rJa3KxWGBqV3znHHfr6vaQ@mail.gmail.com>
X-Cookie: Surprise due today.  Also the rent.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jmO1Z9R8VzyzQrxj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 29, 2023 at 12:14:00PM -0600, Rob Herring wrote:
> On Thu, Jun 29, 2023 at 11:59=E2=80=AFAM Mark Brown <broonie@kernel.org> =
wrote:

> > Right, I'm suggesting applying the core part without waiting for every
> > single leaf driver to be lined up rather than the other way around -
> > that way the core part is stable and the leaf drivers only have issues
> > with changes in their subsystems that they'll have anyway even with
> > waiting.  Leaf drivers can be added on top as they're ready and if
> > something misses a release then it can go through the subsystem, and if
> > people do end up wandering off then you've still got whatever did get
> > merged in case someone else wants to pick things up.

> I misunderstood. I thought you wanted to apply things to get them out
> of your queue.

Well, I *do* but that's got issues especially when things get stuck so
I'm not going to.

>                That doesn't work when the leaf drivers depend on the
> core, so what do we do there? A branch or Lee takes everything? That's
> almost always the case with the bindings as the core binding
> references the child node bindings. My preference there would be that
> Lee picks up all the bindings with the core driver.

My suggestion is that once the core is ready to apply that and also
start applying everything else to Lee's tree as it's ready.  A branch
also works and might come in handy anyway in the case where there's some
subsystem wide updates in some other subsystem (since it avoids having
to pull the whole MFD tree in or anything like that) but it's not
essential to the idea.

--jmO1Z9R8VzyzQrxj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSdy9IACgkQJNaLcl1U
h9B2Gwf/YDlTRsJKKYuDo0kM8Y/qfJeBvUr4RSLWI3OYg3Zu7E25REVWqB7zvi9B
iajIt5dWkRkcfApDCgFtr0a37i/ycFue6vnS2g9ZAyk5jdpsdWiRr0nAPhScTdCL
GEkuDHLPwMXok5aHofSuSnEPa9iDirRplzDWyFB8YoHrqnyXS7P4J9NuOj46UiGt
Dpm8Ap1vRdmCPWC5Hqkcw7FPsZ/Vbusu+jseWWR2/4neYF35VeP6AxVkr/U9cPpw
u93M3KKDQLy/vZPTLVCWfGg9wT9xKZ12k62gPAeUvvGnDdbemisgPoRA7mbpU4tb
+ICCQZbk869VIKKcsM3R26qVtGzC0g==
=xN46
-----END PGP SIGNATURE-----

--jmO1Z9R8VzyzQrxj--

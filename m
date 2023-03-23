Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AADFF6C66D4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 12:38:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbjCWLiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 07:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjCWLiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 07:38:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B4412B9D8;
        Thu, 23 Mar 2023 04:38:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C71C362606;
        Thu, 23 Mar 2023 11:38:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAE66C4339C;
        Thu, 23 Mar 2023 11:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679571518;
        bh=F+fuZgEG2+3pg4JMJViOzTfJymZjqTVxKp+YQTYEjPg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rZ1vsGM/uhS/KS4c5iFJXuu1zo2wqLgBBLScOmRAdh58WEw5+c+xsOPLB4m2gmXal
         BirrIeFQN2LOtz8XqB/AqkXHe2EmpkmWK3hGEIODV+Amfjie+fqe40nr3NXf3uhbbQ
         8ui9cDolyQVhhDalr8MrWlstaEOewESjQG52fV97ZOmtg7LrFOIC6WOpCTsFH+OpOd
         edXh3daVpt0ck5AWKrzec5Vv8N44HmuaKpY2Ax+f1cSJpQCF6SuH1ER6Snj1mfxjzL
         mjupBIID94DnqGvwSAdi9CRo4dmwyRdfjzcQtf3WrzstNhyIkIVqcCnGGTYRGpfY0r
         +ln0zEWMzYXbQ==
Date:   Thu, 23 Mar 2023 11:38:29 +0000
From:   Mark Brown <broonie@kernel.org>
To:     jerome Neanne <jneanne@baylibre.com>
Cc:     Esteban Blanc <eblanc@baylibre.com>, linus.walleij@linaro.org,
        lgirdwood@gmail.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-rtc@vger.kernel.org,
        jpanis@baylibre.com
Subject: Re: [PATCH INTERNAL v1 3/3] regulator: tps6594-regulator: Add driver
 for TI TPS6594 regulators
Message-ID: <e08686be-0b46-403b-b3cd-3462db92dd60@sirena.org.uk>
References: <20230224133129.887203-1-eblanc@baylibre.com>
 <20230224133129.887203-4-eblanc@baylibre.com>
 <Y/i+wVSy+eQxDFJ3@sirena.org.uk>
 <bd4aa2ad-4535-94ca-7630-846546ae3d82@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sqyr3pdl018Qcdzn"
Content-Disposition: inline
In-Reply-To: <bd4aa2ad-4535-94ca-7630-846546ae3d82@baylibre.com>
X-Cookie: A lie in time saves nine.
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sqyr3pdl018Qcdzn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 23, 2023 at 10:12:21AM +0100, jerome Neanne wrote:

> > This would be simpler and you wouldn't need this lookup function if the
> > regulator descriptions included their IRQ names, then you could just
> > request the interrupts while registering the regulators.

> I changed the code to follow your recommendations then now in case of a
> multiphase buck, only one set of interrupt is requested.

> buck2, buck3, buck4 are not associated to a regulator device because buck1
> registers control all the multiphase bucks (only one logic regulator).
> Consequently the mapping for the associated interrupts does not occur.
> I'm not sure it's the right option.
> Do you suggest to keep it like that for multiphase?
> Is it better to request all the interrupts anyway and map it to the same
> rdev?

Do the other interrupts do anything useful for this configuration?  With
a lot of hardware the whole control interface gets merged into one which
includes the interrupts.

> > > +		error = devm_request_threaded_irq(tps->dev, irq, NULL,
> > > +						  tps6594_regulator_irq_handler,
> > > +						  IRQF_ONESHOT,
> > > +						  irq_type->irq_name,
> > > +						  &irq_data[i]);
> > > +		if (error) {
> > > +			dev_err(tps->dev, "failed to request %s IRQ %d: %d\n",
> > > +				irq_type->irq_name, irq, error);
> > > +			return error;
> > > +		}

> > This leaks all previously requested interrupts.

> I'm not sure to understand this sentence correctly. You mean all the
> interrupts already requested are still allocated after the error occurs?

Yes, I'd either not registered the devm or thought there was some other
interrupt wasn't devm.

--sqyr3pdl018Qcdzn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQcOjQACgkQJNaLcl1U
h9Auuwf+PN5kS1OlVilZrrkY1SzeCUq5W+chBmTUcyD85lp5xFNkACPMHE1lYwjE
uVj1L15Dqzt9wbKb5i5/c1p2aiumc4Uz6EYkgn5JIQ5ozBBUI9JYzhyWdPOWKw4/
Vr3NvPPkXLy/na7nRyuGJKmexIo/189mXkIRya3jDLIV7iI0arIc4wdXRJDe3YyO
DbFIaBVG3nudg6GGf1zKJ9rrkB/HMd4WFfbDURoQm4yicpTx2sP7SQQ4zk1KC4QT
hcRVB60RoXOYaESfSvPavmEwMXcrNgQrGCiePgvOUHI1VTMtqDN/3DfM+HD5YgNF
pN2QCR1QG69NJC6jSt3EpqYcayQsJw==
=T/Ls
-----END PGP SIGNATURE-----

--sqyr3pdl018Qcdzn--

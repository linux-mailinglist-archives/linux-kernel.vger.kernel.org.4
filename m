Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F40A6741955
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 22:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbjF1ULo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 16:11:44 -0400
Received: from dfw.source.kernel.org ([139.178.84.217]:54696 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232160AbjF1ULN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 16:11:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D08F261466;
        Wed, 28 Jun 2023 20:11:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05DF5C433C0;
        Wed, 28 Jun 2023 20:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687983072;
        bh=LLcceKwXay+1+LZDqQSJ8DdnOTd9XJoa6qAnUlgbGhQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ny+Dig9eSI8aD48PEXYHzX0z4qqIyDFR4n9v6cCNGMCJIuUkM3THoCcDTZXFEo0iC
         4pZSWDZDTu+NSJjYsR74RLvpclufEOOnYAMEzqs8y+O+w6t2DS/wwm7iXfJ50U74Py
         tlWQZbEZEOsEHxp0xbcG4lpIzaiwo6CzLehq3g8WFubcVqyVMQqTM6cneR/1N/aOXf
         DCfi7lw7VUlaKsMWs0zu3q9pfYNjCOCKH57v1bD+1bJqxYB8nkTPWAE3XF+YsheRNV
         3nQjPTCxd/bNW4DvJNE4Dr7AFDTrxd2F/qF+4raCfkes3j7wvNuKhcOJb7MCCoE/Y5
         J6DsMfu9kAncg==
Date:   Wed, 28 Jun 2023 21:11:05 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        krzysztof.kozlowski+dt@linaro.org, andersson@kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, johan+linaro@kernel.org,
        perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
        ckeepax@opensource.cirrus.com, kuninori.morimoto.gx@renesas.com,
        linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH 2/3] ASoC: qcom: q6apm: add support for reading firmware
 name from DT
Message-ID: <12c19702-9a0a-45b9-9dc0-6b62879fae81@sirena.org.uk>
References: <20230628102621.15016-1-srinivas.kandagatla@linaro.org>
 <20230628102621.15016-3-srinivas.kandagatla@linaro.org>
 <f71c8d2b-d5f4-42bb-932f-5b9ec6117ffc@sirena.org.uk>
 <73dce263-bee6-554f-9eb6-af4aa7badab1@linaro.org>
 <c377aefe-2678-4ba7-96b3-2186e8f3f1b4@sirena.org.uk>
 <fabef33c-a8c7-af61-80b4-91e55081c977@linaro.org>
 <c5bbdaa9-43fb-4ec3-af7d-b1629d2d88f7@sirena.org.uk>
 <CAA8EJprRH6aFj17A-sJzzHJXG7vNWu-yznSh7oA3WBXRv19wvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YMXJcNcxLhYXGPw7"
Content-Disposition: inline
In-Reply-To: <CAA8EJprRH6aFj17A-sJzzHJXG7vNWu-yznSh7oA3WBXRv19wvw@mail.gmail.com>
X-Cookie: HELLO, everybody, I'm a HUMAN!!
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YMXJcNcxLhYXGPw7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 28, 2023 at 11:00:54PM +0300, Dmitry Baryshkov wrote:
> On Wed, 28 Jun 2023 at 22:40, Mark Brown <broonie@kernel.org> wrote:
> > On Wed, Jun 28, 2023 at 10:33:16PM +0300, Dmitry Baryshkov wrote:

> > > This quickly becomes overcomplicated. Some platforms use different firmware
> > > naming structure. Some firmware goes into a generic location and other files
> > > go into device-specific location. So having a generic helper doesn't really
> > > help.

> > That sounds like a job for symlinks surely?

> Excuse me, but I don't understand the goal for such symlinks. In my
> opinion (and more importantly, in the opinion of qcom maintainers),
> firmware-name does the necessary job. It provides enough flexibility
> and doesn't require any additional dances around.

The goal is to avoid adding a Linux specific ABI if we don't need one,
and to allow later adjustment of what's selected on the userspace side
more easily (eg, if a more specific firwmare is found).

--YMXJcNcxLhYXGPw7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSck9gACgkQJNaLcl1U
h9BlIAf/U3zhxoGXi5DoWCg8Bs+vMFignIh07oSJjhgCaLNRBDO8u+xB0O2y3Ttc
huuRgDvcmjdZu1j258LPOc2dOwsYlGpIGNZuO2MxbeRxWLvJ+jYolrQr693R0H7Z
H7tR1GmW2+kU10RHflKOdoByXYSFg3s8Y37K1gUAKYDFCtDdk72sSeRdKWAyxlb1
cieBspLTI7ezND4O8mBpNZTkPrw6TFGDtETlk6ek5ySbUD2beWWTbBWbb604LJrI
IGStw1SfiHcu6eY0zm7BFyiWJgowKLxzq4Aesy/ok/Ng8ztRXk1dYttxFifSY+x0
GSDE23I/jS9mukoIMyL1z3/nA0ty4Q==
=jB6O
-----END PGP SIGNATURE-----

--YMXJcNcxLhYXGPw7--

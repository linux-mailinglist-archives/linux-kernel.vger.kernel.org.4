Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB84272E9DF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 19:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235179AbjFMRaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 13:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240364AbjFMRaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 13:30:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE4701BDC
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 10:29:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1509463334
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 17:29:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 398A9C433D9;
        Tue, 13 Jun 2023 17:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686677364;
        bh=iUzj7k10YTg83S+wBJGVDKpPVzNghGpvuz+AjNuWW7Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hlfE+8v8EkiRGkP+igy4lwShxYw3Vp0o5/DRLgkuVIiZMRvAZuUfsqg2yY5hr5P25
         j02w3EU/54Kv7ndjtLg8NTG+m1c/ZDQojifnhyZj1v2/r+MOeoHOBUqmBl43b7kOLF
         QuajYiRpgF64HW48cVIgNGOFOc/fGH3ZFy0ZibXDscPKUkRxtEHnptPZgPTmwNAlR2
         AS6C8pOItxNBf0G47WsO/8H27ill+Bge5YVi1qJu0avbrWuZSu5tUk9qqEzAhe58/D
         eCyXzhmZdTslsl8jxiTZ5IOgAiBI0fhMOotVDeG+S1Zlpz00fhDpFupsNWVI5NEG4m
         F2xWrotYhMSyA==
Date:   Tue, 13 Jun 2023 18:29:19 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda: Use maple tree register cache
Message-ID: <34b7d114-af69-459e-8a22-2a93a1e43e94@sirena.org.uk>
References: <20230609-alsa-hda-maple-v1-1-a2b725c8b8f5@kernel.org>
 <87v8fua1qm.wl-tiwai@suse.de>
 <877cs7g6f1.wl-tiwai@suse.de>
 <e48bbd3b-544d-43d5-82a1-8fbbcb8cd1a4@sirena.org.uk>
 <87v8frcueb.wl-tiwai@suse.de>
 <60f70667-16b0-4071-aa0f-a83e43bbf2a0@sirena.org.uk>
 <87a5x3cp9r.wl-tiwai@suse.de>
 <18bcfcba-a6ce-4595-bd2b-4d4ba761fd58@sirena.org.uk>
 <874jnbcmy6.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="U5ZQrDXad9z9/cVp"
Content-Disposition: inline
In-Reply-To: <874jnbcmy6.wl-tiwai@suse.de>
X-Cookie: Not a flying toy.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--U5ZQrDXad9z9/cVp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 13, 2023 at 07:05:21PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > > Oh, I'm afraid that we're seeing different things.  The code there is
> > > rather to *set* some initial value for each amp register (but only
> > > once), and it's not about optimization for writing a same value
> > > again.

> > > That is, the function helps to set an initial (mute) value on each amp
> > > when the driver parses the topology and finds an amp.  But if the
> > > driver already has parsed this amp beforehand by other paths, it skips
> > > the initialization, as the other path may have already unmuted the
> > > amp.

> > So it is possible that we might set two distinct values during setup
> > then and we're doing this intentionally?  It's not obvious that this
> > might happen.  A comment wouldn't hurt, and a big part of this is
> > confusing is that in the non-regmap case all we're doing is suppressing
> > duplicate writes, in that path it's just checking for changes in the
> > register value.

> > None of this is what the non-regmap path does, it just suppresses noop
> > writes to the hardware.

> Actually, many of HD-audio codec driver code heavily relies on the
> regmap, more or less mandatory.  The snd_hda_codec_amp_init() is one
> of such.  You may write a codec driver without the regmap, but some
> helpers won't work as expected.

Sounds like it might be so thinly used it's becoming mandatory to have a
regmap in order to avoid gotchas like there might be with things getting
muted?

--U5ZQrDXad9z9/cVp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSIp28ACgkQJNaLcl1U
h9D6iAf/YuE/ekMh7Ju3OxD7fiNwknQJlxztDugOKoOOz6W1IKuXHZQ6VmfOKEvv
QY/hF7MXheC9rR3Ao2lkidhuDGxEBGWw8jizSEjg9OdMI3ciXJiRtH80XVVDnbGr
r1TPDuleLgg8GcmVPoJfmZlOqdAuHxKxFXXIwaInYqWiaegh1k+4NG+R9AdqvjtD
QE8LWM3ybcftlP8KN00cjVhE5JznwCeNmNkljRta+eU4BaV1NxhnbnH+Tox0Amss
jPEmR5iimfW5AyagShLSzvEYxEnFVcxZxTz+s9d9T8z10CbuhOKsXAiz0WGQpAc+
w6gga3FMjiQWOoiJN9r8laLc8yusjA==
=1mK9
-----END PGP SIGNATURE-----

--U5ZQrDXad9z9/cVp--

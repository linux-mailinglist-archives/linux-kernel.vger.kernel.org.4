Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71C9766AD0C
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 18:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbjANRZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 12:25:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjANRZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 12:25:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A03983CD;
        Sat, 14 Jan 2023 09:25:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EF91CB808D2;
        Sat, 14 Jan 2023 17:25:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9958C433D2;
        Sat, 14 Jan 2023 17:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673717142;
        bh=51ViAOYwT+L18PsoAipKMhxe8CCSN6yffy7zR6YFLdI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z94GKYZZWFNbKNROFJv54fKg5nMm4P0X2aQga1SmffqBJEBxJTDrM2s2BlXcuquWh
         N5Zc40MvepK5NQ15bYUb3YIMn+TyjTj2sOg/Tg45+1ZR4NjVsWzRpHNOu27zIg22n7
         8MKhUOjwZMxnru7P8PE3buFtMY2lQVxYx0WI+jslfjxCx342/icq5RqGuvbJw4vhe4
         wVy6hywOAyo8gnIo6YJ61OwId/WWlMPlYCvgeVkiFmMBPZg7fdw9Nq+Dgp8fNeJWef
         p1dKQS1Hz2obK1Alf8POl6dwk6q7N8aBLkY2RI+UWUBWQLuYytVfzN/vUMK+WQbP6s
         ESVfigIGzqAFA==
Date:   Sat, 14 Jan 2023 17:25:48 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jarrah Gosbell <kernel@undef.tools>
Cc:     Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        Ondrej Jirman <megi@xff.cz>
Subject: Re: [PATCH] ASoC: codec: rt5640: Resolve failure to set DMIC clock
 after playback
Message-ID: <Y8LlnIbvnLGERCNo@sirena.org.uk>
References: <20230114003053.401274-1-kernel@undef.tools>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1RYbj7oVxAjXTigi"
Content-Disposition: inline
In-Reply-To: <20230114003053.401274-1-kernel@undef.tools>
X-Cookie: TANSTAAFL
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1RYbj7oVxAjXTigi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jan 14, 2023 at 12:30:54AM +0000, Jarrah Gosbell wrote:

> rt5640_set_dai_sysclk is called with freq == 0 when playback stops. This
> causes DMIC setup code to fail. I2S interface doesn't need to be active
> for codec to work, so don't clear rt5640->sysclk after
> rt5640_set_dai_sysclk is called with freq == 0.

The goal with set_sysclk() is to record the current clock
frequency, if the clock is stopped it should be set to zero.  If
a machine driver is setting the input clock to zero when it's
still being provided then it should be fixed.  If the device
doesn't need a clock for DMIC (which seems dubious) then whatever
is checking for a clock should be fixed.

--1RYbj7oVxAjXTigi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPC5ZsACgkQJNaLcl1U
h9AQHgf/XaEEjF+BLM6Pnh3lYFsdSIlU+KtG76/OC9GzqxX1yVhlp5T1weE8tfSM
nyVWqN20RA2TvVL9npXjB7xlRcsCONSUHg4h9SCDk08p5HT1bL9NtdgtqgMxwDPe
3Q70V5aD8vrF7QtdNLQe7wX/ub/yY7E6F3Nu3mlvdyzFjxekCnp5BcdCNMxQYlP2
cJdDWsO2vdc1tZrN4oFHWrtxoGEi5frIJLPkttaflVt4JV7g/07KpAP3qJ5KCQyY
xItHWBAkhrbaLarnjJMfo9oKlu1U69QR3OFClWpmDYhzReAmtqby9phny8VWOpxT
m1YFxkULKef8d8F4IZDrS72uQ57q9g==
=tHmS
-----END PGP SIGNATURE-----

--1RYbj7oVxAjXTigi--

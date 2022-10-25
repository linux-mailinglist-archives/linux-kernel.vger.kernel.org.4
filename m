Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E04060CA86
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 13:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbiJYLDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 07:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231752AbiJYLDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 07:03:34 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A5017F670;
        Tue, 25 Oct 2022 04:03:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8435CCE1C6F;
        Tue, 25 Oct 2022 11:03:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8B6AC433D6;
        Tue, 25 Oct 2022 11:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666695811;
        bh=fdcC4mR4dB/QFx3WrYK6jDAfOS5Cp8jhgwy0xEun364=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nKazl75omI35NaM4AI2u4k7W5QiR9pAJRt1uiREc6D9JOG0NtBkXFx60eYJJ3s3vx
         z8Fi1DuCZYyslE9JG9lszhv1LRjqS88Wv5q8jdxMol+kMjqm9DBQzbstW/JDWonxHu
         ILgo+cQHum2iXzIJGrjlVB2Z5z7d9N7qGhN7QE/d8Hdw2+vpPgzeZtHJq8fFau9GXz
         vMTpeyGLs7FgaKTv5+O1tJI5CGYXlCQaT6vhfeSFdB2+QQyx8o/TH3HvX9rFDXxR1U
         WCGDJP5c2y3Qt9P4q8qZerE+VNeu3NFJkfyKs04C5lOBVLDNl7fieU4Jk1EsupmK/G
         tguviyOcG63DQ==
Date:   Tue, 25 Oct 2022 12:03:25 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        kuninori.morimoto.gx@renesas.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] ASoC: simple-card: Support custom DAI system
 clock IDs
Message-ID: <Y1fCfej+/WH8TI39@sirena.org.uk>
References: <20221022162742.21671-1-aidanmacdonald.0x0@gmail.com>
 <Y1Z74/vKHbnaCLrX@sirena.org.uk>
 <XaoRSEMyUlabAR8wEJITmm2lGCjwfPZg@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iUFfooZ1kpfKCAGd"
Content-Disposition: inline
In-Reply-To: <XaoRSEMyUlabAR8wEJITmm2lGCjwfPZg@localhost>
X-Cookie: Your step will soil many countries.
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--iUFfooZ1kpfKCAGd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 25, 2022 at 12:17:25AM +0100, Aidan MacDonald wrote:
> Mark Brown <broonie@kernel.org> writes:

> > We already have clock bindings, if we need to configure clocks we should
> > be using those to configure there.

> The existing clock bindings are only useful for setting rates, and
> .set_sysclk() does more than that. See my reply to Krzysztof if you
> want an explanation, check nau8821 or tas2552 codecs for an example
> of the kind of thing I'm talking about.

I thought there was stuff for muxes, but in any case if you are adding a
new binding here you could just as well add one to the clock bindings.

> I picked those codecs at random, but they are fairly representative:
> often a codec will allow the system clock to be derived from another
> I2S clock (eg. BCLK), or provided directly, or maybe generated from an
> internal PLL. In cases like that you need to configure the codec with
> .set_sysclk() to select the right input. Many card drivers need to do
> this, it's just as important as .set_fmt() or .hw_params().

There is a strong case for saying that all the clocking in CODECs might
fit into the clock API, especially given the whole DT thing.

--iUFfooZ1kpfKCAGd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNXwnwACgkQJNaLcl1U
h9DI6Af8Cuqiya/+8/lme/cDu+8TN8e8NuItmTYE0zwwWFnj4moKAKOKjnbxCrq3
H8QZEZheZKL8XP4bCWHLQufnlxwzDApe7++u7t8EtX9EL8mV+cUmtSaOt+fkhBBf
4lv32bLyPe5OX2a/mr7+ZlFWU3Zx3Y4/ZoYNsQnuQvfNtaM057yFyLdkYi2kMhUn
MfUL8GEQS6Nu8+IqNxlRlgtE3wFr31DByy/pe74Ly+dbj85UMltrMgke/bMcsXPB
GtTGf22OV2ZuaOWiW0PgGg7wLoqFzgK1Fg04aF5EMHtoF3eiLzIPxOJH+4tZJEkf
Q8lfomo8CA2QoBibB2zP3gBeIFjDig==
=+vuf
-----END PGP SIGNATURE-----

--iUFfooZ1kpfKCAGd--

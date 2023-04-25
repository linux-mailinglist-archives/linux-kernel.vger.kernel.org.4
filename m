Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 746986EE5F0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 18:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234766AbjDYQmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 12:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234301AbjDYQmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 12:42:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94FCC10F7;
        Tue, 25 Apr 2023 09:42:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29A2362FEB;
        Tue, 25 Apr 2023 16:42:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A77F6C433D2;
        Tue, 25 Apr 2023 16:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682440931;
        bh=j2FI866f7bJRSZe9pyoQke2gaKz6vKX/jQrjan0VOyQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uc49KU1xoyNHghB/S2mkrucoVJ6dNXsKowUEI6tYnUyGgzir6xHVINqi4TMBPmFQZ
         fuYws4vt5muCYXw6Pz+aItDSuVUrJPvKcctIz8Lsy3X8ezdi5DV0EgMN8aDvrY7dNh
         G5H0ggiBFHl79QJp8f/4jSivUevYCykoQm7FEmOAYwaeRB37gcIegwUE7ahMg6CVve
         AUqwNFIQOrPU8rb7RChBJEN8389wVJ1kEBbRNHwDrGVLvgnrg3OSwBf8VtyYitI+G/
         v59RXq6l0l+/5FwUbLLUKm65vW57WqQfQXHtJG2uzHXMcLcOz6kSYKkYtIgxjsOuWU
         RbRVSRK4JageA==
Date:   Tue, 25 Apr 2023 17:42:03 +0100
From:   Mark Brown <broonie@kernel.org>
To:     =?utf-8?B?UGF3ZcWC?= Anikiel <pan@semihalf.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dinguyen@kernel.org,
        lars@metafoo.de, nuno.sa@analog.com, upstream@semihalf.com
Subject: Re: [PATCH 5/9] ASoC: ssm2602: Add workaround for playback with
 external MCLK
Message-ID: <417f9340-3270-4579-8cff-701200a62591@sirena.org.uk>
References: <20230414140203.707729-1-pan@semihalf.com>
 <20230414140203.707729-6-pan@semihalf.com>
 <cb35f3f2-4dc9-4d56-96bd-bcffb33b7aaf@sirena.org.uk>
 <CAF9_jYSMieE=GP3T-gsXe+SDjuWKGVy9LjhMHKB9_hW7czuZmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zKP4caOJkrTJMMD/"
Content-Disposition: inline
In-Reply-To: <CAF9_jYSMieE=GP3T-gsXe+SDjuWKGVy9LjhMHKB9_hW7czuZmg@mail.gmail.com>
X-Cookie: The meek don't want it.
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zKP4caOJkrTJMMD/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 25, 2023 at 06:02:20PM +0200, Pawe=C5=82 Anikiel wrote:
> On Fri, Apr 14, 2023 at 7:35=E2=80=AFPM Mark Brown <broonie@kernel.org> w=
rote:
> > On Fri, Apr 14, 2023 at 04:01:59PM +0200, Pawe=C5=82 Anikiel wrote:

> > > Apply a workaround for what seems to be a hardware quirk: when using
> > > an external MCLK signal, powering on Output and DAC for the first time
> > > produces output distortions unless they're powered together with whole
> > > chip power.

> > This doesn't seem coherent, these are multiple register writes so
> > clearly can't be done at the same moment as initial power on.  Clearly
> > there's some other constraint here.

> The "at the same time" part is done by writing multiple bits at once
> to SSM2602_PWR. But before that, SSM2602_ACTIVE has to be set, and
> then the chip is reset (SSM2602_RESET) to power everything down again.

So you need to power up the chip then do a register write sequence -
that's noticably different to what the description says.

> > > Here are some sequences run at the very start before a sw reset (and
> > > later using one of the NOT OK sequences from above):

> > >   ssmset 0x09 0x01 # core
> > >   ssmset 0x06 0x07 # chip, out, dac
> > >   OK

> > I can't tell what any of this is trying to say, especially given all the
> > magic numbers, and obviously no actual use of the driver should be
> > writing directly to the register map.

> These are shell commands run from userspace (with no ssm2602 driver
> present in the kernel). ssmset is a wrapper for the i2cset command:
> ssmset() {
>         i2cset -y 0 0x1a $(($1*2)) $2
> }
> I definitely should have made that more clear.

> Do you think these logs are worth adding? If so, I'll improve the
> explanation what these mean.

Probably?  Since I couldn't really follow what these were trying to tell
me it's a bit hard to say.  It looks like you worked this out yourself
rather than using an erratum so documenting where the workaround comes
=66rom seems useful.

--zKP4caOJkrTJMMD/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRIAtoACgkQJNaLcl1U
h9CamAgAhCuIv1AvQmJghDPpVDrb/Wzz212HfxzlxLRi8TgBJV4fLdTc6tUs0YqN
XYMXREF2B9AZR+d92U8auVTbEgPxS0wQxr453J7TICBcvyK6t+xlKSg5AhPmQ0lh
uCjjErq3YoxLp13vNrNE84SjLb9PL92+r7vS2dA8WJmwhcwQIk67QVqiF6ywKFUR
sH6EBeAZVZVpsn++ll8z/F/uNVS+cyi/I0IeMuG5kxCsSFcOciYwHUgqWcZYLZA2
bu6ez52dmOPPt5G17MfGSt3W4kZZBM9LT/Qzc+qJ8auQapwAgut/aAYnqPUewlSM
hBfGzlMAlsLti8PUCA7rmd9LbECjVw==
=hoS+
-----END PGP SIGNATURE-----

--zKP4caOJkrTJMMD/--

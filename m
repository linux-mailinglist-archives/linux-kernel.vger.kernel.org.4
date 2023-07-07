Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB6B74B108
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 14:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbjGGMha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 08:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjGGMh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 08:37:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A597219B2
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 05:37:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3470560DC0
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 12:37:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A995C433C9;
        Fri,  7 Jul 2023 12:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688733446;
        bh=mbKtKR0hDOfsYUOd60G4dTNAhNP0rnZEhKEo7PpA4V8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aNit0vigHHp6kJop50zKvZLhCninNHuUv51E8A2M/HAcu4U6AxigDvOK3VHzYcc27
         iulTRe9aU+L3G0VRNAGyHmrZEVmZNuqRHSGS6TJL+5P7acNhqJeKRFHousBnwkqJbD
         kE5yQ3wUtizjtjgSs/usjN0zuOqkf7UeJZ1djz8GOEmmVTFUO4RNmb9PVe2KYA453S
         OmEnnmGub1KgD+cOFKaV8QpALMKkYCq1HYfLxkGeGqz80F9rKs776WgOcXBJcHhgtv
         t+kenDKJFKxbNk5FdJFcWv/NExLVkXDdAjzp1/iS/TzMJop8msfCvX2qVB1owFzLeO
         H738e/iPLQzig==
Date:   Fri, 7 Jul 2023 13:37:21 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
        ckeepax@opensource.cirrus.com, kuninori.morimoto.gx@renesas.com,
        linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH] ASoC: codecs: wcd938x: fix dB range for HPHL and HPHR
Message-ID: <a006bb43-eb8f-42ff-a111-a120a3676b92@sirena.org.uk>
References: <20230705125723.40464-1-srinivas.kandagatla@linaro.org>
 <ZKfAUOOcGoBanHHu@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Oq9TbAv/U+d9U0n3"
Content-Disposition: inline
In-Reply-To: <ZKfAUOOcGoBanHHu@hovoldconsulting.com>
X-Cookie: Victory or defeat!
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Oq9TbAv/U+d9U0n3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 07, 2023 at 09:35:44AM +0200, Johan Hovold wrote:
> On Wed, Jul 05, 2023 at 01:57:23PM +0100, Srinivas Kandagatla wrote:

> > +static const DECLARE_TLV_DB_SCALE(line_gain, -3000, 150, -3000);

> This looks wrong, and indeed that forth argument appears to be a mute
> flag. I guess that one should have been 0 (false) here?

Yes, it is - it's for flagging if the lowest value is mute (many devices
integrate mute into a volume control).

> Headphone output also appears to be way too loud by default with this
> patch (alone) applied. Perhaps it's just the default mixer settings need
> to be updated to match?

Some of the discussion on IRC suggested that this might be the case.

--Oq9TbAv/U+d9U0n3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSoBwAACgkQJNaLcl1U
h9AnzQf+JyxvsKCayD52fTwBgQXf7YiLtnekXQaVpcyZ7dKwsUT7h0Pnp01wyq8N
PQdur2WE72RmuSn0Qi0GUxH633LL66Yxm9eMAnwoIvrM7iX0sK7EfuGz8tVSKCEE
1VRUYEDJE00q/CAvBIKZ79/D/cYNqjGYoOw0272ChF96RX/bdtUusc8p1KCuVmXT
VT+Pkdxr1iiApyNCtEvWLspdPGTWIZvQqCYvyz9HDWvtE8dNaiWvSzAlQUawDZoM
gT3lHCvA3Xhrr3rG39ZouHdnoSlHrXbuJJAJABeDVHYFRAqVpj1/Ld6rtbQzCQvB
pC1fLqmsZlCcGwLTUHtWhNMetyUNOQ==
=Qwsi
-----END PGP SIGNATURE-----

--Oq9TbAv/U+d9U0n3--

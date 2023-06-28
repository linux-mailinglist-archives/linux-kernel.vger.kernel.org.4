Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 066E17417D1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 20:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbjF1SLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 14:11:04 -0400
Received: from dfw.source.kernel.org ([139.178.84.217]:48202 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjF1SK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 14:10:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 029A161374;
        Wed, 28 Jun 2023 18:10:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30A2AC433C8;
        Wed, 28 Jun 2023 18:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687975856;
        bh=S8iFMTRFi4myYQxAkEhyB53zlJci8Gm8CA/jvNuBY2s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cPTY3bX1lk4GxRiSxlodx+ugOaPB3xpc1AmBC6B9gILVTJY8pSBfrCaCQ9rQ/Fv8y
         pmWZm8dao4+74szOO2hgfa6SsbzICms/cgnhZ8JNoK166T+Y3D0SRev4qLf7OwAd54
         0gnOc9wTbeW3k7JIfSTn6veo35Qq4EIvjub+CoAWLkstUS3XubjZjPClmKATV5psyB
         DhUapJ8FeaXOPdB7oMzpfa7FY/vqDW8k4s+lWdD3/k2ecx6FuQ2WbgN4LqfDK+yAF8
         Kh1wKQkKPg9Xyf/ZrdcT2SXk06B2HOxfY0qoj/8fOMtezSZUJnCR7NvTp8DnH2I8PS
         TO9hWPdCw5uvA==
Date:   Wed, 28 Jun 2023 19:10:50 +0100
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
Message-ID: <c377aefe-2678-4ba7-96b3-2186e8f3f1b4@sirena.org.uk>
References: <20230628102621.15016-1-srinivas.kandagatla@linaro.org>
 <20230628102621.15016-3-srinivas.kandagatla@linaro.org>
 <f71c8d2b-d5f4-42bb-932f-5b9ec6117ffc@sirena.org.uk>
 <73dce263-bee6-554f-9eb6-af4aa7badab1@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="odJ0u5EEv+hukUFR"
Content-Disposition: inline
In-Reply-To: <73dce263-bee6-554f-9eb6-af4aa7badab1@linaro.org>
X-Cookie: HELLO, everybody, I'm a HUMAN!!
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--odJ0u5EEv+hukUFR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 28, 2023 at 07:57:38PM +0300, Dmitry Baryshkov wrote:
> On 28/06/2023 14:53, Mark Brown wrote:

> > Why not try a series of firmware names/locations generated using the
> > identifying information for the card/system?  That way we don't have to
> > put a filename in the ABI which has fun scaling issues.

> This is what was done by Srini in the initial (currently committed) version.
> Unfortunately this easily results in the audio topology being separated from
> the rest of the platform-specific firmware. For example, for the mentioned
> X13s we already have a subdir under /lib/firmware/qcom and several
> firmware-name DT properties pointing to the files in that subdir:

> $ grep firmware-name
> arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> 		firmware-name = "qcom/sc8280xp/LENOVO/21BX/qcdxkmsuc8280.mbn";
> 	firmware-name = "qcom/sc8280xp/LENOVO/21BX/qcadsp8280.mbn";
> 	firmware-name = "qcom/sc8280xp/LENOVO/21BX/qccdsp8280.mbn";

> This is not unique to the X13s, other Qualcomm boards also use full paths.

If the goal here is to put all the firmwares for a given board in a
single place surely it would be better to factor this all out of the
individual drivers so that they ask some helper for a directory to use
for firmware?  Adding these device specific firmware node properties
doesn't seem to follow.

--odJ0u5EEv+hukUFR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmScd6kACgkQJNaLcl1U
h9CVewf/VRExNVrsgkLPa3cwHd22uiab7/9Pce7RpfyTmoA1zyYUbQvPZOsJgNZ+
0Q5a15Cw4YMXpdQIE37xVukcWttL5myFf8ycUSU45WAS5+YLuDa/RcuGFP5/IEZm
Lcq3wfX7zG0mxhE9Kj2E+k/rKieUPDbHGBfSikKrw8GL9jB8EZNG3tk7PXRLXpeJ
FAN+BRcSuZTjKInCR0ErUSgbMqNXHinbdxC8VCtwDZd7U6R0YT9xaKlVzMf+aK0K
+8ZptUCFFDR9THaCOXj3ujwF54WycL5Wo+9jIoPsVF92RTQcMwtzGmM48K6WY8tz
86G2gU01b89cvJ2vMPpdqZqR/UxLig==
=8mP1
-----END PGP SIGNATURE-----

--odJ0u5EEv+hukUFR--

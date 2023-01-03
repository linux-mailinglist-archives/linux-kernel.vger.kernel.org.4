Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEE4365C5C5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 19:09:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238674AbjACSJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 13:09:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233919AbjACSJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 13:09:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCCDBFCDA;
        Tue,  3 Jan 2023 10:09:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 597B76148D;
        Tue,  3 Jan 2023 18:09:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEB81C433D2;
        Tue,  3 Jan 2023 18:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672769368;
        bh=M+guTx9/MFdaM/g9JD7GIaQjt1whUIAEus/BUJ/qVW0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aK/PvWiJ0IC/szabV2T3ucI2bbelhC5VEhUGImiCMvL4xSd7gEP89zAHFKL56PGvK
         kgOiX+0uePgsZ8B3qX+GL2Fwpd2qvd2POGDAgoein1yukl4H5Lr4/2uIjTiJVfWKoK
         Dmyr3gLhNUxH6/xObRVsiw3/xIt7ddUn0NDaep9ozLf+PUu1fPd3n4+M8SPBSDkeX1
         KJa7JONexbyP+Q3JjghGzMcP3nTw1OLOWFgqFfU1C7/bvX/CFAf1j4uk+v8y93u5tB
         RmbmkFbnJRNPJGYuSAnnrKSwajaRUJcZTmZ5wLGW877H987VgYXREW9XQC3vujh4OP
         MaJC32NLQAc1w==
Date:   Tue, 3 Jan 2023 18:09:22 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, s.nawrocki@samsung.com,
        perex@perex.cz, tiwai@suse.com, pankaj.dubey@samsung.com,
        alim.akhtar@samsung.com, rcsekar@samsung.com,
        aswani.reddy@samsung.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH v2 2/5] ASoC: samsung: i2s: add support for FSD I2S
Message-ID: <Y7RvUlIuXQLUHEna@sirena.org.uk>
References: <20230103045613.100309-1-p.rajanbabu@samsung.com>
 <CGME20230103045655epcas5p1af06a83208190c471e8cd891ef4760f3@epcas5p1.samsung.com>
 <20230103045613.100309-3-p.rajanbabu@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gcxAJ25eGCCq6ZtM"
Content-Disposition: inline
In-Reply-To: <20230103045613.100309-3-p.rajanbabu@samsung.com>
X-Cookie: So many men
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gcxAJ25eGCCq6ZtM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 03, 2023 at 10:26:10AM +0530, Padmanabhan Rajanbabu wrote:

> +void fsd_i2s_fixup_early(struct snd_pcm_substream *substream,
> +		struct snd_soc_dai *dai)
> +{
> +	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
> +	struct i2s_dai *i2s = to_info(asoc_rtd_to_cpu(rtd, 0));
> +	struct i2s_dai *other = get_other_dai(i2s);
> +
> +	if (!is_opened(other)) {
> +		i2s_set_sysclk(dai, SAMSUNG_I2S_CDCLK, 192, SND_SOC_CLOCK_OUT);
> +		i2s_set_sysclk(dai, SAMSUNG_I2S_OPCLK, 0, MOD_OPCLK_PCLK);
> +	}
> +}

This looks like we're just hard coding to 192kHz?

--gcxAJ25eGCCq6ZtM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmO0b1EACgkQJNaLcl1U
h9Dtpwf/QBcLyOstOlusyhiszKaJsdbQq5jWmUNMELBJe4e8mvmusHElUqb3+OoE
jY2c7i7PWNP3Oi/MeieAOfGJeAB8W4MMyIqVor6A/rpdG4Rpi8oqrjDuO6T94nBJ
staf9152tPNf3feG+I1WMH7K4wHkuSuByqwfES2Gd/AC5CLW5mAsJ7LdCA9isCwB
60ZM6zs3NIOBTTOfTx6Hpr5WCKYLUOCVCBfQ5BfvncrS2Hygd+fgfFaEPCN5Q5vQ
2NuVyFfIToDz6VYW4dJ2C/NKS4UG8633qDg2KZHA/u94L7FzPZLDlHExBIbQARX0
nFuJFOwzX7ip//+J74ftTHpOUeFPqA==
=GVZ8
-----END PGP SIGNATURE-----

--gcxAJ25eGCCq6ZtM--

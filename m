Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A521745BBA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 13:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbjGCL4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 07:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjGCL4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 07:56:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3122992;
        Mon,  3 Jul 2023 04:56:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA23060F00;
        Mon,  3 Jul 2023 11:56:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BF4EC433C8;
        Mon,  3 Jul 2023 11:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688385381;
        bh=F2W2Yz29lXWIrZbzQBpiFGDh8BKRY5hjbFr5d6zCVrs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fewtM7a2Cx5ya9V8+XoM9lpG+ndtxyx//S9nZtj4bgpbJVkqzfImc+/Ce7yZSkH7t
         XYPVhzpx6urFRs4vv5FuaJxOQoTL+MvnIP4RtG44CUg0tqh2Vhn4KYXefdPF7xjVml
         PTIMtAqxJjyOYiisqKpE82dB4t82txblOj5KTPHSrngfTJYNdNYe6ffxnvIYfzd7BA
         DfD3qVdV4Yqc38x2utfEr1e59x4vhsvOuX2CZJnn0x9DlTuGjodYLy0fuf9EMAZVFi
         +aphcOzB7muCt9hh2A2QP1N8s+RK1mFMjAtPkjaRUcEv+3v8eHcRc1AYeh3o4UyZ+f
         8DKK6cwLZ7gJg==
Date:   Mon, 3 Jul 2023 12:56:15 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Johan Hovold <johan@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        johan+linaro@kernel.org, perex@perex.cz, tiwai@suse.com,
        lgirdwood@gmail.com, ckeepax@opensource.cirrus.com,
        kuninori.morimoto.gx@renesas.com, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        Stable@vger.kernel.org
Subject: Re: [PATCH] ASoC: qdsp6: q6apm: use dai link pcm id as pcm device
 number
Message-ID: <80183a58-78ba-46b0-8d2a-502b5b28ffe4@sirena.org.uk>
References: <20230628092404.13927-1-srinivas.kandagatla@linaro.org>
 <ZKJ9UrB8FRkLzLc-@hovoldconsulting.com>
 <ZKKA6K44mp_vjwtp@hovoldconsulting.com>
 <877crh76ge.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="U+PSF/XHDoszaQ30"
Content-Disposition: inline
In-Reply-To: <877crh76ge.wl-tiwai@suse.de>
X-Cookie: Please go away.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--U+PSF/XHDoszaQ30
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 03, 2023 at 10:19:29AM +0200, Takashi Iwai wrote:

> Isn't it rather an issue about the error code passing in qcom driver?
> How about the change like below?
>=20
>=20
> Takashi
>=20
> --- a/sound/soc/qcom/qdsp6/topology.c
> +++ b/sound/soc/qcom/qdsp6/topology.c
> @@ -1276,10 +1276,8 @@ int audioreach_tplg_init(struct snd_soc_component =
*component)
>  	}
> =20
>  	ret =3D snd_soc_tplg_component_load(component, &audioreach_tplg_ops, fw=
);
> -	if (ret < 0) {
> -		dev_err(dev, "tplg component load failed%d\n", ret);
> -		ret =3D -EINVAL;
> -	}
> +	if (ret < 0)
> +		dev_err_probe(dev, ret, "tplg component load failed %d\n", ret);

That looks like a sensible change in general anyway.

--U+PSF/XHDoszaQ30
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSit14ACgkQJNaLcl1U
h9CjtAf7B2p1IgCA8Co/ROslWsAioKfyEfS43xyuwkb1ytO0MD50aPa5lID+D70f
NRxVkywvv6oMZ26fvEFsebBNY/ZMyYdEv2j+hJ7HJjAvfv+JVDuTfFVekmaugM5N
sFM8Pxs5WL12SecXUA6/zWgNt0DTncRKRyEMS5frnfYm+uiB4yT/rCeARNvbfgk3
FKh5SAzmH/ELKlfy2Y0Sn2/J/1Yc5axqR0ZAgJZd0Yl/NHR3sa1taYpTlMGl5B3y
xkBoNudvJrMSWq8v8VVZtisHZiXe//tSssEaTkFY6/4eSu8P9bmLX/Ge87K8IV9G
3L8mkAUNnKXEPq/nH97/BUNtEe3Xrw==
=NvHF
-----END PGP SIGNATURE-----

--U+PSF/XHDoszaQ30--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 814F0686886
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 15:41:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232154AbjBAOlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 09:41:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232088AbjBAOk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 09:40:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1E01353B;
        Wed,  1 Feb 2023 06:40:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 42DD7B82181;
        Wed,  1 Feb 2023 14:40:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 833F4C4339B;
        Wed,  1 Feb 2023 14:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675262452;
        bh=KtS59Ia92JMXEp6HI/ACr8/i5UoMboazeSuRwj5Gwys=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FeowVP6fl+RQKPyGSsV51OlkN9+Q+MDQD+ZLvW8A+38wZaNYjMd7fc0h5jFnyHUGS
         0fljAB7xQbxdH84e1F9OmIkV0q/HpPU/M0y9wALI6beGsPzoMy+K4K8DKc1Cc+I4Rv
         MxZ0qZx+Ki4Q2S7ij7Gb7+oCpFuGOaPM3hc9Dn5lUQoqOy6l66socywszAfSn1REpD
         ewPCUWkHwkoELT3peEMeREWSS4bU6qsjmyexExo4nY3UrpqFkslKUjIbBKYgIi+4ha
         Su2MJa96XAsAnFUtCE943JTIy2RaRNKeqIbP43L+pd04CazY5DFdoVGLTATTQz6j36
         7uuhpL1OOtyow==
Date:   Wed, 1 Feb 2023 14:40:46 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, agross@kernel.org,
        andersson@kernel.org, lgirdwood@gmail.com, robh+dt@kernel.org,
        quic_plai@quicinc.com, bgoswami@quicinc.com,
        srinivas.kandagatla@linaro.org, quic_rohkumar@quicinc.com,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, swboyd@chromium.org,
        judyhsiao@chromium.org, devicetree@vger.kernel.org,
        konrad.dybcio@linaro.org
Subject: Re: [PATCH 02/14] ASoC: qcom: SC7280: audioreach: Add sc7280
 hardware param fixup callback
Message-ID: <Y9p57qn9+Pig9igE@sirena.org.uk>
References: <20230201134947.1638197-1-quic_mohs@quicinc.com>
 <20230201134947.1638197-3-quic_mohs@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="It/vzamgdtamVvYL"
Content-Disposition: inline
In-Reply-To: <20230201134947.1638197-3-quic_mohs@quicinc.com>
X-Cookie: Oh no, not again.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--It/vzamgdtamVvYL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 01, 2023 at 07:19:35PM +0530, Mohammad Rafi Shaik wrote:

> +#define DEFAULT_SAMPLE_RATE_48K	48000

Why are we bothering with a define here given that the define also
encodes the value and it's only used in once place?

>  	for_each_card_prelinks(card, i, link) {
>  		link->init = sc7280_init;
>  		link->ops = &sc7280_ops;
> +		if (link->no_pcm == 1)
> +			link->be_hw_params_fixup = sc7280_snd_be_hw_params_fixup;

We only set the fixup in the case where there's no PCM but we removed
the constraint in all cases - isn't the constraint needed otherwise?

--It/vzamgdtamVvYL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPaee0ACgkQJNaLcl1U
h9CiNgf/SDWbO2koQKvCH5xT7veA8uFDK7FX/PmIQ0kAWddbyKY2R+povhqysfIW
wg9TAzbz60wfmDhq+NTTeiHrB4TqbEhpOsRS9E5GyA5+D64d8JEc6iNju+SUhb8x
XjyRIKFntWKqSxgEDiw3ZSPj+unDqfJjsW9JSj06gMzYBM58mvXiDKIUm1PkXwdz
1CjZSKA4Yq1Oy8JXCJulti9SkgzaFI/ylXPK/+zqXR6BjZ/uWY0xicLF4W6nGfkQ
wRoXtjAMfcK9LKLAf2U0i0Lmb6tJdP7waq0qaGQIB/2kT4GDtPGcgCCqROqMjXFT
90ffHxNOpdMnd0EQSrSTUWQBwYTaCg==
=Ge6o
-----END PGP SIGNATURE-----

--It/vzamgdtamVvYL--

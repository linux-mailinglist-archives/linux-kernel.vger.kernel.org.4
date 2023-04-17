Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA646E4E4B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 18:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjDQQ1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 12:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjDQQ1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 12:27:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 368C6BF
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 09:27:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5F81619FF
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 16:27:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 617B4C433D2;
        Mon, 17 Apr 2023 16:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681748856;
        bh=WKjAMYMuM+y3ujS2vtZ+fs/f9P1qWkcq9QJHC90TkbQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lhHc/xfQdwO+Y8MYWUNsWDjcCly/MMlJ3PNQhYTm4HKEO1NHDT4DA88DyoxH1fic6
         i13misq6696wbT4xyfYvtEt9zljfUrEV9hnUzCBq0SyPVjWFIfN7NM88O6fn9cduVc
         NRN3/cBMMWP5pX17i1s8waDfm1psZ9V1swMX95kMIP3yNDiW1PF/EEgSrEodz17gOm
         JYlGcr/BiR7EVKcDMTpFf+MopbGhZpilrNoZPMjPw0vLzoSKMwy2Xl9r2T5XyRjIfe
         vK7hDXvTCovNvrEYJwRlBxnkjhigHT3arTbRYtzkTNhLgPZbI2r+gkY7agyqSv2A4T
         PeZJj8ScB7rzQ==
Date:   Mon, 17 Apr 2023 17:27:30 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] ASoC: codecs: wcd934x: Simplify with dev_err_probe
Message-ID: <80be967f-b831-4a73-8474-09bb96bd2c32@sirena.org.uk>
References: <20230417141453.919158-1-krzysztof.kozlowski@linaro.org>
 <20230417141453.919158-2-krzysztof.kozlowski@linaro.org>
 <20aa9662-9cbb-4fbe-b6ed-3a6ba33e820a@sirena.org.uk>
 <c294d672-c2fa-7468-f02d-18d5230a1d95@linaro.org>
 <5d753a8a-b979-43f6-a403-8a51f69bac29@sirena.org.uk>
 <752c2dc1-65a9-a74a-d9ce-7db5ddbea5f8@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="H+Aw/4yb0pHe+F4i"
Content-Disposition: inline
In-Reply-To: <752c2dc1-65a9-a74a-d9ce-7db5ddbea5f8@linaro.org>
X-Cookie: Two heads are more numerous than one.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--H+Aw/4yb0pHe+F4i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 17, 2023 at 06:00:59PM +0200, Krzysztof Kozlowski wrote:
> On 17/04/2023 17:58, Mark Brown wrote:

> > You've replaced an unconditional dev_err() with dev_err_probe().

> Which is the core of this change... so what is here surprising? Yes,
> that's functional change and I never wrote that dev_err_probe is equal
> dev_err. It is similar but offers benefits and one difference - does not
> print DEFER. Which is in general exactly what we want.

This may well be what you intended to do but it's not what the commit
message says that the change is doing, unlike patch 1 this isn't an open
coded dev_err_probe() that's being replaced.

--H+Aw/4yb0pHe+F4i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQ9c3IACgkQJNaLcl1U
h9BvZwf/a5vH9V/AMxblNgbtBRuqa5NmfkaQzg/ZNhgXcbrHxMBUEKvFPINPvpRH
nmZqDushKc2myJjrkKtC8cu+kOSM7pTcqh5BWV2uXYCWNhWV10uqeXIs6DQTmgvK
ySLJ4dHyD/jFSy702tJSE3cE+iQlSY1rYM9QAIaaJET87vvPYZ4TJLksWu0cws0y
i2ok1dm8fq7kdyOegG7X/zzDPgFgmKe2Xf4FoLrGKkwVqryyJt5sjHHxV9nWEalz
FVMAiakPgGVTpJkdNH5M58kIO9a41dIxfGPIembfGJrxQFaNg37qEv4xQO0+JTPB
L+lyV7oJqAkqoEBXt9O6c5eTMbtVTQ==
=7ozv
-----END PGP SIGNATURE-----

--H+Aw/4yb0pHe+F4i--

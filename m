Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D398B6E9981
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 18:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbjDTQ2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 12:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjDTQ2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 12:28:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 229FFE5B;
        Thu, 20 Apr 2023 09:28:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B2639611F3;
        Thu, 20 Apr 2023 16:28:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1934C433D2;
        Thu, 20 Apr 2023 16:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682008116;
        bh=LmwKwa5x3j1fsAg5wet8TyPTz8ZTtZ8YsYPimeMNywM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l+iDwcCk+BWmI7O6X2A3m8ISKsoa4ajtFQVPix1cqfnvx2Dd0CHPhHQBGu5kDYV7e
         tFqTxRzV2+7lc5au5i27h77ZDLutyREV5it0cf0V0Nlm646fdIk22xOEeoOpsz8U/S
         jZBkYM6hFnYuG0ecqmzptnKSJMY5ZKCsKLRJJY3/o9M6zGQIQbblNx6tXDEV3CIvqu
         W8JqwiKECP8e02W3qWxtTpJ3MJrsibdshYceTwdhKSDWVtaGObAQ9X54MKHcugADFd
         e58awnadbfZsWdkB6jDdAbfLX2rPys45gnMo9cOG6TtXYjzcqQ0B6Fq9ir04V+rG/h
         txLNTyLUDcybA==
Date:   Thu, 20 Apr 2023 17:28:29 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Patrick Lai <quic_plai@quicinc.com>
Subject: Re: [PATCH 1/6] ASoC: wcd938x: switch to using gpiod API
Message-ID: <9942c3a9-51d1-4161-8871-f6ec696cb4db@sirena.org.uk>
References: <20230420101617.142225-1-krzysztof.kozlowski@linaro.org>
 <20230420101617.142225-2-krzysztof.kozlowski@linaro.org>
 <6b355201-a957-4fca-a513-d5fa0742fb40@sirena.org.uk>
 <fe6202ee-2552-8b5c-c2d5-f2f7042b901d@linaro.org>
 <d746ee5f-283d-44ce-b72c-18c8955d38b1@sirena.org.uk>
 <3eb0cbb4-f6d9-db8a-031e-92627e70f41e@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gITbTckyPcLwKRdn"
Content-Disposition: inline
In-Reply-To: <3eb0cbb4-f6d9-db8a-031e-92627e70f41e@linaro.org>
X-Cookie: Above all else -- sky.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gITbTckyPcLwKRdn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 20, 2023 at 04:16:59PM +0200, Krzysztof Kozlowski wrote:
> On 20/04/2023 15:00, Mark Brown wrote:

> > That's just upstream, what about any downstream users?

> Life of downstream. We all know the drill: merge your DTS or suffer. The

No, the DT is supposed to be an ABI.  The point in having a domain
specific language with a compiler is to allow device trees to be
distributed independently of the kernel.

> I could rework this patch to provide backwards compatible solution like
> I did for WSA:
> https://lore.kernel.org/all/20230102114152.297305-4-krzysztof.kozlowski@linaro.org/

There we go...

> > We could handle inversions through an explicit property if that were
> > needed, that would be a less problematic transition and clearer in the
> > consumer code.

> I am not sure if it is worth. The DTS is supposed to describe hardware,
> so even if reset pin flag was not effective, it is a mistake to describe
> it as ACTIVE_HIGH. Do we care about keeping broken code happy? If yes,
> then property is the way to go. If partially, then I can add
> backwards-compatible approach like I mentioned above.

It's not just this individual transition, it's the whole thing with
encoding the polarity of the signal at all - it's a layer of abstraction
that feels like it introduces at least as many problems as it solves,
and requiring configuration on every single system integration doesn't
feel like the right choice in general.

--gITbTckyPcLwKRdn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRBaCwACgkQJNaLcl1U
h9An4wgAg4BjTPfGmE0oLuvE3Vnm9Cp90JDIgemZSx7SRbTmreZz2bWtJKZLiTwE
slZczeTfUoyJQQWSYiLMo8yUusyLKDIwwBiqFZpfIRkqsraunsNvZ6oOza8xYMLx
Iw1wnmuc8zZIhP/D50uNZf2Buu2kNJlRoOlnaJYjdtLQGLZ9m4IVvuLLir17db48
xeU7l0PDGu+8QCzauKejtsB3Wx88tzH5RGBDMaKLfSlQYjw0Wl7NomJLHwM0qHaL
rlJpbIX36PWlfaqFFkvk6vMvKywcomquZjdDTWUPYYZn2VD44xQuQZKmnphMKDvH
pTFKQZn95I+od+weN7Z49TVSFfD9MQ==
=d3uX
-----END PGP SIGNATURE-----

--gITbTckyPcLwKRdn--

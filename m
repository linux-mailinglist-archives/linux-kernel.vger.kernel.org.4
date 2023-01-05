Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 637BF65EDEF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 14:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233940AbjAEN4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 08:56:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234067AbjAENzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 08:55:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFCE059309;
        Thu,  5 Jan 2023 05:52:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 77882B81AE1;
        Thu,  5 Jan 2023 13:52:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2070FC433EF;
        Thu,  5 Jan 2023 13:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672926735;
        bh=xeo9GTpLRUSR7Hy3MwOAXEHDy3CW0l2eQpdfLTZillM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XG0u5LGAzYrH99gk4KnEd7x+GQ4YxF1Zam5bnKwq36Xlipr7mZSqTOaYP+1kwa2N+
         RGj66SQVhsOr2M1RHJhyEa1RaakHB0qe+7NSrAOAWWw7RIGQSD8lp96vFsuJpn4zqq
         sCsP7+LUsNYrl9AyPLXQbV7sqil0WVbIPvy3Jt9lrVjYHf5Z8Qe6xnF0bHxVpg0tCn
         2UL6ZlUwhfMIpNqnLMPCpmePbQK9IFJKI+TpfzLyk6rnVs3BMHHSw8wxE/J8YzDj1A
         LlRnunh55AaNPgILkIt+5w7PJLzK4zebMxPLvIt1XttDpeCBlgKLPHBB8ThQJ6wXvu
         UQBKzxHHUxFhg==
Date:   Thu, 5 Jan 2023 13:52:10 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 1/2] spi: spidev: fix a race condition when accessing
 spidev->spi
Message-ID: <Y7bWCm/hpK4pbI6W@sirena.org.uk>
References: <20230105124100.185542-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fEslcrgJo5E73pEp"
Content-Disposition: inline
In-Reply-To: <20230105124100.185542-1-brgl@bgdev.pl>
X-Cookie: Surprise due today.  Also the rent.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fEslcrgJo5E73pEp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 05, 2023 at 01:40:59PM +0100, Bartosz Golaszewski wrote:

> can replace the spinlock with a sleeping lock. Using an RW semaphore
> allows the syscalls to run concurrently unless protected otherwise. We

I'm not sure this is important or useful, there's not a lot that can
practically happen concurrently when we get to actually interacting with
the device and it's making the code a bit less clear.

--fEslcrgJo5E73pEp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmO21gkACgkQJNaLcl1U
h9BK4wf+KjgsiUwZTJ7jOiP+abzobEZSPasPIj07C5gzx3zDxgYB6oChldek99db
X3oZBuOrhwjWFOdc4VtXVO4jJjnEg2PPUy9LTxhkpmEA3sIgyq8wLilv0wmdRdAp
dVIAFmYmvSOf2BHb30NSPs6qk+aUDhrK+3EvB7DyipwB4twCbdGrt+R2tuYLpW1C
+zdBHFtGDVR6Wb/ncv8KhjIhuODcUcYYsmjjPBtW7otKASFWxmB9y+s8atpqe7dH
bSob0j++61Yb9JcC3Qu/Xt2dhT48cMgHB2G/LYiKk0jA1IJwnTvz/tZ/LdwIaeJf
xNIiMQy3esbJrYv20SgwNKzTJZaY0A==
=iO1x
-----END PGP SIGNATURE-----

--fEslcrgJo5E73pEp--

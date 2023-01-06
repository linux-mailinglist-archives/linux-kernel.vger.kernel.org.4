Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15C0B66041C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 17:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234403AbjAFQQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 11:16:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbjAFQQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 11:16:55 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 878A46145F;
        Fri,  6 Jan 2023 08:16:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D6ACACE1D15;
        Fri,  6 Jan 2023 16:16:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 258ACC433D2;
        Fri,  6 Jan 2023 16:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673021811;
        bh=h+H6+N9wy+UoVaz0TGMGSilx4hK7OWwV7JqLHVgZlKc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=da+ntefUfTFt/10fvWOeItW2+yM9N72q3JSY9qNuusN63uAFYX42u+MKL1glNIqgN
         GUJhnGBFwXg+mm/ZUjaG+9iXbv20ZX2aboSKPC2zbItXGhIisz68V+cNEem9imndZE
         eye+XtLqGaZ500C6U0fkGCPJ8k5fwDlS2JngvMcK9Sqf4Xl5uSPzL5eFIVeqy5YCIB
         Mbo7vJmmt5qznaCb0D4L8+q8y3+e/YGl94dVMh1yLq+U1jG9klGqYVuDesSBDWhmeq
         k9DKEy/8WZXjzjLJqaG5UlX0ob3+rvrB9ZQjY5OI0nv5IBDDiFAJLtSiP/kAHuLFeG
         GlqJXuyghyyUw==
Date:   Fri, 6 Jan 2023 16:16:46 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2 1/2] spi: spidev: fix a race condition when accessing
 spidev->spi
Message-ID: <Y7hJbjnbcxZnh/9M@sirena.org.uk>
References: <20230106100719.196243-1-brgl@bgdev.pl>
 <Y7gsiW6lAsz/krsV@sirena.org.uk>
 <CAMRc=MfsUxuv6d4GXgf7aTDr3Af89JX1Na_+jWcQQGn2hngWzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="21sB3NTgejk0cpQZ"
Content-Disposition: inline
In-Reply-To: <CAMRc=MfsUxuv6d4GXgf7aTDr3Af89JX1Na_+jWcQQGn2hngWzQ@mail.gmail.com>
X-Cookie: Do not fold, spindle or mutilate.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--21sB3NTgejk0cpQZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 06, 2023 at 03:27:57PM +0100, Bartosz Golaszewski wrote:

> IMO the complication of using an RW semaphore is insignificant and
> maybe a comment next to its declaration in struct spidev would
> suffice?

The complication is using a semaphore at all, it's a pretty unusual
locking construct and the whole up/down thing isn't clear to people
who aren't familiar with it.  Given that there's no clounting being
used rwlock would be a much more obvious choice if the microseconds
of extra concurrency is meaningful somehow.

--21sB3NTgejk0cpQZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmO4SW0ACgkQJNaLcl1U
h9A8ugf+OcvdHWF87ipdB+i++RntZ/IdJU4gd9d2dOs3kY+qgr8fAkNMHFg2WOoP
4QITWDNvpXDR5F/stnlDKpFpkeZ1PNy05+LeOc/YzvGmFQvkCeZtY9TTodTnmwnA
16w3sEVxLFHg9xDBxHsd/9TKZVSNv7kl2R+yfxRfsQRP9gAL1nb0p98C2Nh6EhZ4
Xm8e3Y+8AQPrzCy2cj4bT8SIAlN4YHAJJieRZCV/ZwxSuZWE2rjhaacXyu3exSV6
JISrYl2pz5w1w+5jl9RsXSb5WtiJ44S1ZHYvHXPDUgnMEC4pX8pc8qBBd8sd7XqF
pGYezXRAyWVu+cCXHedWr7YHb5YXFA==
=h69D
-----END PGP SIGNATURE-----

--21sB3NTgejk0cpQZ--

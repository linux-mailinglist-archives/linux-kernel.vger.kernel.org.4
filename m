Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6567660453
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 17:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234327AbjAFQed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 11:34:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234814AbjAFQe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 11:34:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46AB809B7;
        Fri,  6 Jan 2023 08:34:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3747661953;
        Fri,  6 Jan 2023 16:34:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F21DC433D2;
        Fri,  6 Jan 2023 16:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673022867;
        bh=RCmdOFw+uCvdhcIA/LW4xBRZ+gvfGhHCNqUL32jU2Xo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hpE3oIXhVR5dllqnADRzufEpz6EQ+GrhQjbZtDfItpCdvXkEzyWkSKKhMtO7G6+oZ
         nt4V/k3mugnvpwrvc0yLmczjihg1RZhJz3N7KlPfpZovJXGhQt4RHY2f6OoHJbHQRj
         ImC9l08sBsKUrTQdrC6QffTfgiz6MB2zmdyALueWTcDVpSuwQYPuG6fFF7yIE9+C1H
         TTEEuqjuTihapLf8DdcoQNZr3MF/fOORyke+VT1miCZ5FaOgTCoga1chaJ28ljjTBF
         WKa7Q/P30AGuBKS2Ct31ASrcAqG3SrDB5UzCaQXnlevR0Z48Nx3yB9zpUgVOlRBl5o
         bzv/y2ig0VAjQ==
Date:   Fri, 6 Jan 2023 16:34:23 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2 1/2] spi: spidev: fix a race condition when accessing
 spidev->spi
Message-ID: <Y7hNj+O0Y5NNNcna@sirena.org.uk>
References: <20230106100719.196243-1-brgl@bgdev.pl>
 <Y7gsiW6lAsz/krsV@sirena.org.uk>
 <CAMRc=MfsUxuv6d4GXgf7aTDr3Af89JX1Na_+jWcQQGn2hngWzQ@mail.gmail.com>
 <Y7hJbjnbcxZnh/9M@sirena.org.uk>
 <CAMRc=MejZsbL=Ef=hNV-QGcrcgCepKfnAU4z+CFXFf8Wn09M-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pH2PIaMokPOQ5Eaq"
Content-Disposition: inline
In-Reply-To: <CAMRc=MejZsbL=Ef=hNV-QGcrcgCepKfnAU4z+CFXFf8Wn09M-g@mail.gmail.com>
X-Cookie: Do not fold, spindle or mutilate.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pH2PIaMokPOQ5Eaq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 06, 2023 at 05:27:34PM +0100, Bartosz Golaszewski wrote:
> On Fri, Jan 6, 2023 at 5:16 PM Mark Brown <broonie@kernel.org> wrote:

> > The complication is using a semaphore at all, it's a pretty unusual
> > locking construct and the whole up/down thing isn't clear to people
> > who aren't familiar with it.  Given that there's no clounting being
> > used rwlock would be a much more obvious choice if the microseconds
> > of extra concurrency is meaningful somehow.

> I don't have any numbers, it's just that in this case the rwsem feels
> more correct. My opinion is not very strong so you can apply v2.

Like I say the semaphore in particular feels wrong when we don't need
the counting, we have an explicit reader/writer lock if that's what
you're trying to accomplish.

--pH2PIaMokPOQ5Eaq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmO4TY4ACgkQJNaLcl1U
h9A6KAf/QIVHDAnf2BFQybkviui2/MVLJ9ZIa8H0ZhYeY1uY1Hi48ye30FA9etWi
cU5fxbPNmL6s/Sh9sKM686WY+6qqaOJ2OBRwV4TJE5cq4wo7tMweaqJi27PAPz94
xtud1qnt2jQ+o3L6mPzYNjuS1EGriQPISuvX7QPmkHFfvaC1Axq1K45skRHk5MZ+
T3FEzofCwtQONKHTqgnsmzONGfSgV4KtHWQ+abGrbvoUj5wlFdmgjjyaJCnoPG92
4od4eV7HvYjES5p0nk1f4bAsbiMcpHSuUU5y0cIfrdV6FsqKQ2KZu7oBZYolcJLL
GwiFC7s0Vze8Qupt87+Msz5cZiKTdg==
=0M+x
-----END PGP SIGNATURE-----

--pH2PIaMokPOQ5Eaq--

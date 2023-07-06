Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 917FC749BDC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 14:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbjGFMeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 08:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231712AbjGFMds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 08:33:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D95C1BEA
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 05:33:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C9818618EB
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 12:33:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF2A6C433C8;
        Thu,  6 Jul 2023 12:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688646826;
        bh=j3Bj1sSsS6/rr623KKWCqgGRCT39zzClBMwB4l36CAs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AC6iTwZbjWGrAJMvOynJCL/srgn4a2AzvqKPHWv3m+iu3rtfiroBdfVpGciZKczav
         HZTqDgXTa5JjddDN0THlD3FcQ6bGSBYX40IEeVCMc9XTMiprF54YRj4yoUztq7jTuk
         wyzLaqA9fMZeyKnYG3IZ1FONVUiuDXldvsPjoaQ5kVCSUmzMSzMOZkYjH7uCnBEnqq
         ECxUOJZ5K+Y3ooRICbqk9Rg83IZ/DY5DvVNo0rD44FXax0O6tIkApcSAnJSKVJUFbh
         LuhKchKf7hoCg62keSeUxa/4wYrEQPJlS/bzQaAR5wQ9y1LhPwI8z2Uei0UVCvlLSw
         Mw7q1Sydr3YnA==
Date:   Thu, 6 Jul 2023 13:33:40 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Lee Jones <lee@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Benjamin Gray <bgray@linux.ibm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] regmap: Replace "default y if" by select
Message-ID: <a170939b-ee15-4241-ac07-bfa341a56bbe@sirena.org.uk>
References: <cover.1688643442.git.geert@linux-m68k.org>
 <525c37a568b10623ffb2d108850afd7e37f9350e.1688643442.git.geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8w2QbIDms0NhgMtB"
Content-Disposition: inline
In-Reply-To: <525c37a568b10623ffb2d108850afd7e37f9350e.1688643442.git.geert@linux-m68k.org>
X-Cookie: Don't read everything you believe.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8w2QbIDms0NhgMtB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 06, 2023 at 01:42:02PM +0200, Geert Uytterhoeven wrote:

> Merely setting the default to enabled is no guarantee that a Kconfig
> option is actually enabled.  While this works for an invisible option,
> the user can still disable it manually if the option is visible.
> Hence since the REGMAP option was made visible if KUNIT_ALL_TESTS is
> enabled, the user can now manually disable REGMAP, causing build
> failures if any of the REGMAP_* configuration options are enabled.
>=20
> Fix this by replacing "default y if ..." by individual "select REGMAP"
> statements for all users.

I already have a separate patch which will go after the merge window
that will move the KUnit visible option to a separate Kconfig since the
current bodge to work around your desire to not have KUnit enable
anything automatically had really substantial usability issues anyway.

I'm getting fed up with all the problems that these KUNIT_ALL_TESTS
issues TBH, the inital patch here seriously damaged the usability.

--8w2QbIDms0NhgMtB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSmtKAACgkQJNaLcl1U
h9BgDwf/bxvria0yTNlFgcVB47sqjg89/9bKKZ4Z60b9HloA1Ex3l68CaUxnphFt
1BUIy+pcsYDj1ph5LfEPQCHTemXXgdVbfbUrWOzuD65KY1Bbmg7MVxhdODDf27UI
RFGIRtKTgQQqDjJxbmbJ9j7nEp+zd+q5M7caDVioLGPk+kkll6SL+79blhqrAqUb
KSjlJOQnFIqe32/IIvviffVEIJU2RvVPNvup83qdeGUVRdvaSzsVOubOgGJUOY3p
60fQaYz1ejTBpOwNicfFsvGGRGzgK47V/i2Yh8IB8dJ1LaqU+L+l4t0Spmw6qq3N
Wlin1nMDR3ppHaJtZVCDELCSq2YPmQ==
=iv0q
-----END PGP SIGNATURE-----

--8w2QbIDms0NhgMtB--

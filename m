Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8A686C58D5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 22:35:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjCVVfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 17:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjCVVfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 17:35:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F80B12F35
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 14:35:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B2A20622E8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 21:35:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9F21C433EF;
        Wed, 22 Mar 2023 21:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679520951;
        bh=O5urGvWE65epCWTJLDmjCHr4A+CyLtsq+Kqk9qfHOL4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SnaWKepNaCqaM0TGWvWnmgG9ZOTs1u+Sgl9iE1yv6p16x9G2frQ2/P6nEhG0XWMRh
         ftOlbraFA/yRMLAqneu0snlMCiotob4hI6Mj29q7Qq3Z4+0t1axSmrOTafJibksJzW
         5CAw/4Jhdd6hZw8khDaiQIDpHukFoWgrTrfMmybEHIrvCZlgWldQoJSjAjpbEP2Rvw
         naM96uSXJuGSi050+lsZKAFNKcdT3x8N80/NPRS4CvhfxLCYHOl2S6o1eCWjvxmwDk
         su+uB2tUF2VFcbdUooT7C/XfsUWiNJ1oEf9kqsaeRFRvphbWGR7KZsUeSmX6bJPXjZ
         rkQ2k7jy9WYkA==
Date:   Wed, 22 Mar 2023 21:35:47 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Marian Postevca <posteuca@mutex.one>
Cc:     Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH 4/4] ASoC: amd: acp: Improve support for speaker power
 events
Message-ID: <ZBt0syAowVRYaCuL@sirena.org.uk>
References: <20230320203519.20137-1-posteuca@mutex.one>
 <20230320203519.20137-5-posteuca@mutex.one>
 <0989fc51-fee7-4558-ba2c-084cc4fb6833@sirena.org.uk>
 <87r0tgjy9v.fsf@mutex.one>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wNnmN3SGdiALnLaa"
Content-Disposition: inline
In-Reply-To: <87r0tgjy9v.fsf@mutex.one>
X-Cookie: Single tasking: Just Say No.
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wNnmN3SGdiALnLaa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 22, 2023 at 11:01:48PM +0200, Marian Postevca wrote:
> Mark Brown <broonie@kernel.org> writes:

> > The usual mechanism for doing this is with the standard kernel delay
> > functions.  Why not use them in the DAPM event?

> I just followed the logic from sof_es8336.c, the reason for the change
> there is given in commit log of 89cdb224f2abe37ec:

> commit 89cdb224f2abe37ec4ac21ba0d9ddeb5a6a9cf68
> Author: Zhu Ning <zhuning0077@gmail.com>
> Date:   Fri Oct 28 10:04:56 2022 +0800

>     ASoC: sof_es8336: reduce pop noise on speaker

>     The Speaker GPIO needs to be turned on slightly behind the codec turned on.
>     It also need to be turned off slightly before the codec turned down.
>     Current code uses delay in DAPM_EVENT to do it but the mdelay delays the
>     DAPM itself and thus has no effect. A delayed_work is added to turn on the
>     speaker.
>     The Speaker is turned off in .trigger since trigger is called slightly
>     before the DAPM events.

This just sounds like a complicated way of implementing a DAPM
POST event?  Or now I think about it possibly we just need to
tweak the current sorting such that speakers aren't run in
parallel with headphones and line outputs, that should cover any
issues with external speaker amplifiers.  AFAICT the issue here
is a speaker driver amplifying a pop in a line output from the
CODEC?

--wNnmN3SGdiALnLaa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQbdLIACgkQJNaLcl1U
h9AUnwf+OVcj15mqwDAb7rmH2vJ7jbUAEpSCQ1QLsxCiVu+GmGNG8AGELD60P7W4
rN7oAGSHPfKOFKBf9igvag/7DruYk6nhhB4yCI6DwQ/XYiJKqH8NT7MnPKf3r+WI
XcUS4il+ynF0zQx5OinVjmqhjOZN4aJxij62DdsZsaaR1nXeoG8miJwp4XN6BTzo
is7MtVHoU78ZfIe+JtY+U9aJZirsL5e2S8uzxYckSt5SZWNWThnklIEWW2Cq84Ll
gK1qM7UimxsAwSucT7/EfKIk31CxKkfJllhADldZNwIiwVg5LlYmjIc3Gx/BnkYS
BNVGgblEi2Ofos8t6iYuD7lI+6/b/w==
=OYG4
-----END PGP SIGNATURE-----

--wNnmN3SGdiALnLaa--

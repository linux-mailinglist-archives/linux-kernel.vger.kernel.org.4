Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 091AB62D983
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 12:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239506AbiKQLhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 06:37:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239495AbiKQLeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 06:34:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1674E22501
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 03:34:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A595861253
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 11:34:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90E73C433D7;
        Thu, 17 Nov 2022 11:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668684850;
        bh=yMu6+GoFnl1mrIFFhTT3h7tPE+tEdM553AlyVAInMtU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HdOniGdlwP8cyj9N71XQTfTLaJOTTLgOhFdmgU4B+ak6zjuXmZIs3qRCND30cYI5p
         LwUV6gPCiTQeVyEhetyAvPKo6HRrLedjPJdUZgIAj6VGVw1mLZPqTGIu1TIiXu/n15
         Pt2dhgSARtYkngniM6kN5WdFRICtscNIcNoA8Xg7qiYJ2aZxqiw/EpylvUU10nncSU
         1a9VXdp7zAIdtQpJoYcC6HOGQTUKYY0WihJ7mwYs4b5dYsP1OvoTiwEdu9QUQyxqQw
         QmEWDn1h+Rdam4Y0+fPyop0vK7uYuO4/S2C+pmoHRvKzC0ffcLyngND8Rl6X+E5HJT
         vJE2Kq4p/UaOg==
Date:   Thu, 17 Nov 2022 11:34:06 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH 01/11] ASoC: ak5386: switch to using gpiod API
Message-ID: <Y3YcLulaebidYYsg@sirena.org.uk>
References: <20221116053817.2929810-1-dmitry.torokhov@gmail.com>
 <Y3S9KzTE1/UQDmJl@sirena.org.uk>
 <Y3U1BJAPOJTLw/Zb@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QM8UBU9P046DRTWO"
Content-Disposition: inline
In-Reply-To: <Y3U1BJAPOJTLw/Zb@google.com>
X-Cookie: Ego sum ens omnipotens.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--QM8UBU9P046DRTWO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 16, 2022 at 11:07:48AM -0800, Dmitry Torokhov wrote:
> On Wed, Nov 16, 2022 at 10:36:27AM +0000, Mark Brown wrote:

> > How are we ensuring that people have described signals as active
> > low/high in existing DTs, and are we positive that the signal is
> > described as active low for all devices?  In particular if the
> > signal is described as a reset signal then it's active high even
> > if we want it low while the device is actually in use.

> I have been going through in-kernel DTSes and adjusting ones that are
> incorrect. For external ones I think we should take a pragmatic approach
> and say that if driver has last non-mechanical update in 2014 and there
> are no users submitted to mainline since then (as this one), then it is
> highly unlikely that devices currently using this component/codec will
> be updated to the 6.2+ kernel even if they are still in service. And if
> this does happen the breakage will be immediately obvious as we'll keep
> the codec in reset state.

> But if you really want to I can add quirk(s) to gpiolib forcing this
> line to be treated as active-low regardless of what specified in DTS.
> This kind of negates benefit of going to gpiod though.

That doesn't address the bit about checking that the device
describes the signal as active low in hardware - it's assuming
that the signal is described by the device as an active low
reset and not for example as a shutdown signal.

TBH I'm not thrilled about just randomly breaking ABI
compatibility for neatness reasons, it's really not helping
people take device tree ABI compatibility seriously.

--QM8UBU9P046DRTWO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmN2HC4ACgkQJNaLcl1U
h9Dxfgf/ftYFUMW/ILTdWcqMEKVkYIa3+9VBKpQL0Aq9xN022wMz+ICsRHsAonCe
fhG0ZfhhAvP4nkV+Ui6cxFdWM/vM0Or+OF1KnI8BsCoWkMpyDU7WahUXQ8HhjnUv
RkKKkXG3K0jcYeh1yLB4p1miF1tt060Z09558aUHtnFto6vNOtE1VE56aI8TJvzo
qAN33CB7jWe++RfqjI0hismVbCjTNxivk48+6qKzdjS4JsgoqGGqxMYqnJzBMbf5
rUAM8yj6zH74WkWELWsv9ZlxCQ9CAEOWEeP4eWLFgQ1arngjeymdAVy04frQB+Dy
Q1mfUHb1Sj+c6y7pgbHXtAOaX6CjWg==
=EGgz
-----END PGP SIGNATURE-----

--QM8UBU9P046DRTWO--

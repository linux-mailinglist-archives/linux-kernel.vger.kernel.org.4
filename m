Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E05562F5A2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 14:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241423AbiKRNMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 08:12:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233543AbiKRNMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 08:12:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788218C094
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 05:12:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CFE3D62505
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 13:12:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDAC4C433D7;
        Fri, 18 Nov 2022 13:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668777165;
        bh=ogCgxgQsXdIGmtzz2eakVarh+eKQrYvaH2DjUn25Z/A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p8SrqPPD5ygSUo0n6kIaAMeUqsb5O4REBxus5UdXX2qFFXC+cWW+z4VkRgLywPcqS
         qRzPq/xwDumQq9BY7DLVRk68jIuGXySSSZSskagVh4kOK9VTvO8nkNSeaSYZUHvCio
         Sxm6DtGf8fKNUUi5GtQ3jzZH2ZFbd2HPA5s58vB4VOI1WDltLgfYkLSDegNoa1X2lh
         J8z5XoUSg+hw+SOY9pisaDvJqkXtshjhdc9Jlo7c8sB3KC6u67nFmg+WzQ+D4wUJwf
         a4g9CPqcB1kS9BAqkW69imxYNVyVsOPNpvK4ChC7RCzvZCFGzPRNu/mocdBblyvsow
         VhkHmJBqfh43g==
Date:   Fri, 18 Nov 2022 13:12:41 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH 01/11] ASoC: ak5386: switch to using gpiod API
Message-ID: <Y3eEyf9fv0A5obNR@sirena.org.uk>
References: <20221116053817.2929810-1-dmitry.torokhov@gmail.com>
 <Y3S9KzTE1/UQDmJl@sirena.org.uk>
 <Y3U1BJAPOJTLw/Zb@google.com>
 <Y3YcLulaebidYYsg@sirena.org.uk>
 <Y3cm1eeDN+n3tbpG@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tU6ohxgfYVuZNc6t"
Content-Disposition: inline
In-Reply-To: <Y3cm1eeDN+n3tbpG@google.com>
X-Cookie: Ego sum ens omnipotens.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tU6ohxgfYVuZNc6t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 17, 2022 at 10:31:49PM -0800, Dmitry Torokhov wrote:
> On Thu, Nov 17, 2022 at 11:34:06AM +0000, Mark Brown wrote:

> > That doesn't address the bit about checking that the device
> > describes the signal as active low in hardware - it's assuming
> > that the signal is described by the device as an active low
> > reset and not for example as a shutdown signal.

> Huh? If we add a quirk to gpiolib to treat the signal as active low
> (i.e. preserve current driver behavior - I am talking about this
> particular peripheral here, not treating everything as active low of
> course).

My comments were more generic ones about the whole series since
all the patches seemed to be doing the same thing with flipping
the polarity - some of the GPIOs were labelled as things like
reset which is active high if it's not nRESET or something even
though we want to pull it low while using the device.

> > TBH I'm not thrilled about just randomly breaking ABI
> > compatibility for neatness reasons, it's really not helping
> > people take device tree ABI compatibility seriously.

> Yes, I freely admit I do not take device tree ABI compatibility
> seriously. IMO, with the exception of a few peripherals, it is a
> solution in search of a problem, and we declared stability of it too
> early, before we came up with reasonable rules for how resources should
> be described. I strongly believe that in vast majority of cases devices
> with out-of-tree DTs will not be updated to upstream kernels as this
> requires significant engineering effort and vendors usually not
> interested in doing that.

There are practical systems which ship DTs as part of the
firmware, and frankly things like this do contribute to the
issue.  The systems that just ship their DTs are obviously a lot
less visible, but that's the whole goal here.  It's most common
with more server type systems using EDK2 for the firmware, ACPI
isn't always a good fit for them.

--tU6ohxgfYVuZNc6t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmN3hMYACgkQJNaLcl1U
h9B8Rgf+OPKm9HTN6TrD16yqb+6BPDK6pL+Nm+OBSQBKxddvlQMwMF8i+VBXCC7b
ORB4iUroRnGPbx3XYekpEdnjBwfpdNjUCc3Wm24cIwJp99BmKuCHnSCk5shn1s35
EJquFVQbgMz+qHLlIcnbySulM/wIpuhI5+4klYbqGEfway5sPJeZUKSjah1RNmK0
lwYYQM+Ut4FwZcL7s48JAnVpYd1x589K8mKMUMFCPofys0QUhFV5g97/GNLNmu5s
31XlfEkNtzp2thB4OYuXrupJ2+SMa3AcPqROnCO0ktCdAOrn+XeRTSXQjS+ZJ9cZ
PLXvQhwEi6bg7Pq8JEOFHMdxK5NybA==
=dgNV
-----END PGP SIGNATURE-----

--tU6ohxgfYVuZNc6t--

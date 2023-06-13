Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE19972E77D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 17:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241384AbjFMPk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 11:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242675AbjFMPjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 11:39:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A36E1BD3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 08:39:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E21962D2F
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 15:39:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19011C43392;
        Tue, 13 Jun 2023 15:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686670750;
        bh=bqhbfxfuVVbH/p+/UQRRfRNgV8oXiTFi0OTEAjc9R/I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c/bw0zNfo6o1AHPdh4s1EYe30nvhRPcLooJ5+5dKlgi6UOF9qzBNL+/+iIiyuHmjL
         3la+m4er+B9Xs73vcuhGYZaZyz/e0VC2YCJWlTGJ/Izn+iXPNckxydHeXxJJvYgPSC
         CQMt5Ew4xMerOSeddTd0naww3NoJQu3lvTWb7E8u4xQ09w9xwtqsD0+7cG2Ki0Nwoc
         3J5SDOi8XBzEs8yI1yD/CLtwNrUPGr1vPDbH1FNSjb828wkBdp16cja31kQihV6iaD
         asrDmgi8VvPPVPTlfIU/D4QD+EStOqVcSkw2E3Cw44NC0aDkcwiRjMdN/54Qfb2GCD
         unbtQOz9jFrmA==
Date:   Tue, 13 Jun 2023 16:39:05 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Waqar Hameed <waqar.hameed@axis.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, kernel@axis.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] regmap: Add debugfs file for forcing field writes
Message-ID: <8da4b552-740f-489f-a2ae-1a6e87c41463@sirena.org.uk>
References: <pnd1qifa7sj.fsf@axis.com>
 <2023061322-garter-linseed-6dfe@gregkh>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0npxGfmuYZo3rjJ2"
Content-Disposition: inline
In-Reply-To: <2023061322-garter-linseed-6dfe@gregkh>
X-Cookie: Not a flying toy.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0npxGfmuYZo3rjJ2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 13, 2023 at 05:02:27PM +0200, Greg Kroah-Hartman wrote:
> On Tue, Jun 13, 2023 at 01:42:27PM +0200, Waqar Hameed wrote:

> > +#undef REGMAP_ALLOW_FORCE_WRITE_FIELD_DEBUGFS
> > +#ifdef REGMAP_ALLOW_FORCE_WRITE_FIELD_DEBUGFS
> > +	debugfs_create_bool("force_write_field", 0600, map->debugfs,
> > +			    &map->force_write_field);
> > +#endif

> Please no, that means this will never ever ever get used, and if it
> happens to break the build or runtime, no one will ever notice it.

> If you need this for your device/tree/distro, great, just keep it as an
> out-of-tree patch with the huge header "NEVER ENABLE THIS IN A REAL
> SYSTEM" or something like that.

We have an existing setting that parallels this which enables writes via
debugfs - there *is* demand for this sort of thing in development where
this is a viable configuration mechanism, having something in tree in a
way that requires an out of tree patch like you're suggesting to enable
it documents why the feature isn't something you can enable without code
changes whereas just not having anything means people send patches
adding the feature.

This one is very much safer than the general write thing, we probably
*could* have a Kconfig option but changing the guarantees underneath
drivers feels like it's going to explode if we just let it happen.

--0npxGfmuYZo3rjJ2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSIjZgACgkQJNaLcl1U
h9DVmQf8DHD4US+VwJB2+GIOnP9xJerSq1q68bKEagqHIyrFqegoJicQgpq3LZV+
uW1DIiGptfDQ//XDqIWs8Bj66EnJsms1Cmh+aN5ZBx+mIxfJa2rijKWplv9w5ic7
MjtnAZtiRdMqGXkar/E4ym2wFpHlqvBSygEZJdQhIbiflO3uFAK7iAxJJzcmoN+h
lu9gE+WSnp2Fb6FOZBvOychVs4wP+68Lx/hhEHxKjwzhfgPXzqde1TkV65nfch72
czAvYpj6ZLO400CZpMjyPCn6Mjs3qbJRH2WgE9KbW0lNe7v6wbq0TT8IaVdNBW4g
uw0m6+BWS3NyVP8+8/GXCLgTBhtqzA==
=FSRD
-----END PGP SIGNATURE-----

--0npxGfmuYZo3rjJ2--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC5276E9753
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 16:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbjDTOhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 10:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbjDTOhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 10:37:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED7C2713
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 07:37:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0705860B25
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 14:37:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF1CFC433D2;
        Thu, 20 Apr 2023 14:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682001463;
        bh=zincMVYZRK6cafRuIhhd1TtceW5pUuRunOjPTOk8vyg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PYUzycWTy6Gkjj+iAd1JLEplhdNh6GZbACiHMt+v1BCGEhcEMiZmCcuwt5B+/XcN/
         LLLgd8KYOuEQ+7wUNUG5JcoyE+4rMiUC8rwVTiLG6yJXikqWigiREjGqadaQ4fvJel
         kU54CxzsVQncB9dtD8IA4ARLY+EjP8NtxE0/3MuygM5Dli8m+QEGSqFrVe1t7AjC84
         PpPKrGaMLP3D4caJzRZZ9T1gZmVoEEiJcgwxCjbP20NYMSL9Xh0WDNk/o07x30R6JC
         YXq4PRbq2FSCR53vXhPvkrYMmQmDGY605qe7nmQq4QMSGqtjfAcCvD0a+yAMf0JVvn
         tMEI4bNUv6/xw==
Date:   Thu, 20 Apr 2023 15:37:38 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Benjamin Bara <bbara93@gmail.com>
Cc:     DLG-Adam.Ward.opensource@dm.renesas.com, benjamin.bara@skidata.com,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        mazziesaccount@gmail.com, support.opensource@diasemi.com
Subject: Re: [PATCH RFC 1/2] regulator: introduce regulator monitoring
 constraints
Message-ID: <90c4c45b-daae-4f38-a60c-6bb8d33c025d@sirena.org.uk>
References: <3eb854e2-8631-4f4e-aa00-d06236967f54@sirena.org.uk>
 <20230420143045.541253-1-bbara93@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QSDwR6rJzKQxE/zo"
Content-Disposition: inline
In-Reply-To: <20230420143045.541253-1-bbara93@gmail.com>
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


--QSDwR6rJzKQxE/zo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 20, 2023 at 04:30:45PM +0200, Benjamin Bara wrote:
> On Thu, 20 Apr 2023 at 14:17, Mark Brown <broonie@kernel.org> wrote:

> > Are these constraints (ie, board specific limits) or are these more
> > just properties of the regulator device?  It does feel useful to
> > factor out this stuff, but it's not clear to me that these are things
> > that should be configured on a per board basis.

> These are actually properties of the regulator device. However, the
> properties are only "active" if the voltage monitoring is wanted, which
> is currently a per-board decision. Not sure if there might be reasons to
> not activate it.

Right, but in any case where the monitoring is enabled then these
properties would also be needed so there's no point in separately
configuring it.

> > These all sound like things where the regulator device is simply not
> > going to support having monitoring enabled when doing the relevant
> > actions no matter what situation we're in.  If that's the case we
> > should just have the regulator driver set things up.

> I think this would be feasible if the driver decides whether monitoring
> is on or off (which might be a way to go). I think if the decision is
> done per-board, it might simplify things to have the whole "should I
> turn the monitor off now?" overhead not duplicated in every driver that
> supports monitoring. What do you think?

The driver can supply flags to tell the core to do things like it
already does for a whole range of other things, there's no need to force
things to be configured per system in order to factor things out.  It's
just a question of where the core gets information from.

--QSDwR6rJzKQxE/zo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRBTjEACgkQJNaLcl1U
h9AWrAf/SAHiEx9FFCkDqXtrE+v46LMYHid4Q0QeV16Ko7ok5yuIV580igyiNTvs
Y6260JFZQGnHvYkHLvsgmy56jKpfmY1pmMz0Ax1CdOKB4AQs+DJSoDjTf2+obZaI
jNuB+v0Oe3eFS6weWfmwSI36YPx+UNssap/3m/bbc1GMico0q3veMM7lVDZFtO5L
7sIw2YcJtQAp4G3o+MeD4S27cNZOTnzajVtmJdAPuOlA+ujzpjTZj9VhF0EHwSxl
H/VYlB6vHfYABXCCvk//RDVzHFxC1LB6S8euxrQPYxOkSTfbsCS2me+76e49Rm2i
gHXWo6LVrow1HCQLYYAJchW5aadXmw==
=4Pqh
-----END PGP SIGNATURE-----

--QSDwR6rJzKQxE/zo--

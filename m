Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8337A722913
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 16:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234386AbjFEOop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 10:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232558AbjFEOon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 10:44:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A6C9C
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 07:44:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C1C2B61722
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 14:44:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 531F1C433EF;
        Mon,  5 Jun 2023 14:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685976282;
        bh=IXOgGX7q2fZSBzW+eEk1Wq3EVo3HpB6Yt/pW7AWk2wI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sg/62qzWCbwBdbsjCVvKJbPfJhkKi9pCtNJrF/XUcHIseDh90Uy3htaMLJUz5QDnD
         Kugpz7ZITEITYH/SDxkj31A1gPxxAAmxKR3vVzvyP5zGHt7JE79EiTur9Do4ofOYJK
         aRb6tkIm4YB523SeUwS50Q9r1aa1oC9Yv0rbDoiTd1pvOG5N2hnzrYPGOHZLhbxQAm
         9bsHtJPdx1crGSZI/VPvlYXxYkfkQVt5Mg1f0EqgZ8AMHnRJH+pXOpmgSETMF425mF
         +6KQmfSsLeuBbuhosb/4HKBRDkEk7YbOelIPFrXIHZmR6IlBVoHrHg7BmlDDt8scI0
         e0RVg2Zqczo3w==
Date:   Mon, 5 Jun 2023 15:44:37 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Raag Jadav <raagjadav@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] regulator: act8945a: rely on hardware for operating
 mode
Message-ID: <545d3463-ce56-41d5-9d95-55764c448c09@sirena.org.uk>
References: <20230605104830.68552-1-raagjadav@gmail.com>
 <04b8fa24-e5a8-4871-a397-f1c0c886449a@sirena.org.uk>
 <20230605143103.GA3068@pc>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="puGooPXjA0AF5duk"
Content-Disposition: inline
In-Reply-To: <20230605143103.GA3068@pc>
X-Cookie: Biggest security gap -- an open mouth.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--puGooPXjA0AF5duk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 05, 2023 at 08:01:03PM +0530, Raag Jadav wrote:
> On Mon, Jun 05, 2023 at 01:16:33PM +0100, Mark Brown wrote:
> > On Mon, Jun 05, 2023 at 04:18:29PM +0530, Raag Jadav wrote:

> > > Convert ->get_mode() and ->set_mode() hooks to read/write operating mode
> > > from/to hardware instead of relying on driver memory.

> > Why is this change being made - what is the benefit here?

> Original implementation uses drvdata to load/store
> operating mode for the regulator.

> This change doesn't really add anything new.
> It is just to make sure that the driver is in sync
> with the current state of affairs in the hardware
> instead of relying on locally stored status in the memory.

It's also removing a cache so we need to talk to the hardware more often
which doesn't seem like a win.  If there's a bootstapping problem then
shouldn't we just read once at startup?  If there's no problem what's
the advantage?

--puGooPXjA0AF5duk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmR99NUACgkQJNaLcl1U
h9A+awf9E7r5u5zgTmh4yjCrkSLmbjQ/Lpdd/GSvGdMeoWYVkj0Q7iyu9+dwxQnV
UUaBqkrSXcahIl0JkRoWSpMcW0GotHcvzyRrzjCU9uK3DJ5a8SiHa6rm7WbNhMT8
S6JcBGeJzywknHBRpeWfpa7H90WFSxU7/cf/EmVzkAOLxT9T0GQktHSxwrl6BM0T
Ro+DG5elPionsSBnnoHX1UKJE2XCRTMHXpF7+j15aGknbZJs6SuFxaF/9P023v8O
c5CpIVIojStYSvDuZFbol+9NRwKxFLwzXYpNumAXAwU3q0MkT6dqXz+dtPZfIUeC
b3VAjvm7g92qmhwqprlxCi+HDYpmpg==
=jbQQ
-----END PGP SIGNATURE-----

--puGooPXjA0AF5duk--

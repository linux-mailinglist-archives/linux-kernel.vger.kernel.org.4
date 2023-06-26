Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF90273DE15
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 13:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjFZLtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 07:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbjFZLtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 07:49:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E825E43
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 04:49:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 23B5160DF7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 11:49:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 788C8C433C8;
        Mon, 26 Jun 2023 11:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687780156;
        bh=WMnyc76wPixdfN6eTs+gBg4osYliPCF6Ft6xT2Ch/o8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jem1nIw5r5mSLKK4uESM0pz0NZbdpCCfk35MvqualwJ5PeQmgF5z4KrvcdkbC6R0h
         aNhlRlCXVXiYnKTp1vfRwC9gRbl1uOFliiex6vP5xDuFO5Kuik2mtU+jIqpU98no14
         x2iK2iAKaUNF8S/CxXZMyVKVtywmNNO4v0aS5GJ+ypaEW15gSlZJopyOgoUbmaBqGH
         ANpcNOqqKshGEHP+zRyb5DFYcqNdrFQePbvsnIby1oMUbuMMWuPm7IvuUueZUGP1dn
         UAq3kuXm8U67PKzp+5ig/ESPdJB8i6+53j4gmvyxL42ydPj9TeR3UMj4tYXJ509izs
         wHhYE5EJiZTKQ==
Date:   Mon, 26 Jun 2023 12:49:12 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: core: Always store of_node when getting DAI link
 component
Message-ID: <9fbe4924-5c02-43f7-b47f-bc290fd07e67@sirena.org.uk>
References: <20230623-asoc-fix-meson-probe-v1-1-82b2c2ec5ca4@kernel.org>
 <87jzvrksi2.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3CDck05rY9k9by3C"
Content-Disposition: inline
In-Reply-To: <87jzvrksi2.wl-kuninori.morimoto.gx@renesas.com>
X-Cookie: Nihilism should commence with oneself.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3CDck05rY9k9by3C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jun 25, 2023 at 11:54:29PM +0000, Kuninori Morimoto wrote:

> > The generic snd_soc_dai_get_dlc() contains a default translation function
> > for DAI names which has factored out common code in a number of card
> > drivers, resolving the dai_name and of_node either using a driver provided

> Yes, indeed.
> But I think we want to set it under lock and if ret was no error case ?

It doesn't really matter - there's only one possible result, and nothing
should be looking at the dlc unless we return success, but yes that'd
probably be a little cleaner providing we don't ever return early.

--3CDck05rY9k9by3C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSZezcACgkQJNaLcl1U
h9BtEQf+INsq9seLiC6VRG4jRO5+qnpMCXRjGjCNE3PIyshFO46vmTbThLBD2WJ4
82psfBGU3USI8oSeR3uDUMsi7lh7hQq9n8IxaFVbr0TZTaD2EYctvzdRcT5zMbTY
hJ9NHlvfD/Yc6ryT3g3NMYMaHn2ghSUBBN72ihz3PR0VFJ5h4KZc1V6Xw84k7Ekq
qcLCNcIowshKkOZMF2DtiHh4LaPQxkOlKLpkWCdnwYlNPtLjAISRr5kS/8McMiVM
c82esARYyN56ajMf3pcxhZ0tr6kgCKIaydBh/6DQXLuybXheb6SQqb4BXvuervF2
9Mc8GrUj2SFs9x5B/a4KtbK2QRAJUg==
=8Ks5
-----END PGP SIGNATURE-----

--3CDck05rY9k9by3C--

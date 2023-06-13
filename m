Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81F5372E4BE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 16:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242173AbjFMN7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 09:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240917AbjFMN7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 09:59:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21CB3E3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 06:59:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F94E62C43
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 13:59:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 606C9C433F0;
        Tue, 13 Jun 2023 13:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686664759;
        bh=4EDAi+iNifcXm00vXweGwQS6q1c/UCdkOHc/yN7EsPo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PPbQKXKMMZEGmyVEFwUUcOeCTRP9VE6GiHY5NXiTtURTdnFF5mXKClM9mAIwyuFl+
         LRgfEtlVEnXFjLDXT7C9pBk0694VBUMQK4ZpPoG0nmnHHoLdo9kkWF0F831kDeHaVB
         7Vxi7T166lpbMfe0J/DwAIs8B0YlmbsPxBf93mAKPQjTQy3CuPefHDxleWtciYPraw
         HPDVtA1SUNoAsat7ynos+dPej4YlktqYhpWd/t5RkHi6LCkYJaQQ2o3b6ljOhr3haj
         NHihxU9sr9TSHwVZ+85dHWgzdLO3I+IsqSL2egYJ3wDyKkYd+HhCbx+sfKXaTABFNZ
         MxkwkdEzyyJog==
Date:   Tue, 13 Jun 2023 14:59:14 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda: Use maple tree register cache
Message-ID: <e48bbd3b-544d-43d5-82a1-8fbbcb8cd1a4@sirena.org.uk>
References: <20230609-alsa-hda-maple-v1-1-a2b725c8b8f5@kernel.org>
 <87v8fua1qm.wl-tiwai@suse.de>
 <877cs7g6f1.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CeKFcVfVTiPPdzSt"
Content-Disposition: inline
In-Reply-To: <877cs7g6f1.wl-tiwai@suse.de>
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


--CeKFcVfVTiPPdzSt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 13, 2023 at 09:36:34AM +0200, Takashi Iwai wrote:

> This is an error from regache_sync_val(), and it indicates that the
> synced register is write-only; regcache_maple_sync() tries to sync all
> cached values no matter whether it's writable or not, then hitting
> this.

BTW I was just looking at reg_raw_update_once() and I can't figure out
why it's trying to do what it's doing - it does a read to check if it's
seen the register before and then does an _update_bits() if the register
hasn't been cached yet, apparently trying suppress duplicate writes but
possibly deliberately discarding changes to multiple bitfields in the
same register.  That's not what the non-regmap path does, it'll only
discard noop changes to the same bitfield.

--CeKFcVfVTiPPdzSt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSIdjIACgkQJNaLcl1U
h9DUfAf9Gi+yGhHKCsHvttrQZ//1ZwjDJeG+HCM/i+HwUbKA6zLXDB+T6nsWBNPg
7uBcB9XWXq3LoLYZEqJ9nyfEpR4vH6bM5bDD1K8uO1QgNB5ho+4tkQa321XG3HUo
xz9mjYz1VZWuQWiLc/7z7KghBD6bLaCMapWuIWMt8aQD/tF/CTAG1zFovqLyk+Yo
HFx0blkO4LfCkSbVPr6xoPtOkuO8Wo0t2wWTBjrKj8X8npJS2cVCrTiteyFSbzwT
JgPyJoG1ChihxyxX0jnYhC7aGf1rcZ4xrbpK0cFlkTjtw3MSq+Dj/wayhY+pJJAp
sXbQbPgJpxc3+0yNvCXN5hPe4f1t8A==
=7/9p
-----END PGP SIGNATURE-----

--CeKFcVfVTiPPdzSt--

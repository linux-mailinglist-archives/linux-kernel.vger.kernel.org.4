Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09B4772DEFD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 12:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235139AbjFMKQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 06:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241444AbjFMKQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 06:16:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6329010DF
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 03:16:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB49863435
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 10:16:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CA05C433EF;
        Tue, 13 Jun 2023 10:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686651402;
        bh=euxV11e17py/oLQ07+Pz2bttIsU7QRVKaT96M+8AnCc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tgacNZrOslbvX3BxFfcwtfYBYbuPyIayRyBftqc+NeamV46DiMa1a9AdygyXTrGjj
         pul0VR3qfvxlFtp/LkfLcA4aWvq/kCq+nP2TflJEsft/bLULamjQzrm5SecqhIZRn7
         KxSN4d/kI7L0x1t1T5A6NJMdkr64mOrmYGWrW/Q5yYv566DRQ+KT3a/GW+nL4GWzyY
         E1D2h+RqOAR0PYDW33OfUM2kBhBkb6skiBo2VNXoqUJ4xG3/NmuynoYCg+ulE5uvw+
         WPoR3cKt5tuTDfCC8KlPi/Buwt48mpsKGXFcjL0XkPmvcCgsHUSdIJtuTAw5K1hL7z
         6FNKOHDbJeB6A==
Date:   Tue, 13 Jun 2023 11:16:37 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH] regmap: maple: Don't sync read-only registers
Message-ID: <b86f7b95-f116-4d06-9aca-7195b01dffab@sirena.org.uk>
References: <20230613074511.4476-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QD0bhsf6hO4NwSqe"
Content-Disposition: inline
In-Reply-To: <20230613074511.4476-1-tiwai@suse.de>
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


--QD0bhsf6hO4NwSqe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 13, 2023 at 09:45:11AM +0200, Takashi Iwai wrote:
> regcache_maple_sync() tries to sync all cached values no matter
> whether it's writable or not.  OTOH, regache_sync_val() does care the
> wrtability and returns -EIO for a read-only register.  This results in
> an error message like:
>   snd_hda_codec_realtek hdaudioC0D0: Unable to sync register 0x2f0009. -5
> and the sync loop is aborted incompletely.
>=20
> This patch adds the writable register check in the loop for addressing
> the bug.

This should be in _needs_sync().

--QD0bhsf6hO4NwSqe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSIQgUACgkQJNaLcl1U
h9DxtQf9HJLf3oJ8TwTWUYxeYCXazxOQWwzMq+CNDgx82e66cfDywTMYwXIibUlH
1MmJy2B8YN93YY1iRHeXgRZCFSgphvo8rqvzumPoTjWLY/jHSGsHKfgrLKmYs/Nr
hHi2c+RUHdhJxTsju3cOfYbVWljxb65T5WdKLY3aVxVhUTJb4InlzMY30ALyd8Nu
scYzjGeuBp6uBGaNnNumcPKecuqIOzfI5ow+M8daretzOiqET7/HuNncG2is7q8t
QDt5oxMrJxotTSP/Qme+KJ3BOk9KWDPXwllCnAjGhVefKwvY4Bym16chNt4yjfMT
26syD4aUv8e7JfYtRsCApP4b6sGirQ==
=EFK4
-----END PGP SIGNATURE-----

--QD0bhsf6hO4NwSqe--

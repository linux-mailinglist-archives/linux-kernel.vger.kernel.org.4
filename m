Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C087474733C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 15:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbjGDNtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 09:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbjGDNtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 09:49:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4660C1739
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 06:49:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC7BA61259
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 13:49:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77992C433C7;
        Tue,  4 Jul 2023 13:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688478547;
        bh=1X3duhdH+Vvopd9cLifHrkGNg6yeXoAd+LCibcEFA40=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T4V7aoWyJlpne02DABkkRMO9+Hm6hk27HaJoTqMKhsLY67I3s21tOrW/OYLJo9QoU
         ej+792qhw/24dBm36iCjeWwlfnL7P2iuwQDsIODcE+DUgKPBCF4mzlOl3vGTX+c5RT
         paabrpWgC605RN0cGCMVJ/zl7izkrxkgKAkz21v+yF4owB/lQouDEmXHMBLrE+L1DL
         I9EUTvg9OwSaLvne6nasjtCJ7d4TjFWkEJW60gdd0ECUYHyKy6G9uVEPfOjSChYSu3
         nwaUrtu7dZDpdYei0eM60mjAfLoWSGFePSO+2DGF6IBqew8l2T+FNKZ4CNysQW/Ji0
         Pb0SpmoTVfPYQ==
Date:   Tue, 4 Jul 2023 14:49:02 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Benjamin Bara <bbara93@gmail.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        support.opensource@diasemi.com,
        DLG-Adam.Ward.opensource@dm.renesas.com,
        Martin Fuzzey <martin.fuzzey@flowbird.group>,
        linux-kernel@vger.kernel.org,
        Benjamin Bara <benjamin.bara@skidata.com>
Subject: Re: [PATCH RFC v4 07/13] regulator: find active protections during
 initialization
Message-ID: <ca0b3bbb-dfa4-454c-9304-318fbd8e7f78@sirena.org.uk>
References: <20230419-dynamic-vmon-v4-0-4d3734e62ada@skidata.com>
 <20230419-dynamic-vmon-v4-7-4d3734e62ada@skidata.com>
 <030a99f7-98f3-a24d-612c-d460859fc276@gmail.com>
 <08d6fc5d-30bc-4a55-a495-2a73b5800f79@sirena.org.uk>
 <CAJpcXm6sPgW+z93sObv8rNjFxPsd4uzhHNNQaGmUR07kB0-BRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="W63c7pdVT9Jje+c+"
Content-Disposition: inline
In-Reply-To: <CAJpcXm6sPgW+z93sObv8rNjFxPsd4uzhHNNQaGmUR07kB0-BRg@mail.gmail.com>
X-Cookie: Memory fault - where am I?
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--W63c7pdVT9Jje+c+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 03, 2023 at 08:43:47PM +0200, Benjamin Bara wrote:
> On Mon, 26 Jun 2023 at 18:49, Mark Brown <broonie@kernel.org> wrote:

> > Yes, this isn't really the idiom we normally adopt - the default thing
> > is to just leave the hardware untouched, that should not usually be
> > regarded as a problem.

> Thanks for clarifying. I will now activate the constraint instead of erroring
> out. This guarantees that the workaround will still be applied, so basically
> similar to the current bd718x7 implementation. I would still keep the message as
> a warn, or should I drop it too? My idea is to let the user know that there is
> some kind of monitoring going on but the device-tree is not aware of it.

I would leave the warning off, I'd say it's more unusual that it might
be possible to disable the montioring than that it's being enabled - a
lot of devices either have fixed limits or only allow the limit to be
configured without allowing it to be completely disabled.

--W63c7pdVT9Jje+c+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSkI00ACgkQJNaLcl1U
h9BCkwf/VJYuQry5uylU4oN4StQNYW3IdVi/i/Wh4QmjuJxcJfQMUINKRyKB/Yet
ZOoP03oOc6woS0amSyXu37BG0dz2rYCMGNNmg66LyVTi+wfsn3d+S9C5j4ciVUfX
HpRYtz3PNWvp3uBJjWwz3fAVGITXE7qw1lgKt49irty7Q+txsAruinu789Vnq0+l
HulQzceHMlfNmqg56Ty3TsmTN/O0Twsn7XNuCZCTQFaIuzypFiNHsyf1RD4eb5Vo
+yzjhcOzcUbvO8le/plklmueBo3iTV1SGH9JwmTfWqaTQGopYObHoXIaA1P6DObx
FBQpLj+gdoiw4qvjwWzDrNAlRt7Pgw==
=jc9a
-----END PGP SIGNATURE-----

--W63c7pdVT9Jje+c+--

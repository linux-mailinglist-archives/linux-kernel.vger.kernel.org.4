Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B32A36F2976
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Apr 2023 18:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbjD3QOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 12:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbjD3QOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 12:14:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A238F1997
        for <linux-kernel@vger.kernel.org>; Sun, 30 Apr 2023 09:14:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 36CF960B52
        for <linux-kernel@vger.kernel.org>; Sun, 30 Apr 2023 16:14:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47FF1C433EF;
        Sun, 30 Apr 2023 16:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682871289;
        bh=mZw6lY3AryiQpg8PEXI6vvSlsTp6tXZMpHM+z5tjvSI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L4w3zlIs1PcgTSumMTn6nWCZ1jeKgiFWsjs162sVd+ZLljUHYXuOEH/QKhp+Ce/F4
         7Ci90QoRlpeSCBETClDl4ZyM6MDKEAIR/OyMQnYabhn6WWu0VTRCDITq6HVFVU6FWW
         rcUBWwZUuha0xX+4gwReegwLzb5eiJU42FXn1ZnvEQzlYvwQN6uzbSaWetQZKh9cB9
         jv9l7GzMx1bI5Otac7ILxSuS1ENDlmsnpjmNBL9DivCuffGAY3nYftLZJN8AUDuVNP
         GyzctbU0YX48EIBhBPLMubpCdgnRSzJAkDiQXSulIOq3kfzCXvV1KGzVENzWXwVHzk
         rDJXXsV7ZrVJQ==
Date:   Mon, 1 May 2023 01:14:44 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        David Collins <quic_collinsd@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 2/2] regulator: core: Avoid lockdep reports when
 resolving supplies
Message-ID: <ZE6T9NwPbCOCC+ot@finisterre.sirena.org.uk>
References: <20230329143317.RFC.v2.1.I4e9d433ea26360c06dd1381d091c82bb1a4ce843@changeid>
 <20230329143317.RFC.v2.2.I30d8e1ca10cfbe5403884cdd192253a2e063eb9e@changeid>
 <CAE-0n53Eb1BeDPmjBycXUaQAF4ppiAM6UDWje_jiB9GAmR8MMw@mail.gmail.com>
 <CAD=FV=Wqu21ErJGwf24mkFcXTZx_vR1r++0cP68vr9FQDY8O-A@mail.gmail.com>
 <CAE-0n50vofDO6dpEvnetfvXL41m55j7_OXF=JGZ9L34M0xXPDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9tapRAjhGGSv3Ezs"
Content-Disposition: inline
In-Reply-To: <CAE-0n50vofDO6dpEvnetfvXL41m55j7_OXF=JGZ9L34M0xXPDA@mail.gmail.com>
X-Cookie: Avoid contact with eyes.
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9tapRAjhGGSv3Ezs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 28, 2023 at 06:57:36PM -0700, Stephen Boyd wrote:

> Does that long period of time cover a large section of code? I'm not so
> much concerned about holding the lock for a long time. I'm mostly
> concerned about holding the lock across the debugfs APIs, and
> potentially anything else that debugfs might lock against. If the lock
> is only really needed to modify the list in a safe manner then it may be
> better to make it a little more complex so that we don't exit the
> regulator framework with some rdev locks held.

I'm not sure that I understand the specific concerns with the debugfs
APIs?

--9tapRAjhGGSv3Ezs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmROk/MACgkQJNaLcl1U
h9Dvjgf/dtHe0UxzpjqGNfDBLNMJWHX7jJhBUCWW0AQCZnNps8P4jRGX4MIwZRhD
nspAyieUK/h255zr0vYDR9mMtZen1/ZJAkauIUGNI52qNsihdKN1eaavQg20RGrH
NbZNAcVQ57bMQ8nCP+5ZiCadhcQQsA81Zrx2pm67yzPcPMiwvAzna2xQWDG7hOAU
6mIleyCzXFeCO9vFjemtLR42O5Z4+e5/cBaYqrshq96GBxwMMp0o2RfW0UZjW4hV
fh/k6co3u2VUEykTxlkFu/zisqumN0muFB5z/qDnAXrAMOMhJr0l2HjnttbDGJfX
B0dSkrjlNZp+7X6At2OJ/6QSX1eutQ==
=3p9F
-----END PGP SIGNATURE-----

--9tapRAjhGGSv3Ezs--

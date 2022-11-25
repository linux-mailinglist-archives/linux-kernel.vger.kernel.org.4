Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5543C638E94
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 17:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbiKYQuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 11:50:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiKYQtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 11:49:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CCDA537E1;
        Fri, 25 Nov 2022 08:48:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D57062576;
        Fri, 25 Nov 2022 16:48:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AC39C433D7;
        Fri, 25 Nov 2022 16:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669394908;
        bh=cTVoodLlRnSOP0+5MqapZl7ab4yuqBv9vryTvywIgb8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TIk0X2r88mAdgXcX0wma+4mqtdidj+l5UzaOvNkGERBV0KIWnVDqH+jwuM8y90ay6
         +wJs1DvXpE+OkI1MphVGFu8rTwcrAaTlJoYGskbIxciIgNR703V15p/SKFxIc6OY/B
         xuE3yUMhxW8R98348tFw54Ew1mUungbpsu0D5i//fs+zrq/VBjZHnbqH5mehTSOFnS
         2cFgZyjf9mNayVFBtAkPVfFJVi9m9Y7YFaVW7HYv1pl7OxFLRfAvureAPWbGNcP2oz
         QORjLnw2MZGiZGWS3fdOuvBn48NIE5Wm3rs1GOeMoopRAHOoWEgH9uKpZeL+OUFp9t
         WOvbyMCeTZRmQ==
Date:   Fri, 25 Nov 2022 16:48:23 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
Cc:     linux-spi@vger.kernel.org, openbmc@lists.ozlabs.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] spi: wpcm-fiu: Add driver for Nuvoton WPCM450
 Flash Interface Unit (FIU)
Message-ID: <Y4Dx13KQHqyBLak3@sirena.org.uk>
References: <20221124191400.287918-1-j.neuschaefer@gmx.net>
 <20221124191400.287918-3-j.neuschaefer@gmx.net>
 <Y4C9druicCm0m3wi@sirena.org.uk>
 <Y4DuW6Rai0urvrEI@probook>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EcQuk4Qg6NViYNQL"
Content-Disposition: inline
In-Reply-To: <Y4DuW6Rai0urvrEI@probook>
X-Cookie: Time and tide wait for no man.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EcQuk4Qg6NViYNQL
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 25, 2022 at 05:33:31PM +0100, Jonathan Neusch=E4fer wrote:

> As to connecting non-memory chips: There is also a second, completely
> different SPI controller in this SoC, which is used on some boards (in
> factory configuration) to drive a little status LCD. I think it would be
> easiest to use that one for custom hardware extensions.

That's never stopped hardware engineers.  Perhaps it's simpler for
pinmuxing, layout or other reasons in a given design.

> > If the driver were implementing regular SPI operations and advertising
> > a maximum transfer length this should just work without having to jump
> > through hoops.  The core can split transfers up into sections that fit
> > within the controller limits transparently.

> As far as I'm aware, the controller is not capable of performing a pure
> read transfer, because the command byte (a byte that is written, in
> half-duplex) is always included at the start. I think this limitation
> would break your idea.

> IOW, the hoops aren't nice, but I think they're necessary.

Ah, I see.  That is very limiting.  I'm very surprised that the
6 byte thing works at all TBH.

--EcQuk4Qg6NViYNQL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmOA8dYACgkQJNaLcl1U
h9BtJQf9GPbxMYPOrlz3SZgjNLNWe4/gqjuP6n4MLBYU0xX6EA0jljP6ns0O0O1e
hctY+Xg08vYmz9Ty3Ogc6lv1dPXwGB+AxRktoxkZuhp0uiPU5RzTyI7Ln80+DIKA
+KUtP0XO/yjXDcMTS9phUaDmwwKaneKrbYw02G04iYWsJr5Kmp+tJiRYQEBlgdsa
C0bRvfs/rGZHh6PtlamxACJGz8w25EfHbiD/zYpa5csHVQBkSr2qqpMUNKkABBqE
9UNq+InmthqHdHUnjyLVYuy2NcID2EDyo2/rCvi9I6hQceyYchvZFimwp7MciMHy
LkU87STOjXlPjsAaORZDQifKRiG22Q==
=YB2z
-----END PGP SIGNATURE-----

--EcQuk4Qg6NViYNQL--

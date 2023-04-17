Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7A46E4F29
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 19:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbjDQRX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 13:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjDQRXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 13:23:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000CB44B0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 10:23:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8CB24620B8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 17:23:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 055F5C433D2;
        Mon, 17 Apr 2023 17:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681752201;
        bh=wkeg5+i1e32gX2mRBlDeKCM1OhqUGj6JLGniF9eUzR8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jZTQ17mfcj1W4J9vzCSL5U3pyj7Ae1ts53GIi8pgOXnoTeZ+fP3hfuX8A6RytZnsJ
         YN18jVESO6j1t/we3x7fIeWiCV7O4t00eqS5gg6bKz7+qhCj0clOKCoeBWU2/PcDiq
         l/zO7dhHNLhnHF24JavnYDbfh/X/gZ5Ed4klTKT0rGbUYawl9EV1oHAysE39pUA8b9
         jPW4q62LQvrTmXagfKp0FT7RFRUnIv8aKJPyUYNYQZmotdKlQXdiwhc2BGA2kG1HKa
         nH35PO8neXKIXm9RdTbR6fJHIr7t/J6l+zvaaO0fzU1n4n3EsWfaBV5Rd5gpSivnOe
         OK02oE/573M4g==
Date:   Mon, 17 Apr 2023 18:23:16 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] ASoC: codecs: wcd934x: Simplify with dev_err_probe
Message-ID: <7da0f237-b4ba-4c66-8061-a14c09a1e7a5@sirena.org.uk>
References: <20230417141453.919158-1-krzysztof.kozlowski@linaro.org>
 <20230417141453.919158-2-krzysztof.kozlowski@linaro.org>
 <20aa9662-9cbb-4fbe-b6ed-3a6ba33e820a@sirena.org.uk>
 <c294d672-c2fa-7468-f02d-18d5230a1d95@linaro.org>
 <5d753a8a-b979-43f6-a403-8a51f69bac29@sirena.org.uk>
 <752c2dc1-65a9-a74a-d9ce-7db5ddbea5f8@linaro.org>
 <80be967f-b831-4a73-8474-09bb96bd2c32@sirena.org.uk>
 <1cc83bad-55c2-46b5-ad70-cac160b842c1@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2eytpMUzOpYcD15r"
Content-Disposition: inline
In-Reply-To: <1cc83bad-55c2-46b5-ad70-cac160b842c1@linaro.org>
X-Cookie: Two heads are more numerous than one.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2eytpMUzOpYcD15r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 17, 2023 at 06:32:07PM +0200, Krzysztof Kozlowski wrote:

> If you prefer, I can mention the message/EPROBE_DEFER difference in
> commit msgs.

I know you prefer to maintain exacting standards in these areas.

--2eytpMUzOpYcD15r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQ9gIMACgkQJNaLcl1U
h9CZbAf9FNdeT6PP5Su4F8e7QLUDQqxLl/p8ptGVQfMYq+bdL8cy60Px4p3/b8OM
b5y2tSixtmE6OERzR3qZ8IaX/0nizP2PumOJtUaipyBFdQE131qLvwx/6RbcL61g
IjiG1Yu+Tn7FZdMCCTqIMq1yDnZbHx4wZ0tuYYgEl1gjH5wrIMxvZu0f6zw/O8Jy
MBq31U+MvNPyr4hAG2/DrDUQ4H2hCnxiGzWId0eN6l+/m5Le+FlWi87FT5ZkbxWJ
bp7QoVnTMRCBKR5WMUV4bUTZbNMC8bVCELv8xZIlzvL16WxbnN0vERxyjRSJKJlX
VnBiR4rAEVpyJjHvcMoMCuJVzl0I9g==
=j0TA
-----END PGP SIGNATURE-----

--2eytpMUzOpYcD15r--

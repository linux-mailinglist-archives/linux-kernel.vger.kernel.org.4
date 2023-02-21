Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB2A69EA6E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 23:53:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbjBUWxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 17:53:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjBUWxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 17:53:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD9EFFA
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 14:52:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 04D9A611F8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 22:52:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B5C5C433EF;
        Tue, 21 Feb 2023 22:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677019975;
        bh=H5Q0oBWkegXL9ys1FBs/+swNGQY6jgS9ZMg0QZL9abw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ozNuWUtkepAEQeTFW9Uz1w8nlWgCBAPfR9+3cXES9kt6fphXuzsoA2kzlR6F1i13x
         ZFpFEgM/NAdFDxVmJY0lAdR+i7x+P0MJJ7WSuu9EmYzwuWZmFE2pFRNChDb+98OIUV
         kiEBPF4AZB1FGLl6cgrUPzbnhJe3omHIK13d72QXO2+/UG3Ft5yRMTA3izzOd2ZBno
         0eADY3oTQaGteKiW2CP2wlLdUuYNWfY+DqMQDH36+0PPXJHfmWoKE+2f/RmH2wVUmv
         nMD1QaoqiGnTAKCWE2/GLtAB7p+jR4QGm0MNHjpEDY8d5Hysh0pQX9AMg505Zg5DdR
         qRGujFkDKAc0Q==
Date:   Tue, 21 Feb 2023 22:52:52 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Tony Lindgren <tony@atomide.com>,
        Doug Anderson <dianders@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Luca Weiss <luca.weiss@fairphone.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC v1 0/4] Simplify regulator supply resolution code by
 offloading to driver core
Message-ID: <Y/VLREM7n+wstHbn@sirena.org.uk>
References: <CGME20230218083300eucas1p28c7c584877b8914a3b88904690be82f6@eucas1p2.samsung.com>
 <20230218083252.2044423-1-saravanak@google.com>
 <e3814c81-c74d-7087-e87d-12dcb49e6444@samsung.com>
 <CAGETcx-UcVnDw-FJAPeA1mLpPno4OE3AAv4WsfP852zOdKqPCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vRYXYd8hZ4z5+dUv"
Content-Disposition: inline
In-Reply-To: <CAGETcx-UcVnDw-FJAPeA1mLpPno4OE3AAv4WsfP852zOdKqPCw@mail.gmail.com>
X-Cookie: Serving suggestion.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vRYXYd8hZ4z5+dUv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 21, 2023 at 02:36:52PM -0800, Saravana Kannan wrote:

> Thanks for testing it Marek! I don't want people to spend more time
> testing this before I hear Mark/Liam's thoughts. So, let's hold off
> for now.

My main thought right now is that I'm not going to think about it
too hard if it doesn't work correctly...

--vRYXYd8hZ4z5+dUv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmP1S0MACgkQJNaLcl1U
h9B7ZAf/Ws8zy5KA3eWOmYx09doMOIFQN3zjlMla3I+uxFpPE8vE2A45+kRWqMSH
iV1JDMmcU0apP5p1YeSXG9TVONGFlWKoxeVGSNEGmWmHWkBkqZC7ptruYgTy5lqk
TByXJUAkFDBs79AHQEY7wIvWI1cyCqpnQ7K4l6MzMRdE9LQGNpEVWh6ZthOt6ouF
mAc+b8UTk5Jf86HIiNJulncw8nVcuhJl92gdGoDQ6O/jdFdJNDRwDYB/HRuQmSqn
IdWX6FhyNchGDzZCs22lKJfepMuxnlOoeZKY8BvHPnS247EjUv00ddnCr/SVOHD/
aMFVWdh6R+gR4MkF9HqN6q7KYbW2Xg==
=IXR3
-----END PGP SIGNATURE-----

--vRYXYd8hZ4z5+dUv--

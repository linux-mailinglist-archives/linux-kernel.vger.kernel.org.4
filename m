Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24FED6DE641
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 23:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjDKVQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 17:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjDKVQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 17:16:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7809F4EE9;
        Tue, 11 Apr 2023 14:16:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A7CC662370;
        Tue, 11 Apr 2023 21:15:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BD1FC433D2;
        Tue, 11 Apr 2023 21:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681247759;
        bh=btGIKByFxuAAInZLQu3HiFyqS5ZX8qUjbH/pGEhh3N8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s2sIxHKXYc5OoLiIJiiGn4NsBX94sBcwDRB7JzYAwnq1Gu70U/y0C4TURLaQl87+N
         /0RN8XSSYBLF+5/XLORV67T/ehwWMSKhQ1qdTBxzaMgUlRP7m87hOHOvnGuMEbwc8h
         AAEiEKvV1KnwfMwmqeADpZJ6u38HZCFb+qWGcpYd2Yk34SF04Z5R4RJosEHX4yCPby
         BA4Hl7AD4s1qByPd30B6ZGtKzIYqoQplHND5EJVX7whL99zDBxIy30wmIgetVxy5Lu
         XQwumQ6KP33yYiRNiQMJZr1hD7Gd6ISRKCXyBnTBFGv1mJ5Ll+7lrLJI1DfQQhRs0m
         zhpnFebhV0M7g==
Date:   Tue, 11 Apr 2023 22:15:54 +0100
From:   Mark Brown <broonie@kernel.org>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 1/2] gpio: 104-dio-48e: Implement struct dio48e_gpio
Message-ID: <db1edaaa-ea56-4f21-bc69-43f648e79c5b@sirena.org.uk>
References: <cover.1679323449.git.william.gray@linaro.org>
 <ca710d14a710fee44f7911f2a84b6a55570561ee.1679323449.git.william.gray@linaro.org>
 <571b4df1-91ea-481c-9797-842974dfa922@sirena.org.uk>
 <ZDWopwozNjFg/9NX@fedora>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sNpvF8yaJXR5s+zH"
Content-Disposition: inline
In-Reply-To: <ZDWopwozNjFg/9NX@fedora>
X-Cookie: I demand IMPUNITY!
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sNpvF8yaJXR5s+zH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 11, 2023 at 02:36:23PM -0400, William Breathitt Gray wrote:
> On Tue, Apr 11, 2023 at 09:23:55PM +0100, Mark Brown wrote:
> > On Mon, Mar 20, 2023 at 10:50:15AM -0400, William Breathitt Gray wrote:
> > > A private data structure struct dio48e_gpio is introduced to facilitate
> > > passage of the regmap and IRQ mask state for the device to the callback
> > > dio48e_handle_mask_sync(). This is in preparation for the removal of the
> > > handle_mask_sync() map parameter in a subsequent patch.

> > What's the story with this patch?

> Currently dio48e_handle_mask_sync() uses the map argument in its
> implementation. Once the map parameter is removed, the current
> implementation of dio48e_handle_mask_sync() will no longer build, so we
> must adjust the implementation to no longer depend on map.

I mean what's the story with getting this patch applied?  It doesn't
seem to have been reviewed...

--sNpvF8yaJXR5s+zH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQ1zgkACgkQJNaLcl1U
h9D+Sgf+Izhkz9XDgD7m+WF2bcdMC0Wa0wzbLVdlupuU+Z44aAnyk8B5aCio9o5R
1jraSVhUABdSEipqFlyfkuBlRwPRvs0u3xJlvaQa10I24pgoxE5veg4rqFax+BWD
QK6GowyMW3Lo+BK3N+8Ph0001s/D0ITKBLGTKL1Txo4MyjixNxsCXW0l51y0AQIk
txVttXiDekDBK55Y5bFTUXgU1leVJrhWwnTenv/lM+jvsdelxQZ//dPotyF/m8gb
NQ13hLo7PBbJKVpm8Jf5nrSzLKs/f/Sy8kFnQaxzfuYCMbknvQvee7GeOO2FmwyR
VYc2nEOma8I3H2tyZGLefk44ykElUw==
=vNxP
-----END PGP SIGNATURE-----

--sNpvF8yaJXR5s+zH--

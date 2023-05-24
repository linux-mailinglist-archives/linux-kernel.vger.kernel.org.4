Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF5970F480
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 12:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233711AbjEXKr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 06:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231724AbjEXKrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 06:47:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95DFEC5
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 03:47:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B2B263C00
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 10:47:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D707AC433D2;
        Wed, 24 May 2023 10:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684925242;
        bh=4BUAdGevUDS2Epd94O6+pXG+j/PKGBzOUO+dccWD7nw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EMXguB/0jV8xFQSYiE4SJx0kAL4hTAwW3dicEqs8nodTxmrbpO4A9VdOJWgCdw0qJ
         7TZm1vISoi9EU4QHyoJMs38p7ArIDdEpXl1yqZOUwikWXKc1MRrN0W3CP3u72tss/y
         45aaEk0Xk/lkXDA8YQvGYA91Y5jZaPSJxL+ra8yfJssIM2kHJKbs+y5OFa2UYj5bam
         42G+i31itXrG9OGMrahgJhZ1JXK7GPTBbj87ncqTf4PFiwrreor3QkAe+51bEY7ZeL
         ONI/nJCeI8KIro3gQSwOKo+0qiOJIIo4iC9S+geKOkmOpPEQO8z6TV9mkItNflCIm5
         hevRXQK+epHGA==
Date:   Wed, 24 May 2023 11:47:17 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Benjamin Bara <bbara93@gmail.com>,
        DLG-Adam.Ward.opensource@dm.renesas.com, benjamin.bara@skidata.com,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        support.opensource@diasemi.com
Subject: Re: [PATCH RFC v3 1/5] regulator: move monitor handling into own
 function
Message-ID: <d11356e4-c862-48f1-adb5-610e42318a5f@sirena.org.uk>
References: <9641aa06-4925-051c-2ebe-22e43bf9dd4f@gmail.com>
 <20230523115101.627722-1-bbara93@gmail.com>
 <5584a484-df7f-b927-9701-33dcea6230d0@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wm/nzi3fDZj5yXQZ"
Content-Disposition: inline
In-Reply-To: <5584a484-df7f-b927-9701-33dcea6230d0@gmail.com>
X-Cookie: You will be divorced within a year.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wm/nzi3fDZj5yXQZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 24, 2023 at 10:28:10AM +0300, Matti Vaittinen wrote:

> I am thinking that maybe the default should still be to not touch the
> monitoring unless explicitly requested. My thinking is that the hardware

This is the general approach of the regulator API, we require explicit
permission to change any hardware setting since that way anything we do
that's unsafe for the hardware was the result of explicit permissions
rather than a software decision.

> > > I am unsure if we might also have cases where some regulator could
> > > really be enabled w/o core knowing it.

> > Unfortunately, I am not 100% sure what you mean by that.

> I was thinking of a case where regulator state is not readable - I'm not
> 100% sure how core thinks of their state. Another case could be a regulator
> which is not registered to the core but shares monitoring with some other
> regulator. This falls under the common monitoring category mentioned below.

I'd expect that a regulator which supports monitoring will have at least
the requested state readable so it wouldn't come up.

--wm/nzi3fDZj5yXQZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRt6zQACgkQJNaLcl1U
h9DuGwf/bskG8oJOHRhXaBtzcOTe5NFsRtOHTQuYsHgBoD4ylurr0oqvjEaNwe4i
g0xQR6+uCyUtFnStSlA7A/6jtlxukBXKtA+UJjp6LKCCyPFn/KLlBXRznQGNvrO5
TFrGKbUyy7EoLYqZWKCLjM5M+K6jzcp2tHjNaO0Nv30tIUqWUAfuS/9RqKmFkRyS
G5H5TSTvOl1c5MxyRa+GEL1/GJaFdhDftd3kQnZUcWJ37e/r3opBMNIObErYqlWI
SBu6BUGXJYk6XK7FylRXRTBxJfxKX1OaobNIC6X2mVQqRgDqoQR9LRVTyV+HpTJ3
ziUiB2fH3NWcny+yDbKKlPdc0+Xd+g==
=dbSV
-----END PGP SIGNATURE-----

--wm/nzi3fDZj5yXQZ--

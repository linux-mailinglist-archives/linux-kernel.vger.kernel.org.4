Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADD9C6C6FAB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 18:49:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbjCWRtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 13:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbjCWRth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 13:49:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95645234F7;
        Thu, 23 Mar 2023 10:49:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3823DB821E4;
        Thu, 23 Mar 2023 17:49:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43F50C4339B;
        Thu, 23 Mar 2023 17:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679593773;
        bh=N7fwYApR0gf/NiLukZ2JUYkUJ3VsCz9GFyAA2hlGVhc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tgMc4FpXtppipw3zLSRU/cHNKMPva4oQ9xNSeZ94pJsYdwHAc5rgo6Eb78moQalYs
         Kq5atTB++ZkyHY8eKkCpYcBycusHeK375KQWVmWQP7iATP8leZ39k698F7sAO2CqZg
         LGWT0OCn6i+ouJfef9aTPM0P0TSoCvhldKM+TQpbt1qX1eMOybkEplHVjcp22MMnK7
         VW9gbNsiOsAGlD1OlwOalKh5VqHH8pi9KA8j8/SJGTyCk0ITZ0lmhbzxcovtBtjTlu
         9jlp7VD3ZPUuDTi6eI3ncLXPe8JKsytx5MEoWB0I4Z/eUKIZlSQGl9Q9xw9QI/85wd
         chQAmLEuLasdw==
Date:   Thu, 23 Mar 2023 17:49:28 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Doug Anderson <dianders@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        patches@opensource.cirrus.com
Subject: Re: [PATCH] regulator: wm8994: Use PROBE_FORCE_SYNCHRONOUS
Message-ID: <beeef631-943a-40db-af09-753c96b5b140@sirena.org.uk>
References: <CGME20230323083330eucas1p1f7e3f9beb5ba168c6b13374d74c158f0@eucas1p1.samsung.com>
 <20230323083312.199189-1-m.szyprowski@samsung.com>
 <20230323114035.GL68926@ediswmail.ad.cirrus.com>
 <CAD=FV=UYO1KaoAZ7o5cA83SC1VHRomvJfaXVWyYPKrEZHyNNjg@mail.gmail.com>
 <20230323174531.GM68926@ediswmail.ad.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DJ7RTdhO6rre3xA0"
Content-Disposition: inline
In-Reply-To: <20230323174531.GM68926@ediswmail.ad.cirrus.com>
X-Cookie: A lie in time saves nine.
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DJ7RTdhO6rre3xA0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 23, 2023 at 05:45:31PM +0000, Charles Keepax wrote:

> I think really the best place to look at this would be at the
> regulator level. It is fine if mfd_add_devices passes, the problem
> really is that the regulator core doesn't realise the regulator is
> going to be arriving, and thus returns a dummy regulator, rather
> than returning EPROBE_DEFER. If it did the MFD driver would probe
> defer at the point of requesting the regulator, which would all
> make sense.

You need the MFD to tell the regulator subsystem that there's a
regulator bound there, or to force all the users to explicitly do the
mapping of the regulator in their firmwares (which isn't really a
viable approach).

--DJ7RTdhO6rre3xA0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQckScACgkQJNaLcl1U
h9ARmwf/RTIEAxiYOZoohVED3bnRZ4HV3UoBNyUMhmxrfeUNPubx78Q45wSQjBM3
FsSxiJF41u5STnARRc2nrgPO+SacqVfcsQ+/wgFvftbyh4/MeWxrK4FUc74eZPYb
kVO/rOY9UWmqIo80L7C5cayYcTUau1Iy8abkk+Jshjg1H+vU0fh8gbZ9SeWCb8d1
XevjCbzc17W5Kqz8MuHp6+2WlR/jGtMhUXSbb/KLCNeDZd9AiKrU53b7QKinxsX8
3FL2D3XBhQXTBK3/1fN5WIbX6yPXF/X0ht3pMTZDChxvrnWHA+OM9lTTa0GT86WQ
5330mwUufVxHeClGRpt5keu7ZMLK/w==
=n04P
-----END PGP SIGNATURE-----

--DJ7RTdhO6rre3xA0--

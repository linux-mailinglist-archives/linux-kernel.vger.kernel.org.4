Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A32C6C6E38
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 17:57:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbjCWQ5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 12:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbjCWQ5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 12:57:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AAD1BB93;
        Thu, 23 Mar 2023 09:57:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EAC366280F;
        Thu, 23 Mar 2023 16:57:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6513C433EF;
        Thu, 23 Mar 2023 16:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679590661;
        bh=P1aolu2YzUoSDNHTSPO4B5mN/MsMfSdPzcnSDOagisY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vr4x4DNC8Axbd9UgpbWH4uHSGgTZY5CODjICCfI9kNUVNiWsk9Z7//LWzZdgtridy
         CgwJuGV0sfec8PSh09pCxdjb6MxGpmAjWX49a/BrBipvGU6hs7A69pnGhstMUB279d
         EP08mRlgpQJiqK6YeOXpFr6R6ymF45Rglb+pTEUnJa+5otDVGhWpuuhpn1je3RHW8J
         sYkPsYiYO5aObrDh96J31ynt5eevc71KphIA/vG7MFmhsqv9mv2EnG7jjm2fwzckgC
         kfBoGgRwN93ss2iAEAOg+8ifdSXlG3l5Ay9rrO7yqiTkWhMeQJ6Seklue/focAU/gf
         IbfytVWVKT5OQ==
Date:   Thu, 23 Mar 2023 16:57:36 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        patches@opensource.cirrus.com
Subject: Re: [PATCH] regulator: wm8994: Use PROBE_FORCE_SYNCHRONOUS
Message-ID: <584090e3-6833-4ec5-8c6f-ea9b2752abf7@sirena.org.uk>
References: <CGME20230323083330eucas1p1f7e3f9beb5ba168c6b13374d74c158f0@eucas1p1.samsung.com>
 <20230323083312.199189-1-m.szyprowski@samsung.com>
 <20230323114035.GL68926@ediswmail.ad.cirrus.com>
 <CAD=FV=UYO1KaoAZ7o5cA83SC1VHRomvJfaXVWyYPKrEZHyNNjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lEtw+GyiO6jJo43B"
Content-Disposition: inline
In-Reply-To: <CAD=FV=UYO1KaoAZ7o5cA83SC1VHRomvJfaXVWyYPKrEZHyNNjg@mail.gmail.com>
X-Cookie: A lie in time saves nine.
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lEtw+GyiO6jJo43B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 23, 2023 at 09:53:18AM -0700, Doug Anderson wrote:

> Sorry for the breakage and thank you for the fix.

Mostly my fault, it was me asked you to do all the drivers.

> No question that a quick switch back to PROBE_FORCE_SYNCHRONOUS is the
> right first step here, but I'm wondering if there are any further
> steps we want to take.

> If my analysis is correct, there's still potential to run into similar
> problems even with PROBE_FORCE_SYNCHRONOUS. I don't think that
> mfd_add_devices() is _guaranteed_ to finish probing all the
> sub-devices by the time it returns. Specifically, imagine that
> wm8994_ldo_probe() tries to get a GPIO that that system hasn't made
> available yet. Potentially the system could return -EPROBE_DEFER there

Yes, the code isn't 100% robust.  The driver was written on the basis
that we know the target systems for practical deployments are very
unlikely to have such issues and we'd deal with the potential issues if
they ever actually cropped up.

--lEtw+GyiO6jJo43B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQchP8ACgkQJNaLcl1U
h9CvOwf/dBY+sMhY/7ymqEiT7u0T4r8I/nQ31jn6h0K6AC0jD4tn7Xz4TMSDba/H
dqsPyAt/o45fDuZVUcCtX000GVTUfO1Skxop694K3Q8IulDBH6JPL+ba4D6mSteP
JlIhEo5mCPmZ1rI0KNLe2HBCWd0j4ClArkprIgPwDouQA51hjEpYIZQumC26/vCv
Mu8xkvbbi4Zb223tVlPCTOMukBPFUGCwR+Gzkyz3Xkq6X3CsvI+9lV/6/vuSZIY9
V8N5JTPevf9TnLPBVyEcWK5DdyJZG0SESkzmGCDKW/RnM6hxW2IRoU8JT1pFgaLB
/6NVMZSwSO9KuHe5Si0/M/xvQXu0fA==
=gz+4
-----END PGP SIGNATURE-----

--lEtw+GyiO6jJo43B--

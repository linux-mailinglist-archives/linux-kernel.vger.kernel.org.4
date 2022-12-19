Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD1765118E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 19:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbiLSSNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 13:13:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232054AbiLSSNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 13:13:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7886555
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 10:12:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 613E2B80EF6
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 18:12:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 600EDC433D2;
        Mon, 19 Dec 2022 18:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671473574;
        bh=GH25RH87mNKdioHeKsAH73kmYF5wHMloV7KqH1oW71g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cCRV6/wbIv9njTbzRpEx6DeJtbobFAfPw5PzAK0mllq97NeuOylnpQIjNlUiu8BIl
         suax3uk5BGGxxv5vovpGZuGjFTPL7LhQgMyzGqvis+XOwCfUOw9jYA8Bhmns2jUFcz
         shsinH4b0q2ahy+pMf0oPgRrqnFnUk/IJn5kmIW1Umko3hH2Ox4TrTPv90UmrYcCOG
         IWHvSzbw4HuIJzI4N/oV130NSh7vG6mC9gvz2vqZBXl6Q56tcQbyyzxsiTlaGJFOtk
         RUtzJ5rfQu+e7EeL/hMy83JKRhzWTrezsSXVSpMfIts+FA1Rvj2yAC77kemXHGgY52
         90+DCqrWy5VxA==
Date:   Mon, 19 Dec 2022 18:12:49 +0000
From:   Mark Brown <broonie@kernel.org>
To:     "David.Rau.opensource" <David.Rau.opensource@dm.renesas.com>
Cc:     Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "support.opensource@diasemi.com" <support.opensource@diasemi.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] ASoC: da7213: Add support for mono, set frame width
 to 32 when possible
Message-ID: <Y6CpoYfr6PPAH3j6@sirena.org.uk>
References: <20221214044058.6289-1-David.Rau.opensource@dm.renesas.com>
 <Y5nb7ik1cCKo+FlR@sirena.org.uk>
 <CAG+cZ07erTzV8Re-xo8GixpsEhK28Q6wHxQeE0co+sWgQAFgGA@mail.gmail.com>
 <Y5nkDEcgbZ2vNEsK@sirena.org.uk>
 <CAG+cZ06PHgrLebLESbitdkupYcyZ6twr4uv6iczNxp5ztox-EA@mail.gmail.com>
 <OS3PR01MB66410E087BED80930430F72FCDE59@OS3PR01MB6641.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KGYErxMmt0sA/TWp"
Content-Disposition: inline
In-Reply-To: <OS3PR01MB66410E087BED80930430F72FCDE59@OS3PR01MB6641.jpnprd01.prod.outlook.com>
X-Cookie: Pay toll ahead.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KGYErxMmt0sA/TWp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 19, 2022 at 03:52:52AM +0000, David.Rau.opensource wrote:

> Is there anything I should modify or correct to make this commit move forward?

This is a new feature and we're in the merge window so no new features
will be applied at the minute.  Please wait till after the merge window.

Please don't top post, reply in line with needed context.  This allows
readers to readily follow the flow of conversation and understand what
you are talking about and also helps ensure that everything in the
discussion is being addressed.

--KGYErxMmt0sA/TWp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmOgqaAACgkQJNaLcl1U
h9C04Af/elgB0NrS7iobGRds3fx/bh99V4jJtSwBOIJbyzkBeGnCXli7ajwfDzLm
HlOlFZym/N6VK8I6QQ1OGugu+4Ll5g0ujXsZP+mab9/FYHl4k4bu3BW1wmWUDtrE
vfbMmNxxmTbfzhYf4xhWiieUM2o3XXw6zxDoNC092+eKANYL7I1fWN3ii6uw7Zq0
jWZLyiBcxxpsyL4FojJippFCuEsOrP5HZrL53pQdpTW1o6plTLqdkkVC33nrgYtN
toBdY3OsHaUa+VHCV1/Ld27qYGaGwNE0Rbly88oQuI1BkmWi7wYmU0asDNnfAi3b
IZ2Tx5C89ZKVn7Pf5CQvQUpgNeXkZQ==
=u0u7
-----END PGP SIGNATURE-----

--KGYErxMmt0sA/TWp--

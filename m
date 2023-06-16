Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6B8F7331E1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 15:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241496AbjFPNL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 09:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbjFPNLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 09:11:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6212B2D76
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 06:11:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DFE0361EDA
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 13:11:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD43EC433C0;
        Fri, 16 Jun 2023 13:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686921082;
        bh=FTuRXBNohO45rMiPyoIYO48Ylh1Ptzvi5SpYn3NypsQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CB73x15hvt8hIP5meiZF+l9hXcaDBv9N/eduItGu/B3s5vBsGZ7fXhmwHo2YNaygC
         joxDJGVKE9HMnoabLE0Xr5AKSj4YKRLdVMu/xDHYBP9Wra6v2JmyCktHrBKcUuuvH2
         KdoSC3xM2aD5Bxzh5nX/dTIxBLK2B/chvABpYvTeQdmSWyBSh2CX4uPG+MfKP9oeDN
         ED0wh60d3txIns6TQqq87owmpVBxxU/4X3dMNHZ49WuTXmeU3h/p03dduk6T9eB1DL
         sO0XwPAqb1FBl0/gdazc6bxE2LUSzkPqjVgH4bAk1puusau4jbTZ0fuyNJoV4jpVUK
         UlFFi1H9dVGDQ==
Date:   Fri, 16 Jun 2023 14:11:15 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "kondaveeti, Arungopal" <arungopal.kondaveeti@amd.com>
Cc:     alsa-devel@alsa-project.org, vsujithkumar.reddy@amd.com,
        Vijendar.Mukunda@amd.com, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, syed.sabakareem@amd.com,
        mastan.katragadda@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: amd: correct pm_runtime enable sequence
Message-ID: <93cf47c7-612b-49b3-a2f7-d36525fce3ed@sirena.org.uk>
References: <20230614003206.933147-1-arungopal.kondaveeti@amd.com>
 <317a0f1b-94a7-4bd4-9f64-8877e0552b6a@sirena.org.uk>
 <f140ae96-a1fd-e636-2b8b-d453fba5c6e2@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="72HbZWp3mGiv0SB9"
Content-Disposition: inline
In-Reply-To: <f140ae96-a1fd-e636-2b8b-d453fba5c6e2@amd.com>
X-Cookie: P-K4
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--72HbZWp3mGiv0SB9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 16, 2023 at 06:28:29PM +0530, kondaveeti, Arungopal wrote:
> On 6/13/2023 7:39 PM, Mark Brown wrote:
> > On Wed, Jun 14, 2023 at 06:01:59AM +0530, Arun Gopal Kondaveeti wrote:

> > > Replace pm_runtime_allow() with pm_runtime_mark_last_busy()
> > > & pm_runtime_set_active() in pm_runtime enable sequence for
> > > dma drivers.

> > This says what the change does but it doesn't say why the old sequence
> > was a problem and the new one is better.

> pm_runtime_allow is not needed for child platform drivers .

If it's not needed that explains the removal but not the addition of
set_active()...  This information should be in the changelog.

--72HbZWp3mGiv0SB9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSMX3IACgkQJNaLcl1U
h9CnEwf+JeH9RoCEYgqnX6cXKDXe2pqFDengQuJevXhgy15ppkveBy0lMiqvrK8l
EdVKlGxZqMreEllTGa57XFh6o4fSLtFm6kpkz7xD2ufvhdzEgCDPxJHdkYy4Gz3p
Yz2odof1rL7+YPvhuyy8zAnovD/T5h1b5NLu2scMAbH0dIXKegIqy3b9W86698R+
4WQaEO3O6cdAa7B9jDdHeLiGU5LUDHGWHMQ4Q/L5mwUxqDQwW/SnLnuDDY4X2Ca4
ayrLFLe70Hw0ug/bX7reDbhjgUzZx+4e8KCOCMdQA+b0itHd0TDTyREuKHprB1gm
3qGhl5fg/T3JXgN0FDrRIJqksDAeBA==
=jY3O
-----END PGP SIGNATURE-----

--72HbZWp3mGiv0SB9--

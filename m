Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78606674C6C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 06:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbjATFdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 00:33:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjATFdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 00:33:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B4C97AF29;
        Thu, 19 Jan 2023 21:28:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AD2E5B82166;
        Thu, 19 Jan 2023 11:13:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CBD5C433EF;
        Thu, 19 Jan 2023 11:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674126804;
        bh=JrptjghR/Vgs9p8nXxLUoLdJdd6g9EnHtJeS1PFHDQY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=geqj6wRL4wK3/d1U1EN9IXiI1dDG/mMPJ/4P37Z7uTpqkAJwP+h9wRIDNAHQ2ebiE
         R7hOeFahUu56mK1wEThpL2qqeohi8ML/F9VXlDnHM7DNF2jm3EcS3Qw8iv05BEuVFq
         6h6xkiemkCfCJ9cGFev9YqIGHun7NLU1JPFu32S9MzmAMG6NCam2zWXYPfXGnJtynf
         ZXy+VRtLeP5XlXv4SdPVv1qsZMC3gsMX3UdN/OmQVnWk0FeJ0HrGWdCNednsfxvsZ6
         STS4sYlbgoYL8OUIvJKyVkxFzS9InI8sWBtHevkl6H+lu4eIYe9BgFa3Dw0Amydnl1
         rkDeNW/VInIOA==
Date:   Thu, 19 Jan 2023 11:13:21 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Arnd Bergmann <arnd@kernel.org>, Tony Lindgren <tony@atomide.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jerome Neanne <jneanne@baylibre.com>,
        Axel Lin <axel.lin@ingics.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] regulator: tps65219: fix Wextra warning
Message-ID: <Y8kl0YZwMO3nkaly@sirena.org.uk>
References: <20221215164140.821796-1-arnd@kernel.org>
 <Y5tPyOqSNud7LumS@sirena.org.uk>
 <67efe55d-e5cd-46c1-97e4-c9f3a5884a07@app.fastmail.com>
 <b1f98c2a-3087-464e-b9fb-97e7c78cfdab@app.fastmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+SIVaY/fvl0fQGyk"
Content-Disposition: inline
In-Reply-To: <b1f98c2a-3087-464e-b9fb-97e7c78cfdab@app.fastmail.com>
X-Cookie: Serving suggestion.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+SIVaY/fvl0fQGyk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 19, 2023 at 09:07:38AM +0100, Arnd Bergmann wrote:

> It looks like you merged another workaround from Randy Dunlap now as
> commit 2bbba115c3c9 ("regulator: tps65219: use IS_ERR() to detect an error
> pointer"), but I think that one is just as wrong as the one I submitted:
> the 'rdev' variable still remains uninitialized, and checking its value
> after it has already been used is not helpful.

Right, that's just changing the way the result is parsed, it's
nothing to do with making sure things are initialised.  It's just
a coccinelle style thing.

--+SIVaY/fvl0fQGyk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPJJc4ACgkQJNaLcl1U
h9C6Lgf+MGdWjcr2w5o/s6+Tn+hU9fEAEBbvKquANNH4PIWfbHai88bpEJ3h4P+o
D9KYDMRcpJzIkxIvj7f+6tLcFdB7EK1gUFmb919cyQhW5UiZmtNaDAiJNuQLFbzy
sx6iJcNAa+TvRFm0zotZ3souT3RPV+cIjSGKqT8cy4r8g3XWH2fQVyRvAUeg3WCw
pldKcYZQJrVAAolIUHHMQsT82DwAmOcwogYJGps3PhPNTmAlRZZayqjs1lwuPHja
5JkfzsLpfjWWMFoKnFEavbvM9JUlLN1z02LDLeSSSIEVJXqoDSoYXBvJY9eM4l3a
5BIusGAZA/CZcSRFhvCG/P74ttEfMQ==
=+7Er
-----END PGP SIGNATURE-----

--+SIVaY/fvl0fQGyk--

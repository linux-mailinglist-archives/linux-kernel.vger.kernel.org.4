Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81392722CAB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 18:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235018AbjFEQbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 12:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234705AbjFEQb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 12:31:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92EE01986
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 09:30:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C71F6281F
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 16:30:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7DA1C433D2;
        Mon,  5 Jun 2023 16:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685982640;
        bh=zmUdV5+DbT4iJZZY8IEQBwtRHJ1OlON8/d8bhShBTOc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GOwyuqdRAfhRpJtPJQ2SY3IGClTDZm4jeDGm54/cznaNUMV8hBDFVbCKrdtBOZsK4
         mWqWqkpjTW2GxWueCbKJF/FiejoioN4aIH8vMv0A6Lg1oBFF7VzjWLNl+WBKA0ileL
         l4SiG4A/N52bxk3JB15DQte/oNvjjN+GOtcFonms1QYgVMLGjy+KSWCHe2Oj0q4kl3
         cDQye+zuNCArifyw5/GpfstUX0dwTrui+EqeVXo5aoaqf/QyONUYGIwnUdSpEv91xC
         +ZmPkwE73uOWq00qlTWTF9FzVJ/7NdpesX2Hgg66hk9/IPsKbGx4QteE6Y9FNBRrKC
         g6LTnl+J2LILA==
Date:   Mon, 5 Jun 2023 17:30:36 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Raag Jadav <raagjadav@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] regulator: act8945a: rely on hardware for operating
 mode
Message-ID: <42423085-2c9c-47f6-9588-3e2260da7cfa@sirena.org.uk>
References: <20230605104830.68552-1-raagjadav@gmail.com>
 <04b8fa24-e5a8-4871-a397-f1c0c886449a@sirena.org.uk>
 <20230605143103.GA3068@pc>
 <545d3463-ce56-41d5-9d95-55764c448c09@sirena.org.uk>
 <20230605161614.GA6548@pc>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ta/L7bqgTyAkmc7L"
Content-Disposition: inline
In-Reply-To: <20230605161614.GA6548@pc>
X-Cookie: Biggest security gap -- an open mouth.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ta/L7bqgTyAkmc7L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 05, 2023 at 09:46:14PM +0530, Raag Jadav wrote:
> On Mon, Jun 05, 2023 at 03:44:37PM +0100, Mark Brown wrote:

> > It's also removing a cache so we need to talk to the hardware more often
> > which doesn't seem like a win.  If there's a bootstapping problem then
> > shouldn't we just read once at startup?  If there's no problem what's
> > the advantage?

> Well, there could be cases of access which are done
> outside of driver context or hardware failure,
> which are not really ideal but I've faced such problems
> a while back, so just decided to share it.

If we have those then we've got a bigger problem, for example we might
switch to a lower power mode which can't support the load we're trying
to get the consumer to run.

--ta/L7bqgTyAkmc7L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmR+DasACgkQJNaLcl1U
h9CiVQf+MCLoW1uOnH3HZnmYm6sDQZqHffX6VZuxNNzqsy/lS5QembRR5GIZqxGb
uN0V+FIrmBY7GqfUJLC3yetRucrJVN4q/qQJ9x4pl4TgV8oa9bRrqIrLTXfdUBBm
E85fghfmdtQnjCs1b/Cw4GyWbfWnylm0ywiqwolH/SmBk9VjlcLqev/8Kg9Os1UW
9kWfksJvyImh+FDAzR0fDwwKwYuojbGLpAm4HTw3UebNBj5hcEuJbe6n7/42R/79
KUTajn2c19FbHN+eaNrtt3dyY/kbmBeSmQUSHxj8NueFn3gl+Np+pAVuWBSGfwf5
/g80p0gfF2Bmtti9T+HPtVIcycds/g==
=0lfS
-----END PGP SIGNATURE-----

--ta/L7bqgTyAkmc7L--

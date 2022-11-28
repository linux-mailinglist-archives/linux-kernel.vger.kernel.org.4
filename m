Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5378263B17D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 19:39:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbiK1SjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 13:39:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbiK1SjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 13:39:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2054BE94
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 10:39:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CAF42B80EE1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 18:38:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EE68C433D6;
        Mon, 28 Nov 2022 18:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669660738;
        bh=2KxKrqf3Zing11kl1U7+PTXDvSYhu2dejgXbAZj5QkU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CXLpLYEsS0vLavcFL/olUh02dV+QtmFoDkP4NjrVt08UVytd5IZF3vTDWmlX0mKff
         K9ijnmzqS5jh3Xw08aKp7NhMIBEXj3pMQ2k+B3XYh0BkShDAWO8B/N6eQJlNeJ/1pC
         JdAwFALCyrsuzKjp4NVFfAtV+zrMnXTTtryeWv8gra4Y47yHWzDw1nSoj+9oC/T43I
         WpMF7UaExeXShQPViylY49XWzYXgL9Z+rXvyYiEfg5vVTiaeUYVtXqTMkACxd/9ZrA
         QJYdMejp7VRul1H01B7vNCkihaNhSov/pp9kwkDHiYSh4gC3EhBzpByKuWmVZhDCJR
         59Pnf5xScb9aw==
Date:   Mon, 28 Nov 2022 18:38:54 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] regmap: cache: downgrade log level for no cache
 defaults message
Message-ID: <Y4UAPmbQsnqLMDVf@sirena.org.uk>
References: <20220921071054.3132504-1-alexander.stein@ew.tq-group.com>
 <Y4EX7DLt/Lvde/SJ@sirena.org.uk>
 <3208991.44csPzL39Z@steina-w>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uROZqsaJMWnwrz+5"
Content-Disposition: inline
In-Reply-To: <3208991.44csPzL39Z@steina-w>
X-Cookie: In the next world, you're on your own.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uROZqsaJMWnwrz+5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 28, 2022 at 03:58:40PM +0100, Alexander Stein wrote:
> Am Freitag, 25. November 2022, 20:30:52 CET schrieb Mark Brown:

> > In this case if you can't use a rbtree cache I would recommend
> > bootstrapping by initially reading without a cache first to get the
> > default values, then replacing the regmap with one that uses the
> > defaults you just read.  You'll need some care over suspend/resume
> > though.

> The driver I'm working on clk-renesas-pcie.c only has 8 registers, so the=
re is=20
> no benefit to use a different cache than REGCACHE_FLAT.

There's a benefit when it comes to bootstrapping (though also a slight
performance cost, and non-atomicity).

> But I currently fail to see why this is only for non-sparse caches. This =
is=20
> printed even before the cache_ops init() is called.

We only go into hw_init() in the case where the map has specified
num_reg_defaults_raw, as you say you could trigger that for any cache
type but if you're using a sparse cache you're either going to provide
no defaults or provide defaults in the standard, sparse format rather
than the raw format so in practice it won't trigger.

> Before the call to regcache_hw_init() there is this comment:
> > /* Some devices such as PMICs don't have cache defaults,
> >  * we cope with this by reading back the HW registers and
> >  * crafting the cache defaults by hand.
> >  */

> This is exactly what I want to do: Read back HW registers and create a ca=
che.
> Actually regcache_hw_init() is exactly doing what you are suggesting:
> 1. reading HW registers into map->reg_defaults_raw
> 2.
>  a) copy them into map->reg_defaults
>  b) read HW register individually if 1. failed

The other thing with doing a readback to fill the cache is that it's a
potentially slow operation (depending on how big the cache is and the
bus in use) and also a potentially destructive one for things like clear
on read registers.  If regmaps are doing this deliberately (which does
seem valid) we probably want a clearer mechanism for specifying it - I
think an explicit flag would do the trick.

--uROZqsaJMWnwrz+5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmOFAD0ACgkQJNaLcl1U
h9CCcAgAg9MYeYEhv3anXGxfBLh8IWj3lEDfBv8M+MAgyrrXXh3SqTRIlzeU/8HG
CS3RUPay8KUP6xxPpL931+se/c2bQQI2evl0TFAASAtf3iPHSgFeMeXmoBh/kN0m
aBM76554n2mppISIykgUdQd1FloLRDBxWjkX9dyazDw9tClga1dJFxFa+my7PRgF
CM9YQNEIVOaXHLVdO8t5WGXZ83mA5FKxn1eP8WzcBNyEEKrhmS8RD33PbQIOOIGa
DErlabr0SOJmURIBjUwYHrIY43gG9VgBR3oJhajJElhlHbzG+L6BAl8xcvQSnEjB
MlDdm8vetn+SeQR2kRhiPzS2ZtO0aA==
=8Qqz
-----END PGP SIGNATURE-----

--uROZqsaJMWnwrz+5--

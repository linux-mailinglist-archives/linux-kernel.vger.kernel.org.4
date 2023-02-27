Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA766A426F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 14:18:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjB0NS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 08:18:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjB0NS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 08:18:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528D715CA7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 05:18:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 14B6AB80C95
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 13:18:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81091C4339C;
        Mon, 27 Feb 2023 13:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677503902;
        bh=CDhuW7QDNLA6JLvIVxDhgYfgxT0x9vTLa1YeUHVjBrY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cuu+YVFva4h0BP/qJOUfMYHXoIqDM2HxQHHhd1yUhfga+7SaVeZlWe85X7G3gzpBq
         Hv7QootJvOEbh/KVEvzqdtkaeao190Jy7LKay+rVo5I8Yk/AK44pgx54sOCkGo3I14
         1PPrbmzD0g9GSDQwpV+iXgYoIn56CkKP26N1vXueudv5VWEne6VKUJKblmJZ7Dogq8
         TuEym53MmBn3zIbr3CQLfdsjltc4iKYreQk8wu1VTbucHUvz/RyyDiXNAB3KEvqiFJ
         o2Vo8grnFheVlcHZhxUYxV/xvbILC6DGWPjo9VfeYcbma7sYrmid775845dyWZBjGu
         vYdtPjB95Q61Q==
Date:   Mon, 27 Feb 2023 13:18:18 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Sascha Hauer <sha@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
Subject: Re: About regulator error events
Message-ID: <Y/ytmh9QrXN9Tw17@sirena.org.uk>
References: <20230227130542.GM32097@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qb9y2E/9/0TA1vTZ"
Content-Disposition: inline
In-Reply-To: <20230227130542.GM32097@pengutronix.de>
X-Cookie: On the eighth day, God created FORTRAN.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qb9y2E/9/0TA1vTZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 27, 2023 at 02:05:42PM +0100, Sascha Hauer wrote:

> The strategy I had in mind was to disable the regulator, enable it again
> to see if the errors persists and if it does, permanently disable the
> device.  Disabling the regulator only works though when there's only one
> consumer.  With multiple consumers only the enable count decreases, but

Might also be a good idea to turn off any other supplies to the device
as well but yes.

> A first good step might be to notify the user somehow. While we can get
> the overcurrent status of a regulator from
> /sys/class/regulator/*/over_current there doesn't seem to be any way to
> get a regulator event in userspace, right?  Would patches changing that
> be welcomed?

Sure.

> There doesn't seem to be much prior art for handling regulator error
> events in the kernel. It would be great to get some input what others do
> in this situation, or to get some ideas what they would do if they had
> the time to do so ;)

The general issue is that if the regulators get upset enough to start
complaining something has generally gone really badly wrong and there
isn't anything constructive that can be done other than logging.  You
might potentially want to power off the system as a whole or something
too.  I do think any big actions are going to be userspace policy
things.

--qb9y2E/9/0TA1vTZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmP8rZkACgkQJNaLcl1U
h9DeFQgAhPYK3DRv220gpQLpEwPGJieeofQ5tB1x3GYHBxmXMD1RjkTj5ZEDvPSt
/kKbAQFaTW4A9VXeklarIjF0BLHnf7q62/MkVl2B9nG7dV+w9iCj/Qudu8LcZPQt
DTEHPcTszELqYhNBWHZv3P15kl73J+lg/vLht0JmoT8eHbkRINBzDdsMINAWmY6T
jMQreKbWuZRon2yYZhQczWOrqrOnyYJ0NR17QeIn5Wckc0z2GjWxFWHVlioYxjGV
dmCs8SOTXNlUKk5n32LgTVS9jhnIQxPCv2xGlUa+ccgl+9dQdcPs3JJQnIpmMo9f
454kxniD7Iym92bkfdArBiM2kWzFhA==
=GTmk
-----END PGP SIGNATURE-----

--qb9y2E/9/0TA1vTZ--

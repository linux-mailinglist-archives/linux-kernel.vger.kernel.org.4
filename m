Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9417E6601D5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 15:13:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235011AbjAFONh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 09:13:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbjAFONf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 09:13:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5199277D36;
        Fri,  6 Jan 2023 06:13:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB4B06164F;
        Fri,  6 Jan 2023 14:13:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D72BC433D2;
        Fri,  6 Jan 2023 14:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673014414;
        bh=EvgeiMEksqyIUm/FI4vt5rIz7p/gmD7TtQdDbeVnY7U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rvbf9V1GvTNjFwspNomILjaPgJSVQpuuKl4BTMGerMqahBqYfKawcURDbKCSnfuqy
         my/Ebqru13J1Y5+EE01bWEBtmsaPEppqv/JG3drzuAlyEQXX6/yQu16zSAOwuNf4D5
         GbiIUXCOvCne8yGQDaqfH/mzIrHItC4zA2xlkhsaZ05xkAngC+M51lSkOjEqcddZr2
         3jmHx+UjdDE/OzRv1VubXKXpeyTJb6lT4Uiwqo7sCuRVDApbdASCzrmRY04DpR8gtH
         RpSPREEJaTvzuO9ZLmQ4P7MjX0+8KkOW4z4JQmvvl9dzmENfryQ93MbnZ2ihkCUTXC
         PY7QlkLs7sszg==
Date:   Fri, 6 Jan 2023 14:13:29 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2 1/2] spi: spidev: fix a race condition when accessing
 spidev->spi
Message-ID: <Y7gsiW6lAsz/krsV@sirena.org.uk>
References: <20230106100719.196243-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VI4bnjj3fr5nrV29"
Content-Disposition: inline
In-Reply-To: <20230106100719.196243-1-brgl@bgdev.pl>
X-Cookie: Do not fold, spindle or mutilate.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VI4bnjj3fr5nrV29
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 06, 2023 at 11:07:18AM +0100, Bartosz Golaszewski wrote:

> - use a mutex instead of an RW semaphore (but for the record: I believe that
>   the semaphore is the better solution here)

Why?  Like I said in my original reply I'm not clear what the extra
complication is buying us.

--VI4bnjj3fr5nrV29
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmO4LIkACgkQJNaLcl1U
h9Bf+Qf/cmN+eSdQ4r6oxBzEjKUvx4IbbsGGBa2ejQGhDTkO0YyZX8Mkd2bajdMj
IktlRRXgGhB4Vbys7+vdZ8Vpw6GwyM77vIdEFu0DK2vhR0nUYux3Bg/6rKVGFrZs
5QXMvzeG1AGCj921JwQ48Ld02QrA8ni9HLpTvXaFydMeNCw+GatGGsxm8BhoV7vF
LCKzKU2LRL53hbFvLXBQQRmjoa4QzyC8hV6mTHKUR0kjQJ8KzYAwOUyXqbHgFdiR
wzWlxQvGuBkAdXUarhHd8xKYeZjTIalP7+EdQFi4n7PB0dHkOlrdDLkrVW1IHCTj
enLu/jJFav+wDuaO2Lz/sE3qx6rwig==
=M5HA
-----END PGP SIGNATURE-----

--VI4bnjj3fr5nrV29--

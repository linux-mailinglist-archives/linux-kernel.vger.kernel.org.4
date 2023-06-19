Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10DE8735D26
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 19:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjFSRnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 13:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjFSRnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 13:43:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B80198;
        Mon, 19 Jun 2023 10:43:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B66460DFE;
        Mon, 19 Jun 2023 17:43:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6DB4C433C8;
        Mon, 19 Jun 2023 17:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687196601;
        bh=QmULr4A39ToJDl2Z3lOKq1ZRZqqnqgEluIJ5NuB7Z6Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZfKHzdPGyASgwbmQvZzlQoE/GAiW9t9nBDzvEdT1+k5O8zErlPig2Vnypq6gZQapi
         0nlH6ntJe8A6ifan6Lre5qrYlTLlO7lCchWRSde5wJfFqbFzPuyOU7ASyM4LV5yUPw
         0C0EDMuGAMpH2XfkijDPdI+0+QmQX+OahUfP0AyLuv3hdQ/ULL9KoBw7NWf+hcNO55
         btPwXRLGupYXyxhISKBzlNHVFdzHF801qBbLtIlS5pm3gQ03l+BfszbFWgc8rhrQnf
         D7Vk9KYwmsIrFMLhLhlvW65X1yh5caGuRQG2jYqa83MDN/Xhql21D0t+7QrAR1xtbb
         BUhykkEvt33/Q==
Date:   Mon, 19 Jun 2023 18:43:14 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, David Lin <CTLIN0@nuvoton.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, Antti Palosaari <crope@iki.fi>,
        Sergey Kozlov <serjk@netup.ru>, Abylay Ospan <aospan@netup.ru>,
        Yasunari Takiguchi <Yasunari.Takiguchi@sony.com>,
        Michael Krufky <mkrufky@linuxtv.org>,
        Matthias Schwarzott <zzam@gentoo.org>,
        Akihiro Tsukada <tskd08@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH v1 4/4] ASoC: nau8825: Replace copied'n'pasted intlog10()
Message-ID: <060954c0-3435-4e7b-b705-4a2484f59581@sirena.org.uk>
References: <20230619172019.21457-1-andriy.shevchenko@linux.intel.com>
 <20230619172019.21457-5-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Em2WtDmrif0Q+GHr"
Content-Disposition: inline
In-Reply-To: <20230619172019.21457-5-andriy.shevchenko@linux.intel.com>
X-Cookie: Prevent forest fires.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Em2WtDmrif0Q+GHr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 19, 2023 at 08:20:19PM +0300, Andy Shevchenko wrote:
> As the code even references to dvb_math.c, which is now available
> as int_log.c, replace its content by the calling respective API.

Acked-by: Mark Brown <broonie@kernel.org>

--Em2WtDmrif0Q+GHr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSQk7IACgkQJNaLcl1U
h9BEEQf+NR9HrzFdL3tpgECwfvwclK/PpGqn0e1EHp3uUhFELXJ5ln8miBpEcG5W
Lfgd7DHDBQbeFeDupp6gLeK9ktbISgxUG7xqtI9sX/5HDppLQYif9bo66XUMpr0M
2aQskN0wmvQU9H+6BORN8WpmpOWIOyot3XYe7Ie7WEUGmaM6zasYsDJ834mm6HtU
swSsAHSqpMvKtfXOm1wGhVKNzbY3unDFX6i989Icc93DL4mfNVpz/trOCPYHUcEf
7Tv6DxKAZbi091unxVHkcAlYgQPTZvRZ04hxwsMGeEnp5d306BAkZHqI9l7z8IvL
45evpQ2IMAe1zMkbzQAFUCvth/F0Mg==
=4IxJ
-----END PGP SIGNATURE-----

--Em2WtDmrif0Q+GHr--

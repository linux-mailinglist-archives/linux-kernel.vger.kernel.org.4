Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9418A72AE58
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 21:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbjFJTYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 15:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjFJTYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 15:24:00 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4583270B;
        Sat, 10 Jun 2023 12:23:49 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 307FF1C0EB8; Sat, 10 Jun 2023 21:23:48 +0200 (CEST)
Date:   Sat, 10 Jun 2023 21:23:47 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de,
        Thomas Gleixner <tglx@linutronix.de>,
        Ido Schimmel <idosch@nvidia.com>
Subject: Re: [PATCH 5.15 000/159] 5.15.116-rc1 review
Message-ID: <ZITNw9cv/WoZcSaO@duo.ucw.cz>
References: <20230607200903.652580797@linuxfoundation.org>
 <b979807a-a437-4d3f-98f9-989da52abb30@roeck-us.net>
 <d35b1ff1-e198-481c-b1be-9e22445efe06@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="R7QnfhQzEFI8g4qW"
Content-Disposition: inline
In-Reply-To: <d35b1ff1-e198-481c-b1be-9e22445efe06@roeck-us.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--R7QnfhQzEFI8g4qW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Build results:
> > 	total: 155 pass: 155 fail: 0
> > Qemu test results:
> > 	total: 499 pass: 498 fail: 1
> > Failed tests:
> > 	arm:kudo-bmc:multi_v7_defconfig:npcm:usb0.1:nuvoton-npcm730-kudo:rootfs
> >=20
> > The test failure is spurious and not new. I observe it randomly on
> > multi_v7_defconfig builds, primarily on npcm platforms. There is no err=
or
> > message, just a stalled boot. I have been trying to bisect for a while,
> > but I have not been successful so far. No immediate concern; I just wan=
ted
> > to mention it in case someone else hits the same or a similar problem.
> >=20
>=20
> I managed to revise my bisect script sufficiently enough to get reliable
> results. It looks like the culprit is commit 503e554782c9 (" debugobject:
> Ensure pool refill (again)"); see bisect log below. Bisect on four
> different systems all have the same result. After reverting this patch,
> I do not see the problem anymore (again, confirmed on four different
> systems). If anyone has an idea how to debug this, please let me know.
> I'll be happy to give it a try.

You may want to comment out debug_objects_fill_pool() in
debug_object_activate or debug_object_assert_init to see which one is
causing the failure...

CONFIG_PREEMPT_RT is disabled for you, right? (Should 5.15 even have
that option?)

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--R7QnfhQzEFI8g4qW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZITNwwAKCRAw5/Bqldv6
8gMQAKCninpq2IbLx5zozdVkDJvbs6AMzgCgnaBEzhZym15ISXWB1LFhT8v8jR4=
=Mu2c
-----END PGP SIGNATURE-----

--R7QnfhQzEFI8g4qW--

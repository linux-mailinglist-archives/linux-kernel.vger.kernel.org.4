Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A82FA6EFB4B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 21:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232615AbjDZTrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 15:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjDZTrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 15:47:06 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 873621FD3;
        Wed, 26 Apr 2023 12:47:04 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id C748E1C0AAC; Wed, 26 Apr 2023 21:47:02 +0200 (CEST)
Date:   Wed, 26 Apr 2023 21:47:02 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, stable@vger.kernel.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 4.19 00/29] 4.19.282-rc1 review
Message-ID: <ZEl/trjF1Ic76/Ye@duo.ucw.cz>
References: <20230424131121.155649464@linuxfoundation.org>
 <CA+G9fYstB_fROK9LHYuQ8dc2ArieGGAW_x69eEX-eAi5xMeE3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="OWk6w+3ksRt9gcp3"
Content-Disposition: inline
In-Reply-To: <CA+G9fYstB_fROK9LHYuQ8dc2ArieGGAW_x69eEX-eAi5xMeE3Q@mail.gmail.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NEUTRAL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OWk6w+3ksRt9gcp3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

This should be show stopper, actually:

> FYI, This is not a show stopper but worth reporting.


> NOTE:
> Following kernel warning notices on stable rc  4.19.282-rc1 from the
> previous releases 4.19.279-rc1 noticed on arm64, i386 and x86_64. After
> this kernel warning the system is still stable and up and running.
>=20
> This kernel is built with kselftest ftrace merge configs with all
> required Kconfigs.
>=20
> [    0.000000] Linux version 4.19.279-rc1 (tuxmake@tuxmake) (gcc
> version 11.3.0 (Debian 11.3.0-11)) #1 SMP @1679324856
> ...
> [    0.145911] ftrace: allocating 48590 entries in 190 pages
> ...
>=20
> [    2.880223] WARNING: CPU: 0 PID: 0 at
> include/trace/events/lock.h:13 lock_acquire+0x142/0x150
> [    2.881454] WARNING: CPU: 1 PID: 0 at
> include/trace/events/lock.h:58 lock_release+0x1af/0x280

This indicates locking problem somewhere in cpuidle / ftrace.

I skimmed the patches, and I do not see anything obvious there. Is
there chance to do a bisection?

Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--OWk6w+3ksRt9gcp3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZEl/tgAKCRAw5/Bqldv6
8hTCAKCghHkeqrkyD6ZQHjmVWa/tdORG0ACgj5XcrDhQ6VmVOjUgYwVE11PddDk=
=FNqj
-----END PGP SIGNATURE-----

--OWk6w+3ksRt9gcp3--

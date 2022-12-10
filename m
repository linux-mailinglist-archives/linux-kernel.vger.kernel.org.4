Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F36FA648C96
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 03:56:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbiLJCz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 21:55:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiLJCz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 21:55:56 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D8976B993
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 18:55:54 -0800 (PST)
Received: from mercury (unknown [185.209.196.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2E38E6602C07;
        Sat, 10 Dec 2022 02:55:52 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1670640952;
        bh=pc9ownLqt5nvKyk0gYczobM7ByjbrrdJLaohK5dDmcc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XGYmB5sbkutyb0HVIjM7GBjskszc+rNmX/3mIvhPIhaPuJA0gsv7M7jr2evxKHzWo
         cg3qM1FgIu6JOoN+2gfIXIJZE1Q9LvAf8aXJ5GSFvVWuc8U1PHN+VIrCgE9exf/FQj
         ZvH6EYFTPRo063z+ZHA7TlKQ3MP7KdQTmq5s2YbeuDmthURQjzXPR5D2vY6HHQ6bya
         5yUCwps7fxA01RrqRjQWeoU2Lg0Mzs2cdrcuEhtOmCZgSGloAO3VRJQchUXAJB26kE
         Rzquk+iyWn29iwSA/wzPZnLPyB7w1y1z7gDj/nMVB+FXzQH9OMglOJ9wUpbTollVD2
         By4YsjdwUldtg==
Received: by mercury (Postfix, from userid 1000)
        id 9B7941060F43; Sat, 10 Dec 2022 03:55:48 +0100 (CET)
Date:   Sat, 10 Dec 2022 03:55:48 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh@kernel.org>
Subject: Re: [RFC 1/1] ARM: Drop !ARCH_MULTIPLATFORM dependency from Cortex
 A8/9 erratas
Message-ID: <20221210025548.ssinevgkyjzf3622@mercury.elektranox.org>
References: <20221209182000.549179-1-sebastian.reichel@collabora.com>
 <Y5OCTseqVQ+AcMqm@shell.armlinux.org.uk>
 <b050a5b5-ca13-4ae2-baa3-41a3118e5e8a@app.fastmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lxi3meb7xp3kuwb6"
Content-Disposition: inline
In-Reply-To: <b050a5b5-ca13-4ae2-baa3-41a3118e5e8a@app.fastmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lxi3meb7xp3kuwb6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Dec 09, 2022 at 10:36:17PM +0100, Arnd Bergmann wrote:
> On Fri, Dec 9, 2022, at 19:45, Russell King (Oracle) wrote:
> > On Fri, Dec 09, 2022 at 07:20:00PM +0100, Sebastian Reichel wrote:
> >> All the erratas for more recent CPUs (Cortex A15/A12/A17) do not
> >> require !ARCH_MULTIPLATFORM, since there is runtime detection of
> >> effected CPUs in arch/arm/mm/proc-v7.S.
> >>=20
> >> Errata config options for the older Cortex A8/A9 CPUs have the
> >> !ARCH_MULTIPLATFORM dependency, but the CPUs are also runtime
> >> detected. Since there is runtime detection, it should be fine
> >> to enable the erratas for a multi platform kernel.
> >>=20
> >> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> >> ---
> >> For me the most likely explanation that this has not yet happened is
> >> me missing an important detail, so I sent it as RFC. If you point it
> >> out I will try to document the reason.
> >
> > IIRC, the reason these are marked with !ARCH_MULTIPLATFORM is for when
> > the kernel is running in the non-secure world - the accessed registers
> > may prevent platforms booting. However, it was a long time ago and I
> > don't remember clearly now.
>=20
> The git log confirms your memory, this is the description of
> commit 62e4d357aae0 ("ARM: 7609/1: disable errata work-arounds
> which access secure registers"):
>=20
>     In order to support secure and non-secure platforms in multi-platform
>     kernels, errata work-arounds that access secure only registers need to
>     be disabled. Make all the errata options that fit in this category
>     depend on !CONFIG_ARCH_MULTIPLATFORM.
>    =20
>     This will effectively remove the errata options as platforms are
>     converted over to multi-platform.
>    =20
>     Signed-off-by: Rob Herring <rob.herring@calxeda.com>
>     Acked-by: Tony Lindgren <tony@atomide.com>
>     Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
>=20
> As far as I understand, these are all boot time chicken bits that
> should already be set up by the boot loader before entering the
> kernel.=20

Ah, I should have spent more time in the git history instead of
trying to search the mailing list :( I will propose a patch adding
a sentence to the config option helptexts, so that one does not need
to go through the git history to understand the requirement and
correct solution:

This errata workaround requires access to secure registers and thus
is not available on multiplatform kernels. The workaround should be
applied by the bootloader instead.

> Sebastian, are you aware of any particular machines that ship
> without the workaround code in the bootloader or in secure world?

No. I'm investigating sporadic GPU hungs on i.MX6QP on a customer
device and just noticed a couple of erratas missing in the .config.
They might already be enabled in the bootloader (and otherwise
definitely can be enabled there).

Thanks for the fast feedback!

-- Sebastian

--lxi3meb7xp3kuwb6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmOT9TAACgkQ2O7X88g7
+ppiNA//arTKXNw4LBK1Wu93pe1pmtNlmDCX4maNOyTXxN048VgcmY61+irtpFxQ
rBFHj0FCwq3ZraMY8rYCFiceN4xFSOnZn5SEnPYvCWVkix1bqg2OYhkmt07lAxdh
L5vLSMYZHd/OqbT58DLT2xvFrVsN8w4oSKSFnUDlJM7g7l1o1Hy12/zzyYAzvs/w
WSic75C5CGUM+ahre1t3/pQkt4EqjPGkxGHfEGx7kTa31IwWxY0+1lfRHB0r0I9X
yRmV82v9PUyr9d3446igSfCL8POxxMYgcK9Bf1MFXbxpa8x/v+vVXteaCYRvm5KZ
04Ex4GPX0dXJQkMegG/px1XVoOCBjzMMeG2vCMBCata6AD022aW557LmC3ckWFFf
3/vFGKMw47naZp+b5Uc94QzSTL/8NI7PKuYfdQfR5B/T26kghAYSOfucVvftA6PS
+PmHfDd+B0UsEai+BhjMFvsNM9d+evAfJQK/KK5vNNsAf1fWy7TyAPVN0JiPlOia
KT7a3e5PYiuj0Yk8EeEzwwVjyiDG7NfqLhB2CO9bgLKN+tBl4N+H/G0AHqPeI+qA
XqoqLdUUAe0ddm2UWAFOsMCjufa99+zXL0ss94Lt4PYt5y2BSXnQaXfXHbS8g9XO
ipD0XK3ey2C/zOD6A8ZoD/okz1/b+p+qOX61xziXT0SfsAeZrJY=
=GDGJ
-----END PGP SIGNATURE-----

--lxi3meb7xp3kuwb6--

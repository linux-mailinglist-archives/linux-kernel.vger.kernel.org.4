Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6F866A574D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 11:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjB1K6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 05:58:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbjB1K5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 05:57:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31936302BB;
        Tue, 28 Feb 2023 02:57:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BD272B80DFF;
        Tue, 28 Feb 2023 10:57:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09B13C433D2;
        Tue, 28 Feb 2023 10:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677581825;
        bh=D2iUAMCdIQFGE46K3Uak4YjRzsHqOT4rcmVgoAEo6O0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jis5BtzV8MosCQobg4QszUhhb39t1rzLG0VGviohElDNqh5GoyP6KuZlWTCfq2LZi
         yU+/nWL8swju5Gps8ItiqQv7PW95MCbbIPxdtl171FLocmpo91MRZ8me+mxlnfBXfV
         /aZXQTaaOSiSq+1ILvwoLqn2u289yGlAsoXV9vKw7Fk3wSUjmX3PHyhrJbghKwJg4R
         BoouyN1uoY2l7HU+2iCPxkyCuXRVd8Cj5cVf1zjVNj728psroVqJOKCEviC1h7hYj+
         mELGCbLaGmvLGKdE2WCrLw1B+bMtdSgcXC9Ny8+lRs/fJCdcj1pf77ER4QUIqP35Jw
         xmdb2bmiIl84w==
Date:   Tue, 28 Feb 2023 11:57:02 +0100
From:   Wolfram Sang <wsa@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Lee Jones <lee@kernel.org>,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] driver core: bus: Handle early calls to bus_to_subsys()
Message-ID: <Y/3d/sfipoe130Hu@ninjato>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Lee Jones <lee@kernel.org>,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <0a92979f6e790737544638e8a4c19b0564e660a2.1676983596.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bf7Dv4zlfrDlY6f9"
Content-Disposition: inline
In-Reply-To: <0a92979f6e790737544638e8a4c19b0564e660a2.1676983596.git.geert+renesas@glider.be>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bf7Dv4zlfrDlY6f9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 21, 2023 at 01:53:51PM +0100, Geert Uytterhoeven wrote:
> When calling soc_device_match() from early_initcall(), bus_kset is still
> NULL, causing a crash:
>=20
>     Unable to handle kernel NULL pointer dereference at virtual address 0=
000000000000028
>     ...
>     Call trace:
>      __lock_acquire+0x530/0x20f0
>      lock_acquire.part.0+0xc8/0x210
>      lock_acquire+0x64/0x80
>      _raw_spin_lock+0x4c/0x60
>      bus_to_subsys+0x24/0xac
>      bus_for_each_dev+0x30/0xcc
>      soc_device_match+0x4c/0xe0
>      r8a7795_sysc_init+0x18/0x60
>      rcar_sysc_pd_init+0xb0/0x33c
>      do_one_initcall+0x128/0x2bc
>=20
> Before, bus_for_each_dev() handled this gracefully by checking that
> the back-pointer to the private structure was valid.
>=20
> Fix this by adding a NULL check for bus_kset to bus_to_subsys().
>=20
> Fixes: 83b9148df2c95e23 ("driver core: bus: bus iterator cleanups")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Current top-of-head doesn't boot my Salvator-XS board, this patch fixed
it.

Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--bf7Dv4zlfrDlY6f9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmP93foACgkQFA3kzBSg
KbYprA//bHXhMY/B10i601BEs44685UB6WrlQPpGni9zRW/aZNZlVx27QSSz/kCO
7dU5Ft6MN1nKPFbcFzEFn3OQOb4n5eWIV5L6ciAsPf55NS6zJ4gOdKzBFVkwA4QE
U645S92mrW7RTLyekaZC6XHeL1a3CQNuje//Gr2C4quOwrAxaUriJoSxZ6LeFzgU
hc/RUuNaa3O2fq+AQIuaPY9TRFwtzcW0pAvs9szV5YJv+pbL4KQwKc/xRgQhXMQ4
cB5eSwEom5UQJdicRX3ZlC1xtjPH2NIymT9Mn0meCV0O+btBjk1+nFYZq98XDmT2
ZpcerbD5HWjA8m6DFb7mr922SeAPwgNg3+NUqCr3cpbCi99sIraYihFNm/G2Oh2D
whZghWvYa5UgoIrZ8oqBXqIN2RSFf841Q4u68V2/OpdIiL71qaQ3bP54vbCMmwj9
HCRGz3rpX0tx8619JBsRW0SGqyHai6bz28yEQ7lql8zQkbWZa8LaKdxqBG4WOs3e
8q3PQGQIw53bxCc6r0U1rEG6YsHFiwMdDCntRA5Q7NVzWZGXXQ42wmHUmwRXiy0O
7SlOJkt8lZW5lnYDB8fbuyTRP4OPhIX4xRM0n4ob5fR2uC8m3r3bmVEy1WZUFsBD
+5qPk2upFcOi/42z9cqk19Dj/TFDAW3a5cXF36zCqTNP3pkTPXs=
=cSSB
-----END PGP SIGNATURE-----

--bf7Dv4zlfrDlY6f9--

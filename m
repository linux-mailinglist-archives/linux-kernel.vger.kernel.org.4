Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A79916D22B2
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 16:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232849AbjCaOb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 10:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232747AbjCaObx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 10:31:53 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C74B220625;
        Fri, 31 Mar 2023 07:31:13 -0700 (PDT)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id D4D9A4A28;
        Fri, 31 Mar 2023 16:30:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202211; t=1680273022;
        bh=kZL8+56e6lv/MMMqFC565eCb5So9E645Hgn/mf2GmaQ=;
        h=Date:From:Cc:Subject:From;
        b=P4iu4Sawnk9VTuEhTwtIDc8lh1rkP9olUGgxqiEq/8aFQcI9+njuFp8yIWxh661kx
         Tg2mBERMbmiOD4MZCOr1KiYufuqNae3nZKmMvH7poPckvSB4qWC676u/QqblwSj1/t
         UzB8ZQx4gGmVKGhxkRjk+ZBHyPuizi+2T3KJJROfc5jPmB/vOleG/g0FFMIEDUzPyQ
         ahy3d2Wd0r29Jji/slAHTi2EDdAUXW6Yf/kB8JbVflQqOXl8/NwBUy9FMryLjgWWnG
         UpeZE+3rueQ7yFA3QbCfXDzYL0Qf24Cr4K01+6y8x6gPCGO8aPYfagSUDPexWB27es
         PEK+KbCCtZRNw==
Date:   Fri, 31 Mar 2023 16:30:21 +0200
From:   Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        "open list:MODULE SUPPORT" <linux-modules@vger.kernel.org>,
        "open list:MODULE SUPPORT" <linux-kernel@vger.kernel.org>
Subject: [PATCH] KEYS: Make use of platform keyring for module signature
 verification
Message-ID: <qvgp2il2co4iyxkzxvcs4p2bpyilqsbfgcprtpfrsajwae2etc@3z2s2o52i3xg>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ethhinddwvgbvcoy"
Content-Disposition: inline
User-Agent: NeoMutt/20230322
X-Spam-Status: No, score=1.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,MISSING_HEADERS,PDS_RDNS_DYNAMIC_FP,
        RDNS_DYNAMIC,SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ethhinddwvgbvcoy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This allows a cert in DB to be used to sign modules,
in addition to certs in the MoK and built-in keyrings.

This key policy matches what's used for kexec.

Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---

Notes:
    Debian has carried an equivalent patch since 5.3.9-1:
      https://bugs.debian.org/935945
      https://bugs.debian.org/1030200
    in
      https://salsa.debian.org/kernel-team/linux/-/commit/0e65c8f3e316d6f0f=
c30f091dd47dba2ac616529
    and it appears the true origin is some version of
      https://gitlab.com/cki-project/kernel-ark/-/commit/b697ff5e26974fee8f=
cd31a1e221e9dd41515efc

 kernel/module/signing.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/kernel/module/signing.c b/kernel/module/signing.c
index a2ff4242e623..71d6248cf9ec 100644
--- a/kernel/module/signing.c
+++ b/kernel/module/signing.c
@@ -61,10 +61,16 @@ int mod_verify_sig(const void *mod, struct load_info *i=
nfo)
 	modlen -=3D sig_len + sizeof(ms);
 	info->len =3D modlen;
=20
-	return verify_pkcs7_signature(mod, modlen, mod + modlen, sig_len,
-				      VERIFY_USE_SECONDARY_KEYRING,
-				      VERIFYING_MODULE_SIGNATURE,
-				      NULL, NULL);
+	ret =3D verify_pkcs7_signature(mod, modlen, mod + modlen, sig_len,
+				     VERIFY_USE_SECONDARY_KEYRING,
+				     VERIFYING_MODULE_SIGNATURE,
+				     NULL, NULL);
+	if (ret =3D=3D -ENOKEY && IS_ENABLED(CONFIG_INTEGRITY_PLATFORM_KEYRING))
+		ret =3D verify_pkcs7_signature(mod, modlen, mod + modlen, sig_len,
+					     VERIFY_USE_PLATFORM_KEYRING,
+					     VERIFYING_MODULE_SIGNATURE,
+					     NULL, NULL);
+	return ret;
 }
=20
 int module_sig_check(struct load_info *info, int flags)
--=20
2.30.2

--ethhinddwvgbvcoy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmQm7nsACgkQvP0LAY0m
WPH7PxAAm7kjlMTNkXa7IuXBabuDCpGz7Bn5NTDpQlzhMQirVIK9yqnxMB4QKkTv
fz/N7zsuOrF2ikrk83d3d0siR+oeH8FjfRnfV0rItXLGndTTgoN0SjcYB0lMZfia
V40hSM+vWJ3Hqlza/KVr5+htvjnJLZh9DcNDGb/P1t71/31TH/9NZ8fn8XgxEgHD
5Pj0MCBum4ejEM1Pv13bfBauYn3hfQomD0qjDBwn3cEvFemdEZVyxvCgM8PO0lvp
8SHwIhOUyKCWiMRY2w36pjcawA33QD6rl8APqTAhj2PGJHOPywfz8iBMM05hSXdT
U40Ns0VYM1xSkJbQ7QEp2iWBM0DetqGeXs+Ttf6ANVwJpm4kZydY4rFNYMBkK9TG
AceDxM6iLIMFD2k435NOlIeRV+X3EmyIoyCmthNjQaxBK/Tp9j4eF118KiFpOmaM
M6Jc3O74yyxC7/8Oqn9Tk2/KePQDURxHt7lYFZDNJWcqPlLn3nXcpWENbmLnZi37
IbHCfOxie3avtNxC3xIHeGXaijEuD5DeI+DzwDfYL0nnfQv17qfIGR8miIwg5tjc
fV1+4tF6ZKNKRDA3/ahWnJCzwzPMJKTYRdqln1QQvVg4kRciypPG6emghc0JK2jz
2kQaGPk9m77rBK+RFcG6Xm7YiQsu6sniAlQ9xpPA0TKdTK7zhAw=
=0QOz
-----END PGP SIGNATURE-----

--ethhinddwvgbvcoy--

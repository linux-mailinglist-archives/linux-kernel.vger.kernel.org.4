Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 081B964AE26
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 04:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233973AbiLMDXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 22:23:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiLMDXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 22:23:01 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D6E315801;
        Mon, 12 Dec 2022 19:22:58 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NWP2T0QVfz4x1H;
        Tue, 13 Dec 2022 14:22:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1670901777;
        bh=4JD+J4S4csROrcVi8042P8Ob/bctBf6DCqQ9nNZXpRw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DRHSRbkAUSY5VHWxNDD+BGXNdXhUdGfXAUk+OJuYgyQsTZS1BZWXvJqZOh39dypqV
         z9IFLDO2SFoQeQW1u0s0J/OKx5O4n3F5cIfxPQwFti/U1sWrtgOcujsE8JwOjBevIi
         xL8vEvukMNpR+cpgAOt9UWLvgetS1mALGh3BBnW281BKZz79D916t7kDBVuObrsrsS
         doSBsBAc0LVmP2kOxyCBpV/84CsENPoAoBYMSmqCMURKGYKf6OJr6L5zHcwfsKEGm2
         mHpxRuo5taSkpwpjyjCPSR4ZtAIz1YqFnorDyoYgS5HsiNJcWTuIMhGEypvtp7cM/1
         OvpSIEp4QDC2w==
Date:   Tue, 13 Dec 2022 14:22:56 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        John Johansen <john.johansen@canonical.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Rae Moar <rmoar@google.com>
Subject: Re: linux-next: manual merge of the kunit-next tree with the
 apparmor tree
Message-ID: <20221213142256.3d3ee811@canb.auug.org.au>
In-Reply-To: <20221208135327.01364529@canb.auug.org.au>
References: <20221208135327.01364529@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Yr0s_NVnNEF9TrjAv+wuRF4";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Yr0s_NVnNEF9TrjAv+wuRF4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 8 Dec 2022 13:53:27 +1100 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> Today's linux-next merge of the kunit-next tree got a conflict in:
>=20
>   security/apparmor/policy_unpack.c
>=20
> between commits:
>=20
>   371e50a0b19f ("apparmor: make unpack_array return a trianary value")
>   73c7e91c8bc9 ("apparmor: Remove unnecessary size check when unpacking t=
rans_table")
>   217af7e2f4de ("apparmor: refactor profile rules and attachments")
> (and probably others)
>=20
> from the apparmor tree and commit:
>=20
>   2c92044683f5 ("apparmor: test: make static symbols visible during kunit=
 testing")
>=20
> from the kunit-next tree.
>=20
> This is somewhat of a mess ... pity there is not a shared branch (or
> better routing if the patches).
>=20
> I fixed it up (hopefully - see below) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.
>=20
> I also had to add this patch:

This merge fix patch is now:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 8 Dec 2022 13:47:43 +1100
Subject: [PATCH] fixup for "apparmor: make unpack_array return a trianary v=
alue"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 security/apparmor/include/policy_unpack.h | 7 ++++++-
 security/apparmor/policy_unpack.c         | 5 -----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/security/apparmor/include/policy_unpack.h b/security/apparmor/=
include/policy_unpack.h
index 940da8a33e0c..67d59b9736de 100644
--- a/security/apparmor/include/policy_unpack.h
+++ b/security/apparmor/include/policy_unpack.h
@@ -165,6 +165,11 @@ static inline void aa_put_loaddata(struct aa_loaddata =
*data)
 		kref_put(&data->count, aa_loaddata_kref);
 }
=20
+#define tri int
+#define TRI_TRUE 1
+#define TRI_NONE 0
+#define TRI_FALSE -1
+
 #if IS_ENABLED(CONFIG_KUNIT)
 bool aa_inbounds(struct aa_ext *e, size_t size);
 size_t aa_unpack_u16_chunk(struct aa_ext *e, char **chunk);
@@ -172,7 +177,7 @@ bool aa_unpack_X(struct aa_ext *e, enum aa_code code);
 bool aa_unpack_nameX(struct aa_ext *e, enum aa_code code, const char *name=
);
 bool aa_unpack_u32(struct aa_ext *e, u32 *data, const char *name);
 bool aa_unpack_u64(struct aa_ext *e, u64 *data, const char *name);
-size_t aa_unpack_array(struct aa_ext *e, const char *name);
+tri aa_unpack_array(struct aa_ext *e, const char *name, u16 *size);
 size_t aa_unpack_blob(struct aa_ext *e, char **blob, const char *name);
 int aa_unpack_str(struct aa_ext *e, const char **string, const char *name);
 int aa_unpack_strdup(struct aa_ext *e, char **string, const char *name);
diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_u=
npack.c
index 6513545dad5e..173d832fc4ee 100644
--- a/security/apparmor/policy_unpack.c
+++ b/security/apparmor/policy_unpack.c
@@ -30,11 +30,6 @@
 #include "include/policy_unpack.h"
 #include "include/policy_compat.h"
=20
-#define tri int
-#define TRI_TRUE 1
-#define TRI_NONE 0
-#define TRI_FALSE -1
-
 /* audit callback for unpack fields */
 static void audit_cb(struct audit_buffer *ab, void *va)
 {
--=20
2.35.1

--=20
Cheers,
Stephen Rothwell

--Sig_/Yr0s_NVnNEF9TrjAv+wuRF4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmOX8BAACgkQAVBC80lX
0GxudAf/Zh5m11HDJMUpf9GYMI7NHHkPsEyUFjI9HUQkqRpUB/K8R/FM1sxBj6rb
JEh6PBKV4ZkSzeMrpZ7PQcbGc+7dOiHOzdwBtcjFBcVssKuwC3g2jOwjbugMYTVk
yE0cBOplNgzJR1Ze2ODnrnsRzzXpQy4sPyw7Q0ccXkYrsQ0OFMwKj3RlHa7Oxmdx
p8WaLXuIhEXdz2dhDGO6XYrszBESN4s9zv/D4IWBR1HeyU4GALl2E96gdcKt9qSA
9Rc9LGPSxjI6EDf9g4a8674EMrl5eQD3CoaCWarltHu1g9l778DBFdE6SuQ6/89/
crwVEGSrd9wn0raW2lBlb+NjIP+w0A==
=3K0O
-----END PGP SIGNATURE-----

--Sig_/Yr0s_NVnNEF9TrjAv+wuRF4--

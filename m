Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBDD75B5576
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 09:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbiILHl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 03:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiILHlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 03:41:24 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7197613F61;
        Mon, 12 Sep 2022 00:41:22 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MQz6x3xWyz4xZQ;
        Mon, 12 Sep 2022 17:41:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1662968477;
        bh=mxNFFE+eqlU8ONC9r/ZWYD26LKTbN1t7gw3eP3yidqU=;
        h=Date:From:To:Cc:Subject:From;
        b=P7g8wvhpgTqE6neNhrmP/fqBg4egfdZ+ty29xz1+z17AHokt0XfMMcwqav8gMaiB6
         NYe6Moj6NL+5OamvCk+1EO+GDaIq7Ag3FNTrpBX0OnXIpbY8HVL2yYKlZWHVja7UH8
         GJzn8tuD+E+DG+E618ZtG07cwjp23VAfkIHzhfs6O7vMFr5K50Yn5kBdZemKTDtzbE
         V7a2jZDVFzKZ0/Odf6pkAtRE9xjnjka4mPhZ1+EQySeAAUkhPlaFkYYvt38NH79utl
         AczfEuoJYEqdw+szm0ZmOx11H0RSrgtJt3ezK1BYmvSIQ4W6v2IsQWnCz1ttb+VHnQ
         qOZTMr9n9hcXg==
Date:   Mon, 12 Sep 2022 17:41:11 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     Adam Bratschi-Kaye <ark.email@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Antonio Terceiro <antonio.terceiro@linaro.org>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Boris-Chengbiao Zhou <bobo1239@web.de>,
        Daniel Xu <dxu@dxuuu.xyz>,
        Dariusz Sosnowski <dsosnowski@dsosnowski.pl>,
        Douglas Su <d0u9.su@outlook.com>, Finn Behrens <me@kloenk.de>,
        Gary Guo <gary@garyguo.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Miguel Ojeda <ojeda@kernel.org>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>
Subject: linux-next: manual merge of the rust tree with the kbuild tree
Message-ID: <20220912174111.7e701ef5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/iqii0KRdv5L=7yPeTj_KH1e";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/iqii0KRdv5L=7yPeTj_KH1e
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the rust tree got a conflict in:

  Makefile

between commits:

  d0d7e9163953 ("kbuild: move .vmlinux.objs rule to Makefile.modpost")
  1e9657fb4b8f ("kbuild: move core-y and drivers-y to ./Kbuild")

from the kbuild tree and commit:

  4f6a738b5c34 ("Kbuild: add Rust support")

from the rust tree.

I fixed it up (see at the end and the merge fix patch below) and can
carry the fix as necessary. This is now fixed as far as linux-next is
concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the
conflicting tree to minimise any particularly complex conflicts.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 12 Sep 2022 17:38:35 +1000
Subject: [PATCH] rust: fix up for "kbuild: move core-y and drivers-y to ./K=
build"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 Kbuild | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Kbuild b/Kbuild
index 8854e88e0619..253e9f789cf6 100644
--- a/Kbuild
+++ b/Kbuild
@@ -89,6 +89,7 @@ obj-y			+=3D security/
 obj-y			+=3D crypto/
 obj-$(CONFIG_BLOCK)	+=3D block/
 obj-$(CONFIG_IO_URING)	+=3D io_uring/
+obj-$(CONFIG_RUST)	+=3D rust/
 obj-y			+=3D drivers/
 obj-y			+=3D sound/
 obj-$(CONFIG_SAMPLES)	+=3D samples/
--=20
2.35.1

--=20
Cheers,
Stephen Rothwell

diff --cc Makefile
index f8413c411923,a105cb893b4c..000000000000
--- a/Makefile
+++ b/Makefile
@@@ -757,10 -819,20 +821,17 @@@ KBUILD_CFLAGS	+=3D $(call cc-disable-warn
 =20
  ifdef CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE
  KBUILD_CFLAGS +=3D -O2
+ KBUILD_RUSTFLAGS +=3D -Copt-level=3D2
 -else ifdef CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE_O3
 -KBUILD_CFLAGS +=3D -O3
 -KBUILD_RUSTFLAGS +=3D -Copt-level=3D3
  else ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
  KBUILD_CFLAGS +=3D -Os
+ KBUILD_RUSTFLAGS +=3D -Copt-level=3Ds
  endif
 =20
+ # Always set `debug-assertions` and `overflow-checks` because their defau=
lt
+ # depends on `opt-level` and `debug-assertions`, respectively.
+ KBUILD_RUSTFLAGS +=3D -Cdebug-assertions=3D$(if $(CONFIG_RUST_DEBUG_ASSER=
TIONS),y,n)
+ KBUILD_RUSTFLAGS +=3D -Coverflow-checks=3D$(if $(CONFIG_RUST_OVERFLOW_CHE=
CKS),y,n)
+=20
  # Tell gcc to never replace conditional load with a non-conditional one
  ifdef CONFIG_CC_IS_GCC
  # gcc-10 renamed --param=3Dallow-store-data-races=3D0 to
@@@ -1505,7 -1576,7 +1589,8 @@@ endif # CONFIG_MODULE
  # Directories & files removed with 'make clean'
  CLEAN_FILES +=3D include/ksym vmlinux.symvers modules-only.symvers \
  	       modules.builtin modules.builtin.modinfo modules.nsdeps \
- 	       compile_commands.json .thinlto-cache .vmlinux.objs
 -	       compile_commands.json .thinlto-cache rust/test rust/doc
++	       compile_commands.json .thinlto-cache .vmlinux.objs \
++	       rust/test rust/doc
 =20
  # Directories & files removed with 'make mrproper'
  MRPROPER_FILES +=3D include/config include/generated          \

--Sig_/iqii0KRdv5L=7yPeTj_KH1e
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMe4pcACgkQAVBC80lX
0GwS/wgAkyT4O43D/+0wW2g5RyN9HH/43h0XJEKnpPcmKjHzWBM+ahryWEg0zZY5
rZsa2VLHTVCgJlobzk3bUf6b3g7gF6eAl8KzXqZbHskySm9t5ewH3sPi6YIBNEk7
0UjZxyLD9DCwhYsixnxj/LQ7fME79cqMjW13BJ1fM0mXKCtON2fQ2hxlPvwgbCIo
swtLgdu0p4Iu4x59NsXEKrzfrjsS4pugIt4ml8+on2w2a7BNUniZ7bKREn/lJKlC
DHIvQVYxczLPzdHOSFNCyWHlTLln2U+48nMVjTVag8YPlWwLrY5MhKJyHw/pDxq1
2PpdxVVFuLAw0/0/upwgkApPm6SLdA==
=BiK0
-----END PGP SIGNATURE-----

--Sig_/iqii0KRdv5L=7yPeTj_KH1e--

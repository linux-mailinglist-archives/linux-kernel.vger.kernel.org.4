Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8D76BDBFC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 23:50:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjCPWuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 18:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjCPWua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 18:50:30 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DEFA1EFE6;
        Thu, 16 Mar 2023 15:50:28 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Pd2Xf3Djfz4x1f;
        Fri, 17 Mar 2023 09:50:26 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1679007026;
        bh=mI2/fUJBhDj7jPXmsGAJd7HxRPxBeVk95YeH85yjdEI=;
        h=Date:From:To:Cc:Subject:From;
        b=nBjbY/XiDFxPYpwfs5At6gWQjkXcesvPs0tFbS755opMshjevEjNT6tuQmBh/w7R6
         GXV5bbxcyZ6hH1caCPF2Qsx39sLnZyMz88ccP+1FH68WED3uThCR2Bd4QEy2QKUKXB
         Fz3BMnl1u2MbL9Z9HT9UU9flpzGbEEAG/p0fU6pF1f1y1IjBI+qU5HPI0Q1rC0zbup
         WaTTKZBDKbHxdhnjLtJ1syLuAtNqiDcPkoPn0uGfo2SMFj9QfzzTa5dyc8u84OWIbw
         DGpzvHE2FBI5G9LATTxWka39H83eBje0YSF2ZA/mw+XOizuS2XcoXooW0t/3SMgnXY
         C2G6oRjUPEheQ==
Date:   Fri, 17 Mar 2023 09:50:25 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the perf tree
Message-ID: <20230317095025.49aa34f9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/VgnywP8Ly_Ed5l=+iE5JNPy";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/VgnywP8Ly_Ed5l=+iE5JNPy
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the perf tree, today's linux-next build (native perf)
failed like this:

Auto-detecting system features:
...                         clang-bpf-co-re: [ =1B[32mon=1B[m  ]
...                                    llvm: [ =1B[31mOFF=1B[m ]
...                                  libcap: [ =1B[32mon=1B[m  ]
...                                  libbfd: [ =1B[32mon=1B[m  ]

make[1]: *** Deleting file '/home/sfr/next/perf/util/bpf_skel/vmlinux.h'
libbpf: failed to find '.BTF' ELF section in /boot/vmlinux-6.0.0-5-powerpc6=
4le
Error: failed to load BTF from /boot/vmlinux-6.0.0-5-powerpc64le: No data a=
vailable
make[1]: *** [Makefile.perf:1075: /home/sfr/next/perf/util/bpf_skel/vmlinux=
.h] Error 195
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile.perf:236: sub-make] Error 2
Command exited with non-zero status 2

To be clear this is a native build of perf on a PPC64le host using this
command line:

make -C tools/perf -f Makefile.perf -s -O -j60 O=3D../perf EXTRA_CFLAGS=3D-=
Wno-psabi

(I could probably remove the EXTRA_CLFAGS now that I am building with
gcc 12.2)

I don't know which commit caused this.

I have used the perf tree from next-20230316 for today.



--=20
Cheers,
Stephen Rothwell

--Sig_/VgnywP8Ly_Ed5l=+iE5JNPy
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQTnTEACgkQAVBC80lX
0GwAtAf9EGJ31eQFrlfJcE5lvwm2hRcuSjeXKI7Zw3auU4/00dB4DnKOCFEsoRIL
afBE0r8Zo48eVwngOlhPsrnayA66xQM5koU1nstJTUfFuk1EmlIqvWDo0mgWqDvj
IJO6nBrxxORJj3dBGNJakZFpEFKrBXGlyrXyyGnR+/PbpImjc88TQlP0UZBB0ZCn
d3amGgDP9qmmLJTLmjM8mBZjxs6TkhXfvbxWoIkGoa6UGnqcO263VJKROYTqhNAT
iJDogBzb6qe0lXFb1e+QG3aEBUPmv0sJWmGGmIoF9JvpW6Z1t9AYM9RUYAGTZr+U
iLIfsfVa9frX+72UkV+nF/JqhlXr5w==
=Ou++
-----END PGP SIGNATURE-----

--Sig_/VgnywP8Ly_Ed5l=+iE5JNPy--

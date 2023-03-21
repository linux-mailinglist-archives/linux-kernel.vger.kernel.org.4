Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFF006C3CE2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 22:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjCUVkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 17:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjCUVkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 17:40:07 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A5F524BC9;
        Tue, 21 Mar 2023 14:39:59 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Ph4l12jr0z4xFR;
        Wed, 22 Mar 2023 08:39:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1679434797;
        bh=iUyM8WXSWONpbzj8lCsJZATCk3ti1xQ41f6XXkGrF30=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IbGsVeC3SSBgYcmA3bZyGo/Bgy5fRAL9tF8iBdddXPuxTTek59c8/rVN4jZqNmg2g
         jgopxR+rfLnoxQn75a+XWuOuePXg6+Ac0qw9T5dHGgzOmEaCdLBais2XFiTovSzAvs
         Nil69Wf66eB2H9BsnsBeajanMVaHMPRQUgCBI+Sc3VBKSpcxNxUakKTAK4dnrCVNnl
         CUQWs5U4/X/0MrsONUMrIPOSauPFURK+b9cLiCvtHm2Qg1TjxB81K6lPqB5FBFzBA1
         Dx7P+cN+zRWgMFx3lWxpvK9MQnr35lERNzoCixZ3AN7zKGog+8KTIlNHhEconrRU6l
         1TN/37ROJ+umA==
Date:   Wed, 22 Mar 2023 08:39:56 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Ian Rogers <irogers@google.com>, <namhyung@kernel.org>
Subject: Re: linux-next: build failure after merge of the perf tree
Message-ID: <20230322083956.5c051777@canb.auug.org.au>
In-Reply-To: <20230317095025.49aa34f9@canb.auug.org.au>
References: <20230317095025.49aa34f9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/NYRY2U39Yzj5UUJxYYd_bFw";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/NYRY2U39Yzj5UUJxYYd_bFw
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 17 Mar 2023 09:50:25 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> After merging the perf tree, today's linux-next build (native perf)
> failed like this:
>=20
> Auto-detecting system features:
> ...                         clang-bpf-co-re: [ =1B[32mon=1B[m  ]
> ...                                    llvm: [ =1B[31mOFF=1B[m ]
> ...                                  libcap: [ =1B[32mon=1B[m  ]
> ...                                  libbfd: [ =1B[32mon=1B[m  ]
>=20
> make[1]: *** Deleting file '/home/sfr/next/perf/util/bpf_skel/vmlinux.h'
> libbpf: failed to find '.BTF' ELF section in /boot/vmlinux-6.0.0-5-powerp=
c64le
> Error: failed to load BTF from /boot/vmlinux-6.0.0-5-powerpc64le: No data=
 available
> make[1]: *** [Makefile.perf:1075: /home/sfr/next/perf/util/bpf_skel/vmlin=
ux.h] Error 195
> make[1]: *** Waiting for unfinished jobs....
> make: *** [Makefile.perf:236: sub-make] Error 2
> Command exited with non-zero status 2
>=20
> To be clear this is a native build of perf on a PPC64le host using this
> command line:
>=20
> make -C tools/perf -f Makefile.perf -s -O -j60 O=3D../perf EXTRA_CFLAGS=
=3D-Wno-psabi
>=20
> (I could probably remove the EXTRA_CLFAGS now that I am building with
> gcc 12.2)
>=20
> I don't know which commit caused this.
>=20
> I have used the perf tree from next-20230316 for today.

I am still getting this build failure.

--=20
Cheers,
Stephen Rothwell

--Sig_/NYRY2U39Yzj5UUJxYYd_bFw
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQaJCwACgkQAVBC80lX
0GyugQgAjVQo6K+XRsLVeENpXPfMUPdmXV96GbYUczY5KS5ynkqDA9tLIYi+NhUJ
i0YEgg2Y4F5igYRrb7dWOzh64QMska/HFp15yPLtHIwshPCMwrnGB5vS7R90p86W
qnddPE2WPli7dDR0vzib6ucT7FdjcDORcTG6pktffLbpVTLd9x5lvlpN0bvZdaYB
TXvVrV9APwKLsYyGYYgRO6a/RXtkIk/g44Ar7VCKn/D4NNfsWKTWLlPHVgVi7k3y
xN3vkPvqvzUDHJeUhLhXZO2ZY76suw2vhcpxAmY5q0QmwE0fsbdcO7dGhgL/Q/B5
u1dUmNenSruenwmWPP75kdWC+J0rKQ==
=mUe0
-----END PGP SIGNATURE-----

--Sig_/NYRY2U39Yzj5UUJxYYd_bFw--

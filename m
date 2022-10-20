Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 914E0606482
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 17:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbiJTPaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 11:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbiJTP3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 11:29:41 -0400
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C799B84C
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 08:29:22 -0700 (PDT)
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <riel@shelob.surriel.com>)
        id 1olXSz-0008Af-26;
        Thu, 20 Oct 2022 11:28:17 -0400
Message-ID: <366045a27a96e01d0526d63fd78d4f3c5d1f530b.camel@surriel.com>
Subject: Re: [mm] f35b5d7d67: will-it-scale.per_process_ops -95.5% regression
From:   Rik van Riel <riel@surriel.com>
To:     "Huang, Ying" <ying.huang@intel.com>,
        Nathan Chancellor <nathan@kernel.org>
Cc:     kernel test robot <yujie.liu@intel.com>, lkp@lists.01.org,
        lkp@intel.com, Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <shy828301@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        feng.tang@intel.com, zhengjun.xing@linux.intel.com,
        fengwei.yin@intel.com
Date:   Thu, 20 Oct 2022 11:28:16 -0400
In-Reply-To: <871qr3nkw2.fsf@yhuang6-desk2.ccr.corp.intel.com>
References: <202210181535.7144dd15-yujie.liu@intel.com>
         <87edv4r2ip.fsf@yhuang6-desk2.ccr.corp.intel.com>
         <Y1DNQaoPWxE+rGce@dev-arch.thelio-3990X>
         <871qr3nkw2.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-jyyb0dS8k9AkcqYqrs+D"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Sender: riel@shelob.surriel.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-jyyb0dS8k9AkcqYqrs+D
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2022-10-20 at 13:07 +0800, Huang, Ying wrote:
>=20
> Nathan Chancellor <nathan@kernel.org> writes:
> >=20
> > For what it's worth, I just bisected a massive and visible
> > performance
> > regression on my Threadripper 3990X workstation to commit
> > f35b5d7d676e
> > ("mm: align larger anonymous mappings on THP boundaries"), which
> > seems
> > directly related to this report/analysis. I initially noticed this
> > because my full set of kernel builds against mainline went from 2
> > hours
> > and 20 minutes or so to over 3 hours. Zeroing in on x86_64
> > allmodconfig,
> > which I used for the bisect:
> >=20
> > @ 7b5a0b664ebe ("mm/page_ext: remove unused variable in
> > offline_page_ext"):
> >=20
> > Benchmark 1: make -skj128 LLVM=3D1 allmodconfig all
> > =C2=A0 Time (mean =C2=B1 =CF=83):=C2=A0=C2=A0=C2=A0=C2=A0 318.172 s =C2=
=B1=C2=A0 0.730 s=C2=A0=C2=A0=C2=A0 [User: 31750.902 s,
> > System: 4564.246 s]
> > =C2=A0 Range (min =E2=80=A6 max):=C2=A0=C2=A0 317.332 s =E2=80=A6 318.6=
62 s=C2=A0=C2=A0=C2=A0 3 runs
> >=20
> > @ f35b5d7d676e ("mm: align larger anonymous mappings on THP
> > boundaries"):
> >=20
> > Benchmark 1: make -skj128 LLVM=3D1 allmodconfig all
> >   Time (mean =C2=B1 =CF=83):     406.688 s =C2=B1  0.676 s    [User: 31=
819.526 s,
System: 16327.022 s]
> >   Range (min =E2=80=A6 max):   405.954 s =E2=80=A6 407.284 s    3 run
>=20
> Have you tried to build with gcc?=C2=A0 Want to check whether is this
> clang
> specific issue or not.

This may indeed be something LLVM specific. In previous tests,
GCC has generally seen a benefit from increased THP usage.
Many other applications also benefit from getting more THPs.

LLVM showing 10% system time before this change, and a whopping
30% system time after that change, suggests that LLVM is behaving
quite differently from GCC in some ways.

If we can figure out what these differences are, maybe we can
just fine tune the code to avoid this issue.

I'll try to play around with LLVM compilation a little bit next
week, to see if I can figure out what might be going on. I wonder
if LLVM is doing lots of mremap calls or something...

--=20
All Rights Reversed.

--=-jyyb0dS8k9AkcqYqrs+D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAmNRaRAACgkQznnekoTE
3oPi+QgAgglCDIr3nTtc9B3ddLnhdbmzp0chq5yKurOLQJ39FNC8HD7iaukRYXju
toNVMhIfT5JulxIO/bpc1zP3tL1+JDZCBwtqyogLZfhdrQQKSaM4b+JqnAKKEDd7
KoZfirX7DoVxCCTZzduqntmhWUsh1xKJdoSuUGXrSa3PfBFaG8lv+VMQDPB45aNq
SO3hZdgTEMm6u4LgsspE8Ak6oKLhRqgHtf2Kr2DujdQtLUvmn8HdKNROcZSaGpIJ
dbf74SCUe7lZ3Ov3VZsTRR/CV6FeGiKQbKZOs3Va3Xima+aCkVTxKExyaeFShJyi
FHKyytxJoZFGuxV0nKr7ZVQdTebHBA==
=Eb0d
-----END PGP SIGNATURE-----

--=-jyyb0dS8k9AkcqYqrs+D--

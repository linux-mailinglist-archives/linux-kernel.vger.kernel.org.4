Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3677963F98B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 22:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbiLAVDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 16:03:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbiLAVD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 16:03:28 -0500
X-Greylist: delayed 2016 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 01 Dec 2022 13:03:26 PST
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFBF03E0B6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 13:03:24 -0800 (PST)
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <riel@shelob.surriel.com>)
        id 1p0qBi-0005gc-2K;
        Thu, 01 Dec 2022 15:29:42 -0500
Message-ID: <07adee081a70c2b4b44d9bf93a0ad3142e091086.camel@surriel.com>
Subject: Re: [mm] f35b5d7d67: will-it-scale.per_process_ops -95.5% regression
From:   Rik van Riel <riel@surriel.com>
To:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <shy828301@gmail.com>
Cc:     "Huang, Ying" <ying.huang@intel.com>,
        kernel test robot <yujie.liu@intel.com>, lkp@lists.01.org,
        lkp@intel.com, Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        feng.tang@intel.com, zhengjun.xing@linux.intel.com,
        fengwei.yin@intel.com, Nathan Chancellor <nathan@kernel.org>
Date:   Thu, 01 Dec 2022 15:29:41 -0500
In-Reply-To: <e919e5a3-1118-043e-8bbd-5ee35f2ab411@leemhuis.info>
References: <202210181535.7144dd15-yujie.liu@intel.com>
         <87edv4r2ip.fsf@yhuang6-desk2.ccr.corp.intel.com>
         <Y1DNQaoPWxE+rGce@dev-arch.thelio-3990X>
         <871qr3nkw2.fsf@yhuang6-desk2.ccr.corp.intel.com>
         <366045a27a96e01d0526d63fd78d4f3c5d1f530b.camel@surriel.com>
         <Y1GCYXGtEVZbcv/5@dev-arch.thelio-3990X>
         <Y4RX+JZLddDHrLuQ@dev-arch.thelio-3990X>
         <e919e5a3-1118-043e-8bbd-5ee35f2ab411@leemhuis.info>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-k/uf2/ZCYK22Nz0T1hrw"
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


--=-k/uf2/ZCYK22Nz0T1hrw
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2022-12-01 at 19:33 +0100, Thorsten Leemhuis wrote:
> Hi, this is your Linux kernel regression tracker.
>=20
> On 28.11.22 07:40, Nathan Chancellor wrote:
> > Hi Rik,
>=20
> I wonder what we should do about below performance regression. Is
> reverting the culprit now and reapplying it later together with a fix
> a
> viable option? Or was anything done/is anybody doing something
> already
> to address the problem and I just missed it?

The changeset in question speeds up kernel compiles with
GCC, as well as the runtime speed of other programs, due
to being able to use THPs more. However, it slows down kernel
compiles with clang, due to ... something clang does.

I have not figured out what that something is yet.

I don't know if I have the wrong version of clang here,
but I have not seen any smoking gun at all when tracing
clang system calls. I see predominantly small mmap and
unmap calls, and nothing that even triggers 2MB alignment.

>=20
> Yang Shi, Andrew, what's your option on this? I ask you directly,
> because it looks like Rik hasn't posted anything to lists archived on
> lore during the last few weeks. :-/
>=20
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker'
> hat)
>=20
> P.S.: As the Linux kernel's regression tracker I deal with a lot of
> reports and sometimes miss something important when writing mails
> like
> this. If that's the case here, don't hesitate to tell me in a public
> reply, it's in everyone's interest to set the public record straight.
>=20
> > On Thu, Oct 20, 2022 at 10:16:20AM -0700, Nathan Chancellor wrote:
> > > On Thu, Oct 20, 2022 at 11:28:16AM -0400, Rik van Riel wrote:
> > > > On Thu, 2022-10-20 at 13:07 +0800, Huang, Ying wrote:
> > > > > Nathan Chancellor <nathan@kernel.org> writes:
> > > > > >=20
> > > > > > For what it's worth, I just bisected a massive and visible
> > > > > > performance
> > > > > > regression on my Threadripper 3990X workstation to commit
> > > > > > f35b5d7d676e
> > > > > > ("mm: align larger anonymous mappings on THP boundaries"),
> > > > > > which
> > > > > > seems
> > > > > > directly related to this report/analysis. I initially
> > > > > > noticed this
> > > > > > because my full set of kernel builds against mainline went
> > > > > > from 2
> > > > > > hours
> > > > > > and 20 minutes or so to over 3 hours. Zeroing in on x86_64
> > > > > > allmodconfig,
> > > > > > which I used for the bisect:
> > > > > >=20
> > > > > > @ 7b5a0b664ebe ("mm/page_ext: remove unused variable in
> > > > > > offline_page_ext"):
> > > > > >=20
> > > > > > Benchmark 1: make -skj128 LLVM=3D1 allmodconfig all
> > > > > > =C2=A0 Time (mean =C2=B1 =CF=83):=C2=A0=C2=A0=C2=A0=C2=A0 318.1=
72 s =C2=B1=C2=A0 0.730 s=C2=A0=C2=A0=C2=A0 [User:
> > > > > > 31750.902 s,
> > > > > > System: 4564.246 s]
> > > > > > =C2=A0 Range (min =E2=80=A6 max):=C2=A0=C2=A0 317.332 s =E2=80=
=A6 318.662 s=C2=A0=C2=A0=C2=A0 3 runs
> > > > > >=20
> > > > > > @ f35b5d7d676e ("mm: align larger anonymous mappings on THP
> > > > > > boundaries"):
> > > > > >=20
> > > > > > Benchmark 1: make -skj128 LLVM=3D1 allmodconfig all
> > > > > > =C2=A0 Time (mean =C2=B1 =CF=83):=C2=A0=C2=A0=C2=A0=C2=A0 406.6=
88 s =C2=B1=C2=A0 0.676 s=C2=A0=C2=A0=C2=A0 [User:
> > > > > > 31819.526 s,
> > > > System: 16327.022 s]
> > > > > > =C2=A0 Range (min =E2=80=A6 max):=C2=A0=C2=A0 405.954 s =E2=80=
=A6 407.284 s=C2=A0=C2=A0=C2=A0 3 run
> > > > >=20
> > > > > Have you tried to build with gcc?=C2=A0 Want to check whether is
> > > > > this
> > > > > clang
> > > > > specific issue or not.
> > > >=20
> > > > This may indeed be something LLVM specific. In previous tests,
> > > > GCC has generally seen a benefit from increased THP usage.
> > > > Many other applications also benefit from getting more THPs.
> > >=20
> > > Indeed, GCC builds actually appear to be slightly faster on my
> > > system now,
> > > apologies for not trying that before reporting :/
> > >=20
> > > 7b5a0b664ebe:
> > >=20
> > > Benchmark 1: make -skj128 allmodconfig all
> > > =C2=A0 Time (mean =C2=B1 =CF=83):=C2=A0=C2=A0=C2=A0=C2=A0 355.294 s =
=C2=B1=C2=A0 0.931 s=C2=A0=C2=A0=C2=A0 [User: 33620.469
> > > s, System: 6390.064 s]
> > > =C2=A0 Range (min =E2=80=A6 max):=C2=A0=C2=A0 354.571 s =E2=80=A6 356=
.344 s=C2=A0=C2=A0=C2=A0 3 runs
> > >=20
> > > f35b5d7d676e:
> > >=20
> > > Benchmark 1: make -skj128 allmodconfig all
> > > =C2=A0 Time (mean =C2=B1 =CF=83):=C2=A0=C2=A0=C2=A0=C2=A0 347.400 s =
=C2=B1=C2=A0 2.029 s=C2=A0=C2=A0=C2=A0 [User: 34389.724
> > > s, System: 4603.175 s]
> > > =C2=A0 Range (min =E2=80=A6 max):=C2=A0=C2=A0 345.815 s =E2=80=A6 349=
.686 s=C2=A0=C2=A0=C2=A0 3 runs
> > >=20
> > > > LLVM showing 10% system time before this change, and a whopping
> > > > 30% system time after that change, suggests that LLVM is
> > > > behaving
> > > > quite differently from GCC in some ways.
> > >=20
> > > The above tests were done with GCC 12.2.0 from Arch Linux. The
> > > previous LLVM
> > > tests were done with a self-compiled version of LLVM from the
> > > main branch
> > > (16.0.0), optimized with BOLT [1]. To eliminate that as a source
> > > of issues, I
> > > used my distribution's version of clang (14.0.6) and saw similar
> > > results as
> > > before:
> > >=20
> > > 7b5a0b664ebe:
> > >=20
> > > Benchmark 1: make -skj128 LLVM=3D/usr/bin/ allmodconfig all
> > > =C2=A0 Time (mean =C2=B1 =CF=83):=C2=A0=C2=A0=C2=A0=C2=A0 462.517 s =
=C2=B1=C2=A0 1.214 s=C2=A0=C2=A0=C2=A0 [User: 48544.240
> > > s, System: 5586.212 s]
> > > =C2=A0 Range (min =E2=80=A6 max):=C2=A0=C2=A0 461.115 s =E2=80=A6 463=
.245 s=C2=A0=C2=A0=C2=A0 3 runs
> > >=20
> > > f35b5d7d676e:
> > >=20
> > > Benchmark 1: make -skj128 LLVM=3D/usr/bin/ allmodconfig all
> > > =C2=A0 Time (mean =C2=B1 =CF=83):=C2=A0=C2=A0=C2=A0=C2=A0 547.927 s =
=C2=B1=C2=A0 0.862 s=C2=A0=C2=A0=C2=A0 [User: 47913.709
> > > s, System: 17682.514 s]
> > > =C2=A0 Range (min =E2=80=A6 max):=C2=A0=C2=A0 547.429 s =E2=80=A6 548=
.922 s=C2=A0=C2=A0=C2=A0 3 runs
> > >=20
> > > > If we can figure out what these differences are, maybe we can
> > > > just fine tune the code to avoid this issue.
> > > >=20
> > > > I'll try to play around with LLVM compilation a little bit next
> > > > week, to see if I can figure out what might be going on. I
> > > > wonder
> > > > if LLVM is doing lots of mremap calls or something...
> > >=20
> > > If there is any further information I can provide or patches I
> > > can test,
> > > I am more than happy to do so.
> > >=20
> > > [1]:
> > > https://github.com/llvm/llvm-project/tree/96552e73900176d65ee6650faca=
e8d669d6f9498/bolt
> >=20
> > Was there ever a follow up to this report that I missed? I just
> > noticed that I am still reverting f35b5d7d676e in my mainline
> > kernel.
> >=20
> > Cheers,
> > Nathan
> >=20
>=20
> #regzbot ignore-activity
>=20

--=20
All Rights Reversed.

--=-k/uf2/ZCYK22Nz0T1hrw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAmOJDrUACgkQznnekoTE
3oOKGwf8D1oU3PFiQY/CyAhm8mGeE9oujka5t++2aI3a2pfWMp3dPGt3JkNfmKau
wvtntOCd1icP1WSv+QBjgWe6Swvt7KpUfHNH9Zp7rHeLl70j1Uf7zQkPAsMui9Io
VdewMUgCtYfeJQ7ZFmxFw/PsxMovjdYldi5RUuZYT0+5yW3U2g+Ykrd+8XP7/dcN
ZtTQ/vxJnqpISOtM3OPUu81LBTZL3GV1FWap9SFMHoL5pVLh/SCF5z+9ndRmm4Ue
l1UxINj4FoINZzMI9+SJ+v15R2+vMxifSYheBOARz3hCSqat4pe1BgX7nZIS3Xfy
uWE3xlr+uLuiDvK3q+ilwJum7l0FVw==
=Skbz
-----END PGP SIGNATURE-----

--=-k/uf2/ZCYK22Nz0T1hrw--

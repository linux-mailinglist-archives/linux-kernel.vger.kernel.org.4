Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0258366A396
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 20:45:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjAMTpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 14:45:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjAMToi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 14:44:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6760B892F8;
        Fri, 13 Jan 2023 11:44:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 066C162309;
        Fri, 13 Jan 2023 19:44:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B342C433F0;
        Fri, 13 Jan 2023 19:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673639044;
        bh=WGId6XhZAVnIZkoLZ+WhwPO8RltJnG9lEuEO0M2xGlQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XXBtn1pRh6QL9rlBAAnnp9ALNAglQ/gcV7FBa7iFQppj9Je1nYqEI9gwcTGbdNStv
         uD+RzAgWsmCZJwp0Z4ZeFSQJ9KIXr1gzm3Tv0pfaS4jRCWQzVYs9kor3ALLwzzYSmM
         M3yuwW0wPGDwZG0rUyKOn0qbapbx/Aqc6f1lzz3p0HiP17lkWb8soH6NuPnlpRwdsn
         3IZ0sKbW/pd92HhyTH3KMh4iuWdf4OTt50gx6Odg4TXc1tKtSK3h1BpdGf6ZQoULp2
         xEqMVrOpUrH5CScp7Vwb6YphvK9wFuSkVn6UvgIoiU3CYthL5fpA62Xi/Nup6w78UR
         aH326HslpkK/w==
Date:   Fri, 13 Jan 2023 19:43:58 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        lkft-triage@lists.linaro.org, regressions@lists.linux.dev,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>
Subject: Re: next: BUG: kernel NULL pointer dereference, address:
 0000000000000008 - RIP: 0010:do_wp_page
Message-ID: <Y8G0fu7Kpkd8s7DE@sirena.org.uk>
References: <CA+G9fYt_b04YNCCv-iTZTtwb5fmNEQ0abiO46qW_-SrA1GQX8w@mail.gmail.com>
 <Y8Fkjxsq5EOtGiql@casper.infradead.org>
 <CA+G9fYuahjaNs6ia1UOeF98hUhonAt0Z4YOFGcqOKt3J4tRvTw@mail.gmail.com>
 <Y8F+iKuJWAFsUg2m@casper.infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="D0i8bOacOOmVqGFC"
Content-Disposition: inline
In-Reply-To: <Y8F+iKuJWAFsUg2m@casper.infradead.org>
X-Cookie: I know how to do SPECIAL EFFECTS!!
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--D0i8bOacOOmVqGFC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 13, 2023 at 03:53:44PM +0000, Matthew Wilcox wrote:

> Uh, are you compiling your kernels without debuginfo?  The results
> from syzbot & 0day are much more useful:

FWIW here's a decode from arm64 (the boards I sampled all looked very
similar):

<1>Unable to handle kernel NULL pointer dereference at virtual address 0000=
000000000008
<1>Mem abort info:
<1>  ESR =3D 0x0000000096000005
<1>  EC =3D 0x25: DABT (current EL), IL =3D 32 bits
<1>  SET =3D 0, FnV =3D 0
<1>  EA =3D 0, S1PTW =3D 0
<1>  FSC =3D 0x05: level 1 translation fault
<1>Data abort info:
<1>  ISV =3D 0, ISS =3D 0x00000005
<1>  CM =3D 0, WnR =3D 0
<1>user pgtable: 4k pages, 39-bit VAs, pgdp=3D00000000422b3000
<1>[0000000000000008] pgd=3D0000000000000000, p4d=3D0000000000000000, pud=
=3D0000000000000000
<0>Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
<4>Modules linked in:
<4>CPU: 3 PID: 58 Comm: modprobe Not tainted 6.2.0-rc3-next-20230113 #2
<4>Hardware name: Libre Computer Board ALL-H3-CC H5 (DT)
<4>pstate: 40000005 (nZcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
<4>pc : do_wp_page (include/linux/page-flags.h:251 mm/memory.c:3047 mm/memo=
ry.c:3425)=20
<4>lr : do_wp_page (mm/memory.c:3046 mm/memory.c:3425)=20
<4>sp : ffffffc00972bc50
<4>x29: ffffffc00972bc50 x28: ffffff80022e8000 x27: ffffff8002f9c060
<4>x26: 0000000000000002 x25: ffffff80022b4990 x24: 0000000000000000
<4>x23: ffffff8002f9c000 x22: 0000000000000000 x21: 0000000000000000
<4>x20: 0000000000000a55 x19: ffffffc00972bd38 x18: 0000000000000000
<4>x17: 0000000000000000 x16: 0000000000000000 x15: ffffff80022bfa00
<4>x14: ffffff8002f9c000 x13: ffffffc008b3bc88 x12: 0000007f9b02bfff
<4>x11: 0000007f9ad49fc0 x10: ffffff80022bfa0c x9 : ffffff80022bfa00
<4>x8 : ffffff80022bfa50 x7 : ffffff8002f9c000 x6 : 0000000000000000
<4>x5 : 0000000000041362 x4 : 0000007f9ad49000 x3 : ffffff80022b4990
<4>x2 : 0000000000100073 x1 : ffffff80022e8000 x0 : 0000000000000a55
<4>Call trace:
<4> do_wp_page (include/linux/page-flags.h:251 mm/memory.c:3047 mm/memory.c=
:3425)=20
<4> __handle_mm_fault (mm/memory.c:4937 mm/memory.c:5061)=20
<4> handle_mm_fault (mm/memory.c:5207)=20
<4> do_page_fault (arch/arm64/mm/fault.c:512 arch/arm64/mm/fault.c:612)=20
<4> do_mem_abort (arch/arm64/mm/fault.c:831)=20
<4> el0_da (arch/arm64/include/asm/daifflags.h:28 arch/arm64/kernel/entry-c=
ommon.c:133 arch/arm64/kernel/entry-common.c:142 arch/arm64/kernel/entry-co=
mmon.c:516)=20
<4> el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:659)=20
<4> el0t_64_sync (arch/arm64/kernel/entry.S:584)=20
<0>Code: aa1503f8 b9402a60 aa1503f6 b90063e0 (f94006a0)
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	aa1503f8 	.word	0xaa1503f8
   4:	b9402a60 	.word	0xb9402a60
   8:	aa1503f6 	.word	0xaa1503f6
   c:	b90063e0 	.word	0xb90063e0
  10:*	f94006a0 	.word	0xf94006a0		<-- trapping instruction

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	f94006a0 	.word	0xf94006a0
<4>---[ end trace 0000000000000000 ]---

The disassembly is disappointing, I didn't peer at why that is.

--D0i8bOacOOmVqGFC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPBtH4ACgkQJNaLcl1U
h9DpNQf8Czyt/u5BaDQFeT7muEUj/6kfPqMQpWolFNms89VS+F2rJ3V//xXRH37b
uP8Tus+06LoMBDLMQeLHAArx6LI7l5axOmTt7d2FrDhSGuBOxGP5HG91e/kfWDet
PFlhsSPkDJbR/BUG2GEWZD/O1B0gzNE9Qfu0NMTxE+yHu8Rrr5VRPwUch6kCpQxo
K43yEJ+ipfRKPXM4sIl80Z+LRHywJGfQKiPjqlgcjMigZnSUUVkMh+71uke0mBbm
96kqwUQmijUJSFzmaKyZ160r4O37jtyHz4EF8+xKO2Rzm5NtANX0/wrIU54GOPsF
RDFAOPEo04q1VTOXo/swQLcb+wiSOw==
=tRsG
-----END PGP SIGNATURE-----

--D0i8bOacOOmVqGFC--

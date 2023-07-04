Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 768027467FC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 05:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjGDDiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 23:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGDDis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 23:38:48 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64674183;
        Mon,  3 Jul 2023 20:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1688441919;
        bh=lxtstFtduQSfV/bVjp8AFcGu3gmrBrtzQMLVUjriNDw=;
        h=Date:From:To:Cc:Subject:From;
        b=cbflC2s4L9L5EfSdJuBC7Fxbaazr0DE/7kIzOaOB8Ug8DI6HMkLS7WyQdHMV7Drf6
         YJUdGuYnyjxoWf/4/4uCrin6JPF6dEhhw7AAtDzuUP+D/nNOwMc+v7a+f1UpDqZ7kG
         0nNcXXY10Odm9PLx8cgC78g10sSO58ef4dN6aYXKyxCYS3dkL4s7EUn6K7VtpRk/pv
         F2z45A6ebBs8YajKCk0CP+qHoQzBJI01Rip/iLOww0xxKdz/b/bnzFc5iZ/tw1cGKx
         8DaNgpSYHlR1f5Gmg4mzwP2jtF6Z9zxNebeFgk5ERoYB2WNq3DZuwSevxhtJ1KslFr
         0kkpiCI/RqaYw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Qw7mv3tpDz4wZw;
        Tue,  4 Jul 2023 13:38:39 +1000 (AEST)
Date:   Tue, 4 Jul 2023 13:38:37 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: boot failure after merge of the mm tree
Message-ID: <20230704133837.23ba9e49@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/hKY9hptkzjpmOW3tPSym29u";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/hKY9hptkzjpmOW3tPSym29u
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm tree, today's linux-next qemu boot test (powerpc
pseries_le_defconfig) failed like this:

 Run /init as init process
 BUG: Kernel NULL pointer dereference on read at 0x00000008
 Faulting instruction address: 0xc000000000468ed0
 Oops: Kernel access of bad area, sig: 11 [#1]
 LE PAGE_SIZE=3D64K MMU=3DHash SMP NR_CPUS=3D2048 NUMA pSeries
 Modules linked in:
 CPU: 0 PID: 1 Comm: init Not tainted 6.4.0-13165-g408ff5108632 #2
 Hardware name: IBM pSeries (emulated by qemu) POWER8 (raw) 0x4d0200 0xf000=
004 of:SLOF,HEAD pSeries
 NIP:  c000000000468ed0 LR: c000000000468410 CTR: 0000000000000000
 REGS: c00000000479b960 TRAP: 0300   Not tainted  (6.4.0-13165-g408ff510863=
2)
 MSR:  8000000000009033 <SF,EE,ME,IR,DR,RI,LE>  CR: 24024800  XER: 00000000
 CFAR: c00000000000db4c DAR: 0000000000000008 DSISR: 40000000 IRQMASK: 0=20
 GPR00: c000000000468410 c00000000479bc00 c000000001568f00 c0000000041a6180=
=20
 GPR04: 000000007fff8785 c00000000479bbe0 c00000000479bc98 0000000000000000=
=20
 GPR08: ff7fffffffffefbf c00000000153cb10 c000000000432860 0000000000002000=
=20
 GPR12: c00000000445fb08 c000000002b00000 0000000000000000 0000000000000000=
=20
 GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000=
=20
 GPR20: 0000000000000000 0000000000000000 c0000000029901a0 c00000000692d000=
=20
 GPR24: c0000000029901a8 0000000000000075 0000000000000000 c0000000029901b0=
=20
 GPR28: 0000000000000354 c00000000693fcf0 c00000000693fcf0 0000000000000000=
=20
 NIP [c000000000468ed0] __handle_mm_fault+0xeb0/0x18a0
 LR [c000000000468410] __handle_mm_fault+0x3f0/0x18a0
 Call Trace:
 [c00000000479bc00] [c000000000468410] __handle_mm_fault+0x3f0/0x18a0 (unre=
liable)
 [c00000000479bd00] [c000000000469970] handle_mm_fault+0xb0/0x350
 [c00000000479bd50] [c0000000000894b4] ___do_page_fault+0x214/0x920
 [c00000000479bdf0] [c000000000089c70] hash__do_page_fault+0x30/0xc0
 [c00000000479be20] [c0000000000930a4] do_hash_fault+0x1d4/0x330
 [c00000000479be50] [c00000000000904c] instruction_access_common_virt+0x20c=
/0x210
 --- interrupt: 400 at 0x7fff878510a0
 NIP:  00007fff878510a0 LR: 0000000000000000 CTR: 0000000000000000
 REGS: c00000000479be80 TRAP: 0400   Not tainted  (6.4.0-13165-g408ff510863=
2)
 MSR:  800000004000d033 <SF,EE,PR,ME,IR,DR,RI,LE>  CR: 00000000  XER: 00000=
000
 CFAR: c00000000000d7bc IRQMASK: 0=20
 GPR00: 0000000000000000 00007fffeb1b47a0 0000000000000000 0000000000000000=
=20
 GPR04: 0000000000000000 0000000000000000 0000000000000000 0000000000000000=
=20
 GPR08: 0000000000000000 0000000000000000 0000000000000000 0000000000000000=
=20
 GPR12: 00007fff878510a0 0000000000000000 0000000000000000 0000000000000000=
=20
 GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000=
=20
 GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000=
=20
 GPR24: 0000000000000000 0000000000000000 0000000000000000 0000000000000000=
=20
 GPR28: 0000000000000000 0000000000000000 0000000000000000 0000000000000000=
=20
 NIP [00007fff878510a0] 0x7fff878510a0
 LR [0000000000000000] 0x0
 --- interrupt: 400
 Code: 73e90973 4082060c 38610038 4bffe5dd 7c7fe378 73e90d73 408205ec 38610=
038 4bff7ad9 7fff1b78 4bfff728 eb410088 <e95a0008> 71480001 4082078c e92900=
38=20
 ---[ end trace 0000000000000000 ]---

I don't know what caused this, but reverting the mm tree fixed the
failure.  So I have done that for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/hKY9hptkzjpmOW3tPSym29u
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSjlD4ACgkQAVBC80lX
0Gz8JQgAm7TSMchN48+LgSHwMRZ5R+78XYh/6ch8Z4qff4IawrCijY7pheXNG5zR
diFYPUGIrWtdXaKfSTiwi8VYQhwquEJaLpnKCPRMdMSwIgbc/uGuJi1tcYPoaYqT
9+TSll4dkrX8E/HDF+LScB5AUWw93ihuNbo6FPyJSNHxtHawnSArkU+f82+jKdXy
6V+qzOGhUNIe4Awm6F0s0bIfvfn1GYIIlpf64OCEvMGyEmSKwCLUyLxH28/fSTu+
0L6lAN143/bOSyrRMUSwayF83x7bXsx9kvjF64F+U6w/1uemGTFfxvMtnN1SNNkx
rPbkm1m3jpyOF1/HgKUjYDgv/Fa7ng==
=lPNx
-----END PGP SIGNATURE-----

--Sig_/hKY9hptkzjpmOW3tPSym29u--

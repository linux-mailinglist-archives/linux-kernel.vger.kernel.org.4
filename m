Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7EA664F2D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 23:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235288AbjAJWy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 17:54:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjAJWxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 17:53:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A9263F70
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 14:51:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0E4E0B8188A
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 22:51:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A05CC433EF;
        Tue, 10 Jan 2023 22:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673391112;
        bh=5g1zRuG7y1lhwJhDEwBIOlahffMZh4x5LUGiqNyUHd4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lHlbINsQSygqIk4CfKYejhSE5F1ydCErVOpknFDrsjlHDvLA1gXMaJdBJidGriAPH
         k20F9/zg20J76+FeoBhppx03qG9ZXsJO4CC580TlWV3aoy1IlEmidgSed/r7sBTbKj
         1esQjPE/7wLss9+aPnRD7X/LGU27cc+DF2AYTIfcvTXGtQV1Bw2zARK89RqWe90uce
         9ksgRLh5xuXkfXQKkVXxHM1QSLkHptKXvkcnD0kSimRHABjzvU4/V7Y3byeKxiTbl0
         aHis3g+r2N+hiWre27YlvWLoucWhQrhd01fVN/hrubcJInrTCpfh7UEMIOzCCJhyiH
         yg2lyiJwbkKxA==
Date:   Tue, 10 Jan 2023 22:51:48 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 00/44] VMA tree type safety and remove __vma_adjust()
Message-ID: <Y73sBPPA+kaJCiZY@sirena.org.uk>
References: <20230105191517.3099082-1-Liam.Howlett@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rQGdJZ/9yQ/RpHny"
Content-Disposition: inline
In-Reply-To: <20230105191517.3099082-1-Liam.Howlett@oracle.com>
X-Cookie: Process promptly.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rQGdJZ/9yQ/RpHny
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 05, 2023 at 07:15:44PM +0000, Liam Howlett wrote:

> This patch set does two things: 1. Clean up, including removal of
> __vma_adjust() and 2. Extends the VMA iterator API to provide type
> safety to the VMA operations using the maple tree, as requested by Linus
> [1].

This series *appears* to be causing some fun issues in -next for the
past couple of days or so.  The initial failures were seen by KernelCI
on several platforms (I've mostly been trying various arm64 things, at
least 32 bit ARM is also affected).  The intial symptom seen is that a
go binary called skipgen that gets invoked as part of the testing
silently faults, tweaking things so that we get as far as running the
arm64 selftests results in much more useful output with various things
failing with actual error messages such as:

  ./fake_sigreturn_bad_magic: error while loading shared libraries: cannot =
make segment writable for relocation: Cannot allocate memory
  ./sve-test: error while loading shared libraries: cannot make segment wri=
table for relocation: Cannot allocate memory

I'm fairly sure we're not actually running out of memory, there's no OOM
killer activity, the amount of memory the system has appears to make no
difference and just replacing the kernel with a mainline build runs as
expected.

You can see the full run that produced the above errors at:

   https://lava.sirena.org.uk/scheduler/job/88257

which also embeds links to all the binaries used, exact commands run and
so on.  The failing binaries all appear to be execed from within a
testsuite, though it's not *all* binaries execed from within tests (eg,
vec-syscfg execs things and seems happy).

This has taken out a bunch of testsuites in KernelCI (and probably other
CI systems using test-definitions, though I didn't check).

I tried to bisect this but otherwise haven't made any effort to look at
the failure.  The bisect sadly got lost in this series since a lot of
the series either fails to build with:

/home/broonie/git/bisect/mm/madvise.c: In function 'madvise_update_vma':
/home/broonie/git/bisect/mm/madvise.c:165:25: error: implicit declaration o=
f function '__split_vma'; did you mean 'split_vma'? [-Werror=3Dimplicit-fun=
ction-declaration]
  165 |                 error =3D __split_vma(mm, vma, start, 1);
      |                         ^~~~~~~~~~~
      |                         split_vma

or fails to boot with something along the lines of:

<6>[    6.054380] Freeing initrd memory: 86880K
<1>[    6.087945] Unable to handle kernel NULL pointer dereference at virtu=
al address 0000000000000078
<1>[    6.088231] Mem abort info:
<1>[    6.088340]   ESR =3D 0x0000000096000004
<1>[    6.088504]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
<1>[    6.088671]   SET =3D 0, FnV =3D 0
<1>[    6.088802]   EA =3D 0, S1PTW =3D 0
<1>[    6.088929]   FSC =3D 0x04: level 0 translation fault
<1>[    6.089099] Data abort info:
<1>[    6.089210]   ISV =3D 0, ISS =3D 0x00000004
<1>[    6.089347]   CM =3D 0, WnR =3D 0
<1>[    6.089486] user pgtable: 4k pages, 48-bit VAs, pgdp=3D0000000043e330=
00
<1>[    6.089692] [0000000000000078] pgd=3D0000000000000000, p4d=3D00000000=
00000000
<0>[    6.090566] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
<4>[    6.090866] Modules linked in:
<4>[    6.091167] CPU: 0 PID: 42 Comm: modprobe Not tainted 6.2.0-rc1-00190=
-g505c59767243 #13
<4>[    6.091478] Hardware name: linux,dummy-virt (DT)
<4>[    6.091784] pstate: 63400005 (nZCv daif +PAN -UAO +TCO +DIT -SSBS BTY=
PE=3D--)
<4>[    6.092048] pc : mas_wr_walk+0x60/0x2d0
<4>[    6.092622] lr : mas_wr_store_entry.isra.0+0x80/0x4a0
<4>[    6.092798] sp : ffff80000821bb10
<4>[    6.092926] x29: ffff80000821bb10 x28: ffff000003fa4480 x27: 00000002=
00100073
<4>[    6.093206] x26: ffff000003fa41b0 x25: ffff000003fa43f0 x24: 00000000=
00000002
<4>[    6.093445] x23: 0000000ffffae021 x22: 0000000000000000 x21: ffff0000=
02a74440
<4>[    6.093685] x20: ffff000003fa4480 x19: ffff80000821bc48 x18: 00000000=
00000000
<4>[    6.093933] x17: 0000000000000000 x16: ffff000002b8da00 x15: ffff8000=
0821bc48
<4>[    6.094169] x14: 0000ffffae022fff x13: ffffffffffffffff x12: ffff0000=
02b8da0c
<4>[    6.094427] x11: ffff80000821bb68 x10: ffffd75265462458 x9 : ffff8000=
0821bc48
<4>[    6.094685] x8 : ffff80000821bbb8 x7 : ffff80000821bc48 x6 : ffffffff=
ffffffff
<4>[    6.094922] x5 : 000000000000000e x4 : 000000000000000e x3 : 00000000=
00000000
<4>[    6.095167] x2 : 0000000000000008 x1 : 000000000000000f x0 : ffff8000=
0821bb68
<4>[    6.095499] Call trace:
<4>[    6.095685]  mas_wr_walk+0x60/0x2d0
<4>[    6.095936]  mas_store_prealloc+0x50/0xa0
<4>[    6.096097]  mmap_region+0x520/0x784
<4>[    6.096232]  do_mmap+0x3b0/0x52c
<4>[    6.096347]  vm_mmap_pgoff+0xe4/0x10c
<4>[    6.096480]  ksys_mmap_pgoff+0x4c/0x204
<4>[    6.096621]  __arm64_sys_mmap+0x30/0x44
<4>[    6.096754]  invoke_syscall+0x48/0x114
<4>[    6.096900]  el0_svc_common.constprop.0+0x44/0xec
<4>[    6.097052]  do_el0_svc+0x38/0xb0
<4>[    6.097183]  el0_svc+0x2c/0x84
<4>[    6.097287]  el0t_64_sync_handler+0xf4/0x120
<4>[    6.097457]  el0t_64_sync+0x190/0x194
<0>[    6.097835] Code: 39402021 51000425 92401ca4 12001ca5 (f8647844)=20
<4>[    6.098294] ---[ end trace 0000000000000000 ]---

(not always exactly the same backtrace, but the mas_wr_walk() was always
there.)

The specific set of commits in next-20230110 where bisect got lost was:

505c59767243 madvise: use vmi iterator for __split_vma() and vma_merge()
1cfdd2a44d6b mmap: pass through vmi iterator to __split_vma()
7d718fd9873c sched: convert to vma iterator
2f94851ec717 mmap: use vmi version of vma_merge()
7e2dd18353a3 task_mmu: convert to vma iterator
756841b468f5 mm/mremap: use vmi version of vma_merge()
aaba4ba837fa mempolicy: convert to vma iterator
8193673ee5d8 coredump: convert to vma iterator
d4f7ebf41a44 mm: switch vma_merge(), split_vma(), and __split_vma to vma it=
erator
4b02758dc3c5 mlock: convert mlock to vma iterator
fd367dac089e include/linux/mm: declare different type of split_vma() for !C=
ONFIG_MMU
3a72a0174748 mm/damon: stop using vma_mas_store() for maple tree store
dd51a3ca1096 mm: change mprotect_fixup to vma iterator
b9e4eabb8f40 mmap: convert __vma_adjust() to use vma iterator
c6fc05242a09 userfaultfd: use vma iterator
b9000fd4c5a6 mmap-convert-__vma_adjust-to-use-vma-iterator-fix
bdfb333b0b2a ipc/shm: use the vma iterator for munmap calls
3128296746a1 mm: pass through vma iterator to __vma_adjust()
80c8eed1721e mm: add temporary vma iterator versions of vma_merge(), split_=
vma(), and __split_vma()
311129a7971c mmap: convert vma_expand() to use vma iterator
69e9b6c8a525 madvise: use split_vma() instead of __split_vma()
751f0a6713a9 mm: remove unnecessary write to vma iterator in __vma_adjust()
a7f83eb601ef mmap: change do_mas_munmap and do_mas_aligned_munmap() to use =
vma iterator
39fd6622223e mm: pass vma iterator through to __vma_adjust()

(that last one actually failed, the rest were skipped.)  Full bisect
log:

git bisect start
# bad: [435bf71af3a0aa8067f3b87ff9febf68b564dbb6] Add linux-next specific f=
iles for 20230110
git bisect bad 435bf71af3a0aa8067f3b87ff9febf68b564dbb6
# good: [1fe4fd6f5cad346e598593af36caeadc4f5d4fa9] Merge tag 'xfs-6.2-fixes=
-2' of git://git.kernel.org/pub/scm/fs/xfs/xfs-linux
git bisect good 1fe4fd6f5cad346e598593af36caeadc4f5d4fa9
# good: [57aac56e8af1628ef96055820f88ca547233b310] Merge branch 'drm-next' =
of git://git.freedesktop.org/git/drm/drm.git
git bisect good 57aac56e8af1628ef96055820f88ca547233b310
# good: [c9167d1c0ec75118a2859099255f68dc4d0779fd] Merge branch 'rcu/next' =
of git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
git bisect good c9167d1c0ec75118a2859099255f68dc4d0779fd
# good: [74f6598c9d8197774cfa9038c0cf0925cc5f178f] Merge branch 'for-next' =
of git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git
git bisect good 74f6598c9d8197774cfa9038c0cf0925cc5f178f
# bad: [f434860645df3dc10aae20654f17eb30955196c6] drivers/misc/open-dice: d=
on't touch VM_MAYSHARE
git bisect bad f434860645df3dc10aae20654f17eb30955196c6
# good: [f73d9ff6ef5a79d212319950dab7d6b1fdea9ee9] mm/page_reporting: repla=
ce rcu_access_pointer() with rcu_dereference_protected()
git bisect good f73d9ff6ef5a79d212319950dab7d6b1fdea9ee9
# skip: [311129a7971cb4b80038fca4b4ac0c6214dbc46f] mmap: convert vma_expand=
() to use vma iterator
git bisect skip 311129a7971cb4b80038fca4b4ac0c6214dbc46f
# bad: [85a9b62c63adb67becc48887b6e211a3760e1758] zram: correctly handle al=
l next_arg() cases
git bisect bad 85a9b62c63adb67becc48887b6e211a3760e1758
# good: [f355b8d96876e06a6879e8936297474fdf8b5e82] mm/mmap: remove prealloc=
ation from do_mas_align_munmap()
git bisect good f355b8d96876e06a6879e8936297474fdf8b5e82
# skip: [061dc47414898c882c8ffb55c60434f41e844cb7] mm: add vma iterator to =
vma_adjust() arguments
git bisect skip 061dc47414898c882c8ffb55c60434f41e844cb7
# skip: [751f0a6713a94e739a924d8729fd58628e119ef6] mm: remove unnecessary w=
rite to vma iterator in __vma_adjust()
git bisect skip 751f0a6713a94e739a924d8729fd58628e119ef6
# skip: [505c597672439d99cb42b11b5ea56fbf00746e0a] madvise: use vmi iterato=
r for __split_vma() and vma_merge()
git bisect skip 505c597672439d99cb42b11b5ea56fbf00746e0a
# skip: [b01b3b8a73656aa475df807c17e4a34254d3a4c1] mm: change munmap splitt=
ing order and move_vma()
git bisect skip b01b3b8a73656aa475df807c17e4a34254d3a4c1
# bad: [3eade064bd22a24bcde84bdf371fb746087f6c9b] mm: fix two spelling mist=
akes in highmem.h
git bisect bad 3eade064bd22a24bcde84bdf371fb746087f6c9b
# skip: [b9000fd4c5a64464e62e61da21f2101543b2e042] mmap-convert-__vma_adjus=
t-to-use-vma-iterator-fix
git bisect skip b9000fd4c5a64464e62e61da21f2101543b2e042
# skip: [a7f83eb601efc719889279bf9981b4b3f23f0084] mmap: change do_mas_munm=
ap and do_mas_aligned_munmap() to use vma iterator
git bisect skip a7f83eb601efc719889279bf9981b4b3f23f0084
# skip: [1b55bb7e3b16724e91020c168eb50c40a1f5df88] mmap: clean up mmap_regi=
on() unrolling
git bisect skip 1b55bb7e3b16724e91020c168eb50c40a1f5df88
# bad: [4b9c180dfc284fbbecad8feaa4b5f86a12d04e49] mm/mmap: remove __vma_adj=
ust()
git bisect bad 4b9c180dfc284fbbecad8feaa4b5f86a12d04e49
# skip: [3a72a017474833fca226699e3cc7a95cdf55d421] mm/damon: stop using vma=
_mas_store() for maple tree store
git bisect skip 3a72a017474833fca226699e3cc7a95cdf55d421
# skip: [bdfb333b0b2a025de350a01748be1406801f1f24] ipc/shm: use the vma ite=
rator for munmap calls
git bisect skip bdfb333b0b2a025de350a01748be1406801f1f24
# skip: [2f94851ec717a9b318ac57c011af349a5ef20f5e] mmap: use vmi version of=
 vma_merge()
git bisect skip 2f94851ec717a9b318ac57c011af349a5ef20f5e
# skip: [07364e5b9a1db3a939395c387e0222964b962561] mm: don't use __vma_adju=
st() in __split_vma()
git bisect skip 07364e5b9a1db3a939395c387e0222964b962561
# skip: [756841b468f59fd31c3dcd1ff574a2c582124a7e] mm/mremap: use vmi versi=
on of vma_merge()
git bisect skip 756841b468f59fd31c3dcd1ff574a2c582124a7e
# skip: [c6fc05242a095b7652e501ae73313730359a4bbb] userfaultfd: use vma ite=
rator
git bisect skip c6fc05242a095b7652e501ae73313730359a4bbb
# skip: [3128296746a14cb620247ffd3f8ff38dd4c58102] mm: pass through vma ite=
rator to __vma_adjust()
git bisect skip 3128296746a14cb620247ffd3f8ff38dd4c58102
# skip: [dd51a3ca1096d568a796b5b21851d9d07e5955eb] mm: change mprotect_fixu=
p to vma iterator
git bisect skip dd51a3ca1096d568a796b5b21851d9d07e5955eb
# skip: [d4f7ebf41a4428a3ea6f202e297b7584f1109a78] mm: switch vma_merge(), =
split_vma(), and __split_vma to vma iterator
git bisect skip d4f7ebf41a4428a3ea6f202e297b7584f1109a78
# skip: [d2297db1d48afba5b74eb002c1cbf7beb8a5c241] mm/mmap: use vma_prepare=
() and vma_complete() in vma_expand()
git bisect skip d2297db1d48afba5b74eb002c1cbf7beb8a5c241
# skip: [fd367dac089e27a60bc0700dc272428cb9da8446] include/linux/mm: declar=
e different type of split_vma() for !CONFIG_MMU
git bisect skip fd367dac089e27a60bc0700dc272428cb9da8446
# skip: [4b02758dc3c5f80582e4c822d28ef271828b8d68] mlock: convert mlock to =
vma iterator
git bisect skip 4b02758dc3c5f80582e4c822d28ef271828b8d68
# skip: [69e9b6c8a5256fdc6a5854375e6d231527f33247] madvise: use split_vma()=
 instead of __split_vma()
git bisect skip 69e9b6c8a5256fdc6a5854375e6d231527f33247
# skip: [0471d6b0df5e8afe03cb7ff3cd507dd8d45dd0ac] mm/mmap: refactor lockin=
g out of __vma_adjust()
git bisect skip 0471d6b0df5e8afe03cb7ff3cd507dd8d45dd0ac
# skip: [b9e4eabb8f40e7dae4b0d5f33826b6d27c33a6e7] mmap: convert __vma_adju=
st() to use vma iterator
git bisect skip b9e4eabb8f40e7dae4b0d5f33826b6d27c33a6e7
# skip: [edd9f4829c57c856109764d6c1140428b9f275b5] mm/mmap: move anon_vma s=
etting in __vma_adjust()
git bisect skip edd9f4829c57c856109764d6c1140428b9f275b5
# skip: [1cfdd2a44d6b142dc6c16108e1efc8404c21f3b6] mmap: pass through vmi i=
terator to __split_vma()
git bisect skip 1cfdd2a44d6b142dc6c16108e1efc8404c21f3b6
# skip: [fc63eb0e3016002ee0683829f0673463ee0d855e] mm/mmap: introduce init_=
vma_prep() and init_multi_vma_prep()
git bisect skip fc63eb0e3016002ee0683829f0673463ee0d855e
# bad: [39fd6622223e2f26f585c2c19cf69443ba5b3549] mm: pass vma iterator thr=
ough to __vma_adjust()
git bisect bad 39fd6622223e2f26f585c2c19cf69443ba5b3549
# skip: [7d718fd9873c157fc791816829ece1a96e7ac4d3] sched: convert to vma it=
erator
git bisect skip 7d718fd9873c157fc791816829ece1a96e7ac4d3
# skip: [aaba4ba837fa08bb6e822d0726a6718f861661d7] mempolicy: convert to vm=
a iterator
git bisect skip aaba4ba837fa08bb6e822d0726a6718f861661d7
# skip: [7e2dd18353a3f09d2ad16cd4977dd9d716104863] task_mmu: convert to vma=
 iterator
git bisect skip 7e2dd18353a3f09d2ad16cd4977dd9d716104863
# skip: [8193673ee5d8a88563cfd5f5befe299c41d49e54] coredump: convert to vma=
 iterator
git bisect skip 8193673ee5d8a88563cfd5f5befe299c41d49e54
# skip: [80c8eed1721ee630b2494f14f239d7b3389dac7e] mm: add temporary vma it=
erator versions of vma_merge(), split_vma(), and __split_vma()
git bisect skip 80c8eed1721ee630b2494f14f239d7b3389dac7e
# only skipped commits left to test
# possible first bad commit: [39fd6622223e2f26f585c2c19cf69443ba5b3549] mm:=
 pass vma iterator through to __vma_adjust()
# possible first bad commit: [751f0a6713a94e739a924d8729fd58628e119ef6] mm:=
 remove unnecessary write to vma iterator in __vma_adjust()
# possible first bad commit: [69e9b6c8a5256fdc6a5854375e6d231527f33247] mad=
vise: use split_vma() instead of __split_vma()
# possible first bad commit: [3128296746a14cb620247ffd3f8ff38dd4c58102] mm:=
 pass through vma iterator to __vma_adjust()
# possible first bad commit: [b9000fd4c5a64464e62e61da21f2101543b2e042] mma=
p-convert-__vma_adjust-to-use-vma-iterator-fix
# possible first bad commit: [b9e4eabb8f40e7dae4b0d5f33826b6d27c33a6e7] mma=
p: convert __vma_adjust() to use vma iterator
# possible first bad commit: [3a72a017474833fca226699e3cc7a95cdf55d421] mm/=
damon: stop using vma_mas_store() for maple tree store
# possible first bad commit: [fd367dac089e27a60bc0700dc272428cb9da8446] inc=
lude/linux/mm: declare different type of split_vma() for !CONFIG_MMU
# possible first bad commit: [d4f7ebf41a4428a3ea6f202e297b7584f1109a78] mm:=
 switch vma_merge(), split_vma(), and __split_vma to vma iterator
# possible first bad commit: [756841b468f59fd31c3dcd1ff574a2c582124a7e] mm/=
mremap: use vmi version of vma_merge()
# possible first bad commit: [2f94851ec717a9b318ac57c011af349a5ef20f5e] mma=
p: use vmi version of vma_merge()
# possible first bad commit: [1cfdd2a44d6b142dc6c16108e1efc8404c21f3b6] mma=
p: pass through vmi iterator to __split_vma()
# possible first bad commit: [505c597672439d99cb42b11b5ea56fbf00746e0a] mad=
vise: use vmi iterator for __split_vma() and vma_merge()
# possible first bad commit: [7d718fd9873c157fc791816829ece1a96e7ac4d3] sch=
ed: convert to vma iterator
# possible first bad commit: [7e2dd18353a3f09d2ad16cd4977dd9d716104863] tas=
k_mmu: convert to vma iterator
# possible first bad commit: [aaba4ba837fa08bb6e822d0726a6718f861661d7] mem=
policy: convert to vma iterator
# possible first bad commit: [8193673ee5d8a88563cfd5f5befe299c41d49e54] cor=
edump: convert to vma iterator
# possible first bad commit: [4b02758dc3c5f80582e4c822d28ef271828b8d68] mlo=
ck: convert mlock to vma iterator
# possible first bad commit: [dd51a3ca1096d568a796b5b21851d9d07e5955eb] mm:=
 change mprotect_fixup to vma iterator
# possible first bad commit: [c6fc05242a095b7652e501ae73313730359a4bbb] use=
rfaultfd: use vma iterator
# possible first bad commit: [bdfb333b0b2a025de350a01748be1406801f1f24] ipc=
/shm: use the vma iterator for munmap calls
# possible first bad commit: [80c8eed1721ee630b2494f14f239d7b3389dac7e] mm:=
 add temporary vma iterator versions of vma_merge(), split_vma(), and __spl=
it_vma()
# possible first bad commit: [311129a7971cb4b80038fca4b4ac0c6214dbc46f] mma=
p: convert vma_expand() to use vma iterator
# possible first bad commit: [a7f83eb601efc719889279bf9981b4b3f23f0084] mma=
p: change do_mas_munmap and do_mas_aligned_munmap() to use vma iterator

--rQGdJZ/9yQ/RpHny
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmO97AMACgkQJNaLcl1U
h9Dp9Af8Cfes953tKmaDvLUKMNbgDDullDcztMcpZSzWqJCbGa62tv4M0cd4diqd
PFlhQ4Pt9cACywCmdY5rsu0XEijrHLh4Q5OMsM77vjwB7c0eM5dZ+ZuUDE8RakTR
pTb/uUHbKcri/5S4+1O6alTsdV937JXw65Q5LLWbCvuX4ZTo9ygT3o4vNlyd4eai
Ptbi8IFIQDPxqdWs3uB8EiEmGt8eWpzBSYeUybyNFK3WQr3NlPSvB+QlBcCYv5Jh
3JHjk1CrMvYMapmJwgFR8kFvNAwoQOMnZoxdj92RyDcBqiidZGrxdtTmw3I1jstU
KdvntYPQbEnRUTLOUMtdzDRP9UVjng==
=fUl7
-----END PGP SIGNATURE-----

--rQGdJZ/9yQ/RpHny--

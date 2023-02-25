Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2736A2B9A
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 20:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbjBYT6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 14:58:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjBYT6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 14:58:39 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F7216AEB;
        Sat, 25 Feb 2023 11:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1677355106; i=deller@gmx.de;
        bh=YkYucz17GSZWPtoOISSnGu7cJxGHlyciXBkecwBVDcA=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=E9VgtiTycyLXcYbKCF91Nf4pk8k0gXJ8Zt2lKrwABCGKq+SCIG/SLjE2r6nxHSJzG
         YM9sljoX+aDW74+FA3ncZZG1DUow6GtgJ+ZHz6bJdVtt9bb3aH16tZBZA6/GorlRyu
         S+3SDai9r1fKn+vzokz+dZ1ubNR5X5koMuwfYynAp97x1NB30E+UgT2rlZkdlPb/9s
         Ap9/WQalBlkgZzkR2jCv0bXayjs1cQZflWAMpeEnaJWtYvVjZAoE1nw0BKrx+fq+mJ
         3WrJFg4BkXnWydjJ4ZStDpbLksi6CP/EFu12vfbSHaD16oM3h9Pbb6G/IyR8//Npq1
         1/DYydxDWx2uQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([92.116.139.251]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M59C8-1pX79K2xHA-0016fK; Sat, 25
 Feb 2023 20:58:26 +0100
Message-ID: <a39d97c1-2ced-d159-f742-e5c6008f79ee@gmx.de>
Date:   Sat, 25 Feb 2023 20:58:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [Syzkaller & bisect] There is "xfs_dquot_alloc" related BUG in
 v6.2 in guest
Content-Language: en-US
To:     Pengfei Xu <pengfei.xu@intel.com>,
        linux-xfs <linux-xfs@vger.kernel.org>
Cc:     asml.silence@gmail.com, geert@linux-m68k.org,
        linux-kernel@vger.kernel.org, heng.su@intel.com
References: <Y/g/femUL7jZ9gF3@xpf.sh.intel.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <Y/g/femUL7jZ9gF3@xpf.sh.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zFjy7zM7kQgttKY7AdWK8QOY5DW1tVcCEpTXA0dbG7T//w0QzNU
 eer9q9Bo+uuvKAfVpPa0nvQopZ/y6WwOi/IW3Wa55ObgEQ58DOsQupahKlhakpVti6sAwwk
 gcJrA5RItyMENdr3/2aryxWzckxJ6VvDH+xOcDEqZxgvqmv/+9zSyUvUJJgpWk1lNcsUPnX
 v9+7uI0zgBOgUvXzWZPUQ==
UI-OutboundReport: notjunk:1;M01:P0:RNtvFinAGmA=;qw8tztkx3MF9T7OOrv9vmimDcF+
 btlNY2+0piR5r5MubSqmuEj9elfIM9wLFSaJrMqlLt0nSV343XjTyoMjR6E9i57ZHWg5ZxkDO
 0Ou6EhxlsSypUtEtrVo24WwvqIaLwAuwZVo6ndmxsWgvy4ZaQeit/C/YDFlcGhIWNLTt2FSRZ
 AmkDv6OwZWfZNtlOcIsyfKRxShPMmbrYEUhTHVBeS1Aes0Ba8CcaphTgoWL3arL/BgmrrdcsC
 pVdJG22PMTk60XLEGJshSt6pg8W9+X2UggEkwcZxxn275OikDpB2nExWWDn7o6YjVVFIwtKY0
 4lTJKz9Igb3MVZ8D7/25wRk2q5CkIGmlYRKKdGA9Pl/+yJv8Xp+s8dCEaCQGujgxx5z/4v6d7
 4eDivoG9ShSqVbsR18P1Ssu/IBZnAQMu0gMoEvTklqb+NULl+t104hl9fQgbYIuQvbFjUphNK
 obZ/QJfCXTAiIShLTEnzOiiSqYJqhXucWAwauU0zjlwwnsz1HksTeIKgZtssskhTiieoJUFcl
 nhK+8Hf+BYo+xwtfsosC5Ah3dLb0+mHxN5xCFQfSjZr6i6kydsElb9SEsUeXw7HSzsq6XJZug
 AXRTSvrDj+Eq7bJro775rExRp0A2ZpVygIMQf2XZJ9C4RO9hFka82Qj2501P3qbh/6nx5r1ZD
 GFUwg91zFnUPdJcxxXyeqR7KxC370JK/uYj9XnBjJSPSolVFPEHZImM/tR2mBM22GldReKJpB
 V6C5dizJw8gsYzoBKq1uyaRDaooDktz2VBTC5kh2phYNKSwI/47RcsTnUGuyfrHghoc0zFOhy
 isvaAOMk/ooo6HrEUlnln5wf3jFfDVqtxMDxEgGQFBy1Gc04S61vdjvzNzEjWGoY2uX3L7P0y
 sIy72nusidrXmT8BRERKs+KLIGlSTQmJ3dnFQ5I/iiZ5Z2Iq4OF9yAORsoaq2L4vDI48POsgU
 7K/M+YypCN8luUxSj2PN/OFVUss=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looping in xfs mailing list as this seems to be a XFS problem...

On 2/24/23 05:39, Pengfei Xu wrote:
> Hi Helge Deller,
>
> Greeting!
>
> Reproduced code: https://github.com/xupengfe/syzkaller_logs/blob/main/23=
0222_152458_xfs_dquot_alloc_bug/repro.c
> Kconfig: https://github.com/xupengfe/syzkaller_logs/blob/main/230222_152=
458_xfs_dquot_alloc_bug/kconfig_origin
> Issue dmesg: https://github.com/xupengfe/syzkaller_logs/blob/main/230222=
_152458_xfs_dquot_alloc_bug/v6.2_c9c3395d5e3dcc6daee66c6908354d47bf98cb0c_=
dmesg.log
> Bisect info(Might not be correct this time, but just gave some clues to =
the problem)
> https://github.com/xupengfe/syzkaller_logs/blob/main/230222_152458_xfs_d=
quot_alloc_bug/bisect_info.log
>
> All detailed info: https://github.com/xupengfe/syzkaller_logs/tree/main/=
230222_152458_xfs_dquot_alloc_bug
>
> Platform: ADL-S, and it could be reproduced on x86 platform in guest.
> There is "xfs_dquot_alloc" related BUG in v6.2:
>
> [   71.149963] xfs filesystem being mounted at /root/syzkaller.6TPmw0/0/=
file0 supports timestamps until 2038 (0x7fffffff)
> [   71.150653] 00000000: 58 41 47 49 00 00 00 01 00 00 00 00 00 00 80 00=
  XAGI............
> [   71.151006] 00000010: 00 00 00 40 00 00 00 06 00 00 00 01 00 00 00 37=
  ...@...........7
> [   71.151321] 00000020: 00 00 00 20 ff ff ff ff ff ff ff ff ff ff ff ff=
  ... ............
> [   71.151633] 00000030: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff=
  ................
> [   71.151946] 00000040: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff=
  ................
> [   71.152259] 00000050: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff=
  ................
> [   71.152570] 00000060: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff=
  ................
> [   71.152881] 00000070: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff=
  ................
> [   71.153193] 00000080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff=
  ................
> [   71.153607] 00000090: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff=
  ................
> [   71.153921] 000000a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff=
  ................
> [   71.154237] 000000b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff=
  ................
> [   71.154549] 000000c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff=
  ................
> [   71.154865] 000000d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff=
  ................
> [   71.155180] 000000e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff=
  ................
> [   71.155494] 000000f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff=
  ................
> [   71.155807] 00000100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff=
  ................
> [   71.156119] 00000110: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff=
  ................
> [   71.156433] 00000120: ff ff ff ff ff ff ff ff 00 00 00 00 00 00 00 00=
  ................
> [   71.156747] 00000130: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=
  ................
> [   71.157059] 00000140: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=
  ................
> [   71.157382] 00000150: 00 00 00 00 00 00 00 00                        =
  ........
> [   71.157671] XFS (loop3): Internal error xfs_iunlink_remove_inode at l=
ine 2013 of file fs/xfs/xfs_inode.c.  Caller xfs_ifree+0xed/0x9e0
> [   71.158154] CPU: 1 PID: 137 Comm: kworker/1:3 Not tainted 6.2.0-c9c33=
95d5e3d #1
> [   71.158447] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BI=
OS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> [   71.158890] Workqueue: xfs-inodegc/loop3 xfs_inodegc_worker
> [   71.159117] Call Trace:
> [   71.159220]  <TASK>
> [   71.159313]  dump_stack_lvl+0xa7/0xdb
> [   71.159478]  dump_stack+0x19/0x1f
> [   71.159621]  xfs_corruption_error+0xd7/0xe0
> [   71.159805]  ? xfs_ifree+0xed/0x9e0
> [   71.159957]  xfs_iunlink_remove+0x32e/0x590
> [   71.160136]  ? xfs_ifree+0xed/0x9e0
> [   71.160290]  xfs_ifree+0xed/0x9e0
> [   71.160432]  ? write_comp_data+0x2f/0x90
> [   71.160600]  ? xfs_trans_ijoin+0x47/0x70
> [   71.160768]  ? __sanitizer_cov_trace_pc+0x25/0x60
> [   71.160964]  ? xfs_trans_add_item+0x79/0x1c0
> [   71.161151]  xfs_inactive_ifree+0xf8/0x2a0
> [   71.161324]  xfs_inactive+0x226/0x340
> [   71.161482]  xfs_inodegc_worker+0xd3/0x430
> [   71.161657]  process_one_work+0x3b1/0x960
> [   71.161837]  worker_thread+0x52/0x660
> [   71.161999]  ? __pfx_worker_thread+0x10/0x10
> [   71.162184]  kthread+0x161/0x1a0
> [   71.162331]  ? __pfx_kthread+0x10/0x10
> [   71.162498]  ret_from_fork+0x29/0x50
> [   71.162670]  </TASK>
> [   71.162773] XFS (loop3): Corruption detected. Unmount and run xfs_rep=
air
> [   71.163039] XFS (loop3): xfs_inactive_ifree: xfs_ifree returned error=
 -117
> [   71.163869] repro: attempt to access beyond end of device
> [   71.163869] loop3: rw=3D432129, sector=3D65535, nr_sectors =3D 16 lim=
it=3D65536
> [   71.164410] XFS (loop3): log I/O error -5
> [   71.166002] XFS (loop3): Metadata I/O Error (0x1) detected at xfs_ina=
ctive_ifree+0x232/0x2a0 (fs/xfs/xfs_inode.c:1612).  Shutting down filesyst=
em.
> [   71.166541] XFS (loop3): Please unmount the filesystem and rectify th=
e problem(s)
> [   71.167188] XFS (loop1): DAX unsupported by block device. Turning off=
 DAX.
> [   71.167530] XFS (loop7): DAX unsupported by block device. Turning off=
 DAX.
> [   71.167859] XFS (loop6): DAX unsupported by block device. Turning off=
 DAX.
> [   71.168188] XFS (loop4): DAX unsupported by block device. Turning off=
 DAX.
> [   71.168554] XFS (loop1): Mounting V4 Filesystem 86ecfda0-089a-461f-b0=
78-1b43afedebc1
> [   71.168995] XFS (loop7): Mounting V4 Filesystem 86ecfda0-089a-461f-b0=
78-1b43afedebc1
> [   71.169595] XFS (loop2): Unmounting Filesystem 86ecfda0-089a-461f-b07=
8-1b43afedebc1
> [   71.169614] XFS (loop6): Mounting V4 Filesystem 86ecfda0-089a-461f-b0=
78-1b43afedebc1
> [   71.170444] XFS (loop4): Mounting V4 Filesystem 86ecfda0-089a-461f-b0=
78-1b43afedebc1
> [   71.172161] XFS (loop3): Quotacheck: Unsuccessful (Error -5): Disabli=
ng quotas.
> [   71.172510] xfs filesystem being mounted at /root/syzkaller.mc3H24/0/=
file0 supports timestamps until 2038 (0x7fffffff)
> [   71.174633] XFS (loop3): Unmounting Filesystem 86ecfda0-089a-461f-b07=
8-1b43afedebc1
> [   71.175936] XFS (loop5): DAX unsupported by block device. Turning off=
 DAX.
> [   71.176303] XFS (loop5): Mounting V4 Filesystem 86ecfda0-089a-461f-b0=
78-1b43afedebc1
> [   71.178679] XFS (loop4): totally zeroed log
> [   71.179069] XFS (loop4): Ending clean mount
> [   71.179442] XFS (loop4): Quotacheck needed: Please wait.
> [   71.183738] XFS (loop6): totally zeroed log
> [   71.184537] repro: attempt to access beyond end of device
> [   71.184537] loop4: rw=3D432129, sector=3D65535, nr_sectors =3D 16 lim=
it=3D65536
> [   71.184637] XFS (loop6): Ending clean mount
> [   71.185052] XFS (loop4): log I/O error -5
> [   71.185339] XFS (loop6): Quotacheck needed: Please wait.
> [   71.185404] XFS (loop4): Filesystem has been shut down due to log err=
or (0x2).
> [   71.185883] XFS (loop4): Please unmount the filesystem and rectify th=
e problem(s).
> [   71.186372] XFS (loop4): Quotacheck: Unsuccessful (Error -5): Disabli=
ng quotas.
> [   71.186705] xfs filesystem being mounted at /root/syzkaller.uq7iOt/0/=
file0 supports timestamps until 2038 (0x7fffffff)
> [   71.187608] repro: attempt to access beyond end of device
> [   71.187608] loop6: rw=3D432129, sector=3D65535, nr_sectors =3D 16 lim=
it=3D65536
> [   71.188127] XFS (loop6): log I/O error -5
> [   71.188317] XFS (loop6): Filesystem has been shut down due to log err=
or (0x2).
> [   71.188599] XFS (loop6): Please unmount the filesystem and rectify th=
e problem(s).
> [   71.188998] XFS (loop6): Quotacheck: Unsuccessful (Error -5): Disabli=
ng quotas.
> [   71.189324] xfs filesystem being mounted at /root/syzkaller.OjSrkA/0/=
file0 supports timestamps until 2038 (0x7fffffff)
> [   71.191782] XFS (loop4): Unmounting Filesystem 86ecfda0-089a-461f-b07=
8-1b43afedebc1
> [   71.193911] XFS (loop6): Unmounting Filesystem 86ecfda0-089a-461f-b07=
8-1b43afedebc1
> [   71.207573] XFS (loop1): totally zeroed log
> [   71.207813] XFS (loop7): totally zeroed log
> [   71.208396] XFS (loop7): Ending clean mount
> [   71.208664] XFS (loop1): Ending clean mount
> [   71.209093] XFS (loop1): Quotacheck needed: Please wait.
> [   71.210841] XFS (loop7): Quotacheck needed: Please wait.
> [   71.216659] repro: attempt to access beyond end of device
> [   71.216659] loop7: rw=3D432129, sector=3D65535, nr_sectors =3D 16 lim=
it=3D65536
> [   71.217165] XFS (loop7): log I/O error -5
> [   71.217375] XFS (loop7): Filesystem has been shut down due to log err=
or (0x2).
> [   71.217674] XFS (loop7): Please unmount the filesystem and rectify th=
e problem(s).
> [   71.218071] XFS (loop7): Quotacheck: Unsuccessful (Error -5): Disabli=
ng quotas.
> [   71.218402] xfs filesystem being mounted at /root/syzkaller.Q5dMMG/0/=
file0 supports timestamps until 2038 (0x7fffffff)
> [   71.219906] XFS (loop7): Unmounting Filesystem 86ecfda0-089a-461f-b07=
8-1b43afedebc1
> [   71.224443] repro: attempt to access beyond end of device
> [   71.224443] loop1: rw=3D432129, sector=3D65535, nr_sectors =3D 16 lim=
it=3D65536
> [   71.224960] XFS (loop1): log I/O error -5
> [   71.225151] XFS (loop1): Filesystem has been shut down due to log err=
or (0x2).
> [   71.225543] XFS (loop1): Please unmount the filesystem and rectify th=
e problem(s).
> [   71.225966] XFS (loop1): Quotacheck: Unsuccessful (Error -5): Disabli=
ng quotas.
> [   71.226310] xfs filesystem being mounted at /root/syzkaller.qCVHXV/0/=
file0 supports timestamps until 2038 (0x7fffffff)
> [   71.227591] BUG: kernel NULL pointer dereference, address: 0000000000=
0002a8
> [   71.227873] #PF: supervisor read access in kernel mode
> [   71.228077] #PF: error_code(0x0000) - not-present page
> [   71.228280] PGD c313067 P4D c313067 PUD c1fe067 PMD 0
> [   71.228494] Oops: 0000 [#1] PREEMPT SMP NOPTI
> [   71.228673] CPU: 0 PID: 161 Comm: kworker/0:4 Not tainted 6.2.0-c9c33=
95d5e3d #1
> [   71.228961] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BI=
OS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> [   71.229400] Workqueue: xfs-inodegc/loop1 xfs_inodegc_worker
> [   71.229626] RIP: 0010:xfs_dquot_alloc+0x95/0x1e0
> [   71.229820] Code: 80 15 ad 85 48 c7 c6 7c 6b 92 83 e8 75 0f 6b ff 49 =
8b 8d 60 01 00 00 44 89 e0 31 d2 48 c7 c6 18 ae 8f 83 48 8d bb 18 02 00 00=
 <f7> b1 a8 02 2
> [   71.230528] RSP: 0018:ffffc90000babc20 EFLAGS: 00010246
> [   71.230737] RAX: 0000000000000009 RBX: ffff8880093c98c0 RCX: 00000000=
00000000
> [   71.231014] RDX: 0000000000000000 RSI: ffffffff838fae18 RDI: ffff8880=
093c9ad8
> [   71.231292] RBP: ffffc90000babc48 R08: 0000000000000002 R09: 00000000=
00000000
> [   71.231570] R10: ffffc90000baba80 R11: ffff88800af08d98 R12: 00000000=
00000009
> [   71.231850] R13: ffff88800c4bc000 R14: ffff88800c4bc000 R15: 00000000=
00000004
> [   71.232129] FS:  0000000000000000(0000) GS:ffff88807dc00000(0000) knl=
GS:0000000000000000
> [   71.232441] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   71.232668] CR2: 00000000000002a8 CR3: 000000000a1d2002 CR4: 00000000=
00770ef0
> [   71.232949] PKRU: 55555554
> [   71.233061] Call Trace:
> [   71.233162]  <TASK>
> [   71.233254]  xfs_qm_dqread+0x46/0x440
> [   71.233410]  ? xfs_qm_dqget_inode+0x13e/0x500
> [   71.233596]  xfs_qm_dqget_inode+0x154/0x500
> [   71.233774]  xfs_qm_dqattach_one+0x142/0x3c0
> [   71.233961]  xfs_qm_dqattach_locked+0x14a/0x170
> [   71.234149]  xfs_qm_dqattach+0x52/0x80
> [   71.234307]  xfs_inactive+0x186/0x340
> [   71.234461]  xfs_inodegc_worker+0xd3/0x430
> [   71.234630]  process_one_work+0x3b1/0x960
> [   71.234802]  worker_thread+0x52/0x660
> [   71.234957]  ? __pfx_worker_thread+0x10/0x10
> [   71.235136]  kthread+0x161/0x1a0
> [   71.235279]  ? __pfx_kthread+0x10/0x10
> [   71.235442]  ret_from_fork+0x29/0x50
> [   71.235602]  </TASK>
> [   71.235696] Modules linked in:
> [   71.235826] CR2: 00000000000002a8
> [   71.235964] ---[ end trace 0000000000000000 ]---
>
> Reporting the above issue and providing a reproduced way seems valuable.
>
> But not sure report to who in kernel community.
> So used RIP: "xfs_dquot_alloc" key word to bisect between v6.2 and v5.11=
.
> I know there is BUG also but with some other RIP info.
>
> Related commit:
> 29837019d5ebb80a5f180af3107a0645c731a770
> Merge tag 'io_uring-5.19-2022-07-08' of git://git.kernel.dk/linux-block
>
> This might not be the right point of suspicion.
> Could you help to take a look or add the correct developer for this issu=
e?
> Thanks a lot!
>
> ---
>
> If you don't need an environment to reproduce the problem or if you alre=
ady
> have one, please ignore the following information.
>
> How to reproduce:
> git clone https://gitlab.com/xupengfe/repro_vm_env.git
> cd repro_vm_env
> tar -xvf repro_vm_env.tar.gz
> cd repro_vm_env; ./start3.sh  // it needs qemu-system-x86_64 and I used =
v7.1.0
>     // start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058=
f65 v6.2-rc5 kernel
>     // You could change the bzImage_xxx as you want
> In vm and login with root,  there is no password for root.
>
> After login vm successfully, you could transfer reproduced binary to the=
 VM by below way, and reproduce the problem:
> gcc -pthread -o repro repro.c
> scp -P 10023 repro root@localhost:/root/
>
> Get the bzImage for target kernel:
> Please use target kconfig and copy it to kernel_src/.config
> make olddefconfig
> make -jx bzImage           //x should equal or less than cpu num your pc=
 has
>
> Fill the bzImage file into above start3.sh to load the target kernel vm.
>
>
> Tips:
> If you already have qemu-system-x86_64, please ignore below info.
> If you want to install qemu v7.1.0 version:
> git clone https://github.com/qemu/qemu.git
> cd qemu
> git checkout -f v7.1.0
> mkdir build
> cd build
> yum install -y ninja-build.x86_64
> ../configure --target-list=3Dx86_64-softmmu --enable-kvm --enable-vnc --=
enable-gtk --enable-sdl
> make
> make install
>
> Thanks!
> BR.


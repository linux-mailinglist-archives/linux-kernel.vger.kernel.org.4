Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 208DA613FBD
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 22:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbiJaVQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 17:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbiJaVQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 17:16:02 -0400
Received: from hermod.demsh.org (hermod.demsh.org [45.140.147.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3000102C;
        Mon, 31 Oct 2022 14:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=demsh.org; s=022020;
        t=1667250954;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=KROpSdQBC/s9Cd8fpqMe8RrdGK47IhlV96du1YYPKBE=;
        b=FEbijARnKetW9u6jhxqQ5G1KCiq4ipQLk8XD8r6UX+RdcM2aHzoiGcCRKO2xP6okdk6Zzm
        W2wzpA4n72N7FSOv8EmkCpmyKAV8IUPpQPonGKUup1omU5mAGoQvLJdMqAVr1x18Y5Oaws
        IDtw9akws3OyB2CgzcEc2dJA47B4gPIc1QDAoT3ww0mr+ZW8VeOdIgU4mGUoOzFemmgEhh
        3tmCRRnp66Ai8DwCBDsQjM0GvYsyPTh4h357ycbbo72u7v4wwwbkvYcOJ+crk1qUuADVjZ
        Y7A2BrRa+w2EzhKTtaWrprk6SySx/ToEjFTEF1p5H5+tf6FnFSIAJyrhn1bTjg==
Received: from xps.demsh.org (algiz.demsh.org [94.103.82.47])
        by hermod.demsh.org (OpenSMTPD) with ESMTPSA id d3145162 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO) auth=yes user=me;
        Mon, 31 Oct 2022 21:15:54 +0000 (UTC)
Date:   Tue, 1 Nov 2022 00:15:58 +0300
From:   Dmitrii Tcvetkov <me@demsh.org>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Song Liu <song@kernel.org>,
        linux-raid@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [bisected] RAID1 direct IO redirecting sector loop since 6.0
Message-ID: <20221101001558.648ee024@xps.demsh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
                                                                           =
             =20
I have LVM on mdraid RAID1 array of 2 HDDs, LVs are raw disk images for    =
                   =20
QEMU 7.1.0 guests. Complete storage stack is: lvm(mdadm(luks(gpt(SATA HDD))=
)). LUKS2 is       =20
deliberately with 4096 sectors despite underlying drive having 512 byte sec=
tors. Problem     =20
reproduces on kernels 6.0+ including 6.1-rc3.                              =
                   =20
                                                                =20
Host kernel:                                                               =
                   =20
Linux version 6.1-rc3 (portage@heim.demsh.org) (gcc (Gentoo 11.3.0 p4)     =
                   =20
11.3.0, GNU ld (Gentoo 2.38 p4) 2.38) #1 SMP                               =
                   =20
                                                                           =
                   =20
#lsblk -t -a                                                               =
                   =20
NAME                 ALIGNMENT MIN-IO OPT-IO PHY-SEC LOG-SEC ROTA SCHED RQ-=
SIZE  RA WSAME                                                             =
                                        =20
...                                                                        =
                   =20
sdd                          0    512      0     512     512    1 bfq      =
  64 128    0B
=E2=94=94=E2=94=80sdd2                       0    512      0     512     51=
2    1 bfq        64 128    0B
  =E2=94=94=E2=94=80raid1                    0   4096      0    4096    409=
6    1           128 128    0B
    =E2=94=94=E2=94=80md0                    0   4096      0    4096    409=
6    1           128 128    0B
      =E2=94=9C=E2=94=80lvmraid-zfs          0   4096      0    4096    409=
6    1           128 128    0B
      =E2=94=9C=E2=94=80lvmraid-obsd         0   4096      0    4096    409=
6    1           128 128    0B
      =E2=94=94=E2=94=80lvmraid-wrk          0   4096      0    4096    409=
6    1           128 128    0B
sde                          0    512      0     512     512    1 bfq      =
  64 128    0B
=E2=94=94=E2=94=80sde2                       0    512      0     512     51=
2    1 bfq        64 128    0B
  =E2=94=94=E2=94=80raid2                    0   4096      0    4096    409=
6    1           128 128    0B
    =E2=94=94=E2=94=80md0                    0   4096      0    4096    409=
6    1           128 128    0B
      =E2=94=9C=E2=94=80lvmraid-zfs          0   4096      0    4096    409=
6    1           128 128    0B
      =E2=94=9C=E2=94=80lvmraid-obsd         0   4096      0    4096    409=
6    1           128 128    0B
      =E2=94=94=E2=94=80lvmraid-wrk          0   4096      0    4096    409=
6    1           128 128    0B

sdd2 and sde2 are GPT partitions, raid1 and raid2 are LUKS2 devices, comman=
d:
# cryptsetup luksFormat --sector-size 4096 /dev/sdd2
# cryptsetup luksFormat --sector-size 4096 /dev/sde2
md0 command:
# mdadm --create --level=3D1 --metadata=3D1.2 --raid-devices=3D2 /dev/md0 /=
dev/mapper/raid1 /dev/mapper/raid2
LV command:
# pvcreate /dev/md0
# vgcreate lvmraid /de/vmd0
# lvcreate -n wrk -L 20G lvmraid

# cat /proc/mdstat
Personalities : [raid0] [raid1] [raid10] [raid6] [raid5] [raid4]=20
md0 : active raid1 dm-6[1] dm-5[2]
      685644544 blocks super 1.2 [2/2] [UU]
      bitmap: 0/6 pages [0KB], 65536KB chunk

All guests are started like this:
# cat run.sh
DISK=3D"/dev/lvmraid/wrk"

qemu-system-x86_64 -enable-kvm -smp 4 -m 8G -cpu host -machine q35         =
       \
-drive file=3D$DISK,format=3Draw,if=3Dnone,id=3Dhdd,cache=3Dnone,aio=3Dio_u=
ring               \
-device virtio-scsi-pci,id=3Dscsi                                          =
         \
-device scsi-hd,drive=3Dhdd,logical_block_size=3D4096,physical_block_size=
=3D4096        \
-nodefaults                                                                =
       \
-object rng-random,filename=3D/dev/urandom,id=3Drng0                       =
           \
-device virtio-rng-pci,rng=3Drng0                                          =
         \
-vga qxl -spice port=3D5090,disable-ticketing=3Don -machine usb=3Don -devic=
e usb-tablet \
-netdev bridge,br=3Dbr0,id=3Dpub -device virtio-net-pci,netdev=3Dpub

Each guest uses it's own LV in lvmraid and own spice port.

One guest at a time works fine on all kernels. After upgrading KVM host ker=
nel
to 6.0 starting second guest using LV from the same VG results in second
guest sleeping in D state seemingly indefinetely.

These messages appear in dmesg in a loop:
[  852.721444] md/raid1:md0: redirecting sector 62916608 to other
mirror: dm-5
[  852.721519] md/raid1:md0: dm-5: rescheduling sector 62916608=20
[  852.721608] md/raid1:md0: redirecting sector 62916608 to other
mirror: dm-5
[  852.721682] md/raid1:md0: dm-5: rescheduling sector 62916608
[  852.721769] md/raid1:md0: redirecting sector 62916608 to other
mirror: dm-5
[  852.721846] md/raid1:md0: dm-5: rescheduling sector 62916608 =20

The only workaround I found to resolve this at runtime is:
# mdadm --fail /dev/md0 /dev/dm-5
# mdadm --re-add /dev/md0 /dev/dm-5

dmesg after that is as it should:
[ 6094.171989] md/raid1:md0: redirecting sector 62916608 to other mirror: d=
m-5
[ 6094.172058] md/raid1:md0: dm-5: rescheduling sector 62916608
[ 6094.172139] md/raid1:md0: redirecting sector 62916608 to other mirror: d=
m-5
[ 6094.172207] md/raid1:md0: dm-5: rescheduling sector 62916608
[ 6095.357995] md/raid1:md0: Disk failure on dm-5, disabling device.
               md/raid1:md0: Operation continuing on 1 devices.
[ 6101.321556] md: recovery of RAID array md0
[ 6101.321732] md: md0: recovery done.

The reported sector and sectors around it are always readable on both devic=
es:
# dd if=3D/dev/dm-5 iflag=3Ddirect bs=3D4096 skip=3D62916606 count=3D4 | he=
xdump -C
00000000  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |..............=
..|
*
00004000
4+0 records in
4+0 records out
16384 bytes (16 kB, 16 KiB) copied, 0.00080541 s, 20.3 MB/s

# dd if=3D/dev/dm-6 iflag=3Ddirect bs=3D4096 skip=3D62916606 count=3D4 | he=
xdump -C
00000000  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |..............=
..|
*
00004000
4+0 records in
4+0 records out
16384 bytes (16 kB, 16 KiB) copied, 0.0118922 s, 1.4 MB/s

Kernel doesn't kick any members of md0 on it's own.

Failing dm-5 or dm-6 doesn't change the result, as far as I understand
removing redundancy allows kernel to break from the loop.

After that guest works fine. However after guest does=20
graceful shutdown then the problem reproduces again and can be
remedied with mdadm --fail again. In other words it happens during guest
creation and guest teardown.

fragment of strace, the last pread64 call hangs:
[pid  7906] openat(AT_FDCWD, "/dev/lvmraid/wrk", O_RDONLY|O_NONBLOCK|O_CLOE=
XEC) =3D 13
[pid  7906] newfstatat(13, "", {st_mode=3DS_IFBLK|0660, st_rdev=3Dmakedev(0=
xfd, 0x9), ...}, AT_EMPTY_PATH) =3D 0
[pid  7906] ioctl(13, CDROM_DRIVE_STATUS, 0x7fffffff) =3D -1 ENOTTY (Inappr=
opriate ioctl for device)
[pid  7906] close(13)                   =3D 0
[pid  7906] newfstatat(AT_FDCWD, "/dev/lvmraid/wrk", {st_mode=3DS_IFBLK|066=
0, st_rdev=3Dmakedev(0xfd, 0x9), ...}, 0) =3D 0
[pid  7906] openat(AT_FDCWD, "/dev/lvmraid/wrk", O_RDONLY|O_DIRECT|O_CLOEXE=
C) =3D 13
[pid  7906] io_uring_setup(128, {flags=3D0, sq_thread_cpu=3D0, sq_thread_id=
le=3D0, sq_entries=3D128, cq_entries=3D256, features=3DIORING_FEAT_SINGLE_M=
MAP|IORING_FEAT_NODROP|IORING_FEAT_SUBMIT_STABLE|IORI
NG_FEAT_RW_CUR_POS|IORING_FEAT_CUR_PERSONALITY|IORING_FEAT_FAST_POLL|IORING=
_FEAT_POLL_32BITS|IORING_FEAT_SQPOLL_NONFIXED|IORING_FEAT_EXT_ARG|IORING_FE=
AT_NATIVE_WORKERS|IORING_FEAT_RSRC_TAGS|I
ORING_FEAT_CQE_SKIP|IORING_FEAT_LINKED_FILE, sq_off=3D{head=3D0, tail=3D64,=
 ring_mask=3D256, ring_entries=3D264, flags=3D276, dropped=3D272, array=3D4=
416}, cq_off=3D{head=3D128, tail=3D192, ring_mask=3D260, ring_ent
ries=3D268, overflow=3D284, cqes=3D320, flags=3D280}}) =3D 14
[pid  7906] mmap(NULL, 4928, PROT_READ|PROT_WRITE, MAP_SHARED|MAP_POPULATE,=
 14, 0) =3D 0x7958eca02000
[pid  7906] mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_SHARED|MAP_POPULATE,=
 14, 0x10000000) =3D 0x7958ec9fa000
[pid  7906] io_uring_register(14, IORING_REGISTER_RING_FDS, [{offset=3D-1, =
data=3D14}], 1) =3D 1
[pid  7906] write(6, "\1\0\0\0\0\0\0\0", 8) =3D 8=20
[pid  7906] newfstatat(13, "", {st_mode=3DS_IFBLK|0660, st_rdev=3Dmakedev(0=
xfd, 0x9), ...}, AT_EMPTY_PATH) =3D 0
[pid  7906] ioctl(13, BLKDISCARDZEROES, [0]) =3D 0
[pid  7906] fstatfs(13, {f_type=3DTMPFS_MAGIC, f_bsize=3D4096, f_blocks=3D2=
560, f_bfree=3D2560, f_bavail=3D2560, f_files=3D4016118, f_ffree=3D4015380,=
 f_fsid=3D{val=3D[0x73a66ace, 0xdefebdad]}, f_namelen=3D255,=20
f_frsize=3D4096, f_flags=3DST_VALID|ST_NOSUID|ST_RELATIME}) =3D 0
[pid  7906] newfstatat(AT_FDCWD, "/dev/lvmraid/wrk", {st_mode=3DS_IFBLK|066=
0, st_rdev=3Dmakedev(0xfd, 0x9), ...}, 0) =3D 0
[pid  7906] lseek(13, 0, SEEK_END)      =3D 21474836480
[pid  7906] fstatfs(13, {f_type=3DTMPFS_MAGIC, f_bsize=3D4096, f_blocks=3D2=
560, f_bfree=3D2560, f_bavail=3D2560, f_files=3D4016118, f_ffree=3D4015380,=
 f_fsid=3D{val=3D[0x73a66ace, 0xdefebdad]}, f_namelen=3D255,=20
f_frsize=3D4096, f_flags=3DST_VALID|ST_NOSUID|ST_RELATIME}) =3D 0
[pid  7906] ioctl(13, BLKSSZGET, [4096]) =3D 0
[pid  7906] ioctl(13, _IOC(_IOC_READ, 0x58, 0x1e, 0xc), 0x7fff464e32c8) =3D=
 -1 ENOTTY (Inappropriate ioctl for device)
[pid  7906] pread64(13, 0x627c34c8d001, 4096, 0) =3D -1 EINVAL (Invalid arg=
ument)
[pid  7906] pread64(13,

# cat /proc/7906/stack
[<0>] submit_bio_wait+0xdb/0x140
[<0>] blkdev_direct_IO+0x62f/0x770
[<0>] blkdev_read_iter+0xc1/0x140
[<0>] vfs_read+0x34e/0x3c0
[<0>] __x64_sys_pread64+0x74/0xc0
[<0>] do_syscall_64+0x6a/0x90
[<0>] entry_SYSCALL_64_after_hwframe+0x4b/0xb5

After "mdadm --fail" invocation the last line becomes:
[pid  7906] pread64(13, 0x627c34c8d200, 4096, 0) =3D -1 EIO (Input/output e=
rror)

fragment of guest teardown strace:
[pid  8986] openat(AT_FDCWD, "/dev/lvmraid/wrk", O_RDONLY|O_DIRECT|O_CLOEXE=
C) =3D 11
[pid  8986] ioctl(11, BLKSSZGET, [4096]) =3D 0
[pid  8986] ioctl(11, _IOC(_IOC_READ, 0x58, 0x1e, 0xc), 0x7ffd776f4da8) =3D=
 -1 ENOTTY (Inappropriate ioctl for device)
[pid  8986] pread64(11, 0x62f8d5600001, 4096, 0) =3D -1 EINVAL (Invalid arg=
ument)
[pid  8986] pread64(11,

After "mdadm --fail" last line becomes:
[pid  8986] pread64(11, 0x62f8d5600200, 4096, 0) =3D -1 EIO (Input/output e=
rror)

Stack trace in /proc/8986/stack is identical to stack trace from above.
As I understand EINVAL from pread64 here is expected as 13 fd is opened wit=
h O_DIRECT.
However it's strange that kernel loops seemingly indefinetely on second pre=
ad64 until
"mdadm --fail".

Kernels 5.19 and earlier start multiple guests successfully
without the problem. On 6.0+ only first guest starts without problem,
subsequent guests end up in D state until "mdadm --fail".

What other info I can provide? I can apply debug or fixing patches.

Bisect led me to commit b1a000d3b8ec5  ("block: relax direct io memory
alignment").

Bisect log:
git bisect start
# status: waiting for both good and bad commits=20
# bad: [4fe89d07dcc2804c8b562f6c7896a45643d34b2f] Linux 6.0
git bisect bad 4fe89d07dcc2804c8b562f6c7896a45643d34b2f
# status: waiting for good commit(s), bad commit known
# good: [3d7cb6b04c3f3115719235cc6866b10326de34cd] Linux 5.19
git bisect good 3d7cb6b04c3f3115719235cc6866b10326de34cd
# bad: [78acd4ca433425e6dd4032cfc2156c60e34931f2] usb: cdns3: Don't use pri=
v_dev uninitialized in cdns3_gadget_ep_enable()
git bisect bad 78acd4ca433425e6dd4032cfc2156c60e34931f2
# bad: [526942b8134cc34d25d27f95dfff98b8ce2f6fcd] Merge tag 'ata-5.20-rc1' =
of git://git.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata
git bisect bad 526942b8134cc34d25d27f95dfff98b8ce2f6fcd
# good: [2e7a95156d64667a8ded606829d57c6fc92e41df] Merge tag 'regmap-v5.20'=
 of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap
git bisect good 2e7a95156d64667a8ded606829d57c6fc92e41df
# bad: [c013d0af81f60cc7dbe357c4e2a925fb6738dbfe] Merge tag 'for-5.20/block=
-2022-07-29' of git://git.kernel.dk/linux-block
git bisect bad c013d0af81f60cc7dbe357c4e2a925fb6738dbfe
# good: [efb2883060afc79638bb1eb19e2c30e7f6c5a178] Merge branch 'turbostat'=
 of git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux
git bisect good efb2883060afc79638bb1eb19e2c30e7f6c5a178
# good: [cb309ae49da7a7c28f0051deea13970291134fac] io_uring/net: improve io=
_get_notif_slot types
git bisect good cb309ae49da7a7c28f0051deea13970291134fac
# bad: [22c80aac882f712897b88b7ea8f5a74ea19019df] blktrace: Trace remapped =
requests correctly
git bisect bad 22c80aac882f712897b88b7ea8f5a74ea19019df
# bad: [22d0c4080fe49299640d9d6c43154c49794c2825] block: simplify disk_set_=
independent_access_ranges
git bisect bad 22d0c4080fe49299640d9d6c43154c49794c2825
# bad: [3c8f9da41ed90294d8ca42b3ad8a13c5379bd549] blk-mq: Don't disable pre=
emption around __blk_mq_run_hw_queue().
git bisect bad 3c8f9da41ed90294d8ca42b3ad8a13c5379bd549
# bad: [798f2a6f734de87633351c3ab13b17b07397cf68] block: Directly use ida_a=
lloc()/free()
git bisect bad 798f2a6f734de87633351c3ab13b17b07397cf68
# good: [67927d22015060967122facc8cfeaad8012e8808] block/merge: count bytes=
 instead of sectors
git bisect good 67927d22015060967122facc8cfeaad8012e8808
# good: [5debd9691c3ac64c3acd6867c264ad38bbe48cdc] block: introduce bdev_it=
er_is_aligned helper=20
git bisect good 5debd9691c3ac64c3acd6867c264ad38bbe48cdc
# bad: [bf8d08532bc19a14cfb54ae61099dccadefca446] iomap: add support for dm=
a aligned direct-io
git bisect bad bf8d08532bc19a14cfb54ae61099dccadefca446
# bad: [b1a000d3b8ec582da64bb644be633e5a0beffcbf] block: relax direct io me=
mory alignment
git bisect bad b1a000d3b8ec582da64bb644be633e5a0beffcbf
# first bad commit: [b1a000d3b8ec582da64bb644be633e5a0beffcbf] block: relax=
 direct io memory alignment

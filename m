Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC7D6A0D8C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 17:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234084AbjBWQG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 11:06:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233437AbjBWQGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 11:06:54 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A73264E5EE;
        Thu, 23 Feb 2023 08:06:52 -0800 (PST)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pVE7O-0000h5-Up; Thu, 23 Feb 2023 17:06:51 +0100
Message-ID: <a13cd3b5-cc41-bf2f-c8ac-e031ad0d5dd7@leemhuis.info>
Date:   Thu, 23 Feb 2023 17:06:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US, de-DE
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     Song Liu <song@kernel.org>
Cc:     linux-raid <linux-raid@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        Nikolay Kichukov <hijacker@oldum.net>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: [regression] Bug 217074 - upgrading to kernel 6.1.12 from 5.15.x can
 no longer assemble software raid0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1677168412;e370ae46;
X-HE-SMSGID: 1pVE7O-0000h5-Up
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this is your Linux kernel regression tracker.

I noticed a regression report in bugzilla.kernel.org. As many (most?)
kernel developer don't keep an eye on it, I decided to forward it by
mail. Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=217074 :

> Hello,
> Installing a new kernel 6.1.12 does not allow assembly of raid0 device.
> 
> Going back to previous working kernels: 5.15.65, 5.15.75 assembles the raid0 without any problems.
> 
> Kernel command line parameters:
> ... ro kvm_amd.nested=0 kvm_amd.avic=1 kvm_amd.npt=1 raid0.default_layout=2
> 
> mdadm assembly attempt fails with:
> 'mdadm: unexpected failure opening /dev/md<NR>'
> 
> Tried with mdadm-4.1 and mdadm-4.2, but as it works with either versions of mdadm, I rule out the mdadm software.
> 
> strace -f output, last few lines:
> 
> mkdir("/run/mdadm", 0755)               = -1 EEXIST (File exists)
> openat(AT_FDCWD, "/run/mdadm/map.lock", O_RDWR|O_CREAT|O_TRUNC, 0600) = 3
> fcntl(3, F_GETFL)                       = 0x8002 (flags O_RDWR|O_LARGEFILE)
> flock(3, LOCK_EX)                       = 0
> newfstatat(3, "", {st_mode=S_IFREG|0600, st_size=0, ...}, AT_EMPTY_PATH) = 0
> openat(AT_FDCWD, "/run/mdadm/map", O_RDONLY) = 4
> fcntl(4, F_GETFL)                       = 0x8000 (flags O_RDONLY|O_LARGEFILE)
> newfstatat(4, "", {st_mode=S_IFREG|0600, st_size=0, ...}, AT_EMPTY_PATH) = 0
> read(4, "", 4096)                       = 0
> close(4)                                = 0
> openat(AT_FDCWD, "/run/mdadm/map", O_RDONLY) = 4
> fcntl(4, F_GETFL)                       = 0x8000 (flags O_RDONLY|O_LARGEFILE)
> newfstatat(4, "", {st_mode=S_IFREG|0600, st_size=0, ...}, AT_EMPTY_PATH) = 0
> read(4, "", 4096)                       = 0
> close(4)                                = 0
> newfstatat(AT_FDCWD, "/dev/.udev", 0x7ffcd8243c90, 0) = -1 ENOENT (No such file or directory)
> newfstatat(AT_FDCWD, "/run/udev", {st_mode=S_IFDIR|0755, st_size=160, ...}, 0) = 0
> openat(AT_FDCWD, "/proc/mdstat", O_RDONLY) = 4
> fcntl(4, F_SETFD, FD_CLOEXEC)           = 0
> newfstatat(4, "", {st_mode=S_IFREG|0444, st_size=0, ...}, AT_EMPTY_PATH) = 0
> read(4, "Personalities : [raid1] [raid0] "..., 1024) = 56
> read(4, "", 1024)                       = 0
> close(4)                                = 0
> openat(AT_FDCWD, "/sys/block/md127/dev", O_RDONLY) = -1 ENOENT (No such file or directory)
> getpid()                                = 18351
> mknodat(AT_FDCWD, "/dev/.tmp.md.18351:9:127", S_IFBLK|0600, makedev(0x9, 0x7f)) = 0
> openat(AT_FDCWD, "/dev/.tmp.md.18351:9:127", O_RDWR|O_EXCL|O_DIRECT) = -1 ENXIO (No such device or address)
> unlink("/dev/.tmp.md.18351:9:127")      = 0
> getpid()                                = 18351
> mknodat(AT_FDCWD, "/tmp/.tmp.md.18351:9:127", S_IFBLK|0600, makedev(0x9, 0x7f)) = 0
> openat(AT_FDCWD, "/tmp/.tmp.md.18351:9:127", O_RDWR|O_EXCL|O_DIRECT) = -1 ENXIO (No such device or address)
> unlink("/tmp/.tmp.md.18351:9:127")      = 0
> write(2, "mdadm: unexpected failure openin"..., 45mdadm: unexpected failure opening /dev/md127
> ) = 45
> unlink("/run/mdadm/map.lock")           = 0
> close(3)                                = 0
> exit_group(1)                           = ?
> +++ exited with 1 +++
> 
> 
> Tried with kernel compiled with either CONFIG_DEVTMPFS_SAFE=y or CONFIG_DEVTMPFS_SAFE=n, fails the same way.
> 
> The raid consists of 4 devices, here is mdstat contents:
> 
> Personalities : [raid0] 
> md127 : active raid0 sda[0] sdc[2] sdd[3] sdb[1]
>       2929769472 blocks super 1.2 512k chunks
>       
> unused devices: <none>
> 
> 
> Examining the 4 block devices:
> 
> gnusystem /var/log # mdadm --misc -E /dev/sda
> /dev/sda:
>           Magic : a92b4efc
>         Version : 1.2
>     Feature Map : 0x0
>      Array UUID : bb710ce6:edd5d68d:a0a0a405:edd99547
>            Name : gnusystem:md0-store  (local to host gnusystem)
>   Creation Time : Wed Sep 29 22:28:09 2021
>      Raid Level : raid0
>    Raid Devices : 4
> 
>  Avail Dev Size : 976508976 sectors (465.64 GiB 499.97 GB)
>     Data Offset : 264192 sectors
>    Super Offset : 8 sectors
>    Unused Space : before=264112 sectors, after=0 sectors
>           State : clean
>     Device UUID : 7f226c1c:23632b9d:e3d6c656:74522906
> 
>     Update Time : Wed Sep 29 22:28:09 2021
>   Bad Block Log : 512 entries available at offset 8 sectors
>        Checksum : 51e99fb5 - correct
>          Events : 0
> 
>      Chunk Size : 512K
> 
>    Device Role : Active device 0
>    Array State : AAAA ('A' == active, '.' == missing, 'R' == replacing)
> gnusystem /var/log # mdadm --misc -E /dev/sdb
> /dev/sdb:
>           Magic : a92b4efc
>         Version : 1.2
>     Feature Map : 0x0
>      Array UUID : bb710ce6:edd5d68d:a0a0a405:edd99547
>            Name : gnusystem:md0-store  (local to host gnusystem)
>   Creation Time : Wed Sep 29 22:28:09 2021
>      Raid Level : raid0
>    Raid Devices : 4
> 
>  Avail Dev Size : 1953260976 sectors (931.39 GiB 1000.07 GB)
>     Data Offset : 264192 sectors
>    Super Offset : 8 sectors
>    Unused Space : before=264112 sectors, after=0 sectors
>           State : clean
>     Device UUID : ed8795fe:c7e6719a:165db37e:32ec0894
> 
>     Update Time : Wed Sep 29 22:28:09 2021
>   Bad Block Log : 512 entries available at offset 8 sectors
>        Checksum : 215db63b - correct
>          Events : 0
> 
>      Chunk Size : 512K
> 
>    Device Role : Active device 1
>    Array State : AAAA ('A' == active, '.' == missing, 'R' == replacing)
> gnusystem /var/log # mdadm --misc -E /dev/sdc
> /dev/sdc:
>           Magic : a92b4efc
>         Version : 1.2
>     Feature Map : 0x0
>      Array UUID : bb710ce6:edd5d68d:a0a0a405:edd99547
>            Name : gnusystem:md0-store  (local to host gnusystem)
>   Creation Time : Wed Sep 29 22:28:09 2021
>      Raid Level : raid0
>    Raid Devices : 4
> 
>  Avail Dev Size : 976508976 sectors (465.64 GiB 499.97 GB)
>     Data Offset : 264192 sectors
>    Super Offset : 8 sectors
>    Unused Space : before=264112 sectors, after=0 sectors
>           State : clean
>     Device UUID : 3713dfff:d2e29aaf:3275039d:08b317bb
> 
>     Update Time : Wed Sep 29 22:28:09 2021
>   Bad Block Log : 512 entries available at offset 8 sectors
>        Checksum : 42f70f03 - correct
>          Events : 0
> 
>      Chunk Size : 512K
> 
>    Device Role : Active device 2
>    Array State : AAAA ('A' == active, '.' == missing, 'R' == replacing)
> gnusystem /var/log # mdadm --misc -E /dev/sdd
> /dev/sdd:
>           Magic : a92b4efc
>         Version : 1.2
>     Feature Map : 0x0
>      Array UUID : bb710ce6:edd5d68d:a0a0a405:edd99547
>            Name : gnusystem:md0-store  (local to host gnusystem)
>   Creation Time : Wed Sep 29 22:28:09 2021
>      Raid Level : raid0
>    Raid Devices : 4
> 
>  Avail Dev Size : 1953260976 sectors (931.39 GiB 1000.07 GB)
>     Data Offset : 264192 sectors
>    Super Offset : 8 sectors
>    Unused Space : before=264112 sectors, after=0 sectors
>           State : clean
>     Device UUID : 7da858ae:c0d6ca51:0ecaaaf0:280367cc
> 
>     Update Time : Wed Sep 29 22:28:09 2021
>   Bad Block Log : 512 entries available at offset 8 sectors
>        Checksum : 32cf4ab4 - correct
>          Events : 0
> 
>      Chunk Size : 512K
> 
>    Device Role : Active device 3
>    Array State : AAAA ('A' == active, '.' == missing, 'R' == replacing)
> 
> If any more information is needed, let me know.

See the ticket for details.


[TLDR for the rest of this mail: I'm adding this report to the list of
tracked Linux kernel regressions; the text you find below is based on a
few templates paragraphs you might have encountered already in similar
form.]

BTW, let me use this mail to also add the report to the list of tracked
regressions to ensure it's doesn't fall through the cracks:

#regzbot introduced: v5.15..v6.1.12
https://bugzilla.kernel.org/show_bug.cgi?id=217074
#regzbot title: block: md: raid0 no longer assembled
#regzbot ignore-activity

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply and tell me -- ideally
while also telling regzbot about it, as explained by the page listed in
the footer of this mail.

Developers: When fixing the issue, remember to add 'Link:' tags pointing
to the report (e.g. the buzgzilla ticket and maybe this mail as well, if
this thread sees some discussion). See page linked in footer for details.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

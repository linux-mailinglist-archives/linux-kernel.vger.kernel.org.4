Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F13A06AA4B6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 23:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbjCCWn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 17:43:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbjCCWn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 17:43:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A2E7D33C;
        Fri,  3 Mar 2023 14:42:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4446FB81928;
        Fri,  3 Mar 2023 22:41:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4ADEC433D2;
        Fri,  3 Mar 2023 22:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677883287;
        bh=ddB2tfpY7d7Vws0DiDOusuH4nDz5o7Zpo6VvcYiudRY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YZ6bBjWravOAs+mrgz5lGYEuxK/QhHX5ADhYZ+ylYmcn693HeRcrecWp79MJsQU8b
         O4z85oS0DSXDP9/EOqx+MgetTc5U6/155AzRNg2BmpUQoIhHAyNTw9NxTqvxDb2A4l
         vAGjTbEJ4bC4AxGGYSnglXP+jeKuWFw1gdVWXdIj7JGQiWYGahv+InpoO6lwBY12Pk
         BBJNZ1zMTV7QCaxpdAvLHl6aKj02g3EjELXs8f+AZ5uWoP92bQkN7fCclrJ6lfJdMD
         HFV3pWSCLr8Oyu3CqULOtbiKRjGcdR721kW1m2m8cELQrH/hbKbOnulkqvUUusE2iL
         YOgtIiVwMlT8A==
Received: by mail-lf1-f49.google.com with SMTP id d36so2343774lfv.8;
        Fri, 03 Mar 2023 14:41:27 -0800 (PST)
X-Gm-Message-State: AO0yUKWoLRbKYD2Yluz49D2nDJNw+YyB1sD44BHDO1QyarWZRJCCKpDb
        bn6k5rqihGXPR5WtMdLaICDAAaCStzzCMKZPOPM=
X-Google-Smtp-Source: AK7set9+8r88VEQ7/2q9Miz+CPEi/sAQJ8m2vNWn4VJYw+hYUvC0spLA41QyTJysmbtrvM3l5sm/trqaDYHW1mT3BZo=
X-Received: by 2002:ac2:532c:0:b0:4dd:a058:f08f with SMTP id
 f12-20020ac2532c000000b004dda058f08fmr1114274lfh.3.1677883285860; Fri, 03 Mar
 2023 14:41:25 -0800 (PST)
MIME-Version: 1.0
References: <a13cd3b5-cc41-bf2f-c8ac-e031ad0d5dd7@leemhuis.info>
In-Reply-To: <a13cd3b5-cc41-bf2f-c8ac-e031ad0d5dd7@leemhuis.info>
From:   Song Liu <song@kernel.org>
Date:   Fri, 3 Mar 2023 14:41:13 -0800
X-Gmail-Original-Message-ID: <CAPhsuW7ZWthh0PZt71hQh1_51C0yMSpOqWYJKc_+VzzTmW_r5A@mail.gmail.com>
Message-ID: <CAPhsuW7ZWthh0PZt71hQh1_51C0yMSpOqWYJKc_+VzzTmW_r5A@mail.gmail.com>
Subject: Re: [regression] Bug 217074 - upgrading to kernel 6.1.12 from 5.15.x
 can no longer assemble software raid0
To:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Jes.Sorensen@gmail.com
Cc:     linux-raid <linux-raid@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Nikolay Kichukov <hijacker@oldum.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Jes.

It appeared to me that we can assemble the array if we have any of the
following:
1. Enable CONFIG_BLOCK_LEGACY_AUTOLOAD;
2. Have a valid /etc/mdadm.conf;
3. Update mdadm to handle this case. (I tried some ugly hacks, which worked but
    weren't clean).

Since we eventually would like to get rid of CONFIG_BLOCK_LEGACY_AUTOLOAD, I
think we need mdadm to handle this properly. But the logistics might
be complicated, as
mdadm are shipped separately.

Jes, what do you think about this? AFAICT, we need to update the logic in
mdopen.c:create_mddev().

Thanks,
Song


On Thu, Feb 23, 2023 at 8:06 AM Linux regression tracking (Thorsten
Leemhuis) <regressions@leemhuis.info> wrote:
>
> Hi, this is your Linux kernel regression tracker.
>
> I noticed a regression report in bugzilla.kernel.org. As many (most?)
> kernel developer don't keep an eye on it, I decided to forward it by
> mail. Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=217074 :
>
> > Hello,
> > Installing a new kernel 6.1.12 does not allow assembly of raid0 device.
> >
> > Going back to previous working kernels: 5.15.65, 5.15.75 assembles the raid0 without any problems.
> >
> > Kernel command line parameters:
> > ... ro kvm_amd.nested=0 kvm_amd.avic=1 kvm_amd.npt=1 raid0.default_layout=2
> >
> > mdadm assembly attempt fails with:
> > 'mdadm: unexpected failure opening /dev/md<NR>'
> >
> > Tried with mdadm-4.1 and mdadm-4.2, but as it works with either versions of mdadm, I rule out the mdadm software.
> >
> > strace -f output, last few lines:
> >
> > mkdir("/run/mdadm", 0755)               = -1 EEXIST (File exists)
> > openat(AT_FDCWD, "/run/mdadm/map.lock", O_RDWR|O_CREAT|O_TRUNC, 0600) = 3
> > fcntl(3, F_GETFL)                       = 0x8002 (flags O_RDWR|O_LARGEFILE)
> > flock(3, LOCK_EX)                       = 0
> > newfstatat(3, "", {st_mode=S_IFREG|0600, st_size=0, ...}, AT_EMPTY_PATH) = 0
> > openat(AT_FDCWD, "/run/mdadm/map", O_RDONLY) = 4
> > fcntl(4, F_GETFL)                       = 0x8000 (flags O_RDONLY|O_LARGEFILE)
> > newfstatat(4, "", {st_mode=S_IFREG|0600, st_size=0, ...}, AT_EMPTY_PATH) = 0
> > read(4, "", 4096)                       = 0
> > close(4)                                = 0
> > openat(AT_FDCWD, "/run/mdadm/map", O_RDONLY) = 4
> > fcntl(4, F_GETFL)                       = 0x8000 (flags O_RDONLY|O_LARGEFILE)
> > newfstatat(4, "", {st_mode=S_IFREG|0600, st_size=0, ...}, AT_EMPTY_PATH) = 0
> > read(4, "", 4096)                       = 0
> > close(4)                                = 0
> > newfstatat(AT_FDCWD, "/dev/.udev", 0x7ffcd8243c90, 0) = -1 ENOENT (No such file or directory)
> > newfstatat(AT_FDCWD, "/run/udev", {st_mode=S_IFDIR|0755, st_size=160, ...}, 0) = 0
> > openat(AT_FDCWD, "/proc/mdstat", O_RDONLY) = 4
> > fcntl(4, F_SETFD, FD_CLOEXEC)           = 0
> > newfstatat(4, "", {st_mode=S_IFREG|0444, st_size=0, ...}, AT_EMPTY_PATH) = 0
> > read(4, "Personalities : [raid1] [raid0] "..., 1024) = 56
> > read(4, "", 1024)                       = 0
> > close(4)                                = 0
> > openat(AT_FDCWD, "/sys/block/md127/dev", O_RDONLY) = -1 ENOENT (No such file or directory)
> > getpid()                                = 18351
> > mknodat(AT_FDCWD, "/dev/.tmp.md.18351:9:127", S_IFBLK|0600, makedev(0x9, 0x7f)) = 0
> > openat(AT_FDCWD, "/dev/.tmp.md.18351:9:127", O_RDWR|O_EXCL|O_DIRECT) = -1 ENXIO (No such device or address)
> > unlink("/dev/.tmp.md.18351:9:127")      = 0
> > getpid()                                = 18351
> > mknodat(AT_FDCWD, "/tmp/.tmp.md.18351:9:127", S_IFBLK|0600, makedev(0x9, 0x7f)) = 0
> > openat(AT_FDCWD, "/tmp/.tmp.md.18351:9:127", O_RDWR|O_EXCL|O_DIRECT) = -1 ENXIO (No such device or address)
> > unlink("/tmp/.tmp.md.18351:9:127")      = 0
> > write(2, "mdadm: unexpected failure openin"..., 45mdadm: unexpected failure opening /dev/md127
> > ) = 45
> > unlink("/run/mdadm/map.lock")           = 0
> > close(3)                                = 0
> > exit_group(1)                           = ?
> > +++ exited with 1 +++
> >
> >
> > Tried with kernel compiled with either CONFIG_DEVTMPFS_SAFE=y or CONFIG_DEVTMPFS_SAFE=n, fails the same way.
> >
> > The raid consists of 4 devices, here is mdstat contents:
> >
> > Personalities : [raid0]
> > md127 : active raid0 sda[0] sdc[2] sdd[3] sdb[1]
> >       2929769472 blocks super 1.2 512k chunks
> >
> > unused devices: <none>
> >
> >
> > Examining the 4 block devices:
> >
> > gnusystem /var/log # mdadm --misc -E /dev/sda
> > /dev/sda:
> >           Magic : a92b4efc
> >         Version : 1.2
> >     Feature Map : 0x0
> >      Array UUID : bb710ce6:edd5d68d:a0a0a405:edd99547
> >            Name : gnusystem:md0-store  (local to host gnusystem)
> >   Creation Time : Wed Sep 29 22:28:09 2021
> >      Raid Level : raid0
> >    Raid Devices : 4
> >
> >  Avail Dev Size : 976508976 sectors (465.64 GiB 499.97 GB)
> >     Data Offset : 264192 sectors
> >    Super Offset : 8 sectors
> >    Unused Space : before=264112 sectors, after=0 sectors
> >           State : clean
> >     Device UUID : 7f226c1c:23632b9d:e3d6c656:74522906
> >
> >     Update Time : Wed Sep 29 22:28:09 2021
> >   Bad Block Log : 512 entries available at offset 8 sectors
> >        Checksum : 51e99fb5 - correct
> >          Events : 0
> >
> >      Chunk Size : 512K
> >
> >    Device Role : Active device 0
> >    Array State : AAAA ('A' == active, '.' == missing, 'R' == replacing)
> > gnusystem /var/log # mdadm --misc -E /dev/sdb
> > /dev/sdb:
> >           Magic : a92b4efc
> >         Version : 1.2
> >     Feature Map : 0x0
> >      Array UUID : bb710ce6:edd5d68d:a0a0a405:edd99547
> >            Name : gnusystem:md0-store  (local to host gnusystem)
> >   Creation Time : Wed Sep 29 22:28:09 2021
> >      Raid Level : raid0
> >    Raid Devices : 4
> >
> >  Avail Dev Size : 1953260976 sectors (931.39 GiB 1000.07 GB)
> >     Data Offset : 264192 sectors
> >    Super Offset : 8 sectors
> >    Unused Space : before=264112 sectors, after=0 sectors
> >           State : clean
> >     Device UUID : ed8795fe:c7e6719a:165db37e:32ec0894
> >
> >     Update Time : Wed Sep 29 22:28:09 2021
> >   Bad Block Log : 512 entries available at offset 8 sectors
> >        Checksum : 215db63b - correct
> >          Events : 0
> >
> >      Chunk Size : 512K
> >
> >    Device Role : Active device 1
> >    Array State : AAAA ('A' == active, '.' == missing, 'R' == replacing)
> > gnusystem /var/log # mdadm --misc -E /dev/sdc
> > /dev/sdc:
> >           Magic : a92b4efc
> >         Version : 1.2
> >     Feature Map : 0x0
> >      Array UUID : bb710ce6:edd5d68d:a0a0a405:edd99547
> >            Name : gnusystem:md0-store  (local to host gnusystem)
> >   Creation Time : Wed Sep 29 22:28:09 2021
> >      Raid Level : raid0
> >    Raid Devices : 4
> >
> >  Avail Dev Size : 976508976 sectors (465.64 GiB 499.97 GB)
> >     Data Offset : 264192 sectors
> >    Super Offset : 8 sectors
> >    Unused Space : before=264112 sectors, after=0 sectors
> >           State : clean
> >     Device UUID : 3713dfff:d2e29aaf:3275039d:08b317bb
> >
> >     Update Time : Wed Sep 29 22:28:09 2021
> >   Bad Block Log : 512 entries available at offset 8 sectors
> >        Checksum : 42f70f03 - correct
> >          Events : 0
> >
> >      Chunk Size : 512K
> >
> >    Device Role : Active device 2
> >    Array State : AAAA ('A' == active, '.' == missing, 'R' == replacing)
> > gnusystem /var/log # mdadm --misc -E /dev/sdd
> > /dev/sdd:
> >           Magic : a92b4efc
> >         Version : 1.2
> >     Feature Map : 0x0
> >      Array UUID : bb710ce6:edd5d68d:a0a0a405:edd99547
> >            Name : gnusystem:md0-store  (local to host gnusystem)
> >   Creation Time : Wed Sep 29 22:28:09 2021
> >      Raid Level : raid0
> >    Raid Devices : 4
> >
> >  Avail Dev Size : 1953260976 sectors (931.39 GiB 1000.07 GB)
> >     Data Offset : 264192 sectors
> >    Super Offset : 8 sectors
> >    Unused Space : before=264112 sectors, after=0 sectors
> >           State : clean
> >     Device UUID : 7da858ae:c0d6ca51:0ecaaaf0:280367cc
> >
> >     Update Time : Wed Sep 29 22:28:09 2021
> >   Bad Block Log : 512 entries available at offset 8 sectors
> >        Checksum : 32cf4ab4 - correct
> >          Events : 0
> >
> >      Chunk Size : 512K
> >
> >    Device Role : Active device 3
> >    Array State : AAAA ('A' == active, '.' == missing, 'R' == replacing)
> >
> > If any more information is needed, let me know.
>
> See the ticket for details.
>
>
> [TLDR for the rest of this mail: I'm adding this report to the list of
> tracked Linux kernel regressions; the text you find below is based on a
> few templates paragraphs you might have encountered already in similar
> form.]
>
> BTW, let me use this mail to also add the report to the list of tracked
> regressions to ensure it's doesn't fall through the cracks:
>
> #regzbot introduced: v5.15..v6.1.12
> https://bugzilla.kernel.org/show_bug.cgi?id=217074
> #regzbot title: block: md: raid0 no longer assembled
> #regzbot ignore-activity
>
> This isn't a regression? This issue or a fix for it are already
> discussed somewhere else? It was fixed already? You want to clarify when
> the regression started to happen? Or point out I got the title or
> something else totally wrong? Then just reply and tell me -- ideally
> while also telling regzbot about it, as explained by the page listed in
> the footer of this mail.
>
> Developers: When fixing the issue, remember to add 'Link:' tags pointing
> to the report (e.g. the buzgzilla ticket and maybe this mail as well, if
> this thread sees some discussion). See page linked in footer for details.
>
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.

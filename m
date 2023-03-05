Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC2CA6AB273
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 22:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjCEVVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 16:21:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjCEVVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 16:21:18 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1CD15544;
        Sun,  5 Mar 2023 13:21:16 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 61F5B21FAF;
        Sun,  5 Mar 2023 21:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1678051274; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u4gM2e1hvx3P1eYfrzQECAbOZCd7xfdmYJhFl7mp5Gk=;
        b=LcZnzMi8AjyhcTayHMk70NBNMBYPNB3M1tvFy6g2g3O9RN0cpPQMHEi3NFYpxZL4dbpYX8
        66yNsR3uvEVkdCWCobI6W1OuILH8kDX1RbS7zhKy9w4U6mVM1YEVIvrEySIwIoAuiD+cWv
        uwBf10KfM1uZKbgZc6vvdyUEtGEa3co=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1678051274;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u4gM2e1hvx3P1eYfrzQECAbOZCd7xfdmYJhFl7mp5Gk=;
        b=+tXhIjPH21fw/WYZ5bHqcimc5/O64xDzsviPj0dP6+mFoD8GdTwBcBUY68+vdgEfNSH57c
        p/P6m1BEOHue7WCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2B06313440;
        Sun,  5 Mar 2023 21:21:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WPVHM8cHBWR/BAAAMHmgww
        (envelope-from <neilb@suse.de>); Sun, 05 Mar 2023 21:21:11 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Song Liu" <song@kernel.org>
Cc:     "Linux regressions mailing list" <regressions@lists.linux.dev>,
        Jes.Sorensen@gmail.com, "linux-raid" <linux-raid@vger.kernel.org>,
        "LKML" <linux-kernel@vger.kernel.org>,
        "Nikolay Kichukov" <hijacker@oldum.net>
Subject: Re: [regression] Bug 217074 - upgrading to kernel 6.1.12 from 5.15.x
 can no longer assemble software raid0
In-reply-to: <CAPhsuW7ZWthh0PZt71hQh1_51C0yMSpOqWYJKc_+VzzTmW_r5A@mail.gmail.com>
References: <a13cd3b5-cc41-bf2f-c8ac-e031ad0d5dd7@leemhuis.info>,
 <CAPhsuW7ZWthh0PZt71hQh1_51C0yMSpOqWYJKc_+VzzTmW_r5A@mail.gmail.com>
Date:   Mon, 06 Mar 2023 08:21:07 +1100
Message-id: <167805126796.8008.3635368722810568057@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 04 Mar 2023, Song Liu wrote:
> + Jes.
>=20
> It appeared to me that we can assemble the array if we have any of the
> following:
> 1. Enable CONFIG_BLOCK_LEGACY_AUTOLOAD;
> 2. Have a valid /etc/mdadm.conf;
> 3. Update mdadm to handle this case. (I tried some ugly hacks, which worked=
 but
>     weren't clean).
>=20
> Since we eventually would like to get rid of CONFIG_BLOCK_LEGACY_AUTOLOAD, I
> think we need mdadm to handle this properly. But the logistics might
> be complicated, as
> mdadm are shipped separately.
>=20
> Jes, what do you think about this? AFAICT, we need to update the logic in
> mdopen.c:create_mddev().

mdadm already handles this, but only if=20
   CREATE names=3Dyes
is present in /etc/mdadm.conf

Maybe we should flip the default for the next mdadm release, and patch
the kernel (with a stable backport) to select BLOCK_LEGACY_AUTOLOAD if
BLK_DEV_MD=3Dm=20
Then revert that - say - 6 months after the new mdadm is released.

NeilBrown


>=20
> Thanks,
> Song
>=20
>=20
> On Thu, Feb 23, 2023 at 8:06 AM Linux regression tracking (Thorsten
> Leemhuis) <regressions@leemhuis.info> wrote:
> >
> > Hi, this is your Linux kernel regression tracker.
> >
> > I noticed a regression report in bugzilla.kernel.org. As many (most?)
> > kernel developer don't keep an eye on it, I decided to forward it by
> > mail. Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=3D217074 :
> >
> > > Hello,
> > > Installing a new kernel 6.1.12 does not allow assembly of raid0 device.
> > >
> > > Going back to previous working kernels: 5.15.65, 5.15.75 assembles the =
raid0 without any problems.
> > >
> > > Kernel command line parameters:
> > > ... ro kvm_amd.nested=3D0 kvm_amd.avic=3D1 kvm_amd.npt=3D1 raid0.defaul=
t_layout=3D2
> > >
> > > mdadm assembly attempt fails with:
> > > 'mdadm: unexpected failure opening /dev/md<NR>'
> > >
> > > Tried with mdadm-4.1 and mdadm-4.2, but as it works with either version=
s of mdadm, I rule out the mdadm software.
> > >
> > > strace -f output, last few lines:
> > >
> > > mkdir("/run/mdadm", 0755)               =3D -1 EEXIST (File exists)
> > > openat(AT_FDCWD, "/run/mdadm/map.lock", O_RDWR|O_CREAT|O_TRUNC, 0600) =
=3D 3
> > > fcntl(3, F_GETFL)                       =3D 0x8002 (flags O_RDWR|O_LARG=
EFILE)
> > > flock(3, LOCK_EX)                       =3D 0
> > > newfstatat(3, "", {st_mode=3DS_IFREG|0600, st_size=3D0, ...}, AT_EMPTY_=
PATH) =3D 0
> > > openat(AT_FDCWD, "/run/mdadm/map", O_RDONLY) =3D 4
> > > fcntl(4, F_GETFL)                       =3D 0x8000 (flags O_RDONLY|O_LA=
RGEFILE)
> > > newfstatat(4, "", {st_mode=3DS_IFREG|0600, st_size=3D0, ...}, AT_EMPTY_=
PATH) =3D 0
> > > read(4, "", 4096)                       =3D 0
> > > close(4)                                =3D 0
> > > openat(AT_FDCWD, "/run/mdadm/map", O_RDONLY) =3D 4
> > > fcntl(4, F_GETFL)                       =3D 0x8000 (flags O_RDONLY|O_LA=
RGEFILE)
> > > newfstatat(4, "", {st_mode=3DS_IFREG|0600, st_size=3D0, ...}, AT_EMPTY_=
PATH) =3D 0
> > > read(4, "", 4096)                       =3D 0
> > > close(4)                                =3D 0
> > > newfstatat(AT_FDCWD, "/dev/.udev", 0x7ffcd8243c90, 0) =3D -1 ENOENT (No=
 such file or directory)
> > > newfstatat(AT_FDCWD, "/run/udev", {st_mode=3DS_IFDIR|0755, st_size=3D16=
0, ...}, 0) =3D 0
> > > openat(AT_FDCWD, "/proc/mdstat", O_RDONLY) =3D 4
> > > fcntl(4, F_SETFD, FD_CLOEXEC)           =3D 0
> > > newfstatat(4, "", {st_mode=3DS_IFREG|0444, st_size=3D0, ...}, AT_EMPTY_=
PATH) =3D 0
> > > read(4, "Personalities : [raid1] [raid0] "..., 1024) =3D 56
> > > read(4, "", 1024)                       =3D 0
> > > close(4)                                =3D 0
> > > openat(AT_FDCWD, "/sys/block/md127/dev", O_RDONLY) =3D -1 ENOENT (No su=
ch file or directory)
> > > getpid()                                =3D 18351
> > > mknodat(AT_FDCWD, "/dev/.tmp.md.18351:9:127", S_IFBLK|0600, makedev(0x9=
, 0x7f)) =3D 0
> > > openat(AT_FDCWD, "/dev/.tmp.md.18351:9:127", O_RDWR|O_EXCL|O_DIRECT) =
=3D -1 ENXIO (No such device or address)
> > > unlink("/dev/.tmp.md.18351:9:127")      =3D 0
> > > getpid()                                =3D 18351
> > > mknodat(AT_FDCWD, "/tmp/.tmp.md.18351:9:127", S_IFBLK|0600, makedev(0x9=
, 0x7f)) =3D 0
> > > openat(AT_FDCWD, "/tmp/.tmp.md.18351:9:127", O_RDWR|O_EXCL|O_DIRECT) =
=3D -1 ENXIO (No such device or address)
> > > unlink("/tmp/.tmp.md.18351:9:127")      =3D 0
> > > write(2, "mdadm: unexpected failure openin"..., 45mdadm: unexpected fai=
lure opening /dev/md127
> > > ) =3D 45
> > > unlink("/run/mdadm/map.lock")           =3D 0
> > > close(3)                                =3D 0
> > > exit_group(1)                           =3D ?
> > > +++ exited with 1 +++
> > >
> > >
> > > Tried with kernel compiled with either CONFIG_DEVTMPFS_SAFE=3Dy or CONF=
IG_DEVTMPFS_SAFE=3Dn, fails the same way.
> > >
> > > The raid consists of 4 devices, here is mdstat contents:
> > >
> > > Personalities : [raid0]
> > > md127 : active raid0 sda[0] sdc[2] sdd[3] sdb[1]
> > >       2929769472 blocks super 1.2 512k chunks
> > >
> > > unused devices: <none>
> > >
> > >
> > > Examining the 4 block devices:
> > >
> > > gnusystem /var/log # mdadm --misc -E /dev/sda
> > > /dev/sda:
> > >           Magic : a92b4efc
> > >         Version : 1.2
> > >     Feature Map : 0x0
> > >      Array UUID : bb710ce6:edd5d68d:a0a0a405:edd99547
> > >            Name : gnusystem:md0-store  (local to host gnusystem)
> > >   Creation Time : Wed Sep 29 22:28:09 2021
> > >      Raid Level : raid0
> > >    Raid Devices : 4
> > >
> > >  Avail Dev Size : 976508976 sectors (465.64 GiB 499.97 GB)
> > >     Data Offset : 264192 sectors
> > >    Super Offset : 8 sectors
> > >    Unused Space : before=3D264112 sectors, after=3D0 sectors
> > >           State : clean
> > >     Device UUID : 7f226c1c:23632b9d:e3d6c656:74522906
> > >
> > >     Update Time : Wed Sep 29 22:28:09 2021
> > >   Bad Block Log : 512 entries available at offset 8 sectors
> > >        Checksum : 51e99fb5 - correct
> > >          Events : 0
> > >
> > >      Chunk Size : 512K
> > >
> > >    Device Role : Active device 0
> > >    Array State : AAAA ('A' =3D=3D active, '.' =3D=3D missing, 'R' =3D=
=3D replacing)
> > > gnusystem /var/log # mdadm --misc -E /dev/sdb
> > > /dev/sdb:
> > >           Magic : a92b4efc
> > >         Version : 1.2
> > >     Feature Map : 0x0
> > >      Array UUID : bb710ce6:edd5d68d:a0a0a405:edd99547
> > >            Name : gnusystem:md0-store  (local to host gnusystem)
> > >   Creation Time : Wed Sep 29 22:28:09 2021
> > >      Raid Level : raid0
> > >    Raid Devices : 4
> > >
> > >  Avail Dev Size : 1953260976 sectors (931.39 GiB 1000.07 GB)
> > >     Data Offset : 264192 sectors
> > >    Super Offset : 8 sectors
> > >    Unused Space : before=3D264112 sectors, after=3D0 sectors
> > >           State : clean
> > >     Device UUID : ed8795fe:c7e6719a:165db37e:32ec0894
> > >
> > >     Update Time : Wed Sep 29 22:28:09 2021
> > >   Bad Block Log : 512 entries available at offset 8 sectors
> > >        Checksum : 215db63b - correct
> > >          Events : 0
> > >
> > >      Chunk Size : 512K
> > >
> > >    Device Role : Active device 1
> > >    Array State : AAAA ('A' =3D=3D active, '.' =3D=3D missing, 'R' =3D=
=3D replacing)
> > > gnusystem /var/log # mdadm --misc -E /dev/sdc
> > > /dev/sdc:
> > >           Magic : a92b4efc
> > >         Version : 1.2
> > >     Feature Map : 0x0
> > >      Array UUID : bb710ce6:edd5d68d:a0a0a405:edd99547
> > >            Name : gnusystem:md0-store  (local to host gnusystem)
> > >   Creation Time : Wed Sep 29 22:28:09 2021
> > >      Raid Level : raid0
> > >    Raid Devices : 4
> > >
> > >  Avail Dev Size : 976508976 sectors (465.64 GiB 499.97 GB)
> > >     Data Offset : 264192 sectors
> > >    Super Offset : 8 sectors
> > >    Unused Space : before=3D264112 sectors, after=3D0 sectors
> > >           State : clean
> > >     Device UUID : 3713dfff:d2e29aaf:3275039d:08b317bb
> > >
> > >     Update Time : Wed Sep 29 22:28:09 2021
> > >   Bad Block Log : 512 entries available at offset 8 sectors
> > >        Checksum : 42f70f03 - correct
> > >          Events : 0
> > >
> > >      Chunk Size : 512K
> > >
> > >    Device Role : Active device 2
> > >    Array State : AAAA ('A' =3D=3D active, '.' =3D=3D missing, 'R' =3D=
=3D replacing)
> > > gnusystem /var/log # mdadm --misc -E /dev/sdd
> > > /dev/sdd:
> > >           Magic : a92b4efc
> > >         Version : 1.2
> > >     Feature Map : 0x0
> > >      Array UUID : bb710ce6:edd5d68d:a0a0a405:edd99547
> > >            Name : gnusystem:md0-store  (local to host gnusystem)
> > >   Creation Time : Wed Sep 29 22:28:09 2021
> > >      Raid Level : raid0
> > >    Raid Devices : 4
> > >
> > >  Avail Dev Size : 1953260976 sectors (931.39 GiB 1000.07 GB)
> > >     Data Offset : 264192 sectors
> > >    Super Offset : 8 sectors
> > >    Unused Space : before=3D264112 sectors, after=3D0 sectors
> > >           State : clean
> > >     Device UUID : 7da858ae:c0d6ca51:0ecaaaf0:280367cc
> > >
> > >     Update Time : Wed Sep 29 22:28:09 2021
> > >   Bad Block Log : 512 entries available at offset 8 sectors
> > >        Checksum : 32cf4ab4 - correct
> > >          Events : 0
> > >
> > >      Chunk Size : 512K
> > >
> > >    Device Role : Active device 3
> > >    Array State : AAAA ('A' =3D=3D active, '.' =3D=3D missing, 'R' =3D=
=3D replacing)
> > >
> > > If any more information is needed, let me know.
> >
> > See the ticket for details.
> >
> >
> > [TLDR for the rest of this mail: I'm adding this report to the list of
> > tracked Linux kernel regressions; the text you find below is based on a
> > few templates paragraphs you might have encountered already in similar
> > form.]
> >
> > BTW, let me use this mail to also add the report to the list of tracked
> > regressions to ensure it's doesn't fall through the cracks:
> >
> > #regzbot introduced: v5.15..v6.1.12
> > https://bugzilla.kernel.org/show_bug.cgi?id=3D217074
> > #regzbot title: block: md: raid0 no longer assembled
> > #regzbot ignore-activity
> >
> > This isn't a regression? This issue or a fix for it are already
> > discussed somewhere else? It was fixed already? You want to clarify when
> > the regression started to happen? Or point out I got the title or
> > something else totally wrong? Then just reply and tell me -- ideally
> > while also telling regzbot about it, as explained by the page listed in
> > the footer of this mail.
> >
> > Developers: When fixing the issue, remember to add 'Link:' tags pointing
> > to the report (e.g. the buzgzilla ticket and maybe this mail as well, if
> > this thread sees some discussion). See page linked in footer for details.
> >
> > Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> > --
> > Everything you wanna know about Linux kernel regression tracking:
> > https://linux-regtracking.leemhuis.info/about/#tldr
> > If I did something stupid, please tell me, as explained on that page.
>=20


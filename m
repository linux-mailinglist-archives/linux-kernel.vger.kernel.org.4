Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74D1672414E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 13:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237133AbjFFLqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 07:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbjFFLqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 07:46:50 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD61E9E
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 04:46:48 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f6d38a140bso43337495e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 04:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1686052007; x=1688644007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+NT32Bi3KU+Wx0C7qPLoCFLBay3Z+dbgzsDtgUPWjNQ=;
        b=skhGaMresYou0Q54By+kl0vcdIata5pUGFwaJ8aDF/00uOlVELuDGMsiMv22kCcBdJ
         luk1XoUNyoiGaXuPIikY2YhHRFaahCZmvaZKg38LI0roNsAGLWrB+xx/QyHPjaO3n0Oi
         UfNOkOE2mtQZFiSsrZ10jSDuHpMYjNpsO5vgtOgb+GNzlnfUBb+spU7XWrEeqhXkxmik
         QK+2Q8KeCZMSQmu936B/vuDV9OcV/tPbXDNoMrvpyTa5YXjTu9tjywOeuf5Q8tSbzIi4
         Tj8Mp3cMM3KYIxSR9jO6Ek48oJwSDfXvAA5VqvMIcQtdb4g8biBGR5P87PE6dQeJLRJv
         SJww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686052007; x=1688644007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+NT32Bi3KU+Wx0C7qPLoCFLBay3Z+dbgzsDtgUPWjNQ=;
        b=fqOrEF9VQtaVxP4CBvMzU2a3EKOafqAKw3PrICHnqo+JGrV3VVUQghl0tE4kRxeBDD
         GeCc37ASc4sVjxlj+oaeDT/QL7RJxHL2BE64pckZMjZ1iVqhV5600ZpEQE02CGlCs7KM
         SZoPBd2mGXl5YHwrps4AsLLXo7Ft2Zi1HpkSPU6pnPGF6LtNtA2xDyiovf2Web7neKoF
         ziCbd1Tx8XQE6hcCvwtMV08DtObYoQn5qKfEqXdP0mTQJ/tTQS1I/yCCM/8f1JWgYwdm
         xvoXMBXpXwv9pyZm3/V6s/FYUP5Xv11sJw1bY67p/Yy454o6Oh35rb8zHxfX0ja09tZd
         AZNg==
X-Gm-Message-State: AC+VfDwNBeskuIUc29EB9JzxIgIp0YPG5e+Lt1rKbhE4NP8gAiuUfv3+
        f325XYDof+Up1js0/IdF5QzpRCyrGypKMu9lsscKaw==
X-Google-Smtp-Source: ACHHUZ7w65NyX4Wvy+XSHc2T3iXXClyps2J8w4xmBHsZUbeuvbAzKMsC6aZ3lks2reSpp58nFEjM/3Uec9RGzw6feJY=
X-Received: by 2002:a1c:720e:0:b0:3f7:e7a2:25f6 with SMTP id
 n14-20020a1c720e000000b003f7e7a225f6mr1540965wmc.17.1686052007200; Tue, 06
 Jun 2023 04:46:47 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_7C3B580B47C1B17C16488EC1@qq.com> <CAHVXubjm5ax5KYTV_G=GUUH0KJK=v6_jO09XF1T4AzzUTr0CSg@mail.gmail.com>
 <BF85472AD8E99564+e8e07a01-81e5-c9b7-48f4-5b66b83120ee@tinylab.org>
In-Reply-To: <BF85472AD8E99564+e8e07a01-81e5-c9b7-48f4-5b66b83120ee@tinylab.org>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Tue, 6 Jun 2023 13:46:36 +0200
Message-ID: <CAHVXubg1f+qk+XuFf8WKrtXfk_d_8EOppoVqCd-0mRtVsetz+Q@mail.gmail.com>
Subject: Re: Bug report: kernel paniced while booting
To:     Song Shuai <songshuaishuai@tinylab.org>
Cc:     robh <robh@kernel.org>, ajones <ajones@ventanamicro.com>,
        anup <anup@brainfault.org>, palmer <palmer@rivosinc.com>,
        "jeeheng.sia" <jeeheng.sia@starfivetech.com>,
        "leyfoon.tan" <leyfoon.tan@starfivetech.com>,
        "mason.huo" <mason.huo@starfivetech.com>,
        "paul.walmsley" <paul.walmsley@sifive.com>,
        "conor.dooley" <conor.dooley@microchip.com>,
        guoren <guoren@kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 6, 2023 at 12:04=E2=80=AFPM Song Shuai <songshuaishuai@tinylab.=
org> wrote:
>
>
>
> =E5=9C=A8 2023/6/5 22:25, Alexandre Ghiti =E5=86=99=E9=81=93:
> > Hi Song,
> >
> > On Mon, Jun 5, 2023 at 12:52=E2=80=AFPM Song Shuai <songshuaishuai@tiny=
lab.org> wrote:
> >>
> >> Description of problem:
> >>
> >> Booting Linux With RiscVVirtQemu edk2 firmware, a Store/AMO page fault=
 was trapped to trigger a kernel panic.
> >> The entire log has been posted at this link : https://termbin.com/nga4=
.
> >>
> >> You can reproduce it with the following step :
> >>
> >> 1. prepare the environment with
> >>     - Qemu-virt:  v8.0.0 (with OpenSbi v1.2)
> >>     - edk2 : at commit (2bc8545883 "UefiCpuPkg/CpuPageTableLib: Reduce=
 the number of random tests")
> >>     - Linux : v6.4-rc1 and later version
> >>
> >> 2. start the Qemu virt board
> >>
> >> ```sh
> >> $ cat ~/8_riscv/start_latest.sh
> >> #!/bin/bash
> >> /home/song/8_riscv/3_acpi/qemu/ooo/usr/local/bin/qemu-system-riscv64 \
> >>          -s -nographic -drive file=3D/home/song/8_riscv/3_acpi/Build_v=
irt/RiscVVirtQemu/RELEASE_GCC5/FV/RISCV_VIRT.fd,if=3Dpflash,format=3Draw,un=
it=3D1 \
> >>          -machine virt,acpi=3Doff -smp 2 -m 2G \
> >>          -kernel /home/song/9_linux/linux/00_rv_def/arch/riscv/boot/Im=
age \
> >>          -initrd /home/song/8_riscv/3_acpi/buildroot/output/images/roo=
tfs.ext2 \
> >>          -append "root=3D/dev/ram ro console=3DttyS0 earlycon=3Duart82=
50,mmio,0x10000000 efi=3Ddebug loglevel=3D8 memblock=3Ddebug" ## also panic=
 by memtest
> >> ```
> >> 3. Then you will encounter the kernel panic logged in the above link
> >>
> >> Other Information:
> >>
> >> 1. -------
> >>
> >> This report is not identical to my prior report -- "kernel paniced whe=
n system hibernates" [1], but both of them
> >> are closely related with the commit (3335068f8721 "riscv: Use PUD/P4D/=
PGD pages for the linear mapping").
> >>
> >> With this commit, hibernation is trapped with "access fault" while acc=
essing the PMP-protected regions (mmode_resv0@80000000)
> >> from OpenSbi (BTW, hibernation is marked as nonportable by Conor[2]).
> >>
> >> In this report, efi_init handoffs the memory mapping from Boot Service=
s to memblock where reserves mmode_resv0@80000000,
> >> so there is no "access fault" but "page fault".
> >>
> >> And reverting commit 3335068f8721 indeed fixed this panic.
> >>
> >> 2. -------
> >>
> >> As the gdb-pt-dump [3] tool shows, the PTE which covered the fault vir=
tual address had the appropriate permission to store.
> >> Is there another way to trigger the "Store/AMO page fault"? Or the cre=
ation of linear mapping in commit 3335068f8721 did something wrong?
> >>
> >> ```
> >> (gdb) p/x $satp
> >> $1 =3D 0xa000000000081708
> >> (gdb) pt -satp 0xa000000000081708
> >>               Address :     Length   Permissions
> >>    0xff1bfffffea39000 :     0x1000 | W:1 X:0 R:1 S:1
> >>    0xff1bfffffebf9000 :     0x1000 | W:1 X:0 R:1 S:1
> >>    0xff1bfffffec00000 :   0x400000 | W:1 X:0 R:1 S:1
> >>    0xff60000000000000 :   0x1c0000 | W:1 X:0 R:1 S:1
> >>    0xff60000000200000 :   0xa00000 | W:0 X:0 R:1 S:1
> >>    0xff60000000c00000 : 0x7f000000 | W:1 X:0 R:1 S:1  // badaddr: ff60=
00007fdb1000
> >>    0xff6000007fdc0000 :    0x3d000 | W:1 X:0 R:1 S:1
> >>    0xff6000007ffbf000 :     0x1000 | W:1 X:0 R:1 S:1
> >>    0xffffffff80000000 :   0xc00000 | W:0 X:1 R:1 S:1
> >>    0xffffffff80c00000 :   0xa00000 | W:1 X:0 R:1 S:1
> >>
> >> ```
> >>
> >> 3. ------
> >>
> >> You can also reproduce similar panic by appending "memtest" in kernel =
cmdline.
> >> I have posted the memtest boot log at this link: https://termbin.com/1=
twl.
> >>
> >> Please correct me if I'm wrong.
> >>
> >> [1]: https://lore.kernel.org/linux-riscv/CAAYs2=3DgQvkhTeioMmqRDVGjdtN=
F_vhB+vm_1dHJxPNi75YDQ_Q@mail.gmail.com/
> >> [2]: https://lore.kernel.org/linux-riscv/20230526-astride-detonator-9a=
e120051159@wendy/
> >> [3]: https://github.com/martinradev/gdb-pt-dump
> >
> > Thanks for the thorough report, really appreciated.
> >
> > So there are multiple issues here:
> >
> > - the first one is that the memory region for opensbi is marked as not
> > cacheable in the efi memory map, and then this region is not mapped in
> > the linear mapping:
> > [    0.000000] efi:   0x000080000000-0x00008003ffff [Reserved    |   |
> >   |  |  |  |  |  |  |  |   |  |  |  |UC]
> >
> > - the second one (that I feel a bit ashamed of...) is that I did not
> > check the alignment of the virtual address when choosing the map size
> > in best_map_size() and then we end up trying to map a physical region
> > aligned on 2MB that is actually not aligned on 2MB virtually because
> > the opensbi region is not mapped at all.
> >
> The issue 2 should be the root cause of this panic.
>
> Here is my understanding of the necessity of the 2M-aligned VA for
> linear PMD mapping. Please correct me if I'm wrong.
>
> I logged the `create_linear_mapping_range()` function.
>
> ```
> song # lowmem region: [0x0000000081800000 -- 0x00000000ffe3d000], va:
> 0xff6000007fbc0000, pa: 0x00000000ffc00000, map_size: 200000 ,pg: e7
> song # lowmem region: [0x0000000081800000 -- 0x00000000ffe3d000], va:
> 0xff6000007fdc0000, pa: 0x00000000ffe00000, map_size: 1000 ,pg: e7
> ```
>
> The PA `0x00000000ffc00000` of this PMD mapping is aligned with PMD_SIZE
> but VA `0xff6000007fbc0000` is not.
> After the `pmd_index()`, this 2M PA region is actually mapping the
> effective VA region `[0xff6000007fa00000,0xff6000007fc00000)`,
> and any access of VA hole between the end of the effective VA region and
> the start VA of the next 4K mapping (`0xff6000007fdc0000`) will fault.
>
> In this report, the memtest fault VA (`0xff6000007fc00000`) and the
> booting fault VA (`ff6000007fdb1000`) lie right in the VA hole.
>
> When reverting the commit 3335068f8721, the kernel load address is
> always offseted by PMD_SIZE, kernel_map.va_pa_offset and
> MIN_MEMBLOCK_ADDR follow it. So the linear PMD mapping will always take
> 2M-aligned VA. That's why this reverting works.

Yes, I agree with you, this is quite an oversight on my side!

>
> > - the possible third one is that we should not map the linear mapping
> > using 4K pages, this would be slow in my opinion, and I think we
> > should waste a bit of memory to align va and pa on a 2MB boundary.
> I also noticed this one.
> >
> > So I'll fix the second issue, and possibly the third one, and if no
> Thanks for your attention to this report, looking for your fixup.

It's running our internal CI, I hope to send it this afternoon or
tomorrow morning so that it can be discussed during the patchwork
meeting.

Thanks again,

Alex

> > one looks into why the opensbi region is mapped in UC, I'll take a
> > look at edk2.
> >
> > Sorry for that,
> >
> > Alex
> >
>
> --
> Song Shuai
> Thanks
>

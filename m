Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B579724150
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 13:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbjFFLuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 07:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbjFFLuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 07:50:37 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E03186
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 04:50:34 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f6042d610fso59713805e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 04:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1686052233; x=1688644233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M8EMdDbUjL4XG7fKUoOhrnPZTq4GDBikqz9MMG7h3Ms=;
        b=0iEo/LQwrBp18M+mlla+WZPg8zD6VUftXMqEqoamYj2IFMWTRFiPxVpmyIG0i7hkwp
         RvF99UqwHuCJ9cNjtNL/UO/xI/QaufRRcQRyjAnyLjSLPYpHoLSZIqQSaJLuIV5FeVxi
         IzTEhQjRDOi2uTG8PQEPGdqjjisLaY+HjqcWVEZx2te0qddzTv4od1Gjz9rq3LwpMvzc
         SAVomgSns9DtbtDXoIXEtGHzkprqPP4is9ZafMP1nUGz/22KoajsZbC13CPQU1hybNjY
         H3l6g+HwFQYy9GnF7n9iWMq6fm985tK22H+p8ERqeZ57WAuZaHxhsdEyE0YS0DQZaq9M
         2oQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686052233; x=1688644233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M8EMdDbUjL4XG7fKUoOhrnPZTq4GDBikqz9MMG7h3Ms=;
        b=D/L53tcWAnEM1+Gn9aMX+36qmOuSSJQAERVObrLFMoN3AvSAhHqmwuMxdSwKOVemmX
         +OBZtJavoyogvrb8uc/BSU2LvrmyiMRt2rSF1gJuMA/wGF4I37h21xArDB85ecjusy2J
         APyBZS0g1sHke0uDdprSVxfp7qaCVivllSsmANi+O5c0jkHf5DrjBy8G1RL339WQ7CPA
         kNdtMVIm8riF+oSXXwmXTmax711QDj+IWsSZhVMbLU5xjwciM+vHoQkP5iuPOS0L2kRR
         tWX7LPhEcXLFHC5CIlyB0gR0k5A37gdX5ufg3iryeBimjMLJZ4MKu1yilXONbW6Xjpp8
         VnhQ==
X-Gm-Message-State: AC+VfDzDYhwPIraxWWxuimFxY8xkqlBU6FxuLAnxdzByVdctkpNMcEl8
        qRrMWiicR1mbb7ljRmCt6O2Thlfjn8PtPLKiN4S79w==
X-Google-Smtp-Source: ACHHUZ4yXUvuBO5X7qRkwpBWDs/S+5TEqbHk3bWzmiq87QHNzuu/tCrZzng4Yydws5clqLOUcTCgfYYRczIBqF0NMuA=
X-Received: by 2002:a05:600c:2158:b0:3f6:f56:5e82 with SMTP id
 v24-20020a05600c215800b003f60f565e82mr1847496wml.3.1686052233249; Tue, 06 Jun
 2023 04:50:33 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_7C3B580B47C1B17C16488EC1@qq.com> <CAHVXubjm5ax5KYTV_G=GUUH0KJK=v6_jO09XF1T4AzzUTr0CSg@mail.gmail.com>
 <ZH37WMnx/rYSRF/o@sunil-laptop> <CAOnJCU+v-tinJb3=FY9GKzR=CGc+AE45wVdpVVZLSG1WOR2PLA@mail.gmail.com>
 <0855b8d6-e1e0-fea6-2b15-d7cc66d34e02@ghiti.fr> <ZH716mJDnHlj1OBz@sunil-laptop>
In-Reply-To: <ZH716mJDnHlj1OBz@sunil-laptop>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Tue, 6 Jun 2023 13:50:22 +0200
Message-ID: <CAHVXubjEyexKuSgyDj4EOy+FCi5mxLPUAqKrJQL5FeX5VPb4eA@mail.gmail.com>
Subject: Re: Bug report: kernel paniced while booting
To:     Sunil V L <sunilvl@ventanamicro.com>
Cc:     Alexandre Ghiti <alex@ghiti.fr>,
        Atish Patra <atishp@atishpatra.org>,
        Song Shuai <songshuaishuai@tinylab.org>,
        robh <robh@kernel.org>, ajones <ajones@ventanamicro.com>,
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

On Tue, Jun 6, 2023 at 11:01=E2=80=AFAM Sunil V L <sunilvl@ventanamicro.com=
> wrote:
>
> On Tue, Jun 06, 2023 at 09:20:34AM +0200, Alexandre Ghiti wrote:
> >
> > On 05/06/2023 22:55, Atish Patra wrote:
> > > On Mon, Jun 5, 2023 at 8:13=E2=80=AFAM Sunil V L <sunilvl@ventanamicr=
o.com> wrote:
> > > > On Mon, Jun 05, 2023 at 04:25:06PM +0200, Alexandre Ghiti wrote:
> > > > > Hi Song,
> > > > >
> > > > > On Mon, Jun 5, 2023 at 12:52=E2=80=AFPM Song Shuai <songshuaishua=
i@tinylab.org> wrote:
> > > > > > Description of problem:
> > > > > >
> > > > > > Booting Linux With RiscVVirtQemu edk2 firmware, a Store/AMO pag=
e fault was trapped to trigger a kernel panic.
> > > > > > The entire log has been posted at this link : https://termbin.c=
om/nga4.
> > > > > >
> > > > > > You can reproduce it with the following step :
> > > > > >
> > > > > > 1. prepare the environment with
> > > > > >     - Qemu-virt:  v8.0.0 (with OpenSbi v1.2)
> > > > > >     - edk2 : at commit (2bc8545883 "UefiCpuPkg/CpuPageTableLib:=
 Reduce the number of random tests")
> > > > > >     - Linux : v6.4-rc1 and later version
> > > > > >
> > > > > > 2. start the Qemu virt board
> > > > > >
> > > > > > ```sh
> > > > > > $ cat ~/8_riscv/start_latest.sh
> > > > > > #!/bin/bash
> > > > > > /home/song/8_riscv/3_acpi/qemu/ooo/usr/local/bin/qemu-system-ri=
scv64 \
> > > > > >          -s -nographic -drive file=3D/home/song/8_riscv/3_acpi/=
Build_virt/RiscVVirtQemu/RELEASE_GCC5/FV/RISCV_VIRT.fd,if=3Dpflash,format=
=3Draw,unit=3D1 \
> > > > > >          -machine virt,acpi=3Doff -smp 2 -m 2G \
> > > > > >          -kernel /home/song/9_linux/linux/00_rv_def/arch/riscv/=
boot/Image \
> > > > > >          -initrd /home/song/8_riscv/3_acpi/buildroot/output/ima=
ges/rootfs.ext2 \
> > > > > >          -append "root=3D/dev/ram ro console=3DttyS0 earlycon=
=3Duart8250,mmio,0x10000000 efi=3Ddebug loglevel=3D8 memblock=3Ddebug" ## a=
lso panic by memtest
> > > > > > ```
> > > > > > 3. Then you will encounter the kernel panic logged in the above=
 link
> > > > > >
> > > > > > Other Information:
> > > > > >
> > > > > > 1. -------
> > > > > >
> > > > > > This report is not identical to my prior report -- "kernel pani=
ced when system hibernates" [1], but both of them
> > > > > > are closely related with the commit (3335068f8721 "riscv: Use P=
UD/P4D/PGD pages for the linear mapping").
> > > > > >
> > > > > > With this commit, hibernation is trapped with "access fault" wh=
ile accessing the PMP-protected regions (mmode_resv0@80000000)
> > > > > > from OpenSbi (BTW, hibernation is marked as nonportable by Cono=
r[2]).
> > > > > >
> > > > > > In this report, efi_init handoffs the memory mapping from Boot =
Services to memblock where reserves mmode_resv0@80000000,
> > > > > > so there is no "access fault" but "page fault".
> > > > > >
> > > > > > And reverting commit 3335068f8721 indeed fixed this panic.
> > > > > >
> > > > > > 2. -------
> > > > > >
> > > > > > As the gdb-pt-dump [3] tool shows, the PTE which covered the fa=
ult virtual address had the appropriate permission to store.
> > > > > > Is there another way to trigger the "Store/AMO page fault"? Or =
the creation of linear mapping in commit 3335068f8721 did something wrong?
> > > > > >
> > > > > > ```
> > > > > > (gdb) p/x $satp
> > > > > > $1 =3D 0xa000000000081708
> > > > > > (gdb) pt -satp 0xa000000000081708
> > > > > >               Address :     Length   Permissions
> > > > > >    0xff1bfffffea39000 :     0x1000 | W:1 X:0 R:1 S:1
> > > > > >    0xff1bfffffebf9000 :     0x1000 | W:1 X:0 R:1 S:1
> > > > > >    0xff1bfffffec00000 :   0x400000 | W:1 X:0 R:1 S:1
> > > > > >    0xff60000000000000 :   0x1c0000 | W:1 X:0 R:1 S:1
> > > > > >    0xff60000000200000 :   0xa00000 | W:0 X:0 R:1 S:1
> > > > > >    0xff60000000c00000 : 0x7f000000 | W:1 X:0 R:1 S:1  // badadd=
r: ff6000007fdb1000
> > > > > >    0xff6000007fdc0000 :    0x3d000 | W:1 X:0 R:1 S:1
> > > > > >    0xff6000007ffbf000 :     0x1000 | W:1 X:0 R:1 S:1
> > > > > >    0xffffffff80000000 :   0xc00000 | W:0 X:1 R:1 S:1
> > > > > >    0xffffffff80c00000 :   0xa00000 | W:1 X:0 R:1 S:1
> > > > > >
> > > > > > ```
> > > > > >
> > > > > > 3. ------
> > > > > >
> > > > > > You can also reproduce similar panic by appending "memtest" in =
kernel cmdline.
> > > > > > I have posted the memtest boot log at this link: https://termbi=
n.com/1twl.
> > > > > >
> > > > > > Please correct me if I'm wrong.
> > > > > >
> > > > > > [1]: https://lore.kernel.org/linux-riscv/CAAYs2=3DgQvkhTeioMmqR=
DVGjdtNF_vhB+vm_1dHJxPNi75YDQ_Q@mail.gmail.com/
> > > > > > [2]: https://lore.kernel.org/linux-riscv/20230526-astride-deton=
ator-9ae120051159@wendy/
> > > > > > [3]: https://github.com/martinradev/gdb-pt-dump
> > > > > Thanks for the thorough report, really appreciated.
> > > > >
> > > > > So there are multiple issues here:
> > > > >
> > > > > - the first one is that the memory region for opensbi is marked a=
s not
> > > > > cacheable in the efi memory map, and then this region is not mapp=
ed in
> > > > > the linear mapping:
> > > > > [    0.000000] efi:   0x000080000000-0x00008003ffff [Reserved    =
|   |
> > > > >   |  |  |  |  |  |  |  |   |  |  |  |UC]
> > > > >
> > > @Alex: The OpenSBI region is marked reserved because EDK2 chooses to
> > > do that explicitly as explained by Sunil.
> > > I don't think UC has to do anything with it. All the EFI memory regio=
ns are UC.
> >
> >
> > Oops, thanks for correcting me, UC has nothing to do with that indeed, =
I
> > misread is_usable_memory() (https://elixir.bootlin.com/linux/latest/sou=
rce/drivers/firmware/efi/efi-init.c#L127):
> > EFI_RESERVED_TYPE will return false.
> >
> > And then this region won't get mapped, so that's the equivalent of "no-=
map".
> >
> >
> > >
> > > > > - the second one (that I feel a bit ashamed of...) is that I did =
not
> > > > > check the alignment of the virtual address when choosing the map =
size
> > > > > in best_map_size() and then we end up trying to map a physical re=
gion
> > > > > aligned on 2MB that is actually not aligned on 2MB virtually beca=
use
> > > > > the opensbi region is not mapped at all.
> > > > >
> > > > > - the possible third one is that we should not map the linear map=
ping
> > > > > using 4K pages, this would be slow in my opinion, and I think we
> > > > > should waste a bit of memory to align va and pa on a 2MB boundary=
.
> > > > >
> > > > > So I'll fix the second issue, and possibly the third one, and if =
no
> > > > > one looks into why the opensbi region is mapped in UC, I'll take =
a
> > > > > look at edk2.
> > > > >
> > > > Hi Alex,
> > > >
> > > > EDK2 marks opensbi range as reserved memory in EFI map. According t=
o DT
> > > > spec, if the no-map is not set, we need to mark it as
> > > > EfiBootServicesData but EfiBootServicesData is actually considered =
as
> > > > free memory in kernel, as per UEFI spec. To avoid kernel using this
> > > > memory, we deviated from the DT spec for opensbi ranges.
> > > >
> > > IMO, that should be the correct way unless we can change it to
> > > EfiRunServicesData/Code.
> >
> >
> > I'd say that everything depends on "reusable" no?
> >
> > If "no-map" then
> >    EfiReserved
> > else
> >    if reusable then
> >       EfiBootServicesData
> >    else
> >       EfiRuntimeServicesData
> >    endif
> > endif
> >
> Hi Alex,
>
> Is this your proposal or documented somewhere? If it is proposal, this
> option was intentionally not allowed as I understand from Ard's response
> at [1].
>
> [1] - https://github.com/ARM-software/ebbr/issues/52#issuecomment-6903622=
94

You mean because EfiRuntimeServicesData are actually not mapped in the
linear mapping by the kernel right? In that case, yes you're right!

>
> Thanks,
> Sunil

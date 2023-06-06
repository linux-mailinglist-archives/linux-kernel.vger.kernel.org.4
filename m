Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C284A723425
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 02:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232795AbjFFAsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 20:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232727AbjFFAsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 20:48:43 -0400
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09CF2EA
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 17:48:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686012490; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=jZbF6t8CrMYjUmeMR3ZD4aJ135DDCAUbPem7f0VpmhynxqoOZklecjbGHwRoixdXJyGf7+ex3y8GOVVEBvfEvzLnAVM6KKRKujoxZ/1GAvOVNiIbVZ6p6Bgy7K8fAhc0KnYqec7o/6U8g7vpOXHnVheaF69m8GDluwW+kFK3Vmk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1686012490; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=Puzfq8Z7iFo9mTVJ5zXOtSpUSGzex+7YQX+3D4fGb48=; 
        b=ejU+jznQMebHyn6eo3bqg+D/3AIYirEyAruBxZCKNsDZ5aYdJ6Rn81D7hSLMz6W7Ss6hLHvGsore5pgQqlVGQ4qp+orAmp0Qww5r4cqaxunuvUmVazgswUqK5C7wD2i0gxajLfWm3mWuHrVVI+8iTMxwEGz06Mr1VPNSb1+pIWk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1686012490;
        s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
        h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
        bh=Puzfq8Z7iFo9mTVJ5zXOtSpUSGzex+7YQX+3D4fGb48=;
        b=UsFEjVm7jz/Iaos8oWwtFw+8LDa4ON89lLgA7G5v8nLGaDynfZ4h9r5//TS6M0Kv
        qAWeGRM5nfr6En7PM7zShYswRS88NiUH6QmnvB0XzYmVQu+Rx5yX1wbtdoPPwJzrAt5
        7XbBymTlKAG9LaZNjckb3J2bQnJivVWmai4Gt69zOyGiTpEMAyflaBX3QPxfyUQ3LQB
        vT7isgTEGIa3eVowWz8mc7eZFOFC43N/8a7RBQ95WP4K8eHVfxBZU86A/ye3u2kOaLn
        +8PV9ICOPciv0SOP64ijYP6jwbwH8A8x+v7owmbuFLCrEOnM2p/xl738yl/zVBtqbiH
        vjjwcQRBLQ==
Received: from edelgard.fodlan.icenowy.me (120.85.99.123 [120.85.99.123]) by mx.zohomail.com
        with SMTPS id 1686012489918450.4319964852141; Mon, 5 Jun 2023 17:48:09 -0700 (PDT)
Message-ID: <bbc2d1d2e32587c4e212965dab9480b6790f1d37.camel@icenowy.me>
Subject: Re: Bug report: kernel paniced while booting
From:   Icenowy Zheng <uwu@icenowy.me>
To:     Atish Patra <atishp@atishpatra.org>,
        Sunil V L <sunilvl@ventanamicro.com>
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>,
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
Date:   Tue, 06 Jun 2023 08:48:03 +0800
In-Reply-To: <CAOnJCU+v-tinJb3=FY9GKzR=CGc+AE45wVdpVVZLSG1WOR2PLA@mail.gmail.com>
References: <tencent_7C3B580B47C1B17C16488EC1@qq.com>
         <CAHVXubjm5ax5KYTV_G=GUUH0KJK=v6_jO09XF1T4AzzUTr0CSg@mail.gmail.com>
         <ZH37WMnx/rYSRF/o@sunil-laptop>
         <CAOnJCU+v-tinJb3=FY9GKzR=CGc+AE45wVdpVVZLSG1WOR2PLA@mail.gmail.com>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 
MIME-Version: 1.0
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E5=9C=A8 2023-06-05=E6=98=9F=E6=9C=9F=E4=B8=80=E7=9A=84 13:55 -0700=EF=BC=
=8CAtish Patra=E5=86=99=E9=81=93=EF=BC=9A
> On Mon, Jun 5, 2023 at 8:13=E2=80=AFAM Sunil V L <sunilvl@ventanamicro.co=
m>
> wrote:
> >=20
> > On Mon, Jun 05, 2023 at 04:25:06PM +0200, Alexandre Ghiti wrote:
> > > Hi Song,
> > >=20
> > > On Mon, Jun 5, 2023 at 12:52=E2=80=AFPM Song Shuai
> > > <songshuaishuai@tinylab.org> wrote:
> > > >=20
> > > > Description of problem:
> > > >=20
> > > > Booting Linux With RiscVVirtQemu edk2 firmware, a Store/AMO
> > > > page fault was trapped to trigger a kernel panic.
> > > > The entire log has been posted at this link :
> > > > https://termbin.com/nga4.
> > > >=20
> > > > You can reproduce it with the following step :
> > > >=20
> > > > 1. prepare the environment with
> > > > =C2=A0=C2=A0 - Qemu-virt:=C2=A0 v8.0.0 (with OpenSbi v1.2)
> > > > =C2=A0=C2=A0 - edk2 : at commit (2bc8545883 "UefiCpuPkg/CpuPageTabl=
eLib:
> > > > Reduce the number of random tests")
> > > > =C2=A0=C2=A0 - Linux : v6.4-rc1 and later version
> > > >=20
> > > > 2. start the Qemu virt board
> > > >=20
> > > > ```sh
> > > > $ cat ~/8_riscv/start_latest.sh
> > > > #!/bin/bash
> > > > /home/song/8_riscv/3_acpi/qemu/ooo/usr/local/bin/qemu-system-
> > > > riscv64 \
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -s -nographic -drive
> > > > file=3D/home/song/8_riscv/3_acpi/Build_virt/RiscVVirtQemu/RELEASE
> > > > _GCC5/FV/RISCV_VIRT.fd,if=3Dpflash,format=3Draw,unit=3D1 \
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -machine virt,acpi=3Doff=
 -smp 2 -m 2G \
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -kernel
> > > > /home/song/9_linux/linux/00_rv_def/arch/riscv/boot/Image \
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -initrd
> > > > /home/song/8_riscv/3_acpi/buildroot/output/images/rootfs.ext2 \
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -append "root=3D/dev/ram=
 ro console=3DttyS0
> > > > earlycon=3Duart8250,mmio,0x10000000 efi=3Ddebug loglevel=3D8
> > > > memblock=3Ddebug" ## also panic by memtest
> > > > ```
> > > > 3. Then you will encounter the kernel panic logged in the above
> > > > link
> > > >=20
> > > > Other Information:
> > > >=20
> > > > 1. -------
> > > >=20
> > > > This report is not identical to my prior report -- "kernel
> > > > paniced when system hibernates" [1], but both of them
> > > > are closely related with the commit (3335068f8721 "riscv: Use
> > > > PUD/P4D/PGD pages for the linear mapping").
> > > >=20
> > > > With this commit, hibernation is trapped with "access fault"
> > > > while accessing the PMP-protected regions
> > > > (mmode_resv0@80000000)
> > > > from OpenSbi (BTW, hibernation is marked as nonportable by
> > > > Conor[2]).
> > > >=20
> > > > In this report, efi_init handoffs the memory mapping from Boot
> > > > Services to memblock where reserves mmode_resv0@80000000,
> > > > so there is no "access fault" but "page fault".
> > > >=20
> > > > And reverting commit 3335068f8721 indeed fixed this panic.
> > > >=20
> > > > 2. -------
> > > >=20
> > > > As the gdb-pt-dump [3] tool shows, the PTE which covered the
> > > > fault virtual address had the appropriate permission to store.
> > > > Is there another way to trigger the "Store/AMO page fault"? Or
> > > > the creation of linear mapping in commit 3335068f8721 did
> > > > something wrong?
> > > >=20
> > > > ```
> > > > (gdb) p/x $satp
> > > > $1 =3D 0xa000000000081708
> > > > (gdb) pt -satp 0xa000000000081708
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 Address :=C2=A0=C2=A0=C2=A0=C2=A0 Length=C2=A0=C2=A0 Permissions
> > > > =C2=A0 0xff1bfffffea39000 :=C2=A0=C2=A0=C2=A0=C2=A0 0x1000 | W:1 X:=
0 R:1 S:1
> > > > =C2=A0 0xff1bfffffebf9000 :=C2=A0=C2=A0=C2=A0=C2=A0 0x1000 | W:1 X:=
0 R:1 S:1
> > > > =C2=A0 0xff1bfffffec00000 :=C2=A0=C2=A0 0x400000 | W:1 X:0 R:1 S:1
> > > > =C2=A0 0xff60000000000000 :=C2=A0=C2=A0 0x1c0000 | W:1 X:0 R:1 S:1
> > > > =C2=A0 0xff60000000200000 :=C2=A0=C2=A0 0xa00000 | W:0 X:0 R:1 S:1
> > > > =C2=A0 0xff60000000c00000 : 0x7f000000 | W:1 X:0 R:1 S:1=C2=A0 //
> > > > badaddr: ff6000007fdb1000
> > > > =C2=A0 0xff6000007fdc0000 :=C2=A0=C2=A0=C2=A0 0x3d000 | W:1 X:0 R:1=
 S:1
> > > > =C2=A0 0xff6000007ffbf000 :=C2=A0=C2=A0=C2=A0=C2=A0 0x1000 | W:1 X:=
0 R:1 S:1
> > > > =C2=A0 0xffffffff80000000 :=C2=A0=C2=A0 0xc00000 | W:0 X:1 R:1 S:1
> > > > =C2=A0 0xffffffff80c00000 :=C2=A0=C2=A0 0xa00000 | W:1 X:0 R:1 S:1
> > > >=20
> > > > ```
> > > >=20
> > > > 3. ------
> > > >=20
> > > > You can also reproduce similar panic by appending "memtest" in
> > > > kernel cmdline.
> > > > I have posted the memtest boot log at this link:
> > > > https://termbin.com/1twl.
> > > >=20
> > > > Please correct me if I'm wrong.
> > > >=20
> > > > [1]:
> > > > https://lore.kernel.org/linux-riscv/CAAYs2=3DgQvkhTeioMmqRDVGjdtNF_=
vhB+vm_1dHJxPNi75YDQ_Q@mail.gmail.com/
> > > > [2]:
> > > > https://lore.kernel.org/linux-riscv/20230526-astride-detonator-9ae1=
20051159@wendy/
> > > > [3]: https://github.com/martinradev/gdb-pt-dump
> > >=20
> > > Thanks for the thorough report, really appreciated.
> > >=20
> > > So there are multiple issues here:
> > >=20
> > > - the first one is that the memory region for opensbi is marked
> > > as not
> > > cacheable in the efi memory map, and then this region is not
> > > mapped in
> > > the linear mapping:
> > > [=C2=A0=C2=A0=C2=A0 0.000000] efi:=C2=A0=C2=A0 0x000080000000-0x00008=
003ffff [Reserved=C2=A0=C2=A0=C2=A0
> > > |=C2=A0=C2=A0 |
> > > =C2=A0|=C2=A0 |=C2=A0 |=C2=A0 |=C2=A0 |=C2=A0 |=C2=A0 |=C2=A0 |=C2=A0=
=C2=A0 |=C2=A0 |=C2=A0 |=C2=A0 |UC]
> > >=20
>=20
> @Alex: The OpenSBI region is marked reserved because EDK2 chooses to
> do that explicitly as explained by Sunil.
> I don't think UC has to do anything with it. All the EFI memory
> regions are UC.
>=20
> > > - the second one (that I feel a bit ashamed of...) is that I did
> > > not
> > > check the alignment of the virtual address when choosing the map
> > > size
> > > in best_map_size() and then we end up trying to map a physical
> > > region
> > > aligned on 2MB that is actually not aligned on 2MB virtually
> > > because
> > > the opensbi region is not mapped at all.
> > >=20
> > > - the possible third one is that we should not map the linear
> > > mapping
> > > using 4K pages, this would be slow in my opinion, and I think we
> > > should waste a bit of memory to align va and pa on a 2MB
> > > boundary.
> > >=20
> > > So I'll fix the second issue, and possibly the third one, and if
> > > no
> > > one looks into why the opensbi region is mapped in UC, I'll take
> > > a
> > > look at edk2.
> > >=20
> > Hi Alex,
> >=20
> > EDK2 marks opensbi range as reserved memory in EFI map. According
> > to DT
> > spec, if the no-map is not set, we need to mark it as
> > EfiBootServicesData but EfiBootServicesData is actually considered
> > as
> > free memory in kernel, as per UEFI spec. To avoid kernel using this
> > memory, we deviated from the DT spec for opensbi ranges.
> >=20
>=20
> IMO, that should be the correct way unless we can change it to
> EfiRunServicesData/Code.
> Looking at U-Boot code, it sets the no-map region to
> EfiBootServicesData which may cause
> issues in RISC-V as well if we linear mapping sets up the initial
> 2MB.

Semantically I think no-map means the kernel should not be utilizing
it, so it should be EfiRunServicesData instead.

>=20
>=20
> > Let me know your thoughts how we can handle this better in EDK2
> > considering it has to support ACPI also.
> >=20
> > Thanks,
> > Sunil
> >=20
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
>=20
>=20
>=20


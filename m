Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F94D723C75
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 11:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237395AbjFFJBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 05:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234678AbjFFJBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 05:01:41 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68EE28F
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 02:01:39 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1b00ffb4186so34034265ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 02:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1686042099; x=1688634099;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=O6GNn4GUsKMsL/pW57HJSd6ui2CnlDqJZ6BWEi8KGSY=;
        b=C7FjtbGAH3IyOKQiiyPjCTc4qAzVIgfuvRCHvDA0Te8mpBU42JH0oIWodfPPF+El1b
         67Hjku/zAZCZSqNUIdh2nrGlK3hp+tnR5JWCwmcMcNzreS36HnuZ5idn+qMx1lkkTjrW
         Q/37SmSDoBVgJg9JU5msuxzNdDto/evJlUoamRjs6GMAqZ1S06Egl6NaoaOuGhwe+oBN
         MxPmC/1pgV9K2rD3D2xfanHoS33gtw1DhTT0PXOjuaW7Wk8p5c74owWsglmM1QaHLSA3
         iaCAAB4WgEOzaS8Cs5BF9FnZyy+x/PBGLMAMFgQGKfGslDLjs8xE4Jykz7I64quDU4Wk
         l3Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686042099; x=1688634099;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O6GNn4GUsKMsL/pW57HJSd6ui2CnlDqJZ6BWEi8KGSY=;
        b=lr0lp5VzPJkSJUdwvuBjjED5mLThB+yxtgfVtcNkp7AHG/eKNb6qflm4iXWBFjNzTo
         oo8/5BzYtZpUpSkb/BHjBnVZfwZbLWiToiIIg0h1bTg0kj3mA/ksuNbtgOn4Ck+dWOO7
         eHAXQr1bk+prjDLP9IpL5ihj19SmFBmjofguYZnxJkOaR8h7Pe4v+kz4xLPhKsf3/vLd
         iqD4BeGBxKxC1GNGtPaBDO/RufaTDKXi/h0ui9JAo1cMHyHao8SpfojUO8StNilEUBHQ
         zSvB9zxJqFaCCnt8wfW9JUUUA2t+932fqYC+61zDjQGOTcbv6SuQ1uggK1zIf8DeM+IS
         2p4Q==
X-Gm-Message-State: AC+VfDyXZK/oahCeyB2o2+5RM7Sb8psAgzdVzgrw3KK5ZNc1k0sX+w7q
        UDuBoBe90T2m0kfAxmT/eI/2ZA==
X-Google-Smtp-Source: ACHHUZ53GMdii/+LP4ueXdHs8VsgDNcktxztQynmtThIFWFOHmTJgv/iK1/vT3PZrXG5ASVrIfLj6g==
X-Received: by 2002:a17:902:bcc1:b0:1ac:482e:ed4d with SMTP id o1-20020a170902bcc100b001ac482eed4dmr959740pls.18.1686042098819;
        Tue, 06 Jun 2023 02:01:38 -0700 (PDT)
Received: from sunil-laptop ([106.51.186.3])
        by smtp.gmail.com with ESMTPSA id s10-20020a170902ea0a00b001b03ae38496sm8029457plg.48.2023.06.06.02.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 02:01:38 -0700 (PDT)
Date:   Tue, 6 Jun 2023 14:31:30 +0530
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
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
Subject: Re: Bug report: kernel paniced while booting
Message-ID: <ZH716mJDnHlj1OBz@sunil-laptop>
References: <tencent_7C3B580B47C1B17C16488EC1@qq.com>
 <CAHVXubjm5ax5KYTV_G=GUUH0KJK=v6_jO09XF1T4AzzUTr0CSg@mail.gmail.com>
 <ZH37WMnx/rYSRF/o@sunil-laptop>
 <CAOnJCU+v-tinJb3=FY9GKzR=CGc+AE45wVdpVVZLSG1WOR2PLA@mail.gmail.com>
 <0855b8d6-e1e0-fea6-2b15-d7cc66d34e02@ghiti.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0855b8d6-e1e0-fea6-2b15-d7cc66d34e02@ghiti.fr>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 09:20:34AM +0200, Alexandre Ghiti wrote:
> 
> On 05/06/2023 22:55, Atish Patra wrote:
> > On Mon, Jun 5, 2023 at 8:13 AM Sunil V L <sunilvl@ventanamicro.com> wrote:
> > > On Mon, Jun 05, 2023 at 04:25:06PM +0200, Alexandre Ghiti wrote:
> > > > Hi Song,
> > > > 
> > > > On Mon, Jun 5, 2023 at 12:52 PM Song Shuai <songshuaishuai@tinylab.org> wrote:
> > > > > Description of problem:
> > > > > 
> > > > > Booting Linux With RiscVVirtQemu edk2 firmware, a Store/AMO page fault was trapped to trigger a kernel panic.
> > > > > The entire log has been posted at this link : https://termbin.com/nga4.
> > > > > 
> > > > > You can reproduce it with the following step :
> > > > > 
> > > > > 1. prepare the environment with
> > > > >     - Qemu-virt:  v8.0.0 (with OpenSbi v1.2)
> > > > >     - edk2 : at commit (2bc8545883 "UefiCpuPkg/CpuPageTableLib: Reduce the number of random tests")
> > > > >     - Linux : v6.4-rc1 and later version
> > > > > 
> > > > > 2. start the Qemu virt board
> > > > > 
> > > > > ```sh
> > > > > $ cat ~/8_riscv/start_latest.sh
> > > > > #!/bin/bash
> > > > > /home/song/8_riscv/3_acpi/qemu/ooo/usr/local/bin/qemu-system-riscv64 \
> > > > >          -s -nographic -drive file=/home/song/8_riscv/3_acpi/Build_virt/RiscVVirtQemu/RELEASE_GCC5/FV/RISCV_VIRT.fd,if=pflash,format=raw,unit=1 \
> > > > >          -machine virt,acpi=off -smp 2 -m 2G \
> > > > >          -kernel /home/song/9_linux/linux/00_rv_def/arch/riscv/boot/Image \
> > > > >          -initrd /home/song/8_riscv/3_acpi/buildroot/output/images/rootfs.ext2 \
> > > > >          -append "root=/dev/ram ro console=ttyS0 earlycon=uart8250,mmio,0x10000000 efi=debug loglevel=8 memblock=debug" ## also panic by memtest
> > > > > ```
> > > > > 3. Then you will encounter the kernel panic logged in the above link
> > > > > 
> > > > > Other Information:
> > > > > 
> > > > > 1. -------
> > > > > 
> > > > > This report is not identical to my prior report -- "kernel paniced when system hibernates" [1], but both of them
> > > > > are closely related with the commit (3335068f8721 "riscv: Use PUD/P4D/PGD pages for the linear mapping").
> > > > > 
> > > > > With this commit, hibernation is trapped with "access fault" while accessing the PMP-protected regions (mmode_resv0@80000000)
> > > > > from OpenSbi (BTW, hibernation is marked as nonportable by Conor[2]).
> > > > > 
> > > > > In this report, efi_init handoffs the memory mapping from Boot Services to memblock where reserves mmode_resv0@80000000,
> > > > > so there is no "access fault" but "page fault".
> > > > > 
> > > > > And reverting commit 3335068f8721 indeed fixed this panic.
> > > > > 
> > > > > 2. -------
> > > > > 
> > > > > As the gdb-pt-dump [3] tool shows, the PTE which covered the fault virtual address had the appropriate permission to store.
> > > > > Is there another way to trigger the "Store/AMO page fault"? Or the creation of linear mapping in commit 3335068f8721 did something wrong?
> > > > > 
> > > > > ```
> > > > > (gdb) p/x $satp
> > > > > $1 = 0xa000000000081708
> > > > > (gdb) pt -satp 0xa000000000081708
> > > > >               Address :     Length   Permissions
> > > > >    0xff1bfffffea39000 :     0x1000 | W:1 X:0 R:1 S:1
> > > > >    0xff1bfffffebf9000 :     0x1000 | W:1 X:0 R:1 S:1
> > > > >    0xff1bfffffec00000 :   0x400000 | W:1 X:0 R:1 S:1
> > > > >    0xff60000000000000 :   0x1c0000 | W:1 X:0 R:1 S:1
> > > > >    0xff60000000200000 :   0xa00000 | W:0 X:0 R:1 S:1
> > > > >    0xff60000000c00000 : 0x7f000000 | W:1 X:0 R:1 S:1  // badaddr: ff6000007fdb1000
> > > > >    0xff6000007fdc0000 :    0x3d000 | W:1 X:0 R:1 S:1
> > > > >    0xff6000007ffbf000 :     0x1000 | W:1 X:0 R:1 S:1
> > > > >    0xffffffff80000000 :   0xc00000 | W:0 X:1 R:1 S:1
> > > > >    0xffffffff80c00000 :   0xa00000 | W:1 X:0 R:1 S:1
> > > > > 
> > > > > ```
> > > > > 
> > > > > 3. ------
> > > > > 
> > > > > You can also reproduce similar panic by appending "memtest" in kernel cmdline.
> > > > > I have posted the memtest boot log at this link: https://termbin.com/1twl.
> > > > > 
> > > > > Please correct me if I'm wrong.
> > > > > 
> > > > > [1]: https://lore.kernel.org/linux-riscv/CAAYs2=gQvkhTeioMmqRDVGjdtNF_vhB+vm_1dHJxPNi75YDQ_Q@mail.gmail.com/
> > > > > [2]: https://lore.kernel.org/linux-riscv/20230526-astride-detonator-9ae120051159@wendy/
> > > > > [3]: https://github.com/martinradev/gdb-pt-dump
> > > > Thanks for the thorough report, really appreciated.
> > > > 
> > > > So there are multiple issues here:
> > > > 
> > > > - the first one is that the memory region for opensbi is marked as not
> > > > cacheable in the efi memory map, and then this region is not mapped in
> > > > the linear mapping:
> > > > [    0.000000] efi:   0x000080000000-0x00008003ffff [Reserved    |   |
> > > >   |  |  |  |  |  |  |  |   |  |  |  |UC]
> > > > 
> > @Alex: The OpenSBI region is marked reserved because EDK2 chooses to
> > do that explicitly as explained by Sunil.
> > I don't think UC has to do anything with it. All the EFI memory regions are UC.
> 
> 
> Oops, thanks for correcting me, UC has nothing to do with that indeed, I
> misread is_usable_memory() (https://elixir.bootlin.com/linux/latest/source/drivers/firmware/efi/efi-init.c#L127):
> EFI_RESERVED_TYPE will return false.
> 
> And then this region won't get mapped, so that's the equivalent of "no-map".
> 
> 
> > 
> > > > - the second one (that I feel a bit ashamed of...) is that I did not
> > > > check the alignment of the virtual address when choosing the map size
> > > > in best_map_size() and then we end up trying to map a physical region
> > > > aligned on 2MB that is actually not aligned on 2MB virtually because
> > > > the opensbi region is not mapped at all.
> > > > 
> > > > - the possible third one is that we should not map the linear mapping
> > > > using 4K pages, this would be slow in my opinion, and I think we
> > > > should waste a bit of memory to align va and pa on a 2MB boundary.
> > > > 
> > > > So I'll fix the second issue, and possibly the third one, and if no
> > > > one looks into why the opensbi region is mapped in UC, I'll take a
> > > > look at edk2.
> > > > 
> > > Hi Alex,
> > > 
> > > EDK2 marks opensbi range as reserved memory in EFI map. According to DT
> > > spec, if the no-map is not set, we need to mark it as
> > > EfiBootServicesData but EfiBootServicesData is actually considered as
> > > free memory in kernel, as per UEFI spec. To avoid kernel using this
> > > memory, we deviated from the DT spec for opensbi ranges.
> > > 
> > IMO, that should be the correct way unless we can change it to
> > EfiRunServicesData/Code.
> 
> 
> I'd say that everything depends on "reusable" no?
> 
> If "no-map" then
>    EfiReserved
> else
>    if reusable then
>       EfiBootServicesData
>    else
>       EfiRuntimeServicesData
>    endif
> endif
> 
Hi Alex,

Is this your proposal or documented somewhere? If it is proposal, this
option was intentionally not allowed as I understand from Ard's response
at [1].

[1] - https://github.com/ARM-software/ebbr/issues/52#issuecomment-690362294

Thanks,
Sunil

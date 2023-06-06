Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 609857237E4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 08:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234911AbjFFGk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 02:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbjFFGkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 02:40:52 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A98197
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 23:40:50 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-3f6a494810fso50486411cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 23:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1686033650; x=1688625650;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UqiAGy4qjIy1yaY4y/HmMSGJUjUy+hsSGeNr2uAnUAM=;
        b=jTFytEe+/lfsw/dBrLdsmHanoP8VdhpHPsJCubi7YBwlblGJ/ouddT/j4w58BKFhWd
         AvbdadsSZjKHMeeRE09GD4ihk74wGmuuVEdux0zDRKrscLa436PKCKWfDSnRLgZA6XT1
         qSEAexPWUGFF7FqfhVqDLZA/qbO7iKNMjgJveymS/dGZgYxVp0oaSeXBVzU+wYfaR+6J
         c+41Ysz3fAwxyr294QrsFzP1xy1gvTaAQtryY11QkMXcQliL26P+0bgAyxejveLAP79X
         b5QGXPGFBDOx+Jg6MScxQIophjY0w7NI3J+fYnYYDP379coJuRMsO8BquBCdax8fjg4W
         s6Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686033650; x=1688625650;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UqiAGy4qjIy1yaY4y/HmMSGJUjUy+hsSGeNr2uAnUAM=;
        b=WQWVS68X4UDRpvHIVXAW5Nh4+0IcEde6CCkVuAVxQpO6Mv6NzsEzdWjNqUTOEXRRHe
         9FtMsbVA11H/5jeZG2nepjV5zdFSuId3hL9NNRIJUHxkMVOeoSwrlibSc9KOUzbdBISX
         urLyNItf987GxZdxBu8LF2JvP5zQVjRoE2bNEd//6veg/eJo2NidsQUyxS4JMCfBm/ik
         seJ97SCUICajXdtfB3B36DhF9GvrNh4JqjaUsSg0LdJ/BAijsyyr0Sfe94NawLIcJ/3M
         Jy/B0hgoRkMv0mHgERbTxLcG0QVI0GBuSNuxMeFNKPeiy3m5Vft7eD+c2Swxs7xzSTf4
         lzAA==
X-Gm-Message-State: AC+VfDzHtVZNSssJa0mFgeZFYD425xS6g0E4JM5ri/VlmlhSvdi4kCCy
        AnXblKp4hAPULPMnLwBtaYbECw==
X-Google-Smtp-Source: ACHHUZ7hK2xB12BHJ6pZPC6BE+RPCtoGiN2HQvQ+oItvkSCnjbdaYZJ8dNPr3fXz+5gG//AJXkWHOQ==
X-Received: by 2002:a05:622a:3cd:b0:3f5:34fc:f216 with SMTP id k13-20020a05622a03cd00b003f534fcf216mr1073327qtx.54.1686033650038;
        Mon, 05 Jun 2023 23:40:50 -0700 (PDT)
Received: from sunil-laptop ([106.51.186.3])
        by smtp.gmail.com with ESMTPSA id s1-20020a17090a2f0100b0023d386e4806sm7320837pjd.57.2023.06.05.23.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 23:40:49 -0700 (PDT)
Date:   Tue, 6 Jun 2023 12:10:41 +0530
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Jessica Clarke <jrtc27@jrtc27.com>
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
Subject: Re: Bug report: kernel paniced while booting
Message-ID: <ZH7U6QTbKsO0kfYx@sunil-laptop>
References: <tencent_7C3B580B47C1B17C16488EC1@qq.com>
 <CAHVXubjm5ax5KYTV_G=GUUH0KJK=v6_jO09XF1T4AzzUTr0CSg@mail.gmail.com>
 <ZH37WMnx/rYSRF/o@sunil-laptop>
 <38747287-B219-4B48-B088-A33ADC7954A0@jrtc27.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <38747287-B219-4B48-B088-A33ADC7954A0@jrtc27.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 05, 2023 at 10:42:33PM +0100, Jessica Clarke wrote:
> On 5 Jun 2023, at 16:12, Sunil V L <sunilvl@ventanamicro.com> wrote:
> > 
> > On Mon, Jun 05, 2023 at 04:25:06PM +0200, Alexandre Ghiti wrote:
> >> Hi Song,
> >> 
> >> On Mon, Jun 5, 2023 at 12:52 PM Song Shuai <songshuaishuai@tinylab.org> wrote:
> >>> 
> >>> Description of problem:
> >>> 
> >>> Booting Linux With RiscVVirtQemu edk2 firmware, a Store/AMO page fault was trapped to trigger a kernel panic.
> >>> The entire log has been posted at this link : https://termbin.com/nga4.
> >>> 
> >>> You can reproduce it with the following step :
> >>> 
> >>> 1. prepare the environment with
> >>>   - Qemu-virt:  v8.0.0 (with OpenSbi v1.2)
> >>>   - edk2 : at commit (2bc8545883 "UefiCpuPkg/CpuPageTableLib: Reduce the number of random tests")
> >>>   - Linux : v6.4-rc1 and later version
> >>> 
> >>> 2. start the Qemu virt board
> >>> 
> >>> ```sh
> >>> $ cat ~/8_riscv/start_latest.sh
> >>> #!/bin/bash
> >>> /home/song/8_riscv/3_acpi/qemu/ooo/usr/local/bin/qemu-system-riscv64 \
> >>>        -s -nographic -drive file=/home/song/8_riscv/3_acpi/Build_virt/RiscVVirtQemu/RELEASE_GCC5/FV/RISCV_VIRT.fd,if=pflash,format=raw,unit=1 \
> >>>        -machine virt,acpi=off -smp 2 -m 2G \
> >>>        -kernel /home/song/9_linux/linux/00_rv_def/arch/riscv/boot/Image \
> >>>        -initrd /home/song/8_riscv/3_acpi/buildroot/output/images/rootfs.ext2 \
> >>>        -append "root=/dev/ram ro console=ttyS0 earlycon=uart8250,mmio,0x10000000 efi=debug loglevel=8 memblock=debug" ## also panic by memtest
> >>> ```
> >>> 3. Then you will encounter the kernel panic logged in the above link
> >>> 
> >>> Other Information:
> >>> 
> >>> 1. -------
> >>> 
> >>> This report is not identical to my prior report -- "kernel paniced when system hibernates" [1], but both of them
> >>> are closely related with the commit (3335068f8721 "riscv: Use PUD/P4D/PGD pages for the linear mapping").
> >>> 
> >>> With this commit, hibernation is trapped with "access fault" while accessing the PMP-protected regions (mmode_resv0@80000000)
> >>> from OpenSbi (BTW, hibernation is marked as nonportable by Conor[2]).
> >>> 
> >>> In this report, efi_init handoffs the memory mapping from Boot Services to memblock where reserves mmode_resv0@80000000,
> >>> so there is no "access fault" but "page fault".
> >>> 
> >>> And reverting commit 3335068f8721 indeed fixed this panic.
> >>> 
> >>> 2. -------
> >>> 
> >>> As the gdb-pt-dump [3] tool shows, the PTE which covered the fault virtual address had the appropriate permission to store.
> >>> Is there another way to trigger the "Store/AMO page fault"? Or the creation of linear mapping in commit 3335068f8721 did something wrong?
> >>> 
> >>> ```
> >>> (gdb) p/x $satp
> >>> $1 = 0xa000000000081708
> >>> (gdb) pt -satp 0xa000000000081708
> >>>             Address :     Length   Permissions
> >>>  0xff1bfffffea39000 :     0x1000 | W:1 X:0 R:1 S:1
> >>>  0xff1bfffffebf9000 :     0x1000 | W:1 X:0 R:1 S:1
> >>>  0xff1bfffffec00000 :   0x400000 | W:1 X:0 R:1 S:1
> >>>  0xff60000000000000 :   0x1c0000 | W:1 X:0 R:1 S:1
> >>>  0xff60000000200000 :   0xa00000 | W:0 X:0 R:1 S:1
> >>>  0xff60000000c00000 : 0x7f000000 | W:1 X:0 R:1 S:1  // badaddr: ff6000007fdb1000
> >>>  0xff6000007fdc0000 :    0x3d000 | W:1 X:0 R:1 S:1
> >>>  0xff6000007ffbf000 :     0x1000 | W:1 X:0 R:1 S:1
> >>>  0xffffffff80000000 :   0xc00000 | W:0 X:1 R:1 S:1
> >>>  0xffffffff80c00000 :   0xa00000 | W:1 X:0 R:1 S:1
> >>> 
> >>> ```
> >>> 
> >>> 3. ------
> >>> 
> >>> You can also reproduce similar panic by appending "memtest" in kernel cmdline.
> >>> I have posted the memtest boot log at this link: https://termbin.com/1twl.
> >>> 
> >>> Please correct me if I'm wrong.
> >>> 
> >>> [1]: https://lore.kernel.org/linux-riscv/CAAYs2=gQvkhTeioMmqRDVGjdtNF_vhB+vm_1dHJxPNi75YDQ_Q@mail.gmail.com/
> >>> [2]: https://lore.kernel.org/linux-riscv/20230526-astride-detonator-9ae120051159@wendy/
> >>> [3]: https://github.com/martinradev/gdb-pt-dump
> >> 
> >> Thanks for the thorough report, really appreciated.
> >> 
> >> So there are multiple issues here:
> >> 
> >> - the first one is that the memory region for opensbi is marked as not
> >> cacheable in the efi memory map, and then this region is not mapped in
> >> the linear mapping:
> >> [    0.000000] efi:   0x000080000000-0x00008003ffff [Reserved    |   |
> >> |  |  |  |  |  |  |  |   |  |  |  |UC]
> >> 
> >> - the second one (that I feel a bit ashamed of...) is that I did not
> >> check the alignment of the virtual address when choosing the map size
> >> in best_map_size() and then we end up trying to map a physical region
> >> aligned on 2MB that is actually not aligned on 2MB virtually because
> >> the opensbi region is not mapped at all.
> >> 
> >> - the possible third one is that we should not map the linear mapping
> >> using 4K pages, this would be slow in my opinion, and I think we
> >> should waste a bit of memory to align va and pa on a 2MB boundary.
> >> 
> >> So I'll fix the second issue, and possibly the third one, and if no
> >> one looks into why the opensbi region is mapped in UC, I'll take a
> >> look at edk2.
> >> 
> > Hi Alex,
> > 
> > EDK2 marks opensbi range as reserved memory in EFI map. According to DT
> > spec, if the no-map is not set, we need to mark it as
> > EfiBootServicesData but EfiBootServicesData is actually considered as
> > free memory in kernel, as per UEFI spec. To avoid kernel using this
> > memory, we deviated from the DT spec for opensbi ranges.
> 
> Violating specs is never the answer. Do one of:
> 
> 1. Use no-map and take the performance hit
> 2. Exclude the memory range from /memory itself
> 3. Come up with a new no-access property that’s a weaker no-map
>    (i.e. that allows mapping and speculative access) and uses
>    EfiRuntimeServicesData in EFI land
> 
> 2 feels most normal to me, personally, but all are fine.
> 
Hi Jess,

IMO, all the physical memory installed by the user should be visible.
Some part of the memory may be reserved and not available for the user
but excluding from /memory can cause issues.

Whether we mark as EfiReservedMemory or EfiRuntimeServiceData, I think
it will be marked as no-map in memblock and can not be used by the OS
linear mapping. Alex can confirm this.

So, my preference is option 1.

Thanks,
Sunil

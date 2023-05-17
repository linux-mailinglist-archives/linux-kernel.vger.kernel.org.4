Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6A5D706368
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 10:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjEQI60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 04:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbjEQI6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 04:58:21 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5F92D76
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 01:58:14 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3075e802738so439790f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 01:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1684313893; x=1686905893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s8ReLkTekrYtGnrHQWMv70WCHlsnz95Kfr/FaKnOJTI=;
        b=qmictuvVZlClrJQWF/nPjwPEyigcOUbquDpRmQvnbPp9KG33kXcFDTe/tdl2dCiT5G
         6hUBINH0rSqV3lUDEdLN2A45C28tgEC4ElK3fW0/d2eSbFJgtQ4YG0q6cj2IaAWyYv0Z
         tZ2DiSnss2ef7BJ0vwXprf0+32oG2K2OMfU3jlujIFPoKJkIPrr5wrOQa6nfVScFGwVW
         SLEeEedJmqFug5A4i5My89WEnMM+idvJfLd2AEU57XHoHNZAGuuAjq6VA8nqMVdViK2K
         /Qy8SWLai79WG6QBcLrbZRTG7lCngcnGHXalbaqMZcSNQ8Bi0Kj24Na8zT5Tj/KOLe5s
         HpxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684313893; x=1686905893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s8ReLkTekrYtGnrHQWMv70WCHlsnz95Kfr/FaKnOJTI=;
        b=aR1OXF2/aISxixWCYMArKx90BcyfoJbK5MeCKPOkMGzdZgPxFPP47fMkSVDnyo/60q
         pRpduC6LdqP2YX2FweE3Ngu506u5lIcoy2I+ksTT/Z3BbYzGhUC2tl1dicVlIVjxVGYM
         yR/ri+3jH8JHwlMXBqQBCJ1iyS+7fFwHjUFDC5g1zJdG2WqJdNPU3WPmbrumZ6zGwqeu
         2tdpUiwRjuTGDqajrGthA+UvASY6I/jXbvq4tNuVYd+ML1P/7ebRdQO+ESNJ9dDRVf2v
         LirmEOnxf6FwlmSDL/Z1jWAnLOjes92hownu9H1zwwLwZbLulDZBBhIXQmxb1Hz4mCcm
         2Czg==
X-Gm-Message-State: AC+VfDxz4rao8e5b2DAOElsdk8W06ftNqe8Z2yVjqpNzcysUlfdl4ZzQ
        SQxIosEvhtAiI/bO9x4swGCyUExfuiwOkwBrLBj66A==
X-Google-Smtp-Source: ACHHUZ6Q+tqHi6GOOzxFB98C1Gl+AeIJ9ie1nY+IkyRMeQFYby4tq2Uv8ZmDSpsRLUxPNbIp1RNFYVcUsmiJj5rZZlo=
X-Received: by 2002:a5d:4d4a:0:b0:2f4:e96e:3c86 with SMTP id
 a10-20020a5d4d4a000000b002f4e96e3c86mr91714wru.14.1684313892861; Wed, 17 May
 2023 01:58:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAAYs2=gQvkhTeioMmqRDVGjdtNF_vhB+vm_1dHJxPNi75YDQ_Q@mail.gmail.com>
 <CAHVXubgse4Lw7ucg52FkQW4c=QrNo56BXsRZ_nkCHAAPxUXUig@mail.gmail.com>
In-Reply-To: <CAHVXubgse4Lw7ucg52FkQW4c=QrNo56BXsRZ_nkCHAAPxUXUig@mail.gmail.com>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Wed, 17 May 2023 10:58:02 +0200
Message-ID: <CAHVXubj92O_dwGShOJgrYezqk2pA2NtFyhNFbAPyhn7=PztK6Q@mail.gmail.com>
Subject: Re: Bug report: kernel paniced when system hibernates
To:     Song Shuai <suagrfillet@gmail.com>
Cc:     robh@kernel.org, Andrew Jones <ajones@ventanamicro.com>,
        anup@brainfault.org, palmer@rivosinc.com,
        jeeheng.sia@starfivetech.com, leyfoon.tan@starfivetech.com,
        mason.huo@starfivetech.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
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

On Tue, May 16, 2023 at 1:12=E2=80=AFPM Alexandre Ghiti <alexghiti@rivosinc=
.com> wrote:
>
> Hi Song,
>
> On Tue, May 16, 2023 at 11:24=E2=80=AFAM Song Shuai <suagrfillet@gmail.co=
m> wrote:
> >
> > Description of problem:
> >
> > The latest hibernation support[1] of RISC-V Linux produced a kernel pan=
ic.
> > The entire log has been posted at this link: https://termbin.com/sphl .
> >
> > How reproducible:
> >
> > You can reproduce it with the following step :
> >
> > 1. prepare the environment with
> > - Qemu-virt v8.0.0 (with OpenSbi v1.2)
> > - Linux v6.4-rc1
> >
> > 2. start the Qemu virt
> > ```sh
> > $ cat ~/8_riscv/start_latest.sh
> > #!/bin/bash
> > /home/song/8_riscv/3_acpi/qemu/ooo/usr/local/bin/qemu-system-riscv64 \
> > -smp 2 -m 4G -nographic -machine virt \
> > -kernel /home/song/9_linux/linux/00_rv_test/arch/riscv/boot/Image \
> > -append "root=3D/dev/vda ro eaylycon=3Duart8250,mmio,0x10000000
> > early_ioremap_debug console=3DttyS0 loglevel=3D8 memblock=3Ddebug
> > no_console_suspend audit=3D0 3" \
> > -drive file=3D/home/song/8_riscv/fedora/stage4-disk.img,format=3Draw,id=
=3Dhd0 \
> > -device virtio-blk-device,drive=3Dhd0 \
> > -drive file=3D/home/song/8_riscv/fedora/adisk.qcow2,format=3Dqcow2,id=
=3Dhd1 \
> > -device virtio-blk-device,drive=3Dhd1 \
> > -gdb tcp::1236 #-S
> > ```
> > 3. execute hibernation
> >
> > ```sh
> > swapon /dev/vdb2 # this is my swap disk
> >
> > echo disk > /sys/power/state
> > ```
> >
> > 4. Then you will encounter the kernel panic logged in the above link
> >
> >
> > Other Information:
> >
> > After my initial and incomplete dig-up, the commit (3335068f8721
> > "riscv: Use PUD/P4D/PGD pages for the linear mapping")[2]
> > is closely related to this panic. This commit uses re-defined
> > `MIN_MEMBLOCK_ADDR` to discover the entire system memory
> > and extends the `va_pa_offset` from `kernel_map.phys_addr` to
> > `phys_ram_base` for linear memory mapping.
> >
> > If the firmware delivered the firmware memory region (like: a PMP
> > protected region in OpenSbi) without "no-map" propriety,
> > this commit will result in firmware memory being directly mapped by
> > `create_linear_mapping_page_table()`.
> >
> > We can see the mapping via ptdump :
> > ```c
> > ---[ Linear mapping ]---
> > 0xff60000000000000-0xff60000000200000 0x0000000080000000 2M PMD D A G
> > . . W R V ------------- the firmware memory
> > 0xff60000000200000-0xff60000000c00000 0x0000000080200000 10M PMD D A G =
. . . R V
> > 0xff60000000c00000-0xff60000001000000 0x0000000080c00000 4M PMD D A G .=
 . W R V
> > 0xff60000001000000-0xff60000001600000 0x0000000081000000 6M PMD D A G .=
 . . R V
> > 0xff60000001600000-0xff60000040000000 0x0000000081600000 1002M PMD D A
> > G . . W R V
> > 0xff60000040000000-0xff60000100000000 0x00000000c0000000 3G PUD D A G .=
 . W R V
> > ---[ Modules/BPF mapping ]---
> > ---[ Kernel mapping ]---
> > 0xffffffff80000000-0xffffffff80a00000 0x0000000080200000 10M PMD D A G =
. X . R V
> > 0xffffffff80a00000-0xffffffff80c00000 0x0000000080c00000 2M PMD D A G .=
 . . R V
> > 0xffffffff80c00000-0xffffffff80e00000 0x0000000080e00000 2M PMD D A G .=
 . W R V
> > 0xffffffff80e00000-0xffffffff81400000 0x0000000081000000 6M PMD D A G .=
 . . R V
> > 0xffffffff81400000-0xffffffff81800000 0x0000000081600000 4M PMD
> > ```
> >
> > In the hibernation process, `swsusp_save()` calls
> > `copy_data_pages(&copy_bm, &orig_bm)` to copy these two memory
> > bitmaps,
> > the Oops(load access fault) occurred while copying the page of
> > PAGE_OFFSET (which maps the firmware memory).
>
> I'm not saying that the hibernation process is in fault here, but
> that's weird that it is trying to access pages that are not available
> to the kernel: this region is mapped in the page table so that we can
> use a 1GB page, but it is reserved so that it is not added to the
> kernel memory pool.
>
> >
> > I also did two other tests:
> > Test1:
> >
> > The hibernation works well in the kernel with the commit 3335068f8721
> > reverted at least in the current environment.
> >
> > Test2:
> >
> > I built a simple kernel module to simulate the access of the value of
> > `PAGE_OFFSET` address, and the same panic occurred with the load
> > access fault.
> > So hibernation seems not the only case to trigger this panic.
> >
> > Finally, should we always leave the firmware memory with
> > `MEMBLOCK_NOMAP` flag by some efforts from Linux or OpenSbi (at least
> > in the current environment) or any other suggestions?
> >
>
> I actually removed this flag a few years ago, and I have to admit that
> I need to check if that's necessary: the goal of commit 3335068f8721
> ("riscv: Use PUD/P4D/PGD pages for the linear mapping") is to expose
> the "right" start of DRAM so that we can align virtual and physical
> addresses on a 1GB boundary.
>
> So I have to check if a nomap region is actually added as a
> memblock.memory.regions[] or not: if yes, that's perfect, let's add
> the nomap attributes to the PMP regions, otherwise, I don't think that
> is a good solution.

So here is the current linear mapping without nomap in openSBI:

---[ Linear mapping ]---
0xff60000000000000-0xff60000000200000    0x0000000080000000         2M
PMD     D A G . . W R V
0xff60000000200000-0xff60000000e00000    0x0000000080200000        12M
PMD     D A G . . . R V

And below the linear mapping with nomap in openSBI:

---[ Linear mapping ]---
0xff60000000080000-0xff60000000200000    0x0000000080080000      1536K
PTE     D A G . . W R V
0xff60000000200000-0xff60000000e00000    0x0000000080200000        12M
PMD     D A G . . . R V

So adding nomap does not misalign virtual and physical addresses, it
prevents the usage of 1GB page for this area though, so that's a
solution, we just lose this 1GB page here.

But even though that may be the fix, I think we also need to fix that
in the kernel as it would break compatibility with certain versions of
openSBI *if* we fix openSBI...So here are a few solutions:

1. we can mark all "mmode_resv" nodes in the device tree as nomap,
before the linear mapping is established (IIUC, those nodes are added
by openSBI to advertise PMP regions)
    -> This amounts to the same fix as opensbi and we lose the 1GB hugepage=
.
2. we can tweak pfn_is_nosave function to *not* save pfn corresponding
to PMP regions
    -> We don't lose the 1GB hugepage \o/
3. we can use register_nosave_region() to not save the "mmode_resv"
regions (x86 does that
https://elixir.bootlin.com/linux/v6.4-rc1/source/arch/x86/kernel/e820.c#L75=
3)
    -> We don't lose the 1GB hugepage \o/
4. Given JeeHeng pointer to
https://elixir.bootlin.com/linux/v6.4-rc1/source/kernel/power/snapshot.c#L1=
340,
we can mark those pages as non-readable and make the hibernation
process not save those pages
    -> Very late-in-the-day idea, not sure what it's worth, we also
lose the 1GB hugepage...

To me, the best solution is 3 as it would prepare for other similar
issues later, it is similar to x86 and it allows us to keep 1GB
hugepages.

I have been thinking, and to me nomap does not provide anything since
the kernel should not address this memory range, so if it does, we
must fix the kernel.

Let me know what you all think, I'll be preparing a PoC of 3 in the meantim=
e!

Alex



>
> And a last word: Mike Rapoport recently gave a speech [1] where he
> states that mapping the linear mapping with hugepages does not give
> rise to better performance so *maybe* reverting this commit may be a
> solution too as it may not provide the expected benefits (even though
> I'd rather have it and another benefit of mapping the linear mapping
> with 1GB hugepages is that it is faster to boot, but that needs to be
> measured).
>
> [1] https://lwn.net/Articles/931406/
>
> > Please correct me if I'm wrong.
> >
> > [1]: https://lore.kernel.org/r/20230330064321.1008373-5-jeeheng.sia@sta=
rfivetech.com
> > [2]: https://lore.kernel.org/r/20230324155421.271544-4-alexghiti@rivosi=
nc.com
> >
> > --
> > Thanks,
> > Song
>
> Thanks for the thorough report!
>
> Alex

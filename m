Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33BDD706B6E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 16:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbjEQOml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 10:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbjEQOmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 10:42:39 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0134E8695
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 07:42:15 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f41dceb9d4so8628015e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 07:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1684334534; x=1686926534;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=av/f8JU4Lp2kfcTkI5Wcmpk+6Y7joBiI0Xa5jkxwYnc=;
        b=EurCyT3cXQfLFdGQhwk50Br+Vy2sa4n9VXsOSHo4DRhNIn335tTtxjIEEjG463lgGi
         K2s8K+7jhcJ0AS0Q+Hy5RrVD+/L2mW2txIBaVoxoOx03bF0duPALFXZzhFdmoKkhIoX/
         Qzd84FdzLrnVXJ8ae0gvP60bRU9WIIyJyfvtrXdzkGagUlSFTTnIz4LqydM4hGFW/5rw
         nvFrxLAZObXL5suuIBj7NsaC2QpvmI3NYaDzgsWo5F+AM8eG/okxZrGB+vsFXy7gIYPN
         JPbwh1T8g6/uDd+aYfvHlHX+eXteKSrTUf16BoXVfPcjkAP9m8OOb/QJjuWhVM6j3s26
         8S1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684334534; x=1686926534;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=av/f8JU4Lp2kfcTkI5Wcmpk+6Y7joBiI0Xa5jkxwYnc=;
        b=WtkpPJcyldQM/NPZw4fYg5iKkrmeHzLzUR6iYiBSLVdFMnsYF6Qaa+peucb2/RvHzx
         bO6V/IjV3d+GmcWccWeG7pE1h4FNIQ6KolNhZ4YAvs+5wiecjfsQ5+mEn+uOwaXzS4pT
         iX1MUB8CgUjio9aiCl9Wqy/guRfwPDlT8mwYkJ4mEtPsCSzU2s3KsLdkEaKDj1Zx//25
         cncapEsSiDJYs4NEojp2RsRG79ohdidNb0BbXFBE0bKZnOm1DwRSpcRBqegB6yqL5MRP
         76u67Sn/4d8PdH7B+icWPK4qkgxsRssW2mZSPQdVDASfrPHuU5k6YFBjW89j9tZ3MJo+
         2d2Q==
X-Gm-Message-State: AC+VfDzGvuYlrT9BjijGYunjwj6Cu2X95awttN0EI5CUMR5kXuRyNBkV
        aTyBEX23DaTZGz6fbVcHBCocLaZwSYqY65GtT9eexA==
X-Google-Smtp-Source: ACHHUZ7QyCbdqtcu40T9bXjgrNbrxinmOmIvy49O21RKWFNz3RrYcWFpSWec5SxTUBS/FCs4qz9TXXloJaHd5fgITOo=
X-Received: by 2002:a5d:4d4a:0:b0:2f4:e96e:3c86 with SMTP id
 a10-20020a5d4d4a000000b002f4e96e3c86mr863118wru.14.1684334534413; Wed, 17 May
 2023 07:42:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAAYs2=gQvkhTeioMmqRDVGjdtNF_vhB+vm_1dHJxPNi75YDQ_Q@mail.gmail.com>
 <CAHVXubgse4Lw7ucg52FkQW4c=QrNo56BXsRZ_nkCHAAPxUXUig@mail.gmail.com>
 <CAHVXubj92O_dwGShOJgrYezqk2pA2NtFyhNFbAPyhn7=PztK6Q@mail.gmail.com>
 <CAAYs2=gtfhVYUsXkSiCZdzF+Cr573AecWyBn6u_D1C4N4THNVw@mail.gmail.com> <CAHVXubgjgMvFV0MOABbtKr+2TH85+0kow7wOrjxFCP5iXt1saQ@mail.gmail.com>
In-Reply-To: <CAHVXubgjgMvFV0MOABbtKr+2TH85+0kow7wOrjxFCP5iXt1saQ@mail.gmail.com>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Wed, 17 May 2023 16:42:03 +0200
Message-ID: <CAHVXubiD3Vg71LDK43-KS7U47Cd5UAwyzv4WUdOd5Vo4P9C18Q@mail.gmail.com>
Subject: Fwd: Bug report: kernel paniced when system hibernates
To:     Song Shuai <suagrfillet@gmail.com>, Rob Herring <robh@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Sia Jee Heng <jeeheng.sia@starfivetech.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Mason Huo <mason.huo@starfivetech.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Guo Ren <guoren@kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>
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

Sorry, pressed "reply" instead of "reply all"...

---------- Forwarded message ---------
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Wed, May 17, 2023 at 4:40=E2=80=AFPM
Subject: Re: Bug report: kernel paniced when system hibernates
To: Song Shuai <suagrfillet@gmail.com>, Anup Patel
<anup@brainfault.org>, Atish Kumar Patra <atishp@rivosinc.com>


On Wed, May 17, 2023 at 1:05=E2=80=AFPM Song Shuai <suagrfillet@gmail.com> =
wrote:
>
> Alexandre Ghiti <alexghiti@rivosinc.com> =E4=BA=8E2023=E5=B9=B45=E6=9C=88=
17=E6=97=A5=E5=91=A8=E4=B8=89 08:58=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Tue, May 16, 2023 at 1:12=E2=80=AFPM Alexandre Ghiti <alexghiti@rivo=
sinc.com> wrote:
> > >
> > > Hi Song,
> > >
> > > On Tue, May 16, 2023 at 11:24=E2=80=AFAM Song Shuai <suagrfillet@gmai=
l.com> wrote:
> > > >
> > > > Description of problem:
> > > >
> > > > The latest hibernation support[1] of RISC-V Linux produced a kernel=
 panic.
> > > > The entire log has been posted at this link: https://termbin.com/sp=
hl .
> > > >
> > > > How reproducible:
> > > >
> > > > You can reproduce it with the following step :
> > > >
> > > > 1. prepare the environment with
> > > > - Qemu-virt v8.0.0 (with OpenSbi v1.2)
> > > > - Linux v6.4-rc1
> > > >
> > > > 2. start the Qemu virt
> > > > ```sh
> > > > $ cat ~/8_riscv/start_latest.sh
> > > > #!/bin/bash
> > > > /home/song/8_riscv/3_acpi/qemu/ooo/usr/local/bin/qemu-system-riscv6=
4 \
> > > > -smp 2 -m 4G -nographic -machine virt \
> > > > -kernel /home/song/9_linux/linux/00_rv_test/arch/riscv/boot/Image \
> > > > -append "root=3D/dev/vda ro eaylycon=3Duart8250,mmio,0x10000000
> > > > early_ioremap_debug console=3DttyS0 loglevel=3D8 memblock=3Ddebug
> > > > no_console_suspend audit=3D0 3" \
> > > > -drive file=3D/home/song/8_riscv/fedora/stage4-disk.img,format=3Dra=
w,id=3Dhd0 \
> > > > -device virtio-blk-device,drive=3Dhd0 \
> > > > -drive file=3D/home/song/8_riscv/fedora/adisk.qcow2,format=3Dqcow2,=
id=3Dhd1 \
> > > > -device virtio-blk-device,drive=3Dhd1 \
> > > > -gdb tcp::1236 #-S
> > > > ```
> > > > 3. execute hibernation
> > > >
> > > > ```sh
> > > > swapon /dev/vdb2 # this is my swap disk
> > > >
> > > > echo disk > /sys/power/state
> > > > ```
> > > >
> > > > 4. Then you will encounter the kernel panic logged in the above lin=
k
> > > >
> > > >
> > > > Other Information:
> > > >
> > > > After my initial and incomplete dig-up, the commit (3335068f8721
> > > > "riscv: Use PUD/P4D/PGD pages for the linear mapping")[2]
> > > > is closely related to this panic. This commit uses re-defined
> > > > `MIN_MEMBLOCK_ADDR` to discover the entire system memory
> > > > and extends the `va_pa_offset` from `kernel_map.phys_addr` to
> > > > `phys_ram_base` for linear memory mapping.
> > > >
> > > > If the firmware delivered the firmware memory region (like: a PMP
> > > > protected region in OpenSbi) without "no-map" propriety,
> > > > this commit will result in firmware memory being directly mapped by
> > > > `create_linear_mapping_page_table()`.
> > > >
> > > > We can see the mapping via ptdump :
> > > > ```c
> > > > ---[ Linear mapping ]---
> > > > 0xff60000000000000-0xff60000000200000 0x0000000080000000 2M PMD D A=
 G
> > > > . . W R V ------------- the firmware memory
> > > > 0xff60000000200000-0xff60000000c00000 0x0000000080200000 10M PMD D =
A G . . . R V
> > > > 0xff60000000c00000-0xff60000001000000 0x0000000080c00000 4M PMD D A=
 G . . W R V
> > > > 0xff60000001000000-0xff60000001600000 0x0000000081000000 6M PMD D A=
 G . . . R V
> > > > 0xff60000001600000-0xff60000040000000 0x0000000081600000 1002M PMD =
D A
> > > > G . . W R V
> > > > 0xff60000040000000-0xff60000100000000 0x00000000c0000000 3G PUD D A=
 G . . W R V
> > > > ---[ Modules/BPF mapping ]---
> > > > ---[ Kernel mapping ]---
> > > > 0xffffffff80000000-0xffffffff80a00000 0x0000000080200000 10M PMD D =
A G . X . R V
> > > > 0xffffffff80a00000-0xffffffff80c00000 0x0000000080c00000 2M PMD D A=
 G . . . R V
> > > > 0xffffffff80c00000-0xffffffff80e00000 0x0000000080e00000 2M PMD D A=
 G . . W R V
> > > > 0xffffffff80e00000-0xffffffff81400000 0x0000000081000000 6M PMD D A=
 G . . . R V
> > > > 0xffffffff81400000-0xffffffff81800000 0x0000000081600000 4M PMD
> > > > ```
> > > >
> > > > In the hibernation process, `swsusp_save()` calls
> > > > `copy_data_pages(&copy_bm, &orig_bm)` to copy these two memory
> > > > bitmaps,
> > > > the Oops(load access fault) occurred while copying the page of
> > > > PAGE_OFFSET (which maps the firmware memory).
> > >
> > > I'm not saying that the hibernation process is in fault here, but
> > > that's weird that it is trying to access pages that are not available
> > > to the kernel: this region is mapped in the page table so that we can
> > > use a 1GB page, but it is reserved so that it is not added to the
> > > kernel memory pool.
> Yes, my fault, the Test2 is not a correct testcase.
> > >
> > > >
> > > > I also did two other tests:
> > > > Test1:
> > > >
> > > > The hibernation works well in the kernel with the commit 3335068f87=
21
> > > > reverted at least in the current environment.
> > > >
> > > > Test2:
> > > >
> > > > I built a simple kernel module to simulate the access of the value =
of
> > > > `PAGE_OFFSET` address, and the same panic occurred with the load
> > > > access fault.
> > > > So hibernation seems not the only case to trigger this panic.
> > > >
> > > > Finally, should we always leave the firmware memory with
> > > > `MEMBLOCK_NOMAP` flag by some efforts from Linux or OpenSbi (at lea=
st
> > > > in the current environment) or any other suggestions?
> > > >
> > >
> > > I actually removed this flag a few years ago, and I have to admit tha=
t
> > > I need to check if that's necessary: the goal of commit 3335068f8721
> > > ("riscv: Use PUD/P4D/PGD pages for the linear mapping") is to expose
> > > the "right" start of DRAM so that we can align virtual and physical
> > > addresses on a 1GB boundary.
> > >
> > > So I have to check if a nomap region is actually added as a
> > > memblock.memory.regions[] or not: if yes, that's perfect, let's add
> > > the nomap attributes to the PMP regions, otherwise, I don't think tha=
t
> > > is a good solution.
> >
> > So here is the current linear mapping without nomap in openSBI:
> >
> > ---[ Linear mapping ]---
> > 0xff60000000000000-0xff60000000200000    0x0000000080000000         2M
> > PMD     D A G . . W R V
> > 0xff60000000200000-0xff60000000e00000    0x0000000080200000        12M
> > PMD     D A G . . . R V
> >
> > And below the linear mapping with nomap in openSBI:
> >
> > ---[ Linear mapping ]---
> > 0xff60000000080000-0xff60000000200000    0x0000000080080000      1536K
> > PTE     D A G . . W R V
> > 0xff60000000200000-0xff60000000e00000    0x0000000080200000        12M
> > PMD     D A G . . . R V
> >
> > So adding nomap does not misalign virtual and physical addresses, it
> > prevents the usage of 1GB page for this area though, so that's a
> > solution, we just lose this 1GB page here.
> >
> > But even though that may be the fix, I think we also need to fix that
> > in the kernel as it would break compatibility with certain versions of
> > openSBI *if* we fix openSBI...So here are a few solutions:
> >
> > 1. we can mark all "mmode_resv" nodes in the device tree as nomap,
> > before the linear mapping is established (IIUC, those nodes are added
> > by openSBI to advertise PMP regions)
> >     -> This amounts to the same fix as opensbi and we lose the 1GB huge=
page.
> > 2. we can tweak pfn_is_nosave function to *not* save pfn corresponding
> > to PMP regions
> >     -> We don't lose the 1GB hugepage \o/
> > 3. we can use register_nosave_region() to not save the "mmode_resv"
> > regions (x86 does that
> > https://elixir.bootlin.com/linux/v6.4-rc1/source/arch/x86/kernel/e820.c=
#L753)
> >     -> We don't lose the 1GB hugepage \o/
> > 4. Given JeeHeng pointer to
> > https://elixir.bootlin.com/linux/v6.4-rc1/source/kernel/power/snapshot.=
c#L1340,
> > we can mark those pages as non-readable and make the hibernation
> > process not save those pages
> >     -> Very late-in-the-day idea, not sure what it's worth, we also
> > lose the 1GB hugepage...
> >
> > To me, the best solution is 3 as it would prepare for other similar
> > issues later, it is similar to x86 and it allows us to keep 1GB
> > hugepages.
>
> I agree,
> register_nosave_region() is a good way in the early initialization to
> set page frames (like the PMP regions) in forbidden_pages_map and mark
> them as no-savable for hibernation.
>
> Look forward to your fixing.

Please find below the patch in question, which worked for me, if you
can give it a try. As mentioned by Conor, I'd like to make sure the
mmode_resv "interface" is really what we need to use before
upstreaming this fix @Anup Patel @Atish Kumar Patra

diff --git a/arch/riscv/kernel/hibernate.c b/arch/riscv/kernel/hibernate.c
index 264b2dcdd67e..9ad8bf5c956b 100644
--- a/arch/riscv/kernel/hibernate.c
+++ b/arch/riscv/kernel/hibernate.c
@@ -24,6 +24,8 @@
 #include <linux/sched.h>
 #include <linux/suspend.h>
 #include <linux/utsname.h>
+#include <linux/of_fdt.h>
+#include <linux/libfdt.h>

 /* The logical cpu number we should resume on, initialised to a
non-cpu number. */
 static int sleep_cpu =3D -EINVAL;
@@ -67,6 +69,45 @@ static void arch_hdr_invariants(struct
arch_hibernate_hdr_invariants *i)
        memcpy(i->uts_version, init_utsname()->version, sizeof(i->uts_versi=
on));
 }

+void __init register_nosave_regions(void)
+{
+#define MMODE_RESV     "mmode_resv"
+       int node, child;
+       const void *fdt =3D initial_boot_params;
+
+       node =3D fdt_path_offset(fdt, "/reserved-memory");
+       if (node < 0)
+               return;
+
+       fdt_for_each_subnode(child, fdt, node) {
+               phys_addr_t base, size;
+               const __be32 *prop;
+               const char *uname;
+               int len;
+               int t_len =3D (dt_root_addr_cells + dt_root_size_cells)
* sizeof(__be32);
+
+               uname =3D fdt_get_name(fdt, child, NULL);
+
+               if (!uname || strncmp(uname, MMODE_RESV,
sizeof(MMODE_RESV) - 1))
+                       continue;
+
+               prop =3D of_get_flat_dt_prop(child, "reg", &len);
+               if (!prop)
+                       continue;
+
+               while (len >=3D t_len) {
+                       base =3D dt_mem_next_cell(dt_root_addr_cells, &prop=
);
+                       size =3D dt_mem_next_cell(dt_root_size_cells, &prop=
);
+
+                       if (size)
+                               register_nosave_region(phys_to_pfn(base),
+
phys_to_pfn(base + size));
+
+                       len -=3D t_len;
+               }
+       }
+}
+
 /*
  * Check if the given pfn is in the 'nosave' section.
  */
@@ -421,6 +462,8 @@ static int __init riscv_hibernate_init(void)
        if (WARN_ON(!hibernate_cpu_context))
                return -ENOMEM;

+       register_nosave_regions();
+
        return 0;
 }

> >
> > I have been thinking, and to me nomap does not provide anything since
> > the kernel should not address this memory range, so if it does, we
> > must fix the kernel.
> >
> > Let me know what you all think, I'll be preparing a PoC of 3 in the mea=
ntime!
> >
> > Alex
> >
> >
> >
> > >
> > > And a last word: Mike Rapoport recently gave a speech [1] where he
> > > states that mapping the linear mapping with hugepages does not give
> > > rise to better performance so *maybe* reverting this commit may be a
> > > solution too as it may not provide the expected benefits (even though
> > > I'd rather have it and another benefit of mapping the linear mapping
> > > with 1GB hugepages is that it is faster to boot, but that needs to be
> > > measured).
> > >
> > > [1] https://lwn.net/Articles/931406/
> > >
> > > > Please correct me if I'm wrong.
> > > >
> > > > [1]: https://lore.kernel.org/r/20230330064321.1008373-5-jeeheng.sia=
@starfivetech.com
> > > > [2]: https://lore.kernel.org/r/20230324155421.271544-4-alexghiti@ri=
vosinc.com
> > > >
> > > > --
> > > > Thanks,
> > > > Song
> > >
> > > Thanks for the thorough report!
> > >
> > > Alex
>
>
>
> --
> Thanks,
> Song

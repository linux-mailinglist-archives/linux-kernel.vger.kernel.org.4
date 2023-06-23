Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 713B773B374
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 11:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbjFWJYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 05:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbjFWJYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 05:24:34 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF901FFD
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 02:24:31 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-988aefaa44eso46883266b.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 02:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1687512270; x=1690104270;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=I/79PxINtD0wV3qp6JPg1zdLUAhMiA4hYTLnel+qvzo=;
        b=HDSkV6AFN6VgtymEGXR3oh9xtCkJi+1qRjpGrlleMLiKSIfzRh5M3R11ZAK+1INdDP
         x3MZS+KrMO1t6db0/CZIzcMuc+7w7KLR6K/Mipok/9fZeKCZELLmr6KaGo3MSiZh0b8i
         e9dAV0fmk99AOaOTXJ/06w+UVCRWDE/l/Hy1j8tz0ELgHPgT3WLi2LjP8BfDVAESFD8p
         cvKXtyM2A742Cqa1lQ7/Cnqk/F1Au7aEVOQe6ALXNKSaQ/OIHBisnsxdGGW5RMgmCLX7
         zrrMyS0xaazFile/bTDhLsrqcuttw3lzwU0nr7mGzYjNDWgkpb48VPVZO323I9YB9Y+x
         87GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687512270; x=1690104270;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I/79PxINtD0wV3qp6JPg1zdLUAhMiA4hYTLnel+qvzo=;
        b=knrWpOypbtUo82yfCkPlkxsqm70CzsiyqEAZJH0UqOeAa3Qrt+hyQ+jm5wMtoiPrP6
         0m7UPFV5Dxis0hB5+ONCqWYuCsCi/N7NXU6OCrIMA1sAhWb9bR8UY9CBOFTSH3hMcG12
         YFhAfsLx0lYPcW/W1YfBV12uwIsmlUTWDJKt2OtW1SUa1Klz3YybsgMq1Xnoj9CVEQSe
         oE8/QKGcq4ln8pow6aRsHFQwGnshLDbn2AOrknEAaBMWS84hIPQKCHTxvOtJUM4qcmdh
         VeBC4ZLIJQY5yUhdnJme3eTTvlydXyau/pMqM5yDQVPv4Q0QghinzmbwslL1K+O42xIB
         Le/w==
X-Gm-Message-State: AC+VfDz3WlQC4HXxbzLufUcoZ2iyWUdcu3f86KROtYEmFE7YO3oebhMJ
        ifSCwPlWc4wYQ/kMWLco1b4MmA==
X-Google-Smtp-Source: ACHHUZ6LikdDrqUXcXdWSZ/wu38LvuAxOYWRtRJtE65+sUtqXESKaebswi54N8F6fJx1b+g0ukdLEg==
X-Received: by 2002:a17:907:16a6:b0:978:66bd:d771 with SMTP id hc38-20020a17090716a600b0097866bdd771mr21574125ejc.55.1687512269728;
        Fri, 23 Jun 2023 02:24:29 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id w20-20020a056402071400b0051a5ea200d4sm4944437edx.65.2023.06.23.02.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 02:24:29 -0700 (PDT)
Date:   Fri, 23 Jun 2023 11:24:28 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Song Shuai <songshuaishuai@tinylab.org>,
        linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 2/3] Documentation: riscv: Add early boot document
Message-ID: <20230623-1020c71aa0496e2ced2cb3ed@orel>
References: <20230621072234.9900-1-alexghiti@rivosinc.com>
 <20230621072234.9900-2-alexghiti@rivosinc.com>
 <20230621-d6da578719f8af903d6746ef@orel>
 <02ee9366-436a-4be6-5a79-05874f999b88@ghiti.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <02ee9366-436a-4be6-5a79-05874f999b88@ghiti.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 10:48:55AM +0200, Alexandre Ghiti wrote:
> 
> On 21/06/2023 14:19, Andrew Jones wrote:
> > On Wed, Jun 21, 2023 at 09:22:33AM +0200, Alexandre Ghiti wrote:
> > > This document describes the constraints and requirements of the early
> > > boot process in a RISC-V kernel.
> > > 
> > > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > > Reviewed-by: Björn Töpel <bjorn@rivosinc.com>
> > > ---
> > >   Documentation/riscv/boot-image-header.rst |   3 -
> > >   Documentation/riscv/boot.rst              | 170 ++++++++++++++++++++++
> > >   Documentation/riscv/index.rst             |   1 +
> > >   3 files changed, 171 insertions(+), 3 deletions(-)
> > >   create mode 100644 Documentation/riscv/boot.rst
> > > 
> > > diff --git a/Documentation/riscv/boot-image-header.rst b/Documentation/riscv/boot-image-header.rst
> > > index d7752533865f..a4a45310c4c4 100644
> > > --- a/Documentation/riscv/boot-image-header.rst
> > > +++ b/Documentation/riscv/boot-image-header.rst
> > > @@ -7,9 +7,6 @@ Boot image header in RISC-V Linux
> > >   This document only describes the boot image header details for RISC-V Linux.
> > > -TODO:
> > > -  Write a complete booting guide.
> > > -
> > >   The following 64-byte header is present in decompressed Linux kernel image::
> > >   	u32 code0;		  /* Executable code */
> > > diff --git a/Documentation/riscv/boot.rst b/Documentation/riscv/boot.rst
> > > new file mode 100644
> > > index 000000000000..019ee818686d
> > > --- /dev/null
> > > +++ b/Documentation/riscv/boot.rst
> > > @@ -0,0 +1,170 @@
> > > +.. SPDX-License-Identifier: GPL-2.0
> > > +
> > > +===============================================
> > > +RISC-V Kernel Boot Requirements and Constraints
> > > +===============================================
> > > +
> > > +:Author: Alexandre Ghiti <alexghiti@rivosinc.com>
> > > +:Date: 23 May 2023
> > > +
> > > +This document describes what the RISC-V kernel expects from bootloaders and
> > > +firmware, but also the constraints that any developer must have in mind when
> > > +touching the early boot process. For the purposes of this document, the
> > > +'early boot process' refers to any code that runs before the final virtual
> > > +mapping is set up.
> > > +
> > > +Pre-kernel Requirements and Constraints
> > > +=======================================
> > > +
> > > +The RISC-V kernel expects the following of bootloaders and platform firmware:
> > > +
> > > +Register state
> > > +--------------
> > > +
> > > +The RISC-V kernel expects:
> > > +
> > > +  * `$a0` to contain the hartid of the current core.
> > > +  * `$a1` to contain the address of the devicetree in memory.
> > > +
> > > +CSR state
> > > +---------
> > > +
> > > +The RISC-V kernel expects:
> > > +
> > > +  * `$satp = 0`: the MMU, if present, must be disabled.
> > > +
> > > +Reserved memory for resident firmware
> > > +-------------------------------------
> > > +
> > > +The RISC-V kernel must not map any resident memory, or memory protected with
> > > +PMPs, in the direct mapping, so the firmware must correctly mark those regions
> > > +as per the devicetree specification and/or the UEFI specification.
> > > +
> > > +Kernel location
> > > +---------------
> > > +
> > > +The RISC-V kernel expects to be placed at a PMD boundary (2MB aligned for rv64
> > > +and 4MB aligned for rv32). Note that the EFI stub will physically relocate the
> > > +kernel if that's not the case.
> > > +
> > > +Hardware description
> > > +--------------------
> > > +
> > > +The firmware can pass either a devicetree or ACPI tables to the RISC-V kernel.
> > > +
> > > +The devicetree is either passed directly to the kernel from the previous stage
> > > +using the `$a1` register, or when booting with UEFI, it can be passed using the
> > > +EFI configuration table.
> > > +
> > > +The ACPI tables are passed to the kernel using the EFI configuration table. In
> > > +this case, a tiny devicetree is still created by the EFI stub. Please refer to
> > > +"EFI stub and devicetree" tree section below for details about this devicetree.
> >                               ^ redundant 'tree' here
> > 
> > > +
> > > +Kernel entrance
> > > +---------------
> > > +
> > > +On SMP systems, there are 2 methods to enter the kernel:
> > > +
> > > +- `RISCV_BOOT_SPINWAIT`: the firmware releases all harts in the kernel, one hart
> > > +  wins a lottery and executes the early boot code while the other harts are
> > > +  parked waiting for the initialization to finish. This method is mostly used to
> > > +  support older firmwares without SBI HSM extension and M-mode RISC-V kernel.
> > > +- `Ordered booting`: the firmware releases only one hart that will execute the
> > > +  initialization phase and then will start all other harts using the SBI HSM
> > > +  extension. The ordered booting method is the preferred booting method for
> > > +  booting the RISC-V kernel because it can support cpu hotplug and kexec.
> > > +
> > > +UEFI
> > > +----
> > > +
> > > +UEFI memory map
> > > +~~~~~~~~~~~~~~~
> > > +
> > > +When booting with UEFI, the RISC-V kernel will use only the EFI memory map to
> > > +populate the system memory.
> > > +
> > > +The UEFI firmware must parse the subnodes of the `/reserved-memory` devicetree
> > > +node and abide by the devicetree specification to convert the attributes of
> > > +those subnodes (`no-map` and `reusable`) into their correct EFI equivalent
> > > +(refer to section "3.5.4 /reserved-memory and UEFI" of the devicetree
> > > +specification v0.4-rc1).
> > > +
> > > +RISCV_EFI_BOOT_PROTOCOL
> > > +~~~~~~~~~~~~~~~~~~~~~~~
> > > +
> > > +When booting with UEFI, the EFI stub requires the boot hartid in order to pass
> > > +it to the RISC-V kernel in `$a1`. The EFI stub retrieves the boot hartid using
> > > +one of the following methods:
> > > +
> > > +- `RISCV_EFI_BOOT_PROTOCOL` (**preferred**).
> > > +- `boot-hartid` devicetree subnode (**deprecated**).
> > > +
> > > +Any new firmware must implement `RISCV_EFI_BOOT_PROTOCOL` as the devicetree
> > > +based approach is deprecated now.
> > > +
> > > +Early Boot Requirements and Constraints
> > > +=======================================
> > > +
> > > +The RISC-V kernel's early boot process operates under the following constraints:
> > > +
> > > +EFI stub and devicetree
> > > +-----------------------
> > > +
> > > +When booting with UEFI, the devicetree is supplemented (or created) by the EFI
> > > +stub with the same parameters as arm64 which are described at the paragraph
> > > +"UEFI kernel support on ARM" in Documentation/arm/uefi.rst.
> > > +
> > > +Virtual mapping installation
> > > +----------------------------
> > > +
> > > +The installation of the virtual mapping is done in 2 steps in the RISC-V kernel:
> > > +
> > > +1. :c:func:`setup_vm` installs a temporary kernel mapping in
> > > +   :c:var:`early_pg_dir` which allows discovery of the system memory. Only the
> > > +   kernel text/data are mapped at this point. When establishing this mapping, no
> > > +   allocation can be done (since the system memory is not known yet), so
> > > +   :c:var:`early_pg_dir` page table is statically allocated (using only one
> > > +   table for each level).
> > > +
> > > +2. :c:func:`setup_vm_final` creates the final kernel mapping in
> > > +   :c:var:`swapper_pg_dir` and takes advantage of the discovered system memory
> > > +   to create the linear mapping. When establishing this mapping, the kernel
> > > +   can allocate memory but cannot access it directly (since the direct mapping
> > > +   is not present yet), so it uses temporary mappings in the fixmap region to
> > > +   be able to access the newly allocated page table levels.
> > > +
> > > +For :c:func:`virt_to_phys` and :c:func:`phys_to_virt` to be able to correctly
> > > +convert direct mapping addresses to physical addresses, they need to know the
> > > +start of the DRAM. This happens after step 1, right before step 2 installs the
> > > +direct mapping (see :c:func:`setup_bootmem` function in arch/riscv/mm/init.c).
> > > +Any usage of those macros before the final virtual mapping is installed must
> > > +be carefully examined.
> > > +
> > > +Device-tree mapping via fixmap
> > > +------------------------------
> > > +
> > > +The RISC-V kernel uses the fixmap region to map the devicetree because the
> > > +devicetree virtual mapping must remain the same between :c:func:`setup_vm` and
> > > +:c:func:`setup_vm_final` calls since the :c:var:`reserved_mem` array is
> > > +initialized with virtual addresses established by :c:func:`setup_vm` and used
> > > +with the mapping established by :c:func:`setup_vm_final`.
> > > +
> > > +Pre-MMU execution
> > > +-----------------
> > > +
> > > +A few pieces of code need to run before even the first virtual mapping is
> > > +established. These are the installation of the first virtual mapping itself,
> > > +patching of early alternatives and the early parsing of the kernel command line.
> > > +That code must be very carefully compiled as:
> > > +
> > > +- `-fno-pie`: This is needed for relocatable kernels which use `-fPIE`, since
> > > +  otherwise, any access to a global symbol would go through the GOT which is
> > > +  only relocated virtually.
> > > +- `-mcmodel=medany`: Any access to a global symbol must be PC-relative to avoid
> > > +  any relocations to happen before the MMU is setup.
> > > +- *all* instrumentation must also be disabled (that includes KASAN, ftrace and
> > > +  others).
> > > +
> > > +As using a symbol from a different compilation unit requires this unit to be
> > > +compiled with those flags, we advise, as much as possible, not to use external
> > > +symbols.
> > > diff --git a/Documentation/riscv/index.rst b/Documentation/riscv/index.rst
> > > index 175a91db0200..1f66062def6d 100644
> > > --- a/Documentation/riscv/index.rst
> > > +++ b/Documentation/riscv/index.rst
> > > @@ -5,6 +5,7 @@ RISC-V architecture
> > >   .. toctree::
> > >       :maxdepth: 1
> > > +    boot
> > >       boot-image-header
> > >       vm-layout
> > >       hwprobe
> > > -- 
> > > 2.39.2
> > > 
> > Otherwise looks good to me.
> 
> 
> I assume I can add your RB here, don't waste time answering if I'm right :)

Yup, when I read it the first time I wasn't sure I was familiar enough
with everything to give it an r-b, but I just read it again and grepped
a few things that I wasn't already familiar with, so

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks,
drew

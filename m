Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CDD073B2E2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 10:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbjFWItF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 04:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjFWItE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 04:49:04 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 701581706;
        Fri, 23 Jun 2023 01:49:01 -0700 (PDT)
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 107A2E0005;
        Fri, 23 Jun 2023 08:48:55 +0000 (UTC)
Message-ID: <02ee9366-436a-4be6-5a79-05874f999b88@ghiti.fr>
Date:   Fri, 23 Jun 2023 10:48:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 2/3] Documentation: riscv: Add early boot document
Content-Language: en-US
To:     Andrew Jones <ajones@ventanamicro.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Song Shuai <songshuaishuai@tinylab.org>,
        linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org
References: <20230621072234.9900-1-alexghiti@rivosinc.com>
 <20230621072234.9900-2-alexghiti@rivosinc.com>
 <20230621-d6da578719f8af903d6746ef@orel>
From:   Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20230621-d6da578719f8af903d6746ef@orel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 21/06/2023 14:19, Andrew Jones wrote:
> On Wed, Jun 21, 2023 at 09:22:33AM +0200, Alexandre Ghiti wrote:
>> This document describes the constraints and requirements of the early
>> boot process in a RISC-V kernel.
>>
>> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>> Reviewed-by: Björn Töpel <bjorn@rivosinc.com>
>> ---
>>   Documentation/riscv/boot-image-header.rst |   3 -
>>   Documentation/riscv/boot.rst              | 170 ++++++++++++++++++++++
>>   Documentation/riscv/index.rst             |   1 +
>>   3 files changed, 171 insertions(+), 3 deletions(-)
>>   create mode 100644 Documentation/riscv/boot.rst
>>
>> diff --git a/Documentation/riscv/boot-image-header.rst b/Documentation/riscv/boot-image-header.rst
>> index d7752533865f..a4a45310c4c4 100644
>> --- a/Documentation/riscv/boot-image-header.rst
>> +++ b/Documentation/riscv/boot-image-header.rst
>> @@ -7,9 +7,6 @@ Boot image header in RISC-V Linux
>>   
>>   This document only describes the boot image header details for RISC-V Linux.
>>   
>> -TODO:
>> -  Write a complete booting guide.
>> -
>>   The following 64-byte header is present in decompressed Linux kernel image::
>>   
>>   	u32 code0;		  /* Executable code */
>> diff --git a/Documentation/riscv/boot.rst b/Documentation/riscv/boot.rst
>> new file mode 100644
>> index 000000000000..019ee818686d
>> --- /dev/null
>> +++ b/Documentation/riscv/boot.rst
>> @@ -0,0 +1,170 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>> +===============================================
>> +RISC-V Kernel Boot Requirements and Constraints
>> +===============================================
>> +
>> +:Author: Alexandre Ghiti <alexghiti@rivosinc.com>
>> +:Date: 23 May 2023
>> +
>> +This document describes what the RISC-V kernel expects from bootloaders and
>> +firmware, but also the constraints that any developer must have in mind when
>> +touching the early boot process. For the purposes of this document, the
>> +'early boot process' refers to any code that runs before the final virtual
>> +mapping is set up.
>> +
>> +Pre-kernel Requirements and Constraints
>> +=======================================
>> +
>> +The RISC-V kernel expects the following of bootloaders and platform firmware:
>> +
>> +Register state
>> +--------------
>> +
>> +The RISC-V kernel expects:
>> +
>> +  * `$a0` to contain the hartid of the current core.
>> +  * `$a1` to contain the address of the devicetree in memory.
>> +
>> +CSR state
>> +---------
>> +
>> +The RISC-V kernel expects:
>> +
>> +  * `$satp = 0`: the MMU, if present, must be disabled.
>> +
>> +Reserved memory for resident firmware
>> +-------------------------------------
>> +
>> +The RISC-V kernel must not map any resident memory, or memory protected with
>> +PMPs, in the direct mapping, so the firmware must correctly mark those regions
>> +as per the devicetree specification and/or the UEFI specification.
>> +
>> +Kernel location
>> +---------------
>> +
>> +The RISC-V kernel expects to be placed at a PMD boundary (2MB aligned for rv64
>> +and 4MB aligned for rv32). Note that the EFI stub will physically relocate the
>> +kernel if that's not the case.
>> +
>> +Hardware description
>> +--------------------
>> +
>> +The firmware can pass either a devicetree or ACPI tables to the RISC-V kernel.
>> +
>> +The devicetree is either passed directly to the kernel from the previous stage
>> +using the `$a1` register, or when booting with UEFI, it can be passed using the
>> +EFI configuration table.
>> +
>> +The ACPI tables are passed to the kernel using the EFI configuration table. In
>> +this case, a tiny devicetree is still created by the EFI stub. Please refer to
>> +"EFI stub and devicetree" tree section below for details about this devicetree.
>                               ^ redundant 'tree' here
>
>> +
>> +Kernel entrance
>> +---------------
>> +
>> +On SMP systems, there are 2 methods to enter the kernel:
>> +
>> +- `RISCV_BOOT_SPINWAIT`: the firmware releases all harts in the kernel, one hart
>> +  wins a lottery and executes the early boot code while the other harts are
>> +  parked waiting for the initialization to finish. This method is mostly used to
>> +  support older firmwares without SBI HSM extension and M-mode RISC-V kernel.
>> +- `Ordered booting`: the firmware releases only one hart that will execute the
>> +  initialization phase and then will start all other harts using the SBI HSM
>> +  extension. The ordered booting method is the preferred booting method for
>> +  booting the RISC-V kernel because it can support cpu hotplug and kexec.
>> +
>> +UEFI
>> +----
>> +
>> +UEFI memory map
>> +~~~~~~~~~~~~~~~
>> +
>> +When booting with UEFI, the RISC-V kernel will use only the EFI memory map to
>> +populate the system memory.
>> +
>> +The UEFI firmware must parse the subnodes of the `/reserved-memory` devicetree
>> +node and abide by the devicetree specification to convert the attributes of
>> +those subnodes (`no-map` and `reusable`) into their correct EFI equivalent
>> +(refer to section "3.5.4 /reserved-memory and UEFI" of the devicetree
>> +specification v0.4-rc1).
>> +
>> +RISCV_EFI_BOOT_PROTOCOL
>> +~~~~~~~~~~~~~~~~~~~~~~~
>> +
>> +When booting with UEFI, the EFI stub requires the boot hartid in order to pass
>> +it to the RISC-V kernel in `$a1`. The EFI stub retrieves the boot hartid using
>> +one of the following methods:
>> +
>> +- `RISCV_EFI_BOOT_PROTOCOL` (**preferred**).
>> +- `boot-hartid` devicetree subnode (**deprecated**).
>> +
>> +Any new firmware must implement `RISCV_EFI_BOOT_PROTOCOL` as the devicetree
>> +based approach is deprecated now.
>> +
>> +Early Boot Requirements and Constraints
>> +=======================================
>> +
>> +The RISC-V kernel's early boot process operates under the following constraints:
>> +
>> +EFI stub and devicetree
>> +-----------------------
>> +
>> +When booting with UEFI, the devicetree is supplemented (or created) by the EFI
>> +stub with the same parameters as arm64 which are described at the paragraph
>> +"UEFI kernel support on ARM" in Documentation/arm/uefi.rst.
>> +
>> +Virtual mapping installation
>> +----------------------------
>> +
>> +The installation of the virtual mapping is done in 2 steps in the RISC-V kernel:
>> +
>> +1. :c:func:`setup_vm` installs a temporary kernel mapping in
>> +   :c:var:`early_pg_dir` which allows discovery of the system memory. Only the
>> +   kernel text/data are mapped at this point. When establishing this mapping, no
>> +   allocation can be done (since the system memory is not known yet), so
>> +   :c:var:`early_pg_dir` page table is statically allocated (using only one
>> +   table for each level).
>> +
>> +2. :c:func:`setup_vm_final` creates the final kernel mapping in
>> +   :c:var:`swapper_pg_dir` and takes advantage of the discovered system memory
>> +   to create the linear mapping. When establishing this mapping, the kernel
>> +   can allocate memory but cannot access it directly (since the direct mapping
>> +   is not present yet), so it uses temporary mappings in the fixmap region to
>> +   be able to access the newly allocated page table levels.
>> +
>> +For :c:func:`virt_to_phys` and :c:func:`phys_to_virt` to be able to correctly
>> +convert direct mapping addresses to physical addresses, they need to know the
>> +start of the DRAM. This happens after step 1, right before step 2 installs the
>> +direct mapping (see :c:func:`setup_bootmem` function in arch/riscv/mm/init.c).
>> +Any usage of those macros before the final virtual mapping is installed must
>> +be carefully examined.
>> +
>> +Device-tree mapping via fixmap
>> +------------------------------
>> +
>> +The RISC-V kernel uses the fixmap region to map the devicetree because the
>> +devicetree virtual mapping must remain the same between :c:func:`setup_vm` and
>> +:c:func:`setup_vm_final` calls since the :c:var:`reserved_mem` array is
>> +initialized with virtual addresses established by :c:func:`setup_vm` and used
>> +with the mapping established by :c:func:`setup_vm_final`.
>> +
>> +Pre-MMU execution
>> +-----------------
>> +
>> +A few pieces of code need to run before even the first virtual mapping is
>> +established. These are the installation of the first virtual mapping itself,
>> +patching of early alternatives and the early parsing of the kernel command line.
>> +That code must be very carefully compiled as:
>> +
>> +- `-fno-pie`: This is needed for relocatable kernels which use `-fPIE`, since
>> +  otherwise, any access to a global symbol would go through the GOT which is
>> +  only relocated virtually.
>> +- `-mcmodel=medany`: Any access to a global symbol must be PC-relative to avoid
>> +  any relocations to happen before the MMU is setup.
>> +- *all* instrumentation must also be disabled (that includes KASAN, ftrace and
>> +  others).
>> +
>> +As using a symbol from a different compilation unit requires this unit to be
>> +compiled with those flags, we advise, as much as possible, not to use external
>> +symbols.
>> diff --git a/Documentation/riscv/index.rst b/Documentation/riscv/index.rst
>> index 175a91db0200..1f66062def6d 100644
>> --- a/Documentation/riscv/index.rst
>> +++ b/Documentation/riscv/index.rst
>> @@ -5,6 +5,7 @@ RISC-V architecture
>>   .. toctree::
>>       :maxdepth: 1
>>   
>> +    boot
>>       boot-image-header
>>       vm-layout
>>       hwprobe
>> -- 
>> 2.39.2
>>
> Otherwise looks good to me.


I assume I can add your RB here, don't waste time answering if I'm right :)

Thanks!


>
> Thanks,
> drew
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

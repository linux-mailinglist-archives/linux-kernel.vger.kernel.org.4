Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 357B37238D4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 09:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236310AbjFFHVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 03:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233182AbjFFHVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 03:21:04 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C183910C2
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 00:20:39 -0700 (PDT)
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
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3F2B7240009;
        Tue,  6 Jun 2023 07:20:34 +0000 (UTC)
Message-ID: <0855b8d6-e1e0-fea6-2b15-d7cc66d34e02@ghiti.fr>
Date:   Tue, 6 Jun 2023 09:20:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: Bug report: kernel paniced while booting
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
References: <tencent_7C3B580B47C1B17C16488EC1@qq.com>
 <CAHVXubjm5ax5KYTV_G=GUUH0KJK=v6_jO09XF1T4AzzUTr0CSg@mail.gmail.com>
 <ZH37WMnx/rYSRF/o@sunil-laptop>
 <CAOnJCU+v-tinJb3=FY9GKzR=CGc+AE45wVdpVVZLSG1WOR2PLA@mail.gmail.com>
Content-Language: en-US
From:   Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <CAOnJCU+v-tinJb3=FY9GKzR=CGc+AE45wVdpVVZLSG1WOR2PLA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 05/06/2023 22:55, Atish Patra wrote:
> On Mon, Jun 5, 2023 at 8:13 AM Sunil V L <sunilvl@ventanamicro.com> wrote:
>> On Mon, Jun 05, 2023 at 04:25:06PM +0200, Alexandre Ghiti wrote:
>>> Hi Song,
>>>
>>> On Mon, Jun 5, 2023 at 12:52 PM Song Shuai <songshuaishuai@tinylab.org> wrote:
>>>> Description of problem:
>>>>
>>>> Booting Linux With RiscVVirtQemu edk2 firmware, a Store/AMO page fault was trapped to trigger a kernel panic.
>>>> The entire log has been posted at this link : https://termbin.com/nga4.
>>>>
>>>> You can reproduce it with the following step :
>>>>
>>>> 1. prepare the environment with
>>>>     - Qemu-virt:  v8.0.0 (with OpenSbi v1.2)
>>>>     - edk2 : at commit (2bc8545883 "UefiCpuPkg/CpuPageTableLib: Reduce the number of random tests")
>>>>     - Linux : v6.4-rc1 and later version
>>>>
>>>> 2. start the Qemu virt board
>>>>
>>>> ```sh
>>>> $ cat ~/8_riscv/start_latest.sh
>>>> #!/bin/bash
>>>> /home/song/8_riscv/3_acpi/qemu/ooo/usr/local/bin/qemu-system-riscv64 \
>>>>          -s -nographic -drive file=/home/song/8_riscv/3_acpi/Build_virt/RiscVVirtQemu/RELEASE_GCC5/FV/RISCV_VIRT.fd,if=pflash,format=raw,unit=1 \
>>>>          -machine virt,acpi=off -smp 2 -m 2G \
>>>>          -kernel /home/song/9_linux/linux/00_rv_def/arch/riscv/boot/Image \
>>>>          -initrd /home/song/8_riscv/3_acpi/buildroot/output/images/rootfs.ext2 \
>>>>          -append "root=/dev/ram ro console=ttyS0 earlycon=uart8250,mmio,0x10000000 efi=debug loglevel=8 memblock=debug" ## also panic by memtest
>>>> ```
>>>> 3. Then you will encounter the kernel panic logged in the above link
>>>>
>>>> Other Information:
>>>>
>>>> 1. -------
>>>>
>>>> This report is not identical to my prior report -- "kernel paniced when system hibernates" [1], but both of them
>>>> are closely related with the commit (3335068f8721 "riscv: Use PUD/P4D/PGD pages for the linear mapping").
>>>>
>>>> With this commit, hibernation is trapped with "access fault" while accessing the PMP-protected regions (mmode_resv0@80000000)
>>>> from OpenSbi (BTW, hibernation is marked as nonportable by Conor[2]).
>>>>
>>>> In this report, efi_init handoffs the memory mapping from Boot Services to memblock where reserves mmode_resv0@80000000,
>>>> so there is no "access fault" but "page fault".
>>>>
>>>> And reverting commit 3335068f8721 indeed fixed this panic.
>>>>
>>>> 2. -------
>>>>
>>>> As the gdb-pt-dump [3] tool shows, the PTE which covered the fault virtual address had the appropriate permission to store.
>>>> Is there another way to trigger the "Store/AMO page fault"? Or the creation of linear mapping in commit 3335068f8721 did something wrong?
>>>>
>>>> ```
>>>> (gdb) p/x $satp
>>>> $1 = 0xa000000000081708
>>>> (gdb) pt -satp 0xa000000000081708
>>>>               Address :     Length   Permissions
>>>>    0xff1bfffffea39000 :     0x1000 | W:1 X:0 R:1 S:1
>>>>    0xff1bfffffebf9000 :     0x1000 | W:1 X:0 R:1 S:1
>>>>    0xff1bfffffec00000 :   0x400000 | W:1 X:0 R:1 S:1
>>>>    0xff60000000000000 :   0x1c0000 | W:1 X:0 R:1 S:1
>>>>    0xff60000000200000 :   0xa00000 | W:0 X:0 R:1 S:1
>>>>    0xff60000000c00000 : 0x7f000000 | W:1 X:0 R:1 S:1  // badaddr: ff6000007fdb1000
>>>>    0xff6000007fdc0000 :    0x3d000 | W:1 X:0 R:1 S:1
>>>>    0xff6000007ffbf000 :     0x1000 | W:1 X:0 R:1 S:1
>>>>    0xffffffff80000000 :   0xc00000 | W:0 X:1 R:1 S:1
>>>>    0xffffffff80c00000 :   0xa00000 | W:1 X:0 R:1 S:1
>>>>
>>>> ```
>>>>
>>>> 3. ------
>>>>
>>>> You can also reproduce similar panic by appending "memtest" in kernel cmdline.
>>>> I have posted the memtest boot log at this link: https://termbin.com/1twl.
>>>>
>>>> Please correct me if I'm wrong.
>>>>
>>>> [1]: https://lore.kernel.org/linux-riscv/CAAYs2=gQvkhTeioMmqRDVGjdtNF_vhB+vm_1dHJxPNi75YDQ_Q@mail.gmail.com/
>>>> [2]: https://lore.kernel.org/linux-riscv/20230526-astride-detonator-9ae120051159@wendy/
>>>> [3]: https://github.com/martinradev/gdb-pt-dump
>>> Thanks for the thorough report, really appreciated.
>>>
>>> So there are multiple issues here:
>>>
>>> - the first one is that the memory region for opensbi is marked as not
>>> cacheable in the efi memory map, and then this region is not mapped in
>>> the linear mapping:
>>> [    0.000000] efi:   0x000080000000-0x00008003ffff [Reserved    |   |
>>>   |  |  |  |  |  |  |  |   |  |  |  |UC]
>>>
> @Alex: The OpenSBI region is marked reserved because EDK2 chooses to
> do that explicitly as explained by Sunil.
> I don't think UC has to do anything with it. All the EFI memory regions are UC.


Oops, thanks for correcting me, UC has nothing to do with that indeed, I 
misread is_usable_memory() 
(https://elixir.bootlin.com/linux/latest/source/drivers/firmware/efi/efi-init.c#L127): 
EFI_RESERVED_TYPE will return false.

And then this region won't get mapped, so that's the equivalent of "no-map".


>
>>> - the second one (that I feel a bit ashamed of...) is that I did not
>>> check the alignment of the virtual address when choosing the map size
>>> in best_map_size() and then we end up trying to map a physical region
>>> aligned on 2MB that is actually not aligned on 2MB virtually because
>>> the opensbi region is not mapped at all.
>>>
>>> - the possible third one is that we should not map the linear mapping
>>> using 4K pages, this would be slow in my opinion, and I think we
>>> should waste a bit of memory to align va and pa on a 2MB boundary.
>>>
>>> So I'll fix the second issue, and possibly the third one, and if no
>>> one looks into why the opensbi region is mapped in UC, I'll take a
>>> look at edk2.
>>>
>> Hi Alex,
>>
>> EDK2 marks opensbi range as reserved memory in EFI map. According to DT
>> spec, if the no-map is not set, we need to mark it as
>> EfiBootServicesData but EfiBootServicesData is actually considered as
>> free memory in kernel, as per UEFI spec. To avoid kernel using this
>> memory, we deviated from the DT spec for opensbi ranges.
>>
> IMO, that should be the correct way unless we can change it to
> EfiRunServicesData/Code.


I'd say that everything depends on "reusable" no?

If "no-map" then
    EfiReserved
else
    if reusable then
       EfiBootServicesData
    else
       EfiRuntimeServicesData
    endif
endif

For now, I think only the following is done (based on "3.5.4 
/reserved-memory and UEFI" of the DT spec 
https://github.com/devicetree-org/devicetree-specification/releases/download/v0.4-rc1/devicetree-specification-v0.4-rc1.pdf):

If "no-map" then
    EfiReserved
else
    EfiBootServicesData
endif


> Looking at U-Boot code, it sets the no-map region to
> EfiBootServicesData which may cause
> issues in RISC-V as well if we linear mapping sets up the initial 2MB.


Hmm 
https://elixir.bootlin.com/u-boot/v2023.07-rc3/source/lib/efi_loader/efi_dt_fixup.c#L25 
seems to follow what I quoted from the DT spec above:

     if (nomap)
         type = EFI_RESERVED_MEMORY_TYPE;
     else
         type = EFI_BOOT_SERVICES_DATA;


And I don't find anything regarding "reusable" in u-boot code.


>
>
>> Let me know your thoughts how we can handle this better in EDK2
>> considering it has to support ACPI also.
>>
>> Thanks,
>> Sunil
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv
>
>

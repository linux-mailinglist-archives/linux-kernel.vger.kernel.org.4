Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D10B37238F5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 09:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233014AbjFFHZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 03:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236092AbjFFHZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 03:25:45 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1BD9F3
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 00:25:43 -0700 (PDT)
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
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7CE981BF20C;
        Tue,  6 Jun 2023 07:25:37 +0000 (UTC)
Message-ID: <6b2ac044-fc66-b4e8-81e7-3375b85674b7@ghiti.fr>
Date:   Tue, 6 Jun 2023 09:25:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: Bug report: kernel paniced while booting
Content-Language: en-US
To:     Sunil V L <sunilvl@ventanamicro.com>,
        Jessica Clarke <jrtc27@jrtc27.com>
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
 <38747287-B219-4B48-B088-A33ADC7954A0@jrtc27.com>
 <ZH7U6QTbKsO0kfYx@sunil-laptop>
From:   Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <ZH7U6QTbKsO0kfYx@sunil-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 06/06/2023 08:40, Sunil V L wrote:
> On Mon, Jun 05, 2023 at 10:42:33PM +0100, Jessica Clarke wrote:
>> On 5 Jun 2023, at 16:12, Sunil V L <sunilvl@ventanamicro.com> wrote:
>>> On Mon, Jun 05, 2023 at 04:25:06PM +0200, Alexandre Ghiti wrote:
>>>> Hi Song,
>>>>
>>>> On Mon, Jun 5, 2023 at 12:52 PM Song Shuai <songshuaishuai@tinylab.org> wrote:
>>>>> Description of problem:
>>>>>
>>>>> Booting Linux With RiscVVirtQemu edk2 firmware, a Store/AMO page fault was trapped to trigger a kernel panic.
>>>>> The entire log has been posted at this link : https://termbin.com/nga4.
>>>>>
>>>>> You can reproduce it with the following step :
>>>>>
>>>>> 1. prepare the environment with
>>>>>    - Qemu-virt:  v8.0.0 (with OpenSbi v1.2)
>>>>>    - edk2 : at commit (2bc8545883 "UefiCpuPkg/CpuPageTableLib: Reduce the number of random tests")
>>>>>    - Linux : v6.4-rc1 and later version
>>>>>
>>>>> 2. start the Qemu virt board
>>>>>
>>>>> ```sh
>>>>> $ cat ~/8_riscv/start_latest.sh
>>>>> #!/bin/bash
>>>>> /home/song/8_riscv/3_acpi/qemu/ooo/usr/local/bin/qemu-system-riscv64 \
>>>>>         -s -nographic -drive file=/home/song/8_riscv/3_acpi/Build_virt/RiscVVirtQemu/RELEASE_GCC5/FV/RISCV_VIRT.fd,if=pflash,format=raw,unit=1 \
>>>>>         -machine virt,acpi=off -smp 2 -m 2G \
>>>>>         -kernel /home/song/9_linux/linux/00_rv_def/arch/riscv/boot/Image \
>>>>>         -initrd /home/song/8_riscv/3_acpi/buildroot/output/images/rootfs.ext2 \
>>>>>         -append "root=/dev/ram ro console=ttyS0 earlycon=uart8250,mmio,0x10000000 efi=debug loglevel=8 memblock=debug" ## also panic by memtest
>>>>> ```
>>>>> 3. Then you will encounter the kernel panic logged in the above link
>>>>>
>>>>> Other Information:
>>>>>
>>>>> 1. -------
>>>>>
>>>>> This report is not identical to my prior report -- "kernel paniced when system hibernates" [1], but both of them
>>>>> are closely related with the commit (3335068f8721 "riscv: Use PUD/P4D/PGD pages for the linear mapping").
>>>>>
>>>>> With this commit, hibernation is trapped with "access fault" while accessing the PMP-protected regions (mmode_resv0@80000000)
>>>>> from OpenSbi (BTW, hibernation is marked as nonportable by Conor[2]).
>>>>>
>>>>> In this report, efi_init handoffs the memory mapping from Boot Services to memblock where reserves mmode_resv0@80000000,
>>>>> so there is no "access fault" but "page fault".
>>>>>
>>>>> And reverting commit 3335068f8721 indeed fixed this panic.
>>>>>
>>>>> 2. -------
>>>>>
>>>>> As the gdb-pt-dump [3] tool shows, the PTE which covered the fault virtual address had the appropriate permission to store.
>>>>> Is there another way to trigger the "Store/AMO page fault"? Or the creation of linear mapping in commit 3335068f8721 did something wrong?
>>>>>
>>>>> ```
>>>>> (gdb) p/x $satp
>>>>> $1 = 0xa000000000081708
>>>>> (gdb) pt -satp 0xa000000000081708
>>>>>              Address :     Length   Permissions
>>>>>   0xff1bfffffea39000 :     0x1000 | W:1 X:0 R:1 S:1
>>>>>   0xff1bfffffebf9000 :     0x1000 | W:1 X:0 R:1 S:1
>>>>>   0xff1bfffffec00000 :   0x400000 | W:1 X:0 R:1 S:1
>>>>>   0xff60000000000000 :   0x1c0000 | W:1 X:0 R:1 S:1
>>>>>   0xff60000000200000 :   0xa00000 | W:0 X:0 R:1 S:1
>>>>>   0xff60000000c00000 : 0x7f000000 | W:1 X:0 R:1 S:1  // badaddr: ff6000007fdb1000
>>>>>   0xff6000007fdc0000 :    0x3d000 | W:1 X:0 R:1 S:1
>>>>>   0xff6000007ffbf000 :     0x1000 | W:1 X:0 R:1 S:1
>>>>>   0xffffffff80000000 :   0xc00000 | W:0 X:1 R:1 S:1
>>>>>   0xffffffff80c00000 :   0xa00000 | W:1 X:0 R:1 S:1
>>>>>
>>>>> ```
>>>>>
>>>>> 3. ------
>>>>>
>>>>> You can also reproduce similar panic by appending "memtest" in kernel cmdline.
>>>>> I have posted the memtest boot log at this link: https://termbin.com/1twl.
>>>>>
>>>>> Please correct me if I'm wrong.
>>>>>
>>>>> [1]: https://lore.kernel.org/linux-riscv/CAAYs2=gQvkhTeioMmqRDVGjdtNF_vhB+vm_1dHJxPNi75YDQ_Q@mail.gmail.com/
>>>>> [2]: https://lore.kernel.org/linux-riscv/20230526-astride-detonator-9ae120051159@wendy/
>>>>> [3]: https://github.com/martinradev/gdb-pt-dump
>>>> Thanks for the thorough report, really appreciated.
>>>>
>>>> So there are multiple issues here:
>>>>
>>>> - the first one is that the memory region for opensbi is marked as not
>>>> cacheable in the efi memory map, and then this region is not mapped in
>>>> the linear mapping:
>>>> [    0.000000] efi:   0x000080000000-0x00008003ffff [Reserved    |   |
>>>> |  |  |  |  |  |  |  |   |  |  |  |UC]
>>>>
>>>> - the second one (that I feel a bit ashamed of...) is that I did not
>>>> check the alignment of the virtual address when choosing the map size
>>>> in best_map_size() and then we end up trying to map a physical region
>>>> aligned on 2MB that is actually not aligned on 2MB virtually because
>>>> the opensbi region is not mapped at all.
>>>>
>>>> - the possible third one is that we should not map the linear mapping
>>>> using 4K pages, this would be slow in my opinion, and I think we
>>>> should waste a bit of memory to align va and pa on a 2MB boundary.
>>>>
>>>> So I'll fix the second issue, and possibly the third one, and if no
>>>> one looks into why the opensbi region is mapped in UC, I'll take a
>>>> look at edk2.
>>>>
>>> Hi Alex,
>>>
>>> EDK2 marks opensbi range as reserved memory in EFI map. According to DT
>>> spec, if the no-map is not set, we need to mark it as
>>> EfiBootServicesData but EfiBootServicesData is actually considered as
>>> free memory in kernel, as per UEFI spec. To avoid kernel using this
>>> memory, we deviated from the DT spec for opensbi ranges.
>> Violating specs is never the answer. Do one of:
>>
>> 1. Use no-map and take the performance hit
>> 2. Exclude the memory range from /memory itself
>> 3. Come up with a new no-access property that’s a weaker no-map
>>     (i.e. that allows mapping and speculative access) and uses
>>     EfiRuntimeServicesData in EFI land
>>
>> 2 feels most normal to me, personally, but all are fine.
>>
> Hi Jess,
>
> IMO, all the physical memory installed by the user should be visible.
> Some part of the memory may be reserved and not available for the user
> but excluding from /memory can cause issues.
>
> Whether we mark as EfiReservedMemory or EfiRuntimeServiceData, I think
> it will be marked as no-map in memblock and can not be used by the OS
> linear mapping. Alex can confirm this.


Yes, I think you're right, EfiRuntimeServiceData will be marked as 
no-map anyway (see is_usable_memory()).


>
> So, my preference is option 1.


Yes, again, I think you're right, this is feeling more and more like the 
most "natural" solution to me too, we are struggling for a performance 
benefit that was never proven...


>
> Thanks,
> Sunil
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

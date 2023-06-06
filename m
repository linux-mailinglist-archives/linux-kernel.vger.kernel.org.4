Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BDB9723EDE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 12:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236098AbjFFKEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 06:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjFFKEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 06:04:37 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAAA8E55
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 03:04:33 -0700 (PDT)
X-QQ-mid: bizesmtp91t1686045843tio9k4gs
Received: from [192.168.1.114] ( [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 06 Jun 2023 18:04:01 +0800 (CST)
X-QQ-SSF: 00200000000000807000000A0000000
X-QQ-FEAT: RmDZc/K2LPHC/eGOPxqIE8cwxJTymxechOOq2757qIg196A5sM4WkttXpqIOh
        hZFGT0u8YfRTzj4Lg8Zv/JcbNk6EBRQ8ARrRQGFi8nbFsbm6dANGUvVq7/YeqmYJQ4YnmYK
        CBanlcHDGhbx64KRKIZh/NkxAuV5IZlH4rg+QbH9B5N+0eSD1TXDfvKLCb4ttaBnuPK5snr
        ERtiS6P55/iXD5PK+H4taEYx39yHdShUFcNBPSKycXMF4ujRn6ALLrWzFW1qVYNDruxYEDX
        9QZAc9UCyKscbjd4USdW5jhnylwPmSf5Np/30WQINsVk4cdB6R18LwU+bz5fi98jT8GJoKG
        xImyi+V0/vQ6zcrlnAV9RwI2nAvnEZrdXAstVxFHlrXhz1YYplYNHXSXEJ4MNQXwABirBfd
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10253589702890628571
Message-ID: <BF85472AD8E99564+e8e07a01-81e5-c9b7-48f4-5b66b83120ee@tinylab.org>
Date:   Tue, 6 Jun 2023 18:04:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: Bug report: kernel paniced while booting
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     robh <robh@kernel.org>, ajones <ajones@ventanamicro.com>,
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
From:   Song Shuai <songshuaishuai@tinylab.org>
In-Reply-To: <CAHVXubjm5ax5KYTV_G=GUUH0KJK=v6_jO09XF1T4AzzUTr0CSg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-3
X-Spam-Status: No, score=0.3 required=5.0 tests=BAYES_00,FORGED_MUA_MOZILLA,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/6/5 22:25, Alexandre Ghiti 写道:
> Hi Song,
> 
> On Mon, Jun 5, 2023 at 12:52 PM Song Shuai <songshuaishuai@tinylab.org> wrote:
>>
>> Description of problem:
>>
>> Booting Linux With RiscVVirtQemu edk2 firmware, a Store/AMO page fault was trapped to trigger a kernel panic.
>> The entire log has been posted at this link : https://termbin.com/nga4.
>>
>> You can reproduce it with the following step :
>>
>> 1. prepare the environment with
>>     - Qemu-virt:  v8.0.0 (with OpenSbi v1.2)
>>     - edk2 : at commit (2bc8545883 "UefiCpuPkg/CpuPageTableLib: Reduce the number of random tests")
>>     - Linux : v6.4-rc1 and later version
>>
>> 2. start the Qemu virt board
>>
>> ```sh
>> $ cat ~/8_riscv/start_latest.sh
>> #!/bin/bash
>> /home/song/8_riscv/3_acpi/qemu/ooo/usr/local/bin/qemu-system-riscv64 \
>>          -s -nographic -drive file=/home/song/8_riscv/3_acpi/Build_virt/RiscVVirtQemu/RELEASE_GCC5/FV/RISCV_VIRT.fd,if=pflash,format=raw,unit=1 \
>>          -machine virt,acpi=off -smp 2 -m 2G \
>>          -kernel /home/song/9_linux/linux/00_rv_def/arch/riscv/boot/Image \
>>          -initrd /home/song/8_riscv/3_acpi/buildroot/output/images/rootfs.ext2 \
>>          -append "root=/dev/ram ro console=ttyS0 earlycon=uart8250,mmio,0x10000000 efi=debug loglevel=8 memblock=debug" ## also panic by memtest
>> ```
>> 3. Then you will encounter the kernel panic logged in the above link
>>
>> Other Information:
>>
>> 1. -------
>>
>> This report is not identical to my prior report -- "kernel paniced when system hibernates" [1], but both of them
>> are closely related with the commit (3335068f8721 "riscv: Use PUD/P4D/PGD pages for the linear mapping").
>>
>> With this commit, hibernation is trapped with "access fault" while accessing the PMP-protected regions (mmode_resv0@80000000)
>> from OpenSbi (BTW, hibernation is marked as nonportable by Conor[2]).
>>
>> In this report, efi_init handoffs the memory mapping from Boot Services to memblock where reserves mmode_resv0@80000000,
>> so there is no "access fault" but "page fault".
>>
>> And reverting commit 3335068f8721 indeed fixed this panic.
>>
>> 2. -------
>>
>> As the gdb-pt-dump [3] tool shows, the PTE which covered the fault virtual address had the appropriate permission to store.
>> Is there another way to trigger the "Store/AMO page fault"? Or the creation of linear mapping in commit 3335068f8721 did something wrong?
>>
>> ```
>> (gdb) p/x $satp
>> $1 = 0xa000000000081708
>> (gdb) pt -satp 0xa000000000081708
>>               Address :     Length   Permissions
>>    0xff1bfffffea39000 :     0x1000 | W:1 X:0 R:1 S:1
>>    0xff1bfffffebf9000 :     0x1000 | W:1 X:0 R:1 S:1
>>    0xff1bfffffec00000 :   0x400000 | W:1 X:0 R:1 S:1
>>    0xff60000000000000 :   0x1c0000 | W:1 X:0 R:1 S:1
>>    0xff60000000200000 :   0xa00000 | W:0 X:0 R:1 S:1
>>    0xff60000000c00000 : 0x7f000000 | W:1 X:0 R:1 S:1  // badaddr: ff6000007fdb1000
>>    0xff6000007fdc0000 :    0x3d000 | W:1 X:0 R:1 S:1
>>    0xff6000007ffbf000 :     0x1000 | W:1 X:0 R:1 S:1
>>    0xffffffff80000000 :   0xc00000 | W:0 X:1 R:1 S:1
>>    0xffffffff80c00000 :   0xa00000 | W:1 X:0 R:1 S:1
>>
>> ```
>>
>> 3. ------
>>
>> You can also reproduce similar panic by appending "memtest" in kernel cmdline.
>> I have posted the memtest boot log at this link: https://termbin.com/1twl.
>>
>> Please correct me if I'm wrong.
>>
>> [1]: https://lore.kernel.org/linux-riscv/CAAYs2=gQvkhTeioMmqRDVGjdtNF_vhB+vm_1dHJxPNi75YDQ_Q@mail.gmail.com/
>> [2]: https://lore.kernel.org/linux-riscv/20230526-astride-detonator-9ae120051159@wendy/
>> [3]: https://github.com/martinradev/gdb-pt-dump
> 
> Thanks for the thorough report, really appreciated.
> 
> So there are multiple issues here:
> 
> - the first one is that the memory region for opensbi is marked as not
> cacheable in the efi memory map, and then this region is not mapped in
> the linear mapping:
> [    0.000000] efi:   0x000080000000-0x00008003ffff [Reserved    |   |
>   |  |  |  |  |  |  |  |   |  |  |  |UC]
> 
> - the second one (that I feel a bit ashamed of...) is that I did not
> check the alignment of the virtual address when choosing the map size
> in best_map_size() and then we end up trying to map a physical region
> aligned on 2MB that is actually not aligned on 2MB virtually because
> the opensbi region is not mapped at all.
> 
The issue 2 should be the root cause of this panic.

Here is my understanding of the necessity of the 2M-aligned VA for 
linear PMD mapping. Please correct me if I'm wrong.

I logged the `create_linear_mapping_range()` function.

```
song # lowmem region: [0x0000000081800000 -- 0x00000000ffe3d000], va: 
0xff6000007fbc0000, pa: 0x00000000ffc00000, map_size: 200000 ,pg: e7
song # lowmem region: [0x0000000081800000 -- 0x00000000ffe3d000], va: 
0xff6000007fdc0000, pa: 0x00000000ffe00000, map_size: 1000 ,pg: e7
```

The PA `0x00000000ffc00000` of this PMD mapping is aligned with PMD_SIZE 
but VA `0xff6000007fbc0000` is not.
After the `pmd_index()`, this 2M PA region is actually mapping the 
effective VA region `[0xff6000007fa00000,0xff6000007fc00000)`,
and any access of VA hole between the end of the effective VA region and 
the start VA of the next 4K mapping (`0xff6000007fdc0000`) will fault.

In this report, the memtest fault VA (`0xff6000007fc00000`) and the 
booting fault VA (`ff6000007fdb1000`) lie right in the VA hole.

When reverting the commit 3335068f8721, the kernel load address is 
always offseted by PMD_SIZE, kernel_map.va_pa_offset and
MIN_MEMBLOCK_ADDR follow it. So the linear PMD mapping will always take 
2M-aligned VA. That's why this reverting works.

> - the possible third one is that we should not map the linear mapping
> using 4K pages, this would be slow in my opinion, and I think we
> should waste a bit of memory to align va and pa on a 2MB boundary.
I also noticed this one.
> 
> So I'll fix the second issue, and possibly the third one, and if no
Thanks for your attention to this report, looking for your fixup.
> one looks into why the opensbi region is mapped in UC, I'll take a
> look at edk2.
> 
> Sorry for that,
> 
> Alex
> 

-- 
Song Shuai
Thanks


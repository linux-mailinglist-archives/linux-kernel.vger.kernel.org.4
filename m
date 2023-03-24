Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 826D16C7C17
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 11:00:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbjCXKAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 06:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjCXKAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 06:00:16 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6374D18160;
        Fri, 24 Mar 2023 03:00:12 -0700 (PDT)
Received: (Authenticated sender: alex@ghiti.fr)
        by mail.gandi.net (Postfix) with ESMTPSA id 1881FE000B;
        Fri, 24 Mar 2023 09:59:57 +0000 (UTC)
Message-ID: <d0087922-4721-ccf1-80bf-9f74099d0948@ghiti.fr>
Date:   Fri, 24 Mar 2023 10:59:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v8 0/4] riscv: Use PUD/P4D/PGD pages for the linear
 mapping
Content-Language: en-US
To:     Anup Patel <apatel@ventanamicro.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anup Patel <anup@brainfault.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-mm@kvack.org
References: <20230316131711.1284451-1-alexghiti@rivosinc.com>
 <CAK9=C2XJtSG2d_nsyDv7kU1v7Jj0chdevqrMc0MpJswukcEABA@mail.gmail.com>
 <CAHVXubhhxpzHDM-n91V_rceY5t_VqLvrwZj3RP_tNL2=F9mqjQ@mail.gmail.com>
 <CAK9=C2WVOpSqtt8r1U4hnzSZ=cc1PocpukgQjNyahP2XuPhozw@mail.gmail.com>
From:   Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <CAK9=C2WVOpSqtt8r1U4hnzSZ=cc1PocpukgQjNyahP2XuPhozw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.7 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/23/23 15:55, Anup Patel wrote:
> On Thu, Mar 23, 2023 at 6:24 PM Alexandre Ghiti <alexghiti@rivosinc.com> wrote:
>> Hi Anup,
>>
>> On Thu, Mar 23, 2023 at 1:18 PM Anup Patel <apatel@ventanamicro.com> wrote:
>>> Hi Alex,
>>>
>>> On Thu, Mar 16, 2023 at 6:48 PM Alexandre Ghiti <alexghiti@rivosinc.com> wrote:
>>>> This patchset intends to improve tlb utilization by using hugepages for
>>>> the linear mapping.
>>>>
>>>> As reported by Anup in v6, when STRICT_KERNEL_RWX is enabled, we must
>>>> take care of isolating the kernel text and rodata so that they are not
>>>> mapped with a PUD mapping which would then assign wrong permissions to
>>>> the whole region: it is achieved by introducing a new memblock API.
>>>>
>>>> Another patch makes use of this new API in arm64 which used some sort of
>>>> hack to solve this issue: it was built/boot tested successfully.
>>>>
>>>> base-commit-tag: v6.3-rc1
>>>>
>>>> v8:
>>>> - Fix rv32, as reported by Anup
>>>> - Do not modify memblock_isolate_range and fixes comment, as suggested by Mike
>>>> - Use the new memblock API for crash kernel too in arm64, as suggested by Andrew
>>>> - Fix arm64 double mapping (which to me did not work in v7), but ends up not
>>>>    being pretty at all, will wait for comments from arm64 reviewers, but
>>>>    this patch can easily be dropped if they do not want it.
>>>>
>>>> v7:
>>>> - Fix Anup bug report by introducing memblock_isolate_memory which
>>>>    allows us to split the memblock mappings and then avoid to map the
>>>>    the PUD which contains the kernel as read only
>>>> - Add a patch to arm64 to use this newly introduced API
>>>>
>>>> v6:
>>>> - quiet LLVM warning by casting phys_ram_base into an unsigned long
>>>>
>>>> v5:
>>>> - Fix nommu builds by getting rid of riscv_pfn_base in patch 1, thanks
>>>>    Conor
>>>> - Add RB from Andrew
>>>>
>>>> v4:
>>>> - Rebase on top of v6.2-rc3, as noted by Conor
>>>> - Add Acked-by Rob
>>>>
>>>> v3:
>>>> - Change the comment about initrd_start VA conversion so that it fits
>>>>    ARM64 and RISCV64 (and others in the future if needed), as suggested
>>>>    by Rob
>>>>
>>>> v2:
>>>> - Add a comment on why RISCV64 does not need to set initrd_start/end that
>>>>    early in the boot process, as asked by Rob
>>>>
>>>> Alexandre Ghiti (4):
>>>>    riscv: Get rid of riscv_pfn_base variable
>>>>    mm: Introduce memblock_isolate_memory
>>>>    arm64: Make use of memblock_isolate_memory for the linear mapping
>>>>    riscv: Use PUD/P4D/PGD pages for the linear mapping
>>> Kernel boot fine on RV64 but there is a failure which is still not
>>> addressed. You can see this failure as following message in
>>> kernel boot log:
>>>      0.000000] Failed to add a System RAM resource at 80200000
>> Hmmm I don't get that in any of my test configs, would you mind
>> sharing yours and your qemu command line?
> Try alexghiti_test branch at
> https://github.com/avpatel/linux.git
>
> I am building the kernel using defconfig and my rootfs is
> based on busybox.
>
> My QEMU command is:
> qemu-system-riscv64 -M virt -m 512M -nographic -bios
> opensbi/build/platform/generic/firmware/fw_dynamic.bin -kernel
> ./build-riscv64/arch/riscv/boot/Image -append "root=/dev/ram rw
> console=ttyS0 earlycon" -initrd ./rootfs_riscv64.img -smp 4


So splitting memblock.memory is the culprit, it "confuses" the resources 
addition and I can only find hacky ways to fix that...

So given that the arm64 patch with the new API is not pretty and that 
the simplest solution is to re-merge the memblock regions afterwards 
(which is done by memblock_clear_nomap), I'll drop the new API and the 
arm64 patch to use the nomap API like arm64: I'll take advantage of that 
to clean setup_vm_final which I have wanted to do for a long time.

@Mike Thanks for you reviews!

@Anup Thanks for all your bug reports on this patchset, I have to 
improve my test flow (it is in the work :)).


> Regards,
> Anup
>
>> Thanks
>>
>>> Regards,
>>> Anup
>>>
>>>>   arch/arm64/mm/mmu.c           | 25 +++++++++++------
>>>>   arch/riscv/include/asm/page.h | 19 +++++++++++--
>>>>   arch/riscv/mm/init.c          | 53 ++++++++++++++++++++++++++++-------
>>>>   arch/riscv/mm/physaddr.c      | 16 +++++++++++
>>>>   drivers/of/fdt.c              | 11 ++++----
>>>>   include/linux/memblock.h      |  1 +
>>>>   mm/memblock.c                 | 20 +++++++++++++
>>>>   7 files changed, 119 insertions(+), 26 deletions(-)
>>>>
>>>> --
>>>> 2.37.2
>>>>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

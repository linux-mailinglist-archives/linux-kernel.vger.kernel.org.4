Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF02F7080C5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 14:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbjERMJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 08:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbjERMJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 08:09:32 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 864C611B
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 05:09:29 -0700 (PDT)
Received: (Authenticated sender: alex@ghiti.fr)
        by mail.gandi.net (Postfix) with ESMTPSA id E57E9FF802;
        Thu, 18 May 2023 12:09:24 +0000 (UTC)
Message-ID: <fe8d716c-fb4f-1f3f-6c69-de1d8b9fb6af@ghiti.fr>
Date:   Thu, 18 May 2023 14:09:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: Bug report: kernel paniced when system hibernates
To:     Anup Patel <anup@brainfault.org>,
        Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Song Shuai <suagrfillet@gmail.com>, robh@kernel.org,
        Andrew Jones <ajones@ventanamicro.com>, palmer@rivosinc.com,
        jeeheng.sia@starfivetech.com, leyfoon.tan@starfivetech.com,
        mason.huo@starfivetech.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Guo Ren <guoren@kernel.org>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <CAAYs2=gQvkhTeioMmqRDVGjdtNF_vhB+vm_1dHJxPNi75YDQ_Q@mail.gmail.com>
 <CAHVXubgse4Lw7ucg52FkQW4c=QrNo56BXsRZ_nkCHAAPxUXUig@mail.gmail.com>
 <CAHVXubj92O_dwGShOJgrYezqk2pA2NtFyhNFbAPyhn7=PztK6Q@mail.gmail.com>
 <20230517-preacher-primer-f41020b3376a@wendy>
 <CAHVXubhMLgb54_7zV2yFuGPoMKCkUXwozHbDvghc7kQqNLK-JA@mail.gmail.com>
 <CAAhSdy3tKAk1xjinwnSWan0ivdDapcLvSb+hGNynPFZMUsoB9A@mail.gmail.com>
Content-Language: en-US
From:   Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <CAAhSdy3tKAk1xjinwnSWan0ivdDapcLvSb+hGNynPFZMUsoB9A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/18/23 08:53, Anup Patel wrote:
> On Wed, May 17, 2023 at 8:26 PM Alexandre Ghiti <alexghiti@rivosinc.com> wrote:
>> On Wed, May 17, 2023 at 1:28 PM Conor Dooley <conor.dooley@microchip.com> wrote:
>>> Hey Alex,
>>>
>>> On Wed, May 17, 2023 at 10:58:02AM +0200, Alexandre Ghiti wrote:
>>>> On Tue, May 16, 2023 at 1:12 PM Alexandre Ghiti <alexghiti@rivosinc.com> wrote:
>>>>> On Tue, May 16, 2023 at 11:24 AM Song Shuai <suagrfillet@gmail.com> wrote:
>>>>> I actually removed this flag a few years ago, and I have to admit that
>>>>> I need to check if that's necessary: the goal of commit 3335068f8721
>>>>> ("riscv: Use PUD/P4D/PGD pages for the linear mapping") is to expose
>>>>> the "right" start of DRAM so that we can align virtual and physical
>>>>> addresses on a 1GB boundary.
>>>>>
>>>>> So I have to check if a nomap region is actually added as a
>>>>> memblock.memory.regions[] or not: if yes, that's perfect, let's add
>>>>> the nomap attributes to the PMP regions, otherwise, I don't think that
>>>>> is a good solution.
>>>> So here is the current linear mapping without nomap in openSBI:
>>>>
>>>> ---[ Linear mapping ]---
>>>> 0xff60000000000000-0xff60000000200000    0x0000000080000000         2M
>>>> PMD     D A G . . W R V
>>>> 0xff60000000200000-0xff60000000e00000    0x0000000080200000        12M
>>>> PMD     D A G . . . R V
>>>>
>>>> And below the linear mapping with nomap in openSBI:
>>>>
>>>> ---[ Linear mapping ]---
>>>> 0xff60000000080000-0xff60000000200000    0x0000000080080000      1536K
>>>> PTE     D A G . . W R V
>>>> 0xff60000000200000-0xff60000000e00000    0x0000000080200000        12M
>>>> PMD     D A G . . . R V
>>>>
>>>> So adding nomap does not misalign virtual and physical addresses, it
>>>> prevents the usage of 1GB page for this area though, so that's a
>>>> solution, we just lose this 1GB page here.
>>>>
>>>> But even though that may be the fix, I think we also need to fix that
>>>> in the kernel as it would break compatibility with certain versions of
>>>> openSBI *if* we fix openSBI...So here are a few solutions:
>>>>
>>>> 1. we can mark all "mmode_resv" nodes in the device tree as nomap,
>>>> before the linear mapping is established (IIUC, those nodes are added
>>>> by openSBI to advertise PMP regions)
>>>>      -> This amounts to the same fix as opensbi and we lose the 1GB hugepage.
>>> AFAIU, losing the 1 GB hugepage is a regression, which would make this
>>> not an option, right?
>> Not sure this is a real regression, I'd rather avoid it, but as
>> mentioned in my first answer, Mike Rapoport showed that it was making
>> no difference performance-wise...
>>
>>>> 2. we can tweak pfn_is_nosave function to *not* save pfn corresponding
>>>> to PMP regions
>>>>      -> We don't lose the 1GB hugepage \o/
>>>> 3. we can use register_nosave_region() to not save the "mmode_resv"
>>>> regions (x86 does that
>>>> https://elixir.bootlin.com/linux/v6.4-rc1/source/arch/x86/kernel/e820.c#L753)
>>>>      -> We don't lose the 1GB hugepage \o/
>>>> 4. Given JeeHeng pointer to
>>>> https://elixir.bootlin.com/linux/v6.4-rc1/source/kernel/power/snapshot.c#L1340,
>>>> we can mark those pages as non-readable and make the hibernation
>>>> process not save those pages
>>>>      -> Very late-in-the-day idea, not sure what it's worth, we also
>>>> lose the 1GB hugepage...
>>> Ditto here re: introducing another regression.
>>>
>>>> To me, the best solution is 3 as it would prepare for other similar
>>>> issues later, it is similar to x86 and it allows us to keep 1GB
>>>> hugepages.
>>>>
>>>> I have been thinking, and to me nomap does not provide anything since
>>>> the kernel should not address this memory range, so if it does, we
>>>> must fix the kernel.
>>>>
>>>> Let me know what you all think, I'll be preparing a PoC of 3 in the meantime!
>>> #3 would probably get my vote too. It seems like you could use it
>>> dynamically if there was to be a future other provider of "mmode_resv"
>>> regions, rather than doing something location-specific.
>>>
>>> We should probably document these opensbi reserved memory nodes though
>>> in a dt-binding or w/e if we are going to be relying on them to not
>>> crash!
> Depending on a particular node name is fragile. If we really need
> information from DT then I suggest adding "no-save-restore" DT
> property in reserved memory nodes.


I understand your point, the node name is the only thing I found that 
would work with current opensbi: any other idea what we could use instead?


>> Yes, you're right, let's see what Atish and Anup think!
> I think we have two possible approaches:
>
> 1) Update OpenSBI to set "no-map" DT property for firmware
>      reserved regions. We were doing this previously but removed
>      it later for performance reasons mentioned by Alex. It is also
>      worth mentioning that ARM Trusted Firmware also sets "no-map"
>      DT property for firmware reserved regions.
>
> 2) Add a new "no-save-restore" DT property in the reserved
>      memory DT bindings. The hibernate support of Linux arch/riscv
>      will use this DT property to exclude memory regions from
>      save-restore. The EFI implementation of EDK2 and U-Boot
>      should do the following:
>      1) Treat all memory having "no-map" DT property as EFI
>          reserved memory
>      2) Treat all memory not having "no-map" DT property and
>          not having "no-save-restore" DT property as EfiBootServicesData
>      3) Treat all memory not having "no-map" DT property and
>           having "no-save-restore" DT property as EfiRuntimeServiceData
>           (Refer,
> https://devicetree-specification.readthedocs.io/en/latest/chapter3-devicenodes.html#reserved-memory-and-uefi)
>
> Personally, I am leaning towards approach#1 since approach#2
> will require changing DeviceTree specification as well.


If needed, indeed #1 is the simplest, but I insist, to me it is not 
needed (and we don't have it in the current opensbi), if you have 
another opinion, I'm open to discuss it!

Thanks for your quick answer Anup,

Alex


>
> Regards,
> Anup
>
>> Thanks for your quick answers Conor and Song, really appreciated!
>>
>> Alex
>>
>>> Thanks for working on this,
>>> Conor.
>>>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

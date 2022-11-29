Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01EA263B97E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 06:33:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235330AbiK2Fda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 00:33:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235244AbiK2Fd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 00:33:27 -0500
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE3627CE1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 21:33:24 -0800 (PST)
Received: (Authenticated sender: alex@ghiti.fr)
        by mail.gandi.net (Postfix) with ESMTPSA id 8B4EB240003;
        Tue, 29 Nov 2022 05:33:20 +0000 (UTC)
Message-ID: <66e549e8-897b-bfb8-e51d-29a510163dc8@ghiti.fr>
Date:   Tue, 29 Nov 2022 06:33:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] riscv: head: use 0 as the default text_offset
Content-Language: en-US
To:     Samuel Holland <samuel@sholland.org>,
        Atish Kumar Patra <atishp@rivosinc.com>,
        Jisheng Zhang <jszhang@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221128152442.3403-1-jszhang@kernel.org>
 <CAHBxVyHg0fU9msnV4vgp4oK6aZZv+nc9mFTbTRjHNsgJAG0eyg@mail.gmail.com>
 <e39851df-251d-662d-3319-af9d948a9430@sholland.org>
From:   Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <e39851df-251d-662d-3319-af9d948a9430@sholland.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/22 06:04, Samuel Holland wrote:
> On 11/28/22 14:11, Atish Kumar Patra wrote:
>> On Mon, Nov 28, 2022 at 7:34 AM Jisheng Zhang <jszhang@kernel.org> wrote:
>>> Commit 0f327f2aaad6 ("RISC-V: Add an Image header that boot loader can
>>> parse.") adds an image header which "is based on ARM64 boot image
>>> header and provides an opportunity to combine both ARM64 & RISC-V
>>> image headers in future.". At that time, arm64's default text_offset
>>> is 0x80000, this is to give "512 KB of guaranteed BSS space to put
>>> the swapper page tables" as commit cfa7ede20f13 ("arm64: set TEXT_OFFSET
>>> to 0x0 in preparation for removing it entirely") pointed out, but
>>> riscv doesn't need the space, so use 0 as the default text_offset.
>>>
>>> Before this patch, booting linux kernel on Sipeed bl808 M1s Dock
>>> with u-boot booti cmd:
>>> [    0.000000] OF: fdt: Ignoring memory range 0x50000000 - 0x50200000
>>> ...
>>> [    0.000000]   DMA32    [mem 0x0000000050200000-0x0000000053ffffff]
>>> As can be seen, 2MB DDR(0x50000000 - 0x501fffff) can't be used by
>>> linux.
>>>
>>> After this patch, the 64MB DDR is fully usable by linux
>>> [    0.000000]   DMA32    [mem 0x0000000050000000-0x0000000053ffffff]
>>>
>>> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
>>> ---
>>>   arch/riscv/kernel/head.S | 12 +-----------
>>>   1 file changed, 1 insertion(+), 11 deletions(-)
>>>
>>> diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
>>> index b865046e4dbb..ef95943f7a70 100644
>>> --- a/arch/riscv/kernel/head.S
>>> +++ b/arch/riscv/kernel/head.S
>>> @@ -38,18 +38,8 @@ ENTRY(_start)
>>>          .word 0
>>>   #endif
>>>          .balign 8
>>> -#ifdef CONFIG_RISCV_M_MODE
>>> -       /* Image load offset (0MB) from start of RAM for M-mode */
>>> +       /* Image load offset (0MB) from start of RAM */
>>>          .dword 0
>>> -#else
>>> -#if __riscv_xlen == 64
>>> -       /* Image load offset(2MB) from start of RAM */
>>> -       .dword 0x200000
>>> -#else
>>> -       /* Image load offset(4MB) from start of RAM */
>>> -       .dword 0x400000
>>> -#endif
>>> -#endif
>> NACK.
>> RV64 needs to boot at a 2MB aligned address and RV32 needs to boot at
>> a 4MB aligned address.
>> The firmware is assumed to live at the start of DRAM for Linux running
>> in S-mode.
> What needs to happen so we can stop making this assumption? If the SBI
> implementation wants to reserve memory, it should use the devicetree to
> do so. OpenSBI already does this.
>
> Throwing away 2 MiB of RAM is quite wasteful considering we have
> multiple SoCs (D1s, BL808) that are limited to 64 MiB of in-package RAM.


Actually OpenSBI needs less than 2MB of memory (512KB IIRC), and its 
size is marked in the DT. But in practice, it is the memblock subsystem 
that removes any memory below the 2MB offset because __pa translation is 
"invalid" before setup_vm_final. So we can retrieve 1.5MB by simply 
redefining MIN_MEMBLOCK_ADDR, have a look at 
https://patchwork.kernel.org/project/linux-riscv/patch/20221122084141.1849421-1-alexghiti@rivosinc.com/


>
> Regards,
> Samuel
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27A05716440
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 16:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232602AbjE3Odz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 10:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbjE3Odx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 10:33:53 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684888F
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 07:33:50 -0700 (PDT)
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 67A73240007;
        Tue, 30 May 2023 14:33:45 +0000 (UTC)
Message-ID: <92d4aaa8-a1ed-74e1-3a22-df9be1ca1e4a@ghiti.fr>
Date:   Tue, 30 May 2023 16:33:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH -fixes] riscv: Fix relocatable kernels with early
 alternatives using -fno-pie
Content-Language: en-US
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Conor Dooley <conor@kernel.org>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andreas Schwab <schwab@linux-m68k.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230526-rockfish-moody-f6d3e71f9d24@spud>
 <f6522c82-01bd-8a03-579d-a5b294784480@ghiti.fr>
 <20230527-hyperlink-doctrine-ef22cfcb508a@spud>
 <CAHVXubgx3uBEjMLHXTxr0192ZHbSb=qK4NggZyWQTDfgrJt2-g@mail.gmail.com>
 <20230528-darkness-grandly-6cb9e014391d@spud>
 <cf0d2d2a-c407-7b3d-a5ab-ea5c19e7b890@ghiti.fr>
 <20230528-uneatable-earpiece-3f8673548863@spud>
 <b71dc2f5-fdc0-2a8d-e1f9-696cd9a1529e@ghiti.fr>
 <20230529-skillet-quarters-3fbc3b6edb3a@spud>
 <41e57bb9-ce0c-7772-abeb-5c01d5ec19bb@ghiti.fr>
 <20230530-polka-trifle-7ccd7a093099@wendy>
From:   Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20230530-polka-trifle-7ccd7a093099@wendy>
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


On 30/05/2023 13:27, Conor Dooley wrote:
> On Mon, May 29, 2023 at 09:37:28PM +0200, Alexandre Ghiti wrote:
>> On 29/05/2023 21:06, Conor Dooley wrote:
>>> On Mon, May 29, 2023 at 08:51:57PM +0200, Alexandre Ghiti wrote:
>>>> On 28/05/2023 15:56, Conor Dooley wrote:
>>>>> On Sun, May 28, 2023 at 03:42:59PM +0200, Alexandre Ghiti wrote:
>>>>>> Hmmm, it still works for me with both clang and gcc-9.
>>>>> gcc-9 is a bit of a relic, do you have more recent compilers lying
>>>>> around? If not, I can try some older compilers at some point.
>>>>>
>>>>>> You don't have to do that now but is there a way I could get your compiled
>>>>>> image? With the sha1 used to build it? Sorry, I don't see what happens, I
>>>>>> need to get my hands dirty in some debug!
>>>>> What do you mean by "sha1"? It falls with v6.4-rc1 which is a stable
>>>>> hash, if that's what you're looking for.
>>>>>
>>>>> Otherwise,
>>>>> https://github.com/ConchuOD/riscv-env/releases/download/v2022.03/vmlinux.bin
>>>>> (ignore the release crap haha, too lazy to find a proper hosting
>>>>> mechanism)
>>>> Ok, I don't get much info without the symbols, can you also provide the
>>>> vmlinux please? But at least your image does not boot, not during the early
>>>> boot though because the mmu is enabled.
>>> Do you see anything print when you try it? Cos I do not. Iff I have time
>>> tomorrow, I'll go poking with gdb. I'm sorry I have not really done any
>>> investigating, I have been really busy this last week or so with
>>> dt-binding stuff but I should be freer again from tomorrow.
>>>
>>> https://github.com/ConchuOD/riscv-env/releases/download/v2022.03/vmlinux
>>
>> Better, the trap happens in kasan_early_init() when it tries to access a
>> global symbol using the GOT but ends up with a NULL pointer, which is weird.
>> So to me, this is not related to kasan, it happens that kasan_early_init()
>> is the first function called after enabling the mmu, I think you may have an
>> issue with the filling of the relocations.
> Yeah, it reproduces without KASAN.
>
>> Sorry to bother you again, but if
>> at some point you can recompile with DEBUG_INFO enabled, that would be
>> perfect! And also provide the vmlinux.relocs file. Sorry for all that, too
>> bad I can't reproduce it.
> New vmlinux & vmlinux.relocs here:
> https://microchiptechnology-my.sharepoint.com/:u:/g/personal/conor_dooley_microchip_com/EZpFNxYYrnNAh5Z3c-rf0pUBBpdPGTLafqdtfcXRUUBkXw?e=7KKMHX
> They're pretty massive unfortunately & hopefully that is not some
> garbage internal-only link.
> .config is a wee bit different, cos different build machine, but the
> problem still manifests on a icicle. I've added it to the tarball just
> in case.


Ok so I had to recreate the Image from the files you gave me and it 
boots fine using qemu: is that expected? Because you only mention the 
icicle above.


[    0.000000] Linux version 6.4.0-rc1 (conor@wendy) (ClangBuiltLinux 
clang version 15.0.7 (/home/conor/stuff/dev/llvm/clang 
8dfdcc7b7bf66834a761bd8de445840ef68e4d1a), ClangBuiltLinux LLD 15.0.7) 
#1 SMP PREEMPT Tue May 30 12:13:12 IST 2023
[    0.000000] random: crng init done
[    0.000000] Machine model: riscv-virtio,qemu
[    0.000000] earlycon: ns16550a0 at MMIO 0x0000000010000000 (options '')
[    0.000000] printk: bootconsole [ns16550a0] enabled
[    0.000000] printk: debug: skip boot console de-registration.
[    0.000000] efi: UEFI not found.
[    0.000000] OF: reserved mem: 0x0000000080000000..0x000000008003ffff 
(256 KiB) map non-reusable mmode_resv0@80000000
[    0.000000] Zone ranges:
[    0.000000]   DMA32    [mem 0x0000000080000000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x000000017fffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000080000000-0x000000017fffffff]
[    0.000000] Initmem setup node 0 [mem 
0x0000000080000000-0x000000017fffffff]
[    0.000000] SBI specification v1.0 detected
[    0.000000] SBI implementation ID=0x1 Version=0x10002
[    0.000000] SBI TIME extension detected
[    0.000000] SBI IPI extension detected
[    0.000000] SBI RFENCE extension detected
[    0.000000] SBI SRST extension detected
[    0.000000] SBI HSM extension detected
[    0.000000] riscv: base ISA extensions acdfhim
[    0.000000] riscv: ELF capabilities acdfim
[    0.000000] percpu: Embedded 30 pages/cpu s83872 r8192 d30816 u122880
[    0.000000] Kernel command line: earlycon keep_bootcon 
root=/dev/mmcblk1p2 rootdelay=10 reboot=cold
[    0.000000] Dentry cache hash table entries: 524288 (order: 10, 
4194304 bytes, linear)
[    0.000000] Inode-cache hash table entries: 262144 (order: 9, 2097152 
bytes, linear)
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 
1034240
[    0.000000] mem auto-init: stack:all(zero), heap alloc:off, heap free:off

...


>>>> I tried with gcc-12 and it still works fine on my end, so frustrating!
>>> Crap! Also, should you not be enjoying a public holiday rather than
>>> debugging?! Or maybe debugging is enjoyable for you...
>>
>> Ahah, this is what I enjoy doing when the kids finally sleep :)
>>
>>
>> Thank you again for your very quick feedback, really appreciated!
> No worries.
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

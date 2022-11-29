Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 244E163C739
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 19:33:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235985AbiK2Sdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 13:33:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233627AbiK2Sdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 13:33:44 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9027A46673
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 10:33:42 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so18183955pjc.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 10:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jwJ2nOuM+CQrLsIwAyVS8nkHIs06BNqyXkXaQ5c6INA=;
        b=CyXWJ6t0zwpSxLJPykrAUbQ7Eg1BPKl+Qv/qN+0O3SU9Bslrt9YkzG+rwhSdlj6PI6
         AQcpJdrOKj2vRWQ5ds1mNR+0VHh0rSLnacPfFIxa0SvhjlG4j0F811sKrVNFXBGIRS8H
         UFziVWluP8RFPNbAsNng6TwWolCUY+3i3/HoeFpgWtJ8lUtciXfZDkMrmmRkRm2W/GA5
         Ck868NUEYQ9ASMaUrOem07jmmrUg0dIDWsm9kmyvFY/G8osPB0tHBac2R03nbTZVZhBI
         XQ3RbwVpxGZgtFQnqfa5JTFMbrqv8y+V8GD2HwfDu4F4QhkxudfepAq/AJSYwbowkisV
         +F3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jwJ2nOuM+CQrLsIwAyVS8nkHIs06BNqyXkXaQ5c6INA=;
        b=GMBjY6ObXISm81faqSQJx9fYzY5qq7IeUe7zAVFtsqJBUNqXP3L4bF6vB0m7pfjVkl
         ZXih9d/++PD6zIS6x+Cce7+VAPB3AucrRYQW0olx4Qs/cRJYFF6RTXgbkLss0DDAu5R8
         r9ZnwddtpRFx/4br31ptDSvQacK7/vkNd7dti8OZ4W+e1S603aZbVcv+mwa4HpgBLZGs
         yji5qUETkvf7WUukEAFvy6Ck0lQWuLV7sAIalqQv8bxEg5aCUM/AbSl8XB5TztO7Czzo
         T5NDmovLlAuuGSG1zWFnMoE2z9XvgCrvQCr83SuVY3Y4DjSAw1IGuUtnaa1j9nCSfm7M
         XDQQ==
X-Gm-Message-State: ANoB5plWtIOrU1J6mnB3U4hgmK1n2yR6BPvCw3x2ZTNqazjHV6vkfwlt
        uVL8lqixiugIQhyIfwqLhqMzNUdbRbD91w==
X-Google-Smtp-Source: AA0mqf7Pvqnm0eRQZ+TRwvBnVQfWSpI1p78aWHa3Dae+XlKRQPFehjddbLmaLMXhBg2c31N07LmCAw==
X-Received: by 2002:a17:90b:3c0a:b0:212:510b:5851 with SMTP id pb10-20020a17090b3c0a00b00212510b5851mr59756985pjb.57.1669746821759;
        Tue, 29 Nov 2022 10:33:41 -0800 (PST)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id 17-20020a170902c11100b0017a032d7ae4sm11180525pli.104.2022.11.29.10.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 10:33:41 -0800 (PST)
Date:   Tue, 29 Nov 2022 10:33:41 -0800 (PST)
X-Google-Original-Date: Tue, 29 Nov 2022 10:33:32 PST (-0800)
Subject:     Re: [PATCH] riscv: head: use 0 as the default text_offset
In-Reply-To: <d79d85c2-8457-9b0e-6460-089cf91dd425@sholland.org>
CC:     Atish Patra <atishp@rivosinc.com>, jszhang@kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     samuel@sholland.org
Message-ID: <mhng-cdf572b0-b9a3-4ace-8e2b-0c4046235068@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Nov 2022 22:55:24 PST (-0800), samuel@sholland.org wrote:
> On 11/29/22 00:19, Palmer Dabbelt wrote:
>> On Mon, 28 Nov 2022 21:04:48 PST (-0800), samuel@sholland.org wrote:
>>> On 11/28/22 14:11, Atish Kumar Patra wrote:
>>>> On Mon, Nov 28, 2022 at 7:34 AM Jisheng Zhang <jszhang@kernel.org>
>>>> wrote:
>>>>>
>>>>> Commit 0f327f2aaad6 ("RISC-V: Add an Image header that boot loader can
>>>>> parse.") adds an image header which "is based on ARM64 boot image
>>>>> header and provides an opportunity to combine both ARM64 & RISC-V
>>>>> image headers in future.". At that time, arm64's default text_offset
>>>>> is 0x80000, this is to give "512 KB of guaranteed BSS space to put
>>>>> the swapper page tables" as commit cfa7ede20f13 ("arm64: set
>>>>> TEXT_OFFSET
>>>>> to 0x0 in preparation for removing it entirely") pointed out, but
>>>>> riscv doesn't need the space, so use 0 as the default text_offset.
>>>>>
>>>>> Before this patch, booting linux kernel on Sipeed bl808 M1s Dock
>>>>> with u-boot booti cmd:
>>>>> [    0.000000] OF: fdt: Ignoring memory range 0x50000000 - 0x50200000
>>>>> ...
>>>>> [    0.000000]   DMA32    [mem 0x0000000050200000-0x0000000053ffffff]
>>>>> As can be seen, 2MB DDR(0x50000000 - 0x501fffff) can't be used by
>>>>> linux.
>>>>>
>>>>> After this patch, the 64MB DDR is fully usable by linux
>>>>> [    0.000000]   DMA32    [mem 0x0000000050000000-0x0000000053ffffff]
>>>>>
>>>>> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
>>>>> ---
>>>>>  arch/riscv/kernel/head.S | 12 +-----------
>>>>>  1 file changed, 1 insertion(+), 11 deletions(-)
>>>>>
>>>>> diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
>>>>> index b865046e4dbb..ef95943f7a70 100644
>>>>> --- a/arch/riscv/kernel/head.S
>>>>> +++ b/arch/riscv/kernel/head.S
>>>>> @@ -38,18 +38,8 @@ ENTRY(_start)
>>>>>         .word 0
>>>>>  #endif
>>>>>         .balign 8
>>>>> -#ifdef CONFIG_RISCV_M_MODE
>>>>> -       /* Image load offset (0MB) from start of RAM for M-mode */
>>>>> +       /* Image load offset (0MB) from start of RAM */
>>>>>         .dword 0
>>>>> -#else
>>>>> -#if __riscv_xlen == 64
>>>>> -       /* Image load offset(2MB) from start of RAM */
>>>>> -       .dword 0x200000
>>>>> -#else
>>>>> -       /* Image load offset(4MB) from start of RAM */
>>>>> -       .dword 0x400000
>>>>> -#endif
>>>>> -#endif
>>>>
>>>> NACK.
>>>> RV64 needs to boot at a 2MB aligned address and RV32 needs to boot at
>>>> a 4MB aligned address.
>>>> The firmware is assumed to live at the start of DRAM for Linux running
>>>> in S-mode.
>>>
>>> What needs to happen so we can stop making this assumption? If the SBI
>>> implementation wants to reserve memory, it should use the devicetree to
>>> do so. OpenSBI already does this.
>>
>> IMO we've really screwed up the boot flow on RISC-V.  Having Linux
>> reserve space for the firmware is just all backwards, Linux can't know
>> how much memory the firmware needs (which manifests under large hart
>> counts in OpenSBI, for example).  Unfortunately there's no specification
>> that defines these platform-level details, so we're stuck depending on 
>> unspecified behavior like this.
>>
>> I think we could fix this by either making Linux's early boot relocation
>> code work sanely (fix whatever bugs are there, document what can't be
>> fixed, and then add some sort of Image flag to tell firmware the kernel
>> can be relocated) or relying on relocatable firmware, but both of those
>> come with some costs ...
>
> It sounds like Alexandre's patch[1] lets us use memory below this
> offset, so we don't have to relocate the kernel to the beginning of RAM.
> In fact, we could even increase the offset if we are concerned about the
> kernel link address conflicting with the SBI implementation.
>
> [1]:
> https://patchwork.kernel.org/project/linux-riscv/patch/20221122084141.1849421-1-alexghiti@rivosinc.com/
>
>>> Throwing away 2 MiB of RAM is quite wasteful considering we have
>>> multiple SoCs (D1s, BL808) that are limited to 64 MiB of in-package RAM.
>>
>> ... and I'd argue that users on systems don't want to pay those costs. 
>
> What does fixing the early relocation code cost? Just longer boot time?
> If the bootloader takes care of avoiding reserved-memory regions, and
> Linux can run from wherever it gets loaded, that would be ideal to me.

There's a runtime cost to either the relocatable kernel or firmware, 
but if those VA tricks are enough to make it work then it's pretty much 
free in terms of performance -- I think we'd even be able to avoid 
copying the kernel image around if the bootloader aligns it properly?

>> In fact, I'd argue that systems like that don't want resident firmware
>> at all.
>
> I would much rather pay 256 KiB for resident firmware than reimplement
> all of the power management and PMU logic in Linux. It's not as bad as
> losing 2 MiB when I know most of that is unused.

OK, sounds like just having the firmware accurately report the memory it 
needs to Linux and then reclaiming whatever's left in that 2MiB region 
is sufficient here?  That's way easier.

>> So let's just add a CONFIG_SBI=n, and then just use direct drivers for
>> everything.  If the firmware doesn't need to be resident then it's
>> pretty straight-forward to support these 0 offsets, so we can just add
>> that as another Kconfig.  Sure this will trip up firmware that depends
>> on these fixed reservations, but saying "the resident firmware fits in 0
>> superpages" is just as much of a platform-specific dependency as saying
>> "the resident firmware fits in 1 superpage".  If firmware can't handle
>> this field in the Image format then we're going to end up with breakages
>> at some point, it might as well be now.
>>
>> If these systems don't have all the ISA bits necessary to avoid M-mode
>> entirely then we can just implement a tiny M-mode stub in Linux that
>> gets left around during early boot and then shims stuff to S-mode. 
>> That'll be a bit of a headache and with some extensions it can be
>> avoided, the standard stuff won't allow for that until the latest round
>> of specs is done but if it's possible via whatever custom extensions are
>> in these things then that's probably the way to go.
>
> I don't think Linux has a choice here, when started in S-mode. And
> neither does the bootloader parsing the Image, because it most likely
> runs in S-mode as well.

I think there's some options here, but I guess we can leave that up to 
someone who wants the feature ;)

> And when started in M-mode, we already don't use SBI.
>
> Regards,
> Samuel

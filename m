Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFDB8691159
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 20:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbjBITaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 14:30:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjBITaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 14:30:19 -0500
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1E4EE;
        Thu,  9 Feb 2023 11:30:17 -0800 (PST)
Received: (Authenticated sender: alex@ghiti.fr)
        by mail.gandi.net (Postfix) with ESMTPSA id 0D99440008;
        Thu,  9 Feb 2023 19:30:13 +0000 (UTC)
Message-ID: <7ae60bca-5cc0-6cc6-f68a-b48c0b43388b@ghiti.fr>
Date:   Thu, 9 Feb 2023 20:30:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] riscv: Bump COMMAND_LINE_SIZE value to 1024
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>, macro@orcam.me.uk,
        david.abdurachmanov@gmail.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-api@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <mhng-9e6b4607-6bea-411c-b843-916c1e0798ee@palmerdabbelt-glaptop>
 <182c1d4e-a117-79d6-4dd1-8e3c8a447b4a@ghiti.fr>
 <CACT4Y+YYAfTafFk7DE0B=qQFgkPXS7492AhBdY_CP1WdB8CGfA@mail.gmail.com>
 <CACT4Y+Y1s2iE3OF8WHwb7F2crRjgnFCWQfoFvs3d-KgHpMLeKg@mail.gmail.com>
Content-Language: fr
From:   Alex Ghiti <alex@ghiti.fr>
In-Reply-To: <CACT4Y+Y1s2iE3OF8WHwb7F2crRjgnFCWQfoFvs3d-KgHpMLeKg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 9/02/2023 à 12:37, Dmitry Vyukov a écrit :
> On Thu, 10 Nov 2022 at 22:01, Dmitry Vyukov <dvyukov@google.com> wrote:
>>
>> On Mon, 21 Jun 2021 at 00:11, Alex Ghiti <alex@ghiti.fr> wrote:
>>>
>>> Hi Palmer,
>>>
>>> Le 23/04/2021 à 04:57, Palmer Dabbelt a écrit :
>>>> On Fri, 02 Apr 2021 11:33:30 PDT (-0700), macro@orcam.me.uk wrote:
>>>>> On Fri, 2 Apr 2021, David Abdurachmanov wrote:
>>>>>
>>>>>>>>>   This macro is exported as a part of the user API so it must
>>>>>> not depend on
>>>>>>>>> Kconfig.  Also changing it (rather than say adding
>>>>>> COMMAND_LINE_SIZE_V2 or
>>>>>>>>> switching to an entirely new data object that has its dimension
>>>>>> set in a
>>>>>>>>> different way) requires careful evaluation as external binaries
>>>>>> have and
>>>>>>>>> will have the value it expands to compiled in, so it's a part
>>>>>> of the ABI
>>>>>>>>> too.
>>>>>>>>
>>>>>>>> Thanks, I didn't realize this was part of the user BI.  In that
>>>>>> case we
>>>>>>>> really can't chage it, so we'll have to sort out some other way
>>>>>> do fix
>>>>>>>> whatever is going on.
>>>>>>>>
>>>>>>>> I've dropped this from fixes.
>>>>>>>
>>>>>>> Does increasing COMMAND_LINE_SIZE break user-space binaries? I would
>>>>>>> expect it to work the same way as adding new enum values, or adding
>>>>>>> fields at the end of versioned structs, etc.
>>>>>>> I would assume the old bootloaders/etc will only support up to the
>>>>>>> old, smaller max command line size, while the kernel will support
>>>>>>> larger command line size, which is fine.
>>>>>>> However, if something copies /proc/cmdline into a fixed-size buffer
>>>>>>> and expects that to work, that will break... that's quite unfortunate
>>>>>>> user-space code... is it what we afraid of?
>>>>>>>
>>>>>>> Alternatively, could expose the same COMMAND_LINE_SIZE, but internally
>>>>>>> support a larger command line?
>>>>>>
>>>>>> Looking at kernel commit history I see PowerPC switched from 512 to
>>>>>> 2048, and I don't see complaints about the ABI on the mailing list.
>>>>>>
>>>>>> If COMMAND_LINE_SIZE is used by user space applications and we
>>>>>> increase it there shouldn't be problems. I would expect things to
>>>>>> work, but just get truncated boot args? That is the application will
>>>>>> continue only to look at the initial 512 chars.
>>>>>
>>>>>   The macro is in an include/uapi header, so it's exported to the userland
>>>>> and a part of the user API.  I don't know what the consequences are for
>>>>> the RISC-V port specifically, but it has raised my attention, and I think
>>>>> it has to be investigated.
>>>>>
>>>>>   Perhaps it's OK to change it after all, but you'd have to go through
>>>>> known/potential users of this macro.  I guess there shouldn't be that
>>>>> many
>>>>> of them.
>>>>>
>>>>>   In any case it cannot depend on Kconfig, because the userland won't have
>>>>> access to the configuration, and then presumably wants to handle any and
>>>>> all.
>>>>
>>>> It kind of feels to me like COMMAND_LINE_SIZE shouldn't have been part
>>>> of the UABI to begin with.  I sent a patch to remove it from the
>>>> asm-generic UABI, let's see if anyone knows of a reason it should be UABI:
>>>>
>>>> https://lore.kernel.org/linux-arch/20210423025545.313965-1-palmer@dabbelt.com/T/#u
>>>
>>> Arnd seemed to agree with you about removing COMMAND_LINE_SIZE from the
>>> UABI, any progress on your side?
>>
>> Was this ever merged? Don't see this even in linux-next.
> 
> Ping. Still an issue at least for syzbot.

Yes, agreed, Palmer proposed the following instead since blindly 
increasing the command line size would break userspace ABI: 
https://lore.kernel.org/lkml/20221211061358.28035-1-palmer@rivosinc.com/T/

I will bump this thread to make progress, thanks for the ping.

Alex

> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

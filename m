Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00C026022C1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 05:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbiJRDik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 23:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiJRDh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 23:37:58 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126FD26129
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 20:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1666063780; bh=Nsjx7HBFdQ0PfKSORxy+GK4HHujeOaw7K/qEJvRNjDk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=tk/mE1T2UqlKlO0m0RjMedDu0q4aSjzLg9ZnUPP8W4ch54CYqZ/zIzpIl6rhi0gkT
         UkMUTEUZG+PUwcINFgdnof+cxfS2LdGB5khqwLMAy0R6IbB+yG/DoL1QoTG7nrPU6B
         bBxuZQ6BLgDFn83gnTEMHXeTuRzm+XG8QQ0jDlm4=
Received: from [100.100.57.122] (unknown [220.248.53.61])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id DC17E60087;
        Tue, 18 Oct 2022 11:29:39 +0800 (CST)
Message-ID: <c34a277a-1735-65e6-c97d-fcc2ac3d57e6@xen0n.name>
Date:   Tue, 18 Oct 2022 11:29:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:107.0)
 Gecko/20100101 Thunderbird/107.0a1
Subject: Re: [PATCH V2] LoongArch: Add unaligned access support
To:     Huacai Chen <chenhuacai@kernel.org>,
        David Laight <David.Laight@aculab.com>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Guo Ren <guoren@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20221017022330.2383060-1-chenhuacai@loongson.cn>
 <b8792b1a71754d6eb88debe4d6c2c419@AcuMS.aculab.com>
 <CAAhV-H5WM97+Um9ULjv7gT3i5pJ3GfQ8ex6NRNr6uzmMgdVY_Q@mail.gmail.com>
Content-Language: en-US
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <CAAhV-H5WM97+Um9ULjv7gT3i5pJ3GfQ8ex6NRNr6uzmMgdVY_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/10/18 10:24, Huacai Chen wrote:
> Hi, David,
> 
> On Mon, Oct 17, 2022 at 8:58 PM David Laight <David.Laight@aculab.com> wrote:
>>
>> From: Huacai Chen
>>> Sent: 17 October 2022 03:24
>>>
>>> Loongson-2 series (Loongson-2K500, Loongson-2K1000) don't support
>>> unaligned access in hardware, while Loongson-3 series (Loongson-3A5000,
>>> Loongson-3C5000) are configurable whether support unaligned access in
>>> hardware. This patch add unaligned access emulation for those LoongArch
>>> processors without hardware support.
>>>
>> ...
>>> +     /*
>>> +      * This load never faults.
>>> +      */
>>> +     __get_inst(&insn.word, pc, user);
>>
>> On what basis does it never fault?
>> Any user access can fault.
>> If nothing else another thread of the process can unmap
>> the page.
> Yes, this can happen, since __get_inst() handles fault, we can just
> remove the comment.
> 
>>
>>> +     if (user && !access_ok(addr, 8))
>>> +             goto sigbus;
>>
>> Surely that is technically wrong - a two or four byte
>> access is valid right at the end of valid user addreeses.
> Yes, this check should be moved to each case.
> 
>>
>>> +
>>> +     if (insn.reg2i12_format.opcode == ldd_op ||
>>> +             insn.reg2i14_format.opcode == ldptrd_op ||
>>> +             insn.reg3_format.opcode == ldxd_op) {
>>> +             res = unaligned_read(addr, &value, 8, 1);
>>
>> That is the most horrid indentation of long lines I've
>> ever seen.
>> I'd also guess you can common up some of this code
>> by looking at the instruction field that include the
>> transfer width.
>>
>> The long elsif list will generate horrid code.
>> But maybe since you've just taken a fault it really
>> doesn't matter.
>> Indeed just emulating in C using byte accesses
>> it probably fine.
> I want to keep the assembly, because we can use more efficient methods
> with the upcoming alternative mechanism.

What about my more structured approach in another reply that avoids the 
huge else-if conditions? Both the terrible line wraps and codegen could 
be avoided.

-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/


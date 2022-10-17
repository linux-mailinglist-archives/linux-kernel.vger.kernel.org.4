Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E62860084F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 10:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiJQIFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 04:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiJQIFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 04:05:48 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C933D6587
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 01:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1665993944; bh=rbLjBNdrdjtEGr4opnMLT4SrOV8FV9W/7+iLBbcBYx8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=v7ACNPAWfsoEbl/PxgLTT89p4Znwh8KyR4/t3PAS8AsS4O5/nSOyeXqYYIIYeVsrR
         YxIvyN08wEHNlt1rztxeW8CwzUklJdyMlx/UEYBH4LlPMnsPyxONBstMHmf8wSst3q
         hROZIxb2rc+fwjHnRk2z/tHxFiF5GZzL0KxaCRbY=
Received: from [100.100.57.122] (unknown [220.248.53.61])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 281BD600B5;
        Mon, 17 Oct 2022 16:05:44 +0800 (CST)
Message-ID: <52ada3c4-f4f2-dc27-5899-d29e5952189d@xen0n.name>
Date:   Mon, 17 Oct 2022 16:05:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:107.0)
 Gecko/20100101 Thunderbird/107.0a1
Subject: Re: [PATCH] LoongArch: Add unaligned access support
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>, loongarch@lists.linux.dev,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        guoren <guoren@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org
References: <20221016133418.2122777-1-chenhuacai@loongson.cn>
 <506fe4e5-a203-48e6-84a6-f70133be15dd@app.fastmail.com>
 <CAAhV-H7UJDgtY4NfF7-5+TbNEbec7XOpvS87H=fPad4KK0KLaw@mail.gmail.com>
 <b97afda4-143c-46d2-a6af-dd6a700472ec@app.fastmail.com>
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <b97afda4-143c-46d2-a6af-dd6a700472ec@app.fastmail.com>
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

Hi,

Just my 2c...

On 2022/10/17 15:38, Arnd Bergmann wrote:
> On Mon, Oct 17, 2022, at 9:31 AM, Huacai Chen wrote:
>> Hi, Arnd,
>>
>> On Mon, Oct 17, 2022 at 3:12 PM Arnd Bergmann <arnd@arndb.de> wrote:
>>>
>>> On Sun, Oct 16, 2022, at 3:34 PM, Huacai Chen wrote:
>>>> Loongson-2 series (Loongson-2K500, Loongson-2K1000) don't support
>>>> unaligned access in hardware, while Loongson-3 series (Loongson-3A5000,
>>>> Loongson-3C5000) are configurable whether support unaligned access in
>>>> hardware. This patch add unaligned access emulation for those LoongArch
>>>> processors without hardware support.
>>>>
>>>> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
>>>
>>> What does the Loongarch ELF ABI say about this? On most architectures,
>>> C compilers are not allowed to produce unaligned accesses for standard
>>> compliant source code, the only way you'd get this is when casting
>>> a an unaligned (e.g. char*) pointer to another type with higher alignment
>>> requirement.
>> Some unaligned accesses are observed from the kernel network stack, it
>> seems related to whether the packet aligns to IP header or MAC header.
> 
> This is usually a bug in the device driver. It's a fairly common bug
> since the network driver has to ensure the alignment is correct, but
> it's usually fixable, and fixing it results in better performance on
> machines that support unaligned access as well.
> 
> Which driver did you observe this with?

I agree with Arnd that it's probably better to fix the drivers. Having 
the debug feature would help, but in the end it's still the drivers that 
should get the fix. For example I have previously fixed one such 
unaligned access in iwlwifi when I was tinkering with a Loongson 3A4000, 
it was pretty easy to spot with the right perf tools.

> 
>> And, gcc has a -mstrict-align parameter, if without this, there are
>> unaligned instructions.
> 
> Does this default to strict or non-strict mode? Usually gcc does not
> allow to turn this off on architectures that have no hardware support
> for unaligned access.

The LoongArch gcc behavior is tunable via the "-m[no-]strict-align" 
command-line flag, and I believe gcc defaults to producing the 
"non-strict" code, most likely because the most popular LoongArch model 
(the 3A5000) supports efficient unaligned accesses. Also there's always 
the possibility that code compiled for and tested on e.g. 3A5000 will 
get run on the less capable models, so it's arguably desirable to not 
let those just fail.

Yes it's vendors' responsibility to actually test their code/solution 
and observe the failure early, but things happen and I'm actually not 
sure if not doing the emulation will benefit the users at this point...

> 
>>>> +/* sysctl hooks */
>>>> +int unaligned_enabled __read_mostly = 1;     /* Enabled by default */
>>>> +int no_unaligned_warning __read_mostly = 1;  /* Only 1 warning by default */
>>>
>>> The comment says 'sysctl', the implementation has a debugfs interface.
>> Originally "enabled", "warning" and "counters" are all debugfs
>> interfaces, then you told me to use sysctl. Now in this version
>> "enabled" and "warning" are converted to sysctl, but there are no
>> existing "counters" sysctl.
> 
> I don't see the sysctl interface in the patch, what am I missing?

FYI they are chosen by the Kconfig options and live in kernel/sysctl.c. 
And I believe the debugfs interface (the counters) is inspired by the 
original mips code. Pretty niche use case but can be handy at times...

-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98BE6664085
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 13:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238317AbjAJMcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 07:32:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238263AbjAJMcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 07:32:13 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A531F15FE8
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 04:32:11 -0800 (PST)
Received: from kwepemi500024.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NrqsQ6gm4znVBr;
        Tue, 10 Jan 2023 20:30:34 +0800 (CST)
Received: from [10.174.179.163] (10.174.179.163) by
 kwepemi500024.china.huawei.com (7.221.188.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 10 Jan 2023 20:32:07 +0800
Message-ID: <684a2472-f388-b2e1-4a7a-7bc9a07650b4@huawei.com>
Date:   Tue, 10 Jan 2023 20:32:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH -v2] x86/boot/compressed: Register dummy NMI handler in
 EFI boot loader, to avoid kdump crashes
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>
CC:     <michael.roth@amd.com>, <hpa@zytor.com>, <tglx@linutronix.de>,
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        <kirill.shutemov@linux.intel.com>, <jroedel@suse.de>,
        <keescook@chromium.org>, <mingo@redhat.com>,
        <dave.hansen@linux.intel.com>, <brijesh.singh@amd.com>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <liwei391@huawei.com>
References: <20230110102745.2514694-1-zengheng4@huawei.com>
 <Y71FJ+G0NGQe3Ppq@gmail.com> <Y71TglxSLJKO17SY@gmail.com>
 <Y71V8SRLxZ/Uqkfs@zn.tnic>
From:   Zeng Heng <zengheng4@huawei.com>
In-Reply-To: <Y71V8SRLxZ/Uqkfs@zn.tnic>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.163]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500024.china.huawei.com (7.221.188.100)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/1/10 20:11, Borislav Petkov wrote:
> On Tue, Jan 10, 2023 at 01:01:06PM +0100, Ingo Molnar wrote:
>> From: Zeng Heng <zengheng4@huawei.com>
>> Date: Tue, 10 Jan 2023 18:27:45 +0800
>> Subject: [PATCH] x86/boot/compressed: Register dummy NMI handler in EFI boot loader, to avoid kdump crashes
>>
>> If kdump is enabled, when using mce_inject to inject errors, EFI
> Why does "EFI" matter here? Any boot loader would do...
>
>> boot loader would decompress & load second kernel for saving the
> s/&/and/
>
>> vmcore file.
>>
>> For normal errors that is fine.
> Useless sentence.
>
>> However, in the MCE case, the panic
>> CPU that firstly enters into mce_panic() is running within NMI
>> interrupt context,
> "#MC context" it is non-maskable but that's not "NMI interrupt context"

mce is registered on NMI handler by inject_init().

And here is the context of mce-inject:

#0  relocate_kernel () at arch/x86/kernel/relocate_kernel_64.S:55
#1  0xffffffff81a57fc2 in machine_kexec (image=0xffff888101ef8400)
     at arch/x86/kernel/machine_kexec_64.c:391
#2  0xffffffff811a9573 in __crash_kexec (regs=regs@entry=0x0 
<fixed_percpu_data>)
     at kernel/kexec_core.c:1057
#3  0xffffffff81a5b4e4 in panic (fmt=fmt@entry=0xffffffff823211c8 "Fatal 
machine check")
     at kernel/panic.c:393
#4  0xffffffff81aa65f5 in mce_panic (
     msg=msg@entry=0xffffffff823211c8 "Fatal machine check",
     final=final@entry=0xffff88813ac9eec0, exp=<optimized out>)
     at arch/x86/kernel/cpu/mce/core.c:380
#5  0xffffffff8103863b in mce_reign () at 
arch/x86/kernel/cpu/mce/core.c:1042
#6  0xffffffff81aa682f in mce_end (order=order@entry=1)
     at arch/x86/kernel/cpu/mce/core.c:1175
#7  0xffffffff81aa6d57 in do_machine_check (regs=0xfffffe00000beef8)
     at arch/x86/kernel/cpu/mce/core.c:1567
#8  0xffffffffc0495167 in raise_exception (m=m@entry=0xffff88813ad9ef40,
     pregs=<optimized out>) at arch/x86/kernel/cpu/mce/inject.c:152
#9  0xffffffffc0495e7f in mce_raise_notify (cmd=<optimized out>, 
regs=<optimized out>)
     at arch/x86/kernel/cpu/mce/inject.c:168
#10 0xffffffff810204b8 in nmi_handle ()
#11 0xffffffff81aa5e62 in default_do_nmi 
(regs=regs@entry=0xfffffe00000beef8)
     at arch/x86/kernel/nmi.c:335
#12 0xffffffff81aa608d in exc_nmi (regs=0xfffffe00000beef8) at 
arch/x86/kernel/nmi.c:517
#13 0xffffffff81c014e8 in asm_exc_nmi () at arch/x86/entry/entry_64.S:1440


>
>> and the processor blocks delivery of subsequent
>> NMIs until the next execution of the IRET instruction.
>>
>> When the panic CPU takes long time in the panic processing route,
> I'm still unclear on the order of events here. It sounds like
>
> 1. MCE injected
> 2. panic
> 3. kdump gets loaded
>
> If that is the case, then I presume the flow is:
>
> mce_panic -> panic -> __crash_kexec()
>
> Yes?

Yes, exactly. The following procedure is like:

panic() -> relocate_kernel() -> identity_mapped() -> x86 purgatory image 
-> EFI loader -> secondary kernel

>
> If so, then we should make sure we have *exited* #MC context before calling
> panic() and not have to add hacks like this one of adding an empty NMI handler.
>
> But I'm only speculating as it is hard to make sense of all this text.
>
> Thx.
>

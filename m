Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 555B66CCFBD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 04:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjC2CCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 22:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjC2CCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 22:02:05 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1C356189;
        Tue, 28 Mar 2023 19:02:02 -0700 (PDT)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8DxUOUZnCNklHsTAA--.29798S3;
        Wed, 29 Mar 2023 10:02:01 +0800 (CST)
Received: from [10.130.0.102] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxPL4XnCNkIQQQAA--.12984S3;
        Wed, 29 Mar 2023 10:02:01 +0800 (CST)
Subject: Re: [PATCH] LoongArch: Add kernel address sanitizer support
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     Xi Ruoyao <xry111@xry111.site>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        kasan-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20230328111714.2056-1-zhangqing@loongson.cn>
 <9817aaa043e9f0ed964bd523773447bd64f6e2c0.camel@xry111.site>
 <1c231587-3b70-22ab-d554-ebe3de407909@loongson.cn>
 <CAAhV-H5APsBxC8nNa81t3HXum1EU1hOj4S6UC7xLHD7_BCJd7g@mail.gmail.com>
From:   Qing Zhang <zhangqing@loongson.cn>
Message-ID: <9a6f11a3-d01c-e0c9-a4f3-47db25ce02f3@loongson.cn>
Date:   Wed, 29 Mar 2023 10:01:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAAhV-H5APsBxC8nNa81t3HXum1EU1hOj4S6UC7xLHD7_BCJd7g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxPL4XnCNkIQQQAA--.12984S3
X-CM-SenderInfo: x2kd0wptlqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoW7uF43ur1UArykKF4xtw43Wrg_yoW8tw4Upr
        y8GF4rtw48Jr40vrs2q34Duryjv3Z2qw1agr4DK34rZ3sF9F98Kr4DWr13uF929r1j9F4Y
        vFWrtFWa934UJaDanT9S1TB71UUUUbUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bq8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2kK
        e7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI
        0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280
        aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2
        xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC
        6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
        026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF
        0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0x
        vE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
        6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2pVbDUUUU
X-Spam-Status: No, score=-0.0 required=5.0 tests=NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Huacai

On 2023/3/29 上午8:22, Huacai Chen wrote:
> On Tue, Mar 28, 2023 at 8:15 PM Qing Zhang <zhangqing@loongson.cn> wrote:
>>
>> Hi, Ruoyao
>>
>> On 2023/3/28 下午7:39, Xi Ruoyao wrote:
>>> On Tue, 2023-03-28 at 19:17 +0800, Qing Zhang wrote:
>>>
>>> /* snip */
>>>
>>>
>>>> -void * __init relocate_kernel(void)
>>>> +unsigned long __init relocate_kernel(void)
>>>
>>> Why we must modify relocate_kernel for KASAN?
>>
>> When the CONFIG_RANDOMIZE_BASE is enabled, the kernel will be updated to
>> a random new address.
>> Kasan needs to call kasan_early_init before start_kernel.
>> There are two situations:
>> 1> After enabling CONFIG_RELOCATABLE, call kasan_early_init.
>> 2> After CONFIG_RELOCATABLE is not enabled, call kasan_early_init.
>>
>> In order to prevent code redundancy and semantic problems caused by
>> calling kasan_early_init (before jr a0) at the old PC.
> In my opinion, you can call kasan_early_init before relocate_kernel in
> head.S, then no redundancy.
> 
It has no effect now, but kasan_early_init generally maps everything to
a single page of zeroes in kasan area, if placed
Before relocate_kernel, when the kernel was relocated, I worried that
there were changes other than the memory layout.

Thanks,
- Qing
> Huacai
>>
>> Thanks,
>> -Qing
>>>
>>>>    {
>>>>           unsigned long kernel_length;
>>>>           unsigned long random_offset = 0;
>>>>           void *location_new = _text; /* Default to original kernel start */
>>>> -       void *kernel_entry = start_kernel; /* Default to original kernel entry point */
>>>>           char *cmdline = early_ioremap(fw_arg1, COMMAND_LINE_SIZE); /* Boot command line is passed in fw_arg1 */
>>>>
>>>>           strscpy(boot_command_line, cmdline, COMMAND_LINE_SIZE);
>>>> @@ -190,9 +189,6 @@ void * __init relocate_kernel(void)
>>>>
>>>>                   reloc_offset += random_offset;
>>>>
>>>> -               /* Return the new kernel's entry point */
>>>> -               kernel_entry = RELOCATED_KASLR(start_kernel);
>>>> -
>>>>                   /* The current thread is now within the relocated kernel */
>>>>                   __current_thread_info = RELOCATED_KASLR(__current_thread_info);
>>>>
>>>> @@ -204,7 +200,7 @@ void * __init relocate_kernel(void)
>>>>
>>>>           relocate_absolute(random_offset);
>>>>
>>>> -       return kernel_entry;
>>>> +       return random_offset;
>>>
>>


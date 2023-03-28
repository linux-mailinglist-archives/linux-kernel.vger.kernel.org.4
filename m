Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B176CBECF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 14:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231990AbjC1MPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 08:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232719AbjC1MPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 08:15:39 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4745393E5;
        Tue, 28 Mar 2023 05:15:37 -0700 (PDT)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8BxONlo2iJkeBYTAA--.29105S3;
        Tue, 28 Mar 2023 20:15:36 +0800 (CST)
Received: from [10.130.0.102] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Dxjb5l2iJkMWQPAA--.35747S3;
        Tue, 28 Mar 2023 20:15:35 +0800 (CST)
Subject: Re: [PATCH] LoongArch: Add kernel address sanitizer support
To:     Xi Ruoyao <xry111@xry111.site>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Huacai Chen <chenhuacai@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Potapenko <glider@google.com>,
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
From:   Qing Zhang <zhangqing@loongson.cn>
Message-ID: <1c231587-3b70-22ab-d554-ebe3de407909@loongson.cn>
Date:   Tue, 28 Mar 2023 20:15:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <9817aaa043e9f0ed964bd523773447bd64f6e2c0.camel@xry111.site>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Dxjb5l2iJkMWQPAA--.35747S3
X-CM-SenderInfo: x2kd0wptlqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoW7ArWDtw4rur15Gr1DuF1Dtrb_yoW8ZF4kpr
        ykJF15JrWrAr18Jr1qqw1DZryUXw1qq3W5Gr1DJFyrZw17Aryjgr4DXr1qgr1Dtr40gr15
        Jr1UtF12vw1UJr7anT9S1TB71UUUUbUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bqxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJVW0owAa
        w2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44
        I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2
        jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62
        AI1cAE67vIY487MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCa
        FVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r4a6rW5MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
        IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI
        42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42
        IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280
        aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8XTm3UUUUU==
X-Spam-Status: No, score=-0.0 required=5.0 tests=NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Ruoyao

On 2023/3/28 下午7:39, Xi Ruoyao wrote:
> On Tue, 2023-03-28 at 19:17 +0800, Qing Zhang wrote:
> 
> /* snip */
> 
> 
>> -void * __init relocate_kernel(void)
>> +unsigned long __init relocate_kernel(void)
> 
> Why we must modify relocate_kernel for KASAN?

When the CONFIG_RANDOMIZE_BASE is enabled, the kernel will be updated to 
a random new address.
Kasan needs to call kasan_early_init before start_kernel.
There are two situations:
1> After enabling CONFIG_RELOCATABLE, call kasan_early_init.
2> After CONFIG_RELOCATABLE is not enabled, call kasan_early_init.

In order to prevent code redundancy and semantic problems caused by 
calling kasan_early_init (before jr a0) at the old PC.

Thanks,
-Qing
> 
>>   {
>>          unsigned long kernel_length;
>>          unsigned long random_offset = 0;
>>          void *location_new = _text; /* Default to original kernel start */
>> -       void *kernel_entry = start_kernel; /* Default to original kernel entry point */
>>          char *cmdline = early_ioremap(fw_arg1, COMMAND_LINE_SIZE); /* Boot command line is passed in fw_arg1 */
>>   
>>          strscpy(boot_command_line, cmdline, COMMAND_LINE_SIZE);
>> @@ -190,9 +189,6 @@ void * __init relocate_kernel(void)
>>   
>>                  reloc_offset += random_offset;
>>   
>> -               /* Return the new kernel's entry point */
>> -               kernel_entry = RELOCATED_KASLR(start_kernel);
>> -
>>                  /* The current thread is now within the relocated kernel */
>>                  __current_thread_info = RELOCATED_KASLR(__current_thread_info);
>>   
>> @@ -204,7 +200,7 @@ void * __init relocate_kernel(void)
>>   
>>          relocate_absolute(random_offset);
>>   
>> -       return kernel_entry;
>> +       return random_offset;
> 


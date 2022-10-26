Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17B4560DF0C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 12:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233244AbiJZKvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 06:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233188AbiJZKvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 06:51:20 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B6CF24F64A
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 03:51:17 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.32])
        by gateway (Coremail) with SMTP id _____8Axz7ckEVljtZkCAA--.5178S3;
        Wed, 26 Oct 2022 18:51:16 +0800 (CST)
Received: from [10.20.42.32] (unknown [10.20.42.32])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxmFckEVlj8kwFAA--.1514S3;
        Wed, 26 Oct 2022 18:51:16 +0800 (CST)
Subject: Re: [PATCH] LoongArch: Fix memsection size
To:     WANG Xuerui <kernel@xen0n.name>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     linux-kernel@vger.kernel.org, loongarch@lists.linux.dev
References: <20221026075638.9396-1-lvjianmin@loongson.cn>
 <edb4002c-3325-53b2-de79-ad4033b363f7@xen0n.name>
From:   Jianmin Lv <lvjianmin@loongson.cn>
Message-ID: <8196d0ab-8564-b858-32ba-1768c0c31732@loongson.cn>
Date:   Wed, 26 Oct 2022 18:51:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <edb4002c-3325-53b2-de79-ad4033b363f7@xen0n.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxmFckEVlj8kwFAA--.1514S3
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoWxWrWxKFyrCF47ZF48ZFWDurg_yoW5Kry5pF
        1Ikr1SkrWDArn7Ar40ya15WFyYka1ru3yUGF98A34DCw13WF1vyr42y3ya9F9rXw4xAay2
        qFZ8Xws7ZayUAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bxAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJVW0owAS
        0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0V
        AKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1l
        Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42
        xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWU
        GwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI4
        8JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4U
        MIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I
        8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j8yCJUUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/10/26 下午5:21, WANG Xuerui wrote:
> On 2022/10/26 15:56, Jianmin Lv wrote:
>> On LoongArch, the physical address space ranging from 0 to 0xfffffff is
>> always memory, which is in the low half of the memsection range from 0 to
>> 0x1fffffff with 512M memsection size, and the high half will be a hole 
>> with
>> invalid memory pages.
> 
> The description is incorrect. For systems with less than 512MiB of 
> memory for example, I believe not every address from 0x0 to 0x0fff_ffff 
> is valid; 

As far as I know, almost all designs use  0x0 to 0x0fff_ffff as memory 
even with 512M because it's difficult to set cpu to support a 
combination with memory and non-memory for 0x0 to 0x0fff_ffff.

> and regarding the latter part of the sentence, what you mean 
> by "invalid memory pages"...
> 
If with 512M memsection size, for the memsection from 0 to 0x1fffffff, 
low half (0 to 0xfffffff) is valid memory, and high half(0x10000000 to 
0x1fffffff ) is I/O registers (of chipsets and cpu), so high half is not 
memory, I think it's better to change *with invalid memory pages* to 
*which is not memory.*

>>
>> This situation may cause some issues. For example, the range of 
>> 0x10000000
>> to 0x1fffffff is io registers, which will be considered as valid 
>> memory range
>> since which is in the memsection of range of 0 to 0x1fffffff. During S3
> 
> ... turns out to be totally valid, only of the I/O kind. (This might be 
> a case of Chinglish that is actually conveying the incorrect meaning to 
> unaware readers.)
> 

The whole range of the 512M memsection will be totally valid by 
pfn_valid(), and let me try reduce the example description. :)


>> sleep and resume, these io registers will be saved and restored as 
>> valid memory
>> page (pfn_valid() of common version considers that all pages in a 
>> memsection
>> are valid), which will cause exception, especially when restoring 
>> during resume.
>>
>> We can use 256M size for memsection of LoongArch, or use the way as 
>> ARM64 to
>> walk through all memory memblock to check if a mem pfn is valid which 
>> maybe
>> lower performance. For simplicity, this patch just use the former way.
> 
> And the rest of the commit message is, unfortunately, a bit too verbose 
> and hard to understand in general. I have to look at the actual change 
> (luckily, a one-liner in this case) to confirm my understanding.
> 
> I think your intent is just to *avoid stepping into IO memory region 
> during suspend/resume by reducing the section size order by one*. 

Yes.


> Try reducing the verbosity of the commit message in v2?

Ok, let me try. :)

> I can't proofread and edit every commit due to limited time, so you have to practice and 
> improve your writing skills after all. I'll review that piece of text 
> afterwards. :)
> 
Ok, thanks.

>>
>> Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
>>
>> diff --git a/arch/loongarch/include/asm/sparsemem.h 
>> b/arch/loongarch/include/asm/sparsemem.h
>> index 3d18cdf1b069..05903b40a625 100644
>> --- a/arch/loongarch/include/asm/sparsemem.h
>> +++ b/arch/loongarch/include/asm/sparsemem.h
>> @@ -8,7 +8,7 @@
>>    * SECTION_SIZE_BITS        2^N: how big each section will be
>>    * MAX_PHYSMEM_BITS        2^N: how much memory we can have in that 
>> space
>>    */
>> -#define SECTION_SIZE_BITS    29 /* 2^29 = Largest Huge Page Size */
>> +#define SECTION_SIZE_BITS    28
>>   #define MAX_PHYSMEM_BITS    48
>>   #endif /* CONFIG_SPARSEMEM */
> 
> The change is trivial indeed but I'm not immediately giving the R-b.
> 


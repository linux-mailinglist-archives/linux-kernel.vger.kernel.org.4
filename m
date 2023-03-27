Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44E426C9A5E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 05:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbjC0D7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 23:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjC0D7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 23:59:02 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 26E792688
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 20:58:59 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.153])
        by gateway (Coremail) with SMTP id _____8BxMI+CFCFkdxoSAA--.27863S3;
        Mon, 27 Mar 2023 11:58:58 +0800 (CST)
Received: from [10.20.42.153] (unknown [10.20.42.153])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Dxib2BFCFkf8wNAA--.6983S3;
        Mon, 27 Mar 2023 11:58:58 +0800 (CST)
Subject: Re: [PATCH V1 1/5] irqchip/loongson-eiointc: Fix returned value on
 parsing MADT
To:     loongson-kernel@lists.loongnix.cn
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
References: <20230324060854.29375-1-lvjianmin@loongson.cn>
 <20230324060854.29375-2-lvjianmin@loongson.cn> <87h6uagnzo.wl-maz@kernel.org>
From:   Jianmin Lv <lvjianmin@loongson.cn>
Message-ID: <cfc7fd9f-67cf-3140-0ec5-a240a45506b9@loongson.cn>
Date:   Mon, 27 Mar 2023 11:58:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <87h6uagnzo.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Dxib2BFCFkf8wNAA--.6983S3
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoWxZFWUGFyxWF4xur4UJw15CFg_yoW5ZFW3pa
        y2qFZ8tr4rt34xCr92yr1UXr1rZwn3uayxtrWrGayFvr4DCry3JF42ya1jvryIkr4UGF42
        vF4Yqa15uw45A3DanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bfAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        n4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6x
        ACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E
        87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0V
        AS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km
        07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r
        1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWU
        JVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r
        1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUv
        cSsGvfC2KfnxnUUI43ZEXa7IU8q2NtUUUUU==
X-Spam-Status: No, score=-0.0 required=5.0 tests=NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/3/24 下午11:36, Marc Zyngier wrote:
> On Fri, 24 Mar 2023 06:08:50 +0000,
> Jianmin Lv <lvjianmin@loongson.cn> wrote:
>>
>> In pch_pic_parse_madt(), a NULL parent pointer will be
>> returned from acpi_get_vec_parent() for second pch-pic domain
>> related to second bridge while calling eiointc_acpi_init() at
>> first time, where the parent of it has not been initialized
>> yet, and will be initialized during second time calling
>> eiointc_acpi_init(). So, it's reasonable to return zero so
>> that failure of acpi_table_parse_madt() will be avoided, or else
>> acpi_cascade_irqdomain_init() will return and initialization of
>> followed pch_msi domain will be skipped.
>>
>> Although it does not matter when pch_msi_parse_madt() returns
>> -EINVAL if no invalid parent is found, it's also reasonable to
>> return zero for that.
>>
>> Change-Id: I4d278534999ec3e5c8db6d40155ba2665d9de86f
>> Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
>> ---
>>   drivers/irqchip/irq-loongson-eiointc.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/irqchip/irq-loongson-eiointc.c b/drivers/irqchip/irq-loongson-eiointc.c
>> index d15fd38c1756..62a632d73991 100644
>> --- a/drivers/irqchip/irq-loongson-eiointc.c
>> +++ b/drivers/irqchip/irq-loongson-eiointc.c
>> @@ -343,7 +343,7 @@ static int __init pch_pic_parse_madt(union acpi_subtable_headers *header,
>>   	if (parent)
>>   		return pch_pic_acpi_init(parent, pchpic_entry);
>>   
>> -	return -EINVAL;
>> +	return 0;
> 
> Why can't you detect this particular case instead of blindly
> suppressing the error?
> 

For dual-bridges scenario, parent handle for pch_pic IRQ domain will be 
set by acpi_set_vec_parent() during each eiointc initialization. And
the parent handle for one pch_pic will be set during *first* eiointc
entry parsing, and the parent handle for another pch_pic will be
set during *second* eiointc entry parsing. But two pch_pic entries
will be parsed during each eiointc entry parsing, so a NULL parent
pointer must be returned druing first eiointc initialization, which
is reasonable and should not be treated as an error.

The calling stack of pch_pic_parse_madt (where acpi_get_vec_parent is 
called to get parent handle) is like this:

cpuintc_acpi_init
   acpi_cascade_irqdomain_init(in cpuintc driver)
     acpi_table_parse_madt
       eiointc_parse_madt
         eiointc_acpi_init /* this will be called two times 
corresponding  to parsing two eiointc entries in MADT under dual-bridges 
scenario*/
           acpi_set_vec_parent /* set parent handle for one pch_pic 
during first eiointc entry parsing, and set parent handle for another 
pch_pic during second eiointc entry parsing*/
             acpi_cascade_irqdomain_init(in eiointc driver)
               acpi_table_parse_madt
                 pch_pic_parse_madt /* this will be called twice because 
of two pchpic entries, and only one valid parent handle will be returned 
from acpi_get_vec_parent() during first eiointc entry parsing (another 
parent handle is not set yet), so a NULL parent pointer must be returned 
during first eiointc entry parsing, which is reasonable and should not 
be treated as an error.*/

Thanks!

> 	M.
> 


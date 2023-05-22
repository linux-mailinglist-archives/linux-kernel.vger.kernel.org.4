Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C01E70B802
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 10:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232433AbjEVIuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 04:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjEVIuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 04:50:03 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CD1C5A8;
        Mon, 22 May 2023 01:50:01 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.176])
        by gateway (Coremail) with SMTP id _____8CxOuq4LGtkkt4KAA--.18430S3;
        Mon, 22 May 2023 16:50:00 +0800 (CST)
Received: from [10.20.42.176] (unknown [10.20.42.176])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Cxqra3LGtkcdpuAA--.55156S3;
        Mon, 22 May 2023 16:50:00 +0800 (CST)
Subject: Re: [PATCH V1 2/4] irqchip/loongson-pch-pic: Fix potential incorrect
 hwirq assignment
To:     loongson-kernel@lists.loongnix.cn,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Liu Peibao <liupeibao@loongson.cn>, stable@vger.kernel.org
References: <20230520063818.27208-1-lvjianmin@loongson.cn>
 <20230520063818.27208-3-lvjianmin@loongson.cn>
 <a31415d5-ca4e-49fa-60d7-9cd53ba5a680@xen0n.name>
From:   Jianmin Lv <lvjianmin@loongson.cn>
Message-ID: <72063c42-f781-5ef5-ec05-7adaa2eabb33@loongson.cn>
Date:   Mon, 22 May 2023 16:49:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <a31415d5-ca4e-49fa-60d7-9cd53ba5a680@xen0n.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Cxqra3LGtkcdpuAA--.55156S3
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoW7uF48ZrWxXF1DZry5GrWruFg_yoW8Kr1DpF
        48A3y3uFWUCr18A348Jw48Wry3Aw47ta9rKa1rtFyfXr1DX3s0gF1UZFy09r1kAr4xAr1U
        ZFs09FWj9Fy7AFJanT9S1TB71UUUUjDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bq8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2kK
        e7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI
        0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280
        aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2
        xFo4CEbIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC
        6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
        026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF
        0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0x
        vE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv
        6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4Xo7DUUUU
X-Spam-Status: No, score=1.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/5/21 下午6:31, WANG Xuerui wrote:
> On 2023/5/20 14:38, Jianmin Lv wrote:
>> From: Liu Peibao <liupeibao@loongson.cn>
>>
>> In DeviceTree path, when ht_vec_base is not zero, the hwirq of PCH PIC 
>> will
>> be assigned incorrectly. Because when pch_pic_domain_translate() adds the
>> ht_vec_base to hwirq, the hwirq dose not subtract the ht_vec_base when
> 
> "does not have the ht_vec_base subtracted"?
> 

Ok, I'll change it as your suggestion, thanks.

>> calling irq_domain_set_info().
>>
>> The ht_vec_base is designed for the parent irq chip/domain of the PCH 
>> PIC.
>> It seems not proper to deal this in callbacks of the PCH PIC domain and
>> let's put this back like the initial commit ef8c01eb64ca ("irqchip: Add
>> Loongson PCH PIC controller").
>>
>> Fixes: bcdd75c596c8 ("irqchip/loongson-pch-pic: Add ACPI init support")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Liu Peibao <liupeibao@loongson.cn>
>> Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
>> ---
>>   drivers/irqchip/irq-loongson-pch-pic.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/irqchip/irq-loongson-pch-pic.c 
>> b/drivers/irqchip/irq-loongson-pch-pic.c
>> index 921c5c0190d1..93a71f66efeb 100644
>> --- a/drivers/irqchip/irq-loongson-pch-pic.c
>> +++ b/drivers/irqchip/irq-loongson-pch-pic.c
>> @@ -164,7 +164,7 @@ static int pch_pic_domain_translate(struct 
>> irq_domain *d,
>>           if (fwspec->param_count < 2)
>>               return -EINVAL;
>> -        *hwirq = fwspec->param[0] + priv->ht_vec_base;
>> +        *hwirq = fwspec->param[0];
>>           *type = fwspec->param[1] & IRQ_TYPE_SENSE_MASK;
>>       } else {
>>           if (fwspec->param_count < 1)
>> @@ -196,7 +196,7 @@ static int pch_pic_alloc(struct irq_domain 
>> *domain, unsigned int virq,
>>       parent_fwspec.fwnode = domain->parent->fwnode;
>>       parent_fwspec.param_count = 1;
>> -    parent_fwspec.param[0] = hwirq;
>> +    parent_fwspec.param[0] = hwirq + priv->ht_vec_base;
>>       err = irq_domain_alloc_irqs_parent(domain, virq, 1, 
>> &parent_fwspec);
>>       if (err)
> 


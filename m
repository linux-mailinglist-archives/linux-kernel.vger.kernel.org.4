Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C628970B839
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 11:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232692AbjEVI7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 04:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232484AbjEVI7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 04:59:21 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B94E3E74;
        Mon, 22 May 2023 01:58:36 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.176])
        by gateway (Coremail) with SMTP id _____8AxdfC7LmtkU98KAA--.18617S3;
        Mon, 22 May 2023 16:58:35 +0800 (CST)
Received: from [10.20.42.176] (unknown [10.20.42.176])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxLb+6LmtkddxuAA--.56365S3;
        Mon, 22 May 2023 16:58:35 +0800 (CST)
Subject: Re: [PATCH V1 3/4] irqchip/loongson-liointc: Fix IRQ trigger polarity
To:     loongson-kernel@lists.loongnix.cn,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>, stable@vger.kernel.org
References: <20230520063818.27208-1-lvjianmin@loongson.cn>
 <20230520063818.27208-4-lvjianmin@loongson.cn>
 <4a08b133-4ead-083e-4ddb-519e12a0dad6@xen0n.name>
From:   Jianmin Lv <lvjianmin@loongson.cn>
Message-ID: <43e89edb-edea-d094-9b80-f9ce253df77f@loongson.cn>
Date:   Mon, 22 May 2023 16:58:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <4a08b133-4ead-083e-4ddb-519e12a0dad6@xen0n.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxLb+6LmtkddxuAA--.56365S3
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoWxZF1UGr18CFW3ZF4kXF48Xrb_yoWrCr4Dpw
        4fAa4DtryYqr18Wr1UGr18JFy5Jw15Xan8JF1xWFyUuFZ8AwsYvryUWF4qgr1xJr48Gr1U
        Ary5Gay5ua17ArDanT9S1TB71UUUUjDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
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
        0xvE2Ix0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0x
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



On 2023/5/21 下午6:46, WANG Xuerui wrote:
> On 2023/5/20 14:38, Jianmin Lv wrote:
>> For IRQ controller INT_POLARITY regitser of Loongson-2K CPU
> 
> "For the INT_POLARITY register of Loongson-2K series IRQ controller"?
> 
>> series, '0' indicates high level or rising edge triggered IRQ,
>> '1' indicates low level or falling edge triggered IRQ.
> 
> Remove the two "IRQ"s; the topic is "polarity", not "IRQs".
> 
> Also please mention the source of this information; I've checked the 
> Loongson 2K1000LA User Manual v1.0 and it seems a similar description is 
> found in Table 9-2, Section 9.3 (中断寄存器描述 / Description of the 
> Interrupt Registers). It mentioned "Intpol_0" and "Intpol_1" but the 
> description is consistent with the wording here.
> 
>>
>> For Loongson-3A CPU series, setting INT_POLARITY register is not
>> supported and writting it has no effect.
> 
> Only 3A and not the whole Loongson-3 series?
> 
> Also typo: "writing".
> 

Ok, I'll adjust the commit as your suggestion above, thanks.

>>
>> So trigger polarity setting shouled be fixed for Loongson-2K CPU
>> series.
> 
> The changes seem to be just inversion of the polarity flags. It should 
> be correct given your description, and not affect Loongson-3 series 
> because it's supposed to behave as noops; it may be better to move the 
> explanation regarding Loongson-3 behavior to code comment (e.g. 
> somewhere near the definition of LIOINTC_REG_INTC_POL) so it's 
> immediately visible to drive-by readers not familiar with LoongArch 
> internals, without them having to dig through commit history to see this.
> 
Good suggestion, I'll add the information near the definition of 
LIOINTC_REG_INTC_POL.

>>
>> Fixes: 17343d0b4039 ("irqchip/loongson-liointc: Support to set IRQ 
>> type for ACPI path")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Chong Qiao <qiaochong@loongson.cn>
>> Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
> 
> Again, who's the proper author for this patch? Given the tags it seems 
> the author should be Chong Qiao, but I didn't see an Author: line at the 
> beginning.
> 

Again, I'll adjust them as following:
Co-developed-by: Chong Qiao <qiaochong@loongson.cn>
Signed-off-by: Chong Qiao <qiaochong@loongson.cn>
Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>

Thanks.

>> ---
>>   drivers/irqchip/irq-loongson-liointc.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/irqchip/irq-loongson-liointc.c 
>> b/drivers/irqchip/irq-loongson-liointc.c
>> index 8d00a9ad5b00..9a9c2bf048a3 100644
>> --- a/drivers/irqchip/irq-loongson-liointc.c
>> +++ b/drivers/irqchip/irq-loongson-liointc.c
>> @@ -116,19 +116,19 @@ static int liointc_set_type(struct irq_data 
>> *data, unsigned int type)
>>       switch (type) {
>>       case IRQ_TYPE_LEVEL_HIGH:
>>           liointc_set_bit(gc, LIOINTC_REG_INTC_EDGE, mask, false);
>> -        liointc_set_bit(gc, LIOINTC_REG_INTC_POL, mask, true);
>> +        liointc_set_bit(gc, LIOINTC_REG_INTC_POL, mask, false);
>>           break;
>>       case IRQ_TYPE_LEVEL_LOW:
>>           liointc_set_bit(gc, LIOINTC_REG_INTC_EDGE, mask, false);
>> -        liointc_set_bit(gc, LIOINTC_REG_INTC_POL, mask, false);
>> +        liointc_set_bit(gc, LIOINTC_REG_INTC_POL, mask, true);
>>           break;
>>       case IRQ_TYPE_EDGE_RISING:
>>           liointc_set_bit(gc, LIOINTC_REG_INTC_EDGE, mask, true);
>> -        liointc_set_bit(gc, LIOINTC_REG_INTC_POL, mask, true);
>> +        liointc_set_bit(gc, LIOINTC_REG_INTC_POL, mask, false);
>>           break;
>>       case IRQ_TYPE_EDGE_FALLING:
>>           liointc_set_bit(gc, LIOINTC_REG_INTC_EDGE, mask, true);
>> -        liointc_set_bit(gc, LIOINTC_REG_INTC_POL, mask, false);
>> +        liointc_set_bit(gc, LIOINTC_REG_INTC_POL, mask, true);
>>           break;
>>       default:
>>           irq_gc_unlock_irqrestore(gc, flags);
> 


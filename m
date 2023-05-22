Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0A970B800
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 10:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232420AbjEVItH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 04:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjEVItF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 04:49:05 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 40D95AF;
        Mon, 22 May 2023 01:49:03 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.176])
        by gateway (Coremail) with SMTP id _____8CxuOl+LGtkZd4KAA--.18649S3;
        Mon, 22 May 2023 16:49:02 +0800 (CST)
Received: from [10.20.42.176] (unknown [10.20.42.176])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxFLV9LGtkBNpuAA--.55799S3;
        Mon, 22 May 2023 16:49:01 +0800 (CST)
Subject: Re: [PATCH V1 1/4] irqchip/loongson-pch-pic: Fix initialization of HT
 vector register
To:     loongson-kernel@lists.loongnix.cn,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>, stable@vger.kernel.org
References: <20230520063818.27208-1-lvjianmin@loongson.cn>
 <20230520063818.27208-2-lvjianmin@loongson.cn>
 <b9430cda-7ae9-25ca-fc22-d4dd02bae53f@xen0n.name>
From:   Jianmin Lv <lvjianmin@loongson.cn>
Message-ID: <5dc1b15b-278e-65b4-7696-e9ae23c0ea59@loongson.cn>
Date:   Mon, 22 May 2023 16:49:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <b9430cda-7ae9-25ca-fc22-d4dd02bae53f@xen0n.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxFLV9LGtkBNpuAA--.55799S3
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoWxAw1rtr18Cw48GF1rKr4DJwb_yoWrGryUpF
        48t3yjkryUJr18Jr1UGw15XFy3Jr1DGw4DJr4UtFy8Jw1DJr1qgr1UXr1j9r48CrW8JF1U
        Ar48tr1UuF1UJF7anT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bDAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2kK
        e7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI
        0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280
        aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2
        xFo4CEbIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC
        6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
        026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF
        0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0x
        vE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
        6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j5o7tUUUUU=
X-Spam-Status: No, score=1.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/5/21 下午6:29, WANG Xuerui wrote:
> Hi,
> 
> On 2023/5/20 14:38, Jianmin Lv wrote:
>> In a dual-bridge system based ACPI, the IRQ on PCH PIC of
> 
> "In an ACPI-based dual-bridge system"?
> 
> Also what's "the IRQ on PCH PIC of each bridge", is it "IRQ of each 
> bridge's PCH PIC"? Or did I misunderstand it?
> 

Thanks for your comment here, I'll change them in next version.

>> each bridge sent to CPU is always a zero-based number, which
>> means that the IRQ on PCH PIC of each bridge is mapped into
>> vector range from 0 to 63 of upstream irqchip(e.g. EIOINTC).
>>
>>        EIOINTC N: [0 ... 63 | 64 ... 255]
>>                    --------   ----------
>>                        ^          ^
>>                        |          |
>>                    PCH PIC N      |
>>                               PCH MSI N
>>
>> For example, the IRQ vector number of sata controller on
>> PCH PIC of each bridge is 16, which is sent to upstream
>> irqchip of EIOINTC when an interrupt occurs, which will set
>> bit 16 of EIOINTC. Since hwirq of 16 on EIOINTC has been
>> mapped to a irq_desc for sata controller during hierarchy
>> irq allocation, the related mapped IRQ will be found through
>> irq_resolve_mapping() in the IRQ domain of EIOINTC.
>>
>> So, the IRQ number set in HT vector register should be fixed
>> to be a zero-based number.
>>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
>> Signed-off-by: liuyun <liuyun@loongson.cn>
> 
> What's the patch's proper authorship, Yun Liu or you? Based on the 
> ordering of the tags it seems you should be the author, but Yun should 
> be submitting (because their tag comes later, the patch should be 
> flowing from your tree to theirs); otherwise they should be the author 
> and the two signoff lines should be reversed.
> 

Ok, I'll change them as following:
Co-developed-by: liuyun <liuyun@loongson.cn>
Signed-off-by: liuyun <liuyun@loongson.cn>
Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>

Thanks.

>> ---
>>   drivers/irqchip/irq-loongson-pch-pic.c | 6 ++----
>>   1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/irqchip/irq-loongson-pch-pic.c 
>> b/drivers/irqchip/irq-loongson-pch-pic.c
>> index e5fe4d50be05..921c5c0190d1 100644
>> --- a/drivers/irqchip/irq-loongson-pch-pic.c
>> +++ b/drivers/irqchip/irq-loongson-pch-pic.c
>> @@ -401,14 +401,12 @@ static int __init acpi_cascade_irqdomain_init(void)
>>   int __init pch_pic_acpi_init(struct irq_domain *parent,
>>                       struct acpi_madt_bio_pic *acpi_pchpic)
>>   {
>> -    int ret, vec_base;
>> +    int ret;
>>       struct fwnode_handle *domain_handle;
>>       if (find_pch_pic(acpi_pchpic->gsi_base) >= 0)
>>           return 0;
>> -    vec_base = acpi_pchpic->gsi_base - GSI_MIN_PCH_IRQ;
>> -
>>       domain_handle = irq_domain_alloc_fwnode(&acpi_pchpic->address);
>>       if (!domain_handle) {
>>           pr_err("Unable to allocate domain handle\n");
>> @@ -416,7 +414,7 @@ int __init pch_pic_acpi_init(struct irq_domain 
>> *parent,
>>       }
>>       ret = pch_pic_init(acpi_pchpic->address, acpi_pchpic->size,
>> -                vec_base, parent, domain_handle, acpi_pchpic->gsi_base);
>> +                0, parent, domain_handle, acpi_pchpic->gsi_base);
>>       if (ret < 0) {
>>           irq_domain_free_fwnode(domain_handle);
> 


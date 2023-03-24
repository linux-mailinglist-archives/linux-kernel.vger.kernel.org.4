Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 310276C7873
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 08:08:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbjCXHIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 03:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbjCXHIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 03:08:18 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DF1661BD8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 00:08:16 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.153])
        by gateway (Coremail) with SMTP id _____8AxUU9fTB1k5J8QAA--.13691S3;
        Fri, 24 Mar 2023 15:08:15 +0800 (CST)
Received: from [10.20.42.153] (unknown [10.20.42.153])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxhbxeTB1kC_4KAA--.2813S3;
        Fri, 24 Mar 2023 15:08:15 +0800 (CST)
Subject: Re: [PATCH V1 0/5] Fix some issues of irq controllers for
 dual-bridges scenario
To:     loongson-kernel@lists.loongnix.cn
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
References: <20230324060854.29375-1-lvjianmin@loongson.cn>
 <CAAhV-H7NpUwaf5OCZL=2_GAN_RYGOkPeVAcDiVR5b1M2jdzkDA@mail.gmail.com>
From:   Jianmin Lv <lvjianmin@loongson.cn>
Message-ID: <80e79c80-b06c-2d5a-b90b-305b439ac91e@loongson.cn>
Date:   Fri, 24 Mar 2023 15:08:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAAhV-H7NpUwaf5OCZL=2_GAN_RYGOkPeVAcDiVR5b1M2jdzkDA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxhbxeTB1kC_4KAA--.2813S3
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoW7tFWfKrW7Gr17Ary8JFy8Grg_yoW8GrW7pa
        13Ga90kr48GryxCas3Aryjg3WYyw1fJrZrt3yft395XryDWw1DZF1UZ3ZYgrnrAr9xGr1j
        qFW0gr18CF4UAFUanT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bqkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        n4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6x
        ACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E
        87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0V
        AS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCF
        s4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI
        8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41l
        IxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIx
        AIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2
        jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jFApnUUUUU=
X-Spam-Status: No, score=-0.0 required=5.0 tests=NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Huacai

Thanks very much for your reminder and suggestion, I'll change them in 
next version.

On 2023/3/24 下午2:32, Huacai Chen wrote:
> Hi, Jianmin,
> 
> 1, Please remove the Change-Id: lines in every patch;
> 2, Please Cc: stable@vger.kernel.org to make them be backported to
> stable branch;
> 3, Maybe changing the order of Patch3/Patch4 is better.
> 
> Huacai
> 
> On Fri, Mar 24, 2023 at 2:09 PM Jianmin Lv <lvjianmin@loongson.cn> wrote:
>>
>> In dual-bridges scenario, some bugs were found for irq
>> controllers drivers, so the patch serie is used to fix them.
>>
>> Jianmin Lv (5):
>>    irqchip/loongson-eiointc: Fix returned value on parsing MADT
>>    irqchip/loongson-eiointc: Fix incorrect use of acpi_get_vec_parent
>>    irqchip/loongson-pch-pic: Fix pch_pic_acpi_init calling
>>    irqchip/loongson-eiointc: Fix registration of syscore_ops
>>    irqchip/loongson-pch-pic: Fix registration of syscore_ops
>>
>>   drivers/irqchip/irq-loongson-eiointc.c | 27 ++++++++++++++++----------
>>   drivers/irqchip/irq-loongson-pch-pic.c |  6 +++++-
>>   2 files changed, 22 insertions(+), 11 deletions(-)
>>
>> --
>> 2.31.1
>>
>>
> _______________________________________________
> Loongson-kernel mailing list -- loongson-kernel@lists.loongnix.cn
> To unsubscribe send an email to loongson-kernel-leave@lists.loongnix.cn
> 


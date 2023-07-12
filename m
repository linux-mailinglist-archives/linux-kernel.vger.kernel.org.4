Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 001577502A0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 11:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbjGLJOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 05:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232754AbjGLJOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 05:14:39 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AD6FA10A;
        Wed, 12 Jul 2023 02:14:35 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.170])
        by gateway (Coremail) with SMTP id _____8DxPOv5bq5km+YDAA--.5918S3;
        Wed, 12 Jul 2023 17:14:33 +0800 (CST)
Received: from [10.20.42.170] (unknown [10.20.42.170])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Ax3c74bq5kGiAqAA--.53735S3;
        Wed, 12 Jul 2023 17:14:32 +0800 (CST)
Message-ID: <79450f26-fc21-fdbc-50c3-00dc2c3d4967@loongson.cn>
Date:   Wed, 12 Jul 2023 17:14:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 1/2] irqchip/loongson-eiointc: Fix return value
 checking of eiointc_index
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jianmin Lv <lvjianmin@loongson.cn>,
        loongson-kernel@lists.loongnix.cn
References: <20230711120807.1805186-1-maobibo@loongson.cn>
 <20230711120807.1805186-2-maobibo@loongson.cn> <865y6pwlsm.wl-maz@kernel.org>
From:   bibo mao <maobibo@loongson.cn>
In-Reply-To: <865y6pwlsm.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Ax3c74bq5kGiAqAA--.53735S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7KF1xXFWxXr1DtFy3CFyrZrc_yoW8Cr13pF
        W7Aayq9w45Ka47C3s3tF18JFyYvws3t39rKayxJay7X3Z8Jw13Gr4Fyas0kr1SkrW7CF1I
        qF4rXF4UC3Z0yrXCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
        1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
        67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
        AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
        F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
        1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
        xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
        4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j1
        WlkUUUUU=
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/7/12 16:56, Marc Zyngier 写道:
> On Tue, 11 Jul 2023 13:08:06 +0100,
> Bibo Mao <maobibo@loongson.cn> wrote:
>>
>> Return value of function eiointc_index is int, however it is converted
>> into uint32_t and then compared smaller than zero. This causes logic
>> problem. There is eioint initialization problem on qemu virt-machine
>> where there is only one eioint node and more than 4 vcpus. Nodemap of
>> eioint is 1, and external device intr can only be routed to vcpu 0-3, the
>> other vcpus can not response any external device interrupts and only local
>> processor interrupts like ipi/timer can work.
>>
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> ---
>>  drivers/irqchip/irq-loongson-eiointc.c | 12 +++++++-----
>>  1 file changed, 7 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/irqchip/irq-loongson-eiointc.c b/drivers/irqchip/irq-loongson-eiointc.c
>> index 92d8aa28bdf5..1c5a5b59f199 100644
>> --- a/drivers/irqchip/irq-loongson-eiointc.c
>> +++ b/drivers/irqchip/irq-loongson-eiointc.c
>> @@ -144,12 +144,14 @@ static int eiointc_router_init(unsigned int cpu)
>>  	int i, bit;
>>  	uint32_t data;
>>  	uint32_t node = cpu_to_eio_node(cpu);
>> -	uint32_t index = eiointc_index(node);
>> +	int index = eiointc_index(node);
>>  
>> -	if (index < 0) {
>> -		pr_err("Error: invalid nodemap!\n");
>> -		return -1;
>> -	}
>> +	/*
>> +	 * qemu virt-machine has only one eio intc and more than four cpus
>> +	 * irq from eio can only be routed to cpu 0-3 on virt machine
>> +	 */
>> +	if (index < 0)
>> +		return 0;
>>  
>>  	if ((cpu_logical_map(cpu) % CORES_PER_EIO_NODE) == 0) {
>>  		eiointc_enable();
> 
> This sort of thing really needs a Fixes: tag.
Sure, will add Fixes tag.

I am a newbie to lkml, thanks for kindly pointing it out :)

Regards
Bibo Mao

> 
> Thanks,
> 
> 	M.
> 


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D24EF74E46C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 04:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjGKCoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 22:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbjGKCoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 22:44:00 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B2E141A7;
        Mon, 10 Jul 2023 19:43:57 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.170])
        by gateway (Coremail) with SMTP id _____8AxCPLJwaxkPVsDAA--.9828S3;
        Tue, 11 Jul 2023 10:43:21 +0800 (CST)
Received: from [10.20.42.170] (unknown [10.20.42.170])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxF83Iwaxk0BEoAA--.45833S3;
        Tue, 11 Jul 2023 10:43:20 +0800 (CST)
Message-ID: <860524f1-db36-05e1-0437-b13976a5a594@loongson.cn>
Date:   Tue, 11 Jul 2023 10:43:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 1/2] irqchip/loongson-eiointc: Fix return value
 checking of eiointc_index
Content-Language: en-US
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Marc Zyngier <maz@kernel.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
        loongson-kernel@lists.loongnix.cn
References: <20230706022849.1272591-1-maobibo@loongson.cn>
 <20230706022849.1272591-2-maobibo@loongson.cn>
 <CAAhV-H4uQEDPRb0Kj8aqth9U7-7fa50Cj8=Off4+wk+CFhM1HQ@mail.gmail.com>
From:   bibo mao <maobibo@loongson.cn>
In-Reply-To: <CAAhV-H4uQEDPRb0Kj8aqth9U7-7fa50Cj8=Off4+wk+CFhM1HQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxF83Iwaxk0BEoAA--.45833S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7CrWrGr1kGF17uw13XFykXrc_yoW8WFW5pF
        WUAFWq9r15Wa47Casxta1rJFyYvwsxt3yDtayxJFW7XFZ8Gw1DGr4Fy3Z0krn2kr43CF10
        gF45XF4UC3WYywcCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUvab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E
        14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44
        I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2
        jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62
        AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E
        5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAV
        WUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY
        1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
        0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU
        7_MaUUUUU
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Huacai,

Thanks for reviewing my patch.
I reply inline.

在 2023/7/11 09:59, Huacai Chen 写道:
> On Thu, Jul 6, 2023 at 10:28 AM Bibo Mao <maobibo@loongson.cn> wrote:
>>
>> return value of function eiointc_index is int, however it is
> 'return' -> 'Return'.
Will do.

> 
>> converted uint32_t when used. This causes logic problem when
>> checking return value. There is eioi initial problem on qemu
> 'eioi' -> 'eiointc'.
Will do in next version.

Regards
Bibo Mao
> 
> Huacai
> 
>> virt-machine where there is only one eioi node and more than 4
>> vcpus, external device intr can only be routed to vcpu 0-3.
> 
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
>>         int i, bit;
>>         uint32_t data;
>>         uint32_t node = cpu_to_eio_node(cpu);
>> -       uint32_t index = eiointc_index(node);
>> +       int index = eiointc_index(node);
>>
>> -       if (index < 0) {
>> -               pr_err("Error: invalid nodemap!\n");
>> -               return -1;
>> -       }
>> +       /*
>> +        * qemu virt-machine has only one eio intc and more than four cpus
>> +        * irq from eio can only be routed to cpu 0-3 on virt machine
>> +        */
>> +       if (index < 0)
>> +               return 0;
>>
>>         if ((cpu_logical_map(cpu) % CORES_PER_EIO_NODE) == 0) {
>>                 eiointc_enable();
>> --
>> 2.27.0
>>


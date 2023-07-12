Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF6974FC79
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 03:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbjGLBDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 21:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjGLBDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 21:03:21 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 67EE3E49;
        Tue, 11 Jul 2023 18:03:19 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.170])
        by gateway (Coremail) with SMTP id _____8DxBfHV+61kQr8DAA--.10610S3;
        Wed, 12 Jul 2023 09:03:17 +0800 (CST)
Received: from [10.20.42.170] (unknown [10.20.42.170])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxxszV+61k3Y8pAA--.29824S3;
        Wed, 12 Jul 2023 09:03:17 +0800 (CST)
Message-ID: <dbe12bfe-d3c9-cdcf-e7a8-7c8582db3488@loongson.cn>
Date:   Wed, 12 Jul 2023 09:03:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 1/2] irqchip/loongson-eiointc: Fix return value
 checking of eiointc_index
Content-Language: en-US
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Marc Zyngier <maz@kernel.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
        loongson-kernel@lists.loongnix.cn
References: <20230711120807.1805186-1-maobibo@loongson.cn>
 <20230711120807.1805186-2-maobibo@loongson.cn>
 <CAAhV-H5k-FVhrRAQj58dckQAGPT9PNp2ghCCfHOMtsr3gf-wRw@mail.gmail.com>
From:   bibo mao <maobibo@loongson.cn>
In-Reply-To: <CAAhV-H5k-FVhrRAQj58dckQAGPT9PNp2ghCCfHOMtsr3gf-wRw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxxszV+61k3Y8pAA--.29824S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7uw43ZryxCFW7Kw43Cw13Jrc_yoW8CF13pF
        W2yFWqkr4UKa47C3s3tF18JryYvwnYyrWUK3yxJayUXF98J343Gr4rAas0kr1IkrW7CF1I
        gF4rXF4UC3Z0y3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        Jr0_Gr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
        xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v2
        6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
        vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
        wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc4
        0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
        xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
        1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7_MaUUUU
        U
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/7/11 23:06, Huacai Chen 写道:
> On Tue, Jul 11, 2023 at 8:08 PM Bibo Mao <maobibo@loongson.cn> wrote:
>>
>> Return value of function eiointc_index is int, however it is converted
>> into uint32_t and then compared smaller than zero. This causes logic
>> problem. There is eioint initialization problem on qemu virt-machine
>> where there is only one eioint node and more than 4 vcpus. Nodemap of
>> eioint is 1, and external device intr can only be routed to vcpu 0-3, the
>> other vcpus can not response any external device interrupts and only local
>> processor interrupts like ipi/timer can work.
> I'm sorry but there are still spelling problems...
> "eio", "eio intc", "eioint" should all be "eiointc".
Sure, thanks for pointing it out, will modify in next version.

Regards
Bibo Mao
> 
> Huacai
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


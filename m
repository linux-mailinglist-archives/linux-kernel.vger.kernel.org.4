Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9216C9A60
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 06:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjC0EAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 00:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjC0EAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 00:00:36 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E625C2688
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 21:00:34 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.153])
        by gateway (Coremail) with SMTP id _____8AxJDThFCFkwRoSAA--.28096S3;
        Mon, 27 Mar 2023 12:00:33 +0800 (CST)
Received: from [10.20.42.153] (unknown [10.20.42.153])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxMuXgFCFk6MwNAA--.44815S3;
        Mon, 27 Mar 2023 12:00:33 +0800 (CST)
Subject: Re: [PATCH V1 2/5] irqchip/loongson-eiointc: Fix incorrect use of
 acpi_get_vec_parent
To:     loongson-kernel@lists.loongnix.cn
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
References: <20230324060854.29375-1-lvjianmin@loongson.cn>
 <20230324060854.29375-3-lvjianmin@loongson.cn> <87ileqgo42.wl-maz@kernel.org>
From:   Jianmin Lv <lvjianmin@loongson.cn>
Message-ID: <c0ad9408-26a0-2b39-586c-a65cb08d4b76@loongson.cn>
Date:   Mon, 27 Mar 2023 12:00:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <87ileqgo42.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxMuXgFCFk6MwNAA--.44815S3
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoWxJFWxAFWDWw45WF18GFW8Xrb_yoW5try5pF
        yxAFWDtr43XrWUur1ftFs8Xr1Sqw1rZFs7ta1fGayFyanruF1kGF1FkF1UCr9akrW7GF4a
        va1YqF1UZF13A37anT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bqkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        n4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6x
        ACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E
        87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0V
        AS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCF
        s4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI
        8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41l
        IxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIx
        AIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2
        jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jz5lbUUUUU=
X-Spam-Status: No, score=-0.0 required=5.0 tests=NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/3/24 下午11:34, Marc Zyngier wrote:
> On Fri, 24 Mar 2023 06:08:51 +0000,
> Jianmin Lv <lvjianmin@loongson.cn> wrote:
>>
>> In eiointc_acpi_init(), a *eiointc* node is passed into
>> acpi_get_vec_parent() instead of a required *NUMA* node (on some chip
>> like 3C5000L, a *NUMA* node means a *eiointc* node, but on some chip
>> like 3C5000, a *NUMA* node contains 4 *eiointc* nodes), and node in
>> struct acpi_vector_group is essentially a *NUMA* node, which will
>> lead to no parent matched for passed *eiointc* node. so the patch
>> adjusts code to use *NUMA* node for parameter node of
>> acpi_set_vec_parent/acpi_get_vec_parent.
>>
>> Change-Id: Iddd8423f9694cadc1ce28ee290c2e98ca17dfccc
>> Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
>> ---
>>   drivers/irqchip/irq-loongson-eiointc.c | 17 +++++++++++------
>>   1 file changed, 11 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/irqchip/irq-loongson-eiointc.c b/drivers/irqchip/irq-loongson-eiointc.c
>> index 62a632d73991..b165c27a3609 100644
>> --- a/drivers/irqchip/irq-loongson-eiointc.c
>> +++ b/drivers/irqchip/irq-loongson-eiointc.c
>> @@ -280,9 +280,6 @@ static void acpi_set_vec_parent(int node, struct irq_domain *parent, struct acpi
>>   {
>>   	int i;
>>   
>> -	if (cpu_has_flatmode)
>> -		node = cpu_to_node(node * CORES_PER_EIO_NODE);
>> -
>>   	for (i = 0; i < MAX_IO_PICS; i++) {
>>   		if (node == vec_group[i].node) {
>>   			vec_group[i].parent = parent;
>> @@ -349,8 +346,13 @@ static int __init pch_pic_parse_madt(union acpi_subtable_headers *header,
>>   static int __init pch_msi_parse_madt(union acpi_subtable_headers *header,
>>   					const unsigned long end)
>>   {
>> +	struct irq_domain *parent;
>>   	struct acpi_madt_msi_pic *pchmsi_entry = (struct acpi_madt_msi_pic *)header;
>> -	struct irq_domain *parent = acpi_get_vec_parent(eiointc_priv[nr_pics - 1]->node, msi_group);
>> +	int node = eiointc_priv[nr_pics - 1]->node;
>> +
>> +	if (cpu_has_flatmode)
>> +		node = cpu_to_node(node * CORES_PER_EIO_NODE);
> 
> This is a bit unreadable. I'd rather see:
> 
> 	int node;
> 
> 	if (cpu_has_flatmode)
> 		node = ....;
> 	else
> 		node = ....;
> 
> which makes it easy to detect the use of an uninitialised 'node'
> rather than using the wrong default variable.
> 
>> +	parent = acpi_get_vec_parent(node, msi_group);
>>   
>>   	if (parent)
>>   		return pch_msi_acpi_init(parent, pchmsi_entry);
>> @@ -379,6 +381,7 @@ int __init eiointc_acpi_init(struct irq_domain *parent,
>>   	int i, ret, parent_irq;
>>   	unsigned long node_map;
>>   	struct eiointc_priv *priv;
>> +	int node = acpi_eiointc->node;
>>   
>>   	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
>>   	if (!priv)
>> @@ -421,8 +424,10 @@ int __init eiointc_acpi_init(struct irq_domain *parent,
>>   				  "irqchip/loongarch/intc:starting",
>>   				  eiointc_router_init, NULL);
>>   
>> -	acpi_set_vec_parent(acpi_eiointc->node, priv->eiointc_domain, pch_group);
>> -	acpi_set_vec_parent(acpi_eiointc->node, priv->eiointc_domain, msi_group);
>> +	if (cpu_has_flatmode)
>> +		node = cpu_to_node(node * CORES_PER_EIO_NODE);
>> +	acpi_set_vec_parent(node, priv->eiointc_domain, pch_group);
>> +	acpi_set_vec_parent(node, priv->eiointc_domain, msi_group);
>>   	ret = acpi_cascade_irqdomain_init();
>>   
>>   	return ret;
> 
> Same thing here.
> 

Ok, I'll change them  in next version.

Thanks!

> 	M.
> 


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7F171FB15
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 09:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234485AbjFBHg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 03:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234451AbjFBHfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 03:35:53 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 67EC310DA
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 00:35:28 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.170])
        by gateway (Coremail) with SMTP id _____8Dx_+u+m3lktIsDAA--.7690S3;
        Fri, 02 Jun 2023 15:35:26 +0800 (CST)
Received: from [10.20.42.170] (unknown [10.20.42.170])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Axmr29m3lkToiFAA--.18705S3;
        Fri, 02 Jun 2023 15:35:25 +0800 (CST)
Message-ID: <e483b7bb-4184-758d-2840-11d75659975e@loongson.cn>
Date:   Fri, 2 Jun 2023 15:35:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] LoongArch: Align pci memory base address with page size
Content-Language: en-US
To:     loongson-kernel@lists.loongnix.cn
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Jianmin Lv <lvjianmin@loongson.cn>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20230602030732.1047696-1-maobibo@loongson.cn>
 <CAAhV-H58dR4JWtCdqCR553H1-pbppKyi114BMhsrV74Zb_c58Q@mail.gmail.com>
 <17a2ba54-2b85-9cc9-2a43-16eb20d6ce84@loongson.cn>
 <CAAhV-H4VHoNQdpDdpcPfDXJxnpoWUtDqmJMhb_r4DS4JtnxvhQ@mail.gmail.com>
From:   "bibo, mao" <maobibo@loongson.cn>
In-Reply-To: <CAAhV-H4VHoNQdpDdpcPfDXJxnpoWUtDqmJMhb_r4DS4JtnxvhQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Axmr29m3lkToiFAA--.18705S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjvJXoWxCFWkury8Zr1kJF1DWw17Jrb_yoWrtFy3pF
        WfCanxCrWUGry7CwsIqwn8uFsa93s7Kr47Xr43Jry3Gr9rZa43Xr1UJF15uFy8Jrs8GF10
        vr4jkrW7WFy5Aa7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        baAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2
        IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r4j6F4U
        McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487Mx
        AIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r126r1D
        MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67
        AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0
        cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z2
        80aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI
        43ZEXa7IU8vApUUUUUU==
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/6/2 14:55, Huacai Chen 写道:
> On Fri, Jun 2, 2023 at 2:48 PM bibo, mao <maobibo@loongson.cn> wrote:
>>
>>
>>
>> 在 2023/6/2 12:11, Huacai Chen 写道:
>>> +cc Bjorn
>>>
>>> Hi, Bibo,
>>>
>>> On Fri, Jun 2, 2023 at 11:07 AM Bibo Mao <maobibo@loongson.cn> wrote:
>>>>
>>>> LoongArch linux kernel uses 16K page size by default, some pci devices have
>>>> only 4K memory size, it is normal in general architectures. However memory
>>>> space of different pci devices will share one physical page address space.
>>>> This is not safe for mmu protection, also UIO and VFIO requires base
>>>> address of pci memory space page aligned.
>>>>
>>>> This patch adds check with function pcibios_align_resource, and set base
>>>> address of resource page aligned.
>>>>
>>>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>>>> ---
>>>>  arch/loongarch/pci/pci.c | 23 +++++++++++++++++++++++
>>>>  1 file changed, 23 insertions(+)
>>>>
>>>> diff --git a/arch/loongarch/pci/pci.c b/arch/loongarch/pci/pci.c
>>>> index 2726639150bc..1380f3672ba2 100644
>>>> --- a/arch/loongarch/pci/pci.c
>>>> +++ b/arch/loongarch/pci/pci.c
>>>> @@ -83,6 +83,29 @@ int pcibios_alloc_irq(struct pci_dev *dev)
>>>>         return acpi_pci_irq_enable(dev);
>>>>  }
>>>>
>>>> +/*
>>>> + * memory space size of some pci cards is 4K, it is separated with
>>>> + * different pages for generic architectures, so that mmu protection can
>>>> + * work with different pci cards. However page size for LoongArch system
>>>> + * is 16K, memory space of different pci cards may share the same page
>>>> + * on LoongArch, it is not safe here.
>>>> + * Also uio drivers and vfio drivers sugguests that base address of memory
>>>> + * space should page aligned. This function aligns base address with page size
>>>> + */
>>>> +resource_size_t pcibios_align_resource(void *data, const struct resource *res,
>>>> +               resource_size_t size, resource_size_t align)
>>>> +{
>>>> +       resource_size_t start = res->start;
>>>> +
>>>> +       if (res->flags & IORESOURCE_MEM) {
>>>> +               if (align & (PAGE_SIZE - 1)) {
>>>> +                       align = PAGE_SIZE;
>>>> +                       start = ALIGN(start, align);
>>> I don't know whether this patch is really needed, but the logic here
>>> has some problems.
>>>
>>> For example, if PAGE_SIZE=16KB, align=18KB, what should we do? Align
>>> to 16KB or align to 32KB? IMO it should align to 32KB, but in your
>>> patch it will align to 16KB.
>> In general pci device is aligned by size, and its value is a power of 2 in value.
>> I do not see such devices with 18K alignment requirements.
> If so, you can simply ignore "align" and use  start = ALIGN(start, PAGE_SIZE);
> 
>>
>> By pci local bus spec, there are such lines:
>>
>> "Devices are free to consume more address space than required, but decoding down
>> to a 4 KB space for memory is suggested for devices that need less than that amount. For
>> instance, a device that has 64 bytes of registers to be mapped into Memory Space may
>> consume up to 4 KB of address space in order to minimize the number of bits in the address
>> decoder."
>>
>> I cannot  think whether it is necessary simply from judging whether other
>> architectures have similar code. If so, LoongArch system just  always follows others.
>> It is actually one problem since LoongArch uses 16K page size.
> As I know, both MIPS and ARM64 can use non-4K pages, but when I grep
> pcibios_align_resource in the arch directory, none of them do
> PAGE_SIZE alignment.
Here is piece of  code in drivers/vfio/pci/vfio_pci_core.c
                /*
                 * Here we don't handle the case when the BAR is not page
                 * aligned because we can't expect the BAR will be
                 * assigned into the same location in a page in guest
                 * when we passthrough the BAR. And it's hard to access
                 * this BAR in userspace because we have no way to get
                 * the BAR's location in a page.
                 */
no_mmap:
                vdev->bar_mmap_supported[bar] = false;

Do you think it is a issue or not? 

You can search function pnv_pci_default_alignment or pcibios_align_resource about
alpha architecture.

Regards
Bibo, mao

> 
> Huacai
> 
>>
>> Regards
>> Bibo, Mao
>>>
>>> Huacai
>>>> +               }
>>>> +       }
>>>> +       return start;
>>>> +}
>>>> +
>>>>  static void pci_fixup_vgadev(struct pci_dev *pdev)
>>>>  {
>>>>         struct pci_dev *devp = NULL;
>>>> --
>>>> 2.27.0
>>>>
>>> _______________________________________________
>>> Loongson-kernel mailing list -- loongson-kernel@lists.loongnix.cn
>>> To unsubscribe send an email to loongson-kernel-leave@lists.loongnix.cn
>>
>>
> _______________________________________________
> Loongson-kernel mailing list -- loongson-kernel@lists.loongnix.cn
> To unsubscribe send an email to loongson-kernel-leave@lists.loongnix.cn


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6566A5B33D1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 11:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbiIIJZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 05:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbiIIJZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 05:25:18 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EA389136CC7;
        Fri,  9 Sep 2022 02:23:51 -0700 (PDT)
Received: from [10.20.42.105] (unknown [10.20.42.105])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxBOL7BRtjBU0VAA--.19960S3;
        Fri, 09 Sep 2022 17:23:08 +0800 (CST)
Subject: Re: [PATCH V3 1/2] ACPI / scan: Support multiple dma windows with
 different offsets
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Robin Murphy <robin.murphy@arm.com>, chenhuacai@loongson.cn,
        guohanjun@huawei.com, sudeep.holla@arm.com, rafael@kernel.org,
        lenb@kernel.org, robert.moore@intel.com,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        loongarch@lists.linux.dev
References: <20220830030139.29899-1-lvjianmin@loongson.cn>
 <20220830030139.29899-2-lvjianmin@loongson.cn>
 <435e1283-9ff6-f089-6436-3c31a178fd60@arm.com>
 <66baf6f8-0f18-e0a6-4ed4-e2f783497d2d@loongson.cn>
 <YxrznBoBQycR8xCA@lpieralisi>
From:   Jianmin Lv <lvjianmin@loongson.cn>
Message-ID: <53c47160-ccee-a565-34cf-a7e5143744ed@loongson.cn>
Date:   Fri, 9 Sep 2022 17:23:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <YxrznBoBQycR8xCA@lpieralisi>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxBOL7BRtjBU0VAA--.19960S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJr1UAr45CF4kCw43ZrW3GFg_yoW8CryUpa
        48G3W3Gr4Dtrs3Cr4vqw15Zry0vry3Cr4fXrW8Aw1kArn0gr1Svr48J3sYkFWq9a47Gw18
        ZFs0qas3ZF15AwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBI1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
        z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcV
        Aq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j
        6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
        1lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
        e2xFo4CEbIxvr21lc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY2
        0_XrWUJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2Iq
        xVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42
        IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY
        6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aV
        CY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/9/9 下午4:04, Lorenzo Pieralisi wrote:
> On Tue, Sep 06, 2022 at 08:40:48PM +0800, Jianmin Lv wrote:
>>
>>
>> On 2022/9/5 下午8:20, Robin Murphy wrote:
>>> On 2022-08-30 04:01, Jianmin Lv wrote:
>>>> For DT, of_dma_get_range returns bus_dma_region typed dma regions,
>>>> which makes multiple dma windows with different offset available
>>>> for translation between dma address and cpu address.
>>>>
>>>> But for ACPI, acpi_dma_get_range doesn't return similar dma regions,
>>>> causing no path for setting dev->dma_range_map conveniently. So the
>>>> patch changes acpi_dma_get_range and returns bus_dma_region typed
>>>> dma regions according to of_dma_get_range.
>>>>
>>>> After changing acpi_dma_get_range, acpi_arch_dma_setup is changed for
>>>> ARM64, where original dma_addr and size are removed as these
>>>> arguments are now redundant, and pass 0 and U64_MAX for dma_base
>>>> and size of arch_setup_dma_ops, so this is a simplification consistent
>>>> with what other ACPI architectures also pass to iommu_setup_dma_ops().
>>>
>>> Other than a micro-nit that acpi_dma_get_range() could probably use
>>> resource_size(),
>>>
>>
>> Ok, thanks, I'll use resource_size() in acpi_dma_get_range().
> 
> Are you reposting this shortly ? We are almost at -rc5, it would
> be good if we can proceed promptly.
> 
> Thanks,
> Lorenzo
> 
Ok, I'll send V4 today.

Thanks,
Jianmin

>>> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
>>>
>>> It took me longer than I care to admit to figure out where the implicit
>>> declaration of struct bus_dma_region in the scope of acpi.h and
>>> acpi_bus.h comes from, but in the end I guess it's sufficiently
>>> well-defined by the C spec to be reliable.
>>>
>>> Thanks for getting this done!
>>>
>>
>> It's a pleasure!
>>
>>
>>> Robin.
>>>
>>
>> [...]
>>
>>


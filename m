Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D27D602CA2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 15:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbiJRNOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 09:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbiJRNOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 09:14:32 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2196A9FEB;
        Tue, 18 Oct 2022 06:14:23 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.32])
        by gateway (Coremail) with SMTP id _____8DxTtuupk5je24AAA--.2582S3;
        Tue, 18 Oct 2022 21:14:22 +0800 (CST)
Received: from [10.20.42.32] (unknown [10.20.42.32])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxTuCtpk5jVbUAAA--.3091S3;
        Tue, 18 Oct 2022 21:14:21 +0800 (CST)
Subject: Re: [PATCH V5 1/2] ACPI / scan: Support multiple dma windows with
 different offsets
To:     Robin Murphy <robin.murphy@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Yicong Yang <yangyicong@huawei.com>, yangyicong@hisilicon.com,
        lpieralisi@kernel.org, chenhuacai@loongson.cn,
        guohanjun@huawei.com, sudeep.holla@arm.com, lenb@kernel.org,
        robert.moore@intel.com, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, loongarch@lists.linux.dev,
        liulongfang <liulongfang@huawei.com>
References: <20220911090635.5559-1-lvjianmin@loongson.cn>
 <20220911090635.5559-2-lvjianmin@loongson.cn>
 <8e9df8ea-06f0-3989-2563-d5dc6b09a062@huawei.com>
 <CAJZ5v0gBBdTxRkE08PO8W+yi1eTkWqzpGLAyMNuzZmqx02EzFA@mail.gmail.com>
 <c7ae3a66-1d24-1014-b63a-8d4af3de42c8@arm.com>
 <7904cd2e-caf5-0073-9889-306ab524d802@huawei.com>
 <ded07a34-0cf4-3f76-a538-fb6a9abd6673@loongson.cn>
 <CAJZ5v0i5jo-+B6sq5Aftj_TR=dj4gt-4aiXhbu2BW-=KETQgFw@mail.gmail.com>
 <81b8f3db-73b4-b3a4-d3e9-5d1779b13947@loongson.cn>
 <9959cb08-5137-709b-faf6-46fee024630d@arm.com>
From:   Jianmin Lv <lvjianmin@loongson.cn>
Message-ID: <20dad10e-c901-4c03-01a6-6f644886044f@loongson.cn>
Date:   Tue, 18 Oct 2022 21:14:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <9959cb08-5137-709b-faf6-46fee024630d@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxTuCtpk5jVbUAAA--.3091S3
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoWxKw4kCw45GryUuw17WryfZwb_yoWxtr1rpr
        y8JF47CrWrJr18Jr1Utw1UKryUtr1UA3WUXrykG3WDJrsrtr1jqr1UXr1jgr1UAr48Ar17
        tr45tw12vryUAw7anT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bqAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM2
        8EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxd
        M2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zV
        CFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2
        z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2
        IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E
        4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_GFv_Wrylx2IqxVAqx4xG67AKxVWUJVWUGw
        C20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48J
        MIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMI
        IF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E
        87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4YLvDUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/10/18 下午9:06, Robin Murphy wrote:
> On 2022-10-18 14:00, Jianmin Lv wrote:
>>
>>
>> On 2022/10/18 下午8:56, Rafael J. Wysocki wrote:
>>> On Tue, Oct 18, 2022 at 2:50 PM Jianmin Lv <lvjianmin@loongson.cn> 
>>> wrote:
>>>>
>>>>
>>>>
>>>> On 2022/10/18 下午8:32, Yicong Yang wrote:
>>>>> On 2022/10/18 20:00, Robin Murphy wrote:
>>>>>> On 2022-10-18 11:08, Rafael J. Wysocki wrote:
>>>>>>> On Tue, Oct 18, 2022 at 11:33 AM Yicong Yang 
>>>>>>> <yangyicong@huawei.com> wrote:
>>>>>>>>
>>>>>>>> On 2022/9/11 17:06, Jianmin Lv wrote:
>>>>>>>>> In DT systems configurations, of_dma_get_range() returns struct
>>>>>>>>> bus_dma_region DMA regions; they are used to set-up devices
>>>>>>>>> DMA windows with different offset available for translation 
>>>>>>>>> between DMA
>>>>>>>>> address and CPU address.
>>>>>>>>>
>>>>>>>>> In ACPI systems configuration, acpi_dma_get_range() does not 
>>>>>>>>> return
>>>>>>>>> DMA regions yet and that precludes setting up the 
>>>>>>>>> dev->dma_range_map
>>>>>>>>> pointer and therefore DMA regions with multiple offsets.
>>>>>>>>>
>>>>>>>>> Update acpi_dma_get_range() to return struct bus_dma_region
>>>>>>>>> DMA regions like of_dma_get_range() does.
>>>>>>>>>
>>>>>>>>> After updating acpi_dma_get_range(), acpi_arch_dma_setup() is 
>>>>>>>>> changed for
>>>>>>>>> ARM64, where the original dma_addr and size are removed as these
>>>>>>>>> arguments are now redundant, and pass 0 and U64_MAX for dma_base
>>>>>>>>> and size of arch_setup_dma_ops; this is a simplification 
>>>>>>>>> consistent
>>>>>>>>> with what other ACPI architectures also pass to 
>>>>>>>>> iommu_setup_dma_ops().
>>>>>>>>>
>>>>>>>>
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>> With this patch we met problem as well. The DMA coherent mask is 
>>>>>>>> not set correctly
>>>>>>>> for a ehci usb controller and lead to the below calltrace:
>>>>>>>>
>>>>>>>> [   16.699259] ------------[ cut here ]------------
>>>>>>>> [   16.703855] WARNING: CPU: 0 PID: 853 at 
>>>>>>>> kernel/dma/mapping.c:499 dma_alloc_attrs+0xc0/0xf0
>>>>>>>> [   16.712082] Modules linked in:
>>>>>>>> [   16.715124] CPU: 0 PID: 853 Comm: kworker/0:3 Not tainted 
>>>>>>>> 6.1.0-rc1-pipe-deadlock+ #5
>>>>>>>> [   16.722916] Hardware name: Huawei TaiShan 2280 V2/BC82AMDC, 
>>>>>>>> BIOS 2280-V2 CS V5.B211.01 11/10/2021
>>>>>>>> [   16.731745] Workqueue: events work_for_cpu_fn
>>>>>>>> [   16.736083] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT 
>>>>>>>> -SSBS BTYPE=--)
>>>>>>>> [   16.743013] pc : dma_alloc_attrs+0xc0/0xf0
>>>>>>>> [   16.747091] lr : dma_pool_alloc+0x11c/0x200
>>>>>>>> [   16.751255] sp : ffff80001e46bb50
>>>>>>>> [   16.754554] x29: ffff80001e46bb50 x28: 0000000000000000 x27: 
>>>>>>>> 0000000000000000
>>>>>>>> [   16.761657] x26: ffff80000b33ce18 x25: ffff800009cc6c48 x24: 
>>>>>>>> 0000000000000000
>>>>>>>> [   16.768759] x23: ffff00208c830918 x22: 0000000000001000 x21: 
>>>>>>>> 0000000000000cc0
>>>>>>>> [   16.775861] x20: ffff00208ae82080 x19: ffff0020865c40d0 x18: 
>>>>>>>> 0000000000000030
>>>>>>>> [   16.782964] x17: 626d756e20737562 x16: 2064656e67697373 x15: 
>>>>>>>> ffff00208ae82640
>>>>>>>> [   16.790066] x14: 0000000000000000 x13: 646e756f72616b72 x12: 
>>>>>>>> 6f77204348207379
>>>>>>>> [   16.797167] x11: 73706f6e79532067 x10: ffff205f43980000 x9 : 
>>>>>>>> ffff80000830b3ac
>>>>>>>> [   16.804269] x8 : ffff0020861b1b00 x7 : 0000000000000000 x6 : 
>>>>>>>> 0000000000000000
>>>>>>>> [   16.811371] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 
>>>>>>>> 0000000000000cc0
>>>>>>>> [   16.818472] x2 : ffff00208c830918 x1 : 0000000000001000 x0 : 
>>>>>>>> 0000000000000000
>>>>>>>> [   16.825574] Call trace:
>>>>>>>> [   16.828009]  dma_alloc_attrs+0xc0/0xf0
>>>>>>>> [   16.831741]  dma_pool_alloc+0x11c/0x200
>>>>>>>> [   16.835559]  ehci_qh_alloc+0x60/0x12c
>>>>>>>> [   16.839207]  ehci_setup+0x18c/0x40c
>>>>>>>> [   16.842680]  ehci_pci_setup+0xb8/0x680
>>>>>>>> [   16.846412]  usb_add_hcd+0x310/0x5c0
>>>>>>>> [   16.849973]  usb_hcd_pci_probe+0x254/0x36c
>>>>>>>> [   16.854051]  ehci_pci_probe+0x40/0x60
>>>>>>>> [   16.857698]  local_pci_probe+0x48/0xb4
>>>>>>>> [   16.861431]  work_for_cpu_fn+0x24/0x40
>>>>>>>> [   16.865163]  process_one_work+0x1e0/0x450
>>>>>>>> [   16.869155]  worker_thread+0x2cc/0x44c
>>>>>>>> [   16.872886]  kthread+0x114/0x120
>>>>>>>> [   16.876099]  ret_from_fork+0x10/0x20
>>>>>>>> [   16.879657] ---[ end trace 0000000000000000 ]---
>>>>>>>>
>>>>>>>> After reverting this patch the problem resolved. Tested on the 
>>>>>>>> latest 6.1-rc1.
>>>>>>>
>>>>>>> OK, I'll queue up a revert of this and one more commit depending 
>>>>>>> on it.
>>>>>>
>>>>>> FWIW it looks like the fix should be as simple as below.
>>>>>>
>>>>>
>>>>> Looks like it's the case. The change works on my platform, now the 
>>>>> ehci probed successfully again
>>>>> with no calltrace:
>>>>>
>>>>> Tested-by: Yicong Yang <yangyicong@hisilicon.com>
>>>>>
>>>>>> Robin.
>>>>>>
>>>>>> ----->8-----
>>>>>> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
>>>>>> index 558664d169fc..b6962bff1eae 100644
>>>>>> --- a/drivers/acpi/scan.c
>>>>>> +++ b/drivers/acpi/scan.c
>>>>>> @@ -1509,6 +1509,7 @@ int acpi_dma_get_range(struct device *dev, 
>>>>>> const struct bus_dma_region **map)
>>>>>>                goto out;
>>>>>>            }
>>>>>>
>>>>>> +        *map = r;
>>>>>>            list_for_each_entry(rentry, &list, node) {
>>>>>>                if (rentry->res->start >= rentry->res->end) {
>>>>>>                    kfree(r);
>>>>>> @@ -1523,8 +1524,6 @@ int acpi_dma_get_range(struct device *dev, 
>>>>>> const struct bus_dma_region **map)
>>>>>>                r->offset = rentry->offset;
>>>>>>                r++;
>>>>>>            }
>>>>>> -
>>>>>> -        *map = r;
>>>>>>        }
>>>>>>     out:
>>>>>>        acpi_dev_free_resource_list(&list);
>>>>>>
>>>>
>>>> Ohh, yes, map got a wrong value of r because it has been changed.
>>>
>>> Well, please send me a working patch by EOD tomorrow.
>>>
>>
>> Ok!
> 
> In fact there's another related bug in the error path as well. 

Do you mean the bug of *kfree(r)*, it should be original r instead 
changed one, yes?

> I'm writing up the patch now...
>
Ok, thank you very much for making patch for the issue.


> Thanks,
> Robin
> 
>>
>>
>>>> Maybe wo can fix it like this:
>>>>
>>>> truct bus_dma_region *r, *orig_r;
>>>> ...
>>>> orig_r = r = kcalloc(ret + 1, sizeof(*r), GFP_KERNEL);
>>>> ...
>>>> *map = orig_r;
>>>>
>>>>>> .
>>


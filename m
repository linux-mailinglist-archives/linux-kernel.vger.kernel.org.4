Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A41B6F4ED5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 04:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbjECC0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 22:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjECC0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 22:26:50 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C872118
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 19:26:48 -0700 (PDT)
Received: from kwepemm600013.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QB11R0MBDzTkJ8;
        Wed,  3 May 2023 10:22:19 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 3 May 2023 10:26:45 +0800
Subject: Re: [PATCH] mtd: ubi: attach MTD partition from device-tree
To:     Daniel Golle <daniel@makrotopia.org>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
References: <ZEA8hX9UjX9S0NUm@makrotopia.org>
 <9c622f92-382d-8b0d-a438-c7eea0e89b80@huawei.com>
 <ZEW8VS4Y-dVRcGGy@makrotopia.org>
 <f50a0d60-356a-6206-3363-e0f80870c754@huawei.com>
 <ZEZ-wLMxJvDAqrx6@makrotopia.org>
 <6b8201ab-3350-e3f5-b915-b3e94582518d@huawei.com>
 <ZFAHqMxcWZPOTFgs@makrotopia.org>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <9f10bef5-afa9-132e-3c61-323a2e56931d@huawei.com>
Date:   Wed, 3 May 2023 10:26:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <ZFAHqMxcWZPOTFgs@makrotopia.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2023/5/2 2:40, Daniel Golle 写道:
> On Tue, Apr 25, 2023 at 11:01:41AM +0800, Zhihao Cheng wrote:
>> 在 2023/4/24 21:06, Daniel Golle 写道:
>>> On Mon, Apr 24, 2023 at 11:26:13AM +0800, Zhihao Cheng wrote:
>>>>> [...]
>>>>> One way to partially resolve this could be to add a boolean parameter to
>>>>> ubiblock_create_from_param which indicates if -ENOENT should be treated
>>>>> as an error, and set that parameter only when calling from
>>>>> late_initcall.
>>>>>
>>>>> Being able to warn users if they added the same ubiblock device more
>>>>> than once **on the cmdline or module parameter** is more tricky and
>>>>> would require tracking why a ubiblock device has previously been
>>>>> created. However, I don't think that emitting a warning in this case
>>>>> is crucial at all, the user definitely wanted the ubiblock device to be
>>>>> created and saying that more than once is unneccesary but yet also
>>>>> doesn't leave room for any interpretation other than just that the user
>>>>> *really* wants the ubiblock to be created.
>>>>
>>>> Emm, I prefer to fix it, it's weird that ubiblock_create_from_param() being
>>>> executed multiple times(Each ubi_notify_add() will call once, late_initcall
>>>> will call it again). User could see many false positive error messages.
>>>
>>> Given my suggestion above (not printing error in case the UBI device or
>>> volume doesn't exist as well as in case in case the ubiblock device has
>>> already been created) there won't be any false positives.
>>> What is still true is that other errors (eg. invalid string format of
>>> the ubiblock parameter) will be printed multiple times.
>>>
>>> Do you think it is worth putting much effort into avoiding that?
>>> If so, any idea how?
>>>
>>
>> Currently, there are two timings to load ubiblock:
>> 1. boot cmdline: One-time loading
>> 2. ioctl UBI_IOCVOLCRBLK: Can be called multiple times at runtime
>> PS: ubiblock cannot be compiled in module, there are only two options: Y and
>> N
> 
> It's true that ubiblock is a boolean option, however, Y or N decides
> whether support for ubiblock will be included with the ubi driver, which
> can well be a kernel module. In that case, ubiblock is loaded and removed
> together with the rest of the ubi driver.

You are right, ubiblock will be loaded in module way if UBI driver is 
compiled in module format, my mistake.

> 
>>
>> How about deleting 'ubiblock_create_from_param' from ubi_notify_add(), we
>> only call ubiblock_create_from_param() once in ubi_init_attach(). This can
>> keep the ubiblock loading timings are unchanged, and ENODEV and EEXIST won't
>> be false positive.
> 
> I also thought that and it works well under the assumption that all
> drivers providing MTD devices are built-in or inserted before the ubi
> driver is inserted. However, this may not always be true. Think of,
> for example, an SPI bus driver which is built as a module and loaded
> during boot (eg. from initramfs). Your suggestion below solves that.
> 
>>
>> If someone later want to loading ubiblock automically, UBI_VOLUME_ADDED case
>> in ubiblock_notify() is suggested to be implemented.
> 
> I've implemented your suggestion and it works fine, to me even looks
> better than the current code which gets/puts the UBI volume just to
> compare if its info matches the cmdline parameter. I will post this as
> a preliminary patch in the series, together with an other fix and an
> updated version of this patch.

I'll take a look at this series.
> 
>>
>>>>
>>>>>
>>>>>>
>>>>>>> +				pr_err(
>>>>>>> +				       "UBI: block: can't add '%s' volume on ubi%d_%d, err=%d\n",
>>>>>>> +				       vi.name, p->ubi_num, p->vol_id, ret);
>>>>>>>      			continue;
>>>>>>>      		}
>>>>>>>      	}
>>>>>>> @@ -644,13 +645,6 @@ int __init ubiblock_init(void)
>>>>>>>      	if (ubiblock_major < 0)
>>>>>>>      		return ubiblock_major;
>>>>>>> -	/*
>>>>>>> -	 * Attach block devices from 'block=' module param.
>>>>>>> -	 * Even if one block device in the param list fails to come up,
>>>>>>> -	 * still allow the module to load and leave any others up.
>>>>>>> -	 */
>>>>>>> -	ubiblock_create_from_param();
>>>>>>> -
>>>>>>>      	/*
>>>>>>>      	 * Block devices are only created upon user requests, so we ignore
>>>>>>>      	 * existing volumes.
>>>>>>> diff --git a/drivers/mtd/ubi/build.c b/drivers/mtd/ubi/build.c
>>>>>>> index 9cd565daad368..a764f97eee791 100644
>>>>>>> --- a/drivers/mtd/ubi/build.c
>>>>>>> +++ b/drivers/mtd/ubi/build.c
>>>>>>> @@ -27,6 +27,7 @@
>>>>>>>      #include <linux/log2.h>
>>>>>>>      #include <linux/kthread.h>
>>>>>>>      #include <linux/kernel.h>
>>>>>>> +#include <linux/of.h>
>>>>>>>      #include <linux/slab.h>
>>>>>>>      #include <linux/major.h>
>>>>>>>      #include "ubi.h"
>>>>>>> @@ -1065,6 +1066,7 @@ int ubi_attach_mtd_dev(struct mtd_info *mtd, int ubi_num,
>>>>>>>       * ubi_detach_mtd_dev - detach an MTD device.
>>>>>>>       * @ubi_num: UBI device number to detach from
>>>>>>>       * @anyway: detach MTD even if device reference count is not zero
>>>>>>> + * @have_lock: called by MTD notifier holding mtd_table_mutex
>>>>>>>       *
>>>>>>>       * This function destroys an UBI device number @ubi_num and detaches the
>>>>>>>       * underlying MTD device. Returns zero in case of success and %-EBUSY if the
>>>>>>> @@ -1074,7 +1076,7 @@ int ubi_attach_mtd_dev(struct mtd_info *mtd, int ubi_num,
>>>>>>>       * Note, the invocations of this function has to be serialized by the
>>>>>>>       * @ubi_devices_mutex.
>>>>>>>       */
>>>>>>> -int ubi_detach_mtd_dev(int ubi_num, int anyway)
>>>>>>> +int ubi_detach_mtd_dev(int ubi_num, int anyway, bool have_lock)
>>>>>>>      {
>>>>>>>      	struct ubi_device *ubi;
>>>>>>> @@ -1108,7 +1110,7 @@ int ubi_detach_mtd_dev(int ubi_num, int anyway)
>>>>>>>      	 * EC updates that have been made since the last written fastmap.
>>>>>>>      	 * In case of fastmap debugging we omit the update to simulate an
>>>>>>>      	 * unclean shutdown. */
>>>>>>> -	if (!ubi_dbg_chk_fastmap(ubi))
>>>>>>> +	if (!have_lock && !ubi_dbg_chk_fastmap(ubi))
>>>>>>>      		ubi_update_fastmap(ubi);
>>>>>>
>>>>>> Why do you skip updating fastmap if ubi is detached in mtd notification way?
>>>>>
>>>>> The reason here is simple: Once we receive a notification about the MTD
>>>>> device being removed it is too late to update fastmap. The device is
>>>>> gone, nothing we can do about that any more. Just like removing a
>>>>> device holding a filesystem without having priorly unmounted it, e.g.
>>>>> if you 'rmmod usb-storage' (just that block devices unfortunately still
>>>>> lack notifications about removal or size changes...)
>>>>>
>>>>
>>>> Another path still operate mtd device:
>>>> ubi_detach_mtd_dev -> ubi_wl_close -> shutdown_work -> wrk->func ->
>>>> erase_worker -> sync_erase -> ubi_io_sync_erase/ubi_io_write_ec_hdr.
>>>
>>> True, but I didn't see this being a problem, at least in the sense
>>> that I didn't see a kernel panic. We could try to make
>>> ubi_update_fastmap more robust to gracefully return in case the device
>>> is already gone.
>>>
>>
>> You mean ubi_update_fastmap() could trigger panic in ubi_notify_remove()
>> when you remove the SPI bus dirver? May I have the error message?
> 
> I spent a day stairing at the kernel Oops and found that it was unrelated
> to UBI, but rather a bug in the SPI driver. I've posted the fix:
> 
> https://patchwork.kernel.org/project/spi-devel-general/patch/ZFAF6pJxMu1z6k4w@makrotopia.org/
> 
>> I thought both ubi_update_fastmap() and ubi_wl_close() could operate the
>> removed mtd device, it will be better to notify user error messages of
>> ubi_update_fastmap() casued by removing under layer device.
> 
> You were right, there is no problem there and we don't need to skip
> ubi_update_fastmap() now that the SPI driver makes sure to complete
> any ongoing operation before unloading (see above).
> 

Great.

>>
>>>>
>>>> Besides, can we remove any mtd specific driver(eg. phram/nandsim) by rmmod?
>>>
>>> My test-case was to remove the SPI bus driver on which the SPI-NAND chip
>>> is connected to. Afaik there is also no way to prevent this at this
>>> point, we'd have to propagate the usecount of the MTD device down to
>>> the SPI bus hosting it.
>>>
>>>> I notice that get_mtd_device(called before ubi attaching) will increase
>>>> specific mtd driver's module refcnt.
>>>> If we physically remove the mtd device, will it trigger del_mtd_device()?
>>>
>>> Yes, in case what you mean is an SPI-NAND flash connected to an SPI-USB
>>> adapter, and then pulling the USB device.
>>>
>>>> For example, when is phram_remove() called?
>>>
>>>>  From what I can see:
>>> phram_remove -> mtd_device_unregister -> del_mtd_device -> [for all
>>> elements of list mtd_notifiers call their 'remove' function]
>>>
>>> After this we should always end up with mtd->usecount == 0 and hence
>>> proceed. If usecount != 0 at this point there is currently no meaningful
>>> error handling in mtdcore.c as far as my interpretation goes.
> 
> I've found a similar issue with "fake error handling" on removal which
> should rather be skipped in drivers/mtd/ubi/block.c. I will post the
> fix also in the upcoming series which I'm preparing right now.
> 
> .
> 


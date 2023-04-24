Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B06576EC3E7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 05:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjDXD0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 23:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjDXD0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 23:26:31 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D93621BD8
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 20:26:28 -0700 (PDT)
Received: from kwepemm600013.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Q4Vqk5XYCzsRhC;
        Mon, 24 Apr 2023 11:24:50 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 24 Apr 2023 11:26:25 +0800
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
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <f50a0d60-356a-6206-3363-e0f80870c754@huawei.com>
Date:   Mon, 24 Apr 2023 11:26:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <ZEW8VS4Y-dVRcGGy@makrotopia.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ÔÚ 2023/4/24 7:16, Daniel Golle Ð´µÀ:
> Hi Zhihao,
> 
> thank you for taking the time to review this patch.
> 
> On Sun, Apr 23, 2023 at 04:35:28PM +0800, Zhihao Cheng wrote:
>> Hi Daniel,
>>> Split ubi_init() function into early function to be called by
>>> device_initcall() and keep cmdline attachment in late_initcall().
>>> (when building ubi as module, both is still done in a single
>>> module_init() call)
>>>
>>> Register MTD notifier and attach MTD devices which are marked as
>>> compatible with 'linux,ubi' in OF device-tree when being added, detach
>>> UBI device from MTD device when it is being removed.
>>>
>>> Keep behavior regarding ubiblock creation and attaching of UBI device
>>> from kernel or module cmdline unchanged.
>>>
>>> For existing users this should not change anything besides automatic
>>> removal of (dead) UBI devices when their underlying MTD devices are
>>> already gone, e.g. in case of MTD driver module or (SPI) bus driver
>>> module being removed.
>>>
>>> For new users this opens up the option to attach UBI using device-tree
>>> which then happens early and in parallel with other drivers being
>>> probed which slightly reduces the total boot time.
>>>
>>> Attachment no longer happening late is also a requirement for other
>>> drivers to make use of UBI, e.g. drivers/nvmem/u-boot-env.c can now
>>> be extended to support U-Boot environment stored in UBI volumes.
>>>
>>
>> Let me try to understand this patch, the main purpose is to add a new way to
>> load ubi according to device tree, am I right?
> 
> You are right about one aspect of this patch, yes it does add another
> way to attach MTD devices, by utilizing a devicetree compatible
> 'linux,ubi' which can be set for MTD devices (or partitions).
> The other, and maybe even more significant aspect is that it moves
> attaching the MTD device from being a late_initcall() to rather register
> an MTD user driver instead and hence happen as a direct consequence of
> the MTD device showing up.

It means mtd device probing and loading will autimically triggers ubi 
attaching by ubi_notify_add(), right?
If so, I thought of a scenario like this: The mtd device 
probing/removing will autimically loading/removing UBI device, now it 
can be done without any orders(cmdlines/ioctl) in running time. I think 
it's valuable.

> This will be important when using UBI e.g. as an NVMEM provider:
> E.g. on Wi-Fi routers it has become common for vendors to store the
> bootloader environment, Ethernet MAC addresses or Wi-Fi calibration
> data inside an UBI volume (and I don't mean as a file inside a
> filesystem, but really just the UBI volume exposing nvmem cells for
> other drivers). See [1] for an example.
> 

Thanks for introducing the background.

>>
>>> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
>>> ---
>>>    drivers/mtd/ubi/block.c |  20 ++---
>>>    drivers/mtd/ubi/build.c | 163 +++++++++++++++++++++++++++++-----------
>>>    drivers/mtd/ubi/cdev.c  |   2 +-
>>>    drivers/mtd/ubi/ubi.h   |   4 +-
>>>    4 files changed, 132 insertions(+), 57 deletions(-)
>>>
>>> diff --git a/drivers/mtd/ubi/block.c b/drivers/mtd/ubi/block.c
>>> index 3711d7f746003..b24b8b8f54b77 100644
>>> --- a/drivers/mtd/ubi/block.c
>>> +++ b/drivers/mtd/ubi/block.c
>>> @@ -65,10 +65,10 @@ struct ubiblock_pdu {
>>>    };
>>>    /* Numbers of elements set in the @ubiblock_param array */
>>> -static int ubiblock_devs __initdata;
>>> +static int ubiblock_devs;
>>>    /* MTD devices specification parameters */
>>> -static struct ubiblock_param ubiblock_param[UBIBLOCK_MAX_DEVICES] __initdata;
>>> +static struct ubiblock_param ubiblock_param[UBIBLOCK_MAX_DEVICES];
>>>    struct ubiblock {
>>>    	struct ubi_volume_desc *desc;
>>> @@ -582,7 +582,7 @@ open_volume_desc(const char *name, int ubi_num, int vol_id)
>>>    		return ubi_open_volume(ubi_num, vol_id, UBI_READONLY);
>>>    }
>>> -static void __init ubiblock_create_from_param(void)
>>> +void ubiblock_create_from_param(void)
>>>    {
>>>    	int i, ret = 0;
>>>    	struct ubiblock_param *p;
>>> @@ -611,9 +611,10 @@ static void __init ubiblock_create_from_param(void)
>>>    		ret = ubiblock_create(&vi);
>>>    		if (ret) {
>>> -			pr_err(
>>> -			       "UBI: block: can't add '%s' volume on ubi%d_%d, err=%d\n",
>>> -			       vi.name, p->ubi_num, p->vol_id, ret);
>>> +			if (ret != -EEXIST && ret != -ENOENT)
>>
>> The EEXIST and ENOENT types of error messages are filtered, why? After this
>> patch applied, the user won't be aware of which ubi volume failed to create
>> ubiblock.
> 
> The EEXIST and ENOENT errors as filtered as they may happen now without
> that actually being an error.
> ubiblock_create_from_param is potentially being called multiple times,
> each time a new UBI device is attached in the "new" MTD user/device-tree
> way, and also once in "classic" late_initcall way.
> 

I agree, the second caller could trigger EEXIST. But how ENOENT happens, 
do you mean 
ubi_notify_add->ubiblock_create_from_param->open_volume_desc? Could you 
show me path?

> One way to partially resolve this could be to add a boolean parameter to
> ubiblock_create_from_param which indicates if -ENOENT should be treated
> as an error, and set that parameter only when calling from
> late_initcall.
> 
> Being able to warn users if they added the same ubiblock device more
> than once **on the cmdline or module parameter** is more tricky and
> would require tracking why a ubiblock device has previously been
> created. However, I don't think that emitting a warning in this case
> is crucial at all, the user definitely wanted the ubiblock device to be
> created and saying that more than once is unneccesary but yet also
> doesn't leave room for any interpretation other than just that the user
> *really* wants the ubiblock to be created.

Emm, I prefer to fix it, it's weird that ubiblock_create_from_param() 
being executed multiple times(Each ubi_notify_add() will call once, 
late_initcall will call it again). User could see many false positive 
error messages.

> 
>>
>>> +				pr_err(
>>> +				       "UBI: block: can't add '%s' volume on ubi%d_%d, err=%d\n",
>>> +				       vi.name, p->ubi_num, p->vol_id, ret);
>>>    			continue;
>>>    		}
>>>    	}
>>> @@ -644,13 +645,6 @@ int __init ubiblock_init(void)
>>>    	if (ubiblock_major < 0)
>>>    		return ubiblock_major;
>>> -	/*
>>> -	 * Attach block devices from 'block=' module param.
>>> -	 * Even if one block device in the param list fails to come up,
>>> -	 * still allow the module to load and leave any others up.
>>> -	 */
>>> -	ubiblock_create_from_param();
>>> -
>>>    	/*
>>>    	 * Block devices are only created upon user requests, so we ignore
>>>    	 * existing volumes.
>>> diff --git a/drivers/mtd/ubi/build.c b/drivers/mtd/ubi/build.c
>>> index 9cd565daad368..a764f97eee791 100644
>>> --- a/drivers/mtd/ubi/build.c
>>> +++ b/drivers/mtd/ubi/build.c
>>> @@ -27,6 +27,7 @@
>>>    #include <linux/log2.h>
>>>    #include <linux/kthread.h>
>>>    #include <linux/kernel.h>
>>> +#include <linux/of.h>
>>>    #include <linux/slab.h>
>>>    #include <linux/major.h>
>>>    #include "ubi.h"
>>> @@ -1065,6 +1066,7 @@ int ubi_attach_mtd_dev(struct mtd_info *mtd, int ubi_num,
>>>     * ubi_detach_mtd_dev - detach an MTD device.
>>>     * @ubi_num: UBI device number to detach from
>>>     * @anyway: detach MTD even if device reference count is not zero
>>> + * @have_lock: called by MTD notifier holding mtd_table_mutex
>>>     *
>>>     * This function destroys an UBI device number @ubi_num and detaches the
>>>     * underlying MTD device. Returns zero in case of success and %-EBUSY if the
>>> @@ -1074,7 +1076,7 @@ int ubi_attach_mtd_dev(struct mtd_info *mtd, int ubi_num,
>>>     * Note, the invocations of this function has to be serialized by the
>>>     * @ubi_devices_mutex.
>>>     */
>>> -int ubi_detach_mtd_dev(int ubi_num, int anyway)
>>> +int ubi_detach_mtd_dev(int ubi_num, int anyway, bool have_lock)
>>>    {
>>>    	struct ubi_device *ubi;
>>> @@ -1108,7 +1110,7 @@ int ubi_detach_mtd_dev(int ubi_num, int anyway)
>>>    	 * EC updates that have been made since the last written fastmap.
>>>    	 * In case of fastmap debugging we omit the update to simulate an
>>>    	 * unclean shutdown. */
>>> -	if (!ubi_dbg_chk_fastmap(ubi))
>>> +	if (!have_lock && !ubi_dbg_chk_fastmap(ubi))
>>>    		ubi_update_fastmap(ubi);
>>
>> Why do you skip updating fastmap if ubi is detached in mtd notification way?
> 
> The reason here is simple: Once we receive a notification about the MTD
> device being removed it is too late to update fastmap. The device is
> gone, nothing we can do about that any more. Just like removing a
> device holding a filesystem without having priorly unmounted it, e.g.
> if you 'rmmod usb-storage' (just that block devices unfortunately still
> lack notifications about removal or size changes...)
> 

Another path still operate mtd device:
ubi_detach_mtd_dev -> ubi_wl_close -> shutdown_work -> wrk->func -> 
erase_worker -> sync_erase -> ubi_io_sync_erase/ubi_io_write_ec_hdr.

Besides, can we remove any mtd specific driver(eg. phram/nandsim) by 
rmmod? I notice that get_mtd_device(called before ubi attaching) will 
increase specific mtd driver's module refcnt.
If we physically remove the mtd device, will it trigger 
del_mtd_device()? For example, when is phram_remove() called?



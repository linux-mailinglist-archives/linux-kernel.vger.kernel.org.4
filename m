Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1731650E98
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 16:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232136AbiLSP2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 10:28:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231783AbiLSP2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 10:28:04 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2206467
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 07:28:02 -0800 (PST)
Received: from kwepemm600001.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NbNq94b6dzJqHG;
        Mon, 19 Dec 2022 23:27:01 +0800 (CST)
Received: from [10.174.176.245] (10.174.176.245) by
 kwepemm600001.china.huawei.com (7.193.23.3) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 19 Dec 2022 23:27:59 +0800
Message-ID: <dd4d0619-8287-1650-aa43-5db2e86ff8cd@huawei.com>
Date:   Mon, 19 Dec 2022 23:27:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] kobject: Fix slab-out-of-bounds in fill_kobj_path()
To:     Greg KH <gregkh@linuxfoundation.org>,
        Alice Chao <alice.chao@mediatek.com>
CC:     <rafael@kernel.org>, <jesse.brandeburg@intel.com>,
        <anthony.l.nguyen@intel.com>, <intel-wired-lan@lists.osuosl.org>,
        <linux-kernel@vger.kernel.org>
References: <20221219144103.34789-1-wanghai38@huawei.com>
 <Y6B7MKZxjaoQlpgf@kroah.com>
From:   "wanghai (M)" <wanghai38@huawei.com>
In-Reply-To: <Y6B7MKZxjaoQlpgf@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.245]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600001.china.huawei.com (7.193.23.3)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/12/19 22:54, Greg KH 写道:
> On Mon, Dec 19, 2022 at 10:41:03PM +0800, Wang Hai wrote:
>> In kobject_get_path(), if kobj->name is changed between calls
>> get_kobj_path_length() and fill_kobj_path() and the length becomes
>> longer, then fill_kobj_path() will have an out-of-bounds bug.
>>
>> The actual current problem occurs when the ixgbe probe.
>>
>> In ixgbe_mii_bus_init(), if the length of netdev->dev.kobj.name
>> length becomes longer, out-of-bounds will occur.
>>
>> cpu0                                         cpu1
>> ixgbe_probe
>>   register_netdev(netdev)
>>    netdev_register_kobject
>>     device_add
>>      kobject_uevent // Sending ADD events
>>                                               systemd-udevd // rename netdev
>>                                                dev_change_name
>>                                                 device_rename
>>                                                  kobject_rename
>>                                                  |
>>   ixgbe_mii_bus_init                             |
>>    mdiobus_register                              |
>>     __mdiobus_register                           |
>>      device_register                             |
>>       device_add                                 |
>>        kobject_uevent                            |
>>         kobject_get_path                         |
>>          len = get_kobj_path_length // old name  |
>>          path = kzalloc(len, gfp_mask);          |
>>                                                  kobj->name = name;
>>                                                  /* name length becomes
>>                                                   * longer
>>                                                   */
>>          fill_kobj_path /* kobj path length is
>>                          * longer than path,
>>                          * resulting in out of
>>                          * bounds when filling path
>>                          */
>>
>> This is the kasan report:
>>
>> ==================================================================
>> BUG: KASAN: slab-out-of-bounds in fill_kobj_path+0x50/0xc0
>> Write of size 7 at addr ff1100090573d1fd by task kworker/28:1/673
>>
>>   Workqueue: events work_for_cpu_fn
>>   Call Trace:
>>   <TASK>
>>   dump_stack_lvl+0x34/0x48
>>   print_address_description.constprop.0+0x86/0x1e7
>>   print_report+0x36/0x4f
>>   kasan_report+0xad/0x130
>>   kasan_check_range+0x35/0x1c0
>>   memcpy+0x39/0x60
>>   fill_kobj_path+0x50/0xc0
>>   kobject_get_path+0x5a/0xc0
>>   kobject_uevent_env+0x140/0x460
>>   device_add+0x5c7/0x910
>>   __mdiobus_register+0x14e/0x490
>>   ixgbe_probe.cold+0x441/0x574 [ixgbe]
>>   local_pci_probe+0x78/0xc0
>>   work_for_cpu_fn+0x26/0x40
>>   process_one_work+0x3b6/0x6a0
>>   worker_thread+0x368/0x520
>>   kthread+0x165/0x1a0
>>   ret_from_fork+0x1f/0x30
>>
>> This reproducer triggers that bug:
>>
>> while:
>> do
>>      rmmod ixgbe
>>      sleep 0.5
>>      modprobe ixgbe
>>      sleep 0.5
>>
>> When calling fill_kobj_path() to fill path, if the name length of
>> kobj becomes longer, return failure and retry.
>>
>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>> Signed-off-by: Wang Hai <wanghai38@huawei.com>
>> ---
>>   lib/kobject.c | 14 ++++++++++++--
>>   1 file changed, 12 insertions(+), 2 deletions(-)
> Nice find, and a much better description than was reported here:
> 	https://lore.kernel.org/all/20221216031320.2634-1-alice.chao@mediatek.com/
>
> Alice, does this patch resolve your problem as well?
>
>> diff --git a/lib/kobject.c b/lib/kobject.c
>> index a0b2dbfcfa23..d129f437b200 100644
>> --- a/lib/kobject.c
>> +++ b/lib/kobject.c
>> @@ -112,7 +112,7 @@ static int get_kobj_path_length(struct kobject *kobj)
>>   	return length;
>>   }
>>   
>> -static void fill_kobj_path(struct kobject *kobj, char *path, int length)
>> +static bool fill_kobj_path(struct kobject *kobj, char *path, int length)
> Just return an int and an error value, bool isn't a normal return value,
> right?

Hi, Greg.

Thanks for the suggestion, I will change it to int.

>>   {
>>   	struct kobject *parent;
>>   
>> @@ -121,12 +121,16 @@ static void fill_kobj_path(struct kobject *kobj, char *path, int length)
>>   		int cur = strlen(kobject_name(parent));
>>   		/* back up enough to print this name with '/' */
>>   		length -= cur;
>> +		if (length < 0)
>> +			return false;
> Return -EINVAL or something?
>
> What if length ends up 0 here, is that going to be ok?
If length is 0, there is not enough space for '/', which is also
problematic. Thank you for the reminder.
>
>>   		memcpy(path + length, kobject_name(parent), cur);
>>   		*(path + --length) = '/';
>>   	}
>>   
>>   	pr_debug("kobject: '%s' (%p): %s: path = '%s'\n", kobject_name(kobj),
>>   		 kobj, __func__, path);
>> +
>> +	return true;
> return 0;
>
>>   }
>>   
>>   /**
>> @@ -140,14 +144,20 @@ char *kobject_get_path(struct kobject *kobj, gfp_t gfp_mask)
>>   {
>>   	char *path;
>>   	int len;
>> +	bool ret;
> No need for this variable
>
>>   
>> +retry:
>>   	len = get_kobj_path_length(kobj);
>>   	if (len == 0)
>>   		return NULL;
>>   	path = kzalloc(len, gfp_mask);
>>   	if (!path)
>>   		return NULL;
>> -	fill_kobj_path(kobj, path, len);
>> +	ret = fill_kobj_path(kobj, path, len);
>> +	if (!ret) {
> Make this one line:
>
> 	if (fill_kobj_path(kobj, path, len)) {
>
> But, you now have a loop, what guarantees that you can get out of it?

fill_kobj_path() may fail only when the name of kobj or parent is changed,
this change does not happen forever.

And when retrying, the length of the current kobj path is recalculated,
which can guarantee that the length is satisfied next time.


Can I send v2 like this?

diff --git a/lib/kobject.c b/lib/kobject.c
index a0b2dbfcfa23..3f97d903266a 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -112,7 +112,7 @@ static int get_kobj_path_length(struct kobject *kobj)
         return length;
  }

-static void fill_kobj_path(struct kobject *kobj, char *path, int length)
+static int fill_kobj_path(struct kobject *kobj, char *path, int length)
  {
         struct kobject *parent;

@@ -121,12 +121,16 @@ static void fill_kobj_path(struct kobject *kobj, 
char *path, int length)
                 int cur = strlen(kobject_name(parent));
                 /* back up enough to print this name with '/' */
                 length -= cur;
+               if (length <= 0)
+                       return -EINVAL;
                 memcpy(path + length, kobject_name(parent), cur);
                 *(path + --length) = '/';
         }

         pr_debug("kobject: '%s' (%p): %s: path = '%s'\n", 
kobject_name(kobj),
                  kobj, __func__, path);
+
+       return 0;
  }

  /**
@@ -141,13 +145,17 @@ char *kobject_get_path(struct kobject *kobj, gfp_t 
gfp_mask)
         char *path;
         int len;

+retry:
         len = get_kobj_path_length(kobj);
         if (len == 0)
                 return NULL;
         path = kzalloc(len, gfp_mask);
         if (!path)
                 return NULL;
-       fill_kobj_path(kobj, path, len);
+       if (fill_kobj_path(kobj, path, len)) {
+               kfree(path);
+               goto retry;
+       }

         return path;
  }

>
> thanks,
>
> greg k-h
> .

-- 
Wang Hai


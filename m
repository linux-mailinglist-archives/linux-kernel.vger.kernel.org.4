Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0516A62537A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 07:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232287AbiKKGVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 01:21:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiKKGVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 01:21:38 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61AF55E9FA
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 22:21:37 -0800 (PST)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N7pW75wmKzRp00;
        Fri, 11 Nov 2022 14:21:23 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 11 Nov 2022 14:21:35 +0800
Received: from [10.67.108.67] (10.67.108.67) by dggpemm500013.china.huawei.com
 (7.185.36.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 11 Nov
 2022 14:21:35 +0800
Message-ID: <bcd6ba6d-3652-f1cc-bdb9-e7ad16fb3e71@huawei.com>
Date:   Fri, 11 Nov 2022 14:21:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH v2] firmware: dmi-sysfs: Fix null-ptr-deref in
 dmi_sysfs_register_handle
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linmq006@gmail.com>
References: <20221111015326.251650-1-chenzhongjin@huawei.com>
 <20221111015326.251650-2-chenzhongjin@huawei.com>
 <Y23pUlitIuqdyd0g@kroah.com>
From:   Chen Zhongjin <chenzhongjin@huawei.com>
In-Reply-To: <Y23pUlitIuqdyd0g@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.108.67]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2022/11/11 14:18, Greg KH wrote:
> On Fri, Nov 11, 2022 at 09:53:26AM +0800, Chen Zhongjin wrote:
>> KASAN reported a null-ptr-deref error:
>>
>> KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
>> CPU: 0 PID: 1373 Comm: modprobe
>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
>> RIP: 0010:dmi_sysfs_entry_release
>> ...
>> Call Trace:
>>   <TASK>
>>   kobject_put
>>   dmi_sysfs_register_handle (drivers/firmware/dmi-sysfs.c:540) dmi_sysfs
>>   dmi_decode_table (drivers/firmware/dmi_scan.c:133)
>>   dmi_walk (drivers/firmware/dmi_scan.c:1115)
>>   dmi_sysfs_init (drivers/firmware/dmi-sysfs.c:149) dmi_sysfs
>>   do_one_initcall (init/main.c:1296)
>>   ...
>> Kernel panic - not syncing: Fatal exception
>> Kernel Offset: 0x4000000 from 0xffffffff81000000
>> ---[ end Kernel panic - not syncing: Fatal exception ]---
>>
>> It is because previous patch added kobject_put() to release the memory
>> which will call  dmi_sysfs_entry_release() and list_del().
>>
>> However, list_add_tail(entry->list) is called after the error block,
>> so the list_head is uninitialized and cannot be deleted.
>>
>> Move error handling to after list_add_tail to fix this.
>>
>> Fixes: 660ba678f999 ("firmware: dmi-sysfs: Fix memory leak in dmi_sysfs_register_handle")
>> Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
>> ---
>> v1 -> v2:
>> Change fix to moving error handling to after list_add_tail.
>> So that it is consistent with kobject_put(&entry->kobj) in other
>> places.
> <snip>
>
> I got 2 copies of this, which one is correct?

Sorry I accidentally re-sent this, they are all same.

Thanks!

Chen

> thanks,
>
> greg k-h

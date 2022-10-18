Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B24D060295D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 12:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbiJRKdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 06:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbiJRKdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 06:33:33 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FAFEB40CD
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 03:33:31 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Ms97p3ztxzVhsb;
        Tue, 18 Oct 2022 18:28:54 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 18 Oct 2022 18:33:30 +0800
Received: from [10.174.178.174] (10.174.178.174) by
 dggpemm500007.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 18 Oct 2022 18:33:29 +0800
Subject: Re: [PATCH] ocfs2: possible memory leak in mlog_sys_init()
To:     Joseph Qi <joseph.qi@linux.alibaba.com>,
        <linux-kernel@vger.kernel.org>, <ocfs2-devel@oss.oracle.com>
CC:     <mark@fasheh.com>, <jlbec@evilplan.org>,
        <gregkh@linuxfoundation.org>, <akpm@linux-foundation.org>
References: <20221018075213.736562-1-yangyingliang@huawei.com>
 <bf27f347-5ced-98e5-f188-659cc2a9736f@linux.alibaba.com>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <09bb2844-e20a-98e8-c2af-5b6c4795d48e@huawei.com>
Date:   Tue, 18 Oct 2022 18:33:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <bf27f347-5ced-98e5-f188-659cc2a9736f@linux.alibaba.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500007.china.huawei.com (7.185.36.183)
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

On 2022/10/18 17:02, Joseph Qi wrote:
> Hi,
>
> On 10/18/22 3:52 PM, Yang Yingliang wrote:
>> Inject fault while probing module, kset_register() may fail,
>> if it fails, but the refcount of kobject is not decreased to
>> 0, the name allocated in kobject_set_name() is leaked. Fix
>> this by calling kset_put(), so that name can be freed in
>> callback function kobject_cleanup().
>>
>> unreferenced object 0xffff888100da9348 (size 8):
>>    comm "modprobe", pid 257, jiffies 4294701096 (age 33.334s)
>>    hex dump (first 8 bytes):
>>      6c 6f 67 6d 61 73 6b 00                          logmask.
>>    backtrace:
>>      [<00000000306e441c>] __kmalloc_node_track_caller+0x44/0x1b0
>>      [<000000007c491a9e>] kstrdup+0x3a/0x70
>>      [<0000000015719a3b>] kstrdup_const+0x63/0x80
>>      [<0000000084e458ea>] kvasprintf_const+0x149/0x180
>>      [<0000000091302b42>] kobject_set_name_vargs+0x56/0x150
>>      [<000000005f48eeac>] kobject_set_name+0xab/0xe0
>>
>> Fixes: 34980ca8faeb ("Drivers: clean up direct setting of the name of a kset")
>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
>> ---
>>   fs/ocfs2/cluster/masklog.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/ocfs2/cluster/masklog.c b/fs/ocfs2/cluster/masklog.c
>> index 563881ddbf00..7f9ba816d955 100644
>> --- a/fs/ocfs2/cluster/masklog.c
>> +++ b/fs/ocfs2/cluster/masklog.c
>> @@ -156,6 +156,7 @@ static struct kset mlog_kset = {
>>   int mlog_sys_init(struct kset *o2cb_kset)
>>   {
>>   	int i = 0;
>> +	int ret;
>>   
>>   	while (mlog_attrs[i].attr.mode) {
>>   		mlog_default_attrs[i] = &mlog_attrs[i].attr;
>> @@ -165,7 +166,11 @@ int mlog_sys_init(struct kset *o2cb_kset)
>>   
>>   	kobject_set_name(&mlog_kset.kobj, "logmask");
>>   	mlog_kset.kobj.kset = o2cb_kset;
>> -	return kset_register(&mlog_kset);
>> +	ret = kset_register(&mlog_kset);
> If register fails, it will call unregister in o2cb_sys_init(), which
> will put kobject.
They are different ksets, the kset unregistered in o2cb_sys_init() is 
'o2cb_kset', the
kset used to registered in mlog_sys_init() is 'mlog_kset', and they hold 
difference
refcounts.

Thanks,
Yang
>
> Thanks,
> Joseph
>
>> +	if (ret)
>> +		kset_put(&mlog_kset);
>> +
>> +	return ret;
>>   }
>>   
>>   void mlog_sys_shutdown(void)
> .

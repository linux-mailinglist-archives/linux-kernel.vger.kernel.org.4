Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40D40643AFE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 02:53:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbiLFBxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 20:53:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233561AbiLFBxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 20:53:43 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D48822295
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 17:53:39 -0800 (PST)
Received: from dggpemm500013.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NR3Ml0Z8jz15N4y;
        Tue,  6 Dec 2022 09:52:51 +0800 (CST)
Received: from [10.67.108.67] (10.67.108.67) by dggpemm500013.china.huawei.com
 (7.185.36.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 6 Dec
 2022 09:53:38 +0800
Message-ID: <8f90dbbe-51b0-67c8-d6cb-3bd9c1d9d481@huawei.com>
Date:   Tue, 6 Dec 2022 09:53:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH] vme: Fix error not catched in fake_init()
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <linux-staging@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <martyn@welchs.me.uk>, <manohar.vanga@gmail.com>, <arnd@arndb.de>
References: <20221205084805.147436-1-chenzhongjin@huawei.com>
 <Y43kr/73sorrMWA0@kroah.com>
Content-Language: en-US
From:   Chen Zhongjin <chenzhongjin@huawei.com>
In-Reply-To: <Y43kr/73sorrMWA0@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.108.67]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2022/12/5 20:31, Greg KH wrote:
> On Mon, Dec 05, 2022 at 04:48:05PM +0800, Chen Zhongjin wrote:
>> In fake_init(), __root_device_register() is possible to fail but it's
>> ignored, which can cause unregistering vme_root fail when exit.
>>
>>   general protection fault,
>>   probably for non-canonical address 0xdffffc000000008c
>>   KASAN: null-ptr-deref in range [0x0000000000000460-0x0000000000000467]
>>   RIP: 0010:root_device_unregister+0x26/0x60
>>   Call Trace:
>>    <TASK>
>>    __x64_sys_delete_module+0x34f/0x540
>>    do_syscall_64+0x38/0x90
>>    entry_SYSCALL_64_after_hwframe+0x63/0xcd
>>
>> Return error when __root_device_register() fails.
>>
>> Fixes: 658bcdae9c67 ("vme: Adding Fake VME driver")
>> Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
>> ---
>>   drivers/staging/vme_user/vme_fake.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/staging/vme_user/vme_fake.c b/drivers/staging/vme_user/vme_fake.c
>> index dd646b0c531d..1ee432c223e2 100644
>> --- a/drivers/staging/vme_user/vme_fake.c
>> +++ b/drivers/staging/vme_user/vme_fake.c
>> @@ -1073,6 +1073,8 @@ static int __init fake_init(void)
>>   
>>   	/* We need a fake parent device */
>>   	vme_root = __root_device_register("vme", THIS_MODULE);
> This should be calling root_device_register() as well, not this version
> of the call.
Of course it should. Have sent another patch for it.

Thanks for your time!
Chen
> thanks,
>
> greg k-h

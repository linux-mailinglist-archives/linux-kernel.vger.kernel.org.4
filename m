Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C94F16AD9DE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 10:08:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbjCGJIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 04:08:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjCGJIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 04:08:17 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA4332E79
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 01:08:15 -0800 (PST)
Received: from kwepemi500009.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PW8jD3qnNzrSDN;
        Tue,  7 Mar 2023 17:07:28 +0800 (CST)
Received: from [10.67.110.89] (10.67.110.89) by kwepemi500009.china.huawei.com
 (7.221.188.199) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Tue, 7 Mar
 2023 17:08:13 +0800
Message-ID: <396e6a21-5270-1624-1229-1e59701cce35@huawei.com>
Date:   Tue, 7 Mar 2023 17:08:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH] kobject: Fix global-out-of-bounds in
 kobject_action_type()
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <prajnoha@redhat.com>, <linux-kernel@vger.kernel.org>
References: <20230307063757.247430-1-xiafukun@huawei.com>
 <ZAby1q1kA71S2WCv@kroah.com>
From:   Xia Fukun <xiafukun@huawei.com>
In-Reply-To: <ZAby1q1kA71S2WCv@kroah.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.89]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500009.china.huawei.com (7.221.188.199)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your reply.
Your understanding is correct."offline\0\0\0\0\0\0\0\0\0\0" is indeed blocked
from matching "offline" and returns a failed result.

I'm not sure whether to relax the restrictions to make it match successfully.
After all, the incoming count is too large and not the actual length of
"offline".

在 2023/3/7 16:16, Greg KH 写道:
> On Tue, Mar 07, 2023 at 02:37:57PM +0800, Xia Fukun wrote:
>> The following c language code can trigger KASAN's global variable
>> out-of-bounds access error in kobject_action_type():
>>
>>
>> diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
>> index 7c44b7ae4c5c..668346bd28fa 100644
>> --- a/lib/kobject_uevent.c
>> +++ b/lib/kobject_uevent.c
>> @@ -84,7 +84,7 @@ static int kobject_action_type(const char *buf, size_t count,
>>  	for (action = 0; action < ARRAY_SIZE(kobject_actions); action++) {
>>  		if (strncmp(kobject_actions[action], buf, count_first) != 0)
>>  			continue;
>> -		if (kobject_actions[action][count_first] != '\0')
>> +		if (strlen(kobject_actions[action]) != count_first)
>>  			continue;
>>  		if (args)
>>  			*args = args_start;
> 
> Yes, this will stop us from reading a read-only location somewhere in
> the kernel outside of the string array, but is it still doing the same
> functional logic here?
> 
> In your change, this call to strlen will cause the length check to fail,
> so the loop will continue on, and the type will never be set properly.
> Is that correct in your testing?  You just prevented a string of
> "offline\0\0\0\0\0\0\0\0\0\0" from properly being parsed as an offline
> event, which I don't think is what you meant to do, right?
> 
> Or am I reading this code incorrectly?  It really could be cleaned up,
> it's not obvious at all.  Parsing strings in C is a mess...
> 
> thanks,
> 
> greg k-h
> 
> 


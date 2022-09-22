Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CFEF5E623A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 14:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbiIVMW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 08:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbiIVMWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 08:22:23 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16FBEE6A24
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 05:22:21 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MYDnF47P4zMn1v;
        Thu, 22 Sep 2022 20:17:37 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 20:22:20 +0800
Received: from [10.67.108.67] (10.67.108.67) by dggpemm500013.china.huawei.com
 (7.185.36.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 22 Sep
 2022 20:22:19 +0800
Message-ID: <316fc8ae-b96b-1fb6-4a24-b8bcc6f8b948@huawei.com>
Date:   Thu, 22 Sep 2022 20:22:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH -next] kcov: Switch to use list_for_each_entry() helper
Content-Language: en-US
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC:     <linux-kernel@vger.kernel.org>, <kasan-dev@googlegroups.com>,
        <liu3101@purdue.edu>, <nogikh@google.com>, <elver@google.com>,
        <akpm@linux-foundation.org>, <andreyknvl@gmail.com>,
        <dvyukov@google.com>
References: <20220922105025.119941-1-chenzhongjin@huawei.com>
 <YyxR2ErlHj6wrR6m@linutronix.de>
From:   Chen Zhongjin <chenzhongjin@huawei.com>
In-Reply-To: <YyxR2ErlHj6wrR6m@linutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.108.67]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/9/22 20:15, Sebastian Andrzej Siewior wrote:
> On 2022-09-22 18:50:25 [+0800], Chen Zhongjin wrote:
>> --- a/kernel/kcov.c
>> +++ b/kernel/kcov.c
>> @@ -133,10 +133,8 @@ static struct kcov_remote *kcov_remote_add(struct kcov *kcov, u64 handle)
>>   static struct kcov_remote_area *kcov_remote_area_get(unsigned int size)
>>   {
>>   	struct kcov_remote_area *area;
>> -	struct list_head *pos;
>>   
>> -	list_for_each(pos, &kcov_remote_areas) {
>> -		area = list_entry(pos, struct kcov_remote_area, list);
>> +	list_for_each_entry(pos, &kcov_remote_areas, list) {
> so how does this work if you remove pos?

Oops... will fix that.


Thanks so much!

>>   		if (area->size == size) {
>>   			list_del(&area->list);
>>   			return area;
> Sebastian

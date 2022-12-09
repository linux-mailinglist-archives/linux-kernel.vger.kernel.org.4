Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4370E647DA2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 07:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbiLIGP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 01:15:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiLIGPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 01:15:10 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E82C894904;
        Thu,  8 Dec 2022 22:15:09 -0800 (PST)
Received: from dggpeml100012.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NT11y64WxzRp9s;
        Fri,  9 Dec 2022 14:14:14 +0800 (CST)
Received: from [10.67.103.212] (10.67.103.212) by
 dggpeml100012.china.huawei.com (7.185.36.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 9 Dec 2022 14:15:08 +0800
Subject: Re: [PATCH v10 0/3] crypto: hisilicon - supports device isolation
 feature
To:     <gregkh@linuxfoundation.org>, <herbert@gondor.apana.org.au>
References: <20221119074817.12063-1-yekai13@huawei.com>
 <9b934709-2f74-7392-aab6-eb506ddcf708@huawei.com>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <liulongfang@huawei.com>
From:   "yekai (A)" <yekai13@huawei.com>
Message-ID: <75ca78c7-1ca3-3e62-1175-5207ed9f5cf8@huawei.com>
Date:   Fri, 9 Dec 2022 14:15:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <9b934709-2f74-7392-aab6-eb506ddcf708@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.103.212]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml100012.china.huawei.com (7.185.36.121)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/11/25 16:49, yekai (A) wrote:
>
> On 2022/11/19 15:48, Kai Ye wrote:
>> 1、Add the uacce hardware error isolation interface. Hardware error 
>>    thresholds can be configured by sysfs node. User can get the hardware
>>    isolated state by sysfs node.
>> 2、Defining the isolation strategy for uacce device by uacce sysfs node. 
>>    If the number of hardware errors exceeds the configured value, the 
>>    uacce device will not be available in user space.
>> 3、The ACC VF device use the PF device isolation strategy.
>>    
>> changes v1->v2:
>> 	- deleted dev_to_uacce api.
>> 	- add vfs node doc. 
>> 	- move uacce->ref to driver.
>> changes v2->v3:
>> 	- deleted some redundant code.
>> 	- use qm state instead of reference count.
>> 	- add null pointer check.
>> 	- isolate_strategy_read() instead of a copy.
>> changes v3->v4:
>> 	- modify a comment
>> changes v4->v5:
>> 	- use bool instead of atomic.
>> 	- isolation frequency instead of isolation command.
>> changes v5->v6:
>> 	- add is_visible in uacce.
>> 	- add the description of the isolation strategy file node.
>> changes v6->v7
>> 	- add an example for isolate_strategy in Documentation.
>> changes v7->v8
>> 	- update the correct date.
>> changes v8->v9
>>     - move isolation strategy from qm to uacce.
>> changes v9->v10
>> 	- Go back to the v8 version of the solution.
>> 	- Modify some code according to suggestions.
>>
>> Kai Ye (3):
>>   uacce: supports device isolation feature
>>   Documentation: add the device isolation feature sysfs nodes for uacce
>>   crypto: hisilicon/qm - define the device isolation strategy
>>
>>  Documentation/ABI/testing/sysfs-driver-uacce |  18 ++
>>  drivers/crypto/hisilicon/qm.c                | 169 +++++++++++++++++--
>>  drivers/misc/uacce/uacce.c                   |  50 ++++++
>>  include/linux/hisi_acc_qm.h                  |  15 ++
>>  include/linux/uacce.h                        |  12 ++
>>  5 files changed, 249 insertions(+), 15 deletions(-)
>>
> Hi Grek
>
> Just a friendly ping.
>
> Thanks
> Kai

Hi Greg KH

Could you help me to apply this patchset v10?

thanks
Kai


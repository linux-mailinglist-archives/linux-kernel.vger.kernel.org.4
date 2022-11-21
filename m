Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45ABF6318F9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 04:37:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiKUDhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 22:37:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiKUDhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 22:37:34 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ABA2DF8C;
        Sun, 20 Nov 2022 19:37:32 -0800 (PST)
Received: from kwepemi500024.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NFtNl63blzHvcB;
        Mon, 21 Nov 2022 11:36:55 +0800 (CST)
Received: from [10.174.179.163] (10.174.179.163) by
 kwepemi500024.china.huawei.com (7.221.188.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 21 Nov 2022 11:37:29 +0800
Message-ID: <f0c641ee-b20d-48dd-c65f-2b372eae0b06@huawei.com>
Date:   Mon, 21 Nov 2022 11:37:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
From:   Zeng Heng <zengheng4@huawei.com>
Subject: Re: [PATCH] of: overlay: fix memory leak in add_changeset_node()
To:     Frank Rowand <frowand.list@gmail.com>,
        <pantelis.antoniou@konsulko.com>, <grant.likely@linaro.org>,
        <robh+dt@kernel.org>
CC:     <liwei391@huawei.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20221118105308.370474-1-zengheng4@huawei.com>
 <8c8124c1-2de6-adfd-3e4b-766c653ebe2d@gmail.com>
Content-Language: en-US
In-Reply-To: <8c8124c1-2de6-adfd-3e4b-766c653ebe2d@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.163]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500024.china.huawei.com (7.221.188.100)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/11/21 10:00, Frank Rowand wrote:
> On 11/18/22 04:53, Zeng Heng wrote:
>> In of_changeset_action(), we have called of_node_get() to increase
>> refcount of a node.
>>
>> Therefore, when tchild (duplicated by __of_node_dup()) is done,
>> of_node_put() needs to call and release the device_node.
>>
>> Otherwise, there are some memory leak reported about the node:
>>
>> unreferenced object 0xffff88810cd1e800 (size 256):
>>    backtrace:
>>      kmalloc_trace
>>      __of_node_dup
>>      add_changeset_node (inlined)
>>      build_changeset_next_level
>>
>> unreferenced object 0xffff888113721240 (size 16):
>>    backtrace:
>>      __kmalloc_node_track_caller
>>      kstrdup
>>      __of_node_dup
>>      add_changeset_node (inlined)
>>      build_changeset_next_level
>>
>> unreferenced object 0xffff88810a38d400 (size 128):
>>    backtrace:
>>      kmalloc_trace
>>      __of_prop_dup
>>      add_changeset_property
>>      build_changeset_next_level
>>
>> Fixes: 7518b5890d8a ("of/overlay: Introduce DT overlay support")
>> Signed-off-by: Zeng Heng<zengheng4@huawei.com>
>> ---
>>   drivers/of/overlay.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
>> index bd8ff4df723d..a5189a0ec0a3 100644
>> --- a/drivers/of/overlay.c
>> +++ b/drivers/of/overlay.c
>> @@ -436,8 +436,10 @@ static int add_changeset_node(struct overlay_changeset *ovcs,
>>   		of_node_set_flag(tchild, OF_OVERLAY);
>>   
>>   		ret = of_changeset_attach_node(&ovcs->cset, tchild);
>> -		if (ret)
>> +		if (ret) {
>> +			of_node_put(tchild);
>>   			return ret;
>> +		}
> By visual inspection of the code (Linux 6.1-rc1), this does not appear to be
> correct.  For the only case where of_changeset_action(),
> called by of_changeset_attach_node(), returns an error, of_node_get() has not
> yet occurred on tchild.

The correct explanation should be like:

When of_changeset_attach_node() returns fail and tchild is over of life 
cycle which is duplicated by

__of_node_dup(), it needs to call of_node_put() to release tchild in 
error handle route.


The patch is fine, but feel sorry to apologize for the incorrect comment 
of the patch.

I would update the comment in the patch v2.


With Best Regards,

Zeng Heng

>>   
>>   		target_child.np = tchild;
>>   		target_child.in_livetree = false;
> For which version of Linux were the memory leaks detected?  Were any additional
> patches applied?
>
> -Frank

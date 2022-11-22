Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 689AF633C60
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 13:24:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233727AbiKVMYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 07:24:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233689AbiKVMYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 07:24:15 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE4E127FF9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 04:24:12 -0800 (PST)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NGk263YlxzRpQq;
        Tue, 22 Nov 2022 20:23:42 +0800 (CST)
Received: from [10.174.176.230] (10.174.176.230) by
 kwepemi500016.china.huawei.com (7.221.188.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 22 Nov 2022 20:24:10 +0800
Message-ID: <2f4dc5e8-1b2c-e071-a363-d3f509cc4ccc@huawei.com>
Date:   Tue, 22 Nov 2022 20:24:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH] comedi: drivers: pcl730: Fix potential memory leak in
 pcl730_attach()
To:     Ian Abbott <abbotti@mev.co.uk>, <hsweeten@visionengravers.com>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>
References: <20221122120428.25069-1-shangxiaojing@huawei.com>
 <94fee07a-0ac4-fba7-23cb-0a9da42e25d0@mev.co.uk>
From:   shangxiaojing <shangxiaojing@huawei.com>
In-Reply-To: <94fee07a-0ac4-fba7-23cb-0a9da42e25d0@mev.co.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.230]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500016.china.huawei.com (7.221.188.220)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/11/22 20:18, Ian Abbott wrote:
> On 22/11/2022 12:04, Shang XiaoJing wrote:
>> pcl730_attach() calls comedi_request_region() and won't release the
>> resource allocated by alloc_resource() when pcl730_attach() failed 
>> latter.
>> Add release_region() to prevent memory leak.
>>
>> Fixes: 6f9aa29b47f6 ("staging: comedi: pcl730: use 
>> comedi_request_region()")
>> Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>
>> ---
>>   drivers/comedi/drivers/pcl730.c | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/comedi/drivers/pcl730.c 
>> b/drivers/comedi/drivers/pcl730.c
>> index d2733cd5383d..c463de8a14e1 100644
>> --- a/drivers/comedi/drivers/pcl730.c
>> +++ b/drivers/comedi/drivers/pcl730.c
>> @@ -274,8 +274,14 @@ static int pcl730_attach(struct comedi_device *dev,
>>           return ret;
>>       ret = comedi_alloc_subdevices(dev, board->n_subdevs);
>> -    if (ret)
>> +    if (ret) {
>> +        if (dev->iobase && dev->iolen) {
>> +            release_region(dev->iobase, dev->iolen);
>> +            dev->iobase = 0;
>> +            dev->iolen = 0;
>> +        }
>>           return ret;
>> +    }
>>       subdev = 0;
> 
> This is not needed.  If the 'attach' handler pcl730_attach() returns an 
> error, the 'detach' handler comedi_legacy_detach() will be called to 
> clean up the allocated resources.  All the comedi drivers work that way. 
> (A lot of them have an 'auto_attach' handler instead of an 'attach' 
> handler, but the error handling is basically the same.)
> 

ok, thanks for the advice!

Thanks,
-- 
Shang XiaoJing

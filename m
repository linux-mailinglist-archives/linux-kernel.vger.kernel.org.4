Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0724D60F33E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 11:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235192AbiJ0JJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 05:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234728AbiJ0JJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 05:09:39 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D191A617E;
        Thu, 27 Oct 2022 02:09:37 -0700 (PDT)
Received: from fraeml706-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Myfvv6Mtmz67ZcT;
        Thu, 27 Oct 2022 17:07:39 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml706-chm.china.huawei.com (10.206.15.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.31; Thu, 27 Oct 2022 11:09:35 +0200
Received: from [10.195.32.169] (10.195.32.169) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 27 Oct 2022 10:09:34 +0100
Message-ID: <d754f8ec-8f36-f1f1-046d-60f47df13948@huawei.com>
Date:   Thu, 27 Oct 2022 10:09:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH RFC v3 01/22] blk-mq: Don't get budget for reserved
 requests
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <axboe@kernel.dk>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <jinpu.wang@cloud.ionos.com>,
        <hare@suse.de>, <bvanassche@acm.org>, <hch@lst.de>,
        <ming.lei@redhat.com>, <niklas.cassel@wdc.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-ide@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linuxarm@huawei.com>
References: <1666693096-180008-1-git-send-email-john.garry@huawei.com>
 <1666693096-180008-2-git-send-email-john.garry@huawei.com>
 <9cd8aa6a-98be-ddba-db4e-07ed59b53f08@opensource.wdc.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <9cd8aa6a-98be-ddba-db4e-07ed59b53f08@opensource.wdc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.195.32.169]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/10/2022 02:16, Damien Le Moal wrote:
>> Signed-off-by: John Garry<john.garry@huawei.com>
>> ---
>>   block/blk-mq.c          | 4 +++-
>>   drivers/scsi/scsi_lib.c | 3 ++-
>>   2 files changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index 260adeb2e455..d8baabb32ea4 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -1955,11 +1955,13 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
>>   	errors = queued = 0;
>>   	do {
>>   		struct blk_mq_queue_data bd;
>> +		bool need_budget;
>>   
>>   		rq = list_first_entry(list, struct request, queuelist);
>>   
>>   		WARN_ON_ONCE(hctx != rq->mq_hctx);
>> -		prep = blk_mq_prep_dispatch_rq(rq, !nr_budgets);
>> +		need_budget = !nr_budgets && !blk_mq_is_reserved_rq(rq);
>> +		prep = blk_mq_prep_dispatch_rq(rq, need_budget);
>>   		if (prep != PREP_DISPATCH_OK)
>>   			break;
> Below this code, there is:
> 
> 		if (nr_budgets)
> 			nr_budgets--;
> 
> Don't you need to change that to:
> 
> 		if (need_budget && nr_budgets)
> 			nr_budgets--;
> 
> ? Otherwise, the accounting will be off.
> 

Ah, yes, I think that you are right. I actually need to check nr_budgets 
usage further as nr_budgets initial value would be dependent on any 
reserved request requiring a budget (which we don't get).

Thanks,
John

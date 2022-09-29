Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B38CD5EEF3F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 09:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235300AbiI2Hic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 03:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235262AbiI2Hi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 03:38:28 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9764B139439;
        Thu, 29 Sep 2022 00:38:27 -0700 (PDT)
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MdQFk1lYHz6HJZW;
        Thu, 29 Sep 2022 15:38:18 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.31; Thu, 29 Sep 2022 09:38:25 +0200
Received: from [10.126.170.84] (10.126.170.84) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 29 Sep 2022 08:38:24 +0100
Message-ID: <328e6482-52b7-a9e0-5b43-ff1566ec1641@huawei.com>
Date:   Thu, 29 Sep 2022 08:38:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
From:   John Garry <john.garry@huawei.com>
Subject: Re: [PATCH 2/6] scsi: hisi_sas: Use sas_task_find_rq()
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <jinpu.wang@cloud.ionos.com>, <damien.lemoal@wdc.com>
CC:     <hare@suse.de>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <ipylypiv@google.com>, <changyuanl@google.com>, <hch@lst.de>
References: <1664368034-114991-1-git-send-email-john.garry@huawei.com>
 <1664368034-114991-3-git-send-email-john.garry@huawei.com>
 <4737cbca-6250-00b8-a2be-1d98e2b8d04a@opensource.wdc.com>
In-Reply-To: <4737cbca-6250-00b8-a2be-1d98e2b8d04a@opensource.wdc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.170.84]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/09/2022 03:11, Damien Le Moal wrote:
> On 9/28/22 21:27, John Garry wrote:
>> Use sas_task_find_rq() to lookup the request per task for its driver tag.
>>
>> Signed-off-by: John Garry <john.garry@huawei.com>
> 
> Looks good, modulo the question below.
> 
> Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> 

Cheers

>> ---
>>   drivers/scsi/hisi_sas/hisi_sas_main.c | 26 ++++++++------------------
>>   1 file changed, 8 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
>> index 4c37ae9eb6b6..1011dffed51f 100644
>> --- a/drivers/scsi/hisi_sas/hisi_sas_main.c
>> +++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
>> @@ -177,13 +177,13 @@ static void hisi_sas_slot_index_set(struct hisi_hba *hisi_hba, int slot_idx)
>>   }
>>   
>>   static int hisi_sas_slot_index_alloc(struct hisi_hba *hisi_hba,
>> -				     struct scsi_cmnd *scsi_cmnd)
>> +				     struct request *rq)
>>   {
>>   	int index;
>>   	void *bitmap = hisi_hba->slot_index_tags;
>>   
>> -	if (scsi_cmnd)
>> -		return scsi_cmd_to_rq(scsi_cmnd)->tag;
>> +	if (rq)
>> +		return rq->tag;
>>   
>>   	spin_lock(&hisi_hba->lock);
>>   	index = find_next_zero_bit(bitmap, hisi_hba->slot_index_count,
>> @@ -461,11 +461,11 @@ static int hisi_sas_queue_command(struct sas_task *task, gfp_t gfp_flags)
>>   	struct asd_sas_port *sas_port = device->port;
>>   	struct hisi_sas_device *sas_dev = device->lldd_dev;
>>   	bool internal_abort = sas_is_internal_abort(task);
>> -	struct scsi_cmnd *scmd = NULL;
>>   	struct hisi_sas_dq *dq = NULL;
>>   	struct hisi_sas_port *port;
>>   	struct hisi_hba *hisi_hba;
>>   	struct hisi_sas_slot *slot;
>> +	struct request *rq = NULL;
> 
> Do you really need the NULL initialization here ?

Yes, as rq is only set in one case of the switch statement and checked 
outside the switch statement.

Thanks,
John

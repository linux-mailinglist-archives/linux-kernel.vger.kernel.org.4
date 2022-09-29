Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C144B5EEF1B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 09:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235260AbiI2Hds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 03:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235003AbiI2Hdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 03:33:32 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC0C7137E49;
        Thu, 29 Sep 2022 00:33:29 -0700 (PDT)
Received: from fraeml738-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MdQ5f1qHtz6J6BD;
        Thu, 29 Sep 2022 15:31:18 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml738-chm.china.huawei.com (10.206.15.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 29 Sep 2022 09:33:26 +0200
Received: from [10.126.170.84] (10.126.170.84) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 29 Sep 2022 08:33:25 +0100
Message-ID: <1356c5b0-5cd7-b006-1b34-a66a34e23fb4@huawei.com>
Date:   Thu, 29 Sep 2022 08:33:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 1/6] scsi: libsas: Add sas_task_find_rq()
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <jinpu.wang@cloud.ionos.com>, <damien.lemoal@wdc.com>
CC:     <hare@suse.de>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <ipylypiv@google.com>, <changyuanl@google.com>, <hch@lst.de>
References: <1664368034-114991-1-git-send-email-john.garry@huawei.com>
 <1664368034-114991-2-git-send-email-john.garry@huawei.com>
 <0c0306d7-2645-874a-9745-8aa5dcfeede1@opensource.wdc.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <0c0306d7-2645-874a-9745-8aa5dcfeede1@opensource.wdc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.170.84]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
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

On 29/09/2022 03:09, Damien Le Moal wrote:
> On 9/28/22 21:27, John Garry wrote:
>> blk-mq already provides a unique tag per request. Some libsas LLDDs - like
>> hisi_sas - already use this tag as the unique per-IO HW tag.
>>
>> Add a common function to provide the request associated with a sas_task
>> for all libsas LLDDs.
>>
>> Signed-off-by: John Garry <john.garry@huawei.com>
>> ---
>>   include/scsi/libsas.h | 22 ++++++++++++++++++++++
>>   1 file changed, 22 insertions(+)
>>
>> diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
>> index f86b56bf7833..bc51756a3317 100644
>> --- a/include/scsi/libsas.h
>> +++ b/include/scsi/libsas.h
>> @@ -644,6 +644,28 @@ static inline bool sas_is_internal_abort(struct sas_task *task)
>>   	return task->task_proto == SAS_PROTOCOL_INTERNAL_ABORT;
>>   }
>>   
>> +static inline struct request *sas_task_find_rq(struct sas_task *task)
>> +{
>> +	struct scsi_cmnd *scmd;
>> +
>> +	if (!task || !task->uldd_task)
>> +		return NULL;
>> +
>> +	if (task->task_proto & SAS_PROTOCOL_STP_ALL) {
>> +		struct ata_queued_cmd *qc;
>> +
>> +		qc = task->uldd_task;
> 
> I would change these 2 lines into a single line:
> 
> 		struct ata_queued_cmd *qc = task->uldd_task;
> 
> And no cast as suggested.
> 
>> +		scmd = qc->scsicmd;

So do you prefer:

  scmd = ((struct ata_queued_cmd *)task->uldd_task)->scsicmd

As Jason suggested?

Thanks,
John

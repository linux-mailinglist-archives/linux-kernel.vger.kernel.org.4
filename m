Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C32EF5EDEF3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 16:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233070AbiI1OjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 10:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234427AbiI1OjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 10:39:11 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56CBAAF0F2;
        Wed, 28 Sep 2022 07:39:04 -0700 (PDT)
Received: from canpemm500004.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MczZD1g41zpV9G;
        Wed, 28 Sep 2022 22:36:04 +0800 (CST)
Received: from [10.174.179.14] (10.174.179.14) by
 canpemm500004.china.huawei.com (7.192.104.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 28 Sep 2022 22:38:59 +0800
Subject: Re: [PATCH 1/6] scsi: libsas: Add sas_task_find_rq()
To:     John Garry <john.garry@huawei.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <jinpu.wang@cloud.ionos.com>,
        <damien.lemoal@wdc.com>
CC:     <hare@suse.de>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <ipylypiv@google.com>, <changyuanl@google.com>, <hch@lst.de>
References: <1664368034-114991-1-git-send-email-john.garry@huawei.com>
 <1664368034-114991-2-git-send-email-john.garry@huawei.com>
 <e47fe754-c8a7-99ff-88f2-8b09d98306ab@huawei.com>
 <e264e099-8492-5ba5-ae66-4c71c146ba22@huawei.com>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <cad2134a-5b25-963c-592a-45c49fdcfc66@huawei.com>
Date:   Wed, 28 Sep 2022 22:38:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <e264e099-8492-5ba5-ae66-4c71c146ba22@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.14]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500004.china.huawei.com (7.192.104.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/9/28 21:50, John Garry wrote:
> On 28/09/2022 14:13, Jason Yan wrote:
>>> +++ b/include/scsi/libsas.h
>>> @@ -644,6 +644,28 @@ static inline bool sas_is_internal_abort(struct 
>>> sas_task *task)
>>>       return task->task_proto == SAS_PROTOCOL_INTERNAL_ABORT;
>>>   }
>>> +static inline struct request *sas_task_find_rq(struct sas_task *task)
>>> +{
>>> +    struct scsi_cmnd *scmd;
>>> +
>>> +    if (!task || !task->uldd_task)
>>> +        return NULL;
>>> +
>>> +    if (task->task_proto & SAS_PROTOCOL_STP_ALL) {
>>> +        struct ata_queued_cmd *qc;
>>> +
>>> +        qc = task->uldd_task;
>>> +        scmd = qc->scsicmd;
>>
>> Can we remove that local qc?
>>
> 
> We could...
> 
>> and
>>      scmd = ((struct ata_queued_cmd *)task->uldd_task)->scsicmd;
> 
> ... but I am not really sure that this is much better, specifically 
> because of the casting from void. If you feel really strongly about it I 
> could.
> 

There are plenty of examples in the kernel, and in scsi itself. Such as

#define fc_host_node_name(x) \
	(((struct fc_host_attrs *)(x)->shost_data)->node_name)


> thanks,
> John
> .

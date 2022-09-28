Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 172385EDE1F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 15:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233877AbiI1NuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 09:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiI1NuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 09:50:05 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65BBD24BE9;
        Wed, 28 Sep 2022 06:50:01 -0700 (PDT)
Received: from fraeml713-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4McyWd0Rg8z686wr;
        Wed, 28 Sep 2022 21:48:45 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml713-chm.china.huawei.com (10.206.15.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 28 Sep 2022 15:49:59 +0200
Received: from [10.126.175.219] (10.126.175.219) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 28 Sep 2022 14:49:58 +0100
Message-ID: <e264e099-8492-5ba5-ae66-4c71c146ba22@huawei.com>
Date:   Wed, 28 Sep 2022 14:50:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 1/6] scsi: libsas: Add sas_task_find_rq()
To:     Jason Yan <yanaijie@huawei.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <jinpu.wang@cloud.ionos.com>,
        <damien.lemoal@wdc.com>
CC:     <hare@suse.de>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <ipylypiv@google.com>, <changyuanl@google.com>, <hch@lst.de>
References: <1664368034-114991-1-git-send-email-john.garry@huawei.com>
 <1664368034-114991-2-git-send-email-john.garry@huawei.com>
 <e47fe754-c8a7-99ff-88f2-8b09d98306ab@huawei.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <e47fe754-c8a7-99ff-88f2-8b09d98306ab@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.175.219]
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

On 28/09/2022 14:13, Jason Yan wrote:
>> +++ b/include/scsi/libsas.h
>> @@ -644,6 +644,28 @@ static inline bool sas_is_internal_abort(struct 
>> sas_task *task)
>>       return task->task_proto == SAS_PROTOCOL_INTERNAL_ABORT;
>>   }
>> +static inline struct request *sas_task_find_rq(struct sas_task *task)
>> +{
>> +    struct scsi_cmnd *scmd;
>> +
>> +    if (!task || !task->uldd_task)
>> +        return NULL;
>> +
>> +    if (task->task_proto & SAS_PROTOCOL_STP_ALL) {
>> +        struct ata_queued_cmd *qc;
>> +
>> +        qc = task->uldd_task;
>> +        scmd = qc->scsicmd;
> 
> Can we remove that local qc?
>

We could...

> and
>      scmd = ((struct ata_queued_cmd *)task->uldd_task)->scsicmd;

... but I am not really sure that this is much better, specifically 
because of the casting from void. If you feel really strongly about it I 
could.

thanks,
John

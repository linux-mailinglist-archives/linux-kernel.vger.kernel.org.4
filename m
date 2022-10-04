Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A03075F3D59
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 09:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbiJDHhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 03:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiJDHhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 03:37:05 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F75A41984;
        Tue,  4 Oct 2022 00:37:01 -0700 (PDT)
Received: from fraeml706-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MhTx63z1Nz67PH4;
        Tue,  4 Oct 2022 15:34:34 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml706-chm.china.huawei.com (10.206.15.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.31; Tue, 4 Oct 2022 09:36:58 +0200
Received: from [10.48.156.84] (10.48.156.84) by lhrpeml500003.china.huawei.com
 (7.191.162.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 4 Oct
 2022 08:36:57 +0100
Message-ID: <9e405f1d-621e-d1f7-55c5-21ba5c8a85a8@huawei.com>
Date:   Tue, 4 Oct 2022 08:37:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2 4/6] scsi: pm8001: Use sas_task_find_rq() for tagging
To:     Hannes Reinecke <hare@suse.de>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <jinpu.wang@cloud.ionos.com>,
        <damien.lemoal@wdc.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <ipylypiv@google.com>,
        <changyuanl@google.com>, <hch@lst.de>, <yanaijie@huawei.com>
References: <1664528184-162714-1-git-send-email-john.garry@huawei.com>
 <1664528184-162714-5-git-send-email-john.garry@huawei.com>
 <fdbb5c5f-05d9-93fa-83d4-2f0129221641@suse.de>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <fdbb5c5f-05d9-93fa-83d4-2f0129221641@suse.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.156.84]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10/2022 06:53, Hannes Reinecke wrote:
>> -    void *bitmap = pm8001_ha->tags;
>> +    void *bitmap = pm8001_ha->rsvd_tags;
>>       unsigned long flags;
>>       unsigned int tag;
>>       spin_lock_irqsave(&pm8001_ha->bitmap_lock, flags);
>> -    tag = find_first_zero_bit(bitmap, pm8001_ha->tags_num);
>> -    if (tag >= pm8001_ha->tags_num) {
>> +    tag = find_first_zero_bit(bitmap, PM8001_RESERVE_SLOT);
>> +    if (tag >= PM8001_RESERVE_SLOT) {
>>           spin_unlock_irqrestore(&pm8001_ha->bitmap_lock, flags);
>>           return -SAS_QUEUE_FULL;
>>       }
>>       __set_bit(tag, bitmap);
>>       spin_unlock_irqrestore(&pm8001_ha->bitmap_lock, flags);
>> +
>> +    /* reserved tags are in the upper region of the tagset */
>> +    tag += pm8001_ha->shost->can_queue;
>>       *tag_out = tag;
>>       return 0;
>>   }
> Can you move the reserved tags to the _lower_ region of the tagset?
> That way the tag allocation scheme matches with what the block-layer 
> does, and the eventual conversion to reserved tags becomes easier.

Yeah, I agree that having a scheme which matches the block layer would 
be good for consistency and I will make that change, but I am not sure 
how it helps conversion to reserved tags.

Thanks,
John

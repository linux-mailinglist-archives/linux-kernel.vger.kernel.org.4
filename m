Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6325A60F35E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 11:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235386AbiJ0JMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 05:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235376AbiJ0JMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 05:12:17 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CCDD925A0;
        Thu, 27 Oct 2022 02:11:11 -0700 (PDT)
Received: from frapeml100004.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Myfvn3yM4z67cQ8;
        Thu, 27 Oct 2022 17:07:33 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 frapeml100004.china.huawei.com (7.182.85.167) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 27 Oct 2022 11:11:09 +0200
Received: from [10.195.32.169] (10.195.32.169) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 27 Oct 2022 10:11:09 +0100
Message-ID: <bdfe4716-ea8f-b812-8474-577d84da7b24@huawei.com>
Date:   Thu, 27 Oct 2022 10:11:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH RFC v3 03/22] scsi: core: Implement reserved command
 handling
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <axboe@kernel.dk>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <jinpu.wang@cloud.ionos.com>,
        <hare@suse.de>, <bvanassche@acm.org>, <hch@lst.de>,
        <ming.lei@redhat.com>, <niklas.cassel@wdc.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-ide@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linuxarm@huawei.com>
References: <1666693096-180008-1-git-send-email-john.garry@huawei.com>
 <1666693096-180008-4-git-send-email-john.garry@huawei.com>
 <cd5df8e0-03d1-8f22-0367-eb7c76bc70e7@opensource.wdc.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <cd5df8e0-03d1-8f22-0367-eb7c76bc70e7@opensource.wdc.com>
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


> 
>>   	device_initialize(&shost->shost_gendev);
>>   	dev_set_name(&shost->shost_gendev, "host%d", shost->host_no);
>>   	shost->shost_gendev.bus = &scsi_bus_type;
>> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
>> index 39d4fd124375..a8c4e7c037ae 100644
>> --- a/drivers/scsi/scsi_lib.c
>> +++ b/drivers/scsi/scsi_lib.c
>> @@ -1978,6 +1978,8 @@ int scsi_mq_setup_tags(struct Scsi_Host *shost)
>>   	tag_set->nr_hw_queues = shost->nr_hw_queues ? : 1;
>>   	tag_set->nr_maps = shost->nr_maps ? : 1;
>>   	tag_set->queue_depth = shost->can_queue;
>> +	tag_set->reserved_tags = shost->nr_reserved_cmds;
>> +
> Why the blank line ?
> 

I don't think that it is required, I can remedy.

>>   	tag_set->cmd_size = cmd_size;

Thanks,
John

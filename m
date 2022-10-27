Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0AB60FF44
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 19:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235578AbiJ0RXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 13:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235086AbiJ0RXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 13:23:37 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A430618C421;
        Thu, 27 Oct 2022 10:23:34 -0700 (PDT)
Received: from fraeml745-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Myssq4ygLz67bVM;
        Fri, 28 Oct 2022 01:21:35 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml745-chm.china.huawei.com (10.206.15.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 27 Oct 2022 19:23:31 +0200
Received: from [10.195.32.169] (10.195.32.169) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 27 Oct 2022 18:23:30 +0100
Message-ID: <ea0be367-a4e0-3cc2-c4c7-04d8db1714cd@huawei.com>
Date:   Thu, 27 Oct 2022 18:23:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH RFC v3 2/7] ata: libata-scsi: Add
 ata_internal_queuecommand()
To:     Hannes Reinecke <hare@suse.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <bvanassche@acm.org>, <hch@lst.de>, <ming.lei@redhat.com>,
        <niklas.cassel@wdc.com>
CC:     <axboe@kernel.dk>, <jinpu.wang@cloud.ionos.com>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-ide@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linuxarm@huawei.com>, <john.garry2@mail.dcu.ie>
References: <1666693976-181094-1-git-send-email-john.garry@huawei.com>
 <1666693976-181094-3-git-send-email-john.garry@huawei.com>
 <08fdb698-0df3-7bc8-e6af-7d13cc96acfa@opensource.wdc.com>
 <83d9dc82-ea37-4a3c-7e67-1c097f777767@huawei.com>
 <3ef0347f-f3e2-cf08-2b27-f65a7afe82a2@suse.de>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <3ef0347f-f3e2-cf08-2b27-f65a7afe82a2@suse.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.195.32.169]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
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

On 27/10/2022 14:02, Hannes Reinecke wrote:
>>>>   /**
>>>>    *    ata_scsi_slave_config - Set SCSI device attributes
>>>>    *    @sdev: SCSI device to examine
>>>> diff --git a/include/linux/libata.h b/include/linux/libata.h
>>>> index 8938b584520f..f09c5dca16ce 100644
>>>> --- a/include/linux/libata.h
>>>> +++ b/include/linux/libata.h
>>>> @@ -1141,6 +1141,8 @@ extern int ata_std_bios_param(struct 
>>>> scsi_device *sdev,
>>>>                     sector_t capacity, int geom[]);
>>>>   extern void ata_scsi_unlock_native_capacity(struct scsi_device 
>>>> *sdev);
>>>>   extern int ata_scsi_slave_config(struct scsi_device *sdev);
>>>> +extern int ata_internal_queuecommand(struct Scsi_Host *shost,
>>>> +                struct scsi_cmnd *scmd);
>>>>   extern void ata_scsi_slave_destroy(struct scsi_device *sdev);
>>>>   extern int ata_scsi_change_queue_depth(struct scsi_device *sdev,
>>>>                          int queue_depth);
>>>> @@ -1391,7 +1393,8 @@ extern const struct attribute_group 
>>>> *ata_common_sdev_groups[];
>>>>       .slave_destroy        = ata_scsi_slave_destroy,    \
>>>>       .bios_param        = ata_std_bios_param,        \
>>>>       .unlock_native_capacity    = ata_scsi_unlock_native_capacity,\
>>>> -    .max_sectors        = ATA_MAX_SECTORS_LBA48
>>>> +    .max_sectors        = ATA_MAX_SECTORS_LBA48,\
>>>> +    .reserved_queuecommand = ata_internal_queuecommand
>>>>   #define ATA_SUBBASE_SHT(drv_name)                \
>>>>       __ATA_BASE_SHT(drv_name),                \
>>>
>>
> 
> But that means we can't use it before the SCSI host is initialized; some 
> HBAs require to send commands before the host can be initialized properly.

At what stage do you want to send these commands? The tags for the shost 
are not setup until scsi_add_host() -> scsi_mq_setup_tags() is called, 
so can't expect blk-mq to manage reserved tags before then.

If you are required to send commands prior to scsi_add_host(), then I 
suppose the low-level driver still needs to manage tags until the shost 
is ready. I guess that some very simple scheme can be used, like always 
use tag 0, since most probe is done serially per-host. But that's not a 
case which I have had to deal with yet.

Thanks,
John

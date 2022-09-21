Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7CE5BFAC3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 11:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbiIUJWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 05:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbiIUJWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 05:22:21 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A6991116;
        Wed, 21 Sep 2022 02:22:01 -0700 (PDT)
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MXXv34nPHz687SH;
        Wed, 21 Sep 2022 17:20:15 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 21 Sep 2022 11:21:59 +0200
Received: from [10.195.245.235] (10.195.245.235) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 21 Sep 2022 10:21:58 +0100
Message-ID: <55ee46e7-a07d-d1ef-72fd-1f99b2a04684@huawei.com>
Date:   Wed, 21 Sep 2022 10:21:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH RFC 2/6] scsi: scsi_transport_sas: Allocate end device
 target id in the rphy alloc
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>, <hare@suse.de>,
        <hch@lst.de>
CC:     <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, <brking@us.ibm.com>
References: <1663669630-21333-1-git-send-email-john.garry@huawei.com>
 <1663669630-21333-3-git-send-email-john.garry@huawei.com>
 <ecde5199-bb9e-6df4-832a-f3707babd3d6@opensource.wdc.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <ecde5199-bb9e-6df4-832a-f3707babd3d6@opensource.wdc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.195.245.235]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/09/2022 23:02, Damien Le Moal wrote:
>>
>>       return &rdev->rphy;
>>   }
>>   EXPORT_SYMBOL(sas_end_device_alloc);
>> @@ -1500,6 +1505,16 @@ struct sas_rphy *sas_expander_alloc(struct 
>> sas_port *parent,
>>   }
>>   EXPORT_SYMBOL(sas_expander_alloc);
>> +static bool sas_rphy_end_device_valid_tproto(struct sas_rphy *rphy)
>> +{
>> +    struct sas_identify *identify = &rphy->identify;
>> +
>> +    if (identify->target_port_protocols &
>> +        (SAS_PROTOCOL_SSP | SAS_PROTOCOL_STP | SAS_PROTOCOL_SATA))
>> +        return true;
>> +    return false;
> 
> You could just do:
> 
> return identify->target_port_protocols &
>      (SAS_PROTOCOL_SSP | SAS_PROTOCOL_STP | SAS_PROTOCOL_SATA))

OK

> 
>> +}
>> +
>>   /**
>>    * sas_rphy_add  -  add a SAS remote PHY to the device hierarchy
>>    * @rphy:    The remote PHY to be added
>> @@ -1529,16 +1544,10 @@ int sas_rphy_add(struct sas_rphy *rphy)
>>       mutex_lock(&sas_host->lock);
>>       list_add_tail(&rphy->list, &sas_host->rphy_list);
>> -    if (identify->device_type == SAS_END_DEVICE &&
>> -        (identify->target_port_protocols &
>> -         (SAS_PROTOCOL_SSP | SAS_PROTOCOL_STP | SAS_PROTOCOL_SATA)))
>> -        rphy->scsi_target_id = sas_host->next_target_id++;
>> -    else if (identify->device_type == SAS_END_DEVICE)
>> -        rphy->scsi_target_id = -1;
>>       mutex_unlock(&sas_host->lock);
>>       if (identify->device_type == SAS_END_DEVICE &&
> 
> You could move this check inside sas_rphy_end_device_valid_tproto(),
> no ?
> 

Yeah, I suppose I could. I might require a function rename with that.

>> -        rphy->scsi_target_id != -1) {
>> +        sas_rphy_end_device_valid_tproto(rphy)) {
>>           int lun;
>>           if (identify->target_port_protocols & SAS_PROTOCOL_SSP)
>> @@ -1667,7 +1676,7 @@ static int sas_user_scan(struct Scsi_Host 
>> *shost, uint channel,
>>       mutex_lock(&sas_host->lock);
>>       list_for_each_entry(rphy, &sas_host->rphy_list, list) {
>>           if (rphy->identify.device_type != SAS_END_DEVICE ||
>> -            rphy->scsi_target_id == -1)
>> +            !sas_rphy_end_device_valid_tproto(rphy))
>>               continue; 

Thanks,
John

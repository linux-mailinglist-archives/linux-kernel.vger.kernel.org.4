Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE57760F370
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 11:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235278AbiJ0JPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 05:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235395AbiJ0JOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 05:14:43 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D92D3B718;
        Thu, 27 Oct 2022 02:13:26 -0700 (PDT)
Received: from fraeml742-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MyfyN05Qnz67Psy;
        Thu, 27 Oct 2022 17:09:48 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml742-chm.china.huawei.com (10.206.15.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 27 Oct 2022 11:13:24 +0200
Received: from [10.195.32.169] (10.195.32.169) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 27 Oct 2022 10:13:23 +0100
Message-ID: <76fe5007-5c53-9cdf-7c57-6af7ebaf8c97@huawei.com>
Date:   Thu, 27 Oct 2022 10:13:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH RFC v3 04/22] scsi: core: Add support to send reserved
 commands
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <axboe@kernel.dk>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <jinpu.wang@cloud.ionos.com>,
        <hare@suse.de>, <bvanassche@acm.org>, <hch@lst.de>,
        <ming.lei@redhat.com>, <niklas.cassel@wdc.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-ide@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linuxarm@huawei.com>
References: <1666693096-180008-1-git-send-email-john.garry@huawei.com>
 <1666693096-180008-5-git-send-email-john.garry@huawei.com>
 <c30e421e-9652-ebb8-9733-b286cb0f9f19@opensource.wdc.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <c30e421e-9652-ebb8-9733-b286cb0f9f19@opensource.wdc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.195.32.169]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
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

On 27/10/2022 02:21, Damien Le Moal wrote:
>>   
>> +	if (blk_mq_is_reserved_rq(rq)) {
>> +		struct scsi_device *sdev = cmd->device;
> This variable is not really needed. You can call:
> 		
> 		scsi_device_unbusy(cmd->device, cmd);
> 
> No ?

ok, your suggestion is good

> 
>> +
>> +		scsi_mq_uninit_cmd(cmd);
>> +		scsi_device_unbusy(sdev, cmd);
>> +		__blk_mq_end_request(rq, 0);
>> +
>> +		return;
>> +	}
>> +
>>   	INIT_LIST_HEAD(&cmd->eh_entry);
>>   
>>   	atomic_inc(&cmd->device->iodone_cnt);
>> @@ -1718,6 +1728,21 @@ static blk_status_t scsi_queue_rq(struct blk_mq_hw_ctx *hctx,
>>   	blk_status_t ret;
>>   	int reason;
>>   
>> +	if (blk_mq_is_reserved_rq(req)) {
>> +		if (!(req->rq_flags & RQF_DONTPREP)) {
>> +			ret = scsi_prepare_cmd(req);
>> +			if (ret != BLK_STS_OK)
>> +				goto out_dec_host_busy;
>> +
>> +			req->rq_flags |= RQF_DONTPREP;
>> +		} else {
>> +			clear_bit(SCMD_STATE_COMPLETE, &cmd->state);
>> +		}
>> +		blk_mq_start_request(req);
>> +
>> +		return shost->hostt->reserved_queuecommand(shost, cmd);
>> +	}
>> +
>>   	WARN_ON_ONCE(cmd->budget_token < 0);
>>   
>>   	/*
>> diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
>> index 91678c77398e..a39f36aa0b0d 100644
>> --- a/include/scsi/scsi_host.h
>> +++ b/include/scsi/scsi_host.h
>> @@ -73,6 +73,7 @@ struct scsi_host_template {
>>   	 * STATUS: REQUIRED
>>   	 */
>>   	int (* queuecommand)(struct Scsi_Host *, struct scsi_cmnd *);
>> +	int (*reserved_queuecommand)(struct Scsi_Host *, struct scsi_cmnd *);
> Nit: This op name sound like something returning a bool... May be a
> straight "queue_reserved_command" name would be clearer ?

or queuecommand_reserved ? I'm just trying to have the name a variant of 
"queuecommand".

> 

thanks,
John

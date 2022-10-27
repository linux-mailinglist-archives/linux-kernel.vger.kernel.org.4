Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 839EB60F84D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 15:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235921AbiJ0NDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 09:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235861AbiJ0NDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 09:03:03 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA99175792;
        Thu, 27 Oct 2022 06:03:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5246A21D35;
        Thu, 27 Oct 2022 13:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1666875781; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6vU8vlBe1NmH+Y8hhVFNTdabTpguN3wNwqYkXSRqXNw=;
        b=yMR4DON5E2/9m+BnomQU+UpYr4Q1Zdm7v0aJ0HpBCTsVlWjkFzansIMo66WOK3Rnta0WnL
        B3LRaNWse0JPeb/Mij3Ways7jwHzkk24BGNcvVF75lKJij+NukIIsedd+m4OR2VuQ+UHcz
        AD7JuTyl8SBGYrKPPUqFgZvwBbsopC4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1666875781;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6vU8vlBe1NmH+Y8hhVFNTdabTpguN3wNwqYkXSRqXNw=;
        b=qEr+EWEG0kSSrZzav6o334GkEDPqeEs0fYGFuPv2ylmYwEZPFvJeijRE10Tpv0l0+FSb2i
        9625IKD2r9j7iFBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 85140134CA;
        Thu, 27 Oct 2022 13:03:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FFRBHoSBWmOmXAAAMHmgww
        (envelope-from <hare@suse.de>); Thu, 27 Oct 2022 13:03:00 +0000
Message-ID: <3ef0347f-f3e2-cf08-2b27-f65a7afe82a2@suse.de>
Date:   Thu, 27 Oct 2022 15:02:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH RFC v3 2/7] ata: libata-scsi: Add
 ata_internal_queuecommand()
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        jejb@linux.ibm.com, martin.petersen@oracle.com, bvanassche@acm.org,
        hch@lst.de, ming.lei@redhat.com, niklas.cassel@wdc.com
Cc:     axboe@kernel.dk, jinpu.wang@cloud.ionos.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
        linuxarm@huawei.com
References: <1666693976-181094-1-git-send-email-john.garry@huawei.com>
 <1666693976-181094-3-git-send-email-john.garry@huawei.com>
 <08fdb698-0df3-7bc8-e6af-7d13cc96acfa@opensource.wdc.com>
 <83d9dc82-ea37-4a3c-7e67-1c097f777767@huawei.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <83d9dc82-ea37-4a3c-7e67-1c097f777767@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/22 11:56, John Garry wrote:
> On 27/10/2022 02:45, Damien Le Moal wrote:
>> On 10/25/22 19:32, John Garry wrote:
>>> Add callback to queue reserved commands - call it "internal" as this is
>>> what libata uses.
>>>
>>> Also add it to the base ATA SHT.
>>>
>>> Signed-off-by: John Garry <john.garry@huawei.com>
>>> ---
>>>   drivers/ata/libata-scsi.c | 14 ++++++++++++++
>>>   include/linux/libata.h    |  5 ++++-
>>>   2 files changed, 18 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
>>> index 30d7c90b0c35..0d6f37d80137 100644
>>> --- a/drivers/ata/libata-scsi.c
>>> +++ b/drivers/ata/libata-scsi.c
>>> @@ -1118,6 +1118,20 @@ int ata_scsi_dev_config(struct scsi_device 
>>> *sdev, struct ata_device *dev)
>>>       return 0;
>>>   }
>>> +int ata_internal_queuecommand(struct Scsi_Host *shost, struct 
>>> scsi_cmnd *scmd)
>>> +{
>>> +    struct ata_port *ap;
>>> +    int res;
>>> +
>>> +    ap = ata_shost_to_port(shost);
>>
>> You can have this initialization together with the ap declaration.
>>
>>> +    spin_lock_irq(ap->lock);
>>> +    res = ata_sas_queuecmd(scmd, ap);
>>> +    spin_unlock_irq(ap->lock);
>>> +
>>> +    return res;
>>> +}
>>> +EXPORT_SYMBOL_GPL(ata_internal_queuecommand);
>>
>> I am officially lost here. Do not see why this function is needed...
> 
> The general idea in this series is to send ATA internal commands as 
> requests. And this function is used as the SCSI midlayer to queue 
> reserved commands. See how it is plugged into __ATA_BASE_SHT, below.
> 
> So we have this overall flow:
> 
> ata_exec_internal_sg():
>   -> alloc request
>   -> blk_execute_rq_nowait()
>       ... -> scsi_queue_rq()
>          -> sht->reserved_queuecommd()
>              -> ata_internal_queuecommand()
> 
> And then we have ata_internal_queuecommand() -> ata_sas_queuecmd() -> 
> ata_scsi_queue_internal() -> ata_qc_issue().
> 
> Hope it makes sense.
> 
> Thanks,
> John
> 
>>
>>> +
>>>   /**
>>>    *    ata_scsi_slave_config - Set SCSI device attributes
>>>    *    @sdev: SCSI device to examine
>>> diff --git a/include/linux/libata.h b/include/linux/libata.h
>>> index 8938b584520f..f09c5dca16ce 100644
>>> --- a/include/linux/libata.h
>>> +++ b/include/linux/libata.h
>>> @@ -1141,6 +1141,8 @@ extern int ata_std_bios_param(struct 
>>> scsi_device *sdev,
>>>                     sector_t capacity, int geom[]);
>>>   extern void ata_scsi_unlock_native_capacity(struct scsi_device *sdev);
>>>   extern int ata_scsi_slave_config(struct scsi_device *sdev);
>>> +extern int ata_internal_queuecommand(struct Scsi_Host *shost,
>>> +                struct scsi_cmnd *scmd);
>>>   extern void ata_scsi_slave_destroy(struct scsi_device *sdev);
>>>   extern int ata_scsi_change_queue_depth(struct scsi_device *sdev,
>>>                          int queue_depth);
>>> @@ -1391,7 +1393,8 @@ extern const struct attribute_group 
>>> *ata_common_sdev_groups[];
>>>       .slave_destroy        = ata_scsi_slave_destroy,    \
>>>       .bios_param        = ata_std_bios_param,        \
>>>       .unlock_native_capacity    = ata_scsi_unlock_native_capacity,\
>>> -    .max_sectors        = ATA_MAX_SECTORS_LBA48
>>> +    .max_sectors        = ATA_MAX_SECTORS_LBA48,\
>>> +    .reserved_queuecommand = ata_internal_queuecommand
>>>   #define ATA_SUBBASE_SHT(drv_name)                \
>>>       __ATA_BASE_SHT(drv_name),                \
>>
> 

But that means we can't use it before the SCSI host is initialized; some 
HBAs require to send commands before the host can be initialized properly.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


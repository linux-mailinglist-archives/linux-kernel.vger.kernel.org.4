Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9366105BF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 00:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235468AbiJ0W0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 18:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235476AbiJ0WZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 18:25:56 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845824360A
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 15:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666909552; x=1698445552;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4zGL6VS27dEJIbto0cHpBtNIC0C7VmjDzg2O9OeiSVk=;
  b=hI2P4qOEPjvgTP4dfs2iaEra4rI4mA8PAeUQJc7LZAf03H9UcUcHUVXX
   kYhJRrn+hMZraS/bUe+3t1aRXH9RdvTLipbxoVz851Z4XYqB0j3E9SRW1
   D9jXOx2o/aGSH4m/PHGhHhM2FpyAiVqLi2EnlsiTnHowXT2S7tkrP/LYL
   iqkhekTLDHrlD8vVAt/5NH7RTSbgeMfGM1x9AZQZH1Bbw5Sx79iRjtc+D
   A6OyzrJa9osI4Jkk/HInNSt857+2FL1Yi7uYP3Llibv3xXa6BJ80w1IEJ
   E+JHCXxDRCJaQNhlFXn0m+nvXzX80wID6REwcNB9yRCZyOalfQHsIFq0D
   w==;
X-IronPort-AV: E=Sophos;i="5.95,219,1661788800"; 
   d="scan'208";a="213212567"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Oct 2022 06:25:48 +0800
IronPort-SDR: JHDRNrD4uzQOXNIIlVuaqYrN1UrE+HYvFOPS/dd5qSPsgX78fcCKOrT0OfcC9buO76/4i6Is5L
 pUaqbhwfzAgIGFMcDYHoXllVvU2vwVdguw+d6fvMuaW5UDGOgGmgSR7fkhbDU1vwG3bQiHSVk8
 405A+Q9S7y93sVB/oiV0S3bF/BvZMzFTS4hRO6KEemc5i8CVu+jN7RtfqTWQJWuuNPphd1oUKs
 Oo8guPkqtxBUsqntUvS3w2vHjcOkXOFTy7VWhll9e9sBo1meZZJV1xwd3n4nc1GbnhYIhn2xeq
 xGKuehK9tjxhk778aBRvVKru
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Oct 2022 14:39:26 -0700
IronPort-SDR: xov3HNdzy3El7iMXk4h3BB2xHtpJEV/YtI93KBCFhVYcOCtsxPlLk4MSfyhEpGu1+uULdhpIko
 Ef4bWlS9jPc49TBZFM+gjLUMo51UgMycs0CbbJLAmlJjFvQtukj5eu576/V1cVXSW2Fr9VlITG
 7j7LFYbe/kkCPEMudo5+V4ULQ5/5cj6bvB00YEbhswe1VPYsC0/8BM191j3NsYx5FCAigwZI63
 gXwPtPt9IL5k4f3TKm6UpajEthjsSDmMCZCp88x2+N2ptFSs/JOwyOhsRA9t0PQLc+7IjPu6a7
 GqM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Oct 2022 15:25:50 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Mz0cq6ZJmz1RWy0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 15:25:47 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1666909546; x=1669501547; bh=4zGL6VS27dEJIbto0cHpBtNIC0C7VmjDzg2
        O9OeiSVk=; b=gVk0mkA19d9MfldSyyhOJZYOhE07lDu7kkm2idPnfvz3h1XN/Gi
        LpPdVDYpodbMUBRNABtENR9v17MUOgI5pxWxzHjvnqUFZBd7d0CiyaJZ/ubdpXO2
        U0NO49skw+EscXaz3hgRc2Wvoi11ICvDllIkikYKfFNKs9QJHTc9sxsqLYTsevV5
        KqDe92eh11BT3OKzBsQfSZEcg/b+Xr+A7iOCafuJ4hkVH3kuBg0K1J7GleSFrBRH
        8DgKCNaDYnoPfCkdKPabUwNUkIJHRrZ0vzI7guIbOMI6cey3fqMAwN9iKj5DGd3k
        6wiF/LKtcP6An8G9QAjlWwgFLJwWrXOPvZg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id LnqHX_m6uA_Q for <linux-kernel@vger.kernel.org>;
        Thu, 27 Oct 2022 15:25:46 -0700 (PDT)
Received: from [10.225.163.15] (unknown [10.225.163.15])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Mz0cm1jHCz1RvLy;
        Thu, 27 Oct 2022 15:25:44 -0700 (PDT)
Message-ID: <9a2f30cc-d0e9-b454-d7cd-1b0bd3cf0bb9@opensource.wdc.com>
Date:   Fri, 28 Oct 2022 07:25:43 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH RFC v3 2/7] ata: libata-scsi: Add
 ata_internal_queuecommand()
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, hare@suse.de, bvanassche@acm.org,
        hch@lst.de, ming.lei@redhat.com, niklas.cassel@wdc.com
Cc:     axboe@kernel.dk, jinpu.wang@cloud.ionos.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
        linuxarm@huawei.com
References: <1666693976-181094-1-git-send-email-john.garry@huawei.com>
 <1666693976-181094-3-git-send-email-john.garry@huawei.com>
 <08fdb698-0df3-7bc8-e6af-7d13cc96acfa@opensource.wdc.com>
 <83d9dc82-ea37-4a3c-7e67-1c097f777767@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <83d9dc82-ea37-4a3c-7e67-1c097f777767@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/22 18:56, John Garry wrote:
> On 27/10/2022 02:45, Damien Le Moal wrote:
>> On 10/25/22 19:32, John Garry wrote:
>>> Add callback to queue reserved commands - call it "internal" as this is
>>> what libata uses.
>>>
>>> Also add it to the base ATA SHT.
>>>
>>> Signed-off-by: John Garry <john.garry@huawei.com>
>>> ---
>>>   drivers/ata/libata-scsi.c | 14 ++++++++++++++
>>>   include/linux/libata.h    |  5 ++++-
>>>   2 files changed, 18 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
>>> index 30d7c90b0c35..0d6f37d80137 100644
>>> --- a/drivers/ata/libata-scsi.c
>>> +++ b/drivers/ata/libata-scsi.c
>>> @@ -1118,6 +1118,20 @@ int ata_scsi_dev_config(struct scsi_device *sdev, struct ata_device *dev)
>>>   	return 0;
>>>   }
>>>   
>>> +int ata_internal_queuecommand(struct Scsi_Host *shost, struct scsi_cmnd *scmd)
>>> +{
>>> +	struct ata_port *ap;
>>> +	int res;
>>> +
>>> +	ap = ata_shost_to_port(shost);
>>
>> You can have this initialization together with the ap declaration.
>>
>>> +	spin_lock_irq(ap->lock);
>>> +	res = ata_sas_queuecmd(scmd, ap);
>>> +	spin_unlock_irq(ap->lock);
>>> +
>>> +	return res;
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
>   -> alloc request
>   -> blk_execute_rq_nowait()
>       ... -> scsi_queue_rq()
> 		-> sht->reserved_queuecommd()
> 			-> ata_internal_queuecommand()
> 
> And then we have ata_internal_queuecommand() -> ata_sas_queuecmd() -> 
> ata_scsi_queue_internal() -> ata_qc_issue().
> 
> Hope it makes sense.

OK. Got it.
However, ata_exec_internal_sg() being used only from EH context with the
queue quiesced, will blk_execute_rq_nowait() work ? Is there an exception
for internal reserved tags ?

> 
> Thanks,
> John
> 
>>
>>> +
>>>   /**
>>>    *	ata_scsi_slave_config - Set SCSI device attributes
>>>    *	@sdev: SCSI device to examine
>>> diff --git a/include/linux/libata.h b/include/linux/libata.h
>>> index 8938b584520f..f09c5dca16ce 100644
>>> --- a/include/linux/libata.h
>>> +++ b/include/linux/libata.h
>>> @@ -1141,6 +1141,8 @@ extern int ata_std_bios_param(struct scsi_device *sdev,
>>>   			      sector_t capacity, int geom[]);
>>>   extern void ata_scsi_unlock_native_capacity(struct scsi_device *sdev);
>>>   extern int ata_scsi_slave_config(struct scsi_device *sdev);
>>> +extern int ata_internal_queuecommand(struct Scsi_Host *shost,
>>> +				struct scsi_cmnd *scmd);
>>>   extern void ata_scsi_slave_destroy(struct scsi_device *sdev);
>>>   extern int ata_scsi_change_queue_depth(struct scsi_device *sdev,
>>>   				       int queue_depth);
>>> @@ -1391,7 +1393,8 @@ extern const struct attribute_group *ata_common_sdev_groups[];
>>>   	.slave_destroy		= ata_scsi_slave_destroy,	\
>>>   	.bios_param		= ata_std_bios_param,		\
>>>   	.unlock_native_capacity	= ata_scsi_unlock_native_capacity,\
>>> -	.max_sectors		= ATA_MAX_SECTORS_LBA48
>>> +	.max_sectors		= ATA_MAX_SECTORS_LBA48,\
>>> +	.reserved_queuecommand = ata_internal_queuecommand
>>>   
>>>   #define ATA_SUBBASE_SHT(drv_name)				\
>>>   	__ATA_BASE_SHT(drv_name),				\
>>
> 

-- 
Damien Le Moal
Western Digital Research

